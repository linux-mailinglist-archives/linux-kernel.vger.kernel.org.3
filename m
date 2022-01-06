Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7819D4864CA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbiAFNAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239250AbiAFNAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:00:33 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CC3C0611FF;
        Thu,  6 Jan 2022 05:00:33 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id x194so2489998pgx.4;
        Thu, 06 Jan 2022 05:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ca4P6Rl8YbnyzreMY2S3kaJ9rjun/PfVMGIzWUKDdk4=;
        b=D+j/cdx4191SPWO1bDqJEMCpUY3qesil4Ig69VlDpBcozWu7OwfYX34uef89xcSXz1
         e0sA7dYf+cJPptvsD02m+GtJ1S8lekpVSt4i6MAuw0Y499BLBcElutxOZwZALLXqaezT
         D2U8gt9WVyUqwcraxaf1YqunmbSwc3KX+TOtcP/18wfExXYs06RHsdbcKsDWNkCr/pSQ
         hdt/V+pS+HtO1ySWogyiizKUOla/PAnBTpUA1H3NCgF/ztFt+hNLnxC7CfRjym/6Hqud
         gvJhbDu57aeKX9h65uAke49gGYrKXW+hF8aOwpIpOoo2fQOM/+QQzWJMRijJNPcYBNvI
         Yn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ca4P6Rl8YbnyzreMY2S3kaJ9rjun/PfVMGIzWUKDdk4=;
        b=jdj/BZhwgdlQvb/yYvFGOpkU3kDlhG7fg7pD7UGFID2vOIdO33lQVBlq+TL7qO2VoV
         kWrL6xIPKpt9jgletEdM2UAT/wNWw3PXqVm7iGyg5V5qmah9u+ogjldl7OSMRic+uGdD
         y1tAYlFZoHBhUXpVv+7OE6XzUU2nE4wIFBIRYbfK0ynN4mD/X0n4Gs+xKY4+RfS8T1G4
         A3eqCKW5Y75P5SEzFiPtmzhj1lx5zwwF65+Bw5r8MqsF3L3NfCKM+Wxw04Kp0NEXNEZr
         tinqiAuoo+RNsU5bVfzDBNTXdwPn7HSd2G8+hPCVnToyo+ObaFkU3wGNkPHofq19voL1
         V3+w==
X-Gm-Message-State: AOAM530bIM3/ybu+3rdjLI/Ga54eluIbhin5RL0PX+7CkbF2mhTs3/It
        2kqpBTtrc4qmJbnW38rfi/tCRz0Qt0xCAA==
X-Google-Smtp-Source: ABdhPJzgDWtFI52S33KDrM0nBjCkvk7eq0k3VgwaGRbB9C0zZ5ntKtCEaYbC48h5MjzRcxj5TAC9Vw==
X-Received: by 2002:a05:6a00:1309:b0:4bc:c640:73f9 with SMTP id j9-20020a056a00130900b004bcc64073f9mr14246718pfu.50.1641474033025;
        Thu, 06 Jan 2022 05:00:33 -0800 (PST)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g14sm2052583pgp.76.2022.01.06.05.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 05:00:32 -0800 (PST)
From:   Cixi Geng <gengcixi@gmail.com>
To:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] iio: adc: sc27xx: add support for PMIC ump9620
Date:   Thu,  6 Jan 2022 20:59:46 +0800
Message-Id: <20220106125947.139523-7-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106125947.139523-1-gengcixi@gmail.com>
References: <20220106125947.139523-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

The ump9620 is variant from sc27xx chip, add it in here.

Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 263 +++++++++++++++++++++++++++++++++--
 1 file changed, 254 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 195f44cf61e1..68b967f32498 100644
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
@@ -140,6 +151,11 @@ static struct sc27xx_adc_linear_graph small_scale_graph = {
 	100, 341,
 };
 
+static struct sc27xx_adc_linear_graph ump9620_bat_det_graph = {
+	1400, 3482,
+	200, 476,
+};
+
 static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_calib = {
 	4200, 850,
 	3600, 728,
@@ -165,6 +181,33 @@ static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
 	return ((calib_data & 0xff) + calib_adc - 128) * 4;
 }
 
+static int adc_nvmem_cell_calib_data(struct sc27xx_adc_data *data, const char *cell_name)
+{
+	struct nvmem_cell *cell;
+	void *buf;
+	u32 calib_data = 0;
+	size_t len = 0;
+
+	if (!data)
+		return -EINVAL;
+
+	cell = nvmem_cell_get(data->dev, cell_name);
+	if (IS_ERR_OR_NULL(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	if (IS_ERR_OR_NULL(buf)) {
+		nvmem_cell_put(cell);
+		return PTR_ERR(buf);
+	}
+
+	memcpy(&calib_data, buf, min(len, sizeof(u32)));
+
+	kfree(buf);
+	nvmem_cell_put(cell);
+	return calib_data;
+}
+
 static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 					bool big_scale)
 {
@@ -207,6 +250,56 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 	return 0;
 }
 
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
+	return 0;
+}
+
 static int sc2720_adc_get_ratio(int channel, int scale)
 {
 	switch (channel) {
@@ -394,6 +487,50 @@ static int sc2731_adc_get_ratio(int channel, int scale)
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
@@ -453,6 +590,22 @@ static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
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
@@ -578,6 +731,23 @@ static int sc27xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph,
 	return tmp < 0 ? 0 : tmp;
 }
 
+static int ump96xx_adc_to_volt(struct sc27xx_adc_linear_graph *graph, int scale,
+			      int raw_adc)
+{
+	int tmp;
+
+	tmp = (graph->volt0 - graph->volt1) * (raw_adc - graph->adc1);
+	tmp /= (graph->adc0 - graph->adc1);
+	tmp += graph->volt1;
+
+	if (scale == 2)
+		tmp = tmp * 2600 / 1000;
+	else if (scale == 3)
+		tmp = tmp * 4060 / 1000;
+
+	return tmp < 0 ? 0 : tmp;
+}
+
 static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
 				   int scale, int raw_adc)
 {
@@ -608,6 +778,39 @@ static int sc27xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
 	return DIV_ROUND_CLOSEST(volt * denominator, numerator);
 }
 
+static int ump96xx_adc_convert_volt(struct sc27xx_adc_data *data, int channel,
+				   int scale, int raw_adc)
+{
+	u32 numerator, denominator;
+	u32 volt;
+
+	switch (channel) {
+	case 0:
+		if (scale == 1)
+			volt = sc27xx_adc_to_volt(&ump9620_bat_det_graph, raw_adc);
+		else
+			volt = ump96xx_adc_to_volt(&small_scale_graph, scale, raw_adc);
+		break;
+	case 11:
+		volt = sc27xx_adc_to_volt(&big_scale_graph, raw_adc);
+		break;
+	default:
+		if (scale == 1)
+			volt = sc27xx_adc_to_volt(&ump9620_bat_det_graph, raw_adc);
+		else
+			volt = ump96xx_adc_to_volt(&small_scale_graph, scale, raw_adc);
+		break;
+	}
+
+	if (channel == 0 && scale == 1)
+		return volt;
+
+	sc27xx_adc_volt_ratio(data, channel, scale, &numerator, &denominator);
+
+	return DIV_ROUND_CLOSEST(volt * denominator, numerator);
+}
+
+
 static int sc27xx_adc_read_processed(struct sc27xx_adc_data *data,
 				     int channel, int scale, int *val)
 {
@@ -617,7 +820,11 @@ static int sc27xx_adc_read_processed(struct sc27xx_adc_data *data,
 	if (ret)
 		return ret;
 
-	*val = sc27xx_adc_convert_volt(data, channel, scale, raw_adc);
+	if (data->var_data->pmic_type == UMP9620_ADC)
+		*val = ump96xx_adc_convert_volt(data, channel, scale, raw_adc);
+	else
+		*val = sc27xx_adc_convert_volt(data, channel, scale, raw_adc);
+
 	return 0;
 }
 
@@ -735,21 +942,42 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
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
 
@@ -773,6 +1001,10 @@ static void sc27xx_adc_disable(void *_data)
 
 	regmap_update_bits(data->regmap, data->var_data->module_en,
 			   SC27XX_MODULE_ADC_EN, 0);
+
+	if (data->var_data->pmic_type == UMP9620_ADC)
+		regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
+				UMP9620_XTL_WAIT_CTRL0_EN, 0);
 }
 
 static const struct sc27xx_adc_variant_data sc2731_data = {
@@ -823,6 +1055,18 @@ static const struct sc27xx_adc_variant_data sc2720_data = {
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
@@ -914,6 +1158,7 @@ static const struct of_device_id sc27xx_adc_of_match[] = {
 	{ .compatible = "sprd,sc2730-adc", .data = &sc2730_data},
 	{ .compatible = "sprd,sc2721-adc", .data = &sc2721_data},
 	{ .compatible = "sprd,sc2720-adc", .data = &sc2720_data},
+	{ .compatible = "sprd,ump9620-adc", .data = &ump9620_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
-- 
2.25.1

