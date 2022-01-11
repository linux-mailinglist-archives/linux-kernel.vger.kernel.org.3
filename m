Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5001548B81D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbiAKUPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:15:42 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37776
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242906AbiAKUPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:15:23 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8BCAC3F207
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641932122;
        bh=Yb4exiilZ6fWGtkNHAgUE2yCKFhigxo195C0Xf7w5qk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lA65r8lZygBC2ZZ17Ms2WsbS/E4mZsTi8eogQdJJzbalN27YSgH870bF/OStFruk5
         CuEUTvP43K+JCi0qG03fYijb39dbBgOx3Y4ritl9CESr44cp+GJK8wKQtCyDVZrXwi
         i6bZ9HCHWD/xxEBKayhRaWo8H1EvucRY/UJp4XHOV0NSS1GOLcpJwuLdd9GQDeh4e9
         PxXPmXtZa3OnSre1hpA3nyuyNpGfS2LOe+jul5yUf3L2CdaS+FIxIoDyRBPsbMQJrP
         Uej8ZLmfH2yJiuA3XA1zRXSZK9vZBAF0KCiwOF9/EKgGivFEntLWUjoAQdRjv4+PEZ
         w9pyJkuc4xfMg==
Received: by mail-ed1-f71.google.com with SMTP id g11-20020a056402090b00b003f8fd1ac475so215132edz.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:15:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yb4exiilZ6fWGtkNHAgUE2yCKFhigxo195C0Xf7w5qk=;
        b=AFR/L9uV20Z6I9b+B7Ikwym5WuQdmb6I9+L7PGy76UvccIOa2qa6R5ZyI298Jr1r6l
         9M3oaU53MPgs/F/RrDso2QJ6/mN6o+81j0XXVVP20EOJIFgAZ8syPSIyjWaZc2/F6KTQ
         hggGMBu441ltFEVlnJtVL5xy0zXdnzE88F9uwCPi0hzf1tJ+4rQK2nDjzJD4oU0ROgzY
         RM2mo+2bQjtmxbBMXU60RuJSvrMJIWVgtRTho4owpAQoKcpCGM17FjxVDOOMs/MVYoVH
         4AGRYpIxLy+LeRxymZqbOUNVKkaVDQAvM3pJRTezUXXLU6Wp5aRQ17KeghWRenwpaAnd
         ksMg==
X-Gm-Message-State: AOAM531dA4eZO1kLCTFyuteJh5FSCSxm/HS63SQeQgVXRzuVmgfj9I9E
        SEuPM6tvPpVsgkLUdLppPyKaK8ZknRoRx1bbpBiD22QmE8UkNnjWHA52UGX4omlwYa6Pk0Eom2W
        pG4FpQJ837yC0djjUyUKdnbO1gfS1wwdieyA1mZ4UTA==
X-Received: by 2002:a05:6402:4249:: with SMTP id g9mr3571715edb.321.1641932121426;
        Tue, 11 Jan 2022 12:15:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKM89NfIORT3ha11SDkyVnHYgokbq+oykjhh4MT8WCGODxHOOwQN7VsX2r9dpD4YcqNBYMyw==
X-Received: by 2002:a05:6402:4249:: with SMTP id g9mr3571696edb.321.1641932121287;
        Tue, 11 Jan 2022 12:15:21 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id f23sm3852212ejj.128.2022.01.11.12.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:15:20 -0800 (PST)
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
Subject: [PATCH v2 04/28] ARM: dts: exynos: simplify PMIC DVS pin configuration in Odroid XU
Date:   Tue, 11 Jan 2022 21:14:02 +0100
Message-Id: <20220111201426.326777-5-krzysztof.kozlowski@canonical.com>
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

