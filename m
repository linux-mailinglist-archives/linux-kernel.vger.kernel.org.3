Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C651EDF1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 16:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiEHODm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 10:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiEHODc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 10:03:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D021DFB1
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 06:59:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ba17so13521026edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGkttDqvYsUUsrUXY9BC2Fg/b2UvTJ5Tzg5qvRI7Pfg=;
        b=R9RyiZXiRXv6vcGsngJu755jCUvGkw6ljd7grwWqoZNb/ssw/4hYNB5vB9lRa55bZ+
         taUSkVPQIZbHizX2MevwOf9pxOeWARKNOcvLsL3wASS5hSf8+GEUa+n6Bl6AKf3y3wcc
         rEEKdlRNJca0M3bR3PHM1Zp0TcWxL2JpDLZMwCbxIfDrhw9eAAYfFjEUy1zzxTXJOZrX
         3zaQ/dQ9jVXAeXhJl+SL9anhqZ0++VX63p5al1ryHuAblo5bRr160degilyoxjjxmGQJ
         3XI3s5/6YDoHJiN57u8g+89+TYMme/PCTMy17UpzOjSNKTVbrUWMqc4doydRxVY3pGns
         qjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGkttDqvYsUUsrUXY9BC2Fg/b2UvTJ5Tzg5qvRI7Pfg=;
        b=4w7vMaDmqNu/xC2FGxtc9p93lwBnOM9874hry47JhgFtU5ihk1xELvbnf/osQZkz/r
         Pv/UkMUQPWl73/Q6kte9lnkPVTSgFQvZDRCqMPx3NiGvbiGx42R+DcNbOJtJYy0VJE4n
         tGAGDrRehguqlGJEbQgPQDtk9FHfORDq466+vnun2h8Piu2V5rj99n3j9ZrFkSqFAcNO
         GZ/Dj4EM2EqEFrutvvoxKm8E9f2l9eV9WORZA6ofQbCDNMcXUdqs8X9EtIIGV+NL7609
         iTRvpf5LeCKtZXxzjYSuA5T3UeKPf2lWNyfyQquW8VIYU+9oA/ltAfv5LwnzKU9pAsjT
         TPJA==
X-Gm-Message-State: AOAM533tVkyNlOuypAxEYO/HFYrRgi5XMI10Hq9yHAtJI6x74ufdvZ/p
        ANzcNAT6Azj1BfMe0MzF4Ew/fQ==
X-Google-Smtp-Source: ABdhPJyyEyxl9FMGJJ4ozYTfSy5BfZGk1porbFMbi0rxnxZtLnTydeSDWYl5p3+oGop5WsR4vS68JA==
X-Received: by 2002:a50:ce19:0:b0:425:d85c:90e3 with SMTP id y25-20020a50ce19000000b00425d85c90e3mr12866432edi.350.1652018380092;
        Sun, 08 May 2022 06:59:40 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id qz24-20020a170907681800b006f3ef214dc6sm4075524ejc.44.2022.05.08.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 06:59:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Luca Weiss <luca@z3ntu.xyz>, David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] dt-bindings: pinctrl: qcom,pmic-gpio: add 'gpio-reserved-ranges'
Date:   Sun,  8 May 2022 15:59:29 +0200
Message-Id: <20220508135932.132378-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220508135932.132378-1-krzysztof.kozlowski@linaro.org>
References: <20220508135932.132378-1-krzysztof.kozlowski@linaro.org>
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

'gpio-reserved-ranges' property is already used and supported by common pinctrl
bindings, so add it also here to fix warnings like:

  qrb5165-rb5.dtb: gpio@c000: 'gpio-reserved-ranges' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 7e74a87ccc39..69195660ee2a 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -78,6 +78,12 @@ properties:
     minItems: 2
     maxItems: 44
 
+  gpio-reserved-ranges:
+    minItems: 1
+    # maxItems as half of total number of GPIOs, as there has to be at
+    # least one usable GPIO between each reserved range.
+    maxItems: 22
+
   '#gpio-cells':
     const: 2
     description:
@@ -107,6 +113,8 @@ allOf:
         gpio-line-names:
           minItems: 2
           maxItems: 2
+        gpio-reserved-ranges:
+          maxItems: 1
 
   - if:
       properties:
@@ -124,6 +132,9 @@ allOf:
         gpio-line-names:
           minItems: 4
           maxItems: 4
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 2
 
   - if:
       properties:
@@ -137,6 +148,9 @@ allOf:
         gpio-line-names:
           minItems: 6
           maxItems: 6
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 3
 
   - if:
       properties:
@@ -150,6 +164,9 @@ allOf:
         gpio-line-names:
           minItems: 8
           maxItems: 8
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 4
 
   - if:
       properties:
@@ -163,6 +180,9 @@ allOf:
         gpio-line-names:
           minItems: 9
           maxItems: 9
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 5
 
   - if:
       properties:
@@ -182,6 +202,9 @@ allOf:
         gpio-line-names:
           minItems: 10
           maxItems: 10
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 5
 
   - if:
       properties:
@@ -194,6 +217,9 @@ allOf:
         gpio-line-names:
           minItems: 11
           maxItems: 11
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 6
 
   - if:
       properties:
@@ -212,6 +238,9 @@ allOf:
         gpio-line-names:
           minItems: 12
           maxItems: 12
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 6
 
   - if:
       properties:
@@ -224,6 +253,9 @@ allOf:
         gpio-line-names:
           minItems: 13
           maxItems: 13
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 7
 
   - if:
       properties:
@@ -236,6 +268,9 @@ allOf:
         gpio-line-names:
           minItems: 14
           maxItems: 14
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 7
 
   - if:
       properties:
@@ -248,6 +283,9 @@ allOf:
         gpio-line-names:
           minItems: 16
           maxItems: 16
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 8
 
   - if:
       properties:
@@ -261,6 +299,9 @@ allOf:
         gpio-line-names:
           minItems: 22
           maxItems: 22
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 11
 
   - if:
       properties:
@@ -273,6 +314,9 @@ allOf:
         gpio-line-names:
           minItems: 26
           maxItems: 26
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 13
 
   - if:
       properties:
@@ -285,6 +329,9 @@ allOf:
         gpio-line-names:
           minItems: 36
           maxItems: 36
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 18
 
   - if:
       properties:
@@ -297,6 +344,9 @@ allOf:
         gpio-line-names:
           minItems: 38
           maxItems: 38
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 19
 
   - if:
       properties:
@@ -310,6 +360,9 @@ allOf:
         gpio-line-names:
           minItems: 44
           maxItems: 44
+        gpio-reserved-ranges:
+          minItems: 1
+          maxItems: 22
 
 patternProperties:
   '-state$':
-- 
2.32.0

