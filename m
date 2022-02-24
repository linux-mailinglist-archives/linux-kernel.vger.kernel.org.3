Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2C84C31F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiBXQtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiBXQtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C8A1B2AC5;
        Thu, 24 Feb 2022 08:48:46 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n13-20020a05600c3b8d00b0037bff8a24ebso158869wms.4;
        Thu, 24 Feb 2022 08:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4U617hSzU8yGdRXo/Lf34zzRzfzIpW/PZpa5LIw7RNA=;
        b=Gucby27qk9InuvsYqGAc5VviQ86Bg/98eLgVt1W4sStbh/bbbBydUE5qg7tfaZJ0dS
         IMqYOiGpY52J6NW28PETbCLYxIU7aEctVcUgarR+yuXTvxy3TliQhbeyHaINdoF2z/SY
         +0J1PE+gkehTJwLn3bynmp2tk7BPUehwZO3uEgvN8Lref+CzCePiuRqY33TzdQi3Vnw/
         ln8g518bHeATFvE+nD0zhKKB68IKLoEQjt+kk/L/PG4eOteVAOIVt1ml9ciZ0ozaEF4k
         2rttyNRhsZ1HtGXtz00z1jfX8NZPbLW0EAFO+9eD8RStwGw9zbwkMjcdwvPJphAt6dE8
         bZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4U617hSzU8yGdRXo/Lf34zzRzfzIpW/PZpa5LIw7RNA=;
        b=6bCn3kafjnyA4T91vg0ZaDLT4hHMQUDfEcCgtjyIGCoiKTAXNrhMjC8R0Dk4m/M2B2
         obCV4FDMPoqM5dtGAEOaQohZ2J13GnAEeJGYmepZ9Jj/mHpS1NXMgdh7+MUdqLyHroED
         AsdzhWfYf6jL+3O96zTLOtg91MbWDuJW8Dk7O+TtluNpX78HYT4XcPV9kuAEVT0yYSpQ
         Ps2fwJfkE6AA1vzu+XeV9Wc81ryctHKcQclLXtmfUSw4Tx+b4v37vrtEFGWrRFsPYq7K
         Zg8r/z+XzjrtmVQQUNbN/ohri1Y14xna0IelbmdMg/onOOhW5Kew7/9bFeiiksmfEq8B
         f+7A==
X-Gm-Message-State: AOAM533DDvMcCIQ2CDo8x7fX0SaaQ9zFnnESRgGrhZCN9mgkWaMX6IaH
        AG4OcdLpA/LXSxXMU3sPfaA=
X-Google-Smtp-Source: ABdhPJwYZtlsEgv6ZwVscUVrjDdDG47tKcNhLLeK7SqEIChvb8HcZh7rwP7X0XXAisdNpK8vB1jNow==
X-Received: by 2002:a05:600c:384b:b0:380:e437:2817 with SMTP id s11-20020a05600c384b00b00380e4372817mr3041789wmr.53.1645721324396;
        Thu, 24 Feb 2022 08:48:44 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:48:43 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/15] clk: qcom: gcc-ipq806x: convert parent_names to parent_data
Date:   Thu, 24 Feb 2022 17:48:21 +0100
Message-Id: <20220224164831.21475-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224164831.21475-1-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
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

Convert parent_names to parent_data to modernize the driver.
Where possible use parent_hws directly.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 293 ++++++++++++++++++++-------------
 1 file changed, 180 insertions(+), 113 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 34cddf461dba..f18888454b4f 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -25,6 +25,11 @@
 #include "clk-hfpll.h"
 #include "reset.h"
 
+static const struct clk_parent_data gcc_pxo[] = {
+	{ .fw_name = "pxo" },
+	{ .name = "pxo" },
+};
+
 static struct clk_pll pll0 = {
 	.l_reg = 0x30c4,
 	.m_reg = 0x30c8,
@@ -35,7 +40,7 @@ static struct clk_pll pll0 = {
 	.status_bit = 16,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll0",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.ops = &clk_pll_ops,
 	},
@@ -46,7 +51,9 @@ static struct clk_regmap pll0_vote = {
 	.enable_mask = BIT(0),
 	.hw.init = &(struct clk_init_data){
 		.name = "pll0_vote",
-		.parent_names = (const char *[]){ "pll0" },
+		.parent_hws = (const struct clk_hw*[]){
+			&pll0.clkr.hw,
+		},
 		.num_parents = 1,
 		.ops = &clk_pll_vote_ops,
 	},
@@ -62,7 +69,7 @@ static struct clk_pll pll3 = {
 	.status_bit = 16,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll3",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.ops = &clk_pll_ops,
 	},
@@ -89,7 +96,7 @@ static struct clk_pll pll8 = {
 	.status_bit = 16,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll8",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.ops = &clk_pll_ops,
 	},
@@ -100,7 +107,9 @@ static struct clk_regmap pll8_vote = {
 	.enable_mask = BIT(8),
 	.hw.init = &(struct clk_init_data){
 		.name = "pll8_vote",
-		.parent_names = (const char *[]){ "pll8" },
+		.parent_hws = (const struct clk_hw*[]){
+			&pll8.clkr.hw,
+		},
 		.num_parents = 1,
 		.ops = &clk_pll_vote_ops,
 	},
@@ -123,7 +132,7 @@ static struct hfpll_data hfpll0_data = {
 static struct clk_hfpll hfpll0 = {
 	.d = &hfpll0_data,
 	.clkr.hw.init = &(struct clk_init_data){
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.name = "hfpll0",
 		.ops = &clk_ops_hfpll,
@@ -149,7 +158,7 @@ static struct hfpll_data hfpll1_data = {
 static struct clk_hfpll hfpll1 = {
 	.d = &hfpll1_data,
 	.clkr.hw.init = &(struct clk_init_data){
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.name = "hfpll1",
 		.ops = &clk_ops_hfpll,
@@ -175,7 +184,7 @@ static struct hfpll_data hfpll_l2_data = {
 static struct clk_hfpll hfpll_l2 = {
 	.d = &hfpll_l2_data,
 	.clkr.hw.init = &(struct clk_init_data){
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.name = "hfpll_l2",
 		.ops = &clk_ops_hfpll,
@@ -194,7 +203,7 @@ static struct clk_pll pll14 = {
 	.status_bit = 16,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll14",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.ops = &clk_pll_ops,
 	},
@@ -205,7 +214,9 @@ static struct clk_regmap pll14_vote = {
 	.enable_mask = BIT(14),
 	.hw.init = &(struct clk_init_data){
 		.name = "pll14_vote",
-		.parent_names = (const char *[]){ "pll14" },
+		.parent_hws = (const struct clk_hw*[]){
+			&pll14.clkr.hw,
+		},
 		.num_parents = 1,
 		.ops = &clk_pll_vote_ops,
 	},
@@ -238,7 +249,7 @@ static struct clk_pll pll18 = {
 	.freq_tbl = pll18_freq_tbl,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll18",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.ops = &clk_pll_ops,
 	},
@@ -259,9 +270,10 @@ static const struct parent_map gcc_pxo_pll8_map[] = {
 	{ P_PLL8, 3 }
 };
 
-static const char * const gcc_pxo_pll8[] = {
-	"pxo",
-	"pll8_vote",
+static const struct clk_parent_data gcc_pxo_pll8[] = {
+	{ .fw_name = "pxo" },
+	{ .name = "pxo" },
+	{ .hw = &pll8_vote.hw },
 };
 
 static const struct parent_map gcc_pxo_pll8_cxo_map[] = {
@@ -270,10 +282,12 @@ static const struct parent_map gcc_pxo_pll8_cxo_map[] = {
 	{ P_CXO, 5 }
 };
 
-static const char * const gcc_pxo_pll8_cxo[] = {
-	"pxo",
-	"pll8_vote",
-	"cxo",
+static const struct clk_parent_data gcc_pxo_pll8_cxo[] = {
+	{ .fw_name = "pxo" },
+	{ .name = "pxo" },
+	{ .hw = &pll8_vote.hw },
+	{ .fw_name = "cxo" },
+	{ .name = "cxo" },
 };
 
 static const struct parent_map gcc_pxo_pll3_map[] = {
@@ -286,9 +300,10 @@ static const struct parent_map gcc_pxo_pll3_sata_map[] = {
 	{ P_PLL3, 6 }
 };
 
-static const char * const gcc_pxo_pll3[] = {
-	"pxo",
-	"pll3",
+static const struct clk_parent_data gcc_pxo_pll3[] = {
+	{ .fw_name = "pxo" },
+	{ .name = "pxo" },
+	{ .hw = &pll3.clkr.hw },
 };
 
 static const struct parent_map gcc_pxo_pll8_pll0_map[] = {
@@ -297,10 +312,11 @@ static const struct parent_map gcc_pxo_pll8_pll0_map[] = {
 	{ P_PLL0, 2 }
 };
 
-static const char * const gcc_pxo_pll8_pll0[] = {
-	"pxo",
-	"pll8_vote",
-	"pll0_vote",
+static const struct clk_parent_data gcc_pxo_pll8_pll0[] = {
+	{ .fw_name = "pxo" },
+	{ .name = "pxo" },
+	{ .hw = &pll8_vote.hw },
+	{ .hw = &pll0_vote.hw },
 };
 
 static const struct parent_map gcc_pxo_pll8_pll14_pll18_pll0_map[] = {
@@ -311,12 +327,13 @@ static const struct parent_map gcc_pxo_pll8_pll14_pll18_pll0_map[] = {
 	{ P_PLL18, 1 }
 };
 
-static const char * const gcc_pxo_pll8_pll14_pll18_pll0[] = {
-	"pxo",
-	"pll8_vote",
-	"pll0_vote",
-	"pll14",
-	"pll18",
+static const struct clk_parent_data gcc_pxo_pll8_pll14_pll18_pll0[] = {
+	{ .fw_name = "pxo" },
+	{ .name = "pxo" },
+	{ .hw = &pll8_vote.hw },
+	{ .hw = &pll0_vote.hw },
+	{ .hw = &pll14.clkr.hw },
+	{ .hw = &pll18.clkr.hw },
 };
 
 static struct freq_tbl clk_tbl_gsbi_uart[] = {
@@ -362,7 +379,7 @@ static struct clk_rcg gsbi1_uart_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_uart_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -378,8 +395,8 @@ static struct clk_branch gsbi1_uart_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_uart_clk",
-			.parent_names = (const char *[]){
-				"gsbi1_uart_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi1_uart_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -413,7 +430,7 @@ static struct clk_rcg gsbi2_uart_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_uart_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -429,8 +446,8 @@ static struct clk_branch gsbi2_uart_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_uart_clk",
-			.parent_names = (const char *[]){
-				"gsbi2_uart_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi2_uart_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -464,7 +481,7 @@ static struct clk_rcg gsbi4_uart_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_uart_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -480,8 +497,8 @@ static struct clk_branch gsbi4_uart_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_uart_clk",
-			.parent_names = (const char *[]){
-				"gsbi4_uart_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi4_uart_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -515,7 +532,7 @@ static struct clk_rcg gsbi5_uart_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_uart_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -531,8 +548,8 @@ static struct clk_branch gsbi5_uart_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_uart_clk",
-			.parent_names = (const char *[]){
-				"gsbi5_uart_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi5_uart_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -566,7 +583,7 @@ static struct clk_rcg gsbi6_uart_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_uart_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -582,8 +599,8 @@ static struct clk_branch gsbi6_uart_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_uart_clk",
-			.parent_names = (const char *[]){
-				"gsbi6_uart_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi6_uart_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -617,7 +634,7 @@ static struct clk_rcg gsbi7_uart_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_uart_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -633,8 +650,8 @@ static struct clk_branch gsbi7_uart_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_uart_clk",
-			.parent_names = (const char *[]){
-				"gsbi7_uart_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi7_uart_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -681,7 +698,7 @@ static struct clk_rcg gsbi1_qup_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_qup_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -697,7 +714,9 @@ static struct clk_branch gsbi1_qup_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_qup_clk",
-			.parent_names = (const char *[]){ "gsbi1_qup_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi1_qup_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -730,7 +749,7 @@ static struct clk_rcg gsbi2_qup_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_qup_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -746,7 +765,9 @@ static struct clk_branch gsbi2_qup_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_qup_clk",
-			.parent_names = (const char *[]){ "gsbi2_qup_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi2_qup_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -779,7 +800,7 @@ static struct clk_rcg gsbi4_qup_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_qup_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -795,7 +816,9 @@ static struct clk_branch gsbi4_qup_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_qup_clk",
-			.parent_names = (const char *[]){ "gsbi4_qup_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi4_qup_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -828,7 +851,7 @@ static struct clk_rcg gsbi5_qup_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_qup_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -844,7 +867,9 @@ static struct clk_branch gsbi5_qup_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_qup_clk",
-			.parent_names = (const char *[]){ "gsbi5_qup_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi5_qup_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -877,7 +902,7 @@ static struct clk_rcg gsbi6_qup_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_qup_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -893,7 +918,9 @@ static struct clk_branch gsbi6_qup_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_qup_clk",
-			.parent_names = (const char *[]){ "gsbi6_qup_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi6_qup_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -926,7 +953,7 @@ static struct clk_rcg gsbi7_qup_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_qup_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -942,7 +969,9 @@ static struct clk_branch gsbi7_qup_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_qup_clk",
-			.parent_names = (const char *[]){ "gsbi7_qup_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi7_qup_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1076,7 +1105,7 @@ static struct clk_rcg gp0_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gp0_src",
-			.parent_names = gcc_pxo_pll8_cxo,
+			.parent_data = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -1092,7 +1121,9 @@ static struct clk_branch gp0_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gp0_clk",
-			.parent_names = (const char *[]){ "gp0_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&gp0_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1125,7 +1156,7 @@ static struct clk_rcg gp1_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gp1_src",
-			.parent_names = gcc_pxo_pll8_cxo,
+			.parent_data = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -1141,7 +1172,9 @@ static struct clk_branch gp1_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gp1_clk",
-			.parent_names = (const char *[]){ "gp1_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&gp1_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1174,7 +1207,7 @@ static struct clk_rcg gp2_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gp2_src",
-			.parent_names = gcc_pxo_pll8_cxo,
+			.parent_data = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -1190,7 +1223,9 @@ static struct clk_branch gp2_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gp2_clk",
-			.parent_names = (const char *[]){ "gp2_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&gp2_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1228,7 +1263,7 @@ static struct clk_rcg prng_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "prng_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 		},
@@ -1244,7 +1279,9 @@ static struct clk_branch prng_clk = {
 		.enable_mask = BIT(10),
 		.hw.init = &(struct clk_init_data){
 			.name = "prng_clk",
-			.parent_names = (const char *[]){ "prng_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&prng_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 		},
@@ -1290,7 +1327,7 @@ static struct clk_rcg sdc1_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc1_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 		},
@@ -1305,7 +1342,9 @@ static struct clk_branch sdc1_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc1_clk",
-			.parent_names = (const char *[]){ "sdc1_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&sdc1_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1338,7 +1377,7 @@ static struct clk_rcg sdc3_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc3_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 		},
@@ -1353,7 +1392,9 @@ static struct clk_branch sdc3_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc3_clk",
-			.parent_names = (const char *[]){ "sdc3_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&sdc3_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1421,7 +1462,7 @@ static struct clk_rcg tsif_ref_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "tsif_ref_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 		},
@@ -1436,7 +1477,9 @@ static struct clk_branch tsif_ref_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "tsif_ref_clk",
-			.parent_names = (const char *[]){ "tsif_ref_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&tsif_ref_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1583,7 +1626,7 @@ static struct clk_rcg pcie_ref_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie_ref_src",
-			.parent_names = gcc_pxo_pll3,
+			.parent_data = gcc_pxo_pll3,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -1599,7 +1642,9 @@ static struct clk_branch pcie_ref_src_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie_ref_src_clk",
-			.parent_names = (const char *[]){ "pcie_ref_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&pcie_ref_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1675,7 +1720,7 @@ static struct clk_rcg pcie1_ref_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie1_ref_src",
-			.parent_names = gcc_pxo_pll3,
+			.parent_data = gcc_pxo_pll3,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -1691,7 +1736,9 @@ static struct clk_branch pcie1_ref_src_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie1_ref_src_clk",
-			.parent_names = (const char *[]){ "pcie1_ref_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&pcie1_ref_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1767,7 +1814,7 @@ static struct clk_rcg pcie2_ref_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie2_ref_src",
-			.parent_names = gcc_pxo_pll3,
+			.parent_data = gcc_pxo_pll3,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -1783,7 +1830,9 @@ static struct clk_branch pcie2_ref_src_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie2_ref_src_clk",
-			.parent_names = (const char *[]){ "pcie2_ref_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&pcie2_ref_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1864,7 +1913,7 @@ static struct clk_rcg sata_ref_src = {
 		.enable_mask = BIT(7),
 		.hw.init = &(struct clk_init_data){
 			.name = "sata_ref_src",
-			.parent_names = gcc_pxo_pll3,
+			.parent_data = gcc_pxo_pll3,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -1880,7 +1929,9 @@ static struct clk_branch sata_rxoob_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "sata_rxoob_clk",
-			.parent_names = (const char *[]){ "sata_ref_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&sata_ref_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1896,7 +1947,9 @@ static struct clk_branch sata_pmalive_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "sata_pmalive_clk",
-			.parent_names = (const char *[]){ "sata_ref_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&sata_ref_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -1912,7 +1965,7 @@ static struct clk_branch sata_phy_ref_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "sata_phy_ref_clk",
-			.parent_names = (const char *[]){ "pxo" },
+			.parent_data = gcc_pxo,
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 		},
@@ -2001,7 +2054,7 @@ static struct clk_rcg usb30_master_clk_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_master_ref_src",
-			.parent_names = gcc_pxo_pll8_pll0,
+			.parent_data = gcc_pxo_pll8_pll0,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -2017,7 +2070,9 @@ static struct clk_branch usb30_0_branch_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_0_branch_clk",
-			.parent_names = (const char *[]){ "usb30_master_ref_src", },
+			.parent_hws = (const struct clk_hw*[]){
+				&usb30_master_clk_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2033,7 +2088,9 @@ static struct clk_branch usb30_1_branch_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_1_branch_clk",
-			.parent_names = (const char *[]){ "usb30_master_ref_src", },
+			.parent_hws = (const struct clk_hw*[]){
+				&usb30_master_clk_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2071,7 +2128,7 @@ static struct clk_rcg usb30_utmi_clk = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_utmi_clk",
-			.parent_names = gcc_pxo_pll8_pll0,
+			.parent_data = gcc_pxo_pll8_pll0,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -2087,7 +2144,9 @@ static struct clk_branch usb30_0_utmi_clk_ctl = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_0_utmi_clk_ctl",
-			.parent_names = (const char *[]){ "usb30_utmi_clk", },
+			.parent_hws = (const struct clk_hw*[]){
+				&usb30_utmi_clk.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2103,7 +2162,9 @@ static struct clk_branch usb30_1_utmi_clk_ctl = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_1_utmi_clk_ctl",
-			.parent_names = (const char *[]){ "usb30_utmi_clk", },
+			.parent_hws = (const struct clk_hw*[]){
+				&usb30_utmi_clk.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2141,7 +2202,7 @@ static struct clk_rcg usb_hs1_xcvr_clk_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_hs1_xcvr_src",
-			.parent_names = gcc_pxo_pll8_pll0,
+			.parent_data = gcc_pxo_pll8_pll0,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -2157,7 +2218,9 @@ static struct clk_branch usb_hs1_xcvr_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_hs1_xcvr_clk",
-			.parent_names = (const char *[]){ "usb_hs1_xcvr_src" },
+			.parent_hws = (const struct clk_hw*[]){
+				&usb_hs1_xcvr_clk_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2205,7 +2268,7 @@ static struct clk_rcg usb_fs1_xcvr_clk_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_fs1_xcvr_src",
-			.parent_names = gcc_pxo_pll8_pll0,
+			.parent_data = gcc_pxo_pll8_pll0,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -2221,7 +2284,9 @@ static struct clk_branch usb_fs1_xcvr_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_fs1_xcvr_clk",
-			.parent_names = (const char *[]){ "usb_fs1_xcvr_src", },
+			.parent_hws = (const struct clk_hw*[]){
+				&usb_fs1_xcvr_clk_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2237,7 +2302,9 @@ static struct clk_branch usb_fs1_sys_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_fs1_sys_clk",
-			.parent_names = (const char *[]){ "usb_fs1_xcvr_src", },
+			.parent_hws = (const struct clk_hw*[]){
+				&usb_fs1_xcvr_clk_src.clkr.hw,
+			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 			.flags = CLK_SET_RATE_PARENT,
@@ -2337,7 +2404,7 @@ static struct clk_dyn_rcg gmac_core1_src = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core1_src",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 		},
@@ -2354,8 +2421,8 @@ static struct clk_branch gmac_core1_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core1_clk",
-			.parent_names = (const char *[]){
-				"gmac_core1_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gmac_core1_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2409,7 +2476,7 @@ static struct clk_dyn_rcg gmac_core2_src = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core2_src",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 		},
@@ -2426,8 +2493,8 @@ static struct clk_branch gmac_core2_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core2_clk",
-			.parent_names = (const char *[]){
-				"gmac_core2_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gmac_core2_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2481,7 +2548,7 @@ static struct clk_dyn_rcg gmac_core3_src = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core3_src",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 		},
@@ -2498,8 +2565,8 @@ static struct clk_branch gmac_core3_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core3_clk",
-			.parent_names = (const char *[]){
-				"gmac_core3_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gmac_core3_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2553,7 +2620,7 @@ static struct clk_dyn_rcg gmac_core4_src = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core4_src",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 		},
@@ -2570,8 +2637,8 @@ static struct clk_branch gmac_core4_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core4_clk",
-			.parent_names = (const char *[]){
-				"gmac_core4_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&gmac_core4_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2613,7 +2680,7 @@ static struct clk_dyn_rcg nss_tcm_src = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "nss_tcm_src",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 		},
@@ -2628,8 +2695,8 @@ static struct clk_branch nss_tcm_clk = {
 		.enable_mask = BIT(6) | BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "nss_tcm_clk",
-			.parent_names = (const char *[]){
-				"nss_tcm_src",
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_tcm_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2691,7 +2758,7 @@ static struct clk_dyn_rcg ubi32_core1_src_clk = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "ubi32_core1_src_clk",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
@@ -2744,7 +2811,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "ubi32_core2_src_clk",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
-- 
2.34.1

