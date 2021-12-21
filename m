Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D8047C004
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbhLUMvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:51:43 -0500
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:24160
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235157AbhLUMvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:51:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khN815j9hq9I5sVIHRzg91Il5uReexTsIFg9JFNB3G240NYbG2r96L9JO/JYsVIliNteO+824rM7in+uPB7wtiQwiSISnKcezz/S2HwubR78ntwEpAozUolGYOegJ+T1hxoJBUhPJI8jF2Q4lWSXujaEHYFBcHVexPzcNuIcV3IE3UM2cRDxQhuKzKk/WkKnBo4HlB1O5GnwMavrO1mmgl1dAolT8r+IxYKBMGZYB+/PUB5qMtaU7iF0k7bh3XFpg9t9Xe5wdgDTqaDs2HU+0OPSw/XidoOtYth/hiWe5gd6kDR3uowynWlV0RHcqKt+GPp7DBx7FOHv+WU5Q094Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrTzuzVkHkdoEkxZZEBbamQ/HZPPn8PSyb6DIXse8dk=;
 b=BM+lg25woromPGFqKYheKwzeIo+lGh9OISoq+uti5sgRyvTr4E1/8GjMsRSDmLrDjAc1rduD3AM6ZDDhEajta2ICw86y6wNz4UGuy9v89e0C7/g8H/oQmcFAD8fkhIwDL70foA5bEok4/FXhDLdefaFnMHQ9Lhet7uSxLPlyo1aZLAEoUirnJE87m1hYJUcsuEeZZ2YG4n7y2BBzuye15okmsofLfXB3DnmummRZwNsUTyBdPQ6AjZB/WlN8zBzZ9SI4lBKgt0M3dFKhQgxrZ7ZH+3zjcwAaswIuMc1gMAE6+GTBR2U3EPDlmHiIYQBfrYtfOTZIS1n52lt20LLF4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrTzuzVkHkdoEkxZZEBbamQ/HZPPn8PSyb6DIXse8dk=;
 b=nE9UxySpM6d0F9Mkldi5NN4zq6T5qlVdV7Wdh49pY8XFsGkTzOk779v1uterqTU/qLWawjXb2D2Ma5Gt2SFlwc6sKO/yqeLDDO+GPydg67FZHxPgY6CAN/2epdWmrs9M5e7N8t77m/9TpLFKKS666ZEEtdRIM6vJfUOqwSBjuDCgxjxQNDjuIakioHAYw/DBcteeeXcJ/cA8gHKaUIzP0Lc3zeiuS+4UOUZ/r2+LC9+jqCbnCutGQFwiPutzV5TUOOTqQA0Guq9P9EKW8B2Y2aQjLcLeVZ58r/BIkfREwHFMnF9vw90RB/Y/PBxUvRodEITrfPHB548KKexJ4MIt4A==
Received: from MWHPR07CA0021.namprd07.prod.outlook.com (2603:10b6:300:116::31)
 by CY4PR1201MB0056.namprd12.prod.outlook.com (2603:10b6:910:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Tue, 21 Dec
 2021 12:51:38 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::c5) by MWHPR07CA0021.outlook.office365.com
 (2603:10b6:300:116::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 12:51:38 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 12:51:37 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 04:51:37 -0800
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:34 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <kbuild-all@lists.01.org>, <sumitg@nvidia.com>, <bbasu@nvidia.com>,
        <vsethi@nvidia.com>, <jsequeira@nvidia.com>
Subject: [Patch v3 4/9] arm64: tegra: Add node for CBB1.0 in Tegra194 SOC
Date:   Tue, 21 Dec 2021 18:21:12 +0530
Message-ID: <20211221125117.6545-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221125117.6545-1-sumitg@nvidia.com>
References: <20211221125117.6545-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2178e706-43cf-471f-b37f-08d9c480a0d2
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0056:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0056D46DF97E21D33318DE04B97C9@CY4PR1201MB0056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmMSL7rIIiWk6Cb9fwfPa7dBvuENWX4JQfcTGXNGfGGkvZIv9IU0AmSkx9Xn/u7Y0kXdvdeaCx9fxUePGcxe/pzZjnxaDZ1VrebT0S58ONDjlPiJSvXM37thhT0tAtp4XcBUdA4CUO7iLOwcUsdwXLMk2hOnxsQwpjMItV+4f6TyoaRKwcydttoXjE33eClqGhK4pOczSDgKOHwysotNi0+gkmLdnTX8577QgQxBusM9u7DuVkbZiHWscPI7yMzRFIn0On+dB79JyxnRb46ATx/Os8HzT1PsomsHkwuhM2o2SXPtrRBuCacvLhLGDV9myNrpyTQybCQ5khqqW7yNPDk8T0S4+7zIL+y+2o8hub4xK2q0Vcv8zTA+HpoX4ILp2d9FCXFiKbWy6PALfbKHtdu/FAxpsMoRCLAdjjoHL5heJygWh+GMuuwDuZRRADa51Cb/DKR59eG/g5/6W8k9BRyb9kqve+9HL5PS1XcrC+M40pJ0TmUgPAI950Z+MUFLaKrxA32L0Vsf05gAnwHHMrwWdnt9UvMEmxfthM3BSxFl7RTDXkrxlSwkbAZ3WQXwAxq3yWJc3859J3YdbURPcY+Mx6KYL1wCbipm/53AV/F0mx7tWqfZTxNuQTE5FQ7N+wQEFBImuxTZ9X06mqsQMKE9zT2bWE317yBu04J010K/AvoR+cNXeGU/qfJhigErpifRahPvhRHGIcPnSyxiGuJfc7fhZJKYcTVx+i3Db73VHcmcv2ewAAarI7ze4vj19x992BohBvIIKivXBbaOER9XVC9wK+OJwpXX3EtYnotKo0QlXP+RuZyhDIgiqAIOEpdwCPubsUOJYqXyMSRiag==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(5660300002)(40460700001)(26005)(4326008)(54906003)(316002)(8676002)(8936002)(70206006)(2906002)(107886003)(110136005)(186003)(6666004)(81166007)(36860700001)(36756003)(34020700004)(2616005)(336012)(86362001)(70586007)(47076005)(1076003)(83380400001)(7696005)(356005)(82310400004)(426003)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 12:51:38.1593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2178e706-43cf-471f-b37f-08d9c480a0d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding device tree nodes to enable the driver for handling errors from
Control Backbone(CBB). CBB version 1.0 is used in Tegra194 SOC.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 62 +++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 851e049b3519..dddc4982b35a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -22,7 +22,7 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
-		misc@100000 {
+		apbmisc: misc@100000 {
 			compatible = "nvidia,tegra194-misc";
 			reg = <0x00100000 0xf000>,
 			      <0x0010f000 0x1000>;
@@ -87,6 +87,27 @@
 			gpio-controller;
 		};
 
+		cbb-noc@2300000 {
+			compatible = "nvidia,tegra194-cbb-noc";
+			reg = <0x02300000 0x1000>;
+			interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,axi2apb = <&axi2apb>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
+		axi2apb: axi2apb@2390000 {
+			compatible = "nvidia,tegra194-axi2apb";
+			reg = <0x2390000 0x1000>,
+			    <0x23a0000 0x1000>,
+			    <0x23b0000 0x1000>,
+			    <0x23c0000 0x1000>,
+			    <0x23d0000 0x1000>,
+			    <0x23e0000 0x1000>;
+			status = "okay";
+		 };
+
 		ethernet@2490000 {
 			compatible = "nvidia,tegra194-eqos",
 				     "nvidia,tegra186-eqos",
@@ -1359,6 +1380,26 @@
 			#phy-cells = <0>;
 		};
 
+		sce-noc@b600000 {
+			compatible = "nvidia,tegra194-sce-noc";
+			reg = <0xb600000 0x1000>;
+			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,axi2apb = <&axi2apb>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
+		rce-noc@be00000 {
+			compatible = "nvidia,tegra194-rce-noc";
+			reg = <0xbe00000 0x1000>;
+			interrupts = <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,axi2apb = <&axi2apb>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
 		hsp_aon: hsp@c150000 {
 			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";
 			reg = <0x0c150000 0x90000>;
@@ -1374,6 +1415,15 @@
 			#mbox-cells = <2>;
 		};
 
+		aon-noc@c600000 {
+			compatible = "nvidia,tegra194-aon-noc";
+			reg = <0xc600000 0x1000>;
+			interrupts = <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
 		gen2_i2c: i2c@c240000 {
 			compatible = "nvidia,tegra194-i2c";
 			reg = <0x0c240000 0x10000>;
@@ -1552,6 +1602,16 @@
 			status = "okay";
 		};
 
+		bpmp-noc@d600000 {
+			compatible = "nvidia,tegra194-bpmp-noc";
+			reg = <0xd600000 0x1000>;
+			interrupts = <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,axi2apb = <&axi2apb>;
+			nvidia,apbmisc = <&apbmisc>;
+			status = "okay";
+		};
+
 		host1x@13e00000 {
 			compatible = "nvidia,tegra194-host1x";
 			reg = <0x13e00000 0x10000>,
-- 
2.17.1

