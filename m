Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C474E54F2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbiCWPNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiCWPNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:13:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63A96F486
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:12:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id yy13so3491552ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2Q8fm4v433hvdazdR8jN4FCBBlXzJ6xVhdcBHY1Ydo=;
        b=s5DhlRgRd4bwJiFPDdkp1/YtgRn/fKyGuAKjuLkzAzggu77QQqyjPsvgsJTeQwnQfs
         l8Lnn4y7mWQxcyVQ+BUtrWjazQOXGSv71+vT2xv/r5uFTIHkh1OYl+vJGCc9kK2Jy06v
         sUsb7U4y9d5wINvjcgGwtUpMy1HBAgeynPcG8Mq6Pc+1X2YTdeSk9QUaGxmbS2CV0nQF
         zkttM4C7FOrP3vtn0276xQZNG2Bl9Y13lHFw9Ck6dwJDjinYjg3Fqv+lVAbEi2y32IQk
         hgsl+RQDj8GO6NDfdP2jcQOJG/4HS509Nv7DXrcAS69k/tlarbg90E7lOKnSQx39FOXq
         Iskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2Q8fm4v433hvdazdR8jN4FCBBlXzJ6xVhdcBHY1Ydo=;
        b=LfGM0uMBIGF4M4fC6Y8NQB/yQbvNBI/F7j5NgnH/24Y58zS3DusE6eY4HReV34Z3+o
         1UYHvRXPIz1Ut0fP2d9GAb3wu9dpEcEokugj8ha9xVHvCcnfCF6xMogVOdlE6IIJgkbo
         ynUGhXw/AkhuwFeutjHgEnsmc+ghxpg1Bnf6Kt+HUXypbJ7uu93zpBKGK3kUWcgzZK6H
         MvLCGDGdVJGszF6wh4fglt4p4et9TXJIbHFobJWM1copmgjYMi1PtrTpupq02xZSCgc+
         j543tOphC1tLA3QW8x93BPsfCfO4xCi4uj/yr6DfkD3JD1XVY2PPV4s3aeHlwUFZMbfD
         IzIA==
X-Gm-Message-State: AOAM530zssiohtsSItDaL44Wy8jR05bhTAd2n1159bLwxJVi+EbyxXHU
        WLvvNJ8MGhEIRfn4b9chUSiJlgKWp6gA8qRYnnwvAw==
X-Google-Smtp-Source: ABdhPJxeaiW/2Nuu0LmwqYAhq4CFoYD+F9n8CUiqvlujyxlnKZ+teAIFzGHsCIxMG3XSmC0v6PP9gBwqTzFwjAS57Tc=
X-Received: by 2002:a17:907:6d0b:b0:6df:e54c:ad1d with SMTP id
 sa11-20020a1709076d0b00b006dfe54cad1dmr478779ejc.734.1648048321418; Wed, 23
 Mar 2022 08:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220310150905.1.Ie0a005d7a763d501e03b7abe8ee968ca99d23282@changeid>
 <CAHp75Vfbs6sPsrjwxNWLZQu=pEoar2K5sY=fX9a7KkOe=mwsZw@mail.gmail.com>
 <CAMRc=Mc_bw40uY68jcPYR-Lwe-qLcxmQeZO47WrexZtSiE_M5Q@mail.gmail.com>
 <CAHp75VcK0JDkTXuPc2N8G+OotXK0mqfQn7i4nDqXDODe1SqcrQ@mail.gmail.com> <CA+ASDXPncB=edDfXqkmWMqToQSt85UkAMzoApgyQATROoR1x9g@mail.gmail.com>
In-Reply-To: <CA+ASDXPncB=edDfXqkmWMqToQSt85UkAMzoApgyQATROoR1x9g@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 23 Mar 2022 16:11:50 +0100
Message-ID: <CAMRc=Me++Z8DscUqPa6X0a+s6hoO5DR+WLDgDFjUxKZ2cDTVwQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Drop CONFIG_DEBUG_GPIO
To:     Brian Norris <briannorris@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 5:31 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Tue, Mar 22, 2022 at 8:00 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Mar 22, 2022 at 4:49 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > On Tue, Mar 22, 2022 at 3:38 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Mar 11, 2022 at 4:55 AM Brian Norris <briannorris@chromium.org> wrote:
> > > >
> > > > ...
> > > >
> > > > > Description: it says nothing about enabling extra printk()s. But -DDEBUG
> > > > > does just that; it turns on every dev_dbg()/pr_debug() that would
> > > > > otherwise be silent.
> > > >
> > > > Which is what some and I are using a lot during development.
>
> Well, we could fix that part by updating the documentation, so users
> know what they're getting themselves into.
>
> I'm also curious: does dynamic debug not suit you?
> https://www.kernel.org/doc/html/v4.19/admin-guide/dynamic-debug-howto.html
> TBH, I never remember its syntax, and it seems very easy to get wrong,
> so I often throw in #define's myself, if I want it foolproof. But I'm
> curious others thoughts too.
>
> > > AFAIK this: https://www.kernel.org/doc/local/pr_debug.txt is the right
> > > way to do it?
> >
> > Yes. But it means we need to have a separate option on a per driver
> > (or group of drivers) basis. I don't think it's a good idea right now.
>
> I'm not sure I understand this thought; isn't this the opposite of
> what you're arguing above? (That drivers/gpio/ deserves its own
> Kconfig option for enabling (non-dynamic) debug prints?)
>
> > > https://www.kernel.org/doc/local/pr_debug.txt
> > >
> > > This doesn't mention adding Kconfig options just to enable debug messages.
> > >
> > > > ...
> > > >
> > > > > -ccflags-$(CONFIG_DEBUG_GPIO)   += -DDEBUG
> > > > > -
> > > >
> > > > NAK to this change.
> > > >
> > > > I'm not against enabling might_sleep() unconditionally.
> > > >
> > >
> > > These are already controlled by CONFIG_DEBUG_ATOMIC_SLEEP, no? Or
> > > maybe I can't parse that double negation.
> >
> > The part of the patch that converts might_sleep_if():s is fine with me.
>
> I'm fine with that approach (keep CONFIG_DEBUG_GPIO *only* as a
> print-verbosity/DDEBUG control), even if I think it's a bit odd. My
> main point in the patch is differentiating debug checks (that I want;
> that are silent-by-default; that have their own Kconfig knobs) from
> debug prints (that are noisy by default; that I don't want). So if you
> convince Bartosz and/or Linus, you can get an Ack from me for a
> partial revert.
>
> Regards,
> Brian

I'm about to send my PR for v5.18 so I'll remove this one from my
for-next branch as it's not urgent. Let's discuss it during the next
cycle.

Bart
