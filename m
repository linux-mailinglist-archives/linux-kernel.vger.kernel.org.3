Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D62146A158
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351394AbhLFQax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:30:53 -0500
Received: from mail-mw2nam10on2051.outbound.protection.outlook.com ([40.107.94.51]:23520
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1386185AbhLFQao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:30:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMbHdU6LBc9Zw0AmD+Ogyms0yTXwUZssTnoxV6roZNNQod6hO+c0sGXTMirdFu94nQRQfu5fxA3RLbNvtImrXfwyraE0Ne4gj6ds0DoZbSD0kI40+ZIlx66H/RBFB9uykKuIXSR1dkWgoj4JdyOo8DX9t11YpesLTHJqjcMmZfOBDeJnev9mQ9j5jqiJURLp42RbG2gTGHT6Nfn+a/HzDJwz7qm2sN5owevEfR380BURiewezvcb3uIvCnayZYkUKAc0DifU8764IZST8DC1QnXP42/lZmivkczgsRPQaF4SsYZ5nUr+xzEDeXeMZrkmR31KMnpbpQyUOr91eeMFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5T5j3oxthkV4G/yzwGT9oTI1AzaRfAqtMMaUtGmugk=;
 b=NhExyZi1k6NuwFbN9kzg3hSTrZs6L/k5kcNUGuHmKHQjL91On6kjMX6e/Rk/n+i+a+kr8HG8tLKnEHo/VbDrTo89ipLT8zlm3mXcN+YXENjq/PLhBflzMrOF+g4iSwi24ltb6/artzOY4Ft0sf8kW9DnrUNq7hkR/UcL4tSHk+3Nesc3kRepWFh618ej+K849jK57SY9y59fpX/9Y8m137sRjaoZRd56BiPxh0lXeYl03mZLgC48XJX2xFLrcnoZUGH14wxAZ4dTGmo7z9b7mns3jVI5wnc8F2qa+Ry0CD5gl6vjFpb8pdEw7y8dc8fW88DQG8zaVK2PQYPyzlTusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5T5j3oxthkV4G/yzwGT9oTI1AzaRfAqtMMaUtGmugk=;
 b=Xu314s+5dIMCtytAzjYemWe3WDe08bfRLrtE8X+MGZvgSisACb+ILJLNXqR6YLrBoIGhlZnZv8qOiQ6QnyDdOXpKD6yBXdNJBt4+NLpjYeYvaACi9CD4ucAE/52siZxbuZm0AiTkB+Kdt0ezZ+QUjD7wvMrWwUKWfD3so/V2dm4=
Received: from DM6PR13CA0020.namprd13.prod.outlook.com (2603:10b6:5:bc::33) by
 CO1PR02MB8345.namprd02.prod.outlook.com (2603:10b6:303:160::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 16:27:13 +0000
Received: from DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::14) by DM6PR13CA0020.outlook.office365.com
 (2603:10b6:5:bc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.4 via Frontend
 Transport; Mon, 6 Dec 2021 16:27:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT007.mail.protection.outlook.com (10.13.4.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 16:27:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 6 Dec 2021 08:27:04 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 6 Dec 2021 08:27:04 -0800
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [172.23.64.8] (port=39329 helo=xhdvnc108.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1muGpT-0008UN-KV; Mon, 06 Dec 2021 08:27:04 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 16987)
        id A474F6050A; Mon,  6 Dec 2021 21:57:02 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <manish.narani@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>
Subject: [PATCH v2] dt-bindings: usb: dwc3-xilinx: Convert USB DWC3 bindings
Date:   Mon, 6 Dec 2021 21:57:01 +0530
Message-ID: <1638808021-26921-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cd8f195-5b34-4617-dbf0-08d9b8d542bd
X-MS-TrafficTypeDiagnostic: CO1PR02MB8345:EE_
X-Microsoft-Antispam-PRVS: <CO1PR02MB83453D0996B0BC0F87EFE43EC16D9@CO1PR02MB8345.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jSyFd6JdFND9z7ogk+D1Kn5Hrza68Jz60wq7YytmMyoc3e38lHj9rVlPQyz9/nYGaj+BMEoxLvJMMfudmfwpComyG5RKDxTYDQuZIXGpXlGYxuBfZ2eaUZUT1DnCs8loqz0jKiS5ywiYruW779YrsdyY5HYIurIbHMzsC8oUxvUQXXcQwxLiRY1QJmISS6Bm+KrbaoMrFcJFfDlydBtDwYx5G1IdsVHd0RGuzFFJwga176BkAYWWoYFstdDmME50iskjpPhVviYdHJGmDu2DsXvIHJypSpVvZTmKF/ic4unnX/PavJ1iEeSpyqCKUj36xj/xYjOACmFKKCvhpQOBhVT8NCUZgfzKto06ROVP8yYeALxnokISLU/EQiMjtSpOioI3J5P7TBtoiG1MjoC5DdRyws8QDkTThCBeRgLcjGnDU+zY6xUFMiPNIPgACs3HhhxXJ7qbGLg2yWNvbDCVO6Fkp4IUF+SQVNcUBTpUM5/dog0xxo4ErZI98Vvs+7K6vkeRzQQ6YcgNknaoYxOEOoUVGf7WaV4K41qW+KYUP8hmpfJFVCn/Zav26nbaISbCbRKqeUf8BUWyT0xGB8175M4jLEmykrqJG+CebHO9arxnFlOOQpHOOFi+uBsiyStBnU2RmN0iudR+heoihTtQ7Z3B2GfBN1gK5kIP20QmD0KrFoxBD8dmwPaCh8GbavhkC7NACzSVDIoPRGSAjEfDKMOYOwcwFTJvMb7gRz2f8UJKXEYYvwzC62S2X9JH1lpl1JwDANV8Q+Zj6/TjAAjXJVbo9OUtnwAYlTNiJIw0zihjJtGBwnVpCYhk/hpF+VSlTKRmMSo8dleYaZ0g+kFlai54d/XOEnoaZCUJBgwPjNM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(508600001)(6266002)(70206006)(107886003)(966005)(26005)(186003)(70586007)(356005)(36756003)(336012)(2616005)(426003)(44832011)(7636003)(36860700001)(5660300002)(47076005)(83380400001)(82310400004)(4326008)(7049001)(110136005)(54906003)(2906002)(316002)(8936002)(8676002)(42186006)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 16:27:13.6138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd8f195-5b34-4617-dbf0-08d9b8d542bd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8345
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert USB DWC3 bindings to DT schema format using json-schema.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
Changes in v2:
	- Updated the schema with missing phy and phy-names properties
	- Updated the interrupt-names property to resolve dtbs_check warnings
---
 .../devicetree/bindings/usb/dwc3-xilinx.txt        |  56 ---------
 .../devicetree/bindings/usb/dwc3-xilinx.yaml       | 131 +++++++++++++++++++++
 2 files changed, 131 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml

diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
deleted file mode 100644
index 04813a4..00000000
--- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Xilinx SuperSpeed DWC3 USB SoC controller
-
-Required properties:
-- compatible:	May contain "xlnx,zynqmp-dwc3" or "xlnx,versal-dwc3"
-- reg:		Base address and length of the register control block
-- clocks:	A list of phandles for the clocks listed in clock-names
-- clock-names:	Should contain the following:
-  "bus_clk"	 Master/Core clock, have to be >= 125 MHz for SS
-		 operation and >= 60MHz for HS operation
-
-  "ref_clk"	 Clock source to core during PHY power down
-- resets:	A list of phandles for resets listed in reset-names
-- reset-names:
-  "usb_crst"	 USB core reset
-  "usb_hibrst"	 USB hibernation reset
-  "usb_apbrst"	 USB APB reset
-
-Required child node:
-A child node must exist to represent the core DWC3 IP block. The name of
-the node is not important. The content of the node is defined in dwc3.txt.
-
-Optional properties for snps,dwc3:
-- dma-coherent:	Enable this flag if CCI is enabled in design. Adding this
-		flag configures Global SoC bus Configuration Register and
-		Xilinx USB 3.0 IP - USB coherency register to enable CCI.
-- interrupt-names: Should contain the following:
-  "dwc_usb3"	USB gadget mode interrupts
-  "otg"		USB OTG mode interrupts
-  "hiber"	USB hibernation interrupts
-
-Example device node:
-
-		usb@0 {
-			#address-cells = <0x2>;
-			#size-cells = <0x1>;
-			compatible = "xlnx,zynqmp-dwc3";
-			reg = <0x0 0xff9d0000 0x0 0x100>;
-			clock-names = "bus_clk", "ref_clk";
-			clocks = <&clk125>, <&clk125>;
-			resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
-				 <&zynqmp_reset ZYNQMP_RESET_USB1_HIBERRESET>,
-				 <&zynqmp_reset ZYNQMP_RESET_USB1_APB>;
-			reset-names = "usb_crst", "usb_hibrst", "usb_apbrst";
-			ranges;
-
-			dwc3@fe200000 {
-				compatible = "snps,dwc3";
-				reg = <0x0 0xfe200000 0x40000>;
-				interrupt-names = "dwc_usb3", "otg", "hiber";
-				interrupts = <0 65 4>, <0 69 4>, <0 75 4>;
-				phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
-				phy-names = "usb3-phy";
-				dr_mode = "host";
-				dma-coherent;
-			};
-		};
diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
new file mode 100644
index 00000000..f77c16e
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/dwc3-xilinx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx SuperSpeed DWC3 USB SoC controller
+
+maintainers:
+  - Manish Narani <manish.narani@xilinx.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xlnx,zynqmp-dwc3
+          - xlnx,versal-dwc3
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+  ranges: true
+
+  power-domains:
+    description: specifies a phandle to PM domain provider node
+    maxItems: 1
+
+  clocks:
+    description:
+      A list of phandle and clock-specifier pairs for the clocks
+      listed in clock-names.
+    items:
+      - description: Master/Core clock, has to be >= 125 MHz
+          for SS operation and >= 60MHz for HS operation.
+      - description: Clock source to core during PHY power down.
+
+  clock-names:
+    items:
+      - const: bus_clk
+      - const: ref_clk
+
+  resets:
+    description:
+      A list of phandles for resets listed in reset-names.
+
+    items:
+      - description: USB core reset
+      - description: USB hibernation reset
+      - description: USB APB reset
+
+  reset-names:
+    items:
+      - const: usb_crst
+      - const: usb_hibrst
+      - const: usb_apbrst
+
+  phys:
+    minItems: 1
+    maxItems: 2
+
+  phy-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - usb2-phy
+        - usb3-phy
+
+# Required child node:
+
+patternProperties:
+  "^usb@[0-9a-f]+$":
+    $ref: snps,dwc3.yaml#
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+  - power-domains
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/dma/xlnx-zynqmp-dpdma.h>
+    #include <dt-bindings/power/xlnx-zynqmp-power.h>
+    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
+    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
+    #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
+    #include <dt-bindings/phy/phy.h>
+    axi {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        usb@0 {
+            #address-cells = <0x2>;
+            #size-cells = <0x2>;
+            compatible = "xlnx,zynqmp-dwc3";
+            reg = <0x0 0xff9d0000 0x0 0x100>;
+            clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
+            clock-names = "bus_clk", "ref_clk";
+            power-domains = <&zynqmp_firmware PD_USB_0>;
+            resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
+                     <&zynqmp_reset ZYNQMP_RESET_USB1_HIBERRESET>,
+                     <&zynqmp_reset ZYNQMP_RESET_USB1_APB>;
+            reset-names = "usb_crst", "usb_hibrst", "usb_apbrst";
+            phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
+            phy-names = "usb3-phy";
+            ranges;
+
+            usb@fe200000 {
+                compatible = "snps,dwc3";
+                reg = <0x0 0xfe200000 0x0 0x40000>;
+                interrupt-names = "host", "otg";
+                interrupts = <0 65 4>, <0 69 4>;
+                dr_mode = "host";
+                dma-coherent;
+            };
+        };
+    };
-- 
2.1.1

