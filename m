Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988F54839F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 02:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiADBmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 20:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiADBma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 20:42:30 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63275C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 17:42:30 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v22so32645143qtx.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 17:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bA+1Kfch/eEHX+p3OKR2yhTUBKCXwVdeM9Biyu299k4=;
        b=V4aLrlwXyNbjx9n9aOLuJgkBYKuOtmVi16XsIW2IP/6Rk0BCOJgZ7B1V22NKkX3xE8
         MdmY4SH07/rSPArbJ0U9EstMo65FLJP9XMOskCZ2mUTbVxQAZVVJ+zD2n2IfnA8JhUoY
         aUXx46OsWhBxJUSACiTyg0wEB0GxRMtpjX3cYqx15IWSvBMHdCt6n6vcU/jqk/Qw9Ate
         zz5PHY4wpNav/kWoYYA1AA/EumjNh6zcdCLrPJIOwYVjCWDaWkoQh8OJDL2tXdpqGXbI
         /U8Cghp9AxBwsmCxwRAIyj9V38AIXLkkPkoSYFotEf4q8xAM6m1jkML5oeJryE95J4Mb
         qXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bA+1Kfch/eEHX+p3OKR2yhTUBKCXwVdeM9Biyu299k4=;
        b=U/op4A3htCuO7RTkE96Fb7pw0xN0cZWAYnSSgW2k+TJIc6vacgVUjxa1CsRsLSH+ML
         0y1zFB4cmLJINzyf/GPRm6WVpTdNIdX79wQ8PaYJ/KmuF9bPX7eMyVricrgZW3ayrJgg
         L8mZZrHtdAqyvBwyOW1SLWelzAqd3+nA8hk/7yjsBe9mEEXIUaDwZfUfcT4E6OH4XTX1
         KC5pgHSBJo9Nlu9PCk7+NstSwKtk6NCBES5NapLXdqnwCgBUZdcdscYrfajdFLn3WrE4
         qCB8tikKjWyJJWz0TQkjJfSc6gSiLvJS/R//nIN7isYt6qF4pJzejfdbsYYKFpfAEi20
         Ll/w==
X-Gm-Message-State: AOAM5319un+nJaIFnJEneFuxXI3H/N2ZiqhAZhznFjgPG8IqOaysinfb
        05oun4SDY/BjXqnLpivWJyrCN2ztPfPbLm164PsAqQH2tDk=
X-Google-Smtp-Source: ABdhPJxNrV6RgUUxBNHOTX3wOigJb+qX/QV2VcJtOzcWEjwdEoGSOe5vHw/axcitIiggU+SZPbFlNC2K12MmnbvJ9wo=
X-Received: by 2002:a05:622a:5cd:: with SMTP id d13mr41664680qtb.47.1641260549564;
 Mon, 03 Jan 2022 17:42:29 -0800 (PST)
MIME-Version: 1.0
References: <1640930555-12220-1-git-send-email-weidong.guanguan@gmail.com>
In-Reply-To: <1640930555-12220-1-git-send-email-weidong.guanguan@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 4 Jan 2022 09:43:10 +0800
Message-ID: <CADBw62qcAvJc7asZnF=6b8oFWq1Uk2iGynaBfSH2n07p_WexsA@mail.gmail.com>
Subject: Re: [PATCH] clocksource: fix counter with 32bit may wrap around
To:     weidong guan <weidong.guanguan@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "weidong.guan" <weidong.guan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 31, 2021 at 2:03 PM weidong guan <weidong.guanguan@gmail.com> wrote:
>
> From: "weidong.guan" <weidong.guan@unisoc.com>
>
> When the system sleep time exceeds 30+ hours, counter with 32bit may wrap

I am curious about which condition the system can suspend for more
than 30+ hours, from my understanding, the phone will be woken up
periodically.

> around, resulting in insufficient sleep compensation time. So We should
> enable 64bit counter mode of sprd timer and use the given mult/shift
> to ensure that sufficient counts can be generated.
>
> Signed-off-by: weidong.guan <weidong.guan@unisoc.com>
> ---
>  drivers/clocksource/timer-sprd.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
> index 430cb99..7eac059 100644
> --- a/drivers/clocksource/timer-sprd.c
> +++ b/drivers/clocksource/timer-sprd.c
> @@ -30,6 +30,7 @@
>  #define TIMER_VALUE_SHDW_HI    0x1c
>
>  #define TIMER_VALUE_LO_MASK    GENMASK(31, 0)
> +#define TIMER_VALUE_64BIT_MASK GENMASK_ULL(63, 0)
>
>  static void sprd_timer_enable(void __iomem *base, u32 flag)
>  {
> @@ -57,10 +58,12 @@ static void sprd_timer_disable(void __iomem *base)
>         writel_relaxed(val, base + TIMER_CTL);
>  }
>
> -static void sprd_timer_update_counter(void __iomem *base, unsigned long cycles)
> +static void
> +sprd_timer_update_counter(void __iomem *base, unsigned long long cycles)
>  {
>         writel_relaxed(cycles & TIMER_VALUE_LO_MASK, base + TIMER_LOAD_LO);
> -       writel_relaxed(0, base + TIMER_LOAD_HI);
> +       writel_relaxed((cycles >> 32) & TIMER_VALUE_LO_MASK,
> +                       base + TIMER_LOAD_HI);
>  }
>
>  static void sprd_timer_enable_interrupt(void __iomem *base)
> @@ -82,7 +85,7 @@ static int sprd_timer_set_next_event(unsigned long cycles,
>         struct timer_of *to = to_timer_of(ce);
>
>         sprd_timer_disable(timer_of_base(to));
> -       sprd_timer_update_counter(timer_of_base(to), cycles);
> +       sprd_timer_update_counter(timer_of_base(to), (u64)cycles);
>         sprd_timer_enable(timer_of_base(to), 0);
>
>         return 0;
> @@ -93,7 +96,8 @@ static int sprd_timer_set_periodic(struct clock_event_device *ce)
>         struct timer_of *to = to_timer_of(ce);
>
>         sprd_timer_disable(timer_of_base(to));
> -       sprd_timer_update_counter(timer_of_base(to), timer_of_period(to));
> +       sprd_timer_update_counter(timer_of_base(to),
> +                                 (u64)timer_of_period(to));
>         sprd_timer_enable(timer_of_base(to), TIMER_CTL_PERIOD_MODE);
>
>         return 0;
> @@ -162,15 +166,19 @@ static int __init sprd_timer_init(struct device_node *np)
>
>  static u64 sprd_suspend_timer_read(struct clocksource *cs)
>  {
> -       return ~(u64)readl_relaxed(timer_of_base(&suspend_to) +
> -                                  TIMER_VALUE_SHDW_LO) & cs->mask;
> +       u64 value_hi, value_lo;
> +
> +       value_hi = (u64)readl_relaxed(timer_of_base(&suspend_to) + TIMER_VALUE_SHDW_HI);
> +       value_lo = (u64)readl_relaxed(timer_of_base(&suspend_to) + TIMER_VALUE_SHDW_LO);
> +       return ~(u64)((value_hi << 32) + value_lo) & cs->mask;
>  }
>
>  static int sprd_suspend_timer_enable(struct clocksource *cs)
>  {
>         sprd_timer_update_counter(timer_of_base(&suspend_to),
> -                                 TIMER_VALUE_LO_MASK);
> -       sprd_timer_enable(timer_of_base(&suspend_to), TIMER_CTL_PERIOD_MODE);
> +                                 TIMER_VALUE_64BIT_MASK);
> +       sprd_timer_enable(timer_of_base(&suspend_to),
> +                         TIMER_CTL_PERIOD_MODE|TIMER_CTL_64BIT_WIDTH);
>
>         return 0;
>  }
> @@ -183,10 +191,12 @@ static void sprd_suspend_timer_disable(struct clocksource *cs)
>  static struct clocksource suspend_clocksource = {
>         .name   = "sprd_suspend_timer",
>         .rating = 200,
> +       .mult   = 0x1DCD650,
> +       .shift  = 10,

And why?

>         .read   = sprd_suspend_timer_read,
>         .enable = sprd_suspend_timer_enable,
>         .disable = sprd_suspend_timer_disable,
> -       .mask   = CLOCKSOURCE_MASK(32),
> +       .mask   = CLOCKSOURCE_MASK(64),
>         .flags  = CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
>  };
>
> @@ -198,8 +208,7 @@ static int __init sprd_suspend_timer_init(struct device_node *np)
>         if (ret)
>                 return ret;
>
> -       clocksource_register_hz(&suspend_clocksource,
> -                               timer_of_rate(&suspend_to));
> +       clocksource_register_hz(&suspend_clocksource, 0);

-- 
Baolin Wang
