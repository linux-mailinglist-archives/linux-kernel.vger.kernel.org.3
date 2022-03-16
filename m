Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ADD4DB210
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbiCPOA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356407AbiCPOAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:00:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F0766624;
        Wed, 16 Mar 2022 06:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijHEP3ARVDga/ZGMPzTOgFREut/3MzwHlWegoiE04nbOdQbLloca4twr0K+6dWtXJtMlMiHIAJZIWzir0vVqob7K/gon53M4QaHdjsQO7Ril3IhHtS/XyvVchfWfEvZiZ0zzib6wUnaBEtHmPH/O80iXiHlNKiiEpNomb2LK/jIJLkBFaHnQH/ZNVjyzb8Xp0yyv46jEf9WZ+JRzhkMwFPaSTammIIWgyKoubXqp+57yrft2w2rajEpb8V6tV6X8x7Fy3aJP07VAzf0Ob3fJVzOKHuOJHYLHcb4ygIwYEoCgRfHAVwx/k5ygt5bqyKl2w+xCHiZB/MnVvC4pMDloWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jiZqiuA4bL/Xl4sXyXV/fFxhFrzn1JlNSbgW6WB1YI=;
 b=VC+GsXrcnJk/pAFFsYLVy684Rht8xGjZD9YVDc57ufdrFQPkM7zYxgkiDhR5tGu2A0sZSDHmV6eMZZiM0LGJlgbTUSsXjcqDkM/c853p0G10nIsw9zj6CgxEw46O28YVGqwpb1q50qsTpcdOzpvo8kGUdpyhKi8tik/EI+0aYLUknUw5JP2+FkSu0DK9iHg2CPmQ+0Yp/gnv/MQMiyp3SbX0t/GXPGRi8ZJEcZJeM+p3qJTDaria9XuJXRIxjFBs7AlNQ+RHNDacKaUAaaqXThNjGb9C9ho6X+SW4GRme+gZ62hfIIHeFy/vpwYhhb/hEEN9sQ1AUpry8gaKTWFoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jiZqiuA4bL/Xl4sXyXV/fFxhFrzn1JlNSbgW6WB1YI=;
 b=fQfOb9brw3SlxmpvImteq6wUuHakZf5n/zwawX1KpnfknzW+Bk0DNMNU6mdyOn0ZUTW5/O0DDgzdLZuPRLVc1kx6AcQt6d8D87yuP8kvJ2AfoIm8LT/qeJ8o2+CVJ51GPtCVwSN6hOO3yIJSUOHl3LazKKAFCSADTL/SeVMn7urekxLe09qpgO/6Nx+hJTDDlDqEmaUtHMoqZliv+BvnDhoW84YwK+tbb/QpVFXLqR/qEX3HUCQsTmieUgcWkHy/QmmcQutI+CLjRQEUDqemDNT/e2Cc8r6B0i57+UjmpSA+TF4RtEvFxsOAVuPAUsnIU3PcF2GzLdwhuqNQPeUDIA==
Received: from DM5PR19CA0067.namprd19.prod.outlook.com (2603:10b6:3:116::29)
 by DM5PR1201MB0058.namprd12.prod.outlook.com (2603:10b6:4:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 13:58:55 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::ad) by DM5PR19CA0067.outlook.office365.com
 (2603:10b6:3:116::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14 via Frontend
 Transport; Wed, 16 Mar 2022 13:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Wed, 16 Mar 2022 13:58:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 16 Mar
 2022 13:58:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 06:58:52 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 16 Mar 2022 06:58:49 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v1 2/3] arm64: tegra: add node for tegra234 cpufreq
Date:   Wed, 16 Mar 2022 19:28:30 +0530
Message-ID: <20220316135831.900-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220316135831.900-1-sumitg@nvidia.com>
References: <20220316135831.900-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb2a28c9-1036-4265-1388-08da07551c32
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0058:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00582B47717F7C215F6FFB7DB9119@DM5PR1201MB0058.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSBwKLZkiHAy/alBi5lNZjZ5HzgO1pxiC7/RwL/1WnK+W6+oaZzCjnVuLLzHF9rbUw/KrEd6lwn8UrQe2wio3R8facNgL8gj5tFAzlpoXdI2/XJJiDS9qHSn1XvLXHFbsh2CaksHwiZMmDBXbcvheZuuR+pWIG2ACt7klBsqZyBzKSmAB/zbJhy1sx0vVYrYC2N5koI4NJJFPekedeM+PyRcQKVugNJtxISYL7TeBwkR1dUv1DGcTCcACN7TAfOLG/FYo0rXTwBwlUFqi3dSDeByyCV1iUQKcjycaEi3GQ/N7hNifj++pY+mhUcnxLM7chJjy5/8CfV4MIQMsGFYv5QooISM+BswpJHoFOq5iygL2xP1jQnLchGbGIHk8gX+82GQ2so0qtMimahPKW4b/me7aTu5Mmk5jIsHk0zNfY8yL6n7+Q/Q26sdo4QPenLwjD7kVdiyb4gme6airz2A+VQBf3czQt4aeYnSs8d51m3LSjdJdqYQuoaYPs5M9/ANmkoUjdJEHmfxi/LRLSvP0hwX+ED8/Ji6AfMLIMGqzKP3oIfsm6hGEVKibjr4dy1pMCCPFjHBZWU9ksUu157l6V2KSdxlFJ/Wx3YAG987dT0njqqIu4og3bYc2XhooB+csNv1odAAO5LDEPH7diRfWCWjfA9r4t46LjkHE4mtrULbeowPFmEQdf6j8Ia9VEpukpohPS5LcBml6PkBnttoNRKQcStK8c9DH1/welIFkxE=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(26005)(4326008)(336012)(107886003)(2616005)(426003)(1076003)(186003)(70206006)(86362001)(83380400001)(70586007)(54906003)(508600001)(110136005)(921005)(36756003)(4744005)(356005)(2906002)(81166007)(7696005)(8936002)(8676002)(47076005)(36860700001)(40460700003)(6666004)(5660300002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 13:58:55.1754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2a28c9-1036-4265-1388-08da07551c32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0058
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding cclpex node to represent Tegra234 cpufreq.
Tegra234 uses some of the CRAB (Control Register Access Bus)
registers for cpu frequency requests. These registers are
memory mapped to CCPLEX_MMCRAB_ARM region. In this node, mapping
the range of MMCRAB registers required only for cpu frequency info.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index aaace605bdaa..610207f3f967 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1258,6 +1258,13 @@
 		};
 	};
 
+	ccplex@e000000 {
+		compatible = "nvidia,tegra234-ccplex-cluster";
+		reg = <0x0 0x0e000000 0x0 0x5ffff>;
+		nvidia,bpmp = <&bpmp>;
+		status = "okay";
+	};
+
 	sram@40000000 {
 		compatible = "nvidia,tegra234-sysram", "mmio-sram";
 		reg = <0x0 0x40000000 0x0 0x80000>;
-- 
2.17.1

