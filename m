Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8128F59849D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbiHRNrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245197AbiHRNqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:46:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AD7B56DD
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:46:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u14so1789988wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=b/Pll9h/rbDTnlPdrKXDdRGbrsm2wbSDn1R8q7pzFwE=;
        b=osYG1JQUdqi39hrW3UKdYZot/b5GlS/WZkL0ijBh6UDSC0Oq+LT9Cnf3Tt+yMAHSiu
         aS6p3Fpkm82ZPV8/qXtYxaIhoe0Injs/0v8w4hoCJpAmJJd4xoP+WymRELxMtUJqRHTX
         vMEaiaFsb7ZLpEyadyzxW+Pr4H2NzPmGALeOPMfuMHaJVoVix8F09syzRU4or01aUzB2
         Xm6aocxQ4lTTdy8X5Z4kOU4TFBRMfcwXuKEjrKpC+ac8TdVlgioK9CuFWkJOQ8/HAUAy
         UdbFcX1EDQRu5VF7a4FH7K1eseDLlie6YagG0hIy1jXfOWz7yb70Z/9dS9W4bI8Z6Cf1
         ZEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=b/Pll9h/rbDTnlPdrKXDdRGbrsm2wbSDn1R8q7pzFwE=;
        b=Cs6xYTJnHvaVACqc4+BuanTTmyKhlCpexzGTXal48l9S20D/mKNCmn9oZBJmBHnKLx
         mELDjXUpIaFagCzNMPOUETlMlxQ4Z0JFtU2dhxc2smqV5nICPkjewxgezE3PQYaBfxys
         ogVSPhGPOmiNACXrAHl41rKdOyWzRhNXjwa1svpqOpz28/JzfwPV84aI9kcReG6umTp1
         KNqazCRpbLpSWsd54rOH/JfjobEWSlEUPq9DanoDzlrXyHT5dF0a6yjBpftQ0L8U05gm
         /oFQXhqBrJOXizFC25j2bNW1xn+hOJqA8NMXdp+umhHMfsKl+m3Dn1+oBi97M+NWffdc
         ijsQ==
X-Gm-Message-State: ACgBeo1mKhxpBhLRlIZGeC/i0UIh/eOtxJKY8Ll6tRiqZnkIYUDQ+Hjd
        q1qTPMdthp1HE1h3E9LCnO/W9w==
X-Google-Smtp-Source: AA6agR4mKTbWNOxvNypUWCDM67c7OHImiNtBWKxHr0p0b+Nsifd/4YaR4BXj65tEQEZlybqS1+TBLQ==
X-Received: by 2002:a05:6000:1548:b0:223:141:8a06 with SMTP id 8-20020a056000154800b0022301418a06mr1694399wry.153.1660830411206;
        Thu, 18 Aug 2022 06:46:51 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d6785000000b0021e47fb24a2sm1454549wru.19.2022.08.18.06.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:46:50 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/6] ASoC: codecs: tx-macro: add support for sm8450 and sc8280xp
Date:   Thu, 18 Aug 2022 14:46:19 +0100
Message-Id: <20220818134619.3432-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220818134619.3432-1-srinivas.kandagatla@linaro.org>
References: <20220818134619.3432-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPASS VA Macro now has soundwire master to deal with access to
analog mic in low power island use cases.

This is added after sc8280xp, add support for this.
Along with this also add compatibles for sm8450 and sc8280xp.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-va-macro.c | 64 ++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index a35f684053d2..f8b0c8caa1db 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -25,6 +25,10 @@
 #define CDC_VA_FS_CONTROL_EN			BIT(0)
 #define CDC_VA_FS_COUNTER_CLR			BIT(1)
 #define CDC_VA_CLK_RST_CTRL_SWR_CONTROL		(0x0008)
+#define CDC_VA_SWR_RESET_MASK		BIT(1)
+#define CDC_VA_SWR_RESET_ENABLE		BIT(1)
+#define CDC_VA_SWR_CLK_EN_MASK		BIT(0)
+#define CDC_VA_SWR_CLK_ENABLE		BIT(0)
 #define CDC_VA_TOP_CSR_TOP_CFG0			(0x0080)
 #define CDC_VA_FS_BROADCAST_EN			BIT(1)
 #define CDC_VA_TOP_CSR_DMIC0_CTL		(0x0084)
@@ -66,6 +70,8 @@
 #define CDC_VA_TOP_CSR_SWR_MIC_CTL0		(0x00D0)
 #define CDC_VA_TOP_CSR_SWR_MIC_CTL1		(0x00D4)
 #define CDC_VA_TOP_CSR_SWR_MIC_CTL2		(0x00D8)
+#define CDC_VA_SWR_MIC_CLK_SEL_0_1_MASK		(0xEE)
+#define CDC_VA_SWR_MIC_CLK_SEL_0_1_DIV1		(0xCC)
 #define CDC_VA_TOP_CSR_SWR_CTRL			(0x00DC)
 #define CDC_VA_INP_MUX_ADC_MUX0_CFG0		(0x0100)
 #define CDC_VA_INP_MUX_ADC_MUX0_CFG1		(0x0104)
@@ -194,6 +200,8 @@ struct va_macro {
 	unsigned long active_ch_mask[VA_MACRO_MAX_DAIS];
 	unsigned long active_ch_cnt[VA_MACRO_MAX_DAIS];
 	u16 dmic_clk_div;
+	bool has_swr_master;
+	bool reset_swr;
 
 	int dec_mode[VA_MACRO_NUM_DECIMATORS];
 	struct regmap *regmap;
@@ -325,6 +333,9 @@ static bool va_is_rw_register(struct device *dev, unsigned int reg)
 	case CDC_VA_TOP_CSR_DMIC2_CTL:
 	case CDC_VA_TOP_CSR_DMIC3_CTL:
 	case CDC_VA_TOP_CSR_DMIC_CFG:
+	case CDC_VA_TOP_CSR_SWR_MIC_CTL0:
+	case CDC_VA_TOP_CSR_SWR_MIC_CTL1:
+	case CDC_VA_TOP_CSR_SWR_MIC_CTL2:
 	case CDC_VA_TOP_CSR_DEBUG_BUS:
 	case CDC_VA_TOP_CSR_DEBUG_EN:
 	case CDC_VA_TOP_CSR_TX_I2S_CTL:
@@ -1306,12 +1317,40 @@ static const struct snd_soc_component_driver va_macro_component_drv = {
 
 static int fsgen_gate_enable(struct clk_hw *hw)
 {
-	return va_macro_mclk_enable(to_va_macro(hw), true);
+	struct va_macro *va = to_va_macro(hw);
+	struct regmap *regmap = va->regmap;
+	int ret;
+
+	ret = va_macro_mclk_enable(va, true);
+	if (!va->has_swr_master)
+		return ret;
+
+	if (va->reset_swr)
+		regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
+				   CDC_VA_SWR_RESET_MASK,
+				   CDC_VA_SWR_RESET_ENABLE);
+
+	regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
+			   CDC_VA_SWR_CLK_EN_MASK,
+			   CDC_VA_SWR_CLK_ENABLE);
+	if (va->reset_swr)
+		regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
+				   CDC_VA_SWR_RESET_MASK, 0x0);
+	va->reset_swr = false;
+
+	return ret;
 }
 
 static void fsgen_gate_disable(struct clk_hw *hw)
 {
-	va_macro_mclk_enable(to_va_macro(hw), false);
+	struct va_macro *va = to_va_macro(hw);
+	struct regmap *regmap = va->regmap;
+
+	if (va->has_swr_master)
+		regmap_update_bits(regmap, CDC_VA_CLK_RST_CTRL_SWR_CONTROL,
+			   CDC_VA_SWR_CLK_EN_MASK, 0x0);
+
+	va_macro_mclk_enable(va, false);
 }
 
 static int fsgen_gate_is_enabled(struct clk_hw *hw)
@@ -1459,6 +1498,11 @@ static int va_macro_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, va);
 
+	if (of_device_is_compatible(dev->of_node, "qcom,sm8450-lpass-va-macro") ||
+		of_device_is_compatible(dev->of_node, "qcom,sc8280xp-lpass-va-macro")) {
+		va->has_swr_master = true;
+		va->reset_swr = true;
+	}
 	/* mclk rate */
 	clk_set_rate(va->mclk, 2 * VA_MACRO_MCLK_FREQ);
 
@@ -1484,6 +1528,20 @@ static int va_macro_probe(struct platform_device *pdev)
 		goto err_clkout;
 	}
 
+	if (va->has_swr_master) {
+		/* Set default CLK div to 1 */
+		regmap_update_bits(va->regmap, CDC_VA_TOP_CSR_SWR_MIC_CTL0,
+				  CDC_VA_SWR_MIC_CLK_SEL_0_1_MASK,
+				  CDC_VA_SWR_MIC_CLK_SEL_0_1_DIV1);
+		regmap_update_bits(va->regmap, CDC_VA_TOP_CSR_SWR_MIC_CTL1,
+				  CDC_VA_SWR_MIC_CLK_SEL_0_1_MASK,
+				  CDC_VA_SWR_MIC_CLK_SEL_0_1_DIV1);
+		regmap_update_bits(va->regmap, CDC_VA_TOP_CSR_SWR_MIC_CTL2,
+				  CDC_VA_SWR_MIC_CLK_SEL_0_1_MASK,
+				  CDC_VA_SWR_MIC_CLK_SEL_0_1_DIV1);
+
+	}
+
 	ret = devm_snd_soc_register_component(dev, &va_macro_component_drv,
 					      va_macro_dais,
 					      ARRAY_SIZE(va_macro_dais));
@@ -1560,6 +1618,8 @@ static const struct dev_pm_ops va_macro_pm_ops = {
 static const struct of_device_id va_macro_dt_match[] = {
 	{ .compatible = "qcom,sc7280-lpass-va-macro" },
 	{ .compatible = "qcom,sm8250-lpass-va-macro" },
+	{ .compatible = "qcom,sm8450-lpass-va-macro" },
+	{ .compatible = "qcom,sc8280xp-lpass-va-macro" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, va_macro_dt_match);
-- 
2.21.0

