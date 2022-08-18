Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5C6597F10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbiHRHTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiHRHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:18:58 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F968C006;
        Thu, 18 Aug 2022 00:18:57 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a4so523958qto.10;
        Thu, 18 Aug 2022 00:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=96Fu9Q82W8bT1rRZfU++c0oI3k3yt63UqY8b1dg1TC4=;
        b=cYYb/lMWH/blELa8K53woeD9hnWX1+Q2w5sN4+kUmjcGV2L548qGYZkS4vX2OfWi5l
         YC3EQeB1qEcQSJ8QQW6yGqrApPjz3FIggbVc4SNKEa8/yf6SE+HMRmZ4fykGRMvu3mqb
         4Iy8j9xtN3sjmNFN4+em9yRL6C9UyIj7LYFmfETByjnqP+fu/R7pMY3qZ47lPvhMTXcD
         4draO15r1OoLAcRAcKwL0jEq+T/6pc3zHLvaIRcRX+IeuduC3SCFkcmMzCGg/T27HzrE
         rQSGG32K7LGnWCy/fi+qTqjQqZjXfS6hfvq50GQu05FeTtAFoitzULXfRSgFqlC+v9vv
         sjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=96Fu9Q82W8bT1rRZfU++c0oI3k3yt63UqY8b1dg1TC4=;
        b=CuVhyaze+p1QNphJB8LeQGLRf/SFFwhyxCmEISQsBNApik0hTV7AXU/42SxReIZ/Em
         T31FBYdxYFk+gy0ExZOZlHwUjebMLsBA1x6LUhl8q2gooVQUDxYgs89a9ZIcp5JCA4Yk
         2XHYYrcR4B7dk6/uVkNc1oMjz6ugBf669QO4Qc49HnGv39fdA3Begs47cenU4U5YsvFd
         S56oFWXLAYd15fv6FRQpjMZG+zrirxzylNpmyR0GbNfosJcD4Ohs5W9kH9zfvxKgN1kG
         dB+y39bACPgWl8AZMLqLeNzJFmrxFippf6TCPILtjXB15fxxmXI4NpWwK33HID9Y3+wv
         vT5g==
X-Gm-Message-State: ACgBeo1iTNViWLNgi/M/V7wbSQP9ODkTP/iS30SoR4ecgJxika5U6wgc
        T7sca26v5Xzm+wSMHBJYFSM2dsHshnmzwETrIPK7dPveJ5A=
X-Google-Smtp-Source: AA6agR586pCiTcqAZLaiIIfQjJOw4iAtAbXVHmGEmsT1yb5p+b1J4ukXq0N04Yfc/N3LB53JJjPWjLFBdXWEKhqI/BU=
X-Received: by 2002:a05:622a:14cf:b0:343:5b6:68ca with SMTP id
 u15-20020a05622a14cf00b0034305b668camr1451554qtx.195.1660807136374; Thu, 18
 Aug 2022 00:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220816120759.11552-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220816120759.11552-1-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Aug 2022 10:18:19 +0300
Message-ID: <CAHp75Vf-2daFdRiB_ZqA6QshaEO5iLn-XQn8fBENZoCkkf_nKA@mail.gmail.com>
Subject: Re: [PATCH 1/1] serial: 8250: Add helper for clearing IER
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 3:14 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> A number of places want to clear IER with the same CAP_UUE trick.
> Create a helper for that.

No objections,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 39b35a61958c..25e4761e3c57 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -752,6 +752,14 @@ static void serial8250_set_sleep(struct uart_8250_po=
rt *p, int sleep)
>         serial8250_rpm_put(p);
>  }
>
> +static void serial8250_clear_IER(struct uart_8250_port *up)
> +{
> +       if (up->capabilities & UART_CAP_UUE)
> +               serial_out(up, UART_IER, UART_IER_UUE);
> +       else
> +               serial_out(up, UART_IER, 0);
> +}
> +
>  #ifdef CONFIG_SERIAL_8250_RSA
>  /*
>   * Attempts to turn on the RSA FIFO.  Returns zero on failure.
> @@ -1329,10 +1337,7 @@ static void autoconfig(struct uart_8250_port *up)
>         serial8250_out_MCR(up, save_mcr);
>         serial8250_clear_fifos(up);
>         serial_in(up, UART_RX);
> -       if (up->capabilities & UART_CAP_UUE)
> -               serial_out(up, UART_IER, UART_IER_UUE);
> -       else
> -               serial_out(up, UART_IER, 0);
> +       serial8250_clear_IER(up);
>
>  out_unlock:
>         spin_unlock_irqrestore(&port->lock, flags);
> @@ -2142,10 +2147,7 @@ static void serial8250_put_poll_char(struct uart_p=
ort *port,
>          *      First save the IER then disable the interrupts
>          */
>         ier =3D serial_port_in(port, UART_IER);
> -       if (up->capabilities & UART_CAP_UUE)
> -               serial_port_out(port, UART_IER, UART_IER_UUE);
> -       else
> -               serial_port_out(port, UART_IER, 0);
> +       serial8250_clear_IER(up);
>
>         wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
>         /*
> @@ -3383,11 +3385,7 @@ void serial8250_console_write(struct uart_8250_por=
t *up, const char *s,
>          *      First save the IER then disable the interrupts
>          */
>         ier =3D serial_port_in(port, UART_IER);
> -
> -       if (up->capabilities & UART_CAP_UUE)
> -               serial_port_out(port, UART_IER, UART_IER_UUE);
> -       else
> -               serial_port_out(port, UART_IER, 0);
> +       serial8250_clear_IER(up);
>
>         /* check scratch reg to see if port powered off during system sle=
ep */
>         if (up->canary && (up->canary !=3D serial_port_in(port, UART_SCR)=
)) {
> --
> 2.30.2
>


--=20
With Best Regards,
Andy Shevchenko
