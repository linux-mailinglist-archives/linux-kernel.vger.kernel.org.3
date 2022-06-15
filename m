Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B354C596
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbiFOKMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343500AbiFOKMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:12:36 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A4D64D9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=gBzDqYJWrP5LrCucQ6rfc9fBg4G
        DNNOxtb5PIoS5SK4=; b=NLkUnKutjkyQFGS5XvMBusu/V4hO0zLcscNJ/PBhCuO
        7BhAPkxIgPKFQ6Kg4BDed3bxbLeBiy7IPG3+Mz66t8ZwrV79wPbePVEEhlRU/opa
        GIlvg7ELguqb0YZhEy8HM6spbhgAfvPZgxOmJULQe8QRKzhbNaOHhtIMVHGKq6II
        =
Received: (qmail 2073927 invoked from network); 15 Jun 2022 12:12:32 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Jun 2022 12:12:32 +0200
X-UD-Smtp-Session: l3s3148p1@NHxkwnnhyydZD+7R
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: renesas: rcar-gen4: implement SDSRC properly
Date:   Wed, 15 Jun 2022 12:12:26 +0200
Message-Id: <20220615101227.13463-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the divider setting, SDSRC can have a different parent.
Implement this when reading the divider, to get a correct clock tree.
Setting the divider is left to the bootloader for now.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Tested on my Spider board (r8a779f0). Only build tested for r8a779g0 but
the docs for the registers are the same.

 drivers/clk/renesas/r8a779f0-cpg-mssr.c |  2 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c |  2 +-
 drivers/clk/renesas/rcar-gen4-cpg.c     | 10 +++++++++-
 drivers/clk/renesas/rcar-gen4-cpg.h     |  5 ++++-
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/r8a779f0-cpg-mssr.c b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
index 862b49736bf0..0c3aa529e4fa 100644
--- a/drivers/clk/renesas/r8a779f0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779f0-cpg-mssr.c
@@ -71,7 +71,7 @@ static const struct cpg_core_clk r8a779f0_core_clks[] __initconst = {
 	DEF_FIXED(".pll6_div2",	CLK_PLL6_DIV2,	CLK_PLL6,	2, 1),
 	DEF_FIXED(".s0",	CLK_S0,		CLK_PLL1_DIV2,	2, 1),
 
-	DEF_BASE(".sdsrc",	CLK_SDSRC,	CLK_TYPE_GEN4_SDSRC, CLK_PLL5),
+	DEF_GEN4_SDSRC(".sdsrc", CLK_SDSRC,	CLK_PLL5_DIV2,	CLK_PLL5, 0x08a4),
 	DEF_RATE(".oco",	CLK_OCO,	32768),
 
 	DEF_BASE(".rpcsrc",	CLK_RPCSRC,	CLK_TYPE_GEN4_RPCSRC, CLK_PLL5),
diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index 3fc4233b1ead..c8cd32cf4606 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -86,7 +86,7 @@ static const struct cpg_core_clk r8a779g0_core_clks[] __initconst = {
 	DEF_FIXED(".s0_hsc",	CLK_S0_HSC,	CLK_PLL1_DIV2,	2, 1),
 	DEF_FIXED(".sv_vip",	CLK_SV_VIP,	CLK_PLL1,	5, 1),
 	DEF_FIXED(".sv_ir",	CLK_SV_IR,	CLK_PLL1,	5, 1),
-	DEF_BASE(".sdsrc",	CLK_SDSRC,	CLK_TYPE_GEN4_SDSRC, CLK_PLL5),
+	DEF_GEN4_SDSRC(".sdsrc", CLK_SDSRC,	CLK_PLL5_DIV2,	CLK_PLL5, 0x08a4),
 	DEF_RATE(".oco",	CLK_OCO,	32768),
 
 	DEF_BASE(".rpcsrc",	CLK_RPCSRC,		CLK_TYPE_GEN4_RPCSRC, CLK_PLL5),
diff --git a/drivers/clk/renesas/rcar-gen4-cpg.c b/drivers/clk/renesas/rcar-gen4-cpg.c
index c7ed43d6aa67..c6662ec10292 100644
--- a/drivers/clk/renesas/rcar-gen4-cpg.c
+++ b/drivers/clk/renesas/rcar-gen4-cpg.c
@@ -240,7 +240,15 @@ struct clk * __init rcar_gen4_cpg_clk_register(struct device *dev,
 					  base, core->div, core->offset);
 
 	case CLK_TYPE_GEN4_SDSRC:
-		div = ((readl(base + SD0CKCR1) >> 29) & 0x03) + 4;
+		value = (readl(base + core->offset) >> 29) & 3;
+		if (value) {
+			div = value + 4;
+		} else {
+			parent = clks[core->parent >> 16];
+			if (IS_ERR(parent))
+				return ERR_CAST(parent);
+			div = 2;
+		}
 		break;
 
 	case CLK_TYPE_GEN4_SDH:
diff --git a/drivers/clk/renesas/rcar-gen4-cpg.h b/drivers/clk/renesas/rcar-gen4-cpg.h
index 0b15dcfdca7b..e5237b2f5205 100644
--- a/drivers/clk/renesas/rcar-gen4-cpg.h
+++ b/drivers/clk/renesas/rcar-gen4-cpg.h
@@ -32,6 +32,10 @@ enum rcar_gen4_clk_types {
 	CLK_TYPE_GEN4_SOC_BASE,
 };
 
+#define DEF_GEN4_SDSRC(_name, _id, _parent0, _parent1, _offset)	\
+	DEF_BASE(_name, _id, CLK_TYPE_GEN4_SDSRC, \
+		 (_parent0) << 16 | (_parent1), .offset = _offset)
+
 #define DEF_GEN4_SDH(_name, _id, _parent, _offset)	\
 	DEF_BASE(_name, _id, CLK_TYPE_GEN4_SDH, _parent, .offset = _offset)
 
@@ -67,7 +71,6 @@ struct rcar_gen4_cpg_pll_config {
 };
 
 #define CPG_RPCCKCR	0x874
-#define SD0CKCR1	0x8a4
 
 struct clk *rcar_gen4_cpg_clk_register(struct device *dev,
 	const struct cpg_core_clk *core, const struct cpg_mssr_info *info,
-- 
2.35.1

