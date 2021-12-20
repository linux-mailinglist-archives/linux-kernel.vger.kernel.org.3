Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B71C47B1C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 18:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbhLTRC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 12:02:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239881AbhLTRC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 12:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640019745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IMU+crRbPmjYFM4aE3gKGGI6VKsFtp6amlEI5UhnTVM=;
        b=DLEhdh9DaaBuyO2mgjD1NDDVdMhJDvt7EPDmZznwIYGcKD6jng4qhGI3J7lTkytF1RmjWY
        flIgfZSiveprPwLfsAy4LpQiZs1kv7kTWAN1eyKSqzFQhIbkzuMeEIWDD3ITRy6fD84PBW
        5JAAv0PF1V6PlDfp3PUQZ7slPouIG9s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-FIfPXNbAOa2f6u_dVsewhg-1; Mon, 20 Dec 2021 12:02:24 -0500
X-MC-Unique: FIfPXNbAOa2f6u_dVsewhg-1
Received: by mail-ed1-f70.google.com with SMTP id v19-20020a056402349300b003f7eba50675so8103310edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 09:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMU+crRbPmjYFM4aE3gKGGI6VKsFtp6amlEI5UhnTVM=;
        b=7qEDyXYQwXMS+LXvZrVhyqzjRHQV1CgW8GJllj9e3yImQDZ9ChRFVNuhtQLjHDQFS+
         FKtinoVNXG9IcyHBjXJu5qo35iRwThGnBZDtnulqiq1qy8jfNctHEKs7J9zqtltQykMg
         7fCV8BYXmYKQq2bv9OlQMgALtXMZhGZVkH+EplYk4tO26X7zUqbPzhKCTtcMVAxAsyeD
         CFMK73S1/iJJmklFTHK3Xt48YjPD+mu5N5bmKAo/yRWgLdiTqE3rVOodloKkOcAsLmwr
         UTNzdrX8b6zHBzW8gdOSxQ9bPm7YPH4+OP/O7l4QxAnjriqj/IxRPoHlZ/Bnt8fYC2UE
         j+FA==
X-Gm-Message-State: AOAM531X6kbwesDrDgSNQOwuBH5oSNDWZ7Xy28Ou8nIsSosMxnuwSH6z
        Gm6v+OV8iC0yn4UprtHeHNqwccecmSHWTSk379yIrS8YUu25z02qDMkH8fGjZY5P8aQtnTXpY8e
        lyIq1qRtPy9fsnpryR9Lvxvr2DJl0ZRqChAGNsS/X
X-Received: by 2002:a05:6402:d05:: with SMTP id eb5mr17171221edb.360.1640019743123;
        Mon, 20 Dec 2021 09:02:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3uewW7dW2JUgtnmE5hrswtZYTJhzi+M3Hljl0JXA6W2KOd/ltCxASxmEBtTAIgQ7/+1mGgrxoW1uwmM7YFrg=
X-Received: by 2002:a05:6402:d05:: with SMTP id eb5mr17171189edb.360.1640019742880;
 Mon, 20 Dec 2021 09:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20211104171734.137707-1-wander@redhat.com> <YcClBlhwp4arGWtw@kroah.com>
In-Reply-To: <YcClBlhwp4arGWtw@kroah.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Mon, 20 Dec 2021 14:02:11 -0300
Message-ID: <CAAq0SUmVmyALNYUbM5dy3D0=Bp=ukNoNdodc1yxYQjm1SnBgAQ@mail.gmail.com>
Subject: Re: [PATCH v2] tty: serial: Use fifo in 8250 console driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 12:45 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 04, 2021 at 02:17:31PM -0300, wander@redhat.com wrote:
> > From: Wander Lairson Costa <wander@redhat.com>
> >
> > Note: I am using a small test app + driver located at [0] for the
> > problem description. serco is a driver whose write function dispatches
> > to the serial controller. sertest is a user-mode app that writes n bytes
> > to the serial console using the serco driver.
> >
> > Recently I got a report of a soft lockup while loading a bunch a
> > scsi_debug devices (> 500).
> >
> > While investigating it, I noticed that the serial console throughput
> > (called by the printk code) is way below the configured speed of 115200
> > bps in a HP Proliant DL380 Gen9 server. I was expecting something above
> > 10KB/s, but I got 2.5KB/s. I then built a simple driver [0] to isolate
> > the console from the printk code. Here it is:
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
> >
> > In another machine, I measured a throughput of 11.5KB/s, with the serial
> > controller taking between 80-90us to send each byte. That matches the
> > expected throughput for a configuration of 115200 bps.
> >
> > This patch changes the serial8250_console_write to use the 16550 fifo
> > if available. In my artificial benchmark I could get a throughput
> > increase up to 100% in some cases, but in the real case described at the
> > beginning the gain was of about 25%.
> >
> > [0] https://github.com/walac/serial-console-test
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  drivers/tty/serial/8250/8250.h      |  3 ++
> >  drivers/tty/serial/8250/8250_port.c | 63 +++++++++++++++++++++++++----
> >  2 files changed, 59 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
> > index 6473361525d1..c711bf118cc1 100644
> > --- a/drivers/tty/serial/8250/8250.h
> > +++ b/drivers/tty/serial/8250/8250.h
> > @@ -83,6 +83,9 @@ struct serial8250_config {
> >  #define UART_CAP_MINI        BIT(17) /* Mini UART on BCM283X family lacks:
> >                                        * STOP PARITY EPAR SPAR WLEN5 WLEN6
> >                                        */
> > +#define UART_CAP_CWFIFO BIT(18) /* Use the UART Fifo in
> > +                              * serial8250_console_write
> > +                              */
>
> Why do you need a new bit?  Why can't you just do this change for all
> devices that have a fifo?  Why would you _not_ want to do this for all
> devices that have a fifo?
>
The v1 patch [1] didn't have this extra bit. Andy suggested [2] to add
it so we only enabled this new code on tested controllers as a
precaution.
If it doesn't make sense to you, feel free to consider the v1 patch [1].

[1] https://lore.kernel.org/all/20211029201402.428284-1-wander@redhat.com/
[2] https://lore.kernel.org/all/CAHp75Vf6DjNcPWpE4Dh3SuzUMJbFQjq1UNCkrCa60uw35SpqKg@mail.gmail.com/

> thanks,
>
> greg k-h
>

