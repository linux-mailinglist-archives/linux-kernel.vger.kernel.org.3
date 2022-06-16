Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689F754D67A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350945AbiFPAzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350529AbiFPAyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:54:32 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8D057B02
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:21 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 123so12908639pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jcozBsTgT/YC375ApFyzAWc29eO1kZXhYvLLJcIaQdo=;
        b=uxHFvoBck6yzY13QJwCsoy/QcDiD4jvtNexDfJw3rrfOw3IFtc7LVD1pbniMZr4S8a
         4qRn9RcyAbzt4XtOHwUDQ3l7T89+Lhj1iiHrSvEzjvehKWx6pbjoIwMmYIiLKLxS9j/k
         4JRWTqSg/RbC6POQmdE497s4734M9zfH7uP5MUXdHG8/+V8gPs2fqkRPwk4HVxndxxkR
         P7ExyuudbU4dIMWIjkOg4uydXxsiEkAH+XuQvDsyk9jkxXSUC2issAdUHFD6nmKOxQ+0
         atJunX/eYcBXIQFS2wq0CrDD6TWj1osotINHUs2oJ2/W6QFyl4O0oACI5sozsaHmyJkr
         CmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jcozBsTgT/YC375ApFyzAWc29eO1kZXhYvLLJcIaQdo=;
        b=xoZwUghEJ2uHYjU7fpBYYE9HHLhEIbPQZUPHFpzp8P7MrmmgYgyb4zXk+yC3V9JLVh
         aUEDeW4TPg+SoIPxjDoiS4wZejDL/fQHiapEUm6o5D58NRZgPfsmgNsNhDCf6fMg1goy
         Ai73l1Phzvf9+Y6B3aSn5NCJObimOGZYeXxlgO+P5IWVO6BbCWfQ+H5FjiAhXAgynYac
         SHNLmrU9G3m7d4/Sw9fG+BtrWftDn2jxRoXOaMzejnXRqk1yE2biYTMft03zftSSsPZd
         xkxd9TJPSXKS0OXODl2U0clmLgrfhPf6xKQQntF1EZ8DJLV2SS09uEj2KybxSeWLhRn0
         +QVA==
X-Gm-Message-State: AJIora9BctHFoxS5zAqxRGXgGti76j2xkaDN9MbzrUdwXdhR9lp9YfNd
        Mlay23dVd3jnKdaXK5TQIEw5Ew==
X-Google-Smtp-Source: AGRyM1twcd2tCwMCwZDSv8F+YE4PR3Dyio/ZQOxjwbua4c1v6W7iAOTzZjDWyfglp/ue8SymIlHzYQ==
X-Received: by 2002:a05:6a00:b8c:b0:51c:2d3d:4595 with SMTP id g12-20020a056a000b8c00b0051c2d3d4595mr2263247pfj.80.1655340861234;
        Wed, 15 Jun 2022 17:54:21 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 19/40] arm64: dts: tegra: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:12 -0700
Message-Id: <20220616005333.18491-19-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts         |  4 ++--
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts     |  6 +++---
 .../boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts |  6 +++---
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts     |  4 ++--
 arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi    |  4 ++--
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi         |  6 +++---
 arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi         |  2 +-
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts     |  4 ++--
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts          | 10 +++++-----
 .../boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts |  6 +++---
 10 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
index f16acb4cabaa..62d58221ad3c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
@@ -1030,7 +1030,7 @@ clk32k_in: clock-32k {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		lid {
+		switch-lid {
 			label = "Lid";
 			gpios = <&gpio TEGRA_GPIO(R, 4) GPIO_ACTIVE_LOW>;
 			linux,input-type = <5>;
@@ -1039,7 +1039,7 @@ lid {
 			wakeup-source;
 		};
 
-		power {
+		switch-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
index bd1897707fcc..47cf2013afcc 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
@@ -2478,7 +2478,7 @@ sata@3507000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio_aon TEGRA186_AON_GPIO(FF, 0)
 					   GPIO_ACTIVE_LOW>;
@@ -2489,7 +2489,7 @@ power {
 			wakeup-source;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio_aon TEGRA186_AON_GPIO(FF, 1)
 					   GPIO_ACTIVE_LOW>;
@@ -2498,7 +2498,7 @@ volume-up {
 			debounce-interval = <10>;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio_aon TEGRA186_AON_GPIO(FF, 2)
 					   GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts b/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts
index 7e9aad9ff177..3e83a4d52eb1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra186-p3509-0000+p3636-0001.dts
@@ -360,7 +360,7 @@ fan: pwm-fan {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio_aon TEGRA186_AON_GPIO(FF, 0)
 					   GPIO_ACTIVE_LOW>;
@@ -371,7 +371,7 @@ power {
 			wakeup-source;
 		};
 
-		volume-up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio_aon TEGRA186_AON_GPIO(FF, 1)
 					   GPIO_ACTIVE_LOW>;
@@ -380,7 +380,7 @@ volume-up {
 			debounce-interval = <10>;
 		};
 
-		volume-down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio_aon TEGRA186_AON_GPIO(FF, 2)
 					   GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
index fafd7073d18c..bc1041d11f6d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
@@ -2258,7 +2258,7 @@ fan: pwm-fan {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		force-recovery {
+		key-force-recovery {
 			label = "Force Recovery";
 			gpios = <&gpio TEGRA194_MAIN_GPIO(G, 0)
 				       GPIO_ACTIVE_LOW>;
@@ -2267,7 +2267,7 @@ force-recovery {
 			debounce-interval = <10>;
 		};
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio_aon TEGRA194_AON_GPIO(EE, 4)
 					   GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
index 4cee935e44a5..273a1ef716b6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p3509-0000.dtsi
@@ -2262,7 +2262,7 @@ fan: pwm-fan {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		force-recovery {
+		key-force-recovery {
 			label = "Force Recovery";
 			gpios = <&gpio TEGRA194_MAIN_GPIO(G, 0)
 				       GPIO_ACTIVE_LOW>;
@@ -2271,7 +2271,7 @@ force-recovery {
 			debounce-interval = <10>;
 		};
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio_aon TEGRA194_AON_GPIO(EE, 4)
 					   GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index 4b43b89a9651..a44c56c1e56e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1530,20 +1530,20 @@ gpio-keys {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(X, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			wakeup-source;
 		};
 
-		volume_down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio TEGRA_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
-		volume_up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(X, 6) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi
index 10347b6e6e84..8e657b10569d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi
@@ -1596,7 +1596,7 @@ gpio-keys {
 		compatible = "gpio-keys";
 		status = "okay";
 
-		power {
+		key-power {
 			debounce-interval = <30>;
 			gpios = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_LOW>;
 			label = "Power";
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
index 749b44cf3ffa..37678c337a34 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts
@@ -1802,7 +1802,7 @@ cpu-passive {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(X, 5) GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_KEY>;
@@ -1812,7 +1812,7 @@ power {
 			wakeup-source;
 		};
 
-		force-recovery {
+		key-force-recovery {
 			label = "Force Recovery";
 			gpios = <&gpio TEGRA_GPIO(X, 6) GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_KEY>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index a263d51882ee..8494c7b2961b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1756,7 +1756,7 @@ cpu-sleep {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		power {
+		key-power {
 			label = "Power";
 			gpios = <&gpio TEGRA_GPIO(X, 5) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
@@ -1764,7 +1764,7 @@ power {
 			wakeup-source;
 		};
 
-		lid {
+		switch-lid {
 			label = "Lid";
 			gpios = <&gpio TEGRA_GPIO(B, 4) GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
@@ -1772,7 +1772,7 @@ lid {
 			wakeup-source;
 		};
 
-		tablet_mode {
+		key-tablet-mode {
 			label = "Tablet Mode";
 			gpios = <&gpio TEGRA_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
 			linux,input-type = <EV_SW>;
@@ -1780,13 +1780,13 @@ tablet_mode {
 			wakeup-source;
 		};
 
-		volume_down {
+		key-volume-down {
 			label = "Volume Down";
 			gpios = <&gpio TEGRA_GPIO(X, 7) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 		};
 
-		volume_up {
+		key-volume-up {
 			label = "Volume Up";
 			gpios = <&gpio TEGRA_GPIO(M, 4) GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index 3f6c399e3371..02a10bb38562 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -2021,14 +2021,14 @@ gpio-keys {
 		compatible = "gpio-keys";
 		status = "okay";
 
-		force-recovery {
+		key-force-recovery {
 			label = "Force Recovery";
 			gpios = <&gpio TEGRA234_MAIN_GPIO(G, 0) GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_KEY>;
 			linux,code = <BTN_1>;
 		};
 
-		power-key {
+		key-power {
 			label = "Power";
 			gpios = <&gpio_aon TEGRA234_AON_GPIO(EE, 4) GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_KEY>;
@@ -2037,7 +2037,7 @@ power-key {
 			wakeup-source;
 		};
 
-		suspend {
+		key-suspend {
 			label = "Suspend";
 			gpios = <&gpio TEGRA234_MAIN_GPIO(G, 2) GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_KEY>;
-- 
2.34.1

