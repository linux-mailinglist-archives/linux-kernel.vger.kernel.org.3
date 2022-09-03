Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309565AC053
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiICRnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbiICRmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:42:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD07C58DD9;
        Sat,  3 Sep 2022 10:42:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qh18so9505308ejb.7;
        Sat, 03 Sep 2022 10:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6uq5cQ9KVfg3HDUbnIhY2Bo8RTmJZ/5rDl5ZHG3HNZs=;
        b=Bs8aQTbFEJWFO3jn2TIdWHELQWYmLaFsndh/f1y3iMxdRbAf1lbXyzFVaHdK7fA3Ea
         gg6XxRaw9NTVSFBNkBzAuqkfVCBKJjPjLpjMgCjSK6mLTdSHJ5KZ+h25+bJdb9Z/PXNl
         1LNki6l9lvJ26EuisTgvq41IZEQN7YG+j71Z9ie6W0VA/kX5M+xzOqQlaLC9rl1UnY99
         u0wu4qVumq0Hr6ae6Z0UgOXFKHP0nKLr7sL5Al29V3t71EXPx/Scmi8x9U0KVdmO6m1Q
         W7fOTQ8K5fAe0wlBMnvstWpdgjK/hdgBuc51WbytaE16nykQ0O7oIc7mDvw/JP9Z7GYw
         zBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6uq5cQ9KVfg3HDUbnIhY2Bo8RTmJZ/5rDl5ZHG3HNZs=;
        b=ophtpAyEMJtrR624HBW3k1zxAN+/vnjS8geFUVHkC/8HZOZ3Sssb8T6CYQPYrIWpq4
         2SGJ7URpghnhrm+w0W4ejVhkMICF7jSeC4XJtcq6WKTtIL/DjXYTS2kIZfesFZPDgCr+
         8sACoLXLq7+Np0htC0nEzFc4Le3pxnHO5uOj8SrQqNI3GgW7mKBgPAEICTY8fIXH1pnR
         PLWOv1+3TxQUO+CQnx3f8G5ynjgRFEoieOHZcupUbcz++BUAM6R6hJM9Bb8L/cOqYhlR
         7uFcmkQDhBynWYQSHqiDs5eNknReb5CrSAn4e+Pok04BmhKCpgSoVBrA2rhAKgCT+zTv
         BokA==
X-Gm-Message-State: ACgBeo0VHKSgFVcYt8g6TMYVnjPMW5wjRLoZu2v8faEqWinj/8jSAc+s
        nnQJ/LZG/D+ynUZ0nye8sxs=
X-Google-Smtp-Source: AA6agR6SDJy0EOBbhTRUl47m86R28C2FgIqrmKWXSYZd7akQwenjoWfY+8xZ37pS7lDtAdkCe6Ff6Q==
X-Received: by 2002:a17:906:9b89:b0:73d:6a55:c489 with SMTP id dd9-20020a1709069b8900b0073d6a55c489mr31335827ejc.406.1662226957543;
        Sat, 03 Sep 2022 10:42:37 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id c4-20020aa7c744000000b0044df7fd6250sm540402eds.3.2022.09.03.10.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 10:42:37 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] dt-bindings: arm: qcom: Add compatible for oneplus,billie2 phone
Date:   Sat,  3 Sep 2022 20:41:47 +0300
Message-Id: <20220903174150.3566935-7-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220903174150.3566935-1-iskren.chernev@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
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

oneplus,billie2 (OnePlus Nord N100) is based on QualComm Snapdragon
SM4250 SoC.

Add support for the same in dt-bindings.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 19c2f4314741..63cc41cd0119 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -54,6 +54,8 @@ description: |
         sdm845
         sdx55
         sdx65
+        sm4250
+        sm6115
         sm6125
         sm6350
         sm7225
@@ -670,6 +672,11 @@ properties:
               - xiaomi,polaris
           - const: qcom,sdm845
 
+      - items:
+          - enum:
+              - oneplus,billie2
+          - const: qcom,sm4250
+
       - items:
           - enum:
               - sony,pdx201
-- 
2.37.2

