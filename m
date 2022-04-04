Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1644F15D9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351850AbiDDN3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbiDDN3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA9893BFB8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649078864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fA3QEC/J4uwNO/VuL8noIhoYNRgoUgQqydq3qWm/bX8=;
        b=E0VQViYndtwHxccpEgrWlPOZHBvEdql2eKXkDsHmbFuvNSzxWSmXn9qeGH2JhRZZ+PlOyF
        E7r7H4P9G61Hh98sbMNFNIfYsP6NYa+oIEq/MBaDX96Yb49Flzvbm++a4WEp2MblWa8jnO
        MCwvrmEzO+Dey0hyAUi8mIB3UxzovVA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-5K7IwP_qM3CYiTqf6-olmw-1; Mon, 04 Apr 2022 09:27:43 -0400
X-MC-Unique: 5K7IwP_qM3CYiTqf6-olmw-1
Received: by mail-lf1-f69.google.com with SMTP id i33-20020a0565123e2100b0044aa6befbe6so3742073lfv.18
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 06:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fA3QEC/J4uwNO/VuL8noIhoYNRgoUgQqydq3qWm/bX8=;
        b=26ZZKx7lvAQcKvSYL2nKH8/TwzYp89nLnj0sq+SMP8PgzByZkZcaeMo/2g51P8WsAY
         /FP4AfnP/k197PUekcBXTVZncTJosMHauZBBbWQCtj86bobaa/bZ/J1zdNbSeg+VaWKh
         KgD7/WCRc+q7WY2hrufS5xgKLdNjASAtmDi+KJExuXBoh8o0B9GCeRVxKjWj0uU2OUtk
         eTL5pG6M0KqIwnyqXyE9TOcKNMgyCMgJR2vDQbpbQxff05GmXYR5TERdtapf7Est4uOc
         qp6r58OQK1wEsJ09vMY02VEf3l0c3Ut1ZnPKYrltdrhJKitNfm81PwBM44BoiqGiUZHJ
         nxFg==
X-Gm-Message-State: AOAM533SBB0gEPePSyNg2bWtfVwt5NrOHLqeJY2qmI4yFtDvTz5ZnPZw
        N4/P/XiUZX5sEW51KVxHfVBUOa/vsvXcxUffHRGC+6C/4viD1rViVP9yMfwJ10DsqMYVAEC/tG6
        Vz3qUAMtQOOggYwUGskB66gbqZNwnbr6vs9H+PQry
X-Received: by 2002:a05:6512:1585:b0:445:908b:ad71 with SMTP id bp5-20020a056512158500b00445908bad71mr22009169lfb.200.1649078862065;
        Mon, 04 Apr 2022 06:27:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3wxX7ukk/8p5oUa8pql/EHH/fhejvtNBX+mEYrWomsbqP6fX+aeO9S+2VGedeUtOnqoaWXau++bebvLESFZs=
X-Received: by 2002:a05:6512:1585:b0:445:908b:ad71 with SMTP id
 bp5-20020a056512158500b00445908bad71mr22009136lfb.200.1649078861804; Mon, 04
 Apr 2022 06:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220401194645.1738747-1-wander@redhat.com> <20220401194645.1738747-2-wander@redhat.com>
 <Ykq7FXhQfsvr9TtC@smile.fi.intel.com>
In-Reply-To: <Ykq7FXhQfsvr9TtC@smile.fi.intel.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Mon, 4 Apr 2022 10:27:30 -0300
Message-ID: <CAAq0SUn4Z2y4-7fJcZ-T5rrnuwdJCt2+W-bGGmCxU6t+pA165A@mail.gmail.com>
Subject: Re: [PATCH v6] serial/8250: Use fifo in 8250 console driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        =?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?= <andre.goddard@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Jon Hunter <jonathanh@nvidia.com>, phil@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 6:32 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Apr 01, 2022 at 04:46:42PM -0300, Wander Lairson Costa wrote:
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
> > if available. In my benchmarks I got around 25% improvement in the slow
> > machine, and no performance penalty in the fast machine.
>
> ...
>
> > +     use_fifo = (up->capabilities & UART_CAP_FIFO) &&
> > +             /*
> > +              * BCM283x requires to check the fifo
> > +              * after each byte.
> > +              */
> > +             !(up->capabilities & UART_CAP_MINI) &&
>
> Perhaps you need to also comment why we are using tx_loadsz and not fifosize.
>

Maybe it is better to document their difference in the struct
declaration and not in a random usage.


[snip]

