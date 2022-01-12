Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233D148C9FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiALRlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243138AbiALRlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:41:01 -0500
X-Greylist: delayed 423 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jan 2022 09:41:01 PST
Received: from unicorn.mansr.com (unicorn.mansr.com [IPv6:2001:8b0:ca0d:8d8e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51045C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 09:41:01 -0800 (PST)
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id B616715360;
        Wed, 12 Jan 2022 17:33:55 +0000 (GMT)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 8F365219FD4; Wed, 12 Jan 2022 17:33:55 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sunxi: h3/h5: add r_uart node
Date:   Wed, 12 Jan 2022 17:33:27 +0000
Message-Id: <20220112173327.26317-1-mans@mansr.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an additional UART in the PL I/O block.
Add a node and pinmux for it.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
The "documentation" doesn't mention any DMA channels for this UART.
If it nonetheless does have DMA capability and someone knows the channel
assignments, feel free to amend.
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 22d533d18992..55ffba5a4e9f 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -884,6 +884,19 @@ r_i2c: i2c@1f02400 {
 			#size-cells = <0>;
 		};
 
+		r_uart: serial@1f02800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01f02800 0x400>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&r_ccu CLK_APB0_UART>;
+			resets = <&r_ccu RST_APB0_UART>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_uart_pins>;
+			status = "disabled";
+		};
+
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun8i-h3-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
@@ -909,6 +922,11 @@ r_pwm_pin: r-pwm-pin {
 				pins = "PL10";
 				function = "s_pwm";
 			};
+
+			r_uart_pins: r-uart-pins {
+				pins = "PL2", "PL3";
+				function = "s_uart";
+			};
 		};
 
 		r_pwm: pwm@1f03800 {
-- 
2.34.1

