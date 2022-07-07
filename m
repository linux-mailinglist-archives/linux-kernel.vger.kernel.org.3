Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC0B569C8B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbiGGIE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiGGIEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:04:46 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7958925C5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:04:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 19so407416ljz.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NtRj5O4nkE3cVEceWCLBngIdUnO9GCbDr+tkVq82xkI=;
        b=IZ/WuPDO2Es2t+93M8st9KdI2bn3shb7sRgxrO49iwvDI1QCCZJofarEfpsidIseO1
         R+WqbcP6szS/8bTLMIknwl/vuilpf0FFhB8TK3VXhgGT2mlC2JU+yTskZfSGAlUmGzwK
         RvXPfGf9G3Kfb6ME1/0empb1vN7IzvO8d0nRx55ilZ+FoEgtBUy1lyt+iDMSiQkiXs1s
         lDN57vRksfHa9Tct/002BRSBAUxRT/TuTTd8Ez+PS8Qkg6SnY/mq9z2dau4LJZouYTxV
         Ja12Ssw9fUMcuGziBiBnaW8l9CwowvtBqFY2KobHJ/Fu4arctyh676VHJIi+mszh8fx3
         LOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtRj5O4nkE3cVEceWCLBngIdUnO9GCbDr+tkVq82xkI=;
        b=YfeAMY+jABTFtBdg9knMZRvNR32xQdZTAaByCxxA9MypXPMwgWhXiryd6OVQ7KZgFB
         UOEIT56BapymHp1lVlKytMJMoxtd3gzo90r25LoQGiE710fZIJ6EocbHxCb9JOkfFQyT
         Tu+gp9uKDzazyuOKFlsx54ZoSxV2Zzgn9EqnhwP3sl3EXmo4ru/Q/g+rRShdEUeGc5pK
         9LMVLRWyjcYZSDgpv5YI/Oo9SbhypFmQYw1fdbLpFFLa63PKnugmUWP1WOS+6Twf8aQF
         65v6v+IHmm5Xssj1AsuL9CSimXALrlfCkQ9S2jDWovF+z0L8RXEbdt3F8YbQtyog3UrQ
         0NwQ==
X-Gm-Message-State: AJIora/ZpJxXfeL5JH+w28JLEZcg2JRVBegexAF+qdr+yU93VW6YvJm0
        w08n/lYy8fHvMZzwGlTPWSAiJg==
X-Google-Smtp-Source: AGRyM1tFydeT/z45l04X0FlpzM1XlJMya0/TVJwM+JiRkhSe36n+dUVfOKUD3tBOoHWEAl6u+yK/Sg==
X-Received: by 2002:a2e:7c07:0:b0:25a:73a0:4373 with SMTP id x7-20020a2e7c07000000b0025a73a04373mr25637376ljc.409.1657181084041;
        Thu, 07 Jul 2022 01:04:44 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b0047b0f2d7650sm6697187lfr.271.2022.07.07.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:04:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/5] ARM: dts: qcom: align SDHCI clocks with DT schema
Date:   Thu,  7 Jul 2022 09:51:51 +0200
Message-Id: <20220707075151.67335-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org>
References: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org>
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

The DT schema expects clocks iface-core order.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi    | 12 ++++++------
 arch/arm/boot/dts/qcom-ipq4019.dtsi    |  4 ++--
 arch/arm/boot/dts/qcom-msm8226.dtsi    | 18 +++++++++---------
 arch/arm/boot/dts/qcom-msm8974.dtsi    | 18 +++++++++---------
 arch/arm/boot/dts/qcom-msm8974pro.dtsi |  6 +++---
 5 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 45f3cbcf6238..c887ac5cdd7d 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -425,10 +425,10 @@ mmc@f9824900 {
 			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&gcc GCC_SDCC1_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			status = "disabled";
 		};
 
@@ -438,10 +438,10 @@ mmc@f98a4900 {
 			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&gcc GCC_SDCC2_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 1b98764bab7a..a8a32a5e7e5d 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -228,9 +228,9 @@ sdhci: mmc@7824900 {
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			bus-width = <8>;
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>, <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&gcc GCC_DCD_XO_CLK>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index f711463d22dc..9d4223bf8fc1 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -141,10 +141,10 @@ sdhc_1: mmc@f9824900 {
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&gcc GCC_SDCC1_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdhc1_default_state>;
 			status = "disabled";
@@ -157,10 +157,10 @@ sdhc_2: mmc@f98a4900 {
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&gcc GCC_SDCC2_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdhc2_default_state>;
 			status = "disabled";
@@ -173,10 +173,10 @@ sdhc_3: mmc@f9864900 {
 			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC3_APPS_CLK>,
-				 <&gcc GCC_SDCC3_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC3_AHB_CLK>,
+				 <&gcc GCC_SDCC3_APPS_CLK>,
 				 <&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			pinctrl-names = "default";
 			pinctrl-0 = <&sdhc3_default_state>;
 			status = "disabled";
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 971eceaef3d1..1f4baa6ac64d 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -443,10 +443,10 @@ sdhc_1: mmc@f9824900 {
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&gcc GCC_SDCC1_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			bus-width = <8>;
 			non-removable;
 
@@ -460,10 +460,10 @@ sdhc_3: mmc@f9864900 {
 			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC3_APPS_CLK>,
-				 <&gcc GCC_SDCC3_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC3_AHB_CLK>,
+				 <&gcc GCC_SDCC3_APPS_CLK>,
 				 <&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			bus-width = <4>;
 
 			#address-cells = <1>;
@@ -479,10 +479,10 @@ sdhc_2: mmc@f98a4900 {
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&gcc GCC_SDCC2_AHB_CLK>,
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&xo_board>;
-			clock-names = "core", "iface", "xo";
+			clock-names = "iface", "core", "xo";
 			bus-width = <4>;
 
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/qcom-msm8974pro.dtsi b/arch/arm/boot/dts/qcom-msm8974pro.dtsi
index 1e882e16a221..58df6e75ab6d 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974pro.dtsi
@@ -10,10 +10,10 @@ &gpu {
 };
 
 &sdhc_1 {
-	clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-		 <&gcc GCC_SDCC1_AHB_CLK>,
+	clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+		 <&gcc GCC_SDCC1_APPS_CLK>,
 		 <&xo_board>,
 		 <&gcc GCC_SDCC1_CDCCAL_FF_CLK>,
 		 <&gcc GCC_SDCC1_CDCCAL_SLEEP_CLK>;
-	clock-names = "core", "iface", "xo", "cal", "sleep";
+	clock-names = "iface", "core", "xo", "cal", "sleep";
 };
-- 
2.34.1

