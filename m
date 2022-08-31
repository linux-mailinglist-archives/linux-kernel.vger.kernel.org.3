Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D2F5A803B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiHaOb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiHaObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:31:20 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A385F32D8A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:31:19 -0700 (PDT)
Received: (qmail 191749 invoked by uid 1000); 31 Aug 2022 10:31:18 -0400
Date:   Wed, 31 Aug 2022 10:31:18 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
Subject: Re: [PATCH v2] usb: ohci-platform: fix usb disconnect issue after s4
Message-ID: <Yw9wtv5TtEr209j0@rowland.harvard.edu>
References: <20220831045910.12203-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831045910.12203-1-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 12:59:10PM +0800, Yinbo Zhu wrote:
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
> Change in v2:
> 		1. Revise the commit log infomation.	
> 		2. Wrap the ohci_platform_renew() function with two 
> 		   helpers that are ohci_platform_renew_hibernated() 
> 		   and ohci_platform_renew().
> 
>  drivers/usb/host/ohci-platform.c | 49 ++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 0adae6265127..56cb424d3bb0 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -289,7 +289,7 @@ static int ohci_platform_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int ohci_platform_resume(struct device *dev)
> +static int ohci_platform_renew(struct device *dev)
>  {
>  	struct usb_hcd *hcd = dev_get_drvdata(dev);
>  	struct usb_ohci_pdata *pdata = dev_get_platdata(dev);
> @@ -297,6 +297,7 @@ static int ohci_platform_resume(struct device *dev)
>  
>  	if (pdata->power_on) {
>  		int err = pdata->power_on(pdev);
> +
>  		if (err < 0)
>  			return err;
>  	}
> @@ -309,6 +310,38 @@ static int ohci_platform_resume(struct device *dev)
>  
>  	return 0;
>  }
> +
> +static int ohci_platform_renew_hibernated(struct device *dev)
> +{
> +	struct usb_hcd *hcd = dev_get_drvdata(dev);
> +	struct usb_ohci_pdata *pdata = dev_get_platdata(dev);
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	if (pdata->power_on) {
> +		int err = pdata->power_on(pdev);
> +
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	ohci_resume(hcd, true);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +}
> +
> +static int ohci_platform_resume(struct device *dev)
> +{
> +	return ohci_platform_renew(dev);
> +}
> +
> +static int ohci_platform_restore(struct device *dev)
> +{
> +	return ohci_platform_renew_hibernated(dev);
> +}

I really do not see any point in these helper routines.  Why not just 
use these names (ohci_platform_resume and ohci_platform_restore) for the 
actual routines and forget about the _renew names?

Although if it were me, I'd do it more like this:

static int ohci_platform_resume_common(struct device *dev, bool hibernated)
{ ... }

static int ohci_platform_resume(struct device *dev)
{
	return ohci_platform_resume_common(dev, false);
}

static int ohci_platform_restore(struct device *dev)
{
	return ohci_platform_resume_common(dev, true);
}

Alan Stern
