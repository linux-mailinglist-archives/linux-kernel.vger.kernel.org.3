Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CE95861B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbiGaWhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238565AbiGaWht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:37:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9E311156;
        Sun, 31 Jul 2022 15:37:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z18so11665215edb.10;
        Sun, 31 Jul 2022 15:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DbL1oaZ8UbGV0lR6AyRij8BG6+B7LTgylNp4/i3e5iw=;
        b=LMW2Km57eocuHu/nx6TTCN0PikeCcIrGYjv14NCZZjDCl//GdXNQn4mJ6kHZMdT4qE
         ms4aOcCai9/MAgNJj47ZNQq5G8fJggv8cL73dmdOI1pXI+O2yVGsRZ2Un1Sugz89FanZ
         CIk7dYTvVbHqhj9fdgbL1fflx3ZLUb9lrJrG3VM2NKQjxgEhMNAVHGdcn7hcxrA1ur9t
         nY9XXiNFhM5u1dwX129KoRusxIio1YH2C+tDMK0Vq0GrUsnFY2O/AAA7ZLYFtp9s7Y96
         Vq5BC1P6muotbe3jjrRTJtXwUsfMqbDvjEGHwWMkjKakVInYcBru364SAoObDW8BhTwi
         5Cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DbL1oaZ8UbGV0lR6AyRij8BG6+B7LTgylNp4/i3e5iw=;
        b=HuPwzezsCheIqh5qYmiXqYDMTbBXI/mejNCNywxevStBVaktzpB+yXicZ4uUI0A/ea
         9b6wvRiuaDYu9jVoXqs75MBv8tSlVRpwyljOywl7+Rg9Fs7wuqzz+O7SELi1frwwoGuo
         CDn3TISSxPy6Q9lsaF9q9mcNqB8x7OroR0LHbMZ8Sg/QTRkYT11lQTeCfVgmQvJbOYK5
         6HTyOlXnoZ3T4yDXx8hw78d4pP9x9nVthd6KvkyQKC1rjDAqaXh8ALMZCf2lM9b+h/8t
         3Rs1mTNk9iUShEoA1t7/5mVUWF3XBVpHv2AL5cLNNfyA4xDWbe31d6rEsvQs+fjfFV9V
         5vxA==
X-Gm-Message-State: AJIora/nABl6FcmCk0IvrGsl6Hkrt84DHlCJQ2qmr/s1LWyl8JKelJlZ
        7imLLutwkzdVCJrvLiwuNYA=
X-Google-Smtp-Source: AGRyM1t/ePm/76MIVmB2ASdih8TGTLJRMRd6klf29xRqae5SE4cgg0PXG36bUcPSUtQZnUtNzdY5hg==
X-Received: by 2002:a50:fc89:0:b0:43c:bf1e:165d with SMTP id f9-20020a50fc89000000b0043cbf1e165dmr12745320edq.161.1659307066422;
        Sun, 31 Jul 2022 15:37:46 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id r2-20020a17090609c200b0073043ff06dfsm2516045eje.163.2022.07.31.15.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 15:37:45 -0700 (PDT)
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
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 01/13] dt-bindings: regulator: qcom_spmi: Improve formatting of if-then blocks
Date:   Mon,  1 Aug 2022 01:37:24 +0300
Message-Id: <20220731223736.1036286-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220731223736.1036286-1-iskren.chernev@gmail.com>
References: <20220731223736.1036286-1-iskren.chernev@gmail.com>
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

