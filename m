Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7F2486626
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240192AbiAFOfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:35:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49526 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240103AbiAFOfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:35:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1633761CB5;
        Thu,  6 Jan 2022 14:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3BFC36AE3;
        Thu,  6 Jan 2022 14:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641479730;
        bh=ulwEaw59sG7ePO1RDYpCAz04ZJ1s19bdU4we6iDT9WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mJnOjpkv15USUzRGO+GZ/rjroa/evK3aJ7WheN5Z/SGCTVWnF6MCnaO5W8tROCKPP
         +pbu7KUhF8BRtYVCOCnA2tBUyJ+OecFRxnptmmw7ANugrOBJ7eA7YZAEbffUT/d/CR
         ubLlH2vlCGl2F1syaLNLFDbZDoZc2dmXnfGMbcnA=
Date:   Thu, 6 Jan 2022 15:35:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Ming Chen <jj251510319013@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        balbi@kernel.org, maze@google.com
Subject: Re: [PATCH] usb: gadget: function: Fix returning incorrect PNP string
Message-ID: <Ydb+L+wXfKzXyma9@kroah.com>
References: <20220105040439.3182-1-jj251510319013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105040439.3182-1-jj251510319013@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 12:04:39PM +0800, Wei Ming Chen wrote:
> There will be 2 leading bytes indicating the total length of
> the PNP string, so I think we should add value by 2, otherwise
> the PNP string copied to user will not contain the last 2 bytes
> 
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
> ---
>  drivers/usb/gadget/function/f_printer.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
> index abec5c58f525..3fb00fd0b5ee 100644
> --- a/drivers/usb/gadget/function/f_printer.c
> +++ b/drivers/usb/gadget/function/f_printer.c
> @@ -1005,9 +1005,11 @@ static int printer_func_setup(struct usb_function *f,
>  				break;
>  			}
>  			value = strlen(dev->pnp_string);
> +			memcpy(buf + 2, dev->pnp_string, value);
> +
> +			value += 2;
>  			buf[0] = (value >> 8) & 0xFF;
>  			buf[1] = value & 0xFF;
> -			memcpy(buf + 2, dev->pnp_string, value);
>  			DBG(dev, "1284 PNP String: %x %s\n", value,
>  			    dev->pnp_string);
>  			break;
> -- 
> 2.25.1
> 

Are you sure this is correct?

How is this related to this recent thread:
	https://lore.kernel.org/all/CAKjGFBUdjXcZoVV4jdrgTz4rKThTfZAK4CqreKmBZ4KHE+K1GA@mail.gmail.com/#t

your change is different from what is proposed there, why?

thanks,

greg k-h
