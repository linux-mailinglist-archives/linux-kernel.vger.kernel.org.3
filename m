Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443D44D66B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350633AbiCKQs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350568AbiCKQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:48:22 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC351CCB0F;
        Fri, 11 Mar 2022 08:47:18 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id q13so8096515plk.12;
        Fri, 11 Mar 2022 08:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKRz8EIs1Ehd70ae5FQue2b2m+LA5XEkz4T4ZoaSDHM=;
        b=LYAFKqqjj6mH9wOyAYFEEfxLtXL3BruoHURjVsf0OWd4ZwTzETbVOXSD98lO2dQ2JT
         nbnJRRJWqzSsoSPFo9wMOyujDUwy/ixp4yZU5D7PdrjiXnkuea9FYQokRYEzYJi1KW/U
         kaim4t+5cT2nYnTho2gRCfHYfQ/LnI+KFis8mN9TGfMsMs5WKPQgU+Hpjpfci9aPYtzG
         yuFFObPbXWYHad6rc93UcCNg081P3kpsj5xElsZbErFVYvhHhUBj6PBglCMeoj3Z5A5s
         cmkZ1HVNmmK7BGvM8zyJgGdMpjymln4NVPCVRwkC/AasN7ektGRdFx9oMYWK/ZhIqyLn
         OHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKRz8EIs1Ehd70ae5FQue2b2m+LA5XEkz4T4ZoaSDHM=;
        b=sZrju8APSCQLCDTt1zhE/YsExFRHUO0QyS3TqwF4jgVS0N3/FBPMrv21je83Af5nzg
         xuwXW2XjGUE6o+QViXw49OH6AgcE5zK6YBRAdxFQ6ikIOnpNUh1P8M5xzPnpXk2vho1A
         FXSFxlborzneIVL/sPDSYEGpB921hS8CemWPiPzpHTfbmgCtZ9ISo6djA02vSMJcDT0z
         TwmgDhuIJBNir+WYAf4pS7j5gBUeKk75R9BpkwjMUajSN8VVZ7YuV3hbkkaMiGPedwI8
         t4JuAcbDbqss+WY9HH8E2M2EsLT6eDrruHDyGLDSh7NZy7QKCkU84gbqhZhVnZOmyBjQ
         FzHA==
X-Gm-Message-State: AOAM532nyyvtsnFEdvguSsUrZaXEjeKUQ+0d9g9yws0/z01ueiX5POHo
        JniVH64dnlW9LOKs3Tr2IAw=
X-Google-Smtp-Source: ABdhPJxxrseKg3PGkYSvzgH0hRIethoAF50oLzOirm+JML2QBN4OQKYAX2N32FInc30UBuqXfOLOfQ==
X-Received: by 2002:a17:90b:38c2:b0:1bf:ad37:c320 with SMTP id nn2-20020a17090b38c200b001bfad37c320mr15424101pjb.148.1647017237918;
        Fri, 11 Mar 2022 08:47:17 -0800 (PST)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm11107869pfx.81.2022.03.11.08.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:47:17 -0800 (PST)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/7] iio: adc: sc27xx: add support for PMIC ump9620
Date:   Sat, 12 Mar 2022 00:46:27 +0800
Message-Id: <20220311164628.378849-7-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311164628.378849-1-gengcixi@gmail.com>
References: <20220311164628.378849-1-gengcixi@gmail.com>
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

From: Cixi Geng <cixi.geng1@unisoc.com>

The ump9620 is variant from sc27xx chip, add it in here.

Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>

V2 changes:
1. remove duplicated function
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

2. fix the smatch warnings
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/iio/adc/sc27xx_adc.c | 305 ++++++++++++++++++++++++++++++-----
 1 file changed, 266 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index b89637c051ac..e9b680e9c275 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -15,12 +15,16 @@
 /* PMIC global registers definition */
 #define SC2730_MODULE_EN		0x1808
 #define SC2731_MODULE_EN		0xc08
+#define UMP9620_MODULE_EN		0x2008
 #define SC27XX_MODULE_ADC_EN		BIT(5)
 #define SC2721_ARM_CLK_EN		0xc0c
 #define SC2730_ARM_CLK_EN		0x180c
 #define SC2731_ARM_CLK_EN		0xc10
+#define UMP9620_ARM_CLK_EN		0x200c
+#define UMP9620_XTL_WAIT_CTRL0		0x2378
 #define SC27XX_CLK_ADC_EN		BIT(5)
 #define SC27XX_CLK_ADC_CLK_EN		BIT(6)
+#define UMP9620_XTL_WAIT_CTRL0_EN	BIT(8)
 
 /* ADC controller registers definition */
 #define SC27XX_ADC_CTL			0x0
@@ -82,6 +86,13 @@
 enum sc27xx_pmic_type {
 	SC27XX_ADC,
 	SC2721_ADC,
+	UMP9620_ADC,
+};
+
+enum ump96xx_scale_cal {
+	UMP96XX_VBAT_SENSES_CAL,
+	UMP96XX_VBAT_DET_CAL,
+	UMP96XX_CH1_CAL,
 };
 
 struct sc27xx_adc_data {
@@ -139,6 +150,11 @@ static struct sc27xx_adc_linear_graph small_scale_graph = {
 	100, 341,
 };
 
+static struct sc27xx_adc_linear_graph ump9620_bat_det_graph = {
+	1400, 3482,
+	200, 476,
+};
+
 /* Add these for sc2731 pmic, and the [big|small]_scale_graph_calib for common's */
 static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_calib = {
 	4200, 850,
@@ -165,16 +181,41 @@ static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
 	return ((calib_data & 0xff) + calib_adc - 128) * 4;
 }
 
+/* get the adc nvmem cell calibration data */
+static int adc_nvmem_cell_calib_data(struct sc27xx_adc_data *data, const char *cell_name)
+{
+	struct nvmem_cell *cell;
+	void *buf;
+	u32 origin_calib_data = 0;
+	size_t len = 0;
+
+	if (!data)
+		return -EINVAL;
+
+	cell = nvmem_cell_get(data->dev, cell_name);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	if (IS_ERR(buf)) {
+		nvmem_cell_put(cell);
+		return PTR_ERR(buf);
+	}
+
+	memcpy(&origin_calib_data, buf, min(len, sizeof(u32)));
+
+	kfree(buf);
+	nvmem_cell_put(cell);
+	return origin_calib_data;
+}
+
 static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 					bool big_scale)
 {
 	const struct sc27xx_adc_linear_graph *calib_graph;
 	struct sc27xx_adc_linear_graph *graph;
-	struct nvmem_cell *cell;
 	const char *cell_name;
 	u32 calib_data = 0;
-	void *buf;
-	size_t len;
 
 	if (big_scale) {
 		calib_graph = data->var_data->bscale_cal;
@@ -186,24 +227,63 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 		cell_name = "small_scale_calib";
 	}
 
-	cell = nvmem_cell_get(data->dev, cell_name);
-	if (IS_ERR(cell))
-		return PTR_ERR(cell);
-
-	buf = nvmem_cell_read(cell, &len);
-	nvmem_cell_put(cell);
-
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
-
-	memcpy(&calib_data, buf, min(len, sizeof(u32)));
+	calib_data = adc_nvmem_cell_calib_data(data, cell_name);
 
 	/* Only need to calibrate the adc values in the linear graph. */
 	graph->adc0 = sc27xx_adc_get_calib_data(calib_data, calib_graph->adc0);
 	graph->adc1 = sc27xx_adc_get_calib_data(calib_data >> 8,
 						calib_graph->adc1);
 
-	kfree(buf);
+	return 0;
+}
+
+static int ump96xx_adc_scale_cal(struct sc27xx_adc_data *data,
+					enum ump96xx_scale_cal cal_type)
+{
+	struct sc27xx_adc_linear_graph *graph = NULL;
+	const char *cell_name1 = NULL, *cell_name2 = NULL;
+	int adc_calib_data1 = 0, adc_calib_data2 = 0;
+
+	if (!data)
+		return -EINVAL;
+
+	if (cal_type == UMP96XX_VBAT_DET_CAL) {
+		graph = &ump9620_bat_det_graph;
+		cell_name1 = "vbat_det_cal1";
+		cell_name2 = "vbat_det_cal2";
+	} else if (cal_type == UMP96XX_VBAT_SENSES_CAL) {
+		graph = &big_scale_graph;
+		cell_name1 = "big_scale_calib1";
+		cell_name2 = "big_scale_calib2";
+	} else if (cal_type == UMP96XX_CH1_CAL) {
+		graph = &small_scale_graph;
+		cell_name1 = "small_scale_calib1";
+		cell_name2 = "small_scale_calib2";
+	} else {
+		graph = &small_scale_graph;
+		cell_name1 = "small_scale_calib1";
+		cell_name2 = "small_scale_calib2";
+	}
+
+	adc_calib_data1 = adc_nvmem_cell_calib_data(data, cell_name1);
+	if (adc_calib_data1 < 0) {
+		dev_err(data->dev, "err! %s:%d\n", cell_name1, adc_calib_data1);
+		return adc_calib_data1;
+	}
+
+	adc_calib_data2 = adc_nvmem_cell_calib_data(data, cell_name2);
+	if (adc_calib_data2 < 0) {
+		dev_err(data->dev, "err! %s:%d\n", cell_name2, adc_calib_data2);
+		return adc_calib_data2;
+	}
+
+	/*
+	 *Read the data in the two blocks of efuse and convert them into the
+	 *calibration value in the ump9620 adc linear graph.
+	 */
+	graph->adc0 = (adc_calib_data1 & 0xfff0) >> 4;
+	graph->adc1 = (adc_calib_data2 & 0xfff0) >> 4;
+
 	return 0;
 }
 
@@ -394,6 +474,50 @@ static int sc2731_adc_get_ratio(int channel, int scale)
 	return SC27XX_VOLT_RATIO(1, 1);
 }
 
+static int ump9620_adc_get_ratio(int channel, int scale)
+{
+	switch (channel) {
+	case 11:
+		return SC27XX_VOLT_RATIO(1, 1);
+	case 14:
+		switch (scale) {
+		case 0:
+			return SC27XX_VOLT_RATIO(68, 900);
+		default:
+			return SC27XX_VOLT_RATIO(1, 1);
+		}
+	case 15:
+		switch (scale) {
+		case 0:
+			return SC27XX_VOLT_RATIO(1, 3);
+		default:
+			return SC27XX_VOLT_RATIO(1, 1);
+		}
+	case 21:
+	case 22:
+	case 23:
+		switch (scale) {
+		case 0:
+			return SC27XX_VOLT_RATIO(3, 8);
+		default:
+			return SC27XX_VOLT_RATIO(1, 1);
+		}
+	default:
+		switch (scale) {
+		case 0:
+			return SC27XX_VOLT_RATIO(1, 1);
+		case 1:
+			return SC27XX_VOLT_RATIO(1000, 1955);
+		case 2:
+			return SC27XX_VOLT_RATIO(1000, 2600);
+		case 3:
+			return SC27XX_VOLT_RATIO(1000, 4060);
+		default:
+			return SC27XX_VOLT_RATIO(1, 1);
+		}
+	}
+}
+
 /*
  * According to the datasheet set specific value on some channel.
  */
@@ -453,6 +577,22 @@ static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
 	}
 }
 
+static void ump9620_adc_scale_init(struct sc27xx_adc_data *data)
+{
+	int i;
+
+	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
+		if (i == 10 || i == 19 || i == 30 || i == 31)
+			data->channel_scale[i] = 3;
+		else if (i == 7 || i == 9)
+			data->channel_scale[i] = 2;
+		else if (i == 0 || i == 13)
+			data->channel_scale[i] = 1;
+		else
+			data->channel_scale[i] = 0;
+	}
+}
+
 static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 			   int scale, int *val)
 {
@@ -567,7 +707,7 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
 	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
 }
 
-static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
+static int adc_to_volt(struct sc27xx_adc_linear_graph *graph,
 			      int raw_adc)
 {
 	int tmp;
@@ -576,6 +716,31 @@ static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
 	tmp /= (graph->adc0 - graph->adc1);
 	tmp += graph->volt1;
 
+	return tmp;
+}
+
+static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
+			      int raw_adc)
+{
+	int tmp;
+
+	tmp = adc_to_volt(graph, raw_adc);
+
+	return tmp < 0 ? 0 : tmp;
+}
+
+static int ump96xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph, int scale,
+			      int raw_adc)
+{
+	int tmp;
+
+	tmp = adc_to_volt(graph, raw_adc);
+
+	if (scale == 2)
+		tmp = tmp * 2600 / 1000;
+	else if (scale == 3)
+		tmp = tmp * 4060 / 1000;
+
 	return tmp < 0 ? 0 : tmp;
 }
 
@@ -585,23 +750,46 @@ static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
 	u32 numerator, denominator;
 	u32 volt;
 
-	/*
-	 * Convert ADC values to voltage values according to the linear graph,
-	 * and channel 5 and channel 1 has been calibrated, so we can just
-	 * return the voltage values calculated by the linear graph. But other
-	 * channels need be calculated to the real voltage values with the
-	 * voltage ratio.
-	 */
-	switch (channel) {
-	case 5:
-		return sc27xx_adc_to_volt(&big_scale_graph, raw_adc);
+	if (data->var_data->pmic_type == UMP9620_ADC) {
+		switch (channel) {
+		case 0:
+			if (scale == 1)
+				volt = sc27xx_adc_to_volt(&ump9620_bat_det_graph, raw_adc);
+			else
+				volt = ump96xx_adc_to_volt(&small_scale_graph, scale, raw_adc);
+			break;
+		case 11:
+			volt = sc27xx_adc_to_volt(&big_scale_graph, raw_adc);
+			break;
+		default:
+			if (scale == 1)
+				volt = sc27xx_adc_to_volt(&ump9620_bat_det_graph, raw_adc);
+			else
+				volt = ump96xx_adc_to_volt(&small_scale_graph, scale, raw_adc);
+			break;
+		}
 
-	case 1:
-		return sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
+		if (channel == 0 && scale == 1)
+			return volt;
+	} else {
+		/*
+		 * Convert ADC values to voltage values according to the linear graph,
+		 * and channel 5 and channel 1 has been calibrated, so we can just
+		 * return the voltage values calculated by the linear graph. But other
+		 * channels need be calculated to the real voltage values with the
+		 * voltage ratio.
+		 */
+		switch (channel) {
+		case 5:
+			return sc27xx_adc_to_volt(&big_scale_graph, raw_adc);
 
-	default:
-		volt = sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
-		break;
+		case 1:
+			return sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
+
+		default:
+			volt = sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
+			break;
+		}
 	}
 
 	sc27xx_adc_volt_ratio(data, channel, scale, &numerator, &denominator);
@@ -619,6 +807,7 @@ static int sc27xx_adc_read_processed(struct sc27xx_adc_data *data,
 		return ret;
 
 	*val = sc27xx_adc_convert_volt(data, channel, scale, raw_adc);
+
 	return 0;
 }
 
@@ -736,21 +925,42 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 	if (ret)
 		return ret;
 
-	/* Enable ADC work clock and controller clock */
+	/* Enable 26MHz crvstal oscillator wait cycles for UMP9620 ADC */
+	if (data->var_data->pmic_type == UMP9620_ADC) {
+		ret = regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
+					 UMP9620_XTL_WAIT_CTRL0_EN,
+					 UMP9620_XTL_WAIT_CTRL0_EN);
+	}
+
+	/* Enable ADC work clock */
 	ret = regmap_update_bits(data->regmap, data->var_data->clk_en,
 				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN,
 				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
 	if (ret)
 		goto disable_adc;
 
-	/* ADC channel scales' calibration from nvmem device */
-	ret = sc27xx_adc_scale_calibration(data, true);
-	if (ret)
-		goto disable_clk;
+	/* ADC channel scales calibration from nvmem device */
+	if (data->var_data->pmic_type == UMP9620_ADC) {
+		ret = ump96xx_adc_scale_cal(data, UMP96XX_VBAT_SENSES_CAL);
+		if (ret)
+			goto disable_clk;
 
-	ret = sc27xx_adc_scale_calibration(data, false);
-	if (ret)
-		goto disable_clk;
+		ret = ump96xx_adc_scale_cal(data, UMP96XX_VBAT_DET_CAL);
+		if (ret)
+			goto disable_clk;
+
+		ret = ump96xx_adc_scale_cal(data, UMP96XX_CH1_CAL);
+		if (ret)
+			goto disable_clk;
+	} else {
+		ret = sc27xx_adc_scale_calibration(data, true);
+		if (ret)
+			goto disable_clk;
+
+		ret = sc27xx_adc_scale_calibration(data, false);
+		if (ret)
+			goto disable_clk;
+	}
 
 	return 0;
 
@@ -774,6 +984,10 @@ static void sc27xx_adc_disable(void *_data)
 
 	regmap_update_bits(data->regmap, data->var_data->module_en,
 			   SC27XX_MODULE_ADC_EN, 0);
+
+	if (data->var_data->pmic_type == UMP9620_ADC)
+		regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
+				UMP9620_XTL_WAIT_CTRL0_EN, 0);
 }
 
 static const struct sc27xx_adc_variant_data sc2731_data = {
@@ -824,6 +1038,18 @@ static const struct sc27xx_adc_variant_data sc2720_data = {
 	.get_ratio = sc2720_adc_get_ratio,
 };
 
+static const struct sc27xx_adc_variant_data ump9620_data = {
+	.pmic_type = UMP9620_ADC,
+	.module_en = UMP9620_MODULE_EN,
+	.clk_en = UMP9620_ARM_CLK_EN,
+	.scale_shift = SC27XX_ADC_SCALE_SHIFT,
+	.scale_mask = SC27XX_ADC_SCALE_MASK,
+	.bscale_cal = &big_scale_graph,
+	.sscale_cal = &small_scale_graph,
+	.init_scale = ump9620_adc_scale_init,
+	.get_ratio = ump9620_adc_get_ratio,
+};
+
 static int sc27xx_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -917,6 +1143,7 @@ static const struct of_device_id sc27xx_adc_of_match[] = {
 	{ .compatible = "sprd,sc2730-adc", .data = &sc2730_data},
 	{ .compatible = "sprd,sc2721-adc", .data = &sc2721_data},
 	{ .compatible = "sprd,sc2720-adc", .data = &sc2720_data},
+	{ .compatible = "sprd,ump9620-adc", .data = &ump9620_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
-- 
2.25.1

