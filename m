Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EC457F0AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 19:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbiGWRi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 13:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiGWRix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 13:38:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628C71EECA;
        Sat, 23 Jul 2022 10:38:52 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h8so10448616wrw.1;
        Sat, 23 Jul 2022 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xqVXsscgCH6erCyqegMGrNDrb/gZIIh41mQ/X7d4CwE=;
        b=epkcDzeSadElm5A/w7sVPbGgodEMKhjrz1y1/EUxPRWHA67DMmqtwqkFmmvxVeCaXV
         08a0XvcFlT1bmb1h8H/QB4oesWRx+7sztKvIV4pAyA0Sc/hfxafk83haS9mulaxNYbKM
         ARP3fholyjvSyNnzjV5kWAvabUXAEugw3d4WPPx5wZJp74etmFEcbdjBdokXqOElQkf8
         IzPe2Vt3As6H399j/EwpPRFhBGw53x3dNBZCHa4GFs3Y5iyUUMwz9zYSMCzWee7hAQwZ
         yR0Ouim2KORYXzwi0yznsE6QZBI7ZR5TTic4Mo09i84gA3wA+ChHPZu9ggxnKdBFB1VR
         ENdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xqVXsscgCH6erCyqegMGrNDrb/gZIIh41mQ/X7d4CwE=;
        b=IYTvJOW01tTHzylk6LBSKNnxhYHmagl1TGAW5scf30FDjPriwMjI6YXBIjigyyBp9h
         KrPJ0nZY0Ps8QS51id3QK7PTcbVbS3LYE81hMyLPdwb/3we2FcsOyt1CjaatKT2jUX8D
         ks7UQa14fmYJHFulTJqq0XoQkANnhs4A49FMB/KTwdwuAM7/ZwgskbM7T/6Xw92ginoi
         TMvPausnQc+BVxTx3ZvEEVQZ5JBn/51Ighey9/Ue+zeIGY8ZtlqOox5tiOFCwIPKiiw1
         PP3K69iHc8uWkk27PZZRpLxV4Kqf/mwGzNCjyjd9cJMVC92Zxc+V5/ENwYAy+blUeSsn
         84dg==
X-Gm-Message-State: AJIora+73Or5Wbrj9g5SddF/5jfN2mI0uDBiqr1aff29dMdDyWrk/xr7
        00vEhYTaf+YTBXjpAxgZOuaumf0Np1bhfw==
X-Google-Smtp-Source: AGRyM1s5ugsGiQe8xWhsTUXVWMw4k5l9n8IKz/eJ0YRLTg+TuMmRXbbT3Xzte2yVlt2LL8FwAHaz2Q==
X-Received: by 2002:a5d:4d90:0:b0:21e:48ef:c5b with SMTP id b16-20020a5d4d90000000b0021e48ef0c5bmr3197899wru.701.1658597930552;
        Sat, 23 Jul 2022 10:38:50 -0700 (PDT)
Received: from xps-work.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id s3-20020a05600c384300b003a2d47d3051sm9926160wmr.41.2022.07.23.10.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 10:38:50 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] iio: pressure: bmp280: simplify driver initialization logic
Date:   Sat, 23 Jul 2022 19:38:43 +0200
Message-Id: <44a301d5605bcf5b30ae60b21d0b312717b938bc.1658597501.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1658597501.git.ang.iglesiasg@gmail.com>
References: <cover.1658597501.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplified common initialization logic of different sensor types
unifying calibration and initial configuration recovery.

Default config param values of each sensor type are stored inside
chip_info structure and used to initialize sensor data struct instance.

The auxiliar functions for read each sensor type calibration are converted
to a callback available on the chip_info struct.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 91 ++++++++++++++++++------------
 1 file changed, 54 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe7aa81e7cc9..60fba199c7a0 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -107,19 +107,28 @@ struct bmp280_data {
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
@@ -147,15 +156,14 @@ static const struct iio_chan_spec bmp280_channels[] = {
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
 
@@ -640,15 +648,22 @@ static int bmp280_chip_config(struct bmp280_data *data)
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 
 static const struct bmp280_chip_info bmp280_chip_info = {
+	.id_reg = BMP280_REG_ID,
+	.start_up_time = 2000,
+	.num_channels = 2,
+
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	.oversampling_temp_default = ilog2(2),
 
 	.oversampling_press_avail = bmp280_oversampling_avail,
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	.oversampling_press_default = ilog2(16),
 
 	.chip_config = bmp280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
+	.read_calib = bmp280_read_calib,
 };
 
 static int bme280_chip_config(struct bmp280_data *data)
@@ -670,19 +685,27 @@ static int bme280_chip_config(struct bmp280_data *data)
 }
 
 static const struct bmp280_chip_info bme280_chip_info = {
+	.id_reg = BMP280_REG_ID,
+	.start_up_time = 2000,
+	.num_channels = 3,
+
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	.oversampling_temp_default = ilog2(2),
 
 	.oversampling_press_avail = bmp280_oversampling_avail,
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	.oversampling_press_default = ilog2(16),
 
 	.oversampling_humid_avail = bmp280_oversampling_avail,
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
+	.oversampling_humid_default = ilog2(16),
 
 	.chip_config = bme280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_humid = bmp280_read_humid,
+	.read_calib = bmp280_read_calib,
 };
 
 static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
@@ -748,11 +771,11 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
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
@@ -913,17 +936,24 @@ static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 
 static const struct bmp280_chip_info bmp180_chip_info = {
+	.id_reg = BMP280_REG_ID,
+	.start_up_time = 2000,
+	.num_channels = 2,
+
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
 	.num_oversampling_temp_avail =
 		ARRAY_SIZE(bmp180_oversampling_temp_avail),
+	.oversampling_temp_default = ilog2(1),
 
 	.oversampling_press_avail = bmp180_oversampling_press_avail,
 	.num_oversampling_press_avail =
 		ARRAY_SIZE(bmp180_oversampling_press_avail),
+	.oversampling_press_default = ilog2(8),
 
 	.chip_config = bmp180_chip_config,
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
+	.read_calib = bmp180_read_calib,
 };
 
 static irqreturn_t bmp085_eoc_irq(int irq, void *d)
@@ -993,6 +1023,7 @@ int bmp280_common_probe(struct device *dev,
 	int ret;
 	struct iio_dev *indio_dev;
 	struct bmp280_data *data;
+	const struct bmp280_chip_info *chip_info;
 	unsigned int chip_id;
 	struct gpio_desc *gpiod;
 
@@ -1011,30 +1042,25 @@ int bmp280_common_probe(struct device *dev,
 
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
@@ -1071,7 +1097,8 @@ int bmp280_common_probe(struct device *dev,
 	}
 
 	data->regmap = regmap;
-	ret = regmap_read(regmap, BMP280_REG_ID, &chip_id);
+
+	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
 	if (ret < 0)
 		return ret;
 	if (chip_id != chip) {
@@ -1091,21 +1118,11 @@ int bmp280_common_probe(struct device *dev,
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
-- 
2.37.1

