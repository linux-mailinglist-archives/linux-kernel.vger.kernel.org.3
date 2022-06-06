Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F60453EDAB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiFFSM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiFFSMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:12:54 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 234E42AC72
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:12:53 -0700 (PDT)
Received: (qmail 377508 invoked by uid 1000); 6 Jun 2022 14:12:52 -0400
Date:   Mon, 6 Jun 2022 14:12:52 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ohci-at91: add support to enter suspend using
 SMC
Message-ID: <Yp5DpPpW5/3SnuJl@rowland.harvard.edu>
References: <20220606141802.165252-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220606141802.165252-1-clement.leger@bootlin.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 04:18:02PM +0200, Clément Léger wrote:
> When Linux is running under OP-TEE, the SFR is set as secured and thus
> the AT91_OHCIICR_USB_SUSPEND register isn't accessible. Add a SMC to
> do the appropriate call to suspend the controller.
> The SMC id is fetched from the device-tree property
> "microchip,suspend-smc-id". if present, then the syscon regmap is not
> used to enter suspend and a SMC is issued.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

However, this is a little weird...  You've written 
usb_hcd_at91_probe() so that the SMC is detected in preference to the 
regmap, but then you wrote ohci_at91_port_suspend() so that the regmap 
is used in preference to the SMC.  It's not wrong, but it is confusing 
to read.

Do you want to rewrite the patch to make the two routines agree on which 
mechanism to use by default?

Alan Stern

>  drivers/usb/host/ohci-at91.c | 69 ++++++++++++++++++++++++------------
>  1 file changed, 46 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index a24aea3d2759..e73fda4af278 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -13,6 +13,7 @@
>   * This file is licenced under the GPL.
>   */
>  
> +#include <linux/arm-smccc.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/gpio/consumer.h>
> @@ -55,6 +56,7 @@ struct ohci_at91_priv {
>  	bool clocked;
>  	bool wakeup;		/* Saved wake-up state for resume */
>  	struct regmap *sfr_regmap;
> +	u32 smc_id;
>  };
>  /* interface and function clocks; sometimes also an AHB clock */
>  
> @@ -135,6 +137,19 @@ static void at91_stop_hc(struct platform_device *pdev)
>  
>  static void usb_hcd_at91_remove (struct usb_hcd *, struct platform_device *);
>  
> +static u32 at91_dt_suspend_smc(struct device *dev)
> +{
> +	u32 smc_id;
> +
> +	if (!dev->of_node)
> +		return 0;
> +
> +	if (of_property_read_u32(dev->of_node, "microchip,suspend-smc-id", &smc_id))
> +		return 0;
> +
> +	return smc_id;
> +}
> +
>  static struct regmap *at91_dt_syscon_sfr(void)
>  {
>  	struct regmap *regmap;
> @@ -215,9 +230,13 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>  		goto err;
>  	}
>  
> -	ohci_at91->sfr_regmap = at91_dt_syscon_sfr();
> -	if (!ohci_at91->sfr_regmap)
> -		dev_dbg(dev, "failed to find sfr node\n");
> +	ohci_at91->smc_id = at91_dt_suspend_smc(dev);
> +	if (!ohci_at91->smc_id)  {
> +		dev_dbg(dev, "failed to find sfr suspend smc id, using regmap\n");
> +		ohci_at91->sfr_regmap = at91_dt_syscon_sfr();
> +		if (!ohci_at91->sfr_regmap)
> +			dev_dbg(dev, "failed to find sfr node\n");
> +	}
>  
>  	board = hcd->self.controller->platform_data;
>  	ohci = hcd_to_ohci(hcd);
> @@ -303,24 +322,30 @@ static int ohci_at91_hub_status_data(struct usb_hcd *hcd, char *buf)
>  	return length;
>  }
>  
> -static int ohci_at91_port_suspend(struct regmap *regmap, u8 set)
> +static int ohci_at91_port_suspend(struct ohci_at91_priv *ohci_at91, u8 set)
>  {
> +	struct regmap *regmap = ohci_at91->sfr_regmap;
>  	u32 regval;
>  	int ret;
>  
> -	if (!regmap)
> -		return 0;
> +	if (regmap) {
> +		ret = regmap_read(regmap, AT91_SFR_OHCIICR, &regval);
> +		if (ret)
> +			return ret;
>  
> -	ret = regmap_read(regmap, AT91_SFR_OHCIICR, &regval);
> -	if (ret)
> -		return ret;
> +		if (set)
> +			regval |= AT91_OHCIICR_USB_SUSPEND;
> +		else
> +			regval &= ~AT91_OHCIICR_USB_SUSPEND;
>  
> -	if (set)
> -		regval |= AT91_OHCIICR_USB_SUSPEND;
> -	else
> -		regval &= ~AT91_OHCIICR_USB_SUSPEND;
> +		regmap_write(regmap, AT91_SFR_OHCIICR, regval);
> +	} else if (ohci_at91->smc_id) {
> +		struct arm_smccc_res res;
>  
> -	regmap_write(regmap, AT91_SFR_OHCIICR, regval);
> +		arm_smccc_smc(ohci_at91->smc_id, set, 0, 0, 0, 0, 0, 0, &res);
> +		if (res.a0)
> +			return -EINVAL;
> +	}
>  
>  	return 0;
>  }
> @@ -357,9 +382,8 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  
>  		case USB_PORT_FEAT_SUSPEND:
>  			dev_dbg(hcd->self.controller, "SetPortFeat: SUSPEND\n");
> -			if (valid_port(wIndex) && ohci_at91->sfr_regmap) {
> -				ohci_at91_port_suspend(ohci_at91->sfr_regmap,
> -						       1);
> +			if (valid_port(wIndex)) {
> +				ohci_at91_port_suspend(ohci_at91, 1);
>  				return 0;
>  			}
>  			break;
> @@ -400,9 +424,8 @@ static int ohci_at91_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  
>  		case USB_PORT_FEAT_SUSPEND:
>  			dev_dbg(hcd->self.controller, "ClearPortFeature: SUSPEND\n");
> -			if (valid_port(wIndex) && ohci_at91->sfr_regmap) {
> -				ohci_at91_port_suspend(ohci_at91->sfr_regmap,
> -						       0);
> +			if (valid_port(wIndex)) {
> +				ohci_at91_port_suspend(ohci_at91, 0);
>  				return 0;
>  			}
>  			break;
> @@ -630,10 +653,10 @@ ohci_hcd_at91_drv_suspend(struct device *dev)
>  		/* flush the writes */
>  		(void) ohci_readl (ohci, &ohci->regs->control);
>  		msleep(1);
> -		ohci_at91_port_suspend(ohci_at91->sfr_regmap, 1);
> +		ohci_at91_port_suspend(ohci_at91, 1);
>  		at91_stop_clock(ohci_at91);
>  	} else {
> -		ohci_at91_port_suspend(ohci_at91->sfr_regmap, 1);
> +		ohci_at91_port_suspend(ohci_at91, 1);
>  	}
>  
>  	return ret;
> @@ -645,7 +668,7 @@ ohci_hcd_at91_drv_resume(struct device *dev)
>  	struct usb_hcd	*hcd = dev_get_drvdata(dev);
>  	struct ohci_at91_priv *ohci_at91 = hcd_to_ohci_at91_priv(hcd);
>  
> -	ohci_at91_port_suspend(ohci_at91->sfr_regmap, 0);
> +	ohci_at91_port_suspend(ohci_at91, 0);
>  
>  	if (ohci_at91->wakeup)
>  		disable_irq_wake(hcd->irq);
> -- 
> 2.36.1
> 
