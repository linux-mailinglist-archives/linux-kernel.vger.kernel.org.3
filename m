Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F4E58EC30
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiHJMlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiHJMlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:41:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B261B77541;
        Wed, 10 Aug 2022 05:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDaXnSUigW871b5v4Fp/X0X3AKZVZA0EQzb2Cb6VE3gVd4l7rnj1dFCgFXNH8qVn2/8Uu7KOFUn8tm4fhXHfpzG7baPwDFOcazhKouqI+xDpsOCoIZHwGMQBY+pv9kJQARQ+H55USby891eW4QS51YFSnKZSwIO6kR5emKRd+1YL/B+KxQx5xsFd1x48P4YkWqAJazdII8kHtHBzK46F3D8aAarjJu0HRlnd7173fmFlJ/m+3IQ5UnZVlU4nN7qU8NnVCNpLrvdryVKPkxIgwrajqnaW9dPJfcatzy2kpa1bsuHG9h/mhuJG2p97VtHxS80E/Ou1AQho7IcDIfuh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdaGF3z1t4+RNuvhm1NIapr7dmuD7RGnH5o3ub/b7LY=;
 b=Sy0ORUsbayAphzsPNUl13vAABBJgL+mTevUm11DIRQ6N5wxqZWVTvM1tG4ZrkAc5PvT7aScoWSq4XJgwlBhzYI7pYBrR4ji4oiftItHElSUnfc/1tOWlqqBWY93jnpvFXual9DOOQMidiz3R5zGD8mej1Mrh3EHk8g4OXPKNIe35ylYRty5sdRdNf5ZV/v5SS6VKxm+SqdBdJZFaEfNFbi4DUvnpvPvyVnLc+tyVlmciqAEHvDynmp9U2v8JumjGkjEBOGF0tfQpcStFiCoCX58FRvFOV8HOHHZAdOahCi1ptqhZ3H8qpqEiCNTgkWDF3/XiUlcSs1dxDr3c9T0IaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdaGF3z1t4+RNuvhm1NIapr7dmuD7RGnH5o3ub/b7LY=;
 b=cbOH0fCwPLy4iwdgfr7g97fywK7ePDEZNMHGUXkcgw2c2WqnM84Ophm8DjPPPHVEs3RvxrFLO72rzpWuqTu9kcoEqk/cvLo5A2D1OGk2m9cDq2nom0p5Jab/lSRyO6eI8IJ8Mm1a2LZ4g1eeLRC+3TFsM47LAMTCeRHSf1Zw7OI=
Received: from BN0PR04CA0153.namprd04.prod.outlook.com (2603:10b6:408:eb::8)
 by PH0PR02MB7493.namprd02.prod.outlook.com (2603:10b6:510:1a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 12:41:16 +0000
Received: from BN1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::8d) by BN0PR04CA0153.outlook.office365.com
 (2603:10b6:408:eb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Wed, 10 Aug 2022 12:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT054.mail.protection.outlook.com (10.13.2.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 12:41:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 10 Aug 2022 05:41:15 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 10 Aug 2022 05:41:15 -0700
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
Received: from [172.23.66.193] (port=42314 helo=xhdsneeli40u.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1oLl1O-00019B-Ty; Wed, 10 Aug 2022 05:41:15 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <shubhrajyoti.datta@xilinx.com>, <srinivas.neeli@xilinx.com>,
        <michal.simek@xilinx.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <srinivas.neeli@amd.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>, <git@amd.com>
Subject: [PATCH V2] dt-bindings: gpio: gpio-xilinx: Convert Xilinx axi gpio binding to YAML
Date:   Wed, 10 Aug 2022 18:11:09 +0530
Message-ID: <20220810124109.34157-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c0e93f9-0bfb-4f30-7cb5-08da7acd9e1f
X-MS-TrafficTypeDiagnostic: PH0PR02MB7493:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pY30ME6hXvawDPIBtgB2fNAL4zwsyMm+O1eJzw/0i1DlDXm7MaGeDnilepQILcCe+PSo3bZjyl1t0QKCOxpNc/u5lLDg+xDm/B9zfdRNH5pitItPBflrm1xLz0UDuRViIqcPO4qIzdrEZ3nyl6JAIAz/tjqM908D//C4sdQTFnBE8wFnqB2YzgGmMRVInJI2tj4O017r7laqEcWQZlO+CusZXIRMKdbDEX/5Vr8AAJyjKBe/VmB4BbNSt6SR7Ek+eIBdjyjYuNmGAe8XZkjP3sK2+/PQK34mhIIGBr1lfUYETERBBlU7roEC598joqJwchrjV/WmFZZMJRm0ShfHHCyelc+dpmP1eseo7JU/vfhKCXfKHF2/yFBSm3gI+RZGQMd6e5r879di89aPdQKOQ6zLbf/N8GO2hQTNsXsT4nNl47JB1XxPxAMv0JYSXfmIM0wcyiUmuoQbtK2bhMrsdCaptspCYit1JUllMpJ/9lXXGnaPM3VofJXdHttVbkyc2FHa+6vJSe+EwAIQYZrqUMRAIEdKn2PIxJmEhK6/4F3QHnzt+oK2zBzqa5gID4cn3ZSGqn3Bmn0ZSki9p+MpfbI58u22BuEtbnppMRuCT7i/6JMuFulwe7OUmNG0qZXme4yfegUAR4R2h4zm8S1RDYurV7YbgCWZCpa2XFX3xKORlNvdTgqLTGfqlzWLzeKZ1Z8vpAlkZ+/8fr9YGNc5/jgBTLjjIRL6KEeT4Id7a5PJCdliD225tioiWfkNaHkzqpvVP5iRyhLOecaLdidJsj4jVvo6gKdCQJzxjmJJY/QjRIUcy8IrrgMzMg3yj6JCtWR1Gwkl1GTkVYnI27R79t6rgUkPXhT3Xuw0qxvN86Otc+rtdNuzUK0DeZ2MW1dPiDmrkjbC+VvC9ITCZRYPCA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(136003)(346002)(36840700001)(40470700004)(46966006)(336012)(2616005)(47076005)(1076003)(426003)(82740400003)(186003)(356005)(7636003)(83380400001)(5660300002)(8936002)(36860700001)(9786002)(7416002)(70206006)(44832011)(70586007)(4326008)(6666004)(82310400005)(40480700001)(966005)(2906002)(478600001)(40460700003)(26005)(7696005)(41300700001)(54906003)(36756003)(316002)(8676002)(110136005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 12:41:16.4688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0e93f9-0bfb-4f30-7cb5-08da7acd9e1f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7493
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
Changes in V2:
- Updated mainter email with s-o-b.
- Updated few constraints.
- Addressed few other comments.
---
 .../devicetree/bindings/gpio/gpio-xilinx.txt  |  48 ------
 .../bindings/gpio/xlnx,gpio-xilinx.yaml       | 154 ++++++++++++++++++
 2 files changed, 154 insertions(+), 48 deletions(-)
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
index 000000000000..f333ee2288e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/xlnx,gpio-xilinx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx AXI GPIO controller
+
+maintainers:
+  - Neeli Srinivas <srinivas.neeli@xilinx.com>
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
+
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
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: This option sets this GPIO channel1 bits in input mode.
+
+  xlnx,all-inputs-2:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: This option sets this GPIO channel2 bits in input mode.
+
+  xlnx,all-outputs:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: This option sets this GPIO channel1 bits in output mode.
+
+  xlnx,all-outputs-2:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: This option sets this GPIO channel2 bits in output mode.
+
+  xlnx,dout-default:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Sets the default value of all the enabled bits of
+                 channel1.
+    default: 0
+
+  xlnx,dout-default-2:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Sets the default value of all the enabled bits of
+                 channel2.
+    default: 0
+
+  xlnx,gpio-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The value defines the bit width of the GPIO channel1.
+    minimum: 1
+    maximum: 32
+    default: 32
+
+  xlnx,gpio2-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The value defines the bit width of the GPIO channel2.
+    minimum: 1
+    maximum: 32
+    default: 32
+
+  xlnx,interrupt-present:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: This parameter enables interrupt control logic
+                 and interrupt registers in GPIO module.
+    minimum: 0
+    maximum: 1
+    default: 0
+
+  xlnx,is-dual:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: This parameter enables a second GPIO channel (GPIO2).
+    minimum: 0
+    maximum: 1
+    default: 0
+
+  xlnx,tri-default:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: This value configures the input or output mode
+                 of each bit of GPIO channel1.
+
+  xlnx,tri-default-2:
+    $ref: /schemas/types.yaml#/definitions/uint32
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
+            compatible = "xlnx,xps-gpio-1.00.a";
+            reg = <0xa0020000 0x10000>;
+            #gpio-cells = <2>;
+            #interrupt-cells = <0x2>;
+            clocks = <&zynqmp_clk 71>;
+            gpio-controller;
+            interrupt-controller;
+            interrupt-names = "ip2intc_irpt";
+            interrupt-parent = <&gic>;
+            interrupts = <0 89 4>;
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

