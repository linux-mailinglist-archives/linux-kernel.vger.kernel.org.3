Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9540246E17E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 05:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhLIEg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 23:36:56 -0500
Received: from marcansoft.com ([212.63.210.85]:54120 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231923AbhLIEgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 23:36:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BB7A541EA2;
        Thu,  9 Dec 2021 04:33:17 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: interrupt-controller: apple,aic: Add apple,aic2 support
Date:   Thu,  9 Dec 2021 13:32:44 +0900
Message-Id: <20211209043249.65474-2-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209043249.65474-1-marcan@marcan.st>
References: <20211209043249.65474-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new incompatible revision of the AIC peripheral introduces
multi-die support. To handle that, we introduce an optional
4-argument interrupt-cells form.

Also add an apple,event-reg property to specify the offset of the event
register. Inexplicably, the capability registers allow us to compute
other register offsets, but not this one. This allows us to keep
forward-compatibility with future SoCs that will likely implement
different die counts, thus shifting the event register. Apple do the
same thing in their device tree...

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../interrupt-controller/apple,aic.yaml       | 62 +++++++++++++++----
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index 97359024709a..6a8dd213e59a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -18,38 +18,44 @@ description: |
 
   - Level-triggered hardware IRQs wired to SoC blocks
     - Single mask bit per IRQ
-    - Per-IRQ affinity setting
+    - Per-IRQ affinity setting (AICv1 only)
     - Automatic masking on event delivery (auto-ack)
     - Software triggering (ORed with hw line)
   - 2 per-CPU IPIs (meant as "self" and "other", but they are interchangeable
-    if not symmetric)
+    if not symmetric) (AICv1 only)
   - Automatic prioritization (single event/ack register per CPU, lower IRQs =
     higher priority)
   - Automatic masking on ack
-  - Default "this CPU" register view and explicit per-CPU views
+  - Default "this CPU" register view and explicit per-CPU views (AICv1 only)
 
   This device also represents the FIQ interrupt sources on platforms using AIC,
-  which do not go through a discrete interrupt controller.
-
-allOf:
-  - $ref: /schemas/interrupt-controller.yaml#
+  which do not go through a discrete interrupt controller. It also handles
+  FIQ-based Fast IPIs on supported chips.
 
 properties:
   compatible:
-    items:
-      - const: apple,t8103-aic
-      - const: apple,aic
+    oneOf:
+      - items:
+          - const: apple,t8103-aic
+          - const: apple,aic
+      - items:
+          - const: apple,t6000-aic
+          - const: apple,aic2
 
   interrupt-controller: true
 
   '#interrupt-cells':
-    const: 3
+    minimum: 3
+    maximum: 4
     description: |
       The 1st cell contains the interrupt type:
         - 0: Hardware IRQ
         - 1: FIQ
 
-      The 2nd cell contains the interrupt number.
+      The optional 2nd cell contains the die ID (apple,aic2 only).
+      If not present, it defaults to 0.
+
+      The next cell contains the interrupt number.
         - HW IRQs: interrupt number
         - FIQs:
           - 0: physical HV timer
@@ -57,7 +63,7 @@ properties:
           - 2: physical guest timer
           - 3: virtual guest timer
 
-      The 3rd cell contains the interrupt flags. This is normally
+      The last cell contains the interrupt flags. This is normally
       IRQ_TYPE_LEVEL_HIGH (4).
 
   reg:
@@ -68,6 +74,13 @@ properties:
   power-domains:
     maxItems: 1
 
+  apple,event-reg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Specifies the offset of the event register, which lies after all the
+      implemented die register sets, page aligned. This is not computable from
+      capability register values, so we have to specify it explicitly.
+
 required:
   - compatible
   - '#interrupt-cells'
@@ -76,6 +89,29 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - apple,aic
+    then:
+      properties:
+        '#interrupt-cells':
+          const: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - apple,aic2
+    then:
+      required:
+        - apple,event-reg
+
 examples:
   - |
     soc {
-- 
2.33.0

