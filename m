Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67B8564FC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiGDIcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiGDIcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:32:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A422DB4B5;
        Mon,  4 Jul 2022 01:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656923561; x=1688459561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SKOSvrvIla2F6prWk1w6EmMQnAI8EiyQXq/JXI5eSc8=;
  b=zegXMNi4sYURPo20Cx1CQW0DQH1LG9CIDsDm94+pc8P4Dh/QT/3668Cb
   /kt0GwhurNaj9qk41w/fv/5DgBayuD/eDDmwxEF8p9gbvpWGx3/H8o0X7
   hWmzef4WYQmBVkEKGfNPf8TwEpsjj4bbPvvo4ogdpcrBKkkTdiKiEhyl1
   pNj7Z/XEz/wa+Ne48S/WHNJ3HDQJqBvPOwBcBEXutxZ1d1H0q01a9bbEM
   aTofhDMKGOkJeZhwDgPGiA4zOLlxNFJCrQ6dbQQNKFWFf0HC1XhwCiGEh
   +u2K57t0HCUEMDAhQgM30qxIZ41h8wv85XKoUKHmhWU/Y3mZndrUGwOjy
   A==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="102886476"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jul 2022 01:32:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 4 Jul 2022 01:32:34 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 4 Jul 2022 01:32:29 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <tudor.ambarus@microchip.com>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v2] spi: atmel: convert spi_atmel to json-schema
Date:   Mon, 4 Jul 2022 11:31:43 +0300
Message-ID: <20220704083143.56150-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
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

Convert SPI DT binding for Atmel/Microchip SoCs to YAML schema.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---

v1 -> v2:
- change subject headline prefix from "dt-bindings: spi" to "spi: atmel"
- change maintainer
- kept the compatbile as items (instead of switching to enums) and at91rm9200
as fallback for sam9x60, since the evolution of IP's is incremental.
- removed unnecessay "cs-gpios" property and descriptions
- added min/max for fifo-size property.


 .../devicetree/bindings/spi/atmel,spi.yaml    | 77 +++++++++++++++++++
 .../devicetree/bindings/spi/spi_atmel.txt     | 36 ---------
 2 files changed, 77 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/atmel,spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt

diff --git a/Documentation/devicetree/bindings/spi/atmel,spi.yaml b/Documentation/devicetree/bindings/spi/atmel,spi.yaml
new file mode 100644
index 000000000000..d627fc9315bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/atmel,spi.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/atmel,spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel SPI device
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@microchip.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: atmel,at91rm9200-spi
+      - items:
+          - const: microchip,sam9x60-spi
+          - const: atmel,at91rm9200-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    contains:
+      const: spi_clk
+
+  clocks:
+    maxItems: 1
+
+  atmel,fifo-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Maximum number of data the RX and TX FIFOs can store for FIFO
+      capable SPI controllers.
+    minimum: 16
+    maximum: 32
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi1: spi@fffcc000 {
+        compatible = "atmel,at91rm9200-spi";
+        reg = <0xfffcc000 0x4000>;
+        interrupts = <13 IRQ_TYPE_LEVEL_HIGH 5>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&spi1_clk>;
+        clock-names = "spi_clk";
+        cs-gpios = <&pioB 3 GPIO_ACTIVE_HIGH>;
+        atmel,fifo-size = <32>;
+
+        mmc@0 {
+            compatible = "mmc-spi-slot";
+            reg = <0>;
+            gpios = <&pioC 4 GPIO_ACTIVE_HIGH>;    /* CD */
+            spi-max-frequency = <25000000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi_atmel.txt b/Documentation/devicetree/bindings/spi/spi_atmel.txt
deleted file mode 100644
index 5bb4a8f1df7a..000000000000
--- a/Documentation/devicetree/bindings/spi/spi_atmel.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Atmel SPI device
-
-Required properties:
-- compatible : should be "atmel,at91rm9200-spi" or "microchip,sam9x60-spi".
-- reg: Address and length of the register set for the device
-- interrupts: Should contain spi interrupt
-- cs-gpios: chipselects (optional for SPI controller version >= 2 with the
-  Chip Select Active After Transfer feature).
-- clock-names: tuple listing input clock names.
-	Required elements: "spi_clk"
-- clocks: phandles to input clocks.
-
-Optional properties:
-- atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
-  capable SPI controllers.
-
-Example:
-
-spi1: spi@fffcc000 {
-	compatible = "atmel,at91rm9200-spi";
-	reg = <0xfffcc000 0x4000>;
-	interrupts = <13 4 5>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clocks = <&spi1_clk>;
-	clock-names = "spi_clk";
-	cs-gpios = <&pioB 3 0>;
-	atmel,fifo-size = <32>;
-
-	mmc-slot@0 {
-		compatible = "mmc-spi-slot";
-		reg = <0>;
-		gpios = <&pioC 4 0>;	/* CD */
-		spi-max-frequency = <25000000>;
-	};
-};
-- 
2.25.1

