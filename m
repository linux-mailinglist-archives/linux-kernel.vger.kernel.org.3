Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79339539A22
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 01:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348715AbiEaXor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 19:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346319AbiEaXop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 19:44:45 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2052.outbound.protection.outlook.com [40.107.96.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170CC6EB27;
        Tue, 31 May 2022 16:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiuJlyJbWyfBqMuA/TSK9ooz7OazcYUvIGcnskbDEffJ+ZrDAlLtuW4NzsDs3ZPWVSVJS87EiO3FzupIUBnOdfWjvg2FtkcTHZh6tMLAkC/Mp4xOJDwzQ9WbLw+SAjC810y3QCWuEtnLc49/1/BfovNNbw4zjKvh4iVi2DtHfXXLuHFe5T1eFUaZ3l0ZrfDQnly//91MBP7dpv2Ylb61qc+iLBdwddXbHQE/CSEnLZv1iu+FFWxqOLR1Wp41BTD5GX9ZYK4SUoJGjJTdt0R0PpddZwmZ91LMiY52ATLofHvW7gcL4kI8uc4PlbTtkLnVtb4BFFpMcHlQzH3mdFRfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dj9oWKF1PPc7hnlH4NxNkGQTjTaA2k5IR8pGZl8oEzw=;
 b=jw9qlRJJbhaUk7Q7v65GIVen+ylIMghfvMgFnR/jGTd8NdHarN98kJsF6zuZ7A/q2EhsmeG4UDWuH/JIrKT0EP5F5SIUu2O3nEHT456VJFM3o+E/UWvQ4hQ6aUgkoEo7TtVnEFo0fVolOgCVLQqiAMzUEvWKtidaZVgS6lJBBpp3eryhr1Ciyi4J4F8YzWyuSI95qwR0mFznVpSUYfN41l4BqtfJv9ZXkb8p86sIneRwmt+hyPN1EGK7SpVpUycB89HhXp8g9clgJBHGfDhL5kHvEDJlDJkLOiiXy2t46PGPgX3Sh1+li5tzfu9rcBya5+IFwd6U3KoJHEsMyghsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.openampproject.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dj9oWKF1PPc7hnlH4NxNkGQTjTaA2k5IR8pGZl8oEzw=;
 b=oavpCC5XjY1C88csFgeWOFdemxXNz3/e+fbRQN8muWzxo39vjhzkhEn5+eiKqJhDEcmGHtxOV910ioni7PX+0BMeHu80tApm2Qj73qCf5uoo8TvgCmkNEh/4tDSRFAkKct52yCdS37JQxfGXEK2pHMVWB09onNEy2TcpVgrOq/w=
Received: from BN9PR03CA0400.namprd03.prod.outlook.com (2603:10b6:408:111::15)
 by MWHPR02MB2608.namprd02.prod.outlook.com (2603:10b6:300:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16; Tue, 31 May
 2022 23:44:41 +0000
Received: from BN1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::40) by BN9PR03CA0400.outlook.office365.com
 (2603:10b6:408:111::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 31 May 2022 23:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT041.mail.protection.outlook.com (10.13.2.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 31 May 2022 23:44:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 31 May 2022 16:44:39 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 31 May 2022 16:44:39 -0700
Envelope-to: openamp-system-reference@lists.openampproject.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=48904 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwBXT-0006jm-9J; Tue, 31 May 2022 16:44:39 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <openamp-system-reference@lists.openampproject.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 1/6] dt-bindings: remoteproc: Add Xilinx RPU subsystem bindings
Date:   Tue, 31 May 2022 16:43:05 -0700
Message-ID: <20220531234308.3317795-2-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
References: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c985137-7026-4af8-9c67-08da435f87f5
X-MS-TrafficTypeDiagnostic: MWHPR02MB2608:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB2608F7F149AB9D0349762CD7CADC9@MWHPR02MB2608.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3wSEgwJBjh5iFQlpWIAZ4pncQqLalBEp5MexgiwgjPMZngc+uosX6z60NTeaIBKtE2zmRwmmWQW0MVCVWuYwuyIkVbv+EHWAIAjpfvL/jqkYk6WPNSIXgGq+Tr8bF9WoJcKIuqpa349hO2E+4I0Cv0AL/gFP0WFDMuPETtPDYHOq5Bvo60YfI7bLhKuneG9JVAgEYLlaGk+3XeYeh/o76qc+jHCGM8i7qyM7OI9h6RwRmjlyRL2wcPoxSTwD6H5SrKP/O1ydr5ACYgEl0nxCr+rQTyK9LN3KSwIerWeMrnts/+NwhQMmBaIYi924ZIBTnV6G+iI7ncdJlC2Rudm3hDP2jRy+ChiW/9AbWn+kCdBF1b4U8BUP8zLrakqsPkcHBq5hOX4TbmT7YrnU8LCsCZoT7dJQyN4pAQ/49eH84ZaURDWdM7zwYUUKoG8gHjx6ZyrX4jKVEZQoBu9kVD6rlQMBqfKscPzN3tHZtDnJhP41qgcujm1eCEH1dBgOWwXJWs4bKmxsTt9giLt3EoSRTD13EFks1N0nu01WSksBAGQGLfY3yjjNQtRVja8x9EAEM2WMxc/FpO8w345g5KtnxS/EqawfZ1rrVIdjEouep8wjJcZA51EuPNwnQ9KkGep7Io2jz6egWsEAhos1UcY73T+xLiYvypv/3jeJBaNnLxdZlsytU3Zm8AkaVGB53PAzCpRmI59PceHYtwjCG+ulb1bKmZrcZPu2iEJ0wDyV8JKmuPa2Yl/42eESLIzLgWLzjTZzgSxPiGxqK2qFXkt0ZSdNGeZgazk5ed1BpKbtz5av/PHTVOXaxvz70zgK+PCm9aGNFzjQm3ppsjadjz1rA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(4326008)(5660300002)(7049001)(83380400001)(47076005)(26005)(9786002)(8676002)(82310400005)(2906002)(70206006)(7696005)(6666004)(44832011)(70586007)(508600001)(36756003)(966005)(316002)(356005)(7636003)(110136005)(426003)(336012)(40460700003)(36860700001)(54906003)(186003)(2616005)(1076003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 23:44:40.6914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c985137-7026-4af8-9c67-08da435f87f5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2608
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


 .../bindings/remoteproc/xlnx,r5f-rproc.yaml   | 129 ++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
new file mode 100644
index 000000000000..cbff1c201a89
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/xlnx,r5f-rproc.yaml
@@ -0,0 +1,129 @@
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
+        maxItems: 8
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

