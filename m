Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEEB5977DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241934AbiHQU0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241908AbiHQU0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:26:05 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE84A9278;
        Wed, 17 Aug 2022 13:25:58 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3CE8720022E;
        Wed, 17 Aug 2022 22:25:56 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C8A8E200240;
        Wed, 17 Aug 2022 22:25:55 +0200 (CEST)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.134])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 802EB4060D;
        Wed, 17 Aug 2022 13:25:54 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH v4 1/2] arm64: dts: lx2160a: update PCIe nodes to match rev2 silicon
Date:   Wed, 17 Aug 2022 15:25:37 -0500
Message-Id: <20220817202538.21493-2-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220817202538.21493-1-leoyang.li@nxp.com>
References: <20220817202538.21493-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original dts was created based on the non-production rev1 silicon
which was only used for evaluation.  Update the PCIe nodes to align with
the different controller used in production rev2 silicon.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
Reviewed-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 96 +++++++++----------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 6680fb2a6dc9..a7c549277dcc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1104,10 +1104,10 @@ sata3: sata@3230000 {
 		};
 
 		pcie1: pcie@3400000 {
-			compatible = "fsl,lx2160a-pcie";
-			reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
-			      <0x80 0x00000000 0x0 0x00002000>; /* configuration space */
-			reg-names = "csr_axi_slave", "config_axi_slave";
+			compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
+			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+			       0x80 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
 				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
@@ -1116,26 +1116,26 @@ pcie1: pcie@3400000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			apio-wins = <8>;
-			ppio-wins = <8>;
+			num-viewport = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x80 0x00010000 0x0 0x00010000
+				  0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
 			msi-parent = <&its>;
+			iommu-map = <0 &smmu 0 1>; /* This is fixed-up by u-boot */
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
-			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
 		pcie2: pcie@3500000 {
-			compatible = "fsl,lx2160a-pcie";
-			reg = <0x00 0x03500000 0x0 0x00100000>, /* controller registers */
-			      <0x88 0x00000000 0x0 0x00002000>; /* configuration space */
-			reg-names = "csr_axi_slave", "config_axi_slave";
+			compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
+			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
+			       0x88 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
 				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
@@ -1144,26 +1144,26 @@ pcie2: pcie@3500000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			apio-wins = <8>;
-			ppio-wins = <8>;
+			num-viewport = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x88 0x00010000 0x0 0x00010000
+				  0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
 			msi-parent = <&its>;
+			iommu-map = <0 &smmu 0 1>; /* This is fixed-up by u-boot */
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 2 &gic 0 0 GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
-			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
 		pcie3: pcie@3600000 {
-			compatible = "fsl,lx2160a-pcie";
-			reg = <0x00 0x03600000 0x0 0x00100000>, /* controller registers */
-			      <0x90 0x00000000 0x0 0x00002000>; /* configuration space */
-			reg-names = "csr_axi_slave", "config_axi_slave";
+			compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
+			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
+			       0x90 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
 				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
@@ -1172,26 +1172,26 @@ pcie3: pcie@3600000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			apio-wins = <256>;
-			ppio-wins = <24>;
+			num-viewport = <256>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x90 0x00010000 0x0 0x00010000
+				  0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
 			msi-parent = <&its>;
+			iommu-map = <0 &smmu 0 1>; /* This is fixed-up by u-boot */
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 2 &gic 0 0 GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
-			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
 		pcie4: pcie@3700000 {
-			compatible = "fsl,lx2160a-pcie";
-			reg = <0x00 0x03700000 0x0 0x00100000>, /* controller registers */
-			      <0x98 0x00000000 0x0 0x00002000>; /* configuration space */
-			reg-names = "csr_axi_slave", "config_axi_slave";
+			compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
+			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
+			       0x98 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
 				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
@@ -1200,26 +1200,26 @@ pcie4: pcie@3700000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			apio-wins = <8>;
-			ppio-wins = <8>;
+			num-viewport = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0x98 0x00010000 0x0 0x00010000
+				  0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
 			msi-parent = <&its>;
+			iommu-map = <0 &smmu 0 1>; /* This is fixed-up by u-boot */
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 2 &gic 0 0 GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
 		pcie5: pcie@3800000 {
-			compatible = "fsl,lx2160a-pcie";
-			reg = <0x00 0x03800000 0x0 0x00100000>, /* controller registers */
-			      <0xa0 0x00000000 0x0 0x00002000>; /* configuration space */
-			reg-names = "csr_axi_slave", "config_axi_slave";
+			compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
+			reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
+			       0xa0 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
 				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
@@ -1228,26 +1228,26 @@ pcie5: pcie@3800000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			apio-wins = <256>;
-			ppio-wins = <24>;
+			num-viewport = <256>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0xa0 0x00010000 0x0 0x00010000
+				  0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
 			msi-parent = <&its>;
+			iommu-map = <0 &smmu 0 1>; /* This is fixed-up by u-boot */
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 2 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
-			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
 		pcie6: pcie@3900000 {
-			compatible = "fsl,lx2160a-pcie";
-			reg = <0x00 0x03900000 0x0 0x00100000>, /* controller registers */
-			      <0xa8 0x00000000 0x0 0x00002000>; /* configuration space */
-			reg-names = "csr_axi_slave", "config_axi_slave";
+			compatible = "fsl,lx2160ar2-pcie", "fsl,ls2088a-pcie";
+			reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
+			       0xa8 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
 				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
@@ -1256,18 +1256,18 @@ pcie6: pcie@3900000 {
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
-			apio-wins = <8>;
-			ppio-wins = <8>;
+			num-viewport = <8>;
 			bus-range = <0x0 0xff>;
-			ranges = <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0x0 0x00000000 0xa8 0x00010000 0x0 0x00010000
+				  0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
 			msi-parent = <&its>;
+			iommu-map = <0 &smmu 0 1>; /* This is fixed-up by u-boot */
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 2 &gic 0 0 GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 0 GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 0 GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-			iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
 			status = "disabled";
 		};
 
-- 
2.37.1

