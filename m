Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F06946F0BF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbhLIRK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:10:57 -0500
Received: from mail-mw2nam08on2060.outbound.protection.outlook.com ([40.107.101.60]:32786
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242400AbhLIRKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:10:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTmrlJMF2NyQ6NvdVMaP9o4GMzrtzup4fcqKClqmLldiktC7bRLib9fI5mqp+Ntga6qAcSibpYIYJBOma1MoyAXytLKcBW94ItAjR5v4yHBd/DUQJG3Az1L/zczp+YYzfQ8uFICsi8snbybFY211eP/8vxxdZX1XW/fN1T8VYIorXxrzAEtNK4PHhSEyfwmLyFSnSQ8AR90ckImW3HInNSSmDfh28C6ywfxdKukeELzeQt4+NGjYKLabUb2lg0eCpmhQbQEsgbbMfQ3HtSMDycH1ZQq5YebEELl3eFqzonwoylfSJ9yX/vW1rvD8smENraJ7GDC52iCvWCM+H3mGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncX1AswxMuuOx5jXmyy5772CT6i1QWbCPWdRhQ4Zfwo=;
 b=cLr1D9B9xJJoMom8E232TOtCC7Y+H5fT3Y4I49BzCnlkeBMd2KX8X/QpFiQEUY7pj9F0PTzozXSy8K5pjqR53hfgUWTXRyxJNpUHfrJV68wpwpKqt9dQBJs29odzNf7DH0T3QD7Se/MGHDP8HoHVwHRX3Tnbc0xtgtPvSA7ut3JyNHLlMQkWkitbr2t3kZLqdaoy0/xQM9z7x35ifs7RIYeixA9pLH2FIVEFb8Eh89M8Mmpvb5g3hw/6Mw6Fqdmo7KrskRLSaQa5emBvC/s7sBUzsaxzYwIYeXCJ3ZCAeqsmArf5Q3ksj6n8K4295HXNQWen/h8cZX0C3vu/UhIs8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.14) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncX1AswxMuuOx5jXmyy5772CT6i1QWbCPWdRhQ4Zfwo=;
 b=VWCur8u79PVaaD3n3CnEsW5R4xRNPg0TXGF+1rSoARIty/y/ZiK4xCjTbnqJGJrqAGXfv0pzxguuWiIxzFEe23StQawyQsOzuSEPhm3Zi+kNWYxUP2yVV4Bep6ihVQ+NI0dmBsS0k/jlWkuaVeFR/bsHzkKZtS/H1HPrFL726m1vb2alGDrKFJ6//flh1v17JEb02VxT2SbhK2hJ9VFLcxhf4LAaMklSDVUYwJoOS5oB/s92xMRoJTAHcVQn/QUy07A7hqSH+l0KhArD3WlvJwfzA0/QYFDIX/8gJRzadHs4czXfaiSzTvu+vbMImD4mDPmRjzig4bsAgeATCyd3VA==
Received: from MWHPR17CA0073.namprd17.prod.outlook.com (2603:10b6:300:c2::11)
 by CY4PR1201MB2519.namprd12.prod.outlook.com (2603:10b6:903:d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 17:07:13 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c2:cafe::6f) by MWHPR17CA0073.outlook.office365.com
 (2603:10b6:300:c2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Thu, 9 Dec 2021 17:07:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.14)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.14 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.14; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.14) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:07:12 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:07:11 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:07:09 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 09:07:06 -0800
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v1 5/8] dt-bindings: arm: tegra: Add NVIDIA Tegra234 CBB2.0 binding
Date:   Thu, 9 Dec 2021 22:37:04 +0530
Message-ID: <20211209170704.17344-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b496215-1683-4bcb-415a-08d9bb36582e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2519:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB25190CDB3CB34C5B45FC7466B9709@CY4PR1201MB2519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NB1wsb+5yT8uI60SyvEjU63pTug9+xc+UfyvbpterLAj+0DX7a5OhVi41FPn+/GBSeeXZjM45IuOwSH5ovmAuUpZDunCefxxyNPfWFlIHM9ecgFV0taO7Iw6y5HtxlpZldGUi4oLNH3BWqeb9IgQNL1BC8+CcKQL8VEN2mBPnaPUZppMZdB+3jXzhTz5fJyCGOAwgnC9APWwWCjQWClHSAeIEc46DNZFSjbSH0ubqMaLDlm76+yjj+x/2/mpLkMfZf0yOlrCwT38WEjOCvN56c/5l2UFgCIxT/uqAAR8dBXjoLERAUxzTlFic5MvGS6vGzn8EYBosvFuxiemwDBOQHKF3ynjN2oAzq71dHhqZ5Yiy6ut4uB8uzPSJNWsNRpBpoUzG+Gfl+yUMf96xc0UgKYthNMsRwNyljhRwELMPq+WTM25ho+vsT1j3EOCe4YM+leRX6KhnM32lOIpejHCv7RMGeAN2SZ9yNEPGq48+uJqZ0Xop7+M5LaeewFmamb/L1KmfGhI4MgouLhWs9itUWjkIbLccEyFkbhvIm0Z9kUmWm5z3KJG2Jhoe72eM58ujK12uKr870AZRJJbv+YW6iT5fT4Fm/2FfZ/+eG5Pwef4GSV3uC/ptCVhmujifXvUcLRYpxkclkF1Y3IZPrcU9/mcJ8wKjoqLKMuvXFq0/VW4r3Xu/6HAPMmPKhwlTOi5bxoenf9GObYR5Gf1GFBa1pEj9Bd3rSZxLZ2hjblauijCesFRcxrT7X0x0NwT89Fg41DJtpvfL2FQCs/SfIV2xgn18e/gjMYRp//ZpLQ7MjKbRivnrQGSlSMXGsteeyh/Q7dSEmb/zJqVEadIuvuGeL73wMTkL6mJ1rhU4orII6AUVekJMrvrh3CA/HwooLtzfUxs57aHtzMxu4ktOulBeBs+Uc/JsAOpvdcKi5jH/0=
X-Forefront-Antispam-Report: CIP:203.18.50.14;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(316002)(110136005)(8936002)(107886003)(7636003)(70206006)(508600001)(5660300002)(4326008)(70586007)(54906003)(36860700001)(2906002)(1076003)(82310400004)(8676002)(34020700004)(83380400001)(36756003)(47076005)(26005)(7696005)(356005)(336012)(186003)(86362001)(426003)(40460700001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:07:12.8253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b496215-1683-4bcb-415a-08d9bb36582e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.14];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2519
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

