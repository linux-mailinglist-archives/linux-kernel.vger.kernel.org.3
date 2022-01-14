Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A132048E8FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbiANLMS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jan 2022 06:12:18 -0500
Received: from mail-vk1-f176.google.com ([209.85.221.176]:35499 "EHLO
        mail-vk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiANLMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:12:17 -0500
Received: by mail-vk1-f176.google.com with SMTP id 19so5628828vkl.2;
        Fri, 14 Jan 2022 03:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NN2frd6kQv764ZSbGbhAVE/E8qM9eEb48i6osAL/H1U=;
        b=WSV5zCx7qoxG27ziCCj6ITHmFUPm6Bwmsme5OvtNvRAvGyYv4Gxgn8rUivoXOsUFnE
         NJasfatAXTfPrkmUeg3/5WzenDg5o+/EhBPRlRYaiKsu2cb1kR35BFtSyFP0Sx+xUTpl
         oT6MQc//yR/GhUGZKY3bDmczOcKvjItHQn39c5cCVNHB76e3gqGV7C+I9p9MMX4Vw+Ma
         feN1oxiHNONO1f3n0gDu99BMAWAa8xhyQ/EGbz7T5LOl5DEeg1y9H/JlVOpRA0zSdEh9
         XeZYQE6h+tSOvygmUbChy0IL5PEgp8Dymy0GI4Pi0n+suBtqapmLBLoAlWCIiVmjiPpD
         PvKQ==
X-Gm-Message-State: AOAM530U/K+qnehBbNKLjTQJLkQcPd69liUjIuPvfT3obptbZRCWUMkV
        nTxrD5GgiLvEQGsae0YSfK0oKssuF8AaHLFu
X-Google-Smtp-Source: ABdhPJy/EkJSh2R5ETLOwVKLY+oHtUnKRGSpifrSG/MlBdUqw4r7J/rq1Yh9U6admyrIHFLThqI2nQ==
X-Received: by 2002:a05:6122:218b:: with SMTP id j11mr430208vkd.19.1642158736572;
        Fri, 14 Jan 2022 03:12:16 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id l8sm2317706vse.28.2022.01.14.03.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 03:12:15 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id p37so16285220uae.8;
        Fri, 14 Jan 2022 03:12:15 -0800 (PST)
X-Received: by 2002:a67:e905:: with SMTP id c5mr3835204vso.68.1642158734969;
 Fri, 14 Jan 2022 03:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20220113201920.3201760-1-laurent@vivier.eu> <20220113201920.3201760-4-laurent@vivier.eu>
 <CAK8P3a2QzMiga0FFVmTuefnq1OzsgyopiJN2he8043K0TRF1ng@mail.gmail.com> <a53e6d46-114f-7bb2-70b9-113c5f8a9c0e@vivier.eu>
In-Reply-To: <a53e6d46-114f-7bb2-70b9-113c5f8a9c0e@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jan 2022 12:12:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXN=2tjizcjA4vZ1FOSXDBNBkKH355fkfspgO9bOhp6_w@mail.gmail.com>
Message-ID: <CAMuHMdXN=2tjizcjA4vZ1FOSXDBNBkKH355fkfspgO9bOhp6_w@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] clocksource/drivers: Add a goldfish-timer clocksource
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Fri, Jan 14, 2022 at 12:03 PM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 14/01/2022 à 11:46, Arnd Bergmann a écrit :
> > On Thu, Jan 13, 2022 at 9:19 PM Laurent Vivier <laurent@vivier.eu> wrote:
> >> +static int goldfish_timer_set_oneshot(struct clock_event_device *evt)
> >> +{
> >> +       struct goldfish_timer *timerdrv = ced_to_gf(evt);
> >> +       void __iomem *base = timerdrv->base;
> >> +
> >> +       __raw_writel(0, base + TIMER_ALARM_HIGH);
> >> +       __raw_writel(0, base + TIMER_ALARM_LOW);
> >> +       __raw_writel(1, base + TIMER_IRQ_ENABLED);
> >
> > As mentioned elsewhere, the __raw_* accessors are not portable, please
> > use readl()/writel() here, or possibly ioread32_be()/iowrite32_be() for
> > the big-endian variant.
>
> We can't use readl()/writel() here because it's supposed to read from a little endian device, and
> goldfish endianness depends on the endianness of the machine.
>
> For goldfish, readl()/writel() works fine on little-endian machine but not on big-endian machine.
>
> On m68k, you have:
>
> #define readl(addr)      in_le32(addr)
> #define writel(val,addr) out_le32((addr),(val))
>
> and with goldfish it's wrong as the device is not little-endian, it is big-endian like the machine.
>
> same comment with ioread32_be()/iowrite32_be(): it will work on big-endian machine not on little-endian.
>
> We need an accessor that doesn't byteswap the value, that accesses it natively, and in all other
> parts of the kernel __raw_writel() and __raw_readl() are used.

Hence Arnd's suggestion to define custom accessors in the Goldfish
RTC driver, that map to {read,write}l() on little-endian, and to
io{read,write}32_be() on big-endian.

BTW, I'd go for io{read,write}32() on little endian instead, for
symmetry.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
