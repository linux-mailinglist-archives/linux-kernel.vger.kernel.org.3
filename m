Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D385B1648
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiIHIHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiIHIHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:07:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7088D4198
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:07:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id q7so26449496lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 01:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=JIBPCNWbj9cecXNvDfnBoFCAPIFUTWEJI8WrfdBbKVU=;
        b=snZdPWqtr2eMuQRIlgwO7pqW5RS7DVletpBtdbQ/AOgKqBNLimr4sr73NibaKOKnHT
         lFg1q0Tg2aW1uv1vkfG7wwlfhGz5usjBJG46KkP7NjFYyRnryPl1U/853K28tinaSjCL
         XlakPQUFXSmI/ZtFkVJOk4UfKTwpulQp/QWY15oXeAqLzNu31C41fYiXotrJzG7JACbx
         G4LVSTXOroy+rBBH4+DtHw+XieEsQCFo0rjWT/6HAn4HI1XMQfGrY1i+ZLnmfkE0Ily/
         stvpQ/eNhZZtHhhdqb3oYirg8Ka2F6x+Z6Y8IOnNVTlsDSgOFbY022xo+8t43pbUio8C
         ndvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=JIBPCNWbj9cecXNvDfnBoFCAPIFUTWEJI8WrfdBbKVU=;
        b=sHEKkQJ1ixTnWrYMrxHBnt9XGLOrCklStkFxFljCtcvmR6DpjWEptawK4lOb+m/1Rx
         zghc6469sdQMMhmP44Ufi3pXz7zH4UFZKCqVDgo0EY/VFzCNCsIVFbUKJbbAS3u0fwVg
         qgbY0pL5k11DfYvqGDjBYFmVlBOfHWxrPK2l02zVq9/Us/FXL4KGkACdfuBtz7MuwZgp
         fM4aLxuXIpxyBadCpiSsErL+7rlQMsl7eFCL5TboTR0Vjl88PWVwnM9sCNEhSrKdbsWB
         E8nLEySlDaLpHOJzI4/+tm7B4bx5t4kJMqe69NORMvLIKDmQotq/2drc+wPBE2zm6L5B
         lvyQ==
X-Gm-Message-State: ACgBeo1XSiQVT8/O/sh19Yodp1IL4djXhpLleJrf8DZgbFTC3jZcIMlo
        YOs5rGArlq8+peN379DN+9pg4g==
X-Google-Smtp-Source: AA6agR6bi61JlNKPmLVRo+JBbKRF4+ff8UPjrT51MF24gA/paG6mogNY3pKdrlEwgKZdQwtOqarzdQ==
X-Received: by 2002:a05:6512:1285:b0:494:680f:390f with SMTP id u5-20020a056512128500b00494680f390fmr2230044lfs.601.1662624428165;
        Thu, 08 Sep 2022 01:07:08 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n27-20020a05651203fb00b0048a757d1303sm2920503lfq.217.2022.09.08.01.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 01:07:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: pinctrl: qcom,pmic-mpp: make compatible fallbacks specific
Date:   Thu,  8 Sep 2022 10:07:03 +0200
Message-Id: <20220908080703.28643-1-krzysztof.kozlowski@linaro.org>
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

Instead of allowing compatibles followed by any fallback (for SPMI or
SSBI PMICs), make the list specific.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,pmic-mpp.yaml       | 45 ++++++++++---------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
index df79274d0ec3..72cce38bc1ce 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
@@ -15,28 +15,29 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - qcom,pm8018-mpp
-          - qcom,pm8019-mpp
-          - qcom,pm8038-mpp
-          - qcom,pm8058-mpp
-          - qcom,pm8226-mpp
-          - qcom,pm8821-mpp
-          - qcom,pm8841-mpp
-          - qcom,pm8916-mpp
-          - qcom,pm8917-mpp
-          - qcom,pm8921-mpp
-          - qcom,pm8941-mpp
-          - qcom,pm8950-mpp
-          - qcom,pmi8950-mpp
-          - qcom,pm8994-mpp
-          - qcom,pma8084-mpp
-          - qcom,pmi8994-mpp
-
-      - enum:
-          - qcom,spmi-mpp
-          - qcom,ssbi-mpp
+    oneOf:
+      - items:
+          - enum:
+              - qcom,pm8019-mpp
+              - qcom,pm8226-mpp
+              - qcom,pm8841-mpp
+              - qcom,pm8916-mpp
+              - qcom,pm8941-mpp
+              - qcom,pm8950-mpp
+              - qcom,pmi8950-mpp
+              - qcom,pm8994-mpp
+              - qcom,pma8084-mpp
+              - qcom,pmi8994-mpp
+          - const: qcom,spmi-mpp
+      - items:
+          - enum:
+              - qcom,pm8018-mpp
+              - qcom,pm8038-mpp
+              - qcom,pm8058-mpp
+              - qcom,pm8821-mpp
+              - qcom,pm8917-mpp
+              - qcom,pm8921-mpp
+          - const: qcom,ssbi-mpp
 
   reg:
     maxItems: 1
-- 
2.34.1

