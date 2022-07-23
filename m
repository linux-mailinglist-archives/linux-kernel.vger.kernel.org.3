Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7C57EFE2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbiGWO4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbiGWO4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:56:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C68812A8D;
        Sat, 23 Jul 2022 07:56:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m8so8890886edd.9;
        Sat, 23 Jul 2022 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BuuvdWXJhrjPPhNUbwdMly3ckuq+/euuqy+8CL69hCM=;
        b=EppRU8EIU8xG7ZKf+/ibUq2rPjfFowXLdzh42+x67p82Zp1JK6vmpHJtP8ZQ+r43E0
         5CRcCxYPMXL9i5waWcXvGEn34IIk26QlFFbhl/LRJlfOe6cHNULVfiN8k3aHY2w/shJJ
         q1/YVAiOxlfhE9lP4gOYEqD0VnCRU2KIg4ymXpSQfdZCJ1xW3VACAZcBvDQKwsF5L834
         A+/sHOxwMuZxUoaZR5QZjJfcIk2S4MRQjBYJUJZ8/St9QNqQh8m9xtl8C6VIQcxWOEaq
         LcTkrGRUNol+V40utpeQd/YkskOb+MbGg/d39+I6OOhlHNQ/kmoUa/qIJRZQDKMpoOnG
         dAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuuvdWXJhrjPPhNUbwdMly3ckuq+/euuqy+8CL69hCM=;
        b=c3o+55Lziajg7I1cFPnZAstsHpOGZsQytt0R1mAmQ6MNOm76FPY0SOZA90JiVXmTI1
         dY2F91s3fb3lYW+su7uuyX93GGZ7hVTVtDTrAIhGysEEKCOvLos+WGbT6SRryJ0vapNy
         bR21yLt8kLDXr1TL+OA38Rj4/3A79vNYpxEwaBzqNcuGQXBITAkj+jYy9WOx9NCzyObm
         QJdJBHI3lCRK7Rvk3rVO/Ny4Q+/ayJlpbm1q/HJYjapBQY/2o6bhrbocPlxVpwio7nUR
         0N1lZdqg09CmvyNh6wYcUhyPK7YvKK7FAFmsl1ZdGEX1+BgTjr6sFo/AfF7d4HJ5EuHw
         mYlg==
X-Gm-Message-State: AJIora++pnbBdQMuUShggFlOycO2OBmcWvf1Rwi6yBCdJRzQP0HMfVcp
        TxCj8XEVAB6k7De+iSz4Nn8=
X-Google-Smtp-Source: AGRyM1t9FNgP5Bk7gCelvwv4h6vic1dVH3UreaP/3AE/xmozomC3ujLB0cqyTUZrEGhb8GQ/AhPPIg==
X-Received: by 2002:a05:6402:1159:b0:43b:bc82:5ddb with SMTP id g25-20020a056402115900b0043bbc825ddbmr4610867edw.355.1658588164432;
        Sat, 23 Jul 2022 07:56:04 -0700 (PDT)
Received: from localhost.localdomain (host-87-7-207-127.retail.telecomitalia.it. [87.7.207.127])
        by smtp.googlemail.com with ESMTPSA id cy24-20020a0564021c9800b0043ba1ecb0dfsm4143781edb.75.2022.07.23.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 07:56:04 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v6 3/4] clk: qcom: lcc-ipq806x: convert to parent data
Date:   Sat, 23 Jul 2022 16:55:57 +0200
Message-Id: <20220723145558.25210-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220723145558.25210-1-ansuelsmth@gmail.com>
References: <20220723145558.25210-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert lcc-ipq806x driver to parent_data API.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
v6:
- Split to separate patch for ARRAY_SIZE
- Rename .name to pxo_board
- Drop _clk from .fw_name
v5:
- Fix the same compilation error (don't know what the hell happen
  to my buildroot)
v4:
- Fix compilation error
v3:
 - Inline pxo pll4 parent
 - Change .name from pxo to pxo_board

 drivers/clk/qcom/lcc-ipq806x.c | 69 +++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index ba90bebba597..1833e59a6434 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -34,7 +34,9 @@ static struct clk_pll pll4 = {
 	.status_bit = 16,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll4",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "pxo", .name = "pxo_board",
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
+	{ .fw_name = "pxo", .name = "pxo_board" },
+	{ .fw_name = "pll4_vote", .name = "pll4_vote" },
 };
 
 static struct freq_tbl clk_tbl_aif_mi2s[] = {
@@ -131,7 +133,7 @@ static struct clk_rcg mi2s_osr_src = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_osr_src",
-			.parent_names = lcc_pxo_pll4,
+			.parent_data = lcc_pxo_pll4,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -139,10 +141,6 @@ static struct clk_rcg mi2s_osr_src = {
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
+			.parent_hws = (const struct clk_hw*[]) {
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
+			.parent_hws = (const struct clk_hw*[]) {
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
+			.parent_hws = (const struct clk_hw*[]) {
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
+	{ .fw_name = "mi2s_codec", .name = "mi2s_codec_clk" },
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
@@ -245,7 +250,7 @@ static struct clk_rcg pcm_src = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcm_src",
-			.parent_names = lcc_pxo_pll4,
+			.parent_data = lcc_pxo_pll4,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -262,7 +267,9 @@ static struct clk_branch pcm_clk_out = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcm_clk_out",
-			.parent_names = (const char *[]){ "pcm_src" },
+			.parent_hws = (const struct clk_hw*[]) {
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
@@ -325,7 +334,7 @@ static struct clk_rcg spdif_src = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "spdif_src",
-			.parent_names = lcc_pxo_pll4,
+			.parent_data = lcc_pxo_pll4,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -333,10 +342,6 @@ static struct clk_rcg spdif_src = {
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
+			.parent_hws = (const struct clk_hw*[]) {
+				&spdif_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -384,7 +391,7 @@ static struct clk_rcg ahbix_clk = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "ahbix",
-			.parent_names = lcc_pxo_pll4,
+			.parent_data = lcc_pxo_pll4,
 			.num_parents = 2,
 			.ops = &clk_rcg_lcc_ops,
 		},
-- 
2.36.1

