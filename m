Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA59849B4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346081AbiAYNVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:21:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1575958AbiAYNPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643116519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b6uhv29/bBioUMXWvKC0smhs78yaOc0ptvGFnbFZ+K8=;
        b=hrahxDyOEGANvDFM9feyWozqvJOAM0lU+ORwpx2Xh9k7gpPhCRQjPVZUCV+gZOA2MqSwDI
        p0VzZ3eAs464nqmVcc/ISYRKMzFGLycSTvnzrjZ4fh1VS+36+h9YakmSbcpLpNPN0RFxXT
        De9+aTU0Q7EKTb/iEVPVP6IYaJgG2xU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-dFpUkMmjOyuhXnB9GTL_7w-1; Tue, 25 Jan 2022 08:15:18 -0500
X-MC-Unique: dFpUkMmjOyuhXnB9GTL_7w-1
Received: by mail-ed1-f72.google.com with SMTP id f21-20020a50d555000000b00407a8d03b5fso4899289edj.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 05:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b6uhv29/bBioUMXWvKC0smhs78yaOc0ptvGFnbFZ+K8=;
        b=XmhqgXKgm+7V6rhUoi2Yxml5FOfv9y/wtjvT4yfJpsgAONvkNH4blq92fo/J/UMpgi
         Fuqyzr4lGuDJlcE+D/vodaTl+LwLV5/TgKQizT3tvTMnYzpQ7Db2PhThPyx9hhuY8njc
         YaOTr+KhBKkfb6zJLUhB9eT6CNvOJd80UGsHQmft12DeNx9ARLTfujH/ch4jQHCkGiOv
         fx2amx1yo8LDpw+hHLWVlW9ziL5e8t7jKuMuvfKLGiTTxgeyZs4tnvoFujLZ7MDLAcao
         BvhROXMpnG+cxR7ogU3T+Y7YfC3QyOyrJsgAdl5tgZ7Lb3B3Ps4n10v4rgxbDh9BpIrk
         FMJA==
X-Gm-Message-State: AOAM531sMNgym6g9h2FKoRCpFBfwhxRMKqlyHjn8dHqTyJ9+HZJU8FdD
        cloEZ7dd0KxZkN92FeD9/7JqOMHqOacGhfvdO82YtiTrQgFCboNAyrRSPS/Lg1+Ur/OJu7FtnfY
        +IDHMQc+2E0C3CbvzJVFhrDD8PWZMVLHR+XLRM/Nh
X-Received: by 2002:a17:906:7953:: with SMTP id l19mr16557101ejo.36.1643116516258;
        Tue, 25 Jan 2022 05:15:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz46zEhSL9/Fruejioqsp1hJ/snj4gmZBloBtUp8ByyJpvpd5ZhWqia8HSI978KkFXmv2UAyO6tjGM6IsMZSpM=
X-Received: by 2002:a17:906:7953:: with SMTP id l19mr16557078ejo.36.1643116515844;
 Tue, 25 Jan 2022 05:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20211222112831.1968392-1-wander@redhat.com> <20211222112831.1968392-2-wander@redhat.com>
 <Ye/1+Z8mEzbKbrqG@linutronix.de>
In-Reply-To: <Ye/1+Z8mEzbKbrqG@linutronix.de>
From:   Wander Costa <wcosta@redhat.com>
Date:   Tue, 25 Jan 2022 10:15:04 -0300
Message-ID: <CAAq0SUmdGinqdWXrHztx8g9hb+5UF5rDJJjVeVMj3CQ=Fw3kJg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] tty: serial: Use fifo in 8250 console driver
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:07 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-12-22 08:28:30 [-0300], Wander Lairson Costa wrote:
> > Note: I am using a small test app + driver located at [0] for the
> > problem description. serco is a driver whose write function dispatches
> > to the serial controller. sertest is a user-mode app that writes n byte=
s
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
>
> was this the HW access or did this include the wait-for-fifo empty?
>
> > $ trace-cmd record -p function_graph -g serial8250_console_write \
> >    ./sertest -n 1 /tmp/serco
> >
> > $ trace-cmd report
> >
> >             |  serial8250_console_write() {
> >  0.384 us   |    _raw_spin_lock_irqsave();
> >  1.836 us   |    io_serial_in();
> >  1.667 us   |    io_serial_out();
> >             |    uart_console_write() {
> >             |      serial8250_console_putchar() {
> >             |        wait_for_xmitr() {
> >  1.870 us   |          io_serial_in();
> >  2.238 us   |        }
> >  1.737 us   |        io_serial_out();
> >  4.318 us   |      }
> >  4.675 us   |    }
> >             |    wait_for_xmitr() {
> >  1.635 us   |      io_serial_in();
> >             |      __const_udelay() {
> >  1.125 us   |        delay_tsc();
> >  1.429 us   |      }
> > ...
> > ...
> > ...
> >  1.683 us   |      io_serial_in();
> >             |      __const_udelay() {
> >  1.248 us   |        delay_tsc();
> >  1.486 us   |      }
> >  1.671 us   |      io_serial_in();
> >  411.342 us |    }
>
> So this includes waiting for empty slot. It is wait_for_xmitr() only.
>
> > In another machine, I measured a throughput of 11.5KB/s, with the seria=
l
> > controller taking between 80-90us to send each byte. That matches the
> > expected throughput for a configuration of 115200 bps.
> >
> > This patch changes the serial8250_console_write to use the 16550 fifo
> > if available. In my benchmarks I got around 25% improvement in the slow
> > machine, and no performance penalty in the fast machine.
>
> Either the HW is slow on starting to work, or=E2=80=A6
>
> What I noticed now in -rc1 is this output during boot:
>
> |[    6.370196] ACPI: button: Power Button [PWRF]
> |[    6.443501] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> |[0I 15
> |      [0I 15
> |            [No
> |               [ld
> |                  [a2
> |                     [a20tm
> |                           [a2nct
> |                                 [s
> |[s
> |[s
> |[s
> =E2=80=A6
> |[sk65,
> |      [rt
> |         [Pe
> |            [a
> |               [    6.873611] ata1: SATA link down (SStatus 0 SControl 3=
00)
> |[    6.879680] ata3: SATA link down (SStatus 0 SControl 300)
>
> The kernel buffer reports here:
>
> |[    6.370196] ACPI: button: Power Button [PWRF]
> |[    6.443501] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> |[    6.450643] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 11520=
0) is a 16550A
> |[    6.451625] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 11520=
0) is a 16550A
> |[    6.453808] Non-volatile memory driver v1.3
> |[    6.475688] loop: module loaded
> |[    6.476401] ahci 0000:00:1f.2: version 3.0
> |[    6.487238] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps=
 0x3f impl SATA mode
>
> I did remove the last few lines but it appears that since the
> initialisation of the port some of the lines got lost.
>
> Do you see the same?

There is another thread[1] reporting some issues with this patch.
There, this diff seems to fix the problems, could you please try and
report if it works for you too?

diff --git a/drivers/tty/serial/8250/8250_port.c
b/drivers/tty/serial/8250/8250_port.c
index 2abb3de11a48..d3a93e5d55f7 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3343,7 +3343,7 @@ static void serial8250_console_fifo_write(struct
uart_8250_port *up,
 {
        int i;
        const char *end =3D s + count;
-       unsigned int fifosize =3D up->port.fifosize;
+       unsigned int fifosize =3D up->tx_loadsz;
        bool cr_sent =3D false;

        while (s !=3D end) {
@@ -3409,8 +3409,8 @@ void serial8250_console_write(struct
uart_8250_port *up, const char *s,
        }

        use_fifo =3D (up->capabilities & UART_CAP_FIFO) &&
-               port->fifosize > 1 &&
-               (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &&
+               up->tx_loadsz > 1 &&
+               (up->fcr & UART_FCR_ENABLE_FIFO) &&
                /*
                 * After we put a data in the fifo, the controller will sen=
d
                 * it regardless of the CTS state. Therefore, only use fifo

[1] https://lore.kernel.org/all/fa42a60c-954a-acc0-3962-f00427153f78@nvidia=
.com/


>
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>
> Sebastian
>

