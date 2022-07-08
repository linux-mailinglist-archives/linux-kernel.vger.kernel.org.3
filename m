Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C848556BDC2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbiGHQEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbiGHQCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:02:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FBD7695C;
        Fri,  8 Jul 2022 09:02:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z12so21541784wrq.7;
        Fri, 08 Jul 2022 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rg4jRfiWMbzTLHtEYWUNXlGuNm181rxgiYhLfRcL2n4=;
        b=nBnzGJVnF8VfPc14Lp2+tlCpzGcrxDvhdocQ6Thabc7Aaq2qMXuR1wGvg9HCEN7hk3
         aFIb/h4i2HbqEET9ZJSXh4YCIbzazxCAPX30a7xk2RlCTZ3uXOz9CXRR4wWh+3OHaLop
         D1fcwJAtwpz2mzUCF2zmiWMcOp4hLLMs4730MQVXkm36Whjj4s6eXaEMwPCG10GMCMw6
         Og8HDeSXqC7tQZaXx1XCZt6hbbQyvMchIFJfOO9MlLg6HeHbEPO0c9CZLpoZpEzMXZpi
         8AUJtV1zxeFiobNlM2bdiNjX9BRHrStJ6Zy6sVRrzgpKdWda5hmW7evnO6sOAQmzRV9u
         jV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rg4jRfiWMbzTLHtEYWUNXlGuNm181rxgiYhLfRcL2n4=;
        b=nwzNND+V2y8zav36JAzB3y689KUf7SXid91BVpin8odZZJmDEqZj6M8dZ6f57szeq9
         6Lv3mGt9yO4lahAihustDkH8J7txVZOdvasS0bF3RQy6ByDKWc3lQRHda4IM6xCf1OU6
         uH5IsAcQW6hcH1OlR98526N8bxkBOqWh510yitAcU3LiSbgBgXW2wCjT/Jtmx0jjabJy
         WeOMqe/KYs0l2pvgoMs615cs2NIoWqZn5IqMr28py9SzBQIu81SUc8Gj2CxTx6ljbEgP
         oSkFi9MA23gpTcOLffX/ZYfLMy0re0R9Ch3H9vDBzG6elvrfo/NZh6lVZyK3SCGBW7JM
         LgKA==
X-Gm-Message-State: AJIora96jk+hXTYn7IkgO1pwXTrNQCLeHeP/x9KzTwqpsTGQKCY1vJB0
        sNM1FCScS1gelBllzHLWRO8=
X-Google-Smtp-Source: AGRyM1sCcUelm0/FngZamMpPaDw2OctQX3wTWsua5zS3txHup3WL01Xq8hlPY2i65HUJekLQfphAIw==
X-Received: by 2002:a05:6000:1848:b0:21d:8e3f:f8c0 with SMTP id c8-20020a056000184800b0021d8e3ff8c0mr4036901wri.158.1657296137581;
        Fri, 08 Jul 2022 09:02:17 -0700 (PDT)
Received: from localhost (92.40.203.144.threembb.co.uk. [92.40.203.144])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c511100b003a2de511598sm365729wms.12.2022.07.08.09.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:02:17 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/11] ASoC: jz4740-i2s: Make the PLL clock name SoC-specific
Date:   Fri,  8 Jul 2022 17:02:40 +0100
Message-Id: <20220708160244.21933-8-aidanmacdonald.0x0@gmail.com>
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

On some Ingenic SoCs, such as the X1000, there is a programmable
divider used to generate the I2S system clock from a PLL, rather
than a fixed PLL/2 clock. It doesn't make much sense to call the
clock "pll half" on those SoCs, so the clock name should really be
a SoC-dependent value.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 0dcc658b3784..a41398c24d0e 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -75,6 +75,8 @@ struct i2s_soc_info {
 	struct reg_field field_i2sdiv_capture;
 	struct reg_field field_i2sdiv_playback;
 
+	const char *pll_clk_name;
+
 	bool shared_fifo_flush;
 };
 
@@ -281,7 +283,7 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 		clk_set_parent(i2s->clk_i2s, parent);
 		break;
 	case JZ4740_I2S_CLKSRC_PLL:
-		parent = clk_get(NULL, "pll half");
+		parent = clk_get(NULL, i2s->soc_info->pll_clk_name);
 		if (IS_ERR(parent))
 			return PTR_ERR(parent);
 		clk_set_parent(i2s->clk_i2s, parent);
@@ -400,6 +402,7 @@ static const struct i2s_soc_info jz4740_i2s_soc_info = {
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
 	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.pll_clk_name		= "pll half",
 	.shared_fifo_flush	= true,
 };
 
@@ -409,6 +412,7 @@ static const struct i2s_soc_info jz4760_i2s_soc_info = {
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
 	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.pll_clk_name		= "pll half",
 };
 
 static struct snd_soc_dai_driver jz4770_i2s_dai = {
@@ -435,6 +439,7 @@ static const struct i2s_soc_info jz4770_i2s_soc_info = {
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
 	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
 	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.pll_clk_name		= "pll half",
 };
 
 static const struct i2s_soc_info jz4780_i2s_soc_info = {
@@ -443,6 +448,7 @@ static const struct i2s_soc_info jz4780_i2s_soc_info = {
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
 	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
 	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.pll_clk_name		= "pll half",
 };
 
 static const struct snd_soc_component_driver jz4740_i2s_component = {
-- 
2.35.1

