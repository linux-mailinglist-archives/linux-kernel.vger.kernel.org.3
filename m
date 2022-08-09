Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C9958D920
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 15:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243483AbiHINI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243439AbiHINIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 09:08:54 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2082.outbound.protection.outlook.com [40.107.95.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA5BC17;
        Tue,  9 Aug 2022 06:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEv6ULOjEBZl7K8aFA4mJQE8T5ikVAjKU8UjxHORTENrSqnbLfwp1p6jR7ShVNR27jFHztC/sVjQ7rL88eQuh444S+l5+yMoa+MHNNOD9GUpv4KyLxVQg4QoHl75oTV50rVSmmjyCkaMxiu9IFqmIGgob8BA20HYd1oHaRz/01qdw9L0C2a9WnpIqVJCc149HhCdTQAQdIdmvDaXi7lQx/BzPdUVMHIg47LVAGrXAAkFdcH9Q6/r6F/tLNI0dmLlsFz4dzpLgMQj7DTtHfnqewegwJWDdU24e8H/qgrFXbt2XcvdoFn3s0G8ElfTULyJdgxZbox19lhzpl24GW33cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYI7LsRSCYZ8hjsA+99zwHQLpTXhDWk3ic1Jx94FGiQ=;
 b=LH0o/eS3ZDZ8GhJZJFqtFOcSKQkWumOF41H3cX+fAoVjRYt0xWpgI31tjmYgxLxt0un0Oo78CW8I/gX96oDxs+hvW76RBcSDMuD7VXa+95fQipeY8ZYit//5HPxXR6QXhxxrtTxHQMZTGVV4rIrbLPMHcijwb0M5Yv8Z+XctHm5YShSgEaM6RatF9CnVd6RpwFLFUMc2kpY2EDPU9RLHTWsq00MmMWdWLppvHKnxrCoRyI71fEmcX8gZ8KkSkNW/MDSDLAWsDhGqr4F6ERA0bmZ0Lonn7KRC6M0hRdziOymi55yXDLB4D2FaLr6a3vLiS5xkscbqTDfx4MMPjty7hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYI7LsRSCYZ8hjsA+99zwHQLpTXhDWk3ic1Jx94FGiQ=;
 b=eTUacdrnWUbWoLg7hrjOMsCEkgRSBVw5gId19CUlt0zl/qXZOaZDqgHpVo8SltafYkkau6kD0hjKB/G7PwvEPpBlrhfp1JMWJl2bb3ZGuYA3dme8f0xAdJPlEP7ruZiA5pkEAmhBrb7dFMF+bj6kZpfHl/rQWQ2JZ8X5T3nlO4E=
Received: from BN8PR03CA0021.namprd03.prod.outlook.com (2603:10b6:408:94::34)
 by DM5PR02MB2745.namprd02.prod.outlook.com (2603:10b6:3:10e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:08:51 +0000
Received: from BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::5c) by BN8PR03CA0021.outlook.office365.com
 (2603:10b6:408:94::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Tue, 9 Aug 2022 13:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT029.mail.protection.outlook.com (10.13.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 13:08:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 9 Aug 2022 06:08:48 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 9 Aug 2022 06:08:48 -0700
Envelope-to: git@xilinx.com,
 linus.walleij@linaro.org,
 brgl@bgdev.pl,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 srinivas.neeli@amd.com,
 linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 git@amd.com
Received: from [172.23.66.193] (port=41794 helo=xhdsneeli40u.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1oLOyV-000GuI-V3; Tue, 09 Aug 2022 06:08:48 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <shubhrajyoti.datta@xilinx.com>, <srinivas.neeli@xilinx.com>,
        <michal.simek@xilinx.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <srinivas.neeli@amd.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>, <git@amd.com>
Subject: [PATCH] dt-bindings: gpio: gpio-xilinx: Convert Xilinx axi gpio binding to YAML
Date:   Tue, 9 Aug 2022 18:38:42 +0530
Message-ID: <20220809130842.27975-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8d95bbd-d2eb-4cef-0d75-08da7a084df4
X-MS-TrafficTypeDiagnostic: DM5PR02MB2745:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjrUzxF89qbDTIIkq4pGeeYnN/N/YKqMB6RyE836Ir2imm1KaCDbiakPmeaEzCWkfExKCRpwdoyl4qmiRPi7ssAVwKWCm3nEDXIhgTdgTImCzV6HDCBpdyKqjMG8G9uLL491sknFaiBk77b+C5Pjz5elhIcK5iMu37vhbYfMJyKyijuTdcaojNj5Omi72xoTYHspZkTZ4jCdrgL3I2/46LDSed/hnix6v+ncXuUNr803prIOvAoDNXmsWAw4Yh2pa7/J2Cphj2scMgCAxHqn5KEkT5H5qQwGv7I3XgxkfUqyJE+prm7zpuQba6dpiPouaMKzE6dhkHYQE1ihyHv89EK9BdnTNeGfa9dbhP2tu76Pl7W7QyL0xwrGGBme69qEg7mKC+Khh4ypGyzK7t1iFLMWGba2XvHjqUifDy9NSvtwfE9dZD8K7xJEvYIU1YlP0maQCn3Q/B7yzzRVa7MfBVWZTp8MbMsc8kk4fK+g1YrhaPH6I+LTrcjXqRlko8odD4Ex1mUUNjXE0sYj3I3wUXfdBaZmyD89RW4E3lBIIRAvR/eCbG6pFzg2ec5CtR44SMScfY84jUSc3apvNcLI5UgDI30w3yIi5J9CJUxWUNUzriznax4yBH+BR5ozSHIlundvLE72lWwwywc7etrZzzgV9HQxlrtbOjeFfGHGFA+GD8ZPGJJqb3Cquxre8ejv1aZFn1w7yzMY3bExH8e+kr8A2PCQuJt8vqmsVi8qeBDUGkEIk8Xrx04yzb9J8RZR78OVb/8pU7hc34ZA/+YRvtxyRgqpsFpkyWX2Iy10qKbdl8ofb9+FKgzfYpsCjXJNx/gP2uOp71QtL6+PzfkZ3mfLFSR75T7l0paw5zx7Igyn2pGTD64DKoiqO88VB0fiwA49yGZvTZaP3ntk+WMz0w==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(40470700004)(46966006)(36840700001)(6666004)(478600001)(966005)(36756003)(7636003)(356005)(82740400003)(83380400001)(2616005)(186003)(47076005)(1076003)(426003)(336012)(54906003)(26005)(110136005)(41300700001)(40480700001)(70586007)(70206006)(7696005)(316002)(82310400005)(8676002)(4326008)(5660300002)(40460700003)(7416002)(36860700001)(44832011)(9786002)(8936002)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:08:50.9857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d95bbd-d2eb-4cef-0d75-08da7a084df4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2745
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Xilinx axi gpio binding documentation to YAML.

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
---
 .../devicetree/bindings/gpio/gpio-xilinx.txt  |  48 ------
 .../bindings/gpio/xlnx,gpio-xilinx.yaml       | 140 ++++++++++++++++++
 2 files changed, 140 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-xilinx.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-xilinx.txt b/Documentation/devicetree/bindings/gpio/gpio-xilinx.txt
deleted file mode 100644
index e506f30e1a95..000000000000
--- a/Documentation/devicetree/bindings/gpio/gpio-xilinx.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-Xilinx plb/axi GPIO controller
-
-Dual channel GPIO controller with configurable number of pins
-(from 1 to 32 per channel). Every pin can be configured as
-input/output/tristate. Both channels share the same global IRQ but
-local interrupts can be enabled on channel basis.
-
-Required properties:
-- compatible : Should be "xlnx,xps-gpio-1.00.a"
-- reg : Address and length of the register set for the device
-- #gpio-cells : Should be two. The first cell is the pin number and the
-  second cell is used to specify optional parameters (currently unused).
-- gpio-controller : Marks the device node as a GPIO controller.
-
-Optional properties:
-- clocks : Input clock specifier. Refer to common clock bindings.
-- interrupts : Interrupt mapping for GPIO IRQ.
-- xlnx,all-inputs : if n-th bit is setup, GPIO-n is input
-- xlnx,dout-default : if n-th bit is 1, GPIO-n default value is 1
-- xlnx,gpio-width : gpio width
-- xlnx,tri-default : if n-th bit is 1, GPIO-n is in tristate mode
-- xlnx,is-dual : if 1, controller also uses the second channel
-- xlnx,all-inputs-2 : as above but for the second channel
-- xlnx,dout-default-2 : as above but the second channel
-- xlnx,gpio2-width : as above but for the second channel
-- xlnx,tri-default-2 : as above but for the second channel
-
-
-Example:
-gpio: gpio@40000000 {
-	#gpio-cells = <2>;
-	compatible = "xlnx,xps-gpio-1.00.a";
-	clocks = <&clkc25>;
-	gpio-controller ;
-	interrupt-parent = <&microblaze_0_intc>;
-	interrupts = < 6 2 >;
-	reg = < 0x40000000 0x10000 >;
-	xlnx,all-inputs = <0x0>;
-	xlnx,all-inputs-2 = <0x0>;
-	xlnx,dout-default = <0x0>;
-	xlnx,dout-default-2 = <0x0>;
-	xlnx,gpio-width = <0x2>;
-	xlnx,gpio2-width = <0x2>;
-	xlnx,interrupt-present = <0x1>;
-	xlnx,is-dual = <0x1>;
-	xlnx,tri-default = <0xffffffff>;
-	xlnx,tri-default-2 = <0xffffffff>;
-} ;
diff --git a/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml b/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
new file mode 100644
index 000000000000..089e297aa530
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/xlnx,gpio-xilinx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Axi GPIO controller Device Tree Bindings
+
+maintainers:
+  - Neeli Srinivas <srinivas.neeli@amd.com>
+
+description:
+  The AXI GPIO design provides a general purpose input/output interface
+  to an AXI4-Lite interface. The AXI GPIO can be configured as either
+  a single or a dual-channel device. The width of each channel is
+  independently configurable. The channels can be configured to
+  generate an interrupt when a transition on any of their inputs occurs.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,xps-gpio-1.00.a
+  reg:
+    maxItems: 1
+
+  "#gpio-cells":
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  gpio-controller: true
+
+  gpio-line-names:
+    description: strings describing the names of each gpio line
+    minItems: 1
+    maxItems: 64
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  clocks:
+    maxItems: 1
+
+  interrupt-names: true
+
+  xlnx,all-inputs:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: This option sets this GPIO channel1 bits in input mode.
+
+  xlnx,all-inputs-2:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: This option sets this GPIO channel2 bits in input mode.
+
+  xlnx,all-outputs:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: This option sets this GPIO channel1 bits in output mode.
+
+  xlnx,all-outputs-2:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: This option sets this GPIO channel2 bits in output mode.
+
+  xlnx,dout-default:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: Sets the default value of all the enabled bits of
+                 channel1. By default, this parameter is set to 0x0.
+
+  xlnx,dout-default-2:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: Sets the default value of all the enabled bits of
+                 channel2. By default, this parameter is set to 0x0.
+
+  xlnx,gpio-width:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: The value defines the bit width of the GPIO channel1.
+                 Its value can be from 1 to 32, and default value is 32.
+
+  xlnx,gpio2-width:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: The value defines the bit width of the GPIO channel2.
+                 Its value can be from 1 to 32, and default value is 32.
+
+  xlnx,interrupt-present:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: This parameter enables interrupt control logic
+                 and interrupt registers in GPIO module. By default it is 0.
+  xlnx,is-dual:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: This parameter enables a second GPIO channel (GPIO2).
+
+  xlnx,tri-default:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: This value configures the input or output mode
+                 of each bit of GPIO channel1.
+
+  xlnx,tri-default-2:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: This value configures the input or output mode
+                 of each bit of GPIO channel2.
+
+required:
+  - reg
+  - compatible
+  - gpio-controller
+  - "#gpio-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+        gpio@e000a000 {
+            #gpio-cells = <2>;
+            #interrupt-cells = <0x2>;
+            clocks = <&zynqmp_clk 71>;
+            compatible = "xlnx,xps-gpio-1.00.a";
+            gpio-controller;
+            interrupt-controller;
+            interrupt-names = "ip2intc_irpt";
+            interrupt-parent = <&gic>;
+            interrupts = <0 89 4>;
+            reg = <0xa0020000 0x10000>;
+            xlnx,all-inputs = <0x0>;
+            xlnx,all-inputs-2 = <0x0>;
+            xlnx,all-outputs = <0x0>;
+            xlnx,all-outputs-2 = <0x0>;
+            xlnx,dout-default = <0x0>;
+            xlnx,dout-default-2 = <0x0>;
+            xlnx,gpio-width = <0x20>;
+            xlnx,gpio2-width = <0x20>;
+            xlnx,interrupt-present = <0x1>;
+            xlnx,is-dual = <0x1>;
+            xlnx,tri-default = <0xFFFFFFFF>;
+            xlnx,tri-default-2 = <0xFFFFFFFF>;
+        };
+
+...
-- 
2.17.1

