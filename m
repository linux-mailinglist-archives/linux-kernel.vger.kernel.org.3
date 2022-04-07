Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2554F7768
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241726AbiDGHZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiDGHZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:25:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD792611
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:23:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bg10so8979362ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 00:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQl94m0PqCXD+LGa2eBxh9FZsiEePYOtGmPb20IDP/E=;
        b=TppdCLWcbLDy2dzem71sJHOjGFmnTO1FY3CaMlApQ4NWmxBrt8yvZ+KAtA8vOI15QJ
         WYCmnd7KOTfVQ46APpH3zWrTGtlErEsbMPQFWfUTF61iSPDEufFKuLzjHQmAk+dNXfS9
         kz+xTitG0ok0Kux/HDva6OhHqGtgTeupwofSTyjwg/yKWJkE9JWhf71mnOFTtQKA533y
         ABVwMRvcMikHPjHJM8Bz4o93byNwSK6o5QJnb35XX47ndAJPaBwQyJqm18s2xzn9/fIy
         GxGPrgTWjK87S65gy/nFnacgEBuAigEHvjpZTQZ487ysl/UK8lYWoFMTYM5z9wbD/klI
         ktaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQl94m0PqCXD+LGa2eBxh9FZsiEePYOtGmPb20IDP/E=;
        b=GRisnxil4C47TIgaX3gwBbYkFo5qa2kODJ72mZQhEpPZT2OUpB9Un0PlBX2/OdySVy
         j9B2F8up/EkCSBkWwlb9KqLN14EUxjst9eTRR+c5rNZ7xGP6E//3mrMUJ3A2n51fV+vB
         MVbO6yw4GA5uIliIhr+Irh9DSTP2cupb8GPEOjBb2BEd2BhkIKrhW/qlus+Q8stB8u2C
         kCTMEoc7R7JjIOHfSidKc7xeGp3d8luQg8ZOz5NivbJ5nyb2eoRUZUhizNjcGW7XGcEO
         ESTb9l2KXtGfQOc0qkLJcGnnxhajW5a1lUL7pz8QAPdhhFaXAczTJAoqGtw8hLZl/Zbz
         EZ5g==
X-Gm-Message-State: AOAM532LZ/7PTxpAH5OuRHJNwVgNTsoYxtq+hdFKVNBwKP+ZNpxOzteL
        l60RGc1LlM9sxlDTdLydmI6aFQ==
X-Google-Smtp-Source: ABdhPJxl/FiKAekAR1Fup1MzAtANE/f1/F4P25++0drHeIV6KPzAlPY9tNWEMSijk85EnkvdEamntg==
X-Received: by 2002:a17:907:3d94:b0:6df:8791:135f with SMTP id he20-20020a1709073d9400b006df8791135fmr11739008ejc.205.1649316202038;
        Thu, 07 Apr 2022 00:23:22 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id et21-20020a170907295500b006e7f1abe2ccsm4187329ejc.75.2022.04.07.00.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 00:23:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH v2] ARM: s3c: mark as deprecated and schedule removal
Date:   Thu,  7 Apr 2022 09:23:19 +0200
Message-Id: <20220407072319.75614-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung S3C24xx and S3C64xx platforms are very old designs. S3C2416
was introduced in 2008 and S3C6410 in 2009/2010.  They are not widely
available anymore - out-of-stock on FriendlyArm (one of manufacturers of
boards) and only few specialist stores still offer them for quite a high
price.

The community around these platforms was not very active, so I suspect
no one really uses them anymore. Maintenance takes precious time so
there is little sense in keeping them alive if there are no real users.

Let's mark all S3C24xx and S3C64xx platforms as deprecated and mention
possible removal in after 2022 for the first and 2024 for the lattere.
The deprecation message will be as text in Kconfig, build message (not a
warning though) and runtime print error.

If there are any users, they might respond and postpone the removal.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

---

Changes since v1:
1. Language: in->for removal.
2. Don't show pragma with COMPILE_TEST.
3. Add Acks.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/Kconfig                  | 7 ++++++-
 arch/arm/mach-s3c/Kconfig.s3c64xx | 7 ++++++-
 arch/arm/mach-s3c/cpu.c           | 1 +
 arch/arm/mach-s3c/init.c          | 2 ++
 arch/arm/mach-s3c/s3c24xx.c       | 7 +++++++
 arch/arm/mach-s3c/s3c64xx.c       | 7 +++++++
 6 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4814e098f320..22baf93d8be9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -468,7 +468,7 @@ config ARCH_SA1100
 	  Support for StrongARM 11x0 based boards.
 
 config ARCH_S3C24XX
-	bool "Samsung S3C24XX SoCs"
+	bool "Samsung S3C24XX SoCs (deprecated, see help)"
 	select ATAGS
 	select CLKSRC_SAMSUNG_PWM
 	select GPIO_SAMSUNG
@@ -485,6 +485,11 @@ config ARCH_S3C24XX
 	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
 	  Samsung SMDK2410 development board (and derivatives).
 
+	  The platform is deprecated and scheduled for removal. Please reach to
+	  the maintainers of the platform and linux-samsung-soc@vger.kernel.org if
+	  you still use it.
+	  Without such feedback, the platform will be removed after 2022.
+
 config ARCH_OMAP1
 	bool "TI OMAP1"
 	select ARCH_OMAP
diff --git a/arch/arm/mach-s3c/Kconfig.s3c64xx b/arch/arm/mach-s3c/Kconfig.s3c64xx
index af01675d8769..2b27bff4d928 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c64xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
@@ -4,7 +4,7 @@
 #	Simtec Electronics, Ben Dooks <ben@simtec.co.uk>
 
 menuconfig ARCH_S3C64XX
-	bool "Samsung S3C64XX"
+	bool "Samsung S3C64XX (deprecated, see help)"
 	depends on ARCH_MULTI_V6
 	select ARM_AMBA
 	select ARM_VIC
@@ -24,6 +24,11 @@ menuconfig ARCH_S3C64XX
 	help
 	  Samsung S3C64XX series based systems
 
+	  The platform is deprecated and scheduled for removal. Please reach to
+	  the maintainers of the platform and linux-samsung-soc@vger.kernel.org if
+	  you still use it.
+	  Without such feedback, the platform will be removed after 2024.
+
 if ARCH_S3C64XX
 
 # Configuration options for the S3C6410 CPU
diff --git a/arch/arm/mach-s3c/cpu.c b/arch/arm/mach-s3c/cpu.c
index 6e9772555f0d..0df428f01855 100644
--- a/arch/arm/mach-s3c/cpu.c
+++ b/arch/arm/mach-s3c/cpu.c
@@ -28,4 +28,5 @@ void __init s3c64xx_init_cpu(void)
 	}
 
 	pr_info("Samsung CPU ID: 0x%08lx\n", samsung_cpu_id);
+	pr_err("The platform is deprecated and scheduled for removal. Please reach to the maintainers of the platform and linux-samsung-soc@vger.kernel.org if you still use it.  Without such feedback, the platform will be removed after 2022.\n");
 }
diff --git a/arch/arm/mach-s3c/init.c b/arch/arm/mach-s3c/init.c
index 9d92f03e9bc1..bf513616f55d 100644
--- a/arch/arm/mach-s3c/init.c
+++ b/arch/arm/mach-s3c/init.c
@@ -59,6 +59,8 @@ void __init s3c_init_cpu(unsigned long idcode,
 
 	if (cpu->map_io)
 		cpu->map_io();
+
+	pr_err("The platform is deprecated and scheduled for removal. Please reach to the maintainers of the platform and linux-samsung-soc@vger.kernel.org if you still use it.  Without such feedback, the platform will be removed after 2022.\n");
 }
 
 /* s3c24xx_init_clocks
diff --git a/arch/arm/mach-s3c/s3c24xx.c b/arch/arm/mach-s3c/s3c24xx.c
index 37eaf9480da7..819a95364af9 100644
--- a/arch/arm/mach-s3c/s3c24xx.c
+++ b/arch/arm/mach-s3c/s3c24xx.c
@@ -678,3 +678,10 @@ struct platform_device s3c2410_device_dclk = {
 	},
 };
 #endif
+
+#ifndef CONFIG_COMPILE_TEST
+#pragma message "The platform is deprecated and scheduled for removal. " \
+		"Please reach to the maintainers of the platform " \
+		"and linux-samsung-soc@vger.kernel.org if you still use it." \
+		"Without such feedback, the platform will be removed after 2022."
+#endif
diff --git a/arch/arm/mach-s3c/s3c64xx.c b/arch/arm/mach-s3c/s3c64xx.c
index 4dfb648142f2..178085df6d9d 100644
--- a/arch/arm/mach-s3c/s3c64xx.c
+++ b/arch/arm/mach-s3c/s3c64xx.c
@@ -425,3 +425,10 @@ static int __init s3c64xx_init_irq_eint(void)
 	return 0;
 }
 arch_initcall(s3c64xx_init_irq_eint);
+
+#ifndef CONFIG_COMPILE_TEST
+#pragma message "The platform is deprecated and scheduled for removal. " \
+		"Please reach to the maintainers of the platform " \
+		"and linux-samsung-soc@vger.kernel.org if you still use it." \
+		"Without such feedback, the platform will be removed after 2024."
+#endif
-- 
2.32.0

