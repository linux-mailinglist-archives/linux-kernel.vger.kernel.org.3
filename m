Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE90564AE8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiGDAaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiGDAaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:30:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14018D6;
        Sun,  3 Jul 2022 17:30:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o4so11173709wrh.3;
        Sun, 03 Jul 2022 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQQMb/XrQ7h1l98gYcALYwompA+H4chujIZcP50btuI=;
        b=nFD8vp5fN25Zg2lX9700Xm8KVz/sEDBylxOHezDbuPXyHnPsdHebGe3Hvq+Maf9S/I
         99rCt0fviZ97cSyxeFR8BNNSX5RcFRFaOWQXIU2IElRGmcL0nwmSdHlgXE4MPvnlYXZ6
         RYiPOKjS6/0nsLQkuGTCaAQIShAiofhMasfd8V9yuBnfJduqwYVshfga88vvTtcny2s1
         xehgWRQFzbfemJVYHRAhT2TZP3WRT58rXAh/FxtQr7x7Kab1c5K6xSaDxvECwwWpu/WL
         PF09H5oN12RQpNH5CmAVJ0HIBFaZ+aIQnHmrY4TibV2BUwzQjcmzPXh81IiF7zbnu5xG
         b3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQQMb/XrQ7h1l98gYcALYwompA+H4chujIZcP50btuI=;
        b=OZvNaLOSFtUbvfoApvqu6uAUHUS+j1+TirAgnYlyGZG7T5Qm6Md9sIkaYhh2YErMpq
         DvXXCnVQsFM5CAd9rM3HAYMLdVlrrw4REyzaSQ2Eu10YShQ6Map04Zu2ac3ktr0E8mKp
         1y3sjgMxzExjaV030lhqk6afNBtChBpzLje5G9G74xpzkBeyXR0cPVYGLNmKN4wTg6/Y
         zprTOkljGAVHiXXLkBi4bNAgpbDMYfpOblyxehMLcRPMfoRll7iLum4lO5El3y5T4ucJ
         8bKXu3vQ+va7pOAZSaELC5i/IaKDjEqLhcPtqQpvdje4gvW4nnWlOLbE42IEh3uW54Am
         M1xQ==
X-Gm-Message-State: AJIora/ceoY03yON2bivR3qh+P0CjiDaxW/zp7yUDK43IAsjbBFpRVEZ
        KAHYwBkST0zO5be4SYdlvJI=
X-Google-Smtp-Source: AGRyM1t5Sz35y5DD1K/3HQn8WwWFmWDT6NycdpdAoFNAufxPXFDIhhAEG80IWEUkCz2GXXHyQTh3Zw==
X-Received: by 2002:a5d:4387:0:b0:21d:6983:13fc with SMTP id i7-20020a5d4387000000b0021d698313fcmr2875128wrq.696.1656894602714;
        Sun, 03 Jul 2022 17:30:02 -0700 (PDT)
Received: from xps-work.lan (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id j19-20020a5d6e53000000b002102b16b9a4sm28583435wrz.110.2022.07.03.17.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 17:30:02 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] iio: pressure: bmp280: simplify driver initialization logic
Date:   Mon,  4 Jul 2022 02:29:55 +0200
Message-Id: <20220704002957.207850-1-ang.iglesiasg@gmail.com>
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

Extended chip_info structure with default values for configuration params
to simplify and unify initialization logic for different supported sensors

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 91 ++++++++++++++++++------------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index bf8167f43c56..f39160b17cb3 100644
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
@@ -1091,20 +1118,12 @@ int bmp280_common_probe(struct device *dev,
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
+
+	ret = data->chip_info->read_calib(data, chip_id);
+	if (ret < 0) {
+		dev_err(data->dev,
+			"failed to read calibration coefficients\n");
+		return ret;
 	}
 
 	/*
-- 
2.36.1

