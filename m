Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220004B25A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbiBKM0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:26:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349977AbiBKM0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:26:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCE3FE77;
        Fri, 11 Feb 2022 04:26:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8292111D4;
        Fri, 11 Feb 2022 04:26:51 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.196.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF0273F70D;
        Fri, 11 Feb 2022 04:26:49 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH v10 01/18] clk: sunxi-ng: h616-r: Add RTC gate clock
Date:   Fri, 11 Feb 2022 12:26:26 +0000
Message-Id: <20220211122643.1343315-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211122643.1343315-1-andre.przywara@arm.com>
References: <20220211122643.1343315-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H616 features an (undocumented) bus clock gate for accessing the RTC
registers. This seems to be enabled at reset (or by the BootROM), but is
there anyway.
Since the new RTC clock binding for the H616 requires this "bus" clock
to be specified in the DT, add this to R_CCU clock driver and expose it
on the DT side with a new number.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c      | 4 ++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h      | 2 +-
 include/dt-bindings/clock/sun50i-h6-r-ccu.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index 712e103382d8..26fb092f6df6 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -98,6 +98,8 @@ static SUNXI_CCU_GATE(r_apb1_ir_clk,	"r-apb1-ir",	"r-apb1",
 		      0x1cc, BIT(0), 0);
 static SUNXI_CCU_GATE(r_apb1_w1_clk,	"r-apb1-w1",	"r-apb1",
 		      0x1ec, BIT(0), 0);
+static SUNXI_CCU_GATE(r_apb1_rtc_clk,	"r-apb1-rtc",	"r-apb1",
+		      0x20c, BIT(0), 0);
 
 /* Information of IR(RX) mod clock is gathered from BSP source code */
 static const char * const r_mod0_default_parents[] = { "osc32k", "osc24M" };
@@ -147,6 +149,7 @@ static struct ccu_common *sun50i_h616_r_ccu_clks[] = {
 	&r_apb2_i2c_clk.common,
 	&r_apb2_rsb_clk.common,
 	&r_apb1_ir_clk.common,
+	&r_apb1_rtc_clk.common,
 	&ir_clk.common,
 };
 
@@ -179,6 +182,7 @@ static struct clk_hw_onecell_data sun50i_h616_r_hw_clks = {
 		[CLK_R_APB2_I2C]	= &r_apb2_i2c_clk.common.hw,
 		[CLK_R_APB2_RSB]	= &r_apb2_rsb_clk.common.hw,
 		[CLK_R_APB1_IR]		= &r_apb1_ir_clk.common.hw,
+		[CLK_R_APB1_RTC]	= &r_apb1_rtc_clk.common.hw,
 		[CLK_IR]		= &ir_clk.common.hw,
 	},
 	.num	= CLK_NUMBER,
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
index 7e290b840803..10e9b66afc6a 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
@@ -14,6 +14,6 @@
 
 #define CLK_R_APB2	3
 
-#define CLK_NUMBER	(CLK_R_APB2_RSB + 1)
+#define CLK_NUMBER	(CLK_R_APB1_RTC + 1)
 
 #endif /* _CCU_SUN50I_H6_R_H */
diff --git a/include/dt-bindings/clock/sun50i-h6-r-ccu.h b/include/dt-bindings/clock/sun50i-h6-r-ccu.h
index 890368d252c4..a96087abc86f 100644
--- a/include/dt-bindings/clock/sun50i-h6-r-ccu.h
+++ b/include/dt-bindings/clock/sun50i-h6-r-ccu.h
@@ -22,5 +22,6 @@
 #define CLK_W1			12
 
 #define CLK_R_APB2_RSB		13
+#define CLK_R_APB1_RTC		14
 
 #endif /* _DT_BINDINGS_CLK_SUN50I_H6_R_CCU_H_ */
-- 
2.25.1

