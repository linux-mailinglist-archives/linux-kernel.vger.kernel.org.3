Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF84716A5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhLKVQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbhLKVOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:49 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362DEC0698D0;
        Sat, 11 Dec 2021 13:14:44 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id a37so17385672ljq.13;
        Sat, 11 Dec 2021 13:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJ6GuI1oEsp3zgBkmqIhlEjkoTtXoPOcIidkPiSfUAQ=;
        b=UYhhTe0ifSgtmwO9uGe1A4BlRkInarconPwg6/OJzKk+q4+nCoZRciAQxTib694ugh
         AWlpCsBFsbbeRiJzLFl+LJFd5oeNRIA8aq65JQF2lT9L7fyigo92vXexfv8Glb9Fkyfv
         N3Uw0wUwQDJ3frr5TJ+zjqKKpsqPDnIdXq3FEaohVWr3eaKyU46oLctdqm9Eg5C7fhhh
         d0uKdGRgLAog0Tcs22fvSiIipkDHVZn+wNMZt3cMNH0rd4a1ZHKfRgyC6sHnKbhVBE6j
         vgjwuwn2o9EB39ZfB0NCJiogCV/S5+aAxpqW5tpPeLAf849Ft1pmksgDcxehk3lIheUK
         S1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJ6GuI1oEsp3zgBkmqIhlEjkoTtXoPOcIidkPiSfUAQ=;
        b=2jRazHKTzigBWbarFe9xQp4VBfrQaFF/4MrzDQPlArdeXejMS8kzvXqkxFmPpuiEbt
         ZEHYRfqicdAk+SKGGsKJHcr1vmEoLRhNJWtGREjGjM9Tn0CBAGpQTlpss8PPzmaGfhv+
         9rIpVmwvX6n/RHeQaK4LC9TeM7pRwGFtKYuXb/TvK6eGrIgBjWfMdhB85Trvvnwfnx6k
         lgcz1PneGfSdUWUueh73TvmwldBeK7maTcJFtH/WcGdsnOnNfLs5M4CXvTQf/kxsQQqS
         UMNmsO9hsEQgxuCBQt7824RC8dVlVdlOHu0cOQL+5mjHdyyvhxN442LQkUU0uElcy8VZ
         +raQ==
X-Gm-Message-State: AOAM532mR7wvgxAamZhIBnC7ta04VeLAuj/Qpm47LGC/dHqiTRkjXMCZ
        UzO/jmhv2gOgU8n6917kERVnSrHOX8U=
X-Google-Smtp-Source: ABdhPJwy3W5BWEtTqjXIzOoDa0KD2M+ayoU1CPV2gA+otpIaPNIW+4frSzuVrKMTKgyE8UbZGaPI9A==
X-Received: by 2002:a2e:9617:: with SMTP id v23mr20136880ljh.363.1639257282263;
        Sat, 11 Dec 2021 13:14:42 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:41 -0800 (PST)
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
Subject: [PATCH v6 20/28] ARM: tegra: Rename top-level regulators
Date:   Sun, 12 Dec 2021 00:14:04 +0300
Message-Id: <20211211211412.10791-21-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulators defined at the top level in device tree are no longer part of
a simple bus and therefore don't have a reg property. Nodes without a
reg property shouldn't have a unit-address either, so drop the unit
address from the node names. To ensure nodes aren't duplicated (in which
case they would end up merged in the final DTB), append the name of the
regulator to the node name.

[treding@nvidia.com: factored out patch and wrote commit message]
Signed-off-by: David Heidelberg <david@ixit.cz>
Co-developed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts        | 14 +++++-----
 arch/arm/boot/dts/tegra114-roth.dts           | 12 ++++-----
 arch/arm/boot/dts/tegra114-tn7.dts            |  6 ++---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts     | 24 ++++++++---------
 arch/arm/boot/dts/tegra124-nyan.dtsi          | 26 +++++++++----------
 arch/arm/boot/dts/tegra124-venice2.dts        | 26 +++++++++----------
 .../boot/dts/tegra20-acer-a500-picasso.dts    |  8 +++---
 arch/arm/boot/dts/tegra20-harmony.dts         | 14 +++++-----
 arch/arm/boot/dts/tegra20-medcom-wide.dts     |  8 +++---
 arch/arm/boot/dts/tegra20-paz00.dts           |  4 +--
 arch/arm/boot/dts/tegra20-plutux.dts          |  8 +++---
 arch/arm/boot/dts/tegra20-seaboard.dts        | 14 +++++-----
 arch/arm/boot/dts/tegra20-tamonten.dtsi       |  2 +-
 arch/arm/boot/dts/tegra20-tec.dts             |  8 +++---
 arch/arm/boot/dts/tegra20-trimslice.dts       | 10 +++----
 arch/arm/boot/dts/tegra20-ventana.dts         | 10 +++----
 .../tegra30-asus-nexus7-grouper-common.dtsi   |  8 +++---
 ...egra30-asus-nexus7-grouper-maxim-pmic.dtsi |  4 +--
 .../tegra30-asus-nexus7-grouper-ti-pmic.dtsi  |  2 +-
 arch/arm/boot/dts/tegra30-beaver.dts          | 18 ++++++-------
 arch/arm/boot/dts/tegra30-cardhu-a02.dts      | 12 ++++-----
 arch/arm/boot/dts/tegra30-cardhu-a04.dts      | 14 +++++-----
 arch/arm/boot/dts/tegra30-cardhu.dtsi         | 26 +++++++++----------
 23 files changed, 139 insertions(+), 139 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 4bf35d947d9b..d23050bfaba6 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1186,7 +1186,7 @@ volume_up {
 		};
 	};
 
-	vdd_ac_bat_reg: regulator@0 {
+	vdd_ac_bat_reg: regulator-acbat {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_ac_bat";
 		regulator-min-microvolt = <5000000>;
@@ -1194,7 +1194,7 @@ vdd_ac_bat_reg: regulator@0 {
 		regulator-always-on;
 	};
 
-	dvdd_ts_reg: regulator@1 {
+	dvdd_ts_reg: regulator-ts {
 		compatible = "regulator-fixed";
 		regulator-name = "dvdd_ts";
 		regulator-min-microvolt = <1800000>;
@@ -1203,7 +1203,7 @@ dvdd_ts_reg: regulator@1 {
 		gpio = <&gpio TEGRA_GPIO(H, 5) GPIO_ACTIVE_HIGH>;
 	};
 
-	usb1_vbus_reg: regulator@3 {
+	usb1_vbus_reg: regulator-usb1 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -1214,7 +1214,7 @@ usb1_vbus_reg: regulator@3 {
 		vin-supply = <&tps65090_dcdc1_reg>;
 	};
 
-	usb3_vbus_reg: regulator@4 {
+	usb3_vbus_reg: regulator-usb3 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb2_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -1225,7 +1225,7 @@ usb3_vbus_reg: regulator@4 {
 		vin-supply = <&tps65090_dcdc1_reg>;
 	};
 
-	vdd_hdmi_reg: regulator@5 {
+	vdd_hdmi_reg: regulator-hdmi {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_hdmi_5v0";
 		regulator-min-microvolt = <5000000>;
@@ -1233,7 +1233,7 @@ vdd_hdmi_reg: regulator@5 {
 		vin-supply = <&tps65090_dcdc1_reg>;
 	};
 
-	vdd_cam_1v8_reg: regulator@6 {
+	vdd_cam_1v8_reg: regulator-cam {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_cam_1v8_reg";
 		regulator-min-microvolt = <1800000>;
@@ -1242,7 +1242,7 @@ vdd_cam_1v8_reg: regulator@6 {
 		gpio = <&palmas_gpio 6 0>;
 	};
 
-	vdd_5v0_hdmi: regulator@7 {
+	vdd_5v0_hdmi: regulator-hdmicon {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_5V0_HDMI_CON";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/tegra114-roth.dts b/arch/arm/boot/dts/tegra114-roth.dts
index 24ac84f81b19..18521707ff5b 100644
--- a/arch/arm/boot/dts/tegra114-roth.dts
+++ b/arch/arm/boot/dts/tegra114-roth.dts
@@ -1045,7 +1045,7 @@ power {
 		};
 	};
 
-	lcd_bl_en: regulator@0 {
+	lcd_bl_en: regulator-lcden {
 		compatible = "regulator-fixed";
 		regulator-name = "lcd_bl_en";
 		regulator-min-microvolt = <5000000>;
@@ -1053,7 +1053,7 @@ lcd_bl_en: regulator@0 {
 		regulator-boot-on;
 	};
 
-	vdd_lcd: regulator@1 {
+	vdd_lcd: regulator-lcd {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_lcd_1v8";
 		regulator-min-microvolt = <1800000>;
@@ -1064,7 +1064,7 @@ vdd_lcd: regulator@1 {
 		regulator-boot-on;
 	};
 
-	regulator@2 {
+	regulator-1v8ts {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v8_ts";
 		regulator-min-microvolt = <1800000>;
@@ -1073,7 +1073,7 @@ regulator@2 {
 		regulator-boot-on;
 	};
 
-	regulator@3 {
+	regulator-3v3ts {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_3v3_ts";
 		regulator-min-microvolt = <3300000>;
@@ -1083,7 +1083,7 @@ regulator@3 {
 		regulator-boot-on;
 	};
 
-	regulator@4 {
+	regulator-1v8com {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v8_com";
 		regulator-min-microvolt = <1800000>;
@@ -1094,7 +1094,7 @@ regulator@4 {
 		regulator-boot-on;
 	};
 
-	regulator@5 {
+	regulator-3v3com {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_3v3_com";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/tegra114-tn7.dts b/arch/arm/boot/dts/tegra114-tn7.dts
index 73c949d90345..0534247458f0 100644
--- a/arch/arm/boot/dts/tegra114-tn7.dts
+++ b/arch/arm/boot/dts/tegra114-tn7.dts
@@ -303,7 +303,7 @@ volume_up {
 	};
 
 	/* FIXME: output of BQ24192 */
-	vs_sys: regulator@0 {
+	vs_sys: regulator-vs {
 		compatible = "regulator-fixed";
 		regulator-name = "VS_SYS";
 		regulator-min-microvolt = <4200000>;
@@ -312,7 +312,7 @@ vs_sys: regulator@0 {
 		regulator-boot-on;
 	};
 
-	lcd_bl_en: regulator@1 {
+	lcd_bl_en: regulator-lcden {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_LCD_BL";
 		regulator-min-microvolt = <16500000>;
@@ -323,7 +323,7 @@ lcd_bl_en: regulator@1 {
 		regulator-boot-on;
 	};
 
-	vdd_lcd: regulator@2 {
+	vdd_lcd: regulator-lcd {
 		compatible = "regulator-fixed";
 		regulator-name = "VD_LCD_1V8";
 		regulator-min-microvolt = <1800000>;
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 7339373c3e64..094f94a627b2 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1892,7 +1892,7 @@ power {
 		};
 	};
 
-	vdd_mux: regulator@0 {
+	vdd_mux: regulator-mux {
 		compatible = "regulator-fixed";
 		regulator-name = "+VDD_MUX";
 		regulator-min-microvolt = <12000000>;
@@ -1901,7 +1901,7 @@ vdd_mux: regulator@0 {
 		regulator-boot-on;
 	};
 
-	vdd_5v0_sys: regulator@1 {
+	vdd_5v0_sys: regulator-5v0sys {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_SYS";
 		regulator-min-microvolt = <5000000>;
@@ -1911,7 +1911,7 @@ vdd_5v0_sys: regulator@1 {
 		vin-supply = <&vdd_mux>;
 	};
 
-	vdd_3v3_sys: regulator@2 {
+	vdd_3v3_sys: regulator-3v3sys {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_SYS";
 		regulator-min-microvolt = <3300000>;
@@ -1921,7 +1921,7 @@ vdd_3v3_sys: regulator@2 {
 		vin-supply = <&vdd_mux>;
 	};
 
-	vdd_3v3_run: regulator@3 {
+	vdd_3v3_run: regulator-3v3run {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_RUN";
 		regulator-min-microvolt = <3300000>;
@@ -1933,7 +1933,7 @@ vdd_3v3_run: regulator@3 {
 		vin-supply = <&vdd_3v3_sys>;
 	};
 
-	vdd_3v3_hdmi: regulator@4 {
+	vdd_3v3_hdmi: regulator-3v3hdmi {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_AVDD_HDMI_AP_GATED";
 		regulator-min-microvolt = <3300000>;
@@ -1941,7 +1941,7 @@ vdd_3v3_hdmi: regulator@4 {
 		vin-supply = <&vdd_3v3_run>;
 	};
 
-	vdd_usb1_vbus: regulator@5 {
+	vdd_usb1_vbus: regulator-usb1 {
 		compatible = "regulator-fixed";
 		regulator-name = "+USB0_VBUS_SW";
 		regulator-min-microvolt = <5000000>;
@@ -1952,7 +1952,7 @@ vdd_usb1_vbus: regulator@5 {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
-	vdd_usb3_vbus: regulator@6 {
+	vdd_usb3_vbus: regulator-usb3 {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_USB_HS";
 		regulator-min-microvolt = <5000000>;
@@ -1963,7 +1963,7 @@ vdd_usb3_vbus: regulator@6 {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
-	vdd_3v3_lp0: regulator@7 {
+	vdd_3v3_lp0: regulator-lp0 {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_LP0";
 		regulator-min-microvolt = <3300000>;
@@ -1975,7 +1975,7 @@ vdd_3v3_lp0: regulator@7 {
 		vin-supply = <&vdd_3v3_sys>;
 	};
 
-	vdd_hdmi_pll: regulator@8 {
+	vdd_hdmi_pll: regulator-hdmipll {
 		compatible = "regulator-fixed";
 		regulator-name = "+1.05V_RUN_AVDD_HDMI_PLL";
 		regulator-min-microvolt = <1050000>;
@@ -1984,7 +1984,7 @@ vdd_hdmi_pll: regulator@8 {
 		vin-supply = <&vdd_1v05_run>;
 	};
 
-	vdd_5v0_hdmi: regulator@9 {
+	vdd_5v0_hdmi: regulator-hdmicon {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_HDMI_CON";
 		regulator-min-microvolt = <5000000>;
@@ -1995,7 +1995,7 @@ vdd_5v0_hdmi: regulator@9 {
 	};
 
 	/* Molex power connector */
-	vdd_5v0_sata: regulator@10 {
+	vdd_5v0_sata: regulator-5v0sata {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_SATA";
 		regulator-min-microvolt = <5000000>;
@@ -2005,7 +2005,7 @@ vdd_5v0_sata: regulator@10 {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
-	vdd_12v0_sata: regulator@11 {
+	vdd_12v0_sata: regulator-12v0sata {
 		compatible = "regulator-fixed";
 		regulator-name = "+12V_SATA";
 		regulator-min-microvolt = <12000000>;
diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index ccd3d81a3531..d62f57b392ec 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -621,7 +621,7 @@ power {
 		};
 	};
 
-	vdd_mux: regulator@0 {
+	vdd_mux: regulator-mux {
 		compatible = "regulator-fixed";
 		regulator-name = "+VDD_MUX";
 		regulator-min-microvolt = <12000000>;
@@ -630,7 +630,7 @@ vdd_mux: regulator@0 {
 		regulator-boot-on;
 	};
 
-	vdd_5v0_sys: regulator@1 {
+	vdd_5v0_sys: regulator-5v0sys {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_SYS";
 		regulator-min-microvolt = <5000000>;
@@ -640,7 +640,7 @@ vdd_5v0_sys: regulator@1 {
 		vin-supply = <&vdd_mux>;
 	};
 
-	vdd_3v3_sys: regulator@2 {
+	vdd_3v3_sys: regulator-3v3sys {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_SYS";
 		regulator-min-microvolt = <3300000>;
@@ -650,7 +650,7 @@ vdd_3v3_sys: regulator@2 {
 		vin-supply = <&vdd_mux>;
 	};
 
-	vdd_3v3_run: regulator@3 {
+	vdd_3v3_run: regulator-3v3run {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_RUN";
 		regulator-min-microvolt = <3300000>;
@@ -662,7 +662,7 @@ vdd_3v3_run: regulator@3 {
 		vin-supply = <&vdd_3v3_sys>;
 	};
 
-	vdd_3v3_hdmi: regulator@4 {
+	vdd_3v3_hdmi: regulator-3v3hdmi {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_AVDD_HDMI_AP_GATED";
 		regulator-min-microvolt = <3300000>;
@@ -670,7 +670,7 @@ vdd_3v3_hdmi: regulator@4 {
 		vin-supply = <&vdd_3v3_run>;
 	};
 
-	vdd_led: regulator@5 {
+	vdd_led: regulator-led {
 		compatible = "regulator-fixed";
 		regulator-name = "+VDD_LED";
 		gpio = <&gpio TEGRA_GPIO(P, 2) GPIO_ACTIVE_HIGH>;
@@ -678,7 +678,7 @@ vdd_led: regulator@5 {
 		vin-supply = <&vdd_mux>;
 	};
 
-	vdd_5v0_ts: regulator@6 {
+	vdd_5v0_ts: regulator-ts {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_VDD_TS_SW";
 		regulator-min-microvolt = <5000000>;
@@ -689,7 +689,7 @@ vdd_5v0_ts: regulator@6 {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
-	vdd_usb1_vbus: regulator@7 {
+	vdd_usb1_vbus: regulator-usb1 {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_USB_HS";
 		regulator-min-microvolt = <5000000>;
@@ -700,7 +700,7 @@ vdd_usb1_vbus: regulator@7 {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
-	vdd_usb3_vbus: regulator@8 {
+	vdd_usb3_vbus: regulator-usb3 {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_USB_SS";
 		regulator-min-microvolt = <5000000>;
@@ -711,7 +711,7 @@ vdd_usb3_vbus: regulator@8 {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
-	vdd_3v3_panel: regulator@9 {
+	vdd_3v3_panel: regulator-panel {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_PANEL";
 		regulator-min-microvolt = <3300000>;
@@ -721,7 +721,7 @@ vdd_3v3_panel: regulator@9 {
 		vin-supply = <&vdd_3v3_run>;
 	};
 
-	vdd_3v3_lp0: regulator@10 {
+	vdd_3v3_lp0: regulator-lp0 {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_LP0";
 		regulator-min-microvolt = <3300000>;
@@ -736,7 +736,7 @@ vdd_3v3_lp0: regulator@10 {
 		vin-supply = <&vdd_3v3_sys>;
 	};
 
-	vdd_hdmi_pll: regulator@11 {
+	vdd_hdmi_pll: regulator-hdmipll {
 		compatible = "regulator-fixed";
 		regulator-name = "+1.05V_RUN_AVDD_HDMI_PLL";
 		regulator-min-microvolt = <1050000>;
@@ -745,7 +745,7 @@ vdd_hdmi_pll: regulator@11 {
 		vin-supply = <&vdd_1v05_run>;
 	};
 
-	vdd_5v0_hdmi: regulator@12 {
+	vdd_5v0_hdmi: regulator-hdmicon {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_HDMI_CON";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 2fdcb8bf0bc5..2f2932be01c6 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -1086,7 +1086,7 @@ panel: panel {
 		ddc-i2c-bus = <&dpaux>;
 	};
 
-	vdd_mux: regulator@0 {
+	vdd_mux: regulator-mux {
 		compatible = "regulator-fixed";
 		regulator-name = "+VDD_MUX";
 		regulator-min-microvolt = <12000000>;
@@ -1095,7 +1095,7 @@ vdd_mux: regulator@0 {
 		regulator-boot-on;
 	};
 
-	vdd_5v0_sys: regulator@1 {
+	vdd_5v0_sys: regulator-5v0sys {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_SYS";
 		regulator-min-microvolt = <5000000>;
@@ -1105,7 +1105,7 @@ vdd_5v0_sys: regulator@1 {
 		vin-supply = <&vdd_mux>;
 	};
 
-	vdd_3v3_sys: regulator@2 {
+	vdd_3v3_sys: regulator-3v3sys {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_SYS";
 		regulator-min-microvolt = <3300000>;
@@ -1115,7 +1115,7 @@ vdd_3v3_sys: regulator@2 {
 		vin-supply = <&vdd_mux>;
 	};
 
-	vdd_3v3_run: regulator@3 {
+	vdd_3v3_run: regulator-3v3run {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_RUN";
 		regulator-min-microvolt = <3300000>;
@@ -1127,7 +1127,7 @@ vdd_3v3_run: regulator@3 {
 		vin-supply = <&vdd_3v3_sys>;
 	};
 
-	vdd_3v3_hdmi: regulator@4 {
+	vdd_3v3_hdmi: regulator-hdmi {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_AVDD_HDMI_AP_GATED";
 		regulator-min-microvolt = <3300000>;
@@ -1135,7 +1135,7 @@ vdd_3v3_hdmi: regulator@4 {
 		vin-supply = <&vdd_3v3_run>;
 	};
 
-	vdd_led: regulator@5 {
+	vdd_led: regulator-led {
 		compatible = "regulator-fixed";
 		regulator-name = "+VDD_LED";
 		regulator-min-microvolt = <3300000>;
@@ -1145,7 +1145,7 @@ vdd_led: regulator@5 {
 		vin-supply = <&vdd_mux>;
 	};
 
-	vdd_5v0_ts: regulator@6 {
+	vdd_5v0_ts: regulator-ts {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_VDD_TS_SW";
 		regulator-min-microvolt = <5000000>;
@@ -1156,7 +1156,7 @@ vdd_5v0_ts: regulator@6 {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
-	vdd_usb1_vbus: regulator@7 {
+	vdd_usb1_vbus: regulator-usb1 {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_USB_HS";
 		regulator-min-microvolt = <5000000>;
@@ -1167,7 +1167,7 @@ vdd_usb1_vbus: regulator@7 {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
-	vdd_usb3_vbus: regulator@8 {
+	vdd_usb3_vbus: regulator-usb3 {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_USB_SS";
 		regulator-min-microvolt = <5000000>;
@@ -1178,7 +1178,7 @@ vdd_usb3_vbus: regulator@8 {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
-	vdd_3v3_panel: regulator@9 {
+	vdd_3v3_panel: regulator-panel {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_PANEL";
 		regulator-min-microvolt = <3300000>;
@@ -1188,7 +1188,7 @@ vdd_3v3_panel: regulator@9 {
 		vin-supply = <&vdd_3v3_run>;
 	};
 
-	vdd_3v3_lp0: regulator@10 {
+	vdd_3v3_lp0: regulator-lp0 {
 		compatible = "regulator-fixed";
 		regulator-name = "+3.3V_LP0";
 		regulator-min-microvolt = <3300000>;
@@ -1203,7 +1203,7 @@ vdd_3v3_lp0: regulator@10 {
 		vin-supply = <&vdd_3v3_sys>;
 	};
 
-	vdd_hdmi_pll: regulator@11 {
+	vdd_hdmi_pll: regulator-hdmipll {
 		compatible = "regulator-fixed";
 		regulator-name = "+1.05V_RUN_AVDD_HDMI_PLL";
 		regulator-min-microvolt = <1050000>;
@@ -1212,7 +1212,7 @@ vdd_hdmi_pll: regulator@11 {
 		vin-supply = <&vdd_1v05_run>;
 	};
 
-	vdd_5v0_hdmi: regulator@12 {
+	vdd_5v0_hdmi: regulator-hdmicon {
 		compatible = "regulator-fixed";
 		regulator-name = "+5V_HDMI_CON";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index 1aaee6f09fd8..2e6340e92fe1 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -964,7 +964,7 @@ lvds_encoder_output: endpoint {
 		};
 	};
 
-	vdd_5v0_sys: regulator@0 {
+	vdd_5v0_sys: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v0";
 		regulator-min-microvolt = <5000000>;
@@ -972,7 +972,7 @@ vdd_5v0_sys: regulator@0 {
 		regulator-always-on;
 	};
 
-	vdd_3v3_sys: regulator@1 {
+	vdd_3v3_sys: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_3v3_vs";
 		regulator-min-microvolt = <3300000>;
@@ -981,7 +981,7 @@ vdd_3v3_sys: regulator@1 {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
-	vdd_1v8_sys: regulator@2 {
+	vdd_1v8_sys: regulator-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v8_vs";
 		regulator-min-microvolt = <1800000>;
@@ -990,7 +990,7 @@ vdd_1v8_sys: regulator@2 {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
-	vdd_pnl: regulator@3 {
+	vdd_pnl: regulator-panel {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_panel";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 4d137461f3c4..a8494378c382 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -666,7 +666,7 @@ panel: panel {
 		backlight = <&backlight>;
 	};
 
-	vdd_5v0_reg: regulator@0 {
+	vdd_5v0_reg: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v0";
 		regulator-min-microvolt = <5000000>;
@@ -674,7 +674,7 @@ vdd_5v0_reg: regulator@0 {
 		regulator-always-on;
 	};
 
-	regulator@1 {
+	regulator-1v5 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v5";
 		regulator-min-microvolt = <1500000>;
@@ -682,7 +682,7 @@ regulator@1 {
 		gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
 	};
 
-	regulator@2 {
+	regulator-1v2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v2";
 		regulator-min-microvolt = <1200000>;
@@ -691,7 +691,7 @@ regulator@2 {
 		enable-active-high;
 	};
 
-	pci_vdd_reg: regulator@3 {
+	pci_vdd_reg: regulator-1v05 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v05";
 		regulator-min-microvolt = <1050000>;
@@ -700,7 +700,7 @@ pci_vdd_reg: regulator@3 {
 		enable-active-high;
 	};
 
-	vdd_pnl_reg: regulator@4 {
+	vdd_pnl_reg: regulator-pn1 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_pnl";
 		regulator-min-microvolt = <2800000>;
@@ -709,7 +709,7 @@ vdd_pnl_reg: regulator@4 {
 		enable-active-high;
 	};
 
-	vdd_bl_reg: regulator@5 {
+	vdd_bl_reg: regulator-bl {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_bl";
 		regulator-min-microvolt = <2800000>;
@@ -718,7 +718,7 @@ vdd_bl_reg: regulator@5 {
 		enable-active-high;
 	};
 
-	vdd_5v0_hdmi: regulator@6 {
+	vdd_5v0_hdmi: regulator-hdmi {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDIO_HDMI";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
index b31c9bca16e6..cb6199d7d224 100644
--- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts
@@ -92,7 +92,7 @@ sound {
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 
-	vcc_24v_reg: regulator@100 {
+	vcc_24v_reg: regulator-24v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_24v";
 		regulator-min-microvolt = <24000000>;
@@ -100,7 +100,7 @@ vcc_24v_reg: regulator@100 {
 		regulator-always-on;
 	};
 
-	vdd_5v0_reg: regulator@101 {
+	vdd_5v0_reg: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v0";
 		vin-supply = <&vcc_24v_reg>;
@@ -109,7 +109,7 @@ vdd_5v0_reg: regulator@101 {
 		regulator-always-on;
 	};
 
-	vdd_3v3_reg: regulator@102 {
+	vdd_3v3_reg: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_3v3";
 		vin-supply = <&vcc_24v_reg>;
@@ -118,7 +118,7 @@ vdd_3v3_reg: regulator@102 {
 		regulator-always-on;
 	};
 
-	vdd_1v8_reg: regulator@103 {
+	vdd_1v8_reg: regulator-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v8";
 		vin-supply = <&vdd_3v3_reg>;
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index d3d24523553e..46d81d703548 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -612,7 +612,7 @@ panel: panel {
 		backlight = <&backlight>;
 	};
 
-	p5valw_reg: regulator@0 {
+	p5valw_reg: regulator-5v0alw {
 		compatible = "regulator-fixed";
 		regulator-name = "+5valw";
 		regulator-min-microvolt = <5000000>;
@@ -620,7 +620,7 @@ p5valw_reg: regulator@0 {
 		regulator-always-on;
 	};
 
-	vdd_pnl_reg: regulator@1 {
+	vdd_pnl_reg: regulator-3v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "+3VS,vdd_pnl";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/tegra20-plutux.dts b/arch/arm/boot/dts/tegra20-plutux.dts
index 5811b7006a9b..71a8236491df 100644
--- a/arch/arm/boot/dts/tegra20-plutux.dts
+++ b/arch/arm/boot/dts/tegra20-plutux.dts
@@ -60,7 +60,7 @@ sound {
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 
-	vcc_24v_reg: regulator@100 {
+	vcc_24v_reg: regulator-24v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_24v";
 		regulator-min-microvolt = <24000000>;
@@ -68,7 +68,7 @@ vcc_24v_reg: regulator@100 {
 		regulator-always-on;
 	};
 
-	vdd_5v0_reg: regulator@101 {
+	vdd_5v0_reg: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v0";
 		vin-supply = <&vcc_24v_reg>;
@@ -77,7 +77,7 @@ vdd_5v0_reg: regulator@101 {
 		regulator-always-on;
 	};
 
-	vdd_3v3_reg: regulator@102 {
+	vdd_3v3_reg: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_3v3";
 		vin-supply = <&vcc_24v_reg>;
@@ -86,7 +86,7 @@ vdd_3v3_reg: regulator@102 {
 		regulator-always-on;
 	};
 
-	vdd_1v8_reg: regulator@103 {
+	vdd_1v8_reg: regulator-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v8";
 		vin-supply = <&vdd_3v3_reg>;
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index ffeae5da22e7..ca7adeb1fdd9 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -828,7 +828,7 @@ panel: panel {
 		ddc-i2c-bus = <&lvds_ddc>;
 	};
 
-	vdd_5v0_reg: regulator@0 {
+	vdd_5v0_reg: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v0";
 		regulator-min-microvolt = <5000000>;
@@ -836,7 +836,7 @@ vdd_5v0_reg: regulator@0 {
 		regulator-always-on;
 	};
 
-	regulator@1 {
+	regulator-1v5 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v5";
 		regulator-min-microvolt = <1500000>;
@@ -844,7 +844,7 @@ regulator@1 {
 		gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
 	};
 
-	regulator@2 {
+	regulator-1v2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v2";
 		regulator-min-microvolt = <1200000>;
@@ -853,7 +853,7 @@ regulator@2 {
 		enable-active-high;
 	};
 
-	vbus_reg: regulator@3 {
+	vbus_reg: regulator-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_vbus_wup1";
 		regulator-min-microvolt = <5000000>;
@@ -864,7 +864,7 @@ vbus_reg: regulator@3 {
 		regulator-boot-on;
 	};
 
-	vdd_pnl_reg: regulator@4 {
+	vdd_pnl_reg: regulator-pnl {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_pnl";
 		regulator-min-microvolt = <2800000>;
@@ -873,7 +873,7 @@ vdd_pnl_reg: regulator@4 {
 		enable-active-high;
 	};
 
-	vdd_bl_reg: regulator@5 {
+	vdd_bl_reg: regulator-bl {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_bl";
 		regulator-min-microvolt = <2800000>;
@@ -882,7 +882,7 @@ vdd_bl_reg: regulator@5 {
 		enable-active-high;
 	};
 
-	vdd_hdmi: regulator@6 {
+	vdd_hdmi: regulator-hdmi {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDIO_HDMI";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index d5f1a46da0bc..2ad56f84bb62 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -508,7 +508,7 @@ clk32k_in: clock-32k {
 		#clock-cells = <0>;
 	};
 
-	pci_vdd_reg: regulator@1 {
+	pci_vdd_reg: regulator-1v05 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v05";
 		regulator-min-microvolt = <1050000>;
diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dts
index 10ff09d86efa..4f41c74384b2 100644
--- a/arch/arm/boot/dts/tegra20-tec.dts
+++ b/arch/arm/boot/dts/tegra20-tec.dts
@@ -69,7 +69,7 @@ sound {
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
 
-	vcc_24v_reg: regulator@100 {
+	vcc_24v_reg: regulator-24v {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_24v";
 		regulator-min-microvolt = <24000000>;
@@ -77,7 +77,7 @@ vcc_24v_reg: regulator@100 {
 		regulator-always-on;
 	};
 
-	vdd_5v0_reg: regulator@101 {
+	vdd_5v0_reg: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v0";
 		vin-supply = <&vcc_24v_reg>;
@@ -86,7 +86,7 @@ vdd_5v0_reg: regulator@101 {
 		regulator-always-on;
 	};
 
-	vdd_3v3_reg: regulator@102 {
+	vdd_3v3_reg: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_3v3";
 		vin-supply = <&vcc_24v_reg>;
@@ -95,7 +95,7 @@ vdd_3v3_reg: regulator@102 {
 		regulator-always-on;
 	};
 
-	vdd_1v8_reg: regulator@103 {
+	vdd_1v8_reg: regulator-1v8 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v8";
 		vin-supply = <&vdd_3v3_reg>;
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 7bda2d30a748..1f4893699614 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -401,7 +401,7 @@ poweroff {
 		gpios = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_LOW>;
 	};
 
-	hdmi_vdd_reg: regulator@0 {
+	hdmi_vdd_reg: regulator-hdmi {
 		compatible = "regulator-fixed";
 		regulator-name = "avdd_hdmi";
 		regulator-min-microvolt = <3300000>;
@@ -409,7 +409,7 @@ hdmi_vdd_reg: regulator@0 {
 		regulator-always-on;
 	};
 
-	hdmi_pll_reg: regulator@1 {
+	hdmi_pll_reg: regulator-hdmipll {
 		compatible = "regulator-fixed";
 		regulator-name = "avdd_hdmi_pll";
 		regulator-min-microvolt = <1800000>;
@@ -417,7 +417,7 @@ hdmi_pll_reg: regulator@1 {
 		regulator-always-on;
 	};
 
-	vbus_reg: regulator@2 {
+	vbus_reg: regulator-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -428,7 +428,7 @@ vbus_reg: regulator@2 {
 		regulator-boot-on;
 	};
 
-	pci_clk_reg: regulator@3 {
+	pci_clk_reg: regulator-pciclk {
 		compatible = "regulator-fixed";
 		regulator-name = "pci_clk";
 		regulator-min-microvolt = <3300000>;
@@ -436,7 +436,7 @@ pci_clk_reg: regulator@3 {
 		regulator-always-on;
 	};
 
-	pci_vdd_reg: regulator@4 {
+	pci_vdd_reg: regulator-pcivdd {
 		compatible = "regulator-fixed";
 		regulator-name = "pci_vdd";
 		regulator-min-microvolt = <1050000>;
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index ef97457f1334..4284054ebd2c 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -647,7 +647,7 @@ panel: panel {
 		ddc-i2c-bus = <&lvds_ddc>;
 	};
 
-	vdd_5v0_reg: regulator@0 {
+	vdd_5v0_reg: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v0";
 		regulator-min-microvolt = <5000000>;
@@ -655,7 +655,7 @@ vdd_5v0_reg: regulator@0 {
 		regulator-always-on;
 	};
 
-	regulator@1 {
+	regulator-1v5 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v5";
 		regulator-min-microvolt = <1500000>;
@@ -663,7 +663,7 @@ regulator@1 {
 		gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
 	};
 
-	regulator@2 {
+	regulator-1v2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_1v2";
 		regulator-min-microvolt = <1200000>;
@@ -672,7 +672,7 @@ regulator@2 {
 		enable-active-high;
 	};
 
-	vdd_pnl_reg: regulator@3 {
+	vdd_pnl_reg: regulator-pnl {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_pnl";
 		regulator-min-microvolt = <2800000>;
@@ -681,7 +681,7 @@ vdd_pnl_reg: regulator@3 {
 		enable-active-high;
 	};
 
-	vdd_bl_reg: regulator@4 {
+	vdd_bl_reg: regulator-bl {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_bl";
 		regulator-min-microvolt = <2800000>;
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
index 72159eb55a3d..e6aed19a5f3b 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
@@ -1207,7 +1207,7 @@ lvds_encoder_output: endpoint {
 		};
 	};
 
-	vdd_5v0_sys: regulator@0 {
+	vdd_5v0_sys: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v0";
 		regulator-min-microvolt = <5000000>;
@@ -1216,7 +1216,7 @@ vdd_5v0_sys: regulator@0 {
 		regulator-boot-on;
 	};
 
-	vdd_3v3_sys: regulator@1 {
+	vdd_3v3_sys: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -1226,7 +1226,7 @@ vdd_3v3_sys: regulator@1 {
 		vin-supply = <&vdd_5v0_sys>;
 	};
 
-	vdd_pnl: regulator@2 {
+	vdd_pnl: regulator-panel {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_panel";
 		regulator-min-microvolt = <3300000>;
@@ -1237,7 +1237,7 @@ vdd_pnl: regulator@2 {
 		vin-supply = <&vdd_3v3_sys>;
 	};
 
-	vcc_3v3_ts: regulator@3 {
+	vcc_3v3_ts: regulator-ts {
 		compatible = "regulator-fixed";
 		regulator-name = "ldo_s-1167_3v3";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi
index 53966fa4eef2..cd28e8782f7d 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi
@@ -166,12 +166,12 @@ ldo8 {
 		};
 	};
 
-	vdd_3v3_sys: regulator@1 {
+	vdd_3v3_sys: regulator-3v3 {
 		gpio = <&pmic 3 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
-	regulator@4 {
+	regulator-usb {
 		compatible = "regulator-fixed";
 		regulator-name = "avdd_usb";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi
index 9365ae607239..ee4a3f482769 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi
@@ -143,7 +143,7 @@ vdd_core: core-regulator@60 {
 		};
 	};
 
-	vdd_3v3_sys: regulator@1 {
+	vdd_3v3_sys: regulator-3v3 {
 		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 3184a9d6227e..2ec5e47d9623 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -1985,7 +1985,7 @@ gpled2 {
 		};
 	};
 
-	vdd_5v_in_reg: regulator@0 {
+	vdd_5v_in_reg: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v_in";
 		regulator-min-microvolt = <5000000>;
@@ -1993,7 +1993,7 @@ vdd_5v_in_reg: regulator@0 {
 		regulator-always-on;
 	};
 
-	chargepump_5v_reg: regulator@1 {
+	chargepump_5v_reg: regulator-chargepump {
 		compatible = "regulator-fixed";
 		regulator-name = "chargepump_5v";
 		regulator-min-microvolt = <5000000>;
@@ -2004,7 +2004,7 @@ chargepump_5v_reg: regulator@1 {
 		gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
 	};
 
-	ddr_reg: regulator@2 {
+	ddr_reg: regulator-ddr {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_ddr";
 		regulator-min-microvolt = <1500000>;
@@ -2016,7 +2016,7 @@ ddr_reg: regulator@2 {
 		vin-supply = <&vdd_5v_in_reg>;
 	};
 
-	vdd_5v_sata_reg: regulator@3 {
+	vdd_5v_sata_reg: regulator-sata {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_5v_sata";
 		regulator-min-microvolt = <5000000>;
@@ -2028,7 +2028,7 @@ vdd_5v_sata_reg: regulator@3 {
 		vin-supply = <&vdd_5v_in_reg>;
 	};
 
-	usb1_vbus_reg: regulator@4 {
+	usb1_vbus_reg: regulator-usb1 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -2039,7 +2039,7 @@ usb1_vbus_reg: regulator@4 {
 		vin-supply = <&vdd_5v_in_reg>;
 	};
 
-	usb3_vbus_reg: regulator@5 {
+	usb3_vbus_reg: regulator-usb3 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb3_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -2050,7 +2050,7 @@ usb3_vbus_reg: regulator@5 {
 		vin-supply = <&vdd_5v_in_reg>;
 	};
 
-	sys_3v3_reg: regulator@6 {
+	sys_3v3_reg: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "sys_3v3,vdd_3v3_alw";
 		regulator-min-microvolt = <3300000>;
@@ -2062,7 +2062,7 @@ sys_3v3_reg: regulator@6 {
 		vin-supply = <&vdd_5v_in_reg>;
 	};
 
-	sys_3v3_pexs_reg: regulator@7 {
+	sys_3v3_pexs_reg: regulator-pexs {
 		compatible = "regulator-fixed";
 		regulator-name = "sys_3v3_pexs";
 		regulator-min-microvolt = <3300000>;
@@ -2074,7 +2074,7 @@ sys_3v3_pexs_reg: regulator@7 {
 		vin-supply = <&sys_3v3_reg>;
 	};
 
-	vdd_5v0_hdmi: regulator@8 {
+	vdd_5v0_hdmi: regulator-hdmi {
 		compatible = "regulator-fixed";
 		regulator-name = "+VDD_5V_HDMI";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a02.dts b/arch/arm/boot/dts/tegra30-cardhu-a02.dts
index 4899e05a0d9c..247185314f46 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a02.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a02.dts
@@ -16,7 +16,7 @@ mmc@78000400 {
 		keep-power-in-suspend;
 	};
 
-	ddr_reg: regulator@100 {
+	ddr_reg: regulator-ddr {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_ddr";
 		regulator-min-microvolt = <1500000>;
@@ -27,7 +27,7 @@ ddr_reg: regulator@100 {
 		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
 	};
 
-	sys_3v3_reg: regulator@101 {
+	sys_3v3_reg: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "sys_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -38,7 +38,7 @@ sys_3v3_reg: regulator@101 {
 		gpio = <&pmic 7 GPIO_ACTIVE_HIGH>;
 	};
 
-	usb1_vbus_reg: regulator@102 {
+	usb1_vbus_reg: regulator-usb1 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -49,7 +49,7 @@ usb1_vbus_reg: regulator@102 {
 		vin-supply = <&vdd_5v0_reg>;
 	};
 
-	usb3_vbus_reg: regulator@103 {
+	usb3_vbus_reg: regulator-usb3 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb3_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -60,7 +60,7 @@ usb3_vbus_reg: regulator@103 {
 		vin-supply = <&vdd_5v0_reg>;
 	};
 
-	vdd_5v0_reg: regulator@104 {
+	vdd_5v0_reg: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "5v0";
 		regulator-min-microvolt = <5000000>;
@@ -69,7 +69,7 @@ vdd_5v0_reg: regulator@104 {
 		gpio = <&pmic 2 GPIO_ACTIVE_HIGH>;
 	};
 
-	vdd_bl_reg: regulator@105 {
+	vdd_bl_reg: regulator-bl {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_bl";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu-a04.dts b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
index a11028b8b67b..2911f08863a0 100644
--- a/arch/arm/boot/dts/tegra30-cardhu-a04.dts
+++ b/arch/arm/boot/dts/tegra30-cardhu-a04.dts
@@ -16,7 +16,7 @@ mmc@78000400 {
 		keep-power-in-suspend;
 	};
 
-	ddr_reg: regulator@100 {
+	ddr_reg: regulator-ddr {
 		compatible = "regulator-fixed";
 		regulator-name = "ddr";
 		regulator-min-microvolt = <1500000>;
@@ -27,7 +27,7 @@ ddr_reg: regulator@100 {
 		gpio = <&pmic 7 GPIO_ACTIVE_HIGH>;
 	};
 
-	sys_3v3_reg: regulator@101 {
+	sys_3v3_reg: regulator-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "sys_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -38,7 +38,7 @@ sys_3v3_reg: regulator@101 {
 		gpio = <&pmic 6 GPIO_ACTIVE_HIGH>;
 	};
 
-	usb1_vbus_reg: regulator@102 {
+	usb1_vbus_reg: regulator-usb1 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb1_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -49,7 +49,7 @@ usb1_vbus_reg: regulator@102 {
 		vin-supply = <&vdd_5v0_reg>;
 	};
 
-	usb3_vbus_reg: regulator@103 {
+	usb3_vbus_reg: regulator-usb3 {
 		compatible = "regulator-fixed";
 		regulator-name = "usb3_vbus";
 		regulator-min-microvolt = <5000000>;
@@ -60,7 +60,7 @@ usb3_vbus_reg: regulator@103 {
 		vin-supply = <&vdd_5v0_reg>;
 	};
 
-	vdd_5v0_reg: regulator@104 {
+	vdd_5v0_reg: regulator-5v0 {
 		compatible = "regulator-fixed";
 		regulator-name = "5v0";
 		regulator-min-microvolt = <5000000>;
@@ -69,7 +69,7 @@ vdd_5v0_reg: regulator@104 {
 		gpio = <&pmic 8 GPIO_ACTIVE_HIGH>;
 	};
 
-	vdd_bl_reg: regulator@105 {
+	vdd_bl_reg: regulator-bl {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_bl";
 		regulator-min-microvolt = <5000000>;
@@ -80,7 +80,7 @@ vdd_bl_reg: regulator@105 {
 		gpio = <&gpio TEGRA_GPIO(DD, 2) GPIO_ACTIVE_HIGH>;
 	};
 
-	vdd_bl2_reg: regulator@106 {
+	vdd_bl2_reg: regulator-bl2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_bl2";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 3a7621a2efde..d2f6121049a4 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -475,7 +475,7 @@ panel: panel {
 		backlight = <&backlight>;
 	};
 
-	vdd_ac_bat_reg: regulator@0 {
+	vdd_ac_bat_reg: regulator-acbat {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_ac_bat";
 		regulator-min-microvolt = <5000000>;
@@ -483,7 +483,7 @@ vdd_ac_bat_reg: regulator@0 {
 		regulator-always-on;
 	};
 
-	cam_1v8_reg: regulator@1 {
+	cam_1v8_reg: regulator-cam {
 		compatible = "regulator-fixed";
 		regulator-name = "cam_1v8";
 		regulator-min-microvolt = <1800000>;
@@ -493,7 +493,7 @@ cam_1v8_reg: regulator@1 {
 		vin-supply = <&vio_reg>;
 	};
 
-	cp_5v_reg: regulator@2 {
+	cp_5v_reg: regulator-5v0cp {
 		compatible = "regulator-fixed";
 		regulator-name = "cp_5v";
 		regulator-min-microvolt = <5000000>;
@@ -504,7 +504,7 @@ cp_5v_reg: regulator@2 {
 		gpio = <&pmic 0 GPIO_ACTIVE_HIGH>;
 	};
 
-	emmc_3v3_reg: regulator@3 {
+	emmc_3v3_reg: regulator-emmc {
 		compatible = "regulator-fixed";
 		regulator-name = "emmc_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -516,7 +516,7 @@ emmc_3v3_reg: regulator@3 {
 		vin-supply = <&sys_3v3_reg>;
 	};
 
-	modem_3v3_reg: regulator@4 {
+	modem_3v3_reg: regulator-modem {
 		compatible = "regulator-fixed";
 		regulator-name = "modem_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -525,7 +525,7 @@ modem_3v3_reg: regulator@4 {
 		gpio = <&gpio TEGRA_GPIO(D, 6) GPIO_ACTIVE_HIGH>;
 	};
 
-	pex_hvdd_3v3_reg: regulator@5 {
+	pex_hvdd_3v3_reg: regulator-pex {
 		compatible = "regulator-fixed";
 		regulator-name = "pex_hvdd_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -535,7 +535,7 @@ pex_hvdd_3v3_reg: regulator@5 {
 		vin-supply = <&sys_3v3_reg>;
 	};
 
-	vdd_cam1_ldo_reg: regulator@6 {
+	vdd_cam1_ldo_reg: regulator-cam1 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_cam1_ldo";
 		regulator-min-microvolt = <2800000>;
@@ -545,7 +545,7 @@ vdd_cam1_ldo_reg: regulator@6 {
 		vin-supply = <&sys_3v3_reg>;
 	};
 
-	vdd_cam2_ldo_reg: regulator@7 {
+	vdd_cam2_ldo_reg: regulator-cam2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_cam2_ldo";
 		regulator-min-microvolt = <2800000>;
@@ -555,7 +555,7 @@ vdd_cam2_ldo_reg: regulator@7 {
 		vin-supply = <&sys_3v3_reg>;
 	};
 
-	vdd_cam3_ldo_reg: regulator@8 {
+	vdd_cam3_ldo_reg: regulator-cam3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_cam3_ldo";
 		regulator-min-microvolt = <3300000>;
@@ -565,7 +565,7 @@ vdd_cam3_ldo_reg: regulator@8 {
 		vin-supply = <&sys_3v3_reg>;
 	};
 
-	vdd_com_reg: regulator@9 {
+	vdd_com_reg: regulator-com {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_com";
 		regulator-min-microvolt = <3300000>;
@@ -577,7 +577,7 @@ vdd_com_reg: regulator@9 {
 		vin-supply = <&sys_3v3_reg>;
 	};
 
-	vdd_fuse_3v3_reg: regulator@10 {
+	vdd_fuse_3v3_reg: regulator-fuse {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_fuse_3v3";
 		regulator-min-microvolt = <3300000>;
@@ -587,7 +587,7 @@ vdd_fuse_3v3_reg: regulator@10 {
 		vin-supply = <&sys_3v3_reg>;
 	};
 
-	vdd_pnl1_reg: regulator@11 {
+	vdd_pnl1_reg: regulator-pnl1 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_pnl1";
 		regulator-min-microvolt = <3300000>;
@@ -599,7 +599,7 @@ vdd_pnl1_reg: regulator@11 {
 		vin-supply = <&sys_3v3_reg>;
 	};
 
-	vdd_vid_reg: regulator@12 {
+	vdd_vid_reg: regulator-vid {
 		compatible = "regulator-fixed";
 		regulator-name = "vddio_vid";
 		regulator-min-microvolt = <5000000>;
-- 
2.33.1

