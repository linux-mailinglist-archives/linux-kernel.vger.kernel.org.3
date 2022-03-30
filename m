Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4415C4EC6BC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346993AbiC3Okk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346978AbiC3Okd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:40:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7831A5373E;
        Wed, 30 Mar 2022 07:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsUamrdKeqMHJhRgwBb0RfQtYEI3wkwJ/TQa6ozXm+MXsUUcT0dVzXTP5P3+NpS75NH4oIs8uu9cFBGy/4nuBx8RQanGQLIUA7FwYhsRtAyMeAk8A/0GpIuCLZEDG4WiRVf4UwZbyImb7p38KuJqy514xDLE5gL7c8oSvP8FbQ8PF++7tBluAXNIPV4w5hvqrwxlAgt/aAt7s58MH5y2zMhmac6G2Hdi+DVL+zbF0zzNaZiBV8CUkll5vFOXhE63527Aa6+QQ72pjfk178/3lfi/Ms60EFkS5mnwJ+gIXoPbX/ZH6XSZJaPCyTteWLITePdc5g6uZ7VdMaHuvXlCtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8OE3kOIekGzb6oXA4XitGiU1hzTSd0zw0rG6McU2os=;
 b=CbUqHdrULdFgUAoVxv6iaGZjJkcCNs5yryWfCEVdyfTZ7H5wM3TQlh4RPmBloS6mfBOOP529yp+L2lXUyu2wv3acIT/qm7Y8wcrpAElvnc9kGN+lMYg+YHIj3TeqCRPjXi0HmO6Ptofd5aKZYzph9H6bZ/VJ75iKWgkCzABlvAAfAGLcz0jhy6cDHGCDjNmgADPKOxrc1iicf6AKQH91+OCcAOxrgW3S5h8DHbvbkLCGpyl0DGp9nC+IuHbPimUP9dUtB2b1e0heD1EpqPKczwRpnVbUMfkQzAvh1Hx4CDwBBZvsdScSAOIlnu4u6vn18fnOvG0FDpEp9ZHw2hiKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8OE3kOIekGzb6oXA4XitGiU1hzTSd0zw0rG6McU2os=;
 b=FgEaLcvIfsC/m9HaGfNajxnE5giXM+xutECvLx0JyQr0yQ8d3VYbbTT38K7+RdVeYblLlSfv8TBfhComEKvu66N3hlTdPbwgYh1sJ6JKh8lbepv16IDxj3fUnJoE067rdh6+I9oEMv9XKWgk1LFuNVvp0cRjWXbe1/fLnnb1X2GmS6W6vbi7qxAxDrAwUU+ljRNwiY6DndGTAKB6OrucDKPq3lTw/npOv+KrUKh5UVO2EzxvXIt1TaLXemsAelRNFPqhbTaR0DhkUBWcgV3Fw7318sKH9OTm5G38puLe6YztsHGcCX0JbNnDwZgeBM52o3spq2ADwEYKB3xJsRHjIw==
Received: from BN0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:141::31)
 by BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 14:38:46 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::2) by BN0PR07CA0017.outlook.office365.com
 (2603:10b6:408:141::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Wed, 30 Mar 2022 14:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Wed, 30 Mar 2022 14:38:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 30 Mar
 2022 14:38:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 07:38:45 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 30 Mar 2022 07:38:41 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v2 2/4] dt-bindings: arm: tegra: Add bindins for nvidia,tegra-ccplex-cluster
Date:   Wed, 30 Mar 2022 20:08:17 +0530
Message-ID: <20220330143819.27476-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330143819.27476-1-sumitg@nvidia.com>
References: <20220330143819.27476-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b38b7def-038f-4186-aef2-08da125aff67
X-MS-TrafficTypeDiagnostic: BN9PR12MB5244:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5244A7F55697CDB2F3295B50B91F9@BN9PR12MB5244.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jEYzXdlPRbySFXKe2Y7B9j/X7dprltvK7e4KnErBsvQ/dFjCUW0gLzTHMkKnn6vIFxmwscST8PWIOmdCfR17FbD8M/XjyQGAwRCkqUkFapZQy0G6/P4v1S3qTuZ2fx0aeDDJviloornCvU7TBgZuyunobSNYaiqcgBbWvHvJDwkXCkAzUGN9UB9O/pImGeNSaaFcpw3mB6/aLYpO3EJey+uNbWH8YIMawnd8XKf74CbcHVIGcOUfEx6a5CN8iGGhQLy9hxuViDBh3lA2RbWjAFfMHWfN4vK/UkVG4tqCn6ys1ZY+vHhi2RO2y7dvE9KfUrqgVMopcavy99/XENF/jl6UlFa2dd7FbDVpEk46cMMR2ivrzFSMeQo/Zp96B4+ApMQRU5L3euCaiAzBCXbmrlVfdJ3qQF06vCE9eKYNl76MFX5cbREkm+0RY0x2Q/Kz5d/kyVH8MupKe7l/+vo1DiZf8MANh2JpnPIpgCCWXxHicDn7Y4zjjYzgD6Xy7zJS9S4agng0UwCXTNKP3N3RhfyivIvfGj7PzF2nZs4Yp2dZCl9GxEKnI/STo5UyUHoPQAhvp8cz8JFkDqrylFqPP+9GEcXKCNA6+giaStyKmyHWdkppj58Lp/soX1Bmm54slhCUw18twKdPI7yagFSXE9VcQAFem1avRso2QLBCuNJEZB2QtGudT+4o+b92ve+da4y2gN+O/10FaKK0dP291daCqJ/13xXElRoa+EfqZXiaZ7E280v4zNI4oECeR7mqqvr91dup1jEPY5RXBR49bUrBcGyIKnXibj8cPw2V6SzzsG5wb8rvU/NMEUEiDYmJ5cdqWZiF4FMq6maPQSzVCbcbK97vQbPpmPamLdJSd48=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(7696005)(2616005)(40460700003)(356005)(2906002)(508600001)(316002)(81166007)(921005)(82310400004)(1076003)(36860700001)(186003)(110136005)(26005)(336012)(107886003)(70206006)(70586007)(86362001)(426003)(47076005)(54906003)(5660300002)(36756003)(6666004)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 14:38:46.5969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b38b7def-038f-4186-aef2-08da125aff67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5244
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra CCPLEX_CLUSTER area contains memory-mapped
registers that initiate CPU frequency/voltage transitions.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../tegra/nvidia,tegra-ccplex-cluster.yaml    | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
new file mode 100644
index 000000000000..74afa06f695e
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra-ccplex-cluster.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra CPU_CLUSTER area device tree bindings
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+  - Mikko Perttunen <mperttunen@nvidia.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |+
+  The Tegra CCPLEX_CLUSTER area contains memory-mapped
+  registers that initiate CPU frequency/voltage transitions.
+
+properties:
+  $nodename:
+    pattern: "ccplex@([0-9a-f]+)$"
+
+  compatible:
+    enum:
+      - nvidia,tegra186-ccplex-cluster
+      - nvidia,tegra234-ccplex-cluster
+
+  reg:
+    maxItems: 1
+
+  nvidia,bpmp:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: |
+      Specifies the bpmp node that needs to be queried to get
+      operating point data for all CPUs.
+
+additionalProperties: true
+
+required:
+  - compatible
+  - reg
+  - nvidia,bpmp
+  - status
+
+examples:
+  - |
+    ccplex@e000000 {
+      compatible = "nvidia,tegra234-ccplex-cluster";
+      reg = <0x0 0x0e000000 0x0 0x5ffff>;
+      nvidia,bpmp = <&bpmp>;
+      status = "okay";
+    };
-- 
2.17.1

