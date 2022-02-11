Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70104B222E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348703AbiBKJjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:39:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348692AbiBKJjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:39:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E9E4D;
        Fri, 11 Feb 2022 01:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644572371; x=1676108371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dvUkbyhAbfnFruUSVETo756vfkSDlZZDNN18L/VMz2Q=;
  b=IQRyA1NAtjsVxGmOn4mu7zg3OASkJHTUWaz5LA85NZHo+98DwfGWenPT
   Cl0R2hyLoiq65CWIWOeYyJNbtNkutj7Tj3BtcOIjwlqMAJTkfONPIneuh
   ZHgmqqyvDVF4UZinlMyTubftqFhoSUZU9T183E3jawY2D914Dk5Roe1rw
   ABSF98nWqWluJLviRh28LmyvecjUZkG7EZb2gwZINVqINonB6J2G8kQnX
   XI+KNYJROqlI5JA4g2pR66s0C2N9OI2or9lyOhbP9GmvO6kVc5CB2wSnq
   D+UndZxVWbKepXl427bUJiGdsdIh4yQLqjAvtGhGMvyfPMPYvzvDqtjWc
   Q==;
IronPort-SDR: 5r7sXJahiAhDyBCPfjOnW6BslTL5utcWGTfkJk4/HG/J9rcDdOLWEytEoSB4Dq/smWVyTTdhyd
 GbYg+Jj25czcZOIEwWAes581KOAU0dYTnsV1x8GT0LQpM9p2AYfyPL5IwsEdyhLCdnYICDHPwQ
 RnqFA/I8TLiFbBru720e/5bqHjurJHaueGehp9+SmzsOC5zUY1+qDkVhqkyyiorjjP45gjoE9s
 0ZV5NSA107uMg41HuyBtIi55nJo8oRSPy4TOl+AYh2Bq/pDGFtI3GdPs9wLln//Peb4rSDKbUY
 Qnn44WMaGjNDkmFELftZBeCU
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="153263768"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2022 02:39:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 02:39:31 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 11 Feb 2022 02:39:28 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>, <krzysztof.kozlowski@canonical.com>,
        <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PACTH v4 1/3] dt-bindings: crypto: Convert Atmel AES to yaml
Date:   Fri, 11 Feb 2022 11:39:20 +0200
Message-ID: <20220211093922.456634-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211093922.456634-1-tudor.ambarus@microchip.com>
References: <20220211093922.456634-1-tudor.ambarus@microchip.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../crypto/atmel,at91sam9g46-aes.yaml         | 66 +++++++++++++++++++
 .../bindings/crypto/atmel-crypto.txt          | 20 ------
 2 files changed, 66 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
new file mode 100644
index 000000000000..0ccaab16dc61
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-aes.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
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
+    aes: crypto@e1810000 {
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

