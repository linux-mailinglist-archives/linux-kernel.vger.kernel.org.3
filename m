Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69144482EC9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiACHop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:44:45 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41346 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiACHoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:44:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2037iTWD108765;
        Mon, 3 Jan 2022 01:44:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641195869;
        bh=YnsDpMHWivIbaEOl/sbqrKyULwETU8FZm0+z0c/965Q=;
        h=From:To:CC:Subject:Date;
        b=sWQsHNRNeYNFUwFdRJduGYjrVMLmpxbjqVE6lfofJsXCNjCC6ml0+UldTJNnL9Fi0
         3h2GCPF8poWFVz3Y5jsAhdsSztkSh/8vT0DHVicYpDxULgVQ3ZP3tfq+LVkp2EqwV/
         G9qeNAD5ugErrQXV3jKI3GEthtmGjFd2aWML8Ung=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2037iTLq055231
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Jan 2022 01:44:29 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 3
 Jan 2022 01:44:28 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 3 Jan 2022 01:44:28 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2037iSiR038283;
        Mon, 3 Jan 2022 01:44:28 -0600
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <robh+dt@kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <peter.ujfalusi@gmail.com>, <j-choudhary@ti.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] ASoC: dt-bindings: davinci-mcasp: convert McASP bindings to yaml schema
Date:   Mon, 3 Jan 2022 13:14:27 +0530
Message-ID: <20220103074427.4233-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the bindings for McASP controllers for TI SOCs from txt
to YAML schema.

Adds additional properties 'clocks', 'clock-names', 'power-domains',
'#sound-dai-cells' and 'port' which were missing from the txt file.
Removes properties 'sram-size-playback' and 'sram-size-capture'
since they are not used.
Adds 'dmas' and 'dma-names' in the example which were missing from
the txt file.
Changes 'interrupts' and 'interrupt-names' from optional to
required properties.
Changes 'op-modes', 'serial-dir' to optional properties as they are
not needed if the McASP is used only as GPIO.
Changes 'tdm-slots' to required property only for I2S operation mode.

Adds the yaml file in the 'MAINTAINERS' under the heading 'TEXAS
INSTRUMENTS ASoC DRIVERS'

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
Changelog:
v5:
- changes the commit message
- changes description for 'reg', 'op-mode', 'tx-num-evt',
  'rx-num-evt' and 'interrupts'
- adds minimum and maximum for 'tdm-slots'
- removes default from 'serial-dir'
- removes maxItems from 'tdm-slots', 'tx-num-evt', 'rx-num-evt' and
  'auxclk-fs-ratio' as they are of type uint32
- adds 'tdm-slots' as conditionally required property for I2S mode
  of operation

v4:
- changes the commit message
- adds type and description to relevant properties
- changes maxItems for 'serial-dir'
- removes properties 'sram-size-playback' and 'sram-size-capture'
  as they are not used
- removes 'function-gpios'
- removes 'num-serializer'
- marks 'tdm-slots', 'op-mode' and 'serial-dir' as optional properties
- adds the yaml file in MAINTAINERS

v3:
- remove maxItems from 'clock-names'

v2:
- changes the commit message
- modifies the properties 'clocks', 'clock-names', 'dma-names',
  'dmas', 'interrupts' and 'interrupt-names' according to the 
  arm SOCs
- adds 'ports' and 'num-serializer' as node properties

 .../bindings/sound/davinci-mcasp-audio.txt    |  86 --------
 .../bindings/sound/davinci-mcasp-audio.yaml   | 201 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 202 insertions(+), 86 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
deleted file mode 100644
index bd863bd69501..000000000000
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ /dev/null
@@ -1,86 +0,0 @@
-Texas Instruments McASP controller
-
-Required properties:
-- compatible :
-	"ti,dm646x-mcasp-audio"	: for DM646x platforms
-	"ti,da830-mcasp-audio"	: for both DA830 & DA850 platforms
-	"ti,am33xx-mcasp-audio"	: for AM33xx platforms (AM33xx, AM43xx, TI81xx)
-	"ti,dra7-mcasp-audio"	: for DRA7xx platforms
-	"ti,omap4-mcasp-audio"	: for OMAP4
-
-- reg : Should contain reg specifiers for the entries in the reg-names property.
-- reg-names : Should contain:
-         * "mpu" for the main registers (required). For compatibility with
-           existing software, it is recommended this is the first entry.
-         * "dat" for separate data port register access (optional).
-- op-mode : I2S/DIT ops mode. 0 for I2S mode. 1 for DIT mode used for S/PDIF,
-  	    IEC60958-1, and AES-3 formats.
-- tdm-slots : Slots for TDM operation. Indicates number of channels transmitted
-  	      or received over one serializer.
-- serial-dir : A list of serializer configuration. Each entry is a number
-               indication for serializer pin direction.
-               (0 - INACTIVE, 1 - TX, 2 - RX)
-- dmas: two element list of DMA controller phandles and DMA request line
-        ordered pairs.
-- dma-names: identifier string for each DMA request line in the dmas property.
-	     These strings correspond 1:1 with the ordered pairs in dmas. The dma
-	     identifiers must be "rx" and "tx".
-
-Optional properties:
-
-- ti,hwmods : Must be "mcasp<n>", n is controller instance starting 0
-- tx-num-evt : FIFO levels.
-- rx-num-evt : FIFO levels.
-- dismod : Specify the drive on TX pin during inactive slots
-	0 : 3-state
-	2 : logic low
-	3 : logic high
-	Defaults to 'logic low' when the property is not present
-- sram-size-playback : size of sram to be allocated during playback
-- sram-size-capture  : size of sram to be allocated during capture
-- interrupts : Interrupt numbers for McASP
-- interrupt-names : Known interrupt names are "tx" and "rx"
-- pinctrl-0: Should specify pin control group used for this controller.
-- pinctrl-names: Should contain only one value - "default", for more details
-  		 please refer to pinctrl-bindings.txt
-- fck_parent : Should contain a valid clock name which will be used as parent
-	       for the McASP fck
-- auxclk-fs-ratio: When McASP is bus master indicates the ratio between AUCLK
-		   and FS rate if applicable:
-		   AUCLK rate = auxclk-fs-ratio * FS rate
-
-Optional GPIO support:
-If any McASP pin need to be used as GPIO then the McASP node must have:
-...
-  gpio-controller
-  #gpio-cells = <2>;
-...
-
-When requesting a GPIO, the first parameter is the PIN index in McASP_P*
-registers.
-For example to request the AXR2 pin of mcasp8:
-function-gpios = <&mcasp8 2 0>;
-
-Or to request the ACLKR pin of mcasp8:
-function-gpios = <&mcasp8 29 0>;
-
-For generic gpio information, please refer to bindings/gpio/gpio.txt
-
-Example:
-
-mcasp0: mcasp0@1d00000 {
-	compatible = "ti,da830-mcasp-audio";
-	reg = <0x100000 0x3000>;
-	reg-names "mpu";
-	interrupts = <82>, <83>;
-	interrupt-names = "tx", "rx";
-	op-mode = <0>;		/* MCASP_IIS_MODE */
-	tdm-slots = <2>;
-	serial-dir = <
-			0 0 0 0	/* 0: INACTIVE, 1: TX, 2: RX */
-			0 0 0 0
-			0 0 0 1
-			2 0 0 0 >;
-	tx-num-evt = <1>;
-	rx-num-evt = <1>;
-};
diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
new file mode 100644
index 000000000000..f46c66bc6b2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
@@ -0,0 +1,201 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/davinci-mcasp-audio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: McASP Controller for TI SoCs
+
+maintainers:
+  - Jayesh Choudhary <j-choudhary@ti.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,dm646x-mcasp-audio
+      - ti,da830-mcasp-audio
+      - ti,am33xx-mcasp-audio
+      - ti,dra7-mcasp-audio
+      - ti,omap4-mcasp-audio
+
+  reg:
+    minItems: 1
+    items:
+      - description: CFG registers
+      - description: data registers
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: mpu
+      - const: dat
+
+  op-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: 0 - I2S or 1 - DIT operation mode
+    enum:
+      - 0
+      - 1
+
+  tdm-slots:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      number of channels over one serializer
+      the property is ignored in DIT mode
+    minimum: 2
+    maximum: 32
+
+  serial-dir:
+    description:
+      A list of serializer configuration
+      Entry is indication for serializer pin direction
+      0 - Inactive, 1 - TX, 2 - RX
+      All AXR pins should be present in the array even if inactive
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 25
+    items:
+      minimum: 0
+      maximum: 2
+
+  dmas:
+    minItems: 1
+    items:
+      - description: transmission DMA channel
+      - description: reception DMA channel
+
+  dma-names:
+    minItems: 1
+    items:
+      - const: tx
+      - const: rx
+
+  ti,hwmods:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Name of hwmod associated with McASP
+    maxItems: 1
+    deprecated: true
+
+  tx-num-evt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      configures WFIFO threshold
+      0 disables the FIFO use
+      if property is missing, then also FIFO use is disabled
+
+  rx-num-evt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      configures RFIFO threshold
+      0 disables the FIFO use
+      if property is missing, then also FIFO use is disabled
+
+  dismod:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      specify the drive on TX pin during inactive time slots
+      0 - 3-state, 2 - logic low, 3 - logic high
+    enum:
+      - 0
+      - 2
+      - 3
+    default: 2
+
+  interrupts:
+    anyOf:
+      - minItems: 1
+        items:
+          - description: TX interrupt
+          - description: RX interrupt
+      - items:
+          - description: common/combined interrupt
+
+  interrupt-names:
+    oneOf:
+      - minItems: 1
+        items:
+          - const: tx
+          - const: rx
+      - const: common
+
+  fck_parent:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: parent clock name for McASP fck
+    maxItems: 1
+
+  auxclk-fs-ratio:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: ratio of AUCLK and FS rate if applicable
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  clocks:
+    minItems: 1
+    items:
+      - description: functional clock
+      - description: module specific optional ahclkx clock
+      - description: module specific optional ahclkr clock
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: fck
+      - const: ahclkx
+      - const: ahclkr
+
+  power-domains:
+    description: phandle to the corresponding power-domain
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  port:
+    description: connection for when McASP is used via graph card
+    type: object
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - dmas
+  - dma-names
+  - interrupts
+  - interrupt-names
+
+allOf:
+  - if:
+      properties:
+        opmode:
+          enum:
+            - 0
+
+    then:
+      required:
+        - tdm-slots
+
+additionalProperties: false
+
+examples:
+  - |
+    mcasp0: mcasp0@1d00000 {
+      compatible = "ti,da830-mcasp-audio";
+      reg = <0x100000 0x3000>;
+      reg-names = "mpu";
+      interrupts = <82>, <83>;
+      interrupt-names = "tx", "rx";
+      op-mode = <0>;		/* MCASP_IIS_MODE */
+      tdm-slots = <2>;
+      dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
+      dma-names = "tx", "rx";
+      serial-dir = <
+          0 0 0 0	/* 0: INACTIVE, 1: TX, 2: RX */
+          0 0 0 0
+          0 0 0 1
+          2 0 0 0 >;
+      tx-num-evt = <1>;
+      rx-num-evt = <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5ea5655a29c3..ec6bde4efcae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18995,6 +18995,7 @@ TEXAS INSTRUMENTS ASoC DRIVERS
 M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
 F:	sound/soc/ti/
 
 TEXAS INSTRUMENTS' DAC7612 DAC DRIVER
-- 
2.17.1

