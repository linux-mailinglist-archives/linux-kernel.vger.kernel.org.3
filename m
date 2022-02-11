Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFAF4B25A2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350003AbiBKM1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:27:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349988AbiBKM0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:26:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0374E77;
        Fri, 11 Feb 2022 04:26:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E03C139F;
        Fri, 11 Feb 2022 04:26:53 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.196.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B32D93F70D;
        Fri, 11 Feb 2022 04:26:51 -0800 (PST)
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
Subject: [PATCH v10 02/18] clk: sunxi-ng: h616: Add PLL derived 32KHz clock
Date:   Fri, 11 Feb 2022 12:26:27 +0000
Message-Id: <20220211122643.1343315-3-andre.przywara@arm.com>
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

The RTC section of the H616 manual mentions in a half-sentence the
existence of a clock "32K divided by PLL_PERI(2X)". This is used as
one of the possible inputs for the mux that selects the clock for the
32 KHz fanout pad. On the H616 this is routed to pin PG10, and some
boards use that clock output to compensate for a missing 32KHz crystal.
On the OrangePi Zero2 this is for instance connected to the LPO pin of
the WiFi/BT chip.
The new RTC clock binding requires this clock to be named as one input
clock, so we need to expose this to the DT. In contrast to the D1 SoC
there does not seem to be a gate for this clock, so just use a fixed
divider clock, using a newly assigned clock number.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c      | 7 +++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h      | 2 +-
 include/dt-bindings/clock/sun50i-h616-ccu.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
index 49a2474cf314..f4e896b19a16 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
@@ -704,6 +704,12 @@ static CLK_FIXED_FACTOR_HWS(pll_periph0_2x_clk, "pll-periph0-2x",
 			    pll_periph0_parents,
 			    1, 2, 0);
 
+static const struct clk_hw *pll_periph0_2x_hws[] = {
+	&pll_periph0_2x_clk.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_system_32k_clk, "pll-system-32k",
+			    pll_periph0_2x_hws, 36621, 1, 0);
+
 static const struct clk_hw *pll_periph1_parents[] = {
 	&pll_periph1_clk.common.hw
 };
@@ -852,6 +858,7 @@ static struct clk_hw_onecell_data sun50i_h616_hw_clks = {
 		[CLK_PLL_DDR1]		= &pll_ddr1_clk.common.hw,
 		[CLK_PLL_PERIPH0]	= &pll_periph0_clk.common.hw,
 		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.hw,
+		[CLK_PLL_SYSTEM_32K]	= &pll_system_32k_clk.hw,
 		[CLK_PLL_PERIPH1]	= &pll_periph1_clk.common.hw,
 		[CLK_PLL_PERIPH1_2X]	= &pll_periph1_2x_clk.hw,
 		[CLK_PLL_GPU]		= &pll_gpu_clk.common.hw,
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.h b/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
index dd671b413f22..fdd2f4d5103f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
@@ -51,6 +51,6 @@
 
 #define CLK_BUS_DRAM		56
 
-#define CLK_NUMBER		(CLK_BUS_HDCP + 1)
+#define CLK_NUMBER		(CLK_PLL_SYSTEM_32K + 1)
 
 #endif /* _CCU_SUN50I_H616_H_ */
diff --git a/include/dt-bindings/clock/sun50i-h616-ccu.h b/include/dt-bindings/clock/sun50i-h616-ccu.h
index 4fc08b0df2f3..1191aca53ac6 100644
--- a/include/dt-bindings/clock/sun50i-h616-ccu.h
+++ b/include/dt-bindings/clock/sun50i-h616-ccu.h
@@ -111,5 +111,6 @@
 #define CLK_BUS_TVE0		125
 #define CLK_HDCP		126
 #define CLK_BUS_HDCP		127
+#define CLK_PLL_SYSTEM_32K	128
 
 #endif /* _DT_BINDINGS_CLK_SUN50I_H616_H_ */
-- 
2.25.1

