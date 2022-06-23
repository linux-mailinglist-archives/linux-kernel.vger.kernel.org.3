Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FA75573D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiFWHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFWHYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:24:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A10046152
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:24:33 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u15so11465795ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UndQkFV094yCZSTZ0g3V8yTNtRHE1sSLI8lJ0Whr5OQ=;
        b=LxxG2HwInE1hIpau8xuu6LTWIsR2ZFXStCwPPsC3E5dWajeJikaGzSqn+YZmgPW4sx
         gAbKhUs8pvI75j9bYMzlXp8zzZLB1gNEOrD06pYYzVbz8njnJ0rFA3ipRIXBeJUqjwyQ
         2OkH8zdS243eKNw16oqWzWkJ4k+ohKxi+t15VnbGw+iCqkmnoCDlwFHDwE7o7/NODy3U
         f3WPG2nfnv8RRUiR7gtdU5pOCcQow69Gw+rEcRBoNPdZCS99Fd0aQ0RVUqFAyRz9hZ9w
         iidcNhejdHzWcqbGQ1mYSJ52znMWT28hkCuDQYjT4QxHcD/Ee7Qza3u1VQgfjfUdOsiG
         lHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UndQkFV094yCZSTZ0g3V8yTNtRHE1sSLI8lJ0Whr5OQ=;
        b=Lkbz4FYW1rRFttMYcM+GMnyMlUEXvG3CEeEM6fqIb/dWqffxK1871v8FJthQLkFFWR
         2bJSpuDPa8O2dJYWQyAgh9Qo7iZ74lm+rfCyw265Z7A4q5cnh+vdnqWJ9rfUx0IbSTYh
         JmhxWniQetFoKL2QyFx+jiHBIocSs78leC3zYS+4Ey3kwGDNh74Z3Cv0fudjribNeBYe
         fBWrhHYlnnzWDvIs9Mlr1B0gIu3dW8DXvNrcuZ4iymEGSk8hUjBizP4YGY70g3LwR5IG
         bGvU332PF/4sWJo9+dV2lrRGKRL3sv0zle3P7Nh/TYeVcxTr7FdutsxqUklhyAtxUl8g
         5IkA==
X-Gm-Message-State: AJIora+vQDLqpQvQMBDTDVmPnj2eFCVSaQn4AknPWaTF4J6Yav/nv2xn
        G/XDr5R/XCNoK3QYUM80UfUBiw==
X-Google-Smtp-Source: AGRyM1t1t95hm8IimzvVPEAlRlVe3PW6IigWDmSWchyuqd6ky2gYS/fF209B7CQraROMk8HyI89kjw==
X-Received: by 2002:a17:907:2d29:b0:70e:8b1c:c3f0 with SMTP id gs41-20020a1709072d2900b0070e8b1cc3f0mr6709673ejc.37.1655969071889;
        Thu, 23 Jun 2022 00:24:31 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id qf6-20020a1709077f0600b006fec4ee28d0sm10305248ejc.189.2022.06.23.00.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 00:24:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: aspeed: centriq2400: drop the board
Date:   Thu, 23 Jun 2022 09:24:28 +0200
Message-Id: <20220623072428.33697-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The board is unmaintained and unused, according to Joel, so simply let's
remove it.

Link: https://lore.kernel.org/all/CACPK8XfxXi8kQr+vxta8rD6SBgxLf_oBjAH0UkPBacQta552YQ@mail.gmail.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/Makefile                    |   1 -
 .../dts/aspeed-bmc-arm-centriq2400-rep.dts    | 225 ------------------
 2 files changed, 226 deletions(-)
 delete mode 100644 arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 03f5b3a15415..6c36b7610c57 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1556,7 +1556,6 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2600-evb.dtb \
 	aspeed-bmc-amd-ethanolx.dtb \
 	aspeed-bmc-ampere-mtjade.dtb \
-	aspeed-bmc-arm-centriq2400-rep.dtb \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
 	aspeed-bmc-asrock-e3c246d4i.dtb \
 	aspeed-bmc-asrock-romed8hm3.dtb \
diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
deleted file mode 100644
index 3395de96ee11..000000000000
--- a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
+++ /dev/null
@@ -1,225 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/dts-v1/;
-
-#include "aspeed-g5.dtsi"
-#include <dt-bindings/gpio/aspeed-gpio.h>
-
-/ {
-	model = "Qualcomm Centriq 2400  REP AST2520";
-	compatible = "qualcomm,centriq2400-rep-bmc", "aspeed,ast2500";
-
-	chosen {
-		stdout-path = &uart5;
-		bootargs = "console=ttyS4,115200 earlycon";
-	};
-
-	memory@80000000 {
-		reg = <0x80000000 0x40000000>;
-	};
-
-	iio-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
-                        <&adc 4>, <&adc 5>, <&adc 6>, <&adc 8>;
-	};
-
-	iio-hwmon-battery {
-		compatible = "iio-hwmon";
-		io-channels = <&adc 7>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		uid_led {
-			label = "UID_LED";
-			gpios = <&gpio ASPEED_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
-		};
-
-		ras_error_led {
-			label = "RAS_ERROR_LED";
-			gpios = <&gpio ASPEED_GPIO(F, 6) GPIO_ACTIVE_LOW>;
-		};
-
-		system_fault {
-			label = "System_fault";
-			gpios = <&gpio ASPEED_GPIO(A, 1) GPIO_ACTIVE_LOW>;
-		};
-	};
-};
-
-&fmc {
-	status = "okay";
-	flash@0 {
-		status = "okay";
-		m25p,fast-read;
-		label = "bmc";
-#include "openbmc-flash-layout.dtsi"
-	};
-};
-
-&spi1 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi1_default>;
-	flash@0 {
-		status = "okay";
-	};
-};
-
-&spi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_spi2ck_default
-			&pinctrl_spi2miso_default
-			&pinctrl_spi2mosi_default
-			&pinctrl_spi2cs0_default>;
-};
-
-&uart3 {
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd3_default &pinctrl_rxd3_default>;
-	current-speed = <115200>;
-};
-
-&uart5 {
-	status = "okay";
-};
-
-&mac0 {
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
-};
-
-&i2c0 {
-	status = "okay";
-};
-
-&i2c1 {
-	status = "okay";
-
-	tmp421@1e {
-		compatible = "ti,tmp421";
-		reg = <0x1e>;
-	};
-	tmp421@2a {
-		compatible = "ti,tmp421";
-		reg = <0x2a>;
-	};
-	tmp421@4e {
-		compatible = "ti,tmp421";
-		reg = <0x4e>;
-	};
-	tmp421@1c {
-		compatible = "ti,tmp421";
-		reg = <0x1c>;
-	};
-};
-
-&i2c2 {
-	status = "okay";
-};
-
-&i2c3 {
-	status = "okay";
-};
-
-&i2c4 {
-	status = "okay";
-};
-
-&i2c5 {
-	status = "okay";
-};
-
-&i2c6 {
-	status = "okay";
-
-	tmp421@1d {
-		compatible = "ti,tmp421";
-		reg = <0x1d>;
-	};
-	tmp421@1f {
-		compatible = "ti,tmp421";
-		reg = <0x1f>;
-	};
-	tmp421@4d {
-		compatible = "ti,tmp421";
-		reg = <0x4d>;
-	};
-	tmp421@4f {
-		compatible = "ti,tmp421";
-		reg = <0x4f>;
-	};
-	nvt210@4c {
-		compatible = "nvt210";
-		reg = <0x4c>;
-	};
-	eeprom@50 {
-		compatible = "atmel,24c128";
-		reg = <0x50>;
-		pagesize = <128>;
-	};
-};
-
-&i2c7 {
-	status = "okay";
-};
-
-&i2c8 {
-	status = "okay";
-
-	pca9641@70 {
-		compatible = "nxp,pca9641";
-		reg = <0x70>;
-		i2c-arb {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			tmp421@1d {
-				compatible = "tmp421";
-				reg = <0x1d>;
-			};
-			adm1278@12 {
-				compatible = "adi,adm1278";
-				reg = <0x12>;
-				Rsense = <500>;
-			};
-			eeprom@50 {
-				compatible = "atmel,24c02";
-				reg = <0x50>;
-			};
-			ds1100@58 {
-				compatible = "ds1100";
-				reg = <0x58>;
-			};
-		};
-	};
-};
-
-&i2c9 {
-	status = "okay";
-};
-
-&vuart {
-	status = "okay";
-};
-
-&gfx {
-	status = "okay";
-};
-
-&pinctrl {
-	aspeed,external-nodes = <&gfx &lhc>;
-};
-
-&gpio {
-	pin_gpio_c7 {
-		gpio-hog;
-		gpios = <ASPEED_GPIO(C, 7) GPIO_ACTIVE_HIGH>;
-		output;
-		line-name = "BIOS_SPI_MUX_S";
-	};
-};
-- 
2.34.1

