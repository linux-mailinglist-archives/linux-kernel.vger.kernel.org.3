Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7013251D658
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391246AbiEFLQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391217AbiEFLQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:16:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FDF58E5F;
        Fri,  6 May 2022 04:12:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEhtZ8WPhHnXlVPzV5eaUOopQZ/n95L7XTOM8Uixg8IthzBJ3DO99SEr4O0rUUgvgEnU3yiDKoxe1x8o9GzUbJmULbD9fHgbAvXr167YNPCm6tnhGlQFv9ODjt+gOGKumEwDoisoBwYwAHs6u3KFQ7hXu8XZouHwL8CS7gIJkKk6nrFlfGHgTgkT5q0ULzbhGy3pi8wMiwnKed9/FHklukakIr6X7H022UoPL+r0OrNvwKDkIWmFlav/OdoAy9zMVTkJMGpREIfBUAfyyzYkmzwZx1rKgx82RSHEM5nlNn3JGq/WngQdrNGcoYcO93VrQPe8Gm+EipLtemsncNgt7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7GWc1EzRmsSPnxOcKmqqym3uqWXt7sl5R1Evbn9erI=;
 b=WdnfjvadEjX4Il1PiJPKS3R4N9KUicMG4hkSeRvmBvcbMPwLu3+qWE2ZorrFHPVoRdED2IvYN0MbBF8wxEvO/cXXasRpmorZ1qwBMNoiuygmsaWLrB7AcwQ94H4k3c2S7DnZLM2MgI8F9KJfIBOXD3NV9r0cax5KPVoeBNmoUpvsrJgVnKMJ8blzNRVJLD7v7HQmv1W0OxiJOdPxiFywF2qlThig6T4U2UcF37syv9NaRkIzz9+4zGuW4d3pz0ZslMpDvVXbOU1t+M5jKbDbAwlftlnx6U0L5JEWSz6TETV5wmihRXN04yJ/77JyJIisXQceNm6D9E+ic3L2BHKNsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7GWc1EzRmsSPnxOcKmqqym3uqWXt7sl5R1Evbn9erI=;
 b=RnvP5roPp6uPRIhcaqpihjj44FmfMOUVZMzcJmTR9NghAeB0plA+Jw0YY3N6XcrIQwgJ1sCrxvM2brPkIkmae+P4PwOxm1jtwr0IAMogt4FZEJMnz/EcZAIKGtMepiwr2muckrP1GR9TffKlzn0V5VlULw4mk/6tBkUgZ6cCG2jUigQpFkkYLsOkXa1ysOztgV9lZxZPgUlCI9WHHKLc3ClKVeN0BjybqHuBh9sevaVqhgptwnylElsu45p2714CghxQgYm0YwMYzAPeUyUOMMIA82SnU1X1h2TCjeSCYMqBDGcZyzp5H6O6ERL6mKdIdZUFiQM//rjbwEeefy4U6g==
Received: from DS7PR03CA0232.namprd03.prod.outlook.com (2603:10b6:5:3ba::27)
 by DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 11:12:46 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::e0) by DS7PR03CA0232.outlook.office365.com
 (2603:10b6:5:3ba::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 6 May 2022 11:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 11:12:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Fri, 6 May 2022 11:12:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 04:12:44 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 6 May 2022 04:12:41 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v5 4/9] arm64: tegra: Add node for CBB1.0 in Tegra194 SOC
Date:   Fri, 6 May 2022 16:42:12 +0530
Message-ID: <20220506111217.8833-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506111217.8833-1-sumitg@nvidia.com>
References: <20220506111217.8833-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43e0e463-20e9-46de-86b4-08da2f51591e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0217:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0217E700FA5B6E2D51B2CBDDB9C59@DM5PR1201MB0217.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRf4CBrc9T9Z3W9MkSUjOAbFmJiw7OKL57370Ivl5Aj/v/z3zHk9ItywP7efhP5rbaVVwd0xHQvjnkhtvAeaX2u3eczW1mCoyY69MWoocY8zrYcRPjN17U8vbAjOopHrrhCy7hARp5rUHaXJFJcnCpKmAEMF6BqUAh+uN1DCUQAN/nCfS8jD09Y7dIa2c0X/rqKZqtmIGYUzwnU43J0+IcxOc0+ABAX/ALAU5C5UwGW3nspv+fVr4FKOnvPk4n2NEhSn0MCCQvQpFASFAp6YatgrMucbG73LfPWZ61O5yhybzZmH6INrF8Hrbf+xlDgfhHRirdI3Dc2Q6S6nv+rGUjXeySe+Ff/K1d0cSY/iACkijsc73d3/jnO0pgUmstlIuIpavb5EjdQZOJmYb2H8rsophy1PYbjAX66BIAhdIu+bOGxsvg0l8FqjfOzo57E3QvTvZMicLVcl9ovvPI1dfKTAmYZ69QALutrRboYKEtgj9NhkB839hlG8kHtY0ZiYwh33NNO7pxm1rilOSD5dzpPoJgH196CeTFN2m0pLmsN4e/pizNO4rhGjXnYqG+Kt28Ng7zIMi33mkMVJ1oxLY6qGHFKuGRj6egg/P+4R1OMi6Upgh8jsvaf5pMbmQS6uy33TLjuFaeIr4WAI1QvnQNA8FVOA8+bWmgR0dW23maeW+GytToyVqq3EhNJqEP73KdzFiwJ24vaxI6yzlWFMTA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(356005)(36860700001)(86362001)(40460700003)(82310400005)(81166007)(7696005)(70586007)(8676002)(70206006)(2906002)(6666004)(4326008)(5660300002)(508600001)(8936002)(54906003)(336012)(47076005)(426003)(110136005)(83380400001)(26005)(2616005)(107886003)(186003)(1076003)(36756003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 11:12:45.9282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e0e463-20e9-46de-86b4-08da2f51591e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index d1f8248c00f4..c0da62436ed5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -23,7 +23,7 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
-		misc@100000 {
+		apbmisc: misc@100000 {
 			compatible = "nvidia,tegra194-misc";
 			reg = <0x00100000 0xf000>,
 			      <0x0010f000 0x1000>;
@@ -88,6 +88,27 @@
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
@@ -1460,6 +1481,26 @@
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
 			compatible = "nvidia,tegra194-hsp";
 			reg = <0x0c150000 0x90000>;
@@ -1594,6 +1635,25 @@
 
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
 		iommu@10000000 {
 			compatible = "nvidia,tegra194-smmu", "nvidia,smmu-500";
 			reg = <0x10000000 0x800000>;
-- 
2.17.1

