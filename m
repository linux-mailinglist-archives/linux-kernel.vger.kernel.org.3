Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E15D51C92F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385133AbiEETgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385172AbiEETgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:36:12 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FAC65D194;
        Thu,  5 May 2022 12:32:24 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,203,1647270000"; 
   d="scan'208";a="120034550"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 May 2022 04:32:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A078440E166D;
        Fri,  6 May 2022 04:32:20 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 4/4] clk: renesas: r9a07g043: Add support for RZ/Five SoC
Date:   Thu,  5 May 2022 20:31:43 +0100
Message-Id: <20220505193143.31826-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220505193143.31826-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add minimal clock and resets entries required to boot RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 30 +++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 27b47ecfe4d8..95ea639490ef 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -151,7 +151,7 @@ static const struct {
 static const struct {
 	struct rzg2l_mod_clk common[54];
 #ifdef CONFIG_RISCV
-	struct rzg2l_mod_clk rzfive[0];
+	struct rzg2l_mod_clk rzfive[2];
 #else
 	struct rzg2l_mod_clk rzg2ul[3];
 #endif
@@ -268,6 +268,10 @@ static const struct {
 	},
 #ifdef CONFIG_RISCV
 	.rzfive = {
+		DEF_MOD("iax45_pclk",	R9A07G043_IAX45_PCLK, R9A07G043_CLK_P2,
+					0x518, 0),
+		DEF_MOD("iax45_clk",	R9A07G043_IAX45_CLK, R9A07G043_CLK_P1,
+					0x518, 1),
 	},
 #else
 	.rzg2ul = {
@@ -284,7 +288,7 @@ static const struct {
 static const struct {
 	struct rzg2l_reset common[42];
 #ifdef CONFIG_RISCV
-	struct rzg2l_reset rzfive[0];
+	struct rzg2l_reset rzfive[1];
 #else
 	struct rzg2l_reset rzg2ul[3];
 #endif
@@ -335,6 +339,7 @@ static const struct {
 	},
 #ifdef CONFIG_RISCV
 	.rzfive = {
+		DEF_RST(R9A07G043_IAX45_RESETN, 0x818, 0),
 	},
 #else
 	.rzg2ul = {
@@ -345,16 +350,27 @@ static const struct {
 #endif
 };
 
+#ifdef CONFIG_RISCV
+static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
+	MOD_CLK_BASE + R9A07G043_IAX45_CLK,
+	MOD_CLK_BASE + R9A07G043_DMAC_ACLK,
+};
+#else
 static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
 	MOD_CLK_BASE + R9A07G043_GIC600_GICCLK,
 	MOD_CLK_BASE + R9A07G043_IA55_CLK,
 	MOD_CLK_BASE + R9A07G043_DMAC_ACLK,
 };
+#endif
 
 const struct rzg2l_cpg_info r9a07g043_cpg_info = {
 	/* Core Clocks */
 	.core_clks = core_clks.common,
+#ifdef CONFIG_RISCV
+	.num_core_clks = ARRAY_SIZE(core_clks.common),
+#else
 	.num_core_clks = ARRAY_SIZE(core_clks.common) + ARRAY_SIZE(core_clks.rzg2ul),
+#endif
 	.last_dt_core_clk = LAST_DT_CORE_CLK,
 	.num_total_core_clks = MOD_CLK_BASE,
 
@@ -364,10 +380,20 @@ const struct rzg2l_cpg_info r9a07g043_cpg_info = {
 
 	/* Module Clocks */
 	.mod_clks = mod_clks.common,
+#ifdef CONFIG_RISCV
+	.num_mod_clks = ARRAY_SIZE(mod_clks.common) + ARRAY_SIZE(mod_clks.rzfive),
+	.num_hw_mod_clks = R9A07G043_IAX45_PCLK + 1,
+#else
+
 	.num_mod_clks = ARRAY_SIZE(mod_clks.common) + ARRAY_SIZE(mod_clks.rzg2ul),
 	.num_hw_mod_clks = R9A07G043_TSU_PCLK + 1,
+#endif
 
 	/* Resets */
 	.resets = resets.common,
+#ifdef CONFIG_RISCV
+	.num_resets = ARRAY_SIZE(resets.common) + ARRAY_SIZE(resets.rzfive),
+#else
 	ARRAY_SIZE(resets.common) + ARRAY_SIZE(resets.rzg2ul),
+#endif
 };
-- 
2.25.1

