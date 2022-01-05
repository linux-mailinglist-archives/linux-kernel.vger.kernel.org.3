Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C0D484C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbiAEC3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbiAEC3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:29:36 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C2C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 18:29:36 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id p15so63243765ybk.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 18:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OXJ35jZINaVYWhJpHva6wfpMEmgAzbwTMqek/t8df+A=;
        b=VUPWCY+WZKxUFhnomOwkrzT7LRJZkP+lbxEoxOh7bICer+jqQXXAXTfOX/NfxzGozL
         BU1Q75EmxQMRa+K7vxmcIsPb9n8WPiQKrgSmIusyF6ya9b5FyvgZ/mSiiA+5k+pOxY+h
         fJw+IVoxAINBWjCsiuA/kAUovq6fig2eXJLSRciXQ/sDZBL6zeUxT7i4dt7QvoSUH6+c
         wOAXTh30UeL57k8RK9gCDsdde2fV9a1UWxyimNQzktCZ8QeZYXLADjH21Bol9nSBz7eS
         XQgUcLJYfjCWUhngbvHDEQfv8wLbMCnkRxwZCfWHXJgx681pxvoIbeOb7WaeuIg/T/TG
         ilKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OXJ35jZINaVYWhJpHva6wfpMEmgAzbwTMqek/t8df+A=;
        b=CVR871atimo7s/2eBXZpZICsCwD0cIXDVpRo7ST40Votb4023g2mPbZLG4s7+OqsLk
         KaFykhoTZVjh33J92d6hQQnz7e+a22bmrUMOR/Ked7Gx5Cf7iDENDOgloR4COEGz1Rj5
         AQvKz1sBHNgGowaSfVw5PoBPZ+kUkR5NLtBKqWcf19kdkfBRzVQbfsfFo7bblFPAumzQ
         q5K19x+Ue1PFEiH803dzpU6KzdK3vbE7gWLHmuZf6Pw2W6kFHj23YVmwO4T4keMgqPgY
         wynADnXrCSJc+nZ5DDVECL+EnGZqSOKC2WX/xsOMmFC4LateihGc1ZCYMeti8/LanhRj
         Uf5Q==
X-Gm-Message-State: AOAM530dYp88bcxTHHPMBYCXD+nr6fstjtxL962d67pJmZNTg4b805Wk
        ugQr6loS4TIGOCmXY/PnLQMje2xRQCIVP4fKm1E=
X-Google-Smtp-Source: ABdhPJwR/rggRRSMwqWepbdx1RnelS6Opcdw0sp8Ej5NtYVs4H43lGw6qiwlm3REwZzj6CY6AtZQGhhpDVqCZD2nZoM=
X-Received: by 2002:a25:402:: with SMTP id 2mr51802283ybe.127.1641349775692;
 Tue, 04 Jan 2022 18:29:35 -0800 (PST)
MIME-Version: 1.0
References: <1640930555-12220-1-git-send-email-weidong.guanguan@gmail.com> <CADBw62qcAvJc7asZnF=6b8oFWq1Uk2iGynaBfSH2n07p_WexsA@mail.gmail.com>
In-Reply-To: <CADBw62qcAvJc7asZnF=6b8oFWq1Uk2iGynaBfSH2n07p_WexsA@mail.gmail.com>
From:   weidong guan <weidong.guanguan@gmail.com>
Date:   Wed, 5 Jan 2022 10:29:08 +0800
Message-ID: <CAGSvZSntMfD_x_OxvqCzSM_2PaUYTrF+jbkGkWD2xeCt-yXijQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource: fix counter with 32bit may wrap around
To:     Baolin Wang <baolin.wang7@gmail.com>
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

On Tue, Jan 4, 2022 at 9:42 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi,
>
> On Fri, Dec 31, 2021 at 2:03 PM weidong guan <weidong.guanguan@gmail.com> wrote:
> >
> > From: "weidong.guan" <weidong.guan@unisoc.com>
> >
> > When the system sleep time exceeds 30+ hours, counter with 32bit may wrap
>
> I am curious about which condition the system can suspend for more
> than 30+ hours, from my understanding, the phone will be woken up
> periodically.

Yes, it does on mobile phones, but on some non-mobile devices,
it would continue to sleep until you wake it up actively.Just as logs
shown below:
    [89438.802502][11-09 09:14:34.802] PM: suspend entry (deep)
    [200927.406098][11-10 16:12:43.406] PM: suspend exit
And in my opinion, should we try to avoid counter overflow even if
theoretically?

>
> > around, resulting in insufficient sleep compensation time. So We should
> > enable 64bit counter mode of sprd timer and use the given mult/shift
> > to ensure that sufficient counts can be generated.
> >
> > Signed-off-by: weidong.guan <weidong.guan@unisoc.com>
> > ---
> >  drivers/clocksource/timer-sprd.c | 31 ++++++++++++++++++++-----------
> >  1 file changed, 20 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
> > index 430cb99..7eac059 100644
> > --- a/drivers/clocksource/timer-sprd.c
> > +++ b/drivers/clocksource/timer-sprd.c
> > @@ -30,6 +30,7 @@
> >  #define TIMER_VALUE_SHDW_HI    0x1c
> >
> >  #define TIMER_VALUE_LO_MASK    GENMASK(31, 0)
> > +#define TIMER_VALUE_64BIT_MASK GENMASK_ULL(63, 0)
> >
> >  static void sprd_timer_enable(void __iomem *base, u32 flag)
> >  {
> > @@ -57,10 +58,12 @@ static void sprd_timer_disable(void __iomem *base)
> >         writel_relaxed(val, base + TIMER_CTL);
> >  }
> >
> > -static void sprd_timer_update_counter(void __iomem *base, unsigned long cycles)
> > +static void
> > +sprd_timer_update_counter(void __iomem *base, unsigned long long cycles)
> >  {
> >         writel_relaxed(cycles & TIMER_VALUE_LO_MASK, base + TIMER_LOAD_LO);
> > -       writel_relaxed(0, base + TIMER_LOAD_HI);
> > +       writel_relaxed((cycles >> 32) & TIMER_VALUE_LO_MASK,
> > +                       base + TIMER_LOAD_HI);
> >  }
> >
> >  static void sprd_timer_enable_interrupt(void __iomem *base)
> > @@ -82,7 +85,7 @@ static int sprd_timer_set_next_event(unsigned long cycles,
> >         struct timer_of *to = to_timer_of(ce);
> >
> >         sprd_timer_disable(timer_of_base(to));
> > -       sprd_timer_update_counter(timer_of_base(to), cycles);
> > +       sprd_timer_update_counter(timer_of_base(to), (u64)cycles);
> >         sprd_timer_enable(timer_of_base(to), 0);
> >
> >         return 0;
> > @@ -93,7 +96,8 @@ static int sprd_timer_set_periodic(struct clock_event_device *ce)
> >         struct timer_of *to = to_timer_of(ce);
> >
> >         sprd_timer_disable(timer_of_base(to));
> > -       sprd_timer_update_counter(timer_of_base(to), timer_of_period(to));
> > +       sprd_timer_update_counter(timer_of_base(to),
> > +                                 (u64)timer_of_period(to));
> >         sprd_timer_enable(timer_of_base(to), TIMER_CTL_PERIOD_MODE);
> >
> >         return 0;
> > @@ -162,15 +166,19 @@ static int __init sprd_timer_init(struct device_node *np)
> >
> >  static u64 sprd_suspend_timer_read(struct clocksource *cs)
> >  {
> > -       return ~(u64)readl_relaxed(timer_of_base(&suspend_to) +
> > -                                  TIMER_VALUE_SHDW_LO) & cs->mask;
> > +       u64 value_hi, value_lo;
> > +
> > +       value_hi = (u64)readl_relaxed(timer_of_base(&suspend_to) + TIMER_VALUE_SHDW_HI);
> > +       value_lo = (u64)readl_relaxed(timer_of_base(&suspend_to) + TIMER_VALUE_SHDW_LO);
> > +       return ~(u64)((value_hi << 32) + value_lo) & cs->mask;
> >  }
> >
> >  static int sprd_suspend_timer_enable(struct clocksource *cs)
> >  {
> >         sprd_timer_update_counter(timer_of_base(&suspend_to),
> > -                                 TIMER_VALUE_LO_MASK);
> > -       sprd_timer_enable(timer_of_base(&suspend_to), TIMER_CTL_PERIOD_MODE);
> > +                                 TIMER_VALUE_64BIT_MASK);
> > +       sprd_timer_enable(timer_of_base(&suspend_to),
> > +                         TIMER_CTL_PERIOD_MODE|TIMER_CTL_64BIT_WIDTH);
> >
> >         return 0;
> >  }
> > @@ -183,10 +191,12 @@ static void sprd_suspend_timer_disable(struct clocksource *cs)
> >  static struct clocksource suspend_clocksource = {
> >         .name   = "sprd_suspend_timer",
> >         .rating = 200,
> > +       .mult   = 0x1DCD650,
> > +       .shift  = 10,
>
> And why?

Do you mean why we use the given mult/shift? The reason is If we use the
mult/shift automatically calculated by kernel, the mult value is relatively
large, causing the not large enough maximum count value. So under the
precondition of ensuring accuracy, we calculate a relatively small mult/shift
value, aiming to get larger maximum count value.

>
> >         .read   = sprd_suspend_timer_read,
> >         .enable = sprd_suspend_timer_enable,
> >         .disable = sprd_suspend_timer_disable,
> > -       .mask   = CLOCKSOURCE_MASK(32),
> > +       .mask   = CLOCKSOURCE_MASK(64),
> >         .flags  = CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
> >  };
> >
> > @@ -198,8 +208,7 @@ static int __init sprd_suspend_timer_init(struct device_node *np)
> >         if (ret)
> >                 return ret;
> >
> > -       clocksource_register_hz(&suspend_clocksource,
> > -                               timer_of_rate(&suspend_to));
> > +       clocksource_register_hz(&suspend_clocksource, 0);
>
> --
> Baolin Wang
