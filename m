Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D5D4CA42F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241615AbiCBLwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbiCBLwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:52:15 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C308BA75B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:51:32 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id l12so1864060ljh.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 03:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTrGdMDWQ+1A7dYzCk6TbFd6dqfxQ2KILpXjfdugkSA=;
        b=e8J1qC7gEUkDauQ/SvucUsIBb44MqH38JrytyAopOIpx9AlEfP0ZIlsZT4UE44sXCV
         gPvXVvWWXbU6C1vaZolRSh53mZI+HSRaty9LTP0+REFySM9IIXjxx4Zp7k0mpWfWj1fo
         bazHPIBwZeWB/3BSNUXMdGmtdu/P4G3LLSnvQ69NAeguvBI5b7AgsrRqgG6kIs2R0UUp
         kokz1DBXeEiQv+ybwQDV8MW8aFK/Rishq+NDZ2AO45/TTswPZBvTus7crDY+a5eMhUqr
         YyZWL5n14aLHmdbiqFb8u/Gyci7kP3xT9ItwqfLKNgMQHSz8TkGjr/697v0k4N+aIX6e
         /kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTrGdMDWQ+1A7dYzCk6TbFd6dqfxQ2KILpXjfdugkSA=;
        b=xReAde+0x52KuC/nNvsOgKrmeXctVYx3C/Xl9oXdZ/sMetYUhoPEPCRnphS1HzzHsh
         3F5C67r1t8jAcf3fj6Xx/fRCdE1bilDxSoaXTNIcsSUdr/B+mst/8K50POmJMepmu8S/
         3wq0dGsZgNF8JFuidJj20O39mUrsu8CqowwZvVP0n6v3w/IE6QQaFtV7hvuMwXQ+bvG2
         pY8ZoDxHX4rBJsrvlBg3yKBO9f6pkOyTX9JY4PPEizwELtdcgvkUpw9SggX6BPiTQ2wd
         8/fSOF9GM0FiBIt3ahkotB3jfFFjxdi/szu/TzVVVpXjzOUuDskjI+oPlRmwXesKbO1K
         RDZQ==
X-Gm-Message-State: AOAM533ZqlmSHcKODT499QjkrJBKj62qkSxK2jLVP4B8yCxUbUAOPJ7p
        ocAekZ29boI+c1wCtdR5RL+OR2TO4m/hk5daXS3STQ==
X-Google-Smtp-Source: ABdhPJwS2G1eiZJOoHJsLwgtNNztW4acgzTs5l4t1s8KYseKrLtx13lw6/mpFULZC57xMYfs39EwDUa/WeERuxh3uF0=
X-Received: by 2002:a2e:b16a:0:b0:244:e31c:ea96 with SMTP id
 a10-20020a2eb16a000000b00244e31cea96mr20861501ljm.500.1646221890128; Wed, 02
 Mar 2022 03:51:30 -0800 (PST)
MIME-Version: 1.0
References: <20220302101925.210810-1-woodylin@google.com> <c13930a5-85ab-5a2c-54e5-15fc5bc87b17@canonical.com>
In-Reply-To: <c13930a5-85ab-5a2c-54e5-15fc5bc87b17@canonical.com>
From:   Woody Lin <woodylin@google.com>
Date:   Wed, 2 Mar 2022 19:51:18 +0800
Message-ID: <CAHn4DecKKzrxPrOWPhdQf88g+01vqO=9=qPM3hOEdVVAFhScfw@mail.gmail.com>
Subject: Re: [PATCH] serial: samsung: Add samsung_early_read to support early kgdboc
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Cheng <markcheng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 7:14 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 02/03/2022 11:19, Woody Lin wrote:
> > The 'kgdboc_earlycon_init' looks for boot console that has both .read
> > and .write callbacks. Adds 'samsung_early_read' to samsung_tty.c's early
> > console to support kgdboc.
> >
> > Signed-off-by: Woody Lin <woodylin@google.com>
> > ---
> >  drivers/tty/serial/samsung_tty.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> > index d002a4e48ed9..eeb30d016ff1 100644
> > --- a/drivers/tty/serial/samsung_tty.c
> > +++ b/drivers/tty/serial/samsung_tty.c
> > @@ -2949,6 +2949,7 @@ static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
> >
> >  struct samsung_early_console_data {
> >       u32 txfull_mask;
> > +     u32 rxfifo_mask;
> >  };
> >
> >  static void samsung_early_busyuart(struct uart_port *port)
> > @@ -2983,6 +2984,26 @@ static void samsung_early_write(struct console *con, const char *s,
> >       uart_console_write(&dev->port, s, n, samsung_early_putc);
> >  }
> >
> > +static int samsung_early_read(struct console *con, char *s, unsigned int n)
> > +{
> > +     struct earlycon_device *dev = con->data;
> > +     struct samsung_early_console_data *data = dev->port.private_data;
>
> This can be const.
>
> Rest looks ok.
>

Thanks, PATCH v2 is uploaded.

Regards,
Woody

>
> Best regards,
> Krzysztof
