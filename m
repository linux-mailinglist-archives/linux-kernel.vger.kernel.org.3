Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3033507070
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352541AbiDSO3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349004AbiDSO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:28:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71075F5C;
        Tue, 19 Apr 2022 07:25:30 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso2023045pjj.3;
        Tue, 19 Apr 2022 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzQtmy83w28wVk2zpWIVdQI6X3MTzkOS2+CYtXZXbLc=;
        b=dP2nRJcmcs6wzfdL6UNjgJOFMncj9xsrYO3o1vmhMy/g3eugRXZiL9qo0Nk+kHlyyf
         4Kv3JdDfz1YJcQYC8yaAAZ+fwLjjiMZeP2VTP1ph/imHMLuSIsB8TJglXvNv9ehM5Ghl
         fZobKQYbfNXpc4cMNQkERa4ryFsZJEMuToNDwLnu1tIXlSBZ87k6Z3ZN6rKJi+b6vWng
         NIwtzO8JdAWz+qqxj/2q6K8Ga+XbycmLyXuHRXQoSHLRX+MS8oA4Ysgs2Khi3iXVfGig
         EoipMelC/UjFUZH/l842kN8KBBCBTrz4Jkw6wZvPYrsn/HUCT34nkR+9AsiMIc1qZgvl
         vpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pzQtmy83w28wVk2zpWIVdQI6X3MTzkOS2+CYtXZXbLc=;
        b=wSR7zTYWzwN+VqBayb1GJaesbjKG7sdH9FEOcBmyUhM7nSFiYzYZLHFuar0NjZsH8l
         pPvRdx2xGlZLVJ+uR3zKtHYU62WIiagNXAOuMLHWAJmDv/4/QRvYHIj8O2+4Sb8ZZSIv
         UOPLW6st72WEV4vG+ZBjDDQ7+knUgrFxHq2KwSLwAu6y8hQNqHD2zZTeFFnq1zdu9bSp
         YvNad01aMZXc+GcJKgEZJqeL7qlunGxgy90uBby8J/+V4SfUwnx4SyU6xAJwPV7V2uw/
         6zztrU+2W7EVJBkDkmsDLBt/uZKUcvJOCJL1KiC2qnB6/sPs5n7jQFbHI52vZjByoduq
         Oc2w==
X-Gm-Message-State: AOAM53109ViTeHqK/OG0N/2eXsidp2KjpVAccMnbL5e2Fd/t6ap4OOIZ
        HbeUT63LT4QUTG8yQmFcqmzZdltGyGA=
X-Google-Smtp-Source: ABdhPJwjYnwQIuPo2BfbVm8LZg70ozgA+OafmVFFk1ov/mKv57g88jc0L3/ZoKG5vyWVudhIOh72ZA==
X-Received: by 2002:a17:902:d5cd:b0:156:6263:bbc7 with SMTP id g13-20020a170902d5cd00b001566263bbc7mr16479949plh.160.1650378330293;
        Tue, 19 Apr 2022 07:25:30 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ae4f000000b003995a4ce0aasm16681939pgp.22.2022.04.19.07.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:25:29 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/7] iio: adc: sc27xx: structure adjustment and optimization
Date:   Tue, 19 Apr 2022 22:24:55 +0800
Message-Id: <20220419142458.884933-5-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220419142458.884933-1-gengcixi@gmail.com>
References: <20220419142458.884933-1-gengcixi@gmail.com>
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
and so on. also rename the SC27xx to SC2731 for some definition
and function.

Co-developed-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 91 ++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 24211d2a71b1..a8906ffd85bf 100644
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
@@ -133,11 +150,11 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 	size_t len;
 
 	if (big_scale) {
-		calib_graph = &sc2731_big_scale_graph_calib;
+		calib_graph = data->var_data->bscale_cal;
 		graph = &big_scale_graph;
 		cell_name = "big_scale_calib";
 	} else {
-		calib_graph = &sc2731_small_scale_graph_calib;
+		calib_graph = data->var_data->sscale_cal;
 		graph = &small_scale_graph;
 		cell_name = "small_scale_calib";
 	}
@@ -163,7 +180,7 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 	return 0;
 }
 
-static int sc27xx_adc_get_ratio(int channel, int scale)
+static int sc2731_adc_get_ratio(int channel, int scale)
 {
 	switch (channel) {
 	case 1:
@@ -188,6 +205,28 @@ static int sc27xx_adc_get_ratio(int channel, int scale)
 	return SC27XX_VOLT_RATIO(1, 1);
 }
 
+/*
+ * According to the datasheet set specific value on some channel.
+ */
+static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
+{
+	int i;
+	/*
+	 * In the current software design, SC2731 support 2 scales,
+	 * channels 5 uses big scale, others use smale.
+	 */
+	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
+		switch (i) {
+		case 5:
+			data->channel_scale[i] = 1;
+			break;
+		default:
+			data->channel_scale[i] = 0;
+			break;
+		}
+	}
+}
+
 static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 			   int scale, int *val)
 {
@@ -211,10 +250,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
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
@@ -265,8 +305,9 @@ static void sc27xx_adc_volt_ratio(struct sc27xx_adc_data *data,
 				  int channel, int scale,
 				  u32 *div_numerator, u32 *div_denominator)
 {
-	u32 ratio = sc27xx_adc_get_ratio(channel, scale);
+	u32 ratio;
 
+	ratio = data->var_data->get_ratio(channel, scale);
 	*div_numerator = ratio >> SC27XX_RATIO_NUMERATOR_OFFSET;
 	*div_denominator = ratio & SC27XX_RATIO_DENOMINATOR_MASK;
 }
@@ -435,13 +476,13 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
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
@@ -459,10 +500,10 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
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
@@ -473,21 +514,39 @@ static void sc27xx_adc_disable(void *_data)
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
@@ -523,6 +582,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 	}
 
 	sc27xx_data->dev = dev;
+	sc27xx_data->var_data = pdata;
+	sc27xx_data->var_data->init_scale(sc27xx_data);
 
 	ret = sc27xx_adc_enable(sc27xx_data);
 	if (ret) {
@@ -549,7 +610,7 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sc27xx_adc_of_match[] = {
-	{ .compatible = "sprd,sc2731-adc", },
+	{ .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
-- 
2.25.1

