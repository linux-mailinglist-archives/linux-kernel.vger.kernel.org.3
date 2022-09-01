Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227C65A97AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiIANAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiIAM6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:58:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4735F90816
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:57:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso1399160wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=a7kQbSuJBA+hO+22/DPT0818Q67abekR8AZbfSsKp0c=;
        b=u9zUrow7UUAI2VuY0iwmPzhV8W5dimlC/350NOd2L3tXR2TZ/Nejbgiu/1bUp5pYcO
         k9S3Fj5VZEa8osLdkf+cvWPER3AuYQHXUEKzBTff2yUHC2iPzTceaJnWcADh24dpOKpm
         jDRWx7WJyXWqyuzNAK3YlbLpMPZmXq4Ci18YqdMYtKaqWfu4eoXbvMj/3N2q7FGw9E15
         QS9377Jv3ULe3GZXDAD8/3QySkbxZF9Q0tfdSJezyhxJcUgU5qavpXwifl1vDJ4MqpK3
         hcsHBmoAcbV1R/bSB2zmafCBfNXA/xyugF9qGieoy0Cx5yR4dEG+/gMfOLtMrSR53/1x
         7CnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=a7kQbSuJBA+hO+22/DPT0818Q67abekR8AZbfSsKp0c=;
        b=MwJbQQReNBjVoYFSsHF22doMNCpRuh82XCBvG+tRJICE+ycl3b/ML8ClvNuQxqEFkk
         ZFvqVr+kMqI05p3WxjTzZQIVwdJZ5a2UPbBAqSh+Ekc02Ber85rDGJwoXZfomMMOi6WH
         xTcdr6Rovgbx8Vk6jCstsp7DRLm9nk6/ZKQioPB6nt1OvKw9UXJpEYQfLnEu//RmAHU3
         4R7zzXGMSIBWJ52Q131Mr7+XY9WdWRgAWdpvYqX3r/IZwxHJBFUNRF8ZGBZ9vOhGbvE/
         iJV5YgdBaiAjt14mWoRsZbPfqzfiv6a/W/8q9mmnAWNdlHJmA00jl7a7c6vYZkCiRlp+
         FTxA==
X-Gm-Message-State: ACgBeo1wH4gLqXB9GHT31W4kXqPU5bQP9HpuuZhH0yiGMJ4YcITgXY7t
        ohUKbB+6zRsbHyRrV1n4hbq7yg==
X-Google-Smtp-Source: AA6agR5VvcCXGzWQESlA+LLQuf2ieHTUv+0KU0BzRwd+V6NbSjvJ0o3/pRpLlVr4iK7FMU49/1c9LQ==
X-Received: by 2002:a05:600c:1e88:b0:3a6:2ca3:f7f2 with SMTP id be8-20020a05600c1e8800b003a62ca3f7f2mr5334042wmb.7.1662037062715;
        Thu, 01 Sep 2022 05:57:42 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v5-20020a5d59c5000000b002257fd37877sm15556709wry.6.2022.09.01.05.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:57:42 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, ardb@kernel.org,
        davem@davemloft.net, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v9 25/33] dt-bindings: crypto: rockchip: convert to new driver bindings
Date:   Thu,  1 Sep 2022 12:57:02 +0000
Message-Id: <20220901125710.3733083-26-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220901125710.3733083-1-clabbe@baylibre.com>
References: <20220901125710.3733083-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The latest addition to the rockchip crypto driver need to update the
driver bindings.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../crypto/rockchip,rk3288-crypto.yaml        | 79 +++++++++++++++++--
 1 file changed, 71 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
index 8a219d439d02..b7870a4cbdbe 100644
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
@@ -21,21 +23,82 @@ properties:
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
+            - const: aclk
+            - const: hclk
+            - const: sclk
+            - const: apb_pclk
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: crypto-rst
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
+            - const: hclk_master
+            - const: hclk_slave
+            - const: sclk
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: crypto-rst
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
+            - const: hclk_master
+            - const: hclk_slave
+            - const: sclk
+        resets:
+          minItems: 3
+        reset-names:
+          items:
+            - const: rst_master
+            - const: rst_slave
+            - const: crypto-rst
 
 required:
   - compatible
-- 
2.35.1

