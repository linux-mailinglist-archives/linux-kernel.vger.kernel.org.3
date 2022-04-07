Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AAC4F7987
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242951AbiDGIYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242935AbiDGIYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:24:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1F35E15A;
        Thu,  7 Apr 2022 01:22:34 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s137so1640013pgs.5;
        Thu, 07 Apr 2022 01:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qy2gWbI/QU+SKFGCC8Gd1Uxzp8eTOT0zWKMftSr0X8A=;
        b=MYJs/Aw/fQOuhPKHBVtflXUw/Nr5D0zEdImf0xvd9fCd63Ud25MjchHtRnguB4SXsv
         Ebr0lhd4+v371d09CoUZX5jBma9jmL7ABxllJnauvar23HkCihfSplwB2Rsfc+geDEf+
         UDm9sJ3kdWaD2wqai8gCtGUgd7VEYj4DeO0f1WJ8/PZVTt4XupUwBWdhhJMuxz9NgfYv
         Df05D37fmqGzm+vPdKfDqcuSRUHYpv9DCkftajJjVwxd7nDw+qwfODjzS8Wor9oivrWP
         5ScQtIEKFUyIezGFPFF/rClg0y+buA00mLUlBcmxsR65KcY1U6f0qd15zoL7nDGz2n2q
         Veeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qy2gWbI/QU+SKFGCC8Gd1Uxzp8eTOT0zWKMftSr0X8A=;
        b=rDKsf0Ht2yDy9RitOtz4M5KI/LWyRFx4WWf8faaK0RD10AqD/D0GdI1klE471qoP5t
         g2O9WOQjW7DupLgUzOn3j2l0Xy0L0v5CdMUuMLqZfd9s835og294C2RXLrvjsEVKYJeM
         /mmMSHiB3gYNK8YzXipEk00db8NnVs6GxvOItAljm4jK2CXb/cR4NKOW5r5Do0eqGSX1
         UdgSn3BaWtBT6yOYlo/z1mdY6Fj8BIJyEHAEpGoglWrr/AwXnBmf7mLRY0FQf7OKOHZz
         9NNYMoCPuE7Y7mbCLSOwEHkcZgGXWSTBjv08XUmEWPVHnzDJ3trDDp3uCkFqz13/2S5u
         bMUQ==
X-Gm-Message-State: AOAM5318Cv33y6K5+DJMkUEmxyq4h5R3J1rF3VyghuGUh7JcYbPGqfM5
        9DcOsrjJF0X1HZfj6Cb3nBI=
X-Google-Smtp-Source: ABdhPJz4ti2eVRDUPZAcO9ocabNCMxPuynCrAdOWU2o6kTVYZc/3zgZx+e0MN7PPgpJIoULbei+XyA==
X-Received: by 2002:a63:121d:0:b0:39c:c252:135a with SMTP id h29-20020a63121d000000b0039cc252135amr2714112pgl.289.1649319754343;
        Thu, 07 Apr 2022 01:22:34 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm22248098pfx.34.2022.04.07.01.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:22:33 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 7/7] iio: adc: sc27xx: add support for PMIC ump9620
Date:   Thu,  7 Apr 2022 16:21:48 +0800
Message-Id: <20220407082148.571442-8-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407082148.571442-1-gengcixi@gmail.com>
References: <20220407082148.571442-1-gengcixi@gmail.com>
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

Co-developed-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 249 +++++++++++++++++++++++++++++++----
 1 file changed, 226 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 43655a818d09..fe4a45f61ac8 100644
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
@@ -221,6 +237,56 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 	return 0;
 }
 
+static int ump96xx_adc_scale_cal(struct sc27xx_adc_data *data,
+				enum ump96xx_scale_cal cal_type)
+{
+	struct sc27xx_adc_linear_graph *graph;
+	const char *cell_name1, *cell_name2;
+	int adc_calib_data1, adc_calib_data2;
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
+	return 0;
+}
+
 static int sc2720_adc_get_ratio(int channel, int scale)
 {
 	switch (channel) {
@@ -408,6 +474,50 @@ static int sc2731_adc_get_ratio(int channel, int scale)
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
@@ -469,6 +579,22 @@ static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
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
@@ -603,29 +729,67 @@ static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
 	return tmp < 0 ? 0 : tmp;
 }
 
+static int ump96xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph, int scale,
+		int raw_adc)
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
+	return tmp < 0 ? 0 : tmp;
+}
+
+
 static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
 				   int scale, int raw_adc)
 {
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
 
-	case 1:
-		return sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
+		case 1:
+			return sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
 
-	default:
-		volt = sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
-		break;
+		default:
+			volt = sc27xx_adc_to_volt(&small_scale_graph, raw_adc);
+			break;
+		}
 	}
 
 	sc27xx_adc_volt_ratio(data, channel, scale, &numerator, &denominator);
@@ -760,21 +924,42 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 	if (ret)
 		return ret;
 
-	/* Enable ADC work clock and controller clock */
+	/* Enable 26MHz crvstal oscillator wait cycles for UMP9620 ADC */
+	if (data->var_data->pmic_type == UMP9620_ADC) {
+		ret = regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
+				UMP9620_XTL_WAIT_CTRL0_EN,
+				UMP9620_XTL_WAIT_CTRL0_EN);
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
 
@@ -798,6 +983,11 @@ static void sc27xx_adc_disable(void *_data)
 
 	regmap_update_bits(data->regmap, data->var_data->module_en,
 			   SC27XX_MODULE_ADC_EN, 0);
+
+	if (data->var_data->pmic_type == UMP9620_ADC)
+		regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
+				UMP9620_XTL_WAIT_CTRL0_EN, 0);
+
 }
 
 static const struct sc27xx_adc_variant_data sc2731_data = {
@@ -848,6 +1038,18 @@ static const struct sc27xx_adc_variant_data sc2720_data = {
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
@@ -941,6 +1143,7 @@ static const struct of_device_id sc27xx_adc_of_match[] = {
 	{ .compatible = "sprd,sc2730-adc", .data = &sc2730_data},
 	{ .compatible = "sprd,sc2721-adc", .data = &sc2721_data},
 	{ .compatible = "sprd,sc2720-adc", .data = &sc2720_data},
+	{ .compatible = "sprd,ump9620-adc", .data = &ump9620_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
-- 
2.25.1

