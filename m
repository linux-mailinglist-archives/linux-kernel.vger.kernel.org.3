Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E982146D9E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbhLHRlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbhLHRle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:41:34 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D37C061746;
        Wed,  8 Dec 2021 09:38:02 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id z7so6983282lfi.11;
        Wed, 08 Dec 2021 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dpd5vViYyggW1vN/6oOV6ghp4iG8XVXPtGDwqtUMgEc=;
        b=CDGx5/YdKjNi+T3wHSFuUCzIKiyLn89GntkvOgZJxH3rdM0EzynSe6YKe0dRyjQQTR
         daLVoRdHDGJE/SRB1uzYhG896uujZoHMOUE8eu5aXsdlVM5EmBe7kAqsCIJzjgD1w+BH
         vsbwJSf0IwYq40u53lLC5f1oH6qy9p9nLa2KKSxb0nDghKSKBBv7nvMP/Y2wIzHoMbdb
         xAfXwTVomY0xASu20YYfYGpxF7zd/qswqV2kALqbYXT7fxs4TXr/PDqLLilPD3J85uzi
         zo8Ce6ynC9qxcCTQgZ50VNliyLJIn2pCRnxpc2I7HehVTzF3OLflZlgN8V/fS5Hk3zHU
         XmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dpd5vViYyggW1vN/6oOV6ghp4iG8XVXPtGDwqtUMgEc=;
        b=03C7cJ/r7An/MttaLaFpItpMe0dc2W+2XrhINfhAfsHwngNJet95M5pxOoZ868aY9G
         XZlFOeRywbKd9L8cRq2Zoz2ulWgZhouBCF6z7K8nXocIqCP3PrrB0pMtS21icb+mg0yR
         gWiA1R3drkyujV98RJfSUnTYsLT30D1AFq2s6b42UTwJhAQD7LEqjSp9K2+v+IpVmWHk
         fwUODCdrFrQtoAd0uXSJorHdAydEUVMPiKl8Hz1yCTYvyPTBkQklt3c4D344TcZ/BDq/
         c+3UmisYIIaGTrGZCh21qZ5/TTJU2q3jMMZKRMvmldA1lQOKQhPwM/XioB4FC3R9mTd7
         vDVw==
X-Gm-Message-State: AOAM532Bwhc0bLtSu4Jylm2gQv/x3pFKHTnu7mISgQ/1CY/KAyU+5xGh
        YpqinTX6iQm8GZn7aoK1r+E=
X-Google-Smtp-Source: ABdhPJzT//Hk2l345YNJEHjz6ArZWH8uMlAPJT9CJ1CQTkZ1Dcm72AhhmVPqCkgRh5aF6APn9mKgFQ==
X-Received: by 2002:a05:6512:2314:: with SMTP id o20mr799437lfu.51.1638985080502;
        Wed, 08 Dec 2021 09:38:00 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id a25sm349159lfm.250.2021.12.08.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:38:00 -0800 (PST)
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
Subject: [PATCH v5 03/24] ARM: tegra: Add labels to tegra30.dtsi
Date:   Wed,  8 Dec 2021 20:35:48 +0300
Message-Id: <20211208173609.4064-4-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208173609.4064-1-digetx@gmail.com>
References: <20211208173609.4064-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Add phandle names for memory/I2C/SPI/USB/SDMMC controller nodes to allow
for cleaner device descriptions.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 arch/arm/boot/dts/tegra30.dtsi | 36 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index ae3df73c20a7..a6772171c910 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -585,7 +585,7 @@ rtc@7000e000 {
 		clocks = <&tegra_car TEGRA30_CLK_RTC>;
 	};
 
-	i2c@7000c000 {
+	i2c1: i2c@7000c000 {
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c000 0x100>;
 		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
@@ -601,7 +601,7 @@ i2c@7000c000 {
 		status = "disabled";
 	};
 
-	i2c@7000c400 {
+	i2c2: i2c@7000c400 {
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c400 0x100>;
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
@@ -617,7 +617,7 @@ i2c@7000c400 {
 		status = "disabled";
 	};
 
-	i2c@7000c500 {
+	i2c3: i2c@7000c500 {
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c500 0x100>;
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
@@ -633,7 +633,7 @@ i2c@7000c500 {
 		status = "disabled";
 	};
 
-	i2c@7000c700 {
+	i2c4: i2c@7000c700 {
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c700 0x100>;
 		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
@@ -649,7 +649,7 @@ i2c@7000c700 {
 		status = "disabled";
 	};
 
-	i2c@7000d000 {
+	i2c5: i2c@7000d000 {
 		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000d000 0x100>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
@@ -665,7 +665,7 @@ i2c@7000d000 {
 		status = "disabled";
 	};
 
-	spi@7000d400 {
+	spi1: spi@7000d400 {
 		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
 		reg = <0x7000d400 0x200>;
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
@@ -679,7 +679,7 @@ spi@7000d400 {
 		status = "disabled";
 	};
 
-	spi@7000d600 {
+	spi2: spi@7000d600 {
 		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
 		reg = <0x7000d600 0x200>;
 		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
@@ -693,7 +693,7 @@ spi@7000d600 {
 		status = "disabled";
 	};
 
-	spi@7000d800 {
+	spi3: spi@7000d800 {
 		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
 		reg = <0x7000d800 0x200>;
 		interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
@@ -707,7 +707,7 @@ spi@7000d800 {
 		status = "disabled";
 	};
 
-	spi@7000da00 {
+	spi4: spi@7000da00 {
 		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
 		reg = <0x7000da00 0x200>;
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
@@ -721,7 +721,7 @@ spi@7000da00 {
 		status = "disabled";
 	};
 
-	spi@7000dc00 {
+	spi5: spi@7000dc00 {
 		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
 		reg = <0x7000dc00 0x200>;
 		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
@@ -735,7 +735,7 @@ spi@7000dc00 {
 		status = "disabled";
 	};
 
-	spi@7000de00 {
+	spi6: spi@7000de00 {
 		compatible = "nvidia,tegra30-slink", "nvidia,tegra20-slink";
 		reg = <0x7000de00 0x200>;
 		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
@@ -913,7 +913,7 @@ tegra_i2s4: i2s@70080700 {
 		};
 	};
 
-	mmc@78000000 {
+	sdmmc1: mmc@78000000 {
 		compatible = "nvidia,tegra30-sdhci";
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
@@ -924,7 +924,7 @@ mmc@78000000 {
 		status = "disabled";
 	};
 
-	mmc@78000200 {
+	sdmmc2: mmc@78000200 {
 		compatible = "nvidia,tegra30-sdhci";
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
@@ -935,7 +935,7 @@ mmc@78000200 {
 		status = "disabled";
 	};
 
-	mmc@78000400 {
+	sdmmc3: mmc@78000400 {
 		compatible = "nvidia,tegra30-sdhci";
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
@@ -946,7 +946,7 @@ mmc@78000400 {
 		status = "disabled";
 	};
 
-	mmc@78000600 {
+	sdmmc4: mmc@78000600 {
 		compatible = "nvidia,tegra30-sdhci";
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
@@ -957,7 +957,7 @@ mmc@78000600 {
 		status = "disabled";
 	};
 
-	usb@7d000000 {
+	usb1: usb@7d000000 {
 		compatible = "nvidia,tegra30-ehci";
 		reg = <0x7d000000 0x4000>;
 		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
@@ -999,7 +999,7 @@ phy1: usb-phy@7d000000 {
 		status = "disabled";
 	};
 
-	usb@7d004000 {
+	usb2: usb@7d004000 {
 		compatible = "nvidia,tegra30-ehci";
 		reg = <0x7d004000 0x4000>;
 		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
@@ -1039,7 +1039,7 @@ phy2: usb-phy@7d004000 {
 		status = "disabled";
 	};
 
-	usb@7d008000 {
+	usb3: usb@7d008000 {
 		compatible = "nvidia,tegra30-ehci";
 		reg = <0x7d008000 0x4000>;
 		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.33.1

