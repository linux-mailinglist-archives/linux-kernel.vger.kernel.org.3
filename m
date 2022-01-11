Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353FC48B831
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243349AbiAKUSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:18:07 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59956
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242763AbiAKUSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:18:02 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D3F9E40703
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641932281;
        bh=PGhCGHIzXCQK8AryrRyQ6DVaFN8DyDgbyb7ebCRERqc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UL+LsHFKIhqPZIRPda3En1SS7vp2RxghH0TO3QNU2laLLF/m8Lt87Hn+vfleccKmH
         if6pre7GoiDrlYQ4LzbvnmUlnFQrFYztIuxZRmnjalNbqpGbLSF2L3+8juy/Sz3/kh
         8dOJWayjg8CDhX20yN5dDbGOACbErURybtzzrN3QixbmUmT51QVAtGL12NPbUxArP8
         CTdyVeYkbBXTd9yxfT2+oN426pdww1OlQ4PjcdBfW6RAFtj1x0/NClhFwm7j3AXGN9
         zObojllKkX1al6PCrNzgbEKokrMMFAQmUOIsLdAMZb8YK/au+gchVoEwxpieNBQes3
         4VuOSMW4hCteQ==
Received: by mail-ed1-f69.google.com with SMTP id m16-20020a056402431000b003fb60bbe0e2so215145edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGhCGHIzXCQK8AryrRyQ6DVaFN8DyDgbyb7ebCRERqc=;
        b=7uP42NiMMsMWWvlX74kq2dk68nwFD2pGy9mYM5HP/YMBrpotn4mWP2roPEq+/bvwN4
         QvNi1wqnvGn5jJfUjAn9/sxUirWiqPzkAJxNwPGQLvtjmgZ+VXHs9Kp2elD8CpVwJt3X
         0vQRhyLr40WE/RtVoZFGg+S8B5CDKvqPXggSCrLqXsPlBJRp4J6mu0QhmWDjNo82yBJ1
         h6aBCrqJzIb0AMwXtLXO2ylm2L+NjUqEGWSaWf3LY1Y9tGhJU/dsT5FAeTA7XDw+RPD9
         o954eLlbjkMRWqMLOmSqYt4QdsuPf05l4/q9UEjqHBQa9jkscml/1l1k1GSKSuANfWoo
         V7jw==
X-Gm-Message-State: AOAM5316eyyuZ2nOSRFRNI6wvShzrvZyjFQ1ppf8nsc6WhlFoQ4fGISN
        x5DOqwG4mNZtiYkRmwvpqCJqGndmUpmO5OtAZreQWTL3CDuHQA5NFGqqSR0gKbv6uDqTXWIubHN
        g42i6MNat1W1k3RgTnSkRJE8jzZpS3xoABkm50ji14g==
X-Received: by 2002:a17:907:3d94:: with SMTP id he20mr4852848ejc.339.1641932281209;
        Tue, 11 Jan 2022 12:18:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIdiGqTjRdbhrmv0zfCRs9CSoyD6hQUgu9NLRHIRRugCvqFsamAAB93Nka0c4uArWKniPbzQ==
X-Received: by 2002:a17:907:3d94:: with SMTP id he20mr4852831ejc.339.1641932281047;
        Tue, 11 Jan 2022 12:18:01 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e4sm4030881ejs.13.2022.01.11.12.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:18:00 -0800 (PST)
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
        Alim Akhtar <alim.akhtar@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v2 08/28] ARM: dts: exynos: simplify PMIC DVS pin configuration in Peach Pi
Date:   Tue, 11 Jan 2022 21:17:02 +0100
Message-Id: <20220111201722.327219-2-krzysztof.kozlowski@canonical.com>
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
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/boot/dts/exynos5800-peach-pi.dts | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 01f310f387d6..eca805b83816 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -221,7 +221,7 @@ max77802: pmic@9 {
 		interrupts = <1 IRQ_TYPE_NONE>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&max77802_irq>, <&pmic_selb>,
-			    <&pmic_dvs_1>, <&pmic_dvs_2>, <&pmic_dvs_3>;
+			    <&pmic_dvs_1>, <&pmic_dvs_2>;
 		wakeup-source;
 		reg = <0x9>;
 		#clock-cells = <1>;
@@ -874,14 +874,7 @@ &sd1_cmd {
 
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

