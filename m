Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FCD471684
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhLKVPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbhLKVOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5BBC0617A1;
        Sat, 11 Dec 2021 13:14:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id l22so24096210lfg.7;
        Sat, 11 Dec 2021 13:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LxduZpJoyVdx6ynOcxqDsbmHB9lTw4ewpjBxLWfMaWc=;
        b=jG9HbjrUPa5i8TjDM5OLDJmgY89p694ObP/P8hOrVCnO+Fo3asCdqbdyaIJWUBHyZ7
         KG8DON9DVx0h9h8i3EvbzbVgB4KIiI6rYHCODqe8si8njTQYFjanCBdHVkoNrC6K811m
         SedXGXb+54nnNmHhiqtz1Ewiv3st9lsGqbfkTIyoPy8TgxT/I62E75z00j9lEsE/83eO
         /9cTTo+q5PYK1dnCPq40goB7aJuprPu0pZLkuD31naTZqt8x2CmhKtFvvLZbn6G6dRzM
         481mvixS4sJufrpv+ceKsvi1Di9Mo/ddlH9TrBHOYP+idBzwF5yfcDRWpVpSP7a13D7G
         ki+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxduZpJoyVdx6ynOcxqDsbmHB9lTw4ewpjBxLWfMaWc=;
        b=k+x8g2g92zHp3IfOhKqu3r6efxlss+wm568fOvzuyqmKMHZjhCLpB70/6NiBMADer4
         OQSqbtyRYIKW7V8qy8DOZzGNDHAoq05FO6F8fyfyfHkmyQTtzu/cXZ70xZvXf4FCJ/fp
         ChW2hoaoPSASPyWcYvsRNhTRR6Cfj/76HsLufXwU4QdIN93l6DBLT3AmsF0qNQwzSy8G
         Py19vRFyewm7XCLIi1IkWeGX35y3UofjjSSRjKMRO50DuClyD6JP9HlW6dM+f0Uup4UL
         Re9dsRv05suYJfBhlHYJDPyk+ojzDrnX632LVwczI2kfDcx9f3IXCfm/ABxbTZd35Shz
         uK0Q==
X-Gm-Message-State: AOAM531pnnIH5/pxQl033wEhPMXmVGS+6BigFm4Fg/7YIZJvj9CfnJXh
        sfd0ye6WJ4wDwnn3S1/gnno=
X-Google-Smtp-Source: ABdhPJxvXZaa+hs/qx2SBknTkj4MR65JFop//b2LuHLZN7Xn51J2xZi3x56PSSsFWeFn0KoHsDPomA==
X-Received: by 2002:ac2:46c8:: with SMTP id p8mr19780737lfo.174.1639257273662;
        Sat, 11 Dec 2021 13:14:33 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:33 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Anton Bambura <jenneron@protonmail.com>,
        Antoni Aloy Torrens <aaloytorrens@gmail.com>,
        Nikola Milosavljevic <mnidza@outlook.com>,
        Ion Agorria <ion@agorria.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/28] ARM: tegra: Add device-tree for ASUS Transformer Pad TF701T
Date:   Sun, 12 Dec 2021 00:13:56 +0300
Message-Id: <20211211211412.10791-13-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Bambura <jenneron@protonmail.com>

Add device-tree for Tegra114-based ASUS Transformer Pad TF701T (K00C)
tablet.

Link: https://wiki.postmarketos.org/wiki/ASUS_Transformer_Pad_(TF701T)_(asus-tf701t)
Signed-off-by: Anton Bambura <jenneron@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/tegra114-asus-tf701t.dts | 788 +++++++++++++++++++++
 2 files changed, 789 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra114-asus-tf701t.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 87166d66e0b1..e59e7973990d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1331,6 +1331,7 @@ dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += \
 	tegra30-colibri-eval-v3.dtb \
 	tegra30-ouya.dtb
 dtb-$(CONFIG_ARCH_TEGRA_114_SOC) += \
+	tegra114-asus-tf701t.dtb \
 	tegra114-dalmore.dtb \
 	tegra114-roth.dtb \
 	tegra114-tn7.dtb
diff --git a/arch/arm/boot/dts/tegra114-asus-tf701t.dts b/arch/arm/boot/dts/tegra114-asus-tf701t.dts
new file mode 100644
index 000000000000..3026a869de63
--- /dev/null
+++ b/arch/arm/boot/dts/tegra114-asus-tf701t.dts
@@ -0,0 +1,788 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/input/input.h>
+
+#include "tegra114.dtsi"
+
+/ {
+	model = "Asus Transformer Pad TF701T";
+	compatible = "asus,tf701t", "nvidia,tegra114";
+	chassis-type = "convertible";
+
+	aliases {
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc3; /* uSD slot */
+		mmc2 = &sdmmc1; /* WiFi */
+
+		rtc0 = &palmas;
+		rtc1 = &tegra_rtc;
+
+		serial0 = &uartd; /* Console */
+		serial1 = &uartc; /* Bluetooth */
+		serial2 = &uartb; /* GPS */
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,cma@80000000 {
+			compatible = "shared-dma-pool";
+			alloc-ranges = <0x80000000 0x30000000>;
+			size = <0x10000000>;
+			linux,cma-default;
+			reusable;
+		};
+
+		trustzone@bfe00000 {
+			reg = <0xbfe00000 0x200000>;
+			no-map;
+		};
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+
+		enable-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
+		power-supply = <&vdd_5v0_sys>;
+		pwms = <&pwm 1 1000000>;
+
+		brightness-levels = <1 255>;
+		num-interpolated-steps = <254>;
+		default-brightness-level = <224>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&backlight_default>;
+	};
+
+	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
+	clk32k_in: clock-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "pmic-oscillator";
+	};
+
+	firmware {
+		trusted-foundations {
+			compatible = "tlm,trusted-foundations";
+			tlm,version-major = <2>;
+			tlm,version-minor = <8>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		label = "GPIO Buttons";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_default>;
+
+		power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			debounce-interval = <10>;
+			wakeup-source;
+		};
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <10>;
+		};
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(R, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <10>;
+		};
+	};
+
+	gpio-hall-sensor {
+		compatible = "gpio-keys";
+
+		label = "GPIO Hall Effect Sensor";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_hall_sensor_default>;
+
+		hall-sensor {
+			label = "Hall Effect Sensor";
+			gpios = <&gpio TEGRA_GPIO(O, 5) GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	sound {
+		compatible = "asus,tegra-audio-rt5639-tf701t",
+			     "nvidia,tegra-audio-rt5640";
+		nvidia,model = "Asus Transformer Pad TF701T RT5639";
+
+		nvidia,audio-routing =
+			"Headphones", "HPOR",
+			"Headphones", "HPOL",
+			"Speakers", "SPORP",
+			"Speakers", "SPORN",
+			"Speakers", "SPOLP",
+			"Speakers", "SPOLN",
+			"Mic Jack", "MICBIAS1",
+			"IN2P", "Mic Jack";
+
+		nvidia,i2s-controller = <&tegra_i2s0>;
+		nvidia,audio-codec = <&rt5639>;
+
+		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(R, 7) GPIO_ACTIVE_LOW>;
+
+		clocks = <&tegra_car TEGRA114_CLK_PLL_A>,
+			 <&tegra_car TEGRA114_CLK_PLL_A_OUT0>,
+			 <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA114_CLK_EXTERN1>,
+				  <&tegra_pmc TEGRA_PMC_CLK_OUT_1>;
+
+		assigned-clock-parents = <&tegra_car TEGRA114_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA114_CLK_EXTERN1>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_det_default>;
+	};
+
+	vdd_5v0_sys: regulator-5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_3v3_sys: regulator-3v3-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_lcd: regulator-vdd-lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_lcd_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&tps65913_smps8>;
+		enable-active-high;
+		gpio = <&gpio TEGRA_GPIO(CC, 4) GPIO_ACTIVE_HIGH>;
+		regulator-boot-on;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_lcd_default>;
+	};
+
+	vdd_usd: regulator-vdd-usd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_sd_slot";
+		regulator-min-microvolt = <2900000>;
+		regulator-max-microvolt = <2900000>;
+		vin-supply = <&tps65913_smps9>;
+		enable-active-high;
+		gpio = <&gpio TEGRA_GPIO(K, 1) GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc3_vdd_default>;
+	};
+};
+
+&dsia {
+	status = "okay";
+
+	avdd-dsi-csi-supply = <&tps65913_ldo2>;
+
+	nvidia,ganged-mode = <&dsib>;
+
+	panel_primary: panel@0 {
+		compatible = "sharp,lq101r1sx03", "sharp,lq101r1sx01";
+		reg = <0>;
+
+		link2 = <&panel_secondary>;
+
+		power-supply = <&vdd_lcd>;
+		backlight = <&backlight>;
+	};
+};
+
+&dsib {
+	status = "okay";
+
+	avdd-dsi-csi-supply = <&tps65913_ldo2>;
+
+	nvidia,ganged-mode;
+
+	panel_secondary: panel@0 {
+		compatible = "sharp,lq101r1sx03", "sharp,lq101r1sx01";
+		reg = <0>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	magnetometer@c {
+		compatible = "asahi-kasei,ak09911";
+		reg = <0xc>;
+
+		vdd-supply = <&vdd_3v3_sys>;
+	};
+
+	rt5639: audio-codec@1c {
+		compatible = "realtek,rt5639";
+		reg = <0x1c>;
+
+		interrupt-parent = <&gpio>;
+		interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_EDGE_FALLING>;
+
+		realtek,ldo1-en-gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&codec_default>;
+	};
+
+	motion-tracker@68 {
+		compatible = "invensense,mpu6500";
+		reg = <0x68>;
+
+		interrupt-parent = <&gpio>;
+		interrupts = <TEGRA_GPIO(R, 3) IRQ_TYPE_LEVEL_HIGH>;
+
+		mount-matrix =  "0", "-1", "0",
+				"1",  "0", "0",
+				"0",  "0", "1";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&imu_default>;
+	};
+
+	temp_sensor: temperature-sensor@4c {
+		compatible = "onnn,nct1008";
+		reg = <0x4c>;
+
+		vcc-supply = <&vdd_3v3_sys>;
+		#thermal-sensor-cells = <1>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	power-sensor@44 {
+		compatible = "ti,ina230";
+		reg = <0x44>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	light-sensor@1c {
+		compatible = "dynaimage,al3320a";
+		reg = <0x1c>;
+
+		vdd-supply = <&vdd_3v3_sys>;
+	};
+};
+
+&i2c4 {
+	/* HDMI DDC */
+};
+
+&i2c5 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	palmas: pmic@58 {
+		compatible = "ti,palmas";
+		reg = <0x58>;
+		interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+
+		#interrupt-cells = <2>;
+		interrupt-controller;
+
+		ti,system-power-controller;
+
+		palmas_gpio: gpio {
+			compatible = "ti,palmas-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		pmic {
+			compatible = "ti,tps65913-pmic", "ti,palmas-pmic";
+
+			ldo1-in-supply = <&tps65913_smps7>;
+			ldo2-in-supply = <&tps65913_smps7>;
+			ldo4-in-supply = <&tps65913_smps8>;
+			ldo5-in-supply = <&tps65913_smps9>;
+			ldo6-in-supply = <&tps65913_smps9>;
+			ldo7-in-supply = <&tps65913_smps9>;
+			ldo9-in-supply = <&tps65913_smps9>;
+
+			regulators {
+				tps65913_smps123: smps123 {
+					regulator-name = "vdd-cpu";
+					regulator-min-microvolt = <900000>;
+					regulator-max-microvolt = <1350000>;
+					regulator-always-on;
+					regulator-boot-on;
+					ti,roof-floor = <1>;
+					ti,mode-sleep = <3>;
+				};
+
+				tps65913_smps45: smps45 {
+					regulator-name = "vdd-core";
+					regulator-min-microvolt = <900000>;
+					regulator-max-microvolt = <1400000>;
+					regulator-always-on;
+					regulator-boot-on;
+					ti,roof-floor = <3>;
+				};
+
+				smps6 {
+					regulator-name = "va-lcd-hv";
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				tps65913_smps7: smps7 {
+					regulator-name = "vdd-ddr";
+					regulator-min-microvolt = <1350000>;
+					regulator-max-microvolt = <1350000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				tps65913_smps8: smps8 {
+					regulator-name = "vdd-1v8";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				tps65913_smps9: smps9 {
+					regulator-name = "vdd-sd";
+					regulator-min-microvolt = <2900000>;
+					regulator-max-microvolt = <2900000>;
+					regulator-always-on;
+				};
+
+				tps65913_smps10_out1: smps10_out1 {
+					regulator-name = "vd-smps10-out1";
+					regulator-min-microvolt = <5000000>;
+					regulator-max-microvolt = <5000000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				tps65913_smps10_out2: smps10_out2 {
+					regulator-name = "vd-smps10-out2";
+					regulator-min-microvolt = <5000000>;
+					regulator-max-microvolt = <5000000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+
+				tps65913_ldo1: ldo1 {
+					regulator-name = "vdd-hdmi-pll";
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+					regulator-always-on;
+					ti,roof-floor = <3>;
+				};
+
+				tps65913_ldo2: ldo2 {
+					regulator-name = "vdd-2v8-dsi-csi";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					regulator-boot-on;
+				};
+
+				ldo3 {
+					regulator-name = "vpp-fuse";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				ldo4 {
+					regulator-name = "vdd-1v2-cam";
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				ldo5 {
+					regulator-name = "vdd-cam";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+				};
+
+				ldo6 {
+					regulator-name = "vdd-dev";
+					regulator-min-microvolt = <2850000>;
+					regulator-max-microvolt = <2850000>;
+					regulator-boot-on;
+				};
+
+				ldo7 {
+					regulator-name = "vdd-2v8-cam";
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+				};
+
+				tps65913_ldo8: ldo8 {
+					regulator-name = "vdd-rtc";
+					regulator-min-microvolt = <950000>;
+					regulator-max-microvolt = <950000>;
+					regulator-always-on;
+					regulator-boot-on;
+					ti,enable-ldo8-tracking;
+				};
+
+				tps65913_ldo9: ldo9 {
+					regulator-name = "vdd-sdmmc";
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <2900000>;
+				};
+
+				tps65913_ldoln: ldoln {
+					regulator-name = "vdd-hdmi";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+				};
+
+				ldousb {
+					regulator-name = "vdd-usb";
+					regulator-min-microvolt = <3300000>;
+					regulator-max-microvolt = <3300000>;
+					regulator-always-on;
+					regulator-boot-on;
+				};
+			};
+		};
+
+		rtc {
+			compatible = "ti,palmas-rtc";
+			interrupt-parent = <&palmas>;
+			interrupts = <8 0>;
+		};
+
+		pinmux {
+			compatible = "ti,tps65913-pinctrl";
+			ti,palmas-enable-dvfs1;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&palmas_default>;
+
+			palmas_default: pinmux {
+				pin_powergood {
+					pins = "powergood";
+					function = "powergood";
+				};
+
+				pin_vac {
+					pins = "vac";
+					function = "vac";
+				};
+
+				pin_gpio0 {
+					pins = "gpio0";
+					function = "gpio";
+				};
+
+				pin_gpio1 {
+					pins = "gpio1";
+					function = "gpio";
+				};
+
+				pin_gpio2 {
+					pins = "gpio2";
+					function = "gpio";
+				};
+
+				pin_gpio3 {
+					pins = "gpio3";
+					function = "gpio";
+				};
+
+				pin_gpio4 {
+					pins = "gpio4";
+					function = "gpio";
+				};
+
+				pin_gpio5 {
+					pins = "gpio5";
+					function = "gpio";
+				};
+
+				pin_gpio6 {
+					pins = "gpio6";
+					function = "gpio";
+				};
+
+				pin_gpio7 {
+					pins = "gpio7";
+					function = "gpio";
+				};
+			};
+		};
+	};
+};
+
+&pwm {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm_default>;
+};
+
+&sdmmc1 {
+	/* WiFi */
+};
+
+/* MicroSD card */
+&sdmmc3 {
+	status = "okay";
+
+	bus-width = <4>;
+	cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
+
+	nvidia,default-tap = <0x3>;
+	nvidia,default-trim = <0x3>;
+
+	vmmc-supply = <&vdd_usd>;
+	vqmmc-supply = <&tps65913_ldo9>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc3_default>;
+};
+
+&sdmmc4 {
+	/* eMMC */
+};
+
+&tegra_i2s0 {
+	status = "okay";
+};
+
+&uartb {
+	/* GPS */
+};
+
+&uartc {
+	/* Bluetooth */
+};
+
+&uartd {
+	status = "okay";
+};
+
+&usb1 {
+	compatible = "nvidia,tegra114-udc";
+	status = "okay";
+	dr_mode = "peripheral";
+
+	/* Peripheral USB via ASUS connector */
+};
+
+&usb1_phy {
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+
+	/* Host USB via dock */
+};
+
+&usb3_phy {
+	status = "okay";
+	vbus-supply = <&vdd_5v0_sys>;
+};
+
+&pinmux {
+	asus_pad_ec_default: asus-pad-ec-default {
+		ec-interrupt {
+			nvidia,pins = "kb_col5_pq5";
+			nvidia,function = "kbc";
+			nvidia,pull = <TEGRA_PIN_PULL_UP>;
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+		};
+		ec-request {
+			nvidia,pins = "kb_col2_pq2";
+			nvidia,function = "kbc";
+			nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+		};
+	};
+
+	backlight_default: backlight-default {
+		backlight-enable {
+			nvidia,pins = "gmi_ad10_ph2";
+			nvidia,function = "gmi";
+			nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+		};
+	};
+
+	codec_default: codec-default {
+		ldo1-en {
+			nvidia,pins = "sdmmc1_wp_n_pv3";
+			nvidia,function = "sdmmc1";
+			nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+		};
+		interrupt {
+			nvidia,pins = "gpio_w2_aud_pw2",
+					"gpio_w3_aud_pw3";
+			nvidia,function = "spi6";
+			nvidia,pull = <TEGRA_PIN_PULL_UP>;
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+		};
+	};
+
+	gpio_keys_default: gpio-keys-default {
+		power {
+			nvidia,pins = "kb_col0_pq0";
+			nvidia,function = "kbc";
+			nvidia,pull = <TEGRA_PIN_PULL_UP>;
+			nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+		};
+		volume {
+			nvidia,pins = "kb_row1_pr1",
+					"kb_row2_pr2";
+			nvidia,function = "rsvd2";
+			nvidia,pull = <TEGRA_PIN_PULL_UP>;
+			nvidia,tristate = <TEGRA_PIN_ENABLE>;
+			nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+		};
+	};
+
+	gpio_hall_sensor_default: gpio-hall-sensor-default {
+		ulpi_data4_po5 {
+			nvidia,pins = "ulpi_data4_po5";
+			nvidia,function = "spi2";
+			nvidia,pull = <TEGRA_PIN_PULL_UP>;
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+		};
+	};
+
+	hp_det_default: hp-det-default {
+		gmi_iordy_pi5 {
+			nvidia,pins = "kb_row7_pr7";
+			nvidia,function = "rsvd2";
+			nvidia,pull = <TEGRA_PIN_PULL_UP>;
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+		};
+	};
+
+	imu_default: imu-default {
+		kb_row3_pr3 {
+			nvidia,pins = "kb_row3_pr3";
+			nvidia,function = "rsvd3";
+			nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+		};
+	};
+
+	pwm_default: pwm-default {
+		gmi_ad9_ph1 {
+			nvidia,pins = "gmi_ad9_ph1";
+			nvidia,function = "pwm1";
+			nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+		};
+	};
+
+	sdmmc3_default: sdmmc3-default {
+		sdmmc3_clk_pa6 {
+			nvidia,pins = "sdmmc3_clk_pa6";
+			nvidia,function = "sdmmc3";
+			nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+		};
+		sdmmc3_cmd_pa7 {
+			nvidia,pins = "sdmmc3_cmd_pa7",
+					"sdmmc3_dat0_pb7",
+					"sdmmc3_dat1_pb6",
+					"sdmmc3_dat2_pb5",
+					"sdmmc3_dat3_pb4",
+					"kb_col4_pq4",
+					"sdmmc3_clk_lb_out_pee4",
+					"sdmmc3_clk_lb_in_pee5",
+					"sdmmc3_cd_n_pv2";
+			nvidia,function = "sdmmc3";
+			nvidia,pull = <TEGRA_PIN_PULL_UP>;
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+		};
+		drive_sdio3 {
+			nvidia,pins = "drive_sdio3";
+			nvidia,high-speed-mode = <TEGRA_PIN_ENABLE>;
+			nvidia,schmitt = <TEGRA_PIN_DISABLE>;
+			nvidia,pull-down-strength = <22>;
+			nvidia,pull-up-strength = <36>;
+			nvidia,slew-rate-rising = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+			nvidia,slew-rate-falling = <TEGRA_PIN_SLEW_RATE_FASTEST>;
+		};
+	};
+
+	sdmmc3_vdd_default: sdmmc3-vdd-default {
+		gmi_clk_pk1 {
+			nvidia,pins = "gmi_clk_pk1";
+			nvidia,function = "gmi";
+			nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+		};
+	};
+
+	vdd_lcd_default: vdd-lcd-default {
+		sdmmc4_clk_pcc4 {
+			nvidia,pins = "sdmmc4_clk_pcc4";
+			nvidia,function = "sdmmc4";
+			nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+			nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+		};
+	};
+};
-- 
2.33.1

