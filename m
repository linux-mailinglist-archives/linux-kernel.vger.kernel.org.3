Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0153950EA70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245517AbiDYU1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245362AbiDYUZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:25:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367A21301BC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:22:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w4so22432682wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RoEkU2wAHdZrSlV4sPqXXxqUUD/tymZLZdlnbgZM9Yc=;
        b=Lx624Hb1v8mbCoeAt514dLkicA4g8cGOsxM5mgr9CfcmzRoRE9QjF3OUuN8qV248cC
         c8cU3Rs6qgQYuJgFIYMb8KB5OmBLRZD5w5fYiZHnFaTrjokX+Rs3xgaVhvEzFK+6rZd7
         ismfGU1HrufI2PtGUz5+q9Q2k0uoX1IntKAMQ1r2PCnPGOcP4pDr3/GgSegDV14jq+jZ
         FuCX5/Hvng38+UBuYrWpF3+i8AgXuWDG9K9lYSKxJKt4+4VFdxgvPxwPsH3X41xhSV/o
         O38ElT7ffu0RIDyR4vikb4ufpR/qlbuiMvDdkDSbYz8307PJdCv2boqKfDEpntsqLxBY
         cPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoEkU2wAHdZrSlV4sPqXXxqUUD/tymZLZdlnbgZM9Yc=;
        b=nGObdbmw9JS++HRpfDqT4y4EOlgq82/qKO4Avi/MFE4ct7r1xpNeoXTsk3dHUiA9V9
         NCrJaG2fXiPoRFJMUOAhYosyRcMgLsstIxvRLk7OPr1IkqHG/vNvsknjbft6MNSk4a1+
         g1ceDBnRl4TEHd1/9bnBLxkQ7vR3Tpfvy2/ksq3kyIMYjCOxnmVFxroyPyYGs8/r1YQ+
         z2IWugjus29VNtyb6lWfX2LHlpMQDnqA/iIycl/PQZM69//83ZcWLcjH5MVD17ktKAvM
         HPjCcFEgUYaHvckkVEFUdFHJEZ7k/ysope9M98XrEWRIPSbUvrUi0w7EGL5BNChh50Gq
         PRrQ==
X-Gm-Message-State: AOAM530yXJdB06e6ozKXOC9EP1lKdfQWrI2rxfqZoW9Tb59yxkomJZKr
        JIPXeXRfmZCYIBbStmW/6qbz9AsdiM9Oxw==
X-Google-Smtp-Source: ABdhPJwP7xSsF5UJIq/gGiZBqI8EFC+nzUbUZIbMLeZPHpF3ww+DSMXe+2kgo+zQHk3hV1CpelO9gg==
X-Received: by 2002:adf:b64c:0:b0:1e3:16d0:3504 with SMTP id i12-20020adfb64c000000b001e316d03504mr15276335wre.333.1650918111706;
        Mon, 25 Apr 2022 13:21:51 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p3-20020a5d59a3000000b0020a9132d1fbsm11101003wrr.37.2022.04.25.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:21:51 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 25/33] dt-bindings: crypto: rockchip: convert to new driver bindings
Date:   Mon, 25 Apr 2022 20:21:11 +0000
Message-Id: <20220425202119.3566743-26-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425202119.3566743-1-clabbe@baylibre.com>
References: <20220425202119.3566743-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 1 file changed, 77 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
index 8a219d439d02..ad604d7e4bc0 100644
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
@@ -21,21 +23,88 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 3
     maxItems: 4
 
   clock-names:
-    items:
-      - const: aclk
-      - const: hclk
-      - const: sclk
-      - const: apb_pclk
+    minItems: 3
+    maxItems: 4
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   reset-names:
-    items:
-      - const: crypto-rst
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

