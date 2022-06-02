Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B263853BFE9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiFBUjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiFBUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:38:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BE426DE;
        Thu,  2 Jun 2022 13:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq+9M669BpxjZWlxiRZyiH8r2dojEhYIXYt46yV6/vP0KQt6znrCn7vLiNF+ZnyFubbxDloVfBd/LseiUSp+j9RunEG8cDmkRcSq55cDs1Ljh2owdw7iJWwyJDr9B/rXoFuXdnzehW2Q+BeqGEWMwVdKxYIXkKpoVB4qhetSqKrvPJtypxtpmAB8C0ROAb+WvQb/tPZNzokNV2u84tSmqzu3/sTLkU99KCZJ73DFr/UaKu15bqE0LI975o1805tuIIkZ27znvZ7eOd3RdE+D/LvRzULQcUWHhw9Cjfu37pTclvwjAhfS8wb3aS7cEf65nbD2pLE69hWrEywRi7zijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwOUQl3P7T0rDxucwW5Ne56LOJBJeRhRG0pHxO/Yx5k=;
 b=KFkiDkzjTpxtgiu+oWoe6scHNoZQ4DS0+SgCZfviku/gCfcNGaAaKFjk9WhYMaY7nHIe4d6zX4nzeOT13g87cjQisPc8V8v7AmDjfRKF+vj7RYHKvZAO9VQ5rCGa5UicL0w9NOPSiLj2/yNGRAWMdkLMjFsAtmFi+zgQWiRsD9v8A9MYke0V/MVz0XPs5K6AcZqLYSTDJi7PtkpMOzf1i5IKshdJamQydXq+PIV1Ttdm/yotY9VyUR7g9hyNPjlIoJYDR3ekmfmHuqR8U+FUgjY0JEAMAkdxdpmU0a52NB3eRpRmJLTfLYJyy+P2AsurUGABkRq9W8Gs8d4zlTUIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwOUQl3P7T0rDxucwW5Ne56LOJBJeRhRG0pHxO/Yx5k=;
 b=rVz0YwSJx9holmDrpL0yOOtKU/PFB115srnMZ4E+4VQfmlfDuNbmn6lyDucG6qr8f3yLCJDwDDUUGkfoDVBTfRGvw8iQedl4pDB1DhCeUrkkzOZM0umxfJQpK1/ZvGmiAWsqYoBZztGH4W5y+8EVfiQu5JJTePVy8teLYmB38/8=
Received: from BN9PR03CA0346.namprd03.prod.outlook.com (2603:10b6:408:f6::21)
 by BL0PR02MB5378.namprd02.prod.outlook.com (2603:10b6:208:83::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 20:38:50 +0000
Received: from BN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::fa) by BN9PR03CA0346.outlook.office365.com
 (2603:10b6:408:f6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Thu, 2 Jun 2022 20:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT052.mail.protection.outlook.com (10.13.2.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 20:38:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 2 Jun 2022 13:38:49 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 2 Jun 2022 13:38:49 -0700
Envelope-to: bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 openamp-system-reference@lists.openampproject.org
Received: from [172.19.3.14] (port=53866 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwraj-0007MG-6D; Thu, 02 Jun 2022 13:38:49 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <openamp-system-reference@lists.openampproject.org>
Subject: [PATCH v8 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
Date:   Thu, 2 Jun 2022 13:38:29 -0700
Message-ID: <20220602203834.3675160-2-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
References: <20220602203834.3675160-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28db127c-1969-4802-fe72-08da44d7e682
X-MS-TrafficTypeDiagnostic: BL0PR02MB5378:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB537846E7F5E984B8765B0F15CADE9@BL0PR02MB5378.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcqIVeSgt5q7PUsQEIOU4RvDIVznXD3u8yvGW96VTUYYxDqE6Pm6Ov3yZcGPMYikPCwySKGWjstHhAR3tzwRSDuabHcu5zaHAQ55eC2ZqTl5w2D9R9iITh52RarwWhaYCDZYcjUGzb9icgaOVaavKPDtRXY+I6ctTHSqRgDgTbt7l5C8OY2m7QVmRegoocG8ClGFswUspY6L6ysxanjXK99PFBV2/kJ4MYHiGWLW+tdmh47LECa/vMXfAr8ME7Sut07iqUDN9nYCBiJGVJfrwlhqszleIOkb/nACuEC31Zha/ChOuZ2LIOTY8ksHRNtfElijWh9FGKGunbGStjZN5/9XA092HGsDk9DYgGAhicVUMOjrl1G9+MiNsUFj6eV2d4/p6f7y1oFg94wOXOewknf1/da1folm51rIjpn3J4S7mJNJ5n38YhiJVo3cvQdh8oNVQ0EscfVVH9BqkMAirz3Pfioi5ZXpp8URIJFvbNc1MuwvtbshkZ5JxnR68/Gd8PgYAcjHRSpDMYaHlpvsA0AhlrE8nvi2gvQ5jnwlXE+MWQinnmgyejZ+18ZvHPZ0OPviRaBXPuBCycN+v9pq7r02/lDFgXEJ/k2TpimFhr4pVExEtGALB/uR22UYJ8PfM7lDa81Z9KMTEfi59q6U5Z9nLRjgEcWvkPn1bPyP1QX3WqlvwkmqRX+MnQG/Xc1qpmjxBWzj4BsSiRXBO3hW4TsMBDx3HpvO696Zg720Q31SUaEdKKF6fcyd0IhBsHCePX/xQ7YxofH7LsJ9Bp+GSNhNiN1Z049c0DvHLUoxH1tMSQWmYVaSrjjRhZ5apzQJNOnttM6+uoxc0HpTKHzVMQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(36860700001)(7049001)(966005)(5660300002)(44832011)(36756003)(7636003)(8936002)(356005)(9786002)(508600001)(6666004)(7696005)(2616005)(26005)(4326008)(8676002)(70586007)(70206006)(316002)(82310400005)(47076005)(83380400001)(426003)(336012)(186003)(110136005)(2906002)(54906003)(1076003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 20:38:50.0942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28db127c-1969-4802-fe72-08da44d7e682
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5378
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
(cluster).

Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
---

Changes in v8:
  - Add 'items:' for sram property

Changes in v7:
  - Add minItems in sram property

Changes in v6:
  - Add maxItems to sram and memory-region property

Changes in v5:
- Add constraints of the possible values of xlnx,cluster-mode property
- fix description of power-domains property for r5 core
- Remove reg, address-cells and size-cells properties as it is not required
- Fix description of mboxes property
- Add description of each memory-region and remove old .txt binding link
  reference in the description

Changes in v4:
  - Add memory-region, mboxes and mbox-names properties in example

Changes in v3:
  - None

 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 130 ++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
 2 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
new file mode 100644
index 000000000000..adfe05ff157a
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/xlnx,r5f-rproc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx R5F processor subsystem
+
+maintainers:
+  - Ben Levinsky <ben.levinsky@xilinx.com>
+  - Tanmay Shah <tanmay.shah@xilinx.com>
+
+description: |
+  The Xilinx platforms include a pair of Cortex-R5F processors (RPU) for
+  real-time processing based on the Cortex-R5F processor core from ARM.
+  The Cortex-R5F processor implements the Arm v7-R architecture and includes a
+  floating-point unit that implements the Arm VFPv3 instruction set.
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-r5fss
+
+  xlnx,cluster-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    description: |
+      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
+      lock-step mode(Both RPU cores execute the same code in lock-step,
+      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
+      core 1 runs normally). The processor does not support dynamic configuration.
+      Switching between modes is only permitted immediately after a processor reset.
+      If set to  1 then lockstep mode and if 0 then split mode.
+      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
+
+patternProperties:
+  "^r5f-[a-f0-9]+$":
+    type: object
+    description: |
+      The RPU is located in the Low Power Domain of the Processor Subsystem.
+      Each processor includes separate L1 instruction and data caches and
+      tightly coupled memories (TCM). System memory is cacheable, but the TCM
+      memory space is non-cacheable.
+
+      Each RPU contains one 64KB memory and two 32KB memories that
+      are accessed via the TCM A and B port interfaces, for a total of 128KB
+      per processor. In lock-step mode, the processor has access to 256KB of
+      TCM memory.
+
+    properties:
+      compatible:
+        const: xlnx,zynqmp-r5f
+
+      power-domains:
+        description: RPU core PM domain specifier
+        maxItems: 1
+
+      mboxes:
+        minItems: 1
+        items:
+          - description: mailbox channel to send data to RPU
+          - description: mailbox channel to receive data from RPU
+
+      mbox-names:
+        minItems: 1
+        items:
+          - const: tx
+          - const: rx
+
+      sram:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        minItems: 1
+        maxItems: 8
+        items:
+          maxItems: 1
+        description: |
+          phandles to one or more reserved on-chip SRAM regions. Other than TCM,
+          the RPU can execute instructions and access data from, the OCM memory,
+          the main DDR memory, and other system memories.
+
+          The regions should be defined as child nodes of the respective SRAM
+          node, and should be defined as per the generic bindings in,
+          Documentation/devicetree/bindings/sram/sram.yaml
+
+      memory-region:
+        description: |
+          List of phandles to the reserved memory regions associated with the
+          remoteproc device. This is variable and describes the memories shared with
+          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
+          vrings, ...). This reserved memory region will be allocated on DDR memory.
+        minItems: 1
+        maxItems: 8
+        items:
+          - description: region used for RPU firmware image section
+          - description: vdev buffer
+          - description: vring0
+          - description: vring1
+        additionalItems: true
+
+    required:
+      - compatible
+      - power-domains
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    r5fss: r5fss {
+        compatible = "xlnx,zynqmp-r5fss";
+        xlnx,cluster-mode = <1>;
+
+        r5f-0 {
+            compatible = "xlnx,zynqmp-r5f";
+            power-domains = <&zynqmp_firmware 0x7>;
+            memory-region = <&rproc_0_fw_image>, <&rpu0vdev0buffer>, <&rpu0vdev0vring0>, <&rpu0vdev0vring1>;
+            mboxes = <&ipi_mailbox_rpu0 0>, <&ipi_mailbox_rpu0 1>;
+            mbox-names = "tx", "rx";
+        };
+
+        r5f-1 {
+            compatible = "xlnx,zynqmp-r5f";
+            power-domains = <&zynqmp_firmware 0x8>;
+            memory-region = <&rproc_1_fw_image>, <&rpu1vdev0buffer>, <&rpu1vdev0vring0>, <&rpu1vdev0vring1>;
+            mboxes = <&ipi_mailbox_rpu1 0>, <&ipi_mailbox_rpu1 1>;
+            mbox-names = "tx", "rx";
+        };
+    };
+...
diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
index 0d9a412fd5e0..618024cbb20d 100644
--- a/include/dt-bindings/power/xlnx-zynqmp-power.h
+++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
@@ -6,6 +6,12 @@
 #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
 #define _DT_BINDINGS_ZYNQMP_POWER_H
 
+#define		PD_RPU_0	7
+#define		PD_RPU_1	8
+#define		PD_R5_0_ATCM	15
+#define		PD_R5_0_BTCM	16
+#define		PD_R5_1_ATCM	17
+#define		PD_R5_1_BTCM	18
 #define		PD_USB_0	22
 #define		PD_USB_1	23
 #define		PD_TTC_0	24
-- 
2.25.1

