Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D8854D682
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350553AbiFPAyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349840AbiFPAy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:54:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C47157994
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:16 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w21so138162pfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsW59cFZjklHB2Wpxrfsfror1DmvkvVRBrL7nFD90Rw=;
        b=gT7gqFzbN8epGJaDV1iKFM6cTxx7kd3KDK95NFIR6vxJr/e/IBbTs4Wztt6Gf8e9nD
         5sVU/Dk9DyC18wj3nLZp1lVtPcj0NC0BybAhCNtTB10PZg5ho9Q3jIheRedswqqM3vvw
         YEo+K7qmtxwnfAUZCHk7II4CLLTQ2lCbPTrOb2+9ZL31uPpaPn4LqjklKkDjrJWpmeN2
         f3yfH3Lu2WPIFiWiAlX355Jt0GRcBNpbmXKttGoO+H66Wwl+NusPKjIn30Zxsfuly9Xz
         1IhilHqF2ZDGOOyII59iTkLsR02JRWRcEwZF99vHIfqhxibqdQnk+hOfsDswuc8FR5eD
         4wOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsW59cFZjklHB2Wpxrfsfror1DmvkvVRBrL7nFD90Rw=;
        b=1XyKGwACC+GKwArm3I71JRH/09pKrExgbSu1ho3tdX5U36zWoWVNz5q20OGd/TkAff
         JYqQYUFkmvtLWpWDdyDZAId03IiGK3KskSXTUeafQihJTCoooiNr1hufxRiWDLyq0hV4
         FzpPYvu5dLoRYd88IQNo+LrVrFTG44EcYu+RkTcu0nkpjVcw9aVnlKFNUEMrRMDXktav
         HwPNyQaIWcbHAvwHJ/0uWfaE+6Sp4+voitB5gVBsl+Nbp/UufgPPpmNhIfztgWKrsxrB
         u69o2M1587vvqmEDJhDXwhMK7lPzuVue22F+YA95yaw0jNyaGZs0LdWZnXSiZcTyJQPb
         G2kQ==
X-Gm-Message-State: AJIora+s5KZWTOnEmwrXi0NCoDgYLz9hcpXzQQQh7yhRQTuc3boGJhP6
        zDTf0/C64qRSq77EQqkvUovwWA==
X-Google-Smtp-Source: AGRyM1v9PXc3M6qtFJkIuJ5CZkLsvfE0UjONQMjhaOvEr+7WUGSHaubkM2UtRha1WHx8hBYamDVZtg==
X-Received: by 2002:a63:441f:0:b0:3fc:8bd2:f828 with SMTP id r31-20020a63441f000000b003fc8bd2f828mr2096272pga.579.1655340855648;
        Wed, 15 Jun 2022 17:54:15 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 15/40] arm64: dts: mediatek: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:08 -0700
Message-Id: <20220616005333.18491-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts      |  4 ++--
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts           |  4 ++--
 arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts  |  6 +++---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi           | 10 +++++-----
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi |  4 ++--
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi  |  2 +-
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi         |  2 +-
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi       |  4 ++--
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 2b9bf8dd14ec..c2311733d2de 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -40,13 +40,13 @@ cpu@1 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		factory {
+		factory-key {
 			label = "factory";
 			linux,code = <BTN_0>;
 			gpios = <&pio 0 GPIO_ACTIVE_HIGH>;
 		};
 
-		wps {
+		wps-key {
 			label = "wps";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&pio 102 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 596c073d8b05..c28da9323a9c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -42,13 +42,13 @@ gpio-keys {
 		compatible = "gpio-keys";
 		poll-interval = <100>;
 
-		factory {
+		key-factory {
 			label = "factory";
 			linux,code = <BTN_0>;
 			gpios = <&pio 0 0>;
 		};
 
-		wps {
+		key-wps {
 			label = "wps";
 			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&pio 102 0>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
index 44f6149c1307..28433b94f7c7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
@@ -21,7 +21,7 @@ cpu_crit: cpu_crit0 {
 };
 
 &gpio_keys {
-	/delete-node/tablet_mode;
-	/delete-node/volume_down;
-	/delete-node/volume_up;
+	/delete-node/switch-tablet-mode;
+	/delete-node/switch-volume-down;
+	/delete-node/switch-volume-up;
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 9c75fbb31f98..d20378758213 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -53,7 +53,7 @@ gpio_keys: gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_pins>;
 
-		lid {
+		switch-lid {
 			label = "Lid";
 			gpios = <&pio 69 GPIO_ACTIVE_LOW>;
 			linux,code = <SW_LID>;
@@ -61,7 +61,7 @@ lid {
 			gpio-key,wakeup;
 		};
 
-		power {
+		switch-power {
 			label = "Power";
 			gpios = <&pio 14 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_POWER>;
@@ -69,7 +69,7 @@ power {
 			gpio-key,wakeup;
 		};
 
-		tablet_mode {
+		switch-tablet-mode {
 			label = "Tablet_mode";
 			gpios = <&pio 121 GPIO_ACTIVE_HIGH>;
 			linux,code = <SW_TABLET_MODE>;
@@ -77,13 +77,13 @@ tablet_mode {
 			gpio-key,wakeup;
 		};
 
-		volume_down {
+		switch-volume-down {
 			label = "Volume_down";
 			gpios = <&pio 123 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
-		volume_up {
+		switch-volume-up {
 			label = "Volume_up";
 			gpios = <&pio 124 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index 2d7a193272ae..3ac83be53627 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -73,7 +73,7 @@ volume_buttons: volume-buttons {
 		pinctrl-names = "default";
 		pinctrl-0 = <&volume_button_pins>;
 
-		volume_down {
+		button-volume-down {
 			label = "Volume Down";
 			linux,code = <KEY_VOLUMEDOWN>;
 			debounce-interval = <100>;
@@ -81,7 +81,7 @@ volume_down {
 			gpios = <&pio 6 GPIO_ACTIVE_LOW>;
 		};
 
-		volume_up {
+		button-volume-up {
 			label = "Volume Up";
 			linux,code = <KEY_VOLUMEUP>;
 			debounce-interval = <100>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
index 28966a65391b..50a0dd36b5fb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi
@@ -45,7 +45,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pen_eject>;
 
-		pen-insert {
+		switch-pen-insert {
 			label = "Pen Insert";
 			/* Insert = low, eject = high */
 			gpios = <&pio 6 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index b035e06840e6..b50261e8b9ed 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -144,7 +144,7 @@ wifi_wakeup: wifi-wakeup {
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_pins_wakeup>;
 
-		wowlan {
+		button-wowlan {
 			label = "Wake on WiFi";
 			gpios = <&pio 113 GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index 7a717f926929..8ee1529683a3 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -28,7 +28,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_default>;
 
-		volume-up {
+		key-volume-up {
 			gpios = <&pio 42 GPIO_ACTIVE_LOW>;
 			label = "volume_up";
 			linux,code = <115>;
@@ -36,7 +36,7 @@ volume-up {
 			debounce-interval = <15>;
 		};
 
-		volume-down {
+		key-volume-down {
 			gpios = <&pio 43 GPIO_ACTIVE_LOW>;
 			label = "volume_down";
 			linux,code = <114>;
-- 
2.34.1

