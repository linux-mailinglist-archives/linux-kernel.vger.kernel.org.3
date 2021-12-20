Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7FB47B06E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhLTPiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:38:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39610 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhLTPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:38:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5602C6120B;
        Mon, 20 Dec 2021 15:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E8BC36AE8;
        Mon, 20 Dec 2021 15:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640014680;
        bh=Mi2oDzNFK4OW/+LbhQ7Lp2q28SlQE9TbUmYOWSv2Rw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIRJq8Sovx4hb5vC5VINd9mGwalS9pjiGG4mOVTyl9jKn2A8Phe48TA7X48lZQluy
         ax+99u+gTVy+RfJAp8lyp+ztrqoUA99nGL/H0iNLuiXhi6ilf6K/lXBFY4f8psCeNM
         1C82LXjIjkVhcrYooilJ64xaagAVRFOPe9AwZt64=
Date:   Mon, 20 Dec 2021 16:37:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] serial: pch_uart: potential dereference of null
 pointer
Message-ID: <YcCjVpm9kC06kLbG@kroah.com>
References: <20211216141454.423333-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216141454.423333-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 10:14:54PM +0800, Jiasheng Jiang wrote:
> The return value of dma_alloc_coherent() needs to be checked.
> To avoid dereference of null pointer in case of the failure of alloc.
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v2 -> v3
> 
> *Change 1. Remove dev_err.
> *Change 2. Change the return type of pch_request_dma to int.
> *Change 3. Return -ENOMEM when dma_alloc_coherent() failed and 0 the
> others.
> *Change 4. Check return value of dma_alloc_coherent().
> ---
>  drivers/tty/serial/pch_uart.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index f0351e6f0ef6..cfad5592010c 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -698,7 +698,7 @@ static bool filter(struct dma_chan *chan, void *slave)
>  	}
>  }
>  
> -static void pch_request_dma(struct uart_port *port)
> +static int pch_request_dma(struct uart_port *port)
>  {
>  	dma_cap_mask_t mask;
>  	struct dma_chan *chan;
> @@ -723,7 +723,7 @@ static void pch_request_dma(struct uart_port *port)
>  	if (!chan) {
>  		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Tx)\n",
>  			__func__);
> -		return;
> +		return 0;
>  	}
>  	priv->chan_tx = chan;
>  
> @@ -739,13 +739,20 @@ static void pch_request_dma(struct uart_port *port)
>  			__func__);
>  		dma_release_channel(priv->chan_tx);
>  		priv->chan_tx = NULL;
> -		return;
> +		return 0;
>  	}
>  
>  	/* Get Consistent memory for DMA */
>  	priv->rx_buf_virt = dma_alloc_coherent(port->dev, port->fifosize,
>  				    &priv->rx_buf_dma, GFP_KERNEL);
> +	if (!priv->rx_buf_virt) {
> +		dma_release_channel(priv->chan_tx);
> +		priv->chan_tx = NULL;
> +		return -ENOMEM;
> +	}
> +
>  	priv->chan_rx = chan;
> +	return 0;
>  }
>  
>  static void pch_dma_rx_complete(void *arg)
> @@ -1321,8 +1328,11 @@ static int pch_uart_startup(struct uart_port *port)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (priv->use_dma)
> -		pch_request_dma(port);
> +	if (priv->use_dma) {
> +		ret = pch_request_dma(port);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	priv->start_rx = 1;
>  	pch_uart_hal_enable_interrupt(priv, PCH_UART_HAL_RX_INT |
> @@ -1469,6 +1479,7 @@ static int pch_uart_verify_port(struct uart_port *port,
>  				struct serial_struct *serinfo)
>  {
>  	struct eg20t_port *priv;
> +	int ret;
>  
>  	priv = container_of(port, struct eg20t_port, port);
>  	if (serinfo->flags & UPF_LOW_LATENCY) {
> @@ -1483,7 +1494,9 @@ static int pch_uart_verify_port(struct uart_port *port,
>  		return -EOPNOTSUPP;
>  #endif
>  		if (!priv->use_dma) {
> -			pch_request_dma(port);
> +			ret = pch_request_dma(port);
> +			if (ret)
> +				return ret;
>  			if (priv->chan_rx)
>  				priv->use_dma = 1;
>  		}
> -- 
> 2.25.1
> 

This patch is obviously not correct, and will cause problems if it were
accepted.

Please work on whatever tool you are using to find and make these
changes, as it is not working properly.

Or, if this was a manual change, please work on your kernel programming
skills.  There are a number of bugs in this proposed change, showing
that it was not tested at all.

thanks,

greg k-h
