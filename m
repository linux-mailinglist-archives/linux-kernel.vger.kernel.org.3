Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5534F465AAF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354355AbhLBAZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:25:23 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:63476 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354312AbhLBAZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638404518; x=1669940518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9vhgz7xOqNcw0mOG2pqtZsqb8gR5GGwj+K4ByudHeSs=;
  b=zEuiTCbWAgW3g3ogB3eh1DFOLkjwUN2ea+Th3p6iPwBW78sZZ1MBlsbi
   0QfdCTkvgb6DzZ5aPYCLG0SwkwMVwgRp3cJevsaiPfKB0djBoq6q6Mvyj
   sdujm8qKDVBoX3cL85X5IHt5Z0nZJVNhiCMnx1/OJTzMZlW5mlYmiHNnc
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Dec 2021 16:21:58 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 16:21:57 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:21:57 -0800
Received: from hu-vamslank-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 16:21:56 -0800
From:   <quic_vamslank@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <manivannan.sadhasivam@linaro.org>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v6 2/5] clk: qcom: Add LUCID_EVO PLL type for SDX65
Date:   Wed, 1 Dec 2021 16:21:32 -0800
Message-ID: <7e1805ef3f7cddc1222906d8b8e5b79548b46f63.1638402361.git.quic_vamslank@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638402361.git.quic_vamslank@quicinc.com>
References: <cover.1638402361.git.quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>

Add a LUCID_EVO PLL type for SDX65 SoC from Qualcomm.

Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 204 +++++++++++++++++++++++++++----
 drivers/clk/qcom/clk-alpha-pll.h |   3 +
 2 files changed, 181 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index eaedcceb766f..e0c67b76d8ac 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/kernel.h>
@@ -139,6 +140,20 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_OPMODE] = 0x28,
 		[PLL_OFF_STATUS] = 0x38,
 	},
+	[CLK_ALPHA_PLL_TYPE_LUCID_EVO] = {
+		[PLL_OFF_OPMODE] = 0x04,
+		[PLL_OFF_STATUS] = 0x0c,
+		[PLL_OFF_L_VAL] = 0x10,
+		[PLL_OFF_ALPHA_VAL] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0x1c,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0x24,
+		[PLL_OFF_CONFIG_CTL_U1] = 0x28,
+		[PLL_OFF_TEST_CTL] = 0x2c,
+		[PLL_OFF_TEST_CTL_U] = 0x30,
+		[PLL_OFF_TEST_CTL_U1] = 0x34,
+        },
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 
@@ -175,6 +190,10 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 #define LUCID_5LPE_PLL_LATCH_INPUT	BIT(14)
 #define LUCID_5LPE_ENABLE_VOTE_RUN	BIT(21)
 
+/* LUCID EVO PLL specific settings and offsets */
+#define LUCID_EVO_ENABLE_VOTE_RUN       BIT(25)
+#define LUCID_EVO_PLL_L_VAL_MASK        GENMASK(15, 0)
+
 /* ZONDA PLL specific */
 #define ZONDA_PLL_OUT_MASK	0xf
 #define ZONDA_STAY_IN_CFA	BIT(16)
@@ -1741,35 +1760,47 @@ static int alpha_pll_lucid_5lpe_set_rate(struct clk_hw *hw, unsigned long rate,
 					  LUCID_5LPE_ALPHA_PLL_ACK_LATCH);
 }
 
+static int __clk_lucid_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
+                                            unsigned long parent_rate, unsigned long enable_vote_run)
+{
+        struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+        int i, val = 0, div, ret;
+        u32 mask;
+
+        /*
+         * If the PLL is in FSM mode, then treat set_rate callback as a
+         * no-operation.
+         */
+        ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
+        if (ret)
+                return ret;
+
+        if (val & enable_vote_run)
+                return 0;
+
+        if (!pll->post_div_table) {
+                pr_err("Missing the post_div_table for the PLL\n");
+                return -EINVAL;
+        }
+
+        div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+        for (i = 0; i < pll->num_post_div; i++) {
+                if (pll->post_div_table[i].div == div) {
+                        val = pll->post_div_table[i].val;
+                        break;
+                }
+        }
+
+        mask = GENMASK(pll->width + pll->post_div_shift - 1, pll->post_div_shift);
+        return regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+                                  mask, val << pll->post_div_shift);
+}
+
 static int clk_lucid_5lpe_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 					       unsigned long parent_rate)
 {
-	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
-	int i, val = 0, div, ret;
-	u32 mask;
-
-	/*
-	 * If the PLL is in FSM mode, then treat set_rate callback as a
-	 * no-operation.
-	 */
-	ret = regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &val);
-	if (ret)
-		return ret;
-
-	if (val & LUCID_5LPE_ENABLE_VOTE_RUN)
-		return 0;
-
-	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
-	for (i = 0; i < pll->num_post_div; i++) {
-		if (pll->post_div_table[i].div == div) {
-			val = pll->post_div_table[i].val;
-			break;
-		}
-	}
-
-	mask = GENMASK(pll->width + pll->post_div_shift - 1, pll->post_div_shift);
-	return regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
-				  mask, val << pll->post_div_shift);
+	return __clk_lucid_pll_postdiv_set_rate(hw, rate, parent_rate, LUCID_5LPE_ENABLE_VOTE_RUN);
 }
 
 const struct clk_ops clk_alpha_pll_lucid_5lpe_ops = {
@@ -1951,3 +1982,124 @@ const struct clk_ops clk_alpha_pll_zonda_ops = {
 	.set_rate = clk_zonda_pll_set_rate,
 };
 EXPORT_SYMBOL(clk_alpha_pll_zonda_ops);
+
+static int alpha_pll_lucid_evo_enable(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
+	if (ret)
+		return ret;
+
+	/* If in FSM mode, just vote for it */
+	if (val & LUCID_EVO_ENABLE_VOTE_RUN) {
+		ret = clk_enable_regmap(hw);
+		if (ret)
+			return ret;
+		return wait_for_pll_enable_lock(pll);
+	}
+
+	/* Check if PLL is already enabled */
+	ret = trion_pll_is_enabled(pll, regmap);
+	if (ret < 0)
+		return ret;
+	else if (ret) {
+		pr_warn("%s PLL is already enabled\n", clk_hw_get_name(&pll->clkr.hw));
+		return 0;
+	}
+
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+	if (ret)
+		return ret;
+
+	/* Set operation mode to RUN */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_RUN);
+
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret)
+		return ret;
+
+	/* Enable the PLL outputs */
+	ret = regmap_update_bits(regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, PLL_OUT_MASK);
+	if (ret)
+		return ret;
+
+	/* Enable the global PLL outputs */
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, PLL_OUTCTRL);
+	if (ret)
+		return ret;
+
+	/* Ensure that the write above goes through before returning. */
+	mb();
+	return ret;
+}
+
+static void alpha_pll_lucid_evo_disable(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
+	if (ret)
+		return;
+
+	/* If in FSM mode, just unvote it */
+	if (val & LUCID_EVO_ENABLE_VOTE_RUN) {
+		clk_disable_regmap(hw);
+		return;
+	}
+
+	/* Disable the global PLL output */
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+	if (ret)
+		return;
+
+	/* Disable the PLL outputs */
+	ret = regmap_update_bits(regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, 0);
+	if (ret)
+		return;
+
+	/* Place the PLL mode in STANDBY */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+}
+
+static unsigned long alpha_pll_lucid_evo_recalc_rate(struct clk_hw *hw,
+						     unsigned long parent_rate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 l, frac;
+
+	regmap_read(regmap, PLL_L_VAL(pll), &l);
+	l &= LUCID_EVO_PLL_L_VAL_MASK;
+	regmap_read(regmap, PLL_ALPHA_VAL(pll), &frac);
+
+	return alpha_pll_calc_rate(parent_rate, l, frac, pll_alpha_width(pll));
+}
+
+static int clk_lucid_evo_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
+					      unsigned long parent_rate)
+{
+	return __clk_lucid_pll_postdiv_set_rate(hw, rate, parent_rate, LUCID_EVO_ENABLE_VOTE_RUN);
+}
+
+const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops = {
+	.enable = alpha_pll_lucid_evo_enable,
+	.disable = alpha_pll_lucid_evo_disable,
+	.is_enabled = clk_trion_pll_is_enabled,
+	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
+	.round_rate = clk_alpha_pll_round_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_evo_ops);
+
+const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops = {
+	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
+	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
+	.set_rate = clk_lucid_evo_pll_postdiv_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_evo_ops);
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 55e4fa47912f..6e9907deaf30 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -17,6 +17,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_LUCID = CLK_ALPHA_PLL_TYPE_TRION,
 	CLK_ALPHA_PLL_TYPE_AGERA,
 	CLK_ALPHA_PLL_TYPE_ZONDA,
+	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
 	CLK_ALPHA_PLL_TYPE_MAX,
 };
 
@@ -151,6 +152,8 @@ extern const struct clk_ops clk_alpha_pll_postdiv_lucid_5lpe_ops;
 
 extern const struct clk_ops clk_alpha_pll_zonda_ops;
 #define clk_alpha_pll_postdiv_zonda_ops clk_alpha_pll_postdiv_fabia_ops
+extern const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops;
+extern const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops;
 
 void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 			     const struct alpha_pll_config *config);
-- 
2.33.1

