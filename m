Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A6756B79B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiGHKm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbiGHKmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:42:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250C6814BE;
        Fri,  8 Jul 2022 03:42:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b26so30001677wrc.2;
        Fri, 08 Jul 2022 03:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HY2aQJ3seKosRomDmgMnHWVFcuzDBXXIFx3XPBOLqNA=;
        b=hTrtpZJlPsCTGIzPfH98dtPa0cJlHrZ7Oj9Epj9QNcgo4cHfJd37lkvyOgjgW+GJwt
         4/klkb9fTnlXYOuT9tGH3q30stF2AftY1kkNXyZCwDkjn8ZbRtCL/H53IBd+2epXo87S
         CBEXBHq8KUXU5OrTwpvple6RkcXZQjPXr0fc1QZ9whWRCFa9z4/WhElmzFfrwDrqbQ4z
         7MTunmzUq7VHZRsgQXq0CoyIJG+n/39Oa+z6yHioNw2VNmyny0jA4NHEf0lAds7U46rv
         ykdWTRNJWXPLMuObRWwd/Fb/c2v5yjJ6lOB9iZ6vgCp0mOZZe/UOWfO6ZYLp5rbOAygy
         g6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HY2aQJ3seKosRomDmgMnHWVFcuzDBXXIFx3XPBOLqNA=;
        b=ywbei/3IfifnsLlLC3PElZC+NUGKHDJzrXmJnNndn8VIFg2XWyNDzW8maunsOSp6VH
         XYsLRh0wRyVJZt1tQFmZOr4OauaEauubseNsM7DTbR3enTnETftkFyI+s0LcPj6t3Jt+
         r9Nvg1EIrKpxAOzh6LMx0qxKkiDa0+z8QM/UG3IwkyDuEq6/0Gt/5jCzeQvJbZ6S3JIn
         RyOQuEFbJ0h9c4BDgg0xSm35ZSzDvl3t6vZH68gwcoJBTnJPmx+qq4R3ImHfhiuXYCS/
         HyJL2M0QALitTCbkHowaPZASk3P8frZbowBMeLA0npft6yETaHukXq9EkZxuXgtncUZ3
         LADQ==
X-Gm-Message-State: AJIora/SWBZe11REpkWcmamqoLFmE+EV7SYRqt7veAZNpQnwmNiCNnir
        kWQv2969R/HEVrh8wyOlAqYn02Ab020=
X-Google-Smtp-Source: AGRyM1tfpTvfalGhFZsiu1vbL4GpE2n3KO9i2CJQkcDQNrenOpGthP7dzyRUrWJGCDoVSiW6LpirAg==
X-Received: by 2002:a5d:6e5c:0:b0:21d:7ba1:3601 with SMTP id j28-20020a5d6e5c000000b0021d7ba13601mr2741822wrz.554.1657276955770;
        Fri, 08 Jul 2022 03:42:35 -0700 (PDT)
Received: from localhost (92.40.203.220.threembb.co.uk. [92.40.203.220])
        by smtp.gmail.com with ESMTPSA id b6-20020adff906000000b0021d6a23fdf3sm13621400wrr.15.2022.07.08.03.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:42:35 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/11] ASoC: jz4740-i2s: Move component functions near the component driver
Date:   Fri,  8 Jul 2022 11:43:03 +0100
Message-Id: <20220708104304.51415-11-aidanmacdonald.0x0@gmail.com>
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

Move the component suspend/resume functions near the definition
of the component driver to emphasize that they're unrelated to
the DAI functions.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 72 +++++++++++++++++------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 70b9d28a40ce..5db73f12efcf 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -303,42 +303,6 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return ret;
 }
 
-static int jz4740_i2s_suspend(struct snd_soc_component *component)
-{
-	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
-
-	if (snd_soc_component_active(component)) {
-		regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
-		clk_disable_unprepare(i2s->clk_i2s);
-	}
-
-	clk_disable_unprepare(i2s->clk_aic);
-
-	return 0;
-}
-
-static int jz4740_i2s_resume(struct snd_soc_component *component)
-{
-	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
-	int ret;
-
-	ret = clk_prepare_enable(i2s->clk_aic);
-	if (ret)
-		return ret;
-
-	if (snd_soc_component_active(component)) {
-		ret = clk_prepare_enable(i2s->clk_i2s);
-		if (ret) {
-			clk_disable_unprepare(i2s->clk_aic);
-			return ret;
-		}
-
-		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
-	}
-
-	return 0;
-}
-
 static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
@@ -459,6 +423,42 @@ static const struct i2s_soc_info jz4780_i2s_soc_info = {
 	.pll_clk_name		= "pll half",
 };
 
+static int jz4740_i2s_suspend(struct snd_soc_component *component)
+{
+	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
+
+	if (snd_soc_component_active(component)) {
+		regmap_clear_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
+		clk_disable_unprepare(i2s->clk_i2s);
+	}
+
+	clk_disable_unprepare(i2s->clk_aic);
+
+	return 0;
+}
+
+static int jz4740_i2s_resume(struct snd_soc_component *component)
+{
+	struct jz4740_i2s *i2s = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	ret = clk_prepare_enable(i2s->clk_aic);
+	if (ret)
+		return ret;
+
+	if (snd_soc_component_active(component)) {
+		ret = clk_prepare_enable(i2s->clk_i2s);
+		if (ret) {
+			clk_disable_unprepare(i2s->clk_aic);
+			return ret;
+		}
+
+		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CONF, JZ_AIC_CONF_ENABLE);
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_component_driver jz4740_i2s_component = {
 	.name			= "jz4740-i2s",
 	.suspend		= jz4740_i2s_suspend,
-- 
2.35.1

