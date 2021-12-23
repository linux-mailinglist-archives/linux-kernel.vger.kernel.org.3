Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9290D47E0E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347493AbhLWJc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:32:29 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:16249 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234179AbhLWJc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:32:28 -0500
X-IronPort-AV: E=Sophos;i="5.88,229,1635174000"; 
   d="scan'208";a="104472104"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Dec 2021 18:32:26 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A765C4012B0D;
        Thu, 23 Dec 2021 18:32:24 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH] clk: renesas: r9a07g044: Update multiplier and divider values for PLL2/3
Date:   Thu, 23 Dec 2021 09:32:23 +0000
Message-Id: <20211223093223.4725-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the HW manual (Rev.1.00 Sep, 2021) PLL2 and PLL3 should be 1600MHz,
but with current multiplier and divider values this resulted to 1596MHz.

This patch updates the multiplier and divider values for PLL2 and PLL3
so that we get the exact (1600MHz) values.

Fixes: 17f0ff3d49ff1 ("clk: renesas: Add support for R9A07G044 SoC")
Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi,

Below is the log for before and after this patch.

Clock output before the patch:
root@smarc-rzg2l:~# cat /sys/kernel/debug/clk/clk_summary | grep -E 'pll1|pll2|pll3'
    .pll3                             1        2        0  1596000000          0     0  50000         Y
       .pll3_div2                     1        1        0   798000000          0     0  50000         Y
          .pll3_div2_4                3        3        0   199500000          0     0  50000         Y
             .pll3_div2_4_2           2        2        0    99750000          0     0  50000         Y
          .pll3_div2_2                0        0        0   399000000          0     0  50000         Y
       .pll3_533                      0        2        0   532000000          0     0  50000         Y
          .sel_pll3_3                 0        1        0   532000000          0     0  50000         Y
       .pll3_400                      0        0        0   399000000          0     0  50000         Y
    .pll2                             2        2        0  1596000000          0     0  50000         Y
       .pll2_div2                     1        2        0   798000000          0     0  50000         Y
          .pll2_div2_10               0        1        0    79800000          0     0  50000         Y
          .pll2_div2_8                1        1        0    99750000          0     0  50000         Y
    .pll1                             0        0        0  1200000000          0     0  50000         Y
root@smarc-rzg2l:~#

Clock output after the patch:
root@smarc-rzg2l:~# cat /sys/kernel/debug/clk/clk_summary | grep -E 'pll1|pll2|pll3'
    .pll3                             1        2        0  1600000000          0     0  50000         Y
       .pll3_div2                     1        1        0   800000000          0     0  50000         Y
          .pll3_div2_4                3        3        0   200000000          0     0  50000         Y
             .pll3_div2_4_2           2        2        0   100000000          0     0  50000         Y
          .pll3_div2_2                0        0        0   400000000          0     0  50000         Y
       .pll3_533                      0        2        0   533333333          0     0  50000         Y
          .sel_pll3_3                 0        1        0   533333333          0     0  50000         Y
       .pll3_400                      0        0        0   400000000          0     0  50000         Y
    .pll2                             2        2        0  1600000000          0     0  50000         Y
       .pll2_div2                     1        2        0   800000000          0     0  50000         Y
          .pll2_div2_10               0        1        0    80000000          0     0  50000         Y
          .pll2_div2_8                1        1        0   100000000          0     0  50000         Y
    .pll1                             0        0        0  1200000000          0     0  50000         Y
root@smarc-rzg2l:~#

Cheers,
Prabhakar
---
 drivers/clk/renesas/r9a07g044-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index f4537345126d..22923f8949b1 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -89,8 +89,8 @@ static const struct cpg_core_clk r9a07g044_core_clks[] __initconst = {
 	DEF_FIXED(".osc", R9A07G044_OSCCLK, CLK_EXTAL, 1, 1),
 	DEF_FIXED(".osc_div1000", CLK_OSC_DIV1000, CLK_EXTAL, 1, 1000),
 	DEF_SAMPLL(".pll1", CLK_PLL1, CLK_EXTAL, PLL146_CONF(0)),
-	DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 133, 2),
-	DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 133, 2),
+	DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
+	DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
 	DEF_FIXED(".pll3_400", CLK_PLL3_400, CLK_PLL3, 1, 4),
 	DEF_FIXED(".pll3_533", CLK_PLL3_533, CLK_PLL3, 1, 3),
 
-- 
2.17.1

