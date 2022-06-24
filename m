Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA13055986A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiFXLVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiFXLVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:21:16 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB60B7928A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 04:21:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eo8so3066868edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nswwdq9kMT+/2jh1GVwB6lx89Sb6QhmoZOaTHHpxSRg=;
        b=PCs0VJyiDsVMvPRWH/uSgRuNoJMFBJ1IXL/NJBVtBu08gRHJi+ZH0Bu0BWfKbb7VLu
         zawX5TFLQdefNPlie9qAQ6AVoDCqmGu6JuGXJj9oJn/2Nlh6XK1kDlG5Y9TCQoLj47+Q
         Sat/+DRU8dR968xKKYf5vy6p0WUmSkX4H+qisMcO2LJcTslk0N6FdwR4/8kj+IG6MY1U
         9KXuCPHmIvdXUYRlWrtCctuALzy2CwgkwoRcbmsG0f0JjxSr49l4r8PmH3/Q3eY3zewR
         HnziikgM21IhN6kenx+Fs2xXUTofRVCaaY14qEldot/4dasv8YQG6fVRge8P6/8vEFBP
         +yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nswwdq9kMT+/2jh1GVwB6lx89Sb6QhmoZOaTHHpxSRg=;
        b=RkVF8trne4yJeAcE5sIiU65TE3bm02staYN831BUBKnn7Ho5x6H4S4d1jZlvBSQMAP
         J+oDvl/5aMh3EP7enaJDnQ2pTS5tsYe/jSaSqRt/vjvcxipDcWnjsn10P5PyvNbHqwip
         RvSplnuEJ0h6XDVtth2+5xkyFbcFaSCs9/8qafjdR4gfim4kEB45Up/1QmQhmsOw6Ff5
         lb8Dcaf42r6M2zB54bKAgs71+DDWGLGtsxwlajGy82lMPC0x8Ku2j8DLZIHmlN5A5GOy
         rkYeloINdOMAIQuJCTk5c9tBh1h3jKk35cmOO8cCdxim1azvglZRRm3WJYfqJOpJLgu7
         v/nw==
X-Gm-Message-State: AJIora//7u+1lev7/TkSdbp2p+d1TAC1llL2kCYXqSWbjANBLXhhhDnH
        fpKt6s7Bt3RJYJJXoSUUgub+iQ==
X-Google-Smtp-Source: AGRyM1t+3q8i3H1TjipkxGeDkdr3UTTrFKyKEuBidyDjFwMg7pLhaXm/xh1pnaG2df6LaAhL7WaZYg==
X-Received: by 2002:a05:6402:3546:b0:42e:2f58:2c90 with SMTP id f6-20020a056402354600b0042e2f582c90mr16943057edd.84.1656069672244;
        Fri, 24 Jun 2022 04:21:12 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906698a00b00705fa7087bbsm951874ejr.142.2022.06.24.04.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 04:21:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dan Murphy <dmurphy@ti.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: leds: class-multicolor: reference class directly in multi-led node
Date:   Fri, 24 Jun 2022 13:21:06 +0200
Message-Id: <20220624112106.111351-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The leds/common.yaml is referenced directly in each LED node, which
leads to people doing the same with leds/leds-class-multicolor.yaml.
This is not correct because leds-class-multicolor.yaml defined multi-led
property and its children.  Some schemas implemented this incorrect.

Rework this to match same behavior common.yaml, so expect the multi-led
node to reference the leds-class-multicolor.yaml.  Fixing allows to add
unevaluatedProperties:false.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This will conflict with any new users of leds-class-multicolor, e.g.:
https://lore.kernel.org/all/20220623115631.22209-4-peterwu.pub@gmail.com/

The new users should be updated to match the usage introduced here.
---
 .../leds/cznic,turris-omnia-leds.yaml         |  2 ++
 .../bindings/leds/leds-class-multicolor.yaml  | 32 +++++++++----------
 .../devicetree/bindings/leds/leds-lp50xx.yaml |  2 ++
 .../bindings/leds/leds-pwm-multicolor.yaml    |  5 ++-
 .../bindings/leds/leds-qcom-lpg.yaml          |  2 ++
 5 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml b/Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml
index 9362b1ef9e88..14bebe1ad8f8 100644
--- a/Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml
+++ b/Documentation/devicetree/bindings/leds/cznic,turris-omnia-leds.yaml
@@ -33,6 +33,8 @@ patternProperties:
   "^multi-led@[0-9a-b]$":
     type: object
     $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+
     description:
       This node represents one of the RGB LED devices on Turris Omnia.
       No subnodes need to be added for subchannels since this controller only
diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
index f41d021ed677..12693483231f 100644
--- a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
@@ -19,22 +19,22 @@ description: |
   LED class.  Common LED nodes and properties are inherited from the common.yaml
   within this documentation directory.
 
-patternProperties:
-  "^multi-led(@[0-9a-f])?$":
-    type: object
-    description: Represents the LEDs that are to be grouped.
-    properties:
-      color:
-        description: |
-          For multicolor LED support this property should be defined as either
-          LED_COLOR_ID_RGB or LED_COLOR_ID_MULTI which can be found in
-          include/linux/leds/common.h.
-        enum: [ 8, 9 ]
-
-    $ref: "common.yaml#"
-
-    required:
-      - color
+properties:
+  $nodename:
+    pattern: "^multi-led(@[0-9a-f])?$"
+
+  color:
+    description: |
+      For multicolor LED support this property should be defined as either
+      LED_COLOR_ID_RGB or LED_COLOR_ID_MULTI which can be found in
+      include/linux/leds/common.h.
+    enum: [ 8, 9 ]
+
+required:
+  - color
+
+allOf:
+  - $ref: "common.yaml#"
 
 additionalProperties: true
 
diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
index d11898567313..d44bf48b3c2f 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
@@ -56,6 +56,8 @@ patternProperties:
   '^multi-led@[0-9a-f]$':
     type: object
     $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+
     properties:
       reg:
         minItems: 1
diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
index fdaf04e03a8d..e9fdecdaf84d 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -19,6 +19,8 @@ properties:
 
   multi-led:
     type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
 
     patternProperties:
       "^led-[0-9a-z]+$":
@@ -42,9 +44,6 @@ properties:
 required:
   - compatible
 
-allOf:
-  - $ref: leds-class-multicolor.yaml#
-
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
index 409a4c7298e1..fe336fa16518 100644
--- a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -58,6 +58,8 @@ properties:
   multi-led:
     type: object
     $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+
     properties:
       "#address-cells":
         const: 1
-- 
2.34.1

