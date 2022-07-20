Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C13857B2F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240459AbiGTIaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240466AbiGTIaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:30:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6D255AA;
        Wed, 20 Jul 2022 01:30:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bk26so25049525wrb.11;
        Wed, 20 Jul 2022 01:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=uKG/UctqGb2V52Df+n3QlVuOQMNoPoMOajDotCE3VRE=;
        b=W99qqI4pdzYZCWt86trdweIozTOMKVgbT/rfgjPRKnXnW6lsbQQRDhcCVX79zdtrWP
         3IT4yhCGrN4JK5Jqby7qyxkJO+n3f/T2POJPHmUBQQ9IE78cv3spmewFz6ZHMTt02xT2
         UGQM6RPgLi82gMjH2ACe9o76M3rY9Pa0vUyCxra7kk2DlWXoNb2aZkSIrnAiUma+PuVT
         VYqdPJkVUnqVGppI3rgRoVlMr72lLROo/ngq9Suv3zPHuUsxRfXsXo58LPcxY6cSxcGc
         v2tUzVWgVGCA8zkSuClbhDhqolMfhNpofWFwXE99ldqJytCK53FF+p+WxXBJXUYRajJx
         Pk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uKG/UctqGb2V52Df+n3QlVuOQMNoPoMOajDotCE3VRE=;
        b=SmXLkC/rYG2fhCL/sWFAgi+pGtOGrxzEX5AwFM7AU435ZJi5+WyTlJm7OU7wIv+oiR
         dnpMg0RdGAq7N2QOtMlGQF1bdvBE9zkb8Q54vAca4P5Y2vYXT26fKWXHQbZG04DqUL9O
         YvoLorFkYCutGjs/2n2Rzqq8LDL/dvvGNT6oQTamhwU0aQEfuUJmbnUxAC6CYFvmDWNt
         fFDvsMbwml9EASP9oIF6g6FSTTvynZXrz24m/vn+lojT3yl7Z01HCI1a4FlB78b6WYtF
         yK8dal/PUOzTC1OiHcaP/NcfOlxx9z+anY7DxzQUvw4hPIlsqvGTegatO3UgbRP8ZkWG
         lHYA==
X-Gm-Message-State: AJIora8+oXo8NHLWrNQ1hzIpaD9t6D7f75HCRoM07RcqgmvROwnGkT6I
        0bJnOh6/3YIuEiIAIucuSdA=
X-Google-Smtp-Source: AGRyM1tlNI73CEfXgkHrinL57I4wxKWgklxrddU+MhPjj4diceJjuiTd9BPrSV2OtlrXz9IM2LYHhQ==
X-Received: by 2002:a05:6000:18d2:b0:21d:6661:60b5 with SMTP id w18-20020a05600018d200b0021d666160b5mr29708412wrq.475.1658305804491;
        Wed, 20 Jul 2022 01:30:04 -0700 (PDT)
Received: from felia.fritz.box (200116b826a11f008020c2fc6e115b3e.dip.versatel-1u1.de. [2001:16b8:26a1:1f00:8020:c2fc:6e11:5b3e])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c00d000b003a31c4f6f74sm1734547wmm.32.2022.07.20.01.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 01:30:03 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] clk: davinci: remove PLL and PSC clocks for DaVinci DM644x and DM646x
Date:   Wed, 20 Jul 2022 10:29:34 +0200
Message-Id: <20220720082934.17741-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 7dd33764486d ("ARM: davinci: Delete DM644x board files") and commit
b4aed01de486 ("ARM: davinci: Delete DM646x board files") removes the
support for DaVinci DM644x and DM646x boards.

Hence, remove the PLL and PSC clock descriptions for those boards as well.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/clk/davinci/Makefile     |  4 --
 drivers/clk/davinci/pll-dm644x.c | 81 ------------------------------
 drivers/clk/davinci/pll-dm646x.c | 85 --------------------------------
 drivers/clk/davinci/pll.c        |  8 ---
 drivers/clk/davinci/pll.h        |  6 ---
 drivers/clk/davinci/psc-dm644x.c | 85 --------------------------------
 drivers/clk/davinci/psc-dm646x.c | 82 ------------------------------
 drivers/clk/davinci/psc.c        |  6 ---
 drivers/clk/davinci/psc.h        |  6 ---
 include/linux/clk/davinci.h      |  8 ---
 10 files changed, 371 deletions(-)
 delete mode 100644 drivers/clk/davinci/pll-dm644x.c
 delete mode 100644 drivers/clk/davinci/pll-dm646x.c
 delete mode 100644 drivers/clk/davinci/psc-dm644x.c
 delete mode 100644 drivers/clk/davinci/psc-dm646x.c

diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
index 11178b79b483..be6f55d37b49 100644
--- a/drivers/clk/davinci/Makefile
+++ b/drivers/clk/davinci/Makefile
@@ -8,14 +8,10 @@ obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
 obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= pll-dm355.o
 obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= pll-dm365.o
-obj-$(CONFIG_ARCH_DAVINCI_DM644x)	+= pll-dm644x.o
-obj-$(CONFIG_ARCH_DAVINCI_DM646x)	+= pll-dm646x.o
 
 obj-y += psc.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= psc-da830.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= psc-da850.o
 obj-$(CONFIG_ARCH_DAVINCI_DM355)	+= psc-dm355.o
 obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= psc-dm365.o
-obj-$(CONFIG_ARCH_DAVINCI_DM644x)	+= psc-dm644x.o
-obj-$(CONFIG_ARCH_DAVINCI_DM646x)	+= psc-dm646x.o
 endif
diff --git a/drivers/clk/davinci/pll-dm644x.c b/drivers/clk/davinci/pll-dm644x.c
deleted file mode 100644
index 7650fadfaac8..000000000000
--- a/drivers/clk/davinci/pll-dm644x.c
+++ /dev/null
@@ -1,81 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * PLL clock descriptions for TI DM644X
- *
- * Copyright (C) 2018 David Lechner <david@lechnology.com>
- */
-
-#include <linux/bitops.h>
-#include <linux/clk/davinci.h>
-#include <linux/clkdev.h>
-#include <linux/init.h>
-#include <linux/types.h>
-
-#include "pll.h"
-
-static const struct davinci_pll_clk_info dm644x_pll1_info = {
-	.name = "pll1",
-	.pllm_mask = GENMASK(4, 0),
-	.pllm_min = 1,
-	.pllm_max = 32,
-	.pllout_min_rate = 400000000,
-	.pllout_max_rate = 600000000, /* 810MHz @ 1.3V, -810 only */
-	.flags = PLL_HAS_CLKMODE | PLL_HAS_POSTDIV,
-};
-
-SYSCLK(1, pll1_sysclk1, pll1_pllen, 4, SYSCLK_FIXED_DIV);
-SYSCLK(2, pll1_sysclk2, pll1_pllen, 4, SYSCLK_FIXED_DIV);
-SYSCLK(3, pll1_sysclk3, pll1_pllen, 4, SYSCLK_FIXED_DIV);
-SYSCLK(5, pll1_sysclk5, pll1_pllen, 4, SYSCLK_FIXED_DIV);
-
-int dm644x_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
-{
-	struct clk *clk;
-
-	davinci_pll_clk_register(dev, &dm644x_pll1_info, "ref_clk", base, cfgchip);
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk1, base);
-	clk_register_clkdev(clk, "pll1_sysclk1", "dm644x-psc");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk2, base);
-	clk_register_clkdev(clk, "pll1_sysclk2", "dm644x-psc");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk3, base);
-	clk_register_clkdev(clk, "pll1_sysclk3", "dm644x-psc");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk5, base);
-	clk_register_clkdev(clk, "pll1_sysclk5", "dm644x-psc");
-
-	clk = davinci_pll_auxclk_register(dev, "pll1_auxclk", base);
-	clk_register_clkdev(clk, "pll1_auxclk", "dm644x-psc");
-
-	davinci_pll_sysclkbp_clk_register(dev, "pll1_sysclkbp", base);
-
-	return 0;
-}
-
-static const struct davinci_pll_clk_info dm644x_pll2_info = {
-	.name = "pll2",
-	.pllm_mask = GENMASK(4, 0),
-	.pllm_min = 1,
-	.pllm_max = 32,
-	.pllout_min_rate = 400000000,
-	.pllout_max_rate = 900000000,
-	.flags = PLL_HAS_POSTDIV | PLL_POSTDIV_FIXED_DIV,
-};
-
-SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, 0);
-SYSCLK(2, pll2_sysclk2, pll2_pllen, 4, 0);
-
-int dm644x_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
-{
-	davinci_pll_clk_register(dev, &dm644x_pll2_info, "oscin", base, cfgchip);
-
-	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
-
-	davinci_pll_sysclk_register(dev, &pll2_sysclk2, base);
-
-	davinci_pll_sysclkbp_clk_register(dev, "pll2_sysclkbp", base);
-
-	return 0;
-}
diff --git a/drivers/clk/davinci/pll-dm646x.c b/drivers/clk/davinci/pll-dm646x.c
deleted file mode 100644
index 26982970df0e..000000000000
--- a/drivers/clk/davinci/pll-dm646x.c
+++ /dev/null
@@ -1,85 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * PLL clock descriptions for TI DM646X
- *
- * Copyright (C) 2018 David Lechner <david@lechnology.com>
- */
-
-#include <linux/clk-provider.h>
-#include <linux/clk/davinci.h>
-#include <linux/clkdev.h>
-#include <linux/init.h>
-#include <linux/types.h>
-
-#include "pll.h"
-
-static const struct davinci_pll_clk_info dm646x_pll1_info = {
-	.name = "pll1",
-	.pllm_mask = GENMASK(4, 0),
-	.pllm_min = 14,
-	.pllm_max = 32,
-	.flags = PLL_HAS_CLKMODE,
-};
-
-SYSCLK(1, pll1_sysclk1, pll1_pllen, 4, SYSCLK_FIXED_DIV);
-SYSCLK(2, pll1_sysclk2, pll1_pllen, 4, SYSCLK_FIXED_DIV);
-SYSCLK(3, pll1_sysclk3, pll1_pllen, 4, SYSCLK_FIXED_DIV);
-SYSCLK(4, pll1_sysclk4, pll1_pllen, 4, 0);
-SYSCLK(5, pll1_sysclk5, pll1_pllen, 4, 0);
-SYSCLK(6, pll1_sysclk6, pll1_pllen, 4, 0);
-SYSCLK(8, pll1_sysclk8, pll1_pllen, 4, 0);
-SYSCLK(9, pll1_sysclk9, pll1_pllen, 4, 0);
-
-int dm646x_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
-{
-	struct clk *clk;
-
-	davinci_pll_clk_register(dev, &dm646x_pll1_info, "ref_clk", base, cfgchip);
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk1, base);
-	clk_register_clkdev(clk, "pll1_sysclk1", "dm646x-psc");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk2, base);
-	clk_register_clkdev(clk, "pll1_sysclk2", "dm646x-psc");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk3, base);
-	clk_register_clkdev(clk, "pll1_sysclk3", "dm646x-psc");
-	clk_register_clkdev(clk, NULL, "davinci-wdt");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk4, base);
-	clk_register_clkdev(clk, "pll1_sysclk4", "dm646x-psc");
-
-	clk = davinci_pll_sysclk_register(dev, &pll1_sysclk5, base);
-	clk_register_clkdev(clk, "pll1_sysclk5", "dm646x-psc");
-
-	davinci_pll_sysclk_register(dev, &pll1_sysclk6, base);
-
-	davinci_pll_sysclk_register(dev, &pll1_sysclk8, base);
-
-	davinci_pll_sysclk_register(dev, &pll1_sysclk9, base);
-
-	davinci_pll_sysclkbp_clk_register(dev, "pll1_sysclkbp", base);
-
-	davinci_pll_auxclk_register(dev, "pll1_auxclk", base);
-
-	return 0;
-}
-
-static const struct davinci_pll_clk_info dm646x_pll2_info = {
-	.name = "pll2",
-	.pllm_mask = GENMASK(4, 0),
-	.pllm_min = 14,
-	.pllm_max = 32,
-	.flags = 0,
-};
-
-SYSCLK(1, pll2_sysclk1, pll2_pllen, 4, SYSCLK_ALWAYS_ENABLED);
-
-int dm646x_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip)
-{
-	davinci_pll_clk_register(dev, &dm646x_pll2_info, "oscin", base, cfgchip);
-
-	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
-
-	return 0;
-}
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 0d750433eb42..082206676e73 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -889,14 +889,6 @@ static const struct platform_device_id davinci_pll_id_table[] = {
 #ifdef CONFIG_ARCH_DAVINCI_DM365
 	{ .name = "dm365-pll1",  .driver_data = (kernel_ulong_t)dm365_pll1_init  },
 	{ .name = "dm365-pll2",  .driver_data = (kernel_ulong_t)dm365_pll2_init  },
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM644x
-	{ .name = "dm644x-pll1", .driver_data = (kernel_ulong_t)dm644x_pll1_init },
-	{ .name = "dm644x-pll2", .driver_data = (kernel_ulong_t)dm644x_pll2_init },
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM646x
-	{ .name = "dm646x-pll1", .driver_data = (kernel_ulong_t)dm646x_pll1_init },
-	{ .name = "dm646x-pll2", .driver_data = (kernel_ulong_t)dm646x_pll2_init },
 #endif
 	{ }
 };
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index c2a453caa131..1773277bc690 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -130,11 +130,5 @@ int of_da850_pll1_init(struct device *dev, void __iomem *base, struct regmap *cf
 #ifdef CONFIG_ARCH_DAVINCI_DM355
 int dm355_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
 #endif
-#ifdef CONFIG_ARCH_DAVINCI_DM644x
-int dm644x_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM646x
-int dm646x_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
-#endif
 
 #endif /* __CLK_DAVINCI_PLL_H___ */
diff --git a/drivers/clk/davinci/psc-dm644x.c b/drivers/clk/davinci/psc-dm644x.c
deleted file mode 100644
index 0cea6e0bd5f0..000000000000
--- a/drivers/clk/davinci/psc-dm644x.c
+++ /dev/null
@@ -1,85 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * PSC clock descriptions for TI DaVinci DM644x
- *
- * Copyright (C) 2018 David Lechner <david@lechnology.com>
- */
-
-#include <linux/clk-provider.h>
-#include <linux/clk/davinci.h>
-#include <linux/clk.h>
-#include <linux/clkdev.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-#include "psc.h"
-
-LPSC_CLKDEV1(vpss_master_clkdev,	"master",	"vpss");
-LPSC_CLKDEV1(vpss_slave_clkdev,		"slave",	"vpss");
-LPSC_CLKDEV2(emac_clkdev,		NULL,		"davinci_emac.1",
-					"fck",		"davinci_mdio.0");
-LPSC_CLKDEV1(usb_clkdev,		"usb",		NULL);
-LPSC_CLKDEV1(ide_clkdev,		NULL,		"palm_bk3710");
-LPSC_CLKDEV2(aemif_clkdev,		"aemif",	NULL,
-					NULL,		"ti-aemif");
-LPSC_CLKDEV1(mmcsd_clkdev,		NULL,		"dm6441-mmc.0");
-LPSC_CLKDEV1(asp0_clkdev,		NULL,		"davinci-mcbsp");
-LPSC_CLKDEV1(i2c_clkdev,		NULL,		"i2c_davinci.1");
-LPSC_CLKDEV1(uart0_clkdev,		NULL,		"serial8250.0");
-LPSC_CLKDEV1(uart1_clkdev,		NULL,		"serial8250.1");
-LPSC_CLKDEV1(uart2_clkdev,		NULL,		"serial8250.2");
-/* REVISIT: gpio-davinci.c should be modified to drop con_id */
-LPSC_CLKDEV1(gpio_clkdev,		"gpio",		NULL);
-LPSC_CLKDEV1(timer0_clkdev,		"timer0",	NULL);
-LPSC_CLKDEV1(timer2_clkdev,		NULL,		"davinci-wdt");
-
-static const struct davinci_lpsc_clk_info dm644x_psc_info[] = {
-	LPSC(0,  0, vpss_master, pll1_sysclk3, vpss_master_clkdev, 0),
-	LPSC(1,  0, vpss_slave,  pll1_sysclk3, vpss_slave_clkdev,  0),
-	LPSC(6,  0, emac,        pll1_sysclk5, emac_clkdev,        0),
-	LPSC(9,  0, usb,         pll1_sysclk5, usb_clkdev,         0),
-	LPSC(10, 0, ide,         pll1_sysclk5, ide_clkdev,         0),
-	LPSC(11, 0, vlynq,       pll1_sysclk5, NULL,               0),
-	LPSC(14, 0, aemif,       pll1_sysclk5, aemif_clkdev,       0),
-	LPSC(15, 0, mmcsd,       pll1_sysclk5, mmcsd_clkdev,       0),
-	LPSC(17, 0, asp0,        pll1_sysclk5, asp0_clkdev,        0),
-	LPSC(18, 0, i2c,         pll1_auxclk,  i2c_clkdev,         0),
-	LPSC(19, 0, uart0,       pll1_auxclk,  uart0_clkdev,       0),
-	LPSC(20, 0, uart1,       pll1_auxclk,  uart1_clkdev,       0),
-	LPSC(21, 0, uart2,       pll1_auxclk,  uart2_clkdev,       0),
-	LPSC(22, 0, spi,         pll1_sysclk5, NULL,               0),
-	LPSC(23, 0, pwm0,        pll1_auxclk,  NULL,               0),
-	LPSC(24, 0, pwm1,        pll1_auxclk,  NULL,               0),
-	LPSC(25, 0, pwm2,        pll1_auxclk,  NULL,               0),
-	LPSC(26, 0, gpio,        pll1_sysclk5, gpio_clkdev,        0),
-	LPSC(27, 0, timer0,      pll1_auxclk,  timer0_clkdev,      LPSC_ALWAYS_ENABLED),
-	LPSC(28, 0, timer1,      pll1_auxclk,  NULL,               0),
-	/* REVISIT: why can't this be disabled? */
-	LPSC(29, 0, timer2,      pll1_auxclk,  timer2_clkdev,      LPSC_ALWAYS_ENABLED),
-	LPSC(31, 0, arm,         pll1_sysclk2, NULL,               LPSC_ALWAYS_ENABLED),
-	/* REVISIT how to disable? */
-	LPSC(39, 1, dsp,         pll1_sysclk1, NULL,               LPSC_ALWAYS_ENABLED),
-	/* REVISIT how to disable? */
-	LPSC(40, 1, vicp,        pll1_sysclk2, NULL,               LPSC_ALWAYS_ENABLED),
-	{ }
-};
-
-int dm644x_psc_init(struct device *dev, void __iomem *base)
-{
-	return davinci_psc_register_clocks(dev, dm644x_psc_info, 41, base);
-}
-
-static struct clk_bulk_data dm644x_psc_parent_clks[] = {
-	{ .id = "pll1_sysclk1" },
-	{ .id = "pll1_sysclk2" },
-	{ .id = "pll1_sysclk3" },
-	{ .id = "pll1_sysclk5" },
-	{ .id = "pll1_auxclk"  },
-};
-
-const struct davinci_psc_init_data dm644x_psc_init_data = {
-	.parent_clks		= dm644x_psc_parent_clks,
-	.num_parent_clks	= ARRAY_SIZE(dm644x_psc_parent_clks),
-	.psc_init		= &dm644x_psc_init,
-};
diff --git a/drivers/clk/davinci/psc-dm646x.c b/drivers/clk/davinci/psc-dm646x.c
deleted file mode 100644
index 20012dc7471a..000000000000
--- a/drivers/clk/davinci/psc-dm646x.c
+++ /dev/null
@@ -1,82 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * PSC clock descriptions for TI DaVinci DM646x
- *
- * Copyright (C) 2018 David Lechner <david@lechnology.com>
- */
-
-#include <linux/clk-provider.h>
-#include <linux/clk/davinci.h>
-#include <linux/clk.h>
-#include <linux/clkdev.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-#include "psc.h"
-
-LPSC_CLKDEV1(ide_clkdev,	NULL,		"palm_bk3710");
-LPSC_CLKDEV2(emac_clkdev,	NULL,		"davinci_emac.1",
-				"fck",		"davinci_mdio.0");
-LPSC_CLKDEV2(aemif_clkdev,	"aemif",	NULL,
-				NULL,		"ti-aemif");
-LPSC_CLKDEV1(mcasp0_clkdev,	NULL,		"davinci-mcasp.0");
-LPSC_CLKDEV1(mcasp1_clkdev,	NULL,		"davinci-mcasp.1");
-LPSC_CLKDEV1(uart0_clkdev,	NULL,		"serial8250.0");
-LPSC_CLKDEV1(uart1_clkdev,	NULL,		"serial8250.1");
-LPSC_CLKDEV1(uart2_clkdev,	NULL,		"serial8250.2");
-LPSC_CLKDEV1(i2c_clkdev,	NULL,		"i2c_davinci.1");
-/* REVISIT: gpio-davinci.c should be modified to drop con_id */
-LPSC_CLKDEV1(gpio_clkdev,	"gpio",		NULL);
-LPSC_CLKDEV1(timer0_clkdev,	"timer0",	 NULL);
-
-static const struct davinci_lpsc_clk_info dm646x_psc_info[] = {
-	LPSC(0,  0, arm,      pll1_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
-	/* REVISIT how to disable? */
-	LPSC(1,  0, dsp,      pll1_sysclk1, NULL,          LPSC_ALWAYS_ENABLED),
-	LPSC(4,  0, edma_cc,  pll1_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
-	LPSC(5,  0, edma_tc0, pll1_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
-	LPSC(6,  0, edma_tc1, pll1_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
-	LPSC(7,  0, edma_tc2, pll1_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
-	LPSC(8,  0, edma_tc3, pll1_sysclk2, NULL,          LPSC_ALWAYS_ENABLED),
-	LPSC(10, 0, ide,      pll1_sysclk4, ide_clkdev,    0),
-	LPSC(14, 0, emac,     pll1_sysclk3, emac_clkdev,   0),
-	LPSC(16, 0, vpif0,    ref_clk,      NULL,          LPSC_ALWAYS_ENABLED),
-	LPSC(17, 0, vpif1,    ref_clk,      NULL,          LPSC_ALWAYS_ENABLED),
-	LPSC(21, 0, aemif,    pll1_sysclk3, aemif_clkdev,  LPSC_ALWAYS_ENABLED),
-	LPSC(22, 0, mcasp0,   pll1_sysclk3, mcasp0_clkdev, 0),
-	LPSC(23, 0, mcasp1,   pll1_sysclk3, mcasp1_clkdev, 0),
-	LPSC(26, 0, uart0,    aux_clkin,    uart0_clkdev,  0),
-	LPSC(27, 0, uart1,    aux_clkin,    uart1_clkdev,  0),
-	LPSC(28, 0, uart2,    aux_clkin,    uart2_clkdev,  0),
-	/* REVIST: disabling hangs system */
-	LPSC(29, 0, pwm0,     pll1_sysclk3, NULL,          LPSC_ALWAYS_ENABLED),
-	/* REVIST: disabling hangs system */
-	LPSC(30, 0, pwm1,     pll1_sysclk3, NULL,          LPSC_ALWAYS_ENABLED),
-	LPSC(31, 0, i2c,      pll1_sysclk3, i2c_clkdev,    0),
-	LPSC(33, 0, gpio,     pll1_sysclk3, gpio_clkdev,   0),
-	LPSC(34, 0, timer0,   pll1_sysclk3, timer0_clkdev, LPSC_ALWAYS_ENABLED),
-	LPSC(35, 0, timer1,   pll1_sysclk3, NULL,          0),
-	{ }
-};
-
-int dm646x_psc_init(struct device *dev, void __iomem *base)
-{
-	return davinci_psc_register_clocks(dev, dm646x_psc_info, 46, base);
-}
-
-static struct clk_bulk_data dm646x_psc_parent_clks[] = {
-	{ .id = "ref_clk"      },
-	{ .id = "aux_clkin"    },
-	{ .id = "pll1_sysclk1" },
-	{ .id = "pll1_sysclk2" },
-	{ .id = "pll1_sysclk3" },
-	{ .id = "pll1_sysclk4" },
-	{ .id = "pll1_sysclk5" },
-};
-
-const struct davinci_psc_init_data dm646x_psc_init_data = {
-	.parent_clks		= dm646x_psc_parent_clks,
-	.num_parent_clks	= ARRAY_SIZE(dm646x_psc_parent_clks),
-	.psc_init		= &dm646x_psc_init,
-};
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index 7387e7f6276e..42a59dbd49c8 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -516,12 +516,6 @@ static const struct platform_device_id davinci_psc_id_table[] = {
 #endif
 #ifdef CONFIG_ARCH_DAVINCI_DM365
 	{ .name = "dm365-psc",  .driver_data = (kernel_ulong_t)&dm365_psc_init_data  },
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM644x
-	{ .name = "dm644x-psc", .driver_data = (kernel_ulong_t)&dm644x_psc_init_data },
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM646x
-	{ .name = "dm646x-psc", .driver_data = (kernel_ulong_t)&dm646x_psc_init_data },
 #endif
 	{ }
 };
diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
index 69070f834391..5e382b675518 100644
--- a/drivers/clk/davinci/psc.h
+++ b/drivers/clk/davinci/psc.h
@@ -110,11 +110,5 @@ extern const struct davinci_psc_init_data dm355_psc_init_data;
 #ifdef CONFIG_ARCH_DAVINCI_DM365
 extern const struct davinci_psc_init_data dm365_psc_init_data;
 #endif
-#ifdef CONFIG_ARCH_DAVINCI_DM644x
-extern const struct davinci_psc_init_data dm644x_psc_init_data;
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM646x
-extern const struct davinci_psc_init_data dm646x_psc_init_data;
-#endif
 
 #endif /* __CLK_DAVINCI_PSC_H__ */
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
index 8a7b5cd7eac0..f6ebab6228c2 100644
--- a/include/linux/clk/davinci.h
+++ b/include/linux/clk/davinci.h
@@ -28,13 +28,5 @@ int dm365_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgch
 int dm365_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
 int dm365_psc_init(struct device *dev, void __iomem *base);
 #endif
-#ifdef CONFIG_ARCH_DAVINCI_DM644x
-int dm644x_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
-int dm644x_psc_init(struct device *dev, void __iomem *base);
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM646x
-int dm646x_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
-int dm646x_psc_init(struct device *dev, void __iomem *base);
-#endif
 
 #endif /* __LINUX_CLK_DAVINCI_PLL_H___ */
-- 
2.17.1

