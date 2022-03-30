Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC304EBF4D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245644AbiC3K5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245621AbiC3K5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:57:09 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EC62264F77;
        Wed, 30 Mar 2022 03:55:24 -0700 (PDT)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 30 Mar 2022 19:55:23 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id BFF8C2058B50;
        Wed, 30 Mar 2022 19:55:23 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 30 Mar 2022 19:55:23 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 344F3B62B7;
        Wed, 30 Mar 2022 19:55:23 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 5/5] dt-bindings: phy: uniphier: Clean up clocks, resets, and their names using compatible string
Date:   Wed, 30 Mar 2022 19:55:15 +0900
Message-Id: <1648637715-19262-6-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648637715-19262-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1648637715-19262-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of "oneOf:" choices, use "allOf:" and "if:" to define clocks,
clock-names, resets, and reset-names that can be taken by the compatible
string.

The order of clock-names and reset-names doesn't change here.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../phy/socionext,uniphier-ahci-phy.yaml      | 90 +++++++++++++-----
 .../phy/socionext,uniphier-pcie-phy.yaml      | 47 ++++++---
 .../phy/socionext,uniphier-usb3hs-phy.yaml    | 93 ++++++++++++++----
 .../phy/socionext,uniphier-usb3ss-phy.yaml    | 95 +++++++++++++++----
 4 files changed, 251 insertions(+), 74 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
index 14f7579e7daa..a3cd45acea28 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
@@ -30,33 +30,79 @@ properties:
     minItems: 1
     maxItems: 2
 
-  clock-names:
-    oneOf:
-      - items:          # for PXs2
-          - const: link
-      - items:          # for Pro4
-          - const: link
-          - const: gio
-      - items:          # for others
-          - const: link
-          - const: phy
+  clock-names: true
 
   resets:
     minItems: 2
     maxItems: 6
 
-  reset-names:
-    oneOf:
-      - items:          # for Pro4
-          - const: link
-          - const: gio
-          - const: phy
-          - const: pm
-          - const: tx
-          - const: rx
-      - items:          # for others
-          - const: link
-          - const: phy
+  reset-names: true
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: socionext,uniphier-pro4-ahci-phy
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: link
+            - const: gio
+        resets:
+          minItems: 6
+          maxItems: 6
+        reset-names:
+          items:
+            - const: link
+            - const: gio
+            - const: phy
+            - const: pm
+            - const: tx
+            - const: rx
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: socionext,uniphier-pxs2-ahci-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          const: link
+        resets:
+          minItems: 2
+          maxItems: 2
+        reset-names:
+          items:
+            - const: link
+            - const: phy
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: socionext,uniphier-pxs3-ahci-phy
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: link
+            - const: phy
+        resets:
+          minItems: 2
+          maxItems: 2
+        reset-names:
+          items:
+            - const: link
+            - const: phy
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
index fbb71d6dd531..b3ed2f74a414 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
@@ -31,28 +31,51 @@ properties:
     minItems: 1
     maxItems: 2
 
-  clock-names:
-    oneOf:
-      - items:            # for Pro5
-          - const: gio
-          - const: link
-      - const: link       # for others
+  clock-names: true
 
   resets:
     minItems: 1
     maxItems: 2
 
-  reset-names:
-    oneOf:
-      - items:            # for Pro5
-          - const: gio
-          - const: link
-      - const: link       # for others
+  reset-names: true
 
   socionext,syscon:
     $ref: /schemas/types.yaml#/definitions/phandle
     description: A phandle to system control to set configurations for phy
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: socionext,uniphier-pro5-pcie-phy
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: gio
+            - const: link
+        resets:
+          minItems: 2
+          maxItems: 2
+        reset-names:
+          items:
+            - const: gio
+            - const: link
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          const: link
+        resets:
+          maxItems: 1
+        reset-names:
+          const: link
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
index 1bbd164f2527..21e4414eea60 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
@@ -34,30 +34,12 @@ properties:
     minItems: 2
     maxItems: 3
 
-  clock-names:
-    oneOf:
-      - items:               # for Pro5
-          - const: gio
-          - const: link
-      - items:               # for PXs3 with phy-ext
-          - const: link
-          - const: phy
-          - const: phy-ext
-      - items:               # for others
-          - const: link
-          - const: phy
+  clock-names: true
 
   resets:
     maxItems: 2
 
-  reset-names:
-    oneOf:
-      - items:               # for Pro5
-          - const: gio
-          - const: link
-      - items:               # for others
-          - const: link
-          - const: phy
+  reset-names: true
 
   vbus-supply:
     description: A phandle to the regulator for USB VBUS
@@ -80,6 +62,77 @@ properties:
       required for each port, if any one is omitted, the trimming data
       of the port will not be set at all.
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: socionext,uniphier-pro5-usb3-hsphy
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: gio
+            - const: link
+        resets:
+          minItems: 2
+          maxItems: 2
+        reset-names:
+          items:
+            - const: gio
+            - const: link
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - socionext,uniphier-pxs2-usb3-hsphy
+              - socionext,uniphier-ld20-usb3-hsphy
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: link
+            - const: phy
+        resets:
+          minItems: 2
+          maxItems: 2
+        reset-names:
+          items:
+            - const: link
+            - const: phy
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - socionext,uniphier-pxs3-usb3-hsphy
+              - socionext,uniphier-nx1-usb3-hsphy
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 3
+        clock-names:
+          minItems: 2
+          items:
+            - const: link
+            - const: phy
+            - const: phy-ext
+        resets:
+          minItems: 2
+          maxItems: 2
+        reset-names:
+          items:
+            - const: link
+            - const: phy
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
index 06c957d52d23..4c26d2d2303d 100644
--- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
@@ -35,34 +35,89 @@ properties:
     minItems: 2
     maxItems: 3
 
-  clock-names:
-    oneOf:
-      - items:             # for Pro4, Pro5
-          - const: gio
-          - const: link
-      - items:             # for PXs3 with phy-ext
-          - const: link
-          - const: phy
-          - const: phy-ext
-      - items:             # for others
-          - const: link
-          - const: phy
+  clock-names: true
 
   resets:
     maxItems: 2
 
-  reset-names:
-    oneOf:
-      - items:              # for Pro4,Pro5
-          - const: gio
-          - const: link
-      - items:              # for others
-          - const: link
-          - const: phy
+  reset-names: true
 
   vbus-supply:
     description: A phandle to the regulator for USB VBUS, only for USB host
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - socionext,uniphier-pro4-usb3-ssphy
+              - socionext,uniphier-pro5-usb3-ssphy
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: gio
+            - const: link
+        resets:
+          minItems: 2
+          maxItems: 2
+        reset-names:
+          items:
+            - const: gio
+            - const: link
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - socionext,uniphier-pxs2-usb3-ssphy
+              - socionext,uniphier-ld20-usb3-ssphy
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: link
+            - const: phy
+        resets:
+          minItems: 2
+          maxItems: 2
+        reset-names:
+          items:
+            - const: link
+            - const: phy
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - socionext,uniphier-pxs3-usb3-ssphy
+              - socionext,uniphier-nx1-usb3-ssphy
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 3
+        clock-names:
+          minItems: 2
+          items:
+            - const: link
+            - const: phy
+            - const: phy-ext
+        resets:
+          minItems: 2
+          maxItems: 2
+        reset-names:
+          items:
+            - const: link
+            - const: phy
+
 required:
   - compatible
   - reg
-- 
2.25.1

