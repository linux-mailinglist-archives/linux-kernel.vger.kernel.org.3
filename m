Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C83C463181
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbhK3KvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:51:04 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38588 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbhK3KvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:51:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 52B68CE189B;
        Tue, 30 Nov 2021 10:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C51AC53FC1;
        Tue, 30 Nov 2021 10:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638269259;
        bh=Iz+w3i4CcMBGzfiS3z5i9lV9fdtABytE0ZRUKvT6d90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V0NMU0/JMdqWxjxpv0W7Ryf1hQ836qBt7Ny1ypT9hSr9sOKqhCcEwExAUftvAjHPL
         6p/cSec3sjBwjdOOotLXEoOsd0RQFKSMJn5U4CcmW57kX7CgABZXAMhyj5lzORgK1c
         oSHTB0MQ06m/rvpQp5L/rkZ7kM8kK2ZhQvTFX/p8IdMDWhtwxq1+d2+R66QRrtqSyz
         kd2wz8BXW9dBePQdTqHmyxW3u5rluFDCP6lZq7OfcSGa24UUOVFu+/jqMLc1BNw0L0
         ovfM4IYbJBybMAejgG4c/4fLIbyF5OPEewlKHphiy9yCcazUAk08uLjPacN7FBAQgf
         waTAatYRcmTUw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ms0fM-0006f6-Hk; Tue, 30 Nov 2021 11:47:16 +0100
Date:   Tue, 30 Nov 2021 11:47:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 7/7] serial: 8250_port: Remove calls to runtime PM
Message-ID: <YaYBNIGwOkHts6wn@hovoldconsulting.com>
References: <20211115084203.56478-1-tony@atomide.com>
 <20211115084203.56478-8-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115084203.56478-8-tony@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:42:03AM +0200, Tony Lindgren wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Since we now have runtime PM calls in serial_core.c the individual
> drivers do not need them anymore for the struct uart_ops related
> functions.
> 
> Remove runtime PM calls in 8250 driver. This still leaves the flag for
> UART_CAP_RPM for serial8250_rpm_get_tx(), serial8250_rpm_put_tx() and
> serial8250_wakeup() to manage the reference count for serial TX.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> [tony@atomide.com: updated to remove the exported functions too]
> Signed-off-by: Tony Lindgren <tony@atomide.com>

> @@ -1477,8 +1459,11 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
>  			stop_tx_timer);
>  	struct uart_8250_port *p = em485->port;
>  	unsigned long flags;
> +	int err;
>  
> -	serial8250_rpm_get(p);
> +	err = pm_runtime_resume_and_get(p->port.dev);

This also won't work as this function is called on timer expiry; you
cannot do a synchronous resume here.

> +	if (err < 0)
> +		goto out_rpm_err;
>  	spin_lock_irqsave(&p->port.lock, flags);
>  	if (em485->active_timer == &em485->stop_tx_timer) {
>  		p->rs485_stop_tx(p);
> @@ -1486,8 +1471,9 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
>  		em485->tx_stopped = true;
>  	}
>  	spin_unlock_irqrestore(&p->port.lock, flags);
> -	serial8250_rpm_put(p);
> -
> +	pm_runtime_mark_last_busy(p->port.dev);
> +	pm_runtime_put_autosuspend(p->port.dev);
> +out_rpm_err:
>  	return HRTIMER_NORESTART;
>  }
  
>  void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
> @@ -1984,15 +1966,11 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
>  	unsigned long flags;
>  	unsigned int lsr;
>  
> -	serial8250_rpm_get(up);
> -
>  	spin_lock_irqsave(&port->lock, flags);
>  	lsr = serial_port_in(port, UART_LSR);
>  	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
>  	spin_unlock_irqrestore(&port->lock, flags);
>  
> -	serial8250_rpm_put(up);
> -
>  	return (lsr & BOTH_EMPTY) == BOTH_EMPTY ? TIOCSER_TEMT : 0;
>  }

As I mentioned elsewhere, the corresponding get+put is missing in serial
core now.

>  static void serial8250_put_poll_char(struct uart_port *port,
>  			 unsigned char c)
>  {
>  	unsigned int ier;
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  
> -	serial8250_rpm_get(up);
>  	/*
>  	 *	First save the IER then disable the interrupts
>  	 */
> @@ -2155,7 +2117,6 @@ static void serial8250_put_poll_char(struct uart_port *port,
>  	 */
>  	wait_for_xmitr(up, BOTH_EMPTY);
>  	serial_port_out(port, UART_IER, ier);
> -	serial8250_rpm_put(up);
>  }

And this is a console callback; where is it guaranteed that the console
is never suspended?

Johan
