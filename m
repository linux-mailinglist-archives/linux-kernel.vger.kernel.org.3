Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164184C1580
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbiBWOf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241553AbiBWOf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:35:26 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B1BB3E6E;
        Wed, 23 Feb 2022 06:34:57 -0800 (PST)
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:7ebc:9e38:c4df:c57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 442A5929;
        Wed, 23 Feb 2022 15:34:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1645626896;
        bh=t7lXyoF+dyXhtYXC4fPPLMW3kGBxlRCCjpwpkuyd/NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QFdAdvyydxPmLVK0oZz77NP/VG+nAD2fQY7iSbKs/H8sJfTVle6/unEwzHsZfFZQY
         SmwbJ1u6aDZq045UofPFbsyoN4wLdfBVCeK3UnX9Fv/cAEADljzkrf5JGlGoCvCSg5
         YoVaPR0YQvNf5JqF0osV0zTuMaOYJ3NXpFC6AngI=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, sbranden@broadcom.com,
        rjui@broadcom.com, f.fainelli@gmail.com, nsaenz@kernel.org,
        robh+dt@kernel.org, laurent.pinchart@ideasonboard.com,
        stefan.wahren@i2se.com, dave.stevenson@raspberrypi.com,
        naush@raspberrypi.com,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Subject: [PATCH v5.1 2/2] ARM: dts: bcm2711: Add unicam CSI nodes
Date:   Wed, 23 Feb 2022 15:34:34 +0100
Message-Id: <20220223143434.71853-2-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223143434.71853-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220208155027.891055-7-jeanmichel.hautbois@ideasonboard.com>
 <20220223143434.71853-1-jeanmichel.hautbois@ideasonboard.com>
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

Add both MIPI CSI-2 nodes in the core bcm2711 tree. Use the 3-cells
interrupt declaration, corresponding clocks and default as disabled.

Thanks to Stefan Wahren for his guidance on how to deal with different
RPi variants.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/bcm2711.dtsi     |  8 ++++++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/bcm283x.dtsi     | 22 ++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index dff18fc9a906..53dbd5d00c3a 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -1036,6 +1036,14 @@ &rmem {
 	#address-cells = <2>;
 };
 
+&csi0 {
+	interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&csi1 {
+	interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &cma {
 	/*
 	 * arm64 reserves the CMA by default somewhere in ZONE_DMA32,
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 8f988dd253fc..d339f62bdc8f 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -40,6 +40,20 @@ vchiq: mailbox@7e00b840 {
 	};
 };
 
+&csi0 {
+	clocks = <&clocks BCM2835_CLOCK_CAM0>,
+		 <&firmware_clocks 4>;
+	clock-names = "lp", "vpu";
+	power-domains = <&power RPI_POWER_DOMAIN_UNICAM0>;
+};
+
+&csi1 {
+	clocks = <&clocks BCM2835_CLOCK_CAM1>,
+		 <&firmware_clocks 4>;
+	clock-names = "lp", "vpu";
+	power-domains = <&power RPI_POWER_DOMAIN_UNICAM1>;
+};
+
 &gpio {
 	pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index c113661a6668..7b96e1707024 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -456,6 +456,28 @@ dsi1: dsi@7e700000 {
 			status = "disabled";
 		};
 
+		csi0: csi@7e800000 {
+			compatible = "brcm,bcm2835-unicam";
+			reg = <0x7e800000 0x800>,
+			      <0x7e802000 0x4>;
+			reg-names = "unicam", "cmi";
+			interrupts = <2 6>;
+			status = "disabled";
+			port {
+			};
+		};
+
+		csi1: csi@7e801000 {
+			compatible = "brcm,bcm2835-unicam";
+			reg = <0x7e801000 0x800>,
+			      <0x7e802004 0x4>;
+			reg-names = "unicam", "cmi";
+			interrupts = <2 7>;
+			status = "disabled";
+			port {
+			};
+		};
+
 		i2c1: i2c@7e804000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e804000 0x1000>;
-- 
2.32.0

