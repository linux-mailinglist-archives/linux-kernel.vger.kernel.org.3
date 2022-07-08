Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FE956B003
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 03:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiGHBki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 21:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiGHBkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:40:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD5672EFE;
        Thu,  7 Jul 2022 18:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3jlxU6pKAxvWRhu2JrxH7ehlGq9KTTnwkdkJlLuIHmzIIRbCjPL/md4/U79a0iKwuuzjW/srzfLtxIUwY/pQmhnYJ0Zpd2zWV4KOHRAR1h4ICaNEw1I6tyoniRa6NCM7okFt58vufAy1SX2QneLPCcKk9gYCaQkj0l/ohBiFSNZgXJ1MSDKS/WVIZJuVyz45mNW6QF9q2DffffXirME/iiYM3XyFMY1eGAakY5E29N7JEfwKnIss9fjAqc+ez/nwiP6ag7WlCOGkWVd/2DzAkQsBfqnRZKpJdN2B4HaZnX+kLLBV+nWc6BPnq2DMZobgMvW3IUh/w/rmVXn/h7mgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVYfY/fNz5QiOQFAuTyusrvAQ8hyrm94KQW2poHiryU=;
 b=lHqqmHT1lQCvZwAYt7/VR86tMAqejQNM0uOZ6zp7fCcjYJcVF5XPP/VBzK+JAmDw5ZkCzNqoTAdonXSZ9aqmfdjCulkbBQeVpGp/RC5Xbf3j7c2spuzRsw2G/Esm4cDA4Q7Lk2Tei7WOVLuKIAnuBRnNTMWG/c1iCh8zvh/Z/lXUu0NfX0yDEikgsf5swfRrYVbqgopeulIeV/vm/D+Q7wr4agz4ni97ApQO08QrB1HQdRYKE4DD71ThzNZzTdAYeH8k9jjhCcSfVNI4eGl21hVgw2lYPGh9d38FxUlOzA65RBBrF6FAIo8Iqvow67q4WYsu+swXD23I4NB45Ig91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVYfY/fNz5QiOQFAuTyusrvAQ8hyrm94KQW2poHiryU=;
 b=S+zcKHeZZFSDszbUD+uYVpSIJKM1ZJlmGN/Usl5JdSmaU3rU6lFr+uOu6JHip/ReNvAGMhar9JHzLLqzopGaGPKlfnGg5CwB0bexBd1/pg5NsQf5gawl5mJDHzmXbf4rdhkyodMH+e9bxhoqdhXxmICE8YkR9cijS/Q+KB6WiGs=
Received: from MWHPR04CA0049.namprd04.prod.outlook.com (2603:10b6:300:6c::11)
 by DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 8 Jul
 2022 01:40:32 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::32) by MWHPR04CA0049.outlook.office365.com
 (2603:10b6:300:6c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Fri, 8 Jul 2022 01:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 01:40:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 20:40:30 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 18:40:29 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 7 Jul 2022 20:40:28 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>, <michal.simek@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v9 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
Date:   Thu, 7 Jul 2022 18:39:50 -0700
Message-ID: <20220708013955.2340449-2-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708013955.2340449-1-tanmay.shah@amd.com>
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a01035a-7fbd-4738-e541-08da6082d89f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3083:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KwMH7gV5mn5wQVddv65ssK7XZTsYLdoN9SlmBbEBrnaCfvKSaKOVFqLUMEYp?=
 =?us-ascii?Q?LXsFkoqOV7RwZXmdRdDJIUyAe+/s3wdd3VPPd9/+3kfRYnHBYNsus923w0pm?=
 =?us-ascii?Q?x6qIxXTC463FDh03RBlTObFQOIOADh1MEpooMwrh3a/BSXj5c8HkRpmUiw6r?=
 =?us-ascii?Q?SCCMcQQIT63E3MUdiKRA+jdTO7nE5O4VlErxYVCzljoByOpeahOvYc9tXDwm?=
 =?us-ascii?Q?CV5cHipM5QgkArP7EJU6AhTFyOsj3nBSOXJlEEppbd75w3EAC6d/9hWZ47YM?=
 =?us-ascii?Q?JGTXj49sUjvNJJEDI6DWr0HMh1oH31NIpAUhvJ8FP+tDPRIPu2zlr6Ydn1kb?=
 =?us-ascii?Q?sAb1sBKTxzU0C0AACV7KPAlFDpc4CNGLWYhiILAjDdDYwTyui+XBxbM5Rl3t?=
 =?us-ascii?Q?795GmzieUPitX7P9wgr+yTKkA1CcOpMVoN9kOYx2Q7Bn4MutvK0TPGv8EXD7?=
 =?us-ascii?Q?vAEnf72XXXkkoZnTlcvZPFlKAUVuZhGNS1NMSMH+0lo8fgDKxsumA418Nq3/?=
 =?us-ascii?Q?PSUqcEzf5pfLUBPnz4E+bqR5kR7urf0Yha3OBdgtJdiBKYwDanAr+yUIc4QY?=
 =?us-ascii?Q?qDgVEkrTB/769FtAX/o7ErjqmuVkGldRl6aOR2J5NrTUyWZwvG6jKsmZV9zS?=
 =?us-ascii?Q?6usuOJLPOLy7n9J29QGrSmz1SCKilf4Yb8h9BI51ACAmI8pph9B+C7wbl/yn?=
 =?us-ascii?Q?gaOBW6Hw+4uqwkeZQhB34l+pcStCY6LgSGBi0UoEYvl+jpeipVCYPmimfDRu?=
 =?us-ascii?Q?rlKhwVl1HPl45ti6cyi0Gj4ifAjtFdWUqKFI+qzvPjA4Lo3tvPBDQeIQWKaS?=
 =?us-ascii?Q?Np8Q9P080EVdv1jxrNO3SN3PnSLx6QMG2hg9FazHB5PzHPfu0TyG7N6DACwJ?=
 =?us-ascii?Q?VyCYb03TkMrSYlzp2eNd/0sbIofQazHX2hOCzJ0LA+7HIWS5LAIzxynTnPkL?=
 =?us-ascii?Q?m/zDAehTcS5Cy8dQMKnF+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(47076005)(82310400005)(2616005)(316002)(966005)(426003)(1076003)(54906003)(110136005)(81166007)(6636002)(336012)(186003)(36756003)(70586007)(8676002)(4326008)(70206006)(40460700003)(26005)(8936002)(44832011)(86362001)(2906002)(82740400003)(5660300002)(356005)(478600001)(36860700001)(6666004)(40480700001)(41300700001)(34020700004)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 01:40:32.0844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a01035a-7fbd-4738-e541-08da6082d89f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tanmay Shah <tanmay.shah@xilinx.com>

Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
(cluster).

Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---

Changes in v9:
  - remove power-domains property description
  - fix nitpicks in description of other properties

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

 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 135 ++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
 2 files changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
new file mode 100644
index 000000000000..56b4dd1d5088
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
@@ -0,0 +1,135 @@
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
+      The RPU MPCore can operate in split mode (Dual-processor performance), Safety
+      lock-step mode(Both RPU cores execute the same code in lock-step,
+      clock-for-clock) or Single CPU mode (RPU core 0 is held in reset while
+      core 1 runs normally). The processor does not support dynamic configuration.
+      Switching between modes is only permitted immediately after a processor reset.
+      If set to  1 then lockstep mode and if 0 then split mode.
+      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
+      In summary,
+      0: split mode
+      1: lockstep mode (default)
+      2: single cpu mode
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
+          the RPU can execute instructions and access data from the OCM memory,
+          the main DDR memory, and other system memories.
+
+          The regions should be defined as child nodes of the respective SRAM
+          node, and should be defined as per the generic bindings in
+          Documentation/devicetree/bindings/sram/sram.yaml
+
+      memory-region:
+        description: |
+          List of phandles to the reserved memory regions associated with the
+          remoteproc device. This is variable and describes the memories shared with
+          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
+          vrings, ...). This reserved memory region will be allocated in DDR memory.
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

