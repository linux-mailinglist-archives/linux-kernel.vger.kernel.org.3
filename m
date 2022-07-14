Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0F5575056
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbiGNOHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240076AbiGNOHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:07:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD06FEE28
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:07:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83A2662104
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 14:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCE6C34115;
        Thu, 14 Jul 2022 14:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657807630;
        bh=bw+wCJlOkejz2QxcahhYY8ZI2DH0WQfzGd5edWTkDnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bwWW6avYPYfmC8mHiHWR9Hw9Sunq/19HR3/TUP0gZy/AAUDOdf4IeiD1USMlZnMMj
         VBG2BuTNFUDcLnYtgYSmYZxjZuWHVylv0DAvKMvg/gzOlX9BwOLz0UUQfJoOvLmMyt
         Pp5DQt3y//Ed4IeX8qJ+R+fPHMhme2H1oQhEZIVA=
Date:   Thu, 14 Jul 2022 15:28:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     eli.billauer@gmail.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 RESEND] char: xillybus: Check endpoint type at probe
 time
Message-ID: <YtAaDOBOyJkFHb/4@kroah.com>
References: <20220714131824.919052-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714131824.919052-1-zheyuma97@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 09:18:24PM +0800, Zheyu Ma wrote:
> The driver submits bulk urb without checking the endpoint type is
> actually bulk.
> 
> [    3.108690] usb 1-1: BOGUS urb xfer, pipe 3 != type 1
> [    3.108983] WARNING: CPU: 0 PID: 211 at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd9/0x18b0
> [    3.110976] RIP: 0010:usb_submit_urb+0xcd9/0x18b0
> [    3.115318] Call Trace:
> [    3.115452]  <TASK>
> [    3.115570]  try_queue_bulk_in+0x43c/0x6e0 [xillyusb]
> [    3.115838]  xillyusb_probe+0x488/0x1230 [xillyusb]
> 
> Add a check at probe time to fix the bug.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/char/xillybus/xillyusb.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
> index 39bcbfd908b4..b1bac2fdb42a 100644
> --- a/drivers/char/xillybus/xillyusb.c
> +++ b/drivers/char/xillybus/xillyusb.c
> @@ -167,6 +167,7 @@ struct xillyusb_dev {
>  	struct device		*dev; /* For dev_err() and such */
>  	struct kref		kref;
>  	struct workqueue_struct	*workq;
> +	struct usb_interface *intf;
>  
>  	int error;
>  	spinlock_t error_lock; /* protect @error */
> @@ -1890,8 +1891,31 @@ static const struct file_operations xillyusb_fops = {
>  	.poll       = xillyusb_poll,
>  };
>  
> +static int xillyusb_check_endpoint(struct xillyusb_dev *xdev, u8 addr)
> +{
> +	int i;
> +	struct usb_host_interface *if_desc = xdev->intf->altsetting;
> +
> +	for (i = 0; i < if_desc->desc.bNumEndpoints; i++) {
> +		struct usb_endpoint_descriptor *ep = &if_desc->endpoint[i].desc;
> +
> +		if (ep->bEndpointAddress != addr)
> +			continue;
> +
> +		if ((usb_pipein(addr) && usb_endpoint_is_bulk_in(ep)) ||
> +			(usb_pipeout(addr) && usb_endpoint_is_bulk_out(ep)))
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int xillyusb_setup_base_eps(struct xillyusb_dev *xdev)
>  {
> +	if (xillyusb_check_endpoint(xdev, IN_EP_NUM | USB_DIR_IN) ||
> +		xillyusb_check_endpoint(xdev, MSG_EP_NUM | USB_DIR_OUT))
> +		return -EINVAL;
> +
>  	xdev->msg_ep = endpoint_alloc(xdev, MSG_EP_NUM | USB_DIR_OUT,
>  				      bulk_out_work, 1, 2);
>  	if (!xdev->msg_ep)
> @@ -1963,6 +1987,8 @@ static int setup_channels(struct xillyusb_dev *xdev,
>  			chan->out_log2_element_size = out_desc & 0x0f;
>  			chan->out_log2_fifo_size =
>  				((out_desc >> 8) & 0x1f) + 16;
> +			if (xillyusb_check_endpoint(xdev, (i+2) | USB_DIR_OUT))
> +				return -EINVAL;
>  		}
>  	}
>  
> @@ -2126,6 +2152,7 @@ static int xillyusb_probe(struct usb_interface *interface,
>  	mutex_init(&xdev->process_in_mutex);
>  	mutex_init(&xdev->msg_mutex);
>  
> +	xdev->intf = interface;
>  	xdev->udev = usb_get_dev(interface_to_usbdev(interface));
>  	xdev->dev = &interface->dev;
>  	xdev->error = 0;
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
