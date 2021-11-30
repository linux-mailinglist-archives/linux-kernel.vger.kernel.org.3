Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2396D463129
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhK3Kkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:40:31 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34878 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhK3Kk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:40:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F4097CE186D;
        Tue, 30 Nov 2021 10:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0FDC53FC1;
        Tue, 30 Nov 2021 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638268627;
        bh=B1f1qFBORy7uax4+Rx0SsEvUYRnj1q+Nmg/DTw1kfaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DgMWXjD7iEmVExrWZ2kf3Xw8agYY9Q7RCL054d7aN8JBtgULP6lWwvYz8ydyvDLjj
         70whZ390KRhAxCLkXG36t8Jfku+mwfLa/lhhcW/UpRNxMF1UXCh4XXkq9pAmdFDyy3
         zAzCY/o50SKcjrt9FZYcHW1xI6LuoRvdxTDJ2lve5eagB2m1OzPqzE9hjTctR7h4jP
         wEc2gacZlBJqHNhQwiW+/Izk6KLaEkSpE2/bUUAXGe3MQ1O/hPPrIMLj/+ZoCOuZoZ
         ex+1vQFgpBZKN5R41/wlGB78cFNDwaTXsCnQSpBM12sgjRfJQpEOIWnX8IvHL33fz+
         2595dFAX4+wYg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ms0VA-0006aN-MN; Tue, 30 Nov 2021 11:36:44 +0100
Date:   Tue, 30 Nov 2021 11:36:44 +0100
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
Subject: Re: [PATCH 3/7] serial: 8250_port: properly handle runtime PM in IRQ
Message-ID: <YaX+vNpQ0ZwjxEyN@hovoldconsulting.com>
References: <20211115084203.56478-1-tony@atomide.com>
 <20211115084203.56478-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115084203.56478-4-tony@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:41:59AM +0200, Tony Lindgren wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> We can't and basically don't need to call runtime PM in IRQ handler. If
> IRQ is ours, device must be powered on. Otherwise check if the device is
> powered off and return immediately.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> [tony@atomide.com: use port->runtime_suspended]
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1939,17 +1939,19 @@ EXPORT_SYMBOL_GPL(serial8250_handle_irq);
>  
>  static int serial8250_default_handle_irq(struct uart_port *port)
>  {
> -	struct uart_8250_port *up = up_to_u8250p(port);
>  	unsigned int iir;
> -	int ret;
>  
> -	serial8250_rpm_get(up);
> +	/*
> +	 * The IRQ might be shared with other peripherals so we must first
> +	 * check that are we RPM suspended or not. If we are we assume that
> +	 * the IRQ was not for us (we shouldn't be RPM suspended when the
> +	 * interrupt is enabled).
> +	 */
> +	if (port->runtime_suspended)
> +		return 0;

This function is called without holding the port lock that protects
this flag.

Also what prevents the device from being suspended after checking it?

Note that this handler is called from a timer callback when polling and
that case needs to be considered too.

>  
>  	iir = serial_port_in(port, UART_IIR);
> -	ret = serial8250_handle_irq(port, iir);
> -
> -	serial8250_rpm_put(up);
> -	return ret;
> +	return serial8250_handle_irq(port, iir);
>  }
>  
>  /*

Johan
