Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D735E569F3F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiGGKNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiGGKNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:13:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3661CFF1;
        Thu,  7 Jul 2022 03:13:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y8so16755810eda.3;
        Thu, 07 Jul 2022 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iMZJTyLzHVlGJbjHHwMCbTzqcWe51RNsAkxUieZWJ7k=;
        b=VCmv0d/idVqsawSw4dNf5d4cG0+v2rlO5EjSeZ+YH70p7NLFR9qk1Haac7TZTyy5cL
         43pM5tnNFlL4x7fzQbZi4SXIelrYvz/HuQTkFsbtbgDvxYHH3+EPp38na0bnUU8J415J
         kfascdyDtgisfsEn7UH0U0Ryh6mCx2hlAGTXwy5movjtrpy5KyxmheLiOcAGEPpHYfKg
         inVARqNn4DJUxZAT5BCouPPQGoRbVW84oaJPQAoOULhoAeKxtaPeW1HeGT57nxMTofuB
         S+QGZrpQW6cdzr0ALDenkWVBoQT4qzaA361Aex08eAeoHwH7cm+u0gIwT46Il/4bM9gj
         3hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMZJTyLzHVlGJbjHHwMCbTzqcWe51RNsAkxUieZWJ7k=;
        b=Vuf+/3+F6nVvmiCIiB0RvRiA/9E+dyFmV0+lYJZc1/4yUe9Hy90Rd4o3Dwn20Sz0M/
         AdNqt7H994acaaa2lsCaxHm+ZKBXDXkn5P/ODfE8l1vm4lvr+ZU/GTioAL7mHBzwbs05
         et2Cku+lQOb5sL3X2cJ33m7DwfcM73Xy+lWQt7tmrXTzN5gbNakzNkXCc3RLMiVKbtws
         l5OJ4kLdDl4tIal0rYd/OvEVZen1sk/v/ES1t+iYTacrds8lAEf5Vr+YcdVmdhWskB++
         dybIhlCe4NYTLGdLn9GiolXEv0btK30GyhPY+pjHj/eZOEVbsmV5KwPikxcQXe492a4y
         wYig==
X-Gm-Message-State: AJIora8n0Fj4nYAgDjZAmWbF3pmQa9XsZNvHTseSfRiE+3RtPaflvLNn
        mTO1GgyoiGi5SoMBN6OqNWQ=
X-Google-Smtp-Source: AGRyM1sw0JAFEwAiQV7xSiDul0CqnEeHUwawcBNUdD4JRsjNVHXM3EDtYp5uVPB0LbB62B8i4MaDsw==
X-Received: by 2002:a05:6402:540c:b0:434:d965:f8a with SMTP id ev12-20020a056402540c00b00434d9650f8amr60896932edb.30.1657188814150;
        Thu, 07 Jul 2022 03:13:34 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id kv12-20020a17090778cc00b0072ac3f06615sm6235747ejc.133.2022.07.07.03.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:13:33 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 3/3] clk: qcom: lcc-ipq806x: convert to parent data
Date:   Thu,  7 Jul 2022 12:13:26 +0200
Message-Id: <20220707101326.30880-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707101326.30880-1-ansuelsmth@gmail.com>
References: <20220707101326.30880-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert lcc-ipq806x driver to parent_data API.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
v4:
- Fix compilation error
v3:
 - Inline pxo pll4 parent
 - Change .name from pxo to pxo_board

 drivers/clk/qcom/lcc-ipq806x.c | 77 ++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index ba90bebba597..52711ca59345 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -34,7 +34,9 @@ static struct clk_pll pll4 = {
 	.status_bit = 16,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll4",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = (const struct clk_parent_data*[]){
+			{ .fw_name = "pxo", .name = "pxo_board" },
+		},
 		.num_parents = 1,
 		.ops = &clk_pll_ops,
 	},
@@ -64,9 +66,9 @@ static const struct parent_map lcc_pxo_pll4_map[] = {
 	{ P_PLL4, 2 }
 };
 
-static const char * const lcc_pxo_pll4[] = {
-	"pxo",
-	"pll4_vote",
+static const struct clk_parent_data lcc_pxo_pll4[] = {
+	{ .fw_name = "pxo", .name = "pxo" },
+	{ .fw_name = "pll4_vote", .name = "pll4_vote" },
 };
 
 static struct freq_tbl clk_tbl_aif_mi2s[] = {
@@ -131,18 +133,14 @@ static struct clk_rcg mi2s_osr_src = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_osr_src",
-			.parent_names = lcc_pxo_pll4,
-			.num_parents = 2,
+			.parent_data = lcc_pxo_pll4,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
 
-static const char * const lcc_mi2s_parents[] = {
-	"mi2s_osr_src",
-};
-
 static struct clk_branch mi2s_osr_clk = {
 	.halt_reg = 0x50,
 	.halt_bit = 1,
@@ -152,7 +150,9 @@ static struct clk_branch mi2s_osr_clk = {
 		.enable_mask = BIT(17),
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_osr_clk",
-			.parent_names = lcc_mi2s_parents,
+			.parent_hws = (const struct clk_hw*[]){
+				&mi2s_osr_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -167,7 +167,9 @@ static struct clk_regmap_div mi2s_div_clk = {
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_div_clk",
-			.parent_names = lcc_mi2s_parents,
+			.parent_hws = (const struct clk_hw*[]){
+				&mi2s_osr_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_regmap_div_ops,
 		},
@@ -183,7 +185,9 @@ static struct clk_branch mi2s_bit_div_clk = {
 		.enable_mask = BIT(15),
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_bit_div_clk",
-			.parent_names = (const char *[]){ "mi2s_div_clk" },
+			.parent_hws = (const struct clk_hw*[]){
+				&mi2s_div_clk.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -191,6 +195,10 @@ static struct clk_branch mi2s_bit_div_clk = {
 	},
 };
 
+static const struct clk_parent_data lcc_mi2s_bit_div_codec_clk[] = {
+	{ .hw = &mi2s_bit_div_clk.clkr.hw, },
+	{ .fw_name = "mi2s_codec_clk", .name = "mi2s_codec_clk" },
+};
 
 static struct clk_regmap_mux mi2s_bit_clk = {
 	.reg = 0x48,
@@ -199,11 +207,8 @@ static struct clk_regmap_mux mi2s_bit_clk = {
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_bit_clk",
-			.parent_names = (const char *[]){
-				"mi2s_bit_div_clk",
-				"mi2s_codec_clk",
-			},
-			.num_parents = 2,
+			.parent_data = lcc_mi2s_bit_div_codec_clk,
+			.num_parents = ARRAY_SIZE(lcc_mi2s_bit_div_codec_clk),
 			.ops = &clk_regmap_mux_closest_ops,
 			.flags = CLK_SET_RATE_PARENT,
 		},
@@ -245,8 +250,8 @@ static struct clk_rcg pcm_src = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcm_src",
-			.parent_names = lcc_pxo_pll4,
-			.num_parents = 2,
+			.parent_data = lcc_pxo_pll4,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -262,7 +267,9 @@ static struct clk_branch pcm_clk_out = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcm_clk_out",
-			.parent_names = (const char *[]){ "pcm_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&pcm_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -270,6 +277,11 @@ static struct clk_branch pcm_clk_out = {
 	},
 };
 
+static const struct clk_parent_data lcc_pcm_clk_out_codec_clk[] = {
+	{ .hw = &pcm_clk_out.clkr.hw, },
+	{ .fw_name = "pcm_codec_clk", .name = "pcm_codec_clk" },
+};
+
 static struct clk_regmap_mux pcm_clk = {
 	.reg = 0x54,
 	.shift = 10,
@@ -277,11 +289,8 @@ static struct clk_regmap_mux pcm_clk = {
 	.clkr = {
 		.hw.init = &(struct clk_init_data){
 			.name = "pcm_clk",
-			.parent_names = (const char *[]){
-				"pcm_clk_out",
-				"pcm_codec_clk",
-			},
-			.num_parents = 2,
+			.parent_data = lcc_pcm_clk_out_codec_clk,
+			.num_parents = ARRAY_SIZE(lcc_pcm_clk_out_codec_clk),
 			.ops = &clk_regmap_mux_closest_ops,
 			.flags = CLK_SET_RATE_PARENT,
 		},
@@ -325,18 +334,14 @@ static struct clk_rcg spdif_src = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "spdif_src",
-			.parent_names = lcc_pxo_pll4,
-			.num_parents = 2,
+			.parent_data = lcc_pxo_pll4,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
 	},
 };
 
-static const char * const lcc_spdif_parents[] = {
-	"spdif_src",
-};
-
 static struct clk_branch spdif_clk = {
 	.halt_reg = 0xd4,
 	.halt_bit = 1,
@@ -346,7 +351,9 @@ static struct clk_branch spdif_clk = {
 		.enable_mask = BIT(12),
 		.hw.init = &(struct clk_init_data){
 			.name = "spdif_clk",
-			.parent_names = lcc_spdif_parents,
+			.parent_hws = (const struct clk_hw*[]){
+				&spdif_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -384,8 +391,8 @@ static struct clk_rcg ahbix_clk = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "ahbix",
-			.parent_names = lcc_pxo_pll4,
-			.num_parents = 2,
+			.parent_data = lcc_pxo_pll4,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_lcc_ops,
 		},
 	},
-- 
2.36.1

