Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0446311E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhK3KiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:38:18 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34256 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbhK3KiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:38:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 24AFDCE1377;
        Tue, 30 Nov 2021 10:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537DEC53FCB;
        Tue, 30 Nov 2021 10:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638268490;
        bh=u2hYKHt9PlXYet32YOt4WQRn6PDJ/dkWaMmvbt/OdR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r2IpvI9FaW5ebXdfnrETflZYG36K/FnxRkelBmlJvmEiZID+lJSffXcMwmsiSo5ne
         lKkN3mcu8vNuNsrcr0eO4O8oua44wq6KcaQJEd0iVASJYL0upIhn0rLByYbez4AnSs
         6zSCIW374rikSf72lvWANXwEb6WvvhY3LUBVfpLMfflVyOBzNf7rYwrRSllTKNW0o4
         ZWhOKwDPr1v+fpn/Gj+PI3vS9bquVKjiRCFyKAYy5VHa3Wi1FXnVgiS+s+owAfLnI9
         c3ZvQVQbaNH9DMbbpbsEcEY2T+A1U0GLpEHkcEPxe0AnXYqcpVNf3kLR/iOpGvaatY
         LyKMrQfSHMPNg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ms0Sx-0006ZF-3n; Tue, 30 Nov 2021 11:34:27 +0100
Date:   Tue, 30 Nov 2021 11:34:27 +0100
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
Subject: Re: [PATCH 2/7] serial: core: Add wakeup() and start_pending_tx()
 for asynchronous wake
Message-ID: <YaX+M/913at1+wfg@hovoldconsulting.com>
References: <20211115084203.56478-1-tony@atomide.com>
 <20211115084203.56478-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115084203.56478-3-tony@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 10:41:58AM +0200, Tony Lindgren wrote:
> If the serial driver implements PM runtime with autosuspend, the port may
> be powered down on TX. To wake up the port, let's add new wakeup() call
> for serial drivers to implement as needed. We can call wakeup() from
> __uart_start() before attempting to write to the serial port registers.

This needs more detail on the approach taken to handle tx and the issues
involved (e.g. stalled ports etc).

> Let's keep track of the serial port with a new runtime_suspended flag
> that the device driver runtime PM suspend and resume can manage with
> port->lock held. This is because only the device driver knows what the
> device runtime PM state as in Documentation/power/runtime_pm.rst
> under "9. Autosuspend, or automatically-delayed suspend" for locking.
> 
> To allow the serial port drivers to send out pending tx on runtime PM
> resume, let's add start_pending_tx() as suggested by Johan Hovold
> <johan@kernel.org>.
> 
> Suggested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/driver-api/serial/driver.rst |  9 ++++
>  drivers/tty/serial/serial_core.c           | 49 +++++++++++++++++++++-
>  include/linux/serial_core.h                |  3 ++
>  3 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
> --- a/Documentation/driver-api/serial/driver.rst
> +++ b/Documentation/driver-api/serial/driver.rst
> @@ -234,6 +234,15 @@ hardware.
>  
>  	Interrupts: caller dependent.
>  
> +  wakeup(port)
> +	Wake up port if it has been runtime PM suspended.
> +
> +	Locking: port->lock taken.
> +
> +	Interrupts: locally disabled.
> +
> +	This call must not sleep
> +
>    flush_buffer(port)
>  	Flush any write buffers, reset any DMA state and stop any
>  	ongoing DMA transfers.
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -107,12 +107,35 @@ static int serial_pm_resume_and_get(struct device *dev)
>  	return pm_runtime_resume_and_get(dev);
>  }
>  
> +/* Only increments the runtime PM usage count */
> +static void serial_pm_get_noresume(struct device *dev)
> +{
> +	pm_runtime_get_noresume(dev);
> +}
> +
>  static void serial_pm_autosuspend(struct device *dev)
>  {
>  	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
>  }
>  
> +/*
> + * This routine can be used before register access to wake up a serial
> + * port that has been runtime PM suspended by the serial port driver.
> + * Note that the runtime_suspended flag is managed by the serial port
> + * device driver runtime PM.
> + */
> +static int __uart_port_wakeup(struct uart_port *port)
> +{
> +	if (!port->runtime_suspended)
> +		return 0;
> +
> +	if (port->ops->wakeup)
> +		return port->ops->wakeup(port);

Why do you need a subdriver callback for this? Why no schedule a resume
in core rather than spreading the logic out over core and subdrivers?

> +
> +	return 0;
> +}
> +
>  /*
>   * This routine is used by the interrupt handler to schedule processing in
>   * the software interrupt portion of the driver.
> @@ -145,8 +168,15 @@ static void __uart_start(struct tty_struct *tty)
>  	struct uart_state *state = tty->driver_data;
>  	struct uart_port *port = state->uart_port;
>  
> -	if (port && !uart_tx_stopped(port))
> -		port->ops->start_tx(port);
> +	if (!port || uart_tx_stopped(port))
> +		return;
> +
> +	if (__uart_port_wakeup(port) < 0)
> +		return;
> +

This is racy since nothing prevents the device from being suspended
right here.

> +	serial_pm_get_noresume(port->dev);
> +	port->ops->start_tx(port);
> +	serial_pm_autosuspend(port->dev);
>  }
>  
>  static void uart_start(struct tty_struct *tty)
> @@ -160,6 +190,21 @@ static void uart_start(struct tty_struct *tty)
>  	uart_port_unlock(port, flags);
>  }
>  
> +/*
> + * This routine can be called from the serial driver runtime PM resume function
> + * to transmit buffered data if the serial port was not active on uart_write().
> + */
> +void uart_start_pending_tx(struct uart_port *port)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	if (!uart_tx_stopped(port) && uart_circ_chars_pending(&port->state->xmit))
> +		port->ops->start_tx(port);
> +	spin_unlock_irqrestore(&port->lock, flags);
> +}
> +EXPORT_SYMBOL(uart_start_pending_tx);

Perhaps as an intermediate step, but this looks like another argument
for handling everything runtime PM related in core (i.e. enabling
runtime pm and generic suspend/resume ops) and adding callbacks to do
subdriver specific bits instead.

> +
>  static void
>  uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
>  {
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -40,6 +40,7 @@ struct uart_ops {
>  	void		(*set_mctrl)(struct uart_port *, unsigned int mctrl);
>  	unsigned int	(*get_mctrl)(struct uart_port *);
>  	void		(*stop_tx)(struct uart_port *);
> +	int		(*wakeup)(struct uart_port *);
>  	void		(*start_tx)(struct uart_port *);
>  	void		(*throttle)(struct uart_port *);
>  	void		(*unthrottle)(struct uart_port *);
> @@ -250,6 +251,7 @@ struct uart_port {
>  	unsigned char		suspended;
>  	unsigned char		console_reinit;
>  	const char		*name;			/* port name */
> +	unsigned int		runtime_suspended:1;	/* port runtime state set by port driver */
>  	struct attribute_group	*attr_group;		/* port specific attributes */
>  	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
>  	struct serial_rs485     rs485;
> @@ -414,6 +416,7 @@ bool uart_match_port(const struct uart_port *port1,
>  /*
>   * Power Management
>   */
> +void uart_start_pending_tx(struct uart_port *port);
>  int uart_suspend_port(struct uart_driver *reg, struct uart_port *port);
>  int uart_resume_port(struct uart_driver *reg, struct uart_port *port);

Johan
