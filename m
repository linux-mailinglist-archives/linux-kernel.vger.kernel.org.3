Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73864864C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbiAFNAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbiAFNAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:00:22 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782E2C061245;
        Thu,  6 Jan 2022 05:00:22 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id v13so2475736pfi.3;
        Thu, 06 Jan 2022 05:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OmrSkJo+iO0HQArtSBrpw/4y/8eqBV0Eng8AjOhJahM=;
        b=Y7VT92z+IZ0wkBdtNgYCNlM+/9/udl0ajS1C/NOl9o0Sf3gSUDiL8HZvXHpPgmk/jF
         marwE3wIoQlBf2D+LgHBMa2xGbcl+4TKJkPTZboY17qL1PF/yILZQy64+AX3G2gnX+XP
         BS1+HUzj0uSxVmW9zHzo+0/zfvTVUM4T/pHmRJ3+M3xoLainKGpwzu6IAiGThgmghLgM
         R0M+o8fThlQCuR/jJ2X+JJQ8vPgdgIdRuzPf2HhkmOPG13dGhElxwbg2AuffmSSSU/oO
         LdaQLo8z+GRBgt0CPAfzkhjFXsWmafY0HJIsaIR+P3OYF+Kll2PBEGBtJQxlB/kPSXpT
         uyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OmrSkJo+iO0HQArtSBrpw/4y/8eqBV0Eng8AjOhJahM=;
        b=ixGfoBtGsYNhhV1REGwaNpZq3tVZoPpiBcfSGBI70Eqyak/pw15LZ2cHG1uatkf+Md
         x/KdmNaw7cvnyav5k8yFnvrLyRzRpBy+XySmKoQUToccXx32bDbdg/NOHPOcteDqenRt
         g/XF2Q2RTxaARg0NKqw3w7iW7VeqYcNiZ8sgvNMaRZef+3QjXyQctyK/R3Kw+svVLW9s
         7A1sDRjExRHolv95FQek+Ot18spzTs6bJYOEnMqSDmekVJVZRZfP5rvysvSqHQufb8yy
         tGReePNl/eF/zcFL2rlKVI4xm5K9SATvSjxk5CSTXDih0/XB3ttges89FjUY8nfbneiU
         60wg==
X-Gm-Message-State: AOAM533973KtedbylPuoNzKDSAGyznShrwSB1j49h5kcuAzw4WT/lnGr
        ruEI1wGtVMwca4RCP7cWmmG/NG5FV1qU3Q==
X-Google-Smtp-Source: ABdhPJyvusqzmwI0TlLG68pMdZC1ggXw2xi0gUp9RqGms/by/9n0u77K6QNdZs6pZ9ajtIEKJKvbRg==
X-Received: by 2002:a65:6a93:: with SMTP id q19mr15653203pgu.155.1641474021997;
        Thu, 06 Jan 2022 05:00:21 -0800 (PST)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g14sm2052583pgp.76.2022.01.06.05.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 05:00:21 -0800 (PST)
From:   Cixi Geng <gengcixi@gmail.com>
To:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] iio: adc: sc27xx: structure adjuststment and optimization
Date:   Thu,  6 Jan 2022 20:59:43 +0800
Message-Id: <20220106125947.139523-4-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106125947.139523-1-gengcixi@gmail.com>
References: <20220106125947.139523-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

Introduce one variant device data structure to be compatible
with SC2731 PMIC since it has different scale and ratio calculation
and so on.

Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 94 ++++++++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index aee076c8e2b1..d2712e54ee79 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -12,9 +12,9 @@
 #include <linux/slab.h>
 
 /* PMIC global registers definition */
-#define SC27XX_MODULE_EN		0xc08
+#define SC2731_MODULE_EN		0xc08
 #define SC27XX_MODULE_ADC_EN		BIT(5)
-#define SC27XX_ARM_CLK_EN		0xc10
+#define SC2731_ARM_CLK_EN		0xc10
 #define SC27XX_CLK_ADC_EN		BIT(5)
 #define SC27XX_CLK_ADC_CLK_EN		BIT(6)
 
@@ -78,6 +78,23 @@ struct sc27xx_adc_data {
 	int channel_scale[SC27XX_ADC_CHANNEL_MAX];
 	u32 base;
 	int irq;
+	const struct sc27xx_adc_variant_data *var_data;
+};
+
+/*
+ * Since different PMICs of SC27xx series can have different
+ * address and ratio, we should save ratio config and base
+ * in the device data structure.
+ */
+struct sc27xx_adc_variant_data {
+	u32 module_en;
+	u32 clk_en;
+	u32 scale_shift;
+	u32 scale_mask;
+	const struct sc27xx_adc_linear_graph *bscale_cal;
+	const struct sc27xx_adc_linear_graph *sscale_cal;
+	void (*init_scale)(struct sc27xx_adc_data *data);
+	int (*get_ratio)(int channel, int scale);
 };
 
 struct sc27xx_adc_linear_graph {
@@ -103,6 +120,16 @@ static struct sc27xx_adc_linear_graph small_scale_graph = {
 	100, 341,
 };
 
+static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_calib = {
+	4200, 850,
+	3600, 728,
+};
+
+static const struct sc27xx_adc_linear_graph sc2731_small_scale_graph_calib = {
+	1000, 838,
+	100, 84,
+};
+
 static const struct sc27xx_adc_linear_graph big_scale_graph_calib = {
 	4200, 856,
 	3600, 733,
@@ -130,11 +157,11 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 	size_t len;
 
 	if (big_scale) {
-		calib_graph = &big_scale_graph_calib;
+		calib_graph = data->var_data->bscale_cal;
 		graph = &big_scale_graph;
 		cell_name = "big_scale_calib";
 	} else {
-		calib_graph = &small_scale_graph_calib;
+		calib_graph = data->var_data->sscale_cal;
 		graph = &small_scale_graph;
 		cell_name = "small_scale_calib";
 	}
@@ -160,7 +187,7 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 	return 0;
 }
 
-static int sc27xx_adc_get_ratio(int channel, int scale)
+static int sc2731_adc_get_ratio(int channel, int scale)
 {
 	switch (channel) {
 	case 1:
@@ -185,6 +212,21 @@ static int sc27xx_adc_get_ratio(int channel, int scale)
 	return SC27XX_VOLT_RATIO(1, 1);
 }
 
+/*
+ * According to the datasheet set specific value on some channel.
+ */
+static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
+{
+	int i;
+
+	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
+		if (i == 5)
+			data->channel_scale[i] = 1;
+		else
+			data->channel_scale[i] = 0;
+	}
+}
+
 static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 			   int scale, int *val)
 {
@@ -208,10 +250,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 		goto disable_adc;
 
 	/* Configure the channel id and scale */
-	tmp = (scale << SC27XX_ADC_SCALE_SHIFT) & SC27XX_ADC_SCALE_MASK;
+	tmp = (scale << data->var_data->scale_shift) & data->var_data->scale_mask;
 	tmp |= channel & SC27XX_ADC_CHN_ID_MASK;
 	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CH_CFG,
-				 SC27XX_ADC_CHN_ID_MASK | SC27XX_ADC_SCALE_MASK,
+				 SC27XX_ADC_CHN_ID_MASK |
+				 data->var_data->scale_mask,
 				 tmp);
 	if (ret)
 		goto disable_adc;
@@ -262,8 +305,9 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
 				  int channel, int scale,
 				  u32 *div_numerator, u32 *div_denominator)
 {
-	u32 ratio = sc27xx_adc_get_ratio(channel, scale);
+	u32 ratio;
 
+	ratio = data->var_data->get_ratio(channel, scale);
 	*div_numerator = ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
 	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
 }
@@ -432,13 +476,13 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 {
 	int ret;
 
-	ret = regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
+	ret = regmap_update_bits(data->regmap, data->var_data->module_en,
 				 SC27XX_MODULE_ADC_EN, SC27XX_MODULE_ADC_EN);
 	if (ret)
 		return ret;
 
 	/* Enable ADC work clock and controller clock */
-	ret = regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
+	ret = regmap_update_bits(data->regmap, data->var_data->clk_en,
 				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN,
 				 SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN);
 	if (ret)
@@ -456,10 +500,10 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
 	return 0;
 
 disable_clk:
-	regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
+	regmap_update_bits(data->regmap, data->var_data->clk_en,
 			   SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
 disable_adc:
-	regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
+	regmap_update_bits(data->regmap, data->var_data->module_en,
 			   SC27XX_MODULE_ADC_EN, 0);
 
 	return ret;
@@ -470,21 +514,39 @@ static void sc27xx_adc_disable(void *_data)
 	struct sc27xx_adc_data *data = _data;
 
 	/* Disable ADC work clock and controller clock */
-	regmap_update_bits(data->regmap, SC27XX_ARM_CLK_EN,
+	regmap_update_bits(data->regmap, data->var_data->clk_en,
 			   SC27XX_CLK_ADC_EN | SC27XX_CLK_ADC_CLK_EN, 0);
 
-	regmap_update_bits(data->regmap, SC27XX_MODULE_EN,
+	regmap_update_bits(data->regmap, data->var_data->module_en,
 			   SC27XX_MODULE_ADC_EN, 0);
 }
 
+static const struct sc27xx_adc_variant_data sc2731_data = {
+	.module_en = SC2731_MODULE_EN,
+	.clk_en = SC2731_ARM_CLK_EN,
+	.scale_shift = SC27XX_ADC_SCALE_SHIFT,
+	.scale_mask = SC27XX_ADC_SCALE_MASK,
+	.bscale_cal = &sc2731_big_scale_graph_calib,
+	.sscale_cal = &sc2731_small_scale_graph_calib,
+	.init_scale = sc2731_adc_scale_init,
+	.get_ratio = sc2731_adc_get_ratio,
+};
+
 static int sc27xx_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct sc27xx_adc_data *sc27xx_data;
+	const struct sc27xx_adc_variant_data *pdata;
 	struct iio_dev *indio_dev;
 	int ret;
 
+	pdata = of_device_get_match_data(dev);
+	if (!pdata) {
+		dev_err(dev, "No matching driver data found\n");
+		return -EINVAL;
+	}
+
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*sc27xx_data));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -520,6 +582,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 	}
 
 	sc27xx_data->dev = dev;
+	sc27xx_data->var_data = pdata;
+	sc27xx_data->var_data->init_scale(sc27xx_data);
 
 	ret = sc27xx_adc_enable(sc27xx_data);
 	if (ret) {
@@ -546,7 +610,7 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sc27xx_adc_of_match[] = {
-	{ .compatible = "sprd,sc2731-adc", },
+	{ .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
-- 
2.25.1

