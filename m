Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0410C49DD35
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiA0JCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:02:43 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59486 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiA0JCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:02:41 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20R92YDD024483;
        Thu, 27 Jan 2022 03:02:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643274154;
        bh=R4xctapbqo6/4l6vi9qS7z3GpL4CiuP6lFnR0Fc/VJ4=;
        h=From:To:CC:Subject:Date;
        b=I7/qzCzP/mrVX/S7v3rUWXHF7IXOxNl8S0UwdNC2ETQT+6VQO0O02yNLVuTurPHpU
         nEXz+ykew5cKchGupRINoLEkoxEYZZ5r3Tf/50Uv+KkpW/DhgQAVCh218yahL3aPgU
         0dMCzi1wpRGFSQTrf1xupSuzIgmjeufd/sY0k9iY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20R92Y2u055004
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jan 2022 03:02:34 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 27
 Jan 2022 03:02:34 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 27 Jan 2022 03:02:34 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20R92V8E037534;
        Thu, 27 Jan 2022 03:02:32 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-j721e-common-proc-board: Enable PCIe + QSGMII multilink configuration
Date:   Thu, 27 Jan 2022 14:32:25 +0530
Message-ID: <20220127090226.11481-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Enable PCIe + QSGMII multilink configuration for serdes 0. This is for
testing Sierra PHY multilink configuration.
Add support for PLL_CMNLC1 to get clock from REFRCV1 for multilink case.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 .../boot/dts/ti/k3-j721e-common-proc-board.dts    | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 2d7596911b27..157d86dc2824 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -431,7 +431,7 @@
 };
 
 &serdes_ln_ctrl {
-	idle-states = <J721E_SERDES0_LANE0_PCIE0_LANE0>, <J721E_SERDES0_LANE1_PCIE0_LANE1>,
+	idle-states = <J721E_SERDES0_LANE0_PCIE0_LANE0>, <J721E_SERDES0_LANE1_QSGMII_LANE2>,
 		      <J721E_SERDES1_LANE0_PCIE1_LANE0>, <J721E_SERDES1_LANE1_PCIE1_LANE1>,
 		      <J721E_SERDES2_LANE0_PCIE2_LANE0>, <J721E_SERDES2_LANE1_PCIE2_LANE1>,
 		      <J721E_SERDES3_LANE0_USB3_0_SWAP>, <J721E_SERDES3_LANE1_USB3_0>,
@@ -757,8 +757,8 @@
 };
 
 &serdes0 {
-	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC>;
-	assigned-clock-parents = <&wiz0_pll1_refclk>;
+	assigned-clocks = <&serdes0 CDNS_SIERRA_PLL_CMNLC>, <&serdes0 CDNS_SIERRA_PLL_CMNLC1>;
+	assigned-clock-parents = <&wiz0_pll1_refclk>, <&wiz0_pll1_refclk>;
 
 	serdes0_pcie_link: phy@0 {
 		reg = <0>;
@@ -767,6 +767,15 @@
 		cdns,phy-type = <PHY_TYPE_PCIE>;
 		resets = <&serdes_wiz0 1>;
 	};
+
+	serdes0_qsgmii_link: phy@1 {
+		reg = <1>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_QSGMII>;
+		resets = <&serdes_wiz0 2>;
+	};
+
 };
 
 &serdes1 {
-- 
2.17.1

