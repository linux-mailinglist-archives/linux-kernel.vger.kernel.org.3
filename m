Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321F35A643A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiH3M7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiH3M7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:59:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A005F25;
        Tue, 30 Aug 2022 05:59:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D390F616E0;
        Tue, 30 Aug 2022 12:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82E3C433D6;
        Tue, 30 Aug 2022 12:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661864346;
        bh=py80JNZjWXneLCtoEplvUtMQuHLBH9TJN1tDhgjF5Ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xRhzp+ham63Qub7sG6+g79g/Jd1t9JTySXNHNbfKyEx20HVIUUl3+KM1Z4TIvviqn
         Cwrh+dzHQ9xx6LF9JV8HQhUzUjj0HQrI+JKc4kBRlm4MLbI1COUea7EUo4pJs/FBho
         KBdYInSUvJnuyuKM3n4/MR+g91tDR1SKZo3+YaQw=
Date:   Tue, 30 Aug 2022 14:59:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Patchwork Bot <patchwork-bot@kernel.org>
Subject: Re: [PATCH v1] usb: ohci-platform: fix usb disconnect issue after s4
Message-ID: <Yw4JlyrjwHE5nYyd@kroah.com>
References: <20220830111449.2300-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830111449.2300-1-zhuyinbo@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:14:49PM +0800, Yinbo Zhu wrote:
> Avoid retaining bogus hardware states during resume-from-hibernation.
> Previously we had reset the hardware as part of preparing to reinstate
> the snapshot image. But we can do better now with the new PM framework,
> since we know exactly which resume operations are from hibernation
> 
> According to the commit "cd1965db0" and "6ec4beb5c" that the flag
> "hibernated" is for resume-from-hibernation and it should be true when
> usb resume from disk.

When writing commit ids in changelogs, please use the recommended
format.  For this, that paragraph would read:

According to commit cd1965db054e ("USB: ohci: move
ohci_pci_{suspend,resume} to ohci-hcd.c") and commit 6ec4beb5c701 ("USB:
new flag for resume-from-hibernation"), the flag "hibernated" is for...

> When this flag "hibernated" is set, the drivers will reset the hardware
> to get rid of any existing state and make sure resume from hibernation
> re-enumerates everything for ohci.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>

What commit id does this fix?


> ---
>  drivers/usb/host/ohci-platform.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 0adae6265127..e733da2cd3b7 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -289,7 +289,7 @@ static int ohci_platform_suspend(struct device *dev)
>  	return ret;
>  }
>  
> -static int ohci_platform_resume(struct device *dev)
> +static int ohci_platform_renew(struct device *dev, bool hibernated)

I hate functions like this as it's now impossible to read the caller and
understand what is going on.

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
> +	return ohci_platform_renew(dev, false);

See, what does "false" here mean?

You can wrap the ohci_platform_renew() function with two helpers that
are ohci_platform_renew_hibernated() and ohci_platform_renew() or
something like that, which would explain what the difference is here.

thanks,

greg k-h
