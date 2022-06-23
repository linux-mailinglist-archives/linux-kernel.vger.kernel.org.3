Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AAC557EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiFWPks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiFWPkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:40:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAA043AF2;
        Thu, 23 Jun 2022 08:40:44 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CEDD166016D1;
        Thu, 23 Jun 2022 16:40:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655998843;
        bh=2jeuLe0zedb6o0kZiLElfapJFeQNLh2yeAOrBr+93uA=;
        h=From:To:Cc:Subject:Date:From;
        b=ievPSFp8BOVHTNdBWk7zQxRgt3pXWx7VJs/89gkU+G9/atXtB8iOppycZdYKnmXT3
         RX9hJi2qRNLOZcTVK3Lrx0a44cDa1zBiY+W4djjWhG4TjwdgileT54Yz/4c+8wcPdr
         qHIUgDdc9LpXcoZ0Ku/YpA7BeCu52v4Hydz66jID5ip/BSnxdnbhSBAFsf1bRjQvHJ
         VbbMGEgcUa/4DCNTxhm7Y38mkaMP5U4wGf93dAFqghvZ3w/XW6U0Kjmn31ZqiZEo77
         RwfOLxK+4pd7NtMIGmhQ3iS4USpMwto5NslI56resJiso4eo8iwcrUW6gfBUfHIPy+
         ouO0NH/jPxcFg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mmc: mtk-sd: Set clocks based on compatible
Date:   Thu, 23 Jun 2022 11:40:38 -0400
Message-Id: <20220623154038.771874-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding was describing a single clock list for all platforms, but
that's not really suitable: mt2712 requires an extra 'bus_clk' on some
of its controllers, while mt8192 requires four different extra clocks.
The rest of the platforms can share the same 3 clocks, with the third
being optional as it's not present on all platforms.

Move the clock definitions inside if blocks that match on the
compatibles. In practice this gets rid of dtbs_check warnings on mt8192,
since the 'bus_clk' clock from mt2712 is no longer expected on this
platform.

Fixes: 59a23395d8aa ("dt-bindings: mmc: Add support for MT8192 SoC")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
v1: https://lore.kernel.org/all/20220617230114.2438875-1-nfraprado@collabora.com

Changes in v2:
- Kept widest minItems/maxItems outside the if blocks

 .../devicetree/bindings/mmc/mtk-sd.yaml       | 111 +++++++++++++-----
 1 file changed, 81 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index 2a2e9fa8c188..5e73218d2e6e 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -10,9 +10,6 @@ maintainers:
   - Chaotian Jing <chaotian.jing@mediatek.com>
   - Wenbin Mei <wenbin.mei@mediatek.com>
 
-allOf:
-  - $ref: mmc-controller.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -49,27 +46,11 @@ properties:
     description:
       Should contain phandle for the clock feeding the MMC controller.
     minItems: 2
-    items:
-      - description: source clock (required).
-      - description: HCLK which used for host (required).
-      - description: independent source clock gate (required for MT2712).
-      - description: bus clock used for internal register access (required for MT2712 MSDC0/3).
-      - description: msdc subsys clock gate (required for MT8192).
-      - description: peripheral bus clock gate (required for MT8192).
-      - description: AXI bus clock gate (required for MT8192).
-      - description: AHB bus clock gate (required for MT8192).
+    maxItems: 7
 
   clock-names:
     minItems: 2
-    items:
-      - const: source
-      - const: hclk
-      - const: source_cg
-      - const: bus_clk
-      - const: sys_cg
-      - const: pclk_cg
-      - const: axi_cg
-      - const: ahb_cg
+    maxItems: 7
 
   interrupts:
     maxItems: 1
@@ -171,15 +152,85 @@ required:
   - vmmc-supply
   - vqmmc-supply
 
-if:
-  properties:
-    compatible:
-      contains:
-        const: mediatek,mt8183-mmc
-then:
-  properties:
-    reg:
-      minItems: 2
+allOf:
+  - $ref: mmc-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8183-mmc
+    then:
+      properties:
+        reg:
+          minItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8192-mmc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: source clock
+            - description: HCLK which used for host
+            - description: independent source clock gate
+            - description: msdc subsys clock gate
+            - description: peripheral bus clock gate
+            - description: AXI bus clock gate
+            - description: AHB bus clock gate
+        clock-names:
+          items:
+            - const: source
+            - const: hclk
+            - const: source_cg
+            - const: sys_cg
+            - const: pclk_cg
+            - const: axi_cg
+            - const: ahb_cg
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt2712-mmc
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          items:
+            - description: source clock
+            - description: HCLK which used for host
+            - description: independent source clock gate
+            - description: bus clock used for internal register access (required for MSDC0/3).
+        clock-names:
+          minItems: 3
+          items:
+            - const: source
+            - const: hclk
+            - const: source_cg
+            - const: bus_clk
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - mediatek,mt2712-mmc
+                - mediatek,mt8192-mmc
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          items:
+            - description: source clock
+            - description: HCLK which used for host
+            - description: independent source clock gate
+        clock-names:
+          minItems: 2
+          items:
+            - const: source
+            - const: hclk
+            - const: source_cg
 
 unevaluatedProperties: false
 
-- 
2.36.1

