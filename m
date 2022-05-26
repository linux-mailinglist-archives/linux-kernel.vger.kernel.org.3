Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E965354D9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345314AbiEZUoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349011AbiEZUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:43:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E2762FB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:43:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id wh22so5157271ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85iVb4+A/+w2UaA25Ya+ceGSvLvHcnWP7QxOqtzvMO0=;
        b=S5HgNEyB98uoUKhbcA2ZtqjGF6gwgVKBN0MkFURRoXbMBq8iIu7iJxYRcd9FD38Jpa
         tWe8zYVtCZbYmS+NbDi+Nm5CLrB+km2bbjR7ukl21Nv8kKqF8JonP4nB4qLK6GrYTcjP
         d/pocrwxXinp08//rTrYuJEUXqKZswR8glcQXFQe04RUelOkjdYYETO+MEhBgzmDGTLc
         Xn9orwyFir1FvDlERpEmi+Nxj2a9vuSqB9eWXo2lpq4v2XiTFlH90LGqcMFOgkzqJIO5
         qy0ksXfU7RphN+JF3V56zpW3zSiHII+U+rtiiQku3N2KWZJ8Umw9ki+e9aKrhmaRFfpN
         1MQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85iVb4+A/+w2UaA25Ya+ceGSvLvHcnWP7QxOqtzvMO0=;
        b=w7qf2DDmNcoMKgrBWGj4ZUiCtSK8JdjMPZDHLJ42dsCM9iKtkXxwYYr+VrnQU9mbRT
         nE+Wr7fe6z6+B3ntGqxd5vOnWT+W7dCJKJdG+jANOI0WEJtdA53dirJ1zPul1ICA2cvh
         4sJBJbEQKkIzD6aI0viWUhexcevBh7lvtI4RZk+7WXnttStOku6RxvYdlWyknee68Ygq
         Hlkm1XbRAn9eeq+9sXwaIZFpu2qLCAJQXb9u6bjrAb5sMfdwvbxU6/GYX+x2mf/IKt45
         h/PfmKr9/bQjYC5tO3qomiFt1Q3DuGuVQuC1RJE8F9auELCR9Rnd7bbRTnqtKTFE29NF
         XxMw==
X-Gm-Message-State: AOAM531yyqqgtfYEcifsi3jmL/qZqhciBISruQ1ICf29vC/dt8CPUes7
        86utoIFxblvxWi9si+1CyEjgMQ==
X-Google-Smtp-Source: ABdhPJzhHZYNpvkWufjke/+3QahMJ3HSt67FFrEGa28DRx3ILij6+UCPSuL1/9rMJLjuWFYYjmF8sQ==
X-Received: by 2002:a17:907:a406:b0:6ff:29ea:5e3 with SMTP id sg6-20020a170907a40600b006ff29ea05e3mr3421402ejc.161.1653597790628;
        Thu, 26 May 2022 13:43:10 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s25-20020a170906bc5900b006fed40e5564sm802097ejv.83.2022.05.26.13.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:43:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: fsl: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:42:57 +0200
Message-Id: <20220526204258.832179-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204258.832179-1-krzysztof.kozlowski@linaro.org>
References: <20220526204258.832179-1-krzysztof.kozlowski@linaro.org>
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

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm/boot/dts/imx51-ts4800.dts           | 2 +-
 arch/arm/boot/dts/imx6dl-plym2m.dts          | 2 +-
 arch/arm/boot/dts/imx6dl-prtvt7.dts          | 2 +-
 arch/arm/boot/dts/imx6dl-victgo.dts          | 2 +-
 arch/arm/boot/dts/imx6q-bosch-acc.dts        | 2 +-
 arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi | 4 ++--
 arch/arm/boot/dts/imx6ul-tqma6ul2l.dtsi      | 2 +-
 arch/arm/boot/dts/imx6ull-tqma6ull2.dtsi     | 2 +-
 arch/arm/boot/dts/imx6ull-tqma6ull2l.dtsi    | 2 +-
 arch/arm/boot/dts/imx7d-sdb.dts              | 2 +-
 arch/arm/boot/dts/imxrt1050.dtsi             | 4 ++--
 arch/arm/boot/dts/ls1021a-iot.dts            | 2 +-
 12 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index 85654d6baf28..f7408722d68a 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -174,7 +174,7 @@ fpga_irqc: fpga-irqc@15000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_interrupt_fpga>;
 			interrupt-parent = <&gpio2>;
-			interrupts= <9 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <1>;
 		};
diff --git a/arch/arm/boot/dts/imx6dl-plym2m.dts b/arch/arm/boot/dts/imx6dl-plym2m.dts
index c4ce23d8ac9f..522660c912a0 100644
--- a/arch/arm/boot/dts/imx6dl-plym2m.dts
+++ b/arch/arm/boot/dts/imx6dl-plym2m.dts
@@ -196,7 +196,7 @@ adc_ts: adc@0 {
 		compatible = "ti,tsc2046e-adc";
 		reg = <0>;
 		pinctrl-0 = <&pinctrl_tsc2046>;
-		pinctrl-names ="default";
+		pinctrl-names = "default";
 		spi-max-frequency = <1000000>;
 		interrupts-extended = <&gpio3 20 IRQ_TYPE_LEVEL_LOW>;
 		#io-channel-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6dl-prtvt7.dts b/arch/arm/boot/dts/imx6dl-prtvt7.dts
index b86deebef7b7..0a0b7acddfb2 100644
--- a/arch/arm/boot/dts/imx6dl-prtvt7.dts
+++ b/arch/arm/boot/dts/imx6dl-prtvt7.dts
@@ -344,7 +344,7 @@ adc_ts: adc@0 {
 		compatible = "ti,tsc2046e-adc";
 		reg = <0>;
 		pinctrl-0 = <&pinctrl_tsc>;
-		pinctrl-names ="default";
+		pinctrl-names = "default";
 		spi-max-frequency = <1000000>;
 		interrupts-extended = <&gpio3 20 IRQ_TYPE_LEVEL_LOW>;
 		#io-channel-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6dl-victgo.dts b/arch/arm/boot/dts/imx6dl-victgo.dts
index 516ec915a911..779b52858a25 100644
--- a/arch/arm/boot/dts/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/imx6dl-victgo.dts
@@ -144,7 +144,7 @@ adc_ts: adc@0 {
 		compatible = "ti,tsc2046e-adc";
 		reg = <0>;
 		pinctrl-0 = <&pinctrl_touchscreen>;
-		pinctrl-names ="default";
+		pinctrl-names = "default";
 		spi-max-frequency = <1000000>;
 		interrupts-extended = <&gpio5 8 IRQ_TYPE_LEVEL_LOW>;
 		#io-channel-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6q-bosch-acc.dts b/arch/arm/boot/dts/imx6q-bosch-acc.dts
index 8768222e183e..731fbc7b317c 100644
--- a/arch/arm/boot/dts/imx6q-bosch-acc.dts
+++ b/arch/arm/boot/dts/imx6q-bosch-acc.dts
@@ -594,7 +594,7 @@ &wdog1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdog1>;
 	fsl,ext-reset-output;
-	timeout-sec=<10>;
+	timeout-sec = <10>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi b/arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi
index 69ae430a53bd..8254bce1b8a2 100644
--- a/arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi
@@ -15,13 +15,13 @@ touchscreen@0 {
 		reg = <0>;
 		spi-max-frequency = <1000000>;
 		interrupts-extended = <&gpio3 19 IRQ_TYPE_LEVEL_LOW>;
-		vcc-supply  = <&reg_3v3>;
+		vcc-supply = <&reg_3v3>;
 		pendown-gpio = <&gpio3 19 GPIO_ACTIVE_LOW>;
 		ti,x-plate-ohms = /bits/ 16 <850>;
 		ti,y-plate-ohms = /bits/ 16 <295>;
 		ti,pressure-min = /bits/ 16 <2>;
 		ti,pressure-max = /bits/ 16 <1500>;
-		ti,vref-mv	= /bits/ 16 <3300>;
+		ti,vref-mv = /bits/ 16 <3300>;
 		ti,settle-delay-usec = /bits/ 16 <15>;
 		ti,vref-delay-usecs = /bits/ 16 <0>;
 		ti,penirq-recheck-delay-usecs = /bits/ 16 <100>;
diff --git a/arch/arm/boot/dts/imx6ul-tqma6ul2l.dtsi b/arch/arm/boot/dts/imx6ul-tqma6ul2l.dtsi
index caf2c5d03f7e..4b87e2dc70dc 100644
--- a/arch/arm/boot/dts/imx6ul-tqma6ul2l.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tqma6ul2l.dtsi
@@ -14,7 +14,7 @@ / {
 };
 
 &usdhc2 {
-	fsl,tuning-step= <6>;
+	fsl,tuning-step = <6>;
 };
 
 &iomuxc {
diff --git a/arch/arm/boot/dts/imx6ull-tqma6ull2.dtsi b/arch/arm/boot/dts/imx6ull-tqma6ull2.dtsi
index 326e6da91ed4..8541cb3f3b3e 100644
--- a/arch/arm/boot/dts/imx6ull-tqma6ull2.dtsi
+++ b/arch/arm/boot/dts/imx6ull-tqma6ull2.dtsi
@@ -14,7 +14,7 @@ / {
 };
 
 &usdhc2 {
-	fsl,tuning-step= <6>;
+	fsl,tuning-step = <6>;
 	/* Errata ERR010450 Workaround */
 	max-frequency = <99000000>;
 	assigned-clocks = <&clks IMX6UL_CLK_USDHC2_SEL>, <&clks IMX6UL_CLK_USDHC2>;
diff --git a/arch/arm/boot/dts/imx6ull-tqma6ull2l.dtsi b/arch/arm/boot/dts/imx6ull-tqma6ull2l.dtsi
index 8e4d5cd18614..be593d47e3b1 100644
--- a/arch/arm/boot/dts/imx6ull-tqma6ull2l.dtsi
+++ b/arch/arm/boot/dts/imx6ull-tqma6ull2l.dtsi
@@ -14,7 +14,7 @@ / {
 };
 
 &usdhc2 {
-	fsl,tuning-step= <6>;
+	fsl,tuning-step = <6>;
 	/* Errata ERR010450 Workaround */
 	max-frequency = <99000000>;
 	assigned-clocks = <&clks IMX6UL_CLK_USDHC2_SEL>, <&clks IMX6UL_CLK_USDHC2>;
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index f053f5122741..78f4224a9bf4 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -201,7 +201,7 @@ tsc2046@0 {
 		compatible = "ti,tsc2046";
 		reg = <0>;
 		spi-max-frequency = <1000000>;
-		pinctrl-names ="default";
+		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_tsc2046_pendown>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <29 0>;
diff --git a/arch/arm/boot/dts/imxrt1050.dtsi b/arch/arm/boot/dts/imxrt1050.dtsi
index 77b911b06041..03e6a858a7be 100644
--- a/arch/arm/boot/dts/imxrt1050.dtsi
+++ b/arch/arm/boot/dts/imxrt1050.dtsi
@@ -83,7 +83,7 @@ edma1: dma-controller@400e8000 {
 		};
 
 		usdhc1: mmc@402c0000 {
-			compatible ="fsl,imxrt1050-usdhc", "fsl,imx6sl-usdhc";
+			compatible = "fsl,imxrt1050-usdhc", "fsl,imx6sl-usdhc";
 			reg = <0x402c0000 0x4000>;
 			interrupts = <110>;
 			clocks = <&clks IMXRT1050_CLK_IPG_PDOF>,
@@ -95,7 +95,7 @@ usdhc1: mmc@402c0000 {
 			no-1-8-v;
 			max-frequency = <4000000>;
 			fsl,tuning-start-tap = <20>;
-			fsl,tuning-step= <2>;
+			fsl,tuning-step = <2>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/ls1021a-iot.dts b/arch/arm/boot/dts/ls1021a-iot.dts
index 66bcdaf4b6f9..ce8e26d7791f 100644
--- a/arch/arm/boot/dts/ls1021a-iot.dts
+++ b/arch/arm/boot/dts/ls1021a-iot.dts
@@ -142,7 +142,7 @@ pca9555: gpio@23 {
 	};
 
 	sgtl5000: audio-codec@2a {
-		#sound-dai-cells=<0x0>;
+		#sound-dai-cells = <0x0>;
 		compatible = "fsl,sgtl5000";
 		reg = <0x2a>;
 		VDDA-supply = <&reg_3p3v>;
-- 
2.34.1

