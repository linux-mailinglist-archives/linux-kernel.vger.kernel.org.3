Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BBD465F07
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355910AbhLBIBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbhLBIB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:01:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAFDC061574;
        Wed,  1 Dec 2021 23:58:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4D6B0CE2141;
        Thu,  2 Dec 2021 07:58:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F8CC00446;
        Thu,  2 Dec 2021 07:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638431881;
        bh=wyVDICNXjwwo2Cz/7IMhlpu0eRNTYeTr5DjBvE/+C0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M55Fqkgn9zeBwWERd2qawEbOsJU2rpQWhcLcVqLejZFwLOaPqCeWpREo+0tNb1h+l
         8177+4ho52pDqeT4/RVrW8UYMr3Qb/9yCAntvGGtiACVIFNEgRwaWzRTKeoC2XQLFE
         bpUGwk/WTyQTgbq5wAs8xbOHk5sXTmJltV8tBzck=
Date:   Thu, 2 Dec 2021 08:57:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steven Syu <stevensyu7@gmail.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: clear usb_pd flag if change to typec only
 mode
Message-ID: <Yah8g87yej08ogMe@kroah.com>
References: <1638430992-15976-1-git-send-email-stevensyu7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638430992-15976-1-git-send-email-stevensyu7@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:43:12PM +0800, Steven Syu wrote:
> Set usb_pd to 0 when power operation mode
> leaving power delivery. That can avoid user-sepace
> read "yes" form the supports_usb_power_delivery_show() attribute
> but power operation mode already change form power delivery to
> others mode.
> 
> Signed-off-by: Steven Syu <stevensyu7@gmail.com>
> ---
>  drivers/usb/typec/class.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index aeef453..2043e07 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1718,6 +1718,8 @@ void typec_set_pwr_opmode(struct typec_port *port,
>  			partner->usb_pd = 1;
>  			sysfs_notify(&partner_dev->kobj, NULL,
>  				     "supports_usb_power_delivery");
> +		} else if (opmode != TYPEC_PWR_MODE_PD && partner->usb_pd) {
> +			partner->usb_pd = 0;
>  		}
>  		put_device(partner_dev);
>  	}
> -- 
> 2.7.4
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
