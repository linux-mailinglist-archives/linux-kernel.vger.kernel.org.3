Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF0C4CCA11
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237224AbiCCXeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiCCXeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:34:04 -0500
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06523B2E1D;
        Thu,  3 Mar 2022 15:33:16 -0800 (PST)
Received: from newone.lan (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id C09B4202BA;
        Fri,  4 Mar 2022 00:33:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1646350388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bHYpFZSUmUANi/7SmmSRcgqV3gsfMpiU9wroDaSqz2E=;
        b=mq7oRWP+Y2QZbGS21Z0k1ZHt13mPyltR4FhfE80uHLsYgLIkh+OI/ovtnG53U8HxMc4rQJ
        BReIwjTM43k6SYjXFQLRkEqvjLz9/4k+N6NoNKI/+OL0uNoU6jR8r9r1Nv+xIlM3yZoeJD
        aqwLPhC+/lBVZqkJL4Py9vPKYIMyZ5I=
From:   David Heidelberg <david@ixit.cz>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v3] dt-bindings: timer: Tegra: Convert text bindings to yaml
Date:   Fri,  4 Mar 2022 00:33:06 +0100
Message-Id: <20220303233307.61753-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Tegra timer binding into yaml format.

This commit also merge 3 text bindings with almost
identical content (differens in number of registers).

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - reg: true -> reg: maxItems: 1
v3:
 - add brackets around interrupts in the first example

 .../bindings/timer/nvidia,tegra-timer.yaml    | 150 ++++++++++++++++++
 .../bindings/timer/nvidia,tegra20-timer.txt   |  24 ---
 .../bindings/timer/nvidia,tegra210-timer.txt  |  36 -----
 .../bindings/timer/nvidia,tegra30-timer.txt   |  28 ----
 4 files changed, 150 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
new file mode 100644
index 000000000000..b78209cd0f28
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
@@ -0,0 +1,150 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/timer/nvidia,tegra-timer.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra timer
+
+maintainers:
+  - Stephen Warren <swarren@nvidia.com>
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra210-timer
+    then:
+      properties:
+        interrupts:
+          # Either a single combined interrupt or up to 14 individual interrupts
+          minItems: 1
+          maxItems: 14
+          description: >
+            A list of 14 interrupts; one per each timer channels 0 through 13
+
+  - if:
+      properties:
+        compatible:
+          oneOf:
+            - items:
+                - enum:
+                    - nvidia,tegra114-timer
+                    - nvidia,tegra124-timer
+                    - nvidia,tegra132-timer
+                - const: nvidia,tegra30-timer
+            - items:
+                - const: nvidia,tegra30-timer
+                - const: nvidia,tegra20-timer
+    then:
+      properties:
+        interrupts:
+          # Either a single combined interrupt or up to 6 individual interrupts
+          minItems: 1
+          maxItems: 6
+          description: >
+            A list of 6 interrupts; one per each of timer channels 1 through 5,
+            and one for the shared interrupt for the remaining channels.
+
+  - if:
+      properties:
+        compatible:
+          const: nvidia,tegra20-timer
+    then:
+      properties:
+        interrupts:
+          # Either a single combined interrupt or up to 4 individual interrupts
+          minItems: 1
+          maxItems: 4
+          description: |
+            A list of 4 interrupts; one per timer channel.
+
+properties:
+  compatible:
+    oneOf:
+      - const: nvidia,tegra210-timer
+        description: >
+          The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
+          timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
+          from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
+          (TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
+          or watchdog interrupts.
+      - items:
+          - enum:
+              - nvidia,tegra114-timer
+              - nvidia,tegra124-timer
+              - nvidia,tegra132-timer
+          - const: nvidia,tegra30-timer
+      - items:
+          - const: nvidia,tegra30-timer
+          - const: nvidia,tegra20-timer
+        description: >
+          The Tegra30 timer provides ten 29-bit timer channels, a single 32-bit free
+          running counter, and 5 watchdog modules. The first two channels may also
+          trigger a legacy watchdog reset.
+      - const: nvidia,tegra20-timer
+        description: >
+          The Tegra20 timer provides four 29-bit timer channels and a single 32-bit free
+          running counter. The first two channels may also trigger a watchdog reset.
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: timer
+
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    timer@60005000 {
+        compatible = "nvidia,tegra30-timer", "nvidia,tegra20-timer";
+        reg = <0x60005000 0x400>;
+        interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 41 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 42 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 121 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 122 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&tegra_car 214>;
+    };
+  - |
+    #include <dt-bindings/clock/tegra210-car.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@60005000 {
+        compatible = "nvidia,tegra210-timer";
+        reg = <0x60005000 0x400>;
+        interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&tegra_car TEGRA210_CLK_TIMER>;
+        clock-names = "timer";
+    };
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
deleted file mode 100644
index 4a864bd10d3d..000000000000
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-NVIDIA Tegra20 timer
-
-The Tegra20 timer provides four 29-bit timer channels and a single 32-bit free
-running counter. The first two channels may also trigger a watchdog reset.
-
-Required properties:
-
-- compatible : should be "nvidia,tegra20-timer".
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 4 interrupts; one per timer channel.
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-
-Example:
-
-timer {
-	compatible = "nvidia,tegra20-timer";
-	reg = <0x60005000 0x60>;
-	interrupts = <0 0 0x04
-			0 1 0x04
-			0 41 0x04
-			0 42 0x04>;
-	clocks = <&tegra_car 132>;
-};
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
deleted file mode 100644
index 032cda96fe0d..000000000000
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-NVIDIA Tegra210 timer
-
-The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
-timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
-from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
-(TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
-or watchdog interrupts.
-
-Required properties:
-- compatible : "nvidia,tegra210-timer".
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 14 interrupts; one per each timer channels 0 through
-  13.
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-
-timer@60005000 {
-	compatible = "nvidia,tegra210-timer";
-	reg = <0x0 0x60005000 0x0 0x400>;
-	interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
-		     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&tegra_car TEGRA210_CLK_TIMER>;
-	clock-names = "timer";
-};
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
deleted file mode 100644
index 1761f53ee36f..000000000000
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-NVIDIA Tegra30 timer
-
-The Tegra30 timer provides ten 29-bit timer channels, a single 32-bit free
-running counter, and 5 watchdog modules. The first two channels may also
-trigger a legacy watchdog reset.
-
-Required properties:
-
-- compatible : For Tegra30, must contain "nvidia,tegra30-timer".  Otherwise,
-  must contain '"nvidia,<chip>-timer", "nvidia,tegra30-timer"' where
-  <chip> is tegra124 or tegra132.
-- reg : Specifies base physical address and size of the registers.
-- interrupts : A list of 6 interrupts; one per each of timer channels 1
-    through 5, and one for the shared interrupt for the remaining channels.
-- clocks : Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-
-timer {
-	compatible = "nvidia,tegra30-timer", "nvidia,tegra20-timer";
-	reg = <0x60005000 0x400>;
-	interrupts = <0 0 0x04
-		      0 1 0x04
-		      0 41 0x04
-		      0 42 0x04
-		      0 121 0x04
-		      0 122 0x04>;
-	clocks = <&tegra_car 214>;
-};
-- 
2.34.1

