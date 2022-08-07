Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAEC58BABC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 13:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiHGL5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 07:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiHGL5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 07:57:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798BA6144;
        Sun,  7 Aug 2022 04:57:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n4so6274977wrp.10;
        Sun, 07 Aug 2022 04:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=V3co+eN6yPF6YpowbYaJntMrgH1CRhn4wzLgV+KczuQ=;
        b=ow6+JwvBnQl3HvB7SUTH7h0zrR0cQZmka6CxTrfqJNAltV8LRwl1jQvczUS4bit3SM
         EViNWw7lbKuZ6uI8n2hg2ERkJlGxzVZpK9S4/r03k9P2qLPuXm8sC9HR19JkwygMawKF
         Z3llIO287Mw3qth+GgbxOwUIycfy1JbJeS6Ax5O5P5j864mhd2SeHcSrNxhZOVqyoBbd
         ttHdCDR/0VyTVw8XKXNxKctBzWyI1Z/VAkeHiV4EFq1VjgyJwpwzSnKgRudZ8j3nkwZs
         1QDgtxDNbQ5oZ+ZxGo8GhtqaWZnPgsm3BX7o0NHtCZ1AHimGY66UczFYrwTNO1hs4qHd
         sjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=V3co+eN6yPF6YpowbYaJntMrgH1CRhn4wzLgV+KczuQ=;
        b=3lhWqGkq/dh5Zu5d1K/t/fbsCL7uFD1/UFrkrhY+bnmiyVU9cRfqPcc55xiSiKWM5D
         uY3qS0KgMsmV71lnTHw6/bjOQpVfkBMjKvP2kd0GdiQnunDzR9TCPETLjy8NZGk2fuul
         JCejNNsKyPsb+JfSoNzbT88JNBIkf8jrz7k4P2X0TDAypxFintnA9b6pXOGjJBUKPuNE
         f5JQ9bpZtHMRGWh9n11FSbMY7VWhF3MRzHYVivlYWwlHj/oc3/myIAi8uASNF3ht2/wf
         dKii9tzAJISKy1Kaj9zUQtdUqGVTKr0wN8UsOaLgOhZgSUQIoZ4FHg/VE7mayBLVvY4a
         QXzw==
X-Gm-Message-State: ACgBeo10LCqDiXToaC3t6DGcIdxC4sDigqVyvrE9HaT9LvuwJoor45qP
        ZicOOCEU5yKMGpPR8X4FDdHfZCBwft4=
X-Google-Smtp-Source: AA6agR6mwt8T0OcF/96c96g7bETVxx0cOIZksf9dbIjFt5r604f1/svTAlSvlg+njWwLaRLc27sSog==
X-Received: by 2002:adf:f902:0:b0:221:6c4c:4966 with SMTP id b2-20020adff902000000b002216c4c4966mr6645210wrr.479.1659873425588;
        Sun, 07 Aug 2022 04:57:05 -0700 (PDT)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b0039c454067ddsm434818wms.15.2022.08.07.04.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 04:57:05 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/5] iio: pressure: bmp280: Add more tunable config parameters for BMP380
Date:   Sun,  7 Aug 2022 13:57:01 +0200
Message-Id: <680e7218234676ba78fc5eccd5f93e29c06c3983.1659872590.git.ang.iglesiasg@gmail.com>
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

Allows sampling frequency and IIR filter coefficients configuration
using sysfs ABI.

The IIR filter coefficient is configurable using the sysfs attribute
"filter_low_pass_3db_frequency".

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 324 ++++++++++++++++++++++++++---
 drivers/iio/pressure/bmp280.h      |  18 --
 2 files changed, 294 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe171908a89c..39406f0f1e76 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -100,6 +100,27 @@ static const char *const bmp280_supply_names[] = {
 	"vddd", "vdda"
 };
 
+enum bmp380_odr {
+	BMP380_ODR_200HZ,
+	BMP380_ODR_100HZ,
+	BMP380_ODR_50HZ,
+	BMP380_ODR_25HZ,
+	BMP380_ODR_12_5HZ,
+	BMP380_ODR_6_25HZ,
+	BMP380_ODR_3_125HZ,
+	BMP380_ODR_1_5625HZ,
+	BMP380_ODR_0_78HZ,
+	BMP380_ODR_0_39HZ,
+	BMP380_ODR_0_2HZ,
+	BMP380_ODR_0_1HZ,
+	BMP380_ODR_0_05HZ,
+	BMP380_ODR_0_02HZ,
+	BMP380_ODR_0_01HZ,
+	BMP380_ODR_0_006HZ,
+	BMP380_ODR_0_003HZ,
+	BMP380_ODR_0_0015HZ,
+};
+
 #define BMP280_NUM_SUPPLIES ARRAY_SIZE(bmp280_supply_names)
 
 struct bmp280_data {
@@ -121,6 +142,17 @@ struct bmp280_data {
 	u8 oversampling_press;
 	u8 oversampling_temp;
 	u8 oversampling_humid;
+	u8 iir_filter_coeff;
+
+	/*
+	 * BMP380 devices introduce sampling frequency configuration. See
+	 * datasheet sections 3.3.3. and 4.3.19 for more details.
+	 *
+	 * BMx280 devices allowed indirect configuration of sampling frequency
+	 * changing the t_standby duration between measurements, as detailed on
+	 * section 3.6.3 of the datasheet.
+	 */
+	int sampling_freq;
 
 	/*
 	 * Carryover value from temperature conversion, used in pressure
@@ -145,6 +177,7 @@ struct bmp280_data {
 struct bmp280_chip_info {
 	unsigned int id_reg;
 
+	const struct iio_chan_spec *channels;
 	int num_channels;
 	unsigned int start_up_time;
 
@@ -160,6 +193,14 @@ struct bmp280_chip_info {
 	int num_oversampling_humid_avail;
 	int oversampling_humid_default;
 
+	const int *iir_filter_coeffs_avail;
+	int num_iir_filter_coeffs_avail;
+	int iir_filter_coeff_default;
+
+	const int (*sampling_freq_avail)[2];
+	int num_sampling_freq_avail;
+	int sampling_freq_default;
+
 	int (*chip_config)(struct bmp280_data *);
 	int (*read_temp)(struct bmp280_data *, int *);
 	int (*read_press)(struct bmp280_data *, int *, int *);
@@ -211,6 +252,30 @@ static const struct iio_chan_spec bmp280_channels[] = {
 	},
 };
 
+static const struct iio_chan_spec bmp380_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+	},
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+	},
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+	},
+};
+
 static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
 {
 	int ret;
@@ -526,6 +591,25 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!data->chip_info->sampling_freq_avail) {
+			ret = -EINVAL;
+			break;
+		}
+
+		*val = data->chip_info->sampling_freq_avail[data->sampling_freq][0];
+		*val2 = data->chip_info->sampling_freq_avail[data->sampling_freq][1];
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		if (!data->chip_info->iir_filter_coeffs_avail) {
+			ret = -EINVAL;
+			break;
+		}
+
+		*val = data->chip_info->iir_filter_coeffs_avail[data->iir_filter_coeff];
+		ret = IIO_VAL_INT;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -542,14 +626,22 @@ static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
 					       int val)
 {
 	int i;
+	int ret, prev;
 	const int *avail = data->chip_info->oversampling_humid_avail;
 	const int n = data->chip_info->num_oversampling_humid_avail;
 
 	for (i = 0; i < n; i++) {
 		if (avail[i] == val) {
+			prev = data->oversampling_humid;
 			data->oversampling_humid = ilog2(val);
 
-			return data->chip_info->chip_config(data);
+			ret = data->chip_info->chip_config(data);
+			if (ret) {
+				data->oversampling_humid = prev;
+				data->chip_info->chip_config(data);
+				return ret;
+			}
+			return 0;
 		}
 	}
 	return -EINVAL;
@@ -559,14 +651,22 @@ static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
 					       int val)
 {
 	int i;
+	int ret, prev;
 	const int *avail = data->chip_info->oversampling_temp_avail;
 	const int n = data->chip_info->num_oversampling_temp_avail;
 
 	for (i = 0; i < n; i++) {
 		if (avail[i] == val) {
+			prev = data->oversampling_temp;
 			data->oversampling_temp = ilog2(val);
 
-			return data->chip_info->chip_config(data);
+			ret = data->chip_info->chip_config(data);
+			if (ret) {
+				data->oversampling_temp = prev;
+				data->chip_info->chip_config(data);
+				return ret;
+			}
+			return 0;
 		}
 	}
 	return -EINVAL;
@@ -576,14 +676,72 @@ static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
 					       int val)
 {
 	int i;
+	int ret, prev;
 	const int *avail = data->chip_info->oversampling_press_avail;
 	const int n = data->chip_info->num_oversampling_press_avail;
 
 	for (i = 0; i < n; i++) {
 		if (avail[i] == val) {
+			prev = data->oversampling_press;
 			data->oversampling_press = ilog2(val);
 
-			return data->chip_info->chip_config(data);
+			ret = data->chip_info->chip_config(data);
+			if (ret) {
+				data->oversampling_press = prev;
+				data->chip_info->chip_config(data);
+				return ret;
+			}
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int bmp280_write_sampling_frequency(struct bmp280_data *data,
+					   int val, int val2)
+{
+	int i;
+	int ret, prev;
+	const int (*avail)[2] = data->chip_info->sampling_freq_avail;
+	const int n = data->chip_info->num_sampling_freq_avail;
+
+	for (i = 0; i < n; i++) {
+		if (avail[i][0] == val && avail[i][1] == val2) {
+			prev = data->sampling_freq;
+			data->sampling_freq = i;
+
+			ret = data->chip_info->chip_config(data);
+			if (ret) {
+				data->sampling_freq = prev;
+				data->chip_info->chip_config(data);
+				return ret;
+			}
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int bmp280_write_iir_filter_coeffs(struct bmp280_data *data, int val)
+{
+	int i;
+	int ret, prev;
+	const int *avail = data->chip_info->iir_filter_coeffs_avail;
+	const int n = data->chip_info->num_iir_filter_coeffs_avail;
+
+	for (i = 0; i < n; i++) {
+		if (avail[i] == val) {
+			prev = data->iir_filter_coeff;
+			data->iir_filter_coeff = i;
+
+			ret = data->chip_info->chip_config(data);
+			if (ret) {
+				data->iir_filter_coeff = prev;
+				data->chip_info->chip_config(data);
+				return ret;
+
+			}
+			return 0;
 		}
 	}
 	return -EINVAL;
@@ -596,6 +754,12 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 	int ret = 0;
 	struct bmp280_data *data = iio_priv(indio_dev);
 
+	/*
+	 * Helper functions to update sensor running configuration.
+	 * If an error happens applying new settings, will try restore
+	 * previous parameters to ensure the sensor is left in a known
+	 * working configuration.
+	 */
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		pm_runtime_get_sync(data->dev);
@@ -618,6 +782,22 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
 		pm_runtime_mark_last_busy(data->dev);
 		pm_runtime_put_autosuspend(data->dev);
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		pm_runtime_get_sync(data->dev);
+		mutex_lock(&data->lock);
+		ret = bmp280_write_sampling_frequency(data, val, val2);
+		mutex_unlock(&data->lock);
+		pm_runtime_mark_last_busy(data->dev);
+		pm_runtime_put_autosuspend(data->dev);
+		break;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		pm_runtime_get_sync(data->dev);
+		mutex_lock(&data->lock);
+		ret = bmp280_write_iir_filter_coeffs(data, val);
+		mutex_unlock(&data->lock);
+		pm_runtime_mark_last_busy(data->dev);
+		pm_runtime_put_autosuspend(data->dev);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -648,6 +828,17 @@ static int bmp280_read_avail(struct iio_dev *indio_dev,
 		}
 		*type = IIO_VAL_INT;
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)data->chip_info->sampling_freq_avail;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		/* Values are stored in a 2D matrix */
+		*length = data->chip_info->num_sampling_freq_avail;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*vals = data->chip_info->iir_filter_coeffs_avail;
+		*type = IIO_VAL_INT;
+		*length = data->chip_info->num_iir_filter_coeffs_avail;
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -693,6 +884,7 @@ static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
 	.start_up_time = 2000,
+	.channels = bmp280_channels,
 	.num_channels = 2,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
@@ -740,6 +932,7 @@ static int bme280_chip_config(struct bmp280_data *data)
 static const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
 	.start_up_time = 2000,
+	.channels = bmp280_channels,
 	.num_channels = 3,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
@@ -978,18 +1171,39 @@ static int bmp380_read_calib(struct bmp280_data *data, unsigned int chip)
 	return 0;
 }
 
+static const int bmp380_odr_table[][2] = {
+	[BMP380_ODR_200HZ]	= {200, 0},
+	[BMP380_ODR_100HZ]	= {100, 0},
+	[BMP380_ODR_50HZ]	= {50, 0},
+	[BMP380_ODR_25HZ]	= {25, 0},
+	[BMP380_ODR_12_5HZ]	= {12, 500000},
+	[BMP380_ODR_6_25HZ]	= {6, 250000},
+	[BMP380_ODR_3_125HZ]	= {3, 125000},
+	[BMP380_ODR_1_5625HZ]	= {1, 562500},
+	[BMP380_ODR_0_78HZ]	= {0, 781250},
+	[BMP380_ODR_0_39HZ]	= {0, 390625},
+	[BMP380_ODR_0_2HZ]	= {0, 195313},
+	[BMP380_ODR_0_1HZ]	= {0, 97656},
+	[BMP380_ODR_0_05HZ]	= {0, 48828},
+	[BMP380_ODR_0_02HZ]	= {0, 24414},
+	[BMP380_ODR_0_01HZ]	= {0, 12207},
+	[BMP380_ODR_0_006HZ]	= {0, 6104},
+	[BMP380_ODR_0_003HZ]	= {0, 3052},
+	[BMP380_ODR_0_0015HZ]	= {0, 1526},
+};
+
 static int bmp380_chip_config(struct bmp280_data *data)
 {
+	bool change = false, aux;
 	unsigned int tmp;
 	u8 osrs;
 	int ret;
 
 	/* configure power control register */
-	ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
-				BMP380_CTRL_SENSORS_MASK | BMP380_MODE_MASK,
-				BMP380_CTRL_SENSORS_PRESS_EN |
-				BMP380_CTRL_SENSORS_TEMP_EN |
-				FIELD_PREP(BMP380_MODE_MASK, BMP380_MODE_NORMAL));
+	ret = regmap_update_bits(data->regmap, BMP380_REG_POWER_CONTROL,
+				 BMP380_CTRL_SENSORS_MASK,
+				 BMP380_CTRL_SENSORS_PRESS_EN |
+				 BMP380_CTRL_SENSORS_TEMP_EN);
 	if (ret < 0) {
 		dev_err(data->dev,
 			"failed to write operation control register\n");
@@ -1000,55 +1214,94 @@ static int bmp380_chip_config(struct bmp280_data *data)
 	osrs = FIELD_PREP(BMP380_OSRS_TEMP_MASK, data->oversampling_temp) |
 	       FIELD_PREP(BMP380_OSRS_PRESS_MASK, data->oversampling_press);
 
-	ret = regmap_write_bits(data->regmap, BMP380_REG_OSR,
-				BMP380_OSRS_TEMP_MASK | BMP380_OSRS_PRESS_MASK,
-				osrs);
+	ret = regmap_update_bits_check(data->regmap, BMP380_REG_OSR,
+				       BMP380_OSRS_TEMP_MASK |
+				       BMP380_OSRS_PRESS_MASK,
+				       osrs, &aux);
 	if (ret < 0) {
 		dev_err(data->dev, "failed to write oversampling register\n");
 		return ret;
 	}
+	change = change || aux;
 
 	/* configure output data rate */
-	ret = regmap_write_bits(data->regmap, BMP380_REG_ODR,
-				BMP380_ODRS_MASK, BMP380_ODRS_50HZ);
+	ret = regmap_update_bits_check(data->regmap, BMP380_REG_ODR,
+				       BMP380_ODRS_MASK, data->sampling_freq,
+				       &aux);
 	if (ret < 0) {
 		dev_err(data->dev, "failed to write ODR selection register\n");
 		return ret;
 	}
+	change = change || aux;
 
 	/* set filter data */
-	ret = regmap_update_bits(data->regmap, BMP380_REG_CONFIG,
-				 BMP380_FILTER_MASK,
-				 FIELD_PREP(BMP380_FILTER_MASK, BMP380_FILTER_3X));
+	ret = regmap_update_bits_check(data->regmap, BMP380_REG_CONFIG,
+				BMP380_FILTER_MASK,
+				FIELD_PREP(BMP380_FILTER_MASK, data->iir_filter_coeff),
+				&aux);
 	if (ret < 0) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
+	change = change || aux;
 
-	/* wait startup_time before verifying config changes */
-	usleep_range(data->start_up_time, data->start_up_time + 100);
+	if (change) {
+		/*
+		 * The configurations errors are detected on the fly during a measurement
+		 * cycle. If the sampling frequency is too low, it's faster to reset
+		 * the measurement loop than wait until the next measurement is due.
+		 *
+		 * Resets sensor measurement loop toggling between sleep and normal
+		 * operating modes.
+		 */
+		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
+					BMP380_MODE_MASK,
+					FIELD_PREP(BMP380_MODE_MASK,
+						   BMP380_MODE_SLEEP));
+		if (ret < 0) {
+			dev_err(data->dev, "failed to set sleep mode\n");
+			return ret;
+		}
+		usleep_range(2000, 2500);
+		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
+					BMP380_MODE_MASK,
+					FIELD_PREP(BMP380_MODE_MASK,
+						   BMP380_MODE_NORMAL));
+		if (ret < 0) {
+			dev_err(data->dev, "failed to set normal mode\n");
+			return ret;
+		}
+		/*
+		 * Waits for measurement before checking configuration error flag.
+		 * Selected longest measure time indicated in section 3.9.1
+		 * in the datasheet.
+		 */
+		msleep(80);
 
-	/* check config error flag */
-	ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
-	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to read error register\n");
-		return ret;
-	}
-	if (tmp & BMP380_ERR_CONF_MASK) {
-		dev_warn(data->dev,
-			 "sensor flagged configuration as incompatible\n");
-		return -EINVAL;
+		/* check config error flag */
+		ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
+		if (ret < 0) {
+			dev_err(data->dev,
+				"failed to read error register\n");
+			return ret;
+		}
+		if (tmp & BMP380_ERR_CONF_MASK) {
+			dev_warn(data->dev,
+				"sensor flagged configuration as incompatible\n");
+			return -EINVAL;
+		}
 	}
 
 	return 0;
 }
 
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
+static const int bmp380_iir_filter_coeffs_avail[] = { 0, 1, 3, 7, 15, 31, 63, 127 };
 
 static const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
 	.start_up_time = 2000,
+	.channels = bmp380_channels,
 	.num_channels = 2,
 
 	.oversampling_temp_avail = bmp380_oversampling_avail,
@@ -1059,6 +1312,14 @@ static const struct bmp280_chip_info bmp380_chip_info = {
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp380_oversampling_avail),
 	.oversampling_press_default = ilog2(4),
 
+	.sampling_freq_avail = bmp380_odr_table,
+	.num_sampling_freq_avail = ARRAY_SIZE(bmp380_odr_table) * 2,
+	.sampling_freq_default = BMP380_ODR_50HZ,
+
+	.iir_filter_coeffs_avail = bmp380_iir_filter_coeffs_avail,
+	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
+	.iir_filter_coeff_default = 2,
+
 	.chip_config = bmp380_chip_config,
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
@@ -1299,6 +1560,7 @@ static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 static const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
 	.start_up_time = 2000,
+	.channels = bmp280_channels,
 	.num_channels = 2,
 
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
@@ -1397,7 +1659,6 @@ int bmp280_common_probe(struct device *dev,
 	data->dev = dev;
 
 	indio_dev->name = name;
-	indio_dev->channels = bmp280_channels;
 	indio_dev->info = &bmp280_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -1420,10 +1681,13 @@ int bmp280_common_probe(struct device *dev,
 	data->chip_info = chip_info;
 
 	/* apply initial values from chip info structure */
+	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
 	data->oversampling_press = chip_info->oversampling_press_default;
 	data->oversampling_humid = chip_info->oversampling_humid_default;
 	data->oversampling_temp = chip_info->oversampling_temp_default;
+	data->iir_filter_coeff = chip_info->iir_filter_coeff_default;
+	data->sampling_freq = chip_info->sampling_freq_default;
 	data->start_up_time = chip_info->start_up_time;
 
 	/* Bring up regulators */
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 827bc6b7ca07..15ae3c32f168 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -54,24 +54,6 @@
 #define BMP380_OSRS_PRESS_MASK		GENMASK(2, 0)
 
 #define BMP380_ODRS_MASK		GENMASK(4, 0)
-#define BMP380_ODRS_200HZ		0x00
-#define BMP380_ODRS_100HZ		0x01
-#define BMP380_ODRS_50HZ		0x02
-#define BMP380_ODRS_25HZ		0x03
-#define BMP380_ODRS_12_5HZ		0x04
-#define BMP380_ODRS_6_25HZ		0x05
-#define BMP380_ODRS_3_1HZ		0x06
-#define BMP380_ODRS_1_5HZ		0x07
-#define BMP380_ODRS_0_78HZ		0x08
-#define BMP380_ODRS_0_39HZ		0x09
-#define BMP380_ODRS_0_2HZ		0x0A
-#define BMP380_ODRS_0_1HZ		0x0B
-#define BMP380_ODRS_0_05HZ		0x0C
-#define BMP380_ODRS_0_02HZ		0x0D
-#define BMP380_ODRS_0_01HZ		0x0E
-#define BMP380_ODRS_0_006HZ		0x0F
-#define BMP380_ODRS_0_003HZ		0x10
-#define BMP380_ODRS_0_0015HZ		0x11
 
 #define BMP380_CTRL_SENSORS_MASK	GENMASK(1, 0)
 #define BMP380_CTRL_SENSORS_PRESS_EN	BIT(0)
-- 
2.37.1

