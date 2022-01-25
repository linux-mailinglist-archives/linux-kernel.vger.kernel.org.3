Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED25249B4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575651AbiAYNKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575353AbiAYNHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:07:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C82C061401;
        Tue, 25 Jan 2022 05:07:10 -0800 (PST)
Date:   Tue, 25 Jan 2022 14:07:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643116027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=embjUAgs3gi9i4P5ZgYkqf5dsjaVIQcBbySu5M2DZ/4=;
        b=mPl51bvKhZD4jxXnaFxnUJPHpaaLtG8vCLhAnTQVaTfpvCnVIPa87OPGlNOdGL3HdIgSQY
        U1ulizrh3+qZrI7g0Ydl/3xLCE1jPDXbzJGHeIuWhVosT6zMlq4D2wHZRozGmY6Cwx7rIC
        hbducSS2Ik4JQc5IL+k8AuIgEGY7rm0xomkJfK3pZK//0opjeeNX6tnsseiYz5gGXXySpV
        VsmcbGfzYpT/f21tcwT8xgmuM79N/cxfymcwo9FiiEuLvsjbAu3ZwTZ+rJIl6+Aoravj+n
        0PScTorhlnSyPiuBNB4wfIXu0HZYoe3gxM0li5b/cYwMprTTiN1CU3fnZP309A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643116027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=embjUAgs3gi9i4P5ZgYkqf5dsjaVIQcBbySu5M2DZ/4=;
        b=QRhSjCd5kEh1gkOHcrlGmjZJRU5C6GOlaePtfRPX1y5jGv9fkUX7MEnKjBdVi0F85dE1pb
        JPBsfHnYFFzVyKCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/1] tty: serial: Use fifo in 8250 console driver
Message-ID: <Ye/1+Z8mEzbKbrqG@linutronix.de>
References: <20211222112831.1968392-1-wander@redhat.com>
 <20211222112831.1968392-2-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211222112831.1968392-2-wander@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-22 08:28:30 [-0300], Wander Lairson Costa wrote:
> Note: I am using a small test app + driver located at [0] for the
> problem description. serco is a driver whose write function dispatches
> to the serial controller. sertest is a user-mode app that writes n bytes
> to the serial console using the serco driver.
>=20
> While investigating a bug in the RHEL kernel, I noticed that the serial
> console throughput is way below the configured speed of 115200 bps in
> a HP Proliant DL380 Gen9. I was expecting something above 10KB/s, but
> I got 2.5KB/s.
>=20
> $ time ./sertest -n 2500 /tmp/serco
>=20
> real    0m0.997s
> user    0m0.000s
> sys     0m0.997s
>=20
> With the help of the function tracer, I then noticed the serial
> controller was taking around 410us seconds to dispatch one single byte:

was this the HW access or did this include the wait-for-fifo empty?

> $ trace-cmd record -p function_graph -g serial8250_console_write \
>    ./sertest -n 1 /tmp/serco
>=20
> $ trace-cmd report
>=20
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

So this includes waiting for empty slot. It is wait_for_xmitr() only.

> In another machine, I measured a throughput of 11.5KB/s, with the serial
> controller taking between 80-90us to send each byte. That matches the
> expected throughput for a configuration of 115200 bps.
>=20
> This patch changes the serial8250_console_write to use the 16550 fifo
> if available. In my benchmarks I got around 25% improvement in the slow
> machine, and no performance penalty in the fast machine.

Either the HW is slow on starting to work, or=E2=80=A6

What I noticed now in -rc1 is this output during boot:

|[    6.370196] ACPI: button: Power Button [PWRF]
|[    6.443501] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
|[0I 15
|      [0I 15
|            [No
|               [ld
|                  [a2
|                     [a20tm
|                           [a2nct
|                                 [s
|[s
|[s
|[s
=E2=80=A6
|[sk65,
|      [rt
|         [Pe
|            [a
|               [    6.873611] ata1: SATA link down (SStatus 0 SControl 300)
|[    6.879680] ata3: SATA link down (SStatus 0 SControl 300)

The kernel buffer reports here:

|[    6.370196] ACPI: button: Power Button [PWRF]
|[    6.443501] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
|[    6.450643] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200)=
 is a 16550A
|[    6.451625] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200)=
 is a 16550A
|[    6.453808] Non-volatile memory driver v1.3
|[    6.475688] loop: module loaded
|[    6.476401] ahci 0000:00:1f.2: version 3.0
|[    6.487238] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0=
x3f impl SATA mode

I did remove the last few lines but it appears that since the
initialisation of the port some of the lines got lost.

Do you see the same?

> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Sebastian
