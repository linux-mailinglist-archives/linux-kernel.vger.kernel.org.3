Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6224C566A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbiBZNx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiBZNxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:35 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2032117C94;
        Sat, 26 Feb 2022 05:52:54 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s14so11179748edw.0;
        Sat, 26 Feb 2022 05:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xQwB9tv6EZaO3CEL38CijCl4rCEjyAj0oWNoeeHAoVA=;
        b=J9DqM0hLVJYWkHAE5EmHkeXiGwLzgvKFvTwAPpd5FWwMtnWMbo59M95U7AqojRh0ww
         LVaryFYj13+px3PcrmdEKlgUzVxsPMeNR+NBqWtOqrZIwFJXwEMMcPaRhdpzjPY6hMWK
         LB0qMG/cbnvG9k+rVelzLcaNYiPIiq7Cow+Q8uubaZ0I9tCVVTTI362CHimeR8JgQJGk
         LVCdTn0m/VLIXXI7dcNyLn3mWts51HdJc3+DlQ8Xg9V5X3sicZF2L7M5t7gWYPcVOw+f
         c/XXCBjdGj09uU5kKk8k5Upg6E+qpCI0Au6OdGR3ZfOeuwGcKjE6EkVmZXgKFu0g/ZpM
         E0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQwB9tv6EZaO3CEL38CijCl4rCEjyAj0oWNoeeHAoVA=;
        b=c18d3yrvWl1WQYHaTWTSxX5b8+/ecHbxIRNRdpZjtwSF8D9ZeNBwunXqvZXlovhYRz
         30Ah87Myz2/M1bE8X7CxtV/Y4us6xSBRUUo1DKXDCZ50YtXE7G1xbUdHS33Qy1xsv3sM
         k+pb9FVGrRVGKFJFaUNXXBbJW8wL7Xgd0z8WuQZ3ltEYamExoFTEq2UtLK8SVs6D1KeX
         fDSdTZXDK0EmKoKywnozBSnvmHKXHUOMMAm7rK3G/KMC2bRxiyXmemsUIA5GBr+3VFpb
         Jg9fQ6Ise1LcdjxF/qX1t6mhE0FDYQy1ADjvRJ1bjhoyfTrvNg7W/jUB/ikPGMpt38aa
         SqOw==
X-Gm-Message-State: AOAM531hhFCSfdxb8wuWpxXgvtf0Qu6QC6Xc+uJF0IpOKH3gvovoNPYH
        R1L+0lAVUg+nF9S8soFuR6s=
X-Google-Smtp-Source: ABdhPJw3mGU7/L33FLXVkWOBzjPT9aA6CnPge9+T2C42zwSwVFJncbQT6Qe6jhYAMm7u+RuK7RMQvg==
X-Received: by 2002:a05:6402:4384:b0:413:9e36:b56f with SMTP id o4-20020a056402438400b004139e36b56fmr862400edc.280.1645883573104;
        Sat, 26 Feb 2022 05:52:53 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:52 -0800 (PST)
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
Subject: [PATCH v6 12/15] clk: qcom: gcc-ipq806x: add CryptoEngine clocks
Date:   Sat, 26 Feb 2022 14:52:32 +0100
Message-Id: <20220226135235.10051-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220226135235.10051-1-ansuelsmth@gmail.com>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
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

Add missing CryptoEngine clocks and pll11 required clock.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/gcc-ipq806x.c | 244 +++++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index f3d56519eee5..711a8b421e8b 100644
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
@@ -2824,6 +2881,186 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
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
@@ -2831,6 +3068,7 @@ static struct clk_regmap *gcc_ipq806x_clks[] = {
 	[PLL4_VOTE] = &pll4_vote,
 	[PLL8] = &pll8.clkr,
 	[PLL8_VOTE] = &pll8_vote,
+	[PLL11] = &pll11.clkr,
 	[PLL14] = &pll14.clkr,
 	[PLL14_VOTE] = &pll14_vote,
 	[PLL18] = &pll18.clkr,
@@ -2945,6 +3183,12 @@ static struct clk_regmap *gcc_ipq806x_clks[] = {
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
2.34.1

