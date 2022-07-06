Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B3A5693F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiGFVMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiGFVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:12:47 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346AC1E3D3;
        Wed,  6 Jul 2022 14:12:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z41so20832768ede.1;
        Wed, 06 Jul 2022 14:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DN6Fsv+Lu9MqocMHv4nrKh0wp6xmDGgKWuFOSaOTbYc=;
        b=nKWSVJsMKxJtcEVRq6KtW3FUHn1hy1nHhFSSlrJMhsKiY/jJs2EdNFTtywICwkPYVa
         2Gz8szCC4piLVm9Ku7NuhkL+0xmOcjegRZ5AA5XOpqCGJXX2i3Rg2PW9ktDXkk6InWFc
         F6U+xWhTLHUdzeMXKBtT2/UB8jBxHDch84KmSDer+kKHuPvR1F7WkYaQgDzSe8oUys6j
         oUQ0h6ivgxDXrjTJ5mN4ARFsuaHkkCQOEK+Kl0//hldxSOitURxntAYx9bkp9bSnxMNv
         wxwq5x3O+VTOAMkfbjdGadO3VvPEnDm+Co+k0m+9Lo93ZLb3PeriJdTdDaa0Fi27DVRA
         JM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DN6Fsv+Lu9MqocMHv4nrKh0wp6xmDGgKWuFOSaOTbYc=;
        b=MwELeS0cQmQRU/GTMz49LKYgYkxFf9UMnCaeVTHjHRvA/zHN9V6Gl9c2vx0LV+TLo/
         Qm4d6J34oAEZKIZ4l1rgLGn3gDH7knH/f4676mQMLvUDJkA2zvZdu18ERXc9Nk+X70vY
         RGak4iclFuCxSuDMQc7lXc2KBY3hYnrR79g8lF0eSb4a0Di94C7G5B4Pc5TGhx0L7nvC
         xr4/kL50WS0Vuqv7/YSG7bf2xTzTlA94Vm/zknlY2Is9FHk8LuiMslLVMlfzh8ffhdDr
         HZi1/XLpI43vgBAh5YV6wnXoq25OQFjG+gvNhOCwboyLkOv/yE6CJqwY46V77k8F86mh
         +mtw==
X-Gm-Message-State: AJIora8cWFFnHOhOJc+SmTZQ7UY4MFN3Kc5a8b65ygR7PL10gxjQJBMA
        BW3tbm6jhZ0E3/OBhPSvoGA=
X-Google-Smtp-Source: AGRyM1sPulL/CKCCG6um3LrwoF/cFoiX6edDJB39+ovxzjSKJYX9/0C9sIn7FvIUF2cv/lo9vpLAWA==
X-Received: by 2002:a05:6402:190e:b0:435:c4cd:ec2 with SMTP id e14-20020a056402190e00b00435c4cd0ec2mr56563237edz.127.1657141963752;
        Wed, 06 Jul 2022 14:12:43 -0700 (PDT)
Received: from localhost (92.40.202.8.threembb.co.uk. [92.40.202.8])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b0043a2b8ab377sm8566561edb.88.2022.07.06.14.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:12:43 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] ASoC: jz4740-i2s: Simplify using regmap fields
Date:   Wed,  6 Jul 2022 22:13:23 +0100
Message-Id: <20220706211330.120198-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
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

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 100 ++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 28 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 66a901f56392..cbb89f724f64 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -91,12 +91,22 @@ enum jz47xx_i2s_version {
 struct i2s_soc_info {
 	enum jz47xx_i2s_version version;
 	struct snd_soc_dai_driver *dai;
+
+	struct reg_field field_rx_fifo_thresh;
+	struct reg_field field_tx_fifo_thresh;
+	struct reg_field field_i2sdiv_capture;
+	struct reg_field field_i2sdiv_playback;
 };
 
 struct jz4740_i2s {
 	struct resource *mem;
 	struct regmap *regmap;
 
+	struct regmap_field *field_rx_fifo_thresh;
+	struct regmap_field *field_tx_fifo_thresh;
+	struct regmap_field *field_i2sdiv_capture;
+	struct regmap_field *field_i2sdiv_playback;
+
 	struct clk *clk_aic;
 	struct clk *clk_i2s;
 
@@ -222,12 +232,12 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
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
 
@@ -250,23 +260,16 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
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
@@ -342,7 +345,6 @@ static int jz4740_i2s_resume(struct snd_soc_component *component)
 static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	uint32_t conf;
 	int ret;
 
 	ret = clk_prepare_enable(i2s->clk_aic);
@@ -352,22 +354,14 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
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
@@ -414,11 +408,19 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
 static const struct i2s_soc_info jz4740_i2s_soc_info = {
 	.version = JZ_I2S_JZ4740,
 	.dai = &jz4740_i2s_dai,
+	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 12, 15),
+	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
+	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 };
 
 static const struct i2s_soc_info jz4760_i2s_soc_info = {
 	.version = JZ_I2S_JZ4760,
 	.dai = &jz4740_i2s_dai,
+	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
+	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
+	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 };
 
 static struct snd_soc_dai_driver jz4770_i2s_dai = {
@@ -442,11 +444,19 @@ static struct snd_soc_dai_driver jz4770_i2s_dai = {
 static const struct i2s_soc_info jz4770_i2s_soc_info = {
 	.version = JZ_I2S_JZ4770,
 	.dai = &jz4770_i2s_dai,
+	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
+	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
+	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
+	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 };
 
 static const struct i2s_soc_info jz4780_i2s_soc_info = {
 	.version = JZ_I2S_JZ4780,
 	.dai = &jz4770_i2s_dai,
+	.field_rx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 24, 27),
+	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
+	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
+	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 };
 
 static const struct snd_soc_component_driver jz4740_i2s_component = {
@@ -465,6 +475,36 @@ static const struct of_device_id jz4740_of_matches[] = {
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
@@ -509,6 +549,10 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
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

