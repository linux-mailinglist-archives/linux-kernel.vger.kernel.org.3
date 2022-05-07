Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADE651E9C5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 21:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447056AbiEGTxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 15:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446945AbiEGTxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 15:53:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE5A17E01
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 12:49:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e24so14240374wrc.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DETHuK1AGW0MtJsQojTS8x33GEnXY46MVv0jFk7E9B0=;
        b=GlIV/5K1t1kzfM1QGr+MNMcIh0/lAQSspc4ecGh1o7ZhfXG/KHZ9aofpH6dEXKeG2m
         OIxEYr53FpB0aDtQcT6YHF2ReWEpzmrsusgffKu/Kt0UhLkSbYdVbchpNoWenchHrVZ6
         ePgWAAwGGYfC1TYbInhugS4DloNOva5C9U7A6683nfip/ekmZOXTuN9DSEvSoIaJ8wJB
         /XTGcQJR57Xu7AJ1SGeY/PRImCj6ZofiHGwvMn9r0iyAgL1xjJBK2iPqiaZH4tdlE/az
         /eZ22ENCwrN0m++Lr004tQ7OnVP+34mDi9QJwiSZnKGIATnUXyBHabYvWTfsmwNokbaw
         3CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DETHuK1AGW0MtJsQojTS8x33GEnXY46MVv0jFk7E9B0=;
        b=vzviGvAanj5N0oQinl2JUvJhmvh27F+qVGWdGpvKpzmpsFBVO8+UTSnKOC+WmdSH+e
         9xZKI8bW2bi8Pq6awj+Xeolp+XICym4UC8nyllnxq0bVVVeSkU9NLAYpvu8WZLiAQfV1
         58fRC63h1tNOpPafksMjojOwVFVf9FVUe53G4U6C6xhP1/hhxKfvISxPAnKNQG2rpthw
         MJ4B5RDdF/Dqp6Lf8YwRUY3Y82GWq7/DHdDIY/uSYipOs3E65w9Al8ZKMdVW/BHQdIng
         WYCMmmXNg1DhmlK/mmED5e6ThmGj6TCP9Tk1fRXKOsEgLAM71gZJrdmIN4p+PPjY3IA9
         WZeA==
X-Gm-Message-State: AOAM531Z+Viau8B/pa3oXDb90tKkrjB4RbGsLMCn5divcnmuNXXXMXh3
        AkgXy/Jr6FzKz+9Dkg/KK29U7g==
X-Google-Smtp-Source: ABdhPJwdsdVVW2Lv0AjKkCnSMjUPTG31+jBxHqmGitx66Evc8s590XHCcVKjwW8wvPqVyI4fWi4kfA==
X-Received: by 2002:a5d:684b:0:b0:20a:e4d2:1206 with SMTP id o11-20020a5d684b000000b0020ae4d21206mr7743940wrw.599.1651952966644;
        Sat, 07 May 2022 12:49:26 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c1c0600b003942a244ec4sm8535027wms.9.2022.05.07.12.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 12:49:26 -0700 (PDT)
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
Subject: [PATCH 06/11] arm64: dts: qcom: add fallback compatible to PMIC GPIOs
Date:   Sat,  7 May 2022 21:49:08 +0200
Message-Id: <20220507194913.261121-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
References: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
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

The bindings require all PMIC GPIO nodes to have two compatibles -
specific followed by SPMI or SSBI fallback.  Add the fallback to fix
warnings like:

  msm8916-samsung-serranove.dtb: gpios@c000: compatible: ['qcom,pm8916-gpio'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm6350.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/pm660.dtsi       | 2 +-
 arch/arm64/boot/dts/qcom/pm8009.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/pm8150.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/pm8150b.dtsi     | 2 +-
 arch/arm64/boot/dts/qcom/pm8150l.dtsi     | 2 +-
 arch/arm64/boot/dts/qcom/pm8350.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/pm8350b.dtsi     | 2 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/pmr735b.dtsi     | 2 +-
 arch/arm64/boot/dts/qcom/pms405.dtsi      | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm6350.dtsi b/arch/arm64/boot/dts/qcom/pm6350.dtsi
index c5d85064562b..f3056845e65f 100644
--- a/arch/arm64/boot/dts/qcom/pm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6350.dtsi
@@ -36,7 +36,7 @@ pm6350_resin: resin {
 		};
 
 		pm6350_gpios: gpios@c000 {
-			compatible = "qcom,pm6350-gpio";
+			compatible = "qcom,pm6350-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index c482663aad56..d0eefbb51663 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -171,7 +171,7 @@ vcoin: vcoin@83 {
 		};
 
 		pm660_gpios: gpios@c000 {
-			compatible = "qcom,pm660-gpio";
+			compatible = "qcom,pm660-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
 			gpio-ranges = <&pm660_gpios 0 0 13>;
diff --git a/arch/arm64/boot/dts/qcom/pm8009.dtsi b/arch/arm64/boot/dts/qcom/pm8009.dtsi
index b126d7e7e4fb..d451922d2b95 100644
--- a/arch/arm64/boot/dts/qcom/pm8009.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8009.dtsi
@@ -19,7 +19,7 @@ pm8009_pon: pon@800 {
 		};
 
 		pm8009_gpios: gpio@c000 {
-			compatible = "qcom,pm8005-gpio";
+			compatible = "qcom,pm8005-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index 0df76f7b1cc1..72cd93ced4c5 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -127,7 +127,7 @@ rtc@6000 {
 		};
 
 		pm8150_gpios: gpio@c000 {
-			compatible = "qcom,pm8150-gpio";
+			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 058cc5107c75..28162f6fb61d 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -112,7 +112,7 @@ pm8150b_adc_tm: adc-tm@3500 {
 		};
 
 		pm8150b_gpios: gpio@c000 {
-			compatible = "qcom,pm8150b-gpio";
+			compatible = "qcom,pm8150b-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index 52f094a2b713..0642e7d5be35 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -100,7 +100,7 @@ pm8150l_adc_tm: adc-tm@3500 {
 		};
 
 		pm8150l_gpios: gpio@c000 {
-			compatible = "qcom,pm8150l-gpio";
+			compatible = "qcom,pm8150l-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm8350.dtsi b/arch/arm64/boot/dts/qcom/pm8350.dtsi
index b10f33afa5e3..6e91dd7a48b3 100644
--- a/arch/arm64/boot/dts/qcom/pm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8350.dtsi
@@ -45,7 +45,7 @@ pm8350_temp_alarm: temp-alarm@a00 {
 		};
 
 		pm8350_gpios: gpio@8800 {
-			compatible = "qcom,pm8350-gpio";
+			compatible = "qcom,pm8350-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm8350b.dtsi b/arch/arm64/boot/dts/qcom/pm8350b.dtsi
index f1d1d4c8edf8..d9512f01ed1e 100644
--- a/arch/arm64/boot/dts/qcom/pm8350b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8350b.dtsi
@@ -45,7 +45,7 @@ pm8350b_temp_alarm: temp-alarm@a00 {
 		};
 
 		pm8350b_gpios: gpio@8800 {
-			compatible = "qcom,pm8350b-gpio";
+			compatible = "qcom,pm8350b-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index d58902432812..aedc0aa5602f 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -108,7 +108,7 @@ pm8916_mpps: mpps@a000 {
 		};
 
 		pm8916_gpios: gpios@c000 {
-			compatible = "qcom,pm8916-gpio";
+			compatible = "qcom,pm8916-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
index 7072e5a2e73f..68e9122363ae 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
@@ -116,7 +116,7 @@ pmm8155au_1_rtc: rtc@6000 {
 		};
 
 		pmm8155au_1_gpios: gpio@c000 {
-			compatible = "qcom,pmm8155au-gpio";
+			compatible = "qcom,pmm8155au-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
index 72075964fbb9..c307fc662511 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
@@ -89,7 +89,7 @@ die-temp@6 {
 		};
 
 		pmm8155au_2_gpios: gpio@c000 {
-			compatible = "qcom,pmm8155au-gpio";
+			compatible = "qcom,pmm8155au-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pmr735b.dtsi b/arch/arm64/boot/dts/qcom/pmr735b.dtsi
index 604324188603..93a658eb4cdd 100644
--- a/arch/arm64/boot/dts/qcom/pmr735b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmr735b.dtsi
@@ -45,7 +45,7 @@ pmr735b_temp_alarm: temp-alarm@a00 {
 		};
 
 		pmr735b_gpios: gpio@8800 {
-			compatible = "qcom,pmr735b-gpio";
+			compatible = "qcom,pmr735b-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;
 			gpio-controller;
 			#gpio-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 98d173a377d5..43190a5cfe33 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -38,7 +38,7 @@ pms405_0: pms405@0 {
 		#size-cells = <0>;
 
 		pms405_gpios: gpio@c000 {
-			compatible = "qcom,pms405-gpio";
+			compatible = "qcom,pms405-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
2.32.0

