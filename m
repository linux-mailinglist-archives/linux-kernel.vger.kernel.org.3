Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A54148F91B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 20:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiAOTlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 14:41:45 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:41525 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiAOTlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 14:41:44 -0500
Received: by mail-ua1-f51.google.com with SMTP id i10so1108922uab.8;
        Sat, 15 Jan 2022 11:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7Z/KJMX0LABLzo0oa4ju7aJO8/H79numgHrSYFIz3E=;
        b=8NnucBiwQBRnttuF11uJ/WmtptDn0hjyOP8QP4GJzjPEt6T8ZyCiyAnTIQZGLBCsdd
         C0BQU7hSjBHoTgIpcBTR216l44V4UqrWonBhfWeJiF++xrV266V4gTHEA0N/BYaWruFX
         TBmTCEsJxhjJG0UIDK2GTLPL92VMWVKVl56hOVh7BuL0rjUjOHxYyWjB6RR5G6dQ27U8
         eAfeWikBYRgvo2K+Npi5xTfyCcfjEeQkwn+4m4AtHaccVf4+Gyr4bVdwYGqburUU7ULr
         U8tnof5nVHfPLkal03fxxYO4fr4Q+M427xn6PYXWa9mC50iv01ZNsZtob4eqBFoNf7Gq
         RuVw==
X-Gm-Message-State: AOAM531y3UECRDxl49c96LrRYcUjOaef/E61n5XQaqaEjXvTWMw5u62f
        aVZdBO9hQcc7RCRfhcFKUmvqKD21hvbfCw==
X-Google-Smtp-Source: ABdhPJxaDheJumjl/9GM06TB17t/oBe0B7x1UIGmyCB1ey9dMlmS+KRoW8OyTe5l9z1pPq0X1blwRw==
X-Received: by 2002:a67:c40e:: with SMTP id c14mr5341840vsk.73.1642275703216;
        Sat, 15 Jan 2022 11:41:43 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id f1sm2609714uae.5.2022.01.15.11.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 11:41:42 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id w206so7884435vkd.10;
        Sat, 15 Jan 2022 11:41:42 -0800 (PST)
X-Received: by 2002:a1f:5702:: with SMTP id l2mr5701617vkb.33.1642275702507;
 Sat, 15 Jan 2022 11:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20220115193245.3777833-1-laurent@vivier.eu> <20220115193245.3777833-5-laurent@vivier.eu>
In-Reply-To: <20220115193245.3777833-5-laurent@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 15 Jan 2022 20:41:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXBrPM5Zw+wtM3gi6k5n-i_OoWs_eZff27458hqepZV7A@mail.gmail.com>
Message-ID: <CAMuHMdXBrPM5Zw+wtM3gi6k5n-i_OoWs_eZff27458hqepZV7A@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] m68k: introduce a virtual m68k machine
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Sat, Jan 15, 2022 at 8:33 PM Laurent Vivier <laurent@vivier.eu> wrote:
> This machine allows to have up to 3.2 GiB and 128 Virtio devices.
>
> It is based on android goldfish devices.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Thanks for your patch (the new versions keep on coming quickly).

> --- /dev/null
> +++ b/arch/m68k/virt/platform.c

> +static int __init virt_platform_init(void)
> +{
> +       const struct resource goldfish_tty_res[] = {
> +               DEFINE_RES_MEM(virt_bi_data.tty.mmio, 1),
> +               DEFINE_RES_IRQ(virt_bi_data.tty.irq),
> +       };
> +       /* this is the second gf-rtc, the first one is used by the scheduler */
> +       const struct resource goldfish_rtc_res[] = {
> +               DEFINE_RES_MEM(virt_bi_data.rtc.mmio + 0x1000, 0x1000),
> +               DEFINE_RES_IRQ(virt_bi_data.rtc.irq + 1),
> +       };
> +       extern unsigned long min_low_pfn;

checkpatch keeps on complaining.
#include <linux/memblock.h> instead?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
