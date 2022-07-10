Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52156CE5D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 11:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGJJRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 05:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJJRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 05:17:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E7A1116F;
        Sun, 10 Jul 2022 02:17:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so1470260wmb.1;
        Sun, 10 Jul 2022 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2h7tebNzxBgXWYha2s0151QeZmHD5NF+qkk3vM1IJVM=;
        b=UjBwaLT1eJEfYenGXG+jPFEZi7AQfBXIhcHDykRC1/yAS8+kR0MMXkXKmcO5rWNAg8
         cd3SmgvUh9h97V7i4qHmsI0eA2yRxhTHcnVZurzUFPTvn4isDyUydFKkrcpOk9DMn3QV
         c4B3/eQvCd9KECVXtahwUprKeVF5JSxs/kiH/GEKeeXinMeG3Ew4rPJc0966aiQzRAFY
         DijPkh6Ad6A4zqXRKqY3RzxkanWopnZdAO261qdQ1AQXcLS2WNUt+TDkNbHT+nCKc3Xv
         Y6AfEEGtRAvsi3OKiKuLB+mDYeA863TIK8plMv8xyrDrrH4i68CuFfbeJMNi4Afs0jnG
         Uxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2h7tebNzxBgXWYha2s0151QeZmHD5NF+qkk3vM1IJVM=;
        b=VHgXue6X9plrFOAyymBH9kKOi8eUSGy0OCDsWHUgPnweqJvPwaUTPs0ZaJ8JbUQKcp
         u6n3Aj9Z40cpOzjeM2qUYfYed9gEqShH7xSKgPSPJ9M1mlqQaO+7EGDqXNo4c2+Wj7f0
         uYkrcOiROU4jMQBghW+9/zgflJOB58ATsze4GF6vPof1eyOxeclz7qE1InuxCWHPbfoh
         I7Zvr1/sjui13oJii4GxJ11vNBLQ/rigX9Rv22i5dXUYsxvnlvpqsfHI4RaO987IuDMJ
         S1WuvZ6GhiFUyeduYFxQbk809enH81a+PcERpDdvc+Y5HD6c7imQdOd7fQobye36Cvl5
         TNzw==
X-Gm-Message-State: AJIora9xfDX9O6NIBd7Lc+KEShowRLZJ0t3wznI60hYL0CWDMRzR9oR2
        P/EcfY4eWWUwDDeJHW8HPQQ=
X-Google-Smtp-Source: AGRyM1sfvGkk7u/6S+9EV0cDEN2kU1r/y2jt52RdPS39XmE0EYM9pAd36tHqdG+b1BLRr5qto/vSqQ==
X-Received: by 2002:a05:600c:4e0f:b0:3a2:e60a:d953 with SMTP id b15-20020a05600c4e0f00b003a2e60ad953mr948803wmq.96.1657444634535;
        Sun, 10 Jul 2022 02:17:14 -0700 (PDT)
Received: from xps-work.lan (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id c3-20020a5d63c3000000b002167efdd549sm3194010wrw.38.2022.07.10.02.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 02:17:14 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] iio: pressure: bmp280: simplify driver initialization logic
Date:   Sun, 10 Jul 2022 11:17:06 +0200
Message-Id: <20220710091708.15967-1-ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The auxiliar functions for read each sensor type calibration are converted
to a callback available on the chip_info struct.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/pressure/bmp280-core.c | 91 ++++++++++++++++++------------
 1 file changed, 54 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index bf8167f43c56..59e9c5fb4ab4 100644
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
2.36.1

