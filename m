Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C5C46E361
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhLIHm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:42:27 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34154 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbhLIHmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:42:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C03C9CE1FD9;
        Thu,  9 Dec 2021 07:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BAFC004DD;
        Thu,  9 Dec 2021 07:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639035523;
        bh=QyCFo4sEPt8ckkvZYpCfF4KeiGBmMnelIdnnz6gFQbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxXthkSVQWnJi/DSEkmbQsOtVhNm4+bE4ifvfbXI6SRh2VB9lb1DUYdGGDA+O/jwo
         doUercz6uvgEg43T059XW6R5mvSlMjR6Z+Do9iaZ+52vXmpP73x28wh1++amFFONl3
         5g/t+v+UT1AhYDIbTTU1otZfGBK6Qr9rJp+213yQ=
Date:   Thu, 9 Dec 2021 08:38:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "wigin.zeng" <wigin.zeng@dji.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: add lock for dma rx
Message-ID: <YbGygPtkz6ihyW51@kroah.com>
References: <20211209073339.21694-1-wigin.zeng@dji.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209073339.21694-1-wigin.zeng@dji.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 03:33:39PM +0800, wigin.zeng wrote:
> Need to add lock to protect the tty buffer in dma rx handler and serial
> interrupt handler, there is chance that serial handler and dma handler
> executing in same time in multi cores and RT enabled scenario.

Are you sure?  Why has this not been a problem before now?  What
changed?

> Signed-off-by: wigin.zeng <wigin.zeng@dji.com>

I do not think you have a "." in the name you use to sign documents,
right?  Please use your real name here.


> ---
>  drivers/tty/serial/8250/8250_dma.c  | 2 ++
>  drivers/tty/serial/8250/8250_port.c | 3 +++
>  include/linux/serial_core.h         | 1 +
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index 890fa7ddaa7f..592b9906e276 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -48,6 +48,7 @@ static void __dma_rx_complete(void *param)
>         struct dma_tx_state     state;
>         int                     count;
> 
> +       spin_lock(&p->port.rx_lock);
>         dma->rx_running = 0;
>         dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> 
> @@ -55,6 +56,7 @@ static void __dma_rx_complete(void *param)
> 
>         tty_insert_flip_string(tty_port, dma->rx_buf, count);
>         p->port.icount.rx += count;
> +       spin_unlock(&p->port.rx_lock);
> 
>         tty_flip_buffer_push(tty_port);
>  }
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 5775cbff8f6e..4d8662df8d61 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1780,6 +1780,7 @@ unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
>         struct uart_port *port = &up->port;
>         int max_count = 256;
> 
> +       spin_lock(&port->rx_lock);
>         do {
>                 serial8250_read_char(up, lsr);
>                 if (--max_count == 0)
> @@ -1787,6 +1788,7 @@ unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
>                 lsr = serial_in(up, UART_LSR);
>         } while (lsr & (UART_LSR_DR | UART_LSR_BI));
> 
> +       spin_unlock(&port->rx_lock);
>         tty_flip_buffer_push(&port->state->port);
>         return lsr;
>  }
> @@ -3267,6 +3269,7 @@ void serial8250_init_port(struct uart_8250_port *up)
>         struct uart_port *port = &up->port;
> 
>         spin_lock_init(&port->lock);
> +       spin_lock_init(&port->rx_lock);
>         port->ops = &serial8250_pops;
>         port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
> 
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index c58cc142d23f..77980b6f0c27 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -105,6 +105,7 @@ typedef unsigned int __bitwise upstat_t;
> 
>  struct uart_port {
>         spinlock_t              lock;                   /* port lock */
> +       spinlock_t              rx_lock;                /* port rx lock */

Why can you not just use 'lock' here instead if this is really an issue?

And doesn't this slow things down?

thanks,

greg k-h
