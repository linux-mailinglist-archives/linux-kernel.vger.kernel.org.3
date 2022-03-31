Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43AD4ED5D7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiCaIjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiCaIjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:39:06 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 367AA1F1614
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:37:00 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1188:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Thu, 31 Mar 2022 16:29:00 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     krzysztof.kozlowski@canonical.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>
Subject: [PATCH v12 6/9] dt-bindings: interrupt-controller: Add bindings for SP7021 interrupt controller
Date:   Thu, 31 Mar 2022 16:29:53 +0800
Message-Id: <ff5bfd5611ab0defe0c98f98edbbf655e33cd16d.1648714851.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1648714851.git.qinjian@cqplus1.com>
References: <cover.1648714851.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Sunplus SP7021 interrupt controller bindings.

Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
Move 'reg' after 'compatible'
---
 .../sunplus,sp7021-intc.yaml                  | 62 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
new file mode 100644
index 000000000..f26d8b213
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/sunplus,sp7021-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sunplus SP7021 SoC Interrupt Controller Device Tree Bindings
+
+maintainers:
+  - Qin Jian <qinjian@cqplus1.com>
+
+properties:
+  compatible:
+    items:
+      - const: sunplus,sp7021-intc
+
+  reg:
+    maxItems: 2
+    description:
+      Specifies base physical address(s) and size of the controller regs.
+      The 1st region include type/polarity/priority/mask regs.
+      The 2nd region include clear/masked_ext0/masked_ext1/group regs.
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+    description:
+      The first cell is the IRQ number, the second cell is the trigger
+      type as defined in interrupt.txt in this directory.
+
+  interrupts:
+    maxItems: 2
+    description:
+      EXT_INT0 & EXT_INT1, 2 interrupts references to primary interrupt
+      controller.
+
+required:
+  - compatible
+  - reg
+  - interrupt-controller
+  - "#interrupt-cells"
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    intc: interrupt-controller@9c000780 {
+        compatible = "sunplus,sp7021-intc";
+        reg = <0x9c000780 0x80>, <0x9c000a80 0x80>;
+        interrupt-controller;
+        #interrupt-cells = <2>;
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>, /* EXT_INT0 */
+                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>; /* EXT_INT1 */
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8b77f7ae4..9fba67159 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2745,6 +2745,7 @@ S:	Maintained
 W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
 F:	drivers/clk/clk-sp7021.c
 F:	drivers/reset/reset-sunplus.c
-- 
2.33.1

