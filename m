Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721CE51EDF3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 16:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiEHODp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 10:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiEHODd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 10:03:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CA8DFAD
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 06:59:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id be20so13488318edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 06:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTeko8++isKWaAsrc9bIuD47MDDjc5x398JdEtZdw0I=;
        b=hky9VqldxaHt0CS0zRoWOAcbDfYcX0FQ/h4oRjx7Qc0sCLul8KlhQ4i7vPFGdPWQQc
         Gm4cXNvyX5cLWDA2MnRSQz+yKQ6r/pn51fqXaCU7x6cC3fprRhbpfVPiasF8GEESikfY
         ApdIXOvHDmOOqRUo4hWHpysnpTNSoJBjHsr2FZvmeQxOa9ebMN7QtWan9hMyUDYX7tpL
         oKsStNyY08NLDgKDBPqcZ3TZQuH7s2X+m22azL7+Xy9i590wrHu6oP6GSZpD8bvbVAZ+
         wvb/q8eGTsOKT6xyIeTvPGKdPISat+naA66zkv1eEN2xDqJEdtiys2rfe+xvqpzJTn57
         h5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTeko8++isKWaAsrc9bIuD47MDDjc5x398JdEtZdw0I=;
        b=bSuE9qYuhhl+NZltXPs+7KKD3S8toFNOtLZkIilQDhqXipXIXwDjDuC32/v9xvdpuW
         kESUp84v+DxO5NUM3RJqEDw0T9fVs+dsUZcSz3YFKwbmL0xbCo9CHVMC+PZZC7MPq9ex
         sK/JdRkOyLPMoyfX9cjoHp2rm7AE2Fwcy6aKtQnzppGK/SlcbpGT33IF8vyaZIC5VtKw
         Tr7c3Mt4L4TLiFOwK72nWuA9V/CiWKcv5Js6eN9oS+mjCPf3hE07RnJqnRCmyGocv5/N
         jLvm0yTGoEQEGGjfsk0tHx2KtFyVP2TRCLPa7zX366BkWGl0bc3dJz37bvAqYcvXcIPt
         6Z9Q==
X-Gm-Message-State: AOAM532o+YoYUqCv7S3aIRQiDsbtJ2cefXDZpYPtTa6r+LI9G73SiZom
        c4ZlB+S3hFtvyHMePMzSV82+Yw==
X-Google-Smtp-Source: ABdhPJxiUdFCg1+cI0tOzgUACD6XAK5G2X1xqKZwUBb0UkrSyiCMmMSF9O0vs7nbLAEIznyrHPuEag==
X-Received: by 2002:a05:6402:26ca:b0:427:c181:b0ed with SMTP id x10-20020a05640226ca00b00427c181b0edmr13045607edd.400.1652018381468;
        Sun, 08 May 2022 06:59:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id qz24-20020a170907681800b006f3ef214dc6sm4075524ejc.44.2022.05.08.06.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 06:59:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Luca Weiss <luca@z3ntu.xyz>, David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] arm64: dts: qcom: add missing gpio-ranges in PMIC GPIOs
Date:   Sun,  8 May 2022 15:59:30 +0200
Message-Id: <20220508135932.132378-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220508135932.132378-1-krzysztof.kozlowski@linaro.org>
References: <20220508135932.132378-1-krzysztof.kozlowski@linaro.org>
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

The new Qualcomm PMIC GPIO bindings require gpio-ranges property:

  sm8250-sony-xperia-edo-pdx203.dtb: gpio@c000: 'gpio-ranges' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm6350.dtsi  | 1 +
 arch/arm64/boot/dts/qcom/pm8009.dtsi  | 1 +
 arch/arm64/boot/dts/qcom/pm8150.dtsi  | 1 +
 arch/arm64/boot/dts/qcom/pm8150b.dtsi | 1 +
 arch/arm64/boot/dts/qcom/pm8150l.dtsi | 1 +
 arch/arm64/boot/dts/qcom/pm8350.dtsi  | 1 +
 arch/arm64/boot/dts/qcom/pm8350b.dtsi | 1 +
 arch/arm64/boot/dts/qcom/pm8916.dtsi  | 1 +
 arch/arm64/boot/dts/qcom/pmr735b.dtsi | 1 +
 arch/arm64/boot/dts/qcom/pms405.dtsi  | 1 +
 10 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6350.dtsi b/arch/arm64/boot/dts/qcom/pm6350.dtsi
index f3056845e65f..ecf9b9919182 100644
--- a/arch/arm64/boot/dts/qcom/pm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6350.dtsi
@@ -39,6 +39,7 @@ pm6350_gpios: gpios@c000 {
 			compatible = "qcom,pm6350-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
+			gpio-ranges = <&pm6350_gpios 0 0 9>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm8009.dtsi b/arch/arm64/boot/dts/qcom/pm8009.dtsi
index d451922d2b95..0c2c424be0ea 100644
--- a/arch/arm64/boot/dts/qcom/pm8009.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8009.dtsi
@@ -22,6 +22,7 @@ pm8009_gpios: gpio@c000 {
 			compatible = "qcom,pm8005-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
+			gpio-ranges = <&pm8009_gpios 0 0 4>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index 72cd93ced4c5..fd8434215924 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -130,6 +130,7 @@ pm8150_gpios: gpio@c000 {
 			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
+			gpio-ranges = <&pm8150_gpios 0 0 10>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 28162f6fb61d..d0d8890f087c 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -115,6 +115,7 @@ pm8150b_gpios: gpio@c000 {
 			compatible = "qcom,pm8150b-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
+			gpio-ranges = <&pm8150b_gpios 0 0 12>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index 0642e7d5be35..2b273c219fd8 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -103,6 +103,7 @@ pm8150l_gpios: gpio@c000 {
 			compatible = "qcom,pm8150l-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
+			gpio-ranges = <&pm8150l_gpios 0 0 12>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm8350.dtsi b/arch/arm64/boot/dts/qcom/pm8350.dtsi
index 6e91dd7a48b3..2dfeb99300d7 100644
--- a/arch/arm64/boot/dts/qcom/pm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8350.dtsi
@@ -48,6 +48,7 @@ pm8350_gpios: gpio@8800 {
 			compatible = "qcom,pm8350-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;
 			gpio-controller;
+			gpio-ranges = <&pm8350_gpios 0 0 10>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm8350b.dtsi b/arch/arm64/boot/dts/qcom/pm8350b.dtsi
index d9512f01ed1e..f1c7bd9d079c 100644
--- a/arch/arm64/boot/dts/qcom/pm8350b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8350b.dtsi
@@ -48,6 +48,7 @@ pm8350b_gpios: gpio@8800 {
 			compatible = "qcom,pm8350b-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;
 			gpio-controller;
+			gpio-ranges = <&pm8350b_gpios 0 0 8>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index aedc0aa5602f..d52919a8c0b0 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -111,6 +111,7 @@ pm8916_gpios: gpios@c000 {
 			compatible = "qcom,pm8916-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
+			gpio-ranges = <&pm8916_gpios 0 0 4>;
 			#gpio-cells = <2>;
 			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
 				     <0 0xc1 0 IRQ_TYPE_NONE>,
diff --git a/arch/arm64/boot/dts/qcom/pmr735b.dtsi b/arch/arm64/boot/dts/qcom/pmr735b.dtsi
index 93a658eb4cdd..ec24c4478005 100644
--- a/arch/arm64/boot/dts/qcom/pmr735b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmr735b.dtsi
@@ -48,6 +48,7 @@ pmr735b_gpios: gpio@8800 {
 			compatible = "qcom,pmr735b-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;
 			gpio-controller;
+			gpio-ranges = <&pmr735b_gpios 0 0 4>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 43190a5cfe33..26f1e8cc9c6c 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -41,6 +41,7 @@ pms405_gpios: gpio@c000 {
 			compatible = "qcom,pms405-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
+			gpio-ranges = <&pms405_gpios 0 0 12>;
 			#gpio-cells = <2>;
 			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
 				<0 0xc1 0 IRQ_TYPE_NONE>,
-- 
2.32.0

