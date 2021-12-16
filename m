Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68845476EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbhLPKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:18:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59646 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhLPKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:18:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3930761D2B;
        Thu, 16 Dec 2021 10:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1662FC36AE5;
        Thu, 16 Dec 2021 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639649912;
        bh=4DQoS4PQDS6oHlnDMop0XUh7Wj7wp1o/oZdSSaTVXuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OzijCiPnUUGWWAliOoQuoOP34NpkiliucsyUHsYffy4/QXfE/OTwlIPvsijGqr1mh
         d4ao8VSXcNVhdoIPOBUWQ0SlwO079wR3QqnWAUXRVSRNwuD/52HCxJMR163d+vbgqW
         z/xeg4bGBjMZUVAoAVFXnOtg8bZEF9fxocgC2Hqg=
Date:   Thu, 16 Dec 2021 11:18:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: pch_uart: potential dereference of null pointer
Message-ID: <YbsSdWsQE3BkgmtC@kroah.com>
References: <20211216094408.352500-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216094408.352500-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 05:44:08PM +0800, Jiasheng Jiang wrote:
> The return value of dma_alloc_coherent() needs to be checked.
> To avoid dereference of null pointer in case of the failure of alloc.
> 
> Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/tty/serial/pch_uart.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index f0351e6f0ef6..2ee1c4d6f177 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -745,6 +745,12 @@ static void pch_request_dma(struct uart_port *port)
>  	/* Get Consistent memory for DMA */
>  	priv->rx_buf_virt = dma_alloc_coherent(port->dev, port->fifosize,
>  				    &priv->rx_buf_dma, GFP_KERNEL);
> +	if (!priv->rx_buf_virt) {
> +		dma_release_channel(priv->chan_tx);
> +		priv->chan_tx = NULL;
> +		return;

You are not returning an error, what happens when this buffer is later
attempted to be used?

How did you test this change?

thanks,

greg k-h
