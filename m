Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF9F4B649C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbiBOHqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:46:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiBOHqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:46:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B258A107DBD;
        Mon, 14 Feb 2022 23:46:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 189A0B80E70;
        Tue, 15 Feb 2022 07:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE8EC340EC;
        Tue, 15 Feb 2022 07:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644911166;
        bh=3lB9kUJK8jxkLP3rCA6Ubvf8NJBzKM22raR92qKTb/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZ9GS4jrDWdg/MMzlceTdBPLLQ8sJQojB5NiM7B2LKAacCoxsnX/ByWyu4doEst0F
         z0NA2B29/k/O9GoagQtITR9jTgXqvTB9RCdWlithxAj2sejbQRNv4/jwtEEgOaVNuc
         OwkNikfdjuNXCPbyFin6x/H6xzY7Wr9Bw0JOoANE=
Date:   Tue, 15 Feb 2022 08:46:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: serial: add missing pci_dev_put() before return
Message-ID: <YgtaO0aSNLW0dVFZ@kroah.com>
References: <1644890472-65306-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644890472-65306-1-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 06:01:12PM -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
> 
> pci_get_slot() increases its reference count, the caller must
> decrement the reference count by calling pci_dev_put()
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/tty/serial/pch_uart.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index f0351e6..da5a276
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -723,7 +723,7 @@ static void pch_request_dma(struct uart_port *port)
>  	if (!chan) {
>  		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Tx)\n",
>  			__func__);
> -		return;
> +		goto out;
>  	}
>  	priv->chan_tx = chan;
>  
> @@ -739,13 +739,16 @@ static void pch_request_dma(struct uart_port *port)
>  			__func__);
>  		dma_release_channel(priv->chan_tx);
>  		priv->chan_tx = NULL;
> -		return;
> +		goto out;
>  	}
>  
>  	/* Get Consistent memory for DMA */
>  	priv->rx_buf_virt = dma_alloc_coherent(port->dev, port->fifosize,
>  				    &priv->rx_buf_dma, GFP_KERNEL);
>  	priv->chan_rx = chan;
> +
> +out:
> +	pci_dev_put(dma_dev);
>  }
>  
>  static void pch_dma_rx_complete(void *arg)
> -- 
> 2.7.4
> 

What tool are you using to find these?  As Jiri points out, it is not
very correct at all, be careful to not cause bugs when you are
attempting to fix them.

For stuff like this, please always test your changes to verify they
work.

thanks,

greg k-h
