Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEED1505058
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbiDRMYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbiDRMWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:22:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD71CB33;
        Mon, 18 Apr 2022 05:18:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y10so9116656ejw.8;
        Mon, 18 Apr 2022 05:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rBeq7r1LUr17BD3wzjfHgTsyokZ2FymR+3nXomEXu6g=;
        b=Xx1vnBsJpTyBssMLec8mWL15r4vB/b1/DWYrrTDsZnx2crQM4QEDvWC1X35cKEKTw5
         7FVXpOzPkGNXScfkmXRupkAvTHLeBqzzDsn6HcCjyRW7QI9+CmkoALZK8AYNZxWy1Vtf
         vYx5aG7d1KK2A6okFaDTud0BRjgIP9b+6mZyLgNkXsDWEII974cqla2ix6TR9p9HQ3Xu
         5d+p4lAGna3lySSQ8/seWqb6pSTbfMBjtSZrSSkECgoy81rnwU5J1xlKf1Icv7aYoyQV
         1JSwfjcmHfbMsGx2pcbuIfpx30qH+cx7UenAXVLXlG1SOEY15IjTJLYBHDh9cfpzvlfP
         gzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBeq7r1LUr17BD3wzjfHgTsyokZ2FymR+3nXomEXu6g=;
        b=ZRUdqZVj8KkYi8QjYtlTzhx1+7Rs4QqAcJf3qLyKGx5eKZRPYDNTJTyfn+2JlWHDVY
         n64JPSzK7/RJGWC7Mq1INh0w3GpYnLGS4Dc8m1nwCxWUfkFMxyL+TiI1+N9Ad9WmB1Tp
         BgQCJQeQ8y3xqKkPz1GTtinwbaRguyYvMg8hxgsEHVKfVtz/s2F7La8XTfFSIfovjZUU
         IH7YjePYgM+8tZlbPZjVtCeYfB8iwB3bPj7qjHin3LwNZ5yLw7oUoTDaWiPbeJBJQgHW
         wuoRJoyfYcvPWmtTzYrDMXBDOhkpxKMsF4XgdYbX8oKAI1Qr5gljjApiqEpruaQ6iwtg
         w+6A==
X-Gm-Message-State: AOAM533LDUpaamTixsN1iVbbr+svqg7VPc/OlzAkhbz8thqebTneu8ot
        hVJt1k7RRpyPIhaXLdXdZq4PmXKsomg4so3Fv2g=
X-Google-Smtp-Source: ABdhPJxP7RO/30UkizWDp1oKjdyab95YDtjf823TDAl+jEaenz5Jg7MGHYnl6v3ieJuCs7vAkX0IAv0IC6KFJDktHH4=
X-Received: by 2002:a17:907:8a14:b0:6e8:9691:62f7 with SMTP id
 sc20-20020a1709078a1400b006e8969162f7mr8964573ejc.497.1650284294799; Mon, 18
 Apr 2022 05:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2204161848030.9383@angie.orcam.me.uk> <alpine.DEB.2.21.2204162154250.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204162154250.9383@angie.orcam.me.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Apr 2022 15:17:38 +0300
Message-ID: <CAHp75Vem7twcS4bKXJZM4SfE+g9qC3rxtytTKpQsyszZpnrLqw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] serial: 8250: Export ICR access helpers for
 internal use
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 2:02 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> Make ICR access helpers available outside 8250_port.c, however retain
> them as ordinary static functions so as not to regress code generation.
>
> This is because `serial_icr_write' is currently automatically inlined by
> GCC, however `serial_icr_read' is not.  Making them both static inline
> would grow code produced, e.g.:
>
> $ i386-linux-gnu-size --format=gnu 8250_port-{old,new}.o
>       text       data        bss      total filename
>      15065       3378          0      18443 8250_port-old.o
>      15289       3378          0      18667 8250_port-new.o
>
> and:
>
> $ riscv64-linux-gnu-size --format=gnu 8250_port-{old,new}.o
>       text       data        bss      total filename
>      16980       5306          0      22286 8250_port-old.o
>      17124       5306          0      22430 8250_port-new.o
>
> while making them external would needlessly add a new module interface
> and lose the benefit from `serial_icr_write' getting inlined outside
> 8250_port.o.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
See one nit-pick below.

> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> New change in v4, factored out from 5/5.
> ---
>  drivers/tty/serial/8250/8250.h      |   23 +++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c |   21 ---------------------
>  2 files changed, 23 insertions(+), 21 deletions(-)
>
> linux-serial-8250-icr-access.diff
> Index: linux-macro/drivers/tty/serial/8250/8250.h
> ===================================================================
> --- linux-macro.orig/drivers/tty/serial/8250/8250.h
> +++ linux-macro/drivers/tty/serial/8250/8250.h
> @@ -120,6 +120,29 @@ static inline void serial_out(struct uar
>         up->port.serial_out(&up->port, offset, value);
>  }
>
> +/*
> + * For the 16C950
> + */
> +static void __maybe_unused serial_icr_write(struct uart_8250_port *up,
> +                                           int offset, int value)

I think you may drop __maybe_unused here, because it's always used by
the code below. So it will be eliminated altogether when the below
won't be used.

> +{
> +       serial_out(up, UART_SCR, offset);
> +       serial_out(up, UART_ICR, value);
> +}
> +
> +static unsigned int __maybe_unused serial_icr_read(struct uart_8250_port *up,
> +                                                  int offset)
> +{
> +       unsigned int value;
> +
> +       serial_icr_write(up, UART_ACR, up->acr | UART_ACR_ICRRD);
> +       serial_out(up, UART_SCR, offset);
> +       value = serial_in(up, UART_ICR);
> +       serial_icr_write(up, UART_ACR, up->acr);
> +
> +       return value;
> +}
> +
>  void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p);
>
>  static inline int serial_dl_read(struct uart_8250_port *up)
> Index: linux-macro/drivers/tty/serial/8250/8250_port.c
> ===================================================================
> --- linux-macro.orig/drivers/tty/serial/8250/8250_port.c
> +++ linux-macro/drivers/tty/serial/8250/8250_port.c
> @@ -538,27 +538,6 @@ serial_port_out_sync(struct uart_port *p
>  }
>
>  /*
> - * For the 16C950
> - */
> -static void serial_icr_write(struct uart_8250_port *up, int offset, int value)
> -{
> -       serial_out(up, UART_SCR, offset);
> -       serial_out(up, UART_ICR, value);
> -}
> -
> -static unsigned int serial_icr_read(struct uart_8250_port *up, int offset)
> -{
> -       unsigned int value;
> -
> -       serial_icr_write(up, UART_ACR, up->acr | UART_ACR_ICRRD);
> -       serial_out(up, UART_SCR, offset);
> -       value = serial_in(up, UART_ICR);
> -       serial_icr_write(up, UART_ACR, up->acr);
> -
> -       return value;
> -}
> -
> -/*
>   * FIFO support.
>   */
>  static void serial8250_clear_fifos(struct uart_8250_port *p)



-- 
With Best Regards,
Andy Shevchenko
