Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5563447B08A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhLTPpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhLTPpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:45:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B543C061574;
        Mon, 20 Dec 2021 07:45:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C64EA6114E;
        Mon, 20 Dec 2021 15:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A826EC36AE5;
        Mon, 20 Dec 2021 15:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640015113;
        bh=IKJ5T2hq5O+0bUmV/yAr2gQji1zgSircrEDIduveyPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wH7SIh7UX+9uuRzH7o84vfjnX+FfZ0wlghtWesGCLbGWCHq/mGYdW/YitCNSdfIwU
         SqrEaWxj6tLiDbxXx9OrQ+4wXrrA2sGxJMfKX7PKp5GTASW0dbMxQwaKowVoF7Iv2F
         q15ydSFx6C8j9SaGKgvWBWyd4qjnDjoCEg7wjbyE=
Date:   Mon, 20 Dec 2021 16:45:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     wander@redhat.com
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tty: serial: Use fifo in 8250 console driver
Message-ID: <YcClBlhwp4arGWtw@kroah.com>
References: <20211104171734.137707-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104171734.137707-1-wander@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:17:31PM -0300, wander@redhat.com wrote:
> From: Wander Lairson Costa <wander@redhat.com>
> 
> Note: I am using a small test app + driver located at [0] for the
> problem description. serco is a driver whose write function dispatches
> to the serial controller. sertest is a user-mode app that writes n bytes
> to the serial console using the serco driver.
> 
> Recently I got a report of a soft lockup while loading a bunch a
> scsi_debug devices (> 500).
> 
> While investigating it, I noticed that the serial console throughput
> (called by the printk code) is way below the configured speed of 115200
> bps in a HP Proliant DL380 Gen9 server. I was expecting something above
> 10KB/s, but I got 2.5KB/s. I then built a simple driver [0] to isolate
> the console from the printk code. Here it is:
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
> if available. In my artificial benchmark I could get a throughput
> increase up to 100% in some cases, but in the real case described at the
> beginning the gain was of about 25%.
> 
> [0] https://github.com/walac/serial-console-test
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  drivers/tty/serial/8250/8250.h      |  3 ++
>  drivers/tty/serial/8250/8250_port.c | 63 +++++++++++++++++++++++++----
>  2 files changed, 59 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> index 6473361525d1..c711bf118cc1 100644
> --- a/drivers/tty/serial/8250/8250.h
> +++ b/drivers/tty/serial/8250/8250.h
> @@ -83,6 +83,9 @@ struct serial8250_config {
>  #define UART_CAP_MINI	BIT(17)	/* Mini UART on BCM283X family lacks:
>  					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
>  					 */
> +#define UART_CAP_CWFIFO BIT(18) /* Use the UART Fifo in
> +				 * serial8250_console_write
> +				 */

Why do you need a new bit?  Why can't you just do this change for all
devices that have a fifo?  Why would you _not_ want to do this for all
devices that have a fifo?

thanks,

greg k-h
