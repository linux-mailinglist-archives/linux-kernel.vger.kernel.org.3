Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29346F19F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242871AbhLIR0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:26:30 -0500
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:45153
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242814AbhLIR0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:26:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cncFIBpls2tjKyodLUTKxEqYRIB5lxJsvLA0jdjcd1VDzlOSi6sLF0e5XkJ6rrceUT+Xhd+xDdUR+ULLzVlhbviCpl+YVfd7bvIRBtcPps8Noi/bG8skSJXCpqyC3cjnvhSesZH1HMU3kvZRAPvDbwRLsGS3+Ws05gOHfisrmooWaqBdiB4T/7hza/hl4jVkYD1XOkoLgI1/jQdsmdYp1e3YVLNnRrWEjkId+kHYP+MB/LaOx+TFv3G9UQpFTZT4MNiSxfd6xBS0SD7J5m7w5mIH56g4GKkERow2FP7CaT6rK2RQdKFWtmI8crbTKJVe0ER1THEoxd965BR9UHfDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncX1AswxMuuOx5jXmyy5772CT6i1QWbCPWdRhQ4Zfwo=;
 b=IGNy2LEddBuvmQx5uSGQ9qH+gyf7FWjPz/ZEJjjYj9vC2n3CWyVn6CYGPMVRSv2Ti0xsnWFPX+3DrNQsF1TQSH2SDpByh4jhq5Mx0+gsVRXeTHe3sm9L/lLJiPnc7nG+pm/AvImnUiMAZ2gXGTQPvShnDQXvxlQvn1napy5AI5+FtErzQ+3K5/cbVxRCt+tQ1INlkP/xiPRRu92RyXDrIGLshfVgg9/iSW/pXsosDyOzQn+XqMQYoq4ucCabyx7i843O3+gg1jD9ybnj1gQg31lqqASpY3uclx+jx9mR4xNm5SKbCsXEIgXVGCg2P6uBkmyMT/Um1t9Uh6hfJThAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncX1AswxMuuOx5jXmyy5772CT6i1QWbCPWdRhQ4Zfwo=;
 b=df7nnSLNl49gDTiJMyBmQMlxMz2RfltPtYclcPa6u2YNv3JoLtPK6IGxQ/LmFlHfsv3Oq9+Uy25g+TPSDI8c9m3dtDAUkc5UnD1jvQmvJiUbHrMOGeXPXxzFp7jeSTfq6B/xqtS11Fj+7yfU4mQ4CypRIMZgmoXZXPXeB0Ee1L1ANCMf5aCOFqtfr/kaSejNogdMaxEK6Ap6hFxXqeZ7tY56dgek3T32x44hR1Ln3SXmUhvQMJmEKuOMyqIQBAu3SMc1q0CieUpMIxCtwf6uh2jOyvyIZkY3FQqQleohlGg6tEmTzHXdcJ19BEz01RfgK5R6qQtrVqqIb/Qqi4dzqA==
Received: from CO2PR05CA0106.namprd05.prod.outlook.com (2603:10b6:104:1::32)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 17:22:43 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::4d) by CO2PR05CA0106.outlook.office365.com
 (2603:10b6:104:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Thu, 9 Dec 2021 17:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.12)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.12; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.12) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:22:42 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:22:29 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:22:28 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 17:22:26 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch Resend v1 5/8] dt-bindings: arm: tegra: Add NVIDIA Tegra234 CBB2.0 binding
Date:   Thu, 9 Dec 2021 22:52:03 +0530
Message-ID: <20211209172206.17778-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209172206.17778-1-sumitg@nvidia.com>
References: <20211209172206.17778-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 617de5af-abd2-45b3-a80c-08d9bb388278
X-MS-TrafficTypeDiagnostic: DM6PR12MB4481:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB44812B79E01DBA7ADA1C425FB9709@DM6PR12MB4481.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JBHFxGOQQM5uSm/JzmX1lfLF69yvbdMEuyBt32G/d6YykR9Z4DOYa/+NRB7zk+WrL4m9mHMojfxHibanKGKArRjwbZav/3HvtFYZaT1P+DfE/EHnfjVuEUgVqjSysiYC4mORMf2pVpBxEkQS4s3eY9YC6PcYG59sR+KlRF7kg8kjxMiYDGxpjQ/A02ZmG7kI1cG61ysu0yiNqwgJI9see3FECZ9385vQAUbZfAAcnR0SoQbLsO4pOKuF5UESsVjF5DtsX8jPyGpn34+fDJlxnJ2K+WYbqv/bgbIl+ERBEkl2ikf+1T7xATy9mn77ZY4+bUQICDpFisu7+AS5kVimi68qstUQjzw3vDtN8PBggkvfHOQtwl+fuaE5Km5eqZ2yQSPT4qsPK6XT23xTq/CnME743jMPcHN6j9by+T0o2AbCooXXtROkfLLicJdGHVnXbRAG3IhGselrO3DG4+Ev9lXGebXQcSWTcajwADINxHV97nucH1NGfZp9E7iz23sx5X7WtWeVKrVYjEzU7SgSrs1Zr2NqOFyza8EqpKsHu0Op7FQkH+RB7qPq6sHUADy1qD6tSkf/qCHQTi4lG1gCSLoTFR90Sgu17G7Ih3vNO19ppj1oqy1/rTQT/EvfZfe042PpPULjTTRZyyhYjfcJrXj2OgPd1Cm9i0vQHlp08X2nzmlwiLYSv/Jy582ClyCTYpBfMeGtXbyJyWfzdWNCNdALW2/qbPwgPGif9ISS6ksB3uNuqHhg3oBL/djH5ioukG9N4d8GNyJ6eax2gZCQJU32UOeuhudHKDi4TrXLyDzrEprbU2WqyM1AnJDXfiFEAvIVulWTDHar/1nMNJb44q7zT36pnrzcxZEwUAaJMz4aOLheiFOcxv6blnzTxczDbrDjgGlkhotg/g7OFTZAX8KMqVk1PkR6+mdRSfJMn8=
X-Forefront-Antispam-Report: CIP:203.18.50.12;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(107886003)(70586007)(83380400001)(336012)(186003)(82310400004)(316002)(7696005)(70206006)(36756003)(8676002)(508600001)(2906002)(6666004)(7636003)(426003)(5660300002)(54906003)(110136005)(40460700001)(1076003)(356005)(47076005)(26005)(4326008)(8936002)(86362001)(2616005)(36860700001)(34020700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:22:42.7706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617de5af-abd2-45b3-a80c-08d9bb388278
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.12];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation to represent CBB2.0 (Control
Backbone) error handling driver. The driver prints debug information
about failed transaction on receiving interrupt from CBB2.0.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../arm/tegra/nvidia,tegra234-cbb.yaml        | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
new file mode 100644
index 000000000000..ad8177255e6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: "http://devicetree.org/schemas/arm/tegra/tegra23_cbb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra CBB2.0 Error handling driver device tree bindings
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+
+description: |+
+  Control Backbone (CBB) comprises of the physical path from an
+  initiator to a target's register configuration space.
+  CBB2.0 consists of multiple sub-blocks connected to each other
+  to create a topology.
+  Tegra234 SOC has different fabrics based on CBB2.0 architecture
+  which include cluster fabrics BPMP, AON, PSC, SCE, RCE, DCE, FSI
+  and "CBB central fabric".
+
+  In CBB2.0, each initiator which can issue transactions connects to
+  a Root Master Node (MN) before it connects to any other element of
+  the fabric. Each Root MN contains a Error Monitor (EM) which detects
+  and logs error. Interrupts from various EM blocks are collated by
+  Error Notifier (EN) which is per fabric and presents a single
+  interrupt from fabric to the SOC interrupt controller.
+
+  The driver handles errors from CBB due to illegal register accesses
+  and prints debug information about failed transaction on receiving
+  the interrupt from EN. Debug information includes Error Code, Error
+  Description, MasterID, Fabric, SlaveID, Address, Cache, Protection,
+  Security Group etc on receiving error notification.
+
+  If the Error Response Disable (ERD) is set/enabled for an initiator,
+  then SError or Data abort exception error response is masked and an
+  interrupt is used for reporting errors due to illegal accesses from
+  that initiator. The value returned on read failures is '0xFFFFFFFF'
+  for compatibility with PCIE.
+
+properties:
+  $nodename:
+    pattern: "^[a-f]+-en@[0-9a-f]+$"
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
+    maxItems: 1
+    items:
+      - description: secure interrupt from error notifier.
+
+  nvidia,err-notifier-base:
+    description: address of error notifier inside a fabric.
+
+  nvidia,off-mask-erd:
+    description: offset of register having ERD bit.
+
+additionalProperties: true
+
+examples:
+  - |
+    cbb-fabric@1300000 {
+	  compatible = "nvidia,tegra234-cbb-fabric";
+	  reg = <0x13a00000 0x400000>;
+	  interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+	  nvidia,err-notifier-base = <0 0x60000>;
+	  nvidia,off-mask-erd = <0 0x3a004>;
+	  status = "okay";
+    };
+...
-- 
2.17.1

