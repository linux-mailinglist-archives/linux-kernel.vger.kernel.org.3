Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5E156B2E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbiGHGom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiGHGok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:44:40 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FD14D4C8;
        Thu,  7 Jul 2022 23:44:37 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Fri, 8 Jul 2022
 14:29:30 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH 1/3] dt-bindings: clk: meson: add S4 SoC clock controller bindings
Date:   Fri, 8 Jul 2022 14:27:55 +0800
Message-ID: <20220708062757.3662-2-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220708062757.3662-1-yu.tu@amlogic.com>
References: <20220708062757.3662-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new clock controller compatible and dt-bindings header for the
Everything-Else domain of the S4 SoC.

Signed-off-by: Yu Tu <yu.tu@amlogic.com>
---
 .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
 MAINTAINERS                                   |   1 +
 include/dt-bindings/clock/s4-clkc.h           | 354 ++++++++++++++++++
 3 files changed, 356 insertions(+)
 create mode 100644 include/dt-bindings/clock/s4-clkc.h

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
index 7ccecd5c02c1..301b43dea912 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
@@ -12,6 +12,7 @@ Required Properties:
 		"amlogic,g12a-clkc" for G12A SoC.
 		"amlogic,g12b-clkc" for G12B SoC.
 		"amlogic,sm1-clkc" for SM1 SoC.
+		"amlogic,s4-clkc" for S4 SoC.
 - clocks : list of clock phandle, one for each entry clock-names.
 - clock-names : should contain the following:
   * "xtal": the platform xtal
diff --git a/MAINTAINERS b/MAINTAINERS
index c1abc53f9e91..e4ca46c5c8a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1775,6 +1775,7 @@ F:	Documentation/devicetree/bindings/clock/amlogic*
 F:	drivers/clk/meson/
 F:	include/dt-bindings/clock/gxbb*
 F:	include/dt-bindings/clock/meson*
+F:	include/dt-bindings/clock/s*
 
 ARM/Amlogic Meson SoC Crypto Drivers
 M:	Corentin Labbe <clabbe@baylibre.com>
diff --git a/include/dt-bindings/clock/s4-clkc.h b/include/dt-bindings/clock/s4-clkc.h
new file mode 100644
index 000000000000..8b46d54d79fe
--- /dev/null
+++ b/include/dt-bindings/clock/s4-clkc.h
@@ -0,0 +1,354 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
+ * Author: Yu Tu <yu.tu@amlogic.com>
+ */
+
+#ifndef __S4_CLKC_H
+#define __S4_CLKC_H
+
+/*
+ * CLKID index values
+ */
+
+#define CLKID_PLL_BASE			0
+#define CLKID_FIXED_PLL_DCO		(CLKID_PLL_BASE + 0)
+#define CLKID_FIXED_PLL			(CLKID_PLL_BASE + 1)
+#define CLKID_FCLK_DIV2_DIV		(CLKID_PLL_BASE + 2)
+#define CLKID_FCLK_DIV2			(CLKID_PLL_BASE + 3)
+#define CLKID_FCLK_DIV3_DIV		(CLKID_PLL_BASE + 4)
+#define CLKID_FCLK_DIV3			(CLKID_PLL_BASE + 5)
+#define CLKID_FCLK_DIV4_DIV		(CLKID_PLL_BASE + 6)
+#define CLKID_FCLK_DIV4			(CLKID_PLL_BASE + 7)
+#define CLKID_FCLK_DIV5_DIV		(CLKID_PLL_BASE + 8)
+#define CLKID_FCLK_DIV5			(CLKID_PLL_BASE + 9)
+#define CLKID_FCLK_DIV7_DIV		(CLKID_PLL_BASE + 10)
+#define CLKID_FCLK_DIV7			(CLKID_PLL_BASE + 11)
+#define CLKID_FCLK_DIV2P5_DIV		(CLKID_PLL_BASE + 12)
+#define CLKID_FCLK_DIV2P5		(CLKID_PLL_BASE + 13)
+#define CLKID_GP0_PLL_DCO		(CLKID_PLL_BASE + 14)
+#define CLKID_GP0_PLL			(CLKID_PLL_BASE + 15)
+#define CLKID_HIFI_PLL_DCO		(CLKID_PLL_BASE + 16)
+#define CLKID_HIFI_PLL			(CLKID_PLL_BASE + 17)
+#define CLKID_HDMI_PLL_DCO		(CLKID_PLL_BASE + 18)
+#define CLKID_HDMI_PLL_OD		(CLKID_PLL_BASE + 19)
+#define CLKID_HDMI_PLL			(CLKID_PLL_BASE + 20)
+#define CLKID_MPLL_50M_DIV		(CLKID_PLL_BASE + 21)
+#define CLKID_MPLL_50M			(CLKID_PLL_BASE + 22)
+#define CLKID_MPLL_PREDIV		(CLKID_PLL_BASE + 23)
+#define CLKID_MPLL0_DIV			(CLKID_PLL_BASE + 24)
+#define CLKID_MPLL0			(CLKID_PLL_BASE + 25)
+#define CLKID_MPLL1_DIV			(CLKID_PLL_BASE + 26)
+#define CLKID_MPLL1			(CLKID_PLL_BASE + 27)
+#define CLKID_MPLL2_DIV			(CLKID_PLL_BASE + 28)
+#define CLKID_MPLL2			(CLKID_PLL_BASE + 29)
+#define CLKID_MPLL3_DIV			(CLKID_PLL_BASE + 30)
+#define CLKID_MPLL3			(CLKID_PLL_BASE + 31)
+
+#define CLKID_BASE			(CLKID_PLL_BASE + 32)
+#define CLKID_RTC_32K_CLKIN		(CLKID_BASE + 0)
+#define CLKID_RTC_32K_DIV		(CLKID_BASE + 1)
+#define CLKID_RTC_32K_SEL		(CLKID_BASE + 2)
+#define CLKID_RTC_32K_XATL		(CLKID_BASE + 3)
+#define CLKID_RTC_CLK			(CLKID_BASE + 4)
+#define CLKID_SYS_CLK_B_SEL		(CLKID_BASE + 5)
+#define CLKID_SYS_CLK_B_DIV		(CLKID_BASE + 6)
+#define CLKID_SYS_CLK_B_GATE		(CLKID_BASE + 7)
+#define CLKID_SYS_CLK_A_SEL		(CLKID_BASE + 8)
+#define CLKID_SYS_CLK_A_DIV		(CLKID_BASE + 9)
+#define CLKID_SYS_CLK_A_GATE		(CLKID_BASE + 10)
+#define CLKID_SYS_CLK			(CLKID_BASE + 11)
+
+#define CLKID_CECA_32K_CLKIN		(CLKID_BASE + 12)
+#define CLKID_CECA_32K_DIV		(CLKID_BASE + 13)
+#define CLKID_CECA_32K_SEL_PRE		(CLKID_BASE + 14)
+#define CLKID_CECA_32K_SEL		(CLKID_BASE + 15)
+#define CLKID_CECA_32K_CLKOUT		(CLKID_BASE + 16)
+#define CLKID_CECB_32K_CLKIN		(CLKID_BASE + 17)
+#define CLKID_CECB_32K_DIV		(CLKID_BASE + 18)
+#define CLKID_CECB_32K_SEL_PRE		(CLKID_BASE + 19)
+#define CLKID_CECB_32K_SEL		(CLKID_BASE + 20)
+#define CLKID_CECB_32K_CLKOUT		(CLKID_BASE + 21)
+
+#define CLKID_SC_CLK_SEL		(CLKID_BASE + 22)
+#define CLKID_SC_CLK_DIV		(CLKID_BASE + 23)
+#define CLKID_SC_CLK_GATE		(CLKID_BASE + 24)
+
+#define CLKID_DSPA_CLK_B_SEL		(CLKID_BASE + 25)
+#define CLKID_DSPA_CLK_B_DIV		(CLKID_BASE + 26)
+#define CLKID_DSPA_CLK_B_GATE		(CLKID_BASE + 27)
+#define CLKID_DSPA_CLK_A_SEL		(CLKID_BASE + 28)
+#define CLKID_DSPA_CLK_A_DIV		(CLKID_BASE + 29)
+#define CLKID_DSPA_CLK_A_GATE		(CLKID_BASE + 30)
+#define CLKID_DSPA_CLK			(CLKID_BASE + 31)
+
+#define CLKID_12_24M_CLK_GATE		(CLKID_BASE + 32)
+#define CLKID_12M_CLK_DIV		(CLKID_BASE + 33)
+#define CLKID_12_24M_CLK_SEL		(CLKID_BASE + 34)
+#define CLKID_25M_CLK_DIV		(CLKID_BASE + 35)
+#define CLKID_25M_CLK_GATE		(CLKID_BASE + 36)
+
+#define CLKID_VID_PLL_DIV		(CLKID_BASE + 37)
+#define CLKID_VID_PLL_SEL		(CLKID_BASE + 38)
+#define CLKID_VID_PLL			(CLKID_BASE + 39)
+#define CLKID_VCLK_SEL			(CLKID_BASE + 40)
+#define CLKID_VCLK2_SEL			(CLKID_BASE + 41)
+#define CLKID_VCLK_INPUT		(CLKID_BASE + 42)
+#define CLKID_VCLK2_INPUT		(CLKID_BASE + 43)
+#define CLKID_VCLK_DIV			(CLKID_BASE + 44)
+#define CLKID_VCLK2_DIV			(CLKID_BASE + 45)
+#define CLKID_VCLK			(CLKID_BASE + 46)
+#define CLKID_VCLK2			(CLKID_BASE + 47)
+#define CLKID_VCLK_DIV1			(CLKID_BASE + 48)
+#define CLKID_VCLK_DIV2_EN		(CLKID_BASE + 49)
+#define CLKID_VCLK_DIV4_EN		(CLKID_BASE + 50)
+#define CLKID_VCLK_DIV6_EN		(CLKID_BASE + 51)
+#define CLKID_VCLK_DIV12_EN		(CLKID_BASE + 52)
+#define CLKID_VCLK2_DIV1		(CLKID_BASE + 53)
+#define CLKID_VCLK2_DIV2_EN		(CLKID_BASE + 54)
+#define CLKID_VCLK2_DIV4_EN		(CLKID_BASE + 55)
+#define CLKID_VCLK2_DIV6_EN		(CLKID_BASE + 56)
+#define CLKID_VCLK2_DIV12_EN		(CLKID_BASE + 57)
+#define CLKID_VCLK_DIV2			(CLKID_BASE + 58)
+#define CLKID_VCLK_DIV4			(CLKID_BASE + 59)
+#define CLKID_VCLK_DIV6			(CLKID_BASE + 60)
+#define CLKID_VCLK_DIV12		(CLKID_BASE + 61)
+#define CLKID_VCLK2_DIV2		(CLKID_BASE + 62)
+#define CLKID_VCLK2_DIV4		(CLKID_BASE + 63)
+#define CLKID_VCLK2_DIV6		(CLKID_BASE + 64)
+#define CLKID_VCLK2_DIV12		(CLKID_BASE + 65)
+#define CLKID_CTS_ENCI_SEL		(CLKID_BASE + 66)
+#define CLKID_CTS_ENCP_SEL		(CLKID_BASE + 67)
+#define CLKID_CTS_VDAC_SEL		(CLKID_BASE + 68)
+#define CLKID_HDMI_TX_SEL		(CLKID_BASE + 69)
+#define CLKID_CTS_ENCI			(CLKID_BASE + 70)
+#define CLKID_CTS_ENCP			(CLKID_BASE + 71)
+#define CLKID_CTS_VDAC			(CLKID_BASE + 72)
+#define CLKID_HDMI_TX			(CLKID_BASE + 73)
+
+#define CLKID_HDMI_SEL			(CLKID_BASE + 74)
+#define CLKID_HDMI_DIV			(CLKID_BASE + 75)
+#define CLKID_HDMI			(CLKID_BASE + 76)
+#define CLKID_TS_CLK_DIV		(CLKID_BASE + 77)
+#define CLKID_TS_CLK_GATE		(CLKID_BASE + 78)
+
+#define CLKID_MALI_0_SEL		(CLKID_BASE + 79)
+#define CLKID_MALI_0_DIV		(CLKID_BASE + 80)
+#define CLKID_MALI_0			(CLKID_BASE + 81)
+#define CLKID_MALI_1_SEL		(CLKID_BASE + 82)
+#define CLKID_MALI_1_DIV		(CLKID_BASE + 83)
+#define CLKID_MALI_1			(CLKID_BASE + 84)
+#define CLKID_MALI			(CLKID_BASE + 85)
+
+#define CLKID_VDEC_P0_SEL		(CLKID_BASE + 86)
+#define CLKID_VDEC_P0_DIV		(CLKID_BASE + 87)
+#define CLKID_VDEC_P0			(CLKID_BASE + 88)
+#define CLKID_VDEC_P1_SEL		(CLKID_BASE + 89)
+#define CLKID_VDEC_P1_DIV		(CLKID_BASE + 90)
+#define CLKID_VDEC_P1			(CLKID_BASE + 91)
+#define CLKID_VDEC_SEL			(CLKID_BASE + 92)
+
+#define CLKID_HCODEC_P0_SEL		(CLKID_BASE + 93)
+#define CLKID_HCODEC_P0_DIV		(CLKID_BASE + 94)
+#define CLKID_HCODEC_P0			(CLKID_BASE + 95)
+#define CLKID_HCODEC_P1_SEL		(CLKID_BASE + 96)
+#define CLKID_HCODEC_P1_DIV		(CLKID_BASE + 97)
+#define CLKID_HCODEC_P1			(CLKID_BASE + 98)
+#define CLKID_HCODEC_SEL		(CLKID_BASE + 99)
+
+#define CLKID_HEVCB_P0_SEL		(CLKID_BASE + 100)
+#define CLKID_HEVCB_P0_DIV		(CLKID_BASE + 101)
+#define CLKID_HEVCB_P0			(CLKID_BASE + 102)
+#define CLKID_HEVCB_P1_SEL		(CLKID_BASE + 103)
+#define CLKID_HEVCB_P1_DIV		(CLKID_BASE + 104)
+#define CLKID_HEVCB_P1			(CLKID_BASE + 105)
+#define CLKID_HEVCB_SEL			(CLKID_BASE + 106)
+
+#define CLKID_HEVCF_P0_SEL		(CLKID_BASE + 107)
+#define CLKID_HEVCF_P0_DIV		(CLKID_BASE + 108)
+#define CLKID_HEVCF_P0			(CLKID_BASE + 109)
+#define CLKID_HEVCF_P1_SEL		(CLKID_BASE + 110)
+#define CLKID_HEVCF_P1_DIV		(CLKID_BASE + 111)
+#define CLKID_HEVCF_P1			(CLKID_BASE + 112)
+#define CLKID_HEVCF_SEL			(CLKID_BASE + 113)
+
+#define CLKID_WAVE_A_SEL		(CLKID_BASE + 114)
+#define CLKID_WAVE_A_DIV		(CLKID_BASE + 115)
+#define CLKID_WAVE_A_GATE		(CLKID_BASE + 116)
+#define CLKID_WAVE_B_SEL		(CLKID_BASE + 117)
+#define CLKID_WAVE_B_DIV		(CLKID_BASE + 118)
+#define CLKID_WAVE_B_GATE		(CLKID_BASE + 119)
+#define CLKID_WAVE_C_SEL		(CLKID_BASE + 120)
+#define CLKID_WAVE_C_DIV		(CLKID_BASE + 121)
+#define CLKID_WAVE_C_GATE		(CLKID_BASE + 122)
+
+#define CLKID_VPU_0_SEL			(CLKID_BASE + 123)
+#define CLKID_VPU_0_DIV			(CLKID_BASE + 124)
+#define CLKID_VPU_0			(CLKID_BASE + 125)
+#define CLKID_VPU_1_SEL			(CLKID_BASE + 126)
+#define CLKID_VPU_1_DIV			(CLKID_BASE + 127)
+#define CLKID_VPU_1			(CLKID_BASE + 128)
+#define CLKID_VPU			(CLKID_BASE + 129)
+
+#define CLKID_VPU_CLKB_TMP_SEL		(CLKID_BASE + 130)
+#define CLKID_VPU_CLKB_TMP_DIV		(CLKID_BASE + 131)
+#define CLKID_VPU_CLKB_TMP		(CLKID_BASE + 132)
+#define CLKID_VPU_CLKB_DIV		(CLKID_BASE + 133)
+#define CLKID_VPU_CLKB			(CLKID_BASE + 134)
+
+#define CLKID_VPU_CLKC_P0_SEL		(CLKID_BASE + 135)
+#define CLKID_VPU_CLKC_P0_DIV		(CLKID_BASE + 136)
+#define CLKID_VPU_CLKC_P0		(CLKID_BASE + 137)
+#define CLKID_VPU_CLKC_P1_SEL		(CLKID_BASE + 138)
+#define CLKID_VPU_CLKC_P1_DIV		(CLKID_BASE + 139)
+#define CLKID_VPU_CLKC_P1		(CLKID_BASE + 140)
+#define CLKID_VPU_CLKC_SEL		(CLKID_BASE + 141)
+
+#define CLKID_VAPB_0_SEL		(CLKID_BASE + 142)
+#define CLKID_VAPB_0_DIV		(CLKID_BASE + 143)
+#define CLKID_VAPB_0			(CLKID_BASE + 144)
+#define CLKID_VAPB_1_SEL		(CLKID_BASE + 145)
+#define CLKID_VAPB_1_DIV		(CLKID_BASE + 146)
+#define CLKID_VAPB_1			(CLKID_BASE + 147)
+#define CLKID_VAPB			(CLKID_BASE + 148)
+
+#define CLKID_GE2D			(CLKID_BASE + 149)
+
+#define CLKID_VDIN_MEAS_SEL		(CLKID_BASE + 150)
+#define CLKID_VDIN_MEAS_DIV		(CLKID_BASE + 151)
+#define CLKID_VDIN_MEAS_GATE		(CLKID_BASE + 152)
+
+#define CLKID_SD_EMMC_C_CLK_SEL		(CLKID_BASE + 153)
+#define CLKID_SD_EMMC_C_CLK_DIV		(CLKID_BASE + 154)
+#define CLKID_SD_EMMC_C_CLK		(CLKID_BASE + 155)
+#define CLKID_SD_EMMC_A_CLK_SEL		(CLKID_BASE + 156)
+#define CLKID_SD_EMMC_A_CLK_DIV		(CLKID_BASE + 157)
+#define CLKID_SD_EMMC_A_CLK		(CLKID_BASE + 158)
+#define CLKID_SD_EMMC_B_CLK_SEL		(CLKID_BASE + 159)
+#define CLKID_SD_EMMC_B_CLK_DIV		(CLKID_BASE + 160)
+#define CLKID_SD_EMMC_B_CLK		(CLKID_BASE + 161)
+
+#define CLKID_SPICC0_SEL		(CLKID_BASE + 162)
+#define CLKID_SPICC0_DIV		(CLKID_BASE + 163)
+#define CLKID_SPICC0_GATE		(CLKID_BASE + 164)
+#define CLKID_SPICC1_SEL		(CLKID_BASE + 165)
+#define CLKID_SPICC1_DIV		(CLKID_BASE + 166)
+#define CLKID_SPICC1_GATE		(CLKID_BASE + 167)
+
+#define CLKID_PWM_A_SEL			(CLKID_BASE + 168)
+#define CLKID_PWM_A_DIV			(CLKID_BASE + 169)
+#define CLKID_PWM_A_GATE		(CLKID_BASE + 170)
+#define CLKID_PWM_B_SEL			(CLKID_BASE + 171)
+#define CLKID_PWM_B_DIV			(CLKID_BASE + 172)
+#define CLKID_PWM_B_GATE		(CLKID_BASE + 173)
+#define CLKID_PWM_C_SEL			(CLKID_BASE + 174)
+#define CLKID_PWM_C_DIV			(CLKID_BASE + 175)
+#define CLKID_PWM_C_GATE		(CLKID_BASE + 176)
+#define CLKID_PWM_D_SEL			(CLKID_BASE + 177)
+#define CLKID_PWM_D_DIV			(CLKID_BASE + 178)
+#define CLKID_PWM_D_GATE		(CLKID_BASE + 179)
+#define CLKID_PWM_E_SEL			(CLKID_BASE + 180)
+#define CLKID_PWM_E_DIV			(CLKID_BASE + 181)
+#define CLKID_PWM_E_GATE		(CLKID_BASE + 182)
+#define CLKID_PWM_F_SEL			(CLKID_BASE + 183)
+#define CLKID_PWM_F_DIV			(CLKID_BASE + 184)
+#define CLKID_PWM_F_GATE		(CLKID_BASE + 185)
+#define CLKID_PWM_G_SEL			(CLKID_BASE + 186)
+#define CLKID_PWM_G_DIV			(CLKID_BASE + 187)
+#define CLKID_PWM_G_GATE		(CLKID_BASE + 188)
+#define CLKID_PWM_H_SEL			(CLKID_BASE + 189)
+#define CLKID_PWM_H_DIV			(CLKID_BASE + 190)
+#define CLKID_PWM_H_GATE		(CLKID_BASE + 191)
+#define CLKID_PWM_I_SEL			(CLKID_BASE + 192)
+#define CLKID_PWM_I_DIV			(CLKID_BASE + 193)
+#define CLKID_PWM_I_GATE		(CLKID_BASE + 194)
+#define CLKID_PWM_J_SEL			(CLKID_BASE + 195)
+#define CLKID_PWM_J_DIV			(CLKID_BASE + 196)
+#define CLKID_PWM_J_GATE		(CLKID_BASE + 197)
+
+#define CLKID_SARADC_SEL		(CLKID_BASE + 198)
+#define CLKID_SARADC_DIV		(CLKID_BASE + 199)
+#define CLKID_SARADC_GATE		(CLKID_BASE + 200)
+#define CLKID_GEN_SEL			(CLKID_BASE + 201)
+#define CLKID_GEN_DIV			(CLKID_BASE + 202)
+#define CLKID_GEN_GATE			(CLKID_BASE + 203)
+
+#define CLKID_DDR			(CLKID_BASE + 204)
+#define CLKID_DOS			(CLKID_BASE + 205)
+#define CLKID_ETHPHY			(CLKID_BASE + 206)
+#define CLKID_MALI_GATE			(CLKID_BASE + 207)
+#define CLKID_AOCPU			(CLKID_BASE + 208)
+#define CLKID_AUCPU			(CLKID_BASE + 209)
+#define CLKID_CEC			(CLKID_BASE + 210)
+#define CLKID_SD_EMMC_A			(CLKID_BASE + 211)
+#define CLKID_SD_EMMC_B			(CLKID_BASE + 212)
+#define CLKID_NAND			(CLKID_BASE + 213)
+#define CLKID_SMARTCARD			(CLKID_BASE + 214)
+#define CLKID_ACODEC			(CLKID_BASE + 215)
+#define CLKID_SPIFC			(CLKID_BASE + 216)
+#define CLKID_MSR_CLK			(CLKID_BASE + 217)
+#define CLKID_IR_CTRL			(CLKID_BASE + 218)
+#define CLKID_AUDIO			(CLKID_BASE + 219)
+#define CLKID_ETH			(CLKID_BASE + 220)
+#define CLKID_UART_A			(CLKID_BASE + 221)
+#define CLKID_UART_B			(CLKID_BASE + 222)
+#define CLKID_UART_C			(CLKID_BASE + 223)
+#define CLKID_UART_D			(CLKID_BASE + 224)
+#define CLKID_UART_E			(CLKID_BASE + 225)
+#define CLKID_AIFIFO			(CLKID_BASE + 226)
+#define CLKID_TS_DDR			(CLKID_BASE + 227)
+#define CLKID_TS_PLL			(CLKID_BASE + 228)
+#define CLKID_G2D			(CLKID_BASE + 229)
+#define CLKID_SPICC0			(CLKID_BASE + 230)
+#define CLKID_SPICC1			(CLKID_BASE + 231)
+#define CLKID_PCIE			(CLKID_BASE + 232)
+#define CLKID_USB			(CLKID_BASE + 233)
+#define CLKID_PCIE_PHY			(CLKID_BASE + 234)
+#define CLKID_I2C_M_A			(CLKID_BASE + 235)
+#define CLKID_I2C_M_B			(CLKID_BASE + 236)
+#define CLKID_I2C_M_C			(CLKID_BASE + 237)
+#define CLKID_I2C_M_D			(CLKID_BASE + 238)
+#define CLKID_I2C_M_E			(CLKID_BASE + 239)
+#define CLKID_I2C_M_F			(CLKID_BASE + 240)
+#define CLKID_HDMITX_APB		(CLKID_BASE + 241)
+#define CLKID_I2C_S_A			(CLKID_BASE + 242)
+#define CLKID_USB1_TO_DDR		(CLKID_BASE + 243)
+#define CLKID_HDCP22			(CLKID_BASE + 244)
+#define CLKID_MMC_APB			(CLKID_BASE + 245)
+#define CLKID_RSA			(CLKID_BASE + 246)
+#define CLKID_CPU_DEBUG			(CLKID_BASE + 247)
+#define CLKID_DSPA			(CLKID_BASE + 248)
+#define CLKID_VPU_INTR			(CLKID_BASE + 249)
+#define CLKID_SAR_ADC			(CLKID_BASE + 250)
+#define CLKID_GIC			(CLKID_BASE + 251)
+#define CLKID_PWM_AB			(CLKID_BASE + 252)
+#define CLKID_PWM_CD			(CLKID_BASE + 253)
+#define CLKID_PWM_EF			(CLKID_BASE + 254)
+#define CLKID_PWM_GH			(CLKID_BASE + 255)
+#define CLKID_PWM_IJ			(CLKID_BASE + 256)
+#define CLKID_DEMOD			(CLKID_BASE + 257)
+
+#define CLKID_HDCP22_ESMCLK_SEL		(CLKID_BASE + 258)
+#define CLKID_HDCP22_ESMCLK_DIV		(CLKID_BASE + 259)
+#define CLKID_HDCP22_ESMCLK_GATE	(CLKID_BASE + 260)
+#define CLKID_HDCP22_SKPCLK_SEL		(CLKID_BASE + 261)
+#define CLKID_HDCP22_SKPCLK_DIV		(CLKID_BASE + 262)
+#define CLKID_HDCP22_SKPCLK_GATE	(CLKID_BASE + 263)
+
+#define CLKID_DEMOD_CORE_CLK_SEL	(CLKID_BASE + 264)
+#define CLKID_DEMOD_CORE_CLK_DIV	(CLKID_BASE + 265)
+#define CLKID_DEMOD_CORE_CLK_GATE	(CLKID_BASE + 266)
+#define CLKID_ADC_EXTCLK_IN_SEL		(CLKID_BASE + 267)
+#define CLKID_ADC_EXTCLK_IN_DIV		(CLKID_BASE + 268)
+#define CLKID_ADC_EXTCLK_IN_GATE	(CLKID_BASE + 269)
+#define CLKID_DEMOD_CORE_T2_CLK_SEL	(CLKID_BASE + 270)
+#define CLKID_DEMOD_CORE_T2_CLK_DIV	(CLKID_BASE + 271)
+#define CLKID_DEMOD_CORE_T2_CLK_GATE	(CLKID_BASE + 272)
+#define CLKID_DEMOD_32K_CLKIN		(CLKID_BASE + 273)
+#define CLKID_DEMOD_32K_DIV		(CLKID_BASE + 274)
+#define CLKID_DEMOD_32K_XTAL		(CLKID_BASE + 275)
+#define CLKID_DEMOD_32K_CLK		(CLKID_BASE + 276)
+
+#define NR_CLKS				(CLKID_BASE + 277)
+
+#endif /* __S4_CLKC_H */
-- 
2.33.1

