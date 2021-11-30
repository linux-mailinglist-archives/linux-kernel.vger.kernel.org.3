Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA44463133
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhK3KmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbhK3KmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:42:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F389BC061574;
        Tue, 30 Nov 2021 02:39:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4913CCE1752;
        Tue, 30 Nov 2021 10:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EFDC53FC7;
        Tue, 30 Nov 2021 10:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638268742;
        bh=n9VZFQW/7cRZOY70E/3nx7k7yi+6DwZbdEu6eunwWjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQbINpie0p6R2XUP16lWfoN2Yojq8ZBuTmR33AIVmdgj2SmGP14CvMBE9YYiYd9RN
         URyok+ZJsqGWmUIM19YZ4p3snyKOdrL9c9iYj4Un752CCChOb0QdBQLTidfQ/5p004
         9uSgh4cWspv4Rn3gOoio0HEEyWmeqj1Aj79TDbDZeyqcUT4/p5tmGHV6kaDynqID5/
         /Ofll2fHeeXtqBraGbLfrd2WvsIIxnfmHpLwDcI+JRyfd9dlqG+wxWzuyOqjFPxqV9
         5tGf3oeKhUKGsdUlTCAZgG+88lCBEBw4XVCOJ3kfwq2tNU3x5/aF/T3Z6DvFuzB2rs
         PPWI8G9xAs+Pg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ms0X1-0006bR-PT; Tue, 30 Nov 2021 11:38:39 +0100
Date:   Tue, 30 Nov 2021 11:38:39 +0100
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
Subject: Re: [PATCH 4/7] serial: 8250: Implement wakeup for TX and use it for
 8250_omap
Message-ID: <YaX/L6n0vzrjLaoF@hovoldconsulting.com>
References: <20211115084203.56478-1-tony@atomide.com>
 <20211115084203.56478-5-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115084203.56478-5-tony@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:42:00AM +0200, Tony Lindgren wrote:
> We can use the wakeup() and uart_start_pending_tx() calls to wake up an
> idle serial port and send out the pending TX buffer on runtime PM resume.
> This allows us to remove the dependency to pm_runtime_irq_safe() for
> 8250_omap driver in the following patches.
> 
> We manage the port runtime_suspended flag in the serial port driver as
> only the driver knows when the hardware is runtime PM suspended. Note that
> The current flag for rpm_tx_active cannot be used as it is TX specific
> for 8250_port.
> 
> We already have serial8250_start_tx() call serial8250_rpm_get_tx(), and
> serial8250_stop_tx() call serial8250_rpm_put_tx() to take care of the
> runtime PM usage count for TX. To have the serial port driver call
> uart_start_pending_tx() on runtime resume, we must now use just
> pm_runtime_get() for serial8250_start_tx() instead of the sync version.
> 
> With these changes we must now also flip the 8250_omap driver over to
> call uart_start_pending_tx(). That's currently the only user of
> UART_CAP_RPM.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 19 ++++++++++++++
>  drivers/tty/serial/8250/8250_port.c | 39 ++++++++++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1593,12 +1593,16 @@ static int omap8250_runtime_suspend(struct device *dev)
>  {
>  	struct omap8250_priv *priv = dev_get_drvdata(dev);
>  	struct uart_8250_port *up;
> +	struct uart_port *port;
> +	unsigned long flags;
>  
>  	/* In case runtime-pm tries this before we are setup */
>  	if (!priv)
>  		return 0;
>  
>  	up = serial8250_get_port(priv->line);
> +	port = &up->port;
> +
>  	/*
>  	 * When using 'no_console_suspend', the console UART must not be
>  	 * suspended. Since driver suspend is managed by runtime suspend,
> @@ -1610,6 +1614,10 @@ static int omap8250_runtime_suspend(struct device *dev)
>  			return -EBUSY;
>  	}
>  
> +	spin_lock_irqsave(&port->lock, flags);
> +	port->runtime_suspended = 1;
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
>  	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
>  		int ret;
>  
> @@ -1636,13 +1644,18 @@ static int omap8250_runtime_resume(struct device *dev)
>  {
>  	struct omap8250_priv *priv = dev_get_drvdata(dev);
>  	struct uart_8250_port *up;
> +	struct uart_port *port;
> +	unsigned long flags;
>  
>  	/* In case runtime-pm tries this before we are setup */
>  	if (!priv)
>  		return 0;
>  
>  	up = serial8250_get_port(priv->line);
> +	port = &up->port;
>  
> +	/* Restore state with interrupts disabled */
> +	spin_lock_irqsave(&port->lock, flags);
>  	if (omap8250_lost_context(up))
>  		omap8250_restore_regs(up);
>  
> @@ -1651,6 +1664,12 @@ static int omap8250_runtime_resume(struct device *dev)
>  
>  	priv->latency = priv->calc_latency;
>  	schedule_work(&priv->qos_work);
> +
> +	port->runtime_suspended = 0;
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	uart_start_pending_tx(port);
> +
>  	return 0;
>  }
>  #endif
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -724,7 +724,7 @@ void serial8250_rpm_get_tx(struct uart_8250_port *p)
>  	rpm_active = xchg(&p->rpm_tx_active, 1);
>  	if (rpm_active)
>  		return;
> -	pm_runtime_get_sync(p->port.dev);
> +	pm_runtime_get(p->port.dev);
>  }
>  EXPORT_SYMBOL_GPL(serial8250_rpm_get_tx);
>  
> @@ -2509,6 +2509,42 @@ static void serial8250_shutdown(struct uart_port *port)
>  		serial8250_do_shutdown(port);
>  }
>  
> +/*
> + * Wakes up the serial port if it has been runtime PM suspended.
> + *
> + * Note that we rely on the serial8250_rpm functions to manage the
> + * runtime PM usage count. We also currently depend on the runtime
> + * PM autosuspend timeout to keep the port awake until start_tx().
> + * Eventually we should just use runtime PM functions and not rely
> + * on the autosuspend timeout.
> + *
> + * Caller must hold port->lock for port->runtime_suspended status.
> + * Also the port drivers must hold port->lock when changing the
> + * state for port->runtime_suspended in runtime PM functions.
> + */
> +static int serial8250_wakeup(struct uart_port *port)
> +{
> +	struct uart_8250_port *up = up_to_u8250p(port);
> +	struct device *dev = up->port.dev;
> +	int err;
> +
> +	if (!pm_runtime_enabled(dev))
> +		return 0;
> +
> +	if (!port->runtime_suspended) {
> +		pm_runtime_mark_last_busy(dev);
> +		return 0;
> +	}
> +
> +	err = pm_request_resume(dev);
> +	if (err < 0) {
> +		dev_warn(dev, "wakeup failed: %d\n", err);
> +		return err;
> +	}
> +
> +	return -EINPROGRESS;
> +}

Why can't this be done in core?

> +
>  /* Nuvoton NPCM UARTs have a custom divisor calculation */
>  static unsigned int npcm_get_divisor(struct uart_8250_port *up,
>  		unsigned int baud)
> @@ -3237,6 +3273,7 @@ static const struct uart_ops serial8250_pops = {
>  	.break_ctl	= serial8250_break_ctl,
>  	.startup	= serial8250_startup,
>  	.shutdown	= serial8250_shutdown,
> +	.wakeup		= serial8250_wakeup,
>  	.set_termios	= serial8250_set_termios,
>  	.set_ldisc	= serial8250_set_ldisc,
>  	.pm		= serial8250_pm,

Johan
