Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0614B5CE4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiBNVgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:36:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiBNVgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:36:05 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA2BBC8E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:35:48 -0800 (PST)
Received: from terra.local.svanheule.net (104.153-136-217.adsl-dyn.isp.belgacom.be [217.136.153.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 670EF2A25FB;
        Mon, 14 Feb 2022 19:57:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1644865027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWlSj3jND0Xw2BaE2cX6gEUMtrMa1vlnKfokepbt1e4=;
        b=nXya5L0GgmhPE3+2pHiO94UCKR06POE2QGOtaucxne1rk7/Dx31b5OCoUmJ8qM26bwgdac
        7m/se8DraRuXQfA44Cs0Kjni1yI9RY1WgJ99pj1NtQLbA60aUxXetFzbki15AIX9i4f/L+
        rp7cDSm91ob60+QBUq8DYh46/UX0ZWKxkyT+unmgbqPW89R28p2QDm+9HxrP97osL4ViMR
        AP3bqW41Etfad7dPg/WaetQjDJcusPyP8GRvRWlwHPW+jwICJrqlTFgTQn9kLTWqTIBsZb
        B6r5YslRtqIQW/AfuFKVLmZsRGxziF6nd3B1by0omI0JWdkRAWC0vmiSqj/Huw==
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/4] dt-bindings: interrupt-controller: realtek,rtl-intc: require parents
Date:   Mon, 14 Feb 2022 19:56:59 +0100
Message-Id: <a8001b64563a92cd3ca9a3c9190b87d7a3505497.1644864700.git.sander@svanheule.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644864700.git.sander@svanheule.net>
References: <cover.1644864700.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt router has 32 inputs, and up to 15 outputs connected to
the MIPS CPU's interrupts. The way these are mapped to each other is
runtime configurable. This controller can also mask individual interrupt
sources, and has a status register to indicate pending interrupts. This
means the controller is not transparent, and the use of "interrupt-map"
inappropriate. Instead, a list of parent interrupts should be specified.

Two-part compatibles are introduced to be able to require "interrupts"
for new devicetrees. The relevant descriptions are extended or added to
more clearly describe the functionality of this controller. The old
compatible, with "interrupt-map" and "#address-cells", is deprecated.
Interrupt specifiers for new compatibles will require two cells, to
indicate the output selection.

To prevent spurious changes to the binding when more SoCs are added,
"allOf" is used with one "if", and the compatible enum only has one
item.

The example is updated to provide a correct example for RTL8380 SoCs.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v5:
- Add Rob's Reviewed-by

Changes in v4:
- Indicate more clearly that the controller is not transparent.

 .../realtek,rtl-intc.yaml                     | 82 ++++++++++++++-----
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
index 9e76fff20323..f212962afd62 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
@@ -6,6 +6,14 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Realtek RTL SoC interrupt controller devicetree bindings
 
+description:
+  Interrupt controller and router for Realtek MIPS SoCs, allowing each SoC
+  interrupt to be routed to one parent CPU (hardware) interrupt, or left
+  disconnected.
+  All connected input lines from SoC peripherals can be masked individually,
+  and an interrupt status register is present to indicate which interrupts are
+  pending.
+
 maintainers:
   - Birger Koblitz <mail@birger-koblitz.de>
   - Bert Vermeulen <bert@biot.com>
@@ -13,45 +21,79 @@ maintainers:
 
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
2.35.1

