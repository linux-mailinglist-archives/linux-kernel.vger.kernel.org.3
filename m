Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1629495BC0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379549AbiAUITD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:19:03 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:48796 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379433AbiAUISZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:18:25 -0500
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:d916:876:fa52:7241])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E81951273;
        Fri, 21 Jan 2022 09:18:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1642753101;
        bh=g62rX4H5ojw3TBC5rBoXLBe/JwwWPY/fHbZ3UYFUP/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTTO06JZu+GazJe00N9u2tRIXpZjop6ARaNurKJe/z9E+6UHxS/eBXA/rHNMX7hTA
         Hc4nJRcdkdAtoxhDNWh+ttmT6ZWagSOaK38DtLMGBDaGFdDNhMko7+Hqhcx+YITRGJ
         qYgHvBk6dDmNG3wlWmOsVTyorulHaLUqbN0/33oE=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     jeanmichel.hautbois@ideasonboard.com
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com
Subject: [RFC PATCH v2 5/7] ARM: dts: bcm2711: Add unicam CSI nodes
Date:   Fri, 21 Jan 2022 09:18:08 +0100
Message-Id: <20220121081810.155500-6-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
References: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add both MIPI CSI-2 nodes in the core bcm2711 tree. Use the 3-cells
interrupt declaration, corresponding clocks and default as disabled.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
---
 arch/arm/boot/dts/bcm2711.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index dff18fc9a906..077141df7024 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/bcm2835-pm.h>
+#include <dt-bindings/power/raspberrypi-power.h>
 
 / {
 	compatible = "brcm,bcm2711";
@@ -293,6 +294,36 @@ hvs: hvs@7e400000 {
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		csi0: csi1@7e800000 {
+			compatible = "brcm,bcm2835-unicam";
+			reg = <0x7e800000 0x800>,
+			      <0x7e802000 0x4>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clocks BCM2835_CLOCK_CAM0>,
+				 <&firmware_clocks 4>;
+			clock-names = "lp", "vpu";
+			power-domains = <&power RPI_POWER_DOMAIN_UNICAM0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+			status="disabled";
+		};
+
+		csi1: csi1@7e801000 {
+			compatible = "brcm,bcm2835-unicam";
+			reg = <0x7e801000 0x800>,
+			      <0x7e802004 0x4>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clocks BCM2835_CLOCK_CAM1>,
+				 <&firmware_clocks 4>;
+			clock-names = "lp", "vpu";
+			power-domains = <&power RPI_POWER_DOMAIN_UNICAM1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+			status="disabled";
+		};
+
 		pixelvalve3: pixelvalve@7ec12000 {
 			compatible = "brcm,bcm2711-pixelvalve3";
 			reg = <0x7ec12000 0x100>;
-- 
2.32.0

