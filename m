Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D216D478AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbhLQMH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:07:26 -0500
Received: from mail-bn8nam08on2060.outbound.protection.outlook.com ([40.107.100.60]:41729
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235944AbhLQMHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:07:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDkVJB8E7mU1ZNXz7BwFhN9ru1whx737JSVqLQH5m9zueXf3MOVYSiqPgKfM0+36n047/y5s35g4TLKEzft9w/qML3cCLP2PDummgt4DkvJZI2WUuEDUVbllOm6VrNNCTWkEpFuWM8m8az+GpYJEbtzXM6j4kwZRzw1kyLpc+Y0u+6X0IISxxG26CF+f370/0wlvWWirxn9s+UdXlu5fpvluCm8QRsbRxn2dDLXFGCkuYFsFQC81N116beJQc4xodu4P97o/4U82fH7A/XQ+vJk2NsAaPoawEWB5ZeaoyeDg7jCp6YvP+ND9traknfH9NygH/epqsoha9upq6aFg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ+HB3gi2gpKQe8AtlogFINAov3Xcti/g37uMrBFLok=;
 b=Bu9GXNfEjPYaJ4p4aEQSEai5nIL+muWtzvoVQSh/mQu0GDMXAU+qABtNjrgkwBvs1H3TnZU449sE8ApN9b7HFJXJchn+oqVQiXz4w8srKphk0tx6W6WcCxbOHeXiaf7IOSiiXF+IzTv/UGTCp1sDAfpXwbxSCSK1zZm3ei6JpGDKFG1kYKWLGDyKSthXCZF0t3KVIPiHKhZTnT6MYwF1Xvq6+MlXglJH66n8ePJBR7vMq7KgftIKHidlvBNRGlsQtCqnkiXIZgy8UMxN5e0NUyv5ceWdxMxlna/U573QzshLs1cquU9YmxizWYQgt2dot7pNgjJEMie4vdf8Ukenow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ+HB3gi2gpKQe8AtlogFINAov3Xcti/g37uMrBFLok=;
 b=quNHxeR+d47LZ0o1tKI7ZwRTcjHU5i10TLRxYm426NEXuTIA+JoWGNYxmVYVbtuYWB37wQ0hlKMZSZbTrhGC6Bbo2F6n8g0aH72DrzJ4/1MVtlLUPhhLdUKoBHg24NKFGI0cFbvn0FD1A71czQlsV3tOHzQ7tl0p/JJYFsAw0NHuCY3UFp/4itaqQEbtDQNpdZb8C7I58cCK2b5+T/9cINAW504Ju2q0G5tZlefubX2Jx7KYuZ4jNTwPuuxjkz/CEJq8gY55vNQT/TmdXM0X/XQF2pGloELk3YXVHsiGSsf6Fpyer/Xy1hj0e1li283v/g18jckiukgjO6pIxLMllA==
Received: from MW4PR04CA0121.namprd04.prod.outlook.com (2603:10b6:303:84::6)
 by DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 12:07:16 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::f5) by MW4PR04CA0121.outlook.office365.com
 (2603:10b6:303:84::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 12:07:15 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:15 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:13 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:11 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>, Thierry Reding <treding@nvidia.com>
Subject: [Patch v2 3/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194 axi2apb binding
Date:   Fri, 17 Dec 2021 17:36:50 +0530
Message-ID: <20211217120656.16480-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211217120656.16480-1-sumitg@nvidia.com>
References: <20211217120656.16480-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 251bd168-b074-407c-6159-08d9c155c43a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34660A187D2745892C162BCAB9789@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZFVI9OW/rbGXqc7bnHx8fy85zEJGzHex3xmPfA7ZFDFJVsp6OkrmP0776oEK?=
 =?us-ascii?Q?/RbvslBmor5trnDcOhvEVAc2HamDj91WIb+2UTshGyPIkDepuwsPFEO/gUDD?=
 =?us-ascii?Q?eXesJh6ec63SeAVIvzG8uAc7rX4l7HCdieW3SPRDnA+S54aAY1JATPdz/B93?=
 =?us-ascii?Q?EEe1LDfXoXhM9oarmTSk1nJTY6G+Bo7zoeHly9SbCQQzrliZkeeKME4FPnHt?=
 =?us-ascii?Q?Oubk4y7VVQbao59cl5JqpUxrodILhqGP2QjtsIyistB8mydQkptRw5gQDr21?=
 =?us-ascii?Q?uNk3qaP/OH0xIN8iDejwMkf+RTZ9o20QvYFSVr1p19vlMawuUwpRn00Fydzt?=
 =?us-ascii?Q?lj+MwDLjD5xESD+caZteO/raLXJGlkBhsZJhQevbsRkXkib4cFUQFDCpgPDW?=
 =?us-ascii?Q?T2lmwZ8kRhbNMKMRu4uczr4SmU40k7lrYysre6qhb5Ot75+Y3Jx6Ik7Gz1Gy?=
 =?us-ascii?Q?/r0VhQBydwxn8x1xNWiRcRs8hZT56R9GLgI8tyi7Y4xIhmaRglmHNIHAodmh?=
 =?us-ascii?Q?Yxml4niJo5ASkZ4oZH1xzCPCPFKPfpVB89ezppRNWNeXixY7QE6qDLsT3iUK?=
 =?us-ascii?Q?WWB1M4J6NhN30i/Imu96OTtL8zYdlxBMJTZ4wbdErBNxxSzmwuhuJ8rxNQsa?=
 =?us-ascii?Q?lvvm+VFHLa8q3Mu1Fu39kGrAtH9HAqcusi45kZZWKuXSGpD985dZLvMobPLV?=
 =?us-ascii?Q?SgvROHnZsfmacobmfU71BfmHgowN7WIjYXBcvSsXIpi7DtVWg1gjvb0/ZOnS?=
 =?us-ascii?Q?MAIS/GpPfsgsGiKSghdbnulCERr4UY807gEdbRkEzDzHOMfRmnvkG8vj5P76?=
 =?us-ascii?Q?xT1L+b2hLQjwUZ3aggttcbjPncCEj4OCkxm/mVsEsk5JJntaoLvNuYpxeS7w?=
 =?us-ascii?Q?Pj+Iv+9Mz7BtHvEK5siVwE/a2+YqxRVVwuE2QdFw4u7lg63BFcfnvGOnrwlu?=
 =?us-ascii?Q?fJ/ngnh1hfgkVEPamgDkIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(26005)(40460700001)(336012)(70586007)(110136005)(4326008)(2906002)(70206006)(107886003)(6666004)(508600001)(36756003)(316002)(186003)(82310400004)(5660300002)(2616005)(86362001)(7696005)(36860700001)(8936002)(81166007)(54906003)(34020700004)(47076005)(8676002)(356005)(426003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 12:07:15.7083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 251bd168-b074-407c-6159-08d9c155c43a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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

