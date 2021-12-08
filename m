Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4349B46DA03
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbhLHRmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbhLHRlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:44 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293FCC0617A1;
        Wed,  8 Dec 2021 09:38:12 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bu18so7184371lfb.0;
        Wed, 08 Dec 2021 09:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qa/IY+8W01jWKIr064tofsmNMyiGgUbCz9OuxrCRzQI=;
        b=lU6M0mArKQ57YhmPzSOA2eYoHRd0oV744q7NU/OuMO8Gn1e2bVtr8A+VwIl74ueG0S
         ahNjwXhfzUmsdqTbWIgfnUMPjHSSYKj8lpk4V+0zQe4q2tCG7eV+GobTbNp7xK4Yf2BQ
         2hSLzm8QkXXlpF7/mm/dR+z+o8/2uLJtT5b1K5gR+XejQDl2A6QVzKXEnRyVHQGYTF+n
         7I/kUpq5Uuo3PUiWti0y5hhBDYYzskO/uJlve5YhR64n5Yg1VA4VCaYFrY2yF2N5lNri
         XwKTfwLQ5dlIHUxAKH0xZqpqeB3FL9oUO17fxJ5GpBMxNjQyBLENM84BeMJlXVDqCpNj
         54mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qa/IY+8W01jWKIr064tofsmNMyiGgUbCz9OuxrCRzQI=;
        b=O/klWrlXLk9xTFUeHggBEIO3UVcWVqo+pHiMKoDaOJEK1nZy1J01AtFh7D17PZbA12
         shnfZ/EBlJPnE1BbcHshtoH2TgR+7o3+DPclPwJt1Y4B8HqzaroJcfWjulPPpqAsY712
         1+pHHf/9LKP460Ge8XQQY8SyOAfWo6uZGDh7pqn/n7fscCKOY7yu+eUCZ6CLgb5/6Rj8
         dJc56gXr5ANL0LIiSeMOMUsiz/39mhylEiiNRgMTHA2WEgpfXcpHsAzeEtyTb1GHxRS4
         TaWWEwjn/FsAqSRAPBt4mw15ptH6BVn7XR+XYhgIswsmDahsvRL7xeyW4nGLgh2//Zpa
         GsAQ==
X-Gm-Message-State: AOAM530diJFcIJpMqZpw95LtdGQ5A+5sIsdgO/8l3DDFGGMQcYYrk0DS
        KQw9j737fk86lgeWpp5KjGY=
X-Google-Smtp-Source: ABdhPJxuwB2FihYrl7DdgZ2OAxJZKiWuQHXlC0BIAJDS5+akxdmC+lAw6GimCtMMjRbcNQGN5+H4GQ==
X-Received: by 2002:ac2:5a1a:: with SMTP id q26mr783898lfn.329.1638985089950;
        Wed, 08 Dec 2021 09:38:09 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:38:08 -0800 (PST)
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
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/24] ARM: tegra: Add device-tree for ASUS Transformer Infinity TF700T
Date:   Wed,  8 Dec 2021 20:35:56 +0300
Message-Id: <20211208173609.4064-12-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Svyatoslav Ryhel <clamor95@gmail.com>

Add device-tree for ASUS Transformer Infinity TF700T, which is a NVIDIA
Tegra30-based 2-in-1 detachable, originally running Android.

Link: https://wiki.postmarketos.org/wiki/Asus_Transformer_Pad_Infinity_TF700T_(asus-tf700t)
Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com>
Tested-by: Jasper Korten <jja2000@gmail.com>
Co-developed-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Ion Agorria <ion@agorria.com>
Co-developed-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Co-developed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/tegra30-asus-tf700t.dts | 818 ++++++++++++++++++++++
 2 files changed, 819 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra30-asus-tf700t.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fcbcaed0c2da..87166d66e0b1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1324,6 +1324,7 @@ dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += \
 	tegra30-asus-tf201.dtb \
 	tegra30-asus-tf300t.dtb \
 	tegra30-asus-tf300tg.dtb \
+	tegra30-asus-tf700t.dtb \
 	tegra30-beaver.dtb \
 	tegra30-cardhu-a02.dtb \
 	tegra30-cardhu-a04.dtb \
diff --git a/arch/arm/boot/dts/tegra30-asus-tf700t.dts b/arch/arm/boot/dts/tegra30-asus-tf700t.dts
new file mode 100644
index 000000000000..d12f443df4a4
--- /dev/null
+++ b/arch/arm/boot/dts/tegra30-asus-tf700t.dts
@@ -0,0 +1,818 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-asus-transformer-common.dtsi"
+
+/ {
+	model = "Asus Transformer Infinity TF700T";
+	compatible = "asus,tf700t", "nvidia,tegra30";
+
+	host1x@50000000 {
+		lcd: dc@54200000 {
+			clocks = <&tegra_car TEGRA30_CLK_DISP1>,
+				 <&tegra_car TEGRA30_CLK_PLL_D_OUT0>;
+
+			rgb {
+				status = "okay";
+
+				port@0 {
+					dpi_output: endpoint {
+						remote-endpoint = <&bridge_input>;
+						bus-width = <24>;
+					};
+				};
+			};
+		};
+	};
+
+	pinmux@70000868 {
+		state_default: pinmux {
+			lcd_pwr2_pc6 {
+				nvidia,pins = "lcd_pwr2_pc6",
+						"lcd_dc1_pd2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pbb3 {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			spi2_mosi_px0 {
+				nvidia,pins = "spi2_mosi_px0";
+				nvidia,function = "spi2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			pbb7 {
+				nvidia,pins = "pbb7";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb_row7_pr7 {
+				nvidia,pins = "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_cs4_n_pk2 {
+				nvidia,pins = "gmi_cs4_n_pk2";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+		};
+	};
+
+	uartc: serial@70006200 {
+		/* Azurewave AW-NH665 BCM4330B1 */
+		bluetooth {
+			compatible = "brcm,bcm4330-bt";
+		};
+	};
+
+	tc358768_refclk: tc358768-refclk {
+		compatible = "fixed-clock";
+		clock-frequency = <23100000>;
+		clock-accuracy = <100>;
+		#clock-cells = <0>;
+	};
+
+	tc358768_osc: tc358768-osc-gate {
+		compatible = "gpio-gate-clock";
+		enable-gpios = <&gpio TEGRA_GPIO(D, 2) GPIO_ACTIVE_HIGH>;
+		clocks = <&tc358768_refclk>;
+		#clock-cells = <0>;
+	};
+
+	i2c-switch-tc358768 {
+		compatible = "i2c-mux-gpio";
+
+		mux-gpios = <&gpio TEGRA_GPIO(X, 0) GPIO_ACTIVE_HIGH>;
+		i2c-parent = <&lcd_ddc>;
+		idle-state = <0x0>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dsi-bridge@7 {
+				compatible = "toshiba,tc358768";
+				reg = <0x7>;
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				clocks = <&tc358768_osc>;
+				clock-names = "refclk";
+
+				reset-gpios = <&gpio TEGRA_GPIO(N, 6) GPIO_ACTIVE_LOW>;
+
+				vddc-supply = <&vdd_1v2_mipi>;
+				vddio-supply = <&vdd_1v8_vio>;
+				vddmipi-supply = <&vdd_1v2_mipi>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						bridge_input: endpoint {
+							remote-endpoint = <&dpi_output>;
+							data-lines = <24>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						bridge_output: endpoint {
+							remote-endpoint = <&panel_input>;
+						};
+					};
+				};
+
+				/*
+				 * Panasonic VVX10F004B00 or HYDIS HV101WU1-1E1
+				 * LCD SuperIPS+ Full HD panel.
+				 */
+				panel@1 {
+					compatible = "panasonic,vvx10f004b00";
+					reg = <1>;
+
+					power-supply = <&vdd_pnl>;
+					backlight = <&backlight>;
+
+					port {
+						panel_input: endpoint {
+							remote-endpoint = <&bridge_output>;
+						};
+					};
+				};
+			};
+		};
+	};
+
+	i2c@7000c400 {
+		/* Elantech ELAN-3024-7053 or 5184N FPC-1 REV: 2/3 touchscreen */
+		touchscreen@10 {
+			compatible = "elan,ektf3624";
+			reg = <0x10>;
+
+			interrupt-parent = <&gpio>;
+			interrupts = <TEGRA_GPIO(H, 4) IRQ_TYPE_EDGE_FALLING>;
+			reset-gpios = <&gpio TEGRA_GPIO(H, 6) GPIO_ACTIVE_LOW>;
+
+			vcc33-supply = <&vdd_3v3_sys>;
+			vccio-supply = <&vdd_3v3_sys>;
+
+			touchscreen-size-x = <2944>;
+			touchscreen-size-y = <1856>;
+			touchscreen-inverted-y;
+		};
+	};
+
+	i2c@7000c500 {
+		clock-frequency = <100000>;
+
+		magnetometer@e {
+			mount-matrix =   "1",  "0",  "0",
+					 "0", "-1",  "0",
+					 "0",  "0", "-1";
+		};
+
+		gyroscope@68 {
+			mount-matrix =   "0",  "1",  "0",
+					 "1",  "0",  "0",
+					 "0",  "0", "-1";
+
+			/* External I2C interface */
+			i2c-gate {
+				accelerometer@f {
+					mount-matrix =   "0", "-1",  "0",
+							"-1",  "0",  "0",
+							 "0",  "0",  "1";
+				};
+			};
+		};
+	};
+
+	i2c@7000d000 {
+		/* Realtek ALC5631 audio codec */
+		rt5631: audio-codec@1a {
+			compatible = "realtek,rt5631";
+			reg = <0x1a>;
+		};
+	};
+
+	vdd_1v2_mipi: regulator-mipi {
+		compatible = "regulator-fixed";
+		regulator-name = "tc358768_1v2_vdd";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-enable-ramp-delay = <10000>;
+		regulator-boot-on;
+		gpio = <&gpio TEGRA_GPIO(BB, 3) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		vin-supply = <&vdd_3v3_sys>;
+	};
+
+	haptic-feedback {
+		compatible = "gpio-vibrator";
+		enable-gpios = <&gpio TEGRA_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
+		vcc-supply = <&vdd_3v3_sys>;
+	};
+
+	memory-controller@7000f000 {
+		emc-timings-0 {
+			/* Micron 1GB 800MHZ */
+			nvidia,ram-code = <0>;
+
+			timing-25500000 {
+				clock-frequency = <25500000>;
+
+				nvidia,emem-configuration = < 0x00020001 0xc0000020
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0502 0x75830303 0x001f0000 >;
+			};
+
+			timing-51000000 {
+				clock-frequency = <51000000>;
+
+				nvidia,emem-configuration = < 0x00010001 0xc0000020
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0502 0x74630303 0x001f0000 >;
+			};
+
+			timing-102000000 {
+				clock-frequency = <102000000>;
+
+				nvidia,emem-configuration = < 0x00000001 0xc0000030
+					0x00000001 0x00000001 0x00000003 0x00000000
+					0x00000002 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0503 0x73c30504 0x001f0000 >;
+			};
+
+			timing-204000000 {
+				clock-frequency = <204000000>;
+
+				nvidia,emem-configuration = < 0x00000003 0xc0000025
+					0x00000001 0x00000001 0x00000005 0x00000002
+					0x00000004 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0505 0x73840a06 0x001f0000 >;
+			};
+
+			timing-400000000 {
+				clock-frequency = <400000000>;
+
+				nvidia,emem-configuration = < 0x00000006 0xc0000048
+					0x00000001 0x00000002 0x00000009 0x00000005
+					0x00000007 0x00000001 0x00000002 0x00000008
+					0x00000002 0x00000002 0x00000003 0x00000006
+					0x06030202 0x000d0709 0x7086120a 0x001f0000 >;
+			};
+
+			timing-800000000 {
+				clock-frequency = <800000000>;
+
+				nvidia,emem-configuration = < 0x0000000c 0xc0000090
+					0x00000004 0x00000005 0x00000013 0x0000000c
+					0x0000000f 0x00000002 0x00000003 0x0000000c
+					0x00000002 0x00000002 0x00000004 0x00000008
+					0x08040202 0x00160d13 0x712c2414 0x001f0000 >;
+			};
+		};
+
+		emc-timings-1 {
+			/* Elpida 1GB 800MHZ */
+			nvidia,ram-code = <1>;
+
+			timing-25500000 {
+				clock-frequency = <25500000>;
+
+				nvidia,emem-configuration = < 0x00020001 0xc0000020
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0502 0x75830303 0x001f0000 >;
+			};
+
+			timing-51000000 {
+				clock-frequency = <51000000>;
+
+				nvidia,emem-configuration = < 0x00010001 0xc0000020
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0502 0x74630303 0x001f0000 >;
+			};
+
+			timing-102000000 {
+				clock-frequency = <102000000>;
+
+				nvidia,emem-configuration = < 0x00000001 0xc0000030
+					0x00000001 0x00000001 0x00000003 0x00000000
+					0x00000002 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0503 0x73c30504 0x001f0000 >;
+			};
+
+			timing-204000000 {
+				clock-frequency = <204000000>;
+
+				nvidia,emem-configuration = < 0x00000003 0xc0000025
+					0x00000001 0x00000001 0x00000005 0x00000002
+					0x00000004 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0505 0x73840a06 0x001f0000 >;
+			};
+
+			timing-400000000 {
+				clock-frequency = <400000000>;
+
+				nvidia,emem-configuration = < 0x00000006 0xc0000048
+					0x00000001 0x00000002 0x00000009 0x00000005
+					0x00000007 0x00000001 0x00000002 0x00000008
+					0x00000002 0x00000002 0x00000003 0x00000006
+					0x06030202 0x000d0709 0x7086120a 0x001f0000 >;
+			};
+
+			timing-800000000 {
+				clock-frequency = <800000000>;
+
+				nvidia,emem-configuration = < 0x0000000c 0xc0000090
+					0x00000004 0x00000005 0x00000013 0x0000000c
+					0x0000000f 0x00000002 0x00000003 0x0000000c
+					0x00000002 0x00000002 0x00000004 0x00000008
+					0x08040202 0x00160d13 0x712c2414 0x001f0000 >;
+			};
+		};
+	};
+
+	memory-controller@7000f400 {
+		emc-timings-0 {
+			/* Micron 1GB 800MHZ */
+			nvidia,ram-code = <0>;
+
+			timing-25500000 {
+				clock-frequency = <25500000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100003>;
+				nvidia,emc-mode-2 = <0x80200008>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000001
+					0x00000006 0x00000000 0x00000000 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000000
+					0x00000000 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x000000c0 0x00000000 0x00000030
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000007 0x00000007
+					0x00000004 0x00000002 0x00000000 0x00000004
+					0x00000005 0x000000c7 0x00000006 0x00000004
+					0x00000000 0x00000000 0x00004288 0x007800a4
+					0x00008000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000002a0 0x0800211c 0x00000000
+					0x77fff884 0x01f1f108 0x05057404 0x54000007
+					0x08000168 0x08000000 0x00000802 0x00000000
+					0x00000040 0x000c000c 0xa0f10000 0x00000000
+					0x00000000 0x80000287 0xe8000000 0xff00ff00 >;
+			};
+
+			timing-51000000 {
+				clock-frequency = <51000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100003>;
+				nvidia,emc-mode-2 = <0x80200008>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000002
+					0x0000000d 0x00000001 0x00000000 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000000
+					0x00000000 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x00000181 0x00000000 0x00000060
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x0000000e 0x0000000e
+					0x00000004 0x00000003 0x00000000 0x00000004
+					0x00000005 0x0000018e 0x00000006 0x00000004
+					0x00000000 0x00000000 0x00004288 0x007800a4
+					0x00008000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000002a0 0x0800211c 0x00000000
+					0x77fff884 0x01f1f108 0x05057404 0x54000007
+					0x08000168 0x08000000 0x00000802 0x00000000
+					0x00000040 0x000c000c 0xa0f10000 0x00000000
+					0x00000000 0x8000040b 0xe8000000 0xff00ff00 >;
+			};
+
+			timing-102000000 {
+				clock-frequency = <102000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100003>;
+				nvidia,emc-mode-2 = <0x80200008>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000004
+					0x0000001a 0x00000003 0x00000001 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000001
+					0x00000001 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x00000303 0x00000000 0x000000c0
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x0000001c 0x0000001c
+					0x00000004 0x00000005 0x00000000 0x00000004
+					0x00000005 0x0000031c 0x00000006 0x00000004
+					0x00000000 0x00000000 0x00004288 0x007800a4
+					0x00008000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000002a0 0x0800211c 0x00000000
+					0x77fff884 0x01f1f108 0x05057404 0x54000007
+					0x08000168 0x08000000 0x00000802 0x00000000
+					0x00000040 0x000c000c 0xa0f10000 0x00000000
+					0x00000000 0x80000713 0xe8000000 0xff00ff00 >;
+			};
+
+			timing-204000000 {
+				clock-frequency = <204000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100003>;
+				nvidia,emc-mode-2 = <0x80200008>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000009
+					0x00000035 0x00000007 0x00000002 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000002
+					0x00000002 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000006 0x00000004 0x0000000a
+					0x0000000b 0x00000607 0x00000000 0x00000181
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000038 0x00000038
+					0x00000004 0x00000009 0x00000000 0x00000004
+					0x00000005 0x00000638 0x00000007 0x00000004
+					0x00000000 0x00000000 0x00004288 0x004400a4
+					0x00008000 0x00080000 0x00080000 0x00080000
+					0x00080000 0x00080000 0x00080000 0x00080000
+					0x00080000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00080000 0x00080000 0x00080000
+					0x00080000 0x000002a0 0x0800211c 0x00000000
+					0x77fff884 0x01f1f108 0x05057404 0x54000007
+					0x08000168 0x08000000 0x00000802 0x00020000
+					0x00000100 0x000c000c 0xa0f10000 0x00000000
+					0x00000000 0x80000d22 0xe8000000 0xff00ff00 >;
+			};
+
+			timing-400000000 {
+				clock-frequency = <400000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100002>;
+				nvidia,emc-mode-2 = <0x80200000>;
+				nvidia,emc-mode-reset = <0x80000521>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+
+				nvidia,emc-configuration =  < 0x00000012
+					0x00000066 0x0000000c 0x00000004 0x00000003
+					0x00000008 0x00000002 0x0000000a 0x00000004
+					0x00000004 0x00000002 0x00000001 0x00000000
+					0x00000004 0x00000006 0x00000004 0x0000000a
+					0x0000000c 0x00000bf0 0x00000000 0x000002fc
+					0x00000001 0x00000008 0x00000001 0x00000000
+					0x00000008 0x0000000f 0x0000006c 0x00000200
+					0x00000004 0x00000010 0x00000000 0x00000004
+					0x00000005 0x00000c30 0x00000000 0x00000004
+					0x00000000 0x00000000 0x00007088 0x001d0084
+					0x00008000 0x00044000 0x00044000 0x00044000
+					0x00044000 0x00014000 0x00014000 0x00014000
+					0x00014000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00048000 0x00048000 0x00048000
+					0x00048000 0x000002a0 0x0600013d 0x00000000
+					0x77fff884 0x01f1f508 0x05057404 0x54000007
+					0x080001e8 0x08000021 0x00000802 0x00020000
+					0x00000100 0x0158000c 0xa0f10000 0x00000000
+					0x00000000 0x800018c8 0xe8000000 0xff00ff89 >;
+			};
+
+			timing-800000000 {
+				clock-frequency = <800000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100002>;
+				nvidia,emc-mode-2 = <0x80200018>;
+				nvidia,emc-mode-reset = <0x80000d71>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000025
+					0x000000ce 0x0000001a 0x00000009 0x00000005
+					0x0000000d 0x00000004 0x00000013 0x00000009
+					0x00000009 0x00000004 0x00000001 0x00000000
+					0x00000007 0x0000000a 0x00000009 0x0000000a
+					0x00000011 0x00001820 0x00000000 0x00000608
+					0x00000003 0x00000012 0x00000001 0x00000000
+					0x0000000f 0x00000018 0x000000d8 0x00000200
+					0x00000005 0x00000020 0x00000000 0x00000007
+					0x00000008 0x00001860 0x0000000b 0x00000006
+					0x00000000 0x00000000 0x00005088 0xf0070191
+					0x00008000 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x00018000 0x00018000 0x00018000
+					0x00018000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x000002a0 0x0800013d 0x22220000
+					0x77fff884 0x01f1f501 0x07077404 0x54000000
+					0x080001e8 0x08000021 0x00000802 0x00020000
+					0x00000100 0x00f0000c 0xa0f10000 0x00000000
+					0x00000000 0x8000308c 0xe8000000 0xff00ff49 >;
+			};
+		};
+
+		emc-timings-1 {
+			/* Elpida 1GB 800MHZ */
+			nvidia,ram-code = <1>;
+
+			timing-25500000 {
+				clock-frequency = <25500000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100003>;
+				nvidia,emc-mode-2 = <0x80200008>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000001
+					0x00000006 0x00000000 0x00000000 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000000
+					0x00000000 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x000000c0 0x00000000 0x00000030
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000007 0x00000007
+					0x00000004 0x00000002 0x00000000 0x00000004
+					0x00000005 0x000000c7 0x00000006 0x00000004
+					0x00000000 0x00000000 0x00004288 0x007800a4
+					0x00008000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000002a0 0x0800211c 0x00000000
+					0x77fff884 0x01f1f108 0x05057404 0x54000007
+					0x08000168 0x08000000 0x00000802 0x00000000
+					0x00000040 0x000c000c 0xa0f10000 0x00000000
+					0x00000000 0x80000287 0xe8000000 0xff00ff00 >;
+			};
+
+			timing-51000000 {
+				clock-frequency = <51000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100003>;
+				nvidia,emc-mode-2 = <0x80200008>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000002
+					0x0000000d 0x00000001 0x00000000 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000000
+					0x00000000 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x00000181 0x00000000 0x00000060
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x0000000e 0x0000000e
+					0x00000004 0x00000003 0x00000000 0x00000004
+					0x00000005 0x0000018e 0x00000006 0x00000004
+					0x00000000 0x00000000 0x00004288 0x007800a4
+					0x00008000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000002a0 0x0800211c 0x00000000
+					0x77fff884 0x01f1f108 0x05057404 0x54000007
+					0x08000168 0x08000000 0x00000802 0x00000000
+					0x00000040 0x000c000c 0xa0f10000 0x00000000
+					0x00000000 0x8000040b 0xe8000000 0xff00ff00 >;
+			};
+
+			timing-102000000 {
+				clock-frequency = <102000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100003>;
+				nvidia,emc-mode-2 = <0x80200008>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000004
+					0x0000001a 0x00000003 0x00000001 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000001
+					0x00000001 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x00000303 0x00000000 0x000000c0
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x0000001c 0x0000001c
+					0x00000004 0x00000005 0x00000000 0x00000004
+					0x00000005 0x0000031c 0x00000006 0x00000004
+					0x00000000 0x00000000 0x00004288 0x007800a4
+					0x00008000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x000fc000 0x000fc000 0x000fc000
+					0x000fc000 0x000002a0 0x0800211c 0x00000000
+					0x77fff884 0x01f1f108 0x05057404 0x54000007
+					0x08000168 0x08000000 0x00000802 0x00000000
+					0x00000040 0x000c000c 0xa0f10000 0x00000000
+					0x00000000 0x80000713 0xe8000000 0xff00ff00 >;
+			};
+
+			timing-204000000 {
+				clock-frequency = <204000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100003>;
+				nvidia,emc-mode-2 = <0x80200008>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000009
+					0x00000035 0x00000007 0x00000002 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000002
+					0x00000002 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000006 0x00000004 0x0000000a
+					0x0000000b 0x00000607 0x00000000 0x00000181
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000038 0x00000038
+					0x00000004 0x00000009 0x00000000 0x00000004
+					0x00000005 0x00000638 0x00000007 0x00000004
+					0x00000000 0x00000000 0x00004288 0x004400a4
+					0x00008000 0x00080000 0x00080000 0x00080000
+					0x00080000 0x00080000 0x00080000 0x00080000
+					0x00080000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00080000 0x00080000 0x00080000
+					0x00080000 0x000002a0 0x0800211c 0x00000000
+					0x77fff884 0x01f1f108 0x05057404 0x54000007
+					0x08000168 0x08000000 0x00000802 0x00020000
+					0x00000100 0x000c000c 0xa0f10000 0x00000000
+					0x00000000 0x80000d22 0xe8000000 0xff00ff00 >;
+			};
+
+			timing-400000000 {
+				clock-frequency = <400000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100002>;
+				nvidia,emc-mode-2 = <0x80200000>;
+				nvidia,emc-mode-reset = <0x80000521>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+
+				nvidia,emc-configuration =  < 0x00000012
+					0x00000066 0x0000000c 0x00000004 0x00000003
+					0x00000008 0x00000002 0x0000000a 0x00000004
+					0x00000004 0x00000002 0x00000001 0x00000000
+					0x00000004 0x00000006 0x00000004 0x0000000a
+					0x0000000c 0x00000bf0 0x00000000 0x000002fc
+					0x00000001 0x00000008 0x00000001 0x00000000
+					0x00000008 0x0000000f 0x0000006c 0x00000200
+					0x00000004 0x00000010 0x00000000 0x00000004
+					0x00000005 0x00000c30 0x00000000 0x00000004
+					0x00000000 0x00000000 0x00007088 0x001d0084
+					0x00008000 0x00044000 0x00044000 0x00044000
+					0x00044000 0x00014000 0x00014000 0x00014000
+					0x00014000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00048000 0x00048000 0x00048000
+					0x00048000 0x000002a0 0x0600013d 0x00000000
+					0x77fff884 0x01f1f508 0x05057404 0x54000007
+					0x080001e8 0x08000021 0x00000802 0x00020000
+					0x00000100 0x0158000c 0xa0f10000 0x00000000
+					0x00000000 0x800018c8 0xe8000000 0xff00ff89 >;
+			};
+
+			timing-800000000 {
+				clock-frequency = <800000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100002>;
+				nvidia,emc-mode-2 = <0x80200018>;
+				nvidia,emc-mode-reset = <0x80000d71>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000025
+					0x000000ce 0x0000001a 0x00000009 0x00000005
+					0x0000000d 0x00000004 0x00000013 0x00000009
+					0x00000009 0x00000004 0x00000001 0x00000000
+					0x00000007 0x0000000a 0x00000009 0x0000000a
+					0x00000011 0x00001820 0x00000000 0x00000608
+					0x00000003 0x00000012 0x00000001 0x00000000
+					0x0000000f 0x00000018 0x000000d8 0x00000200
+					0x00000005 0x00000020 0x00000000 0x00000007
+					0x00000008 0x00001860 0x0000000b 0x00000006
+					0x00000000 0x00000000 0x00005088 0xf0070191
+					0x00008000 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x00018000 0x00018000 0x00018000
+					0x00018000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x000002a0 0x0a00013d 0x22220000
+					0x77fff884 0x01f1f501 0x07077404 0x54000000
+					0x080001e8 0x08000021 0x00000802 0x00020000
+					0x00000100 0x00f0000c 0xa0f10000 0x00000000
+					0x00000000 0x8000308c 0xe8000000 0xff00ff49 >;
+			};
+		};
+	};
+};
+
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp-900000000-1350;
+};
+
+&emc_bw_dfs_opp_table {
+	/delete-node/ opp-900000000;
+};
-- 
2.33.1

