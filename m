Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF8A4EDBB8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiCaOcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbiCaOcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:32:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECB81DA8C1;
        Thu, 31 Mar 2022 07:30:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22VEUiog096335;
        Thu, 31 Mar 2022 09:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1648737044;
        bh=MzypBx1ySKSl5PbLdLFE1VQwaoH5vhnWar+leG6cRDI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Bdd4ZJ4RQJ2HRKIoqimgnuzW+7DN+cmu/gk4iUSIni81i/hmSSH5CjqCRz+6uL6u3
         PBkNNuewMcOAUnSO+GyGxZfSI6vIVOml04HPQIkoIH17yrLijv/VaKs5vIYO/Gg5RD
         nqnIb9S6WoitbimPpR5vAOiMQK98uhHLISRerpBM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22VEUiqI058147
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 31 Mar 2022 09:30:44 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 31
 Mar 2022 09:30:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 31 Mar 2022 09:30:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22VEUgH4008399;
        Thu, 31 Mar 2022 09:30:43 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <r-ravikumar@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j721e-main: add DP & DP PHY
Date:   Thu, 31 Mar 2022 20:00:34 +0530
Message-ID: <20220331143035.16210-2-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220331143035.16210-1-r-ravikumar@ti.com>
References: <20220331143035.16210-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DT nodes for DisplayPort and DisplayPort PHY. The DP is Cadence MHDP
8546 and the PHY is a Cadence Torrent PHY with TI WIZ wrapper.

A slight irregularity in the bindings is the DPTX PHY register block,
which is in the MHDP IP, but is needed and mapped by the PHY.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 65 +++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index db0669985e42..11426c25a09d 100644
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
+		ranges = <0x5050000 0x0 0x5050000 0x10000>,
+			<0xa030a00 0x0 0xa030a00 0x40>;
+
+		serdes4: serdes@5050000 {
+			/*
+			 * Note: we also map DPTX PHY registers as the Torrent
+			 * needs to manage those.
+			 */
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x5050000 0x10000>,
+			      <0xa030a00 0x40>; /* DPTX PHY */
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
@@ -1267,6 +1309,29 @@
 		};
 	};
 
+	mhdp: dp-bridge@a000000 {
+		compatible = "ti,j721e-mhdp8546";
+		/*
+		 * Note: we do not map DPTX PHY area, as that is handled by
+		 * the PHY driver.
+		 */
+		reg = <0x0 0xa000000 0x0 0x30a00>, /* DSS_EDP0_V2A_CORE_VP_REGS_APB */
+		      <0x0 0x4f40000 0x0 0x20>;    /* DSS_EDP0_INTG_CFG_VP */
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
+		};
+	};
+
 	dss: dss@4a00000 {
 		compatible = "ti,j721e-dss";
 		reg =
-- 
2.17.1

