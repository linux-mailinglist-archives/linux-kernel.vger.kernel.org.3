Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16FA552365
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243226AbiFTR7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242513AbiFTR5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:57:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B91E1EEDD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:57:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eo8so16234204edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dPjc9m9jjOSDqacncQHGMk6hFz5gDzF+xAgCPwYpZfo=;
        b=O0eVkmFKWn0CEFQyhwJfh6gSkxLut+snaPIhrX88n4irfnWjH209+LLoE/dJpMjx3d
         xG9Up6PF+INz94I0O7TqkbGUzR2JwxJoAusNtIKzN6gYb8u5kPeVZRJyGX/mKToUgXrP
         NNQDDA9sILZcM3mdEcSB+djhLidp0iyhgrPahf0ID2igZ8LuJqORtUBn31oZOeRZm5L4
         X66P3jlGqoQdDmprWtMpg5nSqqJFrW2x+wr2EZH2HGk5804jFqESYVzrBiWeScCJq316
         /Ljfahxr4lbxFHdDG2IFzKRmAr04ZstfYP3R5dXm4+NUnwXYStqI+0rNgDuXw+C7ryVS
         OB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dPjc9m9jjOSDqacncQHGMk6hFz5gDzF+xAgCPwYpZfo=;
        b=f+XJkS9WqAjGFoIHN2wkmLmoFwZFQN3WqC50dVkFpvXYgP79Frb7PmVZUElAH7/SiQ
         iWk0QCXl5ixNIkZx4cCYcrCIW2z5mwd8GFMTJu2xAuX7KqbBVJGpfvDPevhkzcPcAitk
         eiDMxNR+A6VnI3bppuATGHQ9PVDCpJeUuzyoWmb/dgQSq9rhIlwRaSA0pjJsE+sL26St
         cF6L7KTAFZoQCneWj+hG3KJ/zDOCQ9r7+vkApbwLRSZG1i/czb18S9hPe3BvsVyWGNwk
         buhOjRAqGH1OV3Kfi2qKVCDKTWwiqC3wTitv/3s+USAnpvr9Wky0iqfC1a8RDy3nFqbn
         vzXA==
X-Gm-Message-State: AJIora8pW8xLZvCzQQFzkRBlj3pJR07p4wzY7PYv4r5QmZXQvHWh3L0a
        WiiEqwwGKpg60zyZpDvySKI2lw==
X-Google-Smtp-Source: AGRyM1uRIbcBM9VViZJowdqff2MvNDYIlrVp69Pj5JNKPD7u5fAAfv0cs6xkqSAbbBaqHkHsA6zBpA==
X-Received: by 2002:a05:6402:3329:b0:435:8136:cb70 with SMTP id e41-20020a056402332900b004358136cb70mr7037286eda.106.1655747857948;
        Mon, 20 Jun 2022 10:57:37 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g13-20020aa7c84d000000b004357b717a96sm4309925edt.85.2022.06.20.10.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:57:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 7/8] ARM: dts: exynos: add function and color to LED node in Odroid XU4
Date:   Mon, 20 Jun 2022 19:57:15 +0200
Message-Id: <20220620175716.132143-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220620175716.132143-1-krzysztof.kozlowski@linaro.org>
References: <20220620175716.132143-1-krzysztof.kozlowski@linaro.org>
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
Exynos5422 Odroid XU4, so we can drop deprecated label property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos5422-odroidxu4.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 1c24f9b35973..f5fb617f46bd 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -9,6 +9,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5422-odroidxu3-common.dtsi"
 
@@ -21,7 +22,8 @@ led-controller {
 		compatible = "pwm-leds";
 
 		led-1 {
-			label = "blue:heartbeat";
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_BLUE>;
 			pwms = <&pwm 2 2000000 0>;
 			pwm-names = "pwm2";
 			max-brightness = <255>;
-- 
2.34.1

