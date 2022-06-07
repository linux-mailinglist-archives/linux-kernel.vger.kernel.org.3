Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4971753F8C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbiFGIxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbiFGIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:52:50 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96EB21E14
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:52:43 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x5so16956785edi.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OapD3u8DomPXjbd8E0R7YCXIachZWLk3usrmeEbpFXo=;
        b=pwe80uBatLu7X4lqc+cj/wQz5j6Z12sV71Cs5XsOfAK7RC/EW6emZgCSstiPvQD5HO
         CxdFNdFYsCepMxsW4n+Xq+CWSK/Zi1OboF9pUcVaxlZNpBSqvOscWGrUoAaGO8yYghdd
         jW25ILEukRsJmIOJJlP67CIZz6JRAFFc3e40Rl7D1RCYuGdp3ArYMv2zIwNeGl6EY5Kl
         JZmvyWdShxVGGBDETh+MuVS7FmTz+yA6+a4owsh+KGbSm5AMMi2tbYM2ykSg9wpxzqBw
         EeHKSZQ7g/WZVpmPbY9zJ97oh7ZWFXtOKeCxhA2qeMBKBRJM1ymJBM8lScZlKYG7L/V6
         FgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OapD3u8DomPXjbd8E0R7YCXIachZWLk3usrmeEbpFXo=;
        b=ABepEEQSFlz0+b+7TD4AQv5itkVUpHKO8iZaHLVZcFK/VHu+/BeTS3nWqrKHFzjR6V
         C+z9qSdDdopLwUwq4OGtJKOLdm6jXM2q0lQouifbB4bs/2i3zSk4pjM0SjAOhiXr3/np
         hWyzi8ryXPA7TcMQxxPzwcR6SZm1FhwBDKC6AwGdyWkzs1wT05cUvm1PBH3KPff4wmIo
         DfyItV8PKg5rptZ1vRwB9SIAQX3h0xBl0CNNs9fiWKpw194Zq6NpXed9uX3ju95zHSdJ
         QlCGmdPNNujxauyDxIEIrhymOh0d7WWYMXNaCz4XW+oj+LaPBCGUc/AEuSm+1Df4tK+V
         uO0A==
X-Gm-Message-State: AOAM5305WTZcecrBQCedFOg4LrqcbfBrQ2wHchtX7vxj9EGmBQ08JfTL
        FXkBn9/l2r7ld8k8G5/Fq7F3LA==
X-Google-Smtp-Source: ABdhPJw7RJjDpizAzDQGq5EM/WF+JeSoXP061+e/qJWgF/HEWaNinPmoyUFpT1f32/n3NwbhzYHz5Q==
X-Received: by 2002:a05:6402:254e:b0:431:35df:5e38 with SMTP id l14-20020a056402254e00b0043135df5e38mr17145811edb.385.1654591962303;
        Tue, 07 Jun 2022 01:52:42 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lk24-20020a170906cb1800b006fa84a0af2asm7458137ejb.16.2022.06.07.01.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:52:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 8/8] ARM: dts: exynos: add function and color to LED nodes in Odroid XU/XU3
Date:   Tue,  7 Jun 2022 10:52:31 +0200
Message-Id: <20220607085231.72246-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607085231.72246-1-krzysztof.kozlowski@linaro.org>
References: <20220607085231.72246-1-krzysztof.kozlowski@linaro.org>
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

Add common LED properties - the function and color - to LED nodes in
Exynos5422 Odroid XU/XU3/XU3-Lite.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi b/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
index 982752e1df24..4e17c040d0be 100644
--- a/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
+++ b/arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	led-controller-1 {
@@ -16,6 +17,8 @@ led-controller-1 {
 
 		led-1 {
 			label = "green:mmc0";
+			function = LED_FUNCTION_DISK_ACTIVITY;
+			color = <LED_COLOR_ID_GREEN>;
 			pwms = <&pwm 1 2000000 0>;
 			pwm-names = "pwm1";
 			/*
@@ -28,6 +31,8 @@ led-1 {
 
 		led-2 {
 			label = "blue:heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_BLUE>;
 			pwms = <&pwm 2 2000000 0>;
 			pwm-names = "pwm2";
 			max-brightness = <255>;
@@ -40,6 +45,8 @@ led-controller-2 {
 
 		led-3 {
 			label = "red:microSD";
+			function = LED_FUNCTION_DISK_ACTIVITY;
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpx2 3 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 			linux,default-trigger = "mmc1";
-- 
2.34.1

