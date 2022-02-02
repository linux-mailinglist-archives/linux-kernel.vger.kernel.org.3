Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA44D4A77D2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbiBBSY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:24:26 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:43653 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346628AbiBBSYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:24:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1643826264; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=EhW4nLLJ9dvUl9QfF226NcakI84k4dRBMFfY+aDDeFU=; b=H2mMintHa2gJ4sBGTpaLZt3T5N9riTKTrjYsPezC0uN2e5iIYh0XjyT0HCqi9tcKqpbyiF9q
 D+WB52ym0ICqiHKq/FbI4HvhMs5oyNTXmqqyYu/ij3390LEBHOYNlLSnTCuf9ncF7Cu1s4te
 1CjsvwCL9BC5mOJ5FiGZ8vC4vMk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 61facb9669943108c5eb8717 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Feb 2022 18:21:10
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0083EC43616; Wed,  2 Feb 2022 18:21:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.0
Received: from hu-tdas-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 267BCC4338F;
        Wed,  2 Feb 2022 18:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 267BCC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1 1/2] clk: qcom: sc7280: Update clk_init_data to const for clock controllers
Date:   Wed,  2 Feb 2022 23:50:52 +0530
Message-Id: <20220202182053.22925-1-tdas@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update clk_init_data to const and also use index instead of fw_name for
global clock controller, camera and display clock controllers.

Fixes: a3cc092196ef6 ("clk: qcom: Add Global Clock controller (GCC) driver for SC7280")
Fixes: 1daec8cfebc28 ("clk: qcom: camcc: Add camera clock controller driver for SC7280")
Fixes: 1a00c962f9cd0 ("clk: qcom: Add display clock controller driver for SC7280")
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/camcc-sc7280.c  | 252 ++++++++++-----------
 drivers/clk/qcom/dispcc-sc7280.c | 102 ++++-----
 drivers/clk/qcom/gcc-sc7280.c    | 362 +++++++++++++++----------------
 3 files changed, 358 insertions(+), 358 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sc7280.c b/drivers/clk/qcom/camcc-sc7280.c
index ec163ea769f5..67bf52daa8a8 100644
--- a/drivers/clk/qcom/camcc-sc7280.c
+++ b/drivers/clk/qcom/camcc-sc7280.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022, The Linux Foundation. All rights reserved.
  */

 #include <linux/clk-provider.h>
@@ -63,10 +63,10 @@ static struct clk_alpha_pll cam_cc_pll0 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll0",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -86,7 +86,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll0_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll0_out_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll0_out_even",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll0.clkr.hw,
@@ -109,7 +109,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll0_out_odd = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll0_out_odd),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll0_out_odd",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll0.clkr.hw,
@@ -138,10 +138,10 @@ static struct clk_alpha_pll cam_cc_pll1 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll1",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -161,7 +161,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll1_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll1_out_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll1_out_even",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll1.clkr.hw,
@@ -188,10 +188,10 @@ static struct clk_alpha_pll cam_cc_pll2 = {
 	.num_vco = ARRAY_SIZE(zonda_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_ZONDA],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll2",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_zonda_ops,
@@ -211,7 +211,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll2_out_aux = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll2_out_aux),
 	.width = 2,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_ZONDA],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll2_out_aux",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll2.clkr.hw,
@@ -234,7 +234,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll2_out_aux2 = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll2_out_aux2),
 	.width = 2,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_ZONDA],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll2_out_aux2",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll2.clkr.hw,
@@ -263,10 +263,10 @@ static struct clk_alpha_pll cam_cc_pll3 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll3",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -286,7 +286,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll3_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll3_out_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll3_out_even",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll3.clkr.hw,
@@ -315,10 +315,10 @@ static struct clk_alpha_pll cam_cc_pll4 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll4",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -338,7 +338,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll4_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll4_out_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll4_out_even",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll4.clkr.hw,
@@ -367,10 +367,10 @@ static struct clk_alpha_pll cam_cc_pll5 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll5",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -390,7 +390,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll5_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll5_out_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll5_out_even",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll5.clkr.hw,
@@ -419,10 +419,10 @@ static struct clk_alpha_pll cam_cc_pll6 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_pll6",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -442,7 +442,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll6_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll6_out_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll6_out_even",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll6.clkr.hw,
@@ -465,7 +465,7 @@ static struct clk_alpha_pll_postdiv cam_cc_pll6_out_odd = {
 	.num_post_div = ARRAY_SIZE(post_div_table_cam_cc_pll6_out_odd),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_pll6_out_odd",
 		.parent_data = &(const struct clk_parent_data){
 			.hw = &cam_cc_pll6.clkr.hw,
@@ -485,7 +485,7 @@ static const struct parent_map cam_cc_parent_map_0[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_0[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll0.clkr.hw },
 	{ .hw = &cam_cc_pll0_out_even.clkr.hw },
 	{ .hw = &cam_cc_pll0_out_odd.clkr.hw },
@@ -502,7 +502,7 @@ static const struct parent_map cam_cc_parent_map_1[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_1[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll0.clkr.hw },
 	{ .hw = &cam_cc_pll0_out_even.clkr.hw },
 	{ .hw = &cam_cc_pll0_out_odd.clkr.hw },
@@ -517,7 +517,7 @@ static const struct parent_map cam_cc_parent_map_2[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_2[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll2_out_aux2.clkr.hw },
 	{ .hw = &cam_cc_pll2.clkr.hw },
 };
@@ -532,7 +532,7 @@ static const struct parent_map cam_cc_parent_map_3[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_3[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll0.clkr.hw },
 	{ .hw = &cam_cc_pll0_out_even.clkr.hw },
 	{ .hw = &cam_cc_pll0_out_odd.clkr.hw },
@@ -546,7 +546,7 @@ static const struct parent_map cam_cc_parent_map_4[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_4[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll3_out_even.clkr.hw },
 };

@@ -556,7 +556,7 @@ static const struct parent_map cam_cc_parent_map_5[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_5[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll4_out_even.clkr.hw },
 };

@@ -566,7 +566,7 @@ static const struct parent_map cam_cc_parent_map_6[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_6[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll5_out_even.clkr.hw },
 };

@@ -576,7 +576,7 @@ static const struct parent_map cam_cc_parent_map_7[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_7[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &cam_cc_pll1_out_even.clkr.hw },
 };

@@ -585,7 +585,7 @@ static const struct parent_map cam_cc_parent_map_8[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_8[] = {
-	{ .fw_name = "sleep_clk" },
+	{ .index = 2 },
 };

 static const struct parent_map cam_cc_parent_map_9[] = {
@@ -593,7 +593,7 @@ static const struct parent_map cam_cc_parent_map_9[] = {
 };

 static const struct clk_parent_data cam_cc_parent_data_9_ao[] = {
-	{ .fw_name = "bi_tcxo_ao" },
+	{ .index = 1 },
 };

 static const struct freq_tbl ftbl_cam_cc_bps_clk_src[] = {
@@ -612,7 +612,7 @@ static struct clk_rcg2 cam_cc_bps_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_bps_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_bps_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -636,7 +636,7 @@ static struct clk_rcg2 cam_cc_camnoc_axi_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_3,
 	.freq_tbl = ftbl_cam_cc_camnoc_axi_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_camnoc_axi_clk_src",
 		.parent_data = cam_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_3),
@@ -656,7 +656,7 @@ static struct clk_rcg2 cam_cc_cci_0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_cci_0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_cci_0_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -670,7 +670,7 @@ static struct clk_rcg2 cam_cc_cci_1_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_cci_0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_cci_1_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -691,7 +691,7 @@ static struct clk_rcg2 cam_cc_cphy_rx_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_cphy_rx_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_cphy_rx_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
@@ -711,7 +711,7 @@ static struct clk_rcg2 cam_cc_csi0phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_csi0phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -725,7 +725,7 @@ static struct clk_rcg2 cam_cc_csi1phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_csi1phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -739,7 +739,7 @@ static struct clk_rcg2 cam_cc_csi2phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_csi2phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -753,7 +753,7 @@ static struct clk_rcg2 cam_cc_csi3phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_csi3phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -767,7 +767,7 @@ static struct clk_rcg2 cam_cc_csi4phytimer_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_csi0phytimer_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_csi4phytimer_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -791,7 +791,7 @@ static struct clk_rcg2 cam_cc_fast_ahb_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_fast_ahb_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_fast_ahb_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -813,7 +813,7 @@ static struct clk_rcg2 cam_cc_icp_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_icp_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_icp_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -836,7 +836,7 @@ static struct clk_rcg2 cam_cc_ife_0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_4,
 	.freq_tbl = ftbl_cam_cc_ife_0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_0_clk_src",
 		.parent_data = cam_cc_parent_data_4,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_4),
@@ -860,7 +860,7 @@ static struct clk_rcg2 cam_cc_ife_1_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_5,
 	.freq_tbl = ftbl_cam_cc_ife_1_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_1_clk_src",
 		.parent_data = cam_cc_parent_data_5,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_5),
@@ -883,7 +883,7 @@ static struct clk_rcg2 cam_cc_ife_0_csid_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_ife_0_csid_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_0_csid_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
@@ -897,7 +897,7 @@ static struct clk_rcg2 cam_cc_ife_1_csid_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_ife_0_csid_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_1_csid_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
@@ -920,7 +920,7 @@ static struct clk_rcg2 cam_cc_ife_2_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_6,
 	.freq_tbl = ftbl_cam_cc_ife_2_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_2_clk_src",
 		.parent_data = cam_cc_parent_data_6,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_6),
@@ -935,7 +935,7 @@ static struct clk_rcg2 cam_cc_ife_2_csid_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_ife_0_csid_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_2_csid_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
@@ -958,7 +958,7 @@ static struct clk_rcg2 cam_cc_ife_lite_0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_3,
 	.freq_tbl = ftbl_cam_cc_ife_lite_0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_lite_0_clk_src",
 		.parent_data = cam_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_3),
@@ -972,7 +972,7 @@ static struct clk_rcg2 cam_cc_ife_lite_0_csid_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_ife_0_csid_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_lite_0_csid_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
@@ -986,7 +986,7 @@ static struct clk_rcg2 cam_cc_ife_lite_1_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_3,
 	.freq_tbl = ftbl_cam_cc_ife_lite_0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_lite_1_clk_src",
 		.parent_data = cam_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_3),
@@ -1000,7 +1000,7 @@ static struct clk_rcg2 cam_cc_ife_lite_1_csid_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_1,
 	.freq_tbl = ftbl_cam_cc_ife_0_csid_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ife_lite_1_csid_clk_src",
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
@@ -1023,7 +1023,7 @@ static struct clk_rcg2 cam_cc_ipe_0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_7,
 	.freq_tbl = ftbl_cam_cc_ipe_0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_ipe_0_clk_src",
 		.parent_data = cam_cc_parent_data_7,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_7),
@@ -1038,7 +1038,7 @@ static struct clk_rcg2 cam_cc_jpeg_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_bps_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_jpeg_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -1062,7 +1062,7 @@ static struct clk_rcg2 cam_cc_lrme_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_3,
 	.freq_tbl = ftbl_cam_cc_lrme_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_lrme_clk_src",
 		.parent_data = cam_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_3),
@@ -1083,7 +1083,7 @@ static struct clk_rcg2 cam_cc_mclk0_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_2,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_mclk0_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
@@ -1097,7 +1097,7 @@ static struct clk_rcg2 cam_cc_mclk1_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_2,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_mclk1_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
@@ -1111,7 +1111,7 @@ static struct clk_rcg2 cam_cc_mclk2_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_2,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_mclk2_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
@@ -1125,7 +1125,7 @@ static struct clk_rcg2 cam_cc_mclk3_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_2,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_mclk3_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
@@ -1139,7 +1139,7 @@ static struct clk_rcg2 cam_cc_mclk4_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_2,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_mclk4_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
@@ -1153,7 +1153,7 @@ static struct clk_rcg2 cam_cc_mclk5_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_2,
 	.freq_tbl = ftbl_cam_cc_mclk0_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_mclk5_clk_src",
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
@@ -1172,7 +1172,7 @@ static struct clk_rcg2 cam_cc_sleep_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_8,
 	.freq_tbl = ftbl_cam_cc_sleep_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_sleep_clk_src",
 		.parent_data = cam_cc_parent_data_8,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_8),
@@ -1192,7 +1192,7 @@ static struct clk_rcg2 cam_cc_slow_ahb_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_0,
 	.freq_tbl = ftbl_cam_cc_slow_ahb_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_slow_ahb_clk_src",
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
@@ -1211,7 +1211,7 @@ static struct clk_rcg2 cam_cc_xo_clk_src = {
 	.hid_width = 5,
 	.parent_map = cam_cc_parent_map_9,
 	.freq_tbl = ftbl_cam_cc_xo_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "cam_cc_xo_clk_src",
 		.parent_data = cam_cc_parent_data_9_ao,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_9_ao),
@@ -1225,7 +1225,7 @@ static struct clk_branch cam_cc_bps_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x7070,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_bps_ahb_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_slow_ahb_clk_src.clkr.hw,
@@ -1243,7 +1243,7 @@ static struct clk_branch cam_cc_bps_areg_clk = {
 	.clkr = {
 		.enable_reg = 0x7054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_bps_areg_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_fast_ahb_clk_src.clkr.hw,
@@ -1261,7 +1261,7 @@ static struct clk_branch cam_cc_bps_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x7038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_bps_axi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_camnoc_axi_clk_src.clkr.hw,
@@ -1279,7 +1279,7 @@ static struct clk_branch cam_cc_bps_clk = {
 	.clkr = {
 		.enable_reg = 0x7028,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_bps_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_bps_clk_src.clkr.hw,
@@ -1297,7 +1297,7 @@ static struct clk_branch cam_cc_camnoc_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xc140,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_camnoc_axi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_camnoc_axi_clk_src.clkr.hw,
@@ -1315,7 +1315,7 @@ static struct clk_branch cam_cc_camnoc_dcd_xo_clk = {
 	.clkr = {
 		.enable_reg = 0xc148,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_camnoc_dcd_xo_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_xo_clk_src.clkr.hw,
@@ -1333,7 +1333,7 @@ static struct clk_branch cam_cc_cci_0_clk = {
 	.clkr = {
 		.enable_reg = 0xc0f8,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_cci_0_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cci_0_clk_src.clkr.hw,
@@ -1351,7 +1351,7 @@ static struct clk_branch cam_cc_cci_1_clk = {
 	.clkr = {
 		.enable_reg = 0xc114,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_cci_1_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cci_1_clk_src.clkr.hw,
@@ -1369,7 +1369,7 @@ static struct clk_branch cam_cc_core_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0xc1a0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_core_ahb_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_slow_ahb_clk_src.clkr.hw,
@@ -1387,7 +1387,7 @@ static struct clk_branch cam_cc_cpas_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0xc11c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_cpas_ahb_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_slow_ahb_clk_src.clkr.hw,
@@ -1405,7 +1405,7 @@ static struct clk_branch cam_cc_csi0phytimer_clk = {
 	.clkr = {
 		.enable_reg = 0xe0c4,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csi0phytimer_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_csi0phytimer_clk_src.clkr.hw,
@@ -1423,7 +1423,7 @@ static struct clk_branch cam_cc_csi1phytimer_clk = {
 	.clkr = {
 		.enable_reg = 0xe0e8,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csi1phytimer_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_csi1phytimer_clk_src.clkr.hw,
@@ -1441,7 +1441,7 @@ static struct clk_branch cam_cc_csi2phytimer_clk = {
 	.clkr = {
 		.enable_reg = 0xe10c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csi2phytimer_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_csi2phytimer_clk_src.clkr.hw,
@@ -1459,7 +1459,7 @@ static struct clk_branch cam_cc_csi3phytimer_clk = {
 	.clkr = {
 		.enable_reg = 0xe134,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csi3phytimer_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_csi3phytimer_clk_src.clkr.hw,
@@ -1477,7 +1477,7 @@ static struct clk_branch cam_cc_csi4phytimer_clk = {
 	.clkr = {
 		.enable_reg = 0xe158,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csi4phytimer_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_csi4phytimer_clk_src.clkr.hw,
@@ -1495,7 +1495,7 @@ static struct clk_branch cam_cc_csiphy0_clk = {
 	.clkr = {
 		.enable_reg = 0xe0c8,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csiphy0_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1513,7 +1513,7 @@ static struct clk_branch cam_cc_csiphy1_clk = {
 	.clkr = {
 		.enable_reg = 0xe0ec,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csiphy1_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1531,7 +1531,7 @@ static struct clk_branch cam_cc_csiphy2_clk = {
 	.clkr = {
 		.enable_reg = 0xe110,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csiphy2_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1549,7 +1549,7 @@ static struct clk_branch cam_cc_csiphy3_clk = {
 	.clkr = {
 		.enable_reg = 0xe138,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csiphy3_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1567,7 +1567,7 @@ static struct clk_branch cam_cc_csiphy4_clk = {
 	.clkr = {
 		.enable_reg = 0xe15c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_csiphy4_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1585,7 +1585,7 @@ static struct clk_branch cam_cc_gdsc_clk = {
 	.clkr = {
 		.enable_reg = 0xc1bc,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_gdsc_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_xo_clk_src.clkr.hw,
@@ -1603,7 +1603,7 @@ static struct clk_branch cam_cc_icp_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0xc0d8,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_icp_ahb_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_slow_ahb_clk_src.clkr.hw,
@@ -1621,7 +1621,7 @@ static struct clk_branch cam_cc_icp_clk = {
 	.clkr = {
 		.enable_reg = 0xc0d0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_icp_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_icp_clk_src.clkr.hw,
@@ -1639,7 +1639,7 @@ static struct clk_branch cam_cc_ife_0_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xa080,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_0_axi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_camnoc_axi_clk_src.clkr.hw,
@@ -1657,7 +1657,7 @@ static struct clk_branch cam_cc_ife_0_clk = {
 	.clkr = {
 		.enable_reg = 0xa028,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_0_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_0_clk_src.clkr.hw,
@@ -1675,7 +1675,7 @@ static struct clk_branch cam_cc_ife_0_cphy_rx_clk = {
 	.clkr = {
 		.enable_reg = 0xa07c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_0_cphy_rx_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1693,7 +1693,7 @@ static struct clk_branch cam_cc_ife_0_csid_clk = {
 	.clkr = {
 		.enable_reg = 0xa054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_0_csid_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_0_csid_clk_src.clkr.hw,
@@ -1711,7 +1711,7 @@ static struct clk_branch cam_cc_ife_0_dsp_clk = {
 	.clkr = {
 		.enable_reg = 0xa038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_0_dsp_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_0_clk_src.clkr.hw,
@@ -1729,7 +1729,7 @@ static struct clk_branch cam_cc_ife_1_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xb068,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_1_axi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_camnoc_axi_clk_src.clkr.hw,
@@ -1747,7 +1747,7 @@ static struct clk_branch cam_cc_ife_1_clk = {
 	.clkr = {
 		.enable_reg = 0xb028,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_1_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_1_clk_src.clkr.hw,
@@ -1765,7 +1765,7 @@ static struct clk_branch cam_cc_ife_1_cphy_rx_clk = {
 	.clkr = {
 		.enable_reg = 0xb064,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_1_cphy_rx_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1783,7 +1783,7 @@ static struct clk_branch cam_cc_ife_1_csid_clk = {
 	.clkr = {
 		.enable_reg = 0xb054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_1_csid_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_1_csid_clk_src.clkr.hw,
@@ -1801,7 +1801,7 @@ static struct clk_branch cam_cc_ife_1_dsp_clk = {
 	.clkr = {
 		.enable_reg = 0xb038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_1_dsp_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_1_clk_src.clkr.hw,
@@ -1819,7 +1819,7 @@ static struct clk_branch cam_cc_ife_2_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xb0d4,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_2_axi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_camnoc_axi_clk_src.clkr.hw,
@@ -1837,7 +1837,7 @@ static struct clk_branch cam_cc_ife_2_clk = {
 	.clkr = {
 		.enable_reg = 0xb094,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_2_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_2_clk_src.clkr.hw,
@@ -1855,7 +1855,7 @@ static struct clk_branch cam_cc_ife_2_cphy_rx_clk = {
 	.clkr = {
 		.enable_reg = 0xb0d0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_2_cphy_rx_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1873,7 +1873,7 @@ static struct clk_branch cam_cc_ife_2_csid_clk = {
 	.clkr = {
 		.enable_reg = 0xb0c0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_2_csid_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_2_csid_clk_src.clkr.hw,
@@ -1891,7 +1891,7 @@ static struct clk_branch cam_cc_ife_2_dsp_clk = {
 	.clkr = {
 		.enable_reg = 0xb0a4,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_2_dsp_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_2_clk_src.clkr.hw,
@@ -1909,7 +1909,7 @@ static struct clk_branch cam_cc_ife_lite_0_clk = {
 	.clkr = {
 		.enable_reg = 0xc01c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_lite_0_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_lite_0_clk_src.clkr.hw,
@@ -1927,7 +1927,7 @@ static struct clk_branch cam_cc_ife_lite_0_cphy_rx_clk = {
 	.clkr = {
 		.enable_reg = 0xc040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_lite_0_cphy_rx_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1945,7 +1945,7 @@ static struct clk_branch cam_cc_ife_lite_0_csid_clk = {
 	.clkr = {
 		.enable_reg = 0xc038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_lite_0_csid_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_lite_0_csid_clk_src.clkr.hw,
@@ -1963,7 +1963,7 @@ static struct clk_branch cam_cc_ife_lite_1_clk = {
 	.clkr = {
 		.enable_reg = 0xc060,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_lite_1_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_lite_1_clk_src.clkr.hw,
@@ -1981,7 +1981,7 @@ static struct clk_branch cam_cc_ife_lite_1_cphy_rx_clk = {
 	.clkr = {
 		.enable_reg = 0xc084,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_lite_1_cphy_rx_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_cphy_rx_clk_src.clkr.hw,
@@ -1999,7 +1999,7 @@ static struct clk_branch cam_cc_ife_lite_1_csid_clk = {
 	.clkr = {
 		.enable_reg = 0xc07c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ife_lite_1_csid_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ife_lite_1_csid_clk_src.clkr.hw,
@@ -2017,7 +2017,7 @@ static struct clk_branch cam_cc_ipe_0_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x8040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ipe_0_ahb_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_slow_ahb_clk_src.clkr.hw,
@@ -2035,7 +2035,7 @@ static struct clk_branch cam_cc_ipe_0_areg_clk = {
 	.clkr = {
 		.enable_reg = 0x803c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ipe_0_areg_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_fast_ahb_clk_src.clkr.hw,
@@ -2053,7 +2053,7 @@ static struct clk_branch cam_cc_ipe_0_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x8038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ipe_0_axi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_camnoc_axi_clk_src.clkr.hw,
@@ -2071,7 +2071,7 @@ static struct clk_branch cam_cc_ipe_0_clk = {
 	.clkr = {
 		.enable_reg = 0x8028,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_ipe_0_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_ipe_0_clk_src.clkr.hw,
@@ -2089,7 +2089,7 @@ static struct clk_branch cam_cc_jpeg_clk = {
 	.clkr = {
 		.enable_reg = 0xc0a4,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_jpeg_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_jpeg_clk_src.clkr.hw,
@@ -2107,7 +2107,7 @@ static struct clk_branch cam_cc_lrme_clk = {
 	.clkr = {
 		.enable_reg = 0xc168,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_lrme_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_lrme_clk_src.clkr.hw,
@@ -2125,7 +2125,7 @@ static struct clk_branch cam_cc_mclk0_clk = {
 	.clkr = {
 		.enable_reg = 0xe018,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_mclk0_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_mclk0_clk_src.clkr.hw,
@@ -2143,7 +2143,7 @@ static struct clk_branch cam_cc_mclk1_clk = {
 	.clkr = {
 		.enable_reg = 0xe034,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_mclk1_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_mclk1_clk_src.clkr.hw,
@@ -2161,7 +2161,7 @@ static struct clk_branch cam_cc_mclk2_clk = {
 	.clkr = {
 		.enable_reg = 0xe050,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_mclk2_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_mclk2_clk_src.clkr.hw,
@@ -2179,7 +2179,7 @@ static struct clk_branch cam_cc_mclk3_clk = {
 	.clkr = {
 		.enable_reg = 0xe06c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_mclk3_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_mclk3_clk_src.clkr.hw,
@@ -2197,7 +2197,7 @@ static struct clk_branch cam_cc_mclk4_clk = {
 	.clkr = {
 		.enable_reg = 0xe088,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_mclk4_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_mclk4_clk_src.clkr.hw,
@@ -2215,7 +2215,7 @@ static struct clk_branch cam_cc_mclk5_clk = {
 	.clkr = {
 		.enable_reg = 0xe0a4,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_mclk5_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_mclk5_clk_src.clkr.hw,
@@ -2233,7 +2233,7 @@ static struct clk_branch cam_cc_sleep_clk = {
 	.clkr = {
 		.enable_reg = 0xc1d8,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "cam_cc_sleep_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw = &cam_cc_sleep_clk_src.clkr.hw,
diff --git a/drivers/clk/qcom/dispcc-sc7280.c b/drivers/clk/qcom/dispcc-sc7280.c
index 4ef4ae231794..7bbf850e04c9 100644
--- a/drivers/clk/qcom/dispcc-sc7280.c
+++ b/drivers/clk/qcom/dispcc-sc7280.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022, The Linux Foundation. All rights reserved.
  */

 #include <linux/clk-provider.h>
@@ -52,10 +52,10 @@ static struct clk_alpha_pll disp_cc_pll0 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_pll0",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -68,7 +68,7 @@ static const struct parent_map disp_cc_parent_map_0[] = {
 };

 static const struct clk_parent_data disp_cc_parent_data_0[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 };

 static const struct parent_map disp_cc_parent_map_1[] = {
@@ -78,7 +78,7 @@ static const struct parent_map disp_cc_parent_map_1[] = {
 };

 static const struct clk_parent_data disp_cc_parent_data_1[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .fw_name = "dp_phy_pll_link_clk" },
 	{ .fw_name = "dp_phy_pll_vco_div_clk" },
 };
@@ -89,7 +89,7 @@ static const struct parent_map disp_cc_parent_map_2[] = {
 };

 static const struct clk_parent_data disp_cc_parent_data_2[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .fw_name = "dsi0_phy_pll_out_byteclk" },
 };

@@ -100,7 +100,7 @@ static const struct parent_map disp_cc_parent_map_3[] = {
 };

 static const struct clk_parent_data disp_cc_parent_data_3[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .fw_name = "edp_phy_pll_link_clk" },
 	{ .fw_name = "edp_phy_pll_vco_div_clk" },
 };
@@ -113,9 +113,9 @@ static const struct parent_map disp_cc_parent_map_4[] = {
 };

 static const struct clk_parent_data disp_cc_parent_data_4[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &disp_cc_pll0.clkr.hw },
-	{ .fw_name = "gcc_disp_gpll0_clk" },
+	{ .index = 1 }, /* gcc_disp_gpll0_clk */
 	{ .hw = &disp_cc_pll0.clkr.hw },
 };

@@ -125,8 +125,8 @@ static const struct parent_map disp_cc_parent_map_5[] = {
 };

 static const struct clk_parent_data disp_cc_parent_data_5[] = {
-	{ .fw_name = "bi_tcxo" },
-	{ .fw_name = "gcc_disp_gpll0_clk" },
+	{ .index = 0 },
+	{ .index = 1 }, /* gcc_disp_gpll0_clk */
 };

 static const struct parent_map disp_cc_parent_map_6[] = {
@@ -135,7 +135,7 @@ static const struct parent_map disp_cc_parent_map_6[] = {
 };

 static const struct clk_parent_data disp_cc_parent_data_6[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .fw_name = "dsi0_phy_pll_out_dsiclk" },
 };

@@ -152,7 +152,7 @@ static struct clk_rcg2 disp_cc_mdss_ahb_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_5,
 	.freq_tbl = ftbl_disp_cc_mdss_ahb_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_ahb_clk_src",
 		.parent_data = disp_cc_parent_data_5,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
@@ -165,7 +165,7 @@ static struct clk_rcg2 disp_cc_mdss_byte0_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_2,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_byte0_clk_src",
 		.parent_data = disp_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
@@ -185,7 +185,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
 	.freq_tbl = ftbl_disp_cc_mdss_dp_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_dp_aux_clk_src",
 		.parent_data = disp_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
@@ -198,7 +198,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_crypto_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_1,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_dp_crypto_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
@@ -211,7 +211,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_1,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_dp_link_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
@@ -224,7 +224,7 @@ static struct clk_rcg2 disp_cc_mdss_dp_pixel_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_1,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_dp_pixel_clk_src",
 		.parent_data = disp_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
@@ -238,7 +238,7 @@ static struct clk_rcg2 disp_cc_mdss_edp_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
 	.freq_tbl = ftbl_disp_cc_mdss_dp_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_edp_aux_clk_src",
 		.parent_data = disp_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
@@ -251,7 +251,7 @@ static struct clk_rcg2 disp_cc_mdss_edp_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_edp_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
@@ -265,7 +265,7 @@ static struct clk_rcg2 disp_cc_mdss_edp_pixel_clk_src = {
 	.mnd_width = 16,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_edp_pixel_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
@@ -279,7 +279,7 @@ static struct clk_rcg2 disp_cc_mdss_esc0_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_2,
 	.freq_tbl = ftbl_disp_cc_mdss_dp_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_esc0_clk_src",
 		.parent_data = disp_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
@@ -302,7 +302,7 @@ static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_4,
 	.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_mdp_clk_src",
 		.parent_data = disp_cc_parent_data_4,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
@@ -315,7 +315,7 @@ static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
 	.mnd_width = 8,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_6,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_pclk0_clk_src",
 		.parent_data = disp_cc_parent_data_6,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_6),
@@ -330,7 +330,7 @@ static struct clk_rcg2 disp_cc_mdss_rot_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_4,
 	.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_rot_clk_src",
 		.parent_data = disp_cc_parent_data_4,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
@@ -344,7 +344,7 @@ static struct clk_rcg2 disp_cc_mdss_vsync_clk_src = {
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
 	.freq_tbl = ftbl_disp_cc_mdss_dp_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "disp_cc_mdss_vsync_clk_src",
 		.parent_data = disp_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
@@ -356,7 +356,7 @@ static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
 	.reg = 0x10f0,
 	.shift = 0,
 	.width = 4,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_byte0_div_clk_src",
 		.parent_hws = (const struct clk_hw*[]){
 			&disp_cc_mdss_byte0_clk_src.clkr.hw,
@@ -370,7 +370,7 @@ static struct clk_regmap_div disp_cc_mdss_dp_link_div_clk_src = {
 	.reg = 0x1124,
 	.shift = 0,
 	.width = 4,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_dp_link_div_clk_src",
 		.parent_hws = (const struct clk_hw*[]){
 			&disp_cc_mdss_dp_link_clk_src.clkr.hw,
@@ -384,7 +384,7 @@ static struct clk_regmap_div disp_cc_mdss_edp_link_div_clk_src = {
 	.reg = 0x11b8,
 	.shift = 0,
 	.width = 4,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "disp_cc_mdss_edp_link_div_clk_src",
 		.parent_hws = (const struct clk_hw*[]){
 			&disp_cc_mdss_edp_link_clk_src.clkr.hw,
@@ -400,7 +400,7 @@ static struct clk_branch disp_cc_mdss_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x1050,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_ahb_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_ahb_clk_src.clkr.hw,
@@ -418,7 +418,7 @@ static struct clk_branch disp_cc_mdss_byte0_clk = {
 	.clkr = {
 		.enable_reg = 0x1030,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_byte0_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_byte0_clk_src.clkr.hw,
@@ -436,7 +436,7 @@ static struct clk_branch disp_cc_mdss_byte0_intf_clk = {
 	.clkr = {
 		.enable_reg = 0x1034,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_byte0_intf_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_byte0_div_clk_src.clkr.hw,
@@ -454,7 +454,7 @@ static struct clk_branch disp_cc_mdss_dp_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x104c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_dp_aux_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_aux_clk_src.clkr.hw,
@@ -472,7 +472,7 @@ static struct clk_branch disp_cc_mdss_dp_crypto_clk = {
 	.clkr = {
 		.enable_reg = 0x1044,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_dp_crypto_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_crypto_clk_src.clkr.hw,
@@ -490,7 +490,7 @@ static struct clk_branch disp_cc_mdss_dp_link_clk = {
 	.clkr = {
 		.enable_reg = 0x103c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_dp_link_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_link_clk_src.clkr.hw,
@@ -508,7 +508,7 @@ static struct clk_branch disp_cc_mdss_dp_link_intf_clk = {
 	.clkr = {
 		.enable_reg = 0x1040,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_dp_link_intf_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_link_div_clk_src.clkr.hw,
@@ -526,7 +526,7 @@ static struct clk_branch disp_cc_mdss_dp_pixel_clk = {
 	.clkr = {
 		.enable_reg = 0x1048,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_dp_pixel_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_dp_pixel_clk_src.clkr.hw,
@@ -544,7 +544,7 @@ static struct clk_branch disp_cc_mdss_edp_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x1060,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_edp_aux_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_edp_aux_clk_src.clkr.hw,
@@ -562,7 +562,7 @@ static struct clk_branch disp_cc_mdss_edp_link_clk = {
 	.clkr = {
 		.enable_reg = 0x1058,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_edp_link_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_edp_link_clk_src.clkr.hw,
@@ -580,7 +580,7 @@ static struct clk_branch disp_cc_mdss_edp_link_intf_clk = {
 	.clkr = {
 		.enable_reg = 0x105c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_edp_link_intf_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_edp_link_div_clk_src.clkr.hw
@@ -598,7 +598,7 @@ static struct clk_branch disp_cc_mdss_edp_pixel_clk = {
 	.clkr = {
 		.enable_reg = 0x1054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_edp_pixel_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_edp_pixel_clk_src.clkr.hw,
@@ -616,7 +616,7 @@ static struct clk_branch disp_cc_mdss_esc0_clk = {
 	.clkr = {
 		.enable_reg = 0x1038,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_esc0_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_esc0_clk_src.clkr.hw,
@@ -634,7 +634,7 @@ static struct clk_branch disp_cc_mdss_mdp_clk = {
 	.clkr = {
 		.enable_reg = 0x1014,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_mdp_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_mdp_clk_src.clkr.hw,
@@ -652,7 +652,7 @@ static struct clk_branch disp_cc_mdss_mdp_lut_clk = {
 	.clkr = {
 		.enable_reg = 0x1024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_mdp_lut_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_mdp_clk_src.clkr.hw,
@@ -670,7 +670,7 @@ static struct clk_branch disp_cc_mdss_non_gdsc_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x2004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_non_gdsc_ahb_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_ahb_clk_src.clkr.hw,
@@ -688,7 +688,7 @@ static struct clk_branch disp_cc_mdss_pclk0_clk = {
 	.clkr = {
 		.enable_reg = 0x1010,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_pclk0_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_pclk0_clk_src.clkr.hw,
@@ -706,7 +706,7 @@ static struct clk_branch disp_cc_mdss_rot_clk = {
 	.clkr = {
 		.enable_reg = 0x101c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_rot_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_rot_clk_src.clkr.hw,
@@ -724,7 +724,7 @@ static struct clk_branch disp_cc_mdss_rscc_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x200c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_rscc_ahb_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_ahb_clk_src.clkr.hw,
@@ -742,7 +742,7 @@ static struct clk_branch disp_cc_mdss_rscc_vsync_clk = {
 	.clkr = {
 		.enable_reg = 0x2008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_rscc_vsync_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_vsync_clk_src.clkr.hw,
@@ -760,7 +760,7 @@ static struct clk_branch disp_cc_mdss_vsync_clk = {
 	.clkr = {
 		.enable_reg = 0x102c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_mdss_vsync_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&disp_cc_mdss_vsync_clk_src.clkr.hw,
@@ -778,7 +778,7 @@ static struct clk_branch disp_cc_sleep_clk = {
 	.clkr = {
 		.enable_reg = 0x5004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "disp_cc_sleep_clk",
 			.ops = &clk_branch2_ops,
 		},
diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 423627d49719..ccecd3d8a6d9 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2020-2022, The Linux Foundation. All rights reserved.
  */

 #include <linux/clk-provider.h>
@@ -45,10 +45,10 @@ static struct clk_alpha_pll gcc_gpll0 = {
 	.clkr = {
 		.enable_reg = 0x52010,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_gpll0",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_fixed_lucid_ops,
@@ -68,7 +68,7 @@ static struct clk_alpha_pll_postdiv gcc_gpll0_out_even = {
 	.num_post_div = ARRAY_SIZE(post_div_table_gcc_gpll0_out_even),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_gpll0_out_even",
 		.parent_hws = (const struct clk_hw*[]){
 			&gcc_gpll0.clkr.hw,
@@ -90,7 +90,7 @@ static struct clk_alpha_pll_postdiv gcc_gpll0_out_odd = {
 	.num_post_div = ARRAY_SIZE(post_div_table_gcc_gpll0_out_odd),
 	.width = 4,
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_gpll0_out_odd",
 		.parent_hws = (const struct clk_hw*[]){
 			&gcc_gpll0.clkr.hw,
@@ -106,10 +106,10 @@ static struct clk_alpha_pll gcc_gpll1 = {
 	.clkr = {
 		.enable_reg = 0x52010,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_gpll1",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_fixed_lucid_ops,
@@ -123,10 +123,10 @@ static struct clk_alpha_pll gcc_gpll10 = {
 	.clkr = {
 		.enable_reg = 0x52010,
 		.enable_mask = BIT(9),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_gpll10",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_fixed_lucid_ops,
@@ -140,10 +140,10 @@ static struct clk_alpha_pll gcc_gpll4 = {
 	.clkr = {
 		.enable_reg = 0x52010,
 		.enable_mask = BIT(4),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_gpll4",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_fixed_lucid_ops,
@@ -157,10 +157,10 @@ static struct clk_alpha_pll gcc_gpll9 = {
 	.clkr = {
 		.enable_reg = 0x52010,
 		.enable_mask = BIT(8),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_gpll9",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_fixed_lucid_ops,
@@ -173,7 +173,7 @@ static struct clk_branch gcc_mss_gpll0_main_div_clk_src = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(17),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_mss_gpll0_main_div_clk_src",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_gpll0_out_even.clkr.hw,
@@ -192,7 +192,7 @@ static const struct parent_map gcc_parent_map_0[] = {
 };

 static const struct clk_parent_data gcc_parent_data_0[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 	{ .hw = &gcc_gpll0.clkr.hw },
 	{ .hw = &gcc_gpll0_out_even.clkr.hw },
 };
@@ -205,7 +205,7 @@ static const struct parent_map gcc_parent_map_1[] = {
 };

 static const struct clk_parent_data gcc_parent_data_1[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 	{ .hw = &gcc_gpll0.clkr.hw },
 	{ .hw = &gcc_gpll0_out_odd.clkr.hw },
 	{ .hw = &gcc_gpll0_out_even.clkr.hw },
@@ -217,8 +217,8 @@ static const struct parent_map gcc_parent_map_2[] = {
 };

 static const struct clk_parent_data gcc_parent_data_2[] = {
-	{ .fw_name = "bi_tcxo" },
-	{ .fw_name = "sleep_clk" },
+	{ .index = 0 }, /* bi_tcxo */
+	{ .index = 2 }, /* sleep_clk */
 };

 static const struct parent_map gcc_parent_map_3[] = {
@@ -226,7 +226,7 @@ static const struct parent_map gcc_parent_map_3[] = {
 };

 static const struct clk_parent_data gcc_parent_data_3[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 };

 static const struct parent_map gcc_parent_map_4[] = {
@@ -238,10 +238,10 @@ static const struct parent_map gcc_parent_map_4[] = {
 };

 static const struct clk_parent_data gcc_parent_data_4[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 	{ .hw = &gcc_gpll0.clkr.hw },
 	{ .hw = &gcc_gpll0_out_odd.clkr.hw },
-	{ .fw_name = "sleep_clk" },
+	{ .index = 2 }, /* sleep_clk */
 	{ .hw = &gcc_gpll0_out_even.clkr.hw },
 };

@@ -251,7 +251,7 @@ static const struct parent_map gcc_parent_map_5[] = {
 };

 static const struct clk_parent_data gcc_parent_data_5[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 	{ .hw = &gcc_gpll0_out_even.clkr.hw },
 };

@@ -262,7 +262,7 @@ static const struct parent_map gcc_parent_map_6[] = {

 static const struct clk_parent_data gcc_parent_data_6[] = {
 	{ .fw_name = "pcie_0_pipe_clk", .name = "pcie_0_pipe_clk" },
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 };

 static const struct parent_map gcc_parent_map_7[] = {
@@ -272,7 +272,7 @@ static const struct parent_map gcc_parent_map_7[] = {

 static const struct clk_parent_data gcc_parent_data_7[] = {
 	{ .fw_name = "pcie_1_pipe_clk", .name = "pcie_1_pipe_clk" },
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 };

 static const struct parent_map gcc_parent_map_8[] = {
@@ -284,7 +284,7 @@ static const struct parent_map gcc_parent_map_8[] = {
 };

 static const struct clk_parent_data gcc_parent_data_8[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 	{ .hw = &gcc_gpll0.clkr.hw },
 	{ .hw = &gcc_gpll0_out_odd.clkr.hw },
 	{ .hw = &gcc_gpll10.clkr.hw },
@@ -301,7 +301,7 @@ static const struct parent_map gcc_parent_map_9[] = {
 };

 static const struct clk_parent_data gcc_parent_data_9[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 	{ .hw = &gcc_gpll0.clkr.hw },
 	{ .hw = &gcc_gpll9.clkr.hw },
 	{ .hw = &gcc_gpll0_out_odd.clkr.hw },
@@ -316,7 +316,7 @@ static const struct parent_map gcc_parent_map_10[] = {

 static const struct clk_parent_data gcc_parent_data_10[] = {
 	{ .fw_name = "ufs_phy_rx_symbol_0_clk" },
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 };

 static const struct parent_map gcc_parent_map_11[] = {
@@ -326,7 +326,7 @@ static const struct parent_map gcc_parent_map_11[] = {

 static const struct clk_parent_data gcc_parent_data_11[] = {
 	{ .fw_name = "ufs_phy_rx_symbol_1_clk" },
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 };

 static const struct parent_map gcc_parent_map_12[] = {
@@ -336,7 +336,7 @@ static const struct parent_map gcc_parent_map_12[] = {

 static const struct clk_parent_data gcc_parent_data_12[] = {
 	{ .fw_name = "ufs_phy_tx_symbol_0_clk" },
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 };

 static const struct parent_map gcc_parent_map_13[] = {
@@ -346,7 +346,7 @@ static const struct parent_map gcc_parent_map_13[] = {

 static const struct clk_parent_data gcc_parent_data_13[] = {
 	{ .fw_name = "usb3_phy_wrapper_gcc_usb30_pipe_clk" },
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 };

 static const struct parent_map gcc_parent_map_14[] = {
@@ -356,7 +356,7 @@ static const struct parent_map gcc_parent_map_14[] = {

 static const struct clk_parent_data gcc_parent_data_14[] = {
 	{ .fw_name = "usb3_phy_wrapper_gcc_usb30_pipe_clk" },
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 };

 static const struct parent_map gcc_parent_map_15[] = {
@@ -365,7 +365,7 @@ static const struct parent_map gcc_parent_map_15[] = {
 };

 static const struct clk_parent_data gcc_parent_data_15[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 }, /* bi_tcxo */
 	{ .hw = &gcc_mss_gpll0_main_div_clk_src.clkr.hw },
 };

@@ -375,7 +375,7 @@ static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
 	.width = 2,
 	.parent_map = gcc_parent_map_6,
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk_src",
 			.parent_data = gcc_parent_data_6,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_6),
@@ -390,7 +390,7 @@ static struct clk_regmap_mux gcc_pcie_1_pipe_clk_src = {
 	.width = 2,
 	.parent_map = gcc_parent_map_7,
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk_src",
 			.parent_data = gcc_parent_data_7,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
@@ -405,7 +405,7 @@ static struct clk_regmap_mux gcc_ufs_phy_rx_symbol_0_clk_src = {
 	.width = 2,
 	.parent_map = gcc_parent_map_10,
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ufs_phy_rx_symbol_0_clk_src",
 			.parent_data = gcc_parent_data_10,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_10),
@@ -420,7 +420,7 @@ static struct clk_regmap_mux gcc_ufs_phy_rx_symbol_1_clk_src = {
 	.width = 2,
 	.parent_map = gcc_parent_map_11,
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ufs_phy_rx_symbol_1_clk_src",
 			.parent_data = gcc_parent_data_11,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_11),
@@ -435,7 +435,7 @@ static struct clk_regmap_mux gcc_ufs_phy_tx_symbol_0_clk_src = {
 	.width = 2,
 	.parent_map = gcc_parent_map_12,
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ufs_phy_tx_symbol_0_clk_src",
 			.parent_data = gcc_parent_data_12,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_12),
@@ -450,7 +450,7 @@ static struct clk_regmap_mux gcc_usb3_prim_phy_pipe_clk_src = {
 	.width = 2,
 	.parent_map = gcc_parent_map_13,
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb3_prim_phy_pipe_clk_src",
 			.parent_data = gcc_parent_data_13,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_13),
@@ -465,7 +465,7 @@ static struct clk_regmap_mux gcc_usb3_sec_phy_pipe_clk_src = {
 	.width = 2,
 	.parent_map = gcc_parent_map_14,
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb3_sec_phy_pipe_clk_src",
 			.parent_data = gcc_parent_data_14,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_14),
@@ -487,7 +487,7 @@ static struct clk_rcg2 gcc_gp1_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_4,
 	.freq_tbl = ftbl_gcc_gp1_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_gp1_clk_src",
 		.parent_data = gcc_parent_data_4,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
@@ -501,7 +501,7 @@ static struct clk_rcg2 gcc_gp2_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_4,
 	.freq_tbl = ftbl_gcc_gp1_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_gp2_clk_src",
 		.parent_data = gcc_parent_data_4,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
@@ -515,7 +515,7 @@ static struct clk_rcg2 gcc_gp3_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_4,
 	.freq_tbl = ftbl_gcc_gp1_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_gp3_clk_src",
 		.parent_data = gcc_parent_data_4,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
@@ -535,7 +535,7 @@ static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_2,
 	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_pcie_0_aux_clk_src",
 		.parent_data = gcc_parent_data_2,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
@@ -555,7 +555,7 @@ static struct clk_rcg2 gcc_pcie_0_phy_rchng_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_pcie_0_phy_rchng_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -569,7 +569,7 @@ static struct clk_rcg2 gcc_pcie_1_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_2,
 	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_pcie_1_aux_clk_src",
 		.parent_data = gcc_parent_data_2,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
@@ -583,7 +583,7 @@ static struct clk_rcg2 gcc_pcie_1_phy_rchng_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_pcie_1_phy_rchng_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -603,7 +603,7 @@ static struct clk_rcg2 gcc_pdm2_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_pdm2_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_pdm2_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -626,7 +626,7 @@ static struct clk_rcg2 gcc_qspi_core_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_qspi_core_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_qspi_core_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -944,7 +944,7 @@ static struct clk_rcg2 gcc_sdcc1_apps_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_8,
 	.freq_tbl = ftbl_gcc_sdcc1_apps_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_sdcc1_apps_clk_src",
 		.parent_data = gcc_parent_data_8,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
@@ -965,7 +965,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_sdcc1_ice_core_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_sdcc1_ice_core_clk_src",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
@@ -989,7 +989,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_9,
 	.freq_tbl = ftbl_gcc_sdcc2_apps_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_9,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_9),
@@ -1013,7 +1013,7 @@ static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_sdcc4_apps_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_sdcc4_apps_clk_src",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
@@ -1035,7 +1035,7 @@ static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_ufs_phy_axi_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_ufs_phy_axi_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -1056,7 +1056,7 @@ static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_ufs_phy_ice_core_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_ufs_phy_ice_core_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -1070,7 +1070,7 @@ static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_3,
 	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_ufs_phy_phy_aux_clk_src",
 		.parent_data = gcc_parent_data_3,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
@@ -1084,7 +1084,7 @@ static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_0,
 	.freq_tbl = ftbl_gcc_ufs_phy_ice_core_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_ufs_phy_unipro_core_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
@@ -1106,7 +1106,7 @@ static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_1,
 	.freq_tbl = ftbl_gcc_usb30_prim_master_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_usb30_prim_master_clk_src",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
@@ -1125,7 +1125,7 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_3,
 	.freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_usb30_prim_mock_utmi_clk_src",
 		.parent_data = gcc_parent_data_3,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
@@ -1145,7 +1145,7 @@ static struct clk_rcg2 gcc_usb30_sec_master_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_5,
 	.freq_tbl = ftbl_gcc_usb30_sec_master_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_usb30_sec_master_clk_src",
 		.parent_data = gcc_parent_data_5,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
@@ -1159,7 +1159,7 @@ static struct clk_rcg2 gcc_usb30_sec_mock_utmi_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_3,
 	.freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_usb30_sec_mock_utmi_clk_src",
 		.parent_data = gcc_parent_data_3,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
@@ -1173,7 +1173,7 @@ static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_2,
 	.freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_usb3_prim_phy_aux_clk_src",
 		.parent_data = gcc_parent_data_2,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
@@ -1187,7 +1187,7 @@ static struct clk_rcg2 gcc_usb3_sec_phy_aux_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_2,
 	.freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_usb3_sec_phy_aux_clk_src",
 		.parent_data = gcc_parent_data_2,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
@@ -1207,7 +1207,7 @@ static struct clk_rcg2 gcc_sec_ctrl_clk_src = {
 	.hid_width = 5,
 	.parent_map = gcc_parent_map_3,
 	.freq_tbl = ftbl_gcc_sec_ctrl_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gcc_sec_ctrl_clk_src",
 		.parent_data = gcc_parent_data_3,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
@@ -1219,7 +1219,7 @@ static struct clk_regmap_div gcc_usb30_prim_mock_utmi_postdiv_clk_src = {
 	.reg = 0xf050,
 	.shift = 0,
 	.width = 4,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_usb30_prim_mock_utmi_postdiv_clk_src",
 		.parent_hws = (const struct clk_hw*[]){
 			&gcc_usb30_prim_mock_utmi_clk_src.clkr.hw,
@@ -1234,7 +1234,7 @@ static struct clk_regmap_div gcc_usb30_sec_mock_utmi_postdiv_clk_src = {
 	.reg = 0x9e050,
 	.shift = 0,
 	.width = 4,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gcc_usb30_sec_mock_utmi_postdiv_clk_src",
 		.parent_hws = (const struct clk_hw*[]){
 			&gcc_usb30_sec_mock_utmi_clk_src.clkr.hw,
@@ -1251,7 +1251,7 @@ static struct clk_branch gcc_pcie_clkref_en = {
 	.clkr = {
 		.enable_reg = 0x8c004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_clkref_en",
 			.ops = &clk_branch2_ops,
 		},
@@ -1264,7 +1264,7 @@ static struct clk_branch gcc_edp_clkref_en = {
 	.clkr = {
 		.enable_reg = 0x8c008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_edp_clkref_en",
 			.ops = &clk_branch2_ops,
 		},
@@ -1279,7 +1279,7 @@ static struct clk_branch gcc_aggre_noc_pcie_0_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(12),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_aggre_noc_pcie_0_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1294,7 +1294,7 @@ static struct clk_branch gcc_aggre_noc_pcie_1_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(11),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_aggre_noc_pcie_1_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1309,7 +1309,7 @@ static struct clk_branch gcc_aggre_noc_pcie_tbu_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(18),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_aggre_noc_pcie_tbu_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1324,7 +1324,7 @@ static struct clk_branch gcc_aggre_noc_pcie_center_sf_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(28),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_aggre_noc_pcie_center_sf_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1339,7 +1339,7 @@ static struct clk_branch gcc_aggre_ufs_phy_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x770cc,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_aggre_ufs_phy_axi_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_ufs_phy_axi_clk_src.clkr.hw,
@@ -1359,7 +1359,7 @@ static struct clk_branch gcc_aggre_usb3_prim_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xf080,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_aggre_usb3_prim_axi_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_usb30_prim_master_clk_src.clkr.hw,
@@ -1379,7 +1379,7 @@ static struct clk_branch gcc_aggre_usb3_sec_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x9e080,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_aggre_usb3_sec_axi_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_usb30_sec_master_clk_src.clkr.hw,
@@ -1399,7 +1399,7 @@ static struct clk_branch gcc_camera_hf_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x26010,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_camera_hf_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1414,7 +1414,7 @@ static struct clk_branch gcc_camera_sf_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x2601c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_camera_sf_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1429,7 +1429,7 @@ static struct clk_branch gcc_cfg_noc_usb3_prim_axi_clk = {
 	.clkr = {
 		.enable_reg = 0xf07c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_cfg_noc_usb3_prim_axi_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_usb30_prim_master_clk_src.clkr.hw,
@@ -1449,7 +1449,7 @@ static struct clk_branch gcc_cfg_noc_usb3_sec_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x9e07c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_cfg_noc_usb3_sec_axi_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_usb30_sec_master_clk_src.clkr.hw,
@@ -1469,7 +1469,7 @@ static struct clk_branch gcc_ddrss_gpu_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x71154,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ddrss_gpu_axi_clk",
 			.ops = &clk_branch2_aon_ops,
 		},
@@ -1484,7 +1484,7 @@ static struct clk_branch gcc_ddrss_pcie_sf_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(19),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ddrss_pcie_sf_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1496,7 +1496,7 @@ static struct clk_branch gcc_disp_gpll0_clk_src = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(7),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_disp_gpll0_clk_src",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_gpll0.clkr.hw,
@@ -1516,7 +1516,7 @@ static struct clk_branch gcc_disp_hf_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x2700c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_disp_hf_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1531,7 +1531,7 @@ static struct clk_branch gcc_disp_sf_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x27014,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_disp_sf_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1544,7 +1544,7 @@ static struct clk_branch gcc_gp1_clk = {
 	.clkr = {
 		.enable_reg = 0x64000,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_gp1_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_gp1_clk_src.clkr.hw,
@@ -1562,7 +1562,7 @@ static struct clk_branch gcc_gp2_clk = {
 	.clkr = {
 		.enable_reg = 0x65000,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_gp2_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_gp2_clk_src.clkr.hw,
@@ -1580,7 +1580,7 @@ static struct clk_branch gcc_gp3_clk = {
 	.clkr = {
 		.enable_reg = 0x66000,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_gp3_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_gp3_clk_src.clkr.hw,
@@ -1597,7 +1597,7 @@ static struct clk_branch gcc_gpu_gpll0_clk_src = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(15),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_gpu_gpll0_clk_src",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_gpll0.clkr.hw,
@@ -1614,7 +1614,7 @@ static struct clk_branch gcc_gpu_gpll0_div_clk_src = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(16),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_gpu_gpll0_div_clk_src",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_gpll0_out_even.clkr.hw,
@@ -1632,7 +1632,7 @@ static struct clk_branch gcc_gpu_iref_en = {
 	.clkr = {
 		.enable_reg = 0x8c014,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_gpu_iref_en",
 			.ops = &clk_branch2_ops,
 		},
@@ -1647,7 +1647,7 @@ static struct clk_branch gcc_gpu_memnoc_gfx_clk = {
 	.clkr = {
 		.enable_reg = 0x7100c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_gpu_memnoc_gfx_clk",
 			.ops = &clk_branch2_aon_ops,
 		},
@@ -1660,7 +1660,7 @@ static struct clk_branch gcc_gpu_snoc_dvm_gfx_clk = {
 	.clkr = {
 		.enable_reg = 0x71018,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_gpu_snoc_dvm_gfx_clk",
 			.ops = &clk_branch2_aon_ops,
 		},
@@ -1673,7 +1673,7 @@ static struct clk_branch gcc_pcie0_phy_rchng_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(22),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie0_phy_rchng_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_pcie_0_phy_rchng_clk_src.clkr.hw,
@@ -1691,7 +1691,7 @@ static struct clk_branch gcc_pcie1_phy_rchng_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(23),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie1_phy_rchng_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_pcie_1_phy_rchng_clk_src.clkr.hw,
@@ -1709,7 +1709,7 @@ static struct clk_branch gcc_pcie_0_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(3),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_0_aux_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_pcie_0_aux_clk_src.clkr.hw,
@@ -1729,7 +1729,7 @@ static struct clk_branch gcc_pcie_0_cfg_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(2),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_0_cfg_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1742,7 +1742,7 @@ static struct clk_branch gcc_pcie_0_mstr_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(1),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_0_mstr_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1755,7 +1755,7 @@ static struct clk_branch gcc_pcie_0_pipe_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(4),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_0_pipe_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_pcie_0_pipe_clk_src.clkr.hw,
@@ -1773,7 +1773,7 @@ static struct clk_branch gcc_pcie_0_slv_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_0_slv_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1786,7 +1786,7 @@ static struct clk_branch gcc_pcie_0_slv_q2a_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(5),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_0_slv_q2a_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1799,7 +1799,7 @@ static struct clk_branch gcc_pcie_1_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(29),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_1_aux_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_pcie_1_aux_clk_src.clkr.hw,
@@ -1819,7 +1819,7 @@ static struct clk_branch gcc_pcie_1_cfg_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(28),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_1_cfg_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1832,7 +1832,7 @@ static struct clk_branch gcc_pcie_1_mstr_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(27),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_1_mstr_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1845,7 +1845,7 @@ static struct clk_branch gcc_pcie_1_pipe_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(30),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_1_pipe_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_pcie_1_pipe_clk_src.clkr.hw,
@@ -1863,7 +1863,7 @@ static struct clk_branch gcc_pcie_1_slv_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(26),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_1_slv_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1876,7 +1876,7 @@ static struct clk_branch gcc_pcie_1_slv_q2a_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(25),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_1_slv_q2a_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1891,7 +1891,7 @@ static struct clk_branch gcc_pcie_throttle_core_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(20),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pcie_throttle_core_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1904,7 +1904,7 @@ static struct clk_branch gcc_pdm2_clk = {
 	.clkr = {
 		.enable_reg = 0x3300c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pdm2_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_pdm2_clk_src.clkr.hw,
@@ -1924,7 +1924,7 @@ static struct clk_branch gcc_pdm_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x33004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pdm_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1937,7 +1937,7 @@ static struct clk_branch gcc_pdm_xo4_clk = {
 	.clkr = {
 		.enable_reg = 0x33008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_pdm_xo4_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1952,7 +1952,7 @@ static struct clk_branch gcc_qmip_camera_nrt_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x26008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qmip_camera_nrt_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1967,7 +1967,7 @@ static struct clk_branch gcc_qmip_camera_rt_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x2600c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qmip_camera_rt_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1980,7 +1980,7 @@ static struct clk_branch gcc_qmip_disp_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x27008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qmip_disp_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -1995,7 +1995,7 @@ static struct clk_branch gcc_qmip_video_vcodec_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x28008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qmip_video_vcodec_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2010,7 +2010,7 @@ static struct clk_branch gcc_qspi_cnoc_periph_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x4b004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qspi_cnoc_periph_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2023,7 +2023,7 @@ static struct clk_branch gcc_qspi_core_clk = {
 	.clkr = {
 		.enable_reg = 0x4b008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qspi_core_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qspi_core_clk_src.clkr.hw,
@@ -2041,7 +2041,7 @@ static struct clk_branch gcc_qupv3_wrap0_core_2x_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(9),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_core_2x_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2054,7 +2054,7 @@ static struct clk_branch gcc_qupv3_wrap0_core_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(8),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_core_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2067,7 +2067,7 @@ static struct clk_branch gcc_qupv3_wrap0_s0_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(10),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s0_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap0_s0_clk_src.clkr.hw,
@@ -2085,7 +2085,7 @@ static struct clk_branch gcc_qupv3_wrap0_s1_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(11),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s1_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap0_s1_clk_src.clkr.hw,
@@ -2103,7 +2103,7 @@ static struct clk_branch gcc_qupv3_wrap0_s2_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(12),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s2_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap0_s2_clk_src.clkr.hw,
@@ -2121,7 +2121,7 @@ static struct clk_branch gcc_qupv3_wrap0_s3_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(13),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s3_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap0_s3_clk_src.clkr.hw,
@@ -2139,7 +2139,7 @@ static struct clk_branch gcc_qupv3_wrap0_s4_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(14),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s4_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap0_s4_clk_src.clkr.hw,
@@ -2157,7 +2157,7 @@ static struct clk_branch gcc_qupv3_wrap0_s5_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(15),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s5_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap0_s5_clk_src.clkr.hw,
@@ -2175,7 +2175,7 @@ static struct clk_branch gcc_qupv3_wrap0_s6_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(16),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s6_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap0_s6_clk_src.clkr.hw,
@@ -2193,7 +2193,7 @@ static struct clk_branch gcc_qupv3_wrap0_s7_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(17),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap0_s7_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap0_s7_clk_src.clkr.hw,
@@ -2211,7 +2211,7 @@ static struct clk_branch gcc_qupv3_wrap1_core_2x_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(18),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_core_2x_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2224,7 +2224,7 @@ static struct clk_branch gcc_qupv3_wrap1_core_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(19),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_core_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2237,7 +2237,7 @@ static struct clk_branch gcc_qupv3_wrap1_s0_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(22),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s0_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap1_s0_clk_src.clkr.hw,
@@ -2255,7 +2255,7 @@ static struct clk_branch gcc_qupv3_wrap1_s1_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(23),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s1_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap1_s1_clk_src.clkr.hw,
@@ -2273,7 +2273,7 @@ static struct clk_branch gcc_qupv3_wrap1_s2_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(24),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s2_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap1_s2_clk_src.clkr.hw,
@@ -2291,7 +2291,7 @@ static struct clk_branch gcc_qupv3_wrap1_s3_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(25),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s3_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap1_s3_clk_src.clkr.hw,
@@ -2309,7 +2309,7 @@ static struct clk_branch gcc_qupv3_wrap1_s4_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(26),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s4_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap1_s4_clk_src.clkr.hw,
@@ -2327,7 +2327,7 @@ static struct clk_branch gcc_qupv3_wrap1_s5_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(27),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s5_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap1_s5_clk_src.clkr.hw,
@@ -2345,7 +2345,7 @@ static struct clk_branch gcc_qupv3_wrap1_s6_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(13),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s6_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap1_s6_clk_src.clkr.hw,
@@ -2363,7 +2363,7 @@ static struct clk_branch gcc_qupv3_wrap1_s7_clk = {
 	.clkr = {
 		.enable_reg = 0x52000,
 		.enable_mask = BIT(14),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap1_s7_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_qupv3_wrap1_s7_clk_src.clkr.hw,
@@ -2383,7 +2383,7 @@ static struct clk_branch gcc_qupv3_wrap_0_m_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(6),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap_0_m_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2398,7 +2398,7 @@ static struct clk_branch gcc_qupv3_wrap_0_s_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(7),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap_0_s_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2413,7 +2413,7 @@ static struct clk_branch gcc_qupv3_wrap_1_m_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(20),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap_1_m_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2428,7 +2428,7 @@ static struct clk_branch gcc_qupv3_wrap_1_s_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x52008,
 		.enable_mask = BIT(21),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_qupv3_wrap_1_s_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2441,7 +2441,7 @@ static struct clk_branch gcc_sdcc1_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x75004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_sdcc1_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2454,7 +2454,7 @@ static struct clk_branch gcc_sdcc1_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x75008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_sdcc1_apps_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_sdcc1_apps_clk_src.clkr.hw,
@@ -2474,7 +2474,7 @@ static struct clk_branch gcc_sdcc1_ice_core_clk = {
 	.clkr = {
 		.enable_reg = 0x75024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_sdcc1_ice_core_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_sdcc1_ice_core_clk_src.clkr.hw,
@@ -2492,7 +2492,7 @@ static struct clk_branch gcc_sdcc2_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x14008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_sdcc2_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2505,7 +2505,7 @@ static struct clk_branch gcc_sdcc2_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x14004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_sdcc2_apps_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_sdcc2_apps_clk_src.clkr.hw,
@@ -2523,7 +2523,7 @@ static struct clk_branch gcc_sdcc4_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x16008,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_sdcc4_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2536,7 +2536,7 @@ static struct clk_branch gcc_sdcc4_apps_clk = {
 	.clkr = {
 		.enable_reg = 0x16004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_sdcc4_apps_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_sdcc4_apps_clk_src.clkr.hw,
@@ -2554,7 +2554,7 @@ static struct clk_branch gcc_throttle_pcie_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x9001c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_throttle_pcie_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2569,7 +2569,7 @@ static struct clk_branch gcc_titan_nrt_throttle_core_clk = {
 	.clkr = {
 		.enable_reg = 0x26024,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_titan_nrt_throttle_core_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2584,7 +2584,7 @@ static struct clk_branch gcc_titan_rt_throttle_core_clk = {
 	.clkr = {
 		.enable_reg = 0x26018,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_titan_rt_throttle_core_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2597,7 +2597,7 @@ static struct clk_branch gcc_ufs_1_clkref_en = {
 	.clkr = {
 		.enable_reg = 0x8c000,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ufs_1_clkref_en",
 			.ops = &clk_branch2_ops,
 		},
@@ -2612,7 +2612,7 @@ static struct clk_branch gcc_ufs_phy_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x77018,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ufs_phy_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2627,7 +2627,7 @@ static struct clk_branch gcc_ufs_phy_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x77010,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ufs_phy_axi_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_ufs_phy_axi_clk_src.clkr.hw,
@@ -2647,7 +2647,7 @@ static struct clk_branch gcc_ufs_phy_ice_core_clk = {
 	.clkr = {
 		.enable_reg = 0x77064,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ufs_phy_ice_core_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_ufs_phy_ice_core_clk_src.clkr.hw,
@@ -2667,7 +2667,7 @@ static struct clk_branch gcc_ufs_phy_phy_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x7709c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ufs_phy_phy_aux_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_ufs_phy_phy_aux_clk_src.clkr.hw,
@@ -2685,7 +2685,7 @@ static struct clk_branch gcc_ufs_phy_rx_symbol_0_clk = {
 	.clkr = {
 		.enable_reg = 0x77020,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ufs_phy_rx_symbol_0_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_ufs_phy_rx_symbol_0_clk_src.clkr.hw,
@@ -2703,7 +2703,7 @@ static struct clk_branch gcc_ufs_phy_rx_symbol_1_clk = {
 	.clkr = {
 		.enable_reg = 0x770b8,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ufs_phy_rx_symbol_1_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_ufs_phy_rx_symbol_1_clk_src.clkr.hw,
@@ -2721,7 +2721,7 @@ static struct clk_branch gcc_ufs_phy_tx_symbol_0_clk = {
 	.clkr = {
 		.enable_reg = 0x7701c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ufs_phy_tx_symbol_0_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_ufs_phy_tx_symbol_0_clk_src.clkr.hw,
@@ -2741,7 +2741,7 @@ static struct clk_branch gcc_ufs_phy_unipro_core_clk = {
 	.clkr = {
 		.enable_reg = 0x7705c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_ufs_phy_unipro_core_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_ufs_phy_unipro_core_clk_src.clkr.hw,
@@ -2759,7 +2759,7 @@ static struct clk_branch gcc_usb30_prim_master_clk = {
 	.clkr = {
 		.enable_reg = 0xf010,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb30_prim_master_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_usb30_prim_master_clk_src.clkr.hw,
@@ -2777,7 +2777,7 @@ static struct clk_branch gcc_usb30_prim_mock_utmi_clk = {
 	.clkr = {
 		.enable_reg = 0xf01c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb30_prim_mock_utmi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw =
@@ -2796,7 +2796,7 @@ static struct clk_branch gcc_usb30_prim_sleep_clk = {
 	.clkr = {
 		.enable_reg = 0xf018,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb30_prim_sleep_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2809,7 +2809,7 @@ static struct clk_branch gcc_usb30_sec_master_clk = {
 	.clkr = {
 		.enable_reg = 0x9e010,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb30_sec_master_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_usb30_sec_master_clk_src.clkr.hw,
@@ -2827,7 +2827,7 @@ static struct clk_branch gcc_usb30_sec_mock_utmi_clk = {
 	.clkr = {
 		.enable_reg = 0x9e01c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb30_sec_mock_utmi_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.hw =
@@ -2846,7 +2846,7 @@ static struct clk_branch gcc_usb30_sec_sleep_clk = {
 	.clkr = {
 		.enable_reg = 0x9e018,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb30_sec_sleep_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2859,7 +2859,7 @@ static struct clk_branch gcc_usb3_prim_phy_aux_clk = {
 	.clkr = {
 		.enable_reg = 0xf054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb3_prim_phy_aux_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
@@ -2877,7 +2877,7 @@ static struct clk_branch gcc_usb3_prim_phy_com_aux_clk = {
 	.clkr = {
 		.enable_reg = 0xf058,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb3_prim_phy_com_aux_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
@@ -2897,7 +2897,7 @@ static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
 	.clkr = {
 		.enable_reg = 0xf05c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb3_prim_phy_pipe_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_usb3_prim_phy_pipe_clk_src.clkr.hw,
@@ -2915,7 +2915,7 @@ static struct clk_branch gcc_cfg_noc_lpass_clk = {
 	.clkr = {
 		.enable_reg = 0x47020,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_cfg_noc_lpass_clk",
 			.ops = &clk_branch2_aon_ops,
 		},
@@ -2927,7 +2927,7 @@ static struct clk_branch gcc_mss_cfg_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x8a000,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_mss_cfg_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2940,7 +2940,7 @@ static struct clk_branch gcc_mss_offline_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x8a004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_mss_offline_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2953,7 +2953,7 @@ static struct clk_branch gcc_mss_snoc_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x8a154,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_mss_snoc_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2966,7 +2966,7 @@ static struct clk_branch gcc_mss_q6_memnoc_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x8a158,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_mss_q6_memnoc_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -2979,7 +2979,7 @@ static struct clk_regmap_mux gcc_mss_q6ss_boot_clk_src = {
 	.width = 1,
 	.parent_map = gcc_parent_map_15,
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_mss_q6ss_boot_clk_src",
 			.parent_data = gcc_parent_data_15,
 			.num_parents = ARRAY_SIZE(gcc_parent_data_15),
@@ -2994,7 +2994,7 @@ static struct clk_branch gcc_usb3_sec_phy_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x9e054,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb3_sec_phy_aux_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_usb3_sec_phy_aux_clk_src.clkr.hw,
@@ -3012,7 +3012,7 @@ static struct clk_branch gcc_usb3_sec_phy_com_aux_clk = {
 	.clkr = {
 		.enable_reg = 0x9e058,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb3_sec_phy_com_aux_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_usb3_sec_phy_aux_clk_src.clkr.hw,
@@ -3032,7 +3032,7 @@ static struct clk_branch gcc_usb3_sec_phy_pipe_clk = {
 	.clkr = {
 		.enable_reg = 0x9e05c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_usb3_sec_phy_pipe_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gcc_usb3_sec_phy_pipe_clk_src.clkr.hw,
@@ -3052,7 +3052,7 @@ static struct clk_branch gcc_video_axi0_clk = {
 	.clkr = {
 		.enable_reg = 0x2800c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_video_axi0_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -3067,7 +3067,7 @@ static struct clk_branch gcc_video_mvp_throttle_core_clk = {
 	.clkr = {
 		.enable_reg = 0x28010,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_video_mvp_throttle_core_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -3080,7 +3080,7 @@ static struct clk_branch gcc_wpss_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x9d154,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_wpss_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -3093,7 +3093,7 @@ static struct clk_branch gcc_wpss_ahb_bdg_mst_clk = {
 	.clkr = {
 		.enable_reg = 0x9d158,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_wpss_ahb_bdg_mst_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -3106,7 +3106,7 @@ static struct clk_branch gcc_wpss_rscp_clk = {
 	.clkr = {
 		.enable_reg = 0x9d16c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gcc_wpss_rscp_clk",
 			.ops = &clk_branch2_ops,
 		},
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

