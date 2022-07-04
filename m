Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6F9565EFD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiGDVYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiGDVYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:24:13 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E441210FEB;
        Mon,  4 Jul 2022 14:24:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id g26so18535172ejb.5;
        Mon, 04 Jul 2022 14:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t/BG5vD2Kpre80JUee6H++Vy9Vk4uNgKEic0vq+tFnI=;
        b=UNW9KqwNzjksDAvjfdnrtc14uOmbwuh+Am2xG3GPA8KJYNPPB+SBsQZWA5H1b+U3gK
         7xa8C+31YCf21Ao6Ks11X2AJvx1xLz1vVkfpy3TlFr6l+O1jVwnqJ51K1d6pHhWg6bHx
         a6vsOXedsgzeNEJ/PFliIJgM1k5pOk2x5+GLvbVAFrAU/FhegnS3fP2w5VKPpUX7qeS5
         aAPJsTQLuhWgerDrZuY3HoKJc252HxtYrdhI/5q6Xoihbg98hN5P/hDHPDdKbMx7vY6i
         B+rYPM+DkB+0z15JnNqDNmVk32bO4gjcL+1UQ+5EXp6R3oKyze2U7TZIZFa+YKQt2q/s
         Bxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t/BG5vD2Kpre80JUee6H++Vy9Vk4uNgKEic0vq+tFnI=;
        b=08x1BBERpUfHhWo799R4tDnatzqXT54XRQZ5HxqlCDnsvTRgj7q6KuLu36B9V2DGrg
         CEeCWvzU1sV0xOLQxyvVjmbr3j1flABwwb2o430Icy/s6KyeF5ATnB3tWjcn+5Z0yUby
         OIgBBWoU1BdDXECLBm+gpvf+vaXZA2jDZHnd8YlWTGWsx/sxIcpJ1f07x7Q5H34RhhVV
         ywPfkDwSLYyZWBsgwvFyO9rHsLG52rpxxCf/8rdwiL35pAYkP+7oLY1mqNb5Qg4RxHzW
         BsR7pXvbfV4uDwErOpsm/tdRGgQ7ppTtJ7wew15X+QPNjiAM4wfFHgo0qnSfiajXFxt1
         EYpA==
X-Gm-Message-State: AJIora93/dOXJzPcfcz+Fx5MGOdtw59CpozmxDVpSQ+UWODzGB+oz+HR
        UD5+0x4wYJMzyI7TxD1sPYo=
X-Google-Smtp-Source: AGRyM1sCRfzWqQ+ofHuJmszZhv+vMuETuyMMUkgtqf/VGab9V12EsouF0SIFzrocMGAo26mXr5EHEQ==
X-Received: by 2002:a17:907:763a:b0:72a:5128:b34f with SMTP id jy26-20020a170907763a00b0072a5128b34fmr26180805ejc.372.1656969851534;
        Mon, 04 Jul 2022 14:24:11 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id k18-20020a056402049200b0042dcbc3f302sm20131117edv.36.2022.07.04.14.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 14:24:11 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jic23@kernel.org, lars@metafoo.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 06/12] dt-bindings: regulator: qcom,spmi-regulator: add PMP8074 PMIC
Date:   Mon,  4 Jul 2022 23:23:56 +0200
Message-Id: <20220704212402.1715182-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704212402.1715182-1-robimarko@gmail.com>
References: <20220704212402.1715182-1-robimarko@gmail.com>
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

Document the PMP8074 PMIC compatible.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
* Add remaining supplies

Changes in v3:
* Add supply matching
---
 .../bindings/regulator/qcom,spmi-regulator.yaml  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
index 06dc99b942e5..8b7c4af4b551 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
@@ -23,6 +23,7 @@ properties:
       - qcom,pm8950-regulators
       - qcom,pm8994-regulators
       - qcom,pmi8994-regulators
+      - qcom,pmp8074-regulators
       - qcom,pms405-regulators
 
   qcom,saw-reg:
@@ -276,6 +277,21 @@ allOf:
         vdd_l1-supply: true
       patternProperties:
         "^vdd_s[1-3]-supply$": true
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pmp8074-regulators
+    then:
+      properties:
+        vdd_l10_l11_l12_l13-supply: true
+        vdd_l1_l2-supply: true
+        vdd_l3_l8-supply: true
+        vdd_l5_l6_l15-supply: true
+      patternProperties:
+        "^vdd_l[479]-supply$": true
+        "^vdd_s[1-5]-supply$": true
   - if:
       properties:
         compatible:
-- 
2.36.1

