Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240CB491349
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbiARBCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244046AbiARBCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:02:05 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE09DC06161C;
        Mon, 17 Jan 2022 17:02:04 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z22so72643838edd.12;
        Mon, 17 Jan 2022 17:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cdRwCloUT8Thyo1nWTg/Cv6W0pfmm/eqyz83O1RekOs=;
        b=Ikm23nEs5gASUqJoTSmbWL5A2FTLi27PjBV534u7BNZ5fEjUiIShiC4jO2jf4FivbS
         Bgh2zciCPoK9XkO/daFf16ZpZxVhDdKOpHDmWCXUzK2yh7fOa/ZDJauvOK3hIi2ny2r8
         TK5xKbAbNFVzkWEnfeTGUB1k1y43vvCz3sfJPYSnjSqgwuVFMDHQUErTt7XbUonN/n7q
         yF0HbupOZY3ChFqqB3pDr2L6XoSp4U8wejagNfTYYuPHZO16SEKjhzW2uVK8f1xXW22R
         9PiMSJ+kVB+HJ6zZz/+0qS98B9j8uPC/o4QSlXSW/vfQT2F1E/dcNPhB/1wlnpMvDh/I
         lnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdRwCloUT8Thyo1nWTg/Cv6W0pfmm/eqyz83O1RekOs=;
        b=E/2MTPZD/VAGSof6yBjH8IgCrN9jl5O48Ewfu8TeQDFD9B3Geg6OpgdACo+h4WNiPw
         ccohEkT4j/mPdu9+CtLZAwVExZPTBywPJzDt7jXdf3w3k0PfsQm9tUnTNJf72LYANRDE
         Hn9AhBIhMauzyLIQRV8zzyVHnnnWH1K8GnY5Bxot2U1jtwoSZJ1e1X0GeRvHAFcwHg/8
         3EskDJdhFxNL3G9H6aontdV4XqZp1TnTDLD+tAg60vZcTAnMCnXYQyoaXajBevBVp8Hf
         QVSDpMXCkSSV7cvKAsA86QeI1sAn3NW3vyDzEhWLtl1zxko+ilgLZk85CBfzO3xNDKKA
         BYNQ==
X-Gm-Message-State: AOAM533VR4j/+gZJ3aOQ1OCe6L7t004tSymqoj3NXg0yf6J/hT7EikWm
        Z+iQBr77wYGvr2U5CYPaL7Q=
X-Google-Smtp-Source: ABdhPJyilzrFW6mHgMehvlQefLz0cNTJZpr0b1ZUqbg7xJeAs9MSA/AuPRR70k2TnN7SSBpGzXo0BA==
X-Received: by 2002:a17:907:6d8a:: with SMTP id sb10mr4773698ejc.86.1642467723283;
        Mon, 17 Jan 2022 17:02:03 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:02:02 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/14] drivers: clk: qcom: gcc-ipq806x: add CryptoEngine clocks
Date:   Tue, 18 Jan 2022 01:44:31 +0100
Message-Id: <20220118004434.17095-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118004434.17095-1-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
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
index 0923d7f79a1c..46d0fe511868 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -268,6 +268,24 @@ static struct clk_pll pll18 = {
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
@@ -276,6 +294,7 @@ enum {
 	P_CXO,
 	P_PLL14,
 	P_PLL18,
+	P_PLL11,
 };
 
 static const struct parent_map gcc_pxo_pll8_map[] = {
@@ -343,6 +362,44 @@ static const struct clk_parent_data gcc_pxo_pll8_pll14_pll18_pll0[] = {
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
@@ -2832,6 +2889,186 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
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
@@ -2839,6 +3076,7 @@ static struct clk_regmap *gcc_ipq806x_clks[] = {
 	[PLL4_VOTE] = &pll4_vote,
 	[PLL8] = &pll8.clkr,
 	[PLL8_VOTE] = &pll8_vote,
+	[PLL11] = &pll11.clkr,
 	[PLL14] = &pll14.clkr,
 	[PLL14_VOTE] = &pll14_vote,
 	[PLL18] = &pll18.clkr,
@@ -2953,6 +3191,12 @@ static struct clk_regmap *gcc_ipq806x_clks[] = {
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

