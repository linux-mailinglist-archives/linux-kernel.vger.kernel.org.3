Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CD551E99B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446924AbiEGTxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245713AbiEGTxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:53:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6390A17079
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 12:49:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so6201039wmn.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 12:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UG9+cIig2tf9rl736/AVv78nJje23FHX5KBYsT/BjQA=;
        b=EMbGODijqIlISgN1pdNil9wjlUNJjOspKbP6duPQiKQvHoqy1zqqVDZxlp+k9oX1Wf
         8e6nOWSdQNIHRktRwFOzbyck52pPnrFaOacopd/neEE8iZVoixi+VtFeKt+/znRJnl2j
         1QdadhiUoUAWE9/IWpvWefhnvYIneeWsWUFPaGahBCrDQsrHGJ7uC82/x9WwnPGZRtKO
         7sILMAXYyFyuXfNN2JuyEfYgLMHR3Bff25u+GjUmbfT3I61mGtTEgNHYNzMweCFjka6a
         ZD3oC069Md4bOJavsL8qcSbStgtIv38Gqf/ry4Bc4a2osRqXEh7th8bnDXVs4h7HRqQ7
         rulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UG9+cIig2tf9rl736/AVv78nJje23FHX5KBYsT/BjQA=;
        b=vFyJg7qBLEOZlZVE6sDNV2nEbGh/fEQt9Gu0VHi01HdE4pQA2rx95NvBI45Wsf6JSk
         BRWTm5hv6iqcOTI9x7o+Cdm5/ktTi6rT1xFv1qOL5N88mKoWelIZw8nYdoGd/WDkICGg
         hM9GwVgek0UKEa/kVAhy/jK9ZqDPHnh4oU9qbnS9nlmWW3a+FJkyIyHfF4EjeGq4v17M
         +5CBiOhLIJY1zms/WPKo2FIqM5vFN+T4RgOsIrMB6pI3ZE6vSO7ocfEwdNao3Ux4EWkD
         Vh1dUoCE+Vv/mubPguM2CsoncPEmlB0H7omZN/fgbodnHRC2jFZD1VwnybMHottamWpj
         ZGYQ==
X-Gm-Message-State: AOAM531R1NuhuPSz+u/KLuds/udwpE9K/Pa3R+yveEVNMu/ttWWo6W0Z
        dtiPt3z7qySVW6/Ao1LPFQyMrw==
X-Google-Smtp-Source: ABdhPJwuMW64Rcvj5fMdYDpnbLoGwSodlAvje7aQa+DJrIzbCs/DKPagFoz3Lj6faPBuIXVQpeIFeg==
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id n16-20020a7bc5d0000000b00389fe853d79mr16043414wmk.77.1651952960901;
        Sat, 07 May 2022 12:49:20 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c1c0600b003942a244ec4sm8535027wms.9.2022.05.07.12.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 12:49:20 -0700 (PDT)
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
Subject: [PATCH 01/11] dt-bindings: pinctrl: qcom,pmic-gpio: document PM8150L and PMM8155AU
Date:   Sat,  7 May 2022 21:49:03 +0200
Message-Id: <20220507194913.261121-2-krzysztof.kozlowski@linaro.org>
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

Add missing compatibles for devices: PM8150L and PMM8155AU.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 22dbcba752d0..23d6b9165e20 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,pm8058-gpio
           - qcom,pm8150-gpio
           - qcom,pm8150b-gpio
+          - qcom,pm8150l-gpio
           - qcom,pm8226-gpio
           - qcom,pm8350-gpio
           - qcom,pm8350b-gpio
@@ -49,6 +50,7 @@ properties:
           - qcom,pmi8994-gpio
           - qcom,pmi8998-gpio
           - qcom,pmk8350-gpio
+          - qcom,pmm8155au-gpio
           - qcom,pmr735a-gpio
           - qcom,pmr735b-gpio
           - qcom,pms405-gpio
@@ -135,6 +137,7 @@ $defs:
                  - gpio1-gpio2 for pmi8950
                  - gpio1-gpio10 for pmi8994
                  - gpio1-gpio4 for pmk8350
+                 - gpio1-gpio10 for pmm8155au
                  - gpio1-gpio4 for pmr735a
                  - gpio1-gpio4 for pmr735b
                  - gpio1-gpio12 for pms405 (holes on gpio1, gpio9
-- 
2.32.0

