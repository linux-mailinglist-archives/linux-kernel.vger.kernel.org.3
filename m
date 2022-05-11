Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EF6523EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347701AbiEKUSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347708AbiEKUSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:18:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F6E6E8EB;
        Wed, 11 May 2022 13:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9tfMMVDO8xKQHAevxf9Pl3Hu96QRcIhYUU/osz4eNSQvwJrbdA9+tQ/VeMi1M6vyT2f+wL2nUl9P+7D/8pLDmrYVKHxmg99lWIqF87K5+3CHy8OfGzkAUs/yuqSh3Ji1MTTfVaavYE1WZW5VQB0tjdoMZdq4TWIU4jT0BfprOq5bF4CGWhKXRsFBVdDUuVID6Xsdg3cipKyRDYFMUBHuyvb9EeiM2dQ6ie384vv0kho6olo14cllEW9f6w8UWEX/aF6GBmMA04STnhDoKwi8Xdg9dqIyokyTdAsip6xbtBjwDZ0mnkjcdkKIDNw4Ep33kx5HKM11kMBXrJb9AUGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jznDdqnHjyPHibZtLc94PozjCBcV6Nsw3XZx/J9GSww=;
 b=HiQDHwkqzNJfzciYUL8ZLi3tk4NsSm8zmmOWZHEbkcFwqnliCGOtOiOwORLNMdGElOOHq5Yj3nxmwE8PuPQq3TXPEosnQd3Cx7MSerMDn/PbzHeag0sXWCtj7VKYHoPJF3s8MD037Y81TtMvYuSZ6WkRQIpZx6OXnKBoWGI9ZVf3NajxV3Qwo7VB+77L2Wp42nacm3RqYsNbpMhZVfoABeyo/TzFvKEGbthWMWE1mEeV4zJKY1LgBsBVaIinA80dstjwK8EUV53Lp4Ran8Yjbo1R0wFQJufMdpg/fOiP1M9xM8UgE0jYKl/g8FEPH8c3gm+Xh1bNvCAGKrGPmFE27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jznDdqnHjyPHibZtLc94PozjCBcV6Nsw3XZx/J9GSww=;
 b=SBysxpH+GPmqQhwKkEuk/2AdFxX5fVGxmMCxhdshrUbllncwxdK0UI+/pDRyTj2sQyKf6ezEGz1bfaQoS234zz+p3tAlnMBiv1VNzmIc9B+wg7irHgr9fNugCf4VA1+TLm/bNQwyWESywL4LuKKsDu82mFRGbBkISKfCTJQ7iuYQZEnWScf71i4/RFSlSa34BPe99soi4eB4I3ryAZbQXYRm30A5LLVuF3BP0lxZQpquFrlWshISI+t+35IhCS/JjM5CdmEHFlbCPp6tUernOcR5hrTnOpBotGGPtzSngjP5vR+us+nQNIcxlvJvF4C44/GM5kaUqsvZ931+EFOVBA==
Received: from BN9PR03CA0958.namprd03.prod.outlook.com (2603:10b6:408:108::33)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 20:18:40 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::ae) by BN9PR03CA0958.outlook.office365.com
 (2603:10b6:408:108::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 20:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 20:18:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 11 May 2022 20:18:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 13:18:38 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 11 May 2022 13:18:35 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v6 7/9] arm64: tegra: Add node for CBB2.0 in Tegra234 SOC
Date:   Thu, 12 May 2022 01:46:49 +0530
Message-ID: <20220511201651.30695-9-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511201651.30695-1-sumitg@nvidia.com>
References: <20220511201651.30695-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86f60938-c550-4e1b-57d1-08da338b701b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51911043D0B40986805BBD9FB9C89@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jA8wIONav27cVDxr3jO5SUjBzcQnWLmFB7dfTMPAbhf19fx+qASZ9dd569FK6O87B3v1qLkXDySkEo8mzTJlQvIlmiLhZOMRy1HMWcc6pNHtxWvMZTFG5+Di8s/5eoCVdIIs+hrUjADKwistSZKqq6Ay6KrsgQud+oNItkcmRIYoaerlom5DeVAeKok3C1t+BEXZ3I4LZLBsDOknx+6Izw+ov5/r/pe1dGWUa3iiRP19nQ0YqKioVkYhX/mbQ34wYFt/e158mowmLYqfci37irQauuBMB2kdkWW0aASnGyoGVULHOqXFmSQOJinhMQ+J31F0Js4GSOLmIWs+kl9kL4LdZ+p1OK5cdcpP2AoJeuTXYweuf5bJTU94PcJJtJCs/56EmFwOnJvWO8lWo8pVSELXZ5p88D62IdKZlWm8TMp+/FmCYhbRSMwesvRy8/SEWwJJpdjYciz4fmi6owzQUYeybbUXyT7S4bhIxEMEEIcvhgrp5QzD8HMxkPj0QSFVa2ZHP0mRe2jO6q9iMDw4nTZXxOsLNFth9ASx8fe/DRVKQLPRITjaI0ZkpEP3wMCR9wwzaEfXVqGJI8Uo3xwqlfuRJDxN/LbRlo+gfsYlWkZ1KA3/3evRfHEaL8mvMZh9sBZs78Ca+zqqb4WygM+z+QZrVgHLkcznwusjmHwxbxvMy1Fq2OBagYAsTFJYvagPAd84j5f/Kz6ItUEGbTNKWw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(6666004)(86362001)(4326008)(2616005)(26005)(7696005)(8676002)(316002)(110136005)(36860700001)(508600001)(54906003)(107886003)(81166007)(356005)(186003)(47076005)(1076003)(336012)(426003)(5660300002)(40460700003)(8936002)(36756003)(2906002)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 20:18:39.8782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f60938-c550-4e1b-57d1-08da338b701b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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

