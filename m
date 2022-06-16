Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEDB54D669
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354888AbiFPAza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350798AbiFPAys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:54:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CDC56748
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i15so29696plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMCBqJLXl1yZV+e3LQN80RorsyQqGZTi99dCXoJkMfc=;
        b=I1/UIAxpSASF+5dR7pcT8TdG9BRTLTaSxQqJxvVGU1dJE27/UkBU24DpeEcAFxw1ig
         xGmFRGuxvpdiDXwBWM6AiwaBer3gXZiZdEOJ7k+gvIF948/cBz/LOl4Uh+iG5XJYM0G2
         ZjhXekfG+CXt5wuKTtAEAhqhp9bKSrpZNcSAPAKSz4GYmkYGaMBWWG5N6j/2rLKtkEa3
         Wh/QUjJfwIiSHQYZabM6k+3nXn7qiMv6IAju9YoWQCSbiTuU6uw0yKYazZu2e3KkqjUE
         tr1v+sQvtl3lFfz++plAg8A7U3PexyFYHZaakYzJJY8oCbuWb5gVcq+1DornCwsCsIzN
         DGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMCBqJLXl1yZV+e3LQN80RorsyQqGZTi99dCXoJkMfc=;
        b=nedor7nwFQVx+wBvw9jA4Lk5YiDn4S1pA69eGFFaP6OWx2EWTMxExcF5I9GTWtbHAe
         oc8b4rVBFb3of4dWayGpKsegrtUzmKNpARq9/QHWuCTdupM0VETnWPXA6akrOUSn6uhc
         7uvpg6rOXGC1WEg1s4Y/Nl2mcgSg531t/w5h5/hpv+r2Xc6VDvho+0jm/i4Gj0Nbe6jv
         7SYqICBstBtnNtp5hKCIM+ac+KmsKSY74/kYr/Kxcz3j9DuUXohjm2Dk+ocMn+FoOg41
         dDZd3mDzQGvbXk6ziV4gdmpcT0XHBmNo41JcS+c8wSQDaIBfQMs6RgXEM1ps2/VBe+z8
         0Qsw==
X-Gm-Message-State: AJIora9Nsr0RMEJuU+67RB3wx6KExkDthG/qixhO2wiYj8U67dXQ+Vlt
        G6QmVPlsOowzwmydRDJUhYLkOw==
X-Google-Smtp-Source: AGRyM1v9+8nFUYlx31cfvNeIk/VMLVb9C7s+cyQKHmJwZrryD4Q0rBmT6429A62oDwaOeSqypA7A4w==
X-Received: by 2002:a17:902:b7c3:b0:167:7ca8:7f24 with SMTP id v3-20020a170902b7c300b001677ca87f24mr2240516plz.51.1655340870073;
        Wed, 15 Jun 2022 17:54:30 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016760c06b76sm233660pll.194.2022.06.15.17.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:54:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 24/40] arm64: dts: qcom: align led node names with dtschema
Date:   Wed, 15 Jun 2022 17:53:17 -0700
Message-Id: <20220616005333.18491-24-krzysztof.kozlowski@linaro.org>
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
with 'led'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts      | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
index 6a200f37c035..0a5b4617a8e6 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
@@ -133,7 +133,7 @@ button-camera-focus {
 	keyboard-leds {
 		compatible = "gpio-leds";
 
-		backlight {
+		led-0 {
 			color = <LED_COLOR_ID_WHITE>;
 			default-state = "off";
 			function = LED_FUNCTION_KBD_BACKLIGHT;
@@ -142,7 +142,7 @@ backlight {
 			retain-state-suspended;
 		};
 
-		caps-lock {
+		led-1 {
 			color = <LED_COLOR_ID_YELLOW>;
 			default-state = "off";
 			function = LED_FUNCTION_CAPSLOCK;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index a6986f95a80a..72b234ad9fab 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -60,21 +60,21 @@ key-vol-up {
 	leds {
 		compatible = "gpio-leds";
 
-		user4 {
+		led-0 {
 			label = "green:user4";
 			gpios = <&pm8998_gpio 13 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "panic-indicator";
 			default-state = "off";
 		};
 
-		wlan {
+		led-1 {
 			label = "yellow:wlan";
 			gpios = <&pm8998_gpio 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "phy0tx";
 			default-state = "off";
 		};
 
-		bt {
+		led-2 {
 			label = "blue:bt";
 			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "bluetooth-power";
-- 
2.34.1

