Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510974788DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbhLQK37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:29:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46938 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbhLQK36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:29:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61799B82787;
        Fri, 17 Dec 2021 10:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A8CC36AEB;
        Fri, 17 Dec 2021 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639736996;
        bh=u60Gy+HM2Cz89/HOSt7nvfcnD1OA0GjqWTWcgPWp9g8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TyH9WORJA9a0ANLDyP5GYNJJNM3NDiOk2limKfOvgDEOzPLLZTWKtcjQtHC4VbmyB
         ae5Qm2s/mjcNM5RUY5UkXr9p7RyjafFQ0E2HkGSznnYK5emM68/7eEJPBUwaoV6OCx
         EQ5Jd748wk3GMWQwR/xJjnejO59cFlR/pdrsflWX89scF9+m7XWs2gG3Ln1JCSrRr6
         SC2KgpEVdpXGP+mQ1ik/Vxg6W9KW7wN5vX/7GbBrbwMvPAHIJx3GKCt9g6sx33u05P
         lLdNupglN+COedh8lQdkuMtMqk8RqZ6A2Em8e+Xm4anvNpBo/6XXh/bOcR5OcND9wh
         FguEj1hcbV4Xw==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzysztof.kozlowski@canonical.com, tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: memory-controllers: ti,gpmc: Add compatible for AM64
Date:   Fri, 17 Dec 2021 12:29:42 +0200
Message-Id: <20211217102945.17432-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211217102945.17432-1-rogerq@kernel.org>
References: <20211217102945.17432-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 SoC contains the GPMC module. Add compatible for it.

Newer SoCs don't necessarily map GPMC data region at the same place
as legacy SoCs. Add reg-names "data", to provide this information to
the device driver.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/memory-controllers/ti,gpmc.yaml  | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
index 25b42d68f9b3..64dc9d398d9a 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
@@ -23,13 +23,20 @@ properties:
     items:
       - enum:
           - ti,am3352-gpmc
+          - ti,am64-gpmc
           - ti,omap2420-gpmc
           - ti,omap2430-gpmc
           - ti,omap3430-gpmc
           - ti,omap4430-gpmc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: data
 
   interrupts:
     maxItems: 1
@@ -44,6 +51,9 @@ properties:
     items:
       - const: fck
 
+  power-domains:
+    maxItems: 1
+
   dmas:
     items:
       - description: DMA channel for GPMC NAND prefetch
@@ -133,6 +143,17 @@ required:
   - "#address-cells"
   - "#size-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,am64-gpmc
+    then:
+      required:
+        - reg-names
+        - power-domains
+
 additionalProperties: false
 
 examples:
-- 
2.17.1

