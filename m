Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0D64676F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380660AbhLCMGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:06:19 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42790 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhLCMGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:06:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B3C2jXr006403;
        Fri, 3 Dec 2021 06:02:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638532965;
        bh=S1Ea7K+gwD3KhW7hZpn2lGhgj5Q5jpH2NygDW4si5zQ=;
        h=From:To:CC:Subject:Date;
        b=BJWqb8rzyAIcHkKQr9itWdj5uVBInK7AMNMxJhmQ22sxebML19DwoA1vcxEeJVDlL
         mRen4fZ+lA9byA6qUzk6vj0cBTJ830/EsN/PX7Ozmd6K+pIghYNsOG/fi9asfrDm8n
         /Sq2t6TCOJXEW7+ix8xD3bxyc3eQ+5cY0RRGwsV4=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B3C2job116713
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Dec 2021 06:02:45 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Dec 2021 06:02:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Dec 2021 06:02:45 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B3C2iue045722;
        Fri, 3 Dec 2021 06:02:44 -0600
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <robh+dt@kernel.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <peter.ujfalusi@gmail.com>, <j-choudhary@ti.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] ASoC: dt-bindings: davinci-mcasp: convert McASP bindings to yaml schema
Date:   Fri, 3 Dec 2021 17:32:43 +0530
Message-ID: <20211203120243.24173-1-j-choudhary@ti.com>
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
'#sound-dai-cells' and 'port' which were missing from txt file.
Removes properties 'sram-size-playback' and 'sram-size-capture'
since they are not used.
Adds 'dmas' and 'dma-names' in the example which were missing from
the txt file.
Changes 'interrupts' and 'interrupt-names' from optional to
required properties.
Changes 'op-mode', 'serial-dir' and 'tdm-slots' to optional properties
as they are not needed if the McASP is used only as GPIO.

Adds the yaml file in the 'MAINTAINERS' under the heading 'TEXAS
INSTRUMENTS ASoC DRIVERS'

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
Changelog:
v4:
- changes the commit message
- adds type and description to relevant properties
- changes maxItems for 'serial-dir'
- removes properties 'sram-size-playback' and 'sram-size-capture'
  as they are not used
- removes 'function-gpios'
- removes 'num-serializer'
- marks 'tdm-slots', 'serial-dir' and 'op-mode' as optional properties
- adds the yaml file in MAINTAINERS

v3:
- removes maxItems from 'clock-names'

v2:
- changes the commit message
- modifies the properties 'clocks', 'clock-names', 'dma-names',
  'dmas', 'interrupts' and 'interrupt-names' according to the
  arm SOCs
- adds 'ports' and 'num-serializer' as node properties

 .../bindings/sound/davinci-mcasp-audio.txt    |  86 --------
 .../bindings/sound/davinci-mcasp-audio.yaml   | 185 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 3 files changed, 186 insertions(+), 86 deletions(-)
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
index 000000000000..5b553c90771a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
@@ -0,0 +1,185 @@
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
+      - description: main registers
+      - description: data port register
+
+  reg-names:
+    minItems: 1
+    items:
+      - const: mpu
+      - const: dat
+
+  op-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: I2S - 0 or DIT - 1 operation mode
+    enum:
+      - 0
+      - 1
+
+  tdm-slots:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: number of channels over one serializer
+    maxItems: 1
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
+      default: 0
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
+    description: configures WFIFO threshold
+    maxItems: 1
+
+  rx-num-evt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: configures RFIFO threshold
+    maxItems: 1
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
+          - description: TX FIFO interrupt
+          - description: RX FIFO interrupt
+      - items:
+          - description: common FIFO interrupt
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
+    maxItems: 1
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
index 00ad0cb5cb05..3fdf1e23f7d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18855,6 +18855,7 @@ TEXAS INSTRUMENTS ASoC DRIVERS
 M:	Peter Ujfalusi <peter.ujfalusi@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
 F:	sound/soc/ti/
 
 TEXAS INSTRUMENTS' DAC7612 DAC DRIVER
-- 
2.17.1

