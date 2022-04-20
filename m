Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0226B5082BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376478AbiDTHx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376453AbiDTHxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:53:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BE23BBFC;
        Wed, 20 Apr 2022 00:50:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyXBFHTQy08bYpEnaFyYE3DU6B91OU4W8OwMAeQJbtsTTwSOvLcfITOSrbVQ9anz+2tABBVAaT9IjMn5CnJyqpSq+7/LLKYWEXEVUHaz04Fa+QYvw/VDF/bSmiT+72+CEyEn1Fj520WPSVi+mdu108ZtZupwDpVZasWQV6kIgjKJupaAqMIYIldzPNNHuaEgBp1G7SGI34+8ttoAzG6sMmH6j1n0fiYa/u0Rv+Mbj6r2By+EeyqJOGvai91jum2OVmTQVpqQ726Hd5xy43faNb0kxpsodCB9g8sN3nXQ91VqKEW2CK0pn3qvG4+V0TMYF/unOaIQTeOu0m/eQa6aEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxLOaX1j3vgTEtukDemBtSe45at8fc5odTnSL2nRAyU=;
 b=Dge2BkkrWWEaQIbYMIRaPFpignuqBkV+wkZ5yGsDP1L8Aw0HmaY8jIY3BAi0mx5Nzj0rGGhxywunk3LGVeDAlgA43jIGlu/PwIiIc1wgdQM+G9H0BbJyzGdjoffUA0J0/jQFfJp76/SkBSTYolIQI22+4Z0xhtBFLA/4rb+1+zvFM8BlJ1J4glQXYVqAlyqPBUMMNIG1SHj3ojLViwxYPELHNRzByTUweWVDPUuhv7bfbHuy0pQI1H9o2A3SovMBn92dG3O1n6GWIsh0B2ylGuK3ClYNdKSvU2PJoZc1os9wD4nw8/RKEl/52UCDKzFkN+qdcLxznlVK2PzN1C47dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxLOaX1j3vgTEtukDemBtSe45at8fc5odTnSL2nRAyU=;
 b=QvupDXGHIzLX2ts0cQ2osT99illPmLQgDLN2Qu4N3zQMqmT5mep8a7HFnn3NYvxh8I5aqxv5cRq9NS76W1K3XYnZm06VTrrYnloZC+IapHTnQBl0omB1lSwsD1jNK2oNailLCBRDhElKhXFJKZGpkUrCi7P7wds14ngwd7DLMpw=
Received: from SA9PR13CA0009.namprd13.prod.outlook.com (2603:10b6:806:21::14)
 by DM5PR02MB2811.namprd02.prod.outlook.com (2603:10b6:3:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 07:50:36 +0000
Received: from SN1NAM02FT0055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:21:cafe::35) by SA9PR13CA0009.outlook.office365.com
 (2603:10b6:806:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.10 via Frontend
 Transport; Wed, 20 Apr 2022 07:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0055.mail.protection.outlook.com (10.97.5.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 07:50:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Apr 2022 00:50:13 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Apr 2022 00:50:13 -0700
Envelope-to: mathieu.poirier@linaro.org,
 bjorn.andersson@linaro.org,
 robh+dt@kernel.org,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=51254 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nh55X-0001h6-TO; Wed, 20 Apr 2022 00:49:23 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <mathieu.poirier@linaro.org>, <bjorn.andersson@linaro.org>
CC:     <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <bill.mills@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
Date:   Wed, 20 Apr 2022 00:44:47 -0700
Message-ID: <20220420074450.2034092-2-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420074450.2034092-1-tanmay.shah@xilinx.com>
References: <20220420074450.2034092-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fca8f5b3-6b18-4501-980c-08da22a2748d
X-MS-TrafficTypeDiagnostic: DM5PR02MB2811:EE_
X-Microsoft-Antispam-PRVS: <DM5PR02MB2811DAB2FE485FA1119CF075CAF59@DM5PR02MB2811.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIRXwcFTtqaGA26uhVdCWyTxNeBCpaQr79O1LBbulhkNoCK64CfOzR96BbJ9BbKPQ8s6iicXq3rjUd5CNcsoe11poRJqSBkJp1ckE0Vk8Ir02R388La+Mbcb6oOj1iWJnfVBP+9eC+6pI/M/aIDEu4a1S6NHrEdlEwwPFiKOhjFj/K8M23fkLTP7dvUHDFNEBu+ycIx2dYy4G26404ldnKe+6RusV/f6g9YTtqf6XQnsNvnuUWJwsIpP3HA6FQ4lPsMmdShQsvmz1j6YmoPBdwwJIreE+hvA1ZJ6ro/iPJGJC5pHmvBAd8MNg45trJtEeyRhguKRzCwYDE5KgnfyQ1ELsdl+eBiQccMij2AdW3gnC4nxSM/LnwWv6i4zDimFSGmgYghHXAJomvI+Lqxa/1k6jc7bdOwJWUFTEW0HbMWZd46b02XA5Ujmt86DE9Dq00RC7s4FDBwXeYcB0vUQprElHtBl3d/x/eG2dempLAEZ7D/SAbl/vIdrhvCZ/uFgjz4ZpEKz7ucW+SmbDN77xK8fq44V06aDQODN4999OmNJefHQCCZ80FzGBjtVl6eomcD5jnGACXoIL314hRDeXD1dhSCWFiUddjC3Q1xqTTHXHG2sSQsI24bL4HSNlyPYBUuRYEJBjRJuJ2oqQ4cuMlo4uRmOu3TmMis59odBtT280GkwEiaDROf1qBwQFctzbyLPKnYujFL1oi8gmvVzqA4mgOW0YLxKUzj891Tdgcog/OPh6sjNP1ja9ycI8bUzp2WkEYPJigI/+HRRxTmBAbKi2LFmHhfONY1otCIbIoYZmt7AvXAaA8ZK3BMWdKNhhpDGIHzu4WKRuYmsM72/hg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(7696005)(2906002)(8676002)(4326008)(82310400005)(966005)(508600001)(7636003)(356005)(5660300002)(6666004)(1076003)(8936002)(426003)(83380400001)(26005)(40460700003)(186003)(316002)(47076005)(70586007)(336012)(44832011)(2616005)(9786002)(70206006)(110136005)(54906003)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 07:50:36.1048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca8f5b3-6b18-4501-980c-08da22a2748d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2811
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem (cluster).

Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
---

Changes in v4:
  - Add memory-region, mboxes and mbox-names properties in example

Changes in v3:
  - None

 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 145 ++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
 2 files changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
new file mode 100644
index 000000000000..c1f99e17b4b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
@@ -0,0 +1,145 @@
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
+    description: |
+      The RPU MPCore can operate in split mode(Dual-processor performance), Safety
+      lock-step mode(Both RPU cores execute the same code in lock-step,
+      clock-for-clock) or Single CPU mode (RPU core 0 can be held in reset while
+      core 1 runs normally). The processor does not support dynamic configuration.
+      Switching between modes is only permitted immediately after a processor reset.
+      If set to  1 then lockstep mode and if 0 then split mode.
+      If set to  2 then single CPU mode. When not defined, default will be lockstep mode.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  reg:
+    items:
+      - description: RPU subsystem status and control registers
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
+        description: |
+          phandle to a PM domain provider node and an args specifier containing
+          the r5f0 and r5f1 node id value.
+
+      reg:
+        items:
+          - description: RPU0 and RPU1 control and status registers
+
+      mboxes:
+        items:
+          - description: |
+              Bi-directional channel to send data to RPU and receive ack from RPU.
+              Request and response message buffers are available and each buffer is 32 bytes.
+          - description: |
+              Bi-directional channel to receive data from RPU and send ack from RPU.
+              Request and response message buffers are available and each buffer is 32 bytes.
+        minItems: 1
+
+      mbox-names:
+        items:
+          - const: tx
+          - const: rx
+        minItems: 1
+
+      sram:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        minItems: 1
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
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        description: |
+          List of phandles to the reserved memory regions associated with the
+          remoteproc device. This is variable and describes the memories shared with
+          the remote processor (e.g. remoteproc firmware and carveouts, rpmsg
+          vrings, ...). This reserved memory region will be allocated on DDR memory.
+          See Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
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
+    r5fss: r5fss@ff9a0000 {
+        compatible = "xlnx,zynqmp-r5fss";
+        xlnx,cluster-mode = <1>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0xff9a0000 0x228>;
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

