Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62D746F193
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242790AbhLIR0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:26:04 -0500
Received: from mail-mw2nam08on2065.outbound.protection.outlook.com ([40.107.101.65]:18240
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230216AbhLIR0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:26:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvQeF7UetndRkY792Ce2VFlTWzV7ZIHPflDayjVBbhDBiCP52Py7T0NLFdduPWx7RHHJpLR2c/SZHs7inaB0hKcGT5DwvtOCvb9fA1S6z0biCLc/6rmHP9voaCbeXcCpXC/xMZlTxiNE/2J7b0gq4oOHmuxUnUVaKydItsx7bpHdGHSmg8+sGy9EPvMEXtHQhS+TT2isuJ5gCXRNnNww02NSlJhZgxnY9O87qnFi/Hy4dX0ZIZbY0AhTAjfyn/B5Gaqc9qWdbrM5gRpgXGbRUAWcwUwAG0gQ0RTio33IJxwJtc3wkJ8bGXAYBYd9ksw6V+H8xTD5bY/89adjDlCzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYl6BRrI6/jay0QlDZzNIGU3T8P25PYAHfN6lWaPn1c=;
 b=PoT6F5ZE04yD/grIy5BYkfBN3AVKu3AbnMCHITpGEQ2XL7gf9VkDK4GEeW+d1kO+NIh+FBnjCGtneJuI4t0EYsfbPOvfSCK8liaz4T6hbPp1gXWX7rET103WfmZq5y4Tx2VjiFnZkGl/vDjU55Ce2QJGRN8MXgzFhD1xYBSlfB4n0IhfE2IGnjXqwiEe0lFmZqrEgq0UxcScH6Slqu61cI+YXqx5oaNwFb+OblW9K6ZT6Gz1SUv9hWyXegHpgIDAfDX2U4Gbr2cX/fKzIqHFzJE+xX0RhtqsJHtuFoKenk7dQdCOYtqZDqQEUGGo0rrRoVfG/M3EXi9JTULh7/lwnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYl6BRrI6/jay0QlDZzNIGU3T8P25PYAHfN6lWaPn1c=;
 b=p9UvWhM3j5gl1fp/40L3L2P7YX1dSpQLAyO/tMyezRirUyY2PdtdDOo6Q5T2TJiakUSj8LqPx95zaVbxRBHnnrIN7AcRdjmtRgtVd8XiK8MLpH9O/7VRS3NhRQv8tAtR5pM5MshVodi17aaMjCWgzN61mycIXQIdNXuLU13CVbvXLeuqH6WbrDoXJbDJ693c+8kporkSkWFW9xhgzzkyHlC6ecYy7oNnBV6v/YuCYLdc5/mTy250JzdVH/vlW2DV+mULOLknNC46E8tfW9WHz55MPvEhBo2wEct/XE3r5YSLLQqvZMcanczkJD18LSNgNoPnLIkYxTWfun7kXUJvTw==
Received: from DM5PR07CA0063.namprd07.prod.outlook.com (2603:10b6:4:ad::28) by
 BL0PR12MB4850.namprd12.prod.outlook.com (2603:10b6:208:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 17:22:26 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::67) by DM5PR07CA0063.outlook.office365.com
 (2603:10b6:4:ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Thu, 9 Dec 2021 17:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:22:25 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:22:24 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:22:22 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 17:22:19 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch Resend v1 3/8] arm64: tegra: Add node for CBB1.0 in Tegra194 SOC
Date:   Thu, 9 Dec 2021 22:52:01 +0530
Message-ID: <20211209172206.17778-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209172206.17778-1-sumitg@nvidia.com>
References: <20211209172206.17778-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f23f1b9-912a-4bb8-936c-08d9bb387853
X-MS-TrafficTypeDiagnostic: BL0PR12MB4850:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4850215F5F4AF659EB14C3D2B9709@BL0PR12MB4850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHX0/ed/FvJnf/xTtzxSpX2CuI5X4RxXk6tY8AwyUvqLgNlmwUgwMq9bMZMuKrC6Z2Uur7wMTX8dHPtHVZplyepJUxJlKacJhOXNj7QjEEjTc2ACfJl/ELW6oEBqTu0VY4koxwHq231XU5T7CmaK8f7Pw4bYoixYe0DDDCFMc6wcZ4CYoXWDX9S1HO/jgaK5Dc3JNV+/hl/hXz7cp7I00og95nehQN9xjOhX+e/eQypuAtbCGXA25TJ2HFB4ObGro4xKLScWS7zzCiGy9v8scpDN28xiSSMJfmYiM8oLownOBnbAL0JE5A6IcyyJJJ3oa9yRts8GnLbPSuMPk3ISA0cbd+1/R6QqiG8oadH/49w91o/3M7vOW3S20kLV4iCQJ7BD9NwAJJW850Z07pv1bwFhLUvB3q4vtIu1g+b0ZSR0cPhxeHrPLaDkeKFaCo/Vdg/vHVm043huXVrzNqz8lFVfnUyJRROdtASajG5u+gP079Ihx6qvYKQT1NjRE0aae8WGBZVg7UwPRmPKqrENcbVEqz5r9fGOmGZZIEixc5xFUe2MEinRCO7wpqg9bYzvEaIZrA9d85b02RDZhuYtFiEhsCMGJk8vbgFiULWPW4CXN9aTk3hPsnf7bRy+sgz27lZl3630hVJbeFNuZkEnQDnEZA8yDe/Ntzn+KLkpJ+zbKicMwf7XA4DRyNq373sFkOMoxJjXJfr68wB5gMLXUbEIjWNn+vHn3mIcaEwfiEppI0Y3YAVBMXQk7v0c5Y5Zgcs2eYyMc+EfYYCNzKWlxB51kfMneCtALb8BEY8nuUw=
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(82310400004)(40460700001)(5660300002)(186003)(110136005)(54906003)(6666004)(426003)(86362001)(4326008)(2616005)(336012)(36756003)(1076003)(8676002)(70206006)(8936002)(7696005)(107886003)(34020700004)(26005)(2906002)(83380400001)(36860700001)(47076005)(508600001)(356005)(7636003)(316002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:22:25.6566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f23f1b9-912a-4bb8-936c-08d9bb387853
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4850
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
index 851e049b3519..b302a46ce53e 100644
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
+			compatible = "nvidia,tegra194-axi2apb-bridge";
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

