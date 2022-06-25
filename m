Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA82F55AB37
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiFYPKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 11:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiFYPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 11:09:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB513E9B;
        Sat, 25 Jun 2022 08:09:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so3065645wms.3;
        Sat, 25 Jun 2022 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ssb57DaJqOBnuPT2qNuz2FP7n/3wQ0MzUtmqxzlYhdg=;
        b=NrF8RPsJj01Xf56KdgivM3sPhVfr9baYRHBIG1lckmmUvIbd8WELeRAV0jo8/rOJkf
         nJXr49+KnaqhOaX5D1Z+jXjhjb5nnjkBz4ygPAtUgsk+NZxlg1/nBkdueVbilmPAivOB
         Z6s/BkX9snVDiQDSIQbK7I5drs2p/igMUUhfyaiZzZUYV8WMZIuq0VqbuE7RkZJ0zgEA
         URy6GyNEkD2D8cxjWYDxHptEUj7qJFi35r7kLs7bGKNgpVbnhgm2fjFCTW81ZUFB++W6
         +Jf7TQt7PCTbnno+4PiKqCZ4ToHdDtd9Zaix+Ijsnx9qgLJVXBasCBnfDykI/Hs+YBf2
         pwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ssb57DaJqOBnuPT2qNuz2FP7n/3wQ0MzUtmqxzlYhdg=;
        b=CRf2DQJy/x1OTrFK7vwJT4Oxn/Q/0z8Npoq4hA4Pp8qtH9EnWlkqUBO3AyG/MxMB9a
         dqkIjoBaQcXvTvXc04B/GGlERYaUEkSXoP1uIAPjEQVzvZuoHST8vS7svp5bzAPehPXv
         1QfYW1+O4W49TUCoHoB1U/p/lpiUMNgU/PCZN7mrbUkn/p3cEtoR1j69frPQs6hUKZpW
         AK8VawJ/72gzOQZV/ob/1ZEJUkFGJRCg5yf5Ti4SvgQPEt7cgxoeFQC7DW6TeHM3mObb
         l2h9yJ8jPpjM4W4Chlv4B4YxAnL/hnd3KsctYU0OyXyqf3ATfu+RFdWVYvUa8hpVggy+
         MAvg==
X-Gm-Message-State: AJIora9PcDIA9gFZWoAmYrctkO2G5uM4gMq4xgySM4K6lhw0Mxkt70fT
        f8nN12+DpyLIzHOwMMzxDTg=
X-Google-Smtp-Source: AGRyM1ugRaVtrJjnkwkaHT8i7T7tOU9pqld+ikp9kQjktSAuRX/HzlS1nIIInROhuYb9Sdy+YUAfRg==
X-Received: by 2002:a05:600c:358f:b0:39c:97cc:82e5 with SMTP id p15-20020a05600c358f00b0039c97cc82e5mr4725711wmq.60.1656169795038;
        Sat, 25 Jun 2022 08:09:55 -0700 (PDT)
Received: from localhost.localdomain (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id n9-20020a7bcbc9000000b003a039054567sm6527731wmi.18.2022.06.25.08.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 08:09:54 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: pressure: bmp280: Add support for BMP380 sensor family
Date:   Sat, 25 Jun 2022 17:09:12 +0200
Message-Id: <20220625150921.47769-1-ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds compatibility with the new generation of this sensor, the BMP380

Included basic sensor initialization to do pressure and temp
measurements and allows tuning oversampling settings for each channel
The compensation algorithms are adapted from the device datasheet and
the repository https://github.com/BoschSensortec/BMP3-Sensor-API

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c   | 378 ++++++++++++++++++++++++++-
 drivers/iio/pressure/bmp280-i2c.c    |   5 +
 drivers/iio/pressure/bmp280-regmap.c |  55 ++++
 drivers/iio/pressure/bmp280-spi.c    |   5 +
 drivers/iio/pressure/bmp280.h        | 118 +++++++++
 5 files changed, 558 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index bf8167f43c56..3887475a9059 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -74,6 +74,24 @@ struct bmp280_calib {
 	s8  H6;
 };
 
+/* See datasheet Section 3.11.1. */
+struct bmp380_calib {
+	u16 T1;
+	u16 T2;
+	s8  T3;
+	s16 P1;
+	s16 P2;
+	s8  P3;
+	s8  P4;
+	u16 P5;
+	u16 P6;
+	s8  P7;
+	s8  P8;
+	s16 P9;
+	s8  P10;
+	s8  P11;
+};
+
 static const char *const bmp280_supply_names[] = {
 	"vddd", "vdda"
 };
@@ -90,6 +108,7 @@ struct bmp280_data {
 	union {
 		struct bmp180_calib bmp180;
 		struct bmp280_calib bmp280;
+		struct bmp380_calib bmp380;
 	} calib;
 	struct regulator_bulk_data supplies[BMP280_NUM_SUPPLIES];
 	unsigned int start_up_time; /* in microseconds */
@@ -129,6 +148,25 @@ struct bmp280_chip_info {
 enum { T1, T2, T3 };
 enum { P1, P2, P3, P4, P5, P6, P7, P8, P9 };
 
+enum {
+	/* Temperature calib indexes */
+	BMP380_T1 = 0,
+	BMP380_T2 = 2,
+	BMP380_T3 = 4,
+	/* Pressure calib indexes */
+	BMP380_P1 = 5,
+	BMP380_P2 = 7,
+	BMP380_P3 = 9,
+	BMP380_P4 = 10,
+	BMP380_P5 = 11,
+	BMP380_P6 = 13,
+	BMP380_P7 = 15,
+	BMP380_P8 = 16,
+	BMP380_P9 = 17,
+	BMP380_P10 = 19,
+	BMP380_P11 = 20
+};
+
 static const struct iio_chan_spec bmp280_channels[] = {
 	{
 		.type = IIO_PRESSURE,
@@ -252,6 +290,7 @@ static int bmp280_read_calib(struct bmp280_data *data,
 
 	return 0;
 }
+
 /*
  * Returns humidity in percent, resolution is 0.01 percent. Output value of
  * "47445" represents 47445/1024 = 46.333 %RH.
@@ -685,6 +724,302 @@ static const struct bmp280_chip_info bme280_chip_info = {
 	.read_humid = bmp280_read_humid,
 };
 
+/* Send a command to BMP3XX sensors */
+static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
+{
+	int ret;
+	unsigned int reg;
+
+	/* check if device is ready to process a command */
+	ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
+	if (ret) {
+		dev_err(data->dev, "failed to read error register\n");
+		goto failure;
+	}
+	if (!(cmd & BMP380_STATUS_CMD_RDY_MASK)) {
+		dev_err(data->dev, "device is not ready to accept commands\n");
+		ret = -EBUSY;
+		goto failure;
+	}
+
+	/* send command to process */
+	ret = regmap_write(data->regmap, BMP380_REG_CMD, cmd);
+	if (ret) {
+		dev_err(data->dev, "failed to send command to device\n");
+		goto failure;
+	}
+	/* wait for 2ms for command to be proccessed */
+	usleep_range(2000, 2500);
+	/* check for command processing error */
+	ret = regmap_read(data->regmap, BMP380_REG_ERROR, &reg);
+	if (ret) {
+		dev_err(data->dev, "error reading ERROR reg\n");
+		goto failure;
+	}
+	if (reg & BMP380_ERR_CMD_MASK) {
+		dev_err(data->dev, "error processing command 0x%X\n", cmd);
+		ret = -EINVAL;
+		goto failure;
+	}
+	dev_dbg(data->dev, "Command 0x%X proccessed successfully\n", cmd);
+
+failure:
+	return ret;
+}
+
+/*
+ * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
+ * "5123" equals 51.23 DegC.  t_fine carries fine temperature as global
+ * value.
+ *
+ * Taken from datasheet, Section Appendix 9, "Compensation formula" and repo
+ * https://github.com/BoschSensortec/BMP3-Sensor-API
+ */
+static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
+{
+	s64 var1, var2, var3, var4, var5, var6, comp_temp;
+	struct bmp380_calib *calib = &data->calib.bmp380;
+
+	var1 = ((s64) adc_temp) - (((s64) calib->T1) << 8);
+	var2 = var1 * ((s64) calib->T2);
+	var3 = var1 * var1;
+	var4 = var3 * ((s64) calib->T3);
+	var5 = (var2 << 18) + var4;
+	var6 = var5 >> 32;
+	data->t_fine = (s32) var6;
+	comp_temp = (var6 * 25) >> 14;
+
+	comp_temp = clamp_val(comp_temp, BMP380_MIN_TEMP, BMP380_MAX_TEMP);
+	return (s32) comp_temp;
+}
+
+/*
+ * Returns pressure in Pa as unsigned 32 bit integer in fractional Pascal.
+ * Output value of "9528709" represents 9528709/100 = 95287.09 Pa = 952.8709 hPa
+ *
+ * Taken from datasheet, Section 9.3. "Pressure compensation" and repository
+ * https://github.com/BoschSensortec/BMP3-Sensor-API
+ */
+static u32 bmp380_compensate_press(struct bmp280_data *data, u32 adc_press)
+{
+	s64 var1, var2, var3, var4, var5, var6, offset, sensitivity;
+	u64 comp_press;
+	struct bmp380_calib *calib = &data->calib.bmp380;
+
+	var1 = ((s64)data->t_fine) * ((s64)data->t_fine);
+	var2 = var1 >> 6;
+	var3 = (var2 * ((s64) data->t_fine)) >> 8;
+	var4 = (((s64)calib->P8) * var3) >> 5;
+	var5 = (((s64) calib->P7) * var1) << 4;
+	var6 = (((s64) calib->P6) * ((s64)data->t_fine)) << 22;
+	offset = (((s64)calib->P5) << 47) + var4 + var5 + var6;
+	var2 = (((s64)calib->P4) * var3) >> 5;
+	var4 = (((s64) calib->P3) * var1) << 2;
+	var5 = (((s64) calib->P2) - ((s64) 1<<14)) *
+		(((s64)data->t_fine) << 21);
+	sensitivity = ((((s64) calib->P1) - ((s64) 1 << 14)) << 46) +
+			var2 + var4 + var5;
+	var1 = (sensitivity >> 24) * ((s64)adc_press);
+	var2 = ((s64)calib->P10) * ((s64) data->t_fine);
+	var3 = var2 + (((s64) calib->P9) << 16);
+	var4 = (var3 * ((s64)adc_press)) >> 13;
+
+	/* dividing by 10 followed by multiplying by 10
+	 * To avoid overflow caused by (uncomp_data->pressure * partial_data4)
+	 */
+	var5 = (((s64)adc_press) * (var4 / 10)) >> 9;
+	var5 *= 10;
+	var6 = ((s64)adc_press) * ((s64)adc_press);
+	var2 = (((s64)calib->P11) * var6) >> 16;
+	var3 = (var2 * ((s64)adc_press)) >> 7;
+	var4 = (offset >> 2) + var1 + var5 + var3;
+	comp_press = ((u64)var4 * 25) >> 40;
+
+	comp_press = clamp_val(comp_press, BMP380_MIN_PRES, BMP380_MAX_PRES);
+	return (u32)comp_press;
+}
+
+static int bmp380_read_temp(struct bmp280_data *data, int *val)
+{
+	int ret;
+	__le32 tmp = 0;
+	u32 adc_temp;
+	s32 comp_temp;
+
+	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB, &tmp, 3);
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read temperature\n");
+		return ret;
+	}
+
+	adc_temp = le32_to_cpu(tmp);
+	if (adc_temp == BMP380_TEMP_SKIPPED) {
+		/* reading was skipped */
+		dev_err(data->dev, "reading temperature skipped\n");
+		return -EIO;
+	}
+	comp_temp = bmp380_compensate_temp(data, adc_temp);
+
+	/*
+	 * val might be NULL if we're called by the read_press routine,
+	 * who only cares about the carry over t_fine value.
+	 */
+	if (val) {
+		/* IIO reports temperatures in mC */
+		*val = comp_temp * 10;
+		return IIO_VAL_INT;
+	}
+
+	return 0;
+}
+
+static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
+{
+	int ret;
+	__le32 tmp = 0;
+	u32 adc_press;
+	s32 comp_press;
+
+	/* Read and compensate temperature so we get a reading of t_fine. */
+	ret = bmp380_read_temp(data, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB, &tmp, 3);
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read pressure\n");
+		return ret;
+	}
+
+	adc_press = le32_to_cpu(tmp);
+	if (adc_press == BMP380_PRESS_SKIPPED) {
+		/* reading was skipped */
+		dev_err(data->dev, "reading pressure skipped\n");
+		return -EIO;
+	}
+	comp_press = bmp380_compensate_press(data, adc_press);
+
+	*val = comp_press;
+	/* Compensated pressure is in cPa (centipascals) */
+	*val2 = 100000;
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int bmp380_read_calib(struct bmp280_data *data,
+			     struct bmp380_calib *calib, unsigned int chip)
+{
+	int ret;
+	u8 buf[BMP380_CALIB_REG_COUNT];
+
+	/* Read temperature calibration values. */
+	ret = regmap_bulk_read(data->regmap, BMP380_REG_CALIB_TEMP_START, buf,
+			       BMP380_CALIB_REG_COUNT);
+	if (ret < 0) {
+		dev_err(data->dev,
+			"failed to read temperature calibration parameters\n");
+		return ret;
+	}
+
+	/* Toss the temperature calibration data into the entropy pool */
+	add_device_randomness(buf, sizeof(buf));
+
+	/* Parse calibration data */
+	calib->T1 = le16_from_bytes(buf[BMP380_T1], buf[BMP380_T1 + 1]);
+	calib->T2 = le16_from_bytes(buf[BMP380_T2], buf[BMP380_T2 + 1]);
+	calib->T3 = buf[BMP380_T3];
+	calib->P1 = le16_from_bytes(buf[BMP380_P1], buf[BMP380_P1 + 1]);
+	calib->P2 = le16_from_bytes(buf[BMP380_P2], buf[BMP380_P2 + 1]);
+	calib->P3 = buf[BMP380_P3];
+	calib->P4 = buf[BMP380_P4];
+	calib->P5 = le16_from_bytes(buf[BMP380_P5], buf[BMP380_P5 + 1]);
+	calib->P6 = le16_from_bytes(buf[BMP380_P6], buf[BMP380_P6 + 1]);
+	calib->P7 = buf[BMP380_P7];
+	calib->P8 = buf[BMP380_P8];
+	calib->P9 = le16_from_bytes(buf[BMP380_P9], buf[BMP380_P9 + 1]);
+	calib->P10 = buf[BMP380_P10];
+	calib->P11 = buf[BMP380_P11];
+
+	return 0;
+}
+
+static int bmp380_chip_config(struct bmp280_data *data)
+{
+	u8 osrs;
+	unsigned int tmp;
+	int ret;
+
+	/* configure power control register */
+	ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
+				BMP380_CTRL_SENSORS_MASK |
+				BMP380_MODE_MASK,
+				BMP380_CTRL_SENSORS_PRESS_EN |
+				BMP380_CTRL_SENSORS_TEMP_EN |
+				BMP380_MODE_NORMAL);
+	if (ret < 0) {
+		dev_err(data->dev,
+			"failed to write operation control register\n");
+		return ret;
+	}
+
+	/* configure oversampling */
+	osrs = BMP380_OSRS_TEMP_X(data->oversampling_temp) |
+				BMP380_OSRS_PRESS_X(data->oversampling_press);
+
+	ret = regmap_write_bits(data->regmap, BMP380_REG_OSR,
+				BMP380_OSRS_TEMP_MASK | BMP380_OSRS_PRESS_MASK,
+				osrs);
+	if (ret < 0) {
+		dev_err(data->dev, "failed to write oversampling register\n");
+		return ret;
+	}
+
+	/* configure output data rate */
+	ret = regmap_write_bits(data->regmap, BMP380_REG_ODR,
+				BMP380_ODRS_MASK, BMP380_ODRS_50HZ);
+	if (ret < 0) {
+		dev_err(data->dev, "failed to write ODR selection register\n");
+		return ret;
+	}
+
+	/* set filter data */
+	ret = regmap_update_bits(data->regmap, BMP380_REG_CONFIG,
+				BMP380_FILTER_MASK, BMP380_FILTER_3X);
+	if (ret < 0) {
+		dev_err(data->dev, "failed to write config register\n");
+		return ret;
+	}
+
+	/* check config error flag */
+	ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
+	if (ret < 0) {
+		dev_err(data->dev,
+			"failed to read error register\n");
+		return ret;
+	}
+	if (tmp && BMP380_ERR_CONF_MASK) {
+		dev_warn(data->dev,
+			 "sensor flagged configuration as incompatible\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
+
+static const struct bmp280_chip_info bmp380_chip_info = {
+	.oversampling_temp_avail = bmp380_oversampling_avail,
+	.num_oversampling_temp_avail = ARRAY_SIZE(bmp380_oversampling_avail),
+
+	.oversampling_press_avail = bmp380_oversampling_avail,
+	.num_oversampling_press_avail = ARRAY_SIZE(bmp380_oversampling_avail),
+
+	.chip_config = bmp380_chip_config,
+	.read_temp = bmp380_read_temp,
+	.read_press = bmp380_read_press,
+};
+
 static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 {
 	int ret;
@@ -1032,6 +1367,13 @@ int bmp280_common_probe(struct device *dev,
 		data->oversampling_temp = ilog2(2);
 		data->start_up_time = 2000;
 		break;
+	case BMP380_CHIP_ID:
+		indio_dev->num_channels = 2;
+		data->chip_info = &bmp380_chip_info;
+		data->oversampling_press = ilog2(4);
+		data->oversampling_temp = ilog2(1);
+		data->start_up_time = 2000;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1071,7 +1413,18 @@ int bmp280_common_probe(struct device *dev,
 	}
 
 	data->regmap = regmap;
-	ret = regmap_read(regmap, BMP280_REG_ID, &chip_id);
+	switch (chip) {
+	case BMP180_CHIP_ID:
+	case BMP280_CHIP_ID:
+	case BME280_CHIP_ID:
+		ret = regmap_read(regmap, BMP280_REG_ID, &chip_id);
+		break;
+	case BMP380_CHIP_ID:
+		ret = regmap_read(regmap, BMP380_REG_ID, &chip_id);
+		break;
+	default:
+		ret = -EINVAL;
+	}
 	if (ret < 0)
 		return ret;
 	if (chip_id != chip) {
@@ -1080,6 +1433,13 @@ int bmp280_common_probe(struct device *dev,
 		return -EINVAL;
 	}
 
+	/* BMP3xx requires soft-reset as part of initialization */
+	if (chip_id == BMP380_CHIP_ID) {
+		ret = bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = data->chip_info->chip_config(data);
 	if (ret < 0)
 		return ret;
@@ -1091,20 +1451,32 @@ int bmp280_common_probe(struct device *dev,
 	 * non-volatile memory during production". Let's read them out at probe
 	 * time once. They will not change.
 	 */
-	if (chip_id  == BMP180_CHIP_ID) {
+	switch (chip_id) {
+	case BMP180_CHIP_ID:
 		ret = bmp180_read_calib(data, &data->calib.bmp180);
 		if (ret < 0) {
 			dev_err(data->dev,
 				"failed to read calibration coefficients\n");
 			return ret;
 		}
-	} else if (chip_id == BMP280_CHIP_ID || chip_id == BME280_CHIP_ID) {
+		break;
+	case BMP280_CHIP_ID:
+	case BME280_CHIP_ID:
 		ret = bmp280_read_calib(data, &data->calib.bmp280, chip_id);
 		if (ret < 0) {
 			dev_err(data->dev,
 				"failed to read calibration coefficients\n");
 			return ret;
 		}
+		break;
+	case BMP380_CHIP_ID:
+		ret = bmp380_read_calib(data, &data->calib.bmp380, chip_id);
+		if (ret < 0) {
+			dev_err(data->dev,
+				"failed to read calibration coefficients\n");
+			return ret;
+		}
+		break;
 	}
 
 	/*
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 35045bd92846..31a8a0daa39a 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -19,6 +19,9 @@ static int bmp280_i2c_probe(struct i2c_client *client,
 	case BME280_CHIP_ID:
 		regmap_config = &bmp280_regmap_config;
 		break;
+	case BMP380_CHIP_ID:
+		regmap_config = &bmp380_regmap_config;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -37,6 +40,7 @@ static int bmp280_i2c_probe(struct i2c_client *client,
 }
 
 static const struct of_device_id bmp280_of_i2c_match[] = {
+	{ .compatible = "bosch,bmp380", .data = (void *)BMP380_CHIP_ID },
 	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
 	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
 	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
@@ -46,6 +50,7 @@ static const struct of_device_id bmp280_of_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
 
 static const struct i2c_device_id bmp280_i2c_id[] = {
+	{"bmp380", BMP380_CHIP_ID },
 	{"bmp280", BMP280_CHIP_ID },
 	{"bmp180", BMP180_CHIP_ID },
 	{"bmp085", BMP180_CHIP_ID },
diff --git a/drivers/iio/pressure/bmp280-regmap.c b/drivers/iio/pressure/bmp280-regmap.c
index da136dbadc8f..b440fa41bf12 100644
--- a/drivers/iio/pressure/bmp280-regmap.c
+++ b/drivers/iio/pressure/bmp280-regmap.c
@@ -72,6 +72,49 @@ static bool bmp280_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static bool bmp380_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP380_REG_CMD:
+	case BMP380_REG_CONFIG:
+	case BMP380_REG_FIFO_CONFIG_1:
+	case BMP380_REG_FIFO_CONFIG_2:
+	case BMP380_REG_FIFO_WATERMARK_LSB:
+	case BMP380_REG_FIFO_WATERMARK_MSB:
+	case BMP380_REG_POWER_CONTROL:
+	case BMP380_REG_INT_CONTROL:
+	case BMP380_REG_IF_CONFIG:
+	case BMP380_REG_ODR:
+	case BMP380_REG_OSR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool bmp380_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMP380_REG_TEMP_XLSB:
+	case BMP380_REG_TEMP_LSB:
+	case BMP380_REG_TEMP_MSB:
+	case BMP380_REG_PRESS_XLSB:
+	case BMP380_REG_PRESS_LSB:
+	case BMP380_REG_PRESS_MSB:
+	case BMP380_REG_SENSOR_TIME_XLSB:
+	case BMP380_REG_SENSOR_TIME_LSB:
+	case BMP380_REG_SENSOR_TIME_MSB:
+	case BMP380_REG_INT_STATUS:
+	case BMP380_REG_FIFO_DATA:
+	case BMP380_REG_STATUS:
+	case BMP380_REG_ERROR:
+	case BMP380_REG_EVENT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 const struct regmap_config bmp280_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -83,3 +126,15 @@ const struct regmap_config bmp280_regmap_config = {
 	.volatile_reg = bmp280_is_volatile_reg,
 };
 EXPORT_SYMBOL(bmp280_regmap_config);
+
+const struct regmap_config bmp380_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = BMP380_REG_CMD,
+	.cache_type = REGCACHE_RBTREE,
+
+	.writeable_reg = bmp380_is_writeable_reg,
+	.volatile_reg = bmp380_is_volatile_reg,
+};
+EXPORT_SYMBOL(bmp380_regmap_config);
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 41f6cc56d229..303c41130343 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -66,6 +66,9 @@ static int bmp280_spi_probe(struct spi_device *spi)
 	case BME280_CHIP_ID:
 		regmap_config = &bmp280_regmap_config;
 		break;
+	case BMP380_CHIP_ID:
+		regmap_config = &bmp380_regmap_config;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -92,6 +95,7 @@ static const struct of_device_id bmp280_of_spi_match[] = {
 	{ .compatible = "bosch,bmp181", },
 	{ .compatible = "bosch,bmp280", },
 	{ .compatible = "bosch,bme280", },
+	{ .compatible = "bosch,bmp380", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmp280_of_spi_match);
@@ -101,6 +105,7 @@ static const struct spi_device_id bmp280_spi_id[] = {
 	{ "bmp181", BMP180_CHIP_ID },
 	{ "bmp280", BMP280_CHIP_ID },
 	{ "bme280", BME280_CHIP_ID },
+	{ "bmp380", BMP380_CHIP_ID },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bmp280_spi_id);
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 57ba0e85db91..b4c122525ffe 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -3,6 +3,122 @@
 #include <linux/device.h>
 #include <linux/regmap.h>
 
+/* BMP380 specific registers */
+#define BMP380_REG_CMD			0x7E
+#define BMP380_REG_CONFIG		0x1F
+#define BMP380_REG_ODR			0X1D
+#define BMP380_REG_OSR			0X1C
+#define BMP380_REG_POWER_CONTROL	0X1B
+#define BMP380_REG_IF_CONFIG		0X1A
+#define BMP380_REG_INT_CONTROL		0X19
+#define BMP380_REG_INT_STATUS		0X11
+#define BMP380_REG_EVENT		0X10
+#define BMP380_REG_STATUS		0X03
+#define BMP380_REG_ERROR		0X02
+#define BMP380_REG_ID			0X00
+
+#define BMP380_REG_FIFO_CONFIG_1	0X18
+#define BMP380_REG_FIFO_CONFIG_2	0X17
+#define BMP380_REG_FIFO_WATERMARK_MSB	0X16
+#define BMP380_REG_FIFO_WATERMARK_LSB	0X15
+#define BMP380_REG_FIFO_DATA		0X14
+#define BMP380_REG_FIFO_LENGTH_MSB	0X13
+#define BMP380_REG_FIFO_LENGTH_LSB	0X12
+
+#define BMP380_REG_SENSOR_TIME_MSB	0X0E
+#define BMP380_REG_SENSOR_TIME_LSB	0X0D
+#define BMP380_REG_SENSOR_TIME_XLSB	0X0C
+
+#define BMP380_REG_TEMP_MSB		0X09
+#define BMP380_REG_TEMP_LSB		0X08
+#define BMP380_REG_TEMP_XLSB		0X07
+
+#define BMP380_REG_PRESS_MSB		0X06
+#define BMP380_REG_PRESS_LSB		0X05
+#define BMP380_REG_PRESS_XLSB		0X04
+
+#define BMP380_REG_CALIB_TEMP_START	0x31
+#define BMP380_CALIB_REG_COUNT		21
+#define le16_from_bytes(lsb, msb)	(le16_to_cpu(((((__le16) msb) << 8) | \
+							(__le16) lsb)))
+
+#define BMP380_FILTER_MASK		GENMASK(3, 1)
+#define BMP380_FILTER_OFF		0
+#define BMP380_FILTER_1X		BIT(1)
+#define BMP380_FILTER_3X		BIT(2)
+#define BMP380_FILTER_7X		(BIT(2) | BIT(1))
+#define BMP380_FILTER_15X		BIT(3)
+#define BMP380_FILTER_31X		(BIT(3) | BIT(1))
+#define BMP380_FILTER_63X		(BIT(3) | BIT(2))
+#define BMP380_FILTER_127X		(BIT(3) | BIT(2) | BIT(1))
+
+#define BMP380_OSRS_TEMP_MASK		GENMASK(5, 3)
+#define BMP380_OSRS_TEMP_X(osrs_t)	((osrs_t) << 3)
+#define BMP380_OSRS_TEMP_1X		BMP380_OSRS_TEMP_X(0)
+#define BMP380_OSRS_TEMP_2X		BMP380_OSRS_TEMP_X(1)
+#define BMP380_OSRS_TEMP_4X		BMP380_OSRS_TEMP_X(2)
+#define BMP380_OSRS_TEMP_8X		BMP380_OSRS_TEMP_X(3)
+#define BMP380_OSRS_TEMP_16X		BMP380_OSRS_TEMP_X(4)
+#define BMP380_OSRS_TEMP_32X		BMP380_OSRS_TEMP_X(5)
+
+#define BMP380_OSRS_PRESS_MASK		(BIT(2) | BIT(1) | BIT(0))
+#define BMP380_OSRS_PRESS_X(osrs_p)	((osrs_p) << 0)
+#define BMP380_OSRS_PRESS_1X		BMP380_OSRS_PRESS_X(0)
+#define BMP380_OSRS_PRESS_2X		BMP380_OSRS_PRESS_X(1)
+#define BMP380_OSRS_PRESS_4X		BMP380_OSRS_PRESS_X(2)
+#define BMP380_OSRS_PRESS_8X		BMP380_OSRS_PRESS_X(3)
+#define BMP380_OSRS_PRESS_16X		BMP380_OSRS_PRESS_X(4)
+#define BMP380_OSRS_PRESS_32X		BMP380_OSRS_PRESS_X(5)
+
+#define BMP380_ODRS_MASK		GENMASK(4, 0)
+#define BMP380_ODRS_200HZ		0x00
+#define BMP380_ODRS_100HZ		0x01
+#define BMP380_ODRS_50HZ		0x02
+#define BMP380_ODRS_25HZ		0x03
+#define BMP380_ODRS_12_5HZ		0x04
+#define BMP380_ODRS_6_25HZ		0x05
+#define BMP380_ODRS_3_1HZ		0x06
+#define BMP380_ODRS_1_5HZ		0x07
+#define BMP380_ODRS_0_78HZ		0x08
+#define BMP380_ODRS_0_39HZ		0x09
+#define BMP380_ODRS_0_2HZ		0x0A
+#define BMP380_ODRS_0_1HZ		0x0B
+#define BMP380_ODRS_0_05HZ		0x0C
+#define BMP380_ODRS_0_02HZ		0x0D
+#define BMP380_ODRS_0_01HZ		0x0E
+#define BMP380_ODRS_0_006HZ		0x0F
+#define BMP380_ODRS_0_003HZ		0x10
+#define BMP380_ODRS_0_0015HZ		0x11
+
+#define BMP380_CTRL_SENSORS_MASK	GENMASK(1, 0)
+#define BMP380_CTRL_SENSORS_PRESS_EN	BIT(0)
+#define BMP380_CTRL_SENSORS_TEMP_EN	BIT(1)
+#define BMP380_MODE_MASK		GENMASK(5, 4)
+#define BMP380_MODE_SLEEP		0
+#define BMP380_MODE_FORCED		BIT(4)
+#define BMP380_MODE_NORMAL		(BIT(5) | BIT(4))
+
+#define BMP380_MIN_TEMP			-4000
+#define BMP380_MAX_TEMP			8500
+#define BMP380_MIN_PRES			3000000
+#define BMP380_MAX_PRES			12500000
+
+#define BMP380_CMD_NOOP			0X00
+#define BMP380_CMD_EXTMODE_EN_MID	0x34
+#define BMP380_CMD_FIFO_FLUSH		0XB0
+#define BMP380_CMD_SOFT_RESET		0xB6
+
+#define BMP380_STATUS_CMD_RDY_MASK	BIT(4)
+#define BMP380_STATUS_DRDY_PRESS_MASK	BIT(5)
+#define BMP380_STATUS_DRDY_TEMP_MASK	BIT(6)
+
+#define BMP380_ERR_FATAL_MASK		BIT(0)
+#define	BMP380_ERR_CMD_MASK		BIT(1)
+#define BMP380_ERR_CONF_MASK		BIT(2)
+
+#define BMP380_TEMP_SKIPPED		0x800000
+#define BMP380_PRESS_SKIPPED		0x800000
+
 /* BMP280 specific registers */
 #define BMP280_REG_HUMIDITY_LSB		0xFE
 #define BMP280_REG_HUMIDITY_MSB		0xFD
@@ -92,6 +208,7 @@
 #define BMP280_REG_RESET		0xE0
 #define BMP280_REG_ID			0xD0
 
+#define BMP380_CHIP_ID			0x50
 #define BMP180_CHIP_ID			0x55
 #define BMP280_CHIP_ID			0x58
 #define BME280_CHIP_ID			0x60
@@ -105,6 +222,7 @@
 /* Regmap configurations */
 extern const struct regmap_config bmp180_regmap_config;
 extern const struct regmap_config bmp280_regmap_config;
+extern const struct regmap_config bmp380_regmap_config;
 
 /* Probe called from different transports */
 int bmp280_common_probe(struct device *dev,
-- 
2.25.1

