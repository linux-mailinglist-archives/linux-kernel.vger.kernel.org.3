Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA8D5240D2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243474AbiEKXSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349078AbiEKXSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:18:31 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C15B216D493;
        Wed, 11 May 2022 16:18:18 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 448E5BAA;
        Thu, 12 May 2022 02:19:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru 448E5BAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1652311143;
        bh=eYQTdTFiuKMN8dk9M7tHXCo0FFs1oCN6A8blXJKSbZU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=lKCNks04eQjrXZ2wzpZWlDWOs60cAf/VO9K6xHqDE3wnv1W+WxqIRjFGWdjDKL5Hc
         X09FMlySc8lKO/G10hKTIsUGhXyTg9VwvUXrnK0qzl1g1pgCYMYg3HUhNoAHM7/p34
         gjvHvgZamBR1Qf463iE1Nnik1esZDgOVX8+kesr8=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 12 May 2022 02:18:15 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 02/23] dt-bindings: ata: ahci-platform: Detach common AHCI bindings
Date:   Thu, 12 May 2022 02:17:49 +0300
Message-ID: <20220511231810.4928-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to create a more sophisticated AHCI controller DT bindings let's
divide the already available generic AHCI platform YAML schema into the
platform part and a set of the common AHCI properties. The former part
will be used to evaluate the AHCI DT nodes mainly compatible with the
generic AHCI controller while the later schema will be used for more
thorough AHCI DT nodes description. For instance such YAML schemas design
will be useful for our DW AHCI SATA controller derivative with four clock
sources, two reset lines, one system controller reference and specific
max Rx/Tx DMA xfers size constraints.

Note the phys and target-supply property requirement is preserved in the
generic AHCI platform bindings because some platforms can lack of the
explicitly specified PHYs or target device power regulators.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Folks, I don't really see why the phys/target-supply requirement has been
added to the generic AHCI DT schema in the first place. Probably just to
imply some meaning for the sub-nodes definition. Anyway in one of the
further patches I am adding the DW AHCI SATA controller DT bindings which
won't require having these properties specified in the sub-nodes, but will
describe additional port-specific properties. That's why I get to keep the
constraints in the ahci-platform.yaml schema instead of moving them to the
common schema.

Changelog v2:
- This is a new patch created after rebasing v1 onto the 5.18-rc3 kernel.

Changelog v3:
- Replace Jens's email address with Damien's one in the list of the
  schema maintainers. (@Damien)
---
 .../devicetree/bindings/ata/ahci-common.yaml  | 117 ++++++++++++++++++
 .../bindings/ata/ahci-platform.yaml           |  68 +---------
 2 files changed, 123 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml

diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
new file mode 100644
index 000000000000..620042ca12e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/ahci-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for Serial ATA AHCI controllers
+
+maintainers:
+  - Hans de Goede <hdegoede@redhat.com>
+  - Damien Le Moal <damien.lemoal@opensource.wdc.com>
+
+description:
+  This document defines device tree properties for a common AHCI SATA
+  controller implementation. It's hardware interface is supposed to
+  conform to the technical standard defined by Intel (see Serial ATA
+  Advanced Host Controller Interface specification for details). The
+  document doesn't constitute a DT-node binding by itself but merely
+  defines a set of common properties for the AHCI-compatible devices.
+
+select: false
+
+allOf:
+  - $ref: sata-common.yaml#
+
+properties:
+  reg:
+    description:
+      Generic AHCI registers space conforming to the Serial ATA AHCI
+      specification.
+
+  reg-names:
+    description: CSR space IDs
+
+  interrupts:
+    description:
+      Generic AHCI state change interrupt. Can be implemented either as a
+      single line attached to the controller as a set of the dedicated signals
+      for the global and particular port events.
+
+  clocks:
+    description:
+      List of all the reference clocks connected to the controller.
+
+  clock-names:
+    description: Reference clocks IDs
+
+  resets:
+    description:
+      List of the reset control lines to reset the controller clock
+      domains.
+
+  reset-names:
+    description: Reset line IDs
+
+  power-domains:
+    description:
+      List of the power domain the AHCI controller being a part of.
+
+  ahci-supply:
+    description: Power regulator for AHCI controller
+
+  target-supply:
+    description: Power regulator for SATA target device
+
+  phy-supply:
+    description: Power regulator for SATA PHY
+
+  phys:
+    description: Reference to the SATA PHY node
+    maxItems: 1
+
+  phy-names:
+    maxItems: 1
+
+  ports-implemented:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description:
+      Mask that indicates which ports the HBA supports. Useful if PI is not
+      programmed by the BIOS, which is true for some embedded SoC's.
+    maximum: 0x1f
+
+patternProperties:
+  "^sata-port@[0-9a-f]+$":
+    type: object
+    description:
+      It is optionally possible to describe the ports as sub-nodes so
+      to enable each port independently when dealing with multiple PHYs.
+
+    properties:
+      reg:
+        description: AHCI SATA port identifier
+        maxItems: 1
+
+      phys:
+        description: Individual AHCI SATA port PHY
+        maxItems: 1
+
+      phy-names:
+        description: AHCI SATA port PHY ID
+        maxItems: 1
+
+      target-supply:
+        description: Power regulator for SATA port target device
+
+    required:
+      - reg
+
+    additionalProperties: true
+
+required:
+  - reg
+  - interrupts
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index 9304e4731965..76075d3c8987 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -36,8 +36,7 @@ select:
     - compatible
 
 allOf:
-  - $ref: "sata-common.yaml#"
-
+  - $ref: "ahci-common.yaml#"
 
 properties:
   compatible:
@@ -69,90 +68,35 @@ properties:
     maxItems: 1
 
   clocks:
-    description:
-      Clock IDs array as required by the controller.
     minItems: 1
     maxItems: 3
 
   clock-names:
-    description:
-      Names of clocks corresponding to IDs in the clock property.
     minItems: 1
     maxItems: 3
 
   interrupts:
     maxItems: 1
 
-  ahci-supply:
-    description:
-      regulator for AHCI controller
-
-  phy-supply:
-    description:
-      regulator for PHY power
-
-  phys:
-    description:
-      List of all PHYs on this controller
-    maxItems: 1
-
-  phy-names:
-    description:
-      Name specifier for the PHYs
-    maxItems: 1
-
-  ports-implemented:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
-    description: |
-      Mask that indicates which ports that the HBA supports
-      are available for software to use. Useful if PORTS_IMPL
-      is not programmed by the BIOS, which is true with
-      some embedded SoCs.
-    maximum: 0x1f
-
   power-domains:
     maxItems: 1
 
   resets:
     maxItems: 1
 
-  target-supply:
-    description:
-      regulator for SATA target power
-
-required:
-  - compatible
-  - reg
-  - interrupts
-
 patternProperties:
   "^sata-port@[0-9a-f]+$":
     type: object
-    additionalProperties: false
-    description:
-      Subnode with configuration of the Ports.
-
-    properties:
-      reg:
-        maxItems: 1
-
-      phys:
-        maxItems: 1
-
-      phy-names:
-        maxItems: 1
-
-      target-supply:
-        description:
-          regulator for SATA target power
-
-    required:
-      - reg
 
     anyOf:
       - required: [ phys ]
       - required: [ target-supply ]
 
+required:
+  - compatible
+  - reg
+  - interrupts
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.1

