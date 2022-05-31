Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFC953935D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbiEaOvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiEaOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:51:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57592C0;
        Tue, 31 May 2022 07:51:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gi33so27202962ejc.3;
        Tue, 31 May 2022 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RyUYTxEhGVj/YIsL/hTx00frob1EwhFyyAlxk5eJqJA=;
        b=c5jUWMojZvgZti6/EtmJ57YkLR6oDynJR2USvxGJHFWnb6HRX6qskr/MZ/exC8PpkG
         DAMqrH6bm7rN8kHrecyf0yQ1+80KGh1OSii93TVVIWfTxJ70JSMsWtT5QTuPgqcUk0EG
         MXV0K0uAxv64DWc6UbAdf9MS711tYfA2WXBbPoH8z0pG6JxTtKE7TLaVzH/VirVfhXN0
         qLSTVOQG41Z5miblPbIHxV42N+/oUUfkhewl8vc56MB+26EhkHf+c8ugyR95iuHxrlQ6
         opXKLDH9/q//+qz3Hzn33JYku9Iqvf1noOjMraprySoaxsIJ3hkqwHfn2Qkk0sO86a+i
         NkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyUYTxEhGVj/YIsL/hTx00frob1EwhFyyAlxk5eJqJA=;
        b=75chPzIq1oeAZ5oHw2NYJISPe9uCEtc9O8B/IHNf0scxs7gGyOk0HgY+HZ+alIsdvU
         iUA1ylbF4k+GgufL8p9TBecSc0fJ4WpEUPFwOUdw20TEEs0P+ZwD7dcMGCRCAvaKJ5jo
         t7k0SuwHYyzl4zdevonxFN5XtOmu0CprIspdlO9YG2jjHYuQBn1BHCg8RzUfirSd8lgB
         hKGqWp1TziX8CNaAjI/SdnodDU5ieSP3cDDMn5J/Hxd7npU+ygETki/Df68xL/ZiBewo
         xfcfEh96dhJLqvcu1r1bLD5x9Gh0BTVDnHn7rhazSxIi+5bN5qxYB2pz2efXOtVZcbd8
         FNYQ==
X-Gm-Message-State: AOAM531yf5zJd4rgbbykAeSDCvR42e3v0aClaz6M83esJ2bf11MjOCVl
        ZUsk3JlW0J7GY/Qq2I3myIRjaRYqbboRhVJDAjG5QdJRjW5smQ==
X-Google-Smtp-Source: ABdhPJyyUxrqkDU9Pdnv/wBT4Ukiky8NfAEOA6SUjdD/jhw8Z0mgIWoKCw/A1Uiiw0BwLN05D8FyNz3mtYHWbLct3XQ=
X-Received: by 2002:a17:907:2ce3:b0:6ff:1447:d3a4 with SMTP id
 hz3-20020a1709072ce300b006ff1447d3a4mr27196777ejc.497.1654008700721; Tue, 31
 May 2022 07:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220530221429.1248083-1-demonsingur@gmail.com> <20220530221429.1248083-3-demonsingur@gmail.com>
In-Reply-To: <20220530221429.1248083-3-demonsingur@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 May 2022 16:51:04 +0200
Message-ID: <CAHp75Vdi8q1SkLz-SC9pr1Hj_tO=6d42g8OQM7zE8dMUGCG9Wg@mail.gmail.com>
Subject: Re: [PATCH 3/4] serial: max310x: make accessing revision id interface-agnostic
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
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

On Tue, May 31, 2022 at 3:55 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
>
> SPI can only use 5 address bits, since one bit is reserved for
> specifying R/W and 2 bits are used to specify the UART port.
> To access registers that have addresses past 0x1F, an extended
> register space can be enabled by writing to the GlobalCommand
> register (address 0x1F).
>
> I2C uses 8 address bits. The R/W bit is placed in the slave
> address, and so is the UART port. Because of this, registers
> that have addresses higher than 0x1F can be accessed normally.
>
> To access the RevID register, on SPI, 0xCE must be written to
> the 0x1F address to enable the extended register space, after
> which the RevID register is accessible at address 0x5. 0xCD
> must be written to the 0x1F address to disable the extended
> register space.
>
> On I2C, the RevID register is accessible at address 0x25.
>
> Create an interface config struct, and add a method for
> toggling the extended register space and a member for the RevId
> register address. Implement these for SPI.

...

>  struct max310x_port {
>         const struct max310x_devtype *devtype;
> +       const struct max310x_if_cfg *if_cfg;
>         struct regmap           *regmap;

I believe the most used pointer is regmap and putting it to be a first
member will make pointer arithmetic no-op at compile time. That said,
adding new member is better after this one.

>         struct clk              *clk;

...

> +       ret = s->if_cfg->set_ext_reg_en(dev, true);

It sounds like a voodoo speech. Can we name the callback better?
->extended_reg_enable() ?

>         if (ret)
>                 return ret;

...

>  static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
> +                        const struct max310x_if_cfg *if_cfg,
>                          struct regmap **regmaps, int irq)

It should be commented on the other patch, but since I can't see it in
my mailbox (yet) I put it here. So,
looking into usage of regmaps parameter it logically should be declared as

struct regmap *regmaps[]

(yes, I know that there is no difference for the compiler, but code
human reader).

...

> -       return max310x_probe(&spi->dev, devtype, regmaps, spi->irq);
> +       return max310x_probe(&spi->dev, devtype, &max310x_spi_if_cfg, regmaps,
> +                            spi->irq);

Can still be on one line, no?

-- 
With Best Regards,
Andy Shevchenko
