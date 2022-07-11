Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B848156D7FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiGKIaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiGKIaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:30:11 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04681F2CF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:29:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 19so5337426ljz.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dC6LNIuV4u3SkoGFdSK182o/o6Da8Zz3GIIdjx4l8L0=;
        b=lzSyO4Ox0rVozeD1AtRgwVLBVTRwfCmvF0gjrNi5W87whAJGsO7EM7+7hp6EsDVlWb
         RuIO3TGkcXGuTpIL06BY8G70JF/Vzz55tQ96qTO4I54X2dkfOFNmUw1UBQ60Xe6jb79q
         rCySCVMos7qeBVmV8OI68pf1kNT0i2eSLxKMTqmIrDVjmX+X9fDd4ZTzCbA1vX6UjRin
         GqE7Z+xQNaRDoVYIl2FrWz1SsbHLISwnxOCCQTBb2sb7U7W7NKtTX96cfOmzpRcMuieR
         9L3Hady7EBgRXs9q9X5+JiVoz2GSmtE/0exEq0mkIdpMH5CptiA5nwDeRO+sl+1nVaVX
         bFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dC6LNIuV4u3SkoGFdSK182o/o6Da8Zz3GIIdjx4l8L0=;
        b=5N+yAH1YxD3VJty5ploSQVIGuxF3vTOlBMkm2Zm+5mmnxgyVdg2gxclsIwYLalmQr5
         mIeHKwqpDY82iukkPbc90ZubhAlSiAv3wlAFQa2LGhwc03KhwBmzLiwcQ7zdoClfcKOP
         0PA3WjHNmyIFt/HkddFEp9z5GVShu3xsE8zwpMBfkRPr1UjyqVvYMkNxRBsZcVOR+hz7
         CJ1UX28bmtTlfMedCRBlzmF3pTsUPkjhA3esiYlWyOV7HIfnTEY+osf7PWtP69b/71m2
         ylc9tHU0DoeCkIfZjH0pmHZZUmGIjQvqMhYs8hZQmN2qIGGulf+Az6bIVUsx/U4GUtzH
         cSOw==
X-Gm-Message-State: AJIora+uWENukqZ2aozQ+WoZZftMViZ2XOZFlHziu/PYC8fgLHDtzKMb
        DlfoE86etxFJpXvUAMFIrPZXmQ==
X-Google-Smtp-Source: AGRyM1tdY2eyygsG2BT5OsoToJC2/vIqxkxEPyuz1dOZfZ8VA+OfdC49cPRm3S4cylCSw9AAlByAVQ==
X-Received: by 2002:a2e:908e:0:b0:25d:53c2:5395 with SMTP id l14-20020a2e908e000000b0025d53c25395mr9280286ljg.120.1657528196136;
        Mon, 11 Jul 2022 01:29:56 -0700 (PDT)
Received: from krzk-bin.. (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id u2-20020a05651206c200b00488ab8914b5sm1401504lff.213.2022.07.11.01.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:29:55 -0700 (PDT)
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
Subject: [PATCH v2 4/5] ARM: dts: qcom: align SDHCI reg-names with DT schema
Date:   Mon, 11 Jul 2022 10:29:39 +0200
Message-Id: <20220711082940.39539-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
References: <20220711082940.39539-1-krzysztof.kozlowski@linaro.org>
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

DT schema requires SDHCI reg names to be hc/core without "_mem" suffix,
just like TXT bindings were expecting before the conversion.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi | 4 ++--
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 1 +
 arch/arm/boot/dts/qcom-msm8226.dtsi | 6 +++---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 6 +++---
 arch/arm/boot/dts/qcom-sdx65.dtsi   | 2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 3e8bded2b5c8..45f3cbcf6238 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -422,7 +422,7 @@ blsp2_uart2: serial@f995e000 {
 		mmc@f9824900 {
 			compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
@@ -435,7 +435,7 @@ mmc@f9824900 {
 		mmc@f98a4900 {
 			compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index a2632349cec4..1b98764bab7a 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -224,6 +224,7 @@ vqmmc: regulator@1948000 {
 		sdhci: mmc@7824900 {
 			compatible = "qcom,sdhci-msm-v4";
 			reg = <0x7824900 0x11c>, <0x7824000 0x800>;
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			bus-width = <8>;
diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 0b5effdb269a..f711463d22dc 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -137,7 +137,7 @@ apcs: syscon@f9011000 {
 		sdhc_1: mmc@f9824900 {
 			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
@@ -153,7 +153,7 @@ sdhc_1: mmc@f9824900 {
 		sdhc_2: mmc@f98a4900 {
 			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
@@ -169,7 +169,7 @@ sdhc_2: mmc@f98a4900 {
 		sdhc_3: mmc@f9864900 {
 			compatible = "qcom,msm8226-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 11b4206036e6..971eceaef3d1 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -439,7 +439,7 @@ acc3: clock-controller@f90b8000 {
 		sdhc_1: mmc@f9824900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
@@ -456,7 +456,7 @@ sdhc_1: mmc@f9824900 {
 		sdhc_3: mmc@f9864900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
@@ -475,7 +475,7 @@ sdhc_3: mmc@f9864900 {
 		sdhc_2: mmc@f98a4900 {
 			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
-			reg-names = "hc_mem", "core_mem";
+			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 7a193678b4f5..4f3389cb6300 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -334,7 +334,7 @@ glink-edge {
 		sdhc_1: mmc@8804000 {
 			compatible = "qcom,sdx65-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x08804000 0x1000>;
-			reg-names = "hc_mem";
+			reg-names = "hc";
 			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
-- 
2.34.1

