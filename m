Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40095883F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiHBWL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiHBWLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:11:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2990339B96;
        Tue,  2 Aug 2022 15:11:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id tl27so10445175ejc.1;
        Tue, 02 Aug 2022 15:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lYDOfJllHJUoNnBsvIq7J6znJT06Hkpj2bFt2tNhaMU=;
        b=hHTs/zZt5+dVuhfSMPVWAX/q16D0enV5XKD3jpGTWGWFpZJjsiRVSl+T035ZylgP0j
         RcKVq+XXqKMBxWgWuxO0T6TyNBGMLEqJebZFwxLLVxz18i+InFGLqkqoS40++qjXsCi9
         6fN916ByKa1Mhv8dZudmfs65fSN/S0ZMfSvxjNf/81E66nkxsAZrQp96gM5KSeLWXbdb
         TGvjqhq26VZgGs3SgZCvWn8bL4s1Kk99NvXKw93bKZNEtltYeU5+MGHFQ+yhWcIRkduU
         FxqPN0Xs008E76iNObWhCbOFdDLKyJ7URQt7xYj2duwAxpnpUoWXjUduXKjFiqlEG3uq
         L2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lYDOfJllHJUoNnBsvIq7J6znJT06Hkpj2bFt2tNhaMU=;
        b=iBeQB0lRTCH1uX1nI2j/efT1F6yFbFpaX2/XfdVUSmCzTklr313Vo9SuLizjj9iWp7
         hNsQKkDevKXkb47hrUtMvkPHUljtoot4xnvU5zyNlmRi2yzWSmBjLeDbyUAyqI80k3Ex
         pH03PdDP0mY8w5hS7Hiw9uir5+J2Lc3lHoTRAssyfXZawp23chn9YVD2P7FJUDVTrwxC
         4i2uQiYuPEfGwkjrWADWaAh+/lzPq6+nQKLRkcfvbarg/goCeBJHm1EXH+4vEA3tGkol
         0lolWIKq2jejpwE0mrYUiTTvTsXIZ/0ufVCgnJ71L1OPeEdRiXE7cV7uaOxGVw2jnDs4
         Ru4g==
X-Gm-Message-State: AJIora/YXacT+1R8xLkjjizJt3mw/2ZvUOnVsXbUcH+fm51O+cPSXM1S
        Ha/rmQnY1REWQ+HMdahPoH7R27M2xyFLlJ+H
X-Google-Smtp-Source: AGRyM1uhUT73uWyPk/EGUoeCJecWdzkDb+GpPc8pF5wJIm6ntsG0nvq4NHtzX9nnnzVqzHGbCrPPmA==
X-Received: by 2002:a17:907:7b95:b0:72f:9c64:4061 with SMTP id ne21-20020a1709077b9500b0072f9c644061mr18178688ejc.351.1659478296652;
        Tue, 02 Aug 2022 15:11:36 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id qc19-20020a170906d8b300b007305d408b3dsm3869524ejb.78.2022.08.02.15.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 15:11:36 -0700 (PDT)
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
Subject: [PATCH v4 03/13] dt-bindings: regulator: qcom_smd: Sort compatibles alphabetically
Date:   Wed,  3 Aug 2022 01:11:02 +0300
Message-Id: <20220802221112.2280686-4-iskren.chernev@gmail.com>
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

As requested by Krzysztof Kozlowski.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../regulator/qcom,smd-rpm-regulator.yaml     | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
index c233461cc980..39802c1223c6 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
@@ -24,6 +24,14 @@ description:
 
   For mp5496, s2
 
+  For pm2250, s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
+  l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22
+
+  For pm660, s1, s2, s3, s4, s5, s6, l1, l2, l3, l5, l6, l7, l8, l9, l10, l22,
+  l12, l13, l14, l15, l16, l17, l18, l19
+
+  For pm660l s1, s2, s3, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, bob
+
   For pm8226, s1, s2, s3, s4, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10,
   l11, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, l25,
   l26, l27, l28, lvs1
@@ -52,11 +60,6 @@ description:
   l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19,
   l20, l21, l22, l23, l24, l25, l26, l27, l28, lvs1, lvs2
 
-  For pm660, s1, s2, s3, s4, s5, s6, l1, l2, l3, l5, l6, l7, l8, l9, l10, l22,
-  l12, l13, l14, l15, l16, l17, l18, l19
-
-  For pm660l s1, s2, s3, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, bob
-
   For pma8084, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, l1, l2, l3,
   l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19,
   l20, l21, l22, l23, l24, l25, l26, l27, lvs1, lvs2, lvs3, lvs4, 5vs1
@@ -68,9 +71,6 @@ description:
   For pms405, s1, s2, s3, s4, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
   l12, l13
 
-  For pm2250, s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
-  l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22
-
 maintainers:
   - Andy Gross <agross@kernel.org>
   - Bjorn Andersson <bjorn.andersson@linaro.org>
@@ -79,6 +79,9 @@ properties:
   compatible:
     enum:
       - qcom,rpm-mp5496-regulators
+      - qcom,rpm-pm2250-regulators
+      - qcom,rpm-pm660-regulators
+      - qcom,rpm-pm660l-regulators
       - qcom,rpm-pm8226-regulators
       - qcom,rpm-pm8841-regulators
       - qcom,rpm-pm8909-regulators
@@ -88,13 +91,10 @@ properties:
       - qcom,rpm-pm8953-regulators
       - qcom,rpm-pm8994-regulators
       - qcom,rpm-pm8998-regulators
-      - qcom,rpm-pm660-regulators
-      - qcom,rpm-pm660l-regulators
       - qcom,rpm-pma8084-regulators
       - qcom,rpm-pmi8994-regulators
       - qcom,rpm-pmi8998-regulators
       - qcom,rpm-pms405-regulators
-      - qcom,rpm-pm2250-regulators
 
 patternProperties:
   ".*-supply$":
-- 
2.37.1

