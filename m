Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F07523E18
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347389AbiEKTzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347324AbiEKTzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:55:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484C979802;
        Wed, 11 May 2022 12:55:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 26CCF1F42D77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652298900;
        bh=VLQbzFLaTXEJncbmCPeLOgEPWtwIfjpqwoLXWnU3Q3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XIfu0ALH+UxjUOkJvim0Bvm/Ub8bSd/PbUcqNK7FzhFLuniO8kcOJuB1RlEwxtFXu
         H2vgu5rjVBEf3nBxLW3rJJWx0eZiLVBs0l/74eRgrtj3Z7i/FC0EiAyWEEU1ijnnCl
         D7vWm+nEPZqemsIzVf/VBeX9ztquXeeXy+fg2x1at844oi+q1hO/kwCszd4zr1FVb9
         jo+s5154S+zHB3ARtdprkROY/sUEPMXmNSyd1qTRIoi1ZTY1TX6Y8mS/GLkP5967PK
         JDWs43LeW97o8lbmR/k6tCGUSLtxJE5z85UyhQod4lZHQI92JuIKReIzJFnAgtfwWN
         ufnOCKxUVtzQA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
Subject: [PATCH v5 1/2] dt-bindings: remoteproc: mediatek: Make l1tcm reg exclusive to mt819x
Date:   Wed, 11 May 2022 15:54:51 -0400
Message-Id: <20220511195452.871897-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511195452.871897-1-nfraprado@collabora.com>
References: <20220511195452.871897-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
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

Fix the dt-binding so that the l1tcm reg can be present only on the
supported platforms: mt8192 and mt8195.

Fixes: 503c64cc42f1 ("dt-bindings: remoteproc: mediatek: add L1TCM memory region")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v5:
- Made l1tcm optional for mt8192/mt8195
- Greatly simplified the constraints override in the if:then:
- Updated commit message

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

 .../bindings/remoteproc/mtk,scp.yaml          | 44 +++++++++++++------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
index abc11ac92818..832064d635b3 100644
--- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
@@ -23,11 +23,13 @@ properties:
 
   reg:
     description:
-      Should contain the address ranges for memory regions SRAM, CFG, and
-      L1TCM.
+      Should contain the address ranges for memory regions SRAM, CFG, and,
+      on some platforms, L1TCM.
+    minItems: 2
     maxItems: 3
 
   reg-names:
+    minItems: 2
     items:
       - const: sram
       - const: cfg
@@ -57,16 +59,30 @@ required:
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
+          maxItems: 2
+        reg-names:
+          maxItems: 2
 
 additionalProperties:
   type: object
@@ -86,10 +102,10 @@ additionalProperties:
 
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
2.36.1

