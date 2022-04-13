Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C875B4FFEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbiDMTMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbiDMTLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:11:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE01716DE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso1761138wmz.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hzWov2h7bUv7TvPCe3xLER2qILsZ8moXoe1I60bhAfY=;
        b=8W4EodW3tieAkC0XUv6rm1jiKbjlFWNXCMOVXJ4IJ5LLrz127MRtiX2JSZr64Cstlj
         aRL4mwMrVfMH9nKgDzC91MXyiZRn8Bdjt0SYwhfWRF0KlcXf+DrbS8t5bkVt8E4G4b2t
         Rl3P2Av42/2ia+MmIN67h5jrKOaBb+mcac/hcr/E7oyUcTMnTA9hx86RutLHLJCfERnD
         WM656r/06c87D53EQq8dMtlR1G6hzi+dLvaAIzWeUChUlVFTj6eBXqDX9ect5ospg6BX
         n0b23f2ftyN5Mb8dNN4Csv5jHs6hhFKv2NSEyrvJKuG2MdSeJZr0TqVnPkO05p5eVyOB
         +JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hzWov2h7bUv7TvPCe3xLER2qILsZ8moXoe1I60bhAfY=;
        b=Nmv1tDoTxVrzBeZpz4q/t28LrfdK9ueh9w+x6dknOcBik8c5Dd0Ym+UZCgl8t0wRjk
         k4OcnGAVo29BhWfXW0d5uIfG702XCstiid78qNQk0QNc/JaD7f8LCgC3qdDz0Gq0HXH4
         90uMghHqXZnn7kz52k8Nl78zemcZzpL/xvc8BrgdogbhO6cFWo22iM6+J3JhZepgWeE0
         RQBlXEIe3TgVFZIdCjikfpGyyfZKczmFQY1/FXBkCeRm4swq+1H4iQ0YXCKRcjF1wa3b
         6RCzyo8ktDGuHlH0wgN2igueDWYxXw+cLBNEneEsTo+u895tg4kL/LoCPJtcs7L5RT/T
         zd4w==
X-Gm-Message-State: AOAM532lGDj6PMMG+c/k5LV+hacS7ah8Suauz+Yt8xlY5f3jtn2en8rX
        5N77KFjh3p4lo/KmFB5AroZDJQ==
X-Google-Smtp-Source: ABdhPJxuz0OK9LfQtbHytm4gTdeIsUNNlJtwRZx+O8qO8GtbdkHHvlem5OqFYML0B70oLzj6q0pcwA==
X-Received: by 2002:a7b:ce11:0:b0:38e:c257:4c76 with SMTP id m17-20020a7bce11000000b0038ec2574c76mr137202wmc.151.1649876869019;
        Wed, 13 Apr 2022 12:07:49 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:48 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 25/33] dt-bindings: crypto: rockchip: convert to new driver bindings
Date:   Wed, 13 Apr 2022 19:07:05 +0000
Message-Id: <20220413190713.1427956-26-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413190713.1427956-1-clabbe@baylibre.com>
References: <20220413190713.1427956-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest addition to the rockchip crypto driver need to update the
driver bindings.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/rockchip,rk3288-crypto.yaml        | 85 +++++++++++++++++--
 1 file changed, 76 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
index b4e87e9894f8..ad604d7e4bc0 100644
--- a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
+++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
@@ -13,6 +13,8 @@ properties:
   compatible:
     enum:
       - rockchip,rk3288-crypto
+      - rockchip,rk3328-crypto
+      - rockchip,rk3399-crypto
 
   reg:
     maxItems: 1
@@ -21,23 +23,88 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 3
     maxItems: 4
 
   clock-names:
+    minItems: 3
     maxItems: 4
-    items:
-      const: aclk
-      const: hclk
-      const: sclk
-      const: apb_pclk
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   reset-names:
-    maxItems: 1
-    items:
-      const: crypto-rst
+    minItems: 1
+    maxItems: 3
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3288-crypto
+    then:
+      properties:
+        clocks:
+          minItems: 4
+        clock-names:
+          items:
+            - const: "aclk"
+            - const: "hclk"
+            - const: "sclk"
+            - const: "apb_pclk"
+          minItems: 4
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: "crypto-rst"
+          maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3328-crypto
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: "hclk_master"
+            - const: "hclk_slave"
+            - const: "sclk"
+          maxItems: 3
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: "crypto-rst"
+          maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3399-crypto
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: "hclk_master"
+            - const: "hclk_slave"
+            - const: "sclk"
+          maxItems: 3
+        resets:
+          minItems: 3
+        reset-names:
+          items:
+            - const: "rst_master"
+            - const: "rst_slave"
+            - const: "crypto-rst"
+          minItems: 3
 
 required:
   - compatible
-- 
2.35.1

