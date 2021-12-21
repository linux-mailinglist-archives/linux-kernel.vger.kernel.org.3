Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2811947BFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbhLUMve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:51:34 -0500
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com ([40.107.244.53]:4928
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235157AbhLUMvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:51:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1f9snyuBc8lsoUx0PZXn6owQEnFqG8PzUTons85UQkufqYOCd0cU71lCvMqbqNsDuGqqEKvSUg1UvZHI/UAF9iLPGutmRRSiRqp+yXk1ln2Vm7zMVEeGEKCKYPjxz2+TeemwAtN11ELC+vgKNHb8iNiYov9XKznALcFtSLf0AuFqvEHCeAV4NgxwgRBIoO1zK85w2VzobwoRd7NpaPNU1Bjmn8H6jlkCvMe6yAOS6+wLtonHeM4fAN+UCdKrMBDFKGzrHhNxhIpQikgsfYPehcb0ZmPySACF9QIv5ee0tkQfiK7S9RhAoHMW6ZhmrkbUfNcj0RgXl2JiMnb6EhnWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2KBrdKJnqi/sr5Z9lw2Jj4KvhINWL7vuMhcbWuIfos=;
 b=OJmLsvTJ1qFwcyfSnroRhowERRJx9yyUk0THWpjbzwdxzQag9xb6cQ7RlZbm9sdDC83t1FJsUNpyYhccgxxOC6mcl3RoLl4Yu+12iJFIQcEgfqTDnJ9+lAL55ExMSsnXqvTVFlMdDu1DZoLCKUzIYt1pwpntJz7eLdHSWY+4iL8LGZJcK9Ix+xAg4GweNAyVhOAURVoLNkWTaG7xpyTY+M1fQQIs9eeKZU80OrVw34wzbzVgccoGzFY7QF66cnW4yX06+uEZtB3GyvyYXcGhkri9Tbjc0uAq3d4e280OlD0f0a5qBBfqrSxA7AGhzNxVNTFNfn0zI8qjcaNyVi30cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2KBrdKJnqi/sr5Z9lw2Jj4KvhINWL7vuMhcbWuIfos=;
 b=sJN0eiYJdXakue2Bq3pHuHAHlOQN6jncyY3FtXA3TCzLLh35TUe4OtHsSDbf7oMDKZMpQ0pJY4fb3SWz9VckBDkKyKjWE2rYVIzrMv8oIbhDUV5KdN1jyO8+d3LFDBtYTMDUFrmOKMjaxvVWkkja7/j937+wGO7TWTDTv7gyTMbZVREbgvw05SIUINn1bixnWtLtLHttb+7yef6ID3LpMrX5U8ZH++1sL2DyTiajHAnKPWkiTmUWZwgOGPsScC3TbFVjy8vTdY/0TJZIWMy+l5XbTR1zoPAJgfsb4QekmYAggamsL8IDRw7KaVSkzV2/wJ4sGVoY9GcNMWGXBT64tQ==
Received: from MWHPR2001CA0022.namprd20.prod.outlook.com
 (2603:10b6:301:15::32) by MWHPR1201MB0158.namprd12.prod.outlook.com
 (2603:10b6:301:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 12:51:31 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::9d) by MWHPR2001CA0022.outlook.office365.com
 (2603:10b6:301:15::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Tue, 21 Dec 2021 12:51:31 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 12:51:30 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Dec
 2021 04:51:30 -0800
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 21 Dec 2021 12:51:27 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <kbuild-all@lists.01.org>, <sumitg@nvidia.com>, <bbasu@nvidia.com>,
        <vsethi@nvidia.com>, <jsequeira@nvidia.com>
Subject: [Patch v3 2/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194 CBB1.0 binding
Date:   Tue, 21 Dec 2021 18:21:10 +0530
Message-ID: <20211221125117.6545-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221125117.6545-1-sumitg@nvidia.com>
References: <20211221125117.6545-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 197dfe3e-cbff-4e56-c969-08d9c4809caa
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0158:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0158F1762AF948BEA3D1D9C1B97C9@MWHPR1201MB0158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vwBCTC7fBhZ01Q0okE9WqL1ca4YupNQfhgLjhOLe8oxbr0emYvcT4vrEYfpx?=
 =?us-ascii?Q?iWEEk1nWzI4VbFeORYRzfkaoTVea3FYsr7QfTCEGe+hYH/ubtiKczRm+kBbn?=
 =?us-ascii?Q?rEba7FU4SDfCRxPqwaMEJdHA+fCAvTr+S/Wa9+sWuGXm3Y72n9YfSD2PhHfO?=
 =?us-ascii?Q?6xk6qKO27AcrE8BmguBdVBaFP02rrotKBi4RBXSBFTFNQ3/lqklOKZLWTZBu?=
 =?us-ascii?Q?sxG4MvUYX1JeRrSCdMuEG2TPVKZ7+HQE4Xh1WMamwfls/adEzO87BJr0sg7u?=
 =?us-ascii?Q?/kpCnvs/kHNnZKZOhVBHtdJFbR9XFnzToNAPlKwss6jmSVXGJDs+UlrWQ61U?=
 =?us-ascii?Q?6/FLJm0XBQMtA5374nK5NkyhW51M1nqv4g/AQSvCw3/Ax8UUvFm1mVsCxHXG?=
 =?us-ascii?Q?W91CRVZGKpOnPC5DrJ1ZMjYjy1RTZP5HeO9+3pY7g7N2zq31IQxIzlUwAm61?=
 =?us-ascii?Q?wxX4VmvteMCWUZJJQ+Sm4dGFTXJojaY2haoKoFa0IY4VZ162CFlfJT2xvecf?=
 =?us-ascii?Q?BJ5AkSACTq3R+HLXUwfPWVkxn4+Hxt4fRqDZ/NCh9tnnJsc6+wKa4u5BkTg8?=
 =?us-ascii?Q?A+XnDVmp82uFV4CUtKofJSRzxIQcG10eEbGNhxvutEdmqUB+JOMfK4eN19PA?=
 =?us-ascii?Q?uOCp5IcVGuH+VTkY937tfi+lR92wLrAK6YpCSXqjri4XkWsEfGRIqtza9hG6?=
 =?us-ascii?Q?GMWIURHyfbpoqwkHarAGjZwVMkGcynPj7lBIWU1nkjMoZpPGUReluHDfJRzB?=
 =?us-ascii?Q?ukgSRzy3bBYIqddOwLCZ2Y48viLkmDICAmicEPes2YFYYzC7NsE4PR2mYdaZ?=
 =?us-ascii?Q?WxlWUC4qsNSWhKQVux3LuU/gMd4X8KXnC82cxq2ut5rO4j3UcMxtzCzInBqa?=
 =?us-ascii?Q?8Un5fh8eEZCbevG6caZe2f4FzFkbV7YD0c29NomuN68eswOG2nb19xgGCG44?=
 =?us-ascii?Q?DisSyyiu0+n0vuILA3usHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(82310400004)(70206006)(8936002)(110136005)(2906002)(36756003)(40460700001)(54906003)(70586007)(2616005)(336012)(426003)(356005)(47076005)(81166007)(34020700004)(36860700001)(107886003)(5660300002)(6666004)(26005)(186003)(1076003)(83380400001)(316002)(508600001)(86362001)(4326008)(8676002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 12:51:31.1682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197dfe3e-cbff-4e56-c969-08d9c4809caa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation to represent the error handling
driver for Control Backbone (CBB) version 1.0 used in Tegra194 SOC.
The driver prints debug information about failed transactions due to
illegal register accesses on receiving interrupt from CBB.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../arm/tegra/nvidia,tegra194-cbb.yaml        | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
new file mode 100644
index 000000000000..3167f0450298
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-cbb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra194 CBB 1.0 device tree bindings
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+
+description: |+
+  The Control Backbone (CBB) is comprised of the physical path from an initiator to a target's
+  register configuration space. CBB 1.0 has multiple hierarchical sub-NOCs (Network-on-Chip) and
+  connects various initiators and targets using different bridges like AXIP2P, AXI2APB.
+
+  This driver handles errors due to illegal register accesses reported by the NOCs inside the CBB.
+  NOCs reporting errors are cluster NOCs "AON-NOC, SCE-NOC, RCE-NOC, BPMP-NOC, CV-NOC" and "CBB
+  Central NOC" which is the main NOC.
+
+  By default, the access issuing initiator is informed about the error using SError or Data Abort
+  exception unless the ERD (Error Response Disable) is enabled/set for that initiator. If the ERD
+  is enabled, then SError or Data Abort is masked and the error is reported with interrupt.
+
+  - For CCPLEX (CPU Complex) initiator, the driver sets ERD bit. So, the errors due to illegal
+    accesses from CCPLEX are reported by interrupts. If ERD is not set, then error is reported by
+    SError.
+  - For other initiators, the ERD is disabled. So, the access issuing initiator is informed about
+    the illegal access by Data Abort exception. In addition, an interrupt is also generated to
+    CCPLEX. These initiators include all engines using Cortex-R5 (which is ARMv7 CPU cluster) and
+    engines like TSEC (Security co-processor), NVDEC (NVIDIA Video Decoder engine) etc which can
+    initiate transactions.
+
+  The driver prints relevant debug information like Error Code, Error Description, Master, Address,
+  AXI ID, Cache, Protection, Security Group etc on receiving error notification.
+
+properties:
+  $nodename:
+    pattern: "^[a-z]+-noc@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - nvidia,tegra194-cbb-noc
+      - nvidia,tegra194-aon-noc
+      - nvidia,tegra194-bpmp-noc
+      - nvidia,tegra194-rce-noc
+      - nvidia,tegra194-sce-noc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      CCPLEX receives secure or nonsecure interrupt depending on error type. A secure interrupt is
+      received for SEC(firewall) & SLV errors and a non-secure interrupt is received for TMO & DEC
+      errors.
+    items:
+      - description: non-secure interrupt
+      - description: secure interrupt
+
+  nvidia,axi2apb:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      Specifies the node having all axi2apb bridges which need to be checked for any error logged
+      in their status register.
+
+  nvidia,apbmisc:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      Specifies the apbmisc node which need to be used for reading ERD register.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - nvidia,axi2apb
+  - nvidia,apbmisc
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    cbb-noc@2300000 {
+        compatible = "nvidia,tegra194-cbb-noc";
+        reg = <0x02300000 0x1000>;
+        interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+        nvidia,axi2apb = <&axi2apb>;
+        nvidia,apbmisc = <&apbmisc>;
+        status = "okay";
+    };
-- 
2.17.1

