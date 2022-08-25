Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2385A179D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiHYRDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiHYRDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:03:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF079B7753;
        Thu, 25 Aug 2022 10:03:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BD61B826BE;
        Thu, 25 Aug 2022 17:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02F2C433D6;
        Thu, 25 Aug 2022 17:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661447027;
        bh=SVgM04PseV435mC0a8STTWiNexw2L/dQTT5kWiUNEvo=;
        h=From:To:Cc:Subject:Date:From;
        b=tnt0MOhLzeuJLEUeNANV/Ib2xTP2E5Q5HKwy8Rs8uF65j+B7a+jUq6nHOUxNkXjm9
         hFezOrMMxH200AnNkqcI9wti4ytfSEaH457GmekbPYEVaD+hbIVLrr/mYB/cldeFMr
         7KOso8fo7UxmaWz6kN0sbbTyRVWZFahQhhF/dEuzP2hVe/cqNa/z7iTF3hcYfSp6Lj
         l3Y/tuSkDlBaXCiIonX4tpmPkdyhoPmaSJKuQwivympyzI15PdwuN6DjojQw+WeRrV
         IoqgYv4w3xmDwQjTlF+5Q1g1jYQUbpO+9CEwJ3YLJeH41xnOvoQevMWdEQubmy9DK/
         8vcJ+YBOrvg0g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Vladimir Zapolskiy <vz@mleia.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [RFC PATCH] usb: reduce kernel log spam on driver registration
Date:   Thu, 25 Aug 2022 19:03:27 +0200
Message-Id: <20220825170327.674446-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13493; i=ardb@kernel.org; h=from:subject; bh=SVgM04PseV435mC0a8STTWiNexw2L/dQTT5kWiUNEvo=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjB6teqp+suHncM8Nc6gfG94bYTOaZ7d/2Ui6Xdtci KqLMgDiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwerXgAKCRDDTyI5ktmPJAUPC/ 97oSVp+bkrQe6AnQqEh8vdWNV5qBbPcNMa3RCM2RqD8t8QMXsGdEckI4KZTgQR2UF2W5Cw5sqGgUQu P21izKnKWuj5TXSQo+CTcXh7iqaQ08ANzoJpFMyTehq8sBSjHUxW/3uL/9ujSBX/DkzM4lpolNaIat 9lQs8mWAyfMBdpFgS9FG0HYFM7MZrY+0zKGn5Ec2EEFGb0Fw6ULYtvDcPkTN1+mh3mjVh66kl0cDjM 8L4pB348A93PIHbYYZ5yOrBOOj3ggElXvBwe70Xrh2yOJc7sSHyQ7aI9BliyiEkGMER8AatjyyGkh5 3sWYLflvnO/3C2nZoiLXY3wUgZXqlfgDF6QHfj04MPkBjNGIaUB+brYBi0ag0co6PAWqA4dm/Yz5Ci cT41XOGnoWAyfm+UGK6tRxqX8IuX4BQNvDm9lpTcT9PH8Vs+ew9NUE5Nic3zVhLwS7mSOa0Lv2SrO5 VZBjQsw7r4EXv09d9Mt1z0hFyqN0eaGt0rbw1t0ZN/LIM=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers are typically supposed to be quiet unless they are actually
probed, but for some reason, USB host controllers seem to be exempt from
this rule, and happily broadcast their existence into the kernel log at
boot even if the hardware in question is nowhere to be found.

Let's fix that, and remove these pr_info() calls.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Avi Fishman <avifishman70@gmail.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: Tali Perry <tali.perry1@gmail.com>
Cc: Patrick Venture <venture@google.com>
Cc: Nancy Yuen <yuenn@google.com>
Cc: Benjamin Fair <benjaminfair@google.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/usb/host/ehci-atmel.c    | 1 -
 drivers/usb/host/ehci-exynos.c   | 1 -
 drivers/usb/host/ehci-fsl.c      | 2 --
 drivers/usb/host/ehci-hcd.c      | 1 -
 drivers/usb/host/ehci-npcm7xx.c  | 2 --
 drivers/usb/host/ehci-omap.c     | 2 --
 drivers/usb/host/ehci-orion.c    | 2 --
 drivers/usb/host/ehci-pci.c      | 2 --
 drivers/usb/host/ehci-platform.c | 2 --
 drivers/usb/host/ehci-spear.c    | 2 --
 drivers/usb/host/ehci-st.c       | 2 --
 drivers/usb/host/fotg210-hcd.c   | 1 -
 drivers/usb/host/ohci-at91.c     | 1 -
 drivers/usb/host/ohci-da8xx.c    | 1 -
 drivers/usb/host/ohci-exynos.c   | 1 -
 drivers/usb/host/ohci-hcd.c      | 1 -
 drivers/usb/host/ohci-nxp.c      | 2 --
 drivers/usb/host/ohci-omap.c     | 2 --
 drivers/usb/host/ohci-pci.c      | 2 --
 drivers/usb/host/ohci-platform.c | 2 --
 drivers/usb/host/ohci-pxa27x.c   | 2 --
 drivers/usb/host/ohci-s3c2410.c  | 1 -
 drivers/usb/host/ohci-spear.c    | 2 --
 drivers/usb/host/ohci-st.c       | 2 --
 24 files changed, 39 deletions(-)

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 05d41fd65f25..0e995019c1df 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -239,7 +239,6 @@ static int __init ehci_atmel_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
 	ehci_init_driver(&ehci_atmel_hc_driver, &ehci_atmel_drv_overrides);
 	return platform_driver_register(&ehci_atmel_driver);
 }
diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 1a9b7572e17f..a65e365e3a04 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -347,7 +347,6 @@ static int __init ehci_exynos_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
 	ehci_init_driver(&exynos_ehci_hc_driver, &exynos_overrides);
 	return platform_driver_register(&exynos_ehci_driver);
 }
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 896c0d107f72..9cea785934e5 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -722,8 +722,6 @@ static int __init ehci_fsl_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info(DRV_NAME ": " DRIVER_DESC "\n");
-
 	ehci_init_driver(&fsl_ehci_hc_driver, &ehci_fsl_overrides);
 
 	fsl_ehci_hc_driver.product_desc =
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 684164fa9716..a1930db0da1c 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1351,7 +1351,6 @@ static int __init ehci_hcd_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	printk(KERN_INFO "%s: " DRIVER_DESC "\n", hcd_name);
 	set_bit(USB_EHCI_LOADED, &usb_hcds_loaded);
 	if (test_bit(USB_UHCI_LOADED, &usb_hcds_loaded) ||
 			test_bit(USB_OHCI_LOADED, &usb_hcds_loaded))
diff --git a/drivers/usb/host/ehci-npcm7xx.c b/drivers/usb/host/ehci-npcm7xx.c
index 6b5a7a873e01..4321ac6b11cc 100644
--- a/drivers/usb/host/ehci-npcm7xx.c
+++ b/drivers/usb/host/ehci-npcm7xx.c
@@ -191,8 +191,6 @@ static int __init ehci_npcm7xx_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ehci_init_driver(&ehci_npcm7xx_hc_driver, NULL);
 	return platform_driver_register(&npcm7xx_ehci_hcd_driver);
 }
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 8c45bc17a580..7dd984722a7f 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -284,8 +284,6 @@ static int __init ehci_omap_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ehci_init_driver(&ehci_omap_hc_driver, &ehci_omap_overrides);
 	return platform_driver_register(&ehci_hcd_omap_driver);
 }
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 3626758b3e2a..2c8b1e6f1fff 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -361,8 +361,6 @@ static int __init ehci_orion_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ehci_init_driver(&ehci_orion_hc_driver, &orion_overrides);
 	return platform_driver_register(&ehci_orion_driver);
 }
diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index 9937c5a7efc2..9581952d999a 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -423,8 +423,6 @@ static int __init ehci_pci_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ehci_init_driver(&ehci_pci_hc_driver, &pci_overrides);
 
 	/* Entries for the PCI suspend/resume callbacks are special */
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 6924f0316e9a..50491eea9409 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -529,8 +529,6 @@ static int __init ehci_platform_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ehci_init_driver(&ehci_platform_hc_driver, &platform_overrides);
 	return platform_driver_register(&ehci_platform_driver);
 }
diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
index 3694e450a11a..13369289d9cc 100644
--- a/drivers/usb/host/ehci-spear.c
+++ b/drivers/usb/host/ehci-spear.c
@@ -167,8 +167,6 @@ static int __init ehci_spear_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ehci_init_driver(&ehci_spear_hc_driver, &spear_overrides);
 	return platform_driver_register(&spear_ehci_hcd_driver);
 }
diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c
index f74433aac948..1086078133f8 100644
--- a/drivers/usb/host/ehci-st.c
+++ b/drivers/usb/host/ehci-st.c
@@ -346,8 +346,6 @@ static int __init ehci_platform_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ehci_init_driver(&ehci_platform_hc_driver, &platform_overrides);
 	return platform_driver_register(&ehci_platform_driver);
 }
diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index f8c111e08a0d..3d1dbcf4c073 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -5692,7 +5692,6 @@ static int __init fotg210_hcd_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
 	set_bit(USB_EHCI_LOADED, &usb_hcds_loaded);
 	if (test_bit(USB_UHCI_LOADED, &usb_hcds_loaded) ||
 			test_bit(USB_OHCI_LOADED, &usb_hcds_loaded))
diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 98326465e2dc..adf0998f0299 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -699,7 +699,6 @@ static int __init ohci_at91_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
 	ohci_init_driver(&ohci_at91_hc_driver, &ohci_at91_drv_overrides);
 
 	/*
diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 1371b0c249ec..d4818e8d652b 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -551,7 +551,6 @@ static int __init ohci_da8xx_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", DRV_NAME);
 	ohci_init_driver(&ohci_da8xx_hc_driver, &da8xx_overrides);
 
 	/*
diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 5f5e8a64c8e2..a060be6ae274 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -310,7 +310,6 @@ static int __init ohci_exynos_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
 	ohci_init_driver(&exynos_ohci_hc_driver, &exynos_overrides);
 	return platform_driver_register(&exynos_ohci_driver);
 }
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index c4c821c2288c..0457dd9f6c19 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1276,7 +1276,6 @@ static int __init ohci_hcd_mod_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	printk(KERN_INFO "%s: " DRIVER_DESC "\n", hcd_name);
 	pr_debug ("%s: block sizes: ed %zd td %zd\n", hcd_name,
 		sizeof (struct ed), sizeof (struct td));
 	set_bit(USB_OHCI_LOADED, &usb_hcds_loaded);
diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
index 106a6bcefb08..5b32e683e367 100644
--- a/drivers/usb/host/ohci-nxp.c
+++ b/drivers/usb/host/ohci-nxp.c
@@ -275,8 +275,6 @@ static int __init ohci_nxp_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ohci_init_driver(&ohci_nxp_hc_driver, NULL);
 	return platform_driver_register(&ohci_hcd_nxp_driver);
 }
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index f5bc9c8bdc9a..cb29701df911 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -423,8 +423,6 @@ static int __init ohci_omap_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ohci_init_driver(&ohci_omap_hc_driver, &omap_overrides);
 	return platform_driver_register(&ohci_hcd_omap_driver);
 }
diff --git a/drivers/usb/host/ohci-pci.c b/drivers/usb/host/ohci-pci.c
index 41efe927d8f3..a146b2d3ef0b 100644
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -306,8 +306,6 @@ static int __init ohci_pci_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ohci_init_driver(&ohci_pci_hc_driver, &pci_overrides);
 
 #ifdef	CONFIG_PM
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 0adae6265127..6d56b52966c7 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -346,8 +346,6 @@ static int __init ohci_platform_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ohci_init_driver(&ohci_platform_hc_driver, &platform_overrides);
 	return platform_driver_register(&ohci_platform_driver);
 }
diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index ab4f610a0140..f2504b884e92 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -608,8 +608,6 @@ static int __init ohci_pxa27x_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ohci_init_driver(&ohci_pxa27x_hc_driver, &pxa27x_overrides);
 	ohci_pxa27x_hc_driver.hub_control = pxa27x_ohci_hub_control;
 
diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index 12264c048601..7207c7a3cf49 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -474,7 +474,6 @@ static int __init ohci_s3c2410_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
 	ohci_init_driver(&ohci_s3c2410_hc_driver, NULL);
 
 	/*
diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 9b81f420656d..71a3f18fe1be 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -179,8 +179,6 @@ static int __init ohci_spear_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ohci_init_driver(&ohci_spear_hc_driver, &spear_overrides);
 	return platform_driver_register(&spear_ohci_hcd_driver);
 }
diff --git a/drivers/usb/host/ohci-st.c b/drivers/usb/host/ohci-st.c
index ac796ccd93ef..2e542a344aae 100644
--- a/drivers/usb/host/ohci-st.c
+++ b/drivers/usb/host/ohci-st.c
@@ -324,8 +324,6 @@ static int __init ohci_platform_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ohci_init_driver(&ohci_platform_hc_driver, &platform_overrides);
 	return platform_driver_register(&ohci_platform_driver);
 }
-- 
2.35.1

