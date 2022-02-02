Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97F64A7808
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346676AbiBBSgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:36:02 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:33160 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346682AbiBBSgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:36:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1643826960; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=bPuNQ5BV1Y0jpL2+ia7+QmkWJsOhYeXGHx1JigiKIMA=; b=AqRfvbLLGAmcWpYR+SKd5s6PaJIqBWtOmmNBZgwoj0Drf42d60UcVAveE30gAg/96Gev7ZFe
 7jHlHZ9869KqhQCf0UoOuNhpfeoLj5huSa1CtbImaOSBAq5XYJz5Q3VMcXX+lo/uwdgoyrcr
 f8J3rclYIr3luPWCnI8QkMQUNUQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 61facf0a0ae862b7cf95f250 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Feb 2022 18:35:54
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4C3C1C4338F; Wed,  2 Feb 2022 18:35:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.0
Received: from hu-tdas-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CAD41C4338F;
        Wed,  2 Feb 2022 18:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CAD41C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1 3/4] clk: qcom: sc7280: Update clk_init_data to const for DISPCC
Date:   Thu,  3 Feb 2022 00:05:27 +0530
Message-Id: <20220202183528.3911-3-tdas@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220202183528.3911-1-tdas@codeaurora.org>
References: <20220202183528.3911-1-tdas@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update clk_init_data to const and also use index instead of fw_name for
display clock controller.

Fixes: 1a00c962f9cd0 ("clk: qcom: Add display clock controller driver for SC7280")
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/dispcc-sc7280.c | 102 +++++++++++++++----------------
 1 file changed, 51 insertions(+), 51 deletions(-)

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
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

