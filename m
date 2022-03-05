Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858B94CE494
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 12:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiCEL1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 06:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiCEL1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 06:27:13 -0500
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06B940A25;
        Sat,  5 Mar 2022 03:26:22 -0800 (PST)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout2.routing.net (Postfix) with ESMTP id F35BD5FBFE;
        Sat,  5 Mar 2022 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1646479581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTV1xdOBqDO16+gerFGDl04Vvm4klTkftcSfewYgx6I=;
        b=CtGvlIRLG7LITJ//B1/j/XOMBJPGpi8rCTzbev1PxxkIEyv6oNo8bXgSPimc9vr1SDn3+X
        /3XI1H3WTCruxJe4+kS/weCu0OIiITglaW7zdlaGFpq2r6pIHeg5jkccXOHnLG/p/zwefm
        qsD6dHP3MtwMZeQzyyLcQ5G7FCTHPi0=
Received: from localhost.localdomain (fttx-pool-217.61.157.101.bambit.de [217.61.157.101])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 031311007BC;
        Sat,  5 Mar 2022 11:26:19 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v5 1/5] dt-bindings: ata: ahci-platform: Convert DT bindings to yaml
Date:   Sat,  5 Mar 2022 12:26:03 +0100
Message-Id: <20220305112607.257734-2-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305112607.257734-1-linux@fw-web.de>
References: <20220305112607.257734-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: e7dc101d-d7d6-43d3-8dfc-70946311db46
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Create a yaml file for dtbs_check from the old txt binding.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---

v5:
  - change subject
  - drop brcm,iproc-ahci from standalone enum
  - fix reg address in example 2
  - move clocknames next to clocks, regnames to reg
  - drop interrupts description
  - drop newline from dma-coherent
  - drop max-items from ports-implemented
  - min2max in child phys
  - fix identation for compatible and sata-common
  - add additionalProperties=false for subnodes
  - pipe for paragraphs and newline after title
  - add maximum for ports-implemented (found only 0x1 as its value)
  - add phy-names to sata-ports

v4:
  - fix min vs. max
  - fix indention of examples
  - move up sata-common.yaml
  - reorder compatible
  - add descriptions/maxitems
  - fix compatible-structure
  - fix typo in example achi vs. ahci
  - add clock-names and reg-names
  - fix ns2 errors in separate patch
v3:
  - add conversion to sata-series
  - fix some errors in dt_binding_check and dtbs_check
  - move to unevaluated properties = false

---
 .../devicetree/bindings/ata/ahci-platform.txt |  79 ---------
 .../bindings/ata/ahci-platform.yaml           | 163 ++++++++++++++++++
 2 files changed, 163 insertions(+), 79 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.txt
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.yaml

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
diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
new file mode 100644
index 000000000000..fae042539824
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -0,0 +1,163 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AHCI SATA Controller
+
+description: |
+  SATA nodes are defined to describe on-chip Serial ATA controllers.
+  Each SATA controller should have its own node.
+
+  It is possible, but not required, to represent each port as a sub-node.
+  It allows to enable each port independently when dealing with multiple
+  PHYs.
+
+maintainers:
+  - Hans de Goede <hdegoede@redhat.com>
+  - Jens Axboe <axboe@kernel.dk>
+
+allOf:
+  - $ref: "sata-common.yaml#"
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - brcm,iproc-ahci
+              - marvell,armada-8k-ahci
+              - marvell,berlin2q-ahci
+          - const: generic-ahci
+      - enum:
+          - cavium,octeon-7130-ahci
+          - hisilicon,hisi-ahci
+          - ibm,476gtr-ahci
+          - marvell,armada-3700-ahci
+          - marvell,armada-380-ahci
+          - snps,dwc-ahci
+          - snps,spear-ahci
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    maxItems: 1
+
+  clocks:
+    description:
+      Clock IDs array as required by the controller.
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    description:
+      Names of clocks corresponding to IDs in the clock property.
+    minItems: 1
+    maxItems: 3
+
+  interrupts:
+    maxItems: 1
+
+  ahci-supply:
+    description:
+      regulator for AHCI controller
+
+  dma-coherent: true
+
+  phy-supply:
+    description:
+      regulator for PHY power
+
+  phys:
+    description:
+      List of all PHYs on this controller
+    maxItems: 1
+
+  phy-names:
+    description:
+      Name specifier for the PHYs
+    maxItems: 1
+
+  ports-implemented:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: |
+      Mask that indicates which ports that the HBA supports
+      are available for software to use. Useful if PORTS_IMPL
+      is not programmed by the BIOS, which is true with
+      some embedded SoCs.
+    maximum: 0x1
+
+  resets:
+    maxItems: 1
+
+  target-supply:
+    description:
+      regulator for SATA target power
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+patternProperties:
+  "^sata-port@[0-9a-f]+$":
+    type: object
+    additionalProperties: false
+    description:
+      Subnode with configuration of the Ports.
+
+    properties:
+      reg:
+        maxItems: 1
+
+      phys:
+        maxItems: 1
+
+      phy-names:
+        maxItems: 1
+
+      target-supply:
+        description:
+          regulator for SATA target power
+
+    required:
+      - reg
+
+    anyOf:
+      - required: [ phys ]
+      - required: [ target-supply ]
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sata@ffe08000 {
+           compatible = "snps,spear-ahci";
+           reg = <0xffe08000 0x1000>;
+           interrupts = <115>;
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/berlin2q.h>
+    sata@f7e90000 {
+            compatible = "marvell,berlin2q-ahci", "generic-ahci";
+            reg = <0xf7e90000 0x1000>;
+            interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&chip CLKID_SATA>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            sata0: sata-port@0 {
+                    reg = <0>;
+                    phys = <&sata_phy 0>;
+                    target-supply = <&reg_sata0>;
+            };
+
+            sata1: sata-port@1 {
+                    reg = <1>;
+                    phys = <&sata_phy 1>;
+                    target-supply = <&reg_sata1>;
+            };
+    };
-- 
2.25.1

