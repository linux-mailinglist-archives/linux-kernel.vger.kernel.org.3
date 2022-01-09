Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1644889F7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 15:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiAIOy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 09:54:57 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:58454 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiAIOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 09:54:52 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:f20a:f473:2021:45ec])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 9228D28EE27;
        Sun,  9 Jan 2022 15:54:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1641740090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=beZnfvFxhflj3F7p8ZPExQMiCmn9XP8LYTsb7UPPuYY=;
        b=9oi5iDvP9y4yoaaAFVqtN9IaqAU5QqaJIx4rmg4fvLLafSFvWb6xw8U33tiKSuS1/3zvtu
        +whVWDidFWCFRyeNkWaUY5fjAQ94eG6QZu2XSbO+vazb3AOrceCllgp/ZFVMd0ap1kfKhG
        9oDZVjsUZoJv8SNrKLYDSI6pRUp4e4PXAylrBgXaqqTSAQ5hSvs6LbHDHU6X/p0tqrIhyy
        SFNS6st/+/+dtlu3xompXdqC2p1yCxg4AP66G1/VLU5z/8VCHe/TGFSqlVf7cR3XELFdr/
        lcvp6TYBgNEtHyUGPS/Rw1ncig3YNINBYt3SaQxW0sSHc0u2mjdtuYOKX9Cxlg==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v3 4/6] dt-bindings: interrupt-controller: realtek,rtl-intc: require parents
Date:   Sun,  9 Jan 2022 15:54:35 +0100
Message-Id: <e043a9faa4a8f71efdf8b7849ec7911f16207fb0.1641739718.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641739718.git.sander@svanheule.net>
References: <cover.1641739718.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt router has 32 inputs and up to 15 outputs, and the way
these are mapped to each other is runtime configurable. The outputs of
this interrupt router on the other hand, are connected to a fixed set of
parent interrupts. This means that "interrupt-map" is inappropriate, and
rather a list of parent interrupts should be specified.

Two-part compatibles are introduced to be able to require "interrupts"
for new devicetrees. The relevant descriptions are extended or added to
more clearly describe the inputs and outputs of this router.  The old
compatible, "interrupt-map" and "#address-cells", is deprecated.
Interrupt specifiers for new compatibles will require two cells, to
indicate the output selection.

To prevent spurious changes when more SoCs are added, "allOf" is used
with one "if", and the compatible enum only has one item.

The example is updated to provide a correct example for RTL8380 SoCs.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 .../realtek,rtl-intc.yaml                     | 78 ++++++++++++++-----
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
index 9e76fff20323..aab8d44010af 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
@@ -6,6 +6,10 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Realtek RTL SoC interrupt controller devicetree bindings
 
+description:
+  Interrupt router for Realtek MIPS SoCs, allowing each SoC interrupt to be
+  routed to one parent interrupt, or left disconnected.
+
 maintainers:
   - Birger Koblitz <mail@birger-koblitz.de>
   - Bert Vermeulen <bert@biot.com>
@@ -13,45 +17,79 @@ maintainers:
 
 properties:
   compatible:
-    const: realtek,rtl-intc
+    oneOf:
+      - items:
+          - enum:
+              - realtek,rtl8380-intc
+          - const: realtek,rtl-intc
+      - const: realtek,rtl-intc
+        deprecated: true
 
-  "#interrupt-cells":
-    const: 1
+  "#interrupt-cells": true
 
   reg:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 15
+    description:
+      List of parent interrupts, in the order that they are connected to this
+      interrupt router's outputs.
 
   interrupt-controller: true
 
-  "#address-cells":
-    const: 0
-
-  interrupt-map:
-    description: Describes mapping from SoC interrupts to CPU interrupts
-
 required:
   - compatible
   - reg
   - "#interrupt-cells"
   - interrupt-controller
-  - "#address-cells"
-  - interrupt-map
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: realtek,rtl-intc
+    then:
+      properties:
+        "#interrupt-cells":
+          const: 1
+
+        "#address-cells":
+          const: 0
+
+        interrupt-map: true
+      required:
+        - "#address-cells"
+        - interrupt-map
+    else:
+      properties:
+        "#interrupt-cells":
+          description:
+            Two cells to specify which line to connect to, and which output it should
+            be routed to. Both cells use a zero-based index.
+          const: 2
+      required:
+        - interrupts
 
 additionalProperties: false
 
 examples:
   - |
     intc: interrupt-controller@3000 {
-      compatible = "realtek,rtl-intc";
-      #interrupt-cells = <1>;
+      compatible = "realtek,rtl8380-intc", "realtek,rtl-intc";
+      #interrupt-cells = <2>;
       interrupt-controller;
-      reg = <0x3000 0x20>;
-      #address-cells = <0>;
-      interrupt-map =
-              <31 &cpuintc 2>,
-              <30 &cpuintc 1>,
-              <29 &cpuintc 5>;
+      reg = <0x3000 0x18>;
+
+      interrupt-parent = <&cpuintc>;
+      interrupts = <2>, <3>, <4>, <5>, <6>;
+    };
+
+    irq-consumer@0 {
+      reg = <0 4>;
+      interrupt-parent = <&intc>;
+      interrupts =
+        <19 3>, /* IRQ 19, routed to output 3 (cpuintc 5) */
+        <18 4>; /* IRQ 18, routed to output 4 (cpuintc 6) */
     };
-- 
2.33.1

