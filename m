Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF65E527143
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiENNcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiENNcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:32:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6611C222A0
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 06:32:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F216360EC3
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 13:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A218C340EE;
        Sat, 14 May 2022 13:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652535150;
        bh=UTOdqW+7dPYVChKZ9Z4lqNcHQlYM7TtsCy0prsvICbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r83wpap6h0Efm1OUpAfvC52f/vIZq2Dan2eG4Dj4uPsawhFYZhagjQYaPbfIYXSA/
         PouD+ww2802yW50/08Szt34zjFUARXLelwxmfcqnE9x+xUr9MlySmfnQPzPx5UUdD1
         QBuMQ21LqdK0KAHhn/Ud6yaeK5MbXZBihRxRSotw=
Date:   Sat, 14 May 2022 15:32:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     eli.billauer@gmail.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] char: xillybus: Check endpoint type before allocing
Message-ID: <Yn+va5fTsuaFTxVR@kroah.com>
References: <Yn9XwHxWsLIJXlHu@kroah.com>
 <20220514114819.2773691-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514114819.2773691-1-zheyuma97@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 07:48:19PM +0800, Zheyu Ma wrote:
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
> Add a check in endpoint_alloc() to fix the bug.
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> Changes in v2:
>     - Check the endpoint type at probe time
> ---
>  drivers/char/xillybus/xillyusb.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
> index dc3551796e5e..4467f13993ef 100644
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
> @@ -475,6 +476,25 @@ static void endpoint_dealloc(struct xillyusb_endpoint *ep)
>  	kfree(ep);
>  }
>  
> +static int xillyusb_check_endpoint(struct xillyusb_dev *xdev, u8 ep_num)
> +{
> +	struct usb_host_interface *if_desc = xdev->intf->altsetting;
> +	int i;
> +
> +	for (i = 0; i < if_desc->desc.bNumEndpoints; i++) {
> +		struct usb_endpoint_descriptor *ep = &if_desc->endpoint[i].desc;
> +
> +		if (ep->bEndpointAddress != ep_num)
> +			continue;
> +
> +		if ((usb_pipein(ep_num) && usb_endpoint_is_bulk_in(ep)) ||
> +			(usb_pipeout(ep_num) && usb_endpoint_is_bulk_out(ep)))
> +			return 0;
> +	}

Why not use the built-in usb core functions that do this for you instead
of hand-parsing this?  Look at usb_find_common_endpoints() and related
functions, that should make this much easier.

thanks,

greg k-h
