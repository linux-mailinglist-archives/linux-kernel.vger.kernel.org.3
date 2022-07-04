Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C25B564AED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiGDAds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiGDAdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:33:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0C16146;
        Sun,  3 Jul 2022 17:33:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b26so11198185wrc.2;
        Sun, 03 Jul 2022 17:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4iMzV5q1Bszb1Le7bggIfrAtHC4PWgCOOkJ4nY/9is=;
        b=hJOCbFbu6z/DhqDssnsA9Si0sFSGNdYGwgPjwgfOEFWjGPyooLZal48rBz0VHi1cOi
         NI9CkSjs4qId8cZNo77X38xx8hCOajU674SJFScO/C6btn6UkM6zTBx4utDgGoqNkb/A
         znFO/SiWV9QM0n3CZvWLXPdTUkWk3aaoIGfpcJWWAytj+iicoY5eiPZTI14a6MyvWjg9
         TgV4CMWWVB43NJ1XRdupLMEVHLkizXOKnuEEIVDMasyfVhmZ6XTqx/Ytg7S0bXsGWh44
         LtOGVqk4ejkMhFjwOG0BM+iwcYmnM6gqWvwRqCeQivIAL4dhK2zUmmcjYOBV4vj5ASQf
         D8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4iMzV5q1Bszb1Le7bggIfrAtHC4PWgCOOkJ4nY/9is=;
        b=wLAjznr2b+/dnGOiZBgpYyb+jVMYgRvZaDtpgBd4WQ4DF5dy6V900jEof2Wppu2L8U
         SXF9MLabNuQRsuk9hW5JagSwJRadbDw+E2vbIL0/cfG73/2zCIw7I7tf6Q4DyLIcTKuf
         FYJ6oeVpaEjFkdCsRmJlJvR4aFjxlPu1F4u1JlrfSMf21oEAO3d+O+cmG3+y5fWocyyY
         AiPaUFJMZriNeXwbud7jQLHxfYkZl7/WuwwC7RgF0nCN/juQs6nfxBl9t8TJ76dQzl+E
         WnFHuw887jScA7wKPuib3fKI5IVH3YcEV5ZbfqKKk/WyE796oK6V765zJ1HqVzNg+ti5
         PiaQ==
X-Gm-Message-State: AJIora/alP3VvYE6K7PJHsCSZ3Sr+kpMAOE/ZIyVg50zI/h2mc142CAa
        TnbUIQTsYWut5dRfYXp39Qc=
X-Google-Smtp-Source: AGRyM1srSO9Ejd3m5KbU4bXgQH8gWnlUsoJFn6ESCG7tpeZfk3l1GrgzwXnW7qzzMypHDXU9+mqdjQ==
X-Received: by 2002:adf:f48e:0:b0:21d:6562:4717 with SMTP id l14-20020adff48e000000b0021d65624717mr5508345wro.428.1656894823807;
        Sun, 03 Jul 2022 17:33:43 -0700 (PDT)
Received: from xps-work.lan (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm28078126wrr.101.2022.07.03.17.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 17:33:43 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] iio: pressure: bmp280: Adds more tunable config parameters for BMP380
Date:   Mon,  4 Jul 2022 02:33:33 +0200
Message-Id: <20220704003337.208696-1-ang.iglesiasg@gmail.com>
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

Allows to configure the IIR filter coefficient and the sampling frequency
The IIR filter coefficient is exposed using the sysfs attribute
"filter_low_pass_3db_frequency"

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 338 ++++++++++++++++++++++++++---
 drivers/iio/pressure/bmp280.h      |  18 --
 2 files changed, 308 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 0d2395a28df8..fb321419bff8 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -99,6 +99,27 @@ static const char *const bmp280_supply_names[] = {
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
+	BMP380_ODR_0_0015HZ
+};
+
 #define BMP280_NUM_SUPPLIES ARRAY_SIZE(bmp280_supply_names)
 
 struct bmp280_data {
@@ -120,6 +141,16 @@ struct bmp280_data {
 	u8 oversampling_press;
 	u8 oversampling_temp;
 	u8 oversampling_humid;
+	u8 iir_filter_coeff;
+
+	/* BMP380 devices introduce sampling frequecy configuration. See
+	 * datasheet sections 3.3.3. and 4.3.19.
+	 *
+	 * BMx280 devices allowed indirect configuration of sampling frequency
+	 * changing the t_standby duration between measurements. See datasheet
+	 * section 3.6.3
+	 */
+	int sampling_freq;
 
 	/*
 	 * Carryover value from temperature conversion, used in pressure
@@ -131,6 +162,7 @@ struct bmp280_data {
 struct bmp280_chip_info {
 	unsigned int id_reg;
 
+	const struct iio_chan_spec *channels;
 	int num_channels;
 	unsigned int start_up_time;
 
@@ -146,6 +178,14 @@ struct bmp280_chip_info {
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
@@ -197,6 +237,30 @@ static const struct iio_chan_spec bmp280_channels[] = {
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
@@ -524,6 +588,25 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
 			break;
 		}
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (unlikely(!data->chip_info->sampling_freq_avail)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		*val = data->chip_info->sampling_freq_avail[data->sampling_freq][0];
+		*val2 = data->chip_info->sampling_freq_avail[data->sampling_freq][1];
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		if (unlikely(!data->chip_info->iir_filter_coeffs_avail)) {
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
@@ -540,14 +623,27 @@ static int bmp280_write_oversampling_ratio_humid(struct bmp280_data *data,
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
+				/*
+				 * Error applying new configuration. Might be
+				 * an invalid configuration, will try to
+				 * restore previous value just to be sure
+				 */
+				data->oversampling_humid = prev;
+				data->chip_info->chip_config(data);
+				return ret;
+			}
+			return 0;
 		}
 	}
 	return -EINVAL;
@@ -557,14 +653,27 @@ static int bmp280_write_oversampling_ratio_temp(struct bmp280_data *data,
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
+				/*
+				 * Error applying new configuration. Might be
+				 * an invalid configuration, will try to
+				 * restore previous value just to be sure
+				 */
+				data->oversampling_temp = prev;
+				data->chip_info->chip_config(data);
+				return ret;
+			}
+			return 0;
 		}
 	}
 	return -EINVAL;
@@ -574,14 +683,87 @@ static int bmp280_write_oversampling_ratio_press(struct bmp280_data *data,
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
+				/*
+				 * Error applying new configuration. Might be
+				 * an invalid configuration, will try to
+				 * restore previous value just to be sure
+				 */
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
+				/*
+				 * Error applying new configuration. Might be
+				 * an invalid configuration, will try to
+				 * restore previous value just to be sure
+				 */
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
+				/*
+				 * Error applying new configuration. Might be
+				 * an invalid configuration, will try to
+				 * restore previous value just to be sure
+				 */
+				data->iir_filter_coeff = prev;
+				data->chip_info->chip_config(data);
+				return ret;
+
+			}
+			return 0;
 		}
 	}
 	return -EINVAL;
@@ -616,6 +798,22 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
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
@@ -646,6 +844,17 @@ static int bmp280_read_avail(struct iio_dev *indio_dev,
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
@@ -691,6 +900,7 @@ static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
 	.start_up_time = 2000,
+	.channels = bmp280_channels,
 	.num_channels = 2,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
@@ -728,6 +938,7 @@ static int bme280_chip_config(struct bmp280_data *data)
 static const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
 	.start_up_time = 2000,
+	.channels = bmp280_channels,
 	.num_channels = 3,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
@@ -965,18 +1176,39 @@ static int bmp380_read_calib(struct bmp280_data *data, unsigned int chip)
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
 	u8 osrs;
 	unsigned int tmp;
 	int ret;
+	bool change, aux;
 
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
@@ -987,55 +1219,90 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
+		/* cycle sensor state machine to reset any measurement in progress
+		 * configuration errors are detected in a measurment cycle.
+		 * If the sampling frequency is too low, it is faster to reset
+		 * measurement cycle and restart measurements
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
+		/* wait before checking the configuration error flag.
+		 * Worst case value for measure time indicated in the datashhet
+		 * in section 3.9.1 is used.
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
@@ -1046,6 +1313,14 @@ static const struct bmp280_chip_info bmp380_chip_info = {
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
@@ -1282,6 +1557,7 @@ static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 static const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
 	.start_up_time = 2000,
+	.channels = bmp280_channels,
 	.num_channels = 2,
 
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
@@ -1380,7 +1656,6 @@ int bmp280_common_probe(struct device *dev,
 	data->dev = dev;
 
 	indio_dev->name = name;
-	indio_dev->channels = bmp280_channels;
 	indio_dev->info = &bmp280_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -1403,10 +1678,13 @@ int bmp280_common_probe(struct device *dev,
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
index fd38906c889c..1314d5059c53 100644
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
2.36.1

