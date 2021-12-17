Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9D5478ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhLQMHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:07:18 -0500
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:59143
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235923AbhLQMHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:07:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZes7NkEloFxaRL7FWMsW1sH4pV6SiuqZLX9A0hdLbHN02VQAkila6NtMQoDOGsIgpVbXzBk0T5aztC+5/fZnXS7QL1aSD7dV5XTsODYrq9YbDawqmo5HOoM7KgSK/02AgAQ6aGrEQrJypa4wjUVxph8+8dPpwnADf34Swc1Pw6gXCw1NpJmdOinQprAQMdiIWKlSCfPrumoye4ON/tTQYl+hpkKMmY2LTZy+0NxoXFjzw+XwjMUZ4I9q9RpipgP7E86gGO1s8c2ur3/k3r8/89MlaKoOOI2LTMwTJdW3WgkEIqLyzAmU90IsXasnYwQLKMZ5eU3Hjz9s3fwwHdftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2KBrdKJnqi/sr5Z9lw2Jj4KvhINWL7vuMhcbWuIfos=;
 b=P5F+UfWOwjRw35BWRwwadkw5HhX3SvrDhoObO9dwmRaz0afRI4m0CM3uS1dR70b+E6JeIYdrUqZnDunJ5q2+YJlR0vcjM99tsRGy2lkXAFRuD7WcmDkmr25+eeBBvb+9FFbWfD+RIHajlaNlik+YydvuPLR5oeE2aD66jWShm1U0k5/R/5CHVKbxnZhJL+PQZR6cDCH/kSsKQVtuyXcoBCDvDzh+HwM/WFyDCeWjVMxD0LI9OoA2VCgPFgvo96xn3mXPGcI29iHz/q2r+3AVNSIsTDjMqhm1ZstEKsa+kML0MyUam45qsypBaAydQLH70fxRbCg4k5zUNjuNqdR1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2KBrdKJnqi/sr5Z9lw2Jj4KvhINWL7vuMhcbWuIfos=;
 b=mQ/QAliQ6Rh7z39TUKfFVewAhoNPdoq399JtqlE51q0qBHq+5Y4Pbf0b3k+I1NG1LXXZsE1G5XzBHiLfsNdbTkbBt4xzqNfcmK/feQEreZ664fEO+Xx2G5cgJWgsjinD1U+k3A+mTWCD27USD2TxftTo38KgVbqsQo2BeFQhIgcG/yHiTOJJzcVoBlti523jT7o8AlPH/RRLsqEF5Z/egVmNyfc5cyWZx0KDd7fFhh2h7W+S/Tgsd0S6O1B3CO+R2LWEhZMHA1Uteddl6gfGa9rw9PLNs79/trdj53rm0v92CDpc5CCVhmJAeDu1uGQpo1OaS6AFpZ740xp1pRo4lg==
Received: from BN6PR1701CA0013.namprd17.prod.outlook.com
 (2603:10b6:405:15::23) by SN1PR12MB2400.namprd12.prod.outlook.com
 (2603:10b6:802:2f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 12:07:11 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::64) by BN6PR1701CA0013.outlook.office365.com
 (2603:10b6:405:15::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 12:07:11 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:11 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 17 Dec
 2021 12:07:10 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 17 Dec 2021 12:07:08 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v2 2/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194 CBB1.0 binding
Date:   Fri, 17 Dec 2021 17:36:49 +0530
Message-ID: <20211217120656.16480-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211217120656.16480-1-sumitg@nvidia.com>
References: <20211217120656.16480-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b9b010e-444c-43ba-f234-08d9c155c1b1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2400:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2400A7AD06A0177CFC34D836B9789@SN1PR12MB2400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2vi4Y/rtWlj2B8gf2C2XRBHrBCwXG2z+JVMLT2LEzJrExaclCtdURoWbJv2u?=
 =?us-ascii?Q?vq6HARLnwTphrAOvnyT1S26qA9HAyRGluGDY9ZjcmhkxRivUANOJ/tGBxVD+?=
 =?us-ascii?Q?IViwVndK1Nnv6BiTx9g5l6aMAYPDwqpXoXKZuPIKSNXpJSWcdIbkItCDY55F?=
 =?us-ascii?Q?xq3dU92+9yFyh34sO+qM/a5TCdfauC1+NS2NCr8iKqrTkQ/9nb6ojqFEquf5?=
 =?us-ascii?Q?dL4COlw17xl/WIYZR/iw/DT3CYwktvwj+1ke7P+uQtx7xGnqXR1JQoBiqaKU?=
 =?us-ascii?Q?RIvcVlQKCxUfBWl07vIBZATtkQyN2qzukSEtUyAEN3MVVF8gNCKS5Ex/8g4w?=
 =?us-ascii?Q?ucQGmQZ5/FO2dqudeHLUltQwDZNRe9PWeFAOGa070LQ6eyY8vkuGPrEwTbjI?=
 =?us-ascii?Q?PQjlAJsw+tpqcWUk96kzjpZ67CvOAMwQ4owGsb5nB5mboKOG++hSI4HJ7/fb?=
 =?us-ascii?Q?Eutpr2hozGmDYEMld4AAa2waClFfeAokugrD5HrDc8ON8JRtnBSN+3h6lcMI?=
 =?us-ascii?Q?kUHux5bRA7DTSd7suMf4GFHRytoK/s5oPPzjwlw2H8CukqKy/wZOCMevzBLK?=
 =?us-ascii?Q?9yvZcCiPKEClJ/PeqkdaEwTPeaFzgr/vFTyk11zK+vSmcqVLluYfMi298BTj?=
 =?us-ascii?Q?cyOIN+PdJ5C1r9zLQl/Vg4+NT1pgw6bR1T51sJDVMm/HUgIlCyj2a9BvXS+f?=
 =?us-ascii?Q?TXlZKbAhrYM8hHkClS4glD13o788eLoPqszdZrkfN4L72cAUQVoyg1DfNLFX?=
 =?us-ascii?Q?h3hLum59SS+JkEdQmJW4K6atawUertnisn+33Usbpl8ykJrKXpfWaQGcDLXW?=
 =?us-ascii?Q?pVVVqK1N8hSTTbt4guzzUEpgwlVDK9aQUSz15V/BF/lvRdXeQLl+ebKaQswc?=
 =?us-ascii?Q?pbOkHrh2AndC2W1tSOR7vopHZw2MhBl3i1sVW6VcV3moY11Zp9maJzDyksog?=
 =?us-ascii?Q?mzPwyjAaeleZdSPId7lLpw=3D=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(508600001)(316002)(34020700004)(36756003)(54906003)(6666004)(47076005)(26005)(2616005)(1076003)(426003)(186003)(336012)(8676002)(7696005)(110136005)(86362001)(8936002)(36860700001)(81166007)(4326008)(5660300002)(70586007)(70206006)(107886003)(83380400001)(82310400004)(2906002)(356005)(40460700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 12:07:11.3984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9b010e-444c-43ba-f234-08d9c155c1b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2400
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

