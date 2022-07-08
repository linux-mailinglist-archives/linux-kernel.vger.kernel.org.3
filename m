Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67EB56B790
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbiGHKnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237905AbiGHKmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:42:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC2804A9;
        Fri,  8 Jul 2022 03:42:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n10so4675953wrc.4;
        Fri, 08 Jul 2022 03:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BZiUZmT0tfqSNYrVDB3ZIcuUNgROO7bIhmSFmAv1IU0=;
        b=cVVnufSyP+POVZOskm1pJBfmF/GFxm3A8OWRvrqclBB1BXUi4HsFJIUJKw+Zdgc+Kp
         6rM6jbl2r1WlEJJFIj8iZc5tZKqK9hdx4mHOO5T4COGk9ghpmZNt4eODqNAaXzTmWWrI
         uBflOhaELq6gD5gtsFWTt3GiUSvw9MSHG14qyxrQkzNbUbMpdAugwDMdZzTwJssE2p+e
         YUnIqx6nPcDxoQTCn4eEenMCHS+ogCltt+/PruW+Zn6C8x7zrRKlXpDr4ad58QrAppkz
         e+zbJUxwUmZo2UXwLroM5Cj1ZAHtbjs2KLlOnV5ApRedEiLNrYCuxV4wL8uxGIW43jN6
         nUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZiUZmT0tfqSNYrVDB3ZIcuUNgROO7bIhmSFmAv1IU0=;
        b=37oY9SJHBaebuzUSdiFhodjA9pPqfw0iPGzpKlnZqzD8b521fzOZsSlIRNAKXV6cVA
         +vONu4/mCj9Ma6SQGWFFr+rZ4qCvYggAiyYTol2cJT5qf3fKe8S1ReHOhF1Erc0ss6SB
         P0NR0XvIo8I9qopSXUh9zi5mG+V0hApWcjJSOBMXXlUuJRvgqUOIbdTjQgYmY+Zw31I/
         xfQHC+Vm12OWbS4cv+tmHk8f0m6DE4xBCN8vJtU6jATVX8pdLfY8/6jeo2pQEMbq0e4y
         wrFaatfXbtLVwlVvfuhTvSz5A2XrjWevwlYuFclYsxIcqCqeYsLQ3RhW4m9MCVLuPwIX
         oq4w==
X-Gm-Message-State: AJIora/6FGsxUiPAilH4YQoYAO0PLiZegKvuVPITty2gkO0QDR11RhvH
        BDr6IVJ18XjyztzGzpaNFJE=
X-Google-Smtp-Source: AGRyM1vjB3JD2fsUC8TyPqfpdDivt12cwIFNLOuE597rwr2UlJMtWtEKp67JoVIEsWnoXg+ZW7lDQQ==
X-Received: by 2002:adf:f90c:0:b0:21a:3dcb:d106 with SMTP id b12-20020adff90c000000b0021a3dcbd106mr2651809wrr.448.1657276957303;
        Fri, 08 Jul 2022 03:42:37 -0700 (PDT)
Received: from localhost (92.40.203.220.threembb.co.uk. [92.40.203.220])
        by smtp.gmail.com with ESMTPSA id r129-20020a1c4487000000b003a0499df21asm1800403wma.25.2022.07.08.03.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:42:36 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] ASoC: jz4740-i2s: Refactor DAI probe/remove ops as component ops
Date:   Fri,  8 Jul 2022 11:43:04 +0100
Message-Id: <20220708104304.51415-12-aidanmacdonald.0x0@gmail.com>
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

Move most of the DAI probe/remove logic into component ops.
This makes things more consistent because the AIC clock is
now managed solely from the component side. And it makes it
easier to add codec switching support later on.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 54 +++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 5db73f12efcf..d99a19bc5166 100644
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
@@ -459,8 +435,38 @@ static int jz4740_i2s_resume(struct snd_soc_component *component)
 	return 0;
 }
 
+static int jz4740_i2s_probe(struct snd_soc_component *component)
+{
+	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
+	int ret;
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

