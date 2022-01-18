Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A65D4922FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 10:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiARJlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 04:41:08 -0500
Received: from muru.com ([72.249.23.125]:51126 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229604AbiARJlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:41:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0A9C280C0;
        Tue, 18 Jan 2022 09:41:54 +0000 (UTC)
Date:   Tue, 18 Jan 2022 11:41:03 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] serial: core: Add support of runtime PM
Message-ID: <YeaLL0cJFeIhz1Tr@atomide.com>
References: <20211115084203.56478-1-tony@atomide.com>
 <20211115084203.56478-2-tony@atomide.com>
 <YaX82wxybOZnPKpy@hovoldconsulting.com>
 <YbGwaOj0ZbEuNEPA@atomide.com>
 <YbHb7HRGGFRBorB7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbHb7HRGGFRBorB7@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Andy Shevchenko <andriy.shevchenko@intel.com> [211209 10:37]:
> On Thu, Dec 09, 2021 at 09:29:44AM +0200, Tony Lindgren wrote:
> > * Johan Hovold <johan@kernel.org> [211130 10:29]:
> > > On Mon, Nov 15, 2021 at 10:41:57AM +0200, Tony Lindgren wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > 
> > > > 8250 driver has wrong implementation of runtime power management, i.e.
> > > > it uses an irq_safe flag. The irq_safe flag takes a permanent usage count
> > > > on the parent device preventing the parent from idling. This patch
> > > > prepares for making runtime power management generic by adding runtime PM
> > > > calls to serial core once for all UART drivers.
> > > > 
> > > > As we have serial drivers that do not enable runtime PM, and drivers that
> > > > enable runtime PM, we add new functions for serial_pm_resume_and_get() and
> > > > serial_pm_autosuspend() functions to handle errors and allow the use also
> > > > for cases when runtime PM is not enabled. The other option considered was
> > > > to not check for runtime PM enable errors. But some CPUs can hang when the
> > > > clocks are not enabled for the device, so ignoring the errors is not a good
> > > > option. Eventually with the serial port drivers updated, we should be able
> > > > to just switch to using the standard runtime PM calls with no need for the
> > > > wrapper functions.
> > > 
> > > A third option which needs to be considered is to always enable runtime
> > > pm in core but to keep the ports active while they are opened unless a
> > > driver opts in for more aggressive power management. This is how USB
> > > devices are handled for example.
> > > 
> > > A next step could then be to move over uart_change_pm() to be handled
> > > from the pm callbacks.
> > 
> > Yes that would be nice to do eventually :)

I think we should do the "third option" above as the first preparatory patch.
It can be done separately from the rest of the series, and we avoid adding
serial layer specific wrappers around runtime PM calls in the later patches.

Below is what I came up with for the preparatory patch, can you guys please
take a look and see if you have better ideas?

For system suspend and resume, it seems we don't need to do anything as
runtime PM is anyways disabled already in prepare.

Andy, care to give the following also a try for your serial port test
cases?

Regards,

Tony

8< --------------------
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -997,6 +997,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		uart->port.regshift     = up->port.regshift;
 		uart->port.iotype       = up->port.iotype;
 		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
+		uart->port.supports_autosuspend = up->port.supports_autosuspend;
 		uart->bugs		= up->bugs;
 		uart->port.mapbase      = up->port.mapbase;
 		uart->port.mapsize      = up->port.mapsize;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1352,6 +1352,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.rs485_start_tx = serial8250_em485_start_tx;
 	up.rs485_stop_tx = serial8250_em485_stop_tx;
 	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
+	up.port.supports_autosuspend = 1;
 
 	ret = of_alias_get_id(np, "serial");
 	if (ret < 0) {
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -16,6 +16,7 @@
 #include <linux/console.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/device.h>
@@ -184,6 +185,7 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 		int init_hw)
 {
 	struct uart_port *uport = uart_port_check(state);
+	struct device *dev = uport->dev;
 	unsigned long flags;
 	unsigned long page;
 	int retval = 0;
@@ -191,6 +193,32 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	if (uport->type == PORT_UNKNOWN)
 		return 1;
 
+	/* Always enable autosuspend and consider child devices for serdev */
+	pm_runtime_use_autosuspend(dev);
+	pm_suspend_ignore_children(dev, false);
+
+	/*
+	 * If the port driver did not enable runtime PM in probe, do it now.
+	 * Devices that did not enable runtime PM get set active so we can
+	 * properly handler the returned errors for runtime PM calls.
+	 */
+	if (!pm_runtime_enabled(dev)) {
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	} else {
+		uport->implements_pm_runtime = 1;
+	}
+
+	/*
+	 * Keep the port enabled unless autosuspend is supported.
+	 * Released in uart_shutdown().
+	 */
+	if (!uport->supports_autosuspend) {
+		retval = pm_runtime_resume_and_get(dev);
+		if (retval < 0)
+			return retval;
+	}
+
 	/*
 	 * Make sure the device is in D0 state.
 	 */
@@ -279,6 +307,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 {
 	struct uart_port *uport = uart_port_check(state);
 	struct tty_port *port = &state->port;
+	struct device *dev = uport->dev;
 	unsigned long flags;
 	char *xmit_buf = NULL;
 
@@ -313,6 +342,19 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	 */
 	tty_port_set_suspended(port, 0);
 
+	/* Runtime PM paired with configuration done in uart_port_startup() */
+	if (uport) {
+		dev = uport->dev;
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_suspend_ignore_children(dev, true);
+		if (!uport->supports_autosuspend)
+			pm_runtime_put_sync(dev);
+		if (!uport->implements_pm_runtime) {
+			pm_runtime_set_suspended(dev);
+			pm_runtime_disable(dev);
+		}
+	}
+
 	/*
 	 * Do not free() the transmit buffer page under the port lock since
 	 * this can create various circular locking scenarios. For instance,
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -249,6 +249,8 @@ struct uart_port {
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
 	unsigned char		console_reinit;
+	unsigned long		implements_pm_runtime:1;
+	unsigned long		supports_autosuspend:1;
 	const char		*name;			/* port name */
 	struct attribute_group	*attr_group;		/* port specific attributes */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
-- 
2.34.1
