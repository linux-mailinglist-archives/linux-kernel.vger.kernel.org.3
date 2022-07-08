Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68F856BDEA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbiGHQCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbiGHQCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:02:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1716874DDA;
        Fri,  8 Jul 2022 09:02:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q9so31145826wrd.8;
        Fri, 08 Jul 2022 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rA03QvKE9ije3JAkiRACkxkuEqw4L+4JjOvYpl8NfrM=;
        b=bnoTyXnsLWJedY1wJMs6Tdn2sAMWhGfYT0Vz5eeBNg6b5ehkAowR1X9uwhYhBOYGwq
         E1E+Iyu3hhr/WV9QJrbFDrqaNccFEyUA3H1ejT+OGr+lMEbAA4HRjZgOd58yog2Ti9fr
         IVtsQmDEUmgnQGsl2LFFqOfYwLD5Wriax8xaP31LPAlioUqJIkLIDV9P0DuPHOIHRycB
         c4m2EYDTCAGf20X1e/R3bchcDPnC57WI4aRiAuIDmdVBo5iqWmde1toZcPhUPTAK5z/S
         O/ldFoFqdJy6Q6SQZFEoHrl8j0el47rSa7K2xfkfEz7/Xosr//BcP1m4PqFQddCrMcjs
         Lbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rA03QvKE9ije3JAkiRACkxkuEqw4L+4JjOvYpl8NfrM=;
        b=1r1Tvkn7K9K60bfm3bWxFD9sWwXrnJMlMA/gKaYVpVn8rhjcd0nFXxJ1atWiFSnQ2v
         826taxxkqEvRdGr2NxIBlxo1hWQtHL6K09m5aJEEfvuSThAVViH9U3QMTnGE0LmTgJ9h
         YtJA/5YrBE2tVKJCLaVvRi0hkcCBW0f7qm2wRUOrxSWgheuQcVo7mbUmBu3M0w4BLDuY
         /aOPaqLvfCmKKaeWB1WKJFUZ3nPIAOoAiOUJ9hjBEeUpAqNh+2HyvRBYIpZ1Ogw474Fo
         JgEmsbCzmp7zebDSM4IUByy9nQWvMk6xMNpxBpvZyrmg1wo8vmf9N+PABEyhYkLmChk0
         HGqw==
X-Gm-Message-State: AJIora9KLnEUB99CFTaRGj08h36d8xqsRpa2B0agBF760MGh7Akzjk0v
        dGPd4DYNebYmh65MVE4iqTmn2auRs6w=
X-Google-Smtp-Source: AGRyM1uWw2MdEV2fZPcfFsKiQSDlhfZp4Acxq8czhHSM6I32h9tgrF7DYEZU0k3n7ztdY8XQ55KXGA==
X-Received: by 2002:adf:e94c:0:b0:21d:81f4:7de2 with SMTP id m12-20020adfe94c000000b0021d81f47de2mr4178289wrn.338.1657296130588;
        Fri, 08 Jul 2022 09:02:10 -0700 (PDT)
Received: from localhost (92.40.203.144.threembb.co.uk. [92.40.203.144])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b0039c747a1e8fsm3298089wmp.7.2022.07.08.09.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:02:10 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/11] ASoC: jz4740-i2s: Convert to regmap API
Date:   Fri,  8 Jul 2022 17:02:36 +0100
Message-Id: <20220708160244.21933-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using regmap for accessing the AIC registers makes the driver a
little easier to read, and later refactors can take advantage of
regmap APIs to further simplify the driver.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/Kconfig      |   1 +
 sound/soc/jz4740/jz4740-i2s.c | 107 +++++++++++++---------------------
 2 files changed, 40 insertions(+), 68 deletions(-)

diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
index e72f826062e9..dd3b4507fbe6 100644
--- a/sound/soc/jz4740/Kconfig
+++ b/sound/soc/jz4740/Kconfig
@@ -3,6 +3,7 @@ config SND_JZ4740_SOC_I2S
 	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740 SoC"
 	depends on MIPS || COMPILE_TEST
 	depends on HAS_IOMEM
+	select REGMAP_MMIO
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y if you want to use I2S protocol and I2S codec on Ingenic JZ4740
diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index adf896333584..1393b383a886 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include <linux/clk.h>
@@ -98,7 +99,7 @@ struct i2s_soc_info {
 };
 
 struct jz4740_i2s {
-	void __iomem *base;
+	struct regmap *regmap;
 
 	struct clk *clk_aic;
 	struct clk *clk_i2s;
@@ -109,23 +110,10 @@ struct jz4740_i2s {
 	const struct i2s_soc_info *soc_info;
 };
 
-static inline uint32_t jz4740_i2s_read(const struct jz4740_i2s *i2s,
-	unsigned int reg)
-{
-	return readl(i2s->base + reg);
-}
-
-static inline void jz4740_i2s_write(const struct jz4740_i2s *i2s,
-	unsigned int reg, uint32_t value)
-{
-	writel(value, i2s->base + reg);
-}
-
 static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	uint32_t conf, ctrl;
 	int ret;
 
 	/*
@@ -133,14 +121,10 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	 * FIFO that is starting up.
 	 */
 	if (!i2s->soc_info->shared_fifo_flush) {
-		ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
-
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			ctrl |= JZ4760_AIC_CTRL_TFLUSH;
+			regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ4760_AIC_CTRL_TFLUSH);
 		else
-			ctrl |= JZ4760_AIC_CTRL_RFLUSH;
-
-		jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
+			regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ4760_AIC_CTRL_RFLUSH);
 	}
 
 	if (snd_soc_dai_active(dai))
@@ -150,20 +134,14 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	 * When there is a shared flush bit for both FIFOs we can
 	 * only flush the FIFOs if no other stream has started.
 	 */
-	if (i2s->soc_info->shared_fifo_flush) {
-		ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
-		ctrl |= JZ_AIC_CTRL_FLUSH;
-		jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
-	}
+	if (i2s->soc_info->shared_fifo_flush)
+		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_FLUSH);
 
 	ret = clk_prepare_enable(i2s->clk_i2s);
 	if (ret)
 		return ret;
 
-	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
-	conf |= JZ_AIC_CONF_ENABLE;
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
-
+	regmap_set_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
 	return 0;
 }
 
@@ -171,14 +149,11 @@ static void jz4740_i2s_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	uint32_t conf;
 
 	if (snd_soc_dai_active(dai))
 		return;
 
-	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
-	conf &= ~JZ_AIC_CONF_ENABLE;
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+	regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
 
 	clk_disable_unprepare(i2s->clk_i2s);
 }
@@ -187,8 +162,6 @@ static int jz4740_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-
-	uint32_t ctrl;
 	uint32_t mask;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -196,38 +169,30 @@ static int jz4740_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	else
 		mask = JZ_AIC_CTRL_ENABLE_CAPTURE | JZ_AIC_CTRL_ENABLE_RX_DMA;
 
-	ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		ctrl |= mask;
+		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, mask);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		ctrl &= ~mask;
+		regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CTRL, mask);
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
-
 	return 0;
 }
 
 static int jz4740_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-
-	uint32_t format = 0;
-	uint32_t conf;
-
-	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
-
-	conf &= ~(JZ_AIC_CONF_BIT_CLK_MASTER | JZ_AIC_CONF_SYNC_CLK_MASTER);
+	const unsigned int conf_mask = JZ_AIC_CONF_BIT_CLK_MASTER |
+				       JZ_AIC_CONF_SYNC_CLK_MASTER;
+	unsigned int conf = 0, format = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_BP_FP:
@@ -263,8 +228,8 @@ static int jz4740_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
-	jz4740_i2s_write(i2s, JZ_REG_AIC_I2S_FMT, format);
+	regmap_update_bits(i2s->regmap, JZ_REG_AIC_CONF, conf_mask, conf);
+	regmap_write(i2s->regmap, JZ_REG_AIC_I2S_FMT, format);
 
 	return 0;
 }
@@ -277,9 +242,9 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	uint32_t ctrl, div_reg;
 	int div;
 
-	ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
+	regmap_read(i2s->regmap, JZ_REG_AIC_CTRL, &ctrl);
+	regmap_read(i2s->regmap, JZ_REG_AIC_CLK_DIV, &div_reg);
 
-	div_reg = jz4740_i2s_read(i2s, JZ_REG_AIC_CLK_DIV);
 	div = clk_get_rate(i2s->clk_i2s) / (64 * params_rate(params));
 
 	switch (params_format(params)) {
@@ -316,8 +281,8 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CLK_DIV, div_reg);
+	regmap_write(i2s->regmap, JZ_REG_AIC_CTRL, ctrl);
+	regmap_write(i2s->regmap, JZ_REG_AIC_CLK_DIV, div_reg);
 
 	return 0;
 }
@@ -354,13 +319,9 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 static int jz4740_i2s_suspend(struct snd_soc_component *component)
 {
 	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
-	uint32_t conf;
 
 	if (snd_soc_component_active(component)) {
-		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
-		conf &= ~JZ_AIC_CONF_ENABLE;
-		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
-
+		regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
 		clk_disable_unprepare(i2s->clk_i2s);
 	}
 
@@ -372,7 +333,6 @@ static int jz4740_i2s_suspend(struct snd_soc_component *component)
 static int jz4740_i2s_resume(struct snd_soc_component *component)
 {
 	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
-	uint32_t conf;
 	int ret;
 
 	ret = clk_prepare_enable(i2s->clk_aic);
@@ -386,9 +346,7 @@ static int jz4740_i2s_resume(struct snd_soc_component *component)
 			return ret;
 		}
 
-		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
-		conf |= JZ_AIC_CONF_ENABLE;
-		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
 	}
 
 	return 0;
@@ -421,8 +379,8 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 			JZ_AIC_CONF_INTERNAL_CODEC;
 	}
 
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
+	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, conf);
 
 	return 0;
 }
@@ -521,11 +479,19 @@ static const struct of_device_id jz4740_of_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, jz4740_of_matches);
 
+static const struct regmap_config jz4740_i2s_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= JZ_REG_AIC_FIFO,
+};
+
 static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct jz4740_i2s *i2s;
 	struct resource *mem;
+	void __iomem *regs;
 	int ret;
 
 	i2s = devm_kzalloc(dev, sizeof(*i2s), GFP_KERNEL);
@@ -534,9 +500,9 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 
 	i2s->soc_info = device_get_match_data(dev);
 
-	i2s->base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
-	if (IS_ERR(i2s->base))
-		return PTR_ERR(i2s->base);
+	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	i2s->playback_dma_data.maxburst = 16;
 	i2s->playback_dma_data.addr = mem->start + JZ_REG_AIC_FIFO;
@@ -552,6 +518,11 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 	if (IS_ERR(i2s->clk_i2s))
 		return PTR_ERR(i2s->clk_i2s);
 
+	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
+					    &jz4740_i2s_regmap_config);
+	if (IS_ERR(i2s->regmap))
+		return PTR_ERR(i2s->regmap);
+
 	platform_set_drvdata(pdev, i2s);
 
 	ret = devm_snd_soc_register_component(dev, &jz4740_i2s_component,
-- 
2.35.1

