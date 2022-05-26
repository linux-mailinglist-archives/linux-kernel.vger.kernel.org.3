Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CBF5350D6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347705AbiEZOhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347665AbiEZOhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:37:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A578CEBB1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:37:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id q15so2043132edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EvQNX3D7qOPXalVBRGNjE8WEf+NnKbp5zSzWzGj2YZY=;
        b=yZr8gWynMDhSjkkCEIuAsSrQF8xeDV6asGZdz3oE8hORHS4s8ma39Y6WDVu9CzViCf
         /+YY8CjmknDW+o7be8JlrJHcwTiamRUa2OJJV5KQHyzKgFSNjHVUsrugKANeCsorApc1
         HzQHaxvxElKwkdzj/rJVetlcoZX4PPz7Sd8ejoQh6WS9D8FhqM96M+J0Ge6AzsZd9vhC
         Hk9KySGQpJAVaVYSk4QkndDUEoFhOhPxF/eFPZ4gKAYpajk0XVoMUCMbO8KgJUgoXwwn
         HEK32e6l6wdFGe0/R6iS1rBOlx4CeOpkQCvBBkMl3ZsegB/OacOnrMcESpziGuSa4wOx
         sy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EvQNX3D7qOPXalVBRGNjE8WEf+NnKbp5zSzWzGj2YZY=;
        b=rPDfZXY55bFk4CCnUImCXvY/OOROZJSNBoTLsWlKY2b7/t/WBYvTAYcip14VvFfHnT
         5nADsakbcQI9aabdeYGwc9BSNlhbv03BhCeOJz4IuS2Agxic9pX9CK47WvmR9kApcgpW
         ler4nft8/xwSOuNhGVsUGIzHN6WU5Ayqqg+7iwqaxzE5Gh1+K4QWYNavEgJoPJPCAPNv
         p3Rsi00HnIUtbASGKoE5D+ImoxpB4MYX8CRJAziUtmE0nbG/pEXW0A+93lgpN9LNNdsq
         sKiQQWeti8LaoFrt1XybyYH5+WlyEoz40Xv9ftS3w+PXS80n9RggVfPMCOl+pd+VIhMe
         Z/9Q==
X-Gm-Message-State: AOAM532YdcWgh+6VM9J0/rpiqB+3sdBQp/YYdFdld4JRqqLJrdr7N0Jj
        w0d1A96WbOVchwmnnF7BeT98kA==
X-Google-Smtp-Source: ABdhPJw0n6VhLZu4xtJwtjXwJnEnEBdNERczo1chysUtqzZArYKojmX25sEBMJCydqEo6wsuidPTuw==
X-Received: by 2002:aa7:c683:0:b0:42a:b2cc:b345 with SMTP id n3-20020aa7c683000000b0042ab2ccb345mr39786124edq.282.1653575844574;
        Thu, 26 May 2022 07:37:24 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f27-20020a50a6db000000b0042be2dfa8bdsm267962edc.81.2022.05.26.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:37:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/7] ARM: dts: s5pv210: use local header for pinctrl register values
Date:   Thu, 26 May 2022 16:37:03 +0200
Message-Id: <20220526143707.767490-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526143707.767490-1-krzysztof.kozlowski@linaro.org>
References: <20220526143707.767490-1-krzysztof.kozlowski@linaro.org>
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

The DTS uses hardware register values directly in pin controller pin
configuration.  These are not some IDs or other abstraction layer but
raw numbers used in the registers.

These numbers were previously put in the bindings header to avoid code
duplication and to provide some context meaning (name), but they do not
fit the purpose of bindings.  It is also quite confusing to use
constants prefixed with Exynos for other SoC, because there is actually
nothing here in common, except the actual value.

Store the constants in a header next to DTS and use them instead of
bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/s5pv210-aquila.dts      |   4 +-
 arch/arm/boot/dts/s5pv210-aries.dtsi      | 134 +++---
 arch/arm/boot/dts/s5pv210-fascinate4g.dts |  22 +-
 arch/arm/boot/dts/s5pv210-galaxys.dts     |  34 +-
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi    | 480 +++++++++++-----------
 arch/arm/boot/dts/s5pv210-pinctrl.h       |  39 ++
 6 files changed, 376 insertions(+), 337 deletions(-)
 create mode 100644 arch/arm/boot/dts/s5pv210-pinctrl.h

diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
index bc0b7354b6c0..0f5c6cd0f3a1 100644
--- a/arch/arm/boot/dts/s5pv210-aquila.dts
+++ b/arch/arm/boot/dts/s5pv210-aquila.dts
@@ -392,7 +392,7 @@ timing0: timing {
 &pinctrl0 {
 	t_flash_detect: t-flash-detect-pins {
 		samsung,pins = "gph3-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
 	};
 };
diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index daa1067055c8..5541df4df628 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -646,183 +646,183 @@ &mfc {
 &pinctrl0 {
 	bt_reset: bt-reset-pins {
 		samsung,pins = "gpb-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	wlan_bt_en: wlan-bt-en-pins {
 		samsung,pins = "gpb-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
 		samsung,pin-val = <1>;
 	};
 
 	codec_ldo: codec-ldo-pins {
 		samsung,pins = "gpf3-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
 	};
 
 	prox_i2c_pins: gp2a-i2c-pins {
 		samsung,pins = "gpg0-2", "gpg2-2";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	wlan_gpio_rst: wlan-gpio-rst-pins {
 		samsung,pins = "gpg1-2";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
 	};
 
 	bt_wake: bt-wake-pins {
 		samsung,pins = "gpg3-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
 	};
 
 	gp2a_irq: gp2a-irq-pins {
 		samsung,pins = "gph0-2";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_F>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_DOWN>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	pmic_dvs_pins: pmic-dvs-pins {
 		samsung,pins = "gph0-3", "gph0-4", "gph0-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 		samsung,pin-val = <0>;
 	};
 
 	pmic_irq: pmic-irq-pins {
 		samsung,pins = "gph0-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_F>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	wifi_host_wake: wifi-host-wake-pins {
 		samsung,pins = "gph2-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_DOWN>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	bt_host_wake: bt-host-wake-pins {
 		samsung,pins = "gph2-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_DOWN>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	musb_irq: musq-irq-pins {
 		samsung,pins = "gph2-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	tf_detect: tf-detect-pins {
 		samsung,pins = "gph3-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_DOWN>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	wifi_wake: wifi-wake-pins {
 		samsung,pins = "gph3-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
 	};
 
 	magnetometer_i2c_pins: yas529-i2c-pins-pins {
 		samsung,pins = "gpj0-0", "gpj0-1";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	ts_irq: ts-irq-pins {
 		samsung,pins = "gpj0-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	vibrator_ena: vibrator-ena-pins {
 		samsung,pins = "gpj1-1";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	gp2a_power: gp2a-power-pins {
 		samsung,pins = "gpj1-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	touchkey_i2c_pins: touchkey-i2c-pins {
 		samsung,pins = "gpj3-0", "gpj3-1";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	touchkey_vdd_ena: touchkey-vdd-ena-pins {
 		samsung,pins = "gpj3-2";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	musb_i2c_pins: musb-i2c-pins {
 		samsung,pins = "gpj3-4", "gpj3-5";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	accel_i2c_pins: accel-i2c-pins {
 		samsung,pins = "gpj3-6", "gpj3-7";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	pmic_i2c_pins: pmic-i2c-pins-pins {
 		samsung,pins = "gpj4-0", "gpj4-3";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	touchkey_irq: touchkey-irq-pins {
 		samsung,pins = "gpj4-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	lcd_spi_pins: spi-lcd-pins {
 		samsung,pins = "mp01-1", "mp04-1", "mp04-3";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	fg_i2c_pins: fg-i2c-pins {
 		samsung,pins = "mp05-0", "mp05-1";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	sound_i2c_pins: sound-i2c-pins {
 		samsung,pins = "mp05-2", "mp05-3";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	panel_rst: panel-rst-pins {
 		samsung,pins = "mp05-5";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
index dfb2ee65e4a8..eae51b197ee9 100644
--- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
+++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
@@ -128,33 +128,33 @@ &pinctrl0 {
 
 	headset_det: headset-det-pins {
 		samsung,pins = "gph0-6", "gph3-6";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_F>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
 	};
 
 	fg_irq: fg-irq-pins {
 		samsung,pins = "gph3-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_F>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	headset_micbias_ena: headset-micbias-ena-pins {
 		samsung,pins = "gpj2-5";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	earpath_sel: earpath-sel-pins {
 		samsung,pins = "gpj2-6";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	main_micbias_ena: main-micbias-ena-pins {
 		samsung,pins = "gpj4-2";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	/* Based on vendor kernel v2.6.35.7 */
diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
index a78caaa1f3c5..aaf880792f36 100644
--- a/arch/arm/boot/dts/s5pv210-galaxys.dts
+++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
@@ -152,47 +152,47 @@ &pinctrl0 {
 
 	fm_i2c_pins: fm-i2c-pins-pins {
 		samsung,pins = "gpd1-2", "gpd1-3";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	headset_det: headset-det-pins {
 		samsung,pins = "gph0-6", "gph3-6";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_F>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
 	};
 
 	fm_irq: fm-irq-pins {
 		samsung,pins = "gpj2-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	fm_rst: fm-rst-pins {
 		samsung,pins = "gpj2-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	earpath_sel: earpath-sel-pins {
 		samsung,pins = "gpj2-6";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	massmemory_en: massmemory-en-pins {
 		samsung,pins = "gpj2-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	micbias_reg_ena: micbias-reg-ena-pins {
 		samsung,pins = "gpj4-2";
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	/* Based on CyanogenMod 3.0.101 kernel */
diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
index ae34e7e57892..6d6daef9fb7a 100644
--- a/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.dtsi
@@ -16,13 +16,13 @@
  * nodes can be added to this file.
  */
 
-#include <dt-bindings/pinctrl/samsung.h>
+#include "s5pv210-pinctrl.h"
 
 #define PIN_SLP(_pin, _mode, _pull)					\
 	_pin {								\
 		samsung,pins = #_pin;					\
-		samsung,pin-con-pdn = <EXYNOS_PIN_PDN_ ##_mode>;	\
-		samsung,pin-pud-pdn = <S3C64XX_PIN_PULL_ ##_pull>;	\
+		samsung,pin-con-pdn = <S5PV210_PIN_PDN_ ##_mode>;	\
+		samsung,pin-pud-pdn = <S5PV210_PIN_PULL_ ##_pull>;	\
 	}
 
 &pinctrl0 {
@@ -280,559 +280,559 @@ gph3: gph3-gpio-bank {
 
 	uart0_data: uart0-data-pins {
 		samsung,pins = "gpa0-0", "gpa0-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	uart0_fctl: uart0-fctl-pins {
 		samsung,pins = "gpa0-2", "gpa0-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	uart1_data: uart1-data-pins {
 		samsung,pins = "gpa0-4", "gpa0-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	uart1_fctl: uart1-fctl-pins {
 		samsung,pins = "gpa0-6", "gpa0-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	uart2_data: uart2-data-pins {
 		samsung,pins = "gpa1-0", "gpa1-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	uart2_fctl: uart2-fctl-pins {
 		samsung,pins = "gpa1-2", "gpa1-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	uart3_data: uart3-data-pins {
 		samsung,pins = "gpa1-2", "gpa1-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	uart_audio: uart-audio-pins {
 		samsung,pins = "gpa1-2", "gpa1-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_4>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpb-0", "gpb-2", "gpb-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpb-4", "gpb-6", "gpb-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	i2s0_bus: i2s0-bus-pins {
 		samsung,pins = "gpi-0", "gpi-1", "gpi-2", "gpi-3",
 				"gpi-4", "gpi-5", "gpi-6";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	i2s1_bus: i2s1-bus-pins {
 		samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 				"gpc0-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	i2s2_bus: i2s2-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_4>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	pcm1_bus: pcm1-bus-pins {
 		samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 				"gpc0-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	ac97_bus: ac97-bus-pins {
 		samsung,pins = "gpc0-0", "gpc0-1", "gpc0-2", "gpc0-3",
 				"gpc0-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_4>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	i2s2_bus: i2s2-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	pcm2_bus: pcm2-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	spdif_bus: spdif-bus-pins {
 		samsung,pins = "gpc1-0", "gpc1-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_4>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	spi2_bus: spi2-bus-pins {
 		samsung,pins = "gpc1-1", "gpc1-2", "gpc1-3", "gpc1-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_5>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_5>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	i2c0_bus: i2c0-bus-pins {
 		samsung,pins = "gpd1-0", "gpd1-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	i2c1_bus: i2c1-bus-pins {
 		samsung,pins = "gpd1-2", "gpd1-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	i2c2_bus: i2c2-bus-pins {
 		samsung,pins = "gpd1-4", "gpd1-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	pwm0_out: pwm0-out-pins {
 		samsung,pins = "gpd0-0";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	pwm1_out: pwm1-out-pins {
 		samsung,pins = "gpd0-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	pwm2_out: pwm2-out-pins {
 		samsung,pins = "gpd0-2";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	pwm3_out: pwm3-out-pins {
 		samsung,pins = "gpd0-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_row0: keypad-row-0-pins {
 		samsung,pins = "gph3-0";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_row1: keypad-row-1-pins {
 		samsung,pins = "gph3-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_row2: keypad-row-2-pins {
 		samsung,pins = "gph3-2";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_row3: keypad-row-3-pins {
 		samsung,pins = "gph3-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_row4: keypad-row-4-pins {
 		samsung,pins = "gph3-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_row5: keypad-row-5-pins {
 		samsung,pins = "gph3-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_row6: keypad-row-6-pins {
 		samsung,pins = "gph3-6";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_row7: keypad-row-7-pins {
 		samsung,pins = "gph3-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_col0: keypad-col-0-pins {
 		samsung,pins = "gph2-0";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_col1: keypad-col-1-pins {
 		samsung,pins = "gph2-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_col2: keypad-col-2-pins {
 		samsung,pins = "gph2-2";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_col3: keypad-col-3-pins {
 		samsung,pins = "gph2-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_col4: keypad-col-4-pins {
 		samsung,pins = "gph2-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_col5: keypad-col-5-pins {
 		samsung,pins = "gph2-5";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_col6: keypad-col-6-pins {
 		samsung,pins = "gph2-6";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	keypad_col7: keypad-col-7-pins {
 		samsung,pins = "gph2-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	sd0_clk: sd0-clk-pins {
 		samsung,pins = "gpg0-0";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd0_cmd: sd0-cmd-pins {
 		samsung,pins = "gpg0-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd0_cd: sd0-cd-pins {
 		samsung,pins = "gpg0-2";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd0_bus1: sd0-bus-width1-pins {
 		samsung,pins = "gpg0-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd0_bus4: sd0-bus-width4-pins {
 		samsung,pins = "gpg0-3", "gpg0-4", "gpg0-5", "gpg0-6";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd0_bus8: sd0-bus-width8-pins {
 		samsung,pins = "gpg1-3", "gpg1-4", "gpg1-5", "gpg1-6";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd1_clk: sd1-clk-pins {
 		samsung,pins = "gpg1-0";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd1_cmd: sd1-cmd-pins {
 		samsung,pins = "gpg1-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd1_cd: sd1-cd-pins {
 		samsung,pins = "gpg1-2";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd1_bus1: sd1-bus-width1-pins {
 		samsung,pins = "gpg1-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd1_bus4: sd1-bus-width4-pins {
 		samsung,pins = "gpg1-3", "gpg1-4", "gpg1-5", "gpg1-6";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd2_clk: sd2-clk-pins {
 		samsung,pins = "gpg2-0";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd2_cmd: sd2-cmd-pins {
 		samsung,pins = "gpg2-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd2_cd: sd2-cd-pins {
 		samsung,pins = "gpg2-2";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd2_bus1: sd2-bus-width1-pins {
 		samsung,pins = "gpg2-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd2_bus4: sd2-bus-width4-pins {
 		samsung,pins = "gpg2-3", "gpg2-4", "gpg2-5", "gpg2-6";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd2_bus8: sd2-bus-width8-pins {
 		samsung,pins = "gpg3-3", "gpg3-4", "gpg3-5", "gpg3-6";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd3_clk: sd3-clk-pins {
 		samsung,pins = "gpg3-0";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd3_cmd: sd3-cmd-pins {
 		samsung,pins = "gpg3-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd3_cd: sd3-cd-pins {
 		samsung,pins = "gpg3-2";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd3_bus1: sd3-bus-width1-pins {
 		samsung,pins = "gpg3-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	sd3_bus4: sd3-bus-width4-pins {
 		samsung,pins = "gpg3-3", "gpg3-4", "gpg3-5", "gpg3-6";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_UP>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_UP>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	eint0: ext-int0-pins {
 		samsung,pins = "gph0-0";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_F>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	eint8: ext-int8-pins {
 		samsung,pins = "gph1-0";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_F>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	eint15: ext-int15-pins {
 		samsung,pins = "gph1-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_F>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	eint16: ext-int16-pins {
 		samsung,pins = "gph2-0";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_F>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	eint31: ext-int31-pins {
 		samsung,pins = "gph3-7";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_F>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	cam_port_a_io: cam-port-a-io-pins {
 		samsung,pins = "gpe0-0", "gpe0-1", "gpe0-2", "gpe0-3",
 				"gpe0-4", "gpe0-5", "gpe0-6", "gpe0-7",
 				"gpe1-0", "gpe1-1", "gpe1-2", "gpe1-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	cam_port_a_clk_active: cam-port-a-clk-active-pins {
 		samsung,pins = "gpe1-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	cam_port_a_clk_idle: cam-port-a-clk-idle-pins {
 		samsung,pins = "gpe1-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_DOWN>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	cam_port_b_io: cam-port-b-io-pins {
 		samsung,pins = "gpj0-0", "gpj0-1", "gpj0-2", "gpj0-3",
 				"gpj0-4", "gpj0-5", "gpj0-6", "gpj0-7",
 				"gpj1-0", "gpj1-1", "gpj1-2", "gpj1-4";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	cam_port_b_clk_active: cam-port-b-clk-active-pins {
 		samsung,pins = "gpj1-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV4>;
 	};
 
 	cam_port_b_clk_idle: cam-port-b-clk-idle-pins {
 		samsung,pins = "gpj1-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_DOWN>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	lcd_ctrl: lcd-ctrl-pins {
 		samsung,pins = "gpd0-0", "gpd0-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_3>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	lcd_sync: lcd-sync-pins {
 		samsung,pins = "gpf0-0", "gpf0-1";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	lcd_clk: lcd-clk-pins {
 		samsung,pins = "gpf0-0", "gpf0-1", "gpf0-2", "gpf0-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 
 	lcd_data24: lcd-data-width24-pins {
@@ -842,8 +842,8 @@ lcd_data24: lcd-data-width24-pins {
 				"gpf2-0", "gpf2-1", "gpf2-2", "gpf2-3",
 				"gpf2-4", "gpf2-5", "gpf2-6", "gpf2-7",
 				"gpf3-0", "gpf3-1", "gpf3-2", "gpf3-3";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
-		samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+		samsung,pin-function = <S5PV210_PIN_FUNC_2>;
+		samsung,pin-pud = <S5PV210_PIN_PULL_NONE>;
+		samsung,pin-drv = <S5PV210_PIN_DRV_LV1>;
 	};
 };
diff --git a/arch/arm/boot/dts/s5pv210-pinctrl.h b/arch/arm/boot/dts/s5pv210-pinctrl.h
new file mode 100644
index 000000000000..2b067bcdca60
--- /dev/null
+++ b/arch/arm/boot/dts/s5pv210-pinctrl.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Samsung's Exynos pinctrl bindings
+ *
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2022 Linaro Ltd
+ * Author: Krzysztof Kozlowski <krzk@kernel.org>
+ */
+
+#ifndef __DTS_ARM_SAMSUNG_S5PV210_PINCTRL_H__
+#define __DTS_ARM_SAMSUNG_S5PV210_PINCTRL_H__
+
+#define S5PV210_PIN_PULL_NONE		0
+#define S5PV210_PIN_PULL_DOWN		1
+#define S5PV210_PIN_PULL_UP		2
+
+/* Pin function in power down mode */
+#define S5PV210_PIN_PDN_OUT0		0
+#define S5PV210_PIN_PDN_OUT1		1
+#define S5PV210_PIN_PDN_INPUT		2
+#define S5PV210_PIN_PDN_PREV		3
+
+#define S5PV210_PIN_DRV_LV1		0
+#define S5PV210_PIN_DRV_LV2		2
+#define S5PV210_PIN_DRV_LV3		1
+#define S5PV210_PIN_DRV_LV4		3
+
+#define S5PV210_PIN_FUNC_INPUT		0
+#define S5PV210_PIN_FUNC_OUTPUT		1
+#define S5PV210_PIN_FUNC_2		2
+#define S5PV210_PIN_FUNC_3		3
+#define S5PV210_PIN_FUNC_4		4
+#define S5PV210_PIN_FUNC_5		5
+#define S5PV210_PIN_FUNC_6		6
+#define S5PV210_PIN_FUNC_EINT		0xf
+#define S5PV210_PIN_FUNC_F		S5PV210_PIN_FUNC_EINT
+
+#endif /* __DTS_ARM_SAMSUNG_S5PV210_PINCTRL_H__ */
-- 
2.34.1

