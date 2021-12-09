Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6811146E1C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhLIFN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhLIFNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:13:55 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD44C0617A2;
        Wed,  8 Dec 2021 21:10:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6022541E57;
        Thu,  9 Dec 2021 05:10:18 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: pci: apple,pcie: Add t6000 support
Date:   Thu,  9 Dec 2021 14:10:00 +0900
Message-Id: <20211209051001.70235-4-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209051001.70235-1-marcan@marcan.st>
References: <20211209051001.70235-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new SoC is compatible with the existing driver, but the block
supports 4 downstream ports, so we need to adjust the binding to
allow that.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../devicetree/bindings/pci/apple,pcie.yaml   | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
index ef1d424ec299..7f01e15fc81c 100644
--- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -28,19 +28,17 @@ description: |
   distributed over the root ports as the OS sees fit by programming
   the PCIe controller's port registers.
 
-allOf:
-  - $ref: /schemas/pci/pci-bus.yaml#
-  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
-
 properties:
   compatible:
     items:
-      - const: apple,t8103-pcie
+      - enum:
+          - apple,t8103-pcie
+          - apple,t6000-pcie
       - const: apple,pcie
 
   reg:
     minItems: 3
-    maxItems: 5
+    maxItems: 6
 
   reg-names:
     minItems: 3
@@ -50,6 +48,7 @@ properties:
       - const: port0
       - const: port1
       - const: port2
+      - const: port3
 
   ranges:
     minItems: 2
@@ -59,7 +58,7 @@ properties:
     description:
       Interrupt specifiers, one for each root port.
     minItems: 1
-    maxItems: 3
+    maxItems: 4
 
   msi-parent: true
 
@@ -81,6 +80,21 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: apple,t8103-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 5
+        interrupts:
+          maxItems: 3
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/apple-aic.h>
-- 
2.33.0

