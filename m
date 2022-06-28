Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD53B55F03B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiF1VOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiF1VOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:14:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5232F394;
        Tue, 28 Jun 2022 14:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656450878; x=1687986878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IoUkcovJgb9CummKhHiDPfjxdWv5DktTuianZK6c4U4=;
  b=JUuZujR3XMHiEAUWLhLzt7oz7ZWUsYrHpmp8nmQPISSE1ZQgfVrd9Iic
   EJNYNfpZ+OyoRG2AYdq5UNM8g68iXG2r0RbaVE9ymkvkawUcdgwVaVYS2
   TFaV7QuIag3mP5pRpwC/zaWNUAxudAa3hkR7b5Nra39ae/F0z3FP2OTqB
   KdN08fKYaSJ5r2Ks+PEbBX4zHKshmcDeUXgG1etja4QXXJWnx8K4v0ULD
   HShHe5dSoyuo96/iLh4T/6NCdrTluUxtLur9DvngFYMA0YglGLcjWgqey
   wW4khY97IKbDBPYjRsYd5REA7HP8VRHmS/e2yPwjxbiEAO73gUJ6fKaNC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="281884890"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="281884890"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 14:14:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="836834531"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 14:14:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o6IXZ-000x9q-Q4;
        Wed, 29 Jun 2022 00:14:33 +0300
Date:   Wed, 29 Jun 2022 00:14:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: 8250: Fix PM usage_count for console handover
Message-ID: <YrtvOSrrSLGX/coS@smile.fi.intel.com>
References: <20220628165834.63044-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220628165834.63044-1-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 07:58:34PM +0300, Ilpo Järvinen wrote:
> When console is enabled, univ8250_console_setup() calls
> serial8250_console_setup() before .dev is set to uart_port. Therefore,
> it will not call pm_runtime_get_sync(). Later, when the actual driver
> is going to take over univ8250_console_exit() is called. As .dev is
> already set, serial8250_console_exit() makes pm_runtime_put_sync() call
> with usage count being zero triggering PM usage count warning
> (extra debug for univ8250_console_setup(), univ8250_console_exit(), and
> serial8250_register_ports()):
> 
> [    0.068987] univ8250_console_setup ttyS0 nodev
> [    0.499670] printk: console [ttyS0] enabled
> [    0.717955] printk: console [ttyS0] printing thread started
> [    1.960163] serial8250_register_ports assigned dev for ttyS0
> [    1.976830] printk: console [ttyS0] disabled
> [    1.976888] printk: console [ttyS0] printing thread stopped
> [    1.977073] univ8250_console_exit ttyS0 usage:0
> [    1.977075] serial8250 serial8250: Runtime PM usage count underflow!
> [    1.977429] dw-apb-uart.6: ttyS0 at MMIO 0x4010006000 (irq = 33, base_baud = 115200) is a 16550A
> [    1.977812] univ8250_console_setup ttyS0 usage:2
> [    1.978167] printk: console [ttyS0] printing thread started
> [    1.978203] printk: console [ttyS0] enabled
> 
> To fix the issue, call pm_runtime_get_sync() in
> serial8250_register_ports() as soon as .dev is set for an uart_port
> if it has console enabled.
> 
> This problem became apparent only recently because 82586a721595 ("PM:
> runtime: Avoid device usage count underflows") added the warning
> printout. I confirmed this problem also occurs with v5.18 (w/o the
> warning printout, obviously) so the recent printk kthreads are not the
> cause for this.

Since printk kthread was reverted, you may drop its mention here completely.

In any case, good catch!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

But it would be good to be tested by Tony.

> Fixes: bedb404e91bb ("serial: 8250_port: Don't use power management for kernel console")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> ---
>  drivers/tty/serial/8250/8250_core.c | 4 ++++
>  drivers/tty/serial/serial_core.c    | 5 -----
>  include/linux/serial_core.h         | 5 +++++
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 57e86133af4f..2e83e7367441 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -23,6 +23,7 @@
>  #include <linux/sysrq.h>
>  #include <linux/delay.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/tty.h>
>  #include <linux/ratelimit.h>
>  #include <linux/tty_flip.h>
> @@ -558,6 +559,9 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
>  
>  		up->port.dev = dev;
>  
> +		if (uart_console_enabled(&up->port))
> +			pm_runtime_get_sync(up->port.dev);
> +
>  		serial8250_apply_quirks(up);
>  		uart_add_one_port(drv, &up->port);
>  	}
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 85ef7ef00b82..3161445504bc 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2024,11 +2024,6 @@ static int uart_proc_show(struct seq_file *m, void *v)
>  }
>  #endif
>  
> -static inline bool uart_console_enabled(struct uart_port *port)
> -{
> -	return uart_console(port) && (port->cons->flags & CON_ENABLED);
> -}
> -
>  static void uart_port_spin_lock_init(struct uart_port *port)
>  {
>  	spin_lock_init(&port->lock);
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index b7b86ee3cb12..9d8aa139b175 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -404,6 +404,11 @@ static const bool earlycon_acpi_spcr_enable EARLYCON_USED_OR_UNUSED;
>  static inline int setup_earlycon(char *buf) { return 0; }
>  #endif
>  
> +static inline bool uart_console_enabled(struct uart_port *port)
> +{
> +	return uart_console(port) && (port->cons->flags & CON_ENABLED);
> +}
> +
>  struct uart_port *uart_get_console(struct uart_port *ports, int nr,
>  				   struct console *c);
>  int uart_parse_earlycon(char *p, unsigned char *iotype, resource_size_t *addr,
> 
> -- 
> tg: (f287f971e256..) fix/console-usage_count (depends on: tty-next)

-- 
With Best Regards,
Andy Shevchenko


