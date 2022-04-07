Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C744F81C8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbiDGOfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242422AbiDGOfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:35:06 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59301AA05B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:33:04 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id qh7so11182921ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYx6WvmvPVasuTSNV9558K37cC2r2s2ajBREoXNyRzA=;
        b=soo+xAe3un5Z/4IpCunTRZWwdgBL1UCYPVfeIX32Yr6LS8djtW2OqI2/mPE4LXuKq+
         VKPH0fLrgZh8YJQupPU08OHJIx1oh4VMKfaPokU/JKmbZUcSldmJ1Iw+spRApG6K7FuD
         AmxhMjQnwZZ0VvTJMxYdly7JSL/rSISrOdggsbK6g7WqAzVN4qvBKCGRtBJSg9Le+UPs
         f7k/6HWfdiv+cIEX7cgc334aUpK8j8PlArbfHIvTTVgK4hId/KK7TbAkLkqHE3Q2Atv8
         8ArJ53UUVw1+BVZaHc8NKRYjkyCtPJLZEFKCxiVBN+THUSPiSRUuVQ+/01kUFo10GhRn
         BKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYx6WvmvPVasuTSNV9558K37cC2r2s2ajBREoXNyRzA=;
        b=BEcz0cg5Z3aja/yUeQsfZj/pu+AG97mvWST1uWSUzT8S5j9E7w8MDWkGUZ9F1v+qzn
         c6pR+yBD6iXq08WaD+qT5XA3uxZ5uua2RYn8xy695ZCgngDn2ZP9de2r/VfpS2N0zhTJ
         pbHeYPQpn8+kb6bYTtsYRAwUHECPU4HSQsHfN+kJf9E600jyEyVBJzZqGA20y8MtfnOc
         cSOleq3esD8M+A6QtKP+CwwaeFtEj+KCh/dSaRSyNGf1PkCBGu4q1DCr1DVje2vnDbX0
         bxQ4h73KkBMd8/InCLcvRUu6jx5UnXULij+oY3groaEuuVKwLhZt6ug9+y3eM3cEb2Y/
         WJ8g==
X-Gm-Message-State: AOAM5311LiiP7XyjLaDOrZMgbKa3mY2XVM6BP18HT3lsidtq6+hGlu8v
        pzn/uFt9WA8j5Pljn9zOwx2uAw==
X-Google-Smtp-Source: ABdhPJzBeAMapRcD10uLOPr1+qNyKD3PjedDGqVD1SRYWjp1T3wV/4J/Yz44pkk0FId/asKk+r3Ayg==
X-Received: by 2002:a17:907:6e8c:b0:6e8:3f0f:936a with SMTP id sh12-20020a1709076e8c00b006e83f0f936amr2208702ejc.448.1649341921338;
        Thu, 07 Apr 2022 07:32:01 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id fy5-20020a1709069f0500b006e841c87243sm236526ejc.64.2022.04.07.07.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:32:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: imx: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:31:54 +0200
Message-Id: <20220407143155.295187-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/imx28-evk.dts                        | 2 +-
 arch/arm/boot/dts/imx28-m28evk.dts                     | 2 +-
 arch/arm/boot/dts/imx28-sps1.dts                       | 2 +-
 arch/arm/boot/dts/imx6dl-rex-basic.dts                 | 2 +-
 arch/arm/boot/dts/imx6q-ba16.dtsi                      | 2 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi                    | 2 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                     | 2 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts                | 2 +-
 arch/arm/boot/dts/imx6q-dms-ba16.dts                   | 2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts                   | 2 +-
 arch/arm/boot/dts/imx6q-marsboard.dts                  | 2 +-
 arch/arm/boot/dts/imx6q-rex-pro.dts                    | 2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi            | 2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi           | 2 +-
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi           | 2 +-
 arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi          | 2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi               | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi           | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi          | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi              | 2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi               | 2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi               | 2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi                 | 2 +-
 arch/arm/boot/dts/imx6sl-evk.dts                       | 2 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts               | 2 +-
 arch/arm/boot/dts/imx6sx-sdb-reva.dts                  | 4 ++--
 arch/arm/boot/dts/imx6sx-sdb.dts                       | 4 ++--
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi                | 2 +-
 arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi        | 2 +-
 arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi        | 2 +-
 arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi | 2 +-
 arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi       | 2 +-
 32 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 7e2b0f198dfa..1053b7c584d8 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -129,7 +129,7 @@ ssp2: spi@80014000 {
 				pinctrl-0 = <&spi2_pins_a>;
 				status = "okay";
 
-				flash: m25p80@0 {
+				flash: flash@0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
 					compatible = "sst,sst25vf016b", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index f3bddc5ada4b..13acdc7916b9 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -33,7 +33,7 @@ ssp2: spi@80014000 {
 				pinctrl-0 = <&spi2_pins_a>;
 				status = "okay";
 
-				flash: m25p80@0 {
+				flash: flash@0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
 					compatible = "m25p80", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/imx28-sps1.dts
index 43be7a6a769b..90928db0df70 100644
--- a/arch/arm/boot/dts/imx28-sps1.dts
+++ b/arch/arm/boot/dts/imx28-sps1.dts
@@ -51,7 +51,7 @@ ssp2: spi@80014000 {
 				pinctrl-0 = <&spi2_pins_a>;
 				status = "okay";
 
-				flash: m25p80@0 {
+				flash: flash@0 {
 					#address-cells = <1>;
 					#size-cells = <1>;
 					compatible = "everspin,mr25h256", "mr25h256";
diff --git a/arch/arm/boot/dts/imx6dl-rex-basic.dts b/arch/arm/boot/dts/imx6dl-rex-basic.dts
index 0f1616bfa9a8..b72f8ea1e6f6 100644
--- a/arch/arm/boot/dts/imx6dl-rex-basic.dts
+++ b/arch/arm/boot/dts/imx6dl-rex-basic.dts
@@ -19,7 +19,7 @@ memory@10000000 {
 };
 
 &ecspi3 {
-	flash: m25p80@0 {
+	flash: flash@0 {
 		compatible = "sst,sst25vf016b", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index 6330d75f8f39..f266f1b7e0cf 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -142,7 +142,7 @@ &ecspi1 {
 	pinctrl-0 = <&pinctrl_ecspi1>;
 	status = "okay";
 
-	flash: n25q032@0 {
+	flash: flash@0 {
 		compatible = "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index 10922375c51e..ead83091e193 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -160,7 +160,7 @@ &ecspi5 {
 	pinctrl-0 = <&pinctrl_ecspi5>;
 	status = "okay";
 
-	m25_eeprom: m25p80@0 {
+	m25_eeprom: flash@0 {
 		compatible = "atmel,at25";
 		spi-max-frequency = <10000000>;
 		size = <0x8000>;
diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index bfb530f29d9d..1ad41c944b4b 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -260,7 +260,7 @@ &ecspi1 {
 	pinctrl-0 = <&pinctrl_ecspi1>;
 	status = "okay";
 
-	m25p80@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index c713ac03b3b9..9591848cbd37 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -102,7 +102,7 @@ &ecspi5 {
 	cs-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		compatible = "m25p80", "jedec,spi-nor";
 		spi-max-frequency = <40000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6q-dms-ba16.dts b/arch/arm/boot/dts/imx6q-dms-ba16.dts
index 48fb47e715f6..137db38f0d27 100644
--- a/arch/arm/boot/dts/imx6q-dms-ba16.dts
+++ b/arch/arm/boot/dts/imx6q-dms-ba16.dts
@@ -47,7 +47,7 @@ &ecspi5 {
 	pinctrl-0 = <&pinctrl_ecspi5>;
 	status = "okay";
 
-	m25_eeprom: m25p80@0 {
+	m25_eeprom: flash@0 {
 		compatible = "atmel,at25256B", "atmel,at25";
 		spi-max-frequency = <20000000>;
 		size = <0x8000>;
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index 4cde45d5c90c..e894faba571f 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -137,7 +137,7 @@ &ecspi1 {
 	pinctrl-0 = <&pinctrl_ecspi1>;
 	status = "okay";
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		compatible = "sst,w25q256", "jedec,spi-nor";
 		spi-max-frequency = <30000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6q-marsboard.dts b/arch/arm/boot/dts/imx6q-marsboard.dts
index 05ee28388229..cc1801002394 100644
--- a/arch/arm/boot/dts/imx6q-marsboard.dts
+++ b/arch/arm/boot/dts/imx6q-marsboard.dts
@@ -100,7 +100,7 @@ &ecspi1 {
 	cs-gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-	m25p80@0 {
+	flash@0 {
 		compatible = "microchip,sst25vf016b";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6q-rex-pro.dts b/arch/arm/boot/dts/imx6q-rex-pro.dts
index 1767e1a3cd53..271f4b2d9b9f 100644
--- a/arch/arm/boot/dts/imx6q-rex-pro.dts
+++ b/arch/arm/boot/dts/imx6q-rex-pro.dts
@@ -19,7 +19,7 @@ memory@10000000 {
 };
 
 &ecspi3 {
-	flash: m25p80@0 {
+	flash: flash@0 {
 		compatible = "sst,sst25vf032b", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
index e21f6ac864e5..baa197c90060 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
@@ -96,7 +96,7 @@ &ecspi4 {
 	pinctrl-0 = <&pinctrl_ecspi4>;
 	status = "okay";
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "micron,n25q128a11", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
index 563bf9d44fe0..2ba577e602e7 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
@@ -131,7 +131,7 @@ &ecspi4 {
 	pinctrl-0 = <&pinctrl_ecspi4>;
 	status = "okay";
 
-	flash: m25p80@1 {
+	flash: flash@1 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "micron,n25q128a11", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
index 648f5fcb72e6..2c1d6f28e695 100644
--- a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
@@ -35,7 +35,7 @@ &ecspi3 {
 	pinctrl-0 = <&pinctrl_ecspi3>;
 	status = "okay";
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "sst,sst25vf040b", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
index b167b33bd108..095c9143d99a 100644
--- a/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
@@ -258,7 +258,7 @@ &ecspi4 {
 	status = "okay";
 
 	/* default boot source: workaround #1 for errata ERR006282 */
-	smarc_flash: spi-flash@0 {
+	smarc_flash: flash@0 {
 		compatible = "winbond,w25q16dw", "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <20000000>;
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index ac34709e9741..0ad4cb4f1e82 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -179,7 +179,7 @@ &ecspi1 {
 	pinctrl-0 = <&pinctrl_ecspi1>;
 	status = "okay";
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		compatible = "microchip,sst25vf016b";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index c96f4d7e1e0d..beaa2dcd436c 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -321,7 +321,7 @@ &ecspi1 {
 	pinctrl-0 = <&pinctrl_ecspi1>;
 	status = "okay";
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		compatible = "microchip,sst25vf016b";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
index 92d09a3ebe0e..ee7e2371f94b 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
@@ -252,7 +252,7 @@ &ecspi1 {
 	pinctrl-0 = <&pinctrl_ecspi1>;
 	status = "okay";
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		compatible = "microchip,sst25vf016b";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 49da30d7510c..904d5d051d63 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -237,7 +237,7 @@ &ecspi1 {
 	pinctrl-0 = <&pinctrl_ecspi1>;
 	status = "okay";
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		compatible = "sst,sst25vf016b", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 5e58740d40c5..1368a4762037 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -272,7 +272,7 @@ &ecspi1 {
 	pinctrl-0 = <&pinctrl_ecspi1 &pinctrl_ecspi1_cs>;
 	status = "disabled"; /* pin conflict with WEIM NOR */
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p32", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index eb9a0b104f1c..901b9a761b66 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -313,7 +313,7 @@ &ecspi1 {
 	pinctrl-0 = <&pinctrl_ecspi1>;
 	status = "okay";
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		compatible = "sst,sst25vf016b", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 0c0105468a2f..37482a9023fc 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -197,7 +197,7 @@ &ecspi1 {
 	pinctrl-0 = <&pinctrl_ecspi1>;
 	status = "okay";
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p32", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 25f6f2fb1555..f16c830f1e91 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -137,7 +137,7 @@ &ecspi1 {
 	pinctrl-0 = <&pinctrl_ecspi1>;
 	status = "okay";
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p32", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
index 66af78e83b70..a2c79bcf9a11 100644
--- a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
+++ b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
@@ -107,7 +107,7 @@ &ecspi1 {
 	pinctrl-0 = <&pinctrl_ecspi1>;
 	status = "okay";
 
-	flash: m25p80@0 {
+	flash: flash@0 {
 		compatible = "microchip,sst25vf016b";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
index dce5dcf96c25..7dda42553f4b 100644
--- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
@@ -123,7 +123,7 @@ &qspi2 {
 	pinctrl-0 = <&pinctrl_qspi2>;
 	status = "okay";
 
-	flash0: s25fl128s@0 {
+	flash0: flash@0 {
 		reg = <0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -133,7 +133,7 @@ flash0: s25fl128s@0 {
 		spi-tx-bus-width = <4>;
 	};
 
-	flash1: s25fl128s@2 {
+	flash1: flash@2 {
 		reg = <2>;
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 99f4cf777a38..969cfe920d25 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -108,7 +108,7 @@ &qspi2 {
 	pinctrl-0 = <&pinctrl_qspi2>;
 	status = "okay";
 
-	flash0: n25q256a@0 {
+	flash0: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "micron,n25q256a", "jedec,spi-nor";
@@ -118,7 +118,7 @@ flash0: n25q256a@0 {
 		reg = <0>;
 	};
 
-	flash1: n25q256a@2 {
+	flash1: flash@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "micron,n25q256a", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
index a3fde3316c73..1a18c41ce385 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
@@ -286,7 +286,7 @@ &qspi {
 	pinctrl-0 = <&pinctrl_qspi>;
 	status = "okay";
 
-	flash0: n25q256a@0 {
+	flash0: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "micron,n25q256a", "jedec,spi-nor";
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
index 47d3ce5d255f..acd936540d89 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
@@ -19,7 +19,7 @@ memory@80000000 {
 };
 
 &qspi {
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-nand";
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
index a095a7654ac6..29ed38dce580 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
@@ -18,7 +18,7 @@ memory@80000000 {
 };
 
 &qspi {
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-nand";
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
index 2a449a3c1ae2..09a83dbdf651 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
@@ -19,7 +19,7 @@ &ecspi2 {
 	pinctrl-0 = <&pinctrl_ecspi2>;
 	status = "okay";
 
-	spi-flash@0 {
+	flash@0 {
 		compatible = "mxicy,mx25v8035f", "jedec,spi-nor";
 		spi-max-frequency = <50000000>;
 		reg = <0>;
diff --git a/arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi b/arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
index b7e984284e1a..d000606c0704 100644
--- a/arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
+++ b/arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
@@ -18,7 +18,7 @@ memory@80000000 {
 };
 
 &qspi {
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "spi-nand";
-- 
2.32.0

