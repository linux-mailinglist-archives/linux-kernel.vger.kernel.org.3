Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C24B46F1A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbhLIR0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:26:35 -0500
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com ([40.107.93.52]:29919
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242822AbhLIR0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:26:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBBdMLvFG4gMIOGCUAnvSjzWrVBf0mV3YjYol18I7w27hHc+Sc1nj39TwxonnxVSfRLofwcqXOzVMl8hsE1CgS/JJ6eda3LFt6aACBQ/Mzyrn544rO0Of/R8gHoK4DWpRJBLLdQWNrahPYaPEAndEeJ0Olvz3xzvOmDTURZh7uEMCG9xN9bAjpzdI01FPhHtugLWP6MN2nsg0E+xYqOLY1zi48ALgFwXnS95WbkB7c9RtYnR3nzqTjzbD2c0FXa2db6j+vFwTXvEZZ4y2JW6j7NMtSjNcgloL9o7NtcrrYwKUoyRMdg23yYz0Yl3kPwq85v5DDk02EvxKN72M45V7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGOYl1cB2bC15bWFwlS9ENKB2eHX3e9CCDllNj27zQc=;
 b=Uqy8wGZRojd+0f4QDW7610jY36J+2YjU+jJjpWzc8mDwlEByeXnOpzofSeCKBgLNkP3j1PAAwysx3REKLNVOPL8dmGrfmcQUnHHHlfZzH2r0aWYDs1u6C4h7BQBrzkKdav0OqjfYsePr9REadeg74Z9NNBAFM2cp+/EgkWfAppRDasURESMZF3UKZ4edziwZk90ezhzWx1PQFBCdP9JxQljo+mdttwUqZehuCwESuo64oSTNb4QofYG11a5N+GWdJWy7IYCQUdu3oS/sTdIYmyuRYU096aJwpJx1D8wmwLgkhxS0DXFT7/08UZ77TDqLZ29BNbzb/KJeret+PKV3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGOYl1cB2bC15bWFwlS9ENKB2eHX3e9CCDllNj27zQc=;
 b=BjoFUB0LhzPDSS3NuNgO6LYwsykTs8VdGa0n4ONc6U3uWwal+1WtvWIo9FNVOMRLF7ziccndmCkJA6QZuqwy1vZ4QdOlR2xU8qwq0QIW+G+G00qYR+kEBHXQAALViqmqBiQJ/Mi8CvI9qJdMdwwrAhfooD+IO0dRknfb6fMZjSwagSqhA0K3cYfogpZ5Hhv+IxWndCCGOQb5l4imKRc0Isdu2kXMO3KN2hWPEamdH9+G6uVnO1BfaIFTFqhDKW0xGMAxs4kdshkh1YdJmyNSbZdBlEpgusYSYyVfFEkgICSHd+MX7mdEAju9ZUEzmeH9svBhKf+LoEWdrJ2G3zPL4A==
Received: from MW4PR04CA0321.namprd04.prod.outlook.com (2603:10b6:303:82::26)
 by SN6PR12MB2655.namprd12.prod.outlook.com (2603:10b6:805:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 17:22:43 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::3c) by MW4PR04CA0321.outlook.office365.com
 (2603:10b6:303:82::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Thu, 9 Dec 2021 17:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:22:43 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:22:33 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:22:31 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 17:22:29 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch Resend v1 6/8] arm64: tegra: Add node for CBB2.0 in Tegra234 SOC
Date:   Thu, 9 Dec 2021 22:52:04 +0530
Message-ID: <20211209172206.17778-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209172206.17778-1-sumitg@nvidia.com>
References: <20211209172206.17778-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8c65f6c-07c4-4845-6ee1-08d9bb3882ca
X-MS-TrafficTypeDiagnostic: SN6PR12MB2655:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2655B85FAB3CC2C421D6A433B9709@SN6PR12MB2655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aDWmvwg+B2WXeh76ejCTscoVR3ViwaXad9d+nfNRutYwBQxpsFL8eLIDxpFznfNxEHZbRwBP3i8MRVEBmESCklpYFPEIg2P0yDh/vwosuNswCf8TWIS6GEM1i13xvUFekOruQs10ztKAS4EvZ+8jg83qOHoVeimZ16ZTd+rxvs0FpEKBX1V06M5Bxp8atP2aCAXrInI2dnBk3dPB9CjrKN/J790TxxwYrOkyh1yIsX8e/CMWIHkPDr0nDd+ovlRMQpNvnx5nvDTAFsOF2biaGkTmIN2zlxA2ePNl8zLRxD97B0n7w8OmSB9NrxnMlgrcKBEscEYA/fsOPY6n5ZE2ND1NKzYahGscmj7p++i0SJVTzLLrZu4GM9rQeRaeeaRlzOrO3zC4CSJ+7i3lVFTEcm0pubRgqe81y8ji+2YXcMp9uYFHHb98q8AdH3Yy0VLq1fCD5mjAVDzS5Gh2PIcAm+VQQnMOI53N1BAgVf5GMsNemeUHo2F3ZVvZQpRoeNRK9eYyd9U1VGymSF1M0XbxhVFPedqijdAQwrILEEt1egAZqU6ACyzvw0B0zv0zJfe1zoZDjWflzlS4/y1clggtNPCdpQ18bWLeOgPFM8YEQj1hhXrzjHnbTnroAvklYgM4hXzVztslVWs+0s8DZjBrpMWFPVgA4xo6CKbMNo5mNk42fnYWtlhuWt/sFJg1Q1CE+sZ5ZO8AqrjzrBaq7ybSFpj+wnXzW0N+RDyYyGWFLPOkc2l1UEntSZw8+G5xgYpWniHDqToXCqJdFhSRggQoZMVGXBSIkrsq6z3lY2iN7bc=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(5660300002)(8936002)(8676002)(70206006)(6666004)(70586007)(508600001)(26005)(82310400004)(86362001)(186003)(4326008)(107886003)(40460700001)(1076003)(336012)(110136005)(34020700004)(2616005)(54906003)(426003)(316002)(36756003)(356005)(47076005)(7636003)(2906002)(7696005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:22:43.3066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c65f6c-07c4-4845-6ee1-08d9bb3882ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2655
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

