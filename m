Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFC6554A95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352917AbiFVNLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352519AbiFVNLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:11:08 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9F16585;
        Wed, 22 Jun 2022 06:11:01 -0700 (PDT)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D33D5FF817;
        Wed, 22 Jun 2022 13:10:50 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, linkmauve@linkmauve.fr,
        rw-r-r-0644@protonmail.com, devicetree@vger.kernel.org
Subject: [PATCH v2 01/12] dt-bindings: wiiu: Document the Nintendo Wii U devicetree
Date:   Wed, 22 Jun 2022 23:10:26 +1000
Message-Id: <20220622131037.57604-2-ash@heyquark.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622131037.57604-1-ash@heyquark.com>
References: <20220302044406.63401-1-ash@heyquark.com>
 <20220622131037.57604-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds schema for the various Wii U devicetree nodes used.

Signed-off-by: Ash Logan <ash@heyquark.com>
---
 .../bindings/powerpc/nintendo/wiiu.yaml       | 28 +++++++++++
 .../powerpc/nintendo/wiiu/espresso-pic.yaml   | 42 +++++++++++++++++
 .../bindings/powerpc/nintendo/wiiu/gpu7.yaml  | 41 +++++++++++++++++
 .../powerpc/nintendo/wiiu/latte-ahci.yaml     | 43 +++++++++++++++++
 .../powerpc/nintendo/wiiu/latte-dsp.yaml      | 35 ++++++++++++++
 .../powerpc/nintendo/wiiu/latte-pic.yaml      | 46 +++++++++++++++++++
 .../powerpc/nintendo/wiiu/latte-sdhci.yaml    | 40 ++++++++++++++++
 .../bindings/powerpc/nintendo/wiiu/latte.yaml | 25 ++++++++++
 8 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml
 create mode 100644 Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml

diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml
new file mode 100644
index 000000000000..5824b07928f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U bindings
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  Nintendo Wii U video game console binding.
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+      - description: Nintendo Wii U video game console
+        items:
+          - const: nintendo,wiiu
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml
new file mode 100644
index 000000000000..878a81595f5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/espresso-pic.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/espresso-pic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U "Espresso" interrupt controller
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  Interrupt controller found on the Nintendo Wii U for the "Espresso" processor.
+
+properties:
+  compatible:
+    oneOf:
+      - description: Nintendo Wii U "Espresso" interrupt controller
+        items:
+          - const: nintendo,espresso-pic
+  '#interrupt-cells':
+    # Interrupt numbers 0-32 in one cell
+    const: 1
+  interrupt-controller: true
+  reg:
+    items:
+      - description: Core registers
+
+additionalProperties: false
+
+examples:
+  - |
+    espresso_pic: pic@c000078 {
+            #interrupt-cells = <1>;
+            interrupt-controller;
+
+            compatible = "nintendo,espresso-pic";
+            reg = <0x0c000078 0x18>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml
new file mode 100644
index 000000000000..e54d49015f36
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/gpu7.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/gpu7.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U Latte "GPU7" graphics processor
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  GPU7 graphics processor, also known as "GX2", found in the Latte multifunction chip of the
+  Nintendo Wii U.
+
+properties:
+  compatible:
+    oneOf:
+      - description: Nintendo Wii U Latte "GPU7" graphics processor
+        items:
+          - const: nintendo,latte-gpu7
+  reg:
+    items:
+      - description: GpuF0MMReg registers
+  interrupts:
+    items:
+      - description: Main interrupt, connected via Espresso PIC
+
+# This will likely get bound to the Radeon driver one day, which will neccesitate extra properties
+additionalProperties: true
+
+examples:
+  - |
+    gpu7@c200000 {
+            compatible = "nintendo,latte-gpu7";
+            reg = <0x0c200000 0x80000>;
+            interrupts = <2>;
+            interrupt-parent = <&espresso_pic>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml
new file mode 100644
index 000000000000..7b9de4effcb0
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-ahci.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U Latte AHCI controller
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  Nintendo Wii U AHCI SATA controller, as found in the Latte chip.
+
+properties:
+  compatible:
+    oneOf:
+      - description: Nintendo Wii U Latte AHCI controller
+        items:
+          - const: nintendo,latte-ahci
+  reg:
+    items:
+      - description: |
+          HBA memory registers. Note that unlike the spec, space for only 6 ports exist, with 2 vendor
+          registers afterwards, thus register space should be 0x408 long (0x100+0x80*6+0x8).
+  interrupts:
+    items:
+      - description: Main HBA interrupt
+      - description: Vendor debugging interrupt
+
+additionalProperties: false
+
+examples:
+  - |
+    sata: ahci@d160400 {
+          compatible = "nintendo,latte-ahci";
+          reg = <0x0d160400 0x408>;
+
+          interrupt-parent = <&latte_pic>;
+          interrupts = <38>, <28>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml
new file mode 100644
index 000000000000..ed0b4c28ce48
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-dsp.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte-dsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U Latte DSP
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  Nintendo Wii U digital signal processor, as found in the Latte chip.
+
+properties:
+  compatible:
+    oneOf:
+      - description: Nintendo Wii U Latte DSP
+        items:
+          - const: nintendo,latte-dsp
+  reg:
+    items:
+      - description: DSP registers
+
+# Once more is known about this device more properties will likely be added
+additionalProperties: true
+
+examples:
+  - |
+    latte_dsp: dsp@c005000 {
+         compatible = "nintendo,latte-dsp";
+         reg = <0x0c005000 0x200>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml
new file mode 100644
index 000000000000..a2df71fb9964
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-pic.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte-pic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U Latte interrupt controller
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  Interrupt controller found on the Nintendo Wii U for the "Latte" devices.
+
+properties:
+  compatible:
+    oneOf:
+      - description: Nintendo Wii U Latte interrupt controller
+        items:
+          - const: nintendo,latte-pic
+  '#interrupt-cells':
+    # Interrupt numbers 0-64 in one cell.
+    const: 1
+  interrupt-controller: true
+  reg:
+    items:
+      - description: Core registers
+  interrupts:
+    items:
+      - description: Cascade interrupt for Espresso PIC
+
+additionalProperties: false
+
+examples:
+  - |
+    latte_pic: pic@d800440 {
+         #interrupt-cells = <1>;
+         interrupt-controller;
+
+         compatible = "nintendo,latte-pic";
+         reg = <0x0d800440 0x30>;
+         interrupt-parent = <&espresso_pic>;
+         interrupts = <24>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml
new file mode 100644
index 000000000000..4b9b0820edc1
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte-sdhci.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nintendo Wii U Latte SD Host controller
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  SDHCI hosts found on the Nintendo Wii U's Latte SoC for SD cards and SDIO devices.
+
+properties:
+  compatible:
+    oneOf:
+      - description: Nintendo Wii U Latte SDHCI
+        items:
+          - const: nintendo,latte-sdhci
+          - const: sdhci
+  reg:
+    items:
+      - description: Core registers
+  interrupts:
+    items:
+      - description: SDHCI interrupt
+
+additionalProperties: false
+
+examples:
+  - |
+    sdcard_0: sdhci@d070000 {
+          compatible = "nintendo,latte-sdhci","sdhci";
+          reg = <0x0d070000 0x200>;
+          interrupts = <7>;
+          interrupt-parent = <&latte_pic>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
new file mode 100644
index 000000000000..6ae86d198fa3
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wiiu/latte.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/powerpc/nintendo/wiiu/latte.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Latte system bus
+
+maintainers:
+  - Ash Logan <ash@heyquark.com>
+  - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
+
+description: |
+  Latte multi-function SoC, containing many of the devices found on the Nintendo Wii U.
+
+properties:
+  compatible:
+    oneOf:
+      - description: Nintendo Wii U "Latte" SoC
+        items:
+          - const: nintendo,latte
+
+additionalProperties: true
+
+...
-- 
2.36.1

