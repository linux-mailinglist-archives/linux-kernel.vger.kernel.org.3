Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315944F120F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354207AbiDDJej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354189AbiDDJeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:34:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F413BF98;
        Mon,  4 Apr 2022 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649064761; x=1680600761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jy1xBW1BgIX5lMNSOseMdp/EtP27vGCho0iLE98NMKs=;
  b=mxgsymapJUMnkQHz64yiFTBtnkjSordmdxzi/owWbf9tPEZOxuDF3Nmf
   ieh3knLEs03NaS2haySYs6h1DzzifOHA/gtMnT30+uVTL1CI4Qt6FGwly
   APAcHOtoLFQvIQJ/w40mG2jof6sPjYqQBLUDh7YN5hC14PGWZRc1X3TQ9
   eTGTrQkeQ5qrBuMxyuqyww1g3i9/IoYVUU9ZSNO7QyQxPplmJWZhL9RLF
   hQ2dwAp2MnvzVLDwJFyMpoTB2RnFOxGy7cVfGnCNiBCsUXivklABVdjCD
   TQlhi5mXPypGs96gKNib6k62E5fnphpYIyQBqIhiP9tUxq1ayGfw5uKOd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="260463957"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="260463957"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 02:32:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="641167689"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 02:32:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nbJ49-00CUUY-Rl;
        Mon, 04 Apr 2022 12:32:05 +0300
Date:   Mon, 4 Apr 2022 12:32:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Lukas Wunner <lukas@wunner.de>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        ilpo.jarvinen@linux.intel.com, rostedt@goodmis.org,
        senozhatsky@chromium.org, andre.goddard@gmail.com,
        sudipm.mukherjee@gmail.com, David.Laight@aculab.com,
        jonathanh@nvidia.com, phil@raspberrypi.com
Subject: Re: [PATCH v6] serial/8250: Use fifo in 8250 console driver
Message-ID: <Ykq7FXhQfsvr9TtC@smile.fi.intel.com>
References: <20220401194645.1738747-1-wander@redhat.com>
 <20220401194645.1738747-2-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401194645.1738747-2-wander@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022 at 04:46:42PM -0300, Wander Lairson Costa wrote:
> Note: I am using a small test app + driver located at [0] for the
> problem description. serco is a driver whose write function dispatches
> to the serial controller. sertest is a user-mode app that writes n bytes
> to the serial console using the serco driver.
> 
> While investigating a bug in the RHEL kernel, I noticed that the serial
> console throughput is way below the configured speed of 115200 bps in
> a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
> I got 2.5KB/s.
> 
> $ time ./sertest -n 2500 /tmp/serco
> 
> real    0m0.997s
> user    0m0.000s
> sys     0m0.997s
> 
> With the help of the function tracer, I then noticed the serial
> controller was taking around 410us seconds to dispatch one single byte:
> 
> $ trace-cmd record -p function_graph -g serial8250_console_write \
>    ./sertest -n 1 /tmp/serco
> 
> $ trace-cmd report
> 
>             |  serial8250_console_write() {
>  0.384 us   |    _raw_spin_lock_irqsave();
>  1.836 us   |    io_serial_in();
>  1.667 us   |    io_serial_out();
>             |    uart_console_write() {
>             |      serial8250_console_putchar() {
>             |        wait_for_xmitr() {
>  1.870 us   |          io_serial_in();
>  2.238 us   |        }
>  1.737 us   |        io_serial_out();
>  4.318 us   |      }
>  4.675 us   |    }
>             |    wait_for_xmitr() {
>  1.635 us   |      io_serial_in();
>             |      __const_udelay() {
>  1.125 us   |        delay_tsc();
>  1.429 us   |      }
> ...
> ...
> ...
>  1.683 us   |      io_serial_in();
>             |      __const_udelay() {
>  1.248 us   |        delay_tsc();
>  1.486 us   |      }
>  1.671 us   |      io_serial_in();
>  411.342 us |    }
> 
> In another machine, I measured a throughput of 11.5KB/s, with the serial
> controller taking between 80-90us to send each byte. That matches the
> expected throughput for a configuration of 115200 bps.
> 
> This patch changes the serial8250_console_write to use the 16550 fifo
> if available. In my benchmarks I got around 25% improvement in the slow
> machine, and no performance penalty in the fast machine.

...

> +	use_fifo = (up->capabilities & UART_CAP_FIFO) &&
> +		/*
> +		 * BCM283x requires to check the fifo
> +		 * after each byte.
> +		 */
> +		!(up->capabilities & UART_CAP_MINI) &&

Perhaps you need to also comment why we are using tx_loadsz and not fifosize.

> +		up->tx_loadsz > 1 &&
> +		(up->fcr & UART_FCR_ENABLE_FIFO) &&
> +		port->state &&
> +		test_bit(TTY_PORT_INITIALIZED, &port->state->port.iflags) &&
> +		/*
> +		 * After we put a data in the fifo, the controller will send
> +		 * it regardless of the CTS state. Therefore, only use fifo
> +		 * if we don't use control flow.
> +		 */
> +		!(up->port.flags & UPF_CONS_FLOW);

-- 
With Best Regards,
Andy Shevchenko


