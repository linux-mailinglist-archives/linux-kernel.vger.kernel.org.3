Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177CD51EA20
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355122AbiEGUke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446964AbiEGUkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:40:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7094A1A050;
        Sat,  7 May 2022 13:36:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i19so20127463eja.11;
        Sat, 07 May 2022 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ViM0XELfh6s+qiFABkqI+WbFDa/9aqIqNljn2rQxT14=;
        b=IdCY/VJLdYjQVcGYDHv7DvvY5cu2OiukGHDORUQZ+u6vsNKSWmPHlksbbSOE1fmAq0
         qF/8m3aGhlnJnfqd0Zdnjpm7Rh80sBGF7jXmOxUD7DFGVJnLni6N19127kChoGrN9GgZ
         MwnJlM816XDaj7LgmyLsdp8uEYYks0D3uJEK2ZeQWS1nihti6p7wmpVnhonlNVt0lr4o
         m6Osoixe4QQo9/0YetCP1zchceZS0UTd3DaaGkp4CYDbvLyuGqKiNI+k77Gf40cRju/l
         v+o9qYFX4oq6KSquBirv+4oMZ05tKzpEqBw+y0y6xHD8hfX/qbgu+pKet7uhFN9qEd9s
         9DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ViM0XELfh6s+qiFABkqI+WbFDa/9aqIqNljn2rQxT14=;
        b=wi/8cs+vFIXyFQjyC9A+mcWyIDZpxbO7+eKCtnyJPzKnyuOeYdY0xZX/j55GH4rdja
         bXRpX1Ri6qGSaTRqHFdAALpXCIvofYGmkiFWvHaCPBo+bSjQvxHGfkECbvgBVj+6JRqc
         u4G3AIhf5f4KN0GCT4U5V1S/akyPJAwXPjE3FQ9clGX2s+TSGuGXaeBvKGR+WCu7/r+j
         iGF6D+poVqt5edwcHd9y758ES4M9lHiXWrEBS7jcteW0XIqSfkyzUL4uFRwHrTmcLkJK
         zJIbv9fowILPQs6Rt8T1Nb3tWazgUtXye6U9ztuTUS/X4aCi6y4sxY+JtYy8aFlyxf4F
         ns+g==
X-Gm-Message-State: AOAM532OX6INfVqjH+htDeLw6IjVClVsxlwqCT9x62bwbWIDFiBLHxW+
        VXG3S09VSKhjVA2kX79np0w=
X-Google-Smtp-Source: ABdhPJyAWz0k/PgBD35GMC/k388JZ3mysq4UwEtLRYReoczgLVdPeqYR4xcR6RyBXqlMaq6MUAaMOw==
X-Received: by 2002:a17:906:d552:b0:6f8:6136:d0a0 with SMTP id cr18-20020a170906d55200b006f86136d0a0mr2926688ejc.366.1651955789840;
        Sat, 07 May 2022 13:36:29 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id eb20-20020a170907281400b006f4c557b7d2sm3283456ejc.203.2022.05.07.13.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:36:29 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 5/6] dt-bindings: mailbox: qcom: set correct #clock-cells
Date:   Sat,  7 May 2022 22:36:19 +0200
Message-Id: <20220507203620.399028-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507203620.399028-1-robimarko@gmail.com>
References: <20220507203620.399028-1-robimarko@gmail.com>
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

IPQ6018 and IPQ8074 require #clock-cells to be set to 1 as their APSS
clock driver provides multiple clock outputs.

So allow setting 1 as #clock-cells and check that its set to 1 for IPQ6018
and IPQ8074, check others for 0 as its currently.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
* Drop not needed blank line

Changes in v2:
* Correct subject name
---
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index 3b5ba7ecc19d..95ecb84e3278 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -50,7 +50,7 @@ properties:
     const: 1
 
   '#clock-cells':
-    const: 0
+    enum: [0, 1]
 
   clock-names:
     minItems: 2
@@ -96,6 +96,21 @@ allOf:
       properties:
         clocks:
           maxItems: 3
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,ipq6018-apcs-apps-global
+            - qcom,ipq8074-apcs-apps-global
+    then:
+      properties:
+        '#clock-cells':
+          const: 1
+    else:
+      properties:
+        '#clock-cells':
+          const: 0
+
 examples:
 
   # Example apcs with msm8996
-- 
2.35.1

