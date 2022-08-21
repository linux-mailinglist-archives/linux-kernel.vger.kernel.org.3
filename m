Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E4359B2CD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiHUIi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUIiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:38:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47883F58D;
        Sun, 21 Aug 2022 01:38:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E43C9B80BE6;
        Sun, 21 Aug 2022 08:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1371C433D6;
        Sun, 21 Aug 2022 08:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661071097;
        bh=/i9xhhHHCAGEdB3uY5EaZywWa6oF8BJzTlDLagzbrUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DM7YoaitJm/2CG7vehv8E9dzVejdQvoMCelzF+o92IqpaGHuFBbhTHUr2rTR57RiR
         2qOHVK0bMZA4+2QSZ0yklfNnUnFwirXBpeAaNqsaEormk32cOcEZYVTu9aIRXNgYBf
         VnWQMVufZ9arK8BSzrlYufKxBgddu+PlGjAY12oE=
Date:   Sun, 21 Aug 2022 10:38:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V2] tty: serial: lpuart: disable flow control while
 waiting for the transmit engine to complete
Message-ID: <YwHvAsOmMaa6rmm0@kroah.com>
References: <20220804070420.32186-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804070420.32186-1-sherry.sun@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 03:04:20PM +0800, Sherry Sun wrote:
> When the user initializes the uart port, and waits for the transmit
> engine to complete in lpuart32_set_termios(), if the UART TX fifo has
> dirty data and the UARTMODIR enable the flow control, the TX fifo may
> never be empty. So here we should disable the flow control first to make
> sure the transmit engin can complete.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
> Changes in V2:
> 1. Rephrase the commit log as suggested by Jiri.
> ---
>  drivers/tty/serial/fsl_lpuart.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index fc7d235a1e27..f0fccd2ff7ac 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2172,6 +2172,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
>  	uart_update_timeout(port, termios->c_cflag, baud);
>  
>  	/* wait transmit engin complete */
> +	lpuart32_write(&sport->port, 0, UARTMODIR);
>  	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
>  
>  	/* disable transmit and receive */
> -- 
> 2.17.1

What commit id does this fix?  Should it be backported to older stable
kernels?

thanks,

greg k-h
