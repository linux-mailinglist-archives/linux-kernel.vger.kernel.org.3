Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4514F797D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbiDGIY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242896AbiDGIYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:24:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979255522C;
        Thu,  7 Apr 2022 01:22:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fu5so4951533pjb.1;
        Thu, 07 Apr 2022 01:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uaK0h7kgpR+PmMbAtvMONscbR32W2T7D1u70s8sBFVM=;
        b=cys/VLYffVs7x/mJ52za3LGp5qryK8LwL6g7oQRgRHz0+2EQB4lkdokvcUqc4oGvwe
         OCY74GHZ8YTLFWYOY3h5fa5v/W5RakuEOEQiU8q6XJR+dUQEkX3iwbsC2rZ6gUrOTKZx
         C9AfxAGP6Zf3pYk9EtZp8O+Iy1+f1fHfW7K+z5hfIBpUdAGR/VsMV2ssGsfp6JBvsScS
         qCjUCZN66/n/TH6Yy+pdCdUHprXlMrS56eNcu/7ENVvxtbP4AgkY8Swct4en+eL4Yqrf
         4fWWyY423Axv3yan6lxfUAj21mR4WTApLomijzWm/SlRct9qYyIki21hYirsbHAfWD0w
         1JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uaK0h7kgpR+PmMbAtvMONscbR32W2T7D1u70s8sBFVM=;
        b=FX1UGQCJQOXTHBRfpcMYkiih/z1tBWoLujKmIzHBtpNrl83R3johDIjGG9sDML369z
         AMAgtrawd3TNQAxPgbqzpglDWofROa08fg1hXmFJTZ0W8DmX27ZoKu+cuq7LIpkeq0Wd
         HnUP/mgH3tj4JVkhVrHyl6DgsFebEqEx/qVV7Hvkc4IoBDfSMxMTQ3dF1fLaSv7dTv3C
         7cOU/MB4fK/SsxLpp0Lj5aI4xyyY9FvwfzmkDKkYwidcn9hxisrLZL8+k5I8/Q9c+eOX
         bpHAhhT2NVAvitU7Sqs0t3GtM5IT8SOhVyNNyte0hyYB+v871kgg0VOHKAhVxgXallnC
         JiyA==
X-Gm-Message-State: AOAM533OmWHanyCgEj+G8UX2eOxBiv42kOvT+tM6hq0sHexTcHU+/8GJ
        A9sIufxMd4gbFYHtbPzuITU=
X-Google-Smtp-Source: ABdhPJxUKImnLUh7YKNSdaLh7I1uRXY2qI6P9epRcyRHWT4pJuvVpc4biK70PY9yhOYhBpZzhft8gA==
X-Received: by 2002:a17:902:e84d:b0:156:bf35:6449 with SMTP id t13-20020a170902e84d00b00156bf356449mr12833036plg.26.1649319739109;
        Thu, 07 Apr 2022 01:22:19 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm22248098pfx.34.2022.04.07.01.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:22:18 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/7] iio: adc: sc27xx: structure adjuststment and optimization
Date:   Thu,  7 Apr 2022 16:21:44 +0800
Message-Id: <20220407082148.571442-4-gengcixi@gmail.com>
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

Introduce one variant device data structure to be compatible
with SC2731 PMIC since it has different scale and ratio calculation
and so on.

Co-developed-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 99 ++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index aee076c8e2b1..28bd70c27420 100644
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
@@ -103,14 +120,15 @@ static struct sc27xx_adc_linear_graph small_scale_graph = {
 	100, 341,
 };
 
-static const struct sc27xx_adc_linear_graph big_scale_graph_calib = {
-	4200, 856,
-	3600, 733,
+/* Add these for sc2731 pmic, and the [big|small]_scale_graph_calib for common's */
+static const struct sc27xx_adc_linear_graph sc2731_big_scale_graph_calib = {
+	4200, 850,
+	3600, 728,
 };
 
-static const struct sc27xx_adc_linear_graph small_scale_graph_calib = {
-	1000, 833,
-	100, 80,
+static const struct sc27xx_adc_linear_graph sc2731_small_scale_graph_calib = {
+	1000, 838,
+	100, 84,
 };
 
 static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
@@ -130,11 +148,11 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
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
@@ -160,7 +178,7 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 	return 0;
 }
 
-static int sc27xx_adc_get_ratio(int channel, int scale)
+static int sc2731_adc_get_ratio(int channel, int scale)
 {
 	switch (channel) {
 	case 1:
@@ -185,6 +203,23 @@ static int sc27xx_adc_get_ratio(int channel, int scale)
 	return SC27XX_VOLT_RATIO(1, 1);
 }
 
+/*
+ * According to the datasheet set specific value on some channel.
+ */
+static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
+{
+	int i;
+	/* In the current software design, SC2731 support 2 scales,
+	 * channels 5 uses big scale, others use smale.
+	 */
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
@@ -208,10 +243,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
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
@@ -262,8 +298,9 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
 				  int channel, int scale,
 				  u32 *div_numerator, u32 *div_denominator)
 {
-	u32 ratio = sc27xx_adc_get_ratio(channel, scale);
+	u32 ratio;
 
+	ratio = data->var_data->get_ratio(channel, scale);
 	*div_numerator = ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
 	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
 }
@@ -432,13 +469,13 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
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
@@ -456,10 +493,10 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
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
@@ -470,21 +507,39 @@ static void sc27xx_adc_disable(void *_data)
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
@@ -520,6 +575,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 	}
 
 	sc27xx_data->dev = dev;
+	sc27xx_data->var_data = pdata;
+	sc27xx_data->var_data->init_scale(sc27xx_data);
 
 	ret = sc27xx_adc_enable(sc27xx_data);
 	if (ret) {
@@ -546,7 +603,7 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sc27xx_adc_of_match[] = {
-	{ .compatible = "sprd,sc2731-adc", },
+	{ .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
-- 
2.25.1

