Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F7B56BDA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbiGHQCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239007AbiGHQCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:02:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7047478B;
        Fri,  8 Jul 2022 09:02:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r14so25374177wrg.1;
        Fri, 08 Jul 2022 09:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HY2aQJ3seKosRomDmgMnHWVFcuzDBXXIFx3XPBOLqNA=;
        b=ePkWqh97Odk53ihOmkyCeBaBZDdkyf77ORSv02MRLn4rHr0kFiPcDG8gMrwdbHPppk
         7xcOHgMxJ7Yoko7rmhreGqvi9Sl+WWqAEcW+G/rLYYpa336Aveb3AJyQTVWeXs6xYpbZ
         YUlVGgSjCgzvizcU8eimplzQNh78DHbbUQ1rt9+bWtiG0jpMPJE04kEHFkePV/qOLJXa
         sfW1KMMQEwELaib2WFZu7rg4mp1bf7YeLUAEg010YsIXRy6bKNUfGTVYAAXY/bm6+qsF
         XVb+NDB3jIAzLIwy6z7ZBLR16kwI4NxumyGsXbePjfdr9z8NwTEg7GNLvJns6EqmgHOr
         6XrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HY2aQJ3seKosRomDmgMnHWVFcuzDBXXIFx3XPBOLqNA=;
        b=bqHjY4IUbCxZfZr643gLPSf+/WPyIHVUrw5vvh1CuC2FyZAeqnt7rYqb5KnXot/wh5
         hR5nfUHI2yVjoX+ceHcxTlG/LiRvsNe16p/bRLQHPNR6JXc9BwbnLJLVqHnRgnhTYE3M
         eaNtWIRmOTKTuCJ3NVUXqw8kB8uI2bLYlmRTDtxEcJ/bI+4UjA7a//O4CngdVY4gQCYP
         dTbNjjbIM4rQQ/lajj5LuwRmWV8rSZFsBaA6qpdApREZWoshQfVmulakhHiOUlrKspNk
         uuyiloPi2HfwMf57OHxszaOAeSD2kwhDVHesung3fhrrU4zQcJrEEBJMTT2iALtNHedO
         Ry9w==
X-Gm-Message-State: AJIora/f1eD2x54AznIoqgoQxLicRX7uAMvnyzQQsIbuojf73695ANxU
        2C/i9atB0sFUe2dLBeQB0z0=
X-Google-Smtp-Source: AGRyM1uYT/KN7zu8elM1TVXvlJK1a297NLgleg+X7aRkmunkQYCixoBZCa7hSLrtAv1+PZTR4g3O6w==
X-Received: by 2002:a05:6000:1887:b0:21d:33c1:efd6 with SMTP id a7-20020a056000188700b0021d33c1efd6mr4014091wri.134.1657296142965;
        Fri, 08 Jul 2022 09:02:22 -0700 (PDT)
Received: from localhost (92.40.203.144.threembb.co.uk. [92.40.203.144])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d44c4000000b0021d9207e6f1sm1331973wrr.34.2022.07.08.09.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:02:22 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/11] ASoC: jz4740-i2s: Move component functions near the component driver
Date:   Fri,  8 Jul 2022 17:02:43 +0100
Message-Id: <20220708160244.21933-11-aidanmacdonald.0x0@gmail.com>
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

