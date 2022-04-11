Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0554FBD13
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346481AbiDKNbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346477AbiDKNbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:31:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B2D27A;
        Mon, 11 Apr 2022 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649683757; x=1681219757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s7lGp6ZwOUOr6C+R1b0zEt7RIc7T3OGFYwSjiL0N5fc=;
  b=gwi8SwU3NTeqezpGRXVlHIAFBl1nDepGxQVzkGOvf9ofGArm9O4bIwaK
   P6F/ZVnCoPrGNAhwzFXAYVU+eg+fNTMoSQAvVwF+RTmaPIJrJi+tszron
   BkeoluBD20Fi/v+u1E+aT8ZhKvBuKfQY8ayqEpVvNVt77k5YeocxMKGnN
   P1F9SZfowaIsE/NN6nOORRweHGhNHbszmDAeuIr+//smVTY1X9/XxWFKV
   4OjjFccneEH9RhwZzs/mif48z6ra4bhp1zRxKOFQJKFa5/NQ/64n0YRVL
   i4w+M+WeX67i3c6m/wMy1RhXUPG4ngN7i5lV0sy0V56spT70IWF/301Sh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="260962323"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="260962323"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 06:29:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="525977643"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 06:29:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ndu2v-001DbK-Mf;
        Mon, 11 Apr 2022 16:25:33 +0300
Date:   Mon, 11 Apr 2022 16:25:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Start managing serial controllers to
 enable runtime PM
Message-ID: <YlQsTWcM3is9TGdw@smile.fi.intel.com>
References: <20220411120218.17422-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411120218.17422-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 03:02:18PM +0300, Tony Lindgren wrote:
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

...

> +struct serial_controller {
> +	struct uart_driver *drv;		/* For port specific uart_state */

> +	struct mutex lock;			/* For changing enabled_count */
> +	int enabled_count;			/* Enable count for runtime PM */

Wondering if we may use kref instead which will check for saturation as well.

> +	unsigned long implements_pm_runtime:1;
> +	unsigned long supports_autosuspend:1;
> +};

...

> +		WARN_ON(port->supports_autosuspend !=
> +			controller->supports_autosuspend);

One line?


...

> +	controller = kzalloc(sizeof(*controller), GFP_KERNEL);
> +	if (!controller)
> +		return -ENOMEM;
> +
> +	mutex_init(&controller->lock);
> +	controller->drv = drv;
> +	controller->supports_autosuspend = port->supports_autosuspend;
> +	port->state->controller = controller;
> +
> +	return radix_tree_insert(&serial_core_devices, idx, controller);

Hmm... Memory leak at error?


...

> +	if (!idx)
> +		return;

Do you really need this?

> +	controller = radix_tree_lookup(&serial_core_devices, idx);
> +	if (!controller)
> +		return;

...and/or this?

> +	controller = radix_tree_delete(&serial_core_devices, idx);
> +	if (!controller)
> +		return;

...

> +	struct device *dev = port->dev;

I would split assignment to be closer to first user...

...

...somewhere here.

> +	if (!dev)
> +		return 0;

...

> +	struct serial_controller *controller;
> +	struct device *dev = port->dev;
> +	struct uart_state *state;

> +	if (!dev)
> +		return;

Ditto.

...

>  	unsigned char		hub6;			/* this should be in the 8250 driver */
>  	unsigned char		suspended;
>  	unsigned char		console_reinit;
> +	unsigned long		supports_autosuspend:1;

Hmm... Maybe use unsigned char and convert all of them to something else if needed?

-- 
With Best Regards,
Andy Shevchenko


