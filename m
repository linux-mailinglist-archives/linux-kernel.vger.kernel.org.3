Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0825A6098
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiH3KUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiH3KTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:19:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E251A069;
        Tue, 30 Aug 2022 03:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661854728; x=1693390728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5en4qBuVzdeyn5IGKXiQxzbRqw1ndSal365HolbPArY=;
  b=uVoCIlReDe5zINvhbnhDYFNBFAFeDNg5MQbd+ZKyqCWxMA6WG2vLMfrg
   j4sU/MAKwCx11cIWfX85GkhWVg9i+RoQlHB/aO8H6pwJEb/+v/v4X1T9V
   QAd99IHnii5gWx84klJwYWLBBckYqfgdHQmLSmSyzXlaa3EfNPRNZhbRC
   W2SPTScbF+nKBJyJLEmntSrPM1SL4GdFYsaUPE1CIFVmnucpGb9gjsZEp
   0Qyp/IvzoMsce6jVJe/v6SbL5KMtjcOBcnfZQfqoP2Fkak4cQy8bemlcA
   OaqeCI9lNVnYNNdyVtPM6rFXUDxZ3EduCnUgzw9qsHcAHHld5onMjKZVC
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="174786808"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 03:18:45 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 03:18:43 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 03:18:41 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/9] riscv: dts: microchip: move the mpfs' pci node to -fabric.dtsi
Date:   Tue, 30 Aug 2022 11:18:00 +0100
Message-ID: <20220830101803.1456180-6-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220830101803.1456180-1-conor.dooley@microchip.com>
References: <20220830101803.1456180-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In today's edition of moving things around:

The PCIe root port on PolarFire SoC is more part of the FPGA than of
the Core Complex. It is located on the other side of the chip and,
apart from its interrupts, most of its configuration is determined
by the FPGA bitstream rather. This includes:

- address translation in both directions
- the addresses at which the config and data regions appear to the
  core complex
- the clocks used by the AXI bus
- the plic interrupt used

Moving the PCIe node to the -fabric.dtsi makes it clearer than a
singular configuration for root port is not correct & allows the
base SoC dtsi to be more easily included.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../dts/microchip/mpfs-icicle-kit-fabric.dtsi | 32 +++++++++++++++++--
 .../dts/microchip/mpfs-polarberry-fabric.dtsi | 29 +++++++++++++++++
 arch/riscv/boot/dts/microchip/mpfs.dtsi       | 29 -----------------
 3 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index c0fb9dd7b2c8..a21440c8ee03 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -37,8 +37,34 @@ fabric_clk1: fabric-clk1 {
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
-};
 
-&pcie {
-	dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x1 0x00000000>;
+	pcie: pcie@2000000000 {
+		compatible = "microchip,pcie-host-1.0";
+		#address-cells = <0x3>;
+		#interrupt-cells = <0x1>;
+		#size-cells = <0x2>;
+		device_type = "pci";
+		reg = <0x20 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
+		reg-names = "cfg", "apb";
+		bus-range = <0x0 0x7f>;
+		interrupt-parent = <&plic>;
+		interrupts = <119>;
+		interrupt-map = <0 0 0 1 &pcie_intc 0>,
+				<0 0 0 2 &pcie_intc 1>,
+				<0 0 0 3 &pcie_intc 2>,
+				<0 0 0 4 &pcie_intc 3>;
+		interrupt-map-mask = <0 0 0 7>;
+		clocks = <&fabric_clk1>, <&fabric_clk1>, <&fabric_clk3>;
+		clock-names = "fic0", "fic1", "fic3";
+		ranges = <0x3000000 0x0 0x8000000 0x20 0x8000000 0x0 0x80000000>;
+		dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x1 0x00000000>;
+		msi-parent = <&pcie>;
+		msi-controller;
+		status = "disabled";
+		pcie_intc: interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+	};
 };
diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
index 49380c428ec9..67303bc0e451 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry-fabric.dtsi
@@ -13,4 +13,33 @@ fabric_clk1: fabric-clk1 {
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
+
+	pcie: pcie@2000000000 {
+		compatible = "microchip,pcie-host-1.0";
+		#address-cells = <0x3>;
+		#interrupt-cells = <0x1>;
+		#size-cells = <0x2>;
+		device_type = "pci";
+		reg = <0x20 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
+		reg-names = "cfg", "apb";
+		bus-range = <0x0 0x7f>;
+		interrupt-parent = <&plic>;
+		interrupts = <119>;
+		interrupt-map = <0 0 0 1 &pcie_intc 0>,
+				<0 0 0 2 &pcie_intc 1>,
+				<0 0 0 3 &pcie_intc 2>,
+				<0 0 0 4 &pcie_intc 3>;
+		interrupt-map-mask = <0 0 0 7>;
+		clocks = <&fabric_clk1>, <&fabric_clk1>, <&fabric_clk3>;
+		clock-names = "fic0", "fic1", "fic3";
+		ranges = <0x3000000 0x0 0x8000000 0x20 0x8000000 0x0 0x80000000>;
+		msi-parent = <&pcie>;
+		msi-controller;
+		status = "disabled";
+		pcie_intc: interrupt-controller {
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+	};
 };
diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index a1176260086a..5974066298e1 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -464,35 +464,6 @@ usb: usb@20201000 {
 			status = "disabled";
 		};
 
-		pcie: pcie@2000000000 {
-			compatible = "microchip,pcie-host-1.0";
-			#address-cells = <0x3>;
-			#interrupt-cells = <0x1>;
-			#size-cells = <0x2>;
-			device_type = "pci";
-			reg = <0x20 0x0 0x0 0x8000000>, <0x0 0x43000000 0x0 0x10000>;
-			reg-names = "cfg", "apb";
-			bus-range = <0x0 0x7f>;
-			interrupt-parent = <&plic>;
-			interrupts = <119>;
-			interrupt-map = <0 0 0 1 &pcie_intc 0>,
-					<0 0 0 2 &pcie_intc 1>,
-					<0 0 0 3 &pcie_intc 2>,
-					<0 0 0 4 &pcie_intc 3>;
-			interrupt-map-mask = <0 0 0 7>;
-			clocks = <&fabric_clk1>, <&fabric_clk1>, <&fabric_clk3>;
-			clock-names = "fic0", "fic1", "fic3";
-			ranges = <0x3000000 0x0 0x8000000 0x20 0x8000000 0x0 0x80000000>;
-			msi-parent = <&pcie>;
-			msi-controller;
-			status = "disabled";
-			pcie_intc: interrupt-controller {
-				#address-cells = <0>;
-				#interrupt-cells = <1>;
-				interrupt-controller;
-			};
-		};
-
 		mbox: mailbox@37020000 {
 			compatible = "microchip,mpfs-mailbox";
 			reg = <0x0 0x37020000 0x0 0x1000>, <0x0 0x2000318C 0x0 0x40>;
-- 
2.36.1

