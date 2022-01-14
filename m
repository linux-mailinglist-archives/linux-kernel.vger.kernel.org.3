Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5A48E9B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbiANMKt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jan 2022 07:10:49 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:41909 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiANMJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:09:52 -0500
Received: by mail-ua1-f45.google.com with SMTP id p37so16518984uae.8;
        Fri, 14 Jan 2022 04:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kEdzLzYRPE0boS0yd+k+Jhoa91HE+G13L0nN6bFEhyo=;
        b=uG/lrgVvyPtXBXKup/zC1yOaIV1YIQgYLR1XzqEVgI0c4PCqMueIXgN7h9Nu2XIMW2
         uezCy0sAEWkYBjeygeIODKENt95d56LcGOrolaac0Ub+dxd4UhVn6Zz8VJDWrwuuGw89
         DPui8Hid6pLeRFi1Q7+ttV30t/J8EMMWuu+Q0kOA0yb2IKq3nl0hg+aWi2ZHAqUrsk8U
         5YsJCpwUkIZwjMZO9feST2vwyjYIuonn9a5AjErm6nL2cJjWApD8H3QgOpJkjpDC+7nX
         TXW0DXd2qT+tnOxxaG521bsIFzxHJ2nuVWUWYoSVl6BRMEzVAyI6GXbwujom9h9TXGyf
         YliA==
X-Gm-Message-State: AOAM533RrRul1EkJntV/DvSO7aPGOJdoWeTPR7uclbKFvgBS/qj3GVCR
        eZSH/mXVDHP4Ht6YUb/fUcWLt3NDjdn2JD75
X-Google-Smtp-Source: ABdhPJzBnzRe9G6dkHfIj3aekSn3OxjRbkPv2cdAbgyHNPt8gY77Dc0wzBQEeT4pnMmlkHp/eLj/sA==
X-Received: by 2002:a67:f550:: with SMTP id z16mr3974367vsn.23.1642162191911;
        Fri, 14 Jan 2022 04:09:51 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 7sm307853vkr.23.2022.01.14.04.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 04:09:51 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id m15so16530745uap.6;
        Fri, 14 Jan 2022 04:09:51 -0800 (PST)
X-Received: by 2002:a9f:3e09:: with SMTP id o9mr4045837uai.114.1642162191265;
 Fri, 14 Jan 2022 04:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20220113201920.3201760-1-laurent@vivier.eu> <20220113201920.3201760-4-laurent@vivier.eu>
 <CAK8P3a2QzMiga0FFVmTuefnq1OzsgyopiJN2he8043K0TRF1ng@mail.gmail.com>
 <a53e6d46-114f-7bb2-70b9-113c5f8a9c0e@vivier.eu> <CAMuHMdXN=2tjizcjA4vZ1FOSXDBNBkKH355fkfspgO9bOhp6_w@mail.gmail.com>
 <d5f59216-793a-f5cf-2ab6-e3cf3a4a855f@vivier.eu>
In-Reply-To: <d5f59216-793a-f5cf-2ab6-e3cf3a4a855f@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Jan 2022 13:09:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWbsF8O34JpwpGba=w_dh4DcDT3_FKbE8RGtVun=iw6Og@mail.gmail.com>
Message-ID: <CAMuHMdWbsF8O34JpwpGba=w_dh4DcDT3_FKbE8RGtVun=iw6Og@mail.gmail.com>
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

On Fri, Jan 14, 2022 at 12:31 PM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 14/01/2022 à 12:12, Geert Uytterhoeven a écrit :
> > On Fri, Jan 14, 2022 at 12:03 PM Laurent Vivier <laurent@vivier.eu> wrote:
> >> Le 14/01/2022 à 11:46, Arnd Bergmann a écrit :
> >>> On Thu, Jan 13, 2022 at 9:19 PM Laurent Vivier <laurent@vivier.eu> wrote:
> >>>> +static int goldfish_timer_set_oneshot(struct clock_event_device *evt)
> >>>> +{
> >>>> +       struct goldfish_timer *timerdrv = ced_to_gf(evt);
> >>>> +       void __iomem *base = timerdrv->base;
> >>>> +
> >>>> +       __raw_writel(0, base + TIMER_ALARM_HIGH);
> >>>> +       __raw_writel(0, base + TIMER_ALARM_LOW);
> >>>> +       __raw_writel(1, base + TIMER_IRQ_ENABLED);
> >>>
> >>> As mentioned elsewhere, the __raw_* accessors are not portable, please
> >>> use readl()/writel() here, or possibly ioread32_be()/iowrite32_be() for
> >>> the big-endian variant.
> >>
> >> We can't use readl()/writel() here because it's supposed to read from a little endian device, and
> >> goldfish endianness depends on the endianness of the machine.
> >>
> >> For goldfish, readl()/writel() works fine on little-endian machine but not on big-endian machine.
> >>
> >> On m68k, you have:
> >>
> >> #define readl(addr)      in_le32(addr)
> >> #define writel(val,addr) out_le32((addr),(val))
> >>
> >> and with goldfish it's wrong as the device is not little-endian, it is big-endian like the machine.
> >>
> >> same comment with ioread32_be()/iowrite32_be(): it will work on big-endian machine not on little-endian.
> >>
> >> We need an accessor that doesn't byteswap the value, that accesses it natively, and in all other
> >> parts of the kernel __raw_writel() and __raw_readl() are used.
> >
> > Hence Arnd's suggestion to define custom accessors in the Goldfish
> > RTC driver, that map to {read,write}l() on little-endian, and to
> > io{read,write}32_be() on big-endian.
> >
> > BTW, I'd go for io{read,write}32() on little endian instead, for
> > symmetry.
>
> You mean something like that:
>
> #ifdef CONFIG_CPU_BIG_ENDIAN
> #define raw_ioread32 ioread32be
> #define raw_iowrite32 iowrite32be
> #else
> #define raw_ioread32 ioread32
> #define raw_iowrite32 iowrite32
> #endif
>
> and then use raw_ioread32()/raw_iowrite32() rather than readl()/writel()?

Exactly.

You may want to use names that have less chance of conflicting in
the future, e.g. goldfish_{read,write}().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
