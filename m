Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5728F544A8A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243429AbiFILlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243885AbiFILkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:40:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AFB1E440B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:40:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bg6so27096460ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJ1HrRyo5FWcLkbF8euDS8gLFRpt8ZVSJLGa36Wuq9I=;
        b=bbBLlKBq/yKgpzmP3eSNjXag8ajyukD5VT8Fac4eXqd28eLJwlykcTvq7S0hdaS1zn
         2H09OMfSuc5f7mBN6CbB0g6sOmrxeILcncLF8L+QMMJeTxB8gs7yZ5mcCzL2z+Rhy/Y5
         ODW7+TlMOTtLNY72cDzrsog0BtTruGWy6QkA8GLTMK9P77Eud5cspWEujJB1loELXDyp
         wy7dnEpGs8qURxPR4gVC2GeCDcFYzJiu0KYjtdKUc204LOkjV41NsuTmlCzjleqJHh8V
         N/0qcjp9Bc3ZLelJ3lIOcfM2vpMaYoExlYcXB0ggtaJJt3DocgEuFl9YZ4H1QPBbQzQ9
         RabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJ1HrRyo5FWcLkbF8euDS8gLFRpt8ZVSJLGa36Wuq9I=;
        b=f8ocIqKRNhga9xyqFFhJoKFlcoJivlImekRanWBFsALKXSHc76BtKMEL71GTeRCNJB
         deJrWf59NPQbjBLYgh3UB9tFgbfi22fKtsIDFx5qSb05MwYl5HBBRpaKUpj5kBrF0O6u
         kbW+E0Kqcy39Liwi6rfYfykE8+ZwBRpsqvqoz5GWUyUXgCuw09KKud0WSliY5s7X8nnO
         O9fkXMmQLrKGR7VprSluprORnSpjyIB/Q8vOMiurEHcjZI/3CrWYhL6uIyrHI0xogoGp
         vVtBOAAvB6Q79L0q4nJp8d7srjHY21tX4j+5VXRLaJVWInONqhFRXzuvYcJoslf0Fy6E
         cWtA==
X-Gm-Message-State: AOAM530lJeanV8tDHScXKhxYKzhCC36Zz886KfywK+RdKjrKh5FFvbSY
        BpzKYz19BRREoBv4jARgW0lu/g==
X-Google-Smtp-Source: ABdhPJyEfoGeMzht2CbOweDKCpeGzmuTDiKi7GsrcaHZX5/qZvByt/7w2xDnmFfg7y852HXr1/kktA==
X-Received: by 2002:a17:907:86a6:b0:6ff:21f0:9e5a with SMTP id qa38-20020a17090786a600b006ff21f09e5amr35061259ejc.164.1654774817803;
        Thu, 09 Jun 2022 04:40:17 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q1-20020a170906360100b006ff59151e34sm10638441ejb.39.2022.06.09.04.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:40:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 26/48] ARM: dts: tegra: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:39:59 +0200
Message-Id: <20220609114002.380563-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic and DT schema expects certain pattern
(e.g. with key/button/switch).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/tegra114-asus-tf701t.dts             |  8 ++++----
 arch/arm/boot/dts/tegra114-dalmore.dts                 |  8 ++++----
 arch/arm/boot/dts/tegra114-roth.dts                    |  6 +++---
 arch/arm/boot/dts/tegra114-tn7.dts                     |  6 +++---
 arch/arm/boot/dts/tegra124-apalis-eval.dts             |  2 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts        |  2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts              |  2 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi                   |  4 ++--
 arch/arm/boot/dts/tegra124-venice2.dts                 |  2 +-
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts        |  8 ++++----
 arch/arm/boot/dts/tegra20-asus-tf101.dts               |  8 ++++----
 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts          |  2 +-
 arch/arm/boot/dts/tegra20-colibri-iris.dts             |  2 +-
 arch/arm/boot/dts/tegra20-harmony.dts                  |  2 +-
 arch/arm/boot/dts/tegra20-paz00.dts                    |  2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts                 |  4 ++--
 arch/arm/boot/dts/tegra20-trimslice.dts                |  2 +-
 arch/arm/boot/dts/tegra20-ventana.dts                  |  2 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts              |  2 +-
 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts         |  2 +-
 .../boot/dts/tegra30-asus-nexus7-grouper-common.dtsi   |  8 ++++----
 arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi | 10 +++++-----
 arch/arm/boot/dts/tegra30-cardhu.dtsi                  |  6 +++---
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts          |  2 +-
 arch/arm/boot/dts/tegra30-ouya.dts                     |  2 +-
 arch/arm/boot/dts/tegra30-pegatron-chagall.dts         | 10 +++++-----
 26 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-asus-tf701t.dts b/arch/arm/boot/dts/tegra114-asus-tf701t.dts
index b791ce97424b..b44b2371cd56 100644
--- a/arch/arm/boot/dts/tegra114-asus-tf701t.dts
+++ b/arch/arm/boot/dts/tegra114-asus-tf701t.dts
@@ -684,7 +684,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_default>;
 
-		power {
+		button-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
@@ -692,14 +692,14 @@ power {
 			wakeup-source;
 		};
 
-		volume-up {
+		button-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 			debounce-interval = <10>;
 		};
 
-		volume-down {
+		button-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio TEGRA_GPIO(R, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
@@ -715,7 +715,7 @@ gpio-hall-sensor {
 		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_hall_sensor_default>;
 
-		hall-sensor {
+		event-hall-sensor {
 			label = "Hall Effect Sensor";
 			gpios = <&gpio TEGRA_GPIO(O, 5) GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 658edfb8d7fa..fffd62bcea6a 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1161,26 +1161,26 @@ clk32k_in: clock-32k {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 		};
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			wakeup-source;
 		};
 
-		volume_down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio TEGRA_GPIO(R, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
-		volume_up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm/boot/dts/tegra114-roth.dts b/arch/arm/boot/dts/tegra114-roth.dts
index 2498cf18fd39..b9d00009d1f4 100644
--- a/arch/arm/boot/dts/tegra114-roth.dts
+++ b/arch/arm/boot/dts/tegra114-roth.dts
@@ -1025,19 +1025,19 @@ clk32k_in: clock-32k {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		back {
+		key-back {
 			label = "Back";
 			gpios = <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BACK>;
 		};
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&gpio TEGRA_GPIO(R, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 		};
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/tegra114-tn7.dts b/arch/arm/boot/dts/tegra114-tn7.dts
index ef8f722dd9cb..f02d8c79eee7 100644
--- a/arch/arm/boot/dts/tegra114-tn7.dts
+++ b/arch/arm/boot/dts/tegra114-tn7.dts
@@ -282,20 +282,20 @@ clk32k_in: clock-32k {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			wakeup-source;
 		};
 
-		volume_down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio TEGRA_GPIO(Q, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
-		volume_up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index 3209554ec7e6..bce12b3411fc 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -191,7 +191,7 @@ backlight: backlight {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wakeup {
+		key-wakeup {
 			label = "WAKE1_MICO";
 			gpios = <&gpio TEGRA_GPIO(DD, 3) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
index 814257c79bf1..800283ad6bdc 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
@@ -193,7 +193,7 @@ backlight: backlight {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wakeup {
+		key-wakeup {
 			label = "WAKE1_MICO";
 			gpios = <&gpio TEGRA_GPIO(DD, 3) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 28b889e4e33b..f41dd4039c07 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1886,7 +1886,7 @@ cpu@0 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index a93cfb492ba1..13061ab5247b 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -603,7 +603,7 @@ cpu@0 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		lid {
+		switch-lid {
 			label = "Lid";
 			gpios = <&gpio TEGRA_GPIO(R, 4) GPIO_ACTIVE_LOW>;
 			linux,input-type = <5>;
@@ -612,7 +612,7 @@ lid {
 			wakeup-source;
 		};
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 6a9592ceb5f2..8f40fcfc11b0 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -1078,7 +1078,7 @@ clk32k_in: clock-32k {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index bf1126d26aff..dac6d02a1b15 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -905,7 +905,7 @@ panel_input: endpoint {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(I, 3) GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_POWER>;
@@ -914,7 +914,7 @@ power {
 			wakeup-source;
 		};
 
-		rotation-lock {
+		key-rotation-lock {
 			label = "Rotate-lock";
 			gpios = <&gpio TEGRA_GPIO(Q, 2) GPIO_ACTIVE_HIGH>;
 			linux,code = <SW_ROTATE_LOCK>;
@@ -922,7 +922,7 @@ rotation-lock {
 			debounce-interval = <10>;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
@@ -931,7 +931,7 @@ volume-up {
 			wakeup-source;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio TEGRA_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index f3b0166f7a9c..62db602c7205 100644
--- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
@@ -980,7 +980,7 @@ cpu1: cpu@1 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		dock-hall-sensor {
+		event-dock-hall-sensor {
 			label = "Lid";
 			gpios = <&gpio TEGRA_GPIO(S, 4) GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
@@ -990,7 +990,7 @@ dock-hall-sensor {
 			wakeup-source;
 		};
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
@@ -999,7 +999,7 @@ power {
 			wakeup-source;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(Q, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
@@ -1008,7 +1008,7 @@ volume-up {
 			wakeup-source;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio TEGRA_GPIO(Q, 4) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
index d2a3bf9d28bd..cb1190b77db3 100644
--- a/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
@@ -209,7 +209,7 @@ clk16m: osc3 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wakeup {
+		key-wakeup {
 			label = "SODIMM pin 45 wakeup";
 			gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 00ecbbd5e9e1..53487cc21513 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -191,7 +191,7 @@ backlight: backlight {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wakeup {
+		key-wakeup {
 			label = "SODIMM pin 45 wakeup";
 			gpios = <&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 79b6b79fab65..11f21aeba8e9 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -648,7 +648,7 @@ clk32k_in: clock-32k {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 0fb4b1f5bc1c..48fe628c6d87 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -596,7 +596,7 @@ clk32k_in: clock-32k {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wakeup {
+		key-wakeup {
 			label = "Wakeup";
 			gpios = <&gpio TEGRA_GPIO(J, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index c4a6a6a94559..5b4c5ef30996 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -800,14 +800,14 @@ clk32k_in: clock-32k {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			wakeup-source;
 		};
 
-		lid {
+		switch-lid {
 			label = "Lid";
 			gpios = <&gpio TEGRA_GPIO(C, 7) GPIO_ACTIVE_HIGH>;
 			linux,input-type = <5>; /* EV_SW */
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 9d0c86711de2..dc51835423a9 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -388,7 +388,7 @@ clk32k_in: clock-32k {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(X, 6) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index b0a00970b61c..caa17e876e41 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -628,7 +628,7 @@ cpu1: cpu@1 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
index 93b83b3c5655..ad968ff968d7 100644
--- a/arch/arm/boot/dts/tegra30-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-eval.dts
@@ -181,7 +181,7 @@ backlight: backlight {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wakeup {
+		key-wakeup {
 			label = "WAKE1_MICO";
 			gpios = <&gpio TEGRA_GPIO(V, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts b/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
index fbfa75e53f32..c172fdb5e1ae 100644
--- a/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
+++ b/arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
@@ -182,7 +182,7 @@ backlight: backlight {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wakeup {
+		key-wakeup {
 			label = "WAKE1_MICO";
 			gpios = <&gpio TEGRA_GPIO(V, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
index 55e6171a411d..5ed6b4dca100 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
@@ -1124,7 +1124,7 @@ trusted-foundations {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		hall-sensor {
+		event-hall-sensor {
 			label = "Lid";
 			gpios = <&gpio TEGRA_GPIO(S, 6) GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
@@ -1134,7 +1134,7 @@ hall-sensor {
 			wakeup-source;
 		};
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
@@ -1143,7 +1143,7 @@ power {
 			wakeup-source;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(Q, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
@@ -1152,7 +1152,7 @@ volume-up {
 			wakeup-source;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio TEGRA_GPIO(Q, 3) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
index c662ab261ed5..58159b789688 100644
--- a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
@@ -1511,7 +1511,7 @@ extcon-keys {
 		compatible = "gpio-keys";
 		interrupt-parent = <&gpio>;
 
-		dock-hall-sensor {
+		event-dock-hall-sensor {
 			label = "Lid sensor";
 			gpios = <&gpio TEGRA_GPIO(S, 6) GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
@@ -1521,7 +1521,7 @@ dock-hall-sensor {
 			wakeup-source;
 		};
 
-		lineout-detect {
+		event-lineout-detect {
 			label = "Audio dock line-out detect";
 			gpios = <&gpio TEGRA_GPIO(X, 3) GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
@@ -1544,7 +1544,7 @@ gpio-keys {
 		compatible = "gpio-keys";
 		interrupt-parent = <&gpio>;
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
@@ -1553,7 +1553,7 @@ power {
 			wakeup-source;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(Q, 2) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
@@ -1562,7 +1562,7 @@ volume-up {
 			wakeup-source;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio TEGRA_GPIO(Q, 3) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index ba257ed36d9c..540530c983ff 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -685,7 +685,7 @@ map0 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			interrupt-parent = <&pmic>;
 			interrupts = <2 0>;
@@ -694,14 +694,14 @@ power {
 			wakeup-source;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 			debounce-interval = <10>;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(R, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
index 7d4a6ca4936a..8dbc15f9a9e4 100644
--- a/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/tegra30-colibri-eval-v3.dts
@@ -145,7 +145,7 @@ clk16m: osc3 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wakeup {
+		key-wakeup {
 			label = "SODIMM pin 45 wakeup";
 			gpios = <&gpio TEGRA_GPIO(V, 1) GPIO_ACTIVE_HIGH>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/tegra30-ouya.dts b/arch/arm/boot/dts/tegra30-ouya.dts
index e58dda4f9d2c..b7acea39b942 100644
--- a/arch/arm/boot/dts/tegra30-ouya.dts
+++ b/arch/arm/boot/dts/tegra30-ouya.dts
@@ -4764,7 +4764,7 @@ usb3_vbus_reg: usb3_vbus_reg {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			gpios = <&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_LOW>;
 			debounce-interval = <10>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/tegra30-pegatron-chagall.dts b/arch/arm/boot/dts/tegra30-pegatron-chagall.dts
index 8ce61035290b..8b22d12dd0e2 100644
--- a/arch/arm/boot/dts/tegra30-pegatron-chagall.dts
+++ b/arch/arm/boot/dts/tegra30-pegatron-chagall.dts
@@ -2655,7 +2655,7 @@ extcon-keys {
 		compatible = "gpio-keys";
 		interrupt-parent = <&gpio>;
 
-		dock-insert {
+		event-dock-insert {
 			label = "Chagall Dock";
 			gpios = <&gpio TEGRA_GPIO(S, 4) GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
@@ -2665,7 +2665,7 @@ dock-insert {
 			wakeup-source;
 		};
 
-		lineout-detect {
+		event-lineout-detect {
 			label = "Audio dock line-out detect";
 			gpios = <&gpio TEGRA_GPIO(S, 3) GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
@@ -2688,7 +2688,7 @@ gpio-keys {
 		compatible = "gpio-keys";
 		interrupt-parent = <&gpio>;
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(V, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
@@ -2697,7 +2697,7 @@ power {
 			wakeup-source;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
@@ -2706,7 +2706,7 @@ volume-up {
 			wakeup-source;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio TEGRA_GPIO(Q, 1) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
-- 
2.34.1

