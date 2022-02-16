Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F76E4B838B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiBPJCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:02:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiBPJCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:02:38 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEFB8BE35
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:02:23 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id m24so1681339vsp.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYjCvPon8yMm63jyhw65liUtpTYKWdTMDUVsDcsDf2Y=;
        b=bAPOqWfC2wgNDfladvmrs4cuL/IaSyzg26KezZcNSGeG+9hME4DXP5viEcCX4mr+1D
         q1I72/G/LPxzmARee/RerR0FyftAxFb98u7DnR397k0KsA1E1AzCfGO5FQkosoOqF4OJ
         vuvsTtTrN5t3rHdZn/FCctPbsG6v2DLgP8UuCta/B1JGdeBaxo0M4iP4Pd/gLmv9Lxka
         Yxf14yaQrsijpT5iOqrSnRiVZSocR4/0w/YBKoIPWtTCk+ZRw5cv6X6zy/JTt73RYWRR
         6UXGxHFrpvoibDCySZHPUhvvtnjS3QDZ+uTBDjs3aO/0mhgDzY73Akfl/mcoQZSbSlw7
         KQcQ==
X-Gm-Message-State: AOAM530Any4JoUAKQyZ/8A53CcKDnWtrWgW6YRPAN63g6vZiSMjjbdTv
        KZ853iN7ANZnPVlgpgBEDTz/qDx3iChr7w==
X-Google-Smtp-Source: ABdhPJwB5U1T4ELThwsktqezn6jNuDcXVXWLdzeOrht3QzjiRyBtkYZfmLslFjXOz9toonIG7TA8Bw==
X-Received: by 2002:a05:6102:3591:b0:31b:4f52:29f1 with SMTP id h17-20020a056102359100b0031b4f5229f1mr541805vsu.61.1645002142405;
        Wed, 16 Feb 2022 01:02:22 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id n8sm293220vsl.8.2022.02.16.01.02.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 01:02:22 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id t22so1699892vsa.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:02:22 -0800 (PST)
X-Received: by 2002:a05:6102:4411:b0:31b:6df1:3b80 with SMTP id
 df17-20020a056102441100b0031b6df13b80mr548021vsb.5.1645002141827; Wed, 16 Feb
 2022 01:02:21 -0800 (PST)
MIME-Version: 1.0
References: <20220215163213.54917-1-andriy.shevchenko@linux.intel.com>
 <87o83859x2.fsf@intel.com> <Ygv32CptVknidyP3@smile.fi.intel.com> <87leyb5gy8.fsf@intel.com>
In-Reply-To: <87leyb5gy8.fsf@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Feb 2022 10:02:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWbpbY0=Beq6AMLS36oOmQhAmCvg=2WGJdFRz9dSwURiA@mail.gmail.com>
Message-ID: <CAMuHMdWbpbY0=Beq6AMLS36oOmQhAmCvg=2WGJdFRz9dSwURiA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] drm/i915/selftests: Replace too verbose for-loop
 with simpler while
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>
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

On Wed, Feb 16, 2022 at 9:55 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Tue, 15 Feb 2022, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Feb 15, 2022 at 07:14:49PM +0200, Jani Nikula wrote:
> >> On Tue, 15 Feb 2022, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >> > It's hard to parse for-loop which has some magic calculations inside.
> >> > Much cleaner to use while-loop directly.
> >>
> >> I assume you're trying to prove a point following our recent
> >> for-vs-while loop discussion. I really can't think of any other reason
> >> you'd end up looking at this file or this loop.
> >>
> >> With the change, the loop indeed becomes simpler, but it also runs one
> >> iteration further than the original. Whoops.
> >
> > Yeah, sorry for that, the initial condition should be d = depth - 1,
> > of course.
>
> Well, no, the condition should be while (--i) instead to also match the
> values the original loop takes. ;D

"There are two hard things in computer science: cache invalidation,
 naming things, and off-by-one errors."

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
