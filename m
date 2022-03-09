Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C2D4D3986
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiCITHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiCITHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:07:45 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179C6101F04;
        Wed,  9 Mar 2022 11:06:42 -0800 (PST)
Received: from Monstersaurus.ksquared.org.uk.beta.tailscale.net (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AA5678C4;
        Wed,  9 Mar 2022 20:06:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646852800;
        bh=/m3d0aHMIAS1HEDWSlNqe6DHmSt/5s6vdPbAB/zGIz0=;
        h=From:To:Cc:Subject:Date:From;
        b=U4qnpIo6dwFVy323NorSvuXsy0gGFyfbBH+Hsb5jt7ULpFvYUWH9dDpoIS1Y35eI3
         A8yodoIlVqyuL0Dx4/7oAOKTq+ID0zgUSPTCigG248coNwaP7Fty4zpM60vrifOkci
         b+65eHT5PoIFepQ1o89uFqSPnFXxi+Yl9S97VbNg=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] arm64: dts: renesas: falcon-cpu: Use INTC_EX for SN65DSI86
Date:   Wed,  9 Mar 2022 19:06:31 +0000
Message-Id: <20220309190631.1576372-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INTC block is a better choice for handling the interrupts on the V3U
as the INTC will always be powered, while the GPIO block may be
de-clocked if not in use. Further more, it may be likely to have a lower
power consumption as it does not need to drive the pins.

Switch the interrupt parent and interrupts definition from gpio1 to
irq0 on intc_ex, and configure the PFC accordingly.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

---
v2:

 - Define irq0_pins, and ensure pinctrl is set in the bridge node.
---
 arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
index 6af3f4f4f268..53c4a26198e3 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
@@ -192,14 +192,17 @@ &i2c1 {
 	clock-frequency = <400000>;
 
 	bridge@2c {
+		pinctrl-0 = <&irq0_pins>;
+		pinctrl-names = "default";
+
 		compatible = "ti,sn65dsi86";
 		reg = <0x2c>;
 
 		clocks = <&sn65dsi86_refclk>;
 		clock-names = "refclk";
 
-		interrupt-parent = <&gpio1>;
-		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&intc_ex>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 
 		vccio-supply = <&reg_1p8v>;
 		vpll-supply = <&reg_1p8v>;
@@ -271,6 +274,11 @@ i2c6_pins: i2c6 {
 		function = "i2c6";
 	};
 
+	irq0_pins: irq0 {
+		groups = "intc_ex_irq0";
+		function = "intc_ex";
+	};
+
 	keys_pins: keys {
 		pins = "GP_6_18", "GP_6_19", "GP_6_20";
 		bias-pull-up;
-- 
2.32.0

