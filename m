Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343654966DC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiAUVEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiAUVD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:03:58 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD708C06173B;
        Fri, 21 Jan 2022 13:03:57 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m4so3334634ejb.9;
        Fri, 21 Jan 2022 13:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WerBO9FmBNHoC1xzdy+NyC6mMRm8VImp6T8cuwrzvc0=;
        b=eHt2m1n9C1YSIV3RV7zviEXl1AsjOIuhSYMNK6BgxpwOULaK65T9yK93eHDB3GkByq
         yLYV0WJMMYRxTNu+CbedDOgcqMZd+uhKYYKr099jA1AkMrS5JamIXHCa8sNkQGdWQ7Qh
         PIW83GuEJzkK39WJXq11DXQnDsds6W2FL+N9O4Yu6YeKauMfOQxfNsZQFyDGsxRDbOQ0
         0HWIp9NoJzJakjS64zPDYCR48+rhX5LFpWg6zDREL+3xXINkFpaGOurco2WvKFXN7HXi
         +9t9zulEomUPMNVSBpacUECRKYN8Mk68oQsnXi0fsAfxmg2z5pSceoMfPtIJcluuGrMl
         XZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WerBO9FmBNHoC1xzdy+NyC6mMRm8VImp6T8cuwrzvc0=;
        b=D4GaM3qOezClyElu6DmB4ZTIzCTBoiSh4RJg2yvdjyd7p1PQePHJD3aYzhtffWxkOf
         cG41s1Cks9gyFzxDcH2DQ5ljjz56HOM19SbUCyY2xuce4YvCUKmv2nyr5HXEecOut33y
         4SoyuinHrccre1MFtMeCj5KCWQQvGIRT1I9uCAEBqA2Kn0DQIP08JlTWxY6vBb50yEgb
         UFGE++O9/VdplrLUCz3ozgs7JQ/uZWrVjXLJZ4C1qxlQVLoctZXd7GF+8xvowGxtmVm1
         uUwj3DNjuYITGnKIW43DI/qJ9SFkIkO5lJoo8h3cxcBoPPLe+lpmbFFfVUKVNjy27w9H
         /HLQ==
X-Gm-Message-State: AOAM533WNR/AqlQ4JeY7wy8ZbejqHG4jMPa7G0xMsi4x1EqMoh+3QRUd
        DNnAG8lhQ6T/ygLdR+ecG2I=
X-Google-Smtp-Source: ABdhPJw/z5SkPvWg0oG5ENfJjJS//F2b8D92OMFuo/YKKqNUq/Zp9Bgdf1H/SD6aCKe8xxNfpQkpxQ==
X-Received: by 2002:a17:907:6091:: with SMTP id ht17mr4935499ejc.282.1642799036136;
        Fri, 21 Jan 2022 13:03:56 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:03:55 -0800 (PST)
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
Subject: [PATCH v3 05/15] drivers: clk: qcom: gcc-ipq806x: convert parent_names to parent_data
Date:   Fri, 21 Jan 2022 22:03:30 +0100
Message-Id: <20220121210340.32362-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert parent_names to parent_data to modernize the driver.
Where possible use parent_hws directly.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 286 ++++++++++++++++++++-------------
 1 file changed, 173 insertions(+), 113 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 34cddf461dba..828383c30322 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -25,6 +25,10 @@
 #include "clk-hfpll.h"
 #include "reset.h"
 
+static const struct clk_parent_data gcc_pxo[] = {
+	{ .fw_name = "pxo" },
+};
+
 static struct clk_pll pll0 = {
 	.l_reg = 0x30c4,
 	.m_reg = 0x30c8,
@@ -35,7 +39,7 @@ static struct clk_pll pll0 = {
 	.status_bit = 16,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll0",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.ops = &clk_pll_ops,
 	},
@@ -46,7 +50,9 @@ static struct clk_regmap pll0_vote = {
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
@@ -62,7 +68,7 @@ static struct clk_pll pll3 = {
 	.status_bit = 16,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll3",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.ops = &clk_pll_ops,
 	},
@@ -89,7 +95,7 @@ static struct clk_pll pll8 = {
 	.status_bit = 16,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll8",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.ops = &clk_pll_ops,
 	},
@@ -100,7 +106,9 @@ static struct clk_regmap pll8_vote = {
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
@@ -123,7 +131,7 @@ static struct hfpll_data hfpll0_data = {
 static struct clk_hfpll hfpll0 = {
 	.d = &hfpll0_data,
 	.clkr.hw.init = &(struct clk_init_data){
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.name = "hfpll0",
 		.ops = &clk_ops_hfpll,
@@ -149,7 +157,7 @@ static struct hfpll_data hfpll1_data = {
 static struct clk_hfpll hfpll1 = {
 	.d = &hfpll1_data,
 	.clkr.hw.init = &(struct clk_init_data){
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.name = "hfpll1",
 		.ops = &clk_ops_hfpll,
@@ -175,7 +183,7 @@ static struct hfpll_data hfpll_l2_data = {
 static struct clk_hfpll hfpll_l2 = {
 	.d = &hfpll_l2_data,
 	.clkr.hw.init = &(struct clk_init_data){
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.name = "hfpll_l2",
 		.ops = &clk_ops_hfpll,
@@ -194,7 +202,7 @@ static struct clk_pll pll14 = {
 	.status_bit = 16,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll14",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.ops = &clk_pll_ops,
 	},
@@ -205,7 +213,9 @@ static struct clk_regmap pll14_vote = {
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
@@ -238,7 +248,7 @@ static struct clk_pll pll18 = {
 	.freq_tbl = pll18_freq_tbl,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "pll18",
-		.parent_names = (const char *[]){ "pxo" },
+		.parent_data = gcc_pxo,
 		.num_parents = 1,
 		.ops = &clk_pll_ops,
 	},
@@ -259,9 +269,9 @@ static const struct parent_map gcc_pxo_pll8_map[] = {
 	{ P_PLL8, 3 }
 };
 
-static const char * const gcc_pxo_pll8[] = {
-	"pxo",
-	"pll8_vote",
+static const struct clk_parent_data gcc_pxo_pll8[] = {
+	{ .fw_name = "pxo" },
+	{ .hw = &pll8_vote.hw },
 };
 
 static const struct parent_map gcc_pxo_pll8_cxo_map[] = {
@@ -270,10 +280,10 @@ static const struct parent_map gcc_pxo_pll8_cxo_map[] = {
 	{ P_CXO, 5 }
 };
 
-static const char * const gcc_pxo_pll8_cxo[] = {
-	"pxo",
-	"pll8_vote",
-	"cxo",
+static const struct clk_parent_data gcc_pxo_pll8_cxo[] = {
+	{ .fw_name = "pxo" },
+	{ .hw = &pll8_vote.hw },
+	{ .fw_name = "cxo" },
 };
 
 static const struct parent_map gcc_pxo_pll3_map[] = {
@@ -286,9 +296,9 @@ static const struct parent_map gcc_pxo_pll3_sata_map[] = {
 	{ P_PLL3, 6 }
 };
 
-static const char * const gcc_pxo_pll3[] = {
-	"pxo",
-	"pll3",
+static const struct clk_parent_data gcc_pxo_pll3[] = {
+	{ .fw_name = "pxo" },
+	{ .hw = &pll3.clkr.hw },
 };
 
 static const struct parent_map gcc_pxo_pll8_pll0_map[] = {
@@ -297,10 +307,10 @@ static const struct parent_map gcc_pxo_pll8_pll0_map[] = {
 	{ P_PLL0, 2 }
 };
 
-static const char * const gcc_pxo_pll8_pll0[] = {
-	"pxo",
-	"pll8_vote",
-	"pll0_vote",
+static const struct clk_parent_data gcc_pxo_pll8_pll0[] = {
+	{ .fw_name = "pxo" },
+	{ .hw = &pll8_vote.hw },
+	{ .hw = &pll0_vote.hw },
 };
 
 static const struct parent_map gcc_pxo_pll8_pll14_pll18_pll0_map[] = {
@@ -311,12 +321,12 @@ static const struct parent_map gcc_pxo_pll8_pll14_pll18_pll0_map[] = {
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
+	{ .hw = &pll8_vote.hw },
+	{ .hw = &pll0_vote.hw },
+	{ .hw = &pll14.clkr.hw },
+	{ .hw = &pll18.clkr.hw },
 };
 
 static struct freq_tbl clk_tbl_gsbi_uart[] = {
@@ -362,7 +372,7 @@ static struct clk_rcg gsbi1_uart_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_uart_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -378,8 +388,8 @@ static struct clk_branch gsbi1_uart_clk = {
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
@@ -413,7 +423,7 @@ static struct clk_rcg gsbi2_uart_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_uart_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -429,8 +439,8 @@ static struct clk_branch gsbi2_uart_clk = {
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
@@ -464,7 +474,7 @@ static struct clk_rcg gsbi4_uart_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_uart_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -480,8 +490,8 @@ static struct clk_branch gsbi4_uart_clk = {
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
@@ -515,7 +525,7 @@ static struct clk_rcg gsbi5_uart_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_uart_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -531,8 +541,8 @@ static struct clk_branch gsbi5_uart_clk = {
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
@@ -566,7 +576,7 @@ static struct clk_rcg gsbi6_uart_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_uart_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -582,8 +592,8 @@ static struct clk_branch gsbi6_uart_clk = {
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
@@ -617,7 +627,7 @@ static struct clk_rcg gsbi7_uart_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_uart_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -633,8 +643,8 @@ static struct clk_branch gsbi7_uart_clk = {
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
@@ -681,7 +691,7 @@ static struct clk_rcg gsbi1_qup_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_qup_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -697,7 +707,9 @@ static struct clk_branch gsbi1_qup_clk = {
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
@@ -730,7 +742,7 @@ static struct clk_rcg gsbi2_qup_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_qup_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -746,7 +758,9 @@ static struct clk_branch gsbi2_qup_clk = {
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
@@ -779,7 +793,7 @@ static struct clk_rcg gsbi4_qup_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_qup_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -795,7 +809,9 @@ static struct clk_branch gsbi4_qup_clk = {
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
@@ -828,7 +844,7 @@ static struct clk_rcg gsbi5_qup_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_qup_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -844,7 +860,9 @@ static struct clk_branch gsbi5_qup_clk = {
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
@@ -877,7 +895,7 @@ static struct clk_rcg gsbi6_qup_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_qup_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -893,7 +911,9 @@ static struct clk_branch gsbi6_qup_clk = {
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
@@ -926,7 +946,7 @@ static struct clk_rcg gsbi7_qup_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_qup_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -942,7 +962,9 @@ static struct clk_branch gsbi7_qup_clk = {
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
@@ -1076,7 +1098,7 @@ static struct clk_rcg gp0_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gp0_src",
-			.parent_names = gcc_pxo_pll8_cxo,
+			.parent_data = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_PARENT_GATE,
@@ -1092,7 +1114,9 @@ static struct clk_branch gp0_clk = {
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
@@ -1125,7 +1149,7 @@ static struct clk_rcg gp1_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gp1_src",
-			.parent_names = gcc_pxo_pll8_cxo,
+			.parent_data = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -1141,7 +1165,9 @@ static struct clk_branch gp1_clk = {
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
@@ -1174,7 +1200,7 @@ static struct clk_rcg gp2_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "gp2_src",
-			.parent_names = gcc_pxo_pll8_cxo,
+			.parent_data = gcc_pxo_pll8_cxo,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -1190,7 +1216,9 @@ static struct clk_branch gp2_clk = {
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
@@ -1228,7 +1256,7 @@ static struct clk_rcg prng_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "prng_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 		},
@@ -1244,7 +1272,9 @@ static struct clk_branch prng_clk = {
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
@@ -1290,7 +1320,7 @@ static struct clk_rcg sdc1_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc1_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 		},
@@ -1305,7 +1335,9 @@ static struct clk_branch sdc1_clk = {
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
@@ -1338,7 +1370,7 @@ static struct clk_rcg sdc3_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc3_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 		},
@@ -1353,7 +1385,9 @@ static struct clk_branch sdc3_clk = {
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
@@ -1421,7 +1455,7 @@ static struct clk_rcg tsif_ref_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "tsif_ref_src",
-			.parent_names = gcc_pxo_pll8,
+			.parent_data = gcc_pxo_pll8,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 		},
@@ -1436,7 +1470,9 @@ static struct clk_branch tsif_ref_clk = {
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
@@ -1583,7 +1619,7 @@ static struct clk_rcg pcie_ref_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie_ref_src",
-			.parent_names = gcc_pxo_pll3,
+			.parent_data = gcc_pxo_pll3,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -1599,7 +1635,9 @@ static struct clk_branch pcie_ref_src_clk = {
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
@@ -1675,7 +1713,7 @@ static struct clk_rcg pcie1_ref_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie1_ref_src",
-			.parent_names = gcc_pxo_pll3,
+			.parent_data = gcc_pxo_pll3,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -1691,7 +1729,9 @@ static struct clk_branch pcie1_ref_src_clk = {
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
@@ -1767,7 +1807,7 @@ static struct clk_rcg pcie2_ref_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie2_ref_src",
-			.parent_names = gcc_pxo_pll3,
+			.parent_data = gcc_pxo_pll3,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -1783,7 +1823,9 @@ static struct clk_branch pcie2_ref_src_clk = {
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
@@ -1864,7 +1906,7 @@ static struct clk_rcg sata_ref_src = {
 		.enable_mask = BIT(7),
 		.hw.init = &(struct clk_init_data){
 			.name = "sata_ref_src",
-			.parent_names = gcc_pxo_pll3,
+			.parent_data = gcc_pxo_pll3,
 			.num_parents = 2,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -1880,7 +1922,9 @@ static struct clk_branch sata_rxoob_clk = {
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
@@ -1896,7 +1940,9 @@ static struct clk_branch sata_pmalive_clk = {
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
@@ -1912,7 +1958,7 @@ static struct clk_branch sata_phy_ref_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "sata_phy_ref_clk",
-			.parent_names = (const char *[]){ "pxo" },
+			.parent_data = gcc_pxo,
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
 		},
@@ -2001,7 +2047,7 @@ static struct clk_rcg usb30_master_clk_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_master_ref_src",
-			.parent_names = gcc_pxo_pll8_pll0,
+			.parent_data = gcc_pxo_pll8_pll0,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -2017,7 +2063,9 @@ static struct clk_branch usb30_0_branch_clk = {
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
@@ -2033,7 +2081,9 @@ static struct clk_branch usb30_1_branch_clk = {
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
@@ -2071,7 +2121,7 @@ static struct clk_rcg usb30_utmi_clk = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_utmi_clk",
-			.parent_names = gcc_pxo_pll8_pll0,
+			.parent_data = gcc_pxo_pll8_pll0,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -2087,7 +2137,9 @@ static struct clk_branch usb30_0_utmi_clk_ctl = {
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
@@ -2103,7 +2155,9 @@ static struct clk_branch usb30_1_utmi_clk_ctl = {
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
@@ -2141,7 +2195,7 @@ static struct clk_rcg usb_hs1_xcvr_clk_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_hs1_xcvr_src",
-			.parent_names = gcc_pxo_pll8_pll0,
+			.parent_data = gcc_pxo_pll8_pll0,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -2157,7 +2211,9 @@ static struct clk_branch usb_hs1_xcvr_clk = {
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
@@ -2205,7 +2261,7 @@ static struct clk_rcg usb_fs1_xcvr_clk_src = {
 		.enable_mask = BIT(11),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_fs1_xcvr_src",
-			.parent_names = gcc_pxo_pll8_pll0,
+			.parent_data = gcc_pxo_pll8_pll0,
 			.num_parents = 3,
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
@@ -2221,7 +2277,9 @@ static struct clk_branch usb_fs1_xcvr_clk = {
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
@@ -2237,7 +2295,9 @@ static struct clk_branch usb_fs1_sys_clk = {
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
@@ -2337,7 +2397,7 @@ static struct clk_dyn_rcg gmac_core1_src = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core1_src",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 		},
@@ -2354,8 +2414,8 @@ static struct clk_branch gmac_core1_clk = {
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
@@ -2409,7 +2469,7 @@ static struct clk_dyn_rcg gmac_core2_src = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core2_src",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 		},
@@ -2426,8 +2486,8 @@ static struct clk_branch gmac_core2_clk = {
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
@@ -2481,7 +2541,7 @@ static struct clk_dyn_rcg gmac_core3_src = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core3_src",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 		},
@@ -2498,8 +2558,8 @@ static struct clk_branch gmac_core3_clk = {
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
@@ -2553,7 +2613,7 @@ static struct clk_dyn_rcg gmac_core4_src = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core4_src",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 		},
@@ -2570,8 +2630,8 @@ static struct clk_branch gmac_core4_clk = {
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
@@ -2613,7 +2673,7 @@ static struct clk_dyn_rcg nss_tcm_src = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "nss_tcm_src",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 		},
@@ -2628,8 +2688,8 @@ static struct clk_branch nss_tcm_clk = {
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
@@ -2691,7 +2751,7 @@ static struct clk_dyn_rcg ubi32_core1_src_clk = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "ubi32_core1_src_clk",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
@@ -2744,7 +2804,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
 		.enable_mask = BIT(1),
 		.hw.init = &(struct clk_init_data){
 			.name = "ubi32_core2_src_clk",
-			.parent_names = gcc_pxo_pll8_pll14_pll18_pll0,
+			.parent_data = gcc_pxo_pll8_pll14_pll18_pll0,
 			.num_parents = 5,
 			.ops = &clk_dyn_rcg_ops,
 			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
-- 
2.33.1

