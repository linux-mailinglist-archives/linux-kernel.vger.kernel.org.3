Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD29496A8F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 08:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiAVHWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 02:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiAVHWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 02:22:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A9DC06173B;
        Fri, 21 Jan 2022 23:22:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 199696077B;
        Sat, 22 Jan 2022 07:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD0CC004E1;
        Sat, 22 Jan 2022 07:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642836137;
        bh=NcI62+HAnm5vi94iD0LrdVqZ7/x8PFoezOP3K1j5Is4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xzuKNT0/inz/x5ZqZ14wligy+F7SyEPpNB6oPNbjo6Q4qqWTlSEK6lR19GLh6FkG7
         FnT+oH9bo8ib4WRH+Mpq3c0pZOb4HjCSowID63HtjpeT/zZ0inFV4Nj/8+MhKzt0Zh
         aiGnK+Aqu2L6OmEQ3J0eQZ6Py0fcyhZUpmdzbjBw=
Date:   Sat, 22 Jan 2022 08:22:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 23/31] usb: core: changing LED_* from enum led_brightness
 to actual value
Message-ID: <Yeuwou0Hs9+JQmMv@kroah.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
 <20220121165436.30956-24-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121165436.30956-24-sampaio.ime@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 01:54:28PM -0300, Luiz Sampaio wrote:
> The enum led_brightness, which contains the declaration of LED_OFF,
> LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
> max_brightness.
> ---
>  drivers/usb/core/ledtrig-usbport.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/ledtrig-usbport.c b/drivers/usb/core/ledtrig-usbport.c
> index ba371a24ff78..85fa5699bb3d 100644
> --- a/drivers/usb/core/ledtrig-usbport.c
> +++ b/drivers/usb/core/ledtrig-usbport.c
> @@ -73,7 +73,7 @@ static void usbport_trig_update_count(struct usbport_trig_data *usbport_data)
>  
>  	usbport_data->count = 0;
>  	usb_for_each_dev(usbport_data, usbport_trig_usb_dev_check);
> -	led_set_brightness(led_cdev, usbport_data->count ? LED_FULL : LED_OFF);
> +	led_set_brightness(led_cdev, usbport_data->count ? 255 : 0);
>  }
>  
>  /***************************************
> @@ -287,12 +287,12 @@ static int usbport_trig_notify(struct notifier_block *nb, unsigned long action,
>  	case USB_DEVICE_ADD:
>  		usbport_trig_add_usb_dev_ports(usb_dev, usbport_data);
>  		if (observed && usbport_data->count++ == 0)
> -			led_set_brightness(led_cdev, LED_FULL);
> +			led_set_brightness(led_cdev, 255);
>  		return NOTIFY_OK;
>  	case USB_DEVICE_REMOVE:
>  		usbport_trig_remove_usb_dev_ports(usbport_data, usb_dev);
>  		if (observed && --usbport_data->count == 0)
> -			led_set_brightness(led_cdev, LED_OFF);
> +			led_set_brightness(led_cdev, 0);
>  		return NOTIFY_OK;
>  	}
>  
> -- 
> 2.34.1
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

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
