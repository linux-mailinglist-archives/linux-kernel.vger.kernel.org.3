Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79933513EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 01:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353170AbiD1XNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 19:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiD1XNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 19:13:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAD74852E9;
        Thu, 28 Apr 2022 16:09:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 691371474;
        Thu, 28 Apr 2022 16:09:45 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56E863F5A1;
        Thu, 28 Apr 2022 16:09:43 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH v11 1/6] clk: sunxi-ng: h6-r: Add RTC gate clock
Date:   Fri, 29 Apr 2022 00:09:28 +0100
Message-Id: <20220428230933.15262-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220428230933.15262-1-andre.przywara@arm.com>
References: <20220428230933.15262-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H6 and H616 feature an (undocumented) bus clock gate for accessing
the RTC registers. This seems to be enabled at reset (or by the BootROM),
so we got away without it so far, but exists regardless.
Since the new RTC clock binding for the H616 requires this "bus" clock
to be specified in the DT, add this to R_CCU clock driver and expose it
on the DT side with a new number.
We do this for both the H6 and H616, but mark it as IGNORE_UNUSED, as we
cannot reference it in any H6 DTs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c      | 5 +++++
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h      | 2 +-
 include/dt-bindings/clock/sun50i-h6-r-ccu.h | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index 712e103382d8..88509339031e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -98,6 +98,8 @@ static SUNXI_CCU_GATE(r_apb1_ir_clk,	"r-apb1-ir",	"r-apb1",
 		      0x1cc, BIT(0), 0);
 static SUNXI_CCU_GATE(r_apb1_w1_clk,	"r-apb1-w1",	"r-apb1",
 		      0x1ec, BIT(0), 0);
+static SUNXI_CCU_GATE(r_apb1_rtc_clk,	"r-apb1-rtc",	"r-apb1",
+		      0x20c, BIT(0), CLK_IGNORE_UNUSED);
 
 /* Information of IR(RX) mod clock is gathered from BSP source code */
 static const char * const r_mod0_default_parents[] = { "osc32k", "osc24M" };
@@ -147,6 +149,7 @@ static struct ccu_common *sun50i_h616_r_ccu_clks[] = {
 	&r_apb2_i2c_clk.common,
 	&r_apb2_rsb_clk.common,
 	&r_apb1_ir_clk.common,
+	&r_apb1_rtc_clk.common,
 	&ir_clk.common,
 };
 
@@ -163,6 +166,7 @@ static struct clk_hw_onecell_data sun50i_h6_r_hw_clks = {
 		[CLK_R_APB2_I2C]	= &r_apb2_i2c_clk.common.hw,
 		[CLK_R_APB2_RSB]	= &r_apb2_rsb_clk.common.hw,
 		[CLK_R_APB1_IR]		= &r_apb1_ir_clk.common.hw,
+		[CLK_R_APB1_RTC]	= &r_apb1_rtc_clk.common.hw,
 		[CLK_R_APB1_W1]		= &r_apb1_w1_clk.common.hw,
 		[CLK_IR]		= &ir_clk.common.hw,
 		[CLK_W1]		= &w1_clk.common.hw,
@@ -179,6 +183,7 @@ static struct clk_hw_onecell_data sun50i_h616_r_hw_clks = {
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
2.35.3

