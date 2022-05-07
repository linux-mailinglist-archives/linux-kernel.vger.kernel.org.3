Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7F151E9AA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446955AbiEGTxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241958AbiEGTxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:53:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0A318381
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 12:49:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so6207057wmz.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 12:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KZqXP6hZh5GqqoyrCubUDtDOPQns4Gp5tyf1oRlYqoQ=;
        b=kBrCVNL+ziJAuwGUKfdbmU1rnM4z9UmOzc2fn8Q+3Jxs5LCWgbna2hB/sre4Ykp1rI
         QQsQ8gpXwzbLw9mUOOPATqwcrGp5m7piKVp2WdxIUsRyhH44Ff9/pimjdVgcoG9SRtNf
         jeGx1KNvUpromFl6YJb/txZDC2d4m1IzjhYoCK2oxq8fO1lHWtVJGYPqSkxZSakwFxfM
         gRFglx7wOlrx+8p/nMJA0MYmT76CU2v6/acH8FqADTPksRU7p8cX4EQO2u98xu0LHiD7
         q+8RD0oGIipImAVtA2umu7MIlm7hSpl9bPW6tRvltp414BVj6D/zwydyAGmbKxhI7flD
         K/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZqXP6hZh5GqqoyrCubUDtDOPQns4Gp5tyf1oRlYqoQ=;
        b=jVhMQrzh4PsagbUdh7R0w6reo0Ie0MGSV0/pimL69JRqoaQalosZ4MPJUUgjny31TC
         2W4mNxI56MNg++FpbFfGJAwTHgBom+UFjfxvrAlTZuFK45jLh2iuoX6cKXM+S1iE5sN5
         PWI2PBSq65PDAKKvoI809NXeQUlHsdZgalNeV8Vq71Ub/x4Y9EFEcbCa755yiSuiVuYE
         NlxkQ6DYjzx09gB5KHcwFGWTACLNXXojza2kGo8tfXEaFNdjv/28S9yhJSMpZNgpeatO
         GvjEY7IgpM7t/FYbeX0bmoGg8aDsjG6FKES46LWOTLR6yUy+5yaQMkRQbt4DjFetEuvR
         lFNA==
X-Gm-Message-State: AOAM532n/+Zky+59jz+ehOiJ9E2MybP2iqRlzFvpbJv1anwh4Loo0WID
        NuJlC4XKrSYmcurN7HIAReTscg==
X-Google-Smtp-Source: ABdhPJw0NQ0meG1Pbjqe5F5Tc29/I/eI4AP15zHWncKsrvzWPKz+e71IIdyqeSULpHmyMcrbrgQzzg==
X-Received: by 2002:a05:600c:3c97:b0:392:9ad0:1911 with SMTP id bg23-20020a05600c3c9700b003929ad01911mr15907698wmb.187.1651952963177;
        Sat, 07 May 2022 12:49:23 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c1c0600b003942a244ec4sm8535027wms.9.2022.05.07.12.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 12:49:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Luca Weiss <luca@z3ntu.xyz>, David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 03/11] dt-bindings: pinctrl: qcom,pmic-gpio: describe gpio-line-names
Date:   Sat,  7 May 2022 21:49:05 +0200
Message-Id: <20220507194913.261121-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
References: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing 'gpio-line-names' property and describe its constraints for
all models except PM8226 (which seems not really used).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 221 ++++++++++++++++++
 1 file changed, 221 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index c266aa3f05c1..33eb52660291 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -74,6 +74,10 @@ properties:
   gpio-ranges:
     maxItems: 1
 
+  gpio-line-names:
+    minItems: 2
+    maxItems: 44
+
   '#gpio-cells':
     const: 2
     description:
@@ -90,6 +94,223 @@ required:
   - gpio-ranges
   - interrupt-controller
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8008-gpio
+              - qcom,pmi8950-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 2
+          maxItems: 2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8005-gpio
+              - qcom,pm8450-gpio
+              - qcom,pm8916-gpio
+              - qcom,pmk8350-gpio
+              - qcom,pmr735a-gpio
+              - qcom,pmr735b-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 4
+          maxItems: 4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8018-gpio
+              - qcom,pm8019-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 6
+          maxItems: 6
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8350b-gpio
+              - qcom,pm8950-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 8
+          maxItems: 8
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm6350-gpio
+              - qcom,pm8350c-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 9
+          maxItems: 9
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm2250-gpio
+              - qcom,pm6150-gpio
+              - qcom,pm7325-gpio
+              - qcom,pm8150-gpio
+              - qcom,pm8350-gpio
+              - qcom,pmc8180-gpio
+              - qcom,pmi8994-gpio
+              - qcom,pmm8155au-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 10
+          maxItems: 10
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pmx55-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 11
+          maxItems: 11
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm660l-gpio
+              - qcom,pm6150l-gpio
+              - qcom,pm8038-gpio
+              - qcom,pm8150b-gpio
+              - qcom,pm8150l-gpio
+              - qcom,pmc8180c-gpio
+              - qcom,pms405-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 12
+          maxItems: 12
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm660-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 13
+          maxItems: 13
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pmi8998-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 14
+          maxItems: 14
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pmx65-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 16
+          maxItems: 16
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8994-gpio
+              - qcom,pma8084-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 22
+          maxItems: 22
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8998-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 26
+          maxItems: 26
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8941-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 36
+          maxItems: 36
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8917-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 38
+          maxItems: 38
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm8058-gpio
+              - qcom,pm8921-gpio
+    then:
+      properties:
+        gpio-line-names:
+          minItems: 44
+          maxItems: 44
+
 patternProperties:
   '-state$':
     oneOf:
-- 
2.32.0

