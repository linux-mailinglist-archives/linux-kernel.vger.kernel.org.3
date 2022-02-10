Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AE24B0C60
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240951AbiBJL25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:28:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240888AbiBJL2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:28:47 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1855B1001;
        Thu, 10 Feb 2022 03:28:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFrfyhgYzkhj2eG0ET9G1Yxezeh3VKVCmFTr3bi/shk07yGhAnhHMox/mFkV79PtgzaZPgbpTBowpTkZVxQiuwpvEYwXvV+iZe06NFOI3GlXrPZ8UguE6w95BJiCi1xcw8EHhqxRyYCsDsO3lPkxU7bz6W6Q/CLtBI8X0fDPipkRuvhxQhUB2/wpWFymexlYua2Cvgn27vlePKgm27Cnj+dqikBrqMQ2oG1s4XtOj4PYSHzhdA/FrVZqy8XazWh8LQAWJSRZCVI6xHq3l7PGyVjfMe2L/3Wmaxvw3HF8KLWZouZHPFKFzvU19gAqqXbTZaBlSDL0NAWyAyfAQ4JRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHYBd1ohOSTwHYwTxWpR/Fls7MQgphgufdOkHf9CNgA=;
 b=X5h6WJegk5eXbL427WcP6yUMlM/nlq+wAfLG3uiNMltv2ZgpX88RRmXyYZcpuDB4i/LEw5uSEvebMMlazpfFMbSEmDerBflqQm+lK1Erqvdsex+IPJF4pcL502oFYTWUT8hXQHnn7qL3epQYSajHBKtns1rQbSHbTXUizP7EL8rg5VyazZnsCsLFXaWrdQRYN/U0gVYw0YOIiMBToIN8Du2G00dGEAkQ3wNM78GtDQVrrlBw12nVS59axwJQocNQIKh5gCYIO5nkQ/ya2E+v0zxzR/AnYzRq6VXnjkNilDY0pgru+9gAR9xZXUcnclzf8YwH0195gZ/SgZVuWgnpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHYBd1ohOSTwHYwTxWpR/Fls7MQgphgufdOkHf9CNgA=;
 b=eweqVdBDWqWmBZJCQkcgswCPbL5zu21svikqmM5vIFgAOHxfPUTpJt0sdFJwCSCL+D6vWe8uJwkam8wwBtbu/lQ35EvkvNDQs4U7E61gCWXN9Y9/OpPYW8k1xjxlcJuPceSeIczX2/NQgZl0sCF2gjjWgOT3xRSAX+YhuXM/Vmg=
Received: from DM5PR10CA0018.namprd10.prod.outlook.com (2603:10b6:4:2::28) by
 MN2PR02MB7037.namprd02.prod.outlook.com (2603:10b6:208:206::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Thu, 10 Feb
 2022 11:28:47 +0000
Received: from DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::5e) by DM5PR10CA0018.outlook.office365.com
 (2603:10b6:4:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Thu, 10 Feb 2022 11:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT061.mail.protection.outlook.com (10.13.4.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 11:28:46 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 10 Feb 2022 03:28:44 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 10 Feb 2022 03:28:44 -0800
Envelope-to: bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 laurent.pinchart@ideasonboard.com,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=48874 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nI7cx-0000UP-UH; Thu, 10 Feb 2022 03:28:43 -0800
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <michal.simek@xilinx.com>
CC:     <laurent.pinchart@ideasonboard.com>, <ben.levinsky@xilinx.com>,
        <bill.mills@linaro.org>, <sergei.korneichuk@xilinx.com>,
        <tanmay.shah@xilinx.com>, <arun.balaji.kannan@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
Date:   Thu, 10 Feb 2022 03:28:19 -0800
Message-ID: <20220210112824.2084724-2-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
References: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d2aab02-46e6-4ade-68ad-08d9ec8880b0
X-MS-TrafficTypeDiagnostic: MN2PR02MB7037:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB70377F5A73518650125DA6D7CA2F9@MN2PR02MB7037.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEC5F5F6h2RPF47a72luzyA+IiyEEgLFimTONLz/neQO6rsy2e2jAJ91PWHKDpm61diOTUNNrOJuS7rqK9ZxvZECHdzKV3gYeEtdXs1dUxV7AHaO8tWqXQ6HHYysbrLKMdj89eH6CXtPzK75gTtCiQqC1o8PDoggDTmmtA2xJFlQIKV1xjXWgABw8V1rYtzC9ebuwNIByMlGv5WU+CT8mgIVZ/daipv0I2wxkNXOEGmusc2XgrBTawVG0eUxftsKRkQ9J4WoZNWZN1u48MZmPLr1Aql35b86m4E+BrVLoVtY4TCa6ayI0tsgiTQcQ8ez7omWGdfYe+hta8Y/TXyhoNUB/yEB7EPxTwAED5iTxN/JNWt4kws0eANyLSdUhwFaVza28uz2XPAu7xnCG9dV9YCB8qTBS1oz+EPIE53IbmIjzRURunVM3PAfhpaa+hiY0oGbswAbomT1Kc7cGzzC4U4pb5tfvJjNWnFJx+nEpzXTrIFtM1djA3ZAfOD7DTOF6l1ljc7fGLCSW/9c3KsXjsmNRvk5qIh7BX0K7fcFoFCTWCJ5O+NOqhnc98W/8VVT/PGDgz4He8uX2eRrMtdVPLgj8umYsSOgl/P5R6GfZ3I1jOMjnSYfxcNEcJ3qMiP+Ym8NoEuWO6bsq1OvmVQ3pS9RiwbysQbIdHOXeiGnsMBIUIx1keMh76SM5Q5m3qErb9hyDm6BUwPrAnCw0Qe17A8kv9nYBa6zunf4RB9dbQZsG2vL/6r1LPDK101faCzTTnGiFMQa5kxOVfh8wvfIydCfsSsKVSedDKXy8vSxVwo05re1puRI40evNyiB7KB9b2vfHij/lIE3cTdGS316zQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(83380400001)(70586007)(54906003)(6636002)(7696005)(44832011)(508600001)(36756003)(110136005)(4326008)(8936002)(8676002)(70206006)(2616005)(26005)(316002)(186003)(1076003)(7636003)(2906002)(426003)(966005)(36860700001)(40460700003)(5660300002)(6666004)(9786002)(82310400004)(336012)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 11:28:46.7450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2aab02-46e6-4ade-68ad-08d9ec8880b0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7037
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

Changes in v3:
  - None

 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 139 ++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
 2 files changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
new file mode 100644
index 000000000000..d43f0b16ad7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
@@ -0,0 +1,139 @@
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
+        };
+
+        r5f-1 {
+            compatible = "xlnx,zynqmp-r5f";
+            power-domains = <&zynqmp_firmware 0x8>;
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

