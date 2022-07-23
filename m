Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2F557F0B1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 19:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiGWRjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 13:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiGWRjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 13:39:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075381CB09;
        Sat, 23 Jul 2022 10:39:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q18so7338wrx.8;
        Sat, 23 Jul 2022 10:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zzKvabAQ9jjSWAsm1T30XNhl11T/+dn1uQJeygF+aPc=;
        b=E+LLely54PMiThLHEU9/UC6Tl6VE5OO2ByLQmuNc10fuyZvJ1GXcERwovm7lKfWr9r
         bkEif9s5OtFDX2Pl37LsI8Qvqwt+2V3krhJOfPLgzbTmiwXF5lp73JzgdQc1XxO9nyEo
         FEl5bBsaI4/zHxVY+nE7NJJEzqTr2lDY60fB2WRAkM2khg9PiXD7sjy7kCDHfk6DGAl0
         n2Rx3ekurvdpyQrorSQy6/N65SAB2XAGrFO8h2jYy55QXJdQ2Mo1Nn8OoYLR+QNT3Jm7
         B79QuhGAs0V4Tvlh2Hhi94vvhQlmQMwAz76HlP8Y6JM5gonL1X3eX7/AHSzxFEiHLKeW
         LgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzKvabAQ9jjSWAsm1T30XNhl11T/+dn1uQJeygF+aPc=;
        b=eD7wQSRz68qR/ZNjSkwlrH3yHy2WDHWhY0e4cuUUlBLCzr7NRh7XeItzcrmOvoDZDI
         gIuC8pzV4PiRMFvOSAuG7s9RIr1TDGxNLJjIKvqusuJM9ptfJnpOYXdEh1elbEYd5I95
         q7iJt3OHJ36ilSBTguIY9iloNI1td77TjKhWLXRE2MfWj2XmjQIg2eBpuE02ZsUcBOkv
         VIcGrasBh3eL9rG8T0soIxplgTQ+0/A5SlvWGt+P7aKabsX7cj+7gG6L+LxSZM4loxFj
         WI/jixGfgTbnbmpC3KLHlG0joJR/ucote7kjAefWE02YX/YQWPIUovaSDCH/gHZXWNlc
         SWHQ==
X-Gm-Message-State: AJIora/TFIdjsGeUCiEL823gRlj4uf7xM5tb9VFjTPWNG4RnXOBIiORz
        kaYML5thtpMW/DIldDCJcEkEvyOpp7APdA==
X-Google-Smtp-Source: AGRyM1v/O5skSZgpCgwOvvaUUpTiShMlcy3F7aOJQmng5OmekLyOytb3QhQNN0k+w+uAJ1kczuijXg==
X-Received: by 2002:adf:f04e:0:b0:21e:48df:a13d with SMTP id t14-20020adff04e000000b0021e48dfa13dmr3293101wro.278.1658597959129;
        Sat, 23 Jul 2022 10:39:19 -0700 (PDT)
Received: from xps-work.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id r67-20020a1c2b46000000b003a308e9a192sm12636030wmr.30.2022.07.23.10.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 10:39:18 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] iio: pressure: bmp280: Fix alignment for DMA safety
Date:   Sat, 23 Jul 2022 19:39:10 +0200
Message-Id: <e6f4055d1c2a535e645ce6c25091dd5b40cd5a2f.1658597501.git.ang.iglesiasg@gmail.com>
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

Adds a DMA-safe buffer to driver data struct to store raw data from sensor

Updated calibration read functions to use DMA-safe buffers as well.
In this case, as calibration data is only read at sensor initialization,
the buffers are allocated with kmalloc and freed after being processed.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 164 ++++++++++++++++++-----------
 1 file changed, 103 insertions(+), 61 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 60fba199c7a0..9311eeec8473 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/pm_runtime.h>
 #include <linux/random.h>
+#include <asm/unaligned.h>
 
 #include "bmp280.h"
 
@@ -36,7 +37,19 @@
  * These enums are used for indexing into the array of calibration
  * coefficients for BMP180.
  */
-enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
+enum {
+	AC1 = 0,
+	AC2 = 2,
+	AC3 = 4,
+	AC4 = 6,
+	AC5 = 8,
+	AC6 = 10,
+	B1 = 12,
+	B2 = 14,
+	MB = 16,
+	MC = 18,
+	MD = 20,
+};
 
 struct bmp180_calib {
 	s16 AC1;
@@ -104,6 +117,12 @@ struct bmp280_data {
 	 * calculation.
 	 */
 	s32 t_fine;
+
+	/*
+	 * DMA (thus cache coherency maintenance) may require the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	u8 buf[3] __aligned(IIO_DMA_MINALIGN);
 };
 
 struct bmp280_chip_info {
@@ -135,8 +154,18 @@ struct bmp280_chip_info {
  * These enums are used for indexing into the array of compensation
  * parameters for BMP280.
  */
-enum { T1, T2, T3 };
-enum { P1, P2, P3, P4, P5, P6, P7, P8, P9 };
+enum { T1 = 0, T2 = 2, T3 = 4 };
+enum {
+	P1 = 0,
+	P2 = 2,
+	P3 = 4,
+	P4 = 6,
+	P5 = 8,
+	P6 = 10,
+	P7 = 12,
+	P8 = 14,
+	P9 = 16,
+};
 
 static const struct iio_chan_spec bmp280_channels[] = {
 	{
@@ -159,51 +188,59 @@ static const struct iio_chan_spec bmp280_channels[] = {
 static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
 {
 	int ret;
+	u8 *t_buf;
+	u8 *p_buf;
 	unsigned int tmp;
-	__le16 l16;
-	__be16 b16;
 	struct device *dev = data->dev;
 	struct bmp280_calib *calib = &data->calib.bmp280;
-	__le16 t_buf[BMP280_COMP_TEMP_REG_COUNT / 2];
-	__le16 p_buf[BMP280_COMP_PRESS_REG_COUNT / 2];
 
+	t_buf = kmalloc(BMP280_COMP_TEMP_REG_COUNT, GFP_KERNEL);
+	if (!t_buf)
+		return -ENOMEM;
 	/* Read temperature calibration values. */
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
 			       t_buf, BMP280_COMP_TEMP_REG_COUNT);
 	if (ret < 0) {
 		dev_err(data->dev,
 			"failed to read temperature calibration parameters\n");
+		kfree(t_buf);
 		return ret;
 	}
 
 	/* Toss the temperature calibration data into the entropy pool */
 	add_device_randomness(t_buf, sizeof(t_buf));
 
-	calib->T1 = le16_to_cpu(t_buf[T1]);
-	calib->T2 = le16_to_cpu(t_buf[T2]);
-	calib->T3 = le16_to_cpu(t_buf[T3]);
+	calib->T1 = get_unaligned_le16(&t_buf[T1]);
+	calib->T2 = get_unaligned_le16(&t_buf[T2]);
+	calib->T3 = get_unaligned_le16(&t_buf[T3]);
+	kfree(t_buf);
 
+	p_buf = kmalloc(BMP280_COMP_PRESS_REG_COUNT, GFP_KERNEL);
+	if (!p_buf)
+		return -ENOMEM;
 	/* Read pressure calibration values. */
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
 			       p_buf, BMP280_COMP_PRESS_REG_COUNT);
 	if (ret < 0) {
 		dev_err(data->dev,
 			"failed to read pressure calibration parameters\n");
+		kfree(p_buf);
 		return ret;
 	}
 
 	/* Toss the pressure calibration data into the entropy pool */
 	add_device_randomness(p_buf, sizeof(p_buf));
 
-	calib->P1 = le16_to_cpu(p_buf[P1]);
-	calib->P2 = le16_to_cpu(p_buf[P2]);
-	calib->P3 = le16_to_cpu(p_buf[P3]);
-	calib->P4 = le16_to_cpu(p_buf[P4]);
-	calib->P5 = le16_to_cpu(p_buf[P5]);
-	calib->P6 = le16_to_cpu(p_buf[P6]);
-	calib->P7 = le16_to_cpu(p_buf[P7]);
-	calib->P8 = le16_to_cpu(p_buf[P8]);
-	calib->P9 = le16_to_cpu(p_buf[P9]);
+	calib->P1 = get_unaligned_le16(&p_buf[P1]);
+	calib->P2 = get_unaligned_le16(&p_buf[P2]);
+	calib->P3 = get_unaligned_le16(&p_buf[P3]);
+	calib->P4 = get_unaligned_le16(&p_buf[P4]);
+	calib->P5 = get_unaligned_le16(&p_buf[P5]);
+	calib->P6 = get_unaligned_le16(&p_buf[P6]);
+	calib->P7 = get_unaligned_le16(&p_buf[P7]);
+	calib->P8 = get_unaligned_le16(&p_buf[P8]);
+	calib->P9 = get_unaligned_le16(&p_buf[P9]);
+	kfree(p_buf);
 
 	/*
 	 * Read humidity calibration values.
@@ -222,12 +259,12 @@ static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
 	}
 	calib->H1 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, &l16, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2, data->buf, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H2 comp value\n");
 		return ret;
 	}
-	calib->H2 = sign_extend32(le16_to_cpu(l16), 15);
+	calib->H2 = get_unaligned_le16(data->buf);
 
 	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &tmp);
 	if (ret < 0) {
@@ -236,20 +273,20 @@ static int bmp280_read_calib(struct bmp280_data *data, unsigned int chip)
 	}
 	calib->H3 = tmp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, &b16, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4, data->buf, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H4 comp value\n");
 		return ret;
 	}
-	calib->H4 = sign_extend32(((be16_to_cpu(b16) >> 4) & 0xff0) |
-				  (be16_to_cpu(b16) & 0xf), 11);
+	calib->H4 = sign_extend32(((get_unaligned_be16(data->buf) >> 4) & 0xff0) |
+				  (get_unaligned_be16(data->buf) & 0xf), 11);
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, &l16, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5, data->buf, 2);
 	if (ret < 0) {
 		dev_err(dev, "failed to read H5 comp value\n");
 		return ret;
 	}
-	calib->H5 = sign_extend32(((le16_to_cpu(l16) >> 4) & 0xfff), 11);
+	calib->H5 = sign_extend32(((get_unaligned_le16(data->buf) >> 4) & 0xfff), 11);
 
 	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
 	if (ret < 0) {
@@ -344,16 +381,15 @@ static int bmp280_read_temp(struct bmp280_data *data,
 			    int *val)
 {
 	int ret;
-	__be32 tmp = 0;
 	s32 adc_temp, comp_temp;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB, &tmp, 3);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB, data->buf, 3);
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
 	}
 
-	adc_temp = be32_to_cpu(tmp) >> 12;
+	adc_temp = get_unaligned_be24(data->buf) >> 4;
 	if (adc_temp == BMP280_TEMP_SKIPPED) {
 		/* reading was skipped */
 		dev_err(data->dev, "reading temperature skipped\n");
@@ -377,7 +413,6 @@ static int bmp280_read_press(struct bmp280_data *data,
 			     int *val, int *val2)
 {
 	int ret;
-	__be32 tmp = 0;
 	s32 adc_press;
 	u32 comp_press;
 
@@ -386,13 +421,13 @@ static int bmp280_read_press(struct bmp280_data *data,
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB, &tmp, 3);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB, data->buf, 3);
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
 	}
 
-	adc_press = be32_to_cpu(tmp) >> 12;
+	adc_press = get_unaligned_be24(data->buf) >> 4;
 	if (adc_press == BMP280_PRESS_SKIPPED) {
 		/* reading was skipped */
 		dev_err(data->dev, "reading pressure skipped\n");
@@ -408,7 +443,6 @@ static int bmp280_read_press(struct bmp280_data *data,
 
 static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 {
-	__be16 tmp;
 	int ret;
 	s32 adc_humidity;
 	u32 comp_humidity;
@@ -418,13 +452,13 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB, &tmp, 2);
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB, data->buf, 2);
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read humidity\n");
 		return ret;
 	}
 
-	adc_humidity = be16_to_cpu(tmp);
+	adc_humidity = get_unaligned_be16(data->buf);
 	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
 		/* reading was skipped */
 		dev_err(data->dev, "reading humidity skipped\n");
@@ -755,56 +789,65 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 
 static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 {
-	__be16 tmp;
 	int ret;
 
 	ret = bmp180_measure(data, BMP180_MEAS_TEMP);
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, &tmp, 2);
+	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, data->buf, 2);
 	if (ret)
 		return ret;
 
-	*val = be16_to_cpu(tmp);
+	*val = get_unaligned_be16(data->buf);
 
 	return 0;
 }
 
 static int bmp180_read_calib(struct bmp280_data *data, unsigned int chip)
 {
+	struct bmp180_calib *calib = &data->calib.bmp180;
+	u8 *buf;
 	int ret;
 	int i;
-	struct bmp180_calib *calib = &data->calib.bmp180;
-	__be16 buf[BMP180_REG_CALIB_COUNT / 2];
+
+	buf = kmalloc(BMP180_REG_CALIB_COUNT, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START, buf,
-			       sizeof(buf));
+			       BMP180_REG_CALIB_COUNT);
 
-	if (ret < 0)
+	if (ret < 0) {
+		kfree(buf);
 		return ret;
+	}
 
 	/* None of the words has the value 0 or 0xFFFF */
-	for (i = 0; i < ARRAY_SIZE(buf); i++) {
-		if (buf[i] == cpu_to_be16(0) || buf[i] == cpu_to_be16(0xffff))
+	for (i = 0; i < BMP180_REG_CALIB_COUNT; i += 2) {
+		if (get_unaligned_be16(&buf[i]) == cpu_to_be16(0) ||
+		    get_unaligned_be16(&buf[i]) == cpu_to_be16(0xffff)) {
+			kfree(buf);
 			return -EIO;
+		}
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
-
+	add_device_randomness(buf, BMP180_REG_CALIB_COUNT);
+
+	calib->AC1 = get_unaligned_be16(&buf[AC1]);
+	calib->AC2 = get_unaligned_be16(&buf[AC2]);
+	calib->AC3 = get_unaligned_be16(&buf[AC3]);
+	calib->AC4 = get_unaligned_be16(&buf[AC4]);
+	calib->AC5 = get_unaligned_be16(&buf[AC5]);
+	calib->AC6 = get_unaligned_be16(&buf[AC6]);
+	calib->B1 = get_unaligned_be16(&buf[B1]);
+	calib->B2 = get_unaligned_be16(&buf[B2]);
+	calib->MB = get_unaligned_be16(&buf[MB]);
+	calib->MC = get_unaligned_be16(&buf[MC]);
+	calib->MD = get_unaligned_be16(&buf[MD]);
+
+	kfree(buf);
 	return 0;
 }
 
@@ -852,18 +895,17 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val)
 static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 {
 	int ret;
-	__be32 tmp = 0;
 	u8 oss = data->oversampling_press;
 
 	ret = bmp180_measure(data, BMP180_MEAS_PRESS_X(oss));
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, &tmp, 3);
+	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB, data->buf, 3);
 	if (ret)
 		return ret;
 
-	*val = (be32_to_cpu(tmp) >> 8) >> (8 - oss);
+	*val = get_unaligned_be24(data->buf) >> (8 - oss);
 
 	return 0;
 }
-- 
2.37.1

