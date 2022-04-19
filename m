Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD552507079
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349004AbiDSO30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiDSO2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:28:21 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD6C5F5C;
        Tue, 19 Apr 2022 07:25:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v12so15913018plv.4;
        Tue, 19 Apr 2022 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FVBdxmXZdWtAT4NIHaq3Vtzlfp5eYa1PeYucsc/OnxM=;
        b=ZbNfyvdoBIDFkv3QIokFrks5zuB5atdGGnn5NGbazhRR/xXYgj+Ldx06A+Z/BlGKwQ
         5XpOk3cunajp4w2JDuQZNGHE4/rDcOK4veqZ7s1P6v7PZ2fxg9r/7+JNpLCmGtVCej0l
         R3P/Mk7NCv2X6MjPNq7EtdtuS1XrIgd6FATrvwaC7H/qjOCiZMkF437esqJRk87t7tuu
         mdBPYi/qHHq359OAGLnvRmiAl7qeyvA7eAcFFLwRl0k13mGQvYXrEbkHzmhBp++rcx2R
         zAH6BA6ZQmIypi/DvvWEi9Go/vA3nuuAhVMYWG/MGOIfJBE0jgqQwlfk1Nx9tUQxE30k
         qGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FVBdxmXZdWtAT4NIHaq3Vtzlfp5eYa1PeYucsc/OnxM=;
        b=46pBRUlSNcKk3BOcLBRiJeg/ol2QD1aq/nvAcdyHkEVscpaUhWZH6xu64TQ/1Yljdm
         rxApcjWAQneqyLe7Llo5So2O+3+ymIe0caODfRBWb8R135Ue00t/WcPYz9/RRvrAg31L
         Q2NtQFBM6IA/js9hj5qUaFPnpFToAN50ocXoBM6rXat0EIrCmqYtze4iyYnn8zn01erN
         j4Mecg8Cf01gwchArEucL8LRqGqjS+iDThBymh4AxGmXmJmePQeYLi5QwnQmJRB12bfP
         4Xj/LyeJVF5FdmgRlqvUI01uY7H23bMaeFc8hjLnA1wpMFji+9x1LOCqXzrfNkeHIBNP
         y9ng==
X-Gm-Message-State: AOAM531CtgNtjsw8t4SmlbVUFEI+xHrq0pcXF9xLiPs12QKRWHuIJzAr
        Hy7bfTjbG2tS18oK6NuN+pY=
X-Google-Smtp-Source: ABdhPJycjeUMK0BJIoBPgSMOr7GkvG5N5FdBcwCEqa9XjlRX1RFhRgfo7Pk8AmAK4isHrjsf6xcIag==
X-Received: by 2002:a17:90b:4a8a:b0:1d2:f7ba:8728 with SMTP id lp10-20020a17090b4a8a00b001d2f7ba8728mr345376pjb.43.1650378338213;
        Tue, 19 Apr 2022 07:25:38 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e15-20020a63ae4f000000b003995a4ce0aasm16681939pgp.22.2022.04.19.07.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:25:37 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        yuming.zhu1@unisoc.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 6/7] iio: adc: sc27xx: add support for PMIC sc2720 and sc2721
Date:   Tue, 19 Apr 2022 22:24:57 +0800
Message-Id: <20220419142458.884933-7-gengcixi@gmail.com>
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

sc2720 and sc2721 is the product of sc27xx series.

Co-developed-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 203 ++++++++++++++++++++++++++++++++++-
 1 file changed, 201 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 27fab579a281..40686ee60c01 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -9,11 +9,13 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
 /* PMIC global registers definition */
 #define SC2731_MODULE_EN		0xc08
 #define SC27XX_MODULE_ADC_EN		BIT(5)
+#define SC2721_ARM_CLK_EN		0xc0c
 #define SC2731_ARM_CLK_EN		0xc10
 #define SC27XX_CLK_ADC_EN		BIT(5)
 #define SC27XX_CLK_ADC_CLK_EN		BIT(6)
@@ -37,7 +39,9 @@
 /* Bits and mask definition for SC27XX_ADC_CH_CFG register */
 #define SC27XX_ADC_CHN_ID_MASK		GENMASK(4, 0)
 #define SC27XX_ADC_SCALE_MASK		GENMASK(10, 9)
+#define SC2721_ADC_SCALE_MASK		BIT(5)
 #define SC27XX_ADC_SCALE_SHIFT		9
+#define SC2721_ADC_SCALE_SHIFT		5
 
 /* Bits definitions for SC27XX_ADC_INT_EN registers */
 #define SC27XX_ADC_IRQ_EN		BIT(0)
@@ -67,8 +71,15 @@
 #define SC27XX_RATIO_NUMERATOR_OFFSET	16
 #define SC27XX_RATIO_DENOMINATOR_MASK	GENMASK(15, 0)
 
+/* ADC specific channel reference voltage 3.5V */
+#define SC27XX_ADC_REFVOL_VDD35		3500000
+
+/* ADC default channel reference voltage is 2.8V */
+#define SC27XX_ADC_REFVOL_VDD28		2800000
+
 struct sc27xx_adc_data {
 	struct device *dev;
+	struct regulator *volref;
 	struct regmap *regmap;
 	/*
 	 * One hardware spinlock to synchronize between the multiple
@@ -95,6 +106,7 @@ struct sc27xx_adc_variant_data {
 	const struct sc27xx_adc_linear_graph *sscale_cal;
 	void (*init_scale)(struct sc27xx_adc_data *data);
 	int (*get_ratio)(int channel, int scale);
+	bool set_volref;
 };
 
 struct sc27xx_adc_linear_graph {
@@ -133,6 +145,16 @@ static const struct sc27xx_adc_linear_graph sc2731_small_scale_graph_calib = {
 	100, 84,
 };
 
+static const struct sc27xx_adc_linear_graph big_scale_graph_calib = {
+	4200, 856,
+	3600, 733,
+};
+
+static const struct sc27xx_adc_linear_graph small_scale_graph_calib = {
+	1000, 833,
+	100, 80,
+};
+
 static int sc27xx_adc_get_calib_data(u32 calib_data, int calib_adc)
 {
 	return ((calib_data & 0xff) + calib_adc - 128) * 4;
@@ -194,6 +216,94 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
 	return 0;
 }
 
+static int sc2720_adc_get_ratio(int channel, int scale)
+{
+	switch (channel) {
+	case 14:
+		switch (scale) {
+		case 0:
+			return SC27XX_VOLT_RATIO(68, 900);
+		case 1:
+			return SC27XX_VOLT_RATIO(68, 1760);
+		case 2:
+			return SC27XX_VOLT_RATIO(68, 2327);
+		case 3:
+			return SC27XX_VOLT_RATIO(68, 3654);
+		default:
+			return SC27XX_VOLT_RATIO(1, 1);
+		}
+	case 16:
+		switch (scale) {
+		case 0:
+			return SC27XX_VOLT_RATIO(48, 100);
+		case 1:
+			return SC27XX_VOLT_RATIO(480, 1955);
+		case 2:
+			return SC27XX_VOLT_RATIO(480, 2586);
+		case 3:
+			return SC27XX_VOLT_RATIO(48, 406);
+		default:
+			return SC27XX_VOLT_RATIO(1, 1);
+		}
+	case 21:
+	case 22:
+	case 23:
+		switch (scale) {
+		case 0:
+			return SC27XX_VOLT_RATIO(3, 8);
+		case 1:
+			return SC27XX_VOLT_RATIO(375, 1955);
+		case 2:
+			return SC27XX_VOLT_RATIO(375, 2586);
+		case 3:
+			return SC27XX_VOLT_RATIO(300, 3248);
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
+			return SC27XX_VOLT_RATIO(1000, 2586);
+		case 3:
+			return SC27XX_VOLT_RATIO(100, 406);
+		default:
+			return SC27XX_VOLT_RATIO(1, 1);
+		}
+	}
+	return SC27XX_VOLT_RATIO(1, 1);
+}
+
+static int sc2721_adc_get_ratio(int channel, int scale)
+{
+	switch (channel) {
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		return scale ? SC27XX_VOLT_RATIO(400, 1025) :
+			SC27XX_VOLT_RATIO(1, 1);
+	case 5:
+		return SC27XX_VOLT_RATIO(7, 29);
+	case 7:
+	case 9:
+		return scale ? SC27XX_VOLT_RATIO(100, 125) :
+			SC27XX_VOLT_RATIO(1, 1);
+	case 14:
+		return SC27XX_VOLT_RATIO(68, 900);
+	case 16:
+		return SC27XX_VOLT_RATIO(48, 100);
+	case 19:
+		return SC27XX_VOLT_RATIO(1, 3);
+	default:
+		return SC27XX_VOLT_RATIO(1, 1);
+	}
+	return SC27XX_VOLT_RATIO(1, 1);
+}
+
 static int sc2731_adc_get_ratio(int channel, int scale)
 {
 	switch (channel) {
@@ -222,6 +332,34 @@ static int sc2731_adc_get_ratio(int channel, int scale)
 /*
  * According to the datasheet set specific value on some channel.
  */
+static void sc2720_adc_scale_init(struct sc27xx_adc_data *data)
+{
+	int i;
+
+	for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
+		switch (i) {
+		case 5:
+			data->channel_scale[i] = 3;
+			break;
+		case 7:
+		case 9:
+			data->channel_scale[i] = 2;
+			break;
+		case 13:
+			data->channel_scale[i] = 1;
+			break;
+		case 19:
+		case 30:
+		case 31:
+			data->channel_scale[i] = 3;
+			break;
+		default:
+			data->channel_scale[i] = 0;
+			break;
+		}
+	}
+}
+
 static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
 {
 	int i;
@@ -244,7 +382,7 @@ static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
 static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 			   int scale, int *val)
 {
-	int ret;
+	int ret, ret_volref;
 	u32 tmp, value, status;
 
 	ret = hwspin_lock_timeout_raw(data->hwlock, SC27XX_ADC_HWLOCK_TIMEOUT);
@@ -253,10 +391,25 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 		return ret;
 	}
 
+	/*
+	 * According to the sc2721 chip data sheet, the reference voltage of
+	 * specific channel 30 and channel 31 in ADC module needs to be set from
+	 * the default 2.8v to 3.5v.
+	 */
+	if ((data->var_data->set_volref) && (channel == 30 || channel == 31)) {
+		ret = regulator_set_voltage(data->volref,
+					SC27XX_ADC_REFVOL_VDD35,
+					SC27XX_ADC_REFVOL_VDD35);
+		if (ret) {
+			dev_err(data->dev, "failed to set the volref 3.5v\n");
+			goto unlock_adc;
+		}
+	}
+
 	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
 				 SC27XX_ADC_EN, SC27XX_ADC_EN);
 	if (ret)
-		goto unlock_adc;
+		goto regulator_restore;
 
 	ret = regmap_update_bits(data->regmap, data->base + SC27XX_ADC_INT_CLR,
 				 SC27XX_ADC_IRQ_CLR, SC27XX_ADC_IRQ_CLR);
@@ -306,6 +459,17 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 disable_adc:
 	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
 			   SC27XX_ADC_EN, 0);
+regulator_restore:
+	if ((data->var_data->set_volref) && (channel == 30 || channel == 31)) {
+		ret_volref = regulator_set_voltage(data->volref,
+					    SC27XX_ADC_REFVOL_VDD28,
+					    SC27XX_ADC_REFVOL_VDD28);
+		if (ret_volref) {
+			dev_err(data->dev, "failed to set the volref 2.8v,ret_volref = 0x%x\n",
+					 ret_volref);
+			ret = ret || ret_volref;
+		}
+	}
 unlock_adc:
 	hwspin_unlock_raw(data->hwlock);
 
@@ -554,6 +718,31 @@ static const struct sc27xx_adc_variant_data sc2731_data = {
 	.sscale_cal = &sc2731_small_scale_graph_calib,
 	.init_scale = sc2731_adc_scale_init,
 	.get_ratio = sc2731_adc_get_ratio,
+	.set_volref = false,
+};
+
+static const struct sc27xx_adc_variant_data sc2721_data = {
+	.module_en = SC2731_MODULE_EN,
+	.clk_en = SC2721_ARM_CLK_EN,
+	.scale_shift = SC2721_ADC_SCALE_SHIFT,
+	.scale_mask = SC2721_ADC_SCALE_MASK,
+	.bscale_cal = &sc2731_big_scale_graph_calib,
+	.sscale_cal = &sc2731_small_scale_graph_calib,
+	.init_scale = sc2731_adc_scale_init,
+	.get_ratio = sc2721_adc_get_ratio,
+	.set_volref = true,
+};
+
+static const struct sc27xx_adc_variant_data sc2720_data = {
+	.module_en = SC2731_MODULE_EN,
+	.clk_en = SC2721_ARM_CLK_EN,
+	.scale_shift = SC27XX_ADC_SCALE_SHIFT,
+	.scale_mask = SC27XX_ADC_SCALE_MASK,
+	.bscale_cal = &big_scale_graph_calib,
+	.sscale_cal = &small_scale_graph_calib,
+	.init_scale = sc2720_adc_scale_init,
+	.get_ratio = sc2720_adc_get_ratio,
+	.set_volref = false,
 };
 
 static int sc27xx_adc_probe(struct platform_device *pdev)
@@ -606,6 +795,14 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 	}
 
 	sc27xx_data->dev = dev;
+	if (pdata->set_volref) {
+		sc27xx_data->volref = devm_regulator_get(dev, "vref");
+		if (IS_ERR(sc27xx_data->volref)) {
+			ret = PTR_ERR(sc27xx_data->volref);
+			return dev_err_probe(dev, ret, "failed to get ADC volref\n");
+		}
+	}
+
 	sc27xx_data->var_data = pdata;
 	sc27xx_data->var_data->init_scale(sc27xx_data);
 
@@ -635,6 +832,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 
 static const struct of_device_id sc27xx_adc_of_match[] = {
 	{ .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
+	{ .compatible = "sprd,sc2721-adc", .data = &sc2721_data},
+	{ .compatible = "sprd,sc2720-adc", .data = &sc2720_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
-- 
2.25.1

