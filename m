Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F5746F0A5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbhLIRKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:10:08 -0500
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:24032
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242437AbhLIRJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:09:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/zo7t7kf/5Nj3N4Ircc4TmjmYU8MD9abF/V9JlDHBM++AbNHRFLpmnR20Vza66q3B4zC64ZcQkbVj2MpN6oEgodn5cIKZ/2Q+UQmZF1pm/UFaD2vkqe38KcOHfzMLdF7u8NYBimozXl+0RYeV0crIEQMwBy9Pn1s5qVHdocgrOrX6Zsb4WTbDo5Yn/qyESwVOZ4g23odnXt7GAcvGHhcDZcbjJeMHt9YcOEoij/dhO8wj2g1aUBxO9xcrd1zgYIbcCQwqxJYaphPt9NNaVcaHk+trdjhprMopUU6RlvHLOEX6PWCAMMOc7iobvEC859mMhsxIfjsBvOB56iYlw60Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqlYD4lnGLXlOfOdkKznR6ZHYsKduH1W/Um9rhsibAo=;
 b=A3Sp0p618HwP5p13sanAeAknCT1W2JVMxd70EmNOjdXr9GEzq704MBfJGjlJvzrkxwxU7gkkN+16qVQUaq7mL6EnQfUcPwx1awTJcUWWwRG9tOcHCLgbOo8ONENMli3WrfbZkKis5Qagobb4u+otF13u0OgTcAq5mv0wHryBhaWkxWYdO4xOQCCELzNIHM21PiQuoZDg9gm/cPkgt5HmR8e0gvTBOJ9Yq9Orhk8Eynz7+qX0DncYtJHTmoPuDSdF0pvmgkyLQ/4jzrigjmBH0WMV9ilOEfPNYDuT8vGIrGE1Gj/V9UjoeeMdCzRanstDno0PK+L9wWNCNHBgotdjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqlYD4lnGLXlOfOdkKznR6ZHYsKduH1W/Um9rhsibAo=;
 b=QrnyqVoigjbjsW4Py5GCV6Tm1Tl0/Z+Stvs1ueGxkJurbPaKaYwyJ/LSwP2rre3U+A/G3MTs7/Akuu8Z0ckLSCIZevw2axZ6WVQytcy7kCzFc7v0xr+0GCAWzlckQiF6AWagjzzKvFU53pglY1p2Plhq+Bwx23GEDeit1K9hy2v+M6AWREVOx1u0W+ZUUEf5x8WkU94RD+hf7WxfG3mAm/24pH+vpWgKMwVA+Ah/Fe8lWecGJy8iE5IxpukqGAtzxkUd76emnQROO9bBA5VMF0SI7Z6kgNQa0ePjdAhAHFg8cJGsyw9x2z1BuWyjy9xAHJXVNvfW95qyfOvq4uASBg==
Received: from MW4PR04CA0042.namprd04.prod.outlook.com (2603:10b6:303:6a::17)
 by BN6PR1201MB2497.namprd12.prod.outlook.com (2603:10b6:404:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 17:06:18 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::71) by MW4PR04CA0042.outlook.office365.com
 (2603:10b6:303:6a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Thu, 9 Dec 2021 17:06:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:06:17 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:06:16 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:06:14 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 17:06:11 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v1 2/8] dt-bindings: arm: tegra: Add NVIDIA Tegra194 CBB1.0 binding
Date:   Thu, 9 Dec 2021 22:36:09 +0530
Message-ID: <20211209170609.17192-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a1dc150-5130-45b7-fb8f-08d9bb36374b
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2497:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB24974F44C5C36CE9714C702AB9709@BN6PR1201MB2497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Koosjm8kGq/CLRHoOVKy2OU5Lzx8Fy09c6AvuWir2q0YwGu6MLwucxIGUDdtjNFCwjKxVhRGoHt8OZJwhWeAO4G5gGKlqGM8svlHhF04d/yojSV28+GZsE/Dgj/91ExAno25e7MsFN4G+gfSMACZ9t2PQpV8rQx62wPElvq3hP6+oom8LAkJdC2GHgpZLKzVUYDXd9x+K6RDF77N7Y1cgzM55B9iXXm8C+UNrrK+9jyzM/+igLRX9C1oGsFjnam+iTSUL3lEx560YkGZ64ZKRLBSe7ZYUhwj8IjbMiMEaOI8467+qyx6v/1o2xRHSq6808Q6r/SuzA6hm4Tb3U23yBZ7iTSBHn17E2SqEBlkT10TolGyfZ+Or6ODArijnSpa/gyAe5axUMhaEl4K4uu/d9gIFIQGWZcN1oc852sAzNJ03P+5f7J/cFAe1TA7fJFVXkym4sZP56no4FvwmJM9IMJs7t8yRsyMTNq53oVr2pJLbpm41ECc5wXdNQJjMbab515ANCry4lRNdBpX2w51HoQXQ8kB6grYUgmO8QUEyj9nBIl0MAi6sVZXmbjlbuiAvUohzPailtHigakCpEU2/XEbG56DXZRhMpSJ93/FunTqy2IJ60YQXBuKM5cK8NCC783UmwIhGWE3g79t6FwIoTfe8X8WHnheGQ8Z/CDPVJPIFt57GOrpbGOLQpZy2ospscBpSrXg3C1FaKbF/CJPMpybxsg07f2q4FGWY2azwHgM6jSsO7fVsD1hJnK4Z3pJR9F/DFxM9uzajePtY8tupRSQcdpUuBxPTrKUKPXBLcdleFNQQCkurXqnDmF6F41yeYITMF3yBIGqGSTLDJH6RNgdZi2z0MD1/gzsZl6UfrRS0Qtrzp+jzs9VFGL5rr05QwDtijNHV/0aTHVczJnGr/QG1bJHW2Yi4Q7v+cvf4lM=
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(426003)(8676002)(7696005)(1076003)(2906002)(316002)(8936002)(34020700004)(336012)(2616005)(70586007)(26005)(70206006)(508600001)(40460700001)(356005)(186003)(4326008)(47076005)(107886003)(5660300002)(86362001)(110136005)(54906003)(83380400001)(7636003)(36756003)(36860700001)(82310400004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:06:17.6553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1dc150-5130-45b7-fb8f-08d9bb36374b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2497
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation to represent the error handling
driver for Control Backbone (CBB) version 1.0 used in Tegra194 SOC.
The driver prints debug information about failed transactions due to
illegal register accesses on receiving interrupt from CBB.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../arm/tegra/nvidia,tegra194-cbb.yaml        | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
new file mode 100644
index 000000000000..a9b5a1eab909
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: "http://devicetree.org/schemas/arm/tegra/tegra19_cbb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra194 CBB1.0 Error handling driver device tree bindings
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+
+description: |+
+  Control Backbone (CBB) comprises of the physical path from an
+  initiator to a target's register configuration space.
+  CBB1.0 has multiple hierarchical sub-NOC's (Network-on-Chip) and
+  connects various initiators and targets using different bridges
+  like AXIP2P, AXI2APB.
+  This driver handles errors due to illegal register accesses reported
+  by the NOC's inside CBB. NOC's reporting errors are cluster NOC's
+  "AON-NOC, SCE-NOC, RCE-NOC, BPMP-NOC, CV-NOC" and "CBB Central NOC"
+  which is the main NOC.
+
+  By default, the access issuing initiator is informed about the error
+  using SError or Data Abort exception unless the ERD (Error Response
+  Disable) is enabled/set for that initiator. If the ERD is enabled,
+  then SError or Data Abort is masked and the error is reported with
+  interrupt.
+
+  - For CCPLEX (CPU Complex) initiator, the driver sets ERD bit. So,
+    the errors due to illegal accesses from CCPLEX are reported by
+    interrupts. If ERD is not set, then error is reported by SError.
+  - For other initiators, the ERD is disabled. So, the access issuing
+    initiator is informed about the illegal access by Data Abort
+    exception. In addition, an interrupt is also generated to CCPLEX.
+    These initiators include all engines using Cortex-R5 (which is
+    ARMv7 CPU cluster) and engines like TSEC (Security co-processor),
+    NVDEC (NVIDIA Video Decoder engine) etc which can initiate
+    transactions.
+
+  The driver prints relevant debug information like Error Code, Error
+  Description, Master, Address, AXI ID, Cache, Protection, Security
+  Group etc on receiving error notification.
+
+properties:
+  $nodename:
+    pattern: "^[a-f]+-noc@[0-9a-f]+$"
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
+    maxItems: 2
+    minItems: 2
+    items:
+      - description: non-secure interrupt
+      - description: secure interrupt
+    description:
+      CCPLEX receives secure or nonsecure interrupt depending on error type.
+      Secure interrupt is received for SEC(firewall) & SLV errors and
+      Non-secure interrupt is received for TMO & DEC errors.
+
+  nvidia,axi2apb:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      Specifies the node having all axi2apb bridges which need to be checked
+      for any error logged in their status register.
+
+  nvidia,apbmisc:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      Specifies the apbmisc node which need to be used for reading ERD register.
+
+additionalProperties: true
+
+examples:
+  - |
+    cbb-noc@2300000 {
+        compatible = "nvidia,tegra194-cbb-noc";
+        reg = <0x02300000 0x1000>;
+        interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+        nvidia,axi2apb = <&axi2apb>;
+        nvidia,apbmisc = <&apbmisc>;
+        status = "okay";
+    };
+
+properties:
+  $nodename:
+    const: axi2apb@2390000
+    description: AXI2APB bridge
+
+  compatible:
+    enum:
+      - nvidia,tegra194-axi2apb-bridge
+
+  reg:
+    maxItems: 6
+    description: Physical base address and length of registers for all bridges
+
+examples:
+  - |
+    axi2apb: axi2apb@2390000 {
+        compatible = "nvidia,tegra194-axi2apb-bridge";
+        reg = <0x02390000 0x1000>,
+            <0x023A0000 0x1000>,
+            <0x023B0000 0x1000>,
+            <0x023C0000 0x1000>,
+            <0x023D0000 0x1000>,
+            <0x023E0000 0x1000>;
+        status = "okay";
+    };
+...
-- 
2.17.1

