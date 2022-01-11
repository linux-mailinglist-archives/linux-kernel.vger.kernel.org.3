Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A75848B81A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbiAKUPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:15:36 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37776
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243124AbiAKUPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:15:25 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2C52B3F175
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641932125;
        bh=zzMyOeYd4lATlu6SXmtUhZks+PFFAFcrD95at+LMCx4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lurv6+otXM1GB83kequpHEDpLGWoqQqzefoQaobmeVMwa2aFG30Ww84bNz0osYOaQ
         6xB03kUumyilzMA9k/6n3SwErvBZva8ZmFtvqUG5VyUarjiDOHX4YNUR6bGU6vXgr2
         tcPlcQiBybP6w4y0kbGoGwKXAQ3akqWRNDPAYi/q7YwcjQ7TB6O8pvad4jLsA3N9v6
         fjmk+0npSYJqqEthyUAmthefjcMwRQMLz2Z0IZ5nuPyb3aaDR2+5utRgX5qRQiXu9s
         fYN25ufep+95sFKXgXT4u85eol1O2EoW5tsbrhkwjL6dLyWW10x8kHcZJZT6pL07xQ
         AN5HS+Xr/hBKw==
Received: by mail-ed1-f71.google.com with SMTP id i9-20020a05640242c900b003fe97faab62so187342edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zzMyOeYd4lATlu6SXmtUhZks+PFFAFcrD95at+LMCx4=;
        b=WQE0Ds/YdUns9wPQkznUpKH5bVcAkLOOb2fRVvqSAaHtGLy0a/5JVZ/tVdnOxMamt7
         AZNaiGP3SU5W6zhILHTVfGpcOOi8HUL8Y1k90NoOR3gqyEU0P5YvwnBOJMTGA6hEKRyT
         FHLVAcphRqjnDojR/iB+k/LwO3GYXcAYoADH7CV1vV8GN9LhMMGoE48AXgSDvpkOWJ6h
         0HdhyqisoZKP5/v+X49B6ZPTTZoITzCvM9/aTmTfvBq6dlpT3XXR+GFOo2iKvdNibQXD
         7EUDfxowgriVYg9NVQYTBfhiJI2t3H0pHyqeSZdkOC5ODHm0kAADdfSDyJU//eMcxdxe
         5EIQ==
X-Gm-Message-State: AOAM532FxEJ6VzAZ/beE7/P12g1NpfOJJK1y2huVMeO0a6W6MVe4wYUl
        MYRdO7HPzCskPjThwycW32MFEL4n/9lRVYhErponE2ucr6Q59y8tfWHTmXi8RIi/d0QMjDRSeMB
        cIMM2yj14Q9YDcjW0/TpVzKG2qqOi3UItNJylMAxEOQ==
X-Received: by 2002:a17:907:6ea8:: with SMTP id sh40mr4902262ejc.585.1641932124327;
        Tue, 11 Jan 2022 12:15:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqjRnzF/+d9jHmNpWhm2DKKgT/66sOUCKGXI9iCOvSb9auVL55voSk4GBjC8XgmId7y2NOUg==
X-Received: by 2002:a17:907:6ea8:: with SMTP id sh40mr4902244ejc.585.1641932124123;
        Tue, 11 Jan 2022 12:15:24 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f23sm3852212ejj.128.2022.01.11.12.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:15:23 -0800 (PST)
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
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>
Subject: [PATCH v2 06/28] ARM: dts: exynos: simplify PMIC DVS pin configuration in Peach Pit
Date:   Tue, 11 Jan 2022 21:14:04 +0100
Message-Id: <20220111201426.326777-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pin configuration for PMIC DVS (pmic-dvs-2 and pmic-dvs-3) are
exactly the same, so merge them.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 1ae5528e9ebf..e8819659081a 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -212,7 +212,7 @@ max77802: pmic@9 {
 		interrupts = <1 IRQ_TYPE_NONE>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max77802_irq>, <&pmic_selb>,
-			    <&pmic_dvs_1>, <&pmic_dvs_2>, <&pmic_dvs_3>;
+			    <&pmic_dvs_1>, <&pmic_dvs_2>;
 		wakeup-source;
 		reg = <0x9>;
 		#clock-cells = <1>;
@@ -892,14 +892,7 @@ &sd1_cmd {
 
 &pinctrl_2 {
 	pmic_dvs_2: pmic-dvs-2 {
-		samsung,pins = "gpj4-2";
-		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
-		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
-	};
-
-	pmic_dvs_3: pmic-dvs-3 {
-		samsung,pins = "gpj4-3";
+		samsung,pins = "gpj4-2", "gpj4-3";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
-- 
2.32.0

