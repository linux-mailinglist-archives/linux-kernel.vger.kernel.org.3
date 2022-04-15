Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334D05025B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350559AbiDOGoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbiDOGoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:44:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D8AFADD;
        Thu, 14 Apr 2022 23:41:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8867AB82BF0;
        Fri, 15 Apr 2022 06:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA977C385A5;
        Fri, 15 Apr 2022 06:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650004890;
        bh=+L/HFWzltw7KDYz0FALc3guFX9clLm9cFM07Zin4qws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U2xoJV98ppVR4dwd0IrPUHQTzHUazzXZ+C+DgBpQQR75KPLW4WYFNd6JDZEL6JCBc
         w2nWV1/4a5WEGt99YbBCAtfxzoyk6NScThAh/KJNUtF5wp7GUw4Xa/uFGbluJTO1IG
         Xsxs6pLSdShzdF+FyDC66IJsu1Ft7gBf1C/pPWGo=
Date:   Fri, 15 Apr 2022 08:41:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kartik <kkartik@nvidia.com>
Cc:     ldewangan@nvidia.com, jirislaby@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] serial: tegra: Correct error handling sequence
Message-ID: <YlkTl/hyNDr9Nlwj@kroah.com>
References: <1648112644-16950-1-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648112644-16950-1-git-send-email-kkartik@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 02:34:04PM +0530, Kartik wrote:
> From: kartik <kkartik@nvidia.com>
> 
> In the current error handling sequence the driver checks for break
> error at the end.
> 
> By handling the break error first, we can avoid a situation where the
> driver keeps processing the errors which can be caused by an unhandled
> break error.
> 
> Signed-off-by: kartik <kkartik@nvidia.com>

I need a full, legal name that you use to sign documents with.  Is that
this name?

> ---
>  drivers/tty/serial/serial-tegra.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> index b6223fa..ba78a02 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -440,7 +440,19 @@ static char tegra_uart_decode_rx_error(struct tegra_uart_port *tup,
>  	char flag = TTY_NORMAL;
>  
>  	if (unlikely(lsr & TEGRA_UART_LSR_ANY)) {
> -		if (lsr & UART_LSR_OE) {
> +		if (lsr & UART_LSR_BI) {
> +			/*
> +			 * Break error
> +			 * If FIFO read error without any data, reset Rx FIFO
> +			 */
> +			if (!(lsr & UART_LSR_DR) && (lsr & UART_LSR_FIFOE))
> +				tegra_uart_fifo_reset(tup, UART_FCR_CLEAR_RCVR);
> +			if (tup->uport.ignore_status_mask & UART_LSR_BI)
> +				return TTY_BREAK;
> +			flag = TTY_BREAK;
> +			tup->uport.icount.brk++;
> +			dev_dbg(tup->uport.dev, "Got Break\n");
> +		} else if (lsr & UART_LSR_OE) {
>  			/* Overrrun error */
>  			flag = TTY_OVERRUN;
>  			tup->uport.icount.overrun++;
> @@ -454,18 +466,6 @@ static char tegra_uart_decode_rx_error(struct tegra_uart_port *tup,
>  			flag = TTY_FRAME;
>  			tup->uport.icount.frame++;
>  			dev_dbg(tup->uport.dev, "Got frame errors\n");
> -		} else if (lsr & UART_LSR_BI) {
> -			/*
> -			 * Break error
> -			 * If FIFO read error without any data, reset Rx FIFO
> -			 */
> -			if (!(lsr & UART_LSR_DR) && (lsr & UART_LSR_FIFOE))
> -				tegra_uart_fifo_reset(tup, UART_FCR_CLEAR_RCVR);
> -			if (tup->uport.ignore_status_mask & UART_LSR_BI)
> -				return TTY_BREAK;
> -			flag = TTY_BREAK;
> -			tup->uport.icount.brk++;
> -			dev_dbg(tup->uport.dev, "Got Break\n");
>  		}
>  		uart_insert_char(&tup->uport, lsr, UART_LSR_OE, 0, flag);
>  	}

What commit does this fix?

thanks,

greg k-h
