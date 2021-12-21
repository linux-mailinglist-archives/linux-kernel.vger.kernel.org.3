Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D5F47C0A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbhLUNSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbhLUNSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:18:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA83C061574;
        Tue, 21 Dec 2021 05:18:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E9FF615A3;
        Tue, 21 Dec 2021 13:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C24C36AE8;
        Tue, 21 Dec 2021 13:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640092688;
        bh=u60Gy+HM2Cz89/HOSt7nvfcnD1OA0GjqWTWcgPWp9g8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GW3KEkW84d4/UGEyZIm2MPN+ABDDa0dQtMkLgqKipAc0mjwvInIp/ZSHzUc2LNnET
         aRVbyR+GAZruHQSe/nY/y8tYEcmODyCqW5cUqEgaCEmGc3uuMHUA0B6P1Cf3QCrBfb
         FTurQWgTUaHQptQstGP/h3yDtDZvzKk0dlZWI2bPCszmGbWygcwMDkhQmzj0f5m9Cu
         TkMa86OgbbXQA+6twpBgjOe9NQBD3FgE1733BV1ZGcMSyCoGUVf9dJSmJ5jL7xhb1Y
         zm/h4NlxN9Fbd5XyrksSqZIwNuGFP/vcer5CVxiZI162bf413A9k224tSaWFtFw08I
         0uMlGncBM4Lvw==
From:   Roger Quadros <rogerq@kernel.org>
To:     krzysztof.kozlowski@canonical.com, miquel.raynal@bootlin.com,
        tony@atomide.com
Cc:     robh@kernel.org, kishon@ti.com, nm@ti.com, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: memory-controllers: ti,gpmc: Add compatible for AM64
Date:   Tue, 21 Dec 2021 15:17:54 +0200
Message-Id: <20211221131757.2030-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221131757.2030-1-rogerq@kernel.org>
References: <20211221131757.2030-1-rogerq@kernel.org>
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

