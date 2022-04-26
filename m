Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409E1510202
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352435AbiDZPjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352410AbiDZPjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:39:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8F1570F;
        Tue, 26 Apr 2022 08:36:15 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23QFa04J095160;
        Tue, 26 Apr 2022 10:36:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650987360;
        bh=gRQr7XeEvyTpJ2fKnZIXTDb/h++VKf/bmPBC0uraUJc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sGuh4to0LAxqj3w9zBtxCf1z+qoC9WaoGcnOAm9ytIJhX81e0EsCcKJbshnGX41Yt
         uF5Kd3V+iF/MAF3+3oPFVZ58WP1U0MSXIboenpYVFXAnUo23fTLNN3U49Gog8+qrGU
         ycy1kkAvtS+TsLIGqaE8j6ftujHN6E1EKEUsOu2o=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23QFa0SE130796
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Apr 2022 10:36:00 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 26
 Apr 2022 10:35:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 26 Apr 2022 10:35:59 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23QFZwmW081638;
        Tue, 26 Apr 2022 10:35:59 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <r-ravikumar@ti.com>
Subject: [PATCH v4 1/2] arm64: dts: ti: k3-j721e-*: add DP & DP PHY
Date:   Tue, 26 Apr 2022 21:05:52 +0530
Message-ID: <20220426153553.18474-2-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220426153553.18474-1-r-ravikumar@ti.com>
References: <20220426153553.18474-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT nodes for DisplayPort and DisplayPort PHY. The DP is Cadence MHDP
8546 and the PHY is a Cadence Torrent PHY with TI WIZ wrapper.

Also add the required phy link nodes in the board dts files.

A slight irregularity in the bindings is the DPTX PHY register block,
which is in the MHDP IP, but is needed and mapped by the PHY.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 16 ++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 75 ++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 16 ++++
 3 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index f5ca8e26ed99..2f119e94e783 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -793,6 +793,22 @@
 	};
 };
 
+&serdes4 {
+	torrent_phy_dp: phy@0 {
+		reg = <0>;
+		resets = <&serdes_wiz4 1>;
+		cdns,phy-type = <PHY_TYPE_DP>;
+		cdns,num-lanes = <4>;
+		cdns,max-bit-rate = <5400>;
+		#phy-cells = <0>;
+	};
+};
+
+&mhdp {
+	phys = <&torrent_phy_dp>;
+	phy-names = "dpphy";
+};
+
 &pcie0_rc {
 	reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
 	phys = <&serdes0_pcie_link>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index db0669985e42..43b6cf5791ee 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2016-2020 Texas Instruments Incorporated - https://www.ti.com/
  */
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/phy/phy-ti.h>
 #include <dt-bindings/mux/mux.h>
 #include <dt-bindings/mux/ti-serdes.h>
 
@@ -789,6 +790,47 @@
 		#size-cells = <2>;
 	};
 
+	serdes_wiz4: wiz@5050000 {
+		compatible = "ti,am64-wiz-10g";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 297 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 297 1>, <&k3_clks 297 9>, <&cmn_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		assigned-clocks = <&k3_clks 297 9>;
+		assigned-clock-parents = <&k3_clks 297 10>;
+		assigned-clock-rates = <19200000>;
+		num-lanes = <4>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+		ranges = <0x05050000 0x00 0x05050000 0x010000>,
+			<0x0a030a00 0x00 0x0a030a00 0x40>;
+
+		serdes4: serdes@5050000 {
+			/*
+			 * Note: we also map DPTX PHY registers as the Torrent
+			 * needs to manage those.
+			 */
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x05050000 0x010000>,
+			      <0x0a030a00 0x40>; /* DPTX PHY */
+			reg-names = "torrent_phy", "dptx_phy";
+
+			resets = <&serdes_wiz4 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>;
+			clock-names = "refclk";
+			assigned-clocks = <&serdes_wiz4 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz4 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz4 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 297 9>,
+						 <&k3_clks 297 9>,
+						 <&k3_clks 297 9>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
@@ -1267,6 +1309,37 @@
 		};
 	};
 
+	mhdp: dp-bridge@a000000 {
+		compatible = "ti,j721e-mhdp8546";
+		/*
+		 * Note: we do not map DPTX PHY area, as that is handled by
+		 * the PHY driver.
+		 */
+		reg = <0x00 0x0a000000 0x00 0x030a00>, /* DSS_EDP0_V2A_CORE_VP_REGS_APB */
+		      <0x00 0x04f40000 0x00 0x20>;    /* DSS_EDP0_INTG_CFG_VP */
+		reg-names = "mhdptx", "j721e-intg";
+
+		clocks = <&k3_clks 151 36>;
+
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>;
+
+		power-domains = <&k3_pds 151 TI_SCI_PD_EXCLUSIVE>;
+
+		dp0_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+			    reg = <0>;
+			};
+
+			port@4 {
+			    reg = <4>;
+			};
+		};
+	};
+
 	dss: dss@4a00000 {
 		compatible = "ti,j721e-dss";
 		reg =
@@ -1317,8 +1390,6 @@
 				  "common_s2";
 
 		dss_ports: ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index f25d85169e0d..98177a20b45f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -624,6 +624,22 @@
 	};
 };
 
+&serdes4 {
+	torrent_phy_dp: phy@0 {
+		reg = <0>;
+		resets = <&serdes_wiz4 1>;
+		cdns,phy-type = <PHY_TYPE_DP>;
+		cdns,num-lanes = <4>;
+		cdns,max-bit-rate = <5400>;
+		#phy-cells = <0>;
+	};
+};
+
+&mhdp {
+	phys = <&torrent_phy_dp>;
+	phy-names = "dpphy";
+};
+
 &usbss0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_usbss0_pins_default>;
-- 
2.17.1

