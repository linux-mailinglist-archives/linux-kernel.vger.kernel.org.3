Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8017B51C5CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382600AbiEERL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382504AbiEERKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:10:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB755D199;
        Thu,  5 May 2022 10:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2VfDeCyIzvQID7GPeT+GRZ1WUoA7a8NVzmHfQVJ7u116l5kgMKetdRPkR514gCSC3l/1xtX5jugWiz2a2tO5RL/tL6Z6YkOZIhDMeNJE2JQF2wODkRimsTVyNmjUOCDC8ddKCmHDPPqCAuLFxA2aw2vS16gJgQDyscBPDPacy/HCbJQGK0m+NRgGbFlDA1oWBNbwXfKlT33/VSwnpthZWCdzhbNk0pvelIZ8RMVDXZ5HLnVoENhaa0TxW+61ZEvsQoS5S3H6juN4Ql/M3oRiFzUZnMGIvisqO+tW8oJZ57ivvrJbXsljJOohASyu7SYLBHANk1V8Nu8XM8vSVHxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGprANekO7cm/1gacN8QgXft56g+KEAxfmB6ofSY9kA=;
 b=Ma9uM3fAj6yy2B1r92QGt5XmkMz764S1pAnGLcok2EMy3x9m8E7vl+FEDypkTUiGVZE6s4EPDz8g5K3DYficwKxXoKLCOps+CI33DlR8FGU0aZK8xrNjnbtoR8gLTEhMKIjfEBz9b8yMFgc+Sahc0T2640m15Ma0N2P3B/vsuGyWCGHu46NTTEdYfpwq/MmBQK6P6IXxf/Z8N/U3jwrBClFMnqb4v3roZLWhqftHzlVp1QXMoFjp+YoSn2RuZ3dHJcCEbHvDcrVw+0mRQjse3UHK0F1Lku7w+U5BLS2oXv+SLTcv4ub+NxpXYXjvvIxl9fsrkKWvfYzGtM02Jbscyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGprANekO7cm/1gacN8QgXft56g+KEAxfmB6ofSY9kA=;
 b=X3CQs/F8JLdxkLksWwtqv28DGdqMBa9vo6J91NBqs1vUS9hPJ51hQaBJGPYXW06UUyUaq/nfeiT+gRDYDx4+pDi9sy6kefdBn75RoUoquzwIK4NZHTy6X25JffL/sJzfEQXYS/05l8ejdg6w0NRq3bj43KadKwFBQXlZODpHeBfcQpvEkqMUMKJv6RNXvgTi+cKxNOh3zb9iLEfiONCPqa0M/yUWzpmDk5yUDk8hjcP757SqgQ/InTtmO59GN/yyLFcRAMqSv1hB9yPEL32RS8RBAo/fS7kxLc4mYlq5Dc+RRlRJnZqK1uBVCtjom4iN7Qz1dwoFoqtxnkGUWSctvg==
Received: from BN0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:408:ee::22)
 by MWHPR1201MB0205.namprd12.prod.outlook.com (2603:10b6:301:4e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Thu, 5 May
 2022 17:07:10 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::86) by BN0PR04CA0017.outlook.office365.com
 (2603:10b6:408:ee::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 17:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 17:07:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 5 May 2022 17:07:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:07:08 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 5 May 2022 10:07:06 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v4 7/9] arm64: tegra: Add node for CBB2.0 in Tegra234 SOC
Date:   Thu, 5 May 2022 22:36:35 +0530
Message-ID: <20220505170637.26538-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505170637.26538-1-sumitg@nvidia.com>
References: <20220505170637.26538-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3271620-88ca-43ad-fd22-08da2eb9b12f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0205:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0205F7499F47307457450687B9C29@MWHPR1201MB0205.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B96w9GayjSmL0H7oSrdP+tUPf+G3qy1XmP1xcR+Zyhb15bbRrXyov4EayHIEOYdOT+ot51p6FtMz+7bJsdsYsPSDHr1lSNf1jp+1bdI3L4vf9KftcAAH2ZQbtceV0Y2FMD7Svgemn/fjwGoadWy2A+E6BI02Y8J28r/ZiBIhI3LqYiEFnR7u4OWJj6PkuNJz34YsxKEnsr3d0r8LrDHGG8LOxj4Qvo/p810uI0JXNS89a8cfl0qaVcnWTq+ui0fdvfISaM1HWbUPIGOkdPgP5JeFz37saAxcrpLtDZh18FOR4+tN/wMsk5O9FR7SDFWhK44rXVCeZKQuoDyUg3odtnL3yEphBCrznHJtc5QsOG95rlTSFUrxatZlH1LB+cPGJKep4hDnID91jz+gjX6sszpT3wUstVLDR+hvaNeeMK7/ljP9BSERqNlB0PIqWOt+uu8+eXktMg8QC5Cvo0629RwT7/wr2Pzy+8Z98V+OhWNhGX1/eyjfrrgSv8hHfRzv7wJF/bUZ1qU34/8tDPnjf0H8UZXVk34J4j6xqNmaJtCaj1vFcVjv5m5PWZlaCilg/tU/m2Ap/ibsAGtpaDBO0svtiXGr1UWwW+u7MvebugBZu6XbKCmC+DwB3fJJmOjXLLvm830R5IJf1ZM8QoXckAF+bHVn5uQ6AIerr6kawK6pNSNBDpsjVYtm1tKbUWWF4/E1IO8hwM2WACsthCDXLQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(110136005)(40460700003)(70586007)(70206006)(81166007)(356005)(8676002)(2906002)(36756003)(4326008)(86362001)(316002)(5660300002)(508600001)(54906003)(8936002)(107886003)(1076003)(26005)(7696005)(6666004)(2616005)(47076005)(426003)(336012)(186003)(36860700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 17:07:10.1167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3271620-88ca-43ad-fd22-08da2eb9b12f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0205
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Control Backbone(CBB) version 2.0 is used in Tegra234 SOC.
Adding nodes to enable handling of errors from different
CBB 2.0 based fabrics in Tegra234 SOC.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 71c21d7d0551..2ac6debe007e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -915,6 +915,20 @@
 			status = "okay";
 		};
 
+		sce-fabric@b600000 {
+			compatible = "nvidia,tegra234-sce-fabric";
+			reg = <0xb600000 0x40000>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
+		rce-fabric@be00000 {
+			compatible = "nvidia,tegra234-rce-fabric";
+			reg = <0xbe00000 0x40000>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
 		hsp_aon: hsp@c150000 {
 			compatible = "nvidia,tegra234-hsp", "nvidia,tegra194-hsp";
 			reg = <0x0c150000 0x90000>;
@@ -999,6 +1013,27 @@
 			interrupt-controller;
 		};
 
+		aon-fabric@c600000 {
+			compatible = "nvidia,tegra234-aon-fabric";
+			reg = <0xc600000 0x40000>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
+		bpmp-fabric@d600000 {
+			compatible = "nvidia,tegra234-bpmp-fabric";
+			reg = <0xd600000 0x40000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
+		dce-fabric@de00000 {
+			compatible = "nvidia,tegra234-sce-fabric";
+			reg = <0xde00000 0x40000>;
+			interrupts = <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
+
 		gic: interrupt-controller@f400000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0f400000 0x010000>, /* GICD */
@@ -1292,6 +1327,13 @@
 			nvidia,memory-controller = <&mc>;
 			status = "okay";
 		};
+
+		cbb-fabric@0x13a00000 {
+			compatible = "nvidia,tegra234-cbb-fabric";
+			reg = <0x13a00000 0x400000>;
+			interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+			status = "okay";
+		};
 	};
 
 	ccplex@e000000 {
-- 
2.17.1

