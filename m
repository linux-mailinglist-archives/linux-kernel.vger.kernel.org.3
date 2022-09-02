Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296005AB41C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiIBOvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiIBOu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:50:59 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2CAB95E32F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:12:58 -0700 (PDT)
Received: (qmail 272628 invoked by uid 1000); 2 Sep 2022 10:12:58 -0400
Date:   Fri, 2 Sep 2022 10:12:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Subject: Re: [PATCH v4] usb: ohci-platform: fix usb disconnect issue after s4
Message-ID: <YxIPai+YGyzCRlkp@rowland.harvard.edu>
References: <20220902063639.17875-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902063639.17875-1-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 02:36:39PM +0800, Yinbo Zhu wrote:
> The ohci retaining bogus hardware states cause usb disconnect devices
> connected before hibernation(s4), this issue occur when ohci-platform
> driver build as a module and the built-in ohci-platform driver will
> re probe and re enumerate the devices, so there will be no such problem.
> 
> Avoid retaining bogus hardware states during resume-from-hibernation.
> Previously we had reset the hardware as part of preparing to reinstate
> the snapshot image. But we can do better now with the new PM framework,
> since we know exactly which resume operations are from hibernation.
> 
> According to the commit 'cd1965db054e ("USB: ohci: move ohci_pci_{
> suspend,resume} to ohci-hcd.c")' and commit '6ec4beb5c701 ("USB: new
> flag for resume-from-hibernation")', the flag "hibernated" is for
> resume-from-hibernation and it should be true when usb resume from disk.
> 
> When this flag "hibernated" is set, the drivers will reset the hardware
> to get rid of any existing state and make sure resume from hibernation
> re-enumerates everything for ohci.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v4:
> 		Add explain what this disconnect issue is.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

I'm a little surprised that the driver doesn't support runtime PM.

>  drivers/usb/host/ohci-platform.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 0adae6265127..822a0f927e62 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -289,7 +289,7 @@ static int ohci_platform_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int ohci_platform_resume(struct device *dev)
> +static int ohci_platform_resume_common(struct device *dev, bool hibernated)
>  {
>  	struct usb_hcd *hcd = dev_get_drvdata(dev);
>  	struct usb_ohci_pdata *pdata = dev_get_platdata(dev);
> @@ -301,7 +301,7 @@ static int ohci_platform_resume(struct device *dev)
>  			return err;
>  	}
>  
> -	ohci_resume(hcd, false);
> +	ohci_resume(hcd, hibernated);
>  
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_active(dev);
> @@ -309,6 +309,16 @@ static int ohci_platform_resume(struct device *dev)
>  
>  	return 0;
>  }
> +
> +static int ohci_platform_resume(struct device *dev)
> +{
> +	return ohci_platform_resume_common(dev, false);
> +}
> +
> +static int ohci_platform_restore(struct device *dev)
> +{
> +	return ohci_platform_resume_common(dev, true);
> +}
>  #endif /* CONFIG_PM_SLEEP */
>  
>  static const struct of_device_id ohci_platform_ids[] = {
> @@ -325,8 +335,16 @@ static const struct platform_device_id ohci_platform_table[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, ohci_platform_table);
>  
> -static SIMPLE_DEV_PM_OPS(ohci_platform_pm_ops, ohci_platform_suspend,
> -	ohci_platform_resume);
> +#ifdef CONFIG_PM_SLEEP
> +static const struct dev_pm_ops ohci_platform_pm_ops = {
> +	.suspend = ohci_platform_suspend,
> +	.resume = ohci_platform_resume,
> +	.freeze = ohci_platform_suspend,
> +	.thaw = ohci_platform_resume,
> +	.poweroff = ohci_platform_suspend,
> +	.restore = ohci_platform_restore,
> +};
> +#endif
>  
>  static struct platform_driver ohci_platform_driver = {
>  	.id_table	= ohci_platform_table,
> @@ -335,7 +353,9 @@ static struct platform_driver ohci_platform_driver = {
>  	.shutdown	= usb_hcd_platform_shutdown,
>  	.driver		= {
>  		.name	= "ohci-platform",
> +#ifdef CONFIG_PM_SLEEP
>  		.pm	= &ohci_platform_pm_ops,
> +#endif
>  		.of_match_table = ohci_platform_ids,
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	}
> -- 
> 2.31.1
> 
