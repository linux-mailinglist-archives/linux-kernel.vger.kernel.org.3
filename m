Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF774F81BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbiDGOfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbiDGOfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:35:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B695A1A12B9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:32:58 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id k23so11273046ejd.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GIcLNaOJ5ag7cmJPgnxQko2OjQFq1jVpKTfZ3tXClU=;
        b=VeUDBC0PdlUDY8Ds1nerVQ5uylXDO9RYxBM36uENYlQAE9cJZrDRbobsvjJfCYVsdp
         AhosRci4onJnhfHFE7eWyBxkSVm+czFUoRVA9UhhUrPSw9zcfamINCIPU293AagdKKcu
         0ZHmh9SdHWAvO/TvF+qn7sWGXTT0xG1SfFB7UICkknIORawQ6K+smRFH1HrY74z5XUjA
         SjNMebZVMNev81K15JCprlvL4ehxBRYc4Bb8uX94+4xylYTBslzsdb6hfgE425sd6DQ7
         Bm+w/5kvtrtTaKlzqUoK6ptzuhyrt80W0QFVmnNiMXTB2gYdxUXpgTJQ5RcpJuYEC2Sm
         OwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GIcLNaOJ5ag7cmJPgnxQko2OjQFq1jVpKTfZ3tXClU=;
        b=1u8gxBAhSFdZhHimQuDIkmraDLF1WdCCaSoH5GUbAZDRd6uRx/szbEXc4DsaRgXqtK
         FGuL0aN1q+JAthonKYGG+HVe/xcHHV6UFev/10G8kB6y218S7cdszz0qyYS6oQ3RAekd
         m1dJMBd7oBEiJ4aMCcQapKS8QHC4WHtv7rx3g2SacHYKhJo6Xoujia4h+UcVcUHzx/Nq
         8DIinStDvkZ+QIrwfhBOwlnNLdCZ47GLhax/bkx4Am5aIfxx+9vtTa9ZmO4YaYzeEgwK
         A7yAhSGrICm8w8gQaFtSyy/9ZEqezyeLcFI2CEYMFRGMnB1SclbCPtKVXcDpPOxf9LKj
         osKg==
X-Gm-Message-State: AOAM531Zv97N81gcnKateecnOCSJ1UauN54FYX2uq3EIho0Uraxd8Xq1
        x1s9aaDn/bHNa4C+FH/bGGS/Pw==
X-Google-Smtp-Source: ABdhPJxYUaJG0sXAutczGdrI0YTYZtangmyTA/uZ/Hzw8jS+41L1NAA3nUM/KMz3g/bNwrVZq1Xp7w==
X-Received: by 2002:a17:907:e8d:b0:6e0:19e7:9549 with SMTP id ho13-20020a1709070e8d00b006e019e79549mr14093058ejc.44.1649341945510;
        Thu, 07 Apr 2022 07:32:25 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id d12-20020a50cf4c000000b0041cc12dc1f3sm6618038edk.71.2022.04.07.07.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:32:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: at91: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:32:22 +0200
Message-Id: <20220407143223.295344-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/at91-dvk_su60_somc.dtsi     | 2 +-
 arch/arm/boot/dts/at91-q5xr5.dts              | 2 +-
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi   | 2 +-
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   | 2 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi     | 2 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts          | 2 +-
 arch/arm/boot/dts/at91-vinco.dts              | 2 +-
 arch/arm/boot/dts/at91sam9n12ek.dts           | 2 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi           | 2 +-
 arch/arm/boot/dts/sama5d3xmb.dtsi             | 2 +-
 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi         | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi b/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
index c1c8650dafce..3542ad8a243e 100644
--- a/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
+++ b/arch/arm/boot/dts/at91-dvk_su60_somc.dtsi
@@ -44,7 +44,7 @@ &spi0 {
 	status = "okay";
 
 	/* spi0.0: 4M Flash Macronix MX25R4035FM1IL0 */
-	spi-flash@0 {
+	flash@0 {
 		compatible = "mxicy,mx25u4035", "jedec,spi-nor";
 		spi-max-frequency = <33000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/at91-q5xr5.dts b/arch/arm/boot/dts/at91-q5xr5.dts
index 47a00062f01f..9cf60b6f695c 100644
--- a/arch/arm/boot/dts/at91-q5xr5.dts
+++ b/arch/arm/boot/dts/at91-q5xr5.dts
@@ -125,7 +125,7 @@ &spi0 {
 	cs-gpios = <&pioA 3 GPIO_ACTIVE_HIGH>, <&pioC 11 GPIO_ACTIVE_LOW>, <0>, <0>;
 	status = "okay";
 
-	m25p80@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
index 21c86171e462..ba621783acdb 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
@@ -214,7 +214,7 @@ &qspi1 {
 	pinctrl-0 = <&pinctrl_qspi1_default>;
 	status = "disabled";
 
-	qspi1_flash: spi_flash@0 {
+	qspi1_flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
index c145c4e5ef58..5e8755f22784 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
@@ -191,7 +191,7 @@ &pwm0 {
 &qspi1 {
 	status = "okay";
 
-	qspi1_flash: spi_flash@0 {
+	qspi1_flash: flash@0 {
 		status = "okay";
 	};
 };
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 9bf2ec0ba3e2..cdfe891f9a9e 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -137,7 +137,7 @@ spi0: spi@f8000000 {
 				pinctrl-0 = <&pinctrl_spi0_default>;
 				status = "okay";
 
-				m25p80@0 {
+				flash@0 {
 					compatible = "atmel,at25df321a";
 					reg = <0>;
 					spi-max-frequency = <50000000>;
diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
index 710cb72bda5a..fd1086f52b40 100644
--- a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
@@ -49,7 +49,7 @@ spi0: spi@f8010000 {
 				cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
 				status = "okay";
 
-				m25p80@0 {
+				flash@0 {
 					compatible = "atmel,at25df321a";
 					spi-max-frequency = <50000000>;
 					reg = <0>;
diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index fe432b6b7e95..7017f626f362 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -65,7 +65,7 @@ ssc0: ssc@f8008000 {
 			spi0: spi@f8010000 {
 				cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
 				status = "okay";
-				m25p80@0 {
+				flash@0 {
 					compatible = "atmel,at25df321a";
 					spi-max-frequency = <50000000>;
 					reg = <0>;
diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
index a51a3372afa1..ebeaa6ab500e 100644
--- a/arch/arm/boot/dts/at91-vinco.dts
+++ b/arch/arm/boot/dts/at91-vinco.dts
@@ -59,7 +59,7 @@ slot@0 {
 			spi0: spi@f8010000 {
 				cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
 				status = "okay";
-				m25p80@0 {
+				flash@0 {
 					compatible = "n25q32b", "jedec,spi-nor";
 					spi-max-frequency = <50000000>;
 					reg = <0>;
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 2bc4e6e0a923..c905d7bfc771 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -119,7 +119,7 @@ pinctrl_usb1_vbus_sense: usb1_vbus_sense {
 			spi0: spi@f0000000 {
 				status = "okay";
 				cs-gpios = <&pioA 14 0>, <0>, <0>, <0>;
-				m25p80@0 {
+				flash@0 {
 					compatible = "atmel,at25df321a";
 					spi-max-frequency = <50000000>;
 					reg = <0>;
diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 6d1264de6060..5f4eaa618ab4 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -125,7 +125,7 @@ &spi0 {
 	cs-gpios = <&pioA 14 0>, <0>, <0>, <0>;
 	status = "disabled"; /* conflicts with mmc1 */
 
-	m25p80@0 {
+	flash@0 {
 		compatible = "atmel,at25df321a";
 		spi-max-frequency = <50000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index a499de8a7a64..3652c9e24124 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -26,7 +26,7 @@ slot@0 {
 			spi0: spi@f0004000 {
 				dmas = <0>, <0>;	/*  Do not use DMA for spi0 */
 
-				m25p80@0 {
+				flash@0 {
 					compatible = "atmel,at25df321a";
 					spi-max-frequency = <50000000>;
 					reg = <0>;
diff --git a/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi b/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
index fa9e5e2a745d..5d9e97fecf83 100644
--- a/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
@@ -25,7 +25,7 @@ slot@0 {
 			spi0: spi@f0004000 {
 				dmas = <0>, <0>;	/*  Do not use DMA for spi0 */
 
-				m25p80@0 {
+				flash@0 {
 					compatible = "atmel,at25df321a";
 					spi-max-frequency = <50000000>;
 					reg = <0>;
-- 
2.32.0

