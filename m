Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE255378D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353820AbiFUQL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353786AbiFUQLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:11:53 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6BC2D1D2;
        Tue, 21 Jun 2022 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655827913; x=1687363913;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=1kz04T5XOTRU8N0Tg0lzAop1DaYDyaZivZ0VPB7eI/A=;
  b=REJhx7sttQ5TGozHxigffu+vwxmX+buoa8ozeYbbdd43CbajT8RsGCaa
   m0VFzLiHi2Wtq/Z3YDn9xDJGI8Q1Evr6C0hVka7Sd+HcsRNK/FwdD9z2k
   2q/dupcPJXc7aO83wpp6rJzDFpu6HilkXrskAKrCTdFhacFoDhVxxeNVq
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Jun 2022 09:11:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 09:11:51 -0700
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 21 Jun 2022 09:11:51 -0700
Received: from srichara-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 21 Jun 2022 09:11:46 -0700
From:   Sricharan R <quic_srichara@quicinc.com>
To:     <quic_srichara@quicinc.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <p.zabel@pengutronix.de>,
        <quic_varada@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 1/8] clk: qcom: clk-alpha-pll: Add support for Stromer PLLs
Date:   Tue, 21 Jun 2022 21:41:19 +0530
Message-ID: <20220621161126.15883-2-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220621161126.15883-1-quic_srichara@quicinc.com>
References: <20220621161126.15883-1-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varadarajan Narayanan <quic_varada@quicinc.com>

Add programming sequence support for managing the Stromer
PLLs.

Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 100 ++++++++++++++++++++++++++++++-
 drivers/clk/qcom/clk-alpha-pll.h |   7 ++-
 2 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 4406cf609aae..08f11e32a57d 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -154,9 +154,24 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_TEST_CTL_U] = 0x30,
 		[PLL_OFF_TEST_CTL_U1] = 0x34,
 	},
+	[CLK_ALPHA_PLL_TYPE_STROMER] = {
+		[PLL_OFF_L_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL] = 0x10,
+		[PLL_OFF_ALPHA_VAL_U] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0x1c,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0xff,
+		[PLL_OFF_TEST_CTL] = 0x30,
+		[PLL_OFF_TEST_CTL_U] = 0x34,
+		[PLL_OFF_STATUS] = 0x28,
+	},
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 
+static unsigned long
+alpha_pll_round_rate(unsigned long rate, unsigned long prate, u32 *l, u64 *a,
+		     u32 alpha_width);
 /*
  * Even though 40 bits are present, use only 32 for ease of calculation.
  */
@@ -165,6 +180,8 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 #define ALPHA_BITWIDTH		32U
 #define ALPHA_SHIFT(w)		min(w, ALPHA_BITWIDTH)
 
+#define	ALPHA_PLL_STATUS_REG_SHIFT	8
+
 #define PLL_HUAYRA_M_WIDTH		8
 #define PLL_HUAYRA_M_SHIFT		8
 #define PLL_HUAYRA_M_MASK		0xff
@@ -273,7 +290,7 @@ static void clk_alpha_pll_write_config(struct regmap *regmap, unsigned int reg,
 void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 			     const struct alpha_pll_config *config)
 {
-	u32 val, mask;
+	u32 val, val_u, mask, mask_u;
 
 	regmap_write(regmap, PLL_L_VAL(pll), config->l);
 	regmap_write(regmap, PLL_ALPHA_VAL(pll), config->alpha);
@@ -303,14 +320,85 @@ void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 	mask |= config->pre_div_mask;
 	mask |= config->post_div_mask;
 	mask |= config->vco_mask;
+	mask |= config->alpha_en_mask;
+	mask |= config->alpha_mode_mask;
 
 	regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
 
+	/* Stromer APSS PLL does not enable LOCK_DET by default, so enable it */
+	val_u = config->status_reg_val << ALPHA_PLL_STATUS_REG_SHIFT;
+	val_u |= config->lock_det;
+
+	mask_u = config->status_reg_mask;
+	mask_u |= config->lock_det;
+
+	if (val_u)
+		regmap_update_bits(regmap, PLL_USER_CTL_U(pll), mask_u, val_u);
+
+	if (config->test_ctl_val)
+		regmap_write(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
+
+	if (config->test_ctl_hi_val)
+		regmap_write(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
+
 	if (pll->flags & SUPPORTS_FSM_MODE)
 		qcom_pll_set_fsm_mode(regmap, PLL_MODE(pll), 6, 0);
 }
 EXPORT_SYMBOL_GPL(clk_alpha_pll_configure);
 
+static int clk_alpha_pll_stromer_determine_rate(struct clk_hw *hw,
+						struct clk_rate_request *req)
+{
+	u32 l;
+	u64 a;
+
+	req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate,
+					 &l, &a, ALPHA_REG_BITWIDTH);
+
+	return 0;
+}
+
+static int clk_alpha_pll_stromer_set_rate(struct clk_hw *hw, unsigned long rate,
+					  unsigned long prate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 l;
+	int ret;
+	u64 a;
+
+	rate = alpha_pll_round_rate(rate, prate, &l, &a, ALPHA_REG_BITWIDTH);
+
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
+		     a >> ALPHA_BITWIDTH);
+
+	regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+			   PLL_ALPHA_EN, PLL_ALPHA_EN);
+
+	if (!clk_hw_is_enabled(hw))
+		return 0;
+
+	/*
+	 * Stromer PLL supports Dynamic programming.
+	 * It allows the PLL frequency to be changed on-the-fly without first
+	 * execution of a shutdown procedure followed by a bring up procedure.
+	 */
+
+	regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_UPDATE,
+			   PLL_UPDATE);
+
+	ret = wait_for_pll_update(pll);
+	if (ret)
+		return ret;
+
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int clk_alpha_pll_hwfsm_enable(struct clk_hw *hw)
 {
 	int ret;
@@ -961,6 +1049,16 @@ const struct clk_ops clk_alpha_pll_hwfsm_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_hwfsm_ops);
 
+const struct clk_ops clk_alpha_pll_stromer_ops = {
+	.enable = clk_alpha_pll_enable,
+	.disable = clk_alpha_pll_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = clk_alpha_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_stromer_determine_rate,
+	.set_rate = clk_alpha_pll_stromer_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_ops);
+
 const struct clk_ops clk_alpha_pll_fixed_trion_ops = {
 	.enable = clk_trion_pll_enable,
 	.disable = clk_trion_pll_disable,
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 6e9907deaf30..272a276a266d 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved. */
+/* Copyright (c) 2015, 2018, 2021 The Linux Foundation. All rights reserved. */
 
 #ifndef __QCOM_CLK_ALPHA_PLL_H__
 #define __QCOM_CLK_ALPHA_PLL_H__
@@ -18,6 +18,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_AGERA,
 	CLK_ALPHA_PLL_TYPE_ZONDA,
 	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
+	CLK_ALPHA_PLL_TYPE_STROMER,
 	CLK_ALPHA_PLL_TYPE_MAX,
 };
 
@@ -124,6 +125,9 @@ struct alpha_pll_config {
 	u32 post_div_mask;
 	u32 vco_val;
 	u32 vco_mask;
+	u32 status_reg_val;
+	u32 status_reg_mask;
+	u32 lock_det;
 };
 
 extern const struct clk_ops clk_alpha_pll_ops;
@@ -132,6 +136,7 @@ extern const struct clk_ops clk_alpha_pll_hwfsm_ops;
 extern const struct clk_ops clk_alpha_pll_postdiv_ops;
 extern const struct clk_ops clk_alpha_pll_huayra_ops;
 extern const struct clk_ops clk_alpha_pll_postdiv_ro_ops;
+extern const struct clk_ops clk_alpha_pll_stromer_ops;
 
 extern const struct clk_ops clk_alpha_pll_fabia_ops;
 extern const struct clk_ops clk_alpha_pll_fixed_fabia_ops;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

