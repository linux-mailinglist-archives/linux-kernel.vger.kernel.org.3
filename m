Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A586477EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbhLPVWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbhLPVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:22:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0437FC061574;
        Thu, 16 Dec 2021 13:22:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8ACFB82641;
        Thu, 16 Dec 2021 21:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F16DC36AEE;
        Thu, 16 Dec 2021 21:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639689767;
        bh=Rby8wL1R+RjVFuXBREBzbt9S6XLeBNTp+vc8b4HLPZo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OMQH3hlrCyXS7AW2yFCYCI6gAMn6YU9jHcBYW75R6j7qIag52Lfkv6XdFE/Qe3F1c
         +Fu8iIakEuAR0HFqo8GzKOu8zwz6zehyxzxEzi6nfSXCPqXtk+0WPg64W2FlILMyyV
         vnMdeVnuK/usJad6qIbm5yYdzzS5wmgZ7DMgMXBwILVvOVoaifKPafcBsfRDBhZtJv
         Ls0R0QM1C/vfTD2JNoxo3/BnTMdejA7gkS2K25rqC/3PK4towqfxbyhxR0l6lj9QeL
         bLyf83gwnUhN+eKjGdkOh6B4KzIipP4L58Tp/vTAGi/xF1hYbiyiYTBSL7eUFvS6oC
         J+jyY6oBigxNg==
Received: by mail-qv1-f44.google.com with SMTP id ke6so561267qvb.1;
        Thu, 16 Dec 2021 13:22:47 -0800 (PST)
X-Gm-Message-State: AOAM532KeVJ6ndrtc3LeTI09rvUnNRXR8EBuSNMk0Yvh4vkokcXb7qk/
        HxcOE8y8WQR7t/F75OAys+YWlCj3V56ZdJZKGg==
X-Google-Smtp-Source: ABdhPJwCk6EQOFeg0DPodBptUy75vtieDV400ot205d73s7buJc0fLIKkr8OqR4T6zfPLrh/d90m8q4caiFdkY4YT3k=
X-Received: by 2002:a0c:e54d:: with SMTP id n13mr86544qvm.16.1639689766539;
 Thu, 16 Dec 2021 13:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20211215224832.1985402-1-robh@kernel.org> <Ybp8QMyoW+MxTgmJ@piout.net>
In-Reply-To: <Ybp8QMyoW+MxTgmJ@piout.net>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 16 Dec 2021 15:22:35 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+QbqH3tsZPjJb-WUObpXos9TQ2b_aB5ih_KSPVQcYLLA@mail.gmail.com>
Message-ID: <CAL_Jsq+QbqH3tsZPjJb-WUObpXos9TQ2b_aB5ih_KSPVQcYLLA@mail.gmail.com>
Subject: Re: [PATCH] serial: atmel: Use platform_get_irq() to get the interrupt
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 5:37 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello Rob,
>
> On 15/12/2021 16:48:31-0600, Rob Herring wrote:
> > Accessing platform device resources directly has long been deprecated for
> > DT as IRQ resources may not be available at device creation time. Drivers
> > continuing to use static IRQ resources is blocking removing the static setup
> > from the DT core code.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/tty/serial/atmel_serial.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> > index 2c99a47a2535..9e57bfe523cf 100644
> > --- a/drivers/tty/serial/atmel_serial.c
> > +++ b/drivers/tty/serial/atmel_serial.c
> > @@ -2479,7 +2479,7 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
> >       port->fifosize          = 1;
> >       port->dev               = &pdev->dev;
> >       port->mapbase           = mpdev->resource[0].start;
>
> Shouldn't you fix that one at the same time?

Sure, I'll make a 2nd patch as it has little to do with $subject.

>
> > -     port->irq               = mpdev->resource[1].start;
> > +     port->irq               = platform_get_irq(mpdev, 0);
> >       port->rs485_config      = atmel_config_rs485;
> >       port->iso7816_config    = atmel_config_iso7816;
> >       port->membase           = NULL;
> > --
> > 2.32.0
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
