Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB4646E33A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 08:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhLIHdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 02:33:21 -0500
Received: from muru.com ([72.249.23.125]:36338 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhLIHdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 02:33:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 47FE980A3;
        Thu,  9 Dec 2021 07:30:27 +0000 (UTC)
Date:   Thu, 9 Dec 2021 09:29:44 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/7] serial: core: Add support of runtime PM
Message-ID: <YbGwaOj0ZbEuNEPA@atomide.com>
References: <20211115084203.56478-1-tony@atomide.com>
 <20211115084203.56478-2-tony@atomide.com>
 <YaX82wxybOZnPKpy@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaX82wxybOZnPKpy@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Johan Hovold <johan@kernel.org> [211130 10:29]:
> On Mon, Nov 15, 2021 at 10:41:57AM +0200, Tony Lindgren wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > 8250 driver has wrong implementation of runtime power management, i.e.
> > it uses an irq_safe flag. The irq_safe flag takes a permanent usage count
> > on the parent device preventing the parent from idling. This patch
> > prepares for making runtime power management generic by adding runtime PM
> > calls to serial core once for all UART drivers.
> > 
> > As we have serial drivers that do not enable runtime PM, and drivers that
> > enable runtime PM, we add new functions for serial_pm_resume_and_get() and
> > serial_pm_autosuspend() functions to handle errors and allow the use also
> > for cases when runtime PM is not enabled. The other option considered was
> > to not check for runtime PM enable errors. But some CPUs can hang when the
> > clocks are not enabled for the device, so ignoring the errors is not a good
> > option. Eventually with the serial port drivers updated, we should be able
> > to just switch to using the standard runtime PM calls with no need for the
> > wrapper functions.
> 
> A third option which needs to be considered is to always enable runtime
> pm in core but to keep the ports active while they are opened unless a
> driver opts in for more aggressive power management. This is how USB
> devices are handled for example.
> 
> A next step could then be to move over uart_change_pm() to be handled
> from the pm callbacks.

Yes that would be nice to do eventually :)

> > @@ -1824,12 +1901,16 @@ static void uart_line_info(struct seq_file *m, struct uart_driver *drv, int i)
> >  	}
> >  
> >  	if (capable(CAP_SYS_ADMIN)) {
> > +		err = serial_pm_resume_and_get(uport->dev);
> > +		if (err < 0)
> > +			goto out;
> >  		pm_state = state->pm_state;
> >  		if (pm_state != UART_PM_STATE_ON)
> >  			uart_change_pm(state, UART_PM_STATE_ON);
> >  		spin_lock_irq(&uport->lock);
> >  		status = uport->ops->get_mctrl(uport);
> >  		spin_unlock_irq(&uport->lock);
> > +		serial_pm_autosuspend(uport->dev);
> >  		if (pm_state != UART_PM_STATE_ON)
> >  			uart_change_pm(state, pm_state);
> 
> The interaction with uart_change_pm() looks inconsistent. Why resume
> before the state change and also suspend *before* updating the pm state?

Good point.

> That is, shouldn't the suspend go after uart_change_pm()? And similar in
> other places.

Yes agreed, runtime PM may disable the clock and shut down the UART so
should be done after uart_change_pm().

BTW, Andy has follow-up patches to also drop the old uart_pm in favor of
runtime PM :)

> > @@ -2050,6 +2131,7 @@ uart_set_options(struct uart_port *port, struct console *co,
> >  {
> >  	struct ktermios termios;
> >  	static struct ktermios dummy;
> > +	int ret;
> >  
> >  	/*
> >  	 * Ensure that the serial-console lock is initialised early.
> > @@ -2089,7 +2171,17 @@ uart_set_options(struct uart_port *port, struct console *co,
> >  	 */
> >  	port->mctrl |= TIOCM_DTR;
> >  
> > -	port->ops->set_termios(port, &termios, &dummy);
> > +	/* At early stage device is not created yet, we can't do PM */
> > +	if (port->dev) {
> 
> Checking port->dev here looks a bit hacky.

As this is kernel console related we may be able to just leave out the
runtime PM calls here, see the two commits below. Andy, do you have some
comments?

> Can you expand on this and also on how this relates to console ports
> presumably never being runtime suspended?

See the following two commits for kernel console handling:

bedb404e91bb ("serial: 8250_port: Don't use power management for kernel console")
a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")

Thanks for looking through the patches again, I'll take a look at all
your comments and will repost after the merge window.

Regards,

Tony
