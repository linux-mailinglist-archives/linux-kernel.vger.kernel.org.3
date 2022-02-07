Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7044AB467
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiBGFt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350177AbiBGDZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 22:25:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0509DC061A73;
        Sun,  6 Feb 2022 19:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644204322; x=1675740322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6WoxkUkguy8rx/vdMwuFD/M1zus/du+BiEWUk2id+LM=;
  b=PYpvX7GSAelpIBSQ1JVOL412h/zkyijpHVO/YV2qcRZhwkGni02Kel4N
   CVtv0l2tWZFIh6+1pLVeTVSDLGI7/45D7FuRvwG8dIIL60ahwCBjpjxPj
   oTa0Fy2UlXusgdkrE3R5WuAyEModTerYktgRi7p+UoLa/QJ1YTWxTTXs3
   2ufNpW6nMpSV+YVAK7BEsZAmow6/VUWfqk6HOHk8N5ex+/weCNHDLPgF1
   Ehv0RfYnOOkJM6tPZbVVBK64REQFngoPpwjFEmKtH/c3eCojePNMJbBpk
   WD2AxXLHqVqOjM+PiHiUDLpaxaqbtpkqrw8P5Cm7yRNRYLFt7rPAEtRqQ
   A==;
IronPort-SDR: kZCMQKK8MQiDSTQxgzF25qDB32EjuHAbxIFHT/exe1J7tlWvHsomMzaGbkX1rrVlKeJPSZij32
 AeTpkdNPWYAJ1bn1cok7H5ELU5HquaxbqrCKfhTerocT1DBrwnlQ0m5+aIhoe7ZZuBdNgVlSp6
 yQ6n8kNRJOTg7WbPfO56j2esbG0fYy88f9CF/udrsfybp/95/ZMbEzFkYJWOTKMsoYrRPeX5RY
 OoMzRfMOwBa18HHV0u5OL+ajfC4GfZVPvDiFmJ+x0kZdOLUtKHZecI1w9cjO/tErFBkq2rLOCs
 54ZefkRcDURwnacr3A61SX/m
X-IronPort-AV: E=Sophos;i="5.88,348,1635231600"; 
   d="scan'208";a="147803329"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Feb 2022 20:24:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 6 Feb 2022 20:24:18 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Sun, 6 Feb 2022 20:24:16 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <herbert@gondor.apana.org.au>, <robh+dt@kernel.org>
CC:     <davem@davemloft.net>, <nicolas.ferre@microchip.com>,
        <claudiu.beznea@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 3/3] dt-bindings: crypto: Convert Atmel SHA to yaml
Date:   Mon, 7 Feb 2022 05:24:05 +0200
Message-ID: <20220207032405.70733-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207032405.70733-1-tudor.ambarus@microchip.com>
References: <20220207032405.70733-1-tudor.ambarus@microchip.com>
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

Convert Atmel SHA documentation to yaml format. With the conversion the
clock and clock-names properties are made mandatory. The driver returns
-EINVAL if "sha_clk" is not found, reflect that in the bindings and make
the clock and clock-names properties mandatory. Update the example to
better describe how one should define the dt node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 .../devicetree/bindings/crypto/atmel,sha.yaml | 59 +++++++++++++++++++
 .../bindings/crypto/atmel-crypto.txt          | 25 --------
 2 files changed, 59 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/atmel,sha.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/atmel-crypto.txt

diff --git a/Documentation/devicetree/bindings/crypto/atmel,sha.yaml b/Documentation/devicetree/bindings/crypto/atmel,sha.yaml
new file mode 100644
index 000000000000..ccba6d36ee68
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/atmel,sha.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/atmel,sha.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel Secure Hash Algorithm (SHA) HW cryptographic accelerator
+
+maintainers:
+  - Tudor Ambarus <tudor.ambarus@microchip.com>
+
+properties:
+  compatible:
+    const: atmel,at91sam9g46-sha
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
+    const: sha_clk
+
+  dmas:
+    maxItems: 1
+    description: TX DMA Channel
+
+  dma-names:
+    const: tx
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
+    sha: sha@e1814000 {
+      compatible = "atmel,at91sam9g46-sha";
+      reg = <0xe1814000 0x100>;
+      interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&pmc PMC_TYPE_PERIPHERAL 83>;
+      clock-names = "sha_clk";
+      dmas = <&dma0 AT91_XDMAC_DT_PERID(48)>;
+      dma-names = "tx";
+      status = "okay";
+    };
diff --git a/Documentation/devicetree/bindings/crypto/atmel-crypto.txt b/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
deleted file mode 100644
index 5c6541cfcc4a..000000000000
--- a/Documentation/devicetree/bindings/crypto/atmel-crypto.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* Atmel HW cryptographic accelerators
-
-These are the HW cryptographic accelerators found on some Atmel products.
-
-* Secure Hash Algorithm (SHA)
-
-Required properties:
-- compatible : Should be "atmel,at91sam9g46-sha".
-- reg: Should contain SHA registers location and length.
-- interrupts: Should contain the IRQ line for the SHA.
-
-Optional properties:
-- dmas: One DMA specifiers as described in
-        atmel-dma.txt and dma.txt files.
-- dma-names: Contains one identifier string for each DMA specifier
-             in the dmas property. Only one "tx" string needed.
-
-Example:
-sha@f8034000 {
-	compatible = "atmel,at91sam9g46-sha";
-	reg = <0xf8034000 0x100>;
-	interrupts = <42 4 0>;
-	dmas = <&dma1 2 17>;
-	dma-names = "tx";
-};
-- 
2.25.1

