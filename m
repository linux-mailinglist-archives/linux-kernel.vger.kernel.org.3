Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DE6571694
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiGLKHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbiGLKHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:07:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE4FAAB3E;
        Tue, 12 Jul 2022 03:07:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g1so9435854edb.12;
        Tue, 12 Jul 2022 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hD9PCfFVxjdxgo34wYFmoGSgALWaO8qG+oDMmVmOZg0=;
        b=kXPavMW5sAa+Rbyof8y1bogy7+VAlw9KQ3529zM/VyZO5iBcZsrhkcrD/Va0Iafz9n
         WP9I1rDqAFGXzyuuFLCZ0qebiOghHmIIdNGN4AbUuerRccN0bEeUSEktIdEcCfi4gkk/
         9tC3Rk8OkIb2lVmjybOIQ9AubQlFbX57K9B7hZWo21hsCgoLELGcXLLjeweavVtKpXWN
         NMAzfVDjDFaXm7aGBF5s8UTk6TAIPSR8aVBLqzE5L/nPPLeM9f4CJ/PeoHnxNqHPnKXx
         r4R535JuszyvD8vklaM5VhP4onTwCvbKu/j3J7gSqUevbBbA2pttlUchnpjcXpgkgbIb
         TINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hD9PCfFVxjdxgo34wYFmoGSgALWaO8qG+oDMmVmOZg0=;
        b=qlsPP8Hz3vO6gJrhiZ13xNqq3hZfJw0zpvIDBzQZ2bvnmcJPK2vTnbjo+X7S5J3Rqc
         eNTdGvCaurBLY1erLHsNSyO7Ig1PjVN56cIRTWqLQnMhdJl/WqH5DFi2otFmtZNO/Gmr
         HuJNCsgR56uXcgfkHWyb2y3WSG2fACgxIqy8Icddk9r0ODyDsxuKxD6Bya0ZZj7jWKk8
         K6+uqKmNUMfilUljyqjItT5kuf9sm4tXQooDabx1dvaavMVnriYrtjdNkBSUsoFBF9mR
         MJD4U3j2xNMx6RpxFeRtrmVA24dyVj1UUUSg0L4nbHOo3f9gdlB/c6gAQWPQDlBkijZP
         cJtg==
X-Gm-Message-State: AJIora/7fal0hHKYT9WHoSquut5tojX5tViQ46Eac21NQt+iAJYdIn6V
        CitWTOZBOzINHiEa2KwFV7c=
X-Google-Smtp-Source: AGRyM1vL79feMqsyNz94la0rfhTZH3JD4RrnvdugStbHKDbmZCIDZ9DfrdHwHhLHyOOG9d0c/A/DJQ==
X-Received: by 2002:a05:6402:3907:b0:431:6776:64e7 with SMTP id fe7-20020a056402390700b00431677664e7mr30518374edb.0.1657620457532;
        Tue, 12 Jul 2022 03:07:37 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id bd27-20020a056402207b00b0043a21e3b4a5sm5799675edb.40.2022.07.12.03.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:07:37 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v8 2/4] dt-bindings: mailbox: qcom: correct clocks for IPQ6018 and IPQ8074
Date:   Tue, 12 Jul 2022 12:07:31 +0200
Message-Id: <20220712100733.34261-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712100733.34261-1-robimarko@gmail.com>
References: <20220712100733.34261-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ6018 APSS driver is registered by APCS as they share the same register
space, and it uses "pll" and "xo" as inputs.

Correct the allowed clocks for IPQ6018 and IPQ8074 as they share the same
driver to allow "pll" and "xo" as clock-names.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v8:
* Add maxItems to clocks and clock-names
---
 .../mailbox/qcom,apcs-kpss-global.yaml        | 46 ++++++++++++++-----
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 95ecb84e3278..9ebe1af47710 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -41,10 +41,7 @@ properties:
   clocks:
     description: phandles to the parent clocks of the clock driver
     minItems: 2
-    items:
-      - description: primary pll parent of the clock driver
-      - description: auxiliary parent
-      - description: reference clock
+    maxItems: 3
 
   '#mbox-cells':
     const: 1
@@ -54,10 +51,7 @@ properties:
 
   clock-names:
     minItems: 2
-    items:
-      - const: pll
-      - const: aux
-      - const: ref
+    maxItems: 3
 
 required:
   - compatible
@@ -71,8 +65,6 @@ allOf:
       properties:
         compatible:
           enum:
-            - qcom,ipq6018-apcs-apps-global
-            - qcom,ipq8074-apcs-apps-global
             - qcom,msm8916-apcs-kpss-global
             - qcom,msm8994-apcs-kpss-global
             - qcom,msm8996-apcs-hmss-global
@@ -86,7 +78,13 @@ allOf:
     then:
       properties:
         clocks:
-          maxItems: 2
+          items:
+            - description: primary pll parent of the clock driver
+            - description: auxiliary parent
+        clock-names:
+          items:
+            - const: pll
+            - const: aux
   - if:
       properties:
         compatible:
@@ -95,7 +93,31 @@ allOf:
     then:
       properties:
         clocks:
-          maxItems: 3
+          items:
+            - description: primary pll parent of the clock driver
+            - description: auxiliary parent
+            - description: reference clock
+        clock-names:
+          items:
+            - const: pll
+            - const: aux
+            - const: ref
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,ipq6018-apcs-apps-global
+            - qcom,ipq8074-apcs-apps-global
+    then:
+      properties:
+        clocks:
+          items:
+            - description: primary pll parent of the clock driver
+            - description: XO clock
+        clock-names:
+          items:
+            - const: pll
+            - const: xo
   - if:
       properties:
         compatible:
-- 
2.36.1

