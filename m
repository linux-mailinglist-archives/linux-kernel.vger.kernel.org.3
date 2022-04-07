Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A718F4F797E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242941AbiDGIYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242909AbiDGIY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:24:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4E9574A5;
        Thu,  7 Apr 2022 01:22:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i11so4209406plg.12;
        Thu, 07 Apr 2022 01:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14J0OL0hxSo82CKtcFdEOvcdmPBV5/U+90dLbviHFSY=;
        b=PwrHnuwZZXdMQzBqMbDJij7FMuqXHfxTh35SEMg5SN9hHDeZyc0XqBNpxQY71ESvss
         torW8HwY3/z3L0Xwudt3mRUdumoL9BKNvOzohAT3WTkAeWGq6naa9Q6Um7nAjzFNq9w6
         QaJV3cYVu4P9vU+OtIhAGHNTyAexFzUObaP52GL1PKkvDSZMQW9sbNU2HiCH53/eGaPL
         8UC7BFzxPNC13MHr8rukXs6gHh4JDbRizWxAp6k4CziH4JIZqkk+bisGlVSRxZ9ucCJv
         BllfVp4OWYJaEtKO1An+GfchBjOjL4cXJaBhEks0JtB7gRp3fVEzYLts8RA8zhq0PXwE
         iWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14J0OL0hxSo82CKtcFdEOvcdmPBV5/U+90dLbviHFSY=;
        b=5tydO+qOlQgG3We2BjcwW4S6Fda9lMf69itB2wK6j81tV70MwhTu0BUsWJ5DHpTk7k
         CTnsaU+F5wKM4Lgiv8TFxmk2doajzbbFmD14fsEWo/mJJ+U6Tu0qb+RmzTL90C9eQTyK
         DorCFwVUx6dQa1xLLoHbTksUX6orPc4UTDcrdyXWnZ8Lc8FQRKPiPolbJnJNhTfGh1Nu
         Upf2yrhG5COmctNhkX0v+q5Q8ERoRRQLzlBWwwdbgZWQv2JdOvlESFwxemTYqoj2NFjl
         IvGCCioQC7DOrjyWCsfnX8DxKrxNMXIj6w3NIrWCIEatjbIofAp58kbvyr4tQ5AZWSmL
         ke0A==
X-Gm-Message-State: AOAM533FeZXcaEuZFwSmwVvEh6rq9X/0J93DmN/Am/kTdjtnITPQmZnu
        9kWPyxcIdfHdyV9u9yZMrvE=
X-Google-Smtp-Source: ABdhPJyN3RcdniAYhbfQ2H1WwQpCI8slFdyZY37K35X5DkhWoO6EH5bf+HhEz3jw1i30CzusS9Qfxg==
X-Received: by 2002:a17:902:dad0:b0:154:740a:9094 with SMTP id q16-20020a170902dad000b00154740a9094mr12740143plx.107.1649319747104;
        Thu, 07 Apr 2022 01:22:27 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm22248098pfx.34.2022.04.07.01.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 01:22:26 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com
Cc:     yuming.zhu1@unisoc.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 5/7] iio: adc: sc27xx: add support for PMIC sc2720 and sc2721
Date:   Thu,  7 Apr 2022 16:21:46 +0800
Message-Id: <20220407082148.571442-6-gengcixi@gmail.com>
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

sc2720 and sc2721 is the product of sc27xx series.

Co-developed-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/iio/adc/sc27xx_adc.c | 211 ++++++++++++++++++++++++++++++++++-
 1 file changed, 209 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index 60c0a6aa3f45..eb9e789dd8ee 100644
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
@@ -67,8 +71,20 @@
 #define SC27XX_RATIO_NUMERATOR_OFFSET	16
 #define SC27XX_RATIO_DENOMINATOR_MASK	GENMASK(15, 0)
 
+/* ADC specific channel reference voltage 3.5V */
+#define SC27XX_ADC_REFVOL_VDD35		3500000
+
+/* ADC default channel reference voltage is 2.8V */
+#define SC27XX_ADC_REFVOL_VDD28		2800000
+
+enum sc27xx_pmic_type {
+	SC27XX_ADC,
+	SC2721_ADC,
+};
+
 struct sc27xx_adc_data {
 	struct device *dev;
+	struct regulator *volref;
 	struct regmap *regmap;
 	/*
 	 * One hardware spinlock to synchronize between the multiple
@@ -87,6 +103,7 @@ struct sc27xx_adc_data {
  * in the device data structure.
  */
 struct sc27xx_adc_variant_data {
+	enum sc27xx_pmic_type pmic_type;
 	u32 module_en;
 	u32 clk_en;
 	u32 scale_shift;
@@ -131,6 +148,16 @@ static const struct sc27xx_adc_linear_graph sc2731_small_scale_graph_calib = {
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
@@ -192,6 +219,94 @@ static int sc27xx_adc_scale_calibration(struct sc27xx_adc_data *data,
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
@@ -220,6 +335,34 @@ static int sc2731_adc_get_ratio(int channel, int scale)
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
@@ -237,7 +380,7 @@ static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
 static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 			   int scale, int *val)
 {
-	int ret;
+	int ret, ret_volref;
 	u32 tmp, value, status;
 
 	ret = hwspin_lock_timeout_raw(data->hwlock, SC27XX_ADC_HWLOCK_TIMEOUT);
@@ -246,10 +389,25 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 		return ret;
 	}
 
+	/*
+	 * According to the sc2721 chip data sheet, the reference voltage of
+	 * specific channel 30 and channel 31 in ADC module needs to be set from
+	 * the default 2.8v to 3.5v.
+	 */
+	if ((data->var_data->pmic_type == SC2721_ADC) && (channel == 30 || channel == 31)) {
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
@@ -300,6 +458,17 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
 	regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
 			   SC27XX_ADC_EN, 0);
 
+regulator_restore:
+	if ((data->var_data->pmic_type == SC2721_ADC) && (channel == 30 || channel == 31)) {
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
 
@@ -540,6 +709,7 @@ static void sc27xx_adc_disable(void *_data)
 }
 
 static const struct sc27xx_adc_variant_data sc2731_data = {
+	.pmic_type = SC27XX_ADC,
 	.module_en = SC2731_MODULE_EN,
 	.clk_en = SC2731_ARM_CLK_EN,
 	.scale_shift = SC27XX_ADC_SCALE_SHIFT,
@@ -550,6 +720,30 @@ static const struct sc27xx_adc_variant_data sc2731_data = {
 	.get_ratio = sc2731_adc_get_ratio,
 };
 
+static const struct sc27xx_adc_variant_data sc2721_data = {
+	.pmic_type = SC2721_ADC,
+	.module_en = SC2731_MODULE_EN,
+	.clk_en = SC2721_ARM_CLK_EN,
+	.scale_shift = SC2721_ADC_SCALE_SHIFT,
+	.scale_mask = SC2721_ADC_SCALE_MASK,
+	.bscale_cal = &sc2731_big_scale_graph_calib,
+	.sscale_cal = &sc2731_small_scale_graph_calib,
+	.init_scale = sc2731_adc_scale_init,
+	.get_ratio = sc2721_adc_get_ratio,
+};
+
+static const struct sc27xx_adc_variant_data sc2720_data = {
+	.pmic_type = SC27XX_ADC,
+	.module_en = SC2731_MODULE_EN,
+	.clk_en = SC2721_ARM_CLK_EN,
+	.scale_shift = SC27XX_ADC_SCALE_SHIFT,
+	.scale_mask = SC27XX_ADC_SCALE_MASK,
+	.bscale_cal = &big_scale_graph_calib,
+	.sscale_cal = &small_scale_graph_calib,
+	.init_scale = sc2720_adc_scale_init,
+	.get_ratio = sc2720_adc_get_ratio,
+};
+
 static int sc27xx_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -600,6 +794,17 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 	}
 
 	sc27xx_data->dev = dev;
+	if (pdata->pmic_type == SC2721_ADC) {
+		sc27xx_data->volref = devm_regulator_get(dev, "vref");
+		if (IS_ERR(sc27xx_data->volref)) {
+			ret = PTR_ERR(sc27xx_data->volref);
+			if (ret == -ENODEV)
+				dev_err(dev, "failed to supply the regulator\n");
+			dev_err(dev, "failed to get ADC volref, the err volref: %d\n", ret);
+			return ret;
+		}
+	}
+
 	sc27xx_data->var_data = pdata;
 	sc27xx_data->var_data->init_scale(sc27xx_data);
 
@@ -629,6 +834,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 
 static const struct of_device_id sc27xx_adc_of_match[] = {
 	{ .compatible = "sprd,sc2731-adc", .data = &sc2731_data},
+	{ .compatible = "sprd,sc2721-adc", .data = &sc2721_data},
+	{ .compatible = "sprd,sc2720-adc", .data = &sc2720_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
-- 
2.25.1

