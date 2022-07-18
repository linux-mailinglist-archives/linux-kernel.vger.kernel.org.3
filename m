Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266F8578295
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiGRMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiGRMmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:42:40 -0400
X-Greylist: delayed 775 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 05:42:38 PDT
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E16C260DC;
        Mon, 18 Jul 2022 05:42:37 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id B55F11C80F69;
        Mon, 18 Jul 2022 20:29:38 +0800 (CST)
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Jul
 2022 20:29:38 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 18 Jul
 2022 20:29:38 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Mon, 18 Jul 2022 20:29:37 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 17E6363A4C; Mon, 18 Jul 2022 15:29:37 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <gregkh@linuxfoundation.org>,
        <stern@rowland.harvard.edu>, <tony@atomide.com>,
        <felipe.balbi@linux.intel.com>, <jgross@suse.com>,
        <lukas.bulwahn@gmail.com>, <arnd@arndb.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/3] usb: host: npcm7xx: remove USB EHCI host reset sequence
Date:   Mon, 18 Jul 2022 15:29:20 +0300
Message-ID: <20220718122922.9396-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220718122922.9396-1-tmaimon77@gmail.com>
References: <20220718122922.9396-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove USB EHCI host controller reset sequence from NPCM7XX USB EHCI
host probe function because it is done in the NPCM reset driver.

Due to it, NPCM7XX EHCI driver configuration is dependent on NPCM reset.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/usb/host/Kconfig        |  2 +-
 drivers/usb/host/ehci-npcm7xx.c | 47 ---------------------------------
 2 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 682b3d2da623..e05e2cf806f8 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -206,7 +206,7 @@ config USB_EHCI_FSL
 
 config USB_EHCI_HCD_NPCM7XX
 	tristate "Support for Nuvoton NPCM7XX on-chip EHCI USB controller"
-	depends on (USB_EHCI_HCD && ARCH_NPCM7XX) || COMPILE_TEST
+	depends on (USB_EHCI_HCD && ARCH_NPCM7XX && RESET_NPCM) || COMPILE_TEST
 	default y if (USB_EHCI_HCD && ARCH_NPCM7XX)
 	help
 	  Enables support for the on-chip EHCI controller on
diff --git a/drivers/usb/host/ehci-npcm7xx.c b/drivers/usb/host/ehci-npcm7xx.c
index 6b5a7a873e01..955e7c8f3db8 100644
--- a/drivers/usb/host/ehci-npcm7xx.c
+++ b/drivers/usb/host/ehci-npcm7xx.c
@@ -28,13 +28,6 @@
 #define DRIVER_DESC "EHCI npcm7xx driver"
 
 static const char hcd_name[] = "npcm7xx-ehci";
-
-#define  USB2PHYCTL_OFFSET 0x144
-
-#define  IPSRST2_OFFSET 0x24
-#define  IPSRST3_OFFSET 0x34
-
-
 static struct hc_driver __read_mostly ehci_npcm7xx_hc_driver;
 
 static int __maybe_unused ehci_npcm7xx_drv_suspend(struct device *dev)
@@ -60,52 +53,12 @@ static int npcm7xx_ehci_hcd_drv_probe(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd;
 	struct resource *res;
-	struct regmap *gcr_regmap;
-	struct regmap *rst_regmap;
 	const struct hc_driver *driver = &ehci_npcm7xx_hc_driver;
 	int irq;
 	int retval;
 
 	dev_dbg(&pdev->dev,	"initializing npcm7xx ehci USB Controller\n");
 
-	gcr_regmap = syscon_regmap_lookup_by_compatible("nuvoton,npcm750-gcr");
-	if (IS_ERR(gcr_regmap)) {
-		dev_err(&pdev->dev, "%s: failed to find nuvoton,npcm750-gcr\n",
-			__func__);
-		return PTR_ERR(gcr_regmap);
-	}
-
-	rst_regmap = syscon_regmap_lookup_by_compatible("nuvoton,npcm750-rst");
-	if (IS_ERR(rst_regmap)) {
-		dev_err(&pdev->dev, "%s: failed to find nuvoton,npcm750-rst\n",
-			__func__);
-		return PTR_ERR(rst_regmap);
-	}
-
-	/********* phy init  ******/
-	// reset usb host
-	regmap_update_bits(rst_regmap, IPSRST2_OFFSET,
-			(0x1 << 26), (0x1 << 26));
-	regmap_update_bits(rst_regmap, IPSRST3_OFFSET,
-			(0x1 << 25), (0x1 << 25));
-	regmap_update_bits(gcr_regmap, USB2PHYCTL_OFFSET,
-			(0x1 << 28), 0);
-
-	udelay(1);
-
-	// enable phy
-	regmap_update_bits(rst_regmap, IPSRST3_OFFSET,
-			(0x1 << 25), 0);
-
-	udelay(50); // enable phy
-
-	regmap_update_bits(gcr_regmap, USB2PHYCTL_OFFSET,
-			(0x1 << 28), (0x1 << 28));
-
-	// enable host
-	regmap_update_bits(rst_regmap, IPSRST2_OFFSET,
-			(0x1 << 26), 0);
-
 	if (usb_disabled())
 		return -ENODEV;
 
-- 
2.33.0

