Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170E94824D9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhLaQU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:20:26 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46598
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231300AbhLaQUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:20:20 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B15F93F1A2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640967619;
        bh=Yb4exiilZ6fWGtkNHAgUE2yCKFhigxo195C0Xf7w5qk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EsEsdClxDPtitnqBY3F7O92T97gKlPg9G5b2864EZ6/Y3s3I+DKL4wziXKjyNLzV9
         vRWKLZGmnFo/eH3nZjr67EB15O8FqgMiTnrcq2hO0guE8CPhLFqqGbByeJp+sB7+6W
         b6zzHvskGhKGovMeuDXuudUbLcF2Lk8kc+rOdTGY0NWl8KsR0U0kKys5DniLaERMTE
         oLNxmA+0G2h1lZStp+AVY42MKB7qmxtBJQi6TGNC4iaCK0jRNY6H4GAzj1RGaEPhW1
         idlwrRH+SRJOXWX/HowlmuZryWwm0hv6VwGtLocS4R+Jw4QirTsjyiA5IImuabCJBA
         +NlyxRplheCvg==
Received: by mail-lj1-f199.google.com with SMTP id l6-20020a2e8686000000b0022d9a4d18d5so8445267lji.19
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yb4exiilZ6fWGtkNHAgUE2yCKFhigxo195C0Xf7w5qk=;
        b=W5EmA+EwRAF1GgB1ix6aAVIQrMbV62o9rwb9kQgud7RcgWA4EO/XUOkH1jJzSogTen
         xyWeOYsb2tZC8Z0aWYzguu13oNg38vyQjKElohMaDS57MFvpPPfMI7dAW1R7HV5XvFaZ
         ZfAfoFATZ2VFrTffzI+ueLGbS2zw4YsgcGGKH3uCqWpNSE4R0rRvucGPO8Mzywbi8vBH
         qUBKDMMTq9/wXOQItfxIGiFAX+McnUe88aotCJw0Gu274YEaBLineA+xSZ2CokFwtUHl
         FJeGikz2Ts3n8C62v6D1e3q+gZnNR+Dxh1s3d+UBUgIfmRt7GnDJFfIX9lLxEADRumy0
         3nIw==
X-Gm-Message-State: AOAM533b0gUtm4HnZ09VxZqAo46ujPHRgamMb3G8rhP0v3xqHHNf5IbQ
        BC5CMMcgjxu8rTKYm6/qL7Zy0PbiIiINAlsqMGWghBlipZPuRwYWT/M3FqsAhzzvUk0GWvGe2Zo
        ZDY7r/OpneA6rAQim0P5u9IERSIk4MDruDHthaFWuWA==
X-Received: by 2002:a19:501a:: with SMTP id e26mr9203886lfb.15.1640967618988;
        Fri, 31 Dec 2021 08:20:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNK4ScMYqUV+4nUybzcAVSBTksErcc62T2piTtEwBST7YOjkfvU2IG+Tb5jsClafIDsjA4mg==
X-Received: by 2002:a19:501a:: with SMTP id e26mr9203878lfb.15.1640967618848;
        Fri, 31 Dec 2021 08:20:18 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bx10sm2817607ljb.3.2021.12.31.08.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:20:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 04/24] ARM: dts: exynos: simplify PMIC DVS pin configuration in Odroid XU
Date:   Fri, 31 Dec 2021 17:19:10 +0100
Message-Id: <20211231161930.256733-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com>
References: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin configuration for PMIC DVS (pmic-dvs-2 and pmic-dvs-3) are
exactly the same, so merge them.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 884fef55836c..9f2200dd5b43 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -188,8 +188,7 @@ max77802: pmic@9 {
 		interrupt-parent = <&gpx0>;
 		interrupts = <4 IRQ_TYPE_NONE>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&max77802_irq>, <&pmic_dvs_1>, <&pmic_dvs_2>,
-			    <&pmic_dvs_3>;
+		pinctrl-0 = <&max77802_irq>, <&pmic_dvs_1>, <&pmic_dvs_2>;
 		wakeup-source;
 		#clock-cells = <1>;
 
@@ -563,15 +562,8 @@ sd2_wp: sd2-wp {
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV4>;
 	};
 
-	pmic_dvs_3: pmic-dvs-3 {
-		samsung,pins = "gpx0-0";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
-	};
-
 	pmic_dvs_2: pmic-dvs-2 {
-		samsung,pins = "gpx0-1";
+		samsung,pins = "gpx0-0", "gpx0-1";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
-- 
2.32.0

