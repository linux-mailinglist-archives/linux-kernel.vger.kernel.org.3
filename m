Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E865A4D5BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346756AbiCKGoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbiCKGoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:44:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DFB157206;
        Thu, 10 Mar 2022 22:43:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2849861D27;
        Fri, 11 Mar 2022 06:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13069C340EC;
        Fri, 11 Mar 2022 06:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646980988;
        bh=Hynl40FMFdNLPC1cJ0x+jyJPX9TWT5Ynp4mHQb6/Kpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTXGLMIcVU+EXlGAqKMJPMXfDp1ZvDjCUBR73pLjFiNwTj7iFxEs6ynADKyKvJUVo
         u5ytKDB2NiYi9Wg+sNRwKAZ2lp7Vz5YhozEwdjaS1a0dymTIt11x5wc6vi1fC54pi6
         rrzy3ty1+I8n0jue5jdWSwJ1bsyI3zh+fOvCyPUc=
Date:   Fri, 11 Mar 2022 07:43:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Ming Chen <jj251510319013@gmail.com>
Cc:     linux-kernel@vger.kernel.org, andreyknvl@gmail.com,
        balbi@kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: raw-gadget: return -EINVAL if no proper ep
 address available
Message-ID: <YirveIx9acrGoe4/@kroah.com>
References: <CA+fCnZd2GoU6LVvT4eBT3w7TigRrp_9XcAGyL55K5nbi3yt4sA@mail.gmail.com>
 <20220311032238.3978-1-jj251510319013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311032238.3978-1-jj251510319013@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 11:22:38AM +0800, Wei Ming Chen wrote:
> If we try to use raw_ioctl_ep_enable() for ep5in on a hardware that
> only support from ep1-ep4 for both in and out direction, it will return
> -EBUSY originally.
> 
> I think it will be more intuitive if we return -EINVAL, because -EBUSY
> sounds like ep5in is not available now, but might be available in the
> future.
> 
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> index d86c3a36441e..e5707626c4d4 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -758,6 +758,7 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
>  	unsigned long flags;
>  	struct usb_endpoint_descriptor *desc;
>  	struct raw_ep *ep;
> +	bool ep_props_matched = false;
>  
>  	desc = memdup_user((void __user *)value, sizeof(*desc));
>  	if (IS_ERR(desc))
> @@ -787,13 +788,14 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
>  
>  	for (i = 0; i < dev->eps_num; i++) {
>  		ep = &dev->eps[i];
> -		if (ep->state != STATE_EP_DISABLED)
> -			continue;
>  		if (ep->addr != usb_endpoint_num(desc) &&
>  				ep->addr != USB_RAW_EP_ADDR_ANY)
>  			continue;
>  		if (!usb_gadget_ep_match_desc(dev->gadget, ep->ep, desc, NULL))
>  			continue;
> +		ep_props_matched = true;
> +		if (ep->state != STATE_EP_DISABLED)
> +			continue;
>  		ep->ep->desc = desc;
>  		ret = usb_ep_enable(ep->ep);
>  		if (ret < 0) {
> @@ -815,8 +817,13 @@ static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
>  		goto out_unlock;
>  	}
>  
> -	dev_dbg(&dev->gadget->dev, "fail, no gadget endpoints available\n");
> -	ret = -EBUSY;
> +	if (!ep_props_matched) {
> +		dev_dbg(&dev->gadget->dev, "fail, bad endpoint descriptor\n");
> +		ret = -EINVAL;
> +	} else {
> +		dev_dbg(&dev->gadget->dev, "fail, no endpoints available\n");
> +		ret = -EBUSY;
> +	}
>  
>  out_free:
>  	kfree(desc);
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
