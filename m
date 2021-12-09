Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD0C46F0C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbhLIRLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:11:07 -0500
Received: from mail-dm6nam10on2066.outbound.protection.outlook.com ([40.107.93.66]:26562
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232090AbhLIRLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:11:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3M2BtVNwiFe932gaRkTyQmWbdz4wP1v0E2AgcN7Vf3mov6m3yY5orDCFGbooLOVCAtnZ+kJ46Iqca7UpbASrG77bpvbdqK8r1127ybZoxukGXLmuDoU80xw7KCS797m92H0z8dkzebGj0LNiPwWSmvBZvnF2YlF+VX6qHxNPAeHIjKllRQdmH7UONhtfkS6FNo64Mwt7KD48zp89MDRLxtXRPOQWBAN8ckSUEtNuoJ4FhvIaveWRmcB0gtoOHll4tuK+SJiJ58VhtRnppQ8urVNt8u2erELmBb/ATDu1lzXsa+2kg67LudwDluCx6VzOKbnlgTqxTfyR+7eDIcypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGOYl1cB2bC15bWFwlS9ENKB2eHX3e9CCDllNj27zQc=;
 b=m6a58Hq+QV9Y8Kx+hL4gI46RdwY/YmGxd4oc9fyRYFMpWFDIIuAXZl4QDSn7/ls7NkTp6cXkM1B2+WbhUEGJlTLFF8T1Geo6cR2LgG0Yktb7viNTIn2ugbyZdfo6ktfEI8/yVZXk1qnWFfDMumFPwSu6vKDClRRio00Ziw6UXIglzKgtN9BG4fXUytiQemWUAwJLQtyafk2Bh5VD1q23ZCgjQIgBzMVkmK9TKxxreErz/GecsqmtwzSgBl5f8+83yRDrCjkU95PQTjpcQHk7ZF79MNNIS0gcAxknVxQtxc+ztnVm2Ufh65QaWGmQWlXpNWBTGdLYuPy3Bg4uDuGQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGOYl1cB2bC15bWFwlS9ENKB2eHX3e9CCDllNj27zQc=;
 b=dhCfWKZUQQBFvJI/ha1A+Evb+8rULPn83NpXeIvE3cqhNevylZqyrfrEmnU9AJsPvehdKkX4r8dH9+QOV3fCJSPTlgYbZ9QitAcKkXxxLSvWn/4ev4GFrup+p7rawjkkauUci0STkgeTBcmDqn/VuaoH0oRgb1KoGUcuv8w07SzPi8KRRg4obH7ZC2P86BjCwVaGrZctPVQk5Zc7zR6hllRpeC0vW2SSpV5AKMlRCR5Zi5DmNuqZGwun9K2GCOe1olZn4sQ0Z6avEC6mC0WWZIN7qD/8hAffYls7gRCOp79PinzbMPeTMtmFUSqODSNN+25O0gQOguW+JqUD7aX0ug==
Received: from MW3PR06CA0020.namprd06.prod.outlook.com (2603:10b6:303:2a::25)
 by CH2PR12MB3861.namprd12.prod.outlook.com (2603:10b6:610:2a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 17:07:24 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::fc) by MW3PR06CA0020.outlook.office365.com
 (2603:10b6:303:2a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend
 Transport; Thu, 9 Dec 2021 17:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:07:21 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:07:21 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:07:20 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 17:07:17 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v1 6/8] arm64: tegra: Add node for CBB2.0 in Tegra234 SOC
Date:   Thu, 9 Dec 2021 22:37:15 +0530
Message-ID: <20211209170715.17392-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d03beaa-c110-47b7-0a32-08d9bb365da4
X-MS-TrafficTypeDiagnostic: CH2PR12MB3861:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB38611780B596549098AA6DCBB9709@CH2PR12MB3861.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAWRbI5u7f+OzdUNIhnja8/28vyC/sCXK7Wz/Uxr2MI73274VkPMNzWLCjLqatpSI09Rl/e6PUhUrI2jYKhmF9w3divCTkRPZux+t/uaFKTZGGqW8XY1PVxMoZnI64OyFM7GZTaER9Aq9Bxe7B1bWLJ66E3qQT5ZALYS3+P9sni/s71kpjRmvsy/PCHldS/Ai1PqsmPn0v40J8BDMwXZw75tDITjRdh0kGtoFdpsUIIdfiWvBmLX9bIi/9Aax5Niry0dNo8c3qHR0OO0VJPBLBKjMmptiqI6Ilxy2eSQDMVsiM/hVDsjmVk1ZWuz4n4TrxNYKw4xLssb7VXb1yjbnRc70CB0KFQi8TyDhcmyo3fv9k2cKK/VdZ9IOF1Nq44h7rvx/mjDB1dB5hRvI0Ge7yNZYPhqn/md59HboipdhNGKtIWe+e1UfKCoLPS5jQG9RUlqrGUQVxxMhaLcGwnpAhwQFf9o00JUvf+0YP0dOKkbX3GgqNOwd5zkiPmJEnnCJNzwPaHsLYl9ZU0lEI8yG75eSrLvOCaaIgYc/IaFFGpyaRU/6ysGe5OGU3rYH50IWYSmG0ues5/Bqh/S3usCgJBDRMkjKwqtknwMU2Nbcnga0pcO52LrB+7uzATK4dAKfyyBIYIvI5Dwf9kzP48MTBdcB4PiDJP5igGvZdKyDLdYxOBNWwoH9h+8qXdzXXIyNjNu+2+SI2xUaRIhnWgaDdpN6gIQht5jj+O9VV1UEM8IeS/AukSme3WCvhpHjGP6bn0YLtBq9ptpQ4tBeK8TeyUBmmhzZpP66N7mGErzlfE=
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(4326008)(110136005)(356005)(54906003)(426003)(70206006)(70586007)(336012)(1076003)(7636003)(107886003)(2616005)(8936002)(5660300002)(26005)(34020700004)(36756003)(82310400004)(2906002)(86362001)(186003)(40460700001)(47076005)(316002)(8676002)(7696005)(508600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:07:21.9858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d03beaa-c110-47b7-0a32-08d9bb365da4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3861
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Control Backbone(CBB) version 2.0 is used in Tegra234 SOC.
Adding nodes to enable handling of errors from different
CBB 2.0 based fabrics in Tegra234 SOC.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 49 ++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index f0efb3a62804..4cef45df0a3e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -73,6 +73,22 @@
 			#mbox-cells = <2>;
 		};
 
+		sce-fabric@b600000 {
+			compatible = "nvidia,tegra234-sce-fabric";
+			reg = <0xb600000 0x40000>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,err-notifier-base = <0 0x19000>;
+			status = "okay";
+		};
+
+		rce-fabric@be00000 {
+			compatible = "nvidia,tegra234-rce-fabric";
+			reg = <0xbe00000 0x40000>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,err-notifier-base = <0 0x19000>;
+			status = "okay";
+		};
+
 		hsp_aon: hsp@c150000 {
 			compatible = "nvidia,tegra234-hsp", "nvidia,tegra194-hsp";
 			reg = <0x0c150000 0x90000>;
@@ -109,6 +125,30 @@
 			interrupt-controller;
 		};
 
+		aon-fabric@c600000 {
+			compatible = "nvidia,tegra234-aon-fabric";
+			reg = <0xc600000 0x40000>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,err-notifier-base = <0 0x17000>;
+			status = "okay";
+		};
+
+		bpmp-fabric@d600000 {
+			compatible = "nvidia,tegra234-bpmp-fabric";
+			reg = <0xd600000 0x40000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,err-notifier-base = <0 0x19000>;
+			status = "okay";
+		};
+
+		dce-fabric@de00000 {
+			compatible = "nvidia,tegra234-sce-fabric";
+			reg = <0xde00000 0x40000>;
+			interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,err-notifier-base = <0 0x19000>;
+			status = "okay";
+		};
+
 		gic: interrupt-controller@f400000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0f400000 0x010000>, /* GICD */
@@ -120,6 +160,15 @@
 			#interrupt-cells = <3>;
 			interrupt-controller;
 		};
+
+		cbb-fabric@0x13a00000 {
+			compatible = "nvidia,tegra234-cbb-fabric";
+			reg = <0x13a00000 0x400000>;
+			interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,err-notifier-base = <0 0x60000>;
+			nvidia,off-mask-erd = <0 0x3a004>;
+			status = "okay";
+		};
 	};
 
 	sysram@40000000 {
-- 
2.17.1

