Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D189D4E9B78
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbiC1Pqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238961AbiC1PqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:46:09 -0400
Received: from mail.baikalelectronics.ru (mail.baikalelectronics.com [87.245.175.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04A184A934;
        Mon, 28 Mar 2022 08:44:14 -0700 (PDT)
Received: from mail.baikalelectronics.ru (unknown [192.168.51.25])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id A0E721E28CD;
        Thu, 24 Mar 2022 03:16:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.ru A0E721E28CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1648080992;
        bh=lqzTR09cR0KHOMzPR1kyUT27q7dvvXtiTzMa2H1eJEI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=WPaTzevrRmp2VeBYtusfXiIj/D9RVshX+jYRiCAXEJXsyB2Bhf/E5wOdbCIoXrsgW
         x8XkVcsixFP9HLBfhalyqPTJVcW91bhp9njvtTCMHaEnanCRxz9Sj7fMU0bLRF+5mu
         XZffu/w61WKGP7tOY5FsqqW3BYi/UCwIQ13JVD/0=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 24 Mar 2022 03:16:32 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 02/21] dt-bindings: ata: Convert AHCI-bindings to DT schema
Date:   Thu, 24 Mar 2022 03:16:09 +0300
Message-ID: <20220324001628.13028-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the DT bindings of Generic AHCI Controllers are described by
means of the legacy text file. Since such format is deprecated in favor of
the DT schema. Let's convert the Generic AHCI Controllers bindings file
then to the corresponding yaml files. There will be two of them: a DT
schema with a set of properties applied to all AHCI-compatible devices,
and a DT schema validating an AHCI-controller on a generic platform. So if
a controller conforms to the Serial ATA AHCI interface specification with
just peculiar platform environment settings like clock sources, PHYs,
power regulators or resets, then the generic AHCI bindings should work for
it. Otherwise a dedicated DT-schema needs to be created.

So a common AHCI SATA controller DT-node is supposed to be equipped with
at least compatible, reg and interrupts properties. It can optionally
contain clocks, resets, {ahci,target,phy}-supply and phys phandles. In
addition the property "ports-implemented" can be specified in order to
define the number of implemented SATA ports. An AHCI SATA controller
DT-node can also have a set of sub-nodes representing its ports, for each
of which an individual power source and PHY phandle can be specified.

Note we have omitted the next compatible strings
"marvell,armada-380-ahci", "marvell,armada-3700-ahci", "snps,dwc-ahci",
"snps,spear-ahci" since the corresponding controllers are handled by the
dedicated drivers now, thus are supposed to have their own DT-schema
defined. dma-coherent has also been discarded since it's a generic
property and is evaluated by the dt-schema parser.

Also note that if there is the "reg-names" property specified for a AHCI
DT-node then it is supposed to at least have the "ahci" sub-string as an
indicator of the AHCI-compatible registers space.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 .../devicetree/bindings/ata/ahci-common.yaml  | 110 ++++++++++++++++++
 .../devicetree/bindings/ata/ahci-platform.txt |  79 -------------
 .../devicetree/bindings/ata/generic-ahci.yaml |  89 ++++++++++++++
 3 files changed, 199 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-common.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.txt
 create mode 100644 Documentation/devicetree/bindings/ata/generic-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
new file mode 100644
index 000000000000..054819930538
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
@@ -0,0 +1,110 @@
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
+  - Jens Axboe <axboe@kernel.dk>
+
+description: |
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
+    contains:
+      const: ahci
+
+  interrupts:
+    description:
+      Generic AHCI state change interrupt. Can be implemented either as a
+      single lane attached to the controller for all global and ports events
+      or as a set of signals for the global and each port.
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
+      List of all the reset control lines to successfully reset the
+      controller clock domains.
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
+    const: sata-phy
+
+  ports-implemented:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Mask that indicates which ports the HBA supports. Useful if PI is not
+      programmed by the BIOS, which is true for some embedded SoC's.
+
+patternProperties:
+  "^sata-port@[0-9a-e]$":
+    description:
+      It is optionally possible to describe the ports as sub-nodes so
+      to enable each port independently when dealing with multiple PHYs.
+    type: object
+
+    properties:
+      reg:
+        description:
+          By design AHCI controller can't work with more than 32 ports
+          due to the CAP.NP fields and PI register size constraints.
+        minimum: 0
+        maximum: 31
+
+      phys:
+        description: Individual AHCI SATA port PHY
+        maxItems: 1
+
+      phy-names:
+        const: sata-phy
+
+      target-supply:
+        description: Power regulator for SATA port target device
+
+    required:
+      - reg
+
+required:
+  - reg
+  - interrupts
+
+additionalProperties: true
+
+...
diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
deleted file mode 100644
index 77091a277642..000000000000
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ /dev/null
@@ -1,79 +0,0 @@
-* AHCI SATA Controller
-
-SATA nodes are defined to describe on-chip Serial ATA controllers.
-Each SATA controller should have its own node.
-
-It is possible, but not required, to represent each port as a sub-node.
-It allows to enable each port independently when dealing with multiple
-PHYs.
-
-Required properties:
-- compatible        : compatible string, one of:
-  - "brcm,iproc-ahci"
-  - "hisilicon,hisi-ahci"
-  - "cavium,octeon-7130-ahci"
-  - "ibm,476gtr-ahci"
-  - "marvell,armada-380-ahci"
-  - "marvell,armada-3700-ahci"
-  - "snps,dwc-ahci"
-  - "snps,spear-ahci"
-  - "generic-ahci"
-- interrupts        : <interrupt mapping for SATA IRQ>
-- reg               : <registers mapping>
-
-Please note that when using "generic-ahci" you must also specify a SoC specific
-compatible:
-	compatible = "manufacturer,soc-model-ahci", "generic-ahci";
-
-Optional properties:
-- dma-coherent      : Present if dma operations are coherent
-- clocks            : a list of phandle + clock specifier pairs
-- resets            : a list of phandle + reset specifier pairs
-- target-supply     : regulator for SATA target power
-- phy-supply        : regulator for PHY power
-- phys              : reference to the SATA PHY node
-- phy-names         : must be "sata-phy"
-- ahci-supply       : regulator for AHCI controller
-- ports-implemented : Mask that indicates which ports that the HBA supports
-		      are available for software to use. Useful if PORTS_IMPL
-		      is not programmed by the BIOS, which is true with
-		      some embedded SOC's.
-
-Required properties when using sub-nodes:
-- #address-cells    : number of cells to encode an address
-- #size-cells       : number of cells representing the size of an address
-
-Sub-nodes required properties:
-- reg		    : the port number
-And at least one of the following properties:
-- phys		    : reference to the SATA PHY node
-- target-supply     : regulator for SATA target power
-
-Examples:
-        sata@ffe08000 {
-		compatible = "snps,spear-ahci";
-		reg = <0xffe08000 0x1000>;
-		interrupts = <115>;
-        };
-
-With sub-nodes:
-	sata@f7e90000 {
-		compatible = "marvell,berlin2q-achi", "generic-ahci";
-		reg = <0xe90000 0x1000>;
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&chip CLKID_SATA>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		sata0: sata-port@0 {
-			reg = <0>;
-			phys = <&sata_phy 0>;
-			target-supply = <&reg_sata0>;
-		};
-
-		sata1: sata-port@1 {
-			reg = <1>;
-			phys = <&sata_phy 1>;
-			target-supply = <&reg_sata1>;;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/ata/generic-ahci.yaml b/Documentation/devicetree/bindings/ata/generic-ahci.yaml
new file mode 100644
index 000000000000..957f45c4f488
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/generic-ahci.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/generic-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic AHCI SATA controller
+
+maintainers:
+  - Hans de Goede <hdegoede@redhat.com>
+  - Jens Axboe <axboe@kernel.dk>
+
+description: |
+  This document defines device tree bindings for the controllers conforming
+  to the generic AHCI SATA interface.
+
+allOf:
+  - $ref: ahci-common.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - description: Generic AHCI SATA device
+        const: generic-ahci
+      - description: Broadcom IPROC AHCI SATA device
+        items:
+          - const: brcm,iproc-ahci
+          - const: generic-ahci
+      - description: HiSilicon AHCI SATA device
+        const: hisilicon,hisi-ahci
+      - description: Cavium Octeon 7130 AHCI SATA device
+        const: octeon-7130-ahci
+      - description: IBM Akebono AHCI SATA device
+        const: ibm,476gtr-ahci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+    #include <dt-bindings/clock/hix5hd2-clock.h>
+
+    sata@1900000 {
+      compatible = "hisilicon,hisi-ahci";
+      reg = <0x1900000 0x10000>;
+
+      interrupts = <0 70 4>;
+
+      clocks = <&clock HIX5HD2_SATA_CLK>;
+
+      phys = <&sata_phy>;
+      phy-names = "sata-phy";
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    sata@663f2000 {
+      compatible = "brcm,iproc-ahci", "generic-ahci";
+      reg = <0x663f2000 0x1000>;
+      reg-names = "ahci";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      dma-coherent;
+
+      interrupts = <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>;
+
+      sata-port@0 {
+        reg = <0>;
+        phys = <&sata_phy0>;
+        phy-names = "sata-phy";
+      };
+
+      sata-port@1 {
+        reg = <1>;
+        phys = <&sata_phy1>;
+        phy-names = "sata-phy";
+      };
+    };
+...
-- 
2.35.1

