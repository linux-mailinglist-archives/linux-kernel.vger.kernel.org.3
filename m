Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36F3544ADA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbiFILpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244071AbiFILms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:42:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D4B19FB11
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:41:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y19so46905033ejq.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wlyfMpqGXVB3B8Sp9d9Fw1nG62ItFJzUUJSrBMxtd/M=;
        b=T4OPENj0j818Dka+qluWpuHUcpbCLpG0bBn4XqNPUfk9cOsLMKB1qgM1L3Uaa67WLd
         1OPGRNzkeBIlpUwV0XcMlA8B6LuZH55AWtOfLQ/ul4EGubEiYTqRiG2OD5LtYW14MNB/
         /3S1yBW4AZ3Jq9bc0KeMLT022R7bybLL68rE57HnDSzAL4Ny4Y3b8cONARd/p8c72TDA
         Az18I87/ozN8BJQpXQlPxSpWbrfo4b7mkH2M2EeIUOelRG+5ln0DalKyO3rKooRqpm6Q
         nk2jvdlbK/YKllCc2N263sxSq0OtHmQRRg7DkCK9CtJyAkfcF9tnnC7GJejdZJl5RlV+
         NJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wlyfMpqGXVB3B8Sp9d9Fw1nG62ItFJzUUJSrBMxtd/M=;
        b=CX27rt7tZ3ZvM2H48Z1fM9Ac6mrSUeYjY4xqh07N/MTwAtvzooLLCpyHWoiifqCBQe
         KuIzZoGT1OcDravCa4BAglkKLEOiIa9pbkmQNGgQ43owd9+qg5zoM6bWmw66YxVCMadh
         mYs6ON9112m5fmvqq06cagCusZWJYIXEM0exEsTyqimSSWDIz45PxWq1RiWsaWR/msH7
         v7CiCfr3IJKelnm3YZ1SgLvuXFk9YZI/V6cPNnc7bbdelyT8zLKdxnymTO0BD2kuAkgY
         ApP0Z+txLb6PzDvEqtVGGXPU1DH1M6OpxAW6TsDW6nrDqomQm/PbciASOqB8bLXXWrJ9
         BT5A==
X-Gm-Message-State: AOAM530GtUGjM3IsC+f3IO3np8q8D91XqxNujI/IEuUy7XSyvpbs/TX5
        UUP6IcYle+X5phHeTaKXkI6qFw==
X-Google-Smtp-Source: ABdhPJzyurk8T+/gdHotwYEIB44m4zpdWpgtcHUpbVaPxoviQXMxT9Nf1Jei89sQixCUE3E33ojk8Q==
X-Received: by 2002:a17:907:94c6:b0:6f5:287a:2bf2 with SMTP id dn6-20020a17090794c600b006f5287a2bf2mr36930792ejc.124.1654774863746;
        Thu, 09 Jun 2022 04:41:03 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bk2-20020a170906b0c200b006fef557bb7asm10498662ejb.80.2022.06.09.04.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 04:41:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 47/48] ARM: dts: exynos: align gpio-key node names with dtschema
Date:   Thu,  9 Jun 2022 13:40:46 +0200
Message-Id: <20220609114047.380793-8-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/exynos4210-i9100.dts        |  8 ++++----
 arch/arm/boot/dts/exynos4210-origen.dts       | 10 +++++-----
 arch/arm/boot/dts/exynos4412-itop-elite.dts   | 10 +++++-----
 arch/arm/boot/dts/exynos5250-arndale.dts      | 12 ++++++------
 arch/arm/boot/dts/exynos5250-snow-common.dtsi |  2 +-
 arch/arm/boot/dts/exynos5250-spring.dts       |  2 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |  2 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |  2 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |  2 +-
 9 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-i9100.dts b/arch/arm/boot/dts/exynos4210-i9100.dts
index 3c0a18b30837..bba85011ecc9 100644
--- a/arch/arm/boot/dts/exynos4210-i9100.dts
+++ b/arch/arm/boot/dts/exynos4210-i9100.dts
@@ -89,21 +89,21 @@ vt_core_15v_reg: regulator-5 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		vol-down {
+		key-vol-down {
 			gpios = <&gpx2 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEDOWN>;
 			label = "volume down";
 			debounce-interval = <10>;
 		};
 
-		vol-up {
+		key-vol-up {
 			gpios = <&gpx2 0 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_VOLUMEUP>;
 			label = "volume up";
 			debounce-interval = <10>;
 		};
 
-		power {
+		key-power {
 			gpios = <&gpx2 7 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "power";
@@ -111,7 +111,7 @@ power {
 			wakeup-source;
 		};
 
-		ok {
+		key-ok {
 			gpios = <&gpx3 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_OK>;
 			label = "ok";
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index a08ce2f37ea2..bfdc21854914 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -46,35 +46,35 @@ mmc_reg: voltage-regulator {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		up {
+		key-up {
 			label = "Up";
 			gpios = <&gpx2 0 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_UP>;
 			wakeup-source;
 		};
 
-		down {
+		key-down {
 			label = "Down";
 			gpios = <&gpx2 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_DOWN>;
 			wakeup-source;
 		};
 
-		back {
+		key-back {
 			label = "Back";
 			gpios = <&gpx1 7 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BACK>;
 			wakeup-source;
 		};
 
-		home {
+		key-home {
 			label = "Home";
 			gpios = <&gpx1 6 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 			wakeup-source;
 		};
 
-		menu {
+		key-menu {
 			label = "Menu";
 			gpios = <&gpx1 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_MENU>;
diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
index a9406280b979..05db9eb9b24c 100644
--- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
+++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
@@ -44,31 +44,31 @@ led3 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		home {
+		key-home {
 			label = "GPIO Key Home";
 			linux,code = <KEY_HOME>;
 			gpios = <&gpx1 1 GPIO_ACTIVE_LOW>;
 		};
 
-		back {
+		key-back {
 			label = "GPIO Key Back";
 			linux,code = <KEY_BACK>;
 			gpios = <&gpx1 2 GPIO_ACTIVE_LOW>;
 		};
 
-		sleep {
+		key-sleep {
 			label = "GPIO Key Sleep";
 			linux,code = <KEY_POWER>;
 			gpios = <&gpx3 3 GPIO_ACTIVE_LOW>;
 		};
 
-		vol-up {
+		key-vol-up {
 			label = "GPIO Key Vol+";
 			linux,code = <KEY_UP>;
 			gpios = <&gpx2 1 GPIO_ACTIVE_LOW>;
 		};
 
-		vol-down {
+		key-vol-down {
 			label = "GPIO Key Vol-";
 			linux,code = <KEY_DOWN>;
 			gpios = <&gpx2 0 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index f7795f2d0f0e..71c0e87d3a1d 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -30,42 +30,42 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		menu {
+		key-menu {
 			label = "SW-TACT2";
 			gpios = <&gpx1 4 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_MENU>;
 			wakeup-source;
 		};
 
-		home {
+		key-home {
 			label = "SW-TACT3";
 			gpios = <&gpx1 5 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_HOME>;
 			wakeup-source;
 		};
 
-		up {
+		key-up {
 			label = "SW-TACT4";
 			gpios = <&gpx1 6 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_UP>;
 			wakeup-source;
 		};
 
-		down {
+		key-down {
 			label = "SW-TACT5";
 			gpios = <&gpx1 7 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_DOWN>;
 			wakeup-source;
 		};
 
-		back {
+		key-back {
 			label = "SW-TACT6";
 			gpios = <&gpx2 0 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_BACK>;
 			wakeup-source;
 		};
 
-		wakeup {
+		key-wakeup {
 			label = "SW-TACT7";
 			gpios = <&gpx2 1 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index c15ecfc4077d..3d84b9c6dea3 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -32,7 +32,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&power_key_irq &lid_irq>;
 
-		power {
+		power-key {
 			label = "Power";
 			gpios = <&gpx1 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index 24609bb20158..5eca10ecd550 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -33,7 +33,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&power_key_irq>, <&lid_irq>;
 
-		power {
+		power-key {
 			label = "Power";
 			gpios = <&gpx1 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 946b791faf85..55b7759682a9 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -42,7 +42,7 @@ oscclk {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		wakeup {
+		key-wakeup {
 			label = "SW-TACT1";
 			gpios = <&gpx2 7 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index d6434ec86022..9e2123470cad 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -60,7 +60,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&power_key_irq &lid_irq>;
 
-		power {
+		power-key {
 			label = "Power";
 			gpios = <&gpx1 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 4ee76281979c..0ebcb66c6319 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -59,7 +59,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&power_key_irq &lid_irq>;
 
-		power {
+		power-key {
 			label = "Power";
 			gpios = <&gpx1 2 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
-- 
2.34.1

