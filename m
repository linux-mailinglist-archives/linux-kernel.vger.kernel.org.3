Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC34BFED1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiBVQeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiBVQdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:33:22 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DCE167F95;
        Tue, 22 Feb 2022 08:32:51 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21MGWc3Q113673;
        Tue, 22 Feb 2022 10:32:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645547558;
        bh=M6ARIgneEQH1F/+LZH6mauYppNZEm7uhcajVIp+V8MA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MuMuUEgHEUxlZg62tSMDOKdNubVAJmhh4sFwzgbQdkTx5+2WcibDYZ61Lq2oaP+zR
         tDgeCF5/nN7ZLQ+M5JlHjDZKVCCMDXOc2ITw3XxdYPxzuHhM2KZkWpQg5xYK2OPXRs
         B/NjGvJBGnIbkWBBRSafZBv79Ies37Ou0TiGY2u0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21MGWclj092844
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Feb 2022 10:32:38 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 22
 Feb 2022 10:32:38 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 22 Feb 2022 10:32:38 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21MGWaW3130385;
        Tue, 22 Feb 2022 10:32:37 -0600
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 1/2] arm64: dts: ti: k3-j721e-main: add DP & DP PHY
Date:   Tue, 22 Feb 2022 22:02:29 +0530
Message-ID: <20220222163230.1566-2-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222163230.1566-1-r-ravikumar@ti.com>
References: <20220222163230.1566-1-r-ravikumar@ti.com>
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
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 102 ++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 599861259a30..9e2b212100bb 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -786,6 +786,82 @@
 		#size-cells = <2>;
 	};
 
+	serdes_wiz4: wiz@5050000 {
+		compatible = "ti,j721e-wiz-10g";
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
+		ranges = <0x5050000 0x0 0x5050000 0x10000>,
+			<0xa030a00 0x0 0xa030a00 0x40>;
+
+		wiz4_pll0_refclk: pll0-refclk {
+			clocks = <&k3_clks 297 9>, <&cmn_refclk>;
+			clock-output-names = "wiz4_pll0_refclk";
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz4_pll0_refclk>;
+			assigned-clock-parents = <&k3_clks 297 9>;
+		};
+
+		wiz4_pll1_refclk: pll1-refclk {
+			clocks = <&k3_clks 297 9>, <&cmn_refclk>;
+			clock-output-names = "wiz4_pll1_refclk";
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz4_pll1_refclk>;
+			assigned-clock-parents = <&k3_clks 297 9>;
+		};
+
+		wiz4_refclk_dig: refclk-dig {
+			clocks = <&k3_clks 297 9>, <&cmn_refclk>;
+			clock-output-names = "wiz4_refclk_dig";
+			#clock-cells = <0>;
+			assigned-clocks = <&wiz4_refclk_dig>;
+			assigned-clock-parents = <&k3_clks 297 9>;
+		};
+
+		wiz4_cmn_refclk_dig_div: cmn-refclk-dig-div {
+			clocks = <&wiz4_refclk_dig>;
+			#clock-cells = <0>;
+		};
+
+		wiz4_cmn_refclk1_dig_div: cmn-refclk1-dig-div {
+			clocks = <&wiz4_pll1_refclk>;
+			#clock-cells = <0>;
+		};
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
+			clocks = <&wiz4_pll0_refclk>;
+			clock-names = "refclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			torrent_phy_dp: phy@0 {
+				reg = <0>;
+				resets = <&serdes_wiz4 1>;
+				cdns,phy-type = <PHY_TYPE_DP>;
+				cdns,num-lanes = <4>;
+				cdns,max-bit-rate = <5400>;
+				#phy-cells = <0>;
+			};
+		};
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
@@ -1264,6 +1340,32 @@
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
+		phys = <&torrent_phy_dp>;
+		phy-names = "dpphy";
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

