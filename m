Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B0C4E6EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244405AbiCYHXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiCYHXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:23:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE543CFF0;
        Fri, 25 Mar 2022 00:22:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnSKtQ4kv6a0K8wSeeZv0qVnPw/ZYT1idsBxMz0gEIaXcEt9AWJQqtgs8A7xqlGzqHn7/1Ov/6hydZGf4HsUbbu4McFw2qrcS6wQCiu3tlMh2s4xSBcvJKXyRSioq0+4XfJM0r+hU8J11w4SSlyxPM0zzHGCw/TDenQu0Hw1w+GgN+F3imw27c3pieE+HPd+1l39VZFuE5fou2kTk75ymdqpgCAr/aV2rWhIG9sO90Os2JT4CmyfBVO8B9DbISEilCsjwoi8s4dETmLzVstCQcPrdpCmSDYaenXYMxldrpvhaIrlqwbTHqhXuwrfgDXX0Ssa0JQuit8NangOPh/DyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIOEiSUpvZ9FhcGegbBmdzBzcGbQnXY6z47Y1OopEAw=;
 b=lkpfoqapqqdWDfmJ5PSqeSP/4R0e6DSqsE5PmIMSLNKqix0ri5i2Vue+pRhBsZ6D1wKf/hMxPR5oINGyjy1Vv+WD9BtWtn9JdZFb7xACsYy86JIvjmlC2NIPBXpQzNGQMhnIrtvRBISd7F7PLCA2GO6MYFl+Pr2CclaOIglk+jglYVlf+DHfVXmHkNP04WcY5g4em76GqxN0EKO8fgjQIUzkllSIlaTEiLjEKbtSu7Ymp0Vrd0XxITMoR2uB9MMqZwU/ubhiebAnmvjLVs/gjgGaIBge0uCZ2VwXyqOBoachUEhiBXY2o6EiyDnsNjL31ypgcmYWKnzQ+syxfCpu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIOEiSUpvZ9FhcGegbBmdzBzcGbQnXY6z47Y1OopEAw=;
 b=ugCKCE7iKCkK4E8RoI4Sz66yPd2hNfHpSEenOZP4EuxDF7lRjJPQKLWzf3AXemmsmvoH8toV5026o62yK8dl9t9CGEIQxEO1owDWqlh6n5AncJgvReEBbt/bDDrpbdCq4KPntGlnuHla6iHrvtQrnVYPz4cuC2z9bhEGkwbUEn5lS+KWyPZQeTJb1GiUnBDX2u/PNJVHST8rcjUxBPVfS+eDkhJYPkx4Hegjfk/tO7auKBdqUDCIgn3FYUzO69sw8U7BqmVj2WVuhBMWAnZw4knQTGbu3KwyjN5iHgV8qhKkBOuxauhJRBJnxJOzS9p/Wf/L9mu8Kv0q090KcHD1Zw==
Received: from DM6PR06CA0031.namprd06.prod.outlook.com (2603:10b6:5:120::44)
 by DM5PR12MB1307.namprd12.prod.outlook.com (2603:10b6:3:79::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 07:22:07 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::8c) by DM6PR06CA0031.outlook.office365.com
 (2603:10b6:5:120::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16 via Frontend
 Transport; Fri, 25 Mar 2022 07:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Fri, 25 Mar 2022 07:22:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 25 Mar
 2022 07:22:06 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 25 Mar
 2022 00:22:05 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 25 Mar 2022 00:22:03 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH] arm64: tegra: Enable hda node for P3737 + P3701
Date:   Fri, 25 Mar 2022 12:51:41 +0530
Message-ID: <20220325072141.28597-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec6ecf64-1c99-47dc-fa2e-08da0e302b3e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1307:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1307B849A8D63C45CE7ED80EC11A9@DM5PR12MB1307.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkJataVygZsPGBQpCPsFcmGlbAKvMBn7jsKbllIJHuJSYcSruYngDc7Ekj64OaMcKFkcAfjSXZxEDeV9elyCYcOM/t7ejbmDw7lKyOy6EHCnxU3z+CE1d4Cqin2dGPi/5aiDa3tAaqt+ijsBwhPKmcWtwUx5owS1I0aEq2eSaaZ/hWo+cb0yBvZDTbMihyjINjjjFOLfToRIH2OQEDei7UCiIh31aWZcMKCyL4WYIE5MuK5dYBCCsORzjs0Ah3Wk2GN+4eVcBgZQMjIe+/7WEJ0on6aMtV3BayjvuiX2celwEsAYIK3TKmvYHIbamL+V0Tk/tqppwKipmX2IDaYgqksg5xzzdxPI3O59zh1s8qcyhBJlY6+otzxBrXejXayXsuLSwDJwZC+Vei+LZhwDf/+PTrHIIddtm1Du2MXdwrq6uL/bjMt2nLyoW1H49m5cV+54/9HiUHQY77NWVA5Gh8klqv+EzzJSRz8GzDByhxOIwj/gPXADPy8JBTQYTEqk0pWr3l2CMVR7P/rIVRRHqH1GaJXKpPciF5+8+2YrS9WBZBfaMhqtG0C1J9dCHBOCHyptHKmYhB+x4in9lg5K8gCFYlwRewkLG39lupncOJ/dJE+lMEHG8Y5wvZ1gXVFUfYzXRJrN5R3nHiDMCPIiBLni19MQNxqzQAAHijsvXmMo5OfGCsJnJIaFoNnmyIX6yOSQQPGMAygZGxsPyfoWnQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6666004)(356005)(40460700003)(110136005)(5660300002)(36756003)(186003)(26005)(70206006)(70586007)(2906002)(47076005)(8676002)(8936002)(4326008)(316002)(36860700001)(86362001)(83380400001)(107886003)(1076003)(2616005)(336012)(81166007)(7696005)(54906003)(82310400004)(426003)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 07:22:07.1707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6ecf64-1c99-47dc-fa2e-08da0e302b3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1307
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add iommus property for hda and enable the node for P3737 + P3701
platform.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 1 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index 34d6a01ee1c6..156d5d95fde7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -1751,6 +1751,7 @@
 
 		hda@3510000 {
 			nvidia,model = "NVIDIA Jetson AGX Orin HDA";
+			status = "okay";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index aaace605bdaa..704c50c24654 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -709,6 +709,7 @@
 			interconnects = <&mc TEGRA234_MEMORY_CLIENT_HDAR &emc>,
 					<&mc TEGRA234_MEMORY_CLIENT_HDAW &emc>;
 			interconnect-names = "dma-mem", "write";
+			iommus = <&smmu_niso0 TEGRA234_SID_HDA>;
 			status = "disabled";
 		};
 
-- 
2.17.1

