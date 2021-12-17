Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D09478AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbhLQMHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:07:31 -0500
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com ([40.107.223.82]:16769
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235983AbhLQMHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:07:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ymk6WdwICqjQ+KssZ4ZpU081N/0ur6zLn5CZLfouQyUEPAe9m4SxnYkHHdBmtEoup8S9QlVptsK5YG6uCgZjK8PZIUIkwJJAcijmBgCgxeq/3LVSw9/hUBs7qcCg4B1W/gqyYkzE1DWOgqlAvUGfurhoO1i/llQGm9EDr2Ivq0Np9Uon2JCcVpI3qqXTOfDldCG+V0FIr8HAnmk+VtMuO9Cuopn/cpg8k/PtItcRx90AQz4Rc1C9YzmpcUsbBfFVfWiKYQZRymaD9iFm7uX74DjKg1ZR1ee3pGE+XPJN50HEq28ItkXAX6FQS7r2kI3DVOQ4ZvW5lfNZBL/l7nxnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrTzuzVkHkdoEkxZZEBbamQ/HZPPn8PSyb6DIXse8dk=;
 b=klZueHxXE39pco9vyUSalfpZUikwpFKUzJtmXELqQKnfYa0AIhjvgL14CJOcNUEGu/V8va5UhT32Ik5KZmExRR12XvWoxb4KqwbkcFpWJ22jr1xttx/qenzXiQvftZrvMobmYW2N/lIU908etcz+jnjViJ+SrYP5+clGAN4WXgN7LNc9NU0SWnyFeitITLe+fHWnsUNVBTMxJ39fFcSxhHBnVo0O5Kvy9pkrfAaExICOT05JbUM/dSEF7SmDnavEPddQ2WW8B/Rgt8k2VqcihQjr4K2+08TpXe6rArmvfdpJmvH7P3MiUlNC/EP2yYrVTD4asTeh3b5tUecV2TZasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrTzuzVkHkdoEkxZZEBbamQ/HZPPn8PSyb6DIXse8dk=;
 b=ECWcTUU+T7rBMo9ki3v48LCL5HhPqhCHEgrl5pUZO3Afz82nFBNL5iUZUCukp372R7PAVJP39v3N7jxk0HLwjUS/JxLV6bmilPa7NPjUVk3wdUQoM8Ta0dBdgRXiShSUDqTgVZzIAx/aSTkbCe+eHMZQXBinyzO8mQZ9zFjRCoQAe+UHS6RVzg0RZFbZ01s5gbqqwvepGVgLeoONyy8p3IbrHS067N91EgkUWUCF51qqtiZ0ZRjAIAgXIdqlmpzOvfaPF2eIW4L8D6SizywDS8mvntUwh+DfPb0okeGHwsvWmqnEKtUfApU1VQ8qlmE9+D8dyI8SEaWTmMa0iX/ihQ==
Received: from BN6PR13CA0072.namprd13.prod.outlook.com (2603:10b6:404:11::34)
 by BN6PR12MB1474.namprd12.prod.outlook.com (2603:10b6:405:f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.16; Fri, 17 Dec
 2021 12:07:19 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::d9) by BN6PR13CA0072.outlook.office365.com
 (2603:10b6:404:11::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.10 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 12:07:19 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:18 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:17 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:15 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v2 4/9] arm64: tegra: Add node for CBB1.0 in Tegra194 SOC
Date:   Fri, 17 Dec 2021 17:36:51 +0530
Message-ID: <20211217120656.16480-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211217120656.16480-1-sumitg@nvidia.com>
References: <20211217120656.16480-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43eed0bd-8252-413d-44b5-08d9c155c655
X-MS-TrafficTypeDiagnostic: BN6PR12MB1474:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB14743A24A311818C65D9766EB9789@BN6PR12MB1474.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jchx5JvtMd9OpcHZPwIyk0qCQ9HhV2pBwo6sP8MyF7fTxM+QBYnqv6w5y5NyyAmdCAEqGMnFx4IbSIMEYMgVDGEIs+PUoSFEWHBPbWj9427YERpDcdXCAZb7gT4Cpg2BYZ1athSYgd10dkq+mh+MZ4dnQNjTRCcB0YSkIeqVVOXqVxllxSpIA8UrOk294maUuEgbx0dTzoamTNouImR+NLPVvJ2GctIeDy3GWMoCPwAnYolNsXOlzdM4VnNXUm++4y8nxSDkSYIhPVDdfz8sp8u1+TPvkxxIp9I8ViJcmj+AjPMCZY2+NyEeCAmT3v+9BPGxnpu+VEVZP6m+0pOQBJ+Q9heHidXm+IQIjkRdNhfaZH6wa8NJ1COgP6hHTCgD3MWS1x3t6G1G55Ak9nRWVZINgVy/OwuB2Lq1XkICyGx8hwrk6KVYyv67pitApFQ6/v65qakcrHjvbKYUvKF+NqmcSgCB7RGx73y8kvYpVMk6hqeH31wVNn1jrGAY3X4ieLIE2uvu+l+sX1vzXCZXCNWoJRSNAPt/vl7g3uUjyuEl89oq9j1Lznn4mKmT+8g78QCJzTI1iT3UbOEEe1XJFUKfUnUQRCpxXUxXA9bADR8c/Xe4JHv/I2gZPxV7Vcc7gfi7qvJynXUOf/LV0gVeIcJPhU/XCCUT3pW2IE8UJKsijsGSWOCIv17QqPGNW7WhpdWQSAe45R4Ga5jrVwSDIFHRmrDw8toCqpNvOknmMFCmgNjOOzrSpwTozdc4rSfLiPLeSEc6PL87wai+GhyNhYrM7rg1R+SpenPYItjgufqzl/8Dz8EaTQVMxK6TB4bJe7D+G8FsIv7Or17R6lQoXw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(336012)(7696005)(26005)(186003)(83380400001)(86362001)(81166007)(47076005)(508600001)(6666004)(70206006)(2906002)(70586007)(316002)(8676002)(110136005)(54906003)(4326008)(356005)(36860700001)(8936002)(40460700001)(1076003)(107886003)(34020700004)(82310400004)(5660300002)(36756003)(426003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 12:07:19.1761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43eed0bd-8252-413d-44b5-08d9c155c655
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1474
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

