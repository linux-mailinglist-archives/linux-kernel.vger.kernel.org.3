Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CAC529A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiEQHBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbiEQHB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:01:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F1B3D1CA
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:01:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ch13so32733489ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzOLeWMoI9zSx/zven+R8jYOl3Pysvttl5adaJeZPwE=;
        b=wm4Jf03mQs70D1AQO8mr+FSdwcopoi8EyQNknbgNQz5wnnLPo4I0y59kwyP4iHEUYC
         1SqcdEXEFLOr9pGaOCDROlHIlSSQNRUYEJUCUIlMFgjZqhNWZDkx+ElBMlMxCqzWSX/U
         WZ+VAv3JvEoGdzR4BUMg2CUXdOLWA96cV/FsZkZRhn1wscj4+1AJZ7ARgkdilmPMO/1l
         wR6bNrD9cK5C43Vrf5HJK/E2A/BKWY0J7U686WdNB1tjQwbir8NSgzn6AAT4uyOo1ECS
         xh9wOM3/Cwm2TpIlk6MA0xy/zbDU4xfn07kRtlmeT/n2AvC9KwUzy4dljEMCLhpusJe8
         V5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzOLeWMoI9zSx/zven+R8jYOl3Pysvttl5adaJeZPwE=;
        b=LxC8i54j+VFbQRtKbbr68ueCFf5B2fKY6Bn2tJhc8amwtYyXgtDkOekVzO4iUYtd95
         Gkj7zXGreqd4zNRdUb5qvLemTqFKSEdsTbUiQGg/QKdU310rjsrvPRS5Vh82Y3PbTDGT
         Zrf9i30XZnJZt6/Qh/9JIz6jB6GFXDNzn9cpCyZV9Em1LTIODB6i+7l1GuUH+MIF7v5W
         N9JNu8KFLrVesrNMyrNFbRfl39EEViFWMgmZuJgwCpPLET/AFS4qaLHg/u1sKUUR3IK6
         hrG4dZjkTA7NX+K8hapYViunZ0Dm8LTovf+Np9CcZY4wHxUXCGlUkMUJW1jS0R2KHPSd
         joJg==
X-Gm-Message-State: AOAM530w8OPy7yD47hZImxUoPp/QlAskMbJBYFeQ2iFRzUVE/VtCC+br
        ZkwGK/o5/XJqtLQTLv8RBC5WJA==
X-Google-Smtp-Source: ABdhPJyS4ug6RGlpiMRHX5YhbZbZdKpS4A8GRbN8on3xyqWHOCo07ADAj6g3CTyFB5ZKerIDTALrYw==
X-Received: by 2002:a17:907:2ce3:b0:6f5:130e:d98f with SMTP id hz3-20020a1709072ce300b006f5130ed98fmr17878330ejc.706.1652770883851;
        Tue, 17 May 2022 00:01:23 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b5-20020a056402138500b0042617ba637esm6487016edv.8.2022.05.17.00.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 00:01:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 05/12] dt-bindings: remoteproc: qcom,adsp: simplify SM8150 power domains
Date:   Tue, 17 May 2022 09:01:06 +0200
Message-Id: <20220517070113.18023-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
References: <20220517070113.18023-1-krzysztof.kozlowski@linaro.org>
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

The SM8150 if cases for power domains can be merged with another entry.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
index 0b2db36e5d14..e3a193299c4a 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
@@ -371,6 +371,8 @@ allOf:
               - qcom,msm8226-adsp-pil
               - qcom,msm8996-adsp-pil
               - qcom,msm8998-adsp-pas
+              - qcom,sm8150-adsp-pas
+              - qcom,sm8150-cdsp-pas
     then:
       properties:
         power-domains:
@@ -434,19 +436,6 @@ allOf:
             - const: cx
             - const: mx
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sm8150-adsp-pas
-              - qcom,sm8150-cdsp-pas
-    then:
-      properties:
-        power-domains:
-          items:
-            - description: CX power domain
-
   - if:
       properties:
         compatible:
-- 
2.32.0

