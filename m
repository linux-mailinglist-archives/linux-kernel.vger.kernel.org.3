Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE89464193
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345087AbhK3WoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344799AbhK3WmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:42:12 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFCBC061748;
        Tue, 30 Nov 2021 14:38:50 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id j18so30885885ljc.12;
        Tue, 30 Nov 2021 14:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oy3zwV/g5imosVMvt8kebzh3+2gNs9w4Z9AIdIXw0XA=;
        b=b/pAzPK119FBu9J2zOqiPkB400kVTHuCKWTy3WLB+DkZ2ZRhKO7Nz+BwGTJTJwtl2D
         LYPONfmGW7lIc9TLvpNbycjc7aB8xkqFVcSfhngcnAKH8KDFrix7Lx4jnr0Zi1ID4sY0
         v7cjiIY4a4DUEwMWpkY6D51vgk8L4gAjLmFYoKXZmfTufy8lxPS+a9bgXct1F7PZxRke
         KOLX6Ui/lMrGgs3igyvD/J+rZEojQs+Uhvs+kmsRGwHWRJWprUfN3+/8A6ankAOtNhFz
         9TgVpwWf8eSXrTMj+MT/NJ5jFMxyYSMPoFtJZWe89OHDzc7RVfy+B8EeOz74k015Yuyh
         JWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oy3zwV/g5imosVMvt8kebzh3+2gNs9w4Z9AIdIXw0XA=;
        b=wZvbE0tcWDErPN0PP6uCa3grEpKu+5sLMAADbPkQEua9oQ+aIKLKrBGqeZiiKqDn6f
         1DS8eDIKPLl1Hisl0B+6/zfrvB/CGyZuNVIjrbzpedxpD6xULVxLr5aMgJQGQjAX+lsB
         Ct5C2tHKRxqlCPj2T2q+hHGiCZqW+d65QhncXPesM9Ddxvi/ZmQJIHoAkPyiXi1MfJ7s
         Lt2jE5Nf0nHhPQPwVgoUKz37aba3IhDsMt7GjYcenav4UQaMGz0ejpS3NijEyYTZq3rX
         hTEg3FSeRNh15tLP2+GTVl+HnAJEwLm395KTYq0/KqDcYs6PYeXSovK1HNPi3Hj7mScH
         JUOw==
X-Gm-Message-State: AOAM532WhPycS9uCCbl8Fkl389qwms6ty0jWJjKMBfNBYUzrIiJQbKaO
        AmUSE6dxyo++uXD7kkP6AJk=
X-Google-Smtp-Source: ABdhPJy/92YDYBUu657tIYU2NFVZTVGPjucJbr9nC8xExZOmXB1AfkhzO69cKrgDG5Pz8XFhK6Ajrg==
X-Received: by 2002:a2e:98d3:: with SMTP id s19mr1634771ljj.59.1638311928487;
        Tue, 30 Nov 2021 14:38:48 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id y11sm1820518ljd.117.2021.11.30.14.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:38:47 -0800 (PST)
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
Subject: [PATCH v4 10/24] ARM: tegra: Add device-tree for ASUS Transformer Pad TF300TG
Date:   Wed,  1 Dec 2021 01:38:06 +0300
Message-Id: <20211130223820.23609-11-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130223820.23609-1-digetx@gmail.com>
References: <20211130223820.23609-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Svyatoslav Ryhel <clamor95@gmail.com>

Add device-tree for ASUS Transformer Pad TF300TG, which is NVIDIA
Tegra30-based tablet device, a variant of TF300T that has 3g modem.

Co-developed-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/Makefile                 |    1 +
 arch/arm/boot/dts/tegra30-asus-tf300tg.dts | 1072 ++++++++++++++++++++
 2 files changed, 1073 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra30-asus-tf300tg.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 85477066bb2d..fcbcaed0c2da 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1323,6 +1323,7 @@ dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += \
 	tegra30-asus-nexus7-tilapia-E1565.dtb \
 	tegra30-asus-tf201.dtb \
 	tegra30-asus-tf300t.dtb \
+	tegra30-asus-tf300tg.dtb \
 	tegra30-beaver.dtb \
 	tegra30-cardhu-a02.dtb \
 	tegra30-cardhu-a04.dtb \
diff --git a/arch/arm/boot/dts/tegra30-asus-tf300tg.dts b/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
new file mode 100644
index 000000000000..e1509b48a4fa
--- /dev/null
+++ b/arch/arm/boot/dts/tegra30-asus-tf300tg.dts
@@ -0,0 +1,1072 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "tegra30-asus-transformer-common.dtsi"
+#include "tegra30-asus-lvds-display.dtsi"
+
+/ {
+	model = "Asus Transformer Pad 3G TF300TG";
+	compatible = "asus,tf300tg", "nvidia,tegra30";
+
+	gpio@6000d000 {
+		tf300tg-init-hog {
+			gpio-hog;
+			gpios = <TEGRA_GPIO(C, 6) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(D, 2) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(P, 1) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(X, 5) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(R, 3) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(U, 5) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(X, 7) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(X, 0) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(Y, 2) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(Y, 3) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(EE, 1) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(R, 7) GPIO_ACTIVE_HIGH>,
+				<TEGRA_GPIO(U, 3) GPIO_ACTIVE_HIGH>;
+			output-low;
+		};
+	};
+
+	pinmux@70000868 {
+		state_default: pinmux {
+			pbb3 {
+				nvidia,pins = "pbb3";
+				nvidia,function = "vgp3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pbb7 {
+				nvidia,pins = "pbb7";
+				nvidia,function = "i2s4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			gmi_cs4_n_pk2 {
+				nvidia,pins = "gmi_cs4_n_pk2";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			lcd_pwr2_pc6 {
+				nvidia,pins = "lcd_pwr2_pc6",
+						"lcd_dc1_pd2";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb_row7_pr7 {
+				nvidia,pins = "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			spi2_cs2_n_pw3 {
+				nvidia,pins = "spi2_cs2_n_pw3";
+				nvidia,function = "spi2";
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+			};
+			dap3_din_pp1 {
+				nvidia,pins = "dap3_din_pp1";
+				nvidia,function = "i2s2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			spi1_sck_px5 {
+				nvidia,pins = "spi1_sck_px5";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pu5 {
+				nvidia,pins = "pu5";
+				nvidia,function = "pwm2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			spi2_mosi_px0 {
+				nvidia,pins = "spi2_mosi_px0";
+				nvidia,function = "spi2";
+			};
+			spi1_miso_px7 {
+				nvidia,pins = "spi1_miso_px7";
+				nvidia,function = "spi1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			clk3_req_pee1 {
+				nvidia,pins = "clk3_req_pee1";
+				nvidia,function = "dev3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			ulpi_nxt_py2 {
+				nvidia,pins = "ulpi_nxt_py2";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			ulpi_stp_py3 {
+				nvidia,pins = "ulpi_stp_py3";
+				nvidia,function = "uartd";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			pu3 {
+				nvidia,pins = "pu3";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap1_din_pn1 {
+				nvidia,pins = "dap1_din_pn1";
+				nvidia,function = "i2s0";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+		};
+	};
+
+	uartc: serial@70006200 {
+		/* Azurewave AW-NH615 BCM4329B1 */
+		bluetooth {
+			compatible = "brcm,bcm4329-bt";
+		};
+	};
+
+	i2c2: i2c@7000c400 {
+		/* Elantech EKTH1036 touchscreen */
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
+			touchscreen-size-x = <2240>;
+			touchscreen-size-y = <1408>;
+			touchscreen-inverted-y;
+		};
+	};
+
+	i2c3: i2c@7000c500 {
+		clock-frequency = <400000>;
+
+		magnetometer@e {
+			mount-matrix =   "1",  "0",  "0",
+					 "0", "-1",  "0",
+					 "0",  "0", "-1";
+		};
+
+		gyroscope@68 {
+			mount-matrix =   "-1",  "0",  "0",
+					  "0",  "1",  "0",
+					  "0",  "0", "-1";
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
+	i2c5: i2c@7000d000 {
+		/* Realtek ALC5631 audio codec */
+		rt5631: audio-codec@1a {
+			compatible = "realtek,rt5631";
+			reg = <0x1a>;
+		};
+	};
+
+	display-panel {
+		compatible = "innolux,g101ice-l01";
+	};
+
+	memory-controller@7000f000 {
+		emc-timings-0 {
+			/* Elpida 1GB 667MHZ */
+			nvidia,ram-code = <0>;
+
+			timing-25500000 {
+				clock-frequency = <25500000>;
+
+				nvidia,emem-configuration = < 0x00020001 0xc0000020
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0502 0x74830303 0x001f0000 >;
+			};
+
+			timing-51000000 {
+				clock-frequency = <51000000>;
+
+				nvidia,emem-configuration = < 0x00010001 0xc0000020
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0502 0x73430303 0x001f0000 >;
+			};
+
+			timing-102000000 {
+				clock-frequency = <102000000>;
+
+				nvidia,emem-configuration = < 0x00000001 0xc0000030
+					0x00000001 0x00000001 0x00000003 0x00000000
+					0x00000001 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0503 0x72830504 0x001f0000 >;
+			};
+
+			timing-204000000 {
+				clock-frequency = <204000000>;
+
+				nvidia,emem-configuration = < 0x00000003 0xc0000025
+					0x00000001 0x00000001 0x00000005 0x00000002
+					0x00000003 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0505 0x72440a06 0x001f0000 >;
+			};
+
+			timing-333500000 {
+				clock-frequency = <333500000>;
+
+				nvidia,emem-configuration = < 0x00000005 0xc000003d
+					0x00000001 0x00000002 0x00000008 0x00000004
+					0x00000004 0x00000001 0x00000002 0x00000007
+					0x00000002 0x00000002 0x00000003 0x00000006
+					0x06030202 0x000b0608 0x70850f09 0x001f0000 >;
+			};
+
+			timing-667000000 {
+				clock-frequency = <667000000>;
+
+				nvidia,emem-configuration = < 0x0000000a 0xc0000079
+					0x00000003 0x00000004 0x00000010 0x0000000b
+					0x0000000a 0x00000001 0x00000003 0x0000000b
+					0x00000002 0x00000002 0x00000004 0x00000008
+					0x08040202 0x00130b10 0x70ea1f11 0x001f0000 >;
+			};
+		};
+
+		emc-timings-1 {
+			/* Hynix 1GB 667MHZ */
+			nvidia,ram-code = <1>;
+
+			timing-25500000 {
+				clock-frequency = <25500000>;
+
+				nvidia,emem-configuration = < 0x00020001 0xc0000020
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0502 0x74830303 0x001f0000 >;
+			};
+
+			timing-51000000 {
+				clock-frequency = <51000000>;
+
+				nvidia,emem-configuration = < 0x00010001 0xc0000020
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0502 0x73430303 0x001f0000 >;
+			};
+
+			timing-102000000 {
+				clock-frequency = <102000000>;
+
+				nvidia,emem-configuration = < 0x00000001 0xc0000030
+					0x00000001 0x00000001 0x00000003 0x00000000
+					0x00000001 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0503 0x72830504 0x001f0000 >;
+			};
+
+			timing-204000000 {
+				clock-frequency = <204000000>;
+
+				nvidia,emem-configuration = < 0x00000003 0xc0000025
+					0x00000001 0x00000001 0x00000005 0x00000002
+					0x00000003 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0505 0x72440a06 0x001f0000 >;
+			};
+
+			timing-333500000 {
+				clock-frequency = <333500000>;
+
+				nvidia,emem-configuration = < 0x00000005 0xc000003d
+					0x00000001 0x00000002 0x00000008 0x00000004
+					0x00000004 0x00000001 0x00000002 0x00000007
+					0x00000002 0x00000002 0x00000003 0x00000006
+					0x06030202 0x000b0608 0x70850f09 0x001f0000 >;
+			};
+
+			timing-667000000 {
+				clock-frequency = <667000000>;
+
+				nvidia,emem-configuration = < 0x0000000a 0xc0000079
+					0x00000003 0x00000004 0x00000010 0x0000000b
+					0x0000000a 0x00000001 0x00000003 0x0000000b
+					0x00000002 0x00000002 0x00000004 0x00000008
+					0x08040202 0x00130b10 0x70ea1f11 0x001f0000 >;
+			};
+		};
+
+		emc-timings-2 {
+			/* Micron 1GB 667MHZ */
+			nvidia,ram-code = <2>;
+
+			timing-25500000 {
+				clock-frequency = <25500000>;
+
+				nvidia,emem-configuration = < 0x00020001 0xc0000020
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0502 0x74830303 0x001f0000 >;
+			};
+
+			timing-51000000 {
+				clock-frequency = <51000000>;
+
+				nvidia,emem-configuration = < 0x00010001 0xc0000020
+					0x00000001 0x00000001 0x00000002 0x00000000
+					0x00000001 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0502 0x73430303 0x001f0000 >;
+			};
+
+			timing-102000000 {
+				clock-frequency = <102000000>;
+
+				nvidia,emem-configuration = < 0x00000001 0xc0000030
+					0x00000001 0x00000001 0x00000003 0x00000000
+					0x00000001 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0503 0x72830504 0x001f0000 >;
+			};
+
+			timing-204000000 {
+				clock-frequency = <204000000>;
+
+				nvidia,emem-configuration = < 0x00000003 0xc0000025
+					0x00000001 0x00000001 0x00000005 0x00000002
+					0x00000003 0x00000001 0x00000003 0x00000008
+					0x00000002 0x00000001 0x00000002 0x00000006
+					0x06020102 0x000a0505 0x72440a06 0x001f0000 >;
+			};
+
+			timing-333500000 {
+				clock-frequency = <333500000>;
+
+				nvidia,emem-configuration = < 0x00000005 0x8000003d
+					0x00000001 0x00000002 0x00000008 0x00000004
+					0x00000004 0x00000001 0x00000002 0x00000007
+					0x00000002 0x00000002 0x00000003 0x00000006
+					0x06030202 0x000b0608 0x70850f09 0x001f0000 >;
+			};
+
+			timing-667000000 {
+				clock-frequency = <667000000>;
+
+				nvidia,emem-configuration = < 0x0000000a 0x80000079
+					0x00000003 0x00000004 0x00000010 0x0000000a
+					0x0000000a 0x00000001 0x00000003 0x0000000b
+					0x00000002 0x00000002 0x00000004 0x00000008
+					0x08040202 0x00130b10 0x70ea1f11 0x001f0000 >;
+			};
+		};
+	};
+
+	memory-controller@7000f400 {
+		emc-timings-0 {
+			/* Elpida 1GB 667MHZ */
+			nvidia,ram-code = <0>;
+
+			timing-25500000 {
+				clock-frequency = <25500000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100003>;
+				nvidia,emc-mode-2 = <0x80200048>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000001
+					0x00000004 0x00000000 0x00000000 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000000
+					0x00000000 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x000000c0 0x00000000 0x00000030
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000005 0x00000005
+					0x00000004 0x00000001 0x00000000 0x00000004
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
+				nvidia,emc-mode-2 = <0x80200048>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000002
+					0x00000008 0x00000001 0x00000000 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000000
+					0x00000000 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x00000181 0x00000000 0x00000060
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000009 0x00000009
+					0x00000004 0x00000002 0x00000000 0x00000004
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
+				nvidia,emc-mode-2 = <0x80200048>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000005
+					0x00000010 0x00000003 0x00000001 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000001
+					0x00000001 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x00000303 0x00000000 0x000000c0
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000012 0x00000012
+					0x00000004 0x00000004 0x00000000 0x00000004
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
+				nvidia,emc-mode-2 = <0x80200048>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x0000000a
+					0x00000020 0x00000007 0x00000002 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000002
+					0x00000002 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000006 0x00000004 0x0000000a
+					0x0000000b 0x00000607 0x00000000 0x00000181
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000023 0x00000023
+					0x00000004 0x00000007 0x00000000 0x00000004
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
+			timing-333500000 {
+				clock-frequency = <333500000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100002>;
+				nvidia,emc-mode-2 = <0x80200040>;
+				nvidia,emc-mode-reset = <0x80000321>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+
+				nvidia,emc-configuration =  < 0x0000000f
+					0x00000034 0x0000000a 0x00000003 0x00000003
+					0x00000008 0x00000002 0x00000009 0x00000003
+					0x00000003 0x00000002 0x00000001 0x00000000
+					0x00000004 0x00000006 0x00000004 0x0000000a
+					0x0000000c 0x000009e9 0x00000000 0x0000027a
+					0x00000001 0x00000008 0x00000001 0x00000000
+					0x00000007 0x0000000e 0x00000039 0x00000200
+					0x00000004 0x0000000a 0x00000000 0x00000004
+					0x00000005 0x00000a2a 0x00000000 0x00000004
+					0x00000000 0x00000000 0x00007088 0x002600a4
+					0x00008000 0x0003c000 0x0003c000 0x0003c000
+					0x0003c000 0x00014000 0x00014000 0x00014000
+					0x00014000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00050000 0x00050000 0x00050000
+					0x00050000 0x000002a0 0x0800013d 0x00000000
+					0x77fff884 0x01f1f508 0x05057404 0x54000007
+					0x080001e8 0x08000021 0x00000802 0x00020000
+					0x00000100 0x018b000c 0xa0f10000 0x00000000
+					0x00000000 0x800014d4 0xe8000000 0xff00ff89 >;
+			};
+
+			timing-667000000 {
+				clock-frequency = <667000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100002>;
+				nvidia,emc-mode-2 = <0x80200058>;
+				nvidia,emc-mode-reset = <0x80000b71>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x0000001f
+					0x00000069 0x00000017 0x00000007 0x00000005
+					0x0000000c 0x00000003 0x00000011 0x00000007
+					0x00000007 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000b 0x00000009 0x0000000b
+					0x00000011 0x00001412 0x00000000 0x00000504
+					0x00000002 0x0000000e 0x00000001 0x00000000
+					0x0000000c 0x00000016 0x00000072 0x00000200
+					0x00000005 0x00000015 0x00000000 0x00000006
+					0x00000007 0x00001453 0x0000000c 0x00000004
+					0x00000000 0x00000000 0x00005088 0xf00b0191
+					0x00008000 0x0000000c 0x0000000c 0x0000000c
+					0x0000000c 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x00018000 0x00018000 0x00018000
+					0x00018000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x0000000c 0x0000000c 0x0000000c
+					0x0000000c 0x000002a0 0x0a00013d 0x22220000
+					0x77fff884 0x01f1f501 0x07077404 0x54000000
+					0x080001e8 0x0a000021 0x00000802 0x00020000
+					0x00000100 0x0156000c 0xa0f10000 0x00000000
+					0x00000000 0x800028a5 0xe8000000 0xff00ff49 >;
+			};
+		};
+
+		emc-timings-1 {
+			/* Hynix 1GB 667MHZ */
+			nvidia,ram-code = <1>;
+
+			timing-25500000 {
+				clock-frequency = <25500000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100003>;
+				nvidia,emc-mode-2 = <0x80200048>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000001
+					0x00000004 0x00000000 0x00000000 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000000
+					0x00000000 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x000000c0 0x00000000 0x00000030
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000005 0x00000005
+					0x00000004 0x00000001 0x00000000 0x00000004
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
+				nvidia,emc-mode-2 = <0x80200048>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000002
+					0x00000008 0x00000001 0x00000000 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000000
+					0x00000000 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x00000181 0x00000000 0x00000060
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000009 0x00000009
+					0x00000004 0x00000002 0x00000000 0x00000004
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
+				nvidia,emc-mode-2 = <0x80200048>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000005
+					0x00000010 0x00000003 0x00000001 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000001
+					0x00000001 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x00000303 0x00000000 0x000000c0
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000012 0x00000012
+					0x00000004 0x00000004 0x00000000 0x00000004
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
+				nvidia,emc-mode-2 = <0x80200048>;
+				nvidia,emc-mode-reset = <0x80001221>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-dyn-self-ref;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x0000000a
+					0x00000020 0x00000007 0x00000002 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000002
+					0x00000002 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000006 0x00000004 0x0000000a
+					0x0000000b 0x00000607 0x00000000 0x00000181
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000023 0x00000023
+					0x00000004 0x00000007 0x00000000 0x00000004
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
+			timing-333500000 {
+				clock-frequency = <333500000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100002>;
+				nvidia,emc-mode-2 = <0x80200040>;
+				nvidia,emc-mode-reset = <0x80000321>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+
+				nvidia,emc-configuration =  < 0x0000000f
+					0x00000034 0x0000000a 0x00000003 0x00000003
+					0x00000008 0x00000002 0x00000009 0x00000003
+					0x00000003 0x00000002 0x00000001 0x00000000
+					0x00000004 0x00000006 0x00000004 0x0000000a
+					0x0000000c 0x000009e9 0x00000000 0x0000027a
+					0x00000001 0x00000008 0x00000001 0x00000000
+					0x00000007 0x0000000e 0x00000039 0x00000200
+					0x00000004 0x0000000a 0x00000000 0x00000004
+					0x00000005 0x00000a2a 0x00000000 0x00000004
+					0x00000000 0x00000000 0x00007088 0x002600a4
+					0x00008000 0x0003c000 0x0003c000 0x0003c000
+					0x0003c000 0x00014000 0x00014000 0x00014000
+					0x00014000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00048000 0x00048000 0x00048000
+					0x00048000 0x000002a0 0x0800013d 0x00000000
+					0x77fff884 0x01f1f508 0x05057404 0x54000007
+					0x080001e8 0x08000021 0x00000802 0x00020000
+					0x00000100 0x018b000c 0xa0f10000 0x00000000
+					0x00000000 0x800014d4 0xe8000000 0xff00ff89 >;
+			};
+
+			timing-667000000 {
+				clock-frequency = <667000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100002>;
+				nvidia,emc-mode-2 = <0x80200058>;
+				nvidia,emc-mode-reset = <0x80000b71>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x00000020
+					0x00000069 0x00000017 0x00000007 0x00000005
+					0x0000000c 0x00000003 0x00000011 0x00000007
+					0x00000007 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000b 0x00000009 0x0000000b
+					0x00000011 0x00001412 0x00000000 0x00000504
+					0x00000002 0x0000000e 0x00000001 0x00000000
+					0x0000000c 0x00000016 0x00000072 0x00000200
+					0x00000005 0x00000015 0x00000000 0x00000006
+					0x00000007 0x00001453 0x0000000c 0x00000004
+					0x00000000 0x00000000 0x00005088 0xf00b0191
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
+					0x00000100 0x0156000c 0xa0f10000 0x00000000
+					0x00000000 0x800028a5 0xe8000000 0xff00ff49 >;
+			};
+		};
+
+		emc-timings-2 {
+			/* Micron 1GB 667MHZ */
+			nvidia,ram-code = <2>;
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
+					0x00000004 0x00000000 0x00000000 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000000
+					0x00000000 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x000000c0 0x00000000 0x00000030
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000005 0x00000005
+					0x00000004 0x00000001 0x00000000 0x00000004
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
+					0x00000008 0x00000001 0x00000000 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000000
+					0x00000000 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x00000181 0x00000000 0x00000060
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000009 0x00000009
+					0x00000004 0x00000002 0x00000000 0x00000004
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
+					0x00000010 0x00000003 0x00000001 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000001
+					0x00000001 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000005 0x00000004 0x0000000a
+					0x0000000b 0x00000303 0x00000000 0x000000c0
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000012 0x00000012
+					0x00000004 0x00000004 0x00000000 0x00000004
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
+					0x00000020 0x00000007 0x00000002 0x00000002
+					0x0000000a 0x00000005 0x0000000b 0x00000002
+					0x00000002 0x00000003 0x00000001 0x00000000
+					0x00000005 0x00000006 0x00000004 0x0000000a
+					0x0000000b 0x00000607 0x00000000 0x00000181
+					0x00000002 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000f 0x00000023 0x00000023
+					0x00000004 0x00000007 0x00000000 0x00000004
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
+			timing-333500000 {
+				clock-frequency = <333500000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100002>;
+				nvidia,emc-mode-2 = <0x80200000>;
+				nvidia,emc-mode-reset = <0x80000321>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+
+				nvidia,emc-configuration =  < 0x0000000f
+					0x00000034 0x0000000a 0x00000003 0x00000003
+					0x00000008 0x00000002 0x00000009 0x00000003
+					0x00000003 0x00000002 0x00000001 0x00000000
+					0x00000004 0x00000006 0x00000004 0x0000000a
+					0x0000000c 0x000009e9 0x00000000 0x0000027a
+					0x00000001 0x00000008 0x00000001 0x00000000
+					0x00000007 0x0000000e 0x00000039 0x00000200
+					0x00000004 0x0000000a 0x00000000 0x00000004
+					0x00000005 0x00000a2a 0x00000000 0x00000004
+					0x00000000 0x00000000 0x00007088 0x002600a4
+					0x00008000 0x0003c000 0x0003c000 0x0003c000
+					0x0003c000 0x00014000 0x00014000 0x00014000
+					0x00014000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00040000 0x00040000 0x00040000
+					0x00040000 0x000002a0 0x0800013d 0x00000000
+					0x77fff884 0x01f1f508 0x05057404 0x54000007
+					0x080001e8 0x08000021 0x00000802 0x00020000
+					0x00000100 0x018b000c 0xa0f10000 0x00000000
+					0x00000000 0x800014d4 0xe8000000 0xff00ff89 >;
+			};
+
+			timing-667000000 {
+				clock-frequency = <667000000>;
+
+				nvidia,emc-auto-cal-interval = <0x001fffff>;
+				nvidia,emc-mode-1 = <0x80100002>;
+				nvidia,emc-mode-2 = <0x80200018>;
+				nvidia,emc-mode-reset = <0x80000b71>;
+				nvidia,emc-zcal-cnt-long = <0x00000040>;
+				nvidia,emc-cfg-periodic-qrst;
+
+				nvidia,emc-configuration =  < 0x0000001f
+					0x00000069 0x00000016 0x00000007 0x00000005
+					0x0000000c 0x00000003 0x00000011 0x00000007
+					0x00000007 0x00000002 0x00000001 0x00000000
+					0x00000007 0x0000000b 0x00000009 0x0000000b
+					0x00000011 0x00001412 0x00000000 0x00000504
+					0x00000002 0x0000000e 0x00000001 0x00000000
+					0x0000000c 0x00000016 0x00000072 0x00000200
+					0x00000005 0x00000015 0x00000000 0x00000006
+					0x00000007 0x00001453 0x0000000c 0x00000004
+					0x00000000 0x00000000 0x00005088 0xf00b0191
+					0x00008000 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x00000000 0x00000000 0x00000000
+					0x00000000 0x0000000a 0x0000000a 0x0000000a
+					0x0000000a 0x000002a0 0x0600013d 0x22220000
+					0x77fff884 0x01f1f501 0x07077404 0x54000000
+					0x080001e8 0x08000021 0x00000802 0x00020000
+					0x00000100 0x0156000c 0xa0f10000 0x00000000
+					0x00000000 0x800028a5 0xe8000000 0xff00ff49 >;
+			};
+		};
+	};
+};
+
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp-750000000-1300;
+	/delete-node/ opp-800000000-1300;
+	/delete-node/ opp-900000000-1350;
+};
+
+&emc_bw_dfs_opp_table {
+	/delete-node/ opp-750000000;
+	/delete-node/ opp-800000000;
+	/delete-node/ opp-900000000;
+};
-- 
2.33.1

