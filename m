Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CBB53FF64
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244203AbiFGMse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244205AbiFGMsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:48:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021731D331
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:48:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A076B81F6F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624B9C385A5;
        Tue,  7 Jun 2022 12:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654606097;
        bh=mtxqza0gI9LzuBdAaUvRx2Y1GByfp78MN6I6ID87xUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zHqwtQR4GRvIUM8GjKkTmWoLj/so+ZFC8V3/9nC7YpOHbbXu8wrzqt4HmbEtIMz8q
         h65SBD5a3WPhnI9HhIj74fkFGXxgX2vNJiaKR8ZM3wcgaMIeydyKlldWJZFkJ3KOtp
         nJGTgiv+x5Y+o7oCDz0rUn/dEfYp37Utz17+W/o0=
Date:   Tue, 7 Jun 2022 14:48:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] comedi: ni_usb6501: fix transfer-buffer overflows
Message-ID: <Yp9JDrF/VEhjI4SC@kroah.com>
References: <20220607111802.13311-1-xiaohuizhang@ruc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607111802.13311-1-xiaohuizhang@ruc.edu.cn>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 07:18:02PM +0800, Xiaohui Zhang wrote:
> Similar to the handling of vmk80xx_alloc_usb_buffers in commit
> a23461c47482("comedi: vmk80xx: fix transfer-buffer overflows"),
> we thought a patch might be needed here as well.
> 
> The driver uses endpoint-sized USB transfer buffers but up until
> recently had no sanity checks on the sizes.
> 
> Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
> ---
>  drivers/comedi/drivers/ni_usb6501.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/ni_usb6501.c b/drivers/comedi/drivers/ni_usb6501.c
> index 0dd9edf7bced..8303bfc305c5 100644
> --- a/drivers/comedi/drivers/ni_usb6501.c
> +++ b/drivers/comedi/drivers/ni_usb6501.c
> @@ -90,6 +90,7 @@
>  #include <linux/comedi/comedi_usb.h>
>  
>  #define	NI6501_TIMEOUT	1000
> +#define MIN_BUF_SIZE	64
>  
>  /* Port request packets */
>  static const u8 READ_PORT_REQUEST[]	= {0x00, 0x01, 0x00, 0x10,
> @@ -459,12 +460,12 @@ static int ni6501_alloc_usb_buffers(struct comedi_device *dev)
>  	struct ni6501_private *devpriv = dev->private;
>  	size_t size;
>  
> -	size = usb_endpoint_maxp(devpriv->ep_rx);
> +	size = max(usb_endpoint_maxp(devpriv->ep_rx), MIN_BUF_SIZE);
>  	devpriv->usb_rx_buf = kzalloc(size, GFP_KERNEL);
>  	if (!devpriv->usb_rx_buf)
>  		return -ENOMEM;
>  
> -	size = usb_endpoint_maxp(devpriv->ep_tx);
> +	size = max(usb_endpoint_maxp(devpriv->ep_tx), MIN_BUF_SIZE);
>  	devpriv->usb_tx_buf = kzalloc(size, GFP_KERNEL);
>  	if (!devpriv->usb_tx_buf)
>  		return -ENOMEM;
> -- 
> 2.17.1
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

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
