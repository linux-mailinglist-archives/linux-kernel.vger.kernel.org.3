Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871C44BB9BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiBRM6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:58:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbiBRM6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:58:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A103537009;
        Fri, 18 Feb 2022 04:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTRqiwlGYfmWoqcLwhL7X3+ItCVRwSg9MW5SL3BQTMOfEc42I/iWjvWBm2nnIMuCHZ1B4H3v8BXxdIq0mXJkPAZPpuUWkUhDFPxNFMMzF1e0ynkqodQtq7X7kNk4FjXqDG0GKe8xx+nXpyV7jnaIRP6vEfvlccMKwOtbaoiokKEIDqslC5Nrw03+8rUMDMm9ny6N2RSB2ziUqmQTkOj/Awgcw7ZVUqUtrcpaexI4xlOcR3RzqV0Ka5Obo70fBfCPCSlUEj8qnBv7wS9SYdi4EkA15K4A85mex+4bok2ycjV7/rKxtJiSj37y0AOcSvddMigUJEt9pYofgl/Q4OcY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbqwTYxjrvpdBZwAhZT7dK7wieUHns5FO0L2eV020s8=;
 b=gYBgpeFsicYNr9cJcRh1pf2MFzPXE4syxOlwyeAhZpC0Pmfg4kF49Rqzd3nHx6mKlnQtQwxenV3LP9HUAcUQd/ycbQCFslL4QdYDohPMonMx9FoUip0rBErk9zTF8Lj/QvB2bCBeiDtvqJVGSspfFYi+aOWS5ZNEJuh93lg2CzhFtTcVoItrI5jxvithOyrmnfjtfSTg6TGXxWMEDZZS6h0KLSJICa/srZuKdVvywhc5XJQSgBVFNmt69SAzKAHZ1MeOy4ozOwx8dkcG1wzhwyp3hpYZrTfn4+sAk23uF4GoBDMgs+wGOFeagtnqaeUXIfSeUfYdBEt3JqJ8I69P4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbqwTYxjrvpdBZwAhZT7dK7wieUHns5FO0L2eV020s8=;
 b=PHAi63OPdYoP803fKgXMNW/o7QXH4iue+aHTKSeCFLLXNIhN6YclHouoq8+EWGAzcoaT+eMnAKluwMFwBvmze1M+pSnE9K1R9UcDrRUkGU5YsAgzWrlLxmz9XfmPccflcIvr0xiRQHSWcsJKQBV8FrqJGf36+5BDS+PsgGufE98=
Received: from SN4PR0401CA0038.namprd04.prod.outlook.com
 (2603:10b6:803:2a::24) by SN6PR02MB4816.namprd02.prod.outlook.com
 (2603:10b6:805:9b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 18 Feb
 2022 12:58:22 +0000
Received: from SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2a:cafe::b) by SN4PR0401CA0038.outlook.office365.com
 (2603:10b6:803:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Fri, 18 Feb 2022 12:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0064.mail.protection.outlook.com (10.97.4.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 18 Feb 2022 12:58:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 18 Feb 2022 04:58:21 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 18 Feb 2022 04:58:21 -0800
Envelope-to: git@xilinx.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.59] (port=57822 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nL2q4-000Gax-Qa; Fri, 18 Feb 2022 04:58:21 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <devicetree@vger.kernel.org>
CC:     <git@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v3] dt-bindings: mailbox: zynqmp_ipi: convert to yaml
Date:   Fri, 18 Feb 2022 18:28:08 +0530
Message-ID: <20220218125808.29952-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aa06c59-e5b7-447a-d34b-08d9f2de57c5
X-MS-TrafficTypeDiagnostic: SN6PR02MB4816:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB481607584530CDAE494B8766AA379@SN6PR02MB4816.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 98qJQlymy+w8kP+N0wB4doYfYncN6xo0fXxEVoxCIgLDjlesWmOCTPG1pOmBnulDfNYzI6EAACEAV1bav0LOXxP1xJsTraOs0Jdes1ZIXr+zfwmzCADOpXmrUns4NLxPAbieeNCzf4vMe56V4zMB1bd/ngCdtA6+awPlZE4kaXIm4UjImcziVaMtefTADquiD5gp/Xb8LL9E8w4sXuC5Z+ZuxTQNauAgzURl+xHq3IiPm8I71PDLU3MYHV+7phOZ5Eg3ORB8HfZBOECsvUMkiK7KwQGydYV35ZTEkjfCI4QzCbI8kmlQ7/UQrXeViFrrZJIe06biXQa6aT7o70wdrAYurxJjXxtar3Ir9G+12ubTEJ+3sDtKCpvVyx4iULJyZP0RFz2+Xq3346cYWSLL3hx0/YVSmus2Zf9h5vdMka5M20dttCXnZy+RsHvBEduoHXXqVn2gWKQX6TQR57xreLNEBjzjH1ETMsb82tLK2XU6du4Sa3elTDx2zllsFzgIhnKe05lM9m/tGdVaNEAiEgiSAd0LXivDcJfHOsmViWaTQC6+D256XgUwKmjiYUs1kRFgEk6MNWI+BPG+d7TWY3/wTl2yuNZrHDz079Mx6GqUWPOnd7VxSrPyPC3AuSGMCs9vkSmxBD6kVkB2xWZqQ9VdKXWaRHHpaQBIhLv+Kn4D1Vmmn48+X+ZGVjK+kNLca6cZskihKWWSSlpTe4U0/tOIRdRCYw/bzOE0SIXmRV0WCGxlW76SELq4mf+KWJ4E5mlkiF85Ao4aD3G6I0K5p1w20C9HgKX8GVVy4t4WrEhdldTjz3sMHmJrI9Vj8/k0eiWIN/r2PWW20YMpN6WyTg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(508600001)(7696005)(2616005)(36860700001)(6916009)(15650500001)(54906003)(316002)(450100002)(47076005)(82310400004)(83380400001)(9786002)(70206006)(7636003)(8936002)(70586007)(1076003)(4326008)(8676002)(2906002)(6666004)(44832011)(186003)(107886003)(426003)(40460700003)(26005)(336012)(356005)(5660300002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 12:58:21.8098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa06c59-e5b7-447a-d34b-08d9f2de57c5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4816
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

 .../mailbox/xlnx,zynqmp-ipi-mailbox.txt       | 127 ------------------
 .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      | 126 +++++++++++++++++
 2 files changed, 126 insertions(+), 127 deletions(-)
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
index 000000000000..6d65448ae838
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
@@ -0,0 +1,126 @@
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
+      +--------------------------+             |
+                         |                     |
+                         |                     |
+       +--------------------------------------------------+
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
+                 Default is smc.
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 2
+
+  xlnx,ipi-id:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Remote Xilinx IPI agent ID of which the mailbox is connected to.
+
+  interrupts:
+    maxItems: 1
+
+  child-node:
+    description: Internal ipi mailbox node
+    type: object  # DT nodes are json objects
+    properties:
+      xlnx,ipi-id:
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Remote Xilinx IPI agent ID of which the mailbox is connected to.
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
+required:
+  - compatible
+  - interrupts
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: true
+
+examples:
+  - |
+    zynqmp_ipi {
+      compatible = "xlnx,zynqmp-ipi-mailbox";
+      interrupts = <0 29 4>;
+      xlnx,ipi-id = <0>;
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      ipi_mailbox_rpu0: mailbox@ff9905c0 {
+        reg = <0x0 0xff9905c0 0x0 0x20>,
+              <0x0 0xff9905e0 0x0 0x20>,
+              <0x0 0xff990e80 0x0 0x20>,
+              <0x0 0xff990ea0 0x0 0x20>;
+        reg-names = "local_request_region",
+              "local_response_region",
+              "remote_request_region",
+              "remote_response_region";
+        #mbox-cells = <1>;
+        xlnx,ipi-id = <4>;
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
2.17.1

