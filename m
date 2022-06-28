Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0D155E138
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiF1I6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242244AbiF1I6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:58:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742B4B4B;
        Tue, 28 Jun 2022 01:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1B1D61548;
        Tue, 28 Jun 2022 08:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4475EC3411D;
        Tue, 28 Jun 2022 08:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656406711;
        bh=5S9xPKZrc7nmOZmYexyOwDlb74dnXm3mkY7WwiGdm34=;
        h=From:To:Cc:Subject:Date:From;
        b=WpXPbMzf1KsgHn5mb3ndtqAD+Fvn6oLjzotcwyKdV/vq2FuGmc+Abnshd3Vl/6Ast
         YlmP3fvwCeEO3vbMtyU+0CSCIxqxuuyxGBfvYBJviLXkLBfM6inzPc527Due+CivO3
         0q+KYNZp3RLZr7xFAyG6UYJzeTCXAlnMdtDVIdpXhzsvXafB69D8tgDLRXXKPOuvDF
         7zodsPotdl/4BiOqWoVkGOMYNmK5CL7FW2+eZe+kpgC5S/m9Y9LTrSaqVqJFNJg1ak
         SsfL9TsaTtHQrx0lLu1rREfzE3jZdCBNr+jobK/k0rnsoED5Aw5H5eIcgXOmDdLHSs
         33nYHYEOXer4A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o673C-0004EL-OM; Tue, 28 Jun 2022 10:58:27 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] clk: qcom: gcc-sc8280xp: use phy-mux clock for PCIe
Date:   Tue, 28 Jun 2022 10:57:07 +0200
Message-Id: <20220628085707.16214-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new phy-mux clock implementation for the PCIe pipe clock muxes
so that the pipe clock source is set to the QMP PHY PLL when the
downstream pipe clock is enabled and restored to the always-on XO when
it is again disabled.

This is needed to prevent the corresponding GDSC from hanging when
enabling or disabling the PCIe power domain, something which requires a
ticking source.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/gcc-sc8280xp.c | 121 ++++++++------------------------
 1 file changed, 31 insertions(+), 90 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index f186ddf6954e..a2f3ffcc5849 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -20,6 +20,7 @@
 #include "clk-regmap.h"
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
+#include "clk-regmap-phy-mux.h"
 #include "common.h"
 #include "gdsc.h"
 #include "reset.h"
@@ -82,11 +83,6 @@ enum {
 	P_GCC_USB4_PHY_PCIE_PIPEGMUX_CLK_SRC,
 	P_GCC_USB4_PHY_PIPEGMUX_CLK_SRC,
 	P_GCC_USB4_PHY_SYS_PIPEGMUX_CLK_SRC,
-	P_PCIE_2A_PIPE_CLK,
-	P_PCIE_2B_PIPE_CLK,
-	P_PCIE_3A_PIPE_CLK,
-	P_PCIE_3B_PIPE_CLK,
-	P_PCIE_4_PIPE_CLK,
 	P_QUSB4PHY_1_GCC_USB4_RX0_CLK,
 	P_QUSB4PHY_1_GCC_USB4_RX1_CLK,
 	P_QUSB4PHY_GCC_USB4_RX0_CLK,
@@ -351,56 +347,6 @@ static const struct clk_parent_data gcc_parent_data_9[] = {
 	{ .hw = &gcc_gpll0_out_even.clkr.hw },
 };
 
-static const struct parent_map gcc_parent_map_10[] = {
-	{ P_PCIE_2A_PIPE_CLK, 0 },
-	{ P_BI_TCXO, 2 },
-};
-
-static const struct clk_parent_data gcc_parent_data_10[] = {
-	{ .index = DT_PCIE_2A_PIPE_CLK },
-	{ .index = DT_BI_TCXO },
-};
-
-static const struct parent_map gcc_parent_map_11[] = {
-	{ P_PCIE_2B_PIPE_CLK, 0 },
-	{ P_BI_TCXO, 2 },
-};
-
-static const struct clk_parent_data gcc_parent_data_11[] = {
-	{ .index = DT_PCIE_2B_PIPE_CLK },
-	{ .index = DT_BI_TCXO },
-};
-
-static const struct parent_map gcc_parent_map_12[] = {
-	{ P_PCIE_3A_PIPE_CLK, 0 },
-	{ P_BI_TCXO, 2 },
-};
-
-static const struct clk_parent_data gcc_parent_data_12[] = {
-	{ .index = DT_PCIE_3A_PIPE_CLK },
-	{ .index = DT_BI_TCXO },
-};
-
-static const struct parent_map gcc_parent_map_13[] = {
-	{ P_PCIE_3B_PIPE_CLK, 0 },
-	{ P_BI_TCXO, 2 },
-};
-
-static const struct clk_parent_data gcc_parent_data_13[] = {
-	{ .index = DT_PCIE_3B_PIPE_CLK },
-	{ .index = DT_BI_TCXO },
-};
-
-static const struct parent_map gcc_parent_map_14[] = {
-	{ P_PCIE_4_PIPE_CLK, 0 },
-	{ P_BI_TCXO, 2 },
-};
-
-static const struct clk_parent_data gcc_parent_data_14[] = {
-	{ .index = DT_PCIE_4_PIPE_CLK },
-	{ .index = DT_BI_TCXO },
-};
-
 static const struct parent_map gcc_parent_map_15[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GCC_GPLL0_OUT_MAIN, 1 },
@@ -741,77 +687,72 @@ static const struct clk_parent_data gcc_parent_data_41[] = {
 	{ .index = DT_USB4_PHY_GCC_USB4_PCIE_PIPE_CLK },
 };
 
-static struct clk_regmap_mux gcc_pcie_2a_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_2a_pipe_clk_src = {
 	.reg = 0x9d05c,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_10,
 	.clkr = {
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_2a_pipe_clk_src",
-			.parent_data = gcc_parent_data_10,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_10),
-			.ops = &clk_regmap_mux_closest_ops,
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_PCIE_2A_PIPE_CLK,
+			},
+			.num_parents = 1,
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_2b_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_2b_pipe_clk_src = {
 	.reg = 0x9e05c,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_11,
 	.clkr = {
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_2b_pipe_clk_src",
-			.parent_data = gcc_parent_data_11,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_11),
-			.ops = &clk_regmap_mux_closest_ops,
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_PCIE_2B_PIPE_CLK,
+			},
+			.num_parents = 1,
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_3a_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_3a_pipe_clk_src = {
 	.reg = 0xa005c,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_12,
 	.clkr = {
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_3a_pipe_clk_src",
-			.parent_data = gcc_parent_data_12,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_12),
-			.ops = &clk_regmap_mux_closest_ops,
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_PCIE_3A_PIPE_CLK,
+			},
+			.num_parents = 1,
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_3b_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_3b_pipe_clk_src = {
 	.reg = 0xa205c,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_13,
 	.clkr = {
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_3b_pipe_clk_src",
-			.parent_data = gcc_parent_data_13,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_13),
-			.ops = &clk_regmap_mux_closest_ops,
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_PCIE_3B_PIPE_CLK,
+			},
+			.num_parents = 1,
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
 
-static struct clk_regmap_mux gcc_pcie_4_pipe_clk_src = {
+static struct clk_regmap_phy_mux gcc_pcie_4_pipe_clk_src = {
 	.reg = 0x6b05c,
-	.shift = 0,
-	.width = 2,
-	.parent_map = gcc_parent_map_14,
 	.clkr = {
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_pcie_4_pipe_clk_src",
-			.parent_data = gcc_parent_data_14,
-			.num_parents = ARRAY_SIZE(gcc_parent_data_14),
-			.ops = &clk_regmap_mux_closest_ops,
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_PCIE_4_PIPE_CLK,
+			},
+			.num_parents = 1,
+			.ops = &clk_regmap_phy_mux_ops,
 		},
 	},
 };
-- 
2.35.1

