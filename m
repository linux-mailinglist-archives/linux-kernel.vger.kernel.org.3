Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C287146D38D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbhLHMt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:49:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44644 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbhLHMtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:49:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37E7AB820EA;
        Wed,  8 Dec 2021 12:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E00C00446;
        Wed,  8 Dec 2021 12:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638967578;
        bh=DFWSlBQApudaZyIitt6ZnYtGk6Slx0oJzrBSIjiftMw=;
        h=From:To:Cc:Subject:Date:From;
        b=jWsFbhfE/03Mjt0c3JTa3BFsOfXr/SFmFE7h8mNZ5UNdHxt6thLjtgi69OUb3VLG8
         CnIKAo3ZJ64eAIi41qgY29BqTiwwRQIYDlcw1tZNzpgXIbzEFiK5zj6KL8B/Ta/PA3
         zMtc38v7smm2VS4q4594LCSwsdegV2NS2YJxVd/nUjdQSyspNtB3ACFpLKqJZdZ5Zc
         HEzLp7rWSA9zEgU/BgrFFu3WCaXqtkzKoPuZnePtQPTn8n4ACYLL4JL+ZwuqVbRz52
         Fq7lCtNcusYbVf0J4VEKGww+tMXkvNRggUZtDJCYDlIMbT3H0yoNSUpz1HOUDyVowY
         sP7fthj54nJBg==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzysztof.kozlowski@canonical.com, tony@atomide.com
Cc:     kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: memory-controllers: ti,gpmc: Add compatible for AM64
Date:   Wed,  8 Dec 2021 14:46:08 +0200
Message-Id: <20211208124611.16843-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM64 SoC contains the GPMC module. Add compatible for it.

Newer SoCs don't necessarily map GPMC data region at the same place
as legacy SoCs. Add reg-names "data", to provide this information to
the device driver.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
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

