Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3E569401
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiGFVNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiGFVM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:12:56 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E81825E8B;
        Wed,  6 Jul 2022 14:12:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e40so20803803eda.2;
        Wed, 06 Jul 2022 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMEBorNhVh7ufMst5Qk6uYNQl+nmEbNFWhKX6b10HnM=;
        b=jlTOXZ1wwHsirtfZGe/1GnuPbG2A8hDgcztcSgQslipPOpKTmWeHD074+ttc/thnxA
         KWQN95ivS/FHDQnxz5p/Bwpu4sOD4G342QW3RDsN/fcrWLyn9JWRsDH0qCdm7kPGREpu
         twP5krmt5onISnYkRBDZOAXw6AyORs5+QgCsVevuiJ6fIMjydQTfr8eXpTl1thNqRUfj
         J5O3eLOTyYzB2RfCAR/ajdA0I/3S1mqvMYEDWk2FUw2FlXK2bhmGeDjaT5bIqJobXD62
         NHgTV4Gy6tsOxqKmdsYcA2aWC27VnY6RJYdXEeXEKemh7M1i+rHdcp7ywdJSjTBZsvqM
         eigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMEBorNhVh7ufMst5Qk6uYNQl+nmEbNFWhKX6b10HnM=;
        b=TcyP4vR/Pv3zcBVz3nmadxSOvV6qWbVOwclsND9ZnI8iR2eM5oFnTrWjsRJUCkVQd8
         LpAjF674chORX+jAOhOhxi1asg3AgMvwbVuvB0MWUdPIBmcFpPqDrjzZleb2g7fa92zh
         9QDDhu9XeWEfA+O04j7crm8PRmijRmv5J+2YvaGnWMMU+RAQ0h/2HOeTNsf558FH5nKt
         +wq6w0LYTdrFbIJpKimH6EL8wtDhZmhTDcfhpaMbBoqik73T6SQUfdA5GZkXpPRjz8AM
         PZRCGwus+K/147pCGqQd3j3n6NBQ4anojzxEwJV0Xi9nXxrf/3IAsYkCQJN5G7A84irn
         RTvw==
X-Gm-Message-State: AJIora8QyIYHZfbo4h1xjracfyTGFrf611yA3NNDl/hGLAZc7JWbLujH
        hFYeVOv8CT04CWU/T8QpGM9z2lGCjbI=
X-Google-Smtp-Source: AGRyM1tET1A7JwSiL++MIHi1kHvIRcUofme2fPTEumpKBcRzjv3d3RnOJ+Ft7soDIOhRwsqP9tA4eA==
X-Received: by 2002:aa7:d8d6:0:b0:43a:2a05:d601 with SMTP id k22-20020aa7d8d6000000b0043a2a05d601mr27594107eds.96.1657141971986;
        Wed, 06 Jul 2022 14:12:51 -0700 (PDT)
Received: from localhost (92.40.202.8.threembb.co.uk. [92.40.202.8])
        by smtp.gmail.com with ESMTPSA id u5-20020a170906068500b00703671ebe65sm17742818ejb.198.2022.07.06.14.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:12:51 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] ASoC: jz4740-i2s: Make the PLL clock name SoC-specific
Date:   Wed,  6 Jul 2022 22:13:28 +0100
Message-Id: <20220706211330.120198-10-aidanmacdonald.0x0@gmail.com>
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
index 3a21ee9d34d1..80b355d715ce 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -71,6 +71,8 @@ struct i2s_soc_info {
 	struct reg_field field_tx_fifo_thresh;
 	struct reg_field field_i2sdiv_capture;
 	struct reg_field field_i2sdiv_playback;
+
+	const char *pll_clk_name;
 };
 
 struct jz4740_i2s {
@@ -265,7 +267,7 @@ static int jz4740_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 		clk_set_parent(i2s->clk_i2s, parent);
 		break;
 	case JZ4740_I2S_CLKSRC_PLL:
-		parent = clk_get(NULL, "pll half");
+		parent = clk_get(NULL, i2s->soc_info->pll_clk_name);
 		if (IS_ERR(parent))
 			return PTR_ERR(parent);
 		clk_set_parent(i2s->clk_i2s, parent);
@@ -387,6 +389,7 @@ static const struct i2s_soc_info jz4740_i2s_soc_info = {
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
 	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.pll_clk_name		= "pll half",
 };
 
 static const struct i2s_soc_info jz4760_i2s_soc_info = {
@@ -395,6 +398,7 @@ static const struct i2s_soc_info jz4760_i2s_soc_info = {
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
 	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.pll_clk_name		= "pll half",
 };
 
 static struct snd_soc_dai_driver jz4770_i2s_dai = {
@@ -421,6 +425,7 @@ static const struct i2s_soc_info jz4770_i2s_soc_info = {
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
 	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
 	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.pll_clk_name		= "pll half",
 };
 
 static const struct i2s_soc_info jz4780_i2s_soc_info = {
@@ -429,6 +434,7 @@ static const struct i2s_soc_info jz4780_i2s_soc_info = {
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 16, 20),
 	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 8, 11),
 	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.pll_clk_name		= "pll half",
 };
 
 static const struct snd_soc_component_driver jz4740_i2s_component = {
-- 
2.35.1

