-- 1. Total transactions
SELECT COUNT(*) FROM transactions;

-- 2. Fraud vs non-fraud count
SELECT isFraud, COUNT(*) 
FROM transactions
GROUP BY isFraud;

-- 3. Avg transaction amount (fraud vs non-fraud)
SELECT isFraud, AVG(amount) 
FROM transactions
GROUP BY isFraud;

-- 4. Top transaction types by fraud
SELECT type, COUNT(*) AS fraud_cases
FROM transactions
WHERE isFraud = 1
GROUP BY type
ORDER BY fraud_cases DESC;

-- 5. High value transactions (>95 percentile approx)
SELECT * FROM transactions
WHERE amount > 100000;

-- 6. Suspicious transactions (zero balance anomaly)
SELECT *
FROM transactions
WHERE oldbalanceOrg = 0 AND amount > 0;

-- 7. Fraud rate per transaction type
SELECT type,
SUM(isFraud)*100.0/COUNT(*) AS fraud_rate
FROM transactions
GROUP BY type;

-- 8. Top risky customers
SELECT nameOrig, COUNT(*) AS suspicious_count
FROM transactions
WHERE isFraud = 1
GROUP BY nameOrig
ORDER BY suspicious_count DESC;

-- 9. Transaction distribution
SELECT type, AVG(amount), MAX(amount)
FROM transactions
GROUP BY type;

-- 10. Balance inconsistency
SELECT *
FROM transactions
WHERE oldbalanceOrg - newbalanceOrig != amount;