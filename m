Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747925AD0BB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbiIEKxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiIEKxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:53:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AB654C9B;
        Mon,  5 Sep 2022 03:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51D0AB8102E;
        Mon,  5 Sep 2022 10:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA02AC43470;
        Mon,  5 Sep 2022 10:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662375194;
        bh=laszTlloEazNn4q68j064DnBDXZiy8Xt3+xeDvwfazo=;
        h=From:To:Cc:Subject:Date:From;
        b=jSew0KtQ12hYgzg+XX+Gj1w/8BoXQzHoiNcpR8GO9LfCXO31t7nTD+vZm3/j6MzS2
         aAk6Rg8fh4kh/ZHfR5f2zdqRTnG+lIk7fFyz/hQeOYeFy2h2QCiMgRGlKhLRY/1owL
         HNxQLQfOYO7Ahfpu8BafyX1DWorNPEwze1B+NIJ8xFDDK5U8FyqsFkS7ToYdtsAgl8
         tWnfZvUVYMam4WEA5m96jpgaGEzIyBMQLpP1X14O4ThDcl+wW24SW0foSdEfn5DJO0
         pNaRL9nur1JVQoLMm7ccyIOl+Vc/pmJBYsasz6Mqqxjz0BWkvpYYuZJv4m0UjvFe3K
         srus6StKXR7Uw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-usb@vger.kernel.org
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
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] usb: reduce kernel log spam on driver registration
Date:   Mon,  5 Sep 2022 12:52:52 +0200
Message-Id: <20220905105252.351795-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18174; i=ardb@kernel.org; h=from:subject; bh=laszTlloEazNn4q68j064DnBDXZiy8Xt3+xeDvwfazo=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjFdUD1K24m0gaam9LdgZAgk5gxc4K/K28xrBNrQmU nIl521SJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYxXVAwAKCRDDTyI5ktmPJGPgDA CHiTeqqMVDvqark5Mg1EI5OboSFrAuh7mRSwQCT+bLw4uYEy3YDxbYi2zQRi0PRhxskp6ZOu6iMlHq +KNcMBOKn2gIBDAUs7f8ZwtH/0uYLfJHZqXXRJA0s6xE1YQKx7yNl92nkluoqqFmoS1LsEV9d7vx3w brev5jJivS1NnOJqKc4X6c22AT5VSlCkN/QY63VTZWMfBgOcEgwL/z2HiI7WETLZ4N3B2y1LCVAEyC xaklInCRgNC+7untW5m7Jq6/cubfoxgWX9AlP7O5+CCApU5VUgnLWQIyCROaTX9zeaHFnHIAPdhlTj wmsSU0S06g03k3k2I5kirAAK57ldpOLxfEBG1h1MlBhtNp1JOxPENwMXUhuglQURGifFQl/khvt4ny +h/kmzgHXQbH02Y6Hs4k/BYqmSNZNWpJRcnZhoWBc7u1NEtmOawrfNX/P0ibcZ3f8ctnxohoGB6aQv Mn9QiE/s4Cb/Jd23es/UaUt+Pe8+Ga5Ny9t/igXnCF3aA=
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
v2: - drop another couple of occurrences pointed out by Robert
    - drop hcd_name variables as well if the only reference to them is
      being dropped
    - pick up acks

 drivers/usb/host/ehci-atmel.c    | 3 ---
 drivers/usb/host/ehci-exynos.c   | 2 --
 drivers/usb/host/ehci-fsl.c      | 2 --
 drivers/usb/host/ehci-hcd.c      | 1 -
 drivers/usb/host/ehci-npcm7xx.c  | 4 ----
 drivers/usb/host/ehci-omap.c     | 2 --
 drivers/usb/host/ehci-orion.c    | 4 ----
 drivers/usb/host/ehci-pci.c      | 2 --
 drivers/usb/host/ehci-platform.c | 4 ----
 drivers/usb/host/ehci-spear.c    | 4 ----
 drivers/usb/host/ehci-st.c       | 4 ----
 drivers/usb/host/fotg210-hcd.c   | 1 -
 drivers/usb/host/ohci-at91.c     | 3 ---
 drivers/usb/host/ohci-da8xx.c    | 1 -
 drivers/usb/host/ohci-exynos.c   | 2 --
 drivers/usb/host/ohci-hcd.c      | 1 -
 drivers/usb/host/ohci-nxp.c      | 2 --
 drivers/usb/host/ohci-omap.c     | 2 --
 drivers/usb/host/ohci-pci.c      | 2 --
 drivers/usb/host/ohci-platform.c | 4 ----
 drivers/usb/host/ohci-pxa27x.c   | 4 ----
 drivers/usb/host/ohci-s3c2410.c  | 3 ---
 drivers/usb/host/ohci-spear.c    | 3 ---
 drivers/usb/host/ohci-st.c       | 4 ----
 drivers/usb/host/u132-hcd.c      | 1 -
 drivers/usb/host/uhci-hcd.c      | 2 --
 26 files changed, 67 deletions(-)

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 05d41fd65f25..8b775e7bab06 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -25,8 +25,6 @@
 
 #define DRIVER_DESC "EHCI Atmel driver"
 
-static const char hcd_name[] = "ehci-atmel";
-
 #define EHCI_INSNREG(index)			((index) * 4 + 0x90)
 #define EHCI_INSNREG08_HSIC_EN			BIT(2)
 
@@ -239,7 +237,6 @@ static int __init ehci_atmel_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
 	ehci_init_driver(&ehci_atmel_hc_driver, &ehci_atmel_drv_overrides);
 	return platform_driver_register(&ehci_atmel_driver);
 }
diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
index 1a9b7572e17f..c8e152c2e0ce 100644
--- a/drivers/usb/host/ehci-exynos.c
+++ b/drivers/usb/host/ehci-exynos.c
@@ -32,7 +32,6 @@
 	(EHCI_INSNREG00_ENA_INCR16 | EHCI_INSNREG00_ENA_INCR8 |	\
 	 EHCI_INSNREG00_ENA_INCR4 | EHCI_INSNREG00_ENA_INCRX_ALIGN)
 
-static const char hcd_name[] = "ehci-exynos";
 static struct hc_driver __read_mostly exynos_ehci_hc_driver;
 
 #define PHY_NUMBER 3
@@ -347,7 +346,6 @@ static int __init ehci_exynos_init(void)
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
index 6b5a7a873e01..f72b28a2c02a 100644
--- a/drivers/usb/host/ehci-npcm7xx.c
+++ b/drivers/usb/host/ehci-npcm7xx.c
@@ -27,8 +27,6 @@
 
 #define DRIVER_DESC "EHCI npcm7xx driver"
 
-static const char hcd_name[] = "npcm7xx-ehci";
-
 #define  USB2PHYCTL_OFFSET 0x144
 
 #define  IPSRST2_OFFSET 0x24
@@ -191,8 +189,6 @@ static int __init ehci_npcm7xx_init(void)
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
index 3626758b3e2a..a3454a3ea4e0 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -65,8 +65,6 @@ struct orion_ehci_hcd {
 	struct phy *phy;
 };
 
-static const char hcd_name[] = "ehci-orion";
-
 static struct hc_driver __read_mostly ehci_orion_hc_driver;
 
 /*
@@ -361,8 +359,6 @@ static int __init ehci_orion_init(void)
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
index 6924f0316e9a..fe497c876d76 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -53,8 +53,6 @@ struct ehci_platform_priv {
 	struct delayed_work poll_work;
 };
 
-static const char hcd_name[] = "ehci-platform";
-
 static int ehci_platform_reset(struct usb_hcd *hcd)
 {
 	struct platform_device *pdev = to_platform_device(hcd->self.controller);
@@ -529,8 +527,6 @@ static int __init ehci_platform_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ehci_init_driver(&ehci_platform_hc_driver, &platform_overrides);
 	return platform_driver_register(&ehci_platform_driver);
 }
diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
index 3694e450a11a..c4ddd1022f60 100644
--- a/drivers/usb/host/ehci-spear.c
+++ b/drivers/usb/host/ehci-spear.c
@@ -24,8 +24,6 @@
 
 #define DRIVER_DESC "EHCI SPEAr driver"
 
-static const char hcd_name[] = "SPEAr-ehci";
-
 struct spear_ehci {
 	struct clk *clk;
 };
@@ -167,8 +165,6 @@ static int __init ehci_spear_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ehci_init_driver(&ehci_spear_hc_driver, &spear_overrides);
 	return platform_driver_register(&spear_ehci_hcd_driver);
 }
diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c
index f74433aac948..f731dc98c533 100644
--- a/drivers/usb/host/ehci-st.c
+++ b/drivers/usb/host/ehci-st.c
@@ -42,8 +42,6 @@ struct st_ehci_platform_priv {
 #define hcd_to_ehci_priv(h) \
 	((struct st_ehci_platform_priv *)hcd_to_ehci(h)->priv)
 
-static const char hcd_name[] = "ehci-st";
-
 #define EHCI_CAPS_SIZE 0x10
 #define AHB2STBUS_INSREG01 (EHCI_CAPS_SIZE + 0x84)
 
@@ -346,8 +344,6 @@ static int __init ehci_platform_init(void)
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
index 98326465e2dc..533537ef3c21 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -62,8 +62,6 @@ struct ohci_at91_priv {
 
 #define DRIVER_DESC "OHCI Atmel driver"
 
-static const char hcd_name[] = "ohci-atmel";
-
 static struct hc_driver __read_mostly ohci_at91_hc_driver;
 
 static const struct ohci_driver_overrides ohci_at91_drv_overrides __initconst = {
@@ -699,7 +697,6 @@ static int __init ohci_at91_init(void)
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
index 5f5e8a64c8e2..8d7977fd5d3b 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -21,7 +21,6 @@
 
 #define DRIVER_DESC "OHCI Exynos driver"
 
-static const char hcd_name[] = "ohci-exynos";
 static struct hc_driver __read_mostly exynos_ohci_hc_driver;
 
 #define to_exynos_ohci(hcd) (struct exynos_ohci_hcd *)(hcd_to_ohci(hcd)->priv)
@@ -310,7 +309,6 @@ static int __init ohci_exynos_init(void)
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
index 0adae6265127..4e7946024ce7 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -41,8 +41,6 @@ struct ohci_platform_priv {
 	struct reset_control *resets;
 };
 
-static const char hcd_name[] = "ohci-platform";
-
 static int ohci_platform_power_on(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
@@ -346,8 +344,6 @@ static int __init ohci_platform_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ohci_init_driver(&ohci_platform_hc_driver, &platform_overrides);
 	return platform_driver_register(&ohci_platform_driver);
 }
diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index ab4f610a0140..a1dad8745622 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -114,8 +114,6 @@
 
 #define PXA_UHC_MAX_PORTNUM    3
 
-static const char hcd_name[] = "ohci-pxa27x";
-
 static struct hc_driver __read_mostly ohci_pxa27x_hc_driver;
 
 struct pxa27x_ohci {
@@ -608,8 +606,6 @@ static int __init ohci_pxa27x_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ohci_init_driver(&ohci_pxa27x_hc_driver, &pxa27x_overrides);
 	ohci_pxa27x_hc_driver.hub_control = pxa27x_ohci_hub_control;
 
diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index 12264c048601..85a0a9ae0095 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -39,8 +39,6 @@
 
 #define DRIVER_DESC "OHCI S3C2410 driver"
 
-static const char hcd_name[] = "ohci-s3c2410";
-
 static struct clk *clk;
 static struct clk *usb_clk;
 
@@ -474,7 +472,6 @@ static int __init ohci_s3c2410_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
 	ohci_init_driver(&ohci_s3c2410_hc_driver, NULL);
 
 	/*
diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 9b81f420656d..196951a27f3f 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -23,7 +23,6 @@
 
 #define DRIVER_DESC "OHCI SPEAr driver"
 
-static const char hcd_name[] = "SPEAr-ohci";
 struct spear_ohci {
 	struct clk *clk;
 };
@@ -179,8 +178,6 @@ static int __init ohci_spear_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ohci_init_driver(&ohci_spear_hc_driver, &spear_overrides);
 	return platform_driver_register(&spear_ohci_hcd_driver);
 }
diff --git a/drivers/usb/host/ohci-st.c b/drivers/usb/host/ohci-st.c
index ac796ccd93ef..82eef3c62e11 100644
--- a/drivers/usb/host/ohci-st.c
+++ b/drivers/usb/host/ohci-st.c
@@ -40,8 +40,6 @@ struct st_ohci_platform_priv {
 #define hcd_to_ohci_priv(h) \
 	((struct st_ohci_platform_priv *)hcd_to_ohci(h)->priv)
 
-static const char hcd_name[] = "ohci-st";
-
 static int st_ohci_platform_power_on(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
@@ -324,8 +322,6 @@ static int __init ohci_platform_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
-
 	ohci_init_driver(&ohci_platform_hc_driver, &platform_overrides);
 	return platform_driver_register(&ohci_platform_driver);
 }
diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index d879d6af5710..95240c9c45bd 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -3190,7 +3190,6 @@ static int __init u132_hcd_init(void)
 	u132_exiting = 0;
 	if (usb_disabled())
 		return -ENODEV;
-	printk(KERN_INFO "driver %s\n", hcd_name);
 	workqueue = create_singlethread_workqueue("u132");
 	if (!workqueue)
 		return -ENOMEM;
diff --git a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
index d90b869f5f40..c22b51af83fc 100644
--- a/drivers/usb/host/uhci-hcd.c
+++ b/drivers/usb/host/uhci-hcd.c
@@ -867,8 +867,6 @@ static int __init uhci_hcd_init(void)
 	if (usb_disabled())
 		return -ENODEV;
 
-	printk(KERN_INFO "uhci_hcd: " DRIVER_DESC "%s\n",
-			ignore_oc ? ", overcurrent ignored" : "");
 	set_bit(USB_UHCI_LOADED, &usb_hcds_loaded);
 
 #ifdef CONFIG_DYNAMIC_DEBUG
-- 
2.35.1

