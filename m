Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED23D4680F8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383609AbhLCX61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:58:27 -0500
Received: from inva021.nxp.com ([92.121.34.21]:58064 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383562AbhLCX6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:58:21 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A9A7E200B32;
        Sat,  4 Dec 2021 00:54:55 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 41AE8200B20;
        Sat,  4 Dec 2021 00:54:55 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 7D92D40007;
        Fri,  3 Dec 2021 16:54:54 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pankaj Bansal <pankaj.bansal@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 04/10] arm64: dts: lx2160a-qds: Add mdio mux nodes
Date:   Fri,  3 Dec 2021 17:54:40 -0600
Message-Id: <20211203235446.8266-5-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211203235446.8266-1-leoyang.li@nxp.com>
References: <20211203235446.8266-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Bansal <pankaj.bansal@nxp.com>

The two external MDIO buses used to communicate with phy devices that
are external to SOC are muxed in LX2160AQDS board.  These buses can be
routed to any one of the eight IO slots on LX2160AQDS board depending on
value in fpga register 0x54.  Additionally the external MDIO1 is used to
communicate to the onboard RGMII phy devices.  The mdio1 is controlled
by bits 4-7 of fpga register and mdio2 is controlled by bits 4-7 of fpga
register.

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../boot/dts/freescale/fsl-lx2160a-qds.dts    | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 8354af0b31e3..2ecfa90f5e28 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -31,6 +31,130 @@ sb_3v3: regulator-sb3v3 {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	mdio-mux-1 {
+		compatible = "mdio-mux-multiplexer";
+		mux-controls = <&mux 0>;
+		mdio-parent-bus = <&emdio1>;
+		#address-cells=<1>;
+		#size-cells = <0>;
+
+		mdio@0 { /* On-board PHY #1 RGMI1*/
+			reg = <0x00>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@8 { /* On-board PHY #2 RGMI2*/
+			reg = <0x8>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@18 { /* Slot #1 */
+			reg = <0x18>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@19 { /* Slot #2 */
+			reg = <0x19>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1a { /* Slot #3 */
+			reg = <0x1a>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1b { /* Slot #4 */
+			reg = <0x1b>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1c { /* Slot #5 */
+			reg = <0x1c>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1d { /* Slot #6 */
+			reg = <0x1d>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1e { /* Slot #7 */
+			reg = <0x1e>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1f { /* Slot #8 */
+			reg = <0x1f>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	mdio-mux-2 {
+		compatible = "mdio-mux-multiplexer";
+		mux-controls = <&mux 1>;
+		mdio-parent-bus = <&emdio2>;
+		#address-cells=<1>;
+		#size-cells = <0>;
+
+		mdio@0 { /* Slot #1 (secondary EMI) */
+			reg = <0x00>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@1 { /* Slot #2 (secondary EMI) */
+			reg = <0x01>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@2 { /* Slot #3 (secondary EMI) */
+			reg = <0x02>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@3 { /* Slot #4 (secondary EMI) */
+			reg = <0x03>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@4 { /* Slot #5 (secondary EMI) */
+			reg = <0x04>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@5 { /* Slot #6 (secondary EMI) */
+			reg = <0x05>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@6 { /* Slot #7 (secondary EMI) */
+			reg = <0x06>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mdio@7 { /* Slot #8 (secondary EMI) */
+			reg = <0x07>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
 };
 
 &can0 {
@@ -81,6 +205,14 @@ dflash2: flash@0 {
 	};
 };
 
+&emdio1 {
+	status = "okay";
+};
+
+&emdio2 {
+	status = "okay";
+};
+
 &esdhc0 {
 	status = "okay";
 };
@@ -107,6 +239,19 @@ mt35xu512aba0: flash@0 {
 &i2c0 {
 	status = "okay";
 
+	fpga@66 {
+		compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c",
+			     "simple-mfd";
+		reg = <0x66>;
+
+		mux: mux-controller {
+			compatible = "reg-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x54 0xf8>, /* 0: reg 0x54, bits 7:3 */
+					<0x54 0x07>; /* 1: reg 0x54, bit 2:0 */
+		};
+	};
+
 	i2c-mux@77 {
 		compatible = "nxp,pca9547";
 		reg = <0x77>;
-- 
2.25.1

