Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B3456741D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiGEQXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGEQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:23:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43221ADB9;
        Tue,  5 Jul 2022 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657038190; x=1688574190;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/QHjMYs0EiUiAP2vhF8+M6ohuoS7ottlSe6haN3fXeI=;
  b=uGVFf+BzTTB9p1jTAM8H8ttpMj+ThIzBD6j+xzCaDt3bL3f5LFqGiP5k
   Zn7gqSspoVqLkbgdHPnlEA9vOUPB5g15SKf6nFeaLyFsi/IvJSkq1INST
   +9kBwhk8F8GQTrx6XzU8lbGX1QBO5Hmci2UYqRkxudFx2iy2l6VBoLcGM
   TkIOkrsmbnjKKoql93dxFaoiFTTw2UKdpMbm1L6sxaXkxrgYfdCE1ahCb
   vgOEczLMqHYL+8Z4eePOW3WjnoLfH0IW/IgtOXRKXcQKVuNsMJ9dhJDmI
   3ReHlIsXzq48/4YL6qjhqhFW56PGiAPIHTlw/mw+ShppVzisCHz+fQner
   A==;
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="166456304"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 09:22:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 09:22:27 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 5 Jul 2022 09:22:27 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.berna@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH] dt-binding: sound: Convert atmel pdmic to json-schema
Date:   Tue, 5 Jul 2022 09:21:42 -0700
Message-ID: <20220705162142.17558-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Convert Atmel PDMIC devicetree binding to json-schema.
Change file naming to match json-schema naming.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 .../bindings/sound/atmel,sama5d2-pdmic.yaml   | 104 ++++++++++++++++++
 .../devicetree/bindings/sound/atmel-pdmic.txt |  55 ---------
 2 files changed, 104 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/atmel-pdmic.txt

diff --git a/Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml b/Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
new file mode 100644
index 000000000000..cb34c0fc4fc8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/atmel,sama5d2-pdmic.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/atmel,sama5d2-pdmic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel PDMIC driver under ALSA SoC architecture
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description:
+  Atmel Pulse Density Modulation Interface Controller
+  (PDMIC) peripheral is a mono PDM decoder module
+  that decodes an incoming PDM sample stream.
+
+properties:
+  compatible:
+    items:
+      - const: atmel,sama5d2-pdmic
+
+  reg:
+    description: Should contain PDMIC registers location and length.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Must contain an entry for each required entry in clock-names.
+      Please refer to clock-bindings.txt.
+
+    items:
+      - description: peripheral clock.
+      - description: generated clock.
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: gclk
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx
+
+  atmel,mic-min-freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The minimal frequency that the microphone supports.
+
+  atmel,mic-max-freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The maximal frequency that the microphone supports.
+
+  atmel,model:
+    description: The user-visible name of this sound card.
+    $ref: /schemas/types.yaml#/definitions/string
+    default: PDMIC
+
+  atmel,mic-offset:
+    $ref: /schemas/types.yaml#/definitions/int32
+    description: The offset that should be added.
+    default: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - dmas
+  - dma-names
+  - clock-names
+  - clocks
+  - atmel,mic-min-freq
+  - atmel,mic-max-freq
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pdmic: sound@f8018000 {
+              compatible = "atmel,sama5d2-pdmic";
+              reg = <0xf8018000 0x124>;
+              interrupts = <48 IRQ_TYPE_LEVEL_HIGH 7>;
+              dmas = <&dma0
+                      (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
+                      | AT91_XDMAC_DT_PERID(50))>;
+              dma-names = "rx";
+              clocks = <&pdmic_clk>, <&pdmic_gclk>;
+              clock-names = "pclk", "gclk";
+              pinctrl-names = "default";
+              pinctrl-0 = <&pinctrl_pdmic_default>;
+              atmel,model = "PDMIC@sama5d2_xplained";
+              atmel,mic-min-freq = <1000000>;
+              atmel,mic-max-freq = <3246000>;
+              atmel,mic-offset = <0x0>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/atmel-pdmic.txt b/Documentation/devicetree/bindings/sound/atmel-pdmic.txt
deleted file mode 100644
index e0875f17c229..000000000000
--- a/Documentation/devicetree/bindings/sound/atmel-pdmic.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-* Atmel PDMIC driver under ALSA SoC architecture
-
-Required properties:
-- compatible
-	Should be "atmel,sama5d2-pdmic".
-- reg
-	Should contain PDMIC registers location and length.
-- interrupts
-	Should contain the IRQ line for the PDMIC.
-- dmas
-	One DMA specifiers as described in atmel-dma.txt and dma.txt files.
-- dma-names
-	Must be "rx".
-- clock-names
-	Required elements:
-	- "pclk"	peripheral clock
-	- "gclk"	generated clock
-- clocks
-	Must contain an entry for each required entry in clock-names.
-	Please refer to clock-bindings.txt.
-- atmel,mic-min-freq
-	The minimal frequency that the micphone supports.
-- atmel,mic-max-freq
-	The maximal frequency that the micphone supports.
-
-Optional properties:
-- pinctrl-names, pinctrl-0
-	Please refer to pinctrl-bindings.txt.
-- atmel,model
-	The user-visible name of this sound card.
-	The default value is "PDMIC".
-- atmel,mic-offset
-	The offset that should be added.
-	The range is from -32768 to 32767.
-	The default value is 0.
-
-Example:
-	pdmic@f8018000 {
-				compatible = "atmel,sama5d2-pdmic";
-				reg = <0xf8018000 0x124>;
-				interrupts = <48 IRQ_TYPE_LEVEL_HIGH 7>;
-				dmas = <&dma0
-					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
-					| AT91_XDMAC_DT_PERID(50))>;
-				dma-names = "rx";
-				clocks = <&pdmic_clk>, <&pdmic_gclk>;
-				clock-names = "pclk", "gclk";
-
-				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_pdmic_default>;
-				atmel,model = "PDMIC @ sama5d2_xplained";
-				atmel,mic-min-freq = <1000000>;
-				atmel,mic-max-freq = <3246000>;
-				atmel,mic-offset = <0x0>;
-	};
-- 
2.34.1

