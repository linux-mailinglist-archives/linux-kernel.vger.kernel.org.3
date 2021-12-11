Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1123647169D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhLKVPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbhLKVOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:14:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6522C0698CE;
        Sat, 11 Dec 2021 13:14:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bu18so24276055lfb.0;
        Sat, 11 Dec 2021 13:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/NxCUOlGoJ8tyJic9hyD6cA39ZaY8j/egJeYG4gP5U=;
        b=qj/NUUerSCEtVmbGdXgc5NLj3QlQgh2DopRQEV86atuU6/TPo19JUqwJQAcxqefE0p
         Zoab9DmcvGhjpcGbt+05Qad0D5pKHeL28k9VQDgZ8WmWTc8CDpcciZeYIDp/JJHtMtSu
         g4FdH8MybxwUTyEmxsQBjGpzxFeWMl0X2/P11uvu/Y3G6m6qEoVAMtHKxz14zz3c/3Kf
         E394947ScNmBAajDeAKxi+JYY15bfRNn5FCk+Op4yi56eQgyXjVsPSM62b/4wnRPmRoC
         MRKevne9IRWunvXvYjaVZPzACBlrabuWAotaQ+IAIgto/6EpP/PsXNKX6nggOWrSR3Wl
         3V3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/NxCUOlGoJ8tyJic9hyD6cA39ZaY8j/egJeYG4gP5U=;
        b=6ox8msw+r5f2g4cD49I9d15HN9281kNWAorGtlWo1r/Ef1lU3HyGlIvbCoy/WtocOA
         hcj/x6sMscyZTBdTteHSv1RQjY3KLBLkq+7FZcjJoxhzivG7FrY8gOoeoDAkLT6lOULQ
         PgE4pvAKiIN8y2hM+ObueWkTzkgXagE60vWT6408JcGxxWrx151S18DGj1q5oAQrwb8d
         Dkl9AaSy/007VpKWdD3VGUDs1au4AqUIGIpOUYUCLSdB4Y9xxyQbcBdF/jajZFi7eXXR
         tKJudaIL2RFAmmgK9Yx61pB2IKdJ54CR+KnJT9pvXsfI87dynROSIoadIsgYphqYrhhZ
         s/lQ==
X-Gm-Message-State: AOAM532ZmARj2ZGCYl8dNhtg7i00iM0XgqTchXeWG5PXO8D2jpUiOEg1
        aQUVHNuO3ysRwxNFqFNpa1U=
X-Google-Smtp-Source: ABdhPJzC7qNOJpn9EN+LYH79rR1HTkZgFyaLb+ul/Fm5DZzr+HG3fCjjjxuH9KI9JmBGOjcxXCv6Hg==
X-Received: by 2002:a05:6512:452:: with SMTP id y18mr15234933lfk.540.1639257281211;
        Sat, 11 Dec 2021 13:14:41 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id v6sm765927lfp.61.2021.12.11.13.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 13:14:40 -0800 (PST)
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
Subject: [PATCH v6 19/28] ARM: tegra: Rename top-level clocks
Date:   Sun, 12 Dec 2021 00:14:03 +0300
Message-Id: <20211211211412.10791-20-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211211412.10791-1-digetx@gmail.com>
References: <20211211211412.10791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Heidelberg <david@ixit.cz>

Clocks defined at the top level in device tree are no longer part of a
simple bus and therefore don't have a reg property. Nodes without a reg
property shouldn't have a unit-address either, so drop the unit address
from the node names. To ensure nodes aren't duplicated (in which case
they would end up merged in the final DTB), append the name of the clock
to the node name.

[treding@nvidia.com: factored out patch and wrote commit message]
Signed-off-by: David Heidelberg <david@ixit.cz>
Co-developed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts                    | 2 +-
 arch/arm/boot/dts/tegra114-roth.dts                       | 2 +-
 arch/arm/boot/dts/tegra114-tn7.dts                        | 2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts                 | 2 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi                      | 2 +-
 arch/arm/boot/dts/tegra124-venice2.dts                    | 2 +-
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts           | 4 ++--
 arch/arm/boot/dts/tegra20-harmony.dts                     | 2 +-
 arch/arm/boot/dts/tegra20-paz00.dts                       | 2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts                    | 2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi                   | 2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts                   | 2 +-
 arch/arm/boot/dts/tegra20-ventana.dts                     | 2 +-
 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi | 2 +-
 arch/arm/boot/dts/tegra30-beaver.dts                      | 2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi                     | 2 +-
 16 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 7fd901f8d39a..4bf35d947d9b 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1151,7 +1151,7 @@ backlight: backlight {
 		default-brightness-level = <6>;
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra114-roth.dts b/arch/arm/boot/dts/tegra114-roth.dts
index 07960171fabe..24ac84f81b19 100644
--- a/arch/arm/boot/dts/tegra114-roth.dts
+++ b/arch/arm/boot/dts/tegra114-roth.dts
@@ -1016,7 +1016,7 @@ backlight: backlight {
 		enable-gpios = <&gpio TEGRA_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra114-tn7.dts b/arch/arm/boot/dts/tegra114-tn7.dts
index 745d234b105b..73c949d90345 100644
--- a/arch/arm/boot/dts/tegra114-tn7.dts
+++ b/arch/arm/boot/dts/tegra114-tn7.dts
@@ -273,7 +273,7 @@ backlight: backlight {
 		power-supply = <&lcd_bl_en>;
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 35ab296408e1..7339373c3e64 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1868,7 +1868,7 @@ usb-phy@7d008000 {
 		vbus-supply = <&vdd_usb3_vbus>;
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index b16cce7476ef..ccd3d81a3531 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -588,7 +588,7 @@ backlight: backlight {
 			 256>;
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index de8c18e6b7e6..2fdcb8bf0bc5 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -1061,7 +1061,7 @@ backlight: backlight {
 		default-brightness-level = <6>;
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index 23d3f8daab23..1aaee6f09fd8 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -827,7 +827,7 @@ bat1010: battery-2s1p {
 	};
 
 	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k-in {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
@@ -839,7 +839,7 @@ clk32k_in: clock@0 {
 	 * oscillator is used as a reference clock-source by the
 	 * Azurewave WiFi/BT module.
 	 */
-	rtc_32k_wifi: clock@1 {
+	rtc_32k_wifi: clock-32k-wifi {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index ae4312eedcbd..4d137461f3c4 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -640,7 +640,7 @@ backlight: backlight {
 		default-brightness-level = <6>;
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 5b38b0606f99..d3d24523553e 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -575,7 +575,7 @@ backlight: backlight {
 		default-brightness-level = <10>;
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 92d494b8c3d2..ffeae5da22e7 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -792,7 +792,7 @@ backlight: backlight {
 		default-brightness-level = <6>;
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index dd4d506683de..d5f1a46da0bc 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -502,7 +502,7 @@ mmc@c8000600 {
 		status = "okay";
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 4bc87bc0c2a4..7bda2d30a748 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -379,7 +379,7 @@ mmc@c8000600 {
 		bus-width = <4>;
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 5a2578b3707f..ef97457f1334 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -606,7 +606,7 @@ backlight: backlight {
 		default-brightness-level = <6>;
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
index 07d4ea130964..72159eb55a3d 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
@@ -1069,7 +1069,7 @@ battery_cell: battery-cell {
 	};
 
 	/* PMIC has a built-in 32KHz oscillator which is used by PMC */
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <32768>;
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index e159feeedef7..3184a9d6227e 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -1966,7 +1966,7 @@ usb-phy@7d008000 {
 		status = "okay";
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 448f1397e64a..3a7621a2efde 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -433,7 +433,7 @@ backlight: backlight {
 		default-brightness-level = <6>;
 	};
 
-	clk32k_in: clock@0 {
+	clk32k_in: clock-32k {
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
 		#clock-cells = <0>;
-- 
2.33.1

