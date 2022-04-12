Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C138C4FDED6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241027AbiDLMAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353132AbiDLL6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:58:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1720A322
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:50:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g18so11553587ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9g2XKcCurSLwM4uxXLpKaNmYdxIC5rYc/R1Ovh/C4Q=;
        b=MsPcFp8g2+jxEPISknC4oBIMRw92gZ1Xnw+417qeh5KUaMBfVUGAgJF5FP1Q5mnCPG
         XPrG9zZefwghYVkFGBB9q9bX5GutUCK94LvkO+zGwXt6UzqhplKW23iasme/htv19qFe
         67Eou6d839vksWAptEuQnnxUh5aTg/vrZh33kyBJgaA5Ms4eaBulo+JSuaEkB6EB7aGx
         m7I57nukrqmzMlvBQ/ZMhFexxUKvt7dHppR7nf4CBjH4MfnLHqG5e7S3UTw9Y964OTMI
         GyvRxK9LiSWypXqx8UOY7kfopQF8cbyHjVcM+YBbgi7hVOKre2oQVEv5N7KnRl4DqQmo
         ylnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9g2XKcCurSLwM4uxXLpKaNmYdxIC5rYc/R1Ovh/C4Q=;
        b=0oQAu9xFrouZIQfOt1W+isnkIKTeJQmwTuQEYAQ8H2p3bZOXAnqqyskfs2Wpe9t+5l
         17mSf100lKEL9JZYNEkbQ54zUdiUhNApgKJAzM9yCSDJlN98xPoKRser/9LFRfVNZ6D4
         OtD8n4+txpxfuBa4q04QIQ22C9e9SaH/UufSVH4KAP3QRe/z4k08DbqiSjhHhCkJjhdu
         D+QHFLVIIEzSNBE9bSsEvRAKwEmVzjdoBlbad+Anr7+U+2Lz5mnIvmthcxOajyFr6MOO
         C5Fkn1J3Ec2ti89Prop5DnI9wWJvw/T5l13EjYAUbao9pEr4QMUFojfnklzf74qcsWrl
         SMHA==
X-Gm-Message-State: AOAM533YL1at/QSJTxZbDQbwydA3jkhCTC+sBn14SU62pOyQvs63TFjz
        1sjF1gauByUgJQbJCpdyg6h/nQ==
X-Google-Smtp-Source: ABdhPJwrYWIRKK/csZ8RLqJCE/zZWpAOR78ZTsbdZtud66k9OMMLPP5dQ7vp3iXsLtLcQcneAJzJJA==
X-Received: by 2002:a17:907:9958:b0:6e7:f67a:a1e7 with SMTP id kl24-20020a170907995800b006e7f67aa1e7mr32973500ejc.400.1649760615678;
        Tue, 12 Apr 2022 03:50:15 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id v21-20020a1709064e9500b006e8973a14d0sm2099511eju.174.2022.04.12.03.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 03:50:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] ARM: dts: at91: use generic node name for dataflash
Date:   Tue, 12 Apr 2022 12:50:13 +0200
Message-Id: <20220412105013.249793-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

The node names should be generic, so use "flash" for dataflash nodes and
for cfi-flash.

Suggested-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt | 2 +-
 arch/arm/boot/dts/at91rm9200ek.dts                      | 4 ++--
 arch/arm/boot/dts/at91sam9260ek.dts                     | 2 +-
 arch/arm/boot/dts/at91sam9261ek.dts                     | 2 +-
 arch/arm/boot/dts/at91sam9263ek.dts                     | 2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi             | 2 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts                  | 2 +-
 arch/arm/boot/dts/at91sam9rlek.dts                      | 2 +-
 arch/arm/boot/dts/usb_a9263.dts                         | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
index 692300117c64..9d837535637b 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
@@ -54,7 +54,7 @@ flexcom@f8034000 {
 		clock-names = "spi_clk";
 		atmel,fifo-size = <32>;
 
-		mtd_dataflash@0 {
+		flash@0 {
 			compatible = "atmel,at25f512b";
 			reg = <0>;
 			spi-max-frequency = <20000000>;
diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
index e1ef4e44e663..4624a6f076f8 100644
--- a/arch/arm/boot/dts/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -73,7 +73,7 @@ &pinctrl_uart1_dcd
 			spi0: spi@fffe0000 {
 				status = "okay";
 				cs-gpios = <&pioA 3 0>, <0>, <0>, <0>;
-				mtd_dataflash@0 {
+				flash@0 {
 					compatible = "atmel,at45", "atmel,dataflash";
 					spi-max-frequency = <15000000>;
 					reg = <0>;
@@ -94,7 +94,7 @@ usb0: ohci@300000 {
 			status = "okay";
 		};
 
-		nor_flash@10000000 {
+		flash@10000000 {
 			compatible = "cfi-flash";
 			reg = <0x10000000 0x800000>;
 			linux,mtd-name = "physmap-flash.0";
diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/at91sam9260ek.dts
index ce96345d28a3..6381088ba24f 100644
--- a/arch/arm/boot/dts/at91sam9260ek.dts
+++ b/arch/arm/boot/dts/at91sam9260ek.dts
@@ -92,7 +92,7 @@ macb0: ethernet@fffc4000 {
 
 			spi0: spi@fffc8000 {
 				cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;
-				mtd_dataflash@1 {
+				flash@1 {
 					compatible = "atmel,at45", "atmel,dataflash";
 					spi-max-frequency = <50000000>;
 					reg = <1>;
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index beed819609e8..8f11c0b7d76d 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -145,7 +145,7 @@ spi0: spi@fffc8000 {
 				cs-gpios = <&pioA 3 0>, <0>, <&pioA 28 0>, <0>;
 				status = "okay";
 
-				mtd_dataflash@0 {
+				flash@0 {
 					compatible = "atmel,at45", "atmel,dataflash";
 					reg = <0>;
 					spi-max-frequency = <15000000>;
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 71f60576761a..42e734020235 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -95,7 +95,7 @@ pinctrl_board_mmc0: mmc0-board {
 			spi0: spi@fffa4000 {
 				status = "okay";
 				cs-gpios = <&pioA 5 0>, <0>, <0>, <0>;
-				mtd_dataflash@0 {
+				flash@0 {
 					compatible = "atmel,at45", "atmel,dataflash";
 					spi-max-frequency = <50000000>;
 					reg = <0>;
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 87bb39060e8b..74b90dc58cbf 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -110,7 +110,7 @@ ssc0: ssc@fffbc000 {
 
 			spi0: spi@fffc8000 {
 				cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;
-				mtd_dataflash@1 {
+				flash@1 {
 					compatible = "atmel,at45", "atmel,dataflash";
 					spi-max-frequency = <50000000>;
 					reg = <1>;
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index b6256a20fbc7..e5db198a87a8 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -167,7 +167,7 @@ pinctrl_pwm_leds: pwm-led {
 			spi0: spi@fffa4000{
 				status = "okay";
 				cs-gpios = <&pioB 3 0>, <0>, <0>, <0>;
-				mtd_dataflash@0 {
+				flash@0 {
 					compatible = "atmel,at45", "atmel,dataflash";
 					spi-max-frequency = <13000000>;
 					reg = <0>;
diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
index 62981b39c815..d74b8d9d84aa 100644
--- a/arch/arm/boot/dts/at91sam9rlek.dts
+++ b/arch/arm/boot/dts/at91sam9rlek.dts
@@ -180,7 +180,7 @@ usb0: gadget@fffd4000 {
 			spi0: spi@fffcc000 {
 				status = "okay";
 				cs-gpios = <&pioA 28 0>, <0>, <0>, <0>;
-				mtd_dataflash@0 {
+				flash@0 {
 					compatible = "atmel,at45", "atmel,dataflash";
 					spi-max-frequency = <15000000>;
 					reg = <0>;
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index 8a0cfbfd0c45..b6cb9cdf8197 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -60,7 +60,7 @@ usb1: gadget@fff78000 {
 			spi0: spi@fffa4000 {
 				cs-gpios = <&pioB 15 GPIO_ACTIVE_HIGH>;
 				status = "okay";
-				mtd_dataflash@0 {
+				flash@0 {
 					compatible = "atmel,at45", "atmel,dataflash";
 					reg = <0>;
 					spi-max-frequency = <15000000>;
-- 
2.32.0

