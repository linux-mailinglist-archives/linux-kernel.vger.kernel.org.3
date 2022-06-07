Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CA053FB66
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbiFGKei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241059AbiFGKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:34:00 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271C762BC4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:33:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bg6so14454331ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WdAxh+O0uIjFe4UvozVO34klV0ZIe/hi3OtAodjcZGE=;
        b=Mb0K0i/8GyglpnlM9LcfaGHP6z5FNt+4CH6xvL7yruCiCSjz9yV8dDlC/rrkNEfPkP
         OwCgk8SfaQc9DTDXA78F/nql/eOsSFR/gZcI7A1PnFQAt0mJUSrLh/fM1k1kpG3mHN2O
         2/Ic/F7zJxl1KA0NGD8BnnR8j4kGWRDSBKZpPkYbsfaDXgLCRNetWMxdE+t6gWF+S9+i
         240S7z8aSqm19wXigQDlaLCKbHOtzx97sMy2ns1mLpdTdC5ljmcvt2Xo2/ycby9QfsEf
         U1ih6H+BHoXc2VljsDuf6jGLcaVJFE586ohHZFoMEJ0gBZer2c5bvLvqshRITognF00L
         STnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WdAxh+O0uIjFe4UvozVO34klV0ZIe/hi3OtAodjcZGE=;
        b=gdz9RP9LEllqCa/nBPBdBaIBehV8bPM8XdrlrfHI85Zkx546HTA0NwPi/1MNMXlSoS
         0bgWW6LfCZycllNjllFDHJZD09u2IoSqK0hbHKSPVsniO1hk6xwucOwwMUSUWu29nPy0
         bWB+EXuHV25868jCMnTS1sFPykAKTCDK0pnckagKH6CS5N0FMjjG9ajfsSOSCgx6EeUE
         DcfKxSdykOvqh5Foobc13BV5YN1xuQLCIZBBlni8DteKn3BbDjNtpjckVZLwJTR2WJWH
         Ys/LjrAJCM/oczLclGa7EQbZ2o7I+9K9igU6D7AQh7nHYfv5sTuDCI8OwFKKjJRtyhW9
         3jtA==
X-Gm-Message-State: AOAM533yHflbOEVVck2i5k0cjp9WpR1CaQehWnhPFPHLUJoG/Ovu9ymP
        YembufyDxptXWxuV7I5Wd4cLZw==
X-Google-Smtp-Source: ABdhPJzvRlBXV1eQi92TT0ErMTBYtwbQKRdn24Vp05ftWF8pyeD1zchH+8Mlvqdt1bbOp7ohlNEIGw==
X-Received: by 2002:a17:906:14d5:b0:711:c55a:998 with SMTP id y21-20020a17090614d500b00711c55a0998mr11917498ejc.708.1654598035746;
        Tue, 07 Jun 2022 03:33:55 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709065ac400b00704fa2748ffsm7505359ejs.99.2022.06.07.03.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:33:55 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/10] arm64: dts: qcom: apq8016-sbc: add function and color to LED nodes
Date:   Tue,  7 Jun 2022 12:29:27 +0200
Message-Id: <20220607102931.102805-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
References: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
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

Add common LED properties - the function and color - to LED nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 7c1eab605c15..3385cdf14a28 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -8,6 +8,7 @@
 #include "msm8916-pm8916.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
 #include <dt-bindings/sound/apq8016-lpass.h>
@@ -116,6 +117,8 @@ leds {
 
 		led@1 {
 			label = "apq8016-sbc:green:user1";
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
@@ -123,6 +126,8 @@ led@1 {
 
 		led@2 {
 			label = "apq8016-sbc:green:user2";
+			function = LED_FUNCTION_DISK_ACTIVITY;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 			default-state = "off";
@@ -130,6 +135,8 @@ led@2 {
 
 		led@3 {
 			label = "apq8016-sbc:green:user3";
+			function = LED_FUNCTION_DISK_ACTIVITY;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc1";
 			default-state = "off";
@@ -137,6 +144,7 @@ led@3 {
 
 		led@4 {
 			label = "apq8016-sbc:green:user4";
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "none";
 			panic-indicator;
@@ -145,6 +153,8 @@ led@4 {
 
 		led@5 {
 			label = "apq8016-sbc:yellow:wlan";
+			function = LED_FUNCTION_WLAN;
+			color = <LED_COLOR_ID_YELLOW>;
 			gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "phy0tx";
 			default-state = "off";
@@ -152,6 +162,8 @@ led@5 {
 
 		led@6 {
 			label = "apq8016-sbc:blue:bt";
+			function = LED_FUNCTION_BLUETOOTH;
+			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "bluetooth-power";
 			default-state = "off";
-- 
2.34.1

