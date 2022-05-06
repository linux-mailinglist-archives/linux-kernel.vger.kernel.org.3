Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959D351E127
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 23:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444513AbiEFVg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 17:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444496AbiEFVgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 17:36:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818345DBEC;
        Fri,  6 May 2022 14:32:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id BBC231F46F14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651872754;
        bh=/dlltmm0CjgK9MLJxH9V1QvvneVKOwNJ66ACc15SFyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LFDaJssSl/nm+tkMOWesdtUJGcuNj+3SIi+O4V55fnnb6G3kKXcbtRIaTwe0SzRuU
         EDUJ6zcPrKkZTkoIa0JCzrq7Yocctx4r/wEWDMlA2vFp/MTsy4YA3bnnlySiEJ70q0
         7mx7AbPfQwyM4jCt6BVEIK+7BMTVlsvSVdfZE1bNheGH+mC7VwOo/5U1O9G4mOM789
         iamv4C8SFrYy36JOiweqAFdI05APxpd9pL8RJSMin9KzE3h6uvU4KIWqMsDlq/R6P6
         RME07Ns1ymoaJVuKkW421hcaD5pFfp9muV+ffFUVNQGXSyoIt9fDT3AhaC534FQXY1
         IhwuHBRlSHy9w==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: remoteproc: mediatek: Make l1tcm reg exclusive to mt819x
Date:   Fri,  6 May 2022 17:32:25 -0400
Message-Id: <20220506213226.257859-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220506213226.257859-1-nfraprado@collabora.com>
References: <20220506213226.257859-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ca23ecfdbd44 ("remoteproc/mediatek: support L1TCM") added support
for the l1tcm memory region on the MT8192 SCP, adding a new da_to_va
callback that handles l1tcm while keeping the old one for
back-compatibility with MT8183. However, since the mt8192 compatible was
missing from the dt-binding, the accompanying dt-binding commit
503c64cc42f1 ("dt-bindings: remoteproc: mediatek: add L1TCM memory region")
mistakenly added this reg as if it were for mt8183. And later
it became common to all platforms as their compatibles were added.

Fix the dt-binding so that the l1tcm reg can, and must, be present only
on the supported platforms: mt8192 and mt8195.

Fixes: 503c64cc42f1 ("dt-bindings: remoteproc: mediatek: add L1TCM memory region")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
The if:then: branches became rather long since it seems that it's not
possible to override the properties in them, only add new ones. That is,
I couldn't leave the items definition for all three regs in the global
reg-names and just decrease minItems and maxItems to 2 for
mt8183/mt8186.

Also I had to add a description to the global reg-names, since it
couldn't be neither missing nor empty.

Let me know if there are better ways to achieve this.

Changes in v4:
- Reworked presence of l1tcm reg to be if:then: based and present only
  on mt8192/mt8195
- Rewrote commit message
- Added Fixes tag

Changes in v3:
- Made the cfg reg required again. After looking again into the mtk-scp
  driver, only l1tcm is optional.
- Added mention that a dtbs_check warning gets fixed by patch in commit
  message.

 .../bindings/remoteproc/mtk,scp.yaml          | 69 ++++++++++++++-----
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
index 823a236242de..e1793a85e610 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
@@ -23,15 +23,12 @@ properties:
 
   reg:
     description:
-      Should contain the address ranges for memory regions SRAM, CFG, and
-      L1TCM.
-    maxItems: 3
+      Should contain the address ranges for memory regions SRAM, CFG, and,
+      on some platforms, L1TCM.
 
   reg-names:
-    items:
-      - const: sram
-      - const: cfg
-      - const: l1tcm
+    description:
+      Register names depend on the platform.
 
   clocks:
     description:
@@ -50,16 +47,50 @@ required:
   - reg
   - reg-names
 
-if:
-  properties:
-    compatible:
-      enum:
-        - mediatek,mt8183-scp
-        - mediatek,mt8192-scp
-then:
-  required:
-    - clocks
-    - clock-names
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt8183-scp
+            - mediatek,mt8192-scp
+    then:
+      required:
+        - clocks
+        - clock-names
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt8183-scp
+            - mediatek,mt8186-scp
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+        reg-names:
+          items:
+            - const: sram
+            - const: cfg
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt8192-scp
+            - mediatek,mt8195-scp
+    then:
+      properties:
+        reg:
+          minItems: 3
+          maxItems: 3
+        reg-names:
+          items:
+            - const: sram
+            - const: cfg
+            - const: l1tcm
 
 additionalProperties:
   type: object
@@ -79,10 +110,10 @@ additionalProperties:
 
 examples:
   - |
-    #include <dt-bindings/clock/mt8183-clk.h>
+    #include <dt-bindings/clock/mt8192-clk.h>
 
     scp@10500000 {
-        compatible = "mediatek,mt8183-scp";
+        compatible = "mediatek,mt8192-scp";
         reg = <0x10500000 0x80000>,
               <0x10700000 0x8000>,
               <0x10720000 0xe0000>;
-- 
2.36.0

