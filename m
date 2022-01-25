Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5055A49B4B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383359AbiAYNOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:14:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59906 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575742AbiAYNLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:11:38 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20PDBKcW027536;
        Tue, 25 Jan 2022 07:11:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643116280;
        bh=QE20+zISOu5EKAhJ8zw7SBaaood4dggVlU8vqh1Znug=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=e5FyOYBmaLioy4Omy3WkZ0l5B069b/C/7gyEO9N04CqMtYm3ay+wzIt34os3bbhlo
         CGz0DgFB1F680TCIT677RmT5e9N2KSFoVUrHpjjjq6bvkRwzQTTkS7FoBc5Tk2B3Bn
         TiOm6nctLHw1PkS0ukk97Tqez767rduEDY3hat68=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20PDBKaA063790
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jan 2022 07:11:20 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 25
 Jan 2022 07:11:19 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 25 Jan 2022 07:11:19 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20PDBE36032789;
        Tue, 25 Jan 2022 07:11:17 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH 1/6] arm64: dts: ti: k3-j721s2-main: Add support for USB
Date:   Tue, 25 Jan 2022 18:41:08 +0530
Message-ID: <20220125131113.727-2-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220125131113.727-1-a-govindraju@ti.com>
References: <20220125131113.727-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for single instance of USB 3.0 controller in J721S2 SoC.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index b04db1d3ab61..e651f0af1aaa 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -26,6 +26,20 @@
 		};
 	};
 
+	scm_conf: scm-conf@104000 {
+		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+		reg = <0x00 0x00104000 0x00 0x18000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x00104000 0x18000>;
+
+		usb_serdes_mux: mux-controller@0 {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x0 0x8000000>; /* USB0 to SERDES0 lane 1/3 mux */
+		};
+	};
+
 	gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
 		#address-cells = <2>;
@@ -683,6 +697,34 @@
 		};
 	};
 
+	usbss0: cdns-usb@4104000 {
+		compatible = "ti,j721e-usb";
+		reg = <0x00 0x04104000 0x00 0x100>;
+		clocks = <&k3_clks 360 16>, <&k3_clks 360 15>;
+		clock-names = "ref", "lpm";
+		assigned-clocks = <&k3_clks 360 16>; /* USB2_REFCLK */
+		assigned-clock-parents = <&k3_clks 360 17>;
+		power-domains = <&k3_pds 360 TI_SCI_PD_EXCLUSIVE>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		dma-coherent;
+
+		usb0: usb@6000000 {
+			compatible = "cdns,usb3";
+			reg = <0x00 0x06000000 0x00 0x10000>,
+			      <0x00 0x06010000 0x00 0x10000>,
+			      <0x00 0x06020000 0x00 0x10000>;
+			reg-names = "otg", "xhci", "dev";
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+			 interrupt-names = "host", "peripheral", "otg";
+			 maximum-speed = "super-speed";
+			 dr_mode = "otg";
+		};
+	};
+
 	main_mcan0: can@2701000 {
 		compatible = "bosch,m_can";
 		reg = <0x00 0x02701000 0x00 0x200>,
-- 
2.17.1

