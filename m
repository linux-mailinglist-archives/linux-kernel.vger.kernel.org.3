Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2444D473F82
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhLNJdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:33:02 -0500
Received: from inva021.nxp.com ([92.121.34.21]:56218 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230320AbhLNJcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:32:52 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B519A200D6A;
        Tue, 14 Dec 2021 10:32:47 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 793E12001A5;
        Tue, 14 Dec 2021 10:32:47 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id B26F540576;
        Tue, 14 Dec 2021 02:32:46 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 1/8] arm64: dts: ls1028a: Add PCIe EP nodes
Date:   Tue, 14 Dec 2021 03:32:33 -0600
Message-Id: <20211214093240.23320-2-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211214093240.23320-1-leoyang.li@nxp.com>
References: <20211214093240.23320-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add PCIe EP nodes for ls1028a to support EP mode.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index fd3f3e8bb6ce..9010c535252a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -637,6 +637,18 @@ pcie1: pcie@3400000 {
 			status = "disabled";
 		};
 
+		pcie_ep1: pcie-ep@3400000 {
+			compatible = "fsl,ls1028a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03400000 0x0 0x00100000
+			       0x80 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "pme";
+			num-ib-windows = <6>;
+			num-ob-windows = <8>;
+			status = "disabled";
+		};
+
 		pcie2: pcie@3500000 {
 			compatible = "fsl,ls1028a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000>, /* controller registers */
@@ -664,6 +676,18 @@ pcie2: pcie@3500000 {
 			status = "disabled";
 		};
 
+		pcie_ep2: pcie-ep@3500000 {
+			compatible = "fsl,ls1028a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03500000 0x0 0x00100000
+			       0x88 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "pme";
+			num-ib-windows = <6>;
+			num-ob-windows = <8>;
+			status = "disabled";
+		};
+
 		smmu: iommu@5000000 {
 			compatible = "arm,mmu-500";
 			reg = <0 0x5000000 0 0x800000>;
-- 
2.25.1

