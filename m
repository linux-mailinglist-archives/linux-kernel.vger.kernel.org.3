Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3734A77C9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiBBSVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:21:15 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:24802 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234473AbiBBSVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:21:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1643826073; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=00lZqAy3JgHwy8QZ/4SSrtFd9A6S8UTHdA19weFzwNs=; b=DUwAc5ilhae7P6lRFKM1SRUu17ce4PSQRwFeZ2ColY98LbcpJTKXw9Z5WXlVc0OKtgK3J4Dj
 EyDcqMzlM0j/SosfTe24NtrCp2RhMoWzrNRQZhpsN8UIiGidlaEvKjn4Q2x1knPaSfogDDg6
 ZGBDIV9YKAdQYkISB0CHHG6oRqM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61facb99e0d9ede916180c4a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Feb 2022 18:21:13
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 69304C4360D; Wed,  2 Feb 2022 18:21:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.0
Received: from hu-tdas-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 033DFC4360C;
        Wed,  2 Feb 2022 18:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 033DFC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1 2/2] clk: qcom: sc7280: Update clk_init_data to const for clock controllers
Date:   Wed,  2 Feb 2022 23:50:53 +0530
Message-Id: <20220202182053.22925-2-tdas@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220202182053.22925-1-tdas@codeaurora.org>
References: <20220202182053.22925-1-tdas@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update clk_init_data to const and also use index instead of fw_name for
graphics, lpasscc and video clock controller.

Fixes: 3e0f01d6c7e74 ("clk: qcom: Add graphics clock controller driver for SC7280")
Fixes: 4ab43d171181d ("clk: qcom: Add lpass clock controller driver for SC7280")
Fixes: fae7617bb1428 ("clk: qcom: Add video clock controller driver for SC7280")
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/gpucc-sc7280.c   | 56 +++++++++++++++----------------
 drivers/clk/qcom/lpasscc-sc7280.c | 14 ++++----
 drivers/clk/qcom/videocc-sc7280.c | 26 +++++++-------
 3 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
index 9a832f2bcf49..e8f6abc5261f 100644
--- a/drivers/clk/qcom/gpucc-sc7280.c
+++ b/drivers/clk/qcom/gpucc-sc7280.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022, The Linux Foundation. All rights reserved.
  */

 #include <linux/clk-provider.h>
@@ -36,10 +36,10 @@ static struct clk_alpha_pll gpu_cc_pll0 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_pll0",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -65,10 +65,10 @@ static struct clk_alpha_pll gpu_cc_pll1 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_pll1",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -85,11 +85,11 @@ static const struct parent_map gpu_cc_parent_map_0[] = {
 };

 static const struct clk_parent_data gpu_cc_parent_data_0[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &gpu_cc_pll0.clkr.hw },
 	{ .hw = &gpu_cc_pll1.clkr.hw },
-	{ .fw_name = "gcc_gpu_gpll0_clk_src" },
-	{ .fw_name = "gcc_gpu_gpll0_div_clk_src" },
+	{ .index = 1 }, /* gcc_gpu_gpll0_clk_src */
+	{ .index = 2 }, /* gcc_gpu_gpll0_div_clk_src */
 };

 static const struct parent_map gpu_cc_parent_map_1[] = {
@@ -100,10 +100,10 @@ static const struct parent_map gpu_cc_parent_map_1[] = {
 };

 static const struct clk_parent_data gpu_cc_parent_data_1[] = {
-	{ .fw_name = "bi_tcxo", },
+	{ .index = 0, },
 	{ .hw = &gpu_cc_pll1.clkr.hw },
-	{ .fw_name = "gcc_gpu_gpll0_clk_src", },
-	{ .fw_name = "gcc_gpu_gpll0_div_clk_src", },
+	{ .index = 1 }, /* gcc_gpu_gpll0_clk_src */
+	{ .index = 2 }, /* gcc_gpu_gpll0_div_clk_src */
 };

 static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
@@ -119,7 +119,7 @@ static struct clk_rcg2 gpu_cc_gmu_clk_src = {
 	.hid_width = 5,
 	.parent_map = gpu_cc_parent_map_0,
 	.freq_tbl = ftbl_gpu_cc_gmu_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gpu_cc_gmu_clk_src",
 		.parent_data = gpu_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_0),
@@ -140,7 +140,7 @@ static struct clk_rcg2 gpu_cc_hub_clk_src = {
 	.hid_width = 5,
 	.parent_map = gpu_cc_parent_map_1,
 	.freq_tbl = ftbl_gpu_cc_hub_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "gpu_cc_hub_clk_src",
 		.parent_data = gpu_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_1),
@@ -152,7 +152,7 @@ static struct clk_regmap_div gpu_cc_hub_ahb_div_clk_src = {
 	.reg = 0x11c0,
 	.shift = 0,
 	.width = 4,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gpu_cc_hub_ahb_div_clk_src",
 		.parent_hws = (const struct clk_hw*[]){
 			&gpu_cc_hub_clk_src.clkr.hw,
@@ -167,7 +167,7 @@ static struct clk_regmap_div gpu_cc_hub_cx_int_div_clk_src = {
 	.reg = 0x11bc,
 	.shift = 0,
 	.width = 4,
-	.clkr.hw.init = &(struct clk_init_data) {
+	.clkr.hw.init = &(const struct clk_init_data) {
 		.name = "gpu_cc_hub_cx_int_div_clk_src",
 		.parent_hws = (const struct clk_hw*[]){
 			&gpu_cc_hub_clk_src.clkr.hw,
@@ -184,7 +184,7 @@ static struct clk_branch gpu_cc_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x1078,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_ahb_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gpu_cc_hub_ahb_div_clk_src.clkr.hw,
@@ -202,7 +202,7 @@ static struct clk_branch gpu_cc_crc_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x107c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_crc_ahb_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gpu_cc_hub_ahb_div_clk_src.clkr.hw,
@@ -220,7 +220,7 @@ static struct clk_branch gpu_cc_cx_gmu_clk = {
 	.clkr = {
 		.enable_reg = 0x1098,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_cx_gmu_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gpu_cc_gmu_clk_src.clkr.hw,
@@ -238,7 +238,7 @@ static struct clk_branch gpu_cc_cx_snoc_dvm_clk = {
 	.clkr = {
 		.enable_reg = 0x108c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_cx_snoc_dvm_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -251,7 +251,7 @@ static struct clk_branch gpu_cc_cxo_aon_clk = {
 	.clkr = {
 		.enable_reg = 0x1004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_cxo_aon_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -264,7 +264,7 @@ static struct clk_branch gpu_cc_cxo_clk = {
 	.clkr = {
 		.enable_reg = 0x109c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_cxo_clk",
 			.ops = &clk_branch2_aon_ops,
 		},
@@ -277,7 +277,7 @@ static struct clk_branch gpu_cc_gx_gmu_clk = {
 	.clkr = {
 		.enable_reg = 0x1064,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_gx_gmu_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gpu_cc_gmu_clk_src.clkr.hw,
@@ -295,7 +295,7 @@ static struct clk_branch gpu_cc_hlos1_vote_gpu_smmu_clk = {
 	.clkr = {
 		.enable_reg = 0x5000,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_hlos1_vote_gpu_smmu_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -308,7 +308,7 @@ static struct clk_branch gpu_cc_hub_aon_clk = {
 	.clkr = {
 		.enable_reg = 0x1178,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_hub_aon_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gpu_cc_hub_clk_src.clkr.hw,
@@ -326,7 +326,7 @@ static struct clk_branch gpu_cc_hub_cx_int_clk = {
 	.clkr = {
 		.enable_reg = 0x1204,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_hub_cx_int_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&gpu_cc_hub_cx_int_div_clk_src.clkr.hw,
@@ -344,7 +344,7 @@ static struct clk_branch gpu_cc_mnd1x_0_gfx3d_clk = {
 	.clkr = {
 		.enable_reg = 0x802c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_mnd1x_0_gfx3d_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -357,7 +357,7 @@ static struct clk_branch gpu_cc_mnd1x_1_gfx3d_clk = {
 	.clkr = {
 		.enable_reg = 0x8030,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_mnd1x_1_gfx3d_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -370,7 +370,7 @@ static struct clk_branch gpu_cc_sleep_clk = {
 	.clkr = {
 		.enable_reg = 0x1090,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "gpu_cc_sleep_clk",
 			.ops = &clk_branch2_ops,
 		},
diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
index b39ee1c9647b..ef055706b442 100644
--- a/drivers/clk/qcom/lpasscc-sc7280.c
+++ b/drivers/clk/qcom/lpasscc-sc7280.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022, The Linux Foundation. All rights reserved.
  */

 #include <linux/clk-provider.h>
@@ -23,7 +23,7 @@ static struct clk_branch lpass_q6ss_ahbm_clk = {
 	.clkr = {
 		.enable_reg = 0x1c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "lpass_q6ss_ahbm_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -36,7 +36,7 @@ static struct clk_branch lpass_q6ss_ahbs_clk = {
 	.clkr = {
 		.enable_reg = 0x20,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "lpass_q6ss_ahbs_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -49,7 +49,7 @@ static struct clk_branch lpass_top_cc_lpi_q6_axim_hs_clk = {
 	.clkr = {
 		.enable_reg = 0x0,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "lpass_top_cc_lpi_q6_axim_hs_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -63,7 +63,7 @@ static struct clk_branch lpass_qdsp6ss_core_clk = {
 	.clkr = {
 		.enable_reg = 0x20,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "lpass_qdsp6ss_core_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -77,7 +77,7 @@ static struct clk_branch lpass_qdsp6ss_xo_clk = {
 	.clkr = {
 		.enable_reg = 0x38,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "lpass_qdsp6ss_xo_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -91,7 +91,7 @@ static struct clk_branch lpass_qdsp6ss_sleep_clk = {
 	.clkr = {
 		.enable_reg = 0x3c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "lpass_qdsp6ss_sleep_clk",
 			.ops = &clk_branch2_ops,
 		},
diff --git a/drivers/clk/qcom/videocc-sc7280.c b/drivers/clk/qcom/videocc-sc7280.c
index 615695d82319..ba192ce6163e 100644
--- a/drivers/clk/qcom/videocc-sc7280.c
+++ b/drivers/clk/qcom/videocc-sc7280.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022, The Linux Foundation. All rights reserved.
  */

 #include <linux/clk-provider.h>
@@ -45,10 +45,10 @@ static struct clk_alpha_pll video_pll0 = {
 	.num_vco = ARRAY_SIZE(lucid_vco),
 	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
 	.clkr = {
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "video_pll0",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "bi_tcxo",
+				.index = 0,
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_lucid_ops,
@@ -62,7 +62,7 @@ static const struct parent_map video_cc_parent_map_0[] = {
 };

 static const struct clk_parent_data video_cc_parent_data_0[] = {
-	{ .fw_name = "bi_tcxo" },
+	{ .index = 0 },
 	{ .hw = &video_pll0.clkr.hw },
 };

@@ -89,7 +89,7 @@ static struct clk_rcg2 video_cc_iris_clk_src = {
 	.hid_width = 5,
 	.parent_map = video_cc_parent_map_0,
 	.freq_tbl = ftbl_video_cc_iris_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "video_cc_iris_clk_src",
 		.parent_data = video_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(video_cc_parent_data_0),
@@ -109,7 +109,7 @@ static struct clk_rcg2 video_cc_sleep_clk_src = {
 	.hid_width = 5,
 	.parent_map = video_cc_parent_map_1,
 	.freq_tbl = ftbl_video_cc_sleep_clk_src,
-	.clkr.hw.init = &(struct clk_init_data){
+	.clkr.hw.init = &(const struct clk_init_data){
 		.name = "video_cc_sleep_clk_src",
 		.parent_data = video_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(video_cc_parent_data_1),
@@ -123,7 +123,7 @@ static struct clk_branch video_cc_iris_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x5004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "video_cc_iris_ahb_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&video_cc_iris_clk_src.clkr.hw,
@@ -141,7 +141,7 @@ static struct clk_branch video_cc_mvs0_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x800c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "video_cc_mvs0_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -156,7 +156,7 @@ static struct clk_branch video_cc_mvs0_core_clk = {
 	.clkr = {
 		.enable_reg = 0x3010,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "video_cc_mvs0_core_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&video_cc_iris_clk_src.clkr.hw,
@@ -174,7 +174,7 @@ static struct clk_branch video_cc_mvsc_core_clk = {
 	.clkr = {
 		.enable_reg = 0x2014,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "video_cc_mvsc_core_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&video_cc_iris_clk_src.clkr.hw,
@@ -192,7 +192,7 @@ static struct clk_branch video_cc_mvsc_ctl_axi_clk = {
 	.clkr = {
 		.enable_reg = 0x8004,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "video_cc_mvsc_ctl_axi_clk",
 			.ops = &clk_branch2_ops,
 		},
@@ -205,7 +205,7 @@ static struct clk_branch video_cc_sleep_clk = {
 	.clkr = {
 		.enable_reg = 0x7034,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "video_cc_sleep_clk",
 			.parent_hws = (const struct clk_hw*[]){
 				&video_cc_sleep_clk_src.clkr.hw,
@@ -223,7 +223,7 @@ static struct clk_branch video_cc_venus_ahb_clk = {
 	.clkr = {
 		.enable_reg = 0x801c,
 		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
+		.hw.init = &(const struct clk_init_data){
 			.name = "video_cc_venus_ahb_clk",
 			.ops = &clk_branch2_ops,
 		},
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

