Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD2471670
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhLKVOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhLKVO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B0EC061714;
        Sat, 11 Dec 2021 13:14:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id cf39so12010293lfb.8;
        Sat, 11 Dec 2021 13:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dOoVddJW1k7frpAQCFchHnyAy85qP/+y2+rbgop9n1Y=;
        b=HfnkpsS+jbFPu/h/xlP6mSOS3aCw/7IB8n6IxtTTAuO3cptCoXt48sv8SGyOMeselQ
         1mYQMSZV0I/ipSwjZes9ADMuHjBeVQYZPuS4CqIHPYMwYxd4b8iMrifhjbfvkT+I9IiR
         frkcX92aVnIz2s1n2fm/BeGzy8so24J4g8p0iuBTtkGxZgOZwDiXYXRBBnF7RiyXX7qp
         wKpFMY9Vxwl7CiKWva2ZzeHhTGS/vudksmTsjgEjgnQJyI4To9aa18IgOe+mXUh65Thv
         qvhezgTIbSuNK0fIQxazdpHl6ml9LXgCWW/YCh4QvdhDGDraFaq8z7Htk8r9MqUOXWAF
         PqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dOoVddJW1k7frpAQCFchHnyAy85qP/+y2+rbgop9n1Y=;
        b=QoV4aKeNufQDEyUQLZNKKD3AhGm0N5qytZ/xm53ilnfwBZ7HTMUuvIjkBQbt8kKvlw
         bmLkcfja12DXBM/tKCHpsxKpEbsCbB/zxWXy0JZ0wUyioi/yi+l2ykpE/5G5UVyCbizT
         6/2M9l+E547cpWhPjmDyOOHT1nkWb8RNSpx/Kszi2fx9NQJlvxV18Q3XPcWker7YuOMQ
         YQjOxC+eyDIdpCn6mTh8WCXAbzID+t40RUl5muH4ybK+ylwUtfWlnxKS/L+7gFN4SXQZ
         SsMXIy/40ajxG8lHc6AQExapnyRUdy94N1MLa1Mm9BnBHNvz75PDwE1qzHfKSw4RWHAC
         uEww==
X-Gm-Message-State: AOAM5328EA4qzxEsKPR4uCHht1i+3m/IOCIUsdtU43ykK825FXs862yR
        BcTOIYIR3wkhh2qSDKWce+4=
X-Google-Smtp-Source: ABdhPJwFHVfqX3JnNpCKszqlVpwnkzHNdt+RwwTAiP/PnTxrIwdqf9XUVPHEdH+W+hhsXbNF/Yi7eQ==
X-Received: by 2002:a05:6512:682:: with SMTP id t2mr19317212lfe.503.1639257264453;
        Sat, 11 Dec 2021 13:14:24 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:24 -0800 (PST)
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
Subject: [PATCH v6 04/28] ARM: tegra: Add labels to tegra114.dtsi
Date:   Sun, 12 Dec 2021 00:13:48 +0300
Message-Id: <20211211211412.10791-5-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Bambura <jenneron@protonmail.com>

Add more labels in order to use label reference in device-specific
dts files. Labels make device-trees more readable and prevent typos
that are difficult to notice.

Signed-off-by: Anton Bambura <jenneron@protonmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 52 ++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 546272e396b4..563ee262f41d 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -93,7 +93,7 @@ rgb {
 			};
 		};
 
-		hdmi@54280000 {
+		hdmi: hdmi@54280000 {
 			compatible = "nvidia,tegra114-hdmi";
 			reg = <0x54280000 0x00040000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
@@ -105,7 +105,7 @@ hdmi@54280000 {
 			status = "disabled";
 		};
 
-		dsi@54300000 {
+		dsia: dsi@54300000 {
 			compatible = "nvidia,tegra114-dsi";
 			reg = <0x54300000 0x00040000>;
 			clocks = <&tegra_car TEGRA114_CLK_DSIA>,
@@ -121,7 +121,7 @@ dsi@54300000 {
 			#size-cells = <0>;
 		};
 
-		dsi@54400000 {
+		dsib: dsi@54400000 {
 			compatible = "nvidia,tegra114-dsi";
 			reg = <0x54400000 0x00040000>;
 			clocks = <&tegra_car TEGRA114_CLK_DSIB>,
@@ -335,7 +335,7 @@ pwm: pwm@7000a000 {
 		status = "disabled";
 	};
 
-	i2c@7000c000 {
+	i2c1: i2c@7000c000 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c000 0x100>;
 		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
@@ -350,7 +350,7 @@ i2c@7000c000 {
 		status = "disabled";
 	};
 
-	i2c@7000c400 {
+	i2c2: i2c@7000c400 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c400 0x100>;
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
@@ -365,7 +365,7 @@ i2c@7000c400 {
 		status = "disabled";
 	};
 
-	i2c@7000c500 {
+	i2c3: i2c@7000c500 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c500 0x100>;
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
@@ -380,7 +380,7 @@ i2c@7000c500 {
 		status = "disabled";
 	};
 
-	i2c@7000c700 {
+	i2c4: i2c@7000c700 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000c700 0x100>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
@@ -395,7 +395,7 @@ i2c@7000c700 {
 		status = "disabled";
 	};
 
-	i2c@7000d000 {
+	i2c5: i2c@7000d000 {
 		compatible = "nvidia,tegra114-i2c";
 		reg = <0x7000d000 0x100>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
@@ -410,7 +410,7 @@ i2c@7000d000 {
 		status = "disabled";
 	};
 
-	spi@7000d400 {
+	spi1: spi@7000d400 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000d400 0x200>;
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
@@ -425,7 +425,7 @@ spi@7000d400 {
 		status = "disabled";
 	};
 
-	spi@7000d600 {
+	spi2: spi@7000d600 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000d600 0x200>;
 		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
@@ -440,7 +440,7 @@ spi@7000d600 {
 		status = "disabled";
 	};
 
-	spi@7000d800 {
+	spi3: spi@7000d800 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000d800 0x200>;
 		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
@@ -455,7 +455,7 @@ spi@7000d800 {
 		status = "disabled";
 	};
 
-	spi@7000da00 {
+	spi4: spi@7000da00 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000da00 0x200>;
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
@@ -470,7 +470,7 @@ spi@7000da00 {
 		status = "disabled";
 	};
 
-	spi@7000dc00 {
+	spi5: spi@7000dc00 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000dc00 0x200>;
 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
@@ -485,7 +485,7 @@ spi@7000dc00 {
 		status = "disabled";
 	};
 
-	spi@7000de00 {
+	spi6: spi@7000de00 {
 		compatible = "nvidia,tegra114-spi";
 		reg = <0x7000de00 0x200>;
 		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
@@ -500,14 +500,14 @@ spi@7000de00 {
 		status = "disabled";
 	};
 
-	rtc@7000e000 {
+	tegra_rtc: rtc@7000e000 {
 		compatible = "nvidia,tegra114-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA114_CLK_RTC>;
 	};
 
-	kbc@7000e200 {
+	tegra_kbc: kbc@7000e200 {
 		compatible = "nvidia,tegra114-kbc";
 		reg = <0x7000e200 0x100>;
 		interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -646,7 +646,7 @@ mipi: mipi@700e3000 {
 		#nvidia,mipi-calibrate-cells = <1>;
 	};
 
-	mmc@78000000 {
+	sdmmc1: mmc@78000000 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -657,7 +657,7 @@ mmc@78000000 {
 		status = "disabled";
 	};
 
-	mmc@78000200 {
+	sdmmc2: mmc@78000200 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
@@ -668,7 +668,7 @@ mmc@78000200 {
 		status = "disabled";
 	};
 
-	mmc@78000400 {
+	sdmmc3: mmc@78000400 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -679,7 +679,7 @@ mmc@78000400 {
 		status = "disabled";
 	};
 
-	mmc@78000600 {
+	sdmmc4: mmc@78000600 {
 		compatible = "nvidia,tegra114-sdhci";
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
@@ -690,7 +690,7 @@ mmc@78000600 {
 		status = "disabled";
 	};
 
-	usb@7d000000 {
+	usb1: usb@7d000000 {
 		compatible = "nvidia,tegra114-ehci", "nvidia,tegra30-ehci";
 		reg = <0x7d000000 0x4000>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
@@ -698,11 +698,11 @@ usb@7d000000 {
 		clocks = <&tegra_car TEGRA114_CLK_USBD>;
 		resets = <&tegra_car 22>;
 		reset-names = "usb";
-		nvidia,phy = <&phy1>;
+		nvidia,phy = <&usb1_phy>;
 		status = "disabled";
 	};
 
-	phy1: usb-phy@7d000000 {
+	usb1_phy: usb-phy@7d000000 {
 		compatible = "nvidia,tegra114-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x7d000000 0x4000>,
 		      <0x7d000000 0x4000>;
@@ -730,7 +730,7 @@ phy1: usb-phy@7d000000 {
 		status = "disabled";
 	};
 
-	usb@7d008000 {
+	usb3: usb@7d008000 {
 		compatible = "nvidia,tegra114-ehci", "nvidia,tegra30-ehci";
 		reg = <0x7d008000 0x4000>;
 		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
@@ -738,11 +738,11 @@ usb@7d008000 {
 		clocks = <&tegra_car TEGRA114_CLK_USB3>;
 		resets = <&tegra_car 59>;
 		reset-names = "usb";
-		nvidia,phy = <&phy3>;
+		nvidia,phy = <&usb3_phy>;
 		status = "disabled";
 	};
 
-	phy3: usb-phy@7d008000 {
+	usb3_phy: usb-phy@7d008000 {
 		compatible = "nvidia,tegra114-usb-phy", "nvidia,tegra30-usb-phy";
 		reg = <0x7d008000 0x4000>,
 		      <0x7d000000 0x4000>;
-- 
2.33.1

