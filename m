Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67AF513A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350455AbiD1QyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350376AbiD1Qxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:53:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C784F4505F;
        Thu, 28 Apr 2022 09:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzC1LavcGerU7o8A78K9NGmiQIBVjUH6JiETKjl/EVwr3eDveqZGjPNQbCOyXag2EGmWv4VLlXtQG/AegzK/6cb2XxTWmbwyXFPDqYfagsu39wNZs9se3KQQvp+sUqogWsvM7si/0M1GFwBJ8k2LdY1Mm0qGjP/yGC2b8GFCfg/grYhobzpkSS+tr3pMnSLO6tHgbgapsewYKVmEEDk09eaFdVutqDW7PKhJ7lVfEVpkwJEvPgetiTdBOSD7PT8p7idS6/AolK1gHy/2AKg6iH8xW8akZL7/A/Jh5Sj0R2dhpyrfw8t7VdACz3i8K1SAJFiErbYYQA1YcQsMmMUDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWBqL8RkSkz6TRdwC5CjpcFGATujoZff33d8nD3mCLU=;
 b=anhsCCWnNrCw20swWA1FWXciWAQyCqtV0sdJaOxJL2N/gUwcTiU9vSgxWiWZMNMmSZfm1b+BLUdF071qMQL1n8U2Q2Mzu4VRfID/YdnseApV234jyVMpCXUNAvuNf0zWtEYidIofKN83TwdNCgyMLdcrUEB3FqDc8gfBrFGCb0bPR2lOCIfIRyjGQFqW8jRYWuzy83/o+bKDvDlsK14jZNcNPqSElmI6lXbJTiXrfhbddjlYj7FlLuOxTdAVLHeQMUI761N8AS/XT21J/2odeQdU3qatdjvHA13SUAO7ggfCjKtaQrcbm3CjnVN1//EnhuuRCZaReh/gv8d7aCLVhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWBqL8RkSkz6TRdwC5CjpcFGATujoZff33d8nD3mCLU=;
 b=BAKsVWI3YRML67O0iFlsvYL4QQmW1J3FYHUvoUI2VRRkZpNb44kBBnBAkiAkVhe3jhSocbCZbauKuP7CTg7G0bBFqrRF3i+a0VX684IbhCy2oCufCduh6agIwXITimrLZ3YrRSaCQ5SNHDFa2JdhZTQoH6FF1mu4FHw3YQnWVQM=
Received: from SA9PR13CA0140.namprd13.prod.outlook.com (2603:10b6:806:27::25)
 by BL0PR02MB4578.namprd02.prod.outlook.com (2603:10b6:208:49::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 16:50:11 +0000
Received: from SN1NAM02FT0014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:27:cafe::dd) by SA9PR13CA0140.outlook.office365.com
 (2603:10b6:806:27::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.6 via Frontend
 Transport; Thu, 28 Apr 2022 16:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0014.mail.protection.outlook.com (10.97.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 16:50:10 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 28 Apr 2022 09:50:08 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 28 Apr 2022 09:50:08 -0700
Envelope-to: git@xilinx.com,
 devicetree@vger.kernel.org,
 jassisinghbrar@gmail.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.39] (port=56568 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nk7LE-000Fww-AA; Thu, 28 Apr 2022 09:50:08 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <devicetree@vger.kernel.org>
CC:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <git@xilinx.com>, <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v4] dt-bindings: mailbox: zynqmp_ipi: convert to yaml
Date:   Thu, 28 Apr 2022 22:20:04 +0530
Message-ID: <20220428165004.3212654-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aa62436-9176-448b-a67a-08da293728b9
X-MS-TrafficTypeDiagnostic: BL0PR02MB4578:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB457874BC6317AF8135AD29FDAAFD9@BL0PR02MB4578.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njoa+6e9+vnksaUnjTasIOpAxOCn7yfIbeNQS9LTvPH7EznUc1MpDN219GwWRH3Xn1h8sNYMlpbUxX7H4U6LIya6zRv6K/FRIvjJM05tQ2eSUGGVO/yTQEIZ1NpTnJL4f4DYuYFp29hkewOl0smOTXNuP+MFsmFdlSyNc/X5JEOT34TejlfIvNZqvz2NYcyjG1OGEXfWTR0i76KCGv/l3Vnk1VMjBeF+ty8E7cYc0EVMkXznD3rbPiMLLof9kiW0gsBARJMzybHU0nejeSag1ZgRoWxYm2I4rn7Y8ZfUEJHY7IKWai20kvSWuWwmjorIpYghYG1EVgzbbaaVP6yNNg7CNLEs8hqBN8TWKoFi4MsrIzXxcHccHaIT9xMJmpRiFFR42Gdxej+zaLPHTd5xojKcVR7ZLJgN2uNMjdjcicBbxe60CATf919Vm/yz+XOtjfK4M36vnU1DxJ95iN/9yAQD5rCG7XKwFf+bwVcDj3y/yYERKCjT22Dgoob/IDwH0TjT+mCdRiBK+dh8Ur+q+nEJHoL5a4kniQlaaAKvYAkO7W+0BAtAK+OWZa1uo4jR2FzYLCYo9ajrCA8zaAwT9J2K/BccFS/THqLcvRKG8tX72PrMQHdTW/p0z5i2VlFVrWs9kHEFhLFvHxFvnR+CVrTqoxoER5nr6SPx/QnkYKIizvHGCn87c29qE51veVjKl9VYd9hhqwy4+hMfoVKJCXhQM6Rq6nFEXyomHc3KWawpI48t/UwrVmgx9QDIDAsymwNaIEJN6J+288qZ27livrJzjCxOYDLQZZ+8j923La+y06v2ardLlcWDbYhBke0YkKP9oJOAPW81PVleUljYQA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(9786002)(5660300002)(8936002)(7636003)(1076003)(40460700003)(6666004)(2906002)(44832011)(36756003)(356005)(508600001)(15650500001)(83380400001)(8676002)(7696005)(70586007)(316002)(47076005)(426003)(70206006)(336012)(186003)(4326008)(36860700001)(82310400005)(54906003)(2616005)(6916009)(107886003)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 16:50:10.8760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa62436-9176-448b-a67a-08da293728b9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4578
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ipi doc to yaml.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
 Fix the warnings reported by Rob
v3:
 Run dtbs_check
v4:
 fix the formatting
 fix the ranges
 
 .../mailbox/xlnx,zynqmp-ipi-mailbox.txt       | 127 ----------------
 .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      | 142 ++++++++++++++++++
 2 files changed, 142 insertions(+), 127 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
deleted file mode 100644
index ad76edccf881..000000000000
--- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt
+++ /dev/null
@@ -1,127 +0,0 @@
-Xilinx IPI Mailbox Controller
-========================================
-
-The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
-messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
-agent owns registers used for notification and buffers for message.
-
-               +-------------------------------------+
-               | Xilinx ZynqMP IPI Controller        |
-               +-------------------------------------+
-    +--------------------------------------------------+
-ATF                    |                     |
-                       |                     |
-                       |                     |
-    +--------------------------+             |
-                       |                     |
-                       |                     |
-    +--------------------------------------------------+
-            +------------------------------------------+
-            |  +----------------+   +----------------+ |
-Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
-            |  |  Registers     |   |                | |
-            |  |                |   |                | |
-            |  +----------------+   +----------------+ |
-            |                                          |
-            | Xilinx IPI Agent Block                   |
-            +------------------------------------------+
-
-
-Controller Device Node:
-===========================
-Required properties:
---------------------
-IPI agent node:
-- compatible:		Shall be: "xlnx,zynqmp-ipi-mailbox"
-- interrupt-parent:	Phandle for the interrupt controller
-- interrupts:		Interrupt information corresponding to the
-			interrupt-names property.
-- xlnx,ipi-id:		local Xilinx IPI agent ID
-- #address-cells:	number of address cells of internal IPI mailbox nodes
-- #size-cells:		number of size cells of internal IPI mailbox nodes
-
-Internal IPI mailbox node:
-- reg:			IPI buffers address ranges
-- reg-names:		Names of the reg resources. It should have:
-			* local_request_region
-			  - IPI request msg buffer written by local and read
-			    by remote
-			* local_response_region
-			  - IPI response msg buffer written by local and read
-			    by remote
-			* remote_request_region
-			  - IPI request msg buffer written by remote and read
-			    by local
-			* remote_response_region
-			  - IPI response msg buffer written by remote and read
-			    by local
-- #mbox-cells:		Shall be 1. It contains:
-			* tx(0) or rx(1) channel
-- xlnx,ipi-id:		remote Xilinx IPI agent ID of which the mailbox is
-			connected to.
-
-Optional properties:
---------------------
-- method:              The method of accessing the IPI agent registers.
-                       Permitted values are: "smc" and "hvc". Default is
-                       "smc".
-
-Client Device Node:
-===========================
-Required properties:
---------------------
-- mboxes:		Standard property to specify a mailbox
-			(See ./mailbox.txt)
-- mbox-names:		List of identifier  strings for each mailbox
-			channel.
-
-Example:
-===========================
-	zynqmp_ipi {
-		compatible = "xlnx,zynqmp-ipi-mailbox";
-		interrupt-parent = <&gic>;
-		interrupts = <0 29 4>;
-		xlnx,ipi-id = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		/* APU<->RPU0 IPI mailbox controller */
-		ipi_mailbox_rpu0: mailbox@ff990400 {
-			reg = <0xff990400 0x20>,
-			      <0xff990420 0x20>,
-			      <0xff990080 0x20>,
-			      <0xff9900a0 0x20>;
-			reg-names = "local_request_region",
-				    "local_response_region",
-				    "remote_request_region",
-				    "remote_response_region";
-			#mbox-cells = <1>;
-			xlnx,ipi-id = <1>;
-		};
-		/* APU<->RPU1 IPI mailbox controller */
-		ipi_mailbox_rpu1: mailbox@ff990440 {
-			reg = <0xff990440 0x20>,
-			      <0xff990460 0x20>,
-			      <0xff990280 0x20>,
-			      <0xff9902a0 0x20>;
-			reg-names = "local_request_region",
-				    "local_response_region",
-				    "remote_request_region",
-				    "remote_response_region";
-			#mbox-cells = <1>;
-			xlnx,ipi-id = <2>;
-		};
-	};
-	rpu0 {
-		...
-		mboxes = <&ipi_mailbox_rpu0 0>,
-			 <&ipi_mailbox_rpu0 1>;
-		mbox-names = "tx", "rx";
-	};
-	rpu1 {
-		...
-		mboxes = <&ipi_mailbox_rpu1 0>,
-			 <&ipi_mailbox_rpu1 1>;
-		mbox-names = "tx", "rx";
-	};
diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
new file mode 100644
index 000000000000..46e91828b6b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mailbox/xlnx,zynqmp-ipi-mailbox.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Xilinx IPI(Inter Processor Interrupt) mailbox controller
+
+description: |
+  The Xilinx IPI(Inter Processor Interrupt) mailbox controller is to manage
+  messaging between two Xilinx Zynq UltraScale+ MPSoC IPI agents. Each IPI
+  agent owns registers used for notification and buffers for message.
+
+               +-------------------------------------+
+               | Xilinx ZynqMP IPI Controller        |
+               +-------------------------------------+
+    +--------------------------------------------------+
+  TF-A                   |                     |
+                         |                     |
+                         |                     |
+    +--------------------------+               |
+                         |                     |
+                         |                     |
+    +--------------------------------------------------+
+              +------------------------------------------+
+              |  +----------------+   +----------------+ |
+  Hardware    |  |  IPI Agent     |   |  IPI Buffers   | |
+              |  |  Registers     |   |                | |
+              |  |                |   |                | |
+              |  +----------------+   +----------------+ |
+              |                                          |
+              | Xilinx IPI Agent Block                   |
+              +------------------------------------------+
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
+
+properties:
+  compatible:
+    const: xlnx,zynqmp-ipi-mailbox
+
+  method:
+    description: |
+                 The method of calling the PM-API firmware layer.
+                 Permitted values are.
+                 - "smc" : SMC #0, following the SMCCC
+                 - "hvc" : HVC #0, following the SMCCC
+
+    $ref: /schemas/types.yaml#/definitions/string-array
+    enum:
+      - smc
+      - hvc
+    default: smc
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+  xlnx,ipi-id:
+    description: |
+      Remote Xilinx IPI agent ID of which the mailbox is connected to.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  interrupts:
+    maxItems: 1
+
+  ranges: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts
+  - '#address-cells'
+  - '#size-cells'
+
+patternProperties:
+  '^mailbox@[0-9a-f]+$':
+    description: Internal ipi mailbox node
+    type: object  # DT nodes are json objects
+    properties:
+      xlnx,ipi-id:
+        description:
+          Remote Xilinx IPI agent ID of which the mailbox is connected to.
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      "#mbox-cells":
+        const: 1
+        description:
+          It contains  tx(0) or rx(1) channel IPI id number.
+
+      reg:
+        maxItems: 4
+
+      reg-names:
+        items:
+          - const: local_request_region
+          - const: local_response_region
+          - const: remote_request_region
+          - const: remote_response_region
+
+
+    required:
+      - reg
+      - "#mbox-cells"
+
+examples:
+  - |
+    amba {
+      #address-cells = <0x2>;
+      #size-cells = <0x2>;
+      zynqmp_ipi {
+        compatible = "xlnx,zynqmp-ipi-mailbox";
+        interrupts = <0 29 4>;
+        xlnx,ipi-id = <0>;
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        ipi_mailbox_rpu0: mailbox@ff9905c0 {
+          reg = <0x0 0xff9905c0 0x0 0x20>,
+                <0x0 0xff9905e0 0x0 0x20>,
+                <0x0 0xff990e80 0x0 0x20>,
+                <0x0 0xff990ea0 0x0 0x20>;
+          reg-names = "local_request_region",
+                "local_response_region",
+                "remote_request_region",
+                "remote_response_region";
+          #mbox-cells = <1>;
+          xlnx,ipi-id = <4>;
+        };
+      };
+    };
+
+    rpu0 {
+      mboxes = <&ipi_mailbox_rpu0 0>,
+               <&ipi_mailbox_rpu0 1>;
+      mbox-names = "tx", "rx";
+    };
+...
-- 
2.25.1

