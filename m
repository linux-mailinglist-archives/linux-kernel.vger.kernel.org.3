Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F075329B5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237017AbiEXLub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiEXLu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:50:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615A72A709;
        Tue, 24 May 2022 04:50:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E59EC1F43B14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653393025;
        bh=jeLT50JLqlVRVb/Mw9cwiM57a6SZA+DS0GFPVnc6CFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Xs3kmbfBIDlWtUB9pUgMRmNwjQFDRQpVvpDP033s7nYE8OBbS+Vmyo2rU/4l8izM7
         3t5VEG/ygQHG1FvC91j/slt9hK0d5g6JFb2/vzwHBq2vINL8kbrZpH9zLeVR2uSD2N
         B0Lj6H9GrZ110YPiVjISuIvEk2Vcn6zCBk0iLnqqpkyDqk6vuGW5ppDV1H0JZexBtX
         veWBs0YsqXRA9dPeh7OoRoJSiHepv67/MJ3t46rw37MBXEB0dDmQCf+h2hpDuQ0Z0q
         wqq8btiM7WrPJSKI6Di4rMVuGsT/1fb8oN8iWn+g91c0ZB5jdLnvhSL2EqbrcbRoH7
         lYcGoKBmA4b0Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     gregkh@linuxfoundation.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3] dt-bindings: serial: mtk-uart: Convert txt to json-schema
Date:   Tue, 24 May 2022 13:50:19 +0200
Message-Id: <20220524115019.97246-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the mtk-uart documentation from freeform text to a json-schema.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

v3: Addressed issues found in Krzysztof's review
v2: Changed to also accept just "mediatek,mt6577-uart" as compatible.

 .../bindings/serial/mediatek,uart.yaml        | 120 ++++++++++++++++++
 .../devicetree/bindings/serial/mtk-uart.txt   |  59 ---------
 2 files changed, 120 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/mediatek,uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/mtk-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
new file mode 100644
index 000000000000..4ff27d6d4d5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/mediatek,uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Universal Asynchronous Receiver/Transmitter (UART)
+
+maintainers:
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+allOf:
+  - $ref: serial.yaml#
+
+description: |
+  The MediaTek UART is based on the basic 8250 UART and compatible
+  with 16550A, with enhancements for high speed baud rates and
+  support for DMA.
+
+properties:
+  compatible:
+    oneOf:
+      - const: mediatek,mt6577-uart
+      - items:
+          - enum:
+              - mediatek,mt2701-uart
+              - mediatek,mt2712-uart
+              - mediatek,mt6580-uart
+              - mediatek,mt6582-uart
+              - mediatek,mt6589-uart
+              - mediatek,mt6755-uart
+              - mediatek,mt6765-uart
+              - mediatek,mt6779-uart
+              - mediatek,mt6795-uart
+              - mediatek,mt6797-uart
+              - mediatek,mt7622-uart
+              - mediatek,mt7623-uart
+              - mediatek,mt7629-uart
+              - mediatek,mt7986-uart
+              - mediatek,mt8127-uart
+              - mediatek,mt8135-uart
+              - mediatek,mt8173-uart
+              - mediatek,mt8183-uart
+              - mediatek,mt8186-uart
+              - mediatek,mt8192-uart
+              - mediatek,mt8195-uart
+              - mediatek,mt8516-uart
+          - const: mediatek,mt6577-uart
+
+  reg:
+    description: The base address of the UART register bank
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: The clock the baudrate is derived from
+      - description: The bus clock for register accesses
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: baud
+      - const: bus
+
+  dmas:
+    items:
+      - description: phandle to TX DMA
+      - description: phandle to RX DMA
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    description:
+      The UART interrupt and optionally the RX in-band wakeup interrupt.
+    minItems: 1
+    items:
+      - const: uart
+      - const: wakeup
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    serial@11006000 {
+        compatible = "mediatek,mt6589-uart", "mediatek,mt6577-uart";
+        reg = <0x11006000 0x400>;
+        interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>,
+                     <GIC_SPI 52 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-names = "uart", "wakeup";
+        clocks = <&uart_clk>, <&bus_clk>;
+        clock-names = "baud", "bus";
+        pinctrl-0 = <&uart_pin>;
+        pinctrl-1 = <&uart_pin_sleep>;
+        pinctrl-names = "default", "sleep";
+    };
diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
deleted file mode 100644
index 113b5d6a2245..000000000000
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ /dev/null
@@ -1,59 +0,0 @@
-* MediaTek Universal Asynchronous Receiver/Transmitter (UART)
-
-Required properties:
-- compatible should contain:
-  * "mediatek,mt2701-uart" for MT2701 compatible UARTS
-  * "mediatek,mt2712-uart" for MT2712 compatible UARTS
-  * "mediatek,mt6580-uart" for MT6580 compatible UARTS
-  * "mediatek,mt6582-uart" for MT6582 compatible UARTS
-  * "mediatek,mt6589-uart" for MT6589 compatible UARTS
-  * "mediatek,mt6755-uart" for MT6755 compatible UARTS
-  * "mediatek,mt6765-uart" for MT6765 compatible UARTS
-  * "mediatek,mt6779-uart" for MT6779 compatible UARTS
-  * "mediatek,mt6795-uart" for MT6795 compatible UARTS
-  * "mediatek,mt6797-uart" for MT6797 compatible UARTS
-  * "mediatek,mt7622-uart" for MT7622 compatible UARTS
-  * "mediatek,mt7623-uart" for MT7623 compatible UARTS
-  * "mediatek,mt7629-uart" for MT7629 compatible UARTS
-  * "mediatek,mt7986-uart", "mediatek,mt6577-uart" for MT7986 compatible UARTS
-  * "mediatek,mt8127-uart" for MT8127 compatible UARTS
-  * "mediatek,mt8135-uart" for MT8135 compatible UARTS
-  * "mediatek,mt8173-uart" for MT8173 compatible UARTS
-  * "mediatek,mt8183-uart", "mediatek,mt6577-uart" for MT8183 compatible UARTS
-  * "mediatek,mt8186-uart", "mediatek,mt6577-uart" for MT8183 compatible UARTS
-  * "mediatek,mt8192-uart", "mediatek,mt6577-uart" for MT8192 compatible UARTS
-  * "mediatek,mt8195-uart", "mediatek,mt6577-uart" for MT8195 compatible UARTS
-  * "mediatek,mt8516-uart" for MT8516 compatible UARTS
-  * "mediatek,mt6577-uart" for MT6577 and all of the above
-
-- reg: The base address of the UART register bank.
-
-- interrupts:
-  index 0: an interrupt specifier for the UART controller itself
-  index 1: optional, an interrupt specifier with edge sensitivity on Rx pin to
-           support Rx in-band wake up. If one would like to use this feature,
-           one must create an addtional pinctrl to reconfigure Rx pin to normal
-           GPIO before suspend.
-
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names:
-  - "baud": The clock the baudrate is derived from
-  - "bus": The bus clock for register accesses (optional)
-
-For compatibility with older device trees an unnamed clock is used for the
-baud clock if the baudclk does not exist. Do not use this for new designs.
-
-Example:
-
-	uart0: serial@11006000 {
-		compatible = "mediatek,mt6589-uart", "mediatek,mt6577-uart";
-		reg = <0x11006000 0x400>;
-		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 52 IRQ_TYPE_EDGE_FALLING>;
-		clocks = <&uart_clk>, <&bus_clk>;
-		clock-names = "baud", "bus";
-		pinctrl-names = "default", "sleep";
-		pinctrl-0 = <&uart_pin>;
-		pinctrl-1 = <&uart_pin_sleep>;
-	};
-- 
2.35.1

