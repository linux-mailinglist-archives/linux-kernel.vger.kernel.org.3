Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8BF56951C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiGFWOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbiGFWOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:14:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E7B2AC61;
        Wed,  6 Jul 2022 15:14:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y8so15198353eda.3;
        Wed, 06 Jul 2022 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Ia2wIH1no59KtJ2reGsq0DQC1cw6bhWoil8Vrx3dno=;
        b=bMmS736J08Rp4iZr7BTlobNhnnhL1yPZz4ZFiHYtJY43PQrGUvUpSfBdji0Dvi60zg
         D07CJDm6NoBJuHyzYrhJFeaGxiKju6IWJUDUkJw++W1bTkKGY1iqNjBj5SFN8wpXBD8u
         NwCLaCMhgYYUg3Lj7C1Egn4MZCwsaPtDUC0L7D9SqR3Bvuukc07MZTVZGjSL5P8GYegk
         xQ8pARDhDyN7FLfhAOXU1EfQbunKeFwdGJgPuAyUIMwtaYk2bdJm7BIHCWBeN4Ol3ACS
         AbyLA6iSuK6FEh4KSLcMrYOTBAhp29lkvlcASs7hXOy4EBxXeVbsAZETEU0ncGMIdUHL
         LjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Ia2wIH1no59KtJ2reGsq0DQC1cw6bhWoil8Vrx3dno=;
        b=fBYjpT4Va5XKpaU+Mr4Nk1wbhwPANZAmDmqIAo8Jb5R/OosCO5j3G8s16fv9U9tirE
         mC9s5PcHFtiGC1KKKixQnZDRYFMwLlnz7cuIDMikGSGLS4Zukt+X+vXYqtgEFgQ3KdEJ
         KL4xxMBrGHKFlaT/lEsUdiDkbOre8O5lwukKrvOpKEsYyJhLKjq6z26nii9mkXTXmC9/
         TBmWnu7H6mRZTjz0PApc8eOwgrEJYTGsAt52Ymli4pGzkxYQ7HBfPDCyxx3AqrVWM5+O
         w/HCoJJw/ACsiY2fbGEP8EWJxRBqCwyBPbWjKGvbyzTcfaBe+2JTXeu95HA5i0Ejm4+l
         3eCg==
X-Gm-Message-State: AJIora+nkMlfamYxaY7GnU0JyeM1dMXCFN+rCPznRSLw4fvHqTdyYUfT
        qOc6B+i/wlUnpcmdUzY+Ezs=
X-Google-Smtp-Source: AGRyM1tZrTLYZ/EmPXwyt1uAfsnFX/8nX9BGIrJN20jZJsf+x8uPv6sX52ZVxdy15BKOJvBRNf5OgA==
X-Received: by 2002:a05:6402:43c4:b0:43a:6309:6c9b with SMTP id p4-20020a05640243c400b0043a63096c9bmr23530879edc.91.1657145672358;
        Wed, 06 Jul 2022 15:14:32 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id h18-20020aa7c952000000b0043a6fde6e7bsm6509469edt.19.2022.07.06.15.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:14:31 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v3 3/3] clk: qcom: lcc-ipq806x: convert to parent data
Date:   Thu,  7 Jul 2022 00:13:27 +0200
Message-Id: <20220706221327.14169-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706221327.14169-1-ansuelsmth@gmail.com>
References: <20220706221327.14169-1-ansuelsmth@gmail.com>
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
v3:
 - Inline pxo pll4 parent
 - Change .name from pxo to pxo_board

 drivers/clk/qcom/lcc-ipq806x.c | 77 ++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index ba90bebba597..66aaf0d0ef79 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -34,7 +34,9 @@ static struct clk_pll pll4 = {
 	.status_bit = 16,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll4",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = (const struct clk_parent_data*[]){
+			{ .fw_name = "pxo", .name = "pxo_board" },
+		}
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

