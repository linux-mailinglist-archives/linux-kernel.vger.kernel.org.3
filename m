Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2356AC23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiGGTqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbiGGTqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:46:46 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972322BB18;
        Thu,  7 Jul 2022 12:46:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o25so34227710ejm.3;
        Thu, 07 Jul 2022 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+czFW2+9KjCaFRnnRgA1Q38cQLtCpG3rkiwunQ6DhPY=;
        b=jL+4yzihTvL3npKTNuAB7hi1qRRuCiCkbA/ICsbp3bpn5DwXEwwV3j4UAgR/Nw9znM
         aBVgQ7MMsF46nhM74qCyOTCmo/sFHnf0L+CB11A16nEXtR4HO6FaqNBblBNJsDQqvVm8
         ioZeAp0IKH9jLW7z9U2rjtVt72knEwctsIo1MPY5qjTj/XlXuJvVUcBUTYaJIRhEZHih
         N6MSBBQHNnysM69OzonJ+AxGBXYqoehslUAzYUwaCn50+MCSC5R774ZMm5BwmtieSAUi
         YZzQDOuqFzOLS6x3foZdnrfPHomO7wDlD7q7upDWsFc72SY4auyLQ8lVl6WmXOsjGj94
         kKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+czFW2+9KjCaFRnnRgA1Q38cQLtCpG3rkiwunQ6DhPY=;
        b=isxwqMCrV0GcmFNS1Lj5aMcyanMUlLx88wIBmI0aBJ/zsKfbcpl3Uwh38k5GpT+o8P
         tR49Yfr4vcG1gJbo+wYhc2uktd6tI2X3dsNZrGwKMl0pMFpfcgg8BBjUdcGArBokREFJ
         OAsGrzRXFNP8AkXk/IIwTXSTG3Rd//JH6iWN2ecnooOnd2RMZUhC04Qpa3SvHbQ7g0SJ
         uyOghI/nbqM/UftEB3WyQTHX0i1XWF58ndVyuu7k+mvhwW2Smocmf3AeWuUYHiPnszX4
         i31W9O/q0eZ14J6ZHJaFdTwm4TM6iA7pPSRw/5P3Wfk78Mvks8Umy05GzFM4YLiRpqJW
         BBtw==
X-Gm-Message-State: AJIora8szazgQhWKmrX8f+JY4AEQfWWIqH5kW2GkRydQ0GVHaghz9Pa9
        EaQWDwzyTJCuR59Tdgas+xs=
X-Google-Smtp-Source: AGRyM1s3Uqo/61cjeb8JuAS+hxYmkzAC6E9YokjYUxTlW5q4VBt8ei7eHdsgODWbSbTHqgTr7CEZdw==
X-Received: by 2002:a17:906:58cf:b0:722:e4e1:c174 with SMTP id e15-20020a17090658cf00b00722e4e1c174mr46873018ejs.85.1657223204130;
        Thu, 07 Jul 2022 12:46:44 -0700 (PDT)
Received: from localhost (92.40.202.166.threembb.co.uk. [92.40.202.166])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906310300b0072a430d2abdsm11911026ejx.91.2022.07.07.12.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:46:43 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] ASoC: jz4740-i2s: Simplify using regmap fields
Date:   Thu,  7 Jul 2022 20:46:47 +0100
Message-Id: <20220707194655.312892-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220707194655.312892-1-aidanmacdonald.0x0@gmail.com>
References: <20220707194655.312892-1-aidanmacdonald.0x0@gmail.com>
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

The differences between register fields on different SoC versions
can be abstracted away using the regmap field API. This is easier
to understand and extend than comparisons based on the version ID.
Since the version IDs are unused after this change, remove them at
the same time, and remove unused macros.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 133 +++++++++++++++++++---------------
 1 file changed, 76 insertions(+), 57 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 69ccec0f09d9..bd73427b837e 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -34,8 +34,6 @@
 #define JZ_REG_AIC_CLK_DIV	0x30
 #define JZ_REG_AIC_FIFO		0x34
 
-#define JZ_AIC_CONF_FIFO_RX_THRESHOLD_MASK (0xf << 12)
-#define JZ_AIC_CONF_FIFO_TX_THRESHOLD_MASK (0xf <<  8)
 #define JZ_AIC_CONF_OVERFLOW_PLAY_LAST BIT(6)
 #define JZ_AIC_CONF_INTERNAL_CODEC BIT(5)
 #define JZ_AIC_CONF_I2S BIT(4)
@@ -44,11 +42,6 @@
 #define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
 #define JZ_AIC_CONF_ENABLE BIT(0)
 
-#define JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 12
-#define JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 8
-#define JZ4760_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 24
-#define JZ4760_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 16
-
 #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
 #define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
@@ -75,27 +68,23 @@
 
 #define JZ_AIC_I2S_STATUS_BUSY BIT(2)
 
-#define JZ_AIC_CLK_DIV_MASK 0xf
-#define I2SDIV_DV_SHIFT 0
-#define I2SDIV_DV_MASK (0xf << I2SDIV_DV_SHIFT)
-#define I2SDIV_IDV_SHIFT 8
-#define I2SDIV_IDV_MASK (0xf << I2SDIV_IDV_SHIFT)
-
-enum jz47xx_i2s_version {
-	JZ_I2S_JZ4740,
-	JZ_I2S_JZ4760,
-	JZ_I2S_JZ4770,
-	JZ_I2S_JZ4780,
-};
-
 struct i2s_soc_info {
-	enum jz47xx_i2s_version version;
 	struct snd_soc_dai_driver *dai;
+
+	struct reg_field field_rx_fifo_thresh;
+	struct reg_field field_tx_fifo_thresh;
+	struct reg_field field_i2sdiv_capture;
+	struct reg_field field_i2sdiv_playback;
 };
 
 struct jz4740_i2s {
 	struct regmap *regmap;
 
+	struct regmap_field *field_rx_fifo_thresh;
+	struct regmap_field *field_tx_fifo_thresh;
+	struct regmap_field *field_i2sdiv_capture;
+	struct regmap_field *field_i2sdiv_playback;
+
 	struct clk *clk_aic;
 	struct clk *clk_i2s;
 
@@ -217,12 +206,12 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+	struct regmap_field *div_field;
 	unsigned int sample_size;
-	uint32_t ctrl, div_reg;
+	uint32_t ctrl;
 	int div;
 
 	regmap_read(i2s->regmap, JZ_REG_AIC_CTRL, &ctrl);
-	regmap_read(i2s->regmap, JZ_REG_AIC_CLK_DIV, &div_reg);
 
 	div = clk_get_rate(i2s->clk_i2s) / (64 * params_rate(params));
 
@@ -245,23 +234,16 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 		else
 			ctrl &= ~JZ_AIC_CTRL_MONO_TO_STEREO;
 
-		div_reg &= ~I2SDIV_DV_MASK;
-		div_reg |= (div - 1) << I2SDIV_DV_SHIFT;
+		div_field = i2s->field_i2sdiv_playback;
 	} else {
 		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
 		ctrl |= sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
 
-		if (i2s->soc_info->version >= JZ_I2S_JZ4770) {
-			div_reg &= ~I2SDIV_IDV_MASK;
-			div_reg |= (div - 1) << I2SDIV_IDV_SHIFT;
-		} else {
-			div_reg &= ~I2SDIV_DV_MASK;
-			div_reg |= (div - 1) << I2SDIV_DV_SHIFT;
-		}
+		div_field = i2s->field_i2sdiv_capture;
 	}
 
 	regmap_write(i2s->regmap, JZ_REG_AIC_CTRL, ctrl);
-	regmap_write(i2s->regmap, JZ_REG_AIC_CLK_DIV, div_reg);
+	regmap_field_write(div_field, div - 1);
 
 	return 0;
 }
@@ -334,7 +316,6 @@ static int jz4740_i2s_resume(struct snd_soc_component *component)
 static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	uint32_t conf;
 	int ret;
 
 	ret = clk_prepare_enable(i2s->clk_aic);
@@ -344,22 +325,14 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
 		&i2s->capture_dma_data);
 
-	if (i2s->soc_info->version >= JZ_I2S_JZ4760) {
-		conf = (7 << JZ4760_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
-			(8 << JZ4760_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
-			JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
-			JZ_AIC_CONF_I2S |
-			JZ_AIC_CONF_INTERNAL_CODEC;
-	} else {
-		conf = (7 << JZ_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET) |
-			(8 << JZ_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET) |
-			JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
-			JZ_AIC_CONF_I2S |
-			JZ_AIC_CONF_INTERNAL_CODEC;
-	}
-
 	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
-	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, conf);
+
+	regmap_write(i2s->regmap, JZ_REG_AIC_CONF,
+		     JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
+		     JZ_AIC_CONF_I2S | JZ_AIC_CONF_INTERNAL_CODEC);
+
+	regmap_field_write(i2s->field_rx_fifo_thresh, 7);
+	regmap_field_write(i2s->field_tx_fifo_thresh, 8);
 
 	return 0;
 }
@@ -404,13 +377,19 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
 };
 
 static const struct i2s_soc_info jz4740_i2s_soc_info = {
-	.version = JZ_I2S_JZ4740,
-	.dai = &jz4740_i2s_dai,
+	.dai			= &jz4740_i2s_dai,
+	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 12, 15),
+	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
+	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 };
 
 static const struct i2s_soc_info jz4760_i2s_soc_info = {
-	.version = JZ_I2S_JZ4760,
-	.dai = &jz4740_i2s_dai,
+	.dai			= &jz4740_i2s_dai,
+	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
+	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
+	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 };
 
 static struct snd_soc_dai_driver jz4770_i2s_dai = {
@@ -432,13 +411,19 @@ static struct snd_soc_dai_driver jz4770_i2s_dai = {
 };
 
 static const struct i2s_soc_info jz4770_i2s_soc_info = {
-	.version = JZ_I2S_JZ4770,
-	.dai = &jz4770_i2s_dai,
+	.dai			= &jz4770_i2s_dai,
+	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
+	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
+	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
+	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 };
 
 static const struct i2s_soc_info jz4780_i2s_soc_info = {
-	.version = JZ_I2S_JZ4780,
-	.dai = &jz4770_i2s_dai,
+	.dai			= &jz4770_i2s_dai,
+	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
+	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
+	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
+	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 };
 
 static const struct snd_soc_component_driver jz4740_i2s_component = {
@@ -457,6 +442,36 @@ static const struct of_device_id jz4740_of_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, jz4740_of_matches);
 
+static int jz4740_i2s_init_regmap_fields(struct device *dev,
+					 struct jz4740_i2s *i2s)
+{
+	i2s->field_rx_fifo_thresh =
+		devm_regmap_field_alloc(dev, i2s->regmap,
+					i2s->soc_info->field_rx_fifo_thresh);
+	if (IS_ERR(i2s->field_rx_fifo_thresh))
+		return PTR_ERR(i2s->field_rx_fifo_thresh);
+
+	i2s->field_tx_fifo_thresh =
+		devm_regmap_field_alloc(dev, i2s->regmap,
+					i2s->soc_info->field_tx_fifo_thresh);
+	if (IS_ERR(i2s->field_tx_fifo_thresh))
+		return PTR_ERR(i2s->field_tx_fifo_thresh);
+
+	i2s->field_i2sdiv_capture =
+		devm_regmap_field_alloc(dev, i2s->regmap,
+					i2s->soc_info->field_i2sdiv_capture);
+	if (IS_ERR(i2s->field_i2sdiv_capture))
+		return PTR_ERR(i2s->field_i2sdiv_capture);
+
+	i2s->field_i2sdiv_playback =
+		devm_regmap_field_alloc(dev, i2s->regmap,
+					i2s->soc_info->field_i2sdiv_playback);
+	if (IS_ERR(i2s->field_i2sdiv_playback))
+		return PTR_ERR(i2s->field_i2sdiv_playback);
+
+	return 0;
+}
+
 static const struct regmap_config jz4740_i2s_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -501,6 +516,10 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 	if (IS_ERR(i2s->regmap))
 		return PTR_ERR(i2s->regmap);
 
+	ret = jz4740_i2s_init_regmap_fields(dev, i2s);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, i2s);
 
 	ret = devm_snd_soc_register_component(dev, &jz4740_i2s_component,
-- 
2.35.1

