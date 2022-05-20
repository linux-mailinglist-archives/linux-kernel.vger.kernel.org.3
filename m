Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C2252E5BA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 09:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbiETHC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 03:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346187AbiETHBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 03:01:45 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFBE212D21
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 00:01:23 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 172.28.114.216
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(13837:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 20 May 2022 14:51:16 +0800 (CST)
From:   Qin Jian <qinjian@cqplus1.com>
To:     sboyd@kernel.org
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, tglx@linutronix.de, maz@kernel.org,
        p.zabel@pengutronix.de, linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v16 06/10] dt-bindings: interrupt-controller: Add bindings for SP7021 interrupt controller
Date:   Fri, 20 May 2022 14:50:40 +0800
Message-Id: <e36788916589fc69ffca348b291c665ff6b6b4ab.1653027644.git.qinjian@cqplus1.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1653027644.git.qinjian@cqplus1.com>
References: <cover.1653027644.git.qinjian@cqplus1.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Qin Jian <qinjian@cqplus1.com>
---
 .../sunplus,sp7021-intc.yaml                  | 62 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
new file mode 100644
index 000000000..bd0021dba
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
+title: Sunplus SP7021 SoC Interrupt Controller
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
index 41cd882e2..d8ba5aace 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2812,8 +2812,13 @@ S:	Maintained
 W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
 F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
 F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
 F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
+F:	arch/arm/boot/dts/sunplus-sp7021*.dts*
+F:	arch/arm/configs/sp7021_*defconfig
+F:	arch/arm/mach-sunplus/
 F:	drivers/clk/clk-sp7021.c
+F:	drivers/irqchip/irq-sp7021-intc.c
 F:	drivers/reset/reset-sunplus.c
 F:	include/dt-bindings/clock/sunplus,sp7021-clkc.h
 F:	include/dt-bindings/reset/sunplus,sp7021-reset.h
-- 
2.33.1

