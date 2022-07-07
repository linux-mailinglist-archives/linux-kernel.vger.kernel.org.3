Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07F56AC22
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbiGGTrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiGGTrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:47:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A5559277;
        Thu,  7 Jul 2022 12:46:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r21so5417085eju.0;
        Thu, 07 Jul 2022 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3O9KA8l0ZyZWk4PrHMwkxFP5JEBmMEH3qlexm1SaGo=;
        b=HwLSwtkKtvR1JYRcZtIwcC4yQ+vua1ftIKD9bu7kpfEy4Cm3W8mblgbzmNPr73P/h/
         /4rPSpd9ODBgzWlhRj8NI6n+CqEoXlLf5JuCM6cu9k4JNYBDelbQyeT5aoJ/d+GkZM/4
         fvgXUgbJudUuxFavxVMK6/qk2tZDOkhN+WxmxgEPt4/sQ8GNYhxfTFQmnLuau0h73YKB
         CTqf2mABEU25rfu8arQIyQ+JFpWEjFYVntJJA6e7vE0AZ0nlrFHn4si5uXvNgtd+RxCS
         2pyvxrKFbyXqnzB/cg0rDl3FAPT4KU6JODXjBqljMnJ+8PeVHvfjCXht9gv4Pd9jUfgB
         0VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3O9KA8l0ZyZWk4PrHMwkxFP5JEBmMEH3qlexm1SaGo=;
        b=02OLcVJ6kPlraXU5cvF2tk19RWA66Rk/OGpIHrk3y0NsyOedsJOAsCIgL7icWrxC6P
         RBK+D58k+UvLsZWct8YwkcWwatEa18kAXlHxky99Qha4Hau/KaSoqAl58ef5sg38ycRa
         /TJu7CbwK8M1KgFlH/I9RivH2fwZPk+h5jwdh9XupqfEWvtKvo5Aoyne1++aEDeQ7haP
         TLhXra+FFuTRaUdZB+c/P2wa7nLMYVXkVBQT2bYhNNPDTMcebtoIHz8LqIu0z0mGih0p
         2W7d68jL+VlTQnfUUr+M+p+O1BZZBGPkMUugeBJNRsMF5ZhGyW7MDsNXevMBwU0Vi4et
         h3qQ==
X-Gm-Message-State: AJIora/bT3GSQrDvRukk9G0AxN0a0pm47AlNPqz/leEP5A1XKSBwVBlD
        gQr/x7P1TTyxX+WmBlYpU/Q=
X-Google-Smtp-Source: AGRyM1vlnCepxfEnkz/UpZMQDzyxm0F292miVG6p+EZfseDNlA70THgCrx3IUvfsU++monQQt7zpnw==
X-Received: by 2002:a17:907:1b03:b0:6ff:78d4:c140 with SMTP id mp3-20020a1709071b0300b006ff78d4c140mr48043015ejc.554.1657223216723;
        Thu, 07 Jul 2022 12:46:56 -0700 (PDT)
Received: from localhost (92.40.202.166.threembb.co.uk. [92.40.202.166])
        by smtp.gmail.com with ESMTPSA id g17-20020aa7c591000000b0043a4a5813d8sm10624117edq.2.2022.07.07.12.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:46:56 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] ASoC: jz4740-i2s: Refactor DAI probe/remove ops as component ops
Date:   Thu,  7 Jul 2022 20:46:55 +0100
Message-Id: <20220707194655.312892-12-aidanmacdonald.0x0@gmail.com>
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

Move most of the DAI probe/remove logic into component ops.
This makes things more consistent because the AIC clock is
now managed solely from the component side. And it makes it
easier to add codec switching support later on.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 53 +++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 5db73f12efcf..e39ba4911678 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -306,32 +306,10 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	int ret;
-
-	ret = clk_prepare_enable(i2s->clk_aic);
-	if (ret)
-		return ret;
 
 	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
 		&i2s->capture_dma_data);
 
-	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
-
-	regmap_write(i2s->regmap, JZ_REG_AIC_CONF,
-		     JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
-		     JZ_AIC_CONF_I2S | JZ_AIC_CONF_INTERNAL_CODEC);
-
-	regmap_field_write(i2s->field_rx_fifo_thresh, 7);
-	regmap_field_write(i2s->field_tx_fifo_thresh, 8);
-
-	return 0;
-}
-
-static int jz4740_i2s_dai_remove(struct snd_soc_dai *dai)
-{
-	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-
-	clk_disable_unprepare(i2s->clk_aic);
 	return 0;
 }
 
@@ -351,7 +329,6 @@ static const struct snd_soc_dai_ops jz4740_i2s_dai_ops = {
 
 static struct snd_soc_dai_driver jz4740_i2s_dai = {
 	.probe = jz4740_i2s_dai_probe,
-	.remove = jz4740_i2s_dai_remove,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
@@ -389,7 +366,6 @@ static const struct i2s_soc_info jz4760_i2s_soc_info = {
 
 static struct snd_soc_dai_driver jz4770_i2s_dai = {
 	.probe = jz4740_i2s_dai_probe,
-	.remove = jz4740_i2s_dai_remove,
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
@@ -459,8 +435,37 @@ static int jz4740_i2s_resume(struct snd_soc_component *component)
 	return 0;
 }
 
+static int jz4740_i2s_probe(struct snd_soc_component *component)
+{
+	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
+
+	ret = clk_prepare_enable(i2s->clk_aic);
+	if (ret)
+		return ret;
+
+	regmap_write(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
+
+	regmap_write(i2s->regmap, JZ_REG_AIC_CONF,
+		     JZ_AIC_CONF_OVERFLOW_PLAY_LAST |
+		     JZ_AIC_CONF_I2S | JZ_AIC_CONF_INTERNAL_CODEC);
+
+	regmap_field_write(i2s->field_rx_fifo_thresh, 7);
+	regmap_field_write(i2s->field_tx_fifo_thresh, 8);
+
+	return 0;
+}
+
+static void jz4740_i2s_remove(struct snd_soc_component *component)
+{
+	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
+
+	clk_disable_unprepare(i2s->clk_aic);
+}
+
 static const struct snd_soc_component_driver jz4740_i2s_component = {
 	.name			= "jz4740-i2s",
+	.probe			= jz4740_i2s_probe,
+	.remove			= jz4740_i2s_remove,
 	.suspend		= jz4740_i2s_suspend,
 	.resume			= jz4740_i2s_resume,
 	.legacy_dai_naming	= 1,
-- 
2.35.1

