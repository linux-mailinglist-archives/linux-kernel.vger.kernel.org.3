Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4381B4B200C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348020AbiBKIVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:21:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244536AbiBKIVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:21:35 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8759BE48;
        Fri, 11 Feb 2022 00:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644567691; x=1676103691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hxyhR77ViR8q7n8EHi/1/cOeFa7oAFpCu+JwfCywQ7I=;
  b=NfMm1FNGqkKd5ChEOV/cYhcng1CHF/Vl96D/9k6Rb6zW9fVpD5cg2UBG
   sdGOVinYngimyINyLrcaTFrd+Q3KyuxB7xKaQ4ch9qbfHsX+1WkDbeKhh
   64xmn6WJZGujB69mmfQwX9+PrhJXbZ2XBbtGyX5UXoYVTZeAbXzzjFdgP
   uubRGG2RWqQS+u9w2uVFfpBH6rqSaZmb48j87Jz6roJNZTTgEGlRzaopi
   hwAJuHzGcv0rKKkMDgqYfNNnzEZeKUn7uBFFJU9fcagVBgYtRFNTbOW44
   KLJRrSt/URkgXxQqTbbv6zPilhiOyA+lEngPr+d6mrqmzpNRJyO06V0Sr
   g==;
IronPort-SDR: 1wuMOUJKu5wG6usHx1WL7l8ZTj5k624+C7yRPcjbeWyYz3oi6Qz3brlwYNHv/XOXrjWzstVfrD
 JSNEAGHtSFcNySLsqbzbo51ZAVv0DXEp9fqsyxGrxFlYw7urj12H3RbPxb7GyDi/ffr7hjqFXD
 3yo1TrTiEDLO03obvUJ5m4ZK72KDW/I7pCYx1syPUm4hrintx/73WxRcVnpLua/6upAVMV+jhy
 tJgac9OHQcXz15CllZKT0dCFuir56tHQesthZLAP/DVwtUX6T5UvQW2inWe1NVSWY0h5BzLX23
 uOJadNGJ9NjolJkpWW8eE1o8
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="153253167"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2022 01:21:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Feb 2022 01:21:26 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 11 Feb 2022 01:21:22 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>, <krzysztof.kozlowski@canonical.com>,
        <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PACTH v3 2/3] dt-bindings: crypto: Convert Atmel TDES to yaml
Date:   Fri, 11 Feb 2022 10:21:13 +0200
Message-ID: <20220211082114.452911-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211082114.452911-1-tudor.ambarus@microchip.com>
References: <20220211082114.452911-1-tudor.ambarus@microchip.com>
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

Convert Atmel TDES documentation to yaml format. With the conversion the
clock and clock-names properties are made mandatory. The driver returns
-EINVAL if "tdes_clk" is not found, reflect that in the bindings and make
the clock and clock-names properties mandatory. Update the example to
better describe how one should define the dt node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 .../crypto/atmel,at91sam9g46-tdes.yaml        | 64 +++++++++++++++++++
 .../bindings/crypto/atmel-crypto.txt          | 23 -------
 2 files changed, 64 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml

diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
new file mode 100644
index 000000000000..fcc5adf03cad
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/atmel,at91sam9g46-tdes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Triple Data Encryption Standard (TDES) HW cryptographic accelerator
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@microchip.com>
+
+properties:
+  compatible:
+    const: atmel,at91sam9g46-tdes
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
+    const: tdes_clk
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
+    tdes: crypto@e2014000 {
+      compatible = "atmel,at91sam9g46-tdes";
+      reg = <0xe2014000 0x100>;
+      interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 96>;
+      clock-names = "tdes_clk";
+      dmas = <&dma0 AT91_XDMAC_DT_PERID(54)>,
+             <&dma0 AT91_XDMAC_DT_PERID(53)>;
+      dma-names = "tx", "rx";
+    };
diff --git a/Documentation/devicetree/bindings/crypto/atmel-crypto.txt b/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
index 1353ebd0dcaa..5c6541cfcc4a 100644
--- a/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
+++ b/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
@@ -2,29 +2,6 @@
 
 These are the HW cryptographic accelerators found on some Atmel products.
 
-* Triple Data Encryption Standard (Triple DES)
-
-Required properties:
-- compatible : Should be "atmel,at91sam9g46-tdes".
-- reg: Should contain TDES registers location and length.
-- interrupts: Should contain the IRQ line for the TDES.
-
-Optional properties:
-- dmas: List of two DMA specifiers as described in
-        atmel-dma.txt and dma.txt files.
-- dma-names: Contains one identifier string for each DMA specifier
-             in the dmas property.
-
-Example:
-tdes@f803c000 {
-	compatible = "atmel,at91sam9g46-tdes";
-	reg = <0xf803c000 0x100>;
-	interrupts = <44 4 0>;
-	dmas = <&dma1 2 20>,
-	       <&dma1 2 21>;
-	dma-names = "tx", "rx";
-};
-
 * Secure Hash Algorithm (SHA)
 
 Required properties:
-- 
2.25.1

