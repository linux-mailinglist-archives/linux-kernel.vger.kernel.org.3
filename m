Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3B7506755
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350247AbiDSJCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350267AbiDSJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:02:34 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10416B876;
        Tue, 19 Apr 2022 01:59:51 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id q75so4289800qke.6;
        Tue, 19 Apr 2022 01:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tS14D5PGmg/JLCqgQ04J95Jt9tqRjNAbrf1/kgwkng=;
        b=duf6Gf8DnFDySzprLxJRPqjJacUoAkFKBAEiMVRMfLgDvkr1RZnUbp2X9jGfo0pbBw
         3lihBbqPdKGoOYozgCT0GalQ8nd9HIXrcl6DYl0Rw3Pv73+HZPkg5920toXhs0bcF1Fp
         onFBA3RvUp7ubUwF2R/gJaRah4tjA4edNZy0cNQj0f6TYflvvQ5gnbyuchhgdfvkjfRb
         nJ5Z9iO0EfVH+v9XkUDk4CYq2fj/+DpYEDG8/G2/g/hI9+o0n0yCy64PioDhRqMEckyj
         s6+MIQl0FIjc7CPUcT6NFULrGum97VFjMFfljQ8HQn7D7kMyuSWTGaGsmjLVgWvU4tvT
         HObA==
X-Gm-Message-State: AOAM531tdmIoQkhOOha/QfJEgKqsi178+qNNShY4RrQVwwV60HYTIQWR
        cgcSldTX0gD21xnVzMmCF1mji4D1U/TiUA==
X-Google-Smtp-Source: ABdhPJxEozh2DMFXsMVnUH8FLob95bDsBhAJJ4tjh+6WGam56QaPC4JWhorlliMEDC9t9b6Isb6JHA==
X-Received: by 2002:a05:620a:2441:b0:69c:3451:2a60 with SMTP id h1-20020a05620a244100b0069c34512a60mr8674837qkn.181.1650358789985;
        Tue, 19 Apr 2022 01:59:49 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id n22-20020ac85b56000000b002f1d7a2867dsm8945619qtw.67.2022.04.19.01.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 01:59:49 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ebf4b91212so164793507b3.8;
        Tue, 19 Apr 2022 01:59:49 -0700 (PDT)
X-Received: by 2002:a81:5210:0:b0:2ef:21e3:54dd with SMTP id
 g16-20020a815210000000b002ef21e354ddmr14521561ywb.438.1650358789297; Tue, 19
 Apr 2022 01:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220419085330.1178925-1-valentin.caron@foss.st.com> <20220419085330.1178925-2-valentin.caron@foss.st.com>
In-Reply-To: <20220419085330.1178925-2-valentin.caron@foss.st.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Apr 2022 10:59:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVCeuC5qStugnssWKUeOVWxd_3XyYtS0mrZpqQVaXAP2w@mail.gmail.com>
Message-ID: <CAMuHMdVCeuC5qStugnssWKUeOVWxd_3XyYtS0mrZpqQVaXAP2w@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] serial: stm32: remove infinite loop possibility in
 putchar function
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Tue, Apr 19, 2022 at 10:54 AM Valentin Caron
<valentin.caron@foss.st.com> wrote:
> Rework stm32_usart_console_putchar() function in order to anticipate
> the case where the character can never be sent.
>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>

Thanks for your patch!

> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -1640,10 +1640,16 @@ static void stm32_usart_console_putchar(struct uart_port *port, unsigned char ch
>  {
>         struct stm32_port *stm32_port = to_stm32_port(port);
>         const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
> +       u32 isr;
> +       int ret;
>
> -       while (!(readl_relaxed(port->membase + ofs->isr) & USART_SR_TXE))
> -               cpu_relax();
> -
> +       ret = readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr, isr,
> +                                               (isr & USART_SR_TXE), 100,
> +                                               STM32_USART_TIMEOUT_USEC);
> +       if (ret != 0) {
> +               dev_err(port->dev, "Error while sending data in UART TX : %d\n", ret);

Does it make sense to print this message, i.e. will the user ever see it?
Or is the failure above temporary?
I assume that you have seen this trigger?

> +               return;
> +       }
>         writel_relaxed(ch, port->membase + ofs->tdr);
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
