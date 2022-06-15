Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5032D54C475
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347821AbiFOJRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347777AbiFOJR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:17:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE9A3F304;
        Wed, 15 Jun 2022 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655284643; x=1686820643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YyhEK4s3L7E+aivaywLYIThq17iLzFEVGLISAiATPXw=;
  b=dOO5kAL65BJWIjEI2fkKJqvJcn1KkOwquVFqbiCbdzC0di5WW5JB28H3
   8tXU2KNj3Ib4zLnXiqPfw1v69qe9CqL0Hfer3I8D7G05+AsUY9cx8gv7I
   gOTHnMvF8SkgPtusFYOyyh1HTblG2ijxgnXr28Mh50+D5J8r2kpfQ9wgd
   LYux9HJqjfs6HuFLOk+Rre3MH9cJFZbnPseeYvKCnjBPsyM/fidZtn0TU
   XzgSZ8WoMTfYtTXTsawZ/oHaObjrytqKkMbk2xMgHXYsweWohTGOvBqdw
   fnfvvJkyNSVt0i9vOMOzUrDNbU8+LpSGQttsb9J8zsRsZtcLvQX8A380P
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="277685900"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="277685900"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 02:17:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="652552017"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 02:17:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o1P9J-000dGZ-V4;
        Wed, 15 Jun 2022 12:17:17 +0300
Date:   Wed, 15 Jun 2022 12:17:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] serial: core: Start managing serial controllers
 to enable runtime PM
Message-ID: <YqmjnaawQ2gye/pe@smile.fi.intel.com>
References: <20220615062455.15490-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615062455.15490-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 09:24:55AM +0300, Tony Lindgren wrote:
> We want to enable runtime PM for serial port device drivers in a generic
> way. To do this, we want to have the serial core layer manage the
> registered serial port controllers. For runtime PM, we need a way to find
> the serial ports for each serial port controller device.
> 
> The serial core manages ports. Each serial controller can have multiple
> ports. As serial core has no struct device, and the serial port device
> drivers have their own driver data, we cannot currently start making
> use of serial core generic data easily without changing all the serial
> port device drivers.
> 
> We could consider adding a serial core specific struct device. It would
> be a child of the serial port device, and would allow us eventually to use
> device_links to add generic runtime PM calls for example. But as the serial
> core layer is not a device driver, driver specific features would need to
> be added, and are probably not justified for a virtual device.
> 
> Considering the above, let's improve the serial core layer so we can
> manage the serial port controllers better. Let's register the controllers
> with the serial core layer in addition to the serial ports.
> 
> To find the serial ports for a controller based on struct device, let's
> add a new data structure for a serial_controller. Let's add the registered
> devices into a radix_tree so we can look up the controller easily even
> with many controllers registered. This allows us to keep track of the
> runtime PM state for each serial port controller device.
> 
> As some serial port device drivers enable runtime PM in their probe before
> registering with the serial core layer, and some do not enable runtime PM
> at all currently, we need check the state in the serial core layer on
> uart_port_startup(). We need to also consider that a serial port device
> may have multiple ports.
> 
> Initially we just want to enable runtime PM for all the serial port
> controller devices. This allows us to add runtime PM calls and properly
> handle any errors without a need for serial layer specific runtime PM
> wrapper functions.
> 
> After this patch no functional changes for the serial port device drivers
> are intended. For most cases, we just enable runtime PM and keep the
> runtime PM usage count until all the serial controller ports are
> unregistered. For drivers implementing runtime PM, we just keep track of
> the configuration.
> 
> The serial core layer has the following use cases to deal with:
> 
> - If a serial port device driver does not implement runtime PM, the
>   device state is set to active state, and the runtime PM usage count
>   is kept until the last port for a device is unregistered
> 
> - If a serial port device driver implements runtime PM, the runtime PM
>   usage count is kept until the last port for the device is unregistered
> 
> - If a serial port device driver implements runtime PM autosuspend,
>   autosuspend is not prevented. This currently gets set only for the
>   8250_omap driver to keep runtime PM working for it
> 
> For system suspend, things should be mostly detached from the runtime PM.
> The serial port device drivers may call pm_runtime_force_suspend() and
> pm_runtime_force_resume() as needed.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A couple of nit-picks below.

> Suggested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> 
> - Use kref as suggested by Andy
> 
> - Fix memory leak on error as noted by Andy
> 
> - Use use unsigned char for supports_autosuspend as suggested by Andy
> 
> - Coding style improvments as suggested by Andy
> 
> ---
>  drivers/tty/serial/8250/8250_core.c |   1 +
>  drivers/tty/serial/8250/8250_omap.c |   1 +
>  drivers/tty/serial/serial_core.c    | 148 ++++++++++++++++++++++++++++
>  include/linux/serial_core.h         |   3 +
>  4 files changed, 153 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -995,6 +995,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  		uart->port.regshift     = up->port.regshift;
>  		uart->port.iotype       = up->port.iotype;
>  		uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
> +		uart->port.supports_autosuspend = up->port.supports_autosuspend;
>  		uart->bugs		= up->bugs;
>  		uart->port.mapbase      = up->port.mapbase;
>  		uart->port.mapsize      = up->port.mapsize;
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1338,6 +1338,7 @@ static int omap8250_probe(struct platform_device *pdev)
>  	up.rs485_start_tx = serial8250_em485_start_tx;
>  	up.rs485_stop_tx = serial8250_em485_stop_tx;
>  	up.port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
> +	up.port.supports_autosuspend = 1;
>  
>  	ret = of_alias_get_id(np, "serial");
>  	if (ret < 0) {
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -16,7 +16,9 @@
>  #include <linux/console.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/of.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/proc_fs.h>
> +#include <linux/radix-tree.h>
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/serial.h> /* for serial_state and serial_icounter_struct */
> @@ -30,6 +32,25 @@
>  #include <linux/irq.h>
>  #include <linux/uaccess.h>
>  
> +/*
> + * Serial port device specific data for serial core.
> + *
> + * Each port device can have multiple ports with struct uart_state allocated
> + * for each port. The array of ports is kept in struct uart_driver.
> + */
> +struct serial_controller {
> +	struct device *dev;			/* Serial port device */

Serial port device is a bit unclear for non-prepared reader. Perhaps add
the word "physical" or another to specify the nature of the device (because
to me "serial port device" sounds like a duplication of something in struct
uart_port, but I have doubts).

> +	struct uart_driver *drv;		/* For port specific uart_state */
> +	struct kref ref;			/* Enable count for runtime PM */
> +	unsigned long implements_pm_runtime:1;
> +	unsigned long supports_autosuspend:1;
> +};
> +
> +/*
> + * Serial core port device instances. Update protected by port_mutex.
> + */
> +static RADIX_TREE(serial_core_devices, GFP_NOWAIT);
> +
>  /*
>   * This is used to lock changes in serial line configuration.
>   */
> @@ -175,6 +196,125 @@ static void uart_port_dtr_rts(struct uart_port *uport, int raise)
>  		uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
>  }
>  
> +/* Called from uart_add_one_port() with port_mutex held */
> +static int serial_core_pm_runtime_start(struct uart_port *port)
> +{
> +	struct uart_state *state = port->state;
> +	struct serial_controller *controller = state->controller;
> +	struct device *dev = port->dev;
> +	int ret = 0;
> +
> +	if (kref_get_unless_zero(&controller->ref))
> +		return 0;
> +
> +	/* Init controller device on first reference */
> +	kref_init(&controller->ref);
> +
> +	/* Always enable autosuspend and consider child devices for serdev */
> +	pm_runtime_use_autosuspend(dev);
> +	pm_suspend_ignore_children(dev, false);
> +
> +	/*
> +	 * If the port driver did not enable runtime PM in probe, do it now.
> +	 * Devices that did not enable runtime PM get set active so we can
> +	 * properly handle the returned errors for runtime PM calls.
> +	 */
> +	if (!pm_runtime_enabled(dev)) {
> +		pm_runtime_set_active(dev);
> +		pm_runtime_enable(dev);
> +	} else {
> +		controller->implements_pm_runtime = 1;
> +	}
> +
> +	/*
> +	 * Keep the port device enabled unless autosuspend is supported.
> +	 * Released on port shutdown.
> +	 */
> +	if (!controller->supports_autosuspend) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0) {
> +			pm_runtime_dont_use_autosuspend(dev);
> +			pm_runtime_disable(dev);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +/* Clean up the runtime PM settings done on serial_core_register_port() */
> +static void serial_core_pm_runtime_cleanup(struct kref *ref)
> +{
> +	struct serial_controller *controller =
> +		 container_of(ref, struct serial_controller, ref);
> +	struct device *dev = controller->dev;
> +
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_suspend_ignore_children(dev, true);
> +	if (!controller->supports_autosuspend)
> +		pm_runtime_put_sync(dev);
> +	if (!controller->implements_pm_runtime) {
> +		pm_runtime_set_suspended(dev);
> +		pm_runtime_disable(dev);
> +	}
> +}
> +
> +/* Called from uart_remove_one_port() and on error path with port_mutex held */
> +static void serial_core_unregister_port(struct uart_port *port)
> +{
> +	unsigned long idx = (unsigned long)port->dev;
> +	struct serial_controller *controller;
> +
> +	/* Check for a registered controller, no struct device early on */
> +	controller = radix_tree_lookup(&serial_core_devices, idx);
> +	if (!controller)
> +		return;
> +
> +	kref_put(&controller->ref, serial_core_pm_runtime_cleanup);
> +
> +	controller = radix_tree_delete(&serial_core_devices, idx);
> +	kfree(controller);
> +}
> +
> +/* Called from uart_add_one_port() with port_mutex held */
> +static int serial_core_register_port(struct uart_port *port,
> +				     struct uart_driver *drv)
> +{
> +	unsigned long idx = (unsigned long)port->dev;
> +	struct serial_controller *controller;
> +	int ret;
> +
> +	if (!idx)
> +		return 0;
> +
> +	controller = radix_tree_lookup(&serial_core_devices, idx);
> +	if (controller) {
> +		port->state->controller = controller;
> +		WARN_ON(port->supports_autosuspend != controller->supports_autosuspend);
> +		return serial_core_pm_runtime_start(port);
> +	}
> +
> +	controller = kzalloc(sizeof(*controller), GFP_KERNEL);
> +	if (!controller)
> +		return -ENOMEM;
> +
> +	controller->drv = drv;
> +	controller->dev = port->dev;
> +	controller->supports_autosuspend = port->supports_autosuspend;
> +	port->state->controller = controller;
> +
> +	ret = radix_tree_insert(&serial_core_devices, idx, controller);
> +	if (ret) {
> +		kfree(controller);
> +		return ret;
> +	}
> +
> +	ret = serial_core_pm_runtime_start(port);
> +	if (ret < 0)
> +		serial_core_unregister_port(port);
> +
> +	return ret;
> +}
> +
>  /*
>   * Startup the port.  This will be called once per open.  All calls
>   * will be serialised by the per-port mutex.
> @@ -2956,6 +3096,10 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>  		goto out;
>  	}
>  
> +	ret = serial_core_register_port(uport, drv);
> +	if (ret)
> +		goto out;
> +
>  	/*
>  	 * If this port is in use as a console then the spinlock is already
>  	 * initialised.
> @@ -2979,6 +3123,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
>  				    GFP_KERNEL);
>  	if (!uport->tty_groups) {
>  		ret = -ENOMEM;
> +		serial_core_unregister_port(uport);
>  		goto out;
>  	}
>  	uport->tty_groups[0] = &tty_dev_attr_group;
> @@ -3048,6 +3193,9 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
>  		goto out;
>  	}
>  	uport->flags |= UPF_DEAD;
> +
> +	serial_core_unregister_port(uport);
> +
>  	mutex_unlock(&port->mutex);
>  
>  	/*
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -250,6 +250,7 @@ struct uart_port {
>  	unsigned char		hub6;			/* this should be in the 8250 driver */
>  	unsigned char		suspended;
>  	unsigned char		console_reinit;
> +	unsigned char		supports_autosuspend;
>  	const char		*name;			/* port name */
>  	struct attribute_group	*attr_group;		/* port specific attributes */
>  	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
> @@ -285,6 +286,8 @@ enum uart_pm_state {
>   * This is the state information which is persistent across opens.
>   */
>  struct uart_state {
> +	struct serial_controller *controller;

While good looking here, I believe resource wise is better to leave @port to be
the first member. The rationale is to get rid of pointer arithmetics at compile
time (and I believe the port is used much more and in more critical places).
However, I dunno if it will get a lot of benefit, would be nice to see
bloat-o-meter output for your variant and my proposal.

>  	struct tty_port		port;
>  
>  	enum uart_pm_state	pm_state;
> -- 
> 2.36.1

-- 
With Best Regards,
Andy Shevchenko


