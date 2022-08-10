Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D13A58EAED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiHJLKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiHJLKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:10:16 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AF5BF
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:10:13 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id e15so20822409lfs.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=jd6pw38fvkJ1CP3Yf/Po0UTmeJ7D/lJSHp7TJj2CaLo=;
        b=jTtPl0Zjc5lj2gMDz8Gm5/1t+4pajMakxMNXEMPVwax+sZhOoXk7BEGQg8xFDYbUgC
         oY5dag8IjtF/zQ+ACHyc/HvFLFvy+y05YqhQafQXML0h5RzpsoBgrVEEm9ltuBm5Q0er
         X1Lp03GOUa1AlUlszsJ5eyI3QW3OgOqsWis9N+q3AHjQHR30GvF97vYhMHzKCBMR3pDx
         76humKztRkYkfvXbvKOlYBC1WmloTzInsaiA7TDFVVTCVasjuIsuMNSfe0IHZhZ7RExJ
         5ChvzcOK0V2WMajd8S6VyzHctGh1fEm0i6m2/OHukagN/qv3Vb3DfGCqtc4jppNlpWMv
         JYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=jd6pw38fvkJ1CP3Yf/Po0UTmeJ7D/lJSHp7TJj2CaLo=;
        b=3yfXY/zwtJo2SgfxlsVUN1VaTA2nk/7wgIL4s12crOLZSHSv+X7ztbVZ0T1NMLYKfr
         61WIOH97clWn8w4txt2wRpJxY7kUl/D2+UQsvEPwKeCyHLx95/yhYG16AdPEQX2r1uPF
         58Z1+WqoiYKiLOac2TnjccQOdH4qJoX1f13sluAW6+zYg4n3gT7JUJqWORVkbMjq7GIg
         fZJsQyH+zYMc+JUIV1SPIdFqZ4rr8JkxDBKe63IH5ICSWEDyII5WZa1Ntuxweo/mh2IV
         HSLLNcWgDQ3LPpgMBPLpUnD64RyailhPHlQ7tB1axuLGQFzVTP4BVDXVOTIN8Kea7T/u
         gXzg==
X-Gm-Message-State: ACgBeo0M/zKJ6IucDFdu4jXzJtfTd2rTSA7vGLf2ssvvYMZMExoPzhEq
        wTw2q5BsrFCmIW7+wi8mDTWmOQ==
X-Google-Smtp-Source: AA6agR5Z0BBtQ19UXN7yW3i3+UrJtD9mTOTbWltPxdpz8E0gUubcfawe11zMgQWAdDR8TP2bN8+ToQ==
X-Received: by 2002:ac2:44bc:0:b0:48a:eb48:6b78 with SMTP id c28-20020ac244bc000000b0048aeb486b78mr10307287lfm.326.1660129811522;
        Wed, 10 Aug 2022 04:10:11 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id u17-20020ac243d1000000b0048b0975ac7asm301425lfl.151.2022.08.10.04.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:10:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] ARM: dts: imx: align SPI node name with dtschema
Date:   Wed, 10 Aug 2022 14:10:06 +0300
Message-Id: <20220810111008.280850-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/imx28-cfa10049.dts    | 4 ++--
 arch/arm/boot/dts/imx28-cfa10055.dts    | 2 +-
 arch/arm/boot/dts/imx28-cfa10056.dts    | 2 +-
 arch/arm/boot/dts/imx28-tx28.dts        | 2 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts    | 2 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi | 2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi     | 2 +-
 arch/arm/boot/dts/imx7d-sdb.dts         | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index a92b05ef390f..ff1b450c0717 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -327,7 +327,7 @@ mac0: ethernet@800f0000 {
 		};
 	};
 
-	spi2 {
+	spi-2 {
 		compatible = "spi-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi2_pins_cfa10049>;
@@ -351,7 +351,7 @@ hx8357: hx8357@0 {
 		};
 	};
 
-	spi3 {
+	spi-3 {
 		compatible = "spi-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi3_pins_cfa10049>;
diff --git a/arch/arm/boot/dts/imx28-cfa10055.dts b/arch/arm/boot/dts/imx28-cfa10055.dts
index d05c370dfc17..fac5bbda7a93 100644
--- a/arch/arm/boot/dts/imx28-cfa10055.dts
+++ b/arch/arm/boot/dts/imx28-cfa10055.dts
@@ -129,7 +129,7 @@ pwm: pwm@80064000 {
 		};
 	};
 
-	spi2 {
+	spi-2 {
 		compatible = "spi-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi2_pins_cfa10055>;
diff --git a/arch/arm/boot/dts/imx28-cfa10056.dts b/arch/arm/boot/dts/imx28-cfa10056.dts
index c1060bd5f17f..c5f3337e8b39 100644
--- a/arch/arm/boot/dts/imx28-cfa10056.dts
+++ b/arch/arm/boot/dts/imx28-cfa10056.dts
@@ -88,7 +88,7 @@ timing0: timing0 {
 		};
 	};
 
-	spi2 {
+	spi-2 {
 		compatible = "spi-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi2_pins_cfa10056>;
diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index 6d7b044fec5b..096f246032c6 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -221,7 +221,7 @@ &gpio5 7 GPIO_ACTIVE_HIGH
 		linux,no-autorepeat;
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		compatible = "spi-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index ec8ca3ac2c1c..3140f038aa98 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -137,7 +137,7 @@ sgtl5000: codec@a {
 		};
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		compatible = "spi-gpio";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
index 1a18c41ce385..c83e64a62d8a 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
@@ -82,7 +82,7 @@ sound-wm8960 {
 			"AMIC", "MICB";
 	};
 
-	spi4 {
+	spi-4 {
 		compatible = "spi-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_spi4>;
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index c485d058e079..15ee0275feaf 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -212,7 +212,7 @@ reg_usbotg_vbus: regulator-usbotgvbus {
 		enable-active-high;
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "spi-gpio";
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 78f4224a9bf4..7eadd7617943 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -39,7 +39,7 @@ volume-down {
 		};
 	};
 
-	spi4 {
+	spi-4 {
 		compatible = "spi-gpio";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_spi4>;
-- 
2.34.1

