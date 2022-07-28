Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4D7583832
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 07:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiG1Fn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 01:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiG1FnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 01:43:23 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E680756BBC;
        Wed, 27 Jul 2022 22:43:21 -0700 (PDT)
Received: from droid06.amlogic.com (10.18.11.248) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2176.14; Thu, 28 Jul 2022
 13:43:21 +0800
From:   Yu Tu <yu.tu@amlogic.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Yu Tu <yu.tu@amlogic.com>
Subject: [PATCH V2 1/3] dt-bindings: clk: meson: add S4 SoC clock controller bindings
Date:   Thu, 28 Jul 2022 13:42:00 +0800
Message-ID: <20220728054202.6981-2-yu.tu@amlogic.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220728054202.6981-1-yu.tu@amlogic.com>
References: <20220728054202.6981-1-yu.tu@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.18.11.248]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 include/dt-bindings/clock/s4-clkc.h           | 146 ++++++++++++++++++
 3 files changed, 148 insertions(+)
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
index c1abc53f9e91..f872d0c0c253 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1775,6 +1775,7 @@ F:	Documentation/devicetree/bindings/clock/amlogic*
 F:	drivers/clk/meson/
 F:	include/dt-bindings/clock/gxbb*
 F:	include/dt-bindings/clock/meson*
+F:	include/dt-bindings/clock/s4-clkc.h
 
 ARM/Amlogic Meson SoC Crypto Drivers
 M:	Corentin Labbe <clabbe@baylibre.com>
diff --git a/include/dt-bindings/clock/s4-clkc.h b/include/dt-bindings/clock/s4-clkc.h
new file mode 100644
index 000000000000..b686c8877419
--- /dev/null
+++ b/include/dt-bindings/clock/s4-clkc.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
+ * Author: Yu Tu <yu.tu@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_S4_CLKC_H
+#define _DT_BINDINGS_CLOCK_S4_CLKC_H
+
+/*
+ * CLKID index values
+ */
+
+#define CLKID_FIXED_PLL			1
+#define CLKID_FCLK_DIV2			3
+#define CLKID_FCLK_DIV3			5
+#define CLKID_FCLK_DIV4			7
+#define CLKID_FCLK_DIV5			9
+#define CLKID_FCLK_DIV7			11
+#define CLKID_FCLK_DIV2P5		13
+#define CLKID_GP0_PLL			15
+#define CLKID_HIFI_PLL			17
+#define CLKID_HDMI_PLL			20
+#define CLKID_MPLL_50M			22
+#define CLKID_MPLL0			25
+#define CLKID_MPLL1			27
+#define CLKID_MPLL2			29
+#define CLKID_MPLL3			31
+#define CLKID_RTC_CLK			36
+#define CLKID_SYS_CLK_B_GATE		39
+#define CLKID_SYS_CLK_A_GATE		42
+#define CLKID_SYS_CLK			43
+#define CLKID_CECA_32K_CLKOUT		48
+#define CLKID_CECB_32K_CLKOUT		53
+#define CLKID_SC_CLK_GATE		56
+#define CLKID_12_24M_CLK_SEL		59
+#define CLKID_VID_PLL			62
+#define CLKID_VCLK			69
+#define CLKID_VCLK2			70
+#define CLKID_VCLK_DIV1			71
+#define CLKID_VCLK2_DIV1		76
+#define CLKID_VCLK_DIV2			81
+#define CLKID_VCLK_DIV4			82
+#define CLKID_VCLK_DIV6			83
+#define CLKID_VCLK_DIV12		84
+#define CLKID_VCLK2_DIV2		85
+#define CLKID_VCLK2_DIV4		86
+#define CLKID_VCLK2_DIV6		87
+#define CLKID_VCLK2_DIV12		88
+#define CLKID_CTS_ENCI			93
+#define CLKID_CTS_ENCP			94
+#define CLKID_CTS_VDAC			95
+#define CLKID_HDMI			99
+#define CLKID_TS_CLK_GATE		101
+#define CLKID_MALI_0			104
+#define CLKID_MALI_1			107
+#define CLKID_MALI			108
+#define CLKID_VDEC_P0			111
+#define CLKID_VDEC_P1			114
+#define CLKID_VDEC_SEL			115
+#define CLKID_HEVCF_P0			118
+#define CLKID_HEVCF_P1			121
+#define CLKID_HEVCF_SEL			122
+#define CLKID_VPU_0			125
+#define CLKID_VPU_1			128
+#define CLKID_VPU			129
+#define CLKID_VPU_CLKB_TMP		132
+#define CLKID_VPU_CLKB			134
+#define CLKID_VPU_CLKC_P0		137
+#define CLKID_VPU_CLKC_P1		140
+#define CLKID_VPU_CLKC_SEL		141
+#define CLKID_VAPB_0			144
+#define CLKID_VAPB_1			147
+#define CLKID_VAPB			148
+#define CLKID_GE2D			149
+#define CLKID_VDIN_MEAS_GATE		152
+#define CLKID_SD_EMMC_C_CLK		155
+#define CLKID_SD_EMMC_A_CLK		158
+#define CLKID_SD_EMMC_B_CLK		161
+#define CLKID_SPICC0_GATE		164
+#define CLKID_PWM_A_GATE		167
+#define CLKID_PWM_B_GATE		170
+#define CLKID_PWM_C_GATE		173
+#define CLKID_PWM_D_GATE		176
+#define CLKID_PWM_E_GATE		179
+#define CLKID_PWM_F_GATE		182
+#define CLKID_PWM_G_GATE		185
+#define CLKID_PWM_H_GATE		188
+#define CLKID_PWM_I_GATE		191
+#define CLKID_PWM_J_GATE		194
+#define CLKID_SARADC_GATE		197
+#define CLKID_GEN_GATE			200
+#define CLKID_DDR			201
+#define CLKID_DOS			202
+#define CLKID_ETHPHY			203
+#define CLKID_MALI_GATE			204
+#define CLKID_AOCPU			205
+#define CLKID_AUCPU			206
+#define CLKID_CEC			207
+#define CLKID_SD_EMMC_A			208
+#define CLKID_SD_EMMC_B			209
+#define CLKID_NAND			210
+#define CLKID_SMARTCARD			211
+#define CLKID_ACODEC			212
+#define CLKID_SPIFC			213
+#define CLKID_MSR_CLK			214
+#define CLKID_IR_CTRL			215
+#define CLKID_AUDIO			216
+#define CLKID_ETH			217
+#define CLKID_UART_A			218
+#define CLKID_UART_B			219
+#define CLKID_UART_C			220
+#define CLKID_UART_D			221
+#define CLKID_UART_E			222
+#define CLKID_AIFIFO			223
+#define CLKID_TS_DDR			224
+#define CLKID_TS_PLL			225
+#define CLKID_G2D			226
+#define CLKID_SPICC0			227
+#define CLKID_SPICC1			228
+#define CLKID_USB			229
+#define CLKID_I2C_M_A			230
+#define CLKID_I2C_M_B			231
+#define CLKID_I2C_M_C			232
+#define CLKID_I2C_M_D			233
+#define CLKID_I2C_M_E			234
+#define CLKID_HDMITX_APB		235
+#define CLKID_I2C_S_A			236
+#define CLKID_USB1_TO_DDR		237
+#define CLKID_HDCP22			238
+#define CLKID_MMC_APB			239
+#define CLKID_RSA			240
+#define CLKID_CPU_DEBUG			241
+#define CLKID_VPU_INTR			242
+#define CLKID_DEMOD			243
+#define CLKID_SAR_ADC			244
+#define CLKID_GIC			245
+#define CLKID_PWM_AB			246
+#define CLKID_PWM_CD			247
+#define CLKID_PWM_EF			248
+#define CLKID_PWM_GH			249
+#define CLKID_PWM_IJ			250
+#define CLKID_HDCP22_ESMCLK_GATE	253
+#define CLKID_HDCP22_SKPCLK_GATE	256
+
+#endif /* _DT_BINDINGS_CLOCK_S4_CLKC_H */
-- 
2.33.1

