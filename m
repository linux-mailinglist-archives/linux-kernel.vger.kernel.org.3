Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC18958EB07
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiHJLMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiHJLLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:11:33 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F35E31DDF
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:11:30 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id by6so7336370ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 04:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Ch7MLzjtjxDAnl8q0BHET3tRA6bodCqHcVbiwE3Oe4g=;
        b=KiNK2omd8DLq4fRawlv2UlQGC3ixt2SOv3WoamhbOn4/WJIHBztUaYvcdEcoEXaeWV
         n3qT5h4eX4/7LFps12YmPYQ0TjGoRatvvtXHp9STxIeeb526zUYTI0ILSYwEL49rB1zK
         4nLLLR+SvRw6OTAIL1Ocw6OHB9fmfsD2dG8PIpnjXmOUKRGmgz83XR6g9snA9M7VcLOS
         jECd8j9D3LrusZc2qHwL1B/d9cDKh3RgSdyRmV3y6f+uoMC+EIqxFAWYD0wckIXH8B3I
         VNO1+2CuFnXqSsXlUCayvwEqU0IXCvVWHZomrQGBc8k3ihJEHi9G700l32EWd7H1xPtX
         /Gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Ch7MLzjtjxDAnl8q0BHET3tRA6bodCqHcVbiwE3Oe4g=;
        b=FxvzXU7yfDZo/u4vPNCLlbN5CV3EIvc9j8c5ygvlkv0nnofnTvBKvafvMeNroX6dIf
         dw8oMlKa5kqMFAtIMZHunMwGv0uk9qY/1NYPFWwFgwOl1y7xTqVu6/Y+DXSPHQHR7uQv
         CgeE+xfKaAnRw/RcRmTkEfw8UWbS1HdQFPAo/ErMuwWEcQ7lxhChbeDtIRhiN0UdAKTr
         4sRQsn2R785IoN50rs++G8FOM3J/Z8G+paqRIM/GY6/rjzZjdn2WiLuXvNGh5AOwYuKn
         Ck2NBMbZgDax1qiXjOaHl8Alfte7EIwf3YCfLPnIfypAUbYLLd/v67yoe3JuGUixQUU4
         J/BA==
X-Gm-Message-State: ACgBeo2yQwbJ4NRBLjsUBsZ/mAlSCwCBEoGrijMpzZPsp6VfDuGaExgr
        BQcNycT5ORSg1+yyORT2QpB6Poeiq6wPQP8G
X-Google-Smtp-Source: AA6agR4Yhps3ifFoUzNeZ4v4pfsf5foycFIjE22kBxaGVNAFDbW82io8VHx2WQvR01APu6a1u0hMIA==
X-Received: by 2002:a05:651c:1503:b0:24c:81df:e1f2 with SMTP id e3-20020a05651c150300b0024c81dfe1f2mr8137090ljf.182.1660129889284;
        Wed, 10 Aug 2022 04:11:29 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id p20-20020ac24ed4000000b0048a7c86f4e7sm298221lfr.291.2022.08.10.04.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:11:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: aspeed: align SPI node name with dtschema
Date:   Wed, 10 Aug 2022 14:11:26 +0300
Message-Id: <20220810111126.281214-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The node names should be generic and DT schema expects certain pattern.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts | 2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts      | 2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts        | 2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts    | 2 +-
 arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
index 9c6271a17ae8..5cd060029ea9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dts
@@ -77,7 +77,7 @@ aliases {
 		i2c55 = &imux55;
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		num-chipselects = <2>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>,
 			   <&gpio0 ASPEED_GPIO(X, 1) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
index 27b43fe099f1..4b520d7ce3e1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
@@ -44,7 +44,7 @@ chosen {
 		stdout-path = &uart5;
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		num-chipselects = <1>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
 	};
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts
index af58a73bbc49..6b319f34a9b9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dts
@@ -207,7 +207,7 @@ aliases {
 		i2c143 = &imux143;
 	};
 
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		num-chipselects = <3>;
 		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>,
 			   <0>,	/* device reg=<1> does not exist */
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
index a901c8be49b9..ed305948386f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
@@ -67,7 +67,7 @@ ast-adc-hwmon {
 	 * full-duplex SPI transactions are not supported by ASPEED SPI
 	 * Controllers.
 	 */
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		status = "okay";
 		compatible = "spi-gpio";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
index 051de5bec345..31590d3186a2 100644
--- a/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
@@ -25,7 +25,7 @@ memory@80000000 {
 	 * full-duplex SPI transactions are not supported by ASPEED SPI
 	 * Controllers.
 	 */
-	spi_gpio: spi-gpio {
+	spi_gpio: spi {
 		status = "okay";
 		compatible = "spi-gpio";
 		#address-cells = <1>;
-- 
2.34.1

