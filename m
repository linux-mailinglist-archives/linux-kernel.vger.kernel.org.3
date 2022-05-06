Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14E251D653
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391207AbiEFLQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391198AbiEFLQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:16:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F285640C;
        Fri,  6 May 2022 04:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JofrFQ71fr/KFCcBqd2BvTIQKCjuVwJOHelMNdnn9gFxZrBns2jKdnnML7ohJTj2UClraGRanoseiKAwDZ+T5S5UpCyOiqkDKlnRGdJxVkJXVUKzR9oKbJ2P6dYlXnZP+j8e6oN7HhsP+9lITGhWUtz0PZuDwut76nzk/cB5CnTY+l07LaUVa8mk6exnlJJjVF6+LWd/iz4QWnMajNsY+L39LUB5qx7zktCD1B4yNCUIt+H/4R6M+I7VP6sHBPEn1R8t63AaHfMx0wusKnKY6bQnsDpoA6/9jDNm6arwLqzk6uagk8Hbw1Qm9TPOQhnVQ27eJ55x+eN3OIw2R9tl6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2KBrdKJnqi/sr5Z9lw2Jj4KvhINWL7vuMhcbWuIfos=;
 b=bGxNRVTDGeqPtzMIY+ldmu4cr5PvtQkO5eA67YcG4M3rfQ0gggV2/a/p9R7zLOD4r4gsn/h0prvf2BgBz4rhGSY19J3OCx3RsphWkajYnMXi3BxZJVdRS4RTN6ypHQLDgbgZMhog0Fwn/Qfw1TzqqwsguEnwgp/iQWomp49cKIc+PV11ebSoHhOJD6lpUkIRvBy8PsuAdtLplwCvIUjYiOk8slt4oInyfLsWpXXQ+28qtK5BSkM2u0EYF7M2e6Op9JsggPurl72JQMhTUZ1epv/95eix823oSOLUElDLYkXrPjex7qORUjxYlyJ3y+1nLoaCgFB5flVjhMuLvOA+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2KBrdKJnqi/sr5Z9lw2Jj4KvhINWL7vuMhcbWuIfos=;
 b=X+AtvZn7Xy4k9N4e2qEo8EmypTcK2bPzeqdw4D6oLeqKkv+wyVMft/ggn/vaGBEzk1vX35Xx91nCO8Si9aYm3QAhHSNJlYAprVX1HhNfa6JgtJ6XSPXn15RIUHeu94426ck/ZUtDZ2J8NRUVzAbzVwapG401reKQLEfuig9QbU35tlj+lC50F/QzKz1JRCBhmgXfI+FfBcZGSQM+jXvap3rfjJNY9Eh3p9Gfd036m6cBl0IqSp4/SyQn2P3s+I9avbUJ4MtFcLgs47Ue6/nhj3NnwyEypZ1T0iQGrChW9p6yaNhS/NlFDcQZg5G4iXLuxymr0WrFfI5V9hT4Lqdx6Q==
Received: from MW4PR03CA0262.namprd03.prod.outlook.com (2603:10b6:303:b4::27)
 by CY4PR1201MB0261.namprd12.prod.outlook.com (2603:10b6:910:1c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Fri, 6 May
 2022 11:12:38 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::39) by MW4PR03CA0262.outlook.office365.com
 (2603:10b6:303:b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Fri, 6 May 2022 11:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 11:12:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Fri, 6 May 2022 11:12:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 04:12:35 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 6 May 2022 04:12:32 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v5 2/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194 CBB1.0 binding
Date:   Fri, 6 May 2022 16:42:10 +0530
Message-ID: <20220506111217.8833-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506111217.8833-1-sumitg@nvidia.com>
References: <20220506111217.8833-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fcbb69a-5069-40ab-7846-08da2f51547f
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0261:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0261EF622F8CC62FC039D6E3B9C59@CY4PR1201MB0261.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2VNf2ZKuXkKZaLTrdsFtFBnpF6IiH7xqvU6AouK5fJ1LrgkkGC2Vvc9/L8kL2FkAlvLz5qLUO+Iwlpt2zQu/5YirIL93IxC8ioTc3nKO1aIZIkuyENshJUPg6GTFh0VtG3UqwbC7FMdiTnQD6jxXOqXPv3oMCd6nMQ08RNNNDrj8BJv6Wl+Vg4e4735XEiCeRxmZ9Hb9kBgc5XVPHpClM9DRtEuOXfDXq4nN0JFGV/68jdv9EXWKHvk5FKBvB65mvaYGPO//VjY+mEtBTpBxdydBuRsT8t6o2B1scGsHQNh8QlW6nHl/UOyB1TUV+SXdDBapukvAdWCB0xR4rIiz+nE7zid56aqy83Alup43UH4+hjU5AGr6heE8k26I3vxXNHdQTqZsnLH5Pr++4PWfikfRKgSz/AFNaMN4yOQ+Hd5W92FkDjpDe05+f4FoMlkRoohIoaOz536U0r18sL/A0Np/9uSB8DsS2BIGmgxBZSVgE2KOD6+4ZD7Ccb8OIHC4y3Ml0MWb4FbtYDvY+6QawjKcdWekfdQ/HE3sHIeN0DO4utVT/9CGnswMoewdAA88zVdni3vsdw1eVyok+c6PdeyMcnb+b4K+s5P2QpHyZsqEbZThMYEV+nmpFdDiBQSFt9m/p4Q/t+YnW3fjKofnkTigsnXPjolSr2/WqZPN1H9GDod3INdYlnS3jlookvLXyRFUZ1hWOPnBw/F7xD6c8H7s4rertKDY2d7CVdu5HfwdsxTVOnId7JatRJNv0AOa22LtVYTpLepiHrGc4hvh/ZonyGUdiCuT2L0Hi0doABtutiFkNfrFlkyDvdv6hlSAb8F7KrTKZJ+tbADgwFzJA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(107886003)(81166007)(70586007)(356005)(2906002)(83380400001)(6666004)(2616005)(8676002)(4326008)(8936002)(70206006)(1076003)(54906003)(82310400005)(86362001)(47076005)(26005)(336012)(426003)(110136005)(316002)(40460700003)(5660300002)(508600001)(7696005)(186003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 11:12:38.2061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcbb69a-5069-40ab-7846-08da2f51547f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0261
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

