Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5205AB17C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237308AbiIBNfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbiIBNeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:34:44 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83D1120FA8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:14:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y3so3857736ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=whps72uK5i5E3SL2GkyTD6wGvmdPn4CKuPw5nDdG7gU=;
        b=pjfTgSTzVvW4yYO/GAX/n7JBsFpiLNWE9Z64c2pY1ol5vdy3H26GbgY+112hWwoqsc
         VqRNen8u/Emp7AcQ/K5gy7lGII4aiTIa7gaVvXUub6KFe6HyKTfYlypoIPdgMRKyzYq3
         93L4WWeCwavgRBJ//PeYSIYnfjLP8G7CRt7WkknsG+TqPeHIa2oAd83Cf+rA+GvrqHtL
         8lGgUowHIHwp+vafFzzQ8UbHVVul3Abz7iyGgWUjw73LWcnserhFkxQqZIpJfVZrGZEW
         s58BT+qOgvbS7pySVICHIQL3L9wWHpf/HgycJHUEpc2/dlzIn0eldr0uXVHoT0SBnUIf
         o39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=whps72uK5i5E3SL2GkyTD6wGvmdPn4CKuPw5nDdG7gU=;
        b=JmDbkev7APy2Ixyw23qPKlm7CH2nD/ARlZQqQkR5NCBMnRMHvidSdLdiqs6HNwIttN
         kBwSXErEublm7eF/TDeMs0s16shBHrPwKMawPNcBGjtD3aQpvCM2fLsg7s3jGU5x8vrC
         5vEINdtyhIsePRpY0z1M0RwzpJY3wB9POlCONqZVnTbRHOEAwQyLPKe05URUlLmooj3K
         +MkpP82WPkhrJ5md7FsZsNi973/eTm3S6imunMxpB6ncTeriuLM1298bEp7m1QLz+sAc
         iz8RYxZ5lEtQPVrVNbFhzx1xEGpsrBcYsSKRngDrxwiPojjeflMutsxXznuwrsONjylj
         8tpA==
X-Gm-Message-State: ACgBeo0WIZprSsbJkW6E/FTT8tOKzo3H/kHSK1R1GoZsn2Dasf9DAPXT
        EsRVDDJgDHaQ+UJ+mIMbmHUMqQFmzqAQhw==
X-Google-Smtp-Source: AA6agR5uXgdga3rkMwI5OOIdZWpVi6D01Thv1ugWJsZt5YNB3jV+QKeZWdzf5KGbzNr6EkkQkJu1iw==
X-Received: by 2002:a17:907:1623:b0:741:9f8f:be50 with SMTP id hb35-20020a170907162300b007419f8fbe50mr15824004ejc.254.1662124387133;
        Fri, 02 Sep 2022 06:13:07 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id a18-20020a50c312000000b0043d7b19abd0sm1408044edb.39.2022.09.02.06.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 06:13:05 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 1/3] iio: temperature: mlx90632 Add runtime powermanagement modes
Date:   Fri,  2 Sep 2022 15:12:58 +0200
Message-Id: <20220902131258.3316367-1-cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crt Mori <cmo@melexis.com>

Sensor can operate in lower power modes and even make measurements when
in those lower powered modes. The decision was taken that if measurement
is not requested within 2 seconds the sensor will remain in SLEEP_STEP
power mode, where measurements are triggered on request with setting the
start of measurement bit (SOB). In this mode the measurements are taking
a bit longer because we need to start it and complete it. Currently, in
continuous mode we read ready data and this mode is activated if sensor
measurement is requested within 2 seconds. The suspend timeout is
increased to 6 seconds (instead of 3 before), because that enables more
measurements in lower power mode (SLEEP_STEP), with the lowest refresh
rate (2 seconds).

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 309 +++++++++++++++++++++++++----
 1 file changed, 272 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 549c0ab5c2be..45a1ab51fd0c 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -7,10 +7,12 @@
  * Driver for the Melexis MLX90632 I2C 16-bit IR thermopile sensor
  */
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/iopoll.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/mod_devicetable.h>
@@ -55,6 +57,12 @@
 #define MLX90632_EE_Ha		0x2481 /* Ha customer calib value reg 16bit */
 #define MLX90632_EE_Hb		0x2482 /* Hb customer calib value reg 16bit */
 
+#define MLX90632_EE_MEDICAL_MEAS1      0x24E1 /* Medical measurement 1 16bit */
+#define MLX90632_EE_MEDICAL_MEAS2      0x24E2 /* Medical measurement 2 16bit */
+#define MLX90632_EE_EXTENDED_MEAS1     0x24F1 /* Extended measurement 1 16bit */
+#define MLX90632_EE_EXTENDED_MEAS2     0x24F2 /* Extended measurement 2 16bit */
+#define MLX90632_EE_EXTENDED_MEAS3     0x24F3 /* Extended measurement 3 16bit */
+
 /* Register addresses - volatile */
 #define MLX90632_REG_I2C_ADDR	0x3000 /* Chip I2C address register */
 
@@ -62,6 +70,7 @@
 #define MLX90632_REG_CONTROL	0x3001 /* Control Register address */
 #define   MLX90632_CFG_PWR_MASK		GENMASK(2, 1) /* PowerMode Mask */
 #define   MLX90632_CFG_MTYP_MASK		GENMASK(8, 4) /* Meas select Mask */
+#define   MLX90632_CFG_SOB_MASK BIT(11)
 
 /* PowerModes statuses */
 #define MLX90632_PWR_STATUS(ctrl_val) (ctrl_val << 1)
@@ -70,6 +79,8 @@
 #define MLX90632_PWR_STATUS_STEP MLX90632_PWR_STATUS(2) /* step */
 #define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous*/
 
+#define MLX90632_EE_RR(ee_val) (ee_val & GENMASK(10, 8)) /* Only Refresh Rate bits*/
+
 /* Measurement types */
 #define MLX90632_MTYP_MEDICAL 0
 #define MLX90632_MTYP_EXTENDED 17
@@ -116,8 +127,9 @@
 #define MLX90632_REF_12 	12LL /* ResCtrlRef value of Ch 1 or Ch 2 */
 #define MLX90632_REF_3		12LL /* ResCtrlRef value of Channel 3 */
 #define MLX90632_MAX_MEAS_NUM	31 /* Maximum measurements in list */
-#define MLX90632_SLEEP_DELAY_MS 3000 /* Autosleep delay */
+#define MLX90632_SLEEP_DELAY_MS 6000 /* Autosleep delay */
 #define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */
+#define MLX90632_MEAS_MAX_TIME 2000 /* Maximum measurement time in ms for the lowest possible refresh rate */
 
 /**
  * struct mlx90632_data - private data for the MLX90632 device
@@ -130,6 +142,9 @@
  * @object_ambient_temperature: Ambient temperature at object (might differ of
  *                              the ambient temperature of sensor.
  * @regulator: Regulator of the device
+ * @powerstatus: Current POWER status of the device
+ * @interraction_timestamp: Timestamp of the last temperature read that is used
+ *			    for power management
  */
 struct mlx90632_data {
 	struct i2c_client *client;
@@ -139,6 +154,8 @@ struct mlx90632_data {
 	u8 mtyp;
 	u32 object_ambient_temperature;
 	struct regulator *regulator;
+	int powerstatus;
+	unsigned long interraction_timestamp; /* in jiffies */
 };
 
 static const struct regmap_range mlx90632_volatile_reg_range[] = {
@@ -158,6 +175,8 @@ static const struct regmap_range mlx90632_read_reg_range[] = {
 	regmap_reg_range(MLX90632_EE_VERSION, MLX90632_EE_Ka),
 	regmap_reg_range(MLX90632_EE_CTRL, MLX90632_EE_I2C_ADDR),
 	regmap_reg_range(MLX90632_EE_Ha, MLX90632_EE_Hb),
+	regmap_reg_range(MLX90632_EE_MEDICAL_MEAS1, MLX90632_EE_MEDICAL_MEAS2),
+	regmap_reg_range(MLX90632_EE_EXTENDED_MEAS1, MLX90632_EE_EXTENDED_MEAS3),
 	regmap_reg_range(MLX90632_REG_I2C_ADDR, MLX90632_REG_CONTROL),
 	regmap_reg_range(MLX90632_REG_I2C_CMD, MLX90632_REG_I2C_CMD),
 	regmap_reg_range(MLX90632_REG_STATUS, MLX90632_REG_STATUS),
@@ -196,18 +215,42 @@ static const struct regmap_config mlx90632_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+static int mlx90632_wakeup(struct mlx90632_data *data);
+
 static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
 {
-	return regmap_update_bits(regmap, MLX90632_REG_CONTROL,
-				  MLX90632_CFG_PWR_MASK,
-				  MLX90632_PWR_STATUS_SLEEP_STEP);
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(regmap_get_device(regmap)));
+	struct mlx90632_data *data = iio_priv(indio_dev);
+	s32 ret = 0;
+
+	if (data->powerstatus != MLX90632_PWR_STATUS_SLEEP_STEP) {
+		ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
+					MLX90632_CFG_PWR_MASK,
+					MLX90632_PWR_STATUS_SLEEP_STEP);
+		if (ret < 0)
+			return ret;
+
+		data->powerstatus = MLX90632_PWR_STATUS_SLEEP_STEP;
+	}
+	return ret;
 }
 
 static s32 mlx90632_pwr_continuous(struct regmap *regmap)
 {
-	return regmap_update_bits(regmap, MLX90632_REG_CONTROL,
-				  MLX90632_CFG_PWR_MASK,
-				  MLX90632_PWR_STATUS_CONTINUOUS);
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(regmap_get_device(regmap)));
+	struct mlx90632_data *data = iio_priv(indio_dev);
+	s32 ret = 0;
+
+	if (data->powerstatus != MLX90632_PWR_STATUS_CONTINUOUS) {
+		ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
+					MLX90632_CFG_PWR_MASK,
+					MLX90632_PWR_STATUS_CONTINUOUS);
+		if (ret < 0)
+			return ret;
+
+		data->powerstatus = MLX90632_PWR_STATUS_CONTINUOUS;
+	}
+	return ret;
 }
 
 /**
@@ -219,6 +262,65 @@ static void mlx90632_reset_delay(void)
 	usleep_range(150, 200);
 }
 
+static int mlx90632_get_measurement_time(struct regmap *regmap, u16 meas)
+{
+	int ret;
+	unsigned int reg;
+
+	ret = regmap_read(regmap, meas, &reg);
+	if (ret < 0)
+		return ret;
+
+	reg = MLX90632_EE_RR(reg) >> 8;
+
+	return MLX90632_MEAS_MAX_TIME >> reg;
+}
+
+static int mlx90632_calculate_dataset_ready_time(struct mlx90632_data *data)
+{
+	int ret;
+	unsigned int refresh_time;
+
+	if (data->mtyp == MLX90632_MTYP_MEDICAL) {
+		ret = mlx90632_get_measurement_time(data->regmap,
+						    MLX90632_EE_MEDICAL_MEAS1);
+		if (ret < 0)
+			return ret;
+
+		refresh_time = ret;
+
+		ret = mlx90632_get_measurement_time(data->regmap,
+						    MLX90632_EE_MEDICAL_MEAS2);
+		if (ret < 0)
+			return ret;
+
+		refresh_time = refresh_time + ret;
+	} else {
+		ret = mlx90632_get_measurement_time(data->regmap,
+						    MLX90632_EE_EXTENDED_MEAS1);
+		if (ret < 0)
+			return ret;
+
+		refresh_time = ret;
+
+		ret = mlx90632_get_measurement_time(data->regmap,
+						    MLX90632_EE_EXTENDED_MEAS2);
+		if (ret < 0)
+			return ret;
+
+		refresh_time = refresh_time + ret;
+
+		ret = mlx90632_get_measurement_time(data->regmap,
+						    MLX90632_EE_EXTENDED_MEAS3);
+		if (ret < 0)
+			return ret;
+
+		refresh_time = refresh_time + ret;
+	}
+
+	return refresh_time;
+}
+
 /**
  * mlx90632_perform_measurement() - Trigger and retrieve current measurement cycle
  * @data: pointer to mlx90632_data object containing regmap information
@@ -249,26 +351,76 @@ static int mlx90632_perform_measurement(struct mlx90632_data *data)
 	return (reg_status & MLX90632_STAT_CYCLE_POS) >> 2;
 }
 
-static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
+/**
+ * mlx90632_perform_measurement_burst() - Trigger and retrieve current measurement
+ * cycle in step sleep mode
+ * @data: pointer to mlx90632_data object containing regmap information
+ *
+ * Perform a measurement and return 2 as measurement cycle position reported
+ * by sensor. This is a blocking function for amount dependent on the sensor
+ * refresh rate.
+ */
+static int mlx90632_perform_measurement_burst(struct mlx90632_data *data)
 {
+	unsigned int reg_status;
 	int ret;
 
-	if ((type != MLX90632_MTYP_MEDICAL) && (type != MLX90632_MTYP_EXTENDED))
-		return -EINVAL;
+	ret = regmap_write_bits(data->regmap, MLX90632_REG_CONTROL,
+				MLX90632_CFG_SOB_MASK, MLX90632_CFG_SOB_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = mlx90632_calculate_dataset_ready_time(data);
+	if (ret < 0)
+		return ret;
+
+	msleep(ret); /* Wait minimum time for dataset to be ready */
+
+	ret = regmap_read_poll_timeout(data->regmap, MLX90632_REG_STATUS,
+				       reg_status,
+				       ((reg_status & MLX90632_STAT_BUSY) == 0),
+				       10000, 100 * 10000);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "data not ready");
+		return -ETIMEDOUT;
+	}
+
+	return 2;
+}
+
 
-	ret = regmap_write(regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
+static int mlx90632_set_meas_type(struct mlx90632_data *data, u8 type)
+{
+	int ret;
+	int current_powerstatus = data->powerstatus;
+
+	if (data->mtyp == type) {
+		return 0;
+	}
+
+	ret = mlx90632_pwr_continuous(data->regmap);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(data->regmap, MLX90632_REG_I2C_CMD, MLX90632_RESET_CMD);
 	if (ret < 0)
 		return ret;
 
 	mlx90632_reset_delay();
 
-	ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
+	ret = regmap_update_bits(data->regmap, MLX90632_REG_CONTROL,
 				 (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
 				 (MLX90632_MTYP_STATUS(type) | MLX90632_PWR_STATUS_HALT));
 	if (ret < 0)
 		return ret;
 
-	return mlx90632_pwr_continuous(regmap);
+	data->mtyp = type;
+	data->powerstatus = MLX90632_PWR_STATUS_HALT;
+
+	if (current_powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
+		return mlx90632_pwr_set_sleep_step(data->regmap);
+	else
+		return mlx90632_pwr_continuous(data->regmap);
 }
 
 static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
@@ -355,11 +507,24 @@ static int mlx90632_read_all_channel(struct mlx90632_data *data,
 	s32 ret, measurement;
 
 	mutex_lock(&data->lock);
-	measurement = mlx90632_perform_measurement(data);
-	if (measurement < 0) {
-		ret = measurement;
+	ret = mlx90632_set_meas_type(data, MLX90632_MTYP_MEDICAL);
+	if (ret < 0)
 		goto read_unlock;
+
+	if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS) {
+		measurement = mlx90632_perform_measurement(data);
+		if (measurement < 0) {
+			ret = measurement;
+			goto read_unlock;
+		}
+	} else if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
+		measurement = mlx90632_perform_measurement_burst(data);
+		if (measurement < 0) {
+			ret = measurement;
+			goto read_unlock;
+		}
 	}
+
 	ret = mlx90632_read_ambient_raw(data->regmap, ambient_new_raw,
 					ambient_old_raw);
 	if (ret < 0)
@@ -441,14 +606,23 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
 	s32 ret, meas;
 
 	mutex_lock(&data->lock);
-	ret = mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_EXTENDED);
+	ret = mlx90632_set_meas_type(data, MLX90632_MTYP_EXTENDED);
 	if (ret < 0)
 		goto read_unlock;
 
-	ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
-				50000, 800000, false, data);
-	if (ret != 0)
-		goto read_unlock;
+	if (data->powerstatus == MLX90632_PWR_STATUS_CONTINUOUS) {
+		ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
+					50000, 800000, false, data);
+		if (ret != 0)
+			goto read_unlock;
+
+	} else if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
+		ret = mlx90632_perform_measurement_burst(data);
+		if (ret < 0) {
+			goto read_unlock;
+		}
+	}
+
 
 	ret = mlx90632_read_object_raw_extended(data->regmap, object_new_raw);
 	if (ret < 0)
@@ -457,8 +631,6 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
 	ret = mlx90632_read_ambient_raw_extended(data->regmap, ambient_new_raw, ambient_old_raw);
 
 read_unlock:
-	(void) mlx90632_set_meas_type(data->regmap, MLX90632_MTYP_MEDICAL);
-
 	mutex_unlock(&data->lock);
 	return ret;
 }
@@ -743,12 +915,39 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
 	return ret;
 }
 
+static int mlx90632_pm_interraction_wakeup(struct mlx90632_data *data)
+{
+	unsigned long now;
+	int ret = 0;
+
+	now = jiffies;
+	if (time_in_range(now, data->interraction_timestamp,
+			  data->interraction_timestamp +
+			  msecs_to_jiffies(MLX90632_MEAS_MAX_TIME + 100))) {
+		if (data->powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP) {
+			ret = mlx90632_pwr_continuous(data->regmap);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	data->interraction_timestamp = now;
+
+	return ret;
+}
+
 static int mlx90632_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *channel, int *val,
 			     int *val2, long mask)
 {
 	struct mlx90632_data *data = iio_priv(indio_dev);
 	int ret;
+	int cr;
+
+	pm_runtime_get_sync(&data->client->dev);
+	ret = mlx90632_pm_interraction_wakeup(data);
+	if (ret < 0)
+		goto mlx90632_read_raw_pm;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
@@ -756,16 +955,22 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
 		case IIO_MOD_TEMP_AMBIENT:
 			ret = mlx90632_calc_ambient_dsp105(data, val);
 			if (ret < 0)
-				return ret;
-			return IIO_VAL_INT;
+				goto mlx90632_read_raw_pm;
+
+			ret = IIO_VAL_INT;
+			break;
 		case IIO_MOD_TEMP_OBJECT:
 			ret = mlx90632_calc_object_dsp105(data, val);
 			if (ret < 0)
-				return ret;
-			return IIO_VAL_INT;
+				goto mlx90632_read_raw_pm;
+
+			ret = IIO_VAL_INT;
+			break;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			break;
 		}
+		break;
 	case IIO_CHAN_INFO_CALIBEMISSIVITY:
 		if (data->emissivity == 1000) {
 			*val = 1;
@@ -774,13 +979,22 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
 			*val = 0;
 			*val2 = data->emissivity * 1000;
 		}
-		return IIO_VAL_INT_PLUS_MICRO;
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
 	case IIO_CHAN_INFO_CALIBAMBIENT:
 		*val = data->object_ambient_temperature;
-		return IIO_VAL_INT;
+		ret = IIO_VAL_INT;
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
+
+mlx90632_read_raw_pm:
+	mutex_unlock(&data->lock);
+	pm_runtime_mark_last_busy(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+	return ret;
 }
 
 static int mlx90632_write_raw(struct iio_dev *indio_dev,
@@ -902,6 +1116,7 @@ static int mlx90632_probe(struct i2c_client *client,
 	mlx90632->client = client;
 	mlx90632->regmap = regmap;
 	mlx90632->mtyp = MLX90632_MTYP_MEDICAL;
+	mlx90632->powerstatus = MLX90632_PWR_STATUS_HALT;
 
 	mutex_init(&mlx90632->lock);
 	indio_dev->name = id->name;
@@ -961,16 +1176,18 @@ static int mlx90632_probe(struct i2c_client *client,
 
 	mlx90632->emissivity = 1000;
 	mlx90632->object_ambient_temperature = 25000; /* 25 degrees milliCelsius */
+	mlx90632->interraction_timestamp = jiffies; /* Set initial value */
 
-	pm_runtime_disable(&client->dev);
+	pm_runtime_get_noresume(&client->dev);
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret < 0) {
 		mlx90632_sleep(mlx90632);
 		return ret;
 	}
-	pm_runtime_enable(&client->dev);
+	devm_pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev, MLX90632_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_put(&client->dev);
 
 	return iio_device_register(indio_dev);
 }
@@ -1007,8 +1224,14 @@ static int __maybe_unused mlx90632_pm_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mlx90632_data *data = iio_priv(indio_dev);
+	int ret;
 
-	return mlx90632_sleep(data);
+	ret = regulator_disable(data->regulator);
+	if (ret < 0)
+		dev_err(regmap_get_device(data->regmap),
+			"Failed to disable power regulator: %d\n", ret);
+
+	return ret;
 }
 
 static int __maybe_unused mlx90632_pm_resume(struct device *dev)
@@ -1016,11 +1239,23 @@ static int __maybe_unused mlx90632_pm_resume(struct device *dev)
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mlx90632_data *data = iio_priv(indio_dev);
 
-	return mlx90632_wakeup(data);
+	return mlx90632_enable_regulator(data);
 }
 
-static UNIVERSAL_DEV_PM_OPS(mlx90632_pm_ops, mlx90632_pm_suspend,
-			    mlx90632_pm_resume, NULL);
+static int __maybe_unused mlx90632_pm_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mlx90632_data *data = iio_priv(indio_dev);
+
+	return mlx90632_pwr_set_sleep_step(data->regmap);
+}
+
+const struct dev_pm_ops mlx90632_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mlx90632_pm_suspend, mlx90632_pm_resume)
+	SET_RUNTIME_PM_OPS(mlx90632_pm_runtime_suspend,
+			   NULL, NULL)
+};
+EXPORT_SYMBOL_GPL(mlx90632_pm_ops);
 
 static struct i2c_driver mlx90632_driver = {
 	.driver = {
-- 
2.34.1

