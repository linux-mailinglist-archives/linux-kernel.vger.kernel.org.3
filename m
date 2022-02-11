Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347334B25C1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350181AbiBKM2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:28:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350168AbiBKM1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:27:51 -0500
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D14FE1;
        Fri, 11 Feb 2022 04:27:42 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id t22so10043047vsa.4;
        Fri, 11 Feb 2022 04:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Huyy9WHn7ezhBl1tBw8tTsSyyS9994mO5WZfsmLZIXc=;
        b=D5cJF7VHvQaI7moFa+wU3A5s1I2VvAaZ6qqMrpg3b03hH8ZFqsKS4kATD5m5RTZbhd
         4M9fnKAUuH5KsKKNxpnlZ49gX6xWS8blZCGUcy2pTZQ2rs9ucgcMOuyYlrGk5QrK5cXo
         0GZnicyp2qt5pYQK4La5DjBztvo+ILNKJNoNYU2ZrfXVk80x7VyWqpJFrQ5xYJUkOtd/
         oHvhfk83NyCU5pvwGwM0JJB0gNLg+jHB/mLksXAiz8NBcV5LtMgrE5kP1KLsYxnLYkDZ
         vaHonNMhagMpD2dK7273zEx6nmC6+ptaEFug99JKW2RhtKWqMkRZ6oeiaL3f+kZtOEDT
         UiMw==
X-Gm-Message-State: AOAM533qlzHCTDmQqGNtI/+C5HvIUe1yIT5SK91FRS20xPdSYNMyCmuB
        kWxnJEnRWe0eTO8jXzNzRpEESwWO753aow==
X-Google-Smtp-Source: ABdhPJwRzWQeKufyemGP4AbEuDeY3llYXt8ZcjXkvvzOU3ladfypDJxPc1+ORy4wIBq5E5EVJqSZww==
X-Received: by 2002:a05:6102:b07:: with SMTP id b7mr406459vst.68.1644582461874;
        Fri, 11 Feb 2022 04:27:41 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id k204sm4803595vkk.0.2022.02.11.04.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 04:27:41 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id 5so4857374vkq.9;
        Fri, 11 Feb 2022 04:27:41 -0800 (PST)
X-Received: by 2002:a1f:2ac3:: with SMTP id q186mr352535vkq.33.1644582461104;
 Fri, 11 Feb 2022 04:27:41 -0800 (PST)
MIME-Version: 1.0
References: <20220211091927.2988283-1-javierm@redhat.com> <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com> <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com> <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de>
 <87pmnt7gm3.fsf@intel.com>
In-Reply-To: <87pmnt7gm3.fsf@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Feb 2022 13:27:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWJ_T5HoWcOuSCDP-uquqpiWGPUmKNaC9U5d=JkGRGP0g@mail.gmail.com>
Message-ID: <CAMuHMdWJ_T5HoWcOuSCDP-uquqpiWGPUmKNaC9U5d=JkGRGP0g@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add drm_fb_xrgb8888_to_gray8_line()
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>
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

Hi Jani,

On Fri, Feb 11, 2022 at 1:06 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Fri, 11 Feb 2022, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > Am 11.02.22 um 12:12 schrieb Andy Shevchenko:
> >> On Fri, Feb 11, 2022 at 11:40:13AM +0100, Javier Martinez Canillas wrote:
> >>> On 2/11/22 11:28, Andy Shevchenko wrote:
> >>>> On Fri, Feb 11, 2022 at 10:19:22AM +0100, Javier Martinez Canillas wrote:
> >>
> >> ...
> >>
> >>>>> +static void drm_fb_xrgb8888_to_gray8_line(u8 *dst, const u32 *src, unsigned int pixels)
> >>>>> +{
> >>>>> + unsigned int x;
> >>>>> +
> >>>>> + for (x = 0; x < pixels; x++) {
> >>>>> +         u8 r = (*src & 0x00ff0000) >> 16;
> >>>>> +         u8 g = (*src & 0x0000ff00) >> 8;
> >>>>> +         u8 b =  *src & 0x000000ff;
> >>>>> +
> >>>>> +         /* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
> >>>>> +         *dst++ = (3 * r + 6 * g + b) / 10;
> >>>>> +         src++;
> >>>>> + }
> >>>>
> >>>> Can be done as
> >>>>
> >>>>    while (pixels--) {
> >>>>            ...
> >>>>    }
> >>>>
> >>>> or
> >>>>
> >>>>    do {
> >>>>            ...
> >>>>    } while (--pixels);
> >>>>
> >>>
> >>> I don't see why a while loop would be an improvement here TBH.
> >>
> >> Less letters to parse when reading the code.
> >
> > It's a simple refactoring of code that has worked well so far. Let's
> > leave it as-is for now.
>
> IMO *always* prefer a for loop over while or do-while.

(guess what ;-) I tend to disagree.

> The for (i = 0; i < N; i++) is such a strong paradigm in C. You
> instantly know how many times you're going to loop, at a glance. Not so
> with with the alternatives, which should be used sparingly.

In this case it's fairly obvious, and you get rid of the extra variable x.
Less code, less variables, what can go wrong? ;-)

> And yes, the do-while suggested above is buggy, and you actually need to
> stop and think to see why.

Yes, that one is wrong.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
