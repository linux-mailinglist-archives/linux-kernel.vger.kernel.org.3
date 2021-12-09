Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D56946F192
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242784AbhLIR0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:26:02 -0500
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:56803
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242781AbhLIR0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:26:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9cUqBWZulZTF895ousaUwPbIJvsI9THsLLc2V2BrEgrMSui8zoUHU9adyRbu6s2ItU/LUci8Y5wMOvU1dpg8oJcfDj2V3ua8HFBovc4LOzU6DITq8Hx/4Gv0q+/QM5u9zd/4uUldCZF7OLOcw0IArODbdLmsWimfBvpSrn2XQv8UTi6mnykjar01z4OHqODZOldjv+asLlH4JH+41Xdf3lAPg6QpqWdyn3vfwLfUIY7Qc1lFofpfExGCovuZBLQpxajm5ueTVQ81Nci2uLtkKLYWaE9SgwYTnDKkmrDUTZl63+Gzk5n2c0fBNf7pCbx07JAxscYGkLwULiTLQd2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqlYD4lnGLXlOfOdkKznR6ZHYsKduH1W/Um9rhsibAo=;
 b=QtM+XlXqEDkg6f7pibU4T4SqRd95kM5l/9jtMQor97h3dxl/wVMlHyxP0jsLM9cW4om2qyNu12WlC+/+gH0k6CaY8yMuBoUZISYnSSICRoAoBc2xjm9g+8iRGcbUktKtQtWO8CK2FrAG4rN/M/Rvw/4k2TN8uIbwSXq591kHAACTi3rTQI+Dz0q+J1WhtHolHlleV2ynojJ+Qmj2uv1FGWtEZ2XhSfJtlb7+INJ4E/MMksU4p+AgKA74NgX1QedvvXEvCyXGZFN7up91GrlJJe9iWE0coV4k3B3WkUbOaMPpQjC/gzHtjSrGMatwu59JT/AynddnGSvBb9Mww+Sc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.13) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqlYD4lnGLXlOfOdkKznR6ZHYsKduH1W/Um9rhsibAo=;
 b=kjhJmmtDUsHfSCYbh65/08akeiEsI0lmTNPvDMcXii5aAvXDC3ceN2Hcbl/XsgbzremUXZfpIV9nLR9cZAHU/HQT9dHqGjBSeuyxiR8kEEjih7KhMHe6tCJbSTKJam029VXZpyTZfPBrei6GFSZI1fVeomSBk/aA6jiuF5kpJaN4Wkmk1d8Mj1NSOllCiIuBpugBm8doyMlW/LRNVTS/I7UU30wVYXg6WAXiKu8GsFGMOjAhu3sCn8WGKRodAFVDp0eT9hf+vj74oaOmmacZ1f59WEGJuvO7fOGs9z2HmbW2cs3MnAuBpzxSzMrgNwNbgG+s2SxMr5FgisehCgrCmQ==
Received: from DM5PR07CA0076.namprd07.prod.outlook.com (2603:10b6:4:ad::41) by
 BL0PR12MB4868.namprd12.prod.outlook.com (2603:10b6:208:1c4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14; Thu, 9 Dec 2021 17:22:25 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::c7) by DM5PR07CA0076.outlook.office365.com
 (2603:10b6:4:ad::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Thu, 9 Dec 2021 17:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.13)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.13 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.13; helo=mail.nvidia.com;
Received: from mail.nvidia.com (203.18.50.13) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 17:22:24 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:22:21 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Dec
 2021 17:22:19 +0000
Received: from sumitg-l4t.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 9 Dec 2021 17:22:16 +0000
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch Resend v1 2/8] dt-bindings: arm: tegra: Add NVIDIA Tegra194 CBB1.0 binding
Date:   Thu, 9 Dec 2021 22:52:00 +0530
Message-ID: <20211209172206.17778-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209172206.17778-1-sumitg@nvidia.com>
References: <20211209172206.17778-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07750851-784e-4971-b1e9-08d9bb3877ac
X-MS-TrafficTypeDiagnostic: BL0PR12MB4868:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4868BC1858BDF8CA1EF2CD29B9709@BL0PR12MB4868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0j0+DVFSwO2KatNhJmQqPg3L4y5Yv6ljVs0RsIdHk/f4y1AhXkIgeEoGcwkjmsAblbwaicUqxoe4mVoz1gDQQMCJo7DWXyDctuToJhSey2sviQaIXC0igI3bEIWuwACTv7aTBemVDht/krqOlhS2EEbqWApGSX8bprDU7NUy2oOtXpBQhl2VvGOVFEIdPyUMIzAB/R4eQlUuGFUPd4/+mKmIQRcfxldtv4KjiSdReWB75W+6UrMTcug7a+5/c4eNPYDi3o2o74HpvxJGiOEnVgjzfXzEPfO54soewKcoGmSlfHs4mi27CMmGFSfpWdBqDQPlg1S+rxgcvgXWwMxkuxjvv6JiBUk5pEtLmLsb7l0BR9qDKLY7Dcw70z7CfkL+8sxBiW7xOVJrpaOh89OOQ3pmEQTePy2fXWfBU0GCv5cCuVajkUe1pLdL29V7aBIjQZScWrc0Ear8pVr58KcI8giriinBOegweQOuBddDdUssjcUxUTLvehBIiXUgxbZhsFjjdW1FkR4x+Zn+jKRkIYhnubt/sVodRfvxDORrRUnyEMgB5HlRPs64lcqRSKhvWxxCGl4oqh2FrcItmdNcYEAebT2kV5pLTXtrFTuUG6l2skKlvLb+m+Fu6UdWBz6nBueS5pT4snb+1sGk7s43LGYUJKuu34tlayRe5ypBUYx9cjXkMH08O1KSNp3+TqIMAUj0E0WzyqFiQmy2WwEl0o0fgm+cqzFnp0BjqM+6grg1WrA5fSfskIvxW2QgeAO31t4XZ+xVurxVUDft3/dOYUIZ6aeUACRByzhC/2NJ5IVp4PwzCDW4i4OW2pJLcmNxtXVS/1SSVegZ3JZ5Ic2pA/sRilxBuG72J2fITYqDe5h+LlSVNUADfk33xd2sFqU6SpsnzHAfJnNUtZNUC3uOmGpvILw9AgXzAuNDBjKluA=
X-Forefront-Antispam-Report: CIP:203.18.50.13;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(8676002)(508600001)(5660300002)(2906002)(8936002)(47076005)(1076003)(26005)(186003)(36756003)(34020700004)(36860700001)(7696005)(2616005)(40460700001)(316002)(86362001)(4326008)(83380400001)(336012)(70586007)(356005)(70206006)(110136005)(107886003)(6666004)(426003)(54906003)(7636003)(82310400004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 17:22:24.5630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07750851-784e-4971-b1e9-08d9bb3877ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.13];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4868
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

