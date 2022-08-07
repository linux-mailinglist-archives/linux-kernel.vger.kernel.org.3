Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737DA58BAB3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 13:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiHGLyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 07:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiHGLys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 07:54:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD4DBE1F;
        Sun,  7 Aug 2022 04:54:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j4-20020a05600c1c0400b003a4f287418bso3252509wms.5;
        Sun, 07 Aug 2022 04:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dEyf3MBcvu7Mhpl7KCISrT9nRy9wHbjVooc9Xv9/fZo=;
        b=eSP3qNuMwuOiap3PZFkQrwYXg1EleXNvveoaMG9fmIRo8Yk0pRQu/yRiDKlcKJxOd5
         uKICq3TjKwseHJHQ8SrLTn+BqmGZkGocwRx9aO3PhqWHZN88zldoYJwmmdtcMg8kBomO
         sU1RKfvMrh/7B8/ijKOtXJ4RHuMk79AG4vRfdcMMmQ4g1ZJ7saC4QpvhbRtAStUKtr4+
         FvJuNJyq1jQOE3WxF9QzWmdJcJ0PooEnXsgd1FApAliG00A2wIxgAxgrdFMwQm4WpChU
         d/dZspFnVeXZuN0/m3oAvp02fXoGf25zipgCowHqEGwY9QTtilsmOHBOz3NevgQ+RBmq
         KYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dEyf3MBcvu7Mhpl7KCISrT9nRy9wHbjVooc9Xv9/fZo=;
        b=zvCj03JnZCjEifsfJaOkqXMt/KCt5fnYa2tFCCOdXzPV24zcuT1uGWDHD4Bg5DbQca
         jBQHXFcZOyfAdK1b/fye+dotE06QxgIbkeJglRvIAi8kJPX2RTzcJdLuHYvEa+SxUSbB
         8H/Jshe7yqQuos6iayrXkY9t/tk13IABGjPHsqGbIrJtYJ8/RKe7zkWZE1xHS57vtn9y
         w0NobIkfvlfN+yYkxf9TuBM63iiX99Tuu7o1sTULCGRjXJs/3Fil/zYWpcnN5Mwg/z3Z
         6sU/yTp9v2utf8vEhq+h8LHb02Txc8cHtp15AszxrXuYYsNRC7PnizxV3Tl23yWpWCOs
         khhQ==
X-Gm-Message-State: ACgBeo1zl7h+wRzwtZSKDsXlZ99mYmYLitEfVxgGo+KtPhKNG0zuEiTj
        cC27c3vt32N0NmQgDTgB1xpToGopuas=
X-Google-Smtp-Source: AA6agR58kq+2CqX0RBzu0EgZfyxkRBeey3QilvAHfU14AUZFmrSbMbdmwKa6jW8NiLOF7UnGhlBIwQ==
X-Received: by 2002:a05:600c:3485:b0:3a3:71cf:12ca with SMTP id a5-20020a05600c348500b003a371cf12camr9842748wmq.28.1659873284381;
        Sun, 07 Aug 2022 04:54:44 -0700 (PDT)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003a319b67f64sm38929038wmq.0.2022.08.07.04.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 04:54:44 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] iio: pressure: bmp280: simplify driver initialization logic
Date:   Sun,  7 Aug 2022 13:54:40 +0200
Message-Id: <602f032955b56eb367177d1de7536f18ad94bc87.1659872590.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659872590.git.ang.iglesiasg@gmail.com>
References: <cover.1659872590.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplified common initialization logic of different sensor types
unifying calibration and initial configuration recovery.

Default config param values of each sensor type are stored inside
chip_info structure and used to initialize sensor data struct instance.

The helper functions for read each sensor type calibration are converted
to a callback available on the chip_info struct.

Revised BMP180 and BMP280 definitions and code functions to use GENMASK
and FIELD_PREP/FIELD_GET utilities to homogenize structure with more
recent drivers, in preparation for the patches adding support for the
BMP380 sensors.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 120 ++++++++++++++++++-----------
 drivers/iio/pressure/bmp280.h      |  73 +++++++++---------
 2 files changed, 113 insertions(+), 80 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe7aa81e7cc9..a109c2609896 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -16,6 +16,8 @@
 
 #define pr_fmt(fmt) "bmp280: " fmt
 
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -107,19 +109,28 @@ struct bmp280_data {
 };
 
 struct bmp280_chip_info {
+	unsigned int id_reg;
+
+	int num_channels;
+	unsigned int start_up_time;
+
 	const int *oversampling_temp_avail;
 	int num_oversampling_temp_avail;
+	int oversampling_temp_default;
 
 	const int *oversampling_press_avail;
 	int num_oversampling_press_avail;
+	int oversampling_press_default;
 
 	const int *oversampling_humid_avail;
 	int num_oversampling_humid_avail;
+	int oversampling_humid_default;
 
 	int (*chip_config)(struct bmp280_data *);
 	int (*read_temp)(struct bmp280_data *, int *);
 	int (*read_press)(struct bmp280_data *, int *, int *);
 	int (*read_humid)(struct bmp280_data *, int *, int *);
+	int (*read_calib)(struct bmp280_data *, unsigned int);
 };
 
 /*
@@ -147,15 +158,14 @@ static const struct iio_chan_spec bmp280_channels[] = {
 	},
 };
 
-static int bmp280_read_calib(struct bmp280_data *data,
-			     struct bmp280_calib *calib,
-			     unsigned int chip)
+static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
 {
 	int ret;
 	unsigned int tmp;
 	__le16 l16;
 	__be16 b16;
 	struct device *dev = data->dev;
+	struct bmp280_calib *calib = &data->calib.bmp280;
 	__le16 t_buf[BMP280_COMP_TEMP_REG_COUNT / 2];
 	__le16 p_buf[BMP280_COMP_PRESS_REG_COUNT / 2];
 
@@ -611,8 +621,8 @@ static const struct iio_info bmp280_info = {
 static int bmp280_chip_config(struct bmp280_data *data)
 {
 	int ret;
-	u8 osrs = BMP280_OSRS_TEMP_X(data->oversampling_temp + 1) |
-		  BMP280_OSRS_PRESS_X(data->oversampling_press + 1);
+	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
+		  FIELD_PREP(BMP280_OSRS_PRESS_MASK, data->oversampling_press + 1);
 
 	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
 				 BMP280_OSRS_TEMP_MASK |
@@ -640,21 +650,38 @@ static int bmp280_chip_config(struct bmp280_data *data)
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 
 static const struct bmp280_chip_info bmp280_chip_info = {
+	.id_reg = BMP280_REG_ID,
+	.start_up_time = 2000,
+	.num_channels = 2,
+
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	/*
+	 * Oversampling config values on BMx280 have one additional setting
+	 * that other generations of the family don't:
+	 * The value 0 means the measurement is bypassed instead of
+	 * oversampling set to x1.
+	 *
+	 * To account for this difference, and preserve the same common
+	 * config logic, this is handled later on chip_config callback
+	 * incrementing one unit the oversampling setting.
+	 */
+	.oversampling_temp_default = BMP280_OSRS_TEMP_2X - 1,
 
 	.oversampling_press_avail = bmp280_oversampling_avail,
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
 	.chip_config = bmp280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
+	.read_calib = bmp280_read_calib,
 };
 
 static int bme280_chip_config(struct bmp280_data *data)
 {
 	int ret;
-	u8 osrs = BMP280_OSRS_HUMIDITIY_X(data->oversampling_humid + 1);
+	u8 osrs = FIELD_PREP(BMP280_OSRS_HUMIDITY_MASK, data->oversampling_humid + 1);
 
 	/*
 	 * Oversampling of humidity must be set before oversampling of
@@ -670,19 +697,27 @@ static int bme280_chip_config(struct bmp280_data *data)
 }
 
 static const struct bmp280_chip_info bme280_chip_info = {
+	.id_reg = BMP280_REG_ID,
+	.start_up_time = 2000,
+	.num_channels = 3,
+
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	.oversampling_temp_default = BMP280_OSRS_TEMP_2X - 1,
 
 	.oversampling_press_avail = bmp280_oversampling_avail,
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
 	.oversampling_humid_avail = bmp280_oversampling_avail,
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	.oversampling_humid_default = BMP280_OSRS_HUMIDITY_16X - 1,
 
 	.chip_config = bme280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_humid = bmp280_read_humid,
+	.read_calib = bmp280_read_calib,
 };
 
 static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
@@ -710,7 +745,7 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 		if (!ret)
 			dev_err(data->dev, "timeout waiting for completion\n");
 	} else {
-		if (ctrl_meas == BMP180_MEAS_TEMP)
+		if (FIELD_GET(BMP180_MEAS_CTRL_MASK, ctrl_meas) == BMP180_MEAS_TEMP)
 			delay_us = 4500;
 		else
 			delay_us =
@@ -735,7 +770,9 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 	__be16 tmp;
 	int ret;
 
-	ret = bmp180_measure(data, BMP180_MEAS_TEMP);
+	ret = bmp180_measure(data,
+			     FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_TEMP) |
+			     BMP180_MEAS_SCO);
 	if (ret)
 		return ret;
 
@@ -748,11 +785,11 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 	return 0;
 }
 
-static int bmp180_read_calib(struct bmp280_data *data,
-			     struct bmp180_calib *calib)
+static int bmp180_read_calib(struct bmp280_data *data, unsigned int chip)
 {
 	int ret;
 	int i;
+	struct bmp180_calib *calib = &data->calib.bmp180;
 	__be16 buf[BMP180_REG_CALIB_COUNT / 2];
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START, buf,
@@ -832,7 +869,10 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 	__be32 tmp = 0;
 	u8 oss = data->oversampling_press;
 
-	ret = bmp180_measure(data, BMP180_MEAS_PRESS_X(oss));
+	ret = bmp180_measure(data,
+			     FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_PRESS) |
+			     FIELD_PREP(BMP180_OSRS_PRESS_MASK, oss) |
+			     BMP180_MEAS_SCO);
 	if (ret)
 		return ret;
 
@@ -913,17 +953,24 @@ static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 
 static const struct bmp280_chip_info bmp180_chip_info = {
+	.id_reg = BMP280_REG_ID,
+	.start_up_time = 2000,
+	.num_channels = 2,
+
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
 	.num_oversampling_temp_avail =
 		ARRAY_SIZE(bmp180_oversampling_temp_avail),
+	.oversampling_temp_default = 0,
 
 	.oversampling_press_avail = bmp180_oversampling_press_avail,
 	.num_oversampling_press_avail =
 		ARRAY_SIZE(bmp180_oversampling_press_avail),
+	.oversampling_press_default = BMP180_MEAS_PRESS_8X,
 
 	.chip_config = bmp180_chip_config,
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
+	.read_calib = bmp180_read_calib,
 };
 
 static irqreturn_t bmp085_eoc_irq(int irq, void *d)
@@ -993,6 +1040,7 @@ int bmp280_common_probe(struct device *dev,
 	int ret;
 	struct iio_dev *indio_dev;
 	struct bmp280_data *data;
+	const struct bmp280_chip_info *chip_info;
 	unsigned int chip_id;
 	struct gpio_desc *gpiod;
 
@@ -1011,30 +1059,25 @@ int bmp280_common_probe(struct device *dev,
 
 	switch (chip) {
 	case BMP180_CHIP_ID:
-		indio_dev->num_channels = 2;
-		data->chip_info = &bmp180_chip_info;
-		data->oversampling_press = ilog2(8);
-		data->oversampling_temp = ilog2(1);
-		data->start_up_time = 10000;
+		chip_info = &bmp180_chip_info;
 		break;
 	case BMP280_CHIP_ID:
-		indio_dev->num_channels = 2;
-		data->chip_info = &bmp280_chip_info;
-		data->oversampling_press = ilog2(16);
-		data->oversampling_temp = ilog2(2);
-		data->start_up_time = 2000;
+		chip_info = &bmp280_chip_info;
 		break;
 	case BME280_CHIP_ID:
-		indio_dev->num_channels = 3;
-		data->chip_info = &bme280_chip_info;
-		data->oversampling_press = ilog2(16);
-		data->oversampling_humid = ilog2(16);
-		data->oversampling_temp = ilog2(2);
-		data->start_up_time = 2000;
+		chip_info = &bme280_chip_info;
 		break;
 	default:
 		return -EINVAL;
 	}
+	data->chip_info = chip_info;
+
+	/* apply initial values from chip info structure */
+	indio_dev->num_channels = chip_info->num_channels;
+	data->oversampling_press = chip_info->oversampling_press_default;
+	data->oversampling_humid = chip_info->oversampling_humid_default;
+	data->oversampling_temp = chip_info->oversampling_temp_default;
+	data->start_up_time = chip_info->start_up_time;
 
 	/* Bring up regulators */
 	regulator_bulk_set_supply_names(data->supplies,
@@ -1071,7 +1114,8 @@ int bmp280_common_probe(struct device *dev,
 	}
 
 	data->regmap = regmap;
-	ret = regmap_read(regmap, BMP280_REG_ID, &chip_id);
+
+	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
 	if (ret < 0)
 		return ret;
 	if (chip_id != chip) {
@@ -1091,21 +1135,11 @@ int bmp280_common_probe(struct device *dev,
 	 * non-volatile memory during production". Let's read them out at probe
 	 * time once. They will not change.
 	 */
-	if (chip_id  == BMP180_CHIP_ID) {
-		ret = bmp180_read_calib(data, &data->calib.bmp180);
-		if (ret < 0) {
-			dev_err(data->dev,
-				"failed to read calibration coefficients\n");
-			return ret;
-		}
-	} else if (chip_id == BMP280_CHIP_ID || chip_id == BME280_CHIP_ID) {
-		ret = bmp280_read_calib(data, &data->calib.bmp280, chip_id);
-		if (ret < 0) {
-			dev_err(data->dev,
-				"failed to read calibration coefficients\n");
-			return ret;
-		}
-	}
+
+	ret = data->chip_info->read_calib(data, chip_id);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret,
+				     "failed to read calibration coefficients\n");
 
 	/*
 	 * Attempt to grab an optional EOC IRQ - only the BMP085 has this
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 57ba0e85db91..5a19c7d04804 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -32,44 +32,41 @@
 #define BMP280_REG_COMP_PRESS_START	0x8E
 #define BMP280_COMP_PRESS_REG_COUNT	18
 
-#define BMP280_FILTER_MASK		(BIT(4) | BIT(3) | BIT(2))
+#define BMP280_FILTER_MASK		GENMASK(4, 2)
 #define BMP280_FILTER_OFF		0
-#define BMP280_FILTER_2X		BIT(2)
-#define BMP280_FILTER_4X		BIT(3)
-#define BMP280_FILTER_8X		(BIT(3) | BIT(2))
-#define BMP280_FILTER_16X		BIT(4)
+#define BMP280_FILTER_2X		1
+#define BMP280_FILTER_4X		2
+#define BMP280_FILTER_8X		3
+#define BMP280_FILTER_16X		4
 
-#define BMP280_OSRS_HUMIDITY_MASK	(BIT(2) | BIT(1) | BIT(0))
-#define BMP280_OSRS_HUMIDITIY_X(osrs_h)	((osrs_h) << 0)
+#define BMP280_OSRS_HUMIDITY_MASK	GENMASK(2, 0)
 #define BMP280_OSRS_HUMIDITY_SKIP	0
-#define BMP280_OSRS_HUMIDITY_1X		BMP280_OSRS_HUMIDITIY_X(1)
-#define BMP280_OSRS_HUMIDITY_2X		BMP280_OSRS_HUMIDITIY_X(2)
-#define BMP280_OSRS_HUMIDITY_4X		BMP280_OSRS_HUMIDITIY_X(3)
-#define BMP280_OSRS_HUMIDITY_8X		BMP280_OSRS_HUMIDITIY_X(4)
-#define BMP280_OSRS_HUMIDITY_16X	BMP280_OSRS_HUMIDITIY_X(5)
+#define BMP280_OSRS_HUMIDITY_1X		1
+#define BMP280_OSRS_HUMIDITY_2X		2
+#define BMP280_OSRS_HUMIDITY_4X		3
+#define BMP280_OSRS_HUMIDITY_8X		4
+#define BMP280_OSRS_HUMIDITY_16X	5
 
-#define BMP280_OSRS_TEMP_MASK		(BIT(7) | BIT(6) | BIT(5))
+#define BMP280_OSRS_TEMP_MASK		GENMASK(7, 5)
 #define BMP280_OSRS_TEMP_SKIP		0
-#define BMP280_OSRS_TEMP_X(osrs_t)	((osrs_t) << 5)
-#define BMP280_OSRS_TEMP_1X		BMP280_OSRS_TEMP_X(1)
-#define BMP280_OSRS_TEMP_2X		BMP280_OSRS_TEMP_X(2)
-#define BMP280_OSRS_TEMP_4X		BMP280_OSRS_TEMP_X(3)
-#define BMP280_OSRS_TEMP_8X		BMP280_OSRS_TEMP_X(4)
-#define BMP280_OSRS_TEMP_16X		BMP280_OSRS_TEMP_X(5)
-
-#define BMP280_OSRS_PRESS_MASK		(BIT(4) | BIT(3) | BIT(2))
+#define BMP280_OSRS_TEMP_1X		1
+#define BMP280_OSRS_TEMP_2X		2
+#define BMP280_OSRS_TEMP_4X		3
+#define BMP280_OSRS_TEMP_8X		4
+#define BMP280_OSRS_TEMP_16X		5
+
+#define BMP280_OSRS_PRESS_MASK		GENMASK(4, 2)
 #define BMP280_OSRS_PRESS_SKIP		0
-#define BMP280_OSRS_PRESS_X(osrs_p)	((osrs_p) << 2)
-#define BMP280_OSRS_PRESS_1X		BMP280_OSRS_PRESS_X(1)
-#define BMP280_OSRS_PRESS_2X		BMP280_OSRS_PRESS_X(2)
-#define BMP280_OSRS_PRESS_4X		BMP280_OSRS_PRESS_X(3)
-#define BMP280_OSRS_PRESS_8X		BMP280_OSRS_PRESS_X(4)
-#define BMP280_OSRS_PRESS_16X		BMP280_OSRS_PRESS_X(5)
-
-#define BMP280_MODE_MASK		(BIT(1) | BIT(0))
+#define BMP280_OSRS_PRESS_1X		1
+#define BMP280_OSRS_PRESS_2X		2
+#define BMP280_OSRS_PRESS_4X		3
+#define BMP280_OSRS_PRESS_8X		4
+#define BMP280_OSRS_PRESS_16X		5
+
+#define BMP280_MODE_MASK		GENMASK(1, 0)
 #define BMP280_MODE_SLEEP		0
-#define BMP280_MODE_FORCED		BIT(0)
-#define BMP280_MODE_NORMAL		(BIT(1) | BIT(0))
+#define BMP280_MODE_FORCED		1
+#define BMP280_MODE_NORMAL		3
 
 /* BMP180 specific registers */
 #define BMP180_REG_OUT_XLSB		0xF8
@@ -79,13 +76,15 @@
 #define BMP180_REG_CALIB_START		0xAA
 #define BMP180_REG_CALIB_COUNT		22
 
+#define BMP180_MEAS_CTRL_MASK		GENMASK(4, 0)
+#define BMP180_MEAS_TEMP		0x0E
+#define BMP180_MEAS_PRESS		0x14
 #define BMP180_MEAS_SCO			BIT(5)
-#define BMP180_MEAS_TEMP		(0x0E | BMP180_MEAS_SCO)
-#define BMP180_MEAS_PRESS_X(oss)	((oss) << 6 | 0x14 | BMP180_MEAS_SCO)
-#define BMP180_MEAS_PRESS_1X		BMP180_MEAS_PRESS_X(0)
-#define BMP180_MEAS_PRESS_2X		BMP180_MEAS_PRESS_X(1)
-#define BMP180_MEAS_PRESS_4X		BMP180_MEAS_PRESS_X(2)
-#define BMP180_MEAS_PRESS_8X		BMP180_MEAS_PRESS_X(3)
+#define BMP180_OSRS_PRESS_MASK		GENMASK(7, 6)
+#define BMP180_MEAS_PRESS_1X		0
+#define BMP180_MEAS_PRESS_2X		1
+#define BMP180_MEAS_PRESS_4X		2
+#define BMP180_MEAS_PRESS_8X		3
 
 /* BMP180 and BMP280 common registers */
 #define BMP280_REG_CTRL_MEAS		0xF4
-- 
2.37.1

