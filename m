Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A11B572D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiGMFdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiGMFbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:31:13 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A107FBB7ED;
        Tue, 12 Jul 2022 22:29:52 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id CE5C416CF;
        Wed, 13 Jul 2022 08:31:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com CE5C416CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1657690295;
        bh=cm8otfSDLc0n+JNoytsv1dVbmB30R533FB1lKBFDB8w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=mTvtxZKDpm8htd4LKygch3pRny1MoaTO9DzoReaOOk0uarOwJcU1Hd7+U1eAsmzFO
         4MGCYbmJJlafq+jmmqQ24+Bf7bSJBEwQoFKFFEC4raWZV3EcJoLYm4k37SX0U5d/3w
         r0MZDKjxG801fdmd6Y2Q6dTY6ZT51HU5bS69VOzk=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Jul 2022 08:29:40 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v5 17/23] dt-bindings: ata: ahci: Add DWC AHCI SATA controller DT schema
Date:   Wed, 13 Jul 2022 08:29:10 +0300
Message-ID: <20220713052917.27036-18-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
References: <20220713052917.27036-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synopsys AHCI SATA controller is mainly compatible with the generic AHCI
SATA controller except a few peculiarities and the platform environment
requirements. In particular it can have at least two reference clocks to
feed up its AHB/AXI interface and SATA PHYs domain and at least one reset
control for the application clock domain. In addition to that the DMA
interface of each port can be tuned up to work with the predefined maximum
data chunk size. Note unlike generic AHCI controller DWC AHCI can't have
more than 8 ports. All of that is reflected in the new DWC AHCI SATA
device DT binding.

Note the DWC AHCI SATA controller DT-schema has been created in a way so
to be reused for the vendor-specific DT-schemas (see for example the
"snps,dwc-ahci" compatible string binding). One of which we are about to
introduce.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Replace min/max constraints of the snps,{tx,rx}-ts-max property with
  enum [ 1, 2, 4, ..., 1024 ]. (@Rob)

Changelog v4:
- Decrease the "additionalProperties" property identation otherwise it's
  percieved as the node property instead of the key one. (@Rob)
- Use the ahci-port properties definition from the AHCI common schema
  in order to extend it with DWC AHCI SATA port properties. (@Rob)
- Remove the Hannes' rb tag since the patch content has changed.

Changelog v5:
- Fix "resets" property description: replace "clocks" with "resets".
  (@Rob)
- Extend "resets/clocks{-names}" property definitions. (@Rob)
- Add "resets" property min/maxItems constraints. (@Rob)
- Add names for the basic resets like RxOOB and PM-alive. (@Rob)
- Add generic DWC AHCI SATA fallback for "rockchip,rk3568-dwc-ahci"
  bindings. (@Rob)
- Due to the change above the schema has been split up into two parts:
  common DWC AHCI SATA properties and generic DW AHCI SATA controller
  DT-schema. (@Rob)
---
 .../bindings/ata/ahci-platform.yaml           |   8 --
 .../bindings/ata/snps,dwc-ahci-common.yaml    | 102 ++++++++++++++++++
 .../bindings/ata/snps,dwc-ahci.yaml           |  75 +++++++++++++
 3 files changed, 177 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
 create mode 100644 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index e19cf9828e68..7dc2a2e8f598 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -30,8 +30,6 @@ select:
           - marvell,armada-3700-ahci
           - marvell,armada-8k-ahci
           - marvell,berlin2q-ahci
-          - snps,dwc-ahci
-          - snps,spear-ahci
   required:
     - compatible
 
@@ -48,17 +46,11 @@ properties:
               - marvell,berlin2-ahci
               - marvell,berlin2q-ahci
           - const: generic-ahci
-      - items:
-          - enum:
-              - rockchip,rk3568-dwc-ahci
-          - const: snps,dwc-ahci
       - enum:
           - cavium,octeon-7130-ahci
           - hisilicon,hisi-ahci
           - ibm,476gtr-ahci
           - marvell,armada-3700-ahci
-          - snps,dwc-ahci
-          - snps,spear-ahci
 
   reg:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
new file mode 100644
index 000000000000..c1457910520b
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/snps,dwc-ahci-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DWC AHCI SATA controller properties
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description:
+  This document defines device tree schema for the generic Synopsys DWC
+  AHCI controller properties.
+
+select: false
+
+allOf:
+  - $ref: ahci-common.yaml#
+
+properties:
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Basic DWC AHCI SATA clock sources like application AXI/AHB BIU clock,
+      PM-alive clock, RxOOB detection clock, embedded PHYs reference (Rx/Tx)
+      clock, etc.
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      oneOf:
+        - description: Application APB/AHB/AXI BIU clock
+          enum:
+            - pclk
+            - aclk
+            - hclk
+            - sata
+        - description: Power Module keep-alive clock
+          const: pmalive
+        - description: RxOOB detection clock
+          const: rxoob
+        - description: SATA Ports reference clock
+          const: ref
+
+  resets:
+    description:
+      At least basic application and reference clock domains resets are
+      normally supported by the DWC AHCI SATA controller.
+    minItems: 1
+    maxItems: 4
+
+  reset-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      oneOf:
+        - description: Application AHB/AXI BIU clock domain reset control
+          enum:
+            - arst
+            - hrst
+        - description: Power Module keep-alive clock domain reset control
+          const: pmalive
+        - description: RxOOB detection clock domain reset control
+          const: rxoob
+        - description: Reference clock domain reset control
+          const: ref
+
+patternProperties:
+  "^sata-port@[0-9a-e]$":
+    $ref: '#/$defs/dwc-ahci-port'
+
+additionalProperties: true
+
+$defs:
+  dwc-ahci-port:
+    $ref: /schemas/ata/ahci-common.yaml#/$defs/ahci-port
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 7
+
+      snps,tx-ts-max:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Maximal size of Tx DMA transactions in FIFO words
+        enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024 ]
+
+      snps,rx-ts-max:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Maximal size of Rx DMA transactions in FIFO words
+        enum: [ 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024 ]
+
+...
diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
new file mode 100644
index 000000000000..5afa4b57ce20
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/snps,dwc-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DWC AHCI SATA controller
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description:
+  This document defines device tree bindings for the generic Synopsys DWC
+  implementation of the AHCI SATA controller.
+
+allOf:
+  - $ref: snps,dwc-ahci-common.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - description: Synopsys AHCI SATA-compatible devices
+        const: snps,dwc-ahci
+      - description: SPEAr1340 AHCI SATA device
+        const: snps,spear-ahci
+      - description: Rockhip RK3568 AHCI controller
+        items:
+          - const: rockchip,rk3568-dwc-ahci
+          - const: snps,dwc-ahci
+
+patternProperties:
+  "^sata-port@[0-9a-e]$":
+    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/ata/ahci.h>
+
+    sata@122f0000 {
+      compatible = "snps,dwc-ahci";
+      reg = <0x122F0000 0x1ff>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+
+      clocks = <&clock1>, <&clock2>;
+      clock-names = "aclk", "ref";
+
+      phys = <&sata_phy>;
+      phy-names = "sata-phy";
+
+      ports-implemented = <0x1>;
+
+      sata-port@0 {
+        reg = <0>;
+
+        hba-port-cap = <HBA_PORT_FBSCP>;
+
+        snps,tx-ts-max = <512>;
+        snps,rx-ts-max = <512>;
+      };
+    };
+
+...
-- 
2.35.1

