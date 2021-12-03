Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A104680F7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383602AbhLCX60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:58:26 -0500
Received: from inva021.nxp.com ([92.121.34.21]:58086 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383563AbhLCX6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:58:21 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E09C1200B39;
        Sat,  4 Dec 2021 00:54:55 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FA66200B07;
        Sat,  4 Dec 2021 00:54:55 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id B9EEC4030F;
        Fri,  3 Dec 2021 16:54:54 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH v2 05/10] arm64: dts: lx2160a: update PCIe nodes to match rev2 silicon
Date:   Fri,  3 Dec 2021 17:54:41 -0600
Message-Id: <20211203235446.8266-6-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211203235446.8266-1-leoyang.li@nxp.com>
References: <20211203235446.8266-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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
index fcde09f36018..de680521e1d1 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1088,10 +1088,10 @@ sata3: sata@3230000 {
 		};
 
 		pcie1: pcie@3400000 {
-			compatible = "fsl,lx2160a-pcie";
-			reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
-			      <0x80 0x00000000 0x0 0x00002000>; /* configuration space */
-			reg-names = "csr_axi_slave", "config_axi_slave";
+			compatible = "fsl,ls2088a-pcie";
+			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+			       0x80 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
 				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
@@ -1100,26 +1100,26 @@ pcie1: pcie@3400000 {
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
+			compatible = "fsl,ls2088a-pcie";
+			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
+			       0x88 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
 				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
@@ -1128,26 +1128,26 @@ pcie2: pcie@3500000 {
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
+			compatible = "fsl,ls2088a-pcie";
+			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
+			       0x90 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
 				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
@@ -1156,26 +1156,26 @@ pcie3: pcie@3600000 {
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
+			compatible = "fsl,ls2088a-pcie";
+			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
+			       0x98 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
 				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
@@ -1184,26 +1184,26 @@ pcie4: pcie@3700000 {
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
+			compatible = "fsl,ls2088a-pcie";
+			reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
+			       0xa0 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
 				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
@@ -1212,26 +1212,26 @@ pcie5: pcie@3800000 {
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
+			compatible = "fsl,ls2088a-pcie";
+			reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
+			       0xa8 0x00000000 0x0 0x00002000>; /* configuration space */
+			reg-names = "regs", "config";
 			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
 				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
 				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
@@ -1240,18 +1240,18 @@ pcie6: pcie@3900000 {
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
2.25.1

