Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6F458BAB5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 13:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbiHGLzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 07:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbiHGLzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 07:55:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6922BC4;
        Sun,  7 Aug 2022 04:55:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q30so7992489wra.11;
        Sun, 07 Aug 2022 04:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hW0jY56ayspvGjk1Jgwrt4zN0hTZQB9HtEjqGRzqiNE=;
        b=jmzWKC48g4fTFF0le53geX8ym+0MYugp3QfSBV1UnKFKt3vq0vuG3s/FtS2XWNLg2r
         mqsD8pj98ffn0jj655kROGqSj05pdSMN8ToI2YsdfNNVS1hdPIgYiDiyg0Mjb/g+8EPq
         +iBeOEgYdgvIcgAce5QEsuf/DO1abECWVvjvoFmINpjbaVdKRXD56DSv7XKc2WaNDfs2
         8i1prUfUaTB4gFIGRGhfY/yaSdxOtVPblw3bhQ/zlHaUGfxgNYTdHE4Kz9cihrz7h5In
         g1NJTqKt7R1iS8QMuVCHFV5AekR2FqxvNNN9gSLNrIZTqaBZuFdP2c7CxmvI0nP347AC
         KPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hW0jY56ayspvGjk1Jgwrt4zN0hTZQB9HtEjqGRzqiNE=;
        b=npZIQ06xfyyH2oG+4+tGx4e1vZKV8XuMjgkE5VhATrHsiZyKDTXXT5wv7LHwmeJeDM
         llbKI8pOD3+MTeBvwRQmVwTv9H+hmNrIi17fdycC+sgZPuV+6WwKt+AgeUSc4TosH6UJ
         2JpmgiBVSBauLQ0RomQ21A5u3pMRV+40hb9zbCo6TbSGtYV4Pt4tE871X8z/qoXSAUP7
         22AM6RyYFonpUoVUQk8umXkJHizIubej4dSsf87r48vdEAPqNo4kXK4qZyYtY7n7gMn/
         C2yFp6A4jbPfMutpeW1vkep9E0eWWOemhE+Y74D0MtGdkDPTt0DpK5mhh1o4sqTL6Sjo
         CM8w==
X-Gm-Message-State: ACgBeo1Y9h+2oEhiqr6ib8W7o07ScqRAlHbkPXiRzyb7l79mjcuAl3Sc
        EKh1TtjHUQ+JeiEAkzHiTXs+PBpEBgA=
X-Google-Smtp-Source: AA6agR7/ZpcxaS+kKR9g7N6sr+tAmUUNZtW1FJxKozKT1alawr/BintUZQR5BkzPq8dO9WCMSRgcXA==
X-Received: by 2002:a05:6000:18af:b0:222:c48d:9064 with SMTP id b15-20020a05600018af00b00222c48d9064mr2483171wri.18.1659873319195;
        Sun, 07 Aug 2022 04:55:19 -0700 (PDT)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b003a2e5f536b3sm14949116wms.24.2022.08.07.04.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 04:55:18 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] iio: pressure: bmp280: Fix alignment for DMA safety
Date:   Sun,  7 Aug 2022 13:55:15 +0200
Message-Id: <49086f5c1401d7d28ebf921a67b49f8403ddb16a.1659872590.git.ang.iglesiasg@gmail.com>
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

Adds DMA-safe buffers to driver data struct to store raw data from sensors

The multiple buffers used thorough the driver share the same memory
allocated as part of the device data instance. The union containing
the buffers is aligned to allow safe usage with DMA operations, such
as regmap bulk read calls.

Updated measurement and calibration reading functions to use the new,
DMA-safe, buffers.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 122 ++++++++++++++---------------
 drivers/iio/pressure/bmp280.h      |   3 +
 2 files changed, 64 insertions(+), 61 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index a109c2609896..4cd657dcbfed 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -31,6 +31,7 @@
 #include <linux/completion.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
+#include <asm/unaligned.h>
 
 #include "bmp280.h"
 
@@ -106,6 +107,18 @@ struct bmp280_data {
 	 * calculation.
 	 */
 	s32 t_fine;
+
+	/*
+	 * DMA (thus cache coherency maintenance) may require the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	union {
+		/* sensor data buffer */
+		u8 data[3];
+		/* calibration data buffers */
+		__le16 bmp280_cal[BMP280_CONTIGUOUS_CALIB_REGS / 2];
+		__be16 bmp180_cal[BMP180_REG_CALIB_COUNT / 2];
+	} buf __aligned(IIO_DMA_MINALIGN);
 };
 
 struct bmp280_chip_info {
@@ -162,41 +175,29 @@ static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
 {
 	int ret;
 	unsigned int tmp;
-	__le16 l16;
-	__be16 b16;
 	struct device *dev = data->dev;
+	__le16 *t_buf = data->buf.bmp280_cal;
+	__le16 *p_buf = &data->buf.bmp280_cal[T3+1];
 	struct bmp280_calib *calib = &data->calib.bmp280;
-	__le16 t_buf[BMP280_COMP_TEMP_REG_COUNT / 2];
-	__le16 p_buf[BMP280_COMP_PRESS_REG_COUNT / 2];
 
 	/* Read temperature calibration values. */
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
-			       t_buf, BMP280_COMP_TEMP_REG_COUNT);
+			       data->buf.bmp280_cal, sizeof(data->buf.bmp280_cal));
 	if (ret < 0) {
 		dev_err(data->dev,
 			"failed to read temperature calibration parameters\n");
 		return ret;
 	}
 
-	/* Toss the temperature calibration data into the entropy pool */
-	add_device_randomness(t_buf, sizeof(t_buf));
+	/* Toss the temperature and pressure calibration data into the entropy pool */
+	add_device_randomness(data->buf.bmp280_cal, sizeof(data->buf.bmp280_cal));
 
+	/* parse temperature calibration data */
 	calib->T1 = le16_to_cpu(t_buf[T1]);
 	calib->T2 = le16_to_cpu(t_buf[T2]);
 	calib->T3 = le16_to_cpu(t_buf[T3]);
 
-	/* Read pressure calibration values. */
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
-			       p_buf, BMP280_COMP_PRESS_REG_COUNT);
-	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to read pressure calibration parameters\n");
-		return ret;
-	}
-
-	/* Toss the pressure calibration data into the entropy pool */
-	add_device_randomness(p_buf, sizeof(p_buf));
-
+	/* parse pressure calibration data */
 	calib->P1 = le16_to_cpu(p_buf[P1]);
 	calib->P2 = le16_to_cpu(p_buf[P2]);
 	calib->P3 = le16_to_cpu(p_buf[P3]);
@@ -224,12 +225,12 @@ static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
 	}
 	calib->H1 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, &l16, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, data->buf.data, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H2 comp value\n");
 		return ret;
 	}
-	calib->H2 = sign_extend32(le16_to_cpu(l16), 15);
+	calib->H2 = get_unaligned_le16(data->buf.data);
 
 	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &tmp);
 	if (ret < 0) {
@@ -238,20 +239,20 @@ static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
 	}
 	calib->H3 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, &b16, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, data->buf.data, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H4 comp value\n");
 		return ret;
 	}
-	calib->H4 = sign_extend32(((be16_to_cpu(b16) >> 4) & 0xff0) |
-				  (be16_to_cpu(b16) & 0xf), 11);
+	calib->H4 = sign_extend32(((get_unaligned_be16(data->buf.data) >> 4) & 0xff0) |
+				  (get_unaligned_be16(data->buf.data) & 0xf), 11);
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, &l16, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, data->buf.data, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H5 comp value\n");
 		return ret;
 	}
-	calib->H5 = sign_extend32(((le16_to_cpu(l16) >> 4) & 0xfff), 11);
+	calib->H5 = sign_extend32(((get_unaligned_le16(data->buf.data) >> 4) & 0xfff), 11);
 
 	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
 	if (ret < 0) {
@@ -346,16 +347,16 @@ static int bmp280_read_temp(struct bmp280_data *data,
 			    int *val)
 {
 	int ret;
-	__be32 tmp = 0;
 	s32 adc_temp, comp_temp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB, &tmp, 3);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
+			       data->buf.data, sizeof(data->buf.data));
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
 	}
 
-	adc_temp = be32_to_cpu(tmp) >> 12;
+	adc_temp = get_unaligned_be24(data->buf.data) >> 4;
 	if (adc_temp == BMP280_TEMP_SKIPPED) {
 		/* reading was skipped */
 		dev_err(data->dev, "reading temperature skipped\n");
@@ -379,7 +380,6 @@ static int bmp280_read_press(struct bmp280_data *data,
 			     int *val, int *val2)
 {
 	int ret;
-	__be32 tmp = 0;
 	s32 adc_press;
 	u32 comp_press;
 
@@ -388,13 +388,14 @@ static int bmp280_read_press(struct bmp280_data *data,
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB, &tmp, 3);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
+			       data->buf.data, sizeof(data->buf.data));
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
 	}
 
-	adc_press = be32_to_cpu(tmp) >> 12;
+	adc_press = get_unaligned_be24(data->buf.data) >> 4;
 	if (adc_press == BMP280_PRESS_SKIPPED) {
 		/* reading was skipped */
 		dev_err(data->dev, "reading pressure skipped\n");
@@ -410,7 +411,6 @@ static int bmp280_read_press(struct bmp280_data *data,
 
 static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 {
-	__be16 tmp;
 	int ret;
 	s32 adc_humidity;
 	u32 comp_humidity;
@@ -420,13 +420,14 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB, &tmp, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
+			       data->buf.data, 2);
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read humidity\n");
 		return ret;
 	}
 
-	adc_humidity = be16_to_cpu(tmp);
+	adc_humidity = get_unaligned_be16(data->buf.data);
 	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
 		/* reading was skipped */
 		dev_err(data->dev, "reading humidity skipped\n");
@@ -767,7 +768,6 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 
 static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 {
-	__be16 tmp;
 	int ret;
 
 	ret = bmp180_measure(data,
@@ -776,48 +776,48 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, &tmp, 2);
+	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, data->buf.data, 2);
 	if (ret)
 		return ret;
 
-	*val = be16_to_cpu(tmp);
+	*val = get_unaligned_be16(data->buf.data);
 
 	return 0;
 }
 
 static int bmp180_read_calib(struct bmp280_data *data, unsigned int chip)
 {
+	struct bmp180_calib *calib = &data->calib.bmp180;
 	int ret;
 	int i;
-	struct bmp180_calib *calib = &data->calib.bmp180;
-	__be16 buf[BMP180_REG_CALIB_COUNT / 2];
 
-	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START, buf,
-			       sizeof(buf));
+	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START,
+			       data->buf.bmp180_cal, sizeof(data->buf.bmp180_cal));
 
 	if (ret < 0)
 		return ret;
 
 	/* None of the words has the value 0 or 0xFFFF */
-	for (i = 0; i < ARRAY_SIZE(buf); i++) {
-		if (buf[i] == cpu_to_be16(0) || buf[i] == cpu_to_be16(0xffff))
+	for (i = 0; i < ARRAY_SIZE(data->buf.bmp180_cal); i++) {
+		if (data->buf.bmp180_cal[i] == cpu_to_be16(0) ||
+		    data->buf.bmp180_cal[i] == cpu_to_be16(0xffff))
 			return -EIO;
 	}
 
 	/* Toss the calibration data into the entropy pool */
-	add_device_randomness(buf, sizeof(buf));
-
-	calib->AC1 = be16_to_cpu(buf[AC1]);
-	calib->AC2 = be16_to_cpu(buf[AC2]);
-	calib->AC3 = be16_to_cpu(buf[AC3]);
-	calib->AC4 = be16_to_cpu(buf[AC4]);
-	calib->AC5 = be16_to_cpu(buf[AC5]);
-	calib->AC6 = be16_to_cpu(buf[AC6]);
-	calib->B1 = be16_to_cpu(buf[B1]);
-	calib->B2 = be16_to_cpu(buf[B2]);
-	calib->MB = be16_to_cpu(buf[MB]);
-	calib->MC = be16_to_cpu(buf[MC]);
-	calib->MD = be16_to_cpu(buf[MD]);
+	add_device_randomness(data->buf.bmp180_cal, sizeof(data->buf.bmp180_cal));
+
+	calib->AC1 = be16_to_cpu(data->buf.bmp180_cal[AC1]);
+	calib->AC2 = be16_to_cpu(data->buf.bmp180_cal[AC2]);
+	calib->AC3 = be16_to_cpu(data->buf.bmp180_cal[AC3]);
+	calib->AC4 = be16_to_cpu(data->buf.bmp180_cal[AC4]);
+	calib->AC5 = be16_to_cpu(data->buf.bmp180_cal[AC5]);
+	calib->AC6 = be16_to_cpu(data->buf.bmp180_cal[AC6]);
+	calib->B1 = be16_to_cpu(data->buf.bmp180_cal[B1]);
+	calib->B2 = be16_to_cpu(data->buf.bmp180_cal[B2]);
+	calib->MB = be16_to_cpu(data->buf.bmp180_cal[MB]);
+	calib->MC = be16_to_cpu(data->buf.bmp180_cal[MC]);
+	calib->MD = be16_to_cpu(data->buf.bmp180_cal[MD]);
 
 	return 0;
 }
@@ -865,9 +865,8 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val)
 
 static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 {
-	int ret;
-	__be32 tmp = 0;
 	u8 oss = data->oversampling_press;
+	int ret;
 
 	ret = bmp180_measure(data,
 			     FIELD_PREP(BMP180_MEAS_CTRL_MASK, BMP180_MEAS_PRESS) |
@@ -876,11 +875,12 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, &tmp, 3);
+	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
+			       data->buf.data, sizeof(data->buf.data));
 	if (ret)
 		return ret;
 
-	*val = (be32_to_cpu(tmp) >> 8) >> (8 - oss);
+	*val = get_unaligned_be24(data->buf.data) >> (8 - oss);
 
 	return 0;
 }
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 5a19c7d04804..c036c7835004 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -32,6 +32,9 @@
 #define BMP280_REG_COMP_PRESS_START	0x8E
 #define BMP280_COMP_PRESS_REG_COUNT	18
 
+#define BMP280_CONTIGUOUS_CALIB_REGS	(BMP280_COMP_TEMP_REG_COUNT \
+					 + BMP280_COMP_PRESS_REG_COUNT)
+
 #define BMP280_FILTER_MASK		GENMASK(4, 2)
 #define BMP280_FILTER_OFF		0
 #define BMP280_FILTER_2X		1
-- 
2.37.1

