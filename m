Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F5756A9C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiGGRhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbiGGRhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:37:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9194453D38;
        Thu,  7 Jul 2022 10:37:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u12so33632454eja.8;
        Thu, 07 Jul 2022 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTqxGKRaQ+4R4vGFv2ndzSh2OvA6/IVMbt55ouGGu20=;
        b=kdx4Nx8NFxwLq90EPWcFdjmjKvR8Nc7CIYHyL9We1Dj1efO4m9KAjgmSVFZMhQmKM0
         UvmRIDMAMWHIL5TtG1xl9ElPzwfThyYx4n79/yyPWNpERY7BgKiByY2CifTnkvETETiU
         kdzx6/0AovY/1sMb9kCoO9cTNslnXVLLGzi6LTkJv7FUb7jUyAoZ0NIKIIpF6/qt4Fmp
         6Jd/NTVwXSoL5XiW+zr6UWaJXRpYEMOxBZwC6dxyDLTE2XFyIA+UoyUNl3fVGU75rzbi
         EaV+XNsPhnM8zYV6RuSIEn2xefoWdK5FEBlCmBlBLD8iCidXeZ6iJGgZiQVSe1IJBHvt
         UI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTqxGKRaQ+4R4vGFv2ndzSh2OvA6/IVMbt55ouGGu20=;
        b=AhoqX0jV5azJmUIrDCzC+DV640RqIRB+e1P947nnszlZiH2s7TEBeXz2r/zJ7w/Mj6
         gfthZpHLjHEnSi+ahW4Glg4SHorE7K/D2RywFZAI9H2Db0kijjAQ9JBraTh6aOIgUjFt
         emetIwQeI20O+BB5UuUK5bzjQZqvXhnpUvoI0a4NN9D11/fxjCQ6W6yK9e8aDH41xZVG
         qkVZl5/QqtFd/eUrqhe8E/YXlfDG5wwUUyVcg328xerNML/nFByFg5ePFuWxswqA4KtC
         yEEKVNyeox7vSoIAeo3YeBYPLDaQixYKfj1EfaCnaEaqkZlodfU0tbOOfyQnYMYokkHM
         erig==
X-Gm-Message-State: AJIora9JTlMqrOA0iMNqeoGgEzwuYLsPt3bVDFc5Qsxibzut8pZs4WRE
        4DuJetua5KyU8IGnX8HFTZM=
X-Google-Smtp-Source: AGRyM1v6pmxNlNCmGigCKNa0PjKVsvHO4Vt0XRzXTKhPxKJTYELJZMlo9HEEDTRJ8lXaLPE9NZCd8A==
X-Received: by 2002:a17:906:8301:b0:6e4:896d:59b1 with SMTP id j1-20020a170906830100b006e4896d59b1mr45983891ejx.396.1657215459063;
        Thu, 07 Jul 2022 10:37:39 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-250.xnet.hr. [88.207.96.250])
        by smtp.googlemail.com with ESMTPSA id l10-20020a1709060cca00b0072b16ea4795sm674715ejh.48.2022.07.07.10.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:37:38 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 3/4] dt-bindings: mailbox: qcom: set correct #clock-cells
Date:   Thu,  7 Jul 2022 19:37:32 +0200
Message-Id: <20220707173733.404947-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707173733.404947-1-robimarko@gmail.com>
References: <20220707173733.404947-1-robimarko@gmail.com>
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
2.36.1

