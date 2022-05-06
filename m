Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C87951D663
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391256AbiEFLRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391242AbiEFLQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:16:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7323A56FB7;
        Fri,  6 May 2022 04:13:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki/QeHMreXHuQtDmylTFaLO7YM7Wx0YY/Nwvtm6c3hxatVOP6XnMQati7Oj8sclLNM0JV0rmb5+tEF7R4poXVhEM5JbGKJqJMaWEmV4IDrTjCxOv12ggcr50MkRQ1fd10uJwt8pkvwzdQW7jee1XwQbEFEnTRXaUxmTqgiyA6105Ol5V+p3E1mBtWPqmeVnmNwitNQibQMU3QoJCV6W8SbmgzEpkBrJNOJSkddhG8GfVYdrMM4BJUlxwoe74bE32d7z37W0VqlVPknXNDJMEOHx6MxQm9vZr6hhtb407yhiF4sq9Md59OnaDpDRfYXO35P2afASlzGXm+gjloTy3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jznDdqnHjyPHibZtLc94PozjCBcV6Nsw3XZx/J9GSww=;
 b=bgzhobEoOj5S/eO+nagPv2BQ5DRg9nW1ijtYSQQ+kapNIypphGijVQQYZkjsxyw0wsOQtY/zqN10o2xRueHIQZjeZ8nOXV48suUP8n5Jw5iXt5GOFL3dhlvxKxIyPbF5hLCqV37NbK+cPGwyNQM4piWsxnJgMlsUsroaKYMXSAFW2v9THJ1WGdVUNcpBDaYOH9S8WaGQ3foCRRNY7TdT5Yk3KPDz9zvUBGLrGuvYShQ3K4A4cCc2LlsdAFxBqGcMaVOMZilb0BVFAsp+thAML+7osCybprjXp87xSieWojafcchdT8bLdAgYZtHXEGMFsa0H5cjdNA0p5o/veZI0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jznDdqnHjyPHibZtLc94PozjCBcV6Nsw3XZx/J9GSww=;
 b=l4fAk5ZmIdFe+USfDK40WVKCANV5OgaZhusOsDubp/fdhQeaeeVxH2efpVl+og7S1u46zoAdEhjiBh/7XZbNotOxDSefD+FyucHeI5XGNnxk6ZBpPkzT6EfCuPcFnAGm/i5qtPMw5E31wMbC6FAX4oQ5WZGcJpD46Fiwt15wtaKBPFYxsByNULI8pTThssN3dyU9OsjcLBwsbD/dun8pdqBgX9WO3545mS+b/oauzFY25cb+xcARKFpjah0IAHGXuDZNq/EBJ34Pu0ytKbTLBERPVo9FUhqH6f1OhSEio4h41D8Jpicypg7+46gfOBCLDUMTTVvP8ssXi8ZiqOp6Gw==
Received: from MWH0EPF00056D0F.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:11) by MWHPR1201MB0253.namprd12.prod.outlook.com
 (2603:10b6:301:52::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 11:13:00 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::200) by MWH0EPF00056D0F.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.12 via Frontend
 Transport; Fri, 6 May 2022 11:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 11:13:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Fri, 6 May 2022 11:12:59 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 04:12:57 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 6 May 2022 04:12:54 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v5 7/9] arm64: tegra: Add node for CBB2.0 in Tegra234 SOC
Date:   Fri, 6 May 2022 16:42:15 +0530
Message-ID: <20220506111217.8833-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506111217.8833-1-sumitg@nvidia.com>
References: <20220506111217.8833-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08805588-5d7d-48c6-94ef-08da2f51618d
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0253:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB025342F03116EED8D14E29AFB9C59@MWHPR1201MB0253.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUGfu7rEjYg4wJr8ew1zCirgoFPFl4PkcoOZVCci/3JP7wsDTLeyGBbRAM2fBC4MPgwdiIM43IB2iqsV1cUjHIwFHtOl4W84lx5zxT+9I24xIKhTHZ2R+zYHR2G5cYCeq70NF45b2W8xV8yCU1RWZ+x8y2WdnPJgrU3nch2nV4c9eRkeU2trrIjNJTGcHDf0wtijtnGpGZmwfKOB3WaDy29cIeMesCM2EMeKKDmbDOZmkA64tHeZx25aNJXdGjubOnWHE+mo5vMXnLANx1AD1QX3/jhaRQWF/KUWQblnXNWatNha1sWZqzX2dOjtWH1bG0tI72/ySNPJ4YiuIOZCmWxuKz/J+QFzzYCU6h0UHX/b9WNZ8yYeuXdcqugCT+iFcXQhdwMuqFM9IHTECUApbMFEj4DRTbqNysq8+C3Hw0l6pz5v3MkS2IwDqpksXLB/AFmNUKVqPBRYACNZcABL8C5tArrMxhxOnWiFIxw72FP+60oUfXLbIkKxYJVm+JnAQrjoRSb75MH6FDeZJaO2ncZGPamCksm4GCRU7DZiM9jAmF4RXyTUEk68zW6IdkoTxxS7Vo3/BBn5+OXQ8WaWW6qVgt25IQZowcVM8jbHRK/cmRx9UJ1w6226dewf9A7m6mu7udhyc2htRLI78hmRnjVq92BQYPukEsSdvrokfdxn4zVje5o6i71QnnmCdkJP3eSkVfrlsa9SUHqMcEEa1w==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(186003)(36756003)(54906003)(2906002)(6666004)(82310400005)(336012)(1076003)(47076005)(7696005)(426003)(110136005)(316002)(107886003)(2616005)(40460700003)(5660300002)(8936002)(8676002)(70206006)(70586007)(4326008)(508600001)(26005)(356005)(36860700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 11:13:00.0621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08805588-5d7d-48c6-94ef-08da2f51618d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0253
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
index cb3af539e477..5da0c379efc9 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -933,6 +933,20 @@
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
@@ -1017,6 +1031,27 @@
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
@@ -1310,6 +1345,13 @@
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

