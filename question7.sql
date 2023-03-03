UPDATE vaccination_data
SET daily_vaccinations = (
  SELECT MEDIAN(daily_vaccinations)
  FROM vaccination_data AS sub
  WHERE sub.country = vaccination_data.country
  AND sub.daily_vaccinations IS NOT NULL
)
WHERE daily_vaccinations IS NULL;

UPDATE vaccination_data
SET daily_vaccinations = 0
WHERE daily_vaccinations IS NULL AND country IN (
  SELECT DISTINCT country
  FROM vaccination_data
  WHERE daily_vaccinations IS NOT NULL
);
