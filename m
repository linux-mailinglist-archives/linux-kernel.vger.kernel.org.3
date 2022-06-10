Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FD3545EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347535AbiFJITj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347364AbiFJISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:18:11 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69615233561;
        Fri, 10 Jun 2022 01:18:09 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 92B9116A3;
        Fri, 10 Jun 2022 11:18:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 92B9116A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849137;
        bh=tREhIctPbG6TtUn0LROFIgA2rsy12HWrOrKl/nPL4HE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=j9QBmc0bJC63Cnmvz3kFxCp4SCCxBJ8yKYg9YgN+jrYc0qVdy1jFJAANt1+fCprGy
         xIro6DXa/GvPcKXBKc6PHwOmM/MNZrrNWA2mqRYRxdLTrXRsmhjQ8sZmfBvY5TrD7x
         qxhGN3Q3EGsF050bz7OJNDyMYsMap0sTvTnWVuxU=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:18:05 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 02/23] dt-bindings: ata: ahci-platform: Detach common AHCI bindings
Date:   Fri, 10 Jun 2022 11:17:40 +0300
Message-ID: <20220610081801.11854-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
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

Also note the SATA/AHCI ports properties have been moved to the
$defs-paragraph of the schemas. It's done in order to create the
extendable properties hierarchy such that particular AHCI-controller
could add vendor-specific port properties.

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

Changelog v4:
- Drop clocks, clock-names, resets, reset-names and power-domains
  properties from the common schema. (@Rob)
- Create sata/ahci-port properties definition hierarchy so the sub-schemas
  would inherit and extend the ports properties of the super-schema. (@Rob)
---
 .../devicetree/bindings/ata/ahci-common.yaml  | 100 ++++++++++++++++++
 .../bindings/ata/ahci-platform.yaml           |  72 ++-----------
 .../devicetree/bindings/ata/sata-common.yaml  |   8 +-
 3 files changed, 115 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml

diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
new file mode 100644
index 000000000000..e89bda3b62cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
@@ -0,0 +1,100 @@
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
+      single line attached to the controller or as a set of the signals
+      indicating the particular port events.
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
+    $ref: '#/$defs/ahci-port'
+    description:
+      It is optionally possible to describe the ports as sub-nodes so
+      to enable each port independently when dealing with multiple PHYs.
+
+required:
+  - reg
+  - interrupts
+
+additionalProperties: true
+
+$defs:
+  ahci-port:
+    $ref: /schemas/ata/sata-common.yaml#/$defs/sata-port
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
+...
diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index 9304e4731965..15be98e0385b 100644
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
@@ -69,90 +68,37 @@ properties:
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
-    type: object
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
+    $ref: /schemas/ata/ahci-common.yaml#/$defs/ahci-port
 
     anyOf:
       - required: [ phys ]
       - required: [ target-supply ]
 
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
 unevaluatedProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/ata/sata-common.yaml b/Documentation/devicetree/bindings/ata/sata-common.yaml
index cb88d3e25e73..5a31a902618d 100644
--- a/Documentation/devicetree/bindings/ata/sata-common.yaml
+++ b/Documentation/devicetree/bindings/ata/sata-common.yaml
@@ -35,9 +35,15 @@ properties:
 
 patternProperties:
   "^sata-port@[0-9a-e]$":
+    $ref: '#/$defs/sata-port'
     description: |
       DT nodes for ports connected on the SATA host. The SATA port
       nodes will be named "sata-port".
+
+additionalProperties: true
+
+$defs:
+  sata-port:
     type: object
 
     properties:
@@ -49,6 +55,4 @@ patternProperties:
           multiplier making it possible to connect up to 15 disks to a single
           SATA port.
 
-additionalProperties: true
-
 ...
-- 
2.35.1

