Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248D9555334
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377656AbiFVSRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377622AbiFVSRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:17:48 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9485B3EBBD;
        Wed, 22 Jun 2022 11:17:44 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,212,1650898800"; 
   d="scan'208";a="125315340"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Jun 2022 03:17:43 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7689740C7F32;
        Thu, 23 Jun 2022 03:17:40 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] clk: renesas: r9a07g043: Add support for RZ/Five SoC
Date:   Wed, 22 Jun 2022 19:17:23 +0100
Message-Id: <20220622181723.13033-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220622181723.13033-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220622181723.13033-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renesas RZ/Five SoC has almost the same clock structure compared to the
Renesas RZ/G2UL SoC, re-use the r9a07g043-cpg.c file to add support for
RZ/Five SoC.

This patch splits up the clocks and reset arrays for RZ/G2UL and RZ/Five
SoC using #ifdef CONFIG_ARM64 and #ifdef CONFIG_RISCV checks.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 33c2bd8df2e5..37475465100d 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -36,9 +36,11 @@ enum clk_ids {
 	CLK_PLL3_DIV2_4_2,
 	CLK_SEL_PLL3_3,
 	CLK_DIV_PLL3_C,
+#ifdef CONFIG_ARM64
 	CLK_PLL5,
 	CLK_PLL5_500,
 	CLK_PLL5_250,
+#endif
 	CLK_PLL6,
 	CLK_PLL6_250,
 	CLK_P1_DIV2,
@@ -100,9 +102,11 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_FIXED(".pll3_533", CLK_PLL3_533, CLK_PLL3, 1, 3),
 	DEF_MUX_RO(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3, sel_pll3_3),
 	DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3, DIVPL3C, dtable_1_32),
+#ifdef CONFIG_ARM64
 	DEF_FIXED(".pll5", CLK_PLL5, CLK_EXTAL, 125, 1),
 	DEF_FIXED(".pll5_500", CLK_PLL5_500, CLK_PLL5, 1, 6),
 	DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_500, 1, 2),
+#endif
 	DEF_FIXED(".pll6", CLK_PLL6, CLK_EXTAL, 125, 6),
 	DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
 
@@ -126,12 +130,20 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 };
 
 static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
+#ifdef CONFIG_ARM64
 	DEF_MOD("gic",		R9A07G043_GIC600_GICCLK, R9A07G043_CLK_P1,
 				0x514, 0),
 	DEF_MOD("ia55_pclk",	R9A07G043_IA55_PCLK, R9A07G043_CLK_P2,
 				0x518, 0),
 	DEF_MOD("ia55_clk",	R9A07G043_IA55_CLK, R9A07G043_CLK_P1,
 				0x518, 1),
+#endif
+#ifdef CONFIG_RISCV
+	DEF_MOD("iax45_pclk",	R9A07G043_IAX45_PCLK, R9A07G043_CLK_P2,
+				0x518, 0),
+	DEF_MOD("iax45_clk",	R9A07G043_IAX45_CLK, R9A07G043_CLK_P1,
+				0x518, 1),
+#endif
 	DEF_MOD("dmac_aclk",	R9A07G043_DMAC_ACLK, R9A07G043_CLK_P1,
 				0x52c, 0),
 	DEF_MOD("dmac_pclk",	R9A07G043_DMAC_PCLK, CLK_P1_DIV2,
@@ -243,9 +255,14 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 };
 
 static struct rzg2l_reset r9a07g043_resets[] = {
+#ifdef CONFIG_ARM64
 	DEF_RST(R9A07G043_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A07G043_GIC600_DBG_GICRESET_N, 0x814, 1),
 	DEF_RST(R9A07G043_IA55_RESETN, 0x818, 0),
+#endif
+#ifdef CONFIG_RISCV
+	DEF_RST(R9A07G043_IAX45_RESETN, 0x818, 0),
+#endif
 	DEF_RST(R9A07G043_DMAC_ARESETN, 0x82c, 0),
 	DEF_RST(R9A07G043_DMAC_RST_ASYNC, 0x82c, 1),
 	DEF_RST(R9A07G043_OSTM0_PRESETZ, 0x834, 0),
@@ -291,8 +308,13 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 };
 
 static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
+#ifdef CONFIG_ARM64
 	MOD_CLK_BASE + R9A07G043_GIC600_GICCLK,
 	MOD_CLK_BASE + R9A07G043_IA55_CLK,
+#endif
+#ifdef CONFIG_RISCV
+	MOD_CLK_BASE + R9A07G043_IAX45_CLK,
+#endif
 	MOD_CLK_BASE + R9A07G043_DMAC_ACLK,
 };
 
@@ -310,11 +332,21 @@ const struct rzg2l_cpg_info r9a07g043_cpg_info = {
 	/* Module Clocks */
 	.mod_clks = r9a07g043_mod_clks,
 	.num_mod_clks = ARRAY_SIZE(r9a07g043_mod_clks),
+#ifdef CONFIG_ARM64
 	.num_hw_mod_clks = R9A07G043_TSU_PCLK + 1,
+#endif
+#ifdef CONFIG_RISCV
+	.num_hw_mod_clks = R9A07G043_IAX45_PCLK + 1,
+#endif
 
 	/* Resets */
 	.resets = r9a07g043_resets,
+#ifdef CONFIG_ARM64
 	.num_resets = R9A07G043_TSU_PRESETN + 1, /* Last reset ID + 1 */
+#endif
+#ifdef CONFIG_RISCV
+	.num_resets = R9A07G043_IAX45_RESETN + 1, /* Last reset ID + 1 */
+#endif
 
 	.has_clk_mon_regs = true,
 };
-- 
2.25.1

