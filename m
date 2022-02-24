Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF64C2CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiBXNIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiBXNIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:08:46 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AB025A968;
        Thu, 24 Feb 2022 05:08:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9CBF2466EA;
        Thu, 24 Feb 2022 13:08:12 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/7] dt-bindings: interrupt-controller: apple,aic2: New binding for AICv2
Date:   Thu, 24 Feb 2022 22:07:36 +0900
Message-Id: <20220224130741.63924-3-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220224130741.63924-1-marcan@marcan.st>
References: <20220224130741.63924-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new incompatible revision of the AIC peripheral introduces
multi-die support. This binding is based on apple,aic, but
changes interrupt-cells to add a new die argument.

Also adds an apple,event-reg property to specify the offset of the event
register. Inexplicably, the capability registers allow us to compute
other register offsets, but not this one. This allows us to keep
forward-compatibility with future SoCs that will likely implement
different die counts, thus shifting the event register. Apple do the
same thing in their device tree...

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../interrupt-controller/apple,aic2.yaml      | 99 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 2 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
new file mode 100644
index 000000000000..311900613b9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/apple,aic2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Interrupt Controller 2
+
+maintainers:
+  - Hector Martin <marcan@marcan.st>
+
+description: |
+  The Apple Interrupt Controller 2 is a simple interrupt controller present on
+  Apple ARM SoC platforms starting with t600x (M1 Pro and Max).
+
+  It provides the following features:
+
+  - Level-triggered hardware IRQs wired to SoC blocks
+    - Single mask bit per IRQ
+    - Automatic masking on event delivery (auto-ack)
+    - Software triggering (ORed with hw line)
+  - Automatic prioritization (single event/ack register per CPU, lower IRQs =
+    higher priority)
+  - Automatic masking on ack
+  - Support for multiple dies
+
+  This device also represents the FIQ interrupt sources on platforms using AIC,
+  which do not go through a discrete interrupt controller. It also handles
+  FIQ-based Fast IPIs.
+
+properties:
+  compatible:
+    items:
+      - const: apple,t6000-aic
+      - const: apple,aic2
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 4
+    description: |
+      The 1st cell contains the interrupt type:
+        - 0: Hardware IRQ
+        - 1: FIQ
+
+      The 2nd cell contains the die ID.
+
+      The next cell contains the interrupt number.
+        - HW IRQs: interrupt number
+        - FIQs:
+          - 0: physical HV timer
+          - 1: virtual HV timer
+          - 2: physical guest timer
+          - 3: virtual guest timer
+
+      The last cell contains the interrupt flags. This is normally
+      IRQ_TYPE_LEVEL_HIGH (4).
+
+  reg:
+    description: |
+      Specifies base physical address and size of the AIC registers.
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  apple,event-reg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Specifies the offset of the event register, which lies after all the
+      implemented die register sets, page aligned. This is not computable from
+      capability register values, so we have to specify it explicitly.
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - reg
+  - apple,event-reg
+
+additionalProperties: false
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        aic: interrupt-controller@28e100000 {
+            compatible = "apple,t6000-aic", "apple,aic2";
+            #interrupt-cells = <4>;
+            interrupt-controller;
+            reg = <0x2 0x8e100000 0x0 0x10000>;
+            apple,event-reg = <0xc000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index aa0f6cbb634e..ad887ec7e96b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1806,7 +1806,7 @@ T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
-F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
-- 
2.33.0

