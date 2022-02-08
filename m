Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AEC4AD6FA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349631AbiBHLaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356470AbiBHKt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:49:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3620FC03FEC0;
        Tue,  8 Feb 2022 02:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644317368; x=1675853368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S1gftKaYgRVlWT8LHhLQHW2YcgyuvKJJFSYmqWNRzww=;
  b=mrOQZeNtlGA/u2fHBxqsnV4OfNLpxZpJbE2evX+Pd9iKvKyulHTyN8Vj
   tXDkKhY+Du9l8sCjOq6Kcfn3QpzktOM4meIneM6wUa69RWHb+A6zDYI42
   8IQorgdEO+LK7YRhfzHxq++coGnzjucFyppuuz1cA5wIlbLZ1e36Aoyg8
   mQsRlHjaArdA1B2swUT1lR0PUExN4/Ch4CmR+XNE/sekt7igzQ0Zojj3T
   HUvTF0Wp8yCngAvC/NGR9ZxG0u8JYO4Umu0CRKMUOT2o8LuXZOPhkxd98
   xgVZSw6J0SCIIXzgz7Kzh3cmhfyA9vdCXTI9Bw/rQ71wpqCkdTVuBj/za
   w==;
IronPort-SDR: dfH9SZszMf+DGfuE/bSUHGRzi0aP3ldUTXgnQqYeq+CsG8Nke37i2VZZFacsOTUH35cWWd2t5I
 0wMItFuQpHbVvU6K3xDfFFGdu3CMDU1uGBvEutZGPU+rHI+gfW9Q2q5b26lV6icniAyzvMunQJ
 pM/cm85JxlQjtR4WRXCMVfQEhl6STTHTn+/ALgjDxNw3LwUEt8zjRgdsQiYk7vdm/qI7DeRcjs
 6Dpdjbi3jXOrkA3L3wh7v6Z9RGZ5+pRUmxeVNuvdWTh82EihePXoB9cLwRlzb/pRRoW0KlISRN
 At9W20RtgftmVfIlt5VlcYYd
X-IronPort-AV: E=Sophos;i="5.88,352,1635231600"; 
   d="scan'208";a="152826403"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Feb 2022 03:49:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Feb 2022 03:49:27 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 8 Feb 2022 03:49:24 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>, <krzysztof.kozlowski@canonical.com>
CC:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Date:   Tue, 8 Feb 2022 12:49:16 +0200
Message-ID: <20220208104918.226156-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208104918.226156-1-tudor.ambarus@microchip.com>
References: <20220208104918.226156-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Atmel AES documentation to yaml format. With the conversion the
clock and clock-names properties are made mandatory. The driver returns
-EINVAL if "aes_clk" is not found, reflect that in the bindings and make
the clock and clock-names properties mandatory. Update the example to
better describe how one should define the dt node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 .../crypto/atmel,at91sam9g46-aes.yaml         | 65 +++++++++++++++++++
 .../bindings/crypto/atmel-crypto.txt          | 20 ------
 2 files changed, 65 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
new file mode 100644
index 000000000000..146ff9c7b60e
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/atmel,at91sam9g46-aes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Advanced Encryption Standard (AES) HW cryptographic accelerator
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@microchip.com>
+
+properties:
+  compatible:
+    const: atmel,at91sam9g46-aes
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: aes_clk
+
+  dmas:
+    items:
+      - description: TX DMA Channel
+      - description: RX DMA Channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/dma/at91.h>
+
+    aes: crypto@f8038000 {
+      compatible = "atmel,at91sam9g46-aes";
+      reg = <0xe1810000 0x100>;
+      interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 27>;
+      clock-names = "aes_clk";
+      dmas = <&dma0 AT91_XDMAC_DT_PERID(1)>,
+             <&dma0 AT91_XDMAC_DT_PERID(2)>;
+      dma-names = "tx", "rx";
+    };
diff --git a/Documentation/devicetree/bindings/crypto/atmel-crypto.txt b/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
index f2aab3dc2b52..1353ebd0dcaa 100644
--- a/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
+++ b/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
@@ -2,26 +2,6 @@
 
 These are the HW cryptographic accelerators found on some Atmel products.
 
-* Advanced Encryption Standard (AES)
-
-Required properties:
-- compatible : Should be "atmel,at91sam9g46-aes".
-- reg: Should contain AES registers location and length.
-- interrupts: Should contain the IRQ line for the AES.
-- dmas: List of two DMA specifiers as described in
-        atmel-dma.txt and dma.txt files.
-- dma-names: Contains one identifier string for each DMA specifier
-             in the dmas property.
-
-Example:
-aes@f8038000 {
-	compatible = "atmel,at91sam9g46-aes";
-	reg = <0xf8038000 0x100>;
-	interrupts = <43 4 0>;
-	dmas = <&dma1 2 18>,
-	       <&dma1 2 19>;
-	dma-names = "tx", "rx";
-
 * Triple Data Encryption Standard (Triple DES)
 
 Required properties:
-- 
2.25.1

