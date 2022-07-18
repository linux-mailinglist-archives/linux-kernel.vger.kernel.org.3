Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D94578577
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiGROaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbiGROah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:30:37 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0BEBF1EAD6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:30:35 -0700 (PDT)
Received: (qmail 122695 invoked by uid 1000); 18 Jul 2022 10:30:34 -0400
Date:   Mon, 18 Jul 2022 10:30:34 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        gregkh@linuxfoundation.org, tony@atomide.com,
        felipe.balbi@linux.intel.com, jgross@suse.com,
        lukas.bulwahn@gmail.com, arnd@arndb.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, openbmc@lists.ozlabs.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] usb: host: npcm7xx: remove USB EHCI host reset
 sequence
Message-ID: <YtVuildpxcI5By4x@rowland.harvard.edu>
References: <20220718122922.9396-1-tmaimon77@gmail.com>
 <20220718122922.9396-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718122922.9396-2-tmaimon77@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 03:29:20PM +0300, Tomer Maimon wrote:
> Remove USB EHCI host controller reset sequence from NPCM7XX USB EHCI
> host probe function because it is done in the NPCM reset driver.
> 
> Due to it, NPCM7XX EHCI driver configuration is dependent on NPCM reset.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---

Regarding the changes to ehci-npcm7xx.c:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

But you probably should remove the "#include <linux/regmap.h>" line near 
the start of the source file.

Alan Stern

>  drivers/usb/host/Kconfig        |  2 +-
>  drivers/usb/host/ehci-npcm7xx.c | 47 ---------------------------------
>  2 files changed, 1 insertion(+), 48 deletions(-)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 682b3d2da623..e05e2cf806f8 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -206,7 +206,7 @@ config USB_EHCI_FSL
>  
>  config USB_EHCI_HCD_NPCM7XX
>  	tristate "Support for Nuvoton NPCM7XX on-chip EHCI USB controller"
> -	depends on (USB_EHCI_HCD && ARCH_NPCM7XX) || COMPILE_TEST
> +	depends on (USB_EHCI_HCD && ARCH_NPCM7XX && RESET_NPCM) || COMPILE_TEST
>  	default y if (USB_EHCI_HCD && ARCH_NPCM7XX)
>  	help
>  	  Enables support for the on-chip EHCI controller on
> diff --git a/drivers/usb/host/ehci-npcm7xx.c b/drivers/usb/host/ehci-npcm7xx.c
> index 6b5a7a873e01..955e7c8f3db8 100644
> --- a/drivers/usb/host/ehci-npcm7xx.c
> +++ b/drivers/usb/host/ehci-npcm7xx.c
> @@ -28,13 +28,6 @@
>  #define DRIVER_DESC "EHCI npcm7xx driver"
>  
>  static const char hcd_name[] = "npcm7xx-ehci";
> -
> -#define  USB2PHYCTL_OFFSET 0x144
> -
> -#define  IPSRST2_OFFSET 0x24
> -#define  IPSRST3_OFFSET 0x34
> -
> -
>  static struct hc_driver __read_mostly ehci_npcm7xx_hc_driver;
>  
>  static int __maybe_unused ehci_npcm7xx_drv_suspend(struct device *dev)
> @@ -60,52 +53,12 @@ static int npcm7xx_ehci_hcd_drv_probe(struct platform_device *pdev)
>  {
>  	struct usb_hcd *hcd;
>  	struct resource *res;
> -	struct regmap *gcr_regmap;
> -	struct regmap *rst_regmap;
>  	const struct hc_driver *driver = &ehci_npcm7xx_hc_driver;
>  	int irq;
>  	int retval;
>  
>  	dev_dbg(&pdev->dev,	"initializing npcm7xx ehci USB Controller\n");
>  
> -	gcr_regmap = syscon_regmap_lookup_by_compatible("nuvoton,npcm750-gcr");
> -	if (IS_ERR(gcr_regmap)) {
> -		dev_err(&pdev->dev, "%s: failed to find nuvoton,npcm750-gcr\n",
> -			__func__);
> -		return PTR_ERR(gcr_regmap);
> -	}
> -
> -	rst_regmap = syscon_regmap_lookup_by_compatible("nuvoton,npcm750-rst");
> -	if (IS_ERR(rst_regmap)) {
> -		dev_err(&pdev->dev, "%s: failed to find nuvoton,npcm750-rst\n",
> -			__func__);
> -		return PTR_ERR(rst_regmap);
> -	}
> -
> -	/********* phy init  ******/
> -	// reset usb host
> -	regmap_update_bits(rst_regmap, IPSRST2_OFFSET,
> -			(0x1 << 26), (0x1 << 26));
> -	regmap_update_bits(rst_regmap, IPSRST3_OFFSET,
> -			(0x1 << 25), (0x1 << 25));
> -	regmap_update_bits(gcr_regmap, USB2PHYCTL_OFFSET,
> -			(0x1 << 28), 0);
> -
> -	udelay(1);
> -
> -	// enable phy
> -	regmap_update_bits(rst_regmap, IPSRST3_OFFSET,
> -			(0x1 << 25), 0);
> -
> -	udelay(50); // enable phy
> -
> -	regmap_update_bits(gcr_regmap, USB2PHYCTL_OFFSET,
> -			(0x1 << 28), (0x1 << 28));
> -
> -	// enable host
> -	regmap_update_bits(rst_regmap, IPSRST2_OFFSET,
> -			(0x1 << 26), 0);
> -
>  	if (usb_disabled())
>  		return -ENODEV;
>  
> -- 
> 2.33.0
> 
