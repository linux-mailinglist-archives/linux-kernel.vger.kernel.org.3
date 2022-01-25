Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA0B49B17D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346748AbiAYKVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:21:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245053AbiAYKTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643105948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q6LqklHRLIbthTQQ/rUdfdHvN2/Q+qVOvOtwYpemCwA=;
        b=VMf/0Ke41ZYp9G48JIvYSNL9yWU8LEoB3AYLDUdsZ/1XZusK4jYfNVM7L30HKuBtOcgFHu
        tEtIkHGOavO73E+gKFtbGzEjoUrB7wyVHrhILEL1ohY49B74mTc/bMegrk4IiCi5WAhSrp
        BQki9fN0UosNtRb1E8IAniMHtTgDQmw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-VUzxnExmNXSILPUoenDZHg-1; Tue, 25 Jan 2022 05:19:07 -0500
X-MC-Unique: VUzxnExmNXSILPUoenDZHg-1
Received: by mail-ej1-f71.google.com with SMTP id i21-20020a1709063c5500b006b4c7308c19so3323256ejg.14
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6LqklHRLIbthTQQ/rUdfdHvN2/Q+qVOvOtwYpemCwA=;
        b=CUuA4KnlY6dJWd2w7NqQuPwL1zd1z9jFZC6buMjYq38wEOhhTVhVQXbdm7rz8GkVwk
         CV75scmyerDdS0+KOdTzDP77MxpN+mgY06ERYxX/otnrwWvjv+9JMCiRADm4fwuRujrV
         y6+qg/JMJjAYL4fYKwc7PfVJxkp+XfR0EOlzkZRNCYrJyQLb5o/0mpcNgOQacf9E4fZR
         RzBx3YNyg7BCtjz1LlJN5hb78S1rhRJ2ssoQAetS52p+47zBum4V11rUFoFLXbhb4NqM
         PVfVp8VwzCWbwFjM7gkr1XrCMoWj+/sjluK6iISdEBQzDQWxvW1hF/wC2FT7bRwv9x8X
         PY7A==
X-Gm-Message-State: AOAM532dWy3ZsMHZzWDnvbVKOpwanVTOOoYTV9ercocI3QjmTxBGT0AN
        c82AyXe6VU5C3AnJJGk6L3ojEl2cGzOK5DlNn3Nvp+8AfNDuwDOhQqxZZZA2Nza3aOnOXIpXatm
        NzRmgmKQv1nSE5dFgjEa6SAB8xGhRj8lTulwoUKtu
X-Received: by 2002:aa7:d916:: with SMTP id a22mr20101445edr.316.1643105944880;
        Tue, 25 Jan 2022 02:19:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1ZCiX9r1ZM7j98bMV6q/xlimOOlVJwPCaPGhxxe9DC6X3cZjpLy91XJEk3Z8ND92qEgxwEbuOH5xNlRDywwE=
X-Received: by 2002:aa7:d916:: with SMTP id a22mr20101428edr.316.1643105944675;
 Tue, 25 Jan 2022 02:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20211029201402.428284-1-wander@redhat.com> <a1ac6254-f79e-d131-fa2a-c7ad714c6d4a@nvidia.com>
 <f451e67d-adb9-01e8-bd11-bf7804863b4b@kernel.org> <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
In-Reply-To: <8e57400f-d6a8-bd42-6214-fca1fe37a972@kernel.org>
From:   Wander Costa <wcosta@redhat.com>
Date:   Tue, 25 Jan 2022 07:18:53 -0300
Message-ID: <CAAq0SUm-NQ6kwxhSJsOwHaBsi7dagAy8Pj4vOHOd6wy33Nqp2g@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Use fifo in 8250 console driver
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Johan Hovold <johan@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 6:36 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 25. 01. 22, 10:08, Jiri Slaby wrote:
> > On 25. 01. 22, 9:39, Jon Hunter wrote:
> >>
> >> On 29/10/2021 21:14, wander@redhat.com wrote:
> >>> From: Wander Lairson Costa <wander@redhat.com>
> >>>
> >>> Note: I am using a small test app + driver located at [0] for the
> >>> problem description. serco is a driver whose write function dispatches
> >>> to the serial controller. sertest is a user-mode app that writes n bytes
> >>> to the serial console using the serco driver.
> ...
> >>> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> >>
> >>
> >> On the current mainline and -next branches, I have noticed that the
> >> serial output on many of our Tegra boards is corrupted and so
> >> parsing the serial output is failing.
> >>
> >> Before this change the serial console would appear as follows ...
> >>
> >> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd071]
> >> [    0.000000] Linux version 5.16.0-rc6-00091-gadbfddc757ae
> >> (jonathanh@jonathanh-vm-01) (aarch64-linux-gnu-gcc (Linaro GCC
> >> 6.4-2017.08) 6.4.1 20170707, GNU ld (Linaro_Binutils-2017.08)
> >> 2.27.0.20161019) #15 SMP PREEMPT Tue Jan 25 00:15:25 PST 2022
> >> [    0.000000] Machine model: NVIDIA Jetson TX1 Developer Kit
> >>
> >> And now I see ...
> >>
> >> [    0.000000] Booting Linux on physicalfd071]
> >> [    0.000000] Linux version 5.16.0-rc6-athanh@j-linux-g017.08)
> >> Linaro_B20161019n 25 00:[    0.000000] Machine model: NVIDIA Jet[
> >> 0.000000] efi: UEFI not found.
> >> [    0.000000] NUMA: No NUMA configurati[    0.000000] NUMA: Faking a
> >> node at [m00000001[    0.000000] NUMA: NODE_DATA [mem 0x17[
> >> 0.000000] Zone ranges:
> >>
> >> Bisecting is pointing to this commit. Let me know if there are any
> >> tests I can run. Otherwise we may need to disable this at least
> >> for Tegra.
> >
> >
> > The test is bogus:
> >          use_fifo = (up->capabilities & UART_CAP_FIFO) &&
> >                  port->fifosize > 1 &&
> >                  (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO)
> >
> > FCR is write only. Reading it, one gets IIR contents.
>
> In particular, the test is checking whether there is no interrupt
> pending (UART_FCR_ENABLE_FIFO == UART_IIR_NO_INT). So it oscillates
> between use_fifo and not, depending on the interrupt state of the chip.
>
> Could you change it into something like this:
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3396,7 +3396,7 @@ void serial8250_console_write(struct
> uart_8250_port *up, const char *s,
>
>          use_fifo = (up->capabilities & UART_CAP_FIFO) &&
>                  port->fifosize > 1 &&
> -               (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &&
> +               (up->fcr & UART_FCR_ENABLE_FIFO) &&
>                  /*
>                   * After we put a data in the fifo, the controller will
> send
>                   * it regardless of the CTS state. Therefore, only use fifo
>

Indeed I made a mistake here. Independent of the reported this, this
should be fixed.
Jiri, do you intend to send an official patch or should I do so?

>
> And see whether it fixes the issue. Anyway, of what port type is the
> serial port (what says dmesg/setserial about that)?
>
> thanks,
> --
> js
> suse labs
>

