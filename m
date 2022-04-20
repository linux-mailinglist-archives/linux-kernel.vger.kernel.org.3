Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE74508784
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359232AbiDTL6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378329AbiDTL60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:58:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5624255AA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:55:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k23so3047216ejd.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVwfxB+S10NbMeBL/IVRmNjz0+au+R9AfQPh7yTQU2M=;
        b=Hy4e2R1MqaxG0+HJrALF0kJPmQKEl0it1cmTA7Lt4LFfkDEBpu5uPDTlE6FbZWanwd
         jMmOezpcwT3tYUTi+LtXlJDWjeqXLIACyXsG500dStVZVVil2k0XWtOWX0aYdRp8POdy
         9hCEicGHtlZ708Cm2NawGh+I0PlP/bEuY4l/jeKzVgByr0Wj77M41NDYgQ3yVTqcHn1I
         l2kJVBk6AXdJ1dBMWF0S37WmEB9vO3eb/3/tFqy/cBY2g1qNUfvJlWPRIR3y3/+hzCOB
         /kJdXd2fKZp+NSYiYXjompqW8Q3zGN3MZIXptFc1pzJFGPVyQKUwqqHnyl5UVcRgHyLj
         uTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YVwfxB+S10NbMeBL/IVRmNjz0+au+R9AfQPh7yTQU2M=;
        b=HdQrfyzViOUpg5YGAZdqrOe+wg0LwejafCqorKmFtnW62NXkLDA13IAGsK1VVKGAOR
         HrhDcOSczK3XfkUi8os+yA8i30J2uUBT74iZzzlEW8oZuJD9lj5HQSJBfGuaUL5+jve6
         Zop6ykvMNqfnwcwtpsG5fiZ2WaHw5eQLbd09Cl0QKV0/2qN5uo0spzC3L1yLVOUQTK/L
         F6IXM1sCs8OXcttOWv5QV7NruadI7cna3EhzPgTVNDM7aVmwphCnl305mzHXKwD7WSQp
         8lNjbAQohtgBiO8Y0JElsefyhFYnWu75FMa47I/zd1xygibOV9aY9Cz00jB6ZPRM1vyP
         wGyQ==
X-Gm-Message-State: AOAM530MgnFuTELzzWogzBx+gQwEWOCGwZv0zAZKN5VG7WNQ+uIoasCe
        nysPL1+vkKTRzidCfkacOsiopSSrdc2cvg==
X-Google-Smtp-Source: ABdhPJweVW9m8Tqhut2hPK+/gSSy9+HWwHoZMyTFlDaj64XkY1e2ZQLc+22FCpzRkgrP506msSGYmg==
X-Received: by 2002:a17:906:954b:b0:6e8:cb85:60a2 with SMTP id g11-20020a170906954b00b006e8cb8560a2mr18089117ejy.382.1650455722616;
        Wed, 20 Apr 2022 04:55:22 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t20-20020a50d714000000b004241f9debcdsm686041edi.21.2022.04.20.04.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:55:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] pinctrl: samsung: fix missing GPIOLIB on ARM64 Exynos config
Date:   Wed, 20 Apr 2022 13:55:12 +0200
Message-Id: <20220420115512.175917-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung pinctrl drivers depend on OF_GPIO, which is part of GPIOLIB.
ARMv7 Exynos platform selects GPIOLIB and Samsung pinctrl drivers. ARMv8
Exynos selects only the latter leading to possible wrong configuration
on ARMv8 build:

  WARNING: unmet direct dependencies detected for PINCTRL_EXYNOS
    Depends on [n]: PINCTRL [=y] && OF_GPIO [=n] && (ARCH_EXYNOS [=y] || ARCH_S5PV210 || COMPILE_TEST [=y])
    Selected by [y]:
    - ARCH_EXYNOS [=y]

Reported-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
Fixes: eed6b3eb20b9 ("arm64: Split out platform options to separate Kconfig")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Original report:
https://bugzilla.kernel.org/show_bug.cgi?id=210047
---
 arch/arm/mach-exynos/Kconfig    | 1 -
 drivers/pinctrl/samsung/Kconfig | 6 ++----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 51a336f349f4..4d3b40e4049a 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -16,7 +16,6 @@ menuconfig ARCH_EXYNOS
 	select EXYNOS_PMU
 	select EXYNOS_SROM
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
-	select GPIOLIB
 	select HAVE_ARM_ARCH_TIMER if ARCH_EXYNOS5
 	select HAVE_ARM_SCU if SMP
 	select PINCTRL
diff --git a/drivers/pinctrl/samsung/Kconfig b/drivers/pinctrl/samsung/Kconfig
index dfd805e76862..c852fd1dd284 100644
--- a/drivers/pinctrl/samsung/Kconfig
+++ b/drivers/pinctrl/samsung/Kconfig
@@ -4,13 +4,13 @@
 #
 config PINCTRL_SAMSUNG
 	bool
-	depends on OF_GPIO
+	select GPIOLIB
+	select OF_GPIO
 	select PINMUX
 	select PINCONF
 
 config PINCTRL_EXYNOS
 	bool "Pinctrl common driver part for Samsung Exynos SoCs"
-	depends on OF_GPIO
 	depends on ARCH_EXYNOS || ARCH_S5PV210 || COMPILE_TEST
 	select PINCTRL_SAMSUNG
 	select PINCTRL_EXYNOS_ARM if ARM && (ARCH_EXYNOS || ARCH_S5PV210)
@@ -26,12 +26,10 @@ config PINCTRL_EXYNOS_ARM64
 
 config PINCTRL_S3C24XX
 	bool "Samsung S3C24XX SoC pinctrl driver"
-	depends on OF_GPIO
 	depends on ARCH_S3C24XX || COMPILE_TEST
 	select PINCTRL_SAMSUNG
 
 config PINCTRL_S3C64XX
 	bool "Samsung S3C64XX SoC pinctrl driver"
-	depends on OF_GPIO
 	depends on ARCH_S3C64XX || COMPILE_TEST
 	select PINCTRL_SAMSUNG
-- 
2.32.0

