Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCA1528E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345723AbiEPTkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345714AbiEPTjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:39:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F6F3FD9B;
        Mon, 16 May 2022 12:39:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i27so30583089ejd.9;
        Mon, 16 May 2022 12:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zJNYDk4SvD1YtpXR0oj8NsF6HENGwzWTt8Lj8cCkpNo=;
        b=GfpaCn3LMRvcWxUW26o8K7i1OgF9OOlb+NMttVfSDfnGCO1x92FO4XgTiW/aE8cK/a
         6EPLXmEh5UIZPGY4T7AjjkJSyPvSKwZzGg/WsQlcpdF+aQT1oaX15KSys6jajMRl4daE
         Dkb/qDAMY2pyPHhL0AS/NHTNs9O4/rHbQSL9QWD2/uXlhfBPY67M6Fvrt62I4p3t1z6t
         3MrdJV2MYZJtHqV7xx+vuMYj9PN+WgalQiRsAqj4e6Ge0FxL2FgyQ+gqB7U1FYmflxs8
         wEL79+0JU40DzFh9awCDRLt/FOmSQs2etsHFSNeG/jjYqyz448nzVYV/ZhAsL9/nmz7/
         UluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zJNYDk4SvD1YtpXR0oj8NsF6HENGwzWTt8Lj8cCkpNo=;
        b=jFRuY6sNOGRrg/d8eDCTF+tXeu0taDfaIpAYvS/9Y8QsWHnPXSat2/MUOK72N+EUoA
         ed3wb8/yum3A68vrE6IIo/LmlUeMoT5P14YpNZ+n0ShKI1gnr4yWD3xJiTLC/dwVZQD5
         sXVJtkS1gDU/MNmzKbD8r1VRoOg7LQ+ZNoI+Z+Nl3F1/gvripsXJMYBfmw7zHHhTd2tB
         UgfcR5up1hzZ9gwpcKaU8agb8TEM+MnAylUoHqj+LWf+tX1XhJJu8g1VQI9qLG/53o12
         GEkrnRpVp5HsrjalTUy1wOYqct3/slxFfTQ3AHB6YVTCibotWXObIuyiUfTVUOrlqYf2
         msFA==
X-Gm-Message-State: AOAM533y0p6FWxLjt73o19SuIY3kuVhjmshF2eSHwl/TBYdOXyyl551w
        3mc/xJNEih4VKyvJ0A3R0Y0=
X-Google-Smtp-Source: ABdhPJxoPobHPfYM65bQ9gkqOcRe7+3noo9i4Ud/hXXldy2+MIeYBuZ0nPEvonOeOo7whoyTzmPsMg==
X-Received: by 2002:a17:907:6d25:b0:6f4:d753:f250 with SMTP id sa37-20020a1709076d2500b006f4d753f250mr16485319ejc.580.1652729950114;
        Mon, 16 May 2022 12:39:10 -0700 (PDT)
Received: from adroid (102-167-184-091.ip-addr.vsenet.de. [91.184.167.102])
        by smtp.gmail.com with ESMTPSA id d3-20020a170907272300b006f3ef214e6fsm85180ejl.213.2022.05.16.12.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 12:39:09 -0700 (PDT)
From:   =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
To:     linux-samsung-soc@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
Subject: [PATCH 3/3] ARM: dts: exynos: add panel and backlight to p4note
Date:   Mon, 16 May 2022 21:37:09 +0200
Message-Id: <20220516193709.10037-3-martin.juecker@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516193709.10037-1-martin.juecker@gmail.com>
References: <20220516193709.10037-1-martin.juecker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add configuration for the LTL101AL01 panel and a pwm backlight to drive
the display in the p4note devices.

Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
---
 arch/arm/boot/dts/exynos4412-p4note.dtsi | 84 ++++++++++++++++++++----
 1 file changed, 71 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index 97f131b1014b..1fd051b52387 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -106,6 +106,16 @@ voltage-regulator-3 {
 		regulator-always-on;
 	};
 
+	panel_vdd: voltage-regulator-4 {
+		compatible = "regulator-fixed";
+		regulator-name = "LCD_ENABLE";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_enable>;
+		gpios = <&gpc0 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+
 	wlan_pwrseq: sdhci3-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpm3 5 GPIO_ACTIVE_LOW>;
@@ -216,6 +226,32 @@ power_supply: charger@6 {
 			monitored-battery = <&battery_cell>;
 		};
 	};
+
+	panel {
+		compatible = "samsung,ltl101al01";
+		pinctrl-0 = <&lvds_nshdn>;
+		pinctrl-names = "default";
+		power-supply = <&panel_vdd>;
+		enable-gpios = <&gpm0 5 GPIO_ACTIVE_HIGH>;
+		backlight = <&backlight>;
+
+		port {
+			lcd_ep: endpoint {
+				remote-endpoint = <&fimd_ep>;
+			};
+		};
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pinctrl-0 = <&led_bl_reset>;
+		pinctrl-names = "default";
+		enable-gpios = <&gpm0 1 GPIO_ACTIVE_HIGH>;
+		pwms = <&pwm 1 78770 0>;
+		brightness-levels = <0 48 128 255>;
+		num-interpolated-steps = <8>;
+		default-brightness-level = <12>;
+	};
 };
 
 &adc {
@@ -295,22 +331,19 @@ &exynos_usbphy {
 };
 
 &fimd {
-	pinctrl-0 = <&lcd_clk &lcd_data24 &pwm1_out>;
+	pinctrl-0 = <&lcd_clk &lcd_data24>;
 	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 
-	display-timings {
-		timing0 {
-			clock-frequency = <66666666>;
-			hactive = <1280>;
-			vactive = <800>;
-			hfront-porch = <18>;
-			hback-porch = <36>;
-			hsync-len = <16>;
-			vback-porch = <16>;
-			vfront-porch = <4>;
-			vsync-len = <3>;
-			hsync-active = <1>;
+	samsung,invert-vclk;
+
+	port@3 {
+		reg = <3>;
+
+		fimd_ep: endpoint {
+			remote-endpoint = <&lcd_ep>;
 		};
 	};
 };
@@ -687,6 +720,12 @@ tsp_reg_gpio_3: tsp-reg-gpio-3-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
+	lcd_enable: lcd-enable-pins {
+		samsung,pins = "gpc0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	sleep0: sleep-state {
 		PIN_SLP(gpa0-0, INPUT, NONE);
 		PIN_SLP(gpa0-1, OUT0, NONE);
@@ -809,12 +848,24 @@ uart_sel: uart-sel-pins {
 		/* 0 = CP, 1 = AP (serial output) */
 	};
 
+	led_bl_reset: led-bl-reset-pins {
+		samsung,pins = "gpm0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	tsp_rst: tsp-rst-pins {
 		samsung,pins = "gpm0-4";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 	};
 
+	lvds_nshdn: lvds-nshdn-pins {
+		samsung,pins = "gpm0-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	tsp_irq: tsp-irq-pins {
 		samsung,pins = "gpm2-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
@@ -1100,6 +1151,13 @@ &pmu_system_controller {
 	assigned-clock-parents = <&clock CLK_XUSBXTI>;
 };
 
+&pwm {
+	pinctrl-0 = <&pwm1_out>;
+	pinctrl-names = "default";
+	samsung,pwm-outputs = <1>;
+	status = "okay";
+};
+
 &rtc {
 	clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
 	clock-names = "rtc", "rtc_src";
-- 
2.25.1

