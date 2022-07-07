Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4319056AC20
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbiGGTrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236584AbiGGTq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:46:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B08C5926C;
        Thu,  7 Jul 2022 12:46:56 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id d2so34268062ejy.1;
        Thu, 07 Jul 2022 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HY2aQJ3seKosRomDmgMnHWVFcuzDBXXIFx3XPBOLqNA=;
        b=WJyzAI+UhCADxJhSCpFfMc6JP0QO5yqzG/wGBZtRpn9kH5VJLTu4tPA4BEw9SIyFky
         +kCT7l8pqt6jrOI3gb5H3XjwW4GMf5XlfqBA95zc6cDAGqsWYByNiV4AYHWNofl9XOJO
         tGCvVyO5IdKHC9/PBlBeAE0ZPbXdRLrm3BYQpA8iyqS4E7EInufMtUzSCm15on1mziEf
         JvwJzxuNZn2oKL5mT1yPYQAANMVw43YAwSSD+8i2LFEiGiInhZfp81est8FmvqXf79fD
         stf9FHEzh6sruZa/41S5RU6J6uzUS6pZtLjJj352zcXMOucnR4ZsYkxQqGkIYZM2u+Cs
         qm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HY2aQJ3seKosRomDmgMnHWVFcuzDBXXIFx3XPBOLqNA=;
        b=YjHPlSIQ4fQF0d/pnaaNmxuN7FgZRNT1C+hoLNYKgUo4MhrWmpSu29sPR0p5Vo4hSk
         SYjcYSkJO6f8OMwQbbT4UooOwGxEHgSPp9kRsKPCAln3Qz8WcYMu7xIBgKZ7Zu3qZIwq
         d45TG1qE41pFrqrw6HGK41e49ncxbwxtl4rEwgdiMTpMrrryob36IUjHptc8lxJNSS82
         KZC9oXALtUGyiVoUoUqQEInJFQuOxwqC1qMCOqK+gFyUz4f1SX5vC1MpXeonBJA1Drcs
         rJs5kvOwlROi7L8ED5Oyv/y3pFW8ZVdvAsvCE5VxZrTwXyg2E7wnA0RJKjxVLFAzSn50
         Vm1Q==
X-Gm-Message-State: AJIora9vj0UWmC2uIqxY+IeZOQlNnIydT/WjTTz2Ck/9r7mqT6G9rlI/
        dyQHiZEGKJRkZknmaXH4H+Y=
X-Google-Smtp-Source: AGRyM1tUzrKvbxi+tK5EGLPnSQdDaVYBSDyNJGRicwUovzw7kcQNq25KFOZRTkp/LJ+afkG0aZQikA==
X-Received: by 2002:a17:906:3589:b0:723:fe13:e981 with SMTP id o9-20020a170906358900b00723fe13e981mr45344059ejb.446.1657223215230;
        Thu, 07 Jul 2022 12:46:55 -0700 (PDT)
Received: from localhost (92.40.202.166.threembb.co.uk. [92.40.202.166])
        by smtp.gmail.com with ESMTPSA id k12-20020a17090666cc00b007041e969a8asm19400140ejp.97.2022.07.07.12.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:46:54 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] ASoC: jz4740-i2s: Move component functions near the component driver
Date:   Thu,  7 Jul 2022 20:46:54 +0100
Message-Id: <20220707194655.312892-11-aidanmacdonald.0x0@gmail.com>
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

