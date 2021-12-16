Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBCD4772E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbhLPNPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbhLPNPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:15:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8660C06173E;
        Thu, 16 Dec 2021 05:15:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 563EB61DD7;
        Thu, 16 Dec 2021 13:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630D9C36AE0;
        Thu, 16 Dec 2021 13:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639660516;
        bh=J9PKFrc+fybZ1tY7fMQZtcBddbuRGRoJPDdp+qbRjm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dVCHWw84RJcwj2KSl9Ty9Xq6sOC3IAVQOan9MapGvPvcOSOBjFrgt9Gguio1pghF8
         hF9gTdIkGE85PrbLtM4rOhFSLIplIbT+kkCFCJbXRZ1ajIy9CCk77fb1ysZbkEiQW7
         JAxjbZP7XM0ur7RYHLyOonXCPQRmwCYg/OHJaH98=
Date:   Thu, 16 Dec 2021 14:15:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: pch_uart: potential dereference of null
 pointer
Message-ID: <Ybs74r4fjDudyJ4C@kroah.com>
References: <20211216125121.399938-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216125121.399938-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:51:21PM +0800, Jiasheng Jiang wrote:
> The return value of dma_alloc_coherent() needs to be checked.
> To avoid dereference of null pointer in case of the failure of alloc.
> 
> Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")

That is not the commit that caused the problem :(

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v1 -> v2
> 
> *Change 1. Add the dev_err when dma_alloc_coherent failed.
> ---
>  drivers/tty/serial/pch_uart.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index f0351e6f0ef6..d19ed7da24fa 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -745,6 +745,14 @@ static void pch_request_dma(struct uart_port *port)
>  	/* Get Consistent memory for DMA */
>  	priv->rx_buf_virt = dma_alloc_coherent(port->dev, port->fifosize,
>  				    &priv->rx_buf_dma, GFP_KERNEL);
> +	if (!priv->rx_buf_virt) {
> +		dev_err(priv->port.dev, "%s:dma_alloc_coherent FAILS(Rx)\n",
> +			__func__);
> +		dma_release_channel(priv->chan_tx);
> +		priv->chan_tx = NULL;
> +		return;

You seemed to have ignored my previous review comments on this change
for some reason :(

This is not correct.

greg k-h
