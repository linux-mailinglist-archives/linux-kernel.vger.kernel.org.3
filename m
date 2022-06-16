Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D93E54D66C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350086AbiFPAzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350883AbiFPAy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:54:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04404580EF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so118919pjz.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9UaV1sYZIIEFZGVRGlOf8TGBu1P1hS1TkTEk2+ru+4=;
        b=tXWDHOTshK3ZvSEO/QH+hzsm1OU4HunqWlYHKsRkCEa+zeOlCxCGW+OVxeKzuVfUdG
         U902w8zmMtF8n7IawKlBAqh11YnJPVI2cVJxDz08sdKzDzeDeILrBKKXOeP6imlw2bat
         AKRqFl9P3+4Jhgdj2Z1n47d1qCe+EmL3PHK9xlHseIOC8sOkaSwi8xp7H1G95satKI5W
         MzHomOvAn1+7Cy9CzVmz1JfG0pOC6wsRNPFNbBEYCNXa9qGsrgOhbMn4W6Qq46NZvc5j
         v3VJacZ7Ie7XDXBiA5gEfaTIhMB+hS0LXChuhfMWCvGzAOgR9FvRMW9jxCRtbRDVUp+k
         cukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9UaV1sYZIIEFZGVRGlOf8TGBu1P1hS1TkTEk2+ru+4=;
        b=sOARJdmkvytsOfzvK+EPNNIayU04DEQtpjy5Ml0jAgeV3NgZdqh6z2dV97jZyhmgG6
         0E1FaQLrhyG3LQlVh5Cz5a9mshWbVYHzvjP58bkcJUTBlkt9F6Vz5Azqpss5C+ZzljqL
         0vdOwqGSFMTQ6+Orxae1ikUzCqQsEL5QuRZFvor1Iuro6lJqHSWp7bvw0tNkIEor2gf/
         A7b80zoe09031VIfjYCYACrGmav5g80lA9L9I7B8f0gMOHvkhVi6XZLNCQOCzrhfDW7w
         tG3rdVLP2TvjkeJVm0F8rahereOhoSfHJiKO199yzClExdS7kqmrCcOhRt/BkxGbRFJB
         b9DA==
X-Gm-Message-State: AJIora+fw6Zy/26FLyKOCl5LfqfeZBZOmuqnUA3Yu3F4UYdFs8xOzUyx
        Lh/RTc/Sx1UkpMqi1pUSwe19sA==
X-Google-Smtp-Source: AGRyM1tDRWvOPoXGaxd6yySH2Ituh+oc0RH1upOt/9o6cEmXxjnSJUR7CRc7UmKQ83ju/QXA73mI8g==
X-Received: by 2002:a17:903:2645:b0:167:92f1:15c0 with SMTP id je5-20020a170903264500b0016792f115c0mr2173940plb.100.1655340873576;
        Wed, 15 Jun 2022 17:54:33 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 26/40] arm64: dts: rockchip: align gpio-key node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:19 -0700
Message-Id: <20220616005333.18491-26-krzysztof.kozlowski@linaro.org>
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

Changes since v2:
1. rk3308-evb.dts, rk3326-odroid-go2.dts: different names according to
   discussion.
---
 arch/arm64/boot/dts/rockchip/rk3308-evb.dts   |  2 +-
 .../boot/dts/rockchip/rk3326-odroid-go2.dts   | 32 +++++++++----------
 .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   |  2 +-
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi  |  2 +-
 .../boot/dts/rockchip/rk3368-geekbox.dts      |  2 +-
 .../dts/rockchip/rk3368-orion-r68-meta.dts    |  2 +-
 .../boot/dts/rockchip/rk3368-px5-evb.dts      |  2 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts   |  2 +-
 .../boot/dts/rockchip/rk3399-firefly.dts      |  2 +-
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  2 +-
 .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  2 +-
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi |  2 +-
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi |  2 +-
 .../boot/dts/rockchip/rk3399-nanopi-r4s.dts   |  4 +--
 .../boot/dts/rockchip/rk3399-nanopi4.dtsi     |  2 +-
 .../boot/dts/rockchip/rk3399-orangepi.dts     |  2 +-
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts |  4 +--
 .../boot/dts/rockchip/rk3399-roc-pc.dtsi      |  2 +-
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   |  2 +-
 .../boot/dts/rockchip/rk3399-sapphire.dtsi    |  2 +-
 .../boot/dts/rockchip/rk3566-pinenote.dtsi    |  2 +-
 21 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
index 9b4f855ea5d4..9fe9b0d11003 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-evb.dts
@@ -75,7 +75,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key>;
 
-		power {
+		key-power {
 			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_POWER>;
 			label = "GPIO Key Power";
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index ea0695b51ecd..415aa9ff8bd4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -71,82 +71,82 @@ gpio-keys {
 		 * |------------------------------------------------|
 		 */
 
-		sw1 {
+		button-sw1 {
 			gpios = <&gpio1 RK_PB4 GPIO_ACTIVE_LOW>;
 			label = "DPAD-UP";
 			linux,code = <BTN_DPAD_UP>;
 		};
-		sw2 {
+		button-sw2 {
 			gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_LOW>;
 			label = "DPAD-DOWN";
 			linux,code = <BTN_DPAD_DOWN>;
 		};
-		sw3 {
+		button-sw3 {
 			gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_LOW>;
 			label = "DPAD-LEFT";
 			linux,code = <BTN_DPAD_LEFT>;
 		};
-		sw4 {
+		button-sw4 {
 			gpios = <&gpio1 RK_PB7 GPIO_ACTIVE_LOW>;
 			label = "DPAD-RIGHT";
 			linux,code = <BTN_DPAD_RIGHT>;
 		};
-		sw5 {
+		button-sw5 {
 			gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "BTN-A";
 			linux,code = <BTN_EAST>;
 		};
-		sw6 {
+		button-sw6 {
 			gpios = <&gpio1 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "BTN-B";
 			linux,code = <BTN_SOUTH>;
 		};
-		sw7 {
+		button-sw7 {
 			gpios = <&gpio1 RK_PA6 GPIO_ACTIVE_LOW>;
 			label = "BTN-Y";
 			linux,code = <BTN_WEST>;
 		};
-		sw8 {
+		button-sw8 {
 			gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_LOW>;
 			label = "BTN-X";
 			linux,code = <BTN_NORTH>;
 		};
-		sw9 {
+		button-sw9 {
 			gpios = <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
 			label = "F1";
 			linux,code = <BTN_TRIGGER_HAPPY1>;
 		};
-		sw10 {
+		button-sw10 {
 			gpios = <&gpio2 RK_PA1 GPIO_ACTIVE_LOW>;
 			label = "F2";
 			linux,code = <BTN_TRIGGER_HAPPY2>;
 		};
-		sw11 {
+		button-sw11 {
 			gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "F3";
 			linux,code = <BTN_TRIGGER_HAPPY3>;
 		};
-		sw12 {
+		button-sw12 {
 			gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_LOW>;
 			label = "F4";
 			linux,code = <BTN_TRIGGER_HAPPY4>;
 		};
-		sw13 {
+		button-sw13 {
 			gpios = <&gpio2 RK_PA4 GPIO_ACTIVE_LOW>;
 			label = "F5";
 			linux,code = <BTN_TRIGGER_HAPPY5>;
 		};
-		sw14 {
+		button-sw14 {
 			gpios = <&gpio2 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "F6";
 			linux,code = <BTN_TRIGGER_HAPPY6>;
 		};
-		sw15 {
+		button-sw15 {
 			gpios = <&gpio2 RK_PA6 GPIO_ACTIVE_LOW>;
 			label = "TOP-LEFT";
 			linux,code = <BTN_TL>;
 		};
-		sw16 {
+		button-sw16 {
 			gpios = <&gpio2 RK_PA7 GPIO_ACTIVE_LOW>;
 			label = "TOP-RIGHT";
 			linux,code = <BTN_TR>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
index 3857d487ab84..1445b879ac7a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
@@ -34,7 +34,7 @@ keys {
 		pinctrl-0 = <&reset_button_pin>;
 		pinctrl-names = "default";
 
-		reset {
+		key-reset {
 			label = "reset";
 			gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_RESTART>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
index 15d1fc541c38..083452c67711 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
@@ -76,7 +76,7 @@ keys: gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key>;
 
-		power {
+		key-power {
 			wakeup-source;
 			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
index 62aa97a0b8c9..be06e6e64d18 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
@@ -43,7 +43,7 @@ keys: gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key>;
 
-		power {
+		key-power {
 			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
index 05c50e584e2e..7f5bba0c6001 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
@@ -44,7 +44,7 @@ keys: gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key>;
 
-		power {
+		key-power {
 			wakeup-source;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
 			label = "GPIO Power";
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
index 5ccaa5f7a370..29df84b81552 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts
@@ -30,7 +30,7 @@ keys: gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key>;
 
-		power {
+		key-power {
 			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
 			linux,code = <KEY_POWER>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 959d3cc801f2..38d757c00548 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -37,7 +37,7 @@ keys: gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key>;
 
-		power {
+		key-power {
 			wakeup-source;
 			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
index b340c9e246c4..c5db64f3e124 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-firefly.dts
@@ -87,7 +87,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwrbtn>;
 
-		power {
+		key-power {
 			debounce-interval = <100>;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Key Power";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 50d459ee4831..cd074641884b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -206,7 +206,7 @@ gpio_keys: gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&bt_host_wake_l>;
 
-		wake_on_bt: wake-on-bt {
+		wake_on_bt: key-wake-on-bt {
 			label = "Wake-on-Bluetooth";
 			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_WAKEUP>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
index 6863689df06f..2cc9b3386c16 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
@@ -92,7 +92,7 @@ &gpio_keys {
 	pinctrl-names = "default";
 	pinctrl-0 = <&bt_host_wake_l>, <&cpu1_pen_eject>;
 
-	pen-insert {
+	switch-pen-insert {
 		label = "Pen Insert";
 		/* Insert = low, eject = high */
 		gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index 1977103a5ef4..40d4053fba80 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -183,7 +183,7 @@ gpio_keys: gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pen_eject_odl>;
 
-		pen-insert {
+		switch-pen-insert {
 			label = "Pen Insert";
 			/* Insert = low, eject = high */
 			gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index 46c4581deb8d..2a332763c35c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -136,7 +136,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwrbtn>;
 
-		power {
+		key-power {
 			debounce-interval = <100>;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Key Power";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
index cef4d18b599d..fe5b52610010 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -46,9 +46,9 @@ wan_led: led-wan {
 	gpio-keys {
 		pinctrl-0 = <&reset_button_pin>;
 
-		/delete-node/ power;
+		/delete-node/ key-power;
 
-		reset {
+		key-reset {
 			debounce-interval = <50>;
 			gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_LOW>;
 			label = "reset";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 248ad41a976b..278123b4f911 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -111,7 +111,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&power_key>;
 
-		power {
+		key-power {
 			debounce-interval = <100>;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Key Power";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
index ed856bfcfc33..9e2e246e0bab 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts
@@ -78,7 +78,7 @@ keys: gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
 
-		power {
+		key-power {
 			debounce-interval = <100>;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index d6b68d77d63a..194e48c755f6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -76,7 +76,7 @@ gpio-key-lid {
 		pinctrl-names = "default";
 		pinctrl-0 = <&lidbtn_pin>;
 
-		lid {
+		switch-lid {
 			debounce-interval = <20>;
 			gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_LOW>;
 			label = "Lid";
@@ -92,7 +92,7 @@ gpio-key-power {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwrbtn_pin>;
 
-		power {
+		key-power {
 			debounce-interval = <20>;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "Power";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 0e45cc2d195b..acb174d3a8c5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -54,7 +54,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key_l>;
 
-		power {
+		key-power {
 			debounce-interval = <100>;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Key Power";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 6fdeee7d5f6d..78157521e944 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -42,7 +42,7 @@ gpio-keys {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwrbtn>;
 
-		power {
+		key-power {
 			debounce-interval = <100>;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Key Power";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
index 2aa0fad8f893..e6ac292ce645 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
@@ -53,7 +53,7 @@ keys: gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
 
-		power {
+		key-power {
 			debounce-interval = <100>;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index e01668e6e5f9..ea0fa627c464 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -49,7 +49,7 @@ gpio-keys {
 		pinctrl-0 = <&hall_int_l>;
 		pinctrl-names = "default";
 
-		cover {
+		switch {
 			label = "cover";
 			gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
-- 
2.34.1

