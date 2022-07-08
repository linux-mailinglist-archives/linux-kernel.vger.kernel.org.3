Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADD856B792
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbiGHKmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbiGHKmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:42:25 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A95804A9;
        Fri,  8 Jul 2022 03:42:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d16so23645103wrv.10;
        Fri, 08 Jul 2022 03:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0mdd5cSa/TBxKXWevDn49tiFgg+XLtvko/YRF3UBtto=;
        b=e2n80bvlwMH4XPayGvWPLJoNFtAqbwrDsnZj930aZrx36tkwohNd6n62Cy+PZ1D8yH
         vFdskHvMmN4ldved48lhpxnoX2OwU+uD7HNe7d1MlO8396YtGzgh+xwb1mAYSSIy8Dzi
         mA5Qd83dHxXw50sJUgLgCRxLMHETrZIZDaLVdBkrUNL9y1IorXFj0OVyETW5jTTrBg2R
         jtvU/oyMSiDBXMLJHmT2MLa/1+oq66ejh3KS7IbVPyvn6B41dmjrQw4maeu7f0j3v9gk
         C1D83j04JmJrLJqwM5qU5dDMfzuOTDBkY+CGzFaL7wXoJoMGZ4vWDVefaOPI1HGN+yk4
         Dscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0mdd5cSa/TBxKXWevDn49tiFgg+XLtvko/YRF3UBtto=;
        b=VexWiprSIR2pZZmeV1GxqC/3cLW/ohdIc0B94mwJMqwCCsXp5GVj/8jlGVOHlKJRtu
         EzSg6sWl/p/S11cBz/tPqaDh/rAdLoiR8JpR/D4V0MW+jWtkDgjXe1n4AwoFPKU1nSia
         EyWf6jMiTOl4CuDwofDcM9d87ZlXay54ZkxM4Fr//Izav+UbGJdATAL3oQSSmNX4PNHk
         w7VCRkWiE2larWG/vZVLR4dUrrd+w36tMg1ONteDpib7fYvYV0LKjbI9D+W5rEI+qPAP
         k6cg9dcqsKrGhA8gnnS7AvDnpddllFvI6+jme+f5Wbrog+JcfQtOhdgHp+/4EJrtfdNY
         osRQ==
X-Gm-Message-State: AJIora+8EqTOcxHZFB/A1kJw84sp/wBX9+sCO9d5bAVS0s3Moa0N+hf8
        zzDtOCCiMCSQm/HxhBFxkio=
X-Google-Smtp-Source: AGRyM1sSmUx797esxo3IUTQbsfrrDUIkGSyTkBW2Q1EmoNoCeqbg1cXYsitqirOt2vKWk9DOC0+Q3Q==
X-Received: by 2002:a5d:6dab:0:b0:21d:8faf:5118 with SMTP id u11-20020a5d6dab000000b0021d8faf5118mr2643884wrs.360.1657276942406;
        Fri, 08 Jul 2022 03:42:22 -0700 (PDT)
Received: from localhost (92.40.203.220.threembb.co.uk. [92.40.203.220])
        by smtp.gmail.com with ESMTPSA id p10-20020a05600c23ca00b003a2c67aa6c0sm1985559wmb.23.2022.07.08.03.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:42:22 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/11] ASoC: jz4740-i2s: Convert to regmap API
Date:   Fri,  8 Jul 2022 11:42:55 +0100
Message-Id: <20220708104304.51415-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220708104304.51415-1-aidanmacdonald.0x0@gmail.com>
References: <20220708104304.51415-1-aidanmacdonald.0x0@gmail.com>
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
 sound/soc/jz4740/Kconfig      |  1 +
 sound/soc/jz4740/jz4740-i2s.c | 96 +++++++++++++----------------------
 2 files changed, 37 insertions(+), 60 deletions(-)

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
index c4c1e89b47c1..69ccec0f09d9 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include <linux/clk.h>
@@ -93,7 +94,7 @@ struct i2s_soc_info {
 };
 
 struct jz4740_i2s {
-	void __iomem *base;
+	struct regmap *regmap;
 
 	struct clk *clk_aic;
 	struct clk *clk_i2s;
@@ -104,40 +105,22 @@ struct jz4740_i2s {
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
 
 	if (snd_soc_dai_active(dai))
 		return 0;
 
-	ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
-	ctrl |= JZ_AIC_CTRL_FLUSH;
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
+	regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_FLUSH);
 
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
 
@@ -145,14 +128,11 @@ static void jz4740_i2s_shutdown(struct snd_pcm_substream *substream,
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
@@ -161,8 +141,6 @@ static int jz4740_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-
-	uint32_t ctrl;
 	uint32_t mask;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -170,38 +148,30 @@ static int jz4740_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
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
@@ -237,8 +207,8 @@ static int jz4740_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
-	jz4740_i2s_write(i2s, JZ_REG_AIC_I2S_FMT, format);
+	regmap_update_bits(i2s->regmap, JZ_REG_AIC_CONF, conf_mask, conf);
+	regmap_write(i2s->regmap, JZ_REG_AIC_I2S_FMT, format);
 
 	return 0;
 }
@@ -251,9 +221,9 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	uint32_t ctrl, div_reg;
 	int div;
 
-	ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
+	regmap_read(i2s->regmap, JZ_REG_AIC_CTRL, &ctrl);
+	regmap_read(i2s->regmap, JZ_REG_AIC_CLK_DIV, &div_reg);
 
-	div_reg = jz4740_i2s_read(i2s, JZ_REG_AIC_CLK_DIV);
 	div = clk_get_rate(i2s->clk_i2s) / (64 * params_rate(params));
 
 	switch (params_format(params)) {
@@ -290,8 +260,8 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CLK_DIV, div_reg);
+	regmap_write(i2s->regmap, JZ_REG_AIC_CTRL, ctrl);
+	regmap_write(i2s->regmap, JZ_REG_AIC_CLK_DIV, div_reg);
 
 	return 0;
 }
@@ -328,13 +298,9 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
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
 
@@ -346,7 +312,6 @@ static int jz4740_i2s_suspend(struct snd_soc_component *component)
 static int jz4740_i2s_resume(struct snd_soc_component *component)
 {
 	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
-	uint32_t conf;
 	int ret;
 
 	ret = clk_prepare_enable(i2s->clk_aic);
@@ -360,9 +325,7 @@ static int jz4740_i2s_resume(struct snd_soc_component *component)
 			return ret;
 		}
 
-		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
-		conf |= JZ_AIC_CONF_ENABLE;
-		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
 	}
 
 	return 0;
@@ -395,8 +358,8 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 			JZ_AIC_CONF_INTERNAL_CODEC;
 	}
 
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
+	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
+	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, conf);
 
 	return 0;
 }
@@ -494,11 +457,19 @@ static const struct of_device_id jz4740_of_matches[] = {
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
@@ -507,9 +478,9 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 
 	i2s->soc_info = device_get_match_data(dev);
 
-	i2s->base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
-	if (IS_ERR(i2s->base))
-		return PTR_ERR(i2s->base);
+	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
 
 	i2s->playback_dma_data.maxburst = 16;
 	i2s->playback_dma_data.addr = mem->start + JZ_REG_AIC_FIFO;
@@ -525,6 +496,11 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
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

