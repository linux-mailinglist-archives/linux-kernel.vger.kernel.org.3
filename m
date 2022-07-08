Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F38356B77E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237965AbiGHKms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237474AbiGHKmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:42:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C193804A9;
        Fri,  8 Jul 2022 03:42:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f2so24593662wrr.6;
        Fri, 08 Jul 2022 03:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rg4jRfiWMbzTLHtEYWUNXlGuNm181rxgiYhLfRcL2n4=;
        b=KkicO0u2riWbLdjNYzvFSTrCVNYwCu0SNCAyxMYI5MBgL2LZJ3dIf4y43RlBxUf70h
         /Z9JwLlonGTwxzdYvS8eQqsdMuZCWxty6hu08AQlZrxJYslrAuIQ1E6vmgUi9xa/YNem
         WM3Eyqyof9D4Jt5SLFilJ9GGIsvel0+NAl45DO92lYPigBG19lf1oJ2nKEAum17FtwHk
         UQqwYkd4YZkDheytch6fXMqLy0SfVfz7WVVWZCKeRUyf0szrY7lS4QPB5qfLRdHbv78Z
         CiEEjJxmlWzjngwfiZLZ8qm1f4h3iMlMqedUkZzidrDH/wRr/B4JwF0IzCT8HmxcKeII
         FNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rg4jRfiWMbzTLHtEYWUNXlGuNm181rxgiYhLfRcL2n4=;
        b=5ZQgiufFZT1zvUrDDtQr7wcFimatBYXRl1UCgBN1QCYOh1Nm0RKGo+YiP65L2XEQXx
         f0PZJShX45jvIh3QHj+qizidEEddwH0QU/j9Ggkj/rd8JQ/3BQepcB8rk7Y9wRq/ADIw
         ZphUfdZnNSykI5uh6P0YDmTEUytqQpAQaKGbWPxZRtmlpqW2bKpop0LgU8HgQ/JBUFde
         SJVTMR+g+vV4ypMit5JGU6st58XjUma9L+VNxK1s7mkvX6wlzVZCXaqKWmEaYKN0cJrM
         26MLZA+9QwVh7DdZ75Y/YG3WvlBPnEPWZqZ9s0yGoqJhx95IGaQnA8vj0nIIz2Ts8Ddw
         ermA==
X-Gm-Message-State: AJIora8sY0JcKKiqkLGRNrF9M1o0QsJLs6KFIQc5xzOz+OW4U5cStzfe
        QFr9E6xiO4CAxvX48arhSm0=
X-Google-Smtp-Source: AGRyM1vHc8hf16D5xkMwPgK+XGc4Vp0KdP7iXGd1mjRXQ1Z+X6xDYu1EU7/2T4NIHU2GPcgz1O9q5w==
X-Received: by 2002:a05:6000:80e:b0:21b:9fb8:1b65 with SMTP id bt14-20020a056000080e00b0021b9fb81b65mr2768594wrb.592.1657276950872;
        Fri, 08 Jul 2022 03:42:30 -0700 (PDT)
Received: from localhost (92.40.203.220.threembb.co.uk. [92.40.203.220])
        by smtp.gmail.com with ESMTPSA id p9-20020a5d68c9000000b0021d7122ab80sm10031028wrw.110.2022.07.08.03.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:42:30 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/11] ASoC: jz4740-i2s: Make the PLL clock name SoC-specific
Date:   Fri,  8 Jul 2022 11:43:00 +0100
Message-Id: <20220708104304.51415-8-aidanmacdonald.0x0@gmail.com>
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

