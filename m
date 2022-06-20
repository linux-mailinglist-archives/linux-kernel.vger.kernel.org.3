Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB934551BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345751AbiFTNbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346757AbiFTN3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:29:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079D3248F3;
        Mon, 20 Jun 2022 06:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C0EF5CE139F;
        Mon, 20 Jun 2022 13:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC825C3411C;
        Mon, 20 Jun 2022 13:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730653;
        bh=SHVwJLEk2tnmicNGaRD3YPQJdxFUin99Ol3gEng/YzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzBJYmasWqnspP8jyZlLQwdZh+WpKwfIQaHEJQohLSkOnCxyJTrIni3XGZkn2x7Yl
         zRqmC7/woIw1ThSGqggImr1d7rRVupXKZAe/RnXH5lbzMkGQtVPE/bsNoGL6DwZ4t2
         okIXjHqB3novCwABI2il9fXgs1Ks7ai4feFwpW80Buumn0nkFY0vKXoBSaLAgno6PD
         NhnAsvAZPb8XJd3km+w/ZY7YJFo9pRk9A4dIzQdjfQbX9DN9ypUoAokdEG72ENz0PX
         XAxd0W/qEtTJoI1+zr+Do3FQARkLuecRexLZJjn522xf575e3CmZFTz7KBuyBpqDId
         lL1j9CENZP/jw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3HB3-0000z6-3O; Mon, 20 Jun 2022 15:10:49 +0200
Date:   Mon, 20 Jun 2022 15:10:49 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: use kmemdup instead of kmalloc + memcpy
Message-ID: <YrBx2eQYwiGcDC8m@hovoldconsulting.com>
References: <20220620105939.5128-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620105939.5128-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 06:59:39PM +0800, Slark Xiao wrote:
> For code neat purpose, we can use kmemdup to replace
> kmalloc + memcpy.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/usb/serial/opticon.c | 4 +---
>  drivers/usb/serial/sierra.c  | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/serial/opticon.c b/drivers/usb/serial/opticon.c
> index aed28c35caff..bca6766a63e6 100644
> --- a/drivers/usb/serial/opticon.c
> +++ b/drivers/usb/serial/opticon.c
> @@ -208,7 +208,7 @@ static int opticon_write(struct tty_struct *tty, struct usb_serial_port *port,
>  	priv->outstanding_bytes += count;
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
> -	buffer = kmalloc(count, GFP_ATOMIC);
> +	buffer = kmemdup(buf, count, GFP_ATOMIC);
>  	if (!buffer)
>  		goto error_no_buffer;
>  
> @@ -216,8 +216,6 @@ static int opticon_write(struct tty_struct *tty, struct usb_serial_port *port,
>  	if (!urb)
>  		goto error_no_urb;
>  
> -	memcpy(buffer, buf, count);
> -
>  	usb_serial_debug_data(&port->dev, __func__, count, buffer);
>  
>  	/* The connected devices do not have a bulk write endpoint,

Looks like we have the same pattern also in garmin_write_bulk(). Care to
include that one as well?

Johan
