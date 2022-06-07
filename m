Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAE253F8BF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbiFGIxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238676AbiFGIwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:52:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAD7186C4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:52:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq6so20740012ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 01:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YT+2L+1k/jLLOrfW59KWU9Ya4hbG+ZAnHljBrrzu/WY=;
        b=tZkBrcugm3d+uQGBHLu4ISyC/+KePxoHoClbAmHkFE3GsMicQ3j8IOeUj3qLCey0tt
         Ek1qMFU3f7JxSPcwm4QFJv557/uhvbHmZTgn+v671w3SmupKwb7h6efflBq3aDTJrTul
         TT3Y+yf49bKOMQMsODvyx6QGsp3pdB6F+ZBG+VsyTifYhzotQaRUpPqEWkiyRykz4uKJ
         WrNe+u2LHmJ2w6B/KUMzBcnD5NUv3C7lcqpIg7BHBy5ZCNhA71W7MYG9O1WwHertEhp9
         A1NGG0XcTvFEXvJ0Ywa1TS/l9JO65SFUAufrlRA0WWU1hys1GuPKsPd4nW9wiwbbfR4F
         uE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YT+2L+1k/jLLOrfW59KWU9Ya4hbG+ZAnHljBrrzu/WY=;
        b=f6ZHeMBEtSODlkES8/fpyvlruZpI4Q+HzQWcdFe85zuJ+VsQkyYgEca5tAcFrAG9LH
         akcYzSEyD8rThVIH6wiaQ6FQspwTLwGiYoybIKcx+0uzojIebB0uRQVxUUnLlpfUXfM/
         rJ+JJTZldkH3QWZ4IgbOlvItzycwEV1UkXdf9FOP5aEgB2uUFLN5BFOFu2O+Vk7gEZja
         yULjLcSE34odKiJ13m5wVQcN7d73qyQAg9vdEBBUsNpG5AXuFBYaHMxENTip/xmMuNUO
         r9G9JIND5QIaqYPPftcxyKesuPKvG6WQgap+AJaiZYCKeO8eKPmZryP0XQzKHLUa8BDt
         SiDQ==
X-Gm-Message-State: AOAM533FQDuHDfmIk5e2eNAEGrK+DQL2h7XJGgUqCZjs9W7qPmJmdyCC
        mtUQHuYp9x1zqfZUSVT5EC2NNg==
X-Google-Smtp-Source: ABdhPJyYViMegf8NUq6mrTDz88Uv43gvwiUkl1wdp7laXDNLo/hB8QGFuDQ0f3CoqvYDk+FdJGU9/Q==
X-Received: by 2002:a17:906:dc89:b0:6f4:d3a9:34ed with SMTP id cs9-20020a170906dc8900b006f4d3a934edmr25179930ejc.459.1654591961278;
        Tue, 07 Jun 2022 01:52:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id lk24-20020a170906cb1800b006fa84a0af2asm7458137ejb.16.2022.06.07.01.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:52:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 7/8] ARM: dts: exynos: add function and color to LED node in Odroid XU4
Date:   Tue,  7 Jun 2022 10:52:30 +0200
Message-Id: <20220607085231.72246-7-krzysztof.kozlowski@linaro.org>
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

Add common LED properties - the function and color - to LED node in
Exynos5422 Odroid XU4.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos5422-odroidxu4.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 1c24f9b35973..64683f682c07 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -9,6 +9,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5422-odroidxu3-common.dtsi"
 
@@ -22,6 +23,8 @@ led-controller {
 
 		led-1 {
 			label = "blue:heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_BLUE>;
 			pwms = <&pwm 2 2000000 0>;
 			pwm-names = "pwm2";
 			max-brightness = <255>;
-- 
2.34.1

