Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EC85861BD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbiGaWhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238579AbiGaWhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:37:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA38C1115F;
        Sun, 31 Jul 2022 15:37:49 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f22so692659edc.7;
        Sun, 31 Jul 2022 15:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0qLv0cy1W9Ap062G5ssbiJilt2Dw2rzrYlHVXVTiiTk=;
        b=HmYIo7Vg3YHc5+eV5MEmGLf90TbKuGsCMOcxPrubmtVazzCuVIwNV8CbK3pPfdbvJV
         s7P5yGwOt9IZ3BVHT+f4UN3nGeXuln+7N01+xbwpC31DPI8huaTE7dh7P1/50R+osfOr
         wP+id8kIUR6CmOYJMNGs4dsxqwYwTr5ml003F5daIdCn+WYMc4aICn9bGUrQdT3zLqLo
         Y2IC2PgpbPFYpMIrKC87QHomAYNgxxYmwm8Byk3S+zQQwhGxLHR0r4eL0V7mKDKoTM12
         ENwOjUSlxeKBnkNQf/2wx62NuWysa/oiGxhRirwygokQHXug1Gpig7zDkUoKswrr5+CV
         MCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0qLv0cy1W9Ap062G5ssbiJilt2Dw2rzrYlHVXVTiiTk=;
        b=TgSMsbN7kOY+Rf5IvaG3FYOi0XbgpU8a78lR9Y8mUSOk8xoQ9kpG4rReA7SFT10lte
         8ZIIM96HIWE23da93VVbIGQd9dw19WKFPltPZpEQblnZ83PcrjlcIB6iiQ1wRNNLKRUx
         md+PwsfgEDmpBeWR+8bjdFY0/jp3NMF3Gvx3t9a1M8n7lpbNIRgLWVZhPVaRyr1v737e
         Snh3YC/+n9WAYQAd6QGpAf5aKE2Tu0n2Ur3ju14e10t7llG7nP5KfEk9UxlMTqOq0gBt
         cmSXryywvyVoV+fFXrPQ0uXk+ttvNREP1tFFnYH1aVFxGSUcGPkk66vDK+WXNwoA/plJ
         W4CQ==
X-Gm-Message-State: AJIora/vc/00tkUGLwb1j7A7LjRFy6Z2SVu/s+hYDfq95fKirt4wAfLt
        Dj9JVlNKXl+kNqEYlEaeUZ9msa4BS/XyHkUn
X-Google-Smtp-Source: AGRyM1vjbuQCOlGWXoF2jpLNdHtdiljKKFpXzw4ljamz++izEEbdgqaAMw3rE7mVHEi1iE4yUtOAJQ==
X-Received: by 2002:a05:6402:e93:b0:43b:6a49:7e88 with SMTP id h19-20020a0564020e9300b0043b6a497e88mr13443574eda.132.1659307068587;
        Sun, 31 Jul 2022 15:37:48 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id e15-20020a50fb8f000000b0043a6df72c11sm5770977edq.63.2022.07.31.15.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 15:37:48 -0700 (PDT)
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
        Adam Skladowski <a39.skl@gmail.com>
Subject: [PATCH v3 02/13] dt-bindings: regulator: qcom_spmi: Document PM6125 PMIC
Date:   Mon,  1 Aug 2022 01:37:25 +0300
Message-Id: <20220731223736.1036286-3-iskren.chernev@gmail.com>
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

Add support for pm6125 compatible string and add relevant supplies in QCom
SPMI regulator documentation.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 .../regulator/qcom,spmi-regulator.yaml        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
index da644c161e99..24108d0e4c4e 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
@@ -12,6 +12,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - qcom,pm6125-regulators
       - qcom,pm660-regulators
       - qcom,pm660l-regulators
       - qcom,pm8004-regulators
@@ -106,6 +107,25 @@ required:
   - compatible
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm6125-regulators
+    then:
+      properties:
+        vdd_l1_l7_l17_l18-supply: true
+        vdd_l2_l3_l4-supply: true
+        vdd_l5_l15_l19_l20_l21_l22-supply: true
+        vdd_l6_l8-supply: true
+        vdd_l9_l11-supply: true
+        vdd_l10_l13_l14-supply: true
+        vdd_l12_l16-supply: true
+        vdd_l23_l24-supply: true
+      patternProperties:
+        "^vdd_s[1-8]-supply$": true
+
   - if:
       properties:
         compatible:
-- 
2.37.1

