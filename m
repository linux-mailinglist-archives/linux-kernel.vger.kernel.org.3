Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7115657D324
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiGUSR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGUSRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:17:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373B97694D;
        Thu, 21 Jul 2022 11:17:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D425561FB7;
        Thu, 21 Jul 2022 18:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA017C341C0;
        Thu, 21 Jul 2022 18:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658427444;
        bh=imHAn8ZcGhWHF9A7KhZZa19O7+2F35uWJBtJ6yqAjww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bI/uL+imhRKvsmqQifzLodVyyLA0FwKoov1T7QBHN4f2eFmO6Nurhe1A6CjJ96o+w
         PzsLlAicTqta/zXJO5HXLBi99/NMACV+ldz+2CknnQYDVkn1gz50ufvEAFgCEk9i+5
         pq3i0hLVo70hK1Id1PHBqRD0jeT+8yvQmnnDaG2Y=
Date:   Thu, 21 Jul 2022 20:17:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sdlyyxy <sdlyyxy@bupt.edu.cn>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: usb_wwan: replace DTR/RTS magic numbers
 with macros
Message-ID: <YtmYIk85IIIOKivi@kroah.com>
References: <20220721152335.629105-1-sdlyyxy@bupt.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721152335.629105-1-sdlyyxy@bupt.edu.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 11:23:35PM +0800, sdlyyxy wrote:
> The usb_wwan_send_setup function generates DTR/RTS signals in compliance
> with CDC ACM standard. This patch changes magic numbers in this function
> to equivalent macros.
> 
> Signed-off-by: sdlyyxy <sdlyyxy@bupt.edu.cn>
> ---
>  drivers/usb/serial/usb_wwan.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
> index dab38b63eaf7..a6bd6144702d 100644
> --- a/drivers/usb/serial/usb_wwan.c
> +++ b/drivers/usb/serial/usb_wwan.c
> @@ -29,10 +29,14 @@
>  #include <linux/bitops.h>
>  #include <linux/uaccess.h>
>  #include <linux/usb.h>
> +#include <linux/usb/cdc.h>
>  #include <linux/usb/serial.h>
>  #include <linux/serial.h>
>  #include "usb-wwan.h"
>  
> +#define ACM_CTRL_DTR 0x01
> +#define ACM_CTRL_RTS 0x02
> +
>  /*
>   * Generate DTR/RTS signals on the port using the SET_CONTROL_LINE_STATE request
>   * in CDC ACM.
> @@ -48,9 +52,9 @@ static int usb_wwan_send_setup(struct usb_serial_port *port)
>  	portdata = usb_get_serial_port_data(port);
>  
>  	if (portdata->dtr_state)
> -		val |= 0x01;
> +		val |= ACM_CTRL_DTR;
>  	if (portdata->rts_state)
> -		val |= 0x02;
> +		val |= ACM_CTRL_RTS;
>  
>  	ifnum = serial->interface->cur_altsetting->desc.bInterfaceNumber;
>  
> @@ -59,8 +63,9 @@ static int usb_wwan_send_setup(struct usb_serial_port *port)
>  		return res;
>  
>  	res = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
> -				0x22, 0x21, val, ifnum, NULL, 0,
> -				USB_CTRL_SET_TIMEOUT);
> +				USB_CDC_REQ_SET_CONTROL_LINE_STATE,
> +				USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> +				val, ifnum, NULL, 0, USB_CTRL_SET_TIMEOUT);
>  
>  	usb_autopm_put_interface(port->serial->interface);
>  
> -- 
> 2.25.1
> 
> 
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

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
