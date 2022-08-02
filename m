Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A5E5883E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiHBWLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbiHBWLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:11:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D8127B21;
        Tue,  2 Aug 2022 15:11:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gb36so2726878ejc.10;
        Tue, 02 Aug 2022 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3Y1u+L6GDe7/vxWVB8jSSZZAPQ4qzN5M9/i+BDgCEew=;
        b=Aex55Oe65js2Kp1HNdEdImAHzJwKiCba0qCDzExUC5sNT0r3vXCmy8HMTpE/CJI9L/
         X/APIVbhyXNR27TBYhR16ZaT1NG+3PCyufSRk2FFiBbKvSrkbLSre4r5C2HMpZmswkFJ
         fjVepBhnP1UamD3v5YsjUbHQZwTB/Nr4dskEsz3wi3R31YMSAJwRQ9BCDeTVNlVYae8D
         7JDf+ZKqQzgAUpkQai9IjFXlUuBci7lvxMJlksPFAz5VFWhdYVSpSCEKZg3aarj5SOWL
         70Y7Uq3DPUmOG8OVZfmyJqXc04ECyh1kfndhmp/WRbh8jbKBNor1pCKYz5Xistkh3Cz9
         nPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3Y1u+L6GDe7/vxWVB8jSSZZAPQ4qzN5M9/i+BDgCEew=;
        b=sJamPJVjNWet1B2AydTBAfrnkfMsuMKlLgq1ZID9Xb4Mlrgw0hnqLBGd2G8oV1S7qX
         EaSo1MFGYjfKlZM5oglOqVVQauFKOuSE5ueyQlE+1QmXD9x2LBY2sRvpmqDGZhQfeUcW
         Fwni1qpCXB+uZ+5iM2NymBrTYf5SEl9kKdFoIPPq/Trv1vHdokXTWg3ej7pnxeldT/xk
         qJ37BvCt4zze+kTwetbogBRZpeYhD+3F5JNDXjGL3Cb6Dx9ZQu5tZOY0XuyBu5k3NGX5
         IjP32glUvqL3h9f1ffC3sr1/fuSQdKzVEColzf4Rc6pz2ifPYE1pcsEwlex+Ox6fGJD+
         E6jw==
X-Gm-Message-State: ACgBeo076YWGZlonXGiTSSMPSIRlDI3KWQoz3upROC5fB7hwcQjXKGCd
        gsuRt8jnOwrvLX0ucktM/e4=
X-Google-Smtp-Source: AA6agR6BxPXbjzpR6Tg4RPsqbRCYZQS8slUEAne+6lLngk6tH34gWY5ydkmV/io+7NTcGPYibxhOSQ==
X-Received: by 2002:a17:907:97d2:b0:730:657f:bef5 with SMTP id js18-20020a17090797d200b00730657fbef5mr11930218ejc.757.1659478292204;
        Tue, 02 Aug 2022 15:11:32 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id ia17-20020a170907a07100b007307d099ed7sm2927058ejc.121.2022.08.02.15.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:31 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 01/13] dt-bindings: regulator: qcom_spmi: Improve formatting of if-then blocks
Date:   Wed,  3 Aug 2022 01:11:00 +0300
Message-Id: <20220802221112.2280686-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802221112.2280686-1-iskren.chernev@gmail.com>
References: <20220802221112.2280686-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a newline between if-then blocks for different compatible PMICs.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/regulator/qcom,spmi-regulator.yaml      | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
index 8b7c4af4b551..da644c161e99 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
@@ -121,6 +121,7 @@ allOf:
         vdd_l8_l9_l10_l11_l12_l13_l14-supply: true
       patternProperties:
         "^vdd_s[1-6]-supply$": true
+
   - if:
       properties:
         compatible:
@@ -135,6 +136,7 @@ allOf:
         vdd_l4_l6-supply: true
       patternProperties:
         "^vdd_s[1-5]-supply$": true
+
   - if:
       properties:
         compatible:
@@ -144,6 +146,7 @@ allOf:
     then:
       patternProperties:
         "^vdd_s[25]-supply$": true
+
   - if:
       properties:
         compatible:
@@ -153,6 +156,7 @@ allOf:
     then:
       patternProperties:
         "^vdd_s[1-4]-supply$": true
+
   - if:
       properties:
         compatible:
@@ -172,6 +176,7 @@ allOf:
         vdd_lvs1-supply: true
       patternProperties:
         "^vdd_s[1-5]-supply$": true
+
   - if:
       properties:
         compatible:
@@ -181,6 +186,7 @@ allOf:
     then:
       patternProperties:
         "^vdd_s[1-8]-supply$": true
+
   - if:
       properties:
         compatible:
@@ -196,6 +202,7 @@ allOf:
       patternProperties:
         "^vdd_l[27]-supply$": true
         "^vdd_s[1-4]-supply$": true
+
   - if:
       properties:
         compatible:
@@ -224,6 +231,7 @@ allOf:
         vin_5vs-supply: true
       patternProperties:
         "^vdd_s[1-3]-supply$": true
+
   - if:
       properties:
         compatible:
@@ -242,6 +250,7 @@ allOf:
         vdd_l9_l10_l13_l14_l15_l18-supply: true
       patternProperties:
         "^vdd_s[1-6]-supply$": true
+
   - if:
       properties:
         compatible:
@@ -266,6 +275,7 @@ allOf:
         vdd_lvs_1_2-supply: true
       patternProperties:
         "^vdd_s[1-9][0-2]?-supply$": true
+
   - if:
       properties:
         compatible:
@@ -277,6 +287,7 @@ allOf:
         vdd_l1-supply: true
       patternProperties:
         "^vdd_s[1-3]-supply$": true
+
   - if:
       properties:
         compatible:
@@ -292,6 +303,7 @@ allOf:
       patternProperties:
         "^vdd_l[479]-supply$": true
         "^vdd_s[1-5]-supply$": true
+
   - if:
       properties:
         compatible:
-- 
2.37.1

