Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F8F49AFDE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 10:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456661AbiAYJQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 04:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455640AbiAYJFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:05:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C6CC061214;
        Tue, 25 Jan 2022 00:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02AA2613F5;
        Tue, 25 Jan 2022 08:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC098C340E0;
        Tue, 25 Jan 2022 08:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643100617;
        bh=oxSIri0DeRSQQ3KdpLeQU8/o5kCnSJfA0DeyhNCV32U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RmjJs3gckKBAckVu9AawRxpZd2S4Xg7e1H4AOOrR1GrHWXwPrrQjwAau8JCet/5vq
         zAwWDwe7WgzsAoQsJ6TTKCLCFJrxX9uzKg1yAOR4hFm+BOU0PIVIZTEWaqSUdAfoLo
         0ZTr5VjbIvjXF1kc1fNR70sacBx9tewG8pi5r4mA=
Date:   Tue, 25 Jan 2022 09:50:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     wander@redhat.com, Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
Message-ID: <Ye+5xrJ2kC85E8QT@kroah.com>
References: <20211029201402.428284-1-wander@redhat.com>
 <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 08:39:24AM +0000, Jon Hunter wrote:
> 
> On 29/10/2021 21:14, wander@redhat.com wrote:
> > From: Wander Lairson Costa <wander@redhat.com>
> > 
> > Note: I am using a small test app + driver located at [0] for the
> > problem description. serco is a driver whose write function dispatches
> > to the serial controller. sertest is a user-mode app that writes n bytes
> > to the serial console using the serco driver.
> > 
> > While investigating a bug in the RHEL kernel, I noticed that the serial
> > console throughput is way below the configured speed of 115200 bps in
> > a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
> > I got 2.5KB/s.
> > 
> > $ time ./sertest -n 2500 /tmp/serco
> > 
> > real    0m0.997s
> > user    0m0.000s
> > sys     0m0.997s
> > 
> > With the help of the function tracer, I then noticed the serial
> > controller was taking around 410us seconds to dispatch one single byte:
> > 
> > $ trace-cmd record -p function_graph -g serial8250_console_write \
> >     ./sertest -n 1 /tmp/serco
> > 
> > $ trace-cmd report
> > 
> >              |  serial8250_console_write() {
> >   0.384 us   |    _raw_spin_lock_irqsave();
> >   1.836 us   |    io_serial_in();
> >   1.667 us   |    io_serial_out();
> >              |    uart_console_write() {
> >              |      serial8250_console_putchar() {
> >              |        wait_for_xmitr() {
> >   1.870 us   |          io_serial_in();
> >   2.238 us   |        }
> >   1.737 us   |        io_serial_out();
> >   4.318 us   |      }
> >   4.675 us   |    }
> >              |    wait_for_xmitr() {
> >   1.635 us   |      io_serial_in();
> >              |      __const_udelay() {
> >   1.125 us   |        delay_tsc();
> >   1.429 us   |      }
> > ...
> > ...
> > ...
> >   1.683 us   |      io_serial_in();
> >              |      __const_udelay() {
> >   1.248 us   |        delay_tsc();
> >   1.486 us   |      }
> >   1.671 us   |      io_serial_in();
> >   411.342 us |    }
> > 
> > In another machine, I measured a throughput of 11.5KB/s, with the serial
> > controller taking between 80-90us to send each byte. That matches the
> > expected throughput for a configuration of 115200 bps.
> > 
> > This patch changes the serial8250_console_write to use the 16550 fifo
> > if available. In my benchmarks I got around 25% improvement in the slow
> > machine, and no performance penalty in the fast machine.
> > 
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> 
> 
> On the current mainline and -next branches, I have noticed that the
> serial output on many of our Tegra boards is corrupted and so
> parsing the serial output is failing.
> 
> Before this change the serial console would appear as follows ...
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd071]
> [    0.000000] Linux version 5.16.0-rc6-00091-gadbfddc757ae (jonathanh@jonathanh-vm-01) (aarch64-linux-gnu-gcc (Linaro GCC 6.4-2017.08) 6.4.1 20170707, GNU ld (Linaro_Binutils-2017.08) 2.27.0.20161019) #15 SMP PREEMPT Tue Jan 25 00:15:25 PST 2022
> [    0.000000] Machine model: NVIDIA Jetson TX1 Developer Kit
> 
> And now I see ...
> 
> [    0.000000] Booting Linux on physicalfd071]
> [    0.000000] Linux version 5.16.0-rc6-athanh@j-linux-g017.08) Linaro_B20161019n 25 00:[    0.000000] Machine model: NVIDIA Jet[    0.000000] efi: UEFI not found.
> [    0.000000] NUMA: No NUMA configurati[    0.000000] NUMA: Faking a node at [m00000001[    0.000000] NUMA: NODE_DATA [mem 0x17[    0.000000] Zone ranges:
> 
> Bisecting is pointing to this commit. Let me know if there are any
> tests I can run. Otherwise we may need to disable this at least
> for Tegra.

Ick.  Does this uart have any other quirks assigned to it that are
somehow not getting assigned here?

thanks,

greg k-h
