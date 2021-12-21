Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA1447C000
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbhLUMvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:51:39 -0500
Received: from mail-mw2nam08on2046.outbound.protection.outlook.com ([40.107.101.46]:40448
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235157AbhLUMvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:51:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khLGfuxHlcJErdPiXpiXyZG8RCL7Z2GOItjtuNL2Nu0STW/T6ZOTe0Dibi0BipC46I546HRA9aeiG/itVALDSmrRgYXD3zVPIYDdNeBmf4wondkf/hHL9JLOpL93B3MICzMEMkl5Ezk8P4O9nMwaxMWaKQ5qpjosMa0+y/C+QYpE3GfGRLOUE3AHbt1iQC36eXU5807dRCAWGSjnhsE9qwgBnesVNeboXbQPU8U0DWTiJI9IPDudtfa8BvYtLHLjeQo8uzOWPkaKYcOV0zV1H+1XhEK4vEjLkRU7sPjAeCoAK0Ja9j5wH6XAJdnws434tDOZzs2nvoneQyehoT/2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ+HB3gi2gpKQe8AtlogFINAov3Xcti/g37uMrBFLok=;
 b=WDluIdcLeMQkMkPTksyJ2/jEcaPgoEuKcExFa60sBbQ308amzUgZ+gtwgiP5jx1349v0HGWuZOz1KP16zLjpikEKyAx4RP5WOXBCwMuExJuo4zWdMGExMYbHftEhhtWomYmnw67tZjReSaLeAzFOF4WWDM2A8HiMfYIOFHRS285lu7taC4IxASw1Gu/peOWkI2YVP2uurkgoktd893idnjBups5plOEGX49CCh5vUKdUwQSj1PeEZ6AXTfQw4aPprkIiqAKHKdYiWesTuvd0zsVKyHLv24+/gtPfWgGXYsVQxizKZKTO+axP4aOle8EgG3k3lNwYgFjW4c9/3QgHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ+HB3gi2gpKQe8AtlogFINAov3Xcti/g37uMrBFLok=;
 b=mN2e+qvPfvjQED9zz+RQdUrRN5SH1MfRefhdZTkDzLQ9paw9wOorpoiCORUpRxlRibb2D4V3SllbPhPbe1xDfqwHZNvHWJSIS1RDanzzcpOjsW9IXn/0/S0c2ISl381DglMO0TXaCKmFnfBEY4bXnILeqcCw1/SrWPAd9z4PUXaYjmMXRpHRqTc4010M+pFFcA7lY7nt1pGoyLodgqSYi9Zbrlpy6Bpoi0L+RF/W31uSUplurC49/TvnnasUFbQHsVCbFUdEwCGDsLP7SkVhvCVDMyLjyqmoBKBA8hxGhUDgcbnnIfLjPlNEC7jflrzqvVzhaposFn740BcIsDAJiA==
Received: from MWHPR04CA0052.namprd04.prod.outlook.com (2603:10b6:300:6c::14)
 by BY5PR12MB4818.namprd12.prod.outlook.com (2603:10b6:a03:1b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Tue, 21 Dec
 2021 12:51:34 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::39) by MWHPR04CA0052.outlook.office365.com
 (2603:10b6:300:6c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 12:51:34 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 12:51:34 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 04:51:33 -0800
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:30 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <kbuild-all@lists.01.org>, <sumitg@nvidia.com>, <bbasu@nvidia.com>,
        <vsethi@nvidia.com>, <jsequeira@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [Patch v3 3/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194 axi2apb binding
Date:   Tue, 21 Dec 2021 18:21:11 +0530
Message-ID: <20211221125117.6545-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221125117.6545-1-sumitg@nvidia.com>
References: <20211221125117.6545-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f40c18a-13dd-418c-2581-08d9c4809e9f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4818:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4818BBA2AB1B87EB454D5600B97C9@BY5PR12MB4818.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PThWMk71r5s1LEfQbz97vOV46xyyFjEXluY9u/4gL7sxii3FffDr5qgaLyha?=
 =?us-ascii?Q?dyAS91NSFrNVqmW9xFzGb1wvyctHubaIbcFxqqne//p6cGItphK6iUPwsv7h?=
 =?us-ascii?Q?DJyB+KrBiN9MHUCwkJrNfCj0+rKuguWXw0jBxT5iDRQx/XRwasNIjWv80b3n?=
 =?us-ascii?Q?WhNpDiGtQRmGHQTc2rii0++XmYX7FTlahayqqFcrl4S/9UIJGyriLK4pZA1L?=
 =?us-ascii?Q?8bM8n2o6MYrCBc01Lq/jXeieSABBc2MUwCjvAz0kq0EcWtF20WNmsEDtO6Hu?=
 =?us-ascii?Q?ZQ3B8+PCrETxjzqLy8wzC2X9KMCr0khJl5MD4FkoKrBDiRsQV/wE0Wsj/x9G?=
 =?us-ascii?Q?/+8g214iS465qe8nz/0BQ+L79aq1KI+0M+J9N+J91CvA9Ql0zP+aW1rp0BGq?=
 =?us-ascii?Q?zQNDd3LiNuJ1iLCiWaV181YHNeI/tw239ljjuUogW5Tijq4Ko7KaYLLDK7WO?=
 =?us-ascii?Q?6HpZ1udyerZtmc/q3czlBLYk428X4M6rYNmbaaVvm/poV4fDLyc7me1ou+qS?=
 =?us-ascii?Q?Yt2JN0USemXW++DMGVVFYu8mG/rSNY/ngVSJLsHLKS3Ybw20sb3j9R2gj1ch?=
 =?us-ascii?Q?tz1nQrzGch0fdx0WAFO9VGrmTSuwLcLaMPM/yALDX2WxgBpRWbLYSeJCkCtf?=
 =?us-ascii?Q?+lBRBffo7pQU044Qm4mDdcFOUUGxEQyTaoDSesi+a1HSczCfmILKs8YiroFi?=
 =?us-ascii?Q?QO9NzwTAyQIGfDDcqYniFz85lPPelNkAljNjn/hd5yXpC+R4+AdGcaErIl7z?=
 =?us-ascii?Q?haD+ZESVuRYhdri8fWKSz/zarXKS5yMLwaUXlzE8lQy1MHhrSW3OjkiMTUHT?=
 =?us-ascii?Q?IBt06wg7H5kFJ30wvrDxXxLLJCbNjhY5UDd1rg/r2eek1GWcWDKi0XrmfL07?=
 =?us-ascii?Q?P2CNBULwflxKMbISoDcSfyUYeIz9iTCSwvMuNZhiD5pprY2sdubldM10hW+V?=
 =?us-ascii?Q?/dgEH8e6fbzzlbndot4UZQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700002)(70586007)(34020700004)(26005)(5660300002)(426003)(316002)(47076005)(107886003)(2616005)(508600001)(86362001)(40460700001)(36860700001)(186003)(82310400004)(70206006)(4326008)(2906002)(110136005)(336012)(54906003)(36756003)(8936002)(81166007)(356005)(8676002)(7696005)(6666004)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 12:51:34.4473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f40c18a-13dd-418c-2581-08d9c4809e9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4818
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation to represent the axi2apb bridges
used by Control Backbone (CBB) 1.0 in Tegra194 SOC. All errors for APB
slaves are reported as slave error because APB bas single bit to report
error. So, CBB driver needs to further check error status registers of
all the axi2apb bridges to find error type.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../arm/tegra/nvidia,tegra194-axi2apb.yaml    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
new file mode 100644
index 000000000000..788a13f8aa93
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-axi2apb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra194 AXI2APB bridge
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+
+properties:
+  $nodename:
+    pattern: "^axi2apb@([0-9a-f]+)$"
+
+  compatible:
+    enum:
+      - nvidia,tegra194-axi2apb
+
+  reg:
+    maxItems: 6
+    description: Physical base address and length of registers for all bridges
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    axi2apb: axi2apb@2390000 {
+      compatible = "nvidia,tegra194-axi2apb";
+      reg = <0x02390000 0x1000>,
+            <0x023a0000 0x1000>,
+            <0x023b0000 0x1000>,
+            <0x023c0000 0x1000>,
+            <0x023d0000 0x1000>,
+            <0x023e0000 0x1000>;
+    };
-- 
2.17.1

