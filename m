Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB93A4956E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378301AbiATXVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378220AbiATXUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:47 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27F1C061574;
        Thu, 20 Jan 2022 15:20:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso25311700wmj.2;
        Thu, 20 Jan 2022 15:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vaOb6lzR+ohDnwzAKg4t+EygQuxBAzQ4LziIApjliUg=;
        b=hVo8QgLIr0GUAFf5yfHgbNNXb0waZUSjtFtYr85H6g9uTqfAl6o8AeXfggT/dSBSvy
         UuzG/mXnCCGpKALHZUsTai72QfX2afpBAvm7pxXK7/56SexDqGgZQMiBbd2h71aHbP7y
         JeN7wIGq63tX0RxV/3WGGM/OxUeI4xK+nRWG4RMBxkXc0EzxPL6N53jb3AQF8ZjqJ/lu
         TB9KGUoPXd7mk8913+CjiwNQ0Nw0YsQoDXU/ZLsGAsaLec+X5E9SUII3vug0zw57KF2L
         QpoJzYGh+9IdzXdhq8UG0wiax91HT4HF0fDHAyv/PP2eBlurLmAa14Wm1+5NfPJl5h6W
         DJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vaOb6lzR+ohDnwzAKg4t+EygQuxBAzQ4LziIApjliUg=;
        b=Bbrsj/zzrJ7U7Gk1AuPiD3qNkYxgCXysT7EG3bHu7SyanWIqP4hEK6ymRAry5lx3cX
         hVBoTf6XFEOtl5Skr8qWsKZN7aGhMQY33TEu7Wf9iZMp4hs+nJV4UB6pl+VsT96i4ckO
         Nj4SblKXuNAakL0OIpQmadFgT4qVrQsVlUxegSfY9thfUfmxO3ubXYrWp7NNZ/Ig7aiB
         SfH+Rgm4yW6EMUgsstuFEV7uT5AaZMhRWnKh/gGCxsiWwX8Uq0w3txlskFQTrMXioPw1
         s0W87Rlpimxw7eS8dmjNHhbR3fZujTZ2Gaqvurx980KwJcvoG1iP7DN0cEu88eu6wBIg
         PBfw==
X-Gm-Message-State: AOAM530fyG8h3ZAgHo4A+YuqtUBO4HdOxpdNLo4QO1WuG681QM9n65m+
        nYjdwZbjzVMB+OCxdkqDEROxXaHMurU=
X-Google-Smtp-Source: ABdhPJx7tj2wIsfBqlflD054IGOMw0pCyVCzxjHk2d8t1MK3mhogBAyj5t9dVFdAjovn3DyPl7MhVw==
X-Received: by 2002:a1c:7316:: with SMTP id d22mr11186776wmb.5.1642720845235;
        Thu, 20 Jan 2022 15:20:45 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:44 -0800 (PST)
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
Subject: [PATCH v2 12/15] drivers: clk: qcom: gcc-ipq806x: add CryptoEngine clocks
Date:   Fri, 21 Jan 2022 00:20:25 +0100
Message-Id: <20220120232028.6738-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing CryptoEngine clocks and pll11 required clock.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 244 +++++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index dbd61e4844b0..a86d1504a149 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -256,6 +256,24 @@ static struct clk_pll pll18 = {
 	},
 };
 
+static struct clk_pll pll11 = {
+	.l_reg = 0x3184,
+	.m_reg = 0x3188,
+	.n_reg = 0x318c,
+	.config_reg = 0x3194,
+	.mode_reg = 0x3180,
+	.status_reg = 0x3198,
+	.status_bit = 16,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "pll11",
+		.parent_data = &(const struct clk_parent_data){
+			.fw_name = "pxo",
+		},
+		.num_parents = 1,
+		.ops = &clk_pll_ops,
+	},
+};
+
 enum {
 	P_PXO,
 	P_PLL8,
@@ -264,6 +282,7 @@ enum {
 	P_CXO,
 	P_PLL14,
 	P_PLL18,
+	P_PLL11,
 };
 
 static const struct parent_map gcc_pxo_pll8_map[] = {
@@ -331,6 +350,44 @@ static const struct clk_parent_data gcc_pxo_pll8_pll14_pll18_pll0[] = {
 	{ .hw = &pll18.clkr.hw },
 };
 
+static const struct parent_map gcc_pxo_pll8_pll0_pll14_pll18_pll11_map[] = {
+	{ P_PXO, 0 },
+	{ P_PLL8, 4 },
+	{ P_PLL0, 2 },
+	{ P_PLL14, 5 },
+	{ P_PLL18, 1 },
+	{ P_PLL11, 3 },
+};
+
+static const struct clk_parent_data gcc_pxo_pll8_pll0_pll14_pll18_pll11[] = {
+	{ .fw_name = "pxo" },
+	{ .hw = &pll8_vote.hw },
+	{ .hw = &pll0_vote.hw },
+	{ .hw = &pll14.clkr.hw },
+	{ .hw = &pll18.clkr.hw },
+	{ .hw = &pll11.clkr.hw },
+
+};
+
+static const struct parent_map gcc_pxo_pll3_pll0_pll14_pll18_pll11_map[] = {
+	{ P_PXO, 0 },
+	{ P_PLL3, 6 },
+	{ P_PLL0, 2 },
+	{ P_PLL14, 5 },
+	{ P_PLL18, 1 },
+	{ P_PLL11, 3 },
+};
+
+static const struct clk_parent_data gcc_pxo_pll3_pll0_pll14_pll18_pll11[] = {
+	{ .fw_name = "pxo" },
+	{ .hw = &pll3.clkr.hw },
+	{ .hw = &pll0_vote.hw },
+	{ .hw = &pll14.clkr.hw },
+	{ .hw = &pll18.clkr.hw },
+	{ .hw = &pll11.clkr.hw },
+
+};
+
 static struct freq_tbl clk_tbl_gsbi_uart[] = {
 	{  1843200, P_PLL8, 2,  6, 625 },
 	{  3686400, P_PLL8, 2, 12, 625 },
@@ -2818,6 +2875,186 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
 	},
 };
 
+static const struct freq_tbl clk_tbl_ce5_core[] = {
+	{ 150000000, P_PLL3, 8, 1, 1 },
+	{ 213200000, P_PLL11, 5, 1, 1 },
+	{ }
+};
+
+static struct clk_dyn_rcg ce5_core_src = {
+	.ns_reg[0] = 0x36C4,
+	.ns_reg[1] = 0x36C8,
+	.bank_reg = 0x36C0,
+	.s[0] = {
+		.src_sel_shift = 0,
+		.parent_map = gcc_pxo_pll3_pll0_pll14_pll18_pll11_map,
+	},
+	.s[1] = {
+		.src_sel_shift = 0,
+		.parent_map = gcc_pxo_pll3_pll0_pll14_pll18_pll11_map,
+	},
+	.p[0] = {
+		.pre_div_shift = 3,
+		.pre_div_width = 4,
+	},
+	.p[1] = {
+		.pre_div_shift = 3,
+		.pre_div_width = 4,
+	},
+	.mux_sel_bit = 0,
+	.freq_tbl = clk_tbl_ce5_core,
+	.clkr = {
+		.enable_reg = 0x36C0,
+		.enable_mask = BIT(1),
+		.hw.init = &(struct clk_init_data){
+			.name = "ce5_core_src",
+			.parent_data = gcc_pxo_pll3_pll0_pll14_pll18_pll11,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll3_pll0_pll14_pll18_pll11),
+			.ops = &clk_dyn_rcg_ops,
+		},
+	},
+};
+
+static struct clk_branch ce5_core_clk = {
+	.halt_reg = 0x2FDC,
+	.halt_bit = 5,
+	.hwcg_reg = 0x36CC,
+	.hwcg_bit = 6,
+	.clkr = {
+		.enable_reg = 0x36CC,
+		.enable_mask = BIT(4),
+		.hw.init = &(struct clk_init_data){
+			.name = "ce5_core_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&ce5_core_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static const struct freq_tbl clk_tbl_ce5_a_clk[] = {
+	{ 160000000, P_PLL0, 5, 1, 1 },
+	{ 213200000, P_PLL11, 5, 1, 1 },
+	{ }
+};
+
+static struct clk_dyn_rcg ce5_a_clk_src = {
+	.ns_reg[0] = 0x3d84,
+	.ns_reg[1] = 0x3d88,
+	.bank_reg = 0x3d80,
+	.s[0] = {
+		.src_sel_shift = 0,
+		.parent_map = gcc_pxo_pll8_pll0_pll14_pll18_pll11_map,
+	},
+	.s[1] = {
+		.src_sel_shift = 0,
+		.parent_map = gcc_pxo_pll8_pll0_pll14_pll18_pll11_map,
+	},
+	.p[0] = {
+		.pre_div_shift = 3,
+		.pre_div_width = 4,
+	},
+	.p[1] = {
+		.pre_div_shift = 3,
+		.pre_div_width = 4,
+	},
+	.mux_sel_bit = 0,
+	.freq_tbl = clk_tbl_ce5_a_clk,
+	.clkr = {
+		.enable_reg = 0x3d80,
+		.enable_mask = BIT(1),
+		.hw.init = &(struct clk_init_data){
+			.name = "ce5_a_clk_src",
+			.parent_data = gcc_pxo_pll8_pll0_pll14_pll18_pll11,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0_pll14_pll18_pll11),
+			.ops = &clk_dyn_rcg_ops,
+		},
+	},
+};
+
+static struct clk_branch ce5_a_clk = {
+	.halt_reg = 0x3c20,
+	.halt_bit = 12,
+	.hwcg_reg = 0x3d8c,
+	.hwcg_bit = 6,
+	.clkr = {
+		.enable_reg = 0x3d8c,
+		.enable_mask = BIT(4),
+		.hw.init = &(struct clk_init_data){
+			.name = "ce5_a_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&ce5_a_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
+static const struct freq_tbl clk_tbl_ce5_h_clk[] = {
+	{ 160000000, P_PLL0, 5, 1, 1 },
+	{ 213200000, P_PLL11, 5, 1, 1 },
+	{ }
+};
+
+static struct clk_dyn_rcg ce5_h_clk_src = {
+	.ns_reg[0] = 0x3c64,
+	.ns_reg[1] = 0x3c68,
+	.bank_reg = 0x3c60,
+	.s[0] = {
+		.src_sel_shift = 0,
+		.parent_map = gcc_pxo_pll8_pll0_pll14_pll18_pll11_map,
+	},
+	.s[1] = {
+		.src_sel_shift = 0,
+		.parent_map = gcc_pxo_pll8_pll0_pll14_pll18_pll11_map,
+	},
+	.p[0] = {
+		.pre_div_shift = 3,
+		.pre_div_width = 4,
+	},
+	.p[1] = {
+		.pre_div_shift = 3,
+		.pre_div_width = 4,
+	},
+	.mux_sel_bit = 0,
+	.freq_tbl = clk_tbl_ce5_h_clk,
+	.clkr = {
+		.enable_reg = 0x3c60,
+		.enable_mask = BIT(1),
+		.hw.init = &(struct clk_init_data){
+			.name = "ce5_h_clk_src",
+			.parent_data = gcc_pxo_pll8_pll0_pll14_pll18_pll11,
+			.num_parents = ARRAY_SIZE(gcc_pxo_pll8_pll0_pll14_pll18_pll11),
+			.ops = &clk_dyn_rcg_ops,
+		},
+	},
+};
+
+static struct clk_branch ce5_h_clk = {
+	.halt_reg = 0x3c20,
+	.halt_bit = 11,
+	.hwcg_reg = 0x3c6c,
+	.hwcg_bit = 6,
+	.clkr = {
+		.enable_reg = 0x3c6c,
+		.enable_mask = BIT(4),
+		.hw.init = &(struct clk_init_data){
+			.name = "ce5_h_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&ce5_h_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.ops = &clk_branch_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
+
 static struct clk_regmap *gcc_ipq806x_clks[] = {
 	[PLL0] = &pll0.clkr,
 	[PLL0_VOTE] = &pll0_vote,
@@ -2825,6 +3062,7 @@ static struct clk_regmap *gcc_ipq806x_clks[] = {
 	[PLL4_VOTE] = &pll4_vote,
 	[PLL8] = &pll8.clkr,
 	[PLL8_VOTE] = &pll8_vote,
+	[PLL11] = &pll11.clkr,
 	[PLL14] = &pll14.clkr,
 	[PLL14_VOTE] = &pll14_vote,
 	[PLL18] = &pll18.clkr,
@@ -2939,6 +3177,12 @@ static struct clk_regmap *gcc_ipq806x_clks[] = {
 	[PLL9] = &hfpll0.clkr,
 	[PLL10] = &hfpll1.clkr,
 	[PLL12] = &hfpll_l2.clkr,
+	[CE5_A_CLK_SRC] = &ce5_a_clk_src.clkr,
+	[CE5_A_CLK] = &ce5_a_clk.clkr,
+	[CE5_H_CLK_SRC] = &ce5_h_clk_src.clkr,
+	[CE5_H_CLK] = &ce5_h_clk.clkr,
+	[CE5_CORE_CLK_SRC] = &ce5_core_src.clkr,
+	[CE5_CORE_CLK] = &ce5_core_clk.clkr,
 };
 
 static const struct qcom_reset_map gcc_ipq806x_resets[] = {
-- 
2.33.1

