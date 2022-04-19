Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DBB5074EE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355247AbiDSQsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiDSQoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:44:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8291E23BF4;
        Tue, 19 Apr 2022 09:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2060B61821;
        Tue, 19 Apr 2022 16:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCD4C385A7;
        Tue, 19 Apr 2022 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386481;
        bh=B/EPqKtpF/X7/qtDP9YwLKtvodaWStDsu3zudJ8kKz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/RYNgH/mBUlontysDvDDbQEl/w5JkQ9KERIge+TcJ551/XZYLOWdDTGCMdx+YKy7
         Eo/SvJOdF5wgBq+JPCny5Iz4sfnm67vOL/aV3JDNF+eu3PEHxKh+sOrXkMuKManFEB
         FvCJgeGTM+6w0HGQJbhRtyvAVvYZhIZUQzpHF2wCtgZokugnVX+Kwy6gFqN6W1IZJt
         h6Z8zUzZzd2yynsmy/ykvebZNOmvxQfFa0IczJPaH1E/UzhZyrRLjpixBmukOAd097
         r+a1YGs658YewbGmFKHNY8vaSw30yUPgx99OTD0iJIm65L2L+bhpmbdN90g/nC0hhO
         aQjZ7EgUWchew==
From:   Arnd Bergmann <arnd@kernel.org>
To:     robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 19/48] ARM: pxa: lubbock: pass udc irqs as resource
Date:   Tue, 19 Apr 2022 18:37:41 +0200
Message-Id: <20220419163810.2118169-20-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220419163810.2118169-1-arnd@kernel.org>
References: <20220419163810.2118169-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Lubbock is the only machine that has three IRQs for the UDC.
These are currently hardcoded in the driver based on a
machine header file.

Change this to use platform device resources as we use for
the generic IRQ anyway.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/lubbock.c                   | 12 +++++-
 .../arm/mach-pxa/{include/mach => }/lubbock.h |  2 -
 drivers/usb/gadget/udc/pxa25x_udc.c           | 37 ++++++++++---------
 drivers/usb/gadget/udc/pxa25x_udc.h           |  7 +---
 4 files changed, 32 insertions(+), 26 deletions(-)
 rename arch/arm/mach-pxa/{include/mach => }/lubbock.h (97%)

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 46aef93c0615..201f89f49642 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -46,7 +46,7 @@
 
 #include "pxa25x.h"
 #include <linux/platform_data/asoc-pxa.h>
-#include <mach/lubbock.h>
+#include "lubbock.h"
 #include "udc.h"
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/video-pxafb.h>
@@ -131,6 +131,13 @@ static struct pxa2xx_udc_mach_info udc_info __initdata = {
 	// no D+ pullup; lubbock can't connect/disconnect in software
 };
 
+static struct resource lubbock_udc_resources[] = {
+	DEFINE_RES_MEM(0x40600000, 0x10000),
+	DEFINE_RES_IRQ(IRQ_USB),
+	DEFINE_RES_IRQ(LUBBOCK_USB_IRQ),
+	DEFINE_RES_IRQ(LUBBOCK_USB_DISC_IRQ),
+};
+
 /* GPIOs for SA1111 PCMCIA */
 static struct gpiod_lookup_table sa1111_pcmcia_gpio_table = {
 	.dev_id = "1800",
@@ -496,6 +503,9 @@ static void __init lubbock_init(void)
 	lubbock_init_pcmcia();
 
 	clk_add_alias("SA1111_CLK", NULL, "GPIO11_CLK", NULL);
+	/* lubbock has two extra IRQs */
+	pxa25x_device_udc.resource = lubbock_udc_resources;
+	pxa25x_device_udc.num_resources = ARRAY_SIZE(lubbock_udc_resources);
 	pxa_set_udc_info(&udc_info);
 	pxa_set_fb_info(NULL, &sharp_lm8v31);
 	pxa_set_mci_info(&lubbock_mci_platform_data);
diff --git a/arch/arm/mach-pxa/include/mach/lubbock.h b/arch/arm/mach-pxa/lubbock.h
similarity index 97%
rename from arch/arm/mach-pxa/include/mach/lubbock.h
rename to arch/arm/mach-pxa/lubbock.h
index a3af4a2f9446..8e3ff7d57121 100644
--- a/arch/arm/mach-pxa/include/mach/lubbock.h
+++ b/arch/arm/mach-pxa/lubbock.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  arch/arm/mach-pxa/include/mach/lubbock.h
- *
  *  Author:	Nicolas Pitre
  *  Created:	Jun 15, 2001
  *  Copyright:	MontaVista Software Inc.
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 6c414c99d01c..c593fc383481 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -44,10 +44,6 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
 
-#ifdef CONFIG_ARCH_LUBBOCK
-#include <mach/lubbock.h>
-#endif
-
 #define UDCCR	 0x0000 /* UDC Control Register */
 #define UDC_RES1 0x0004 /* UDC Undocumented - Reserved1 */
 #define UDC_RES2 0x0008 /* UDC Undocumented - Reserved2 */
@@ -1578,18 +1574,15 @@ lubbock_vbus_irq(int irq, void *_dev)
 	int			vbus;
 
 	dev->stats.irqs++;
-	switch (irq) {
-	case LUBBOCK_USB_IRQ:
+	if (irq == dev->usb_irq) {
 		vbus = 1;
-		disable_irq(LUBBOCK_USB_IRQ);
-		enable_irq(LUBBOCK_USB_DISC_IRQ);
-		break;
-	case LUBBOCK_USB_DISC_IRQ:
+		disable_irq(dev->usb_irq);
+		enable_irq(dev->usb_disc_irq);
+	} else if (irq == dev->usb_disc_irq) {
 		vbus = 0;
-		disable_irq(LUBBOCK_USB_DISC_IRQ);
-		enable_irq(LUBBOCK_USB_IRQ);
-		break;
-	default:
+		disable_irq(dev->usb_disc_irq);
+		enable_irq(dev->usb_irq);
+	} else {
 		return IRQ_NONE;
 	}
 
@@ -2422,20 +2415,28 @@ static int pxa25x_udc_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_ARCH_LUBBOCK
 	if (machine_is_lubbock()) {
-		retval = devm_request_irq(&pdev->dev, LUBBOCK_USB_DISC_IRQ,
+		dev->usb_irq = platform_get_irq(pdev, 1);
+		if (dev->usb_irq < 0)
+			return dev->usb_irq;
+
+		dev->usb_disc_irq = platform_get_irq(pdev, 2);
+		if (dev->usb_disc_irq < 0)
+			return dev->usb_disc_irq;
+
+		retval = devm_request_irq(&pdev->dev, dev->usb_disc_irq,
 					  lubbock_vbus_irq, 0, driver_name,
 					  dev);
 		if (retval != 0) {
 			pr_err("%s: can't get irq %i, err %d\n",
-				driver_name, LUBBOCK_USB_DISC_IRQ, retval);
+				driver_name, dev->usb_disc_irq, retval);
 			goto err;
 		}
-		retval = devm_request_irq(&pdev->dev, LUBBOCK_USB_IRQ,
+		retval = devm_request_irq(&pdev->dev, dev->usb_irq,
 					  lubbock_vbus_irq, 0, driver_name,
 					  dev);
 		if (retval != 0) {
 			pr_err("%s: can't get irq %i, err %d\n",
-				driver_name, LUBBOCK_USB_IRQ, retval);
+				driver_name, dev->usb_irq, retval);
 			goto err;
 		}
 	} else
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.h b/drivers/usb/gadget/udc/pxa25x_udc.h
index aa4b68fd9fc0..6ab6047edc83 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.h
+++ b/drivers/usb/gadget/udc/pxa25x_udc.h
@@ -117,16 +117,13 @@ struct pxa25x_udc {
 	u64					dma_mask;
 	struct pxa25x_ep			ep [PXA_UDC_NUM_ENDPOINTS];
 	void __iomem				*regs;
+	int					usb_irq;
+	int					usb_disc_irq;
 };
 #define to_pxa25x(g)	(container_of((g), struct pxa25x_udc, gadget))
 
 /*-------------------------------------------------------------------------*/
 
-#ifdef CONFIG_ARCH_LUBBOCK
-#include <mach/lubbock.h>
-/* lubbock can also report usb connect/disconnect irqs */
-#endif
-
 static struct pxa25x_udc *the_controller;
 
 /*-------------------------------------------------------------------------*/
-- 
2.29.2

