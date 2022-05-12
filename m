Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE752487D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351794AbiELJBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351770AbiELJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:01:21 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2085.outbound.protection.outlook.com [40.107.96.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECCA393CA;
        Thu, 12 May 2022 02:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN83iDQoVigZFCgrX12HcfcyLxAV0otY9pE5tPLu5WhGevWNoImft7mwnLp4j819mN6Vmf+uHvfk+aRPsI2FbVrsgtq1/sayBO09MYwHTADk8DNhI3EIhYri0AiPcfyzqh6nrJjdFmOmLDSE4dYiXCzPeQyin8L6Gmu2GpolCWYKb4uAJjn40ctTrW5+JwzVuXvj2R4o2upnl9Zi2ojAFvJ1YXwH9RPwQHLTvprmRO3Fql2LZpRxlCWE/rtyoWPqwdjrc2qZ4IO7moSukPmZq+HBNjolEMQYW6anSoSOUJOc6Uke9/1xQ4Q2qRBHXRxtzS+JxXG55WNOdPphFMXghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYSU66Zq3/bWkhd/67htkG+NbmHF0xf4ozBEaoJ3iT4=;
 b=RJMK317oxUYM/l1hKAi2R+prHq8yCEcDy+83F5hSYOKyJ5jD8/JKbDMsHExriqUBcbuowdRT2DmojCTqAYyHZ0OX3Z9BR58aKC6qRD1SfauV+rpPJ7DQ694dwpqcp0LQ++sJOr3mpysXuqPMGoSk1HGPOr/PtbuUfDIg+eGXVA0Xt6MIlaLDfIvMRc9qrPSuF6IvhgVg5KDudA3aY4GlI0I0/SSM0lHkmX8u+CR3SUkz03HROTSyqY27wDExWTu4UV0vleR7RQizyRkQX4FuoaBGPXEnQa7kfe+mHjc021anLewhd0M2JnUpRUi6mN1Atgx3HOBlo29/ZpnAs6PL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYSU66Zq3/bWkhd/67htkG+NbmHF0xf4ozBEaoJ3iT4=;
 b=SkdxpDqWp65HqwzI1vBEp4cnFMcRTqlspLbUZqsR9i0uWwG4nSR3ouUL3e/oHFkcwMmLRVb4WqBjFFNTIriBCPM75anf/l/AfXd4yESnJbsnzECa5Amoqw4Watx1CnEbDs4B4wFFtgz+IHpsG3N4BVAK1R/BR1BllUkOrVsnYyb7xXqjmdh+1h0rV1XV10CG7pWEGtXhW8ZHrKFaAFKaUiP4+K2yiJHxkkbSWB7/ggNmGQnk/4v90XJbobwim86pVcUFyavatqpb7ssofbNJaLPW6p3YBXb2V5yp5/sLjoJ2XXztW96Xv8YYIQEZcOp5PqsOU1wcV4ln5QBy1cYNaQ==
Received: from MW4PR03CA0333.namprd03.prod.outlook.com (2603:10b6:303:dc::8)
 by DM6PR12MB3881.namprd12.prod.outlook.com (2603:10b6:5:148::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 09:01:19 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::be) by MW4PR03CA0333.outlook.office365.com
 (2603:10b6:303:dc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14 via Frontend
 Transport; Thu, 12 May 2022 09:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 09:01:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 12 May 2022 09:01:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 02:01:13 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 12 May 2022 02:01:10 -0700
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <akhilrajeev@nvidia.com>
Subject: [PATCH 2/2] arm64: tegra: Add Tegra234 GPCDMA device tree node
Date:   Thu, 12 May 2022 14:30:52 +0530
Message-ID: <20220512090052.47840-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220512090052.47840-1-akhilrajeev@nvidia.com>
References: <20220512090052.47840-1-akhilrajeev@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9267846b-35c5-4224-f184-08da33f5fa65
X-MS-TrafficTypeDiagnostic: DM6PR12MB3881:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38816EA5F81B53EF5AACB9FBC0CB9@DM6PR12MB3881.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grJO34I8C+9rtP3cAz7SG6fUJvLpgfP2reWduS4BtG7iuPNPGj4ZuCOuDa9UlSwGia1RKh3PujsLDtRE0iusbTyxQuflMEOsvumuX6RkROR1uVoYKyEsBlwS9NLnej2mxYfrxsx6BAjcT2KiUlYq1vjssWmddvkny1HegiZaSrCquC9OhST/kGowHx2zKHPYVO7AqSNxDDtAuSrjz1BMMXxJz3LtfNnCF1ieZ2XI1CgCw3J8tohFY+jlHx27ZZQUdH+UDwBNFwQGSmpPUs02EKmzUZvnTXBXOT6xCWHUX5elrdHt2S3PgPRcWhXleiO/VkBj8dUVOSqxw/zR4dYrZo0svQ/RwIGOu1PO0TqF88CA/UBbvs2vxr2aToJ28ZVgk+uVq4mrpQKZOyZUbGLLlR92MZEb+Tfr1GfD6wnsQTC6R8GTOgnVmLYRpjTVcAua6W31Ol3IUrxNKlIiG/jgheJjt2KeTws5iMiWGbJ0Jny9vSiy+8gxJyY+Qwkw0rNaASxiw8zFGXC+Q+d/jC8UheK+gJZm0UA4PWbb25Imqx2ubE2Nd653E/+2aAT6lJgl+Y2WP4tk9keg4bsEvi8ZHoLPIEwlOJuQDir/CwXx1T3p6b3KZSNSVUSrMwkpnV8FB1cg6kLEMPtQS4Fbdz7EXyowZ78AIic73NAcnnzVn4fR9/nRFhddDwBheCS6PN7tmjznHvq7fRF44HGopGhdlQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(316002)(36756003)(26005)(110136005)(82310400005)(2616005)(70206006)(70586007)(1076003)(8676002)(107886003)(4326008)(186003)(47076005)(508600001)(7696005)(426003)(336012)(86362001)(2906002)(81166007)(356005)(36860700001)(5660300002)(8936002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 09:01:18.6085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9267846b-35c5-4224-f184-08da33f5fa65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3881
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree nodes for Tegra234 GPCDMA

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 43 ++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index cb3af539e477..860c3cc68cea 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -21,6 +21,49 @@
 
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
+		gpcdma: dma-controller@2600000 {
+			compatible = "nvidia,tegra194-gpcdma",
+				      "nvidia,tegra186-gpcdma";
+			reg = <0x2600000 0x210000>;
+			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
+			reset-names = "gpcdma";
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			iommus = <&smmu_niso0 TEGRA234_SID_GPCDMA>;
+			dma-coherent;
+			status = "okay";
+		};
+
 		aconnect@2900000 {
 			compatible = "nvidia,tegra234-aconnect",
 				     "nvidia,tegra210-aconnect";
-- 
2.17.1

