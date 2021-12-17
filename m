Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101D0478AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbhLQMHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:07:44 -0500
Received: from mail-sn1anam02on2087.outbound.protection.outlook.com ([40.107.96.87]:64416
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236062AbhLQMH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:07:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUx5jiw7nKq3C6G87+7NGdg2kQCINECXEUb98AoZMS3b54vDrLRWlIsuZxHwj4vvA7izdiwlQO0qbSBp97HeLxYc2I3INr3VvhJEYtZzsPhG/3+HzEUXzFnrpvq4M0FtuK1U9VvaPThv0BracU3IAdL4uhXdMVhKG6VfDmigrkF0i/exld0BlzBld43T8AyWP8ECmXG+UqRfVTE6WXyQx+FOzGNB6GYzSB5dPmoVd+OaU16FN8PT/6/YrKlsuL9LHVFt+9zuOnMi2jDwe4a3HSpWwIRlQ7l3XRQL/TOeZMrl30RXp5d+XXDfbG//mJpt9b+LLCJklaBsJAwtIBADYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAwJwAK226raxGh5NoBwO9QVUpnql59xp5WX7VgSuHc=;
 b=kDXP0y6oVpEcPy3l105FTS6Ut71zRe6dm1Z7NRk+OAkCVCGyBSXXNIO/oAWMgcwVeaDfnzs+wr/XCNku/NGN4vP4DAEvhhpdy9qUV9LaI3CagKbPbO6UsorpZq3vLGrw44TG7Uu+CcPe6JflqqX9x9+8yerz0/vtHxsRgDbUlzHrnRYB3QJp8M8As1rkoCH8n7d1m+Df0NbzkGV6Kg/Dc335ORoxV+RXfpB4MdDMVLSxwCLR3U3qJtFGUNHkHHylglo0/jyxhHMk0CVgJgN1kRt1wuU2Cx8QSeNYynrEje7Pr5sHtvwIas1EhHJGHt39UESvoPx887GkIgwga06nQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAwJwAK226raxGh5NoBwO9QVUpnql59xp5WX7VgSuHc=;
 b=cKDDYukRzRxo5kDPOhEw3rml1HJM+n+rudThTa8kIow5RYc4sF1+JP+UG1kOk5sf2L7JGEd0/PSlpSdp8vwobrUTNRBShO8jxKwjWSr9dRk359ju0yFb5S0fQXFZNynvIEUHrvkonBox1BP1CAD3D7IGJ6fuLF/WLKkHzDYGZl4XV1/hOzBgQzlO6ZF+eUmTdLEB2jKNZ1rPyWjthZOYyYSan7rUhdyfxIar91VNS9VuWTWujg0TTomGJwpHwJmeutPqZ4GjoHSXD/XsOaO9q4/gmq2/2mHiDasxn89J368fh1CRgtDSLQX92KL9YhEJrW2X1NszYD5JKAH9DedjPQ==
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 12:07:27 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::11) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 12:07:27 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:26 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:24 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:21 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v2 6/9] dt-bindings: arm: tegra: Add NVIDIA Tegra234 CBB2.0 binding
Date:   Fri, 17 Dec 2021 17:36:53 +0530
Message-ID: <20211217120656.16480-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211217120656.16480-1-sumitg@nvidia.com>
References: <20211217120656.16480-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3573a389-1f7c-42e9-4c99-08d9c155cb4d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4234:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4234B10BEE51A38064A90708B9789@DM6PR12MB4234.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SNFtzXeV+h2+e5keBdd2jfWw5YNGtQwUOwwVgVRjN32Y3KpuLYyZ7yC0t4UI?=
 =?us-ascii?Q?aDM/AbXYJiHRihZSR0HS/DqY2Sr9Z7Is9DCtEt1VgVGc6hVC1YLx3XyMnplP?=
 =?us-ascii?Q?Joqy6r6Jo5M4QIjlYWJjuyPE35aXg/xZi/wCxiEXK6SO22zvMgqYA5aw2wCw?=
 =?us-ascii?Q?H6wASJhtxSIw1/dhSB4E8G8MDLVIIHBZVi+H9TJk/c59f5C8q7BPfsP+dPv+?=
 =?us-ascii?Q?I7502D27DeU+b8PMuB+slhpC6u0lrwE5xUYg1NbLi1LRh0VLP2IFG5C1gYHC?=
 =?us-ascii?Q?czO36xjOnKjsbGEal6iBx3u0QapwTdg2Aw202prId8bysN00AV+wKYEx39Qw?=
 =?us-ascii?Q?9E9IOPBlcENJv8HtVFxwrtjFbuskMVUFWa0G3Apxy3DYoI7DOJxHWrifB9uC?=
 =?us-ascii?Q?/FU88d6Ra7YKwRZ8xbJoM/vd9jgilN4DFrpQB2DMLVlYCaGN9p2SkGhKGFcg?=
 =?us-ascii?Q?wVCtbeseCnkY7MWt5+g7C82MLSmqErIqfx3rrvK3EbFWGpv/BRT6w1LsOelf?=
 =?us-ascii?Q?hK45tnExqQVuyXk5A8QnGv5eP2ep7WdzHzzfYcrYqO1cFelnQ7xTB6HGPjIk?=
 =?us-ascii?Q?Ohn47zXUNg9dCpsUP4G+4dOpylFU3ZTaVMpWJljQ5MLyixmHA0oHfQohZtLp?=
 =?us-ascii?Q?P+NUcKntaQ16biWW1oyAKyKbXwbgKIQajEvnzJkIbFoj14p23WuTKbyQQ+qL?=
 =?us-ascii?Q?yfL4sz4KyuVkb/oapgPelYXR2hAkZIH7vc/z6ES4HduD/uYGAA72Stj4QbJ3?=
 =?us-ascii?Q?EtK+HvZ5votEmjl1++iL4n223VNNwH4MKrFYHFRK+xVgBqayPKJ7KkPdqkgg?=
 =?us-ascii?Q?PjvDJbb5ijA6QKJXuHfR9Kuw9gdNAxeo+V959puz13Qcto07cu4VgEvn7BLX?=
 =?us-ascii?Q?pffTrRMuiILD004gLZcyqxI9JZOEuW4SyrEqHx/Jcq8vE7fyE8rO7kD6Nd2s?=
 =?us-ascii?Q?rRyzWSb6pN5UaXj3yarxtQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(70586007)(110136005)(81166007)(426003)(47076005)(83380400001)(26005)(2906002)(316002)(7696005)(40460700001)(34020700004)(356005)(8936002)(36860700001)(6666004)(70206006)(508600001)(86362001)(36756003)(2616005)(5660300002)(186003)(4326008)(8676002)(1076003)(336012)(54906003)(82310400004)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 12:07:27.5763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3573a389-1f7c-42e9-4c99-08d9c155cb4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation to represent CBB2.0 (Control
Backbone) error handling driver. The driver prints debug information
about failed transaction on receiving interrupt from CBB2.0.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../arm/tegra/nvidia,tegra234-cbb.yaml        | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
new file mode 100644
index 000000000000..fa4383be19d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra234-cbb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra CBB 2.0 Error handling driver device tree bindings
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+
+description: |+
+  The Control Backbone (CBB) is comprised of the physical path from an initiator to a target's
+  register configuration space. CBB 2.0 consists of multiple sub-blocks connected to each other
+  to create a topology. The Tegra234 SoC has different fabrics based on CBB2.0 architecture which
+  include cluster fabrics BPMP, AON, PSC, SCE, RCE, DCE, FSI and "CBB central fabric".
+
+  In CBB 2.0, each initiator which can issue transactions connects to a Root Master Node (MN)
+  before it connects to any other element of the fabric. Each Root MN contains a Error Monitor
+  (EM) which detects and logs error. Interrupts from various EM blocks are collated by Error
+  Notifier (EN) which is per fabric and presents a single interrupt from fabric to the SoC
+  interrupt controller.
+
+  The driver handles errors from CBB due to illegal register accesses and prints debug information
+  about failed transaction on receiving the interrupt from EN. Debug information includes Error
+  Code, Error Description, MasterID, Fabric, SlaveID, Address, Cache, Protection, Security Group
+  etc on receiving error notification.
+
+  If the Error Response Disable (ERD) is set/enabled for an initiator, then SError or Data abort
+  exception error response is masked and an interrupt is used for reporting errors due to illegal
+  accesses from that initiator. The value returned on read failures is '0xFFFFFFFF' for
+  compatibility with PCIE.
+
+properties:
+  $nodename:
+    pattern: "^[a-z]+-fabric@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - nvidia,tegra234-aon-fabric
+      - nvidia,tegra234-bpmp-fabric
+      - nvidia,tegra234-cbb-fabric
+      - nvidia,tegra234-dce-fabric
+      - nvidia,tegra234-rce-fabric
+      - nvidia,tegra234-sce-fabric
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: secure interrupt from error notifier
+
+additionalProperties: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    cbb-fabric@1300000 {
+      compatible = "nvidia,tegra234-cbb-fabric";
+      reg = <0x13a00000 0x400000>;
+      interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+      status = "okay";
+    };
-- 
2.17.1

