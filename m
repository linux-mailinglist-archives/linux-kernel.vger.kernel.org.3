Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955C757168F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiGLKHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiGLKHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:07:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151E4AAB38;
        Tue, 12 Jul 2022 03:07:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y8so9462393eda.3;
        Tue, 12 Jul 2022 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTqxGKRaQ+4R4vGFv2ndzSh2OvA6/IVMbt55ouGGu20=;
        b=pkwqT0p9reHxG5NNziBFKHep3mzeSWMdQjuLqBj3Z93BDYrG5PosjiWli6sI0OaXfG
         Ruht+6uwaL0YFUH5vEQs8gnKIMMGItsxgRm3AY9zADh/Vi7ONTCV48SFMAZ3YM23zvIO
         k/0cAJFtISgK+BGOQtCry2XPRJ74hFrpPs2bJO7QmBuX3FqWsLDZuFlx+XfKg+7H9CMg
         YP5TcMBV/rFakXL44rQHE8BF+kmiFo6otU13ZD6pSyxmb7mZrnv5F12HXLi9f8xBx5xP
         BgygRgSROnAqmch1bfNwfIIgUOmK25Oek6z6aMy7E+WsTUM1YZkSOW3q9rctT8Teh9i+
         YVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTqxGKRaQ+4R4vGFv2ndzSh2OvA6/IVMbt55ouGGu20=;
        b=cuoQjw9BXz8WIIWz0Gcl1Y/chmORHi1eblF3Pr7xBbSaKUdMNZ2vcOvTfsEt1IPpHp
         Q99q7Kj20DREV9g/OodmvvElrGjRj+QnI/F+kjP4P4hLMEI2QIJYCZw8zQ0fZo6on7h1
         Xg3LCTAZdkaGIkmb02pQZNRZ2BXy1d5n5Ky8+uOVSMiYbpwT6mFtXFyePjWdTi5KRIg2
         K64DwLp11uo8I3AraL68K6/CbhICJvrz1AlsUQLI7obGIaeiGRB0i1pyc9R4cApxziyM
         wTpuaaEIidu4CJB5EEhj9k0LUYkY2pvPoCeZTCiWPK9CgZw3nkYlIBgzIg7d9BO4igM6
         5MRg==
X-Gm-Message-State: AJIora8IIAQr7QkRFP/cxX9qMAaw9btnPqDUsF+R7zQFF9GKVyjQhynY
        xYyMJJvHYeA6uWi5iHGYn6k=
X-Google-Smtp-Source: AGRyM1vsV7oT7VKKqx70BYd9loPyNBlyHXC2igMEcGuYerOS2SXyzGyFprw2BKPwaynm0IdBgUt1/g==
X-Received: by 2002:a50:fd93:0:b0:43a:71e2:781e with SMTP id o19-20020a50fd93000000b0043a71e2781emr30883012edt.396.1657620456614;
        Tue, 12 Jul 2022 03:07:36 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id bd27-20020a056402207b00b0043a21e3b4a5sm5799675edb.40.2022.07.12.03.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:07:36 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/4] dt-bindings: mailbox: qcom: set correct #clock-cells
Date:   Tue, 12 Jul 2022 12:07:30 +0200
Message-Id: <20220712100733.34261-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

