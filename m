Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D778544BB4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbiFIMX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245364AbiFIMXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:23:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BA62F008
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:23:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i29so20968606lfp.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llootBNvnKzlHSo7HBVwmmGvWmrZUKeALsskuPp9oY4=;
        b=PFIHGY61X8JnRhWtvwXV3fYxBQkbuMhPZHdKbAHE3ATwSdFXTvNH4TNE3BWhkVLrTA
         RnsJwyyJcVEHEP9Nw5e+K1ihE7iH0Xfit/DfK0NPMl9vttkwJvauVBNABZvteYYsIhEh
         yv7YZ//OcOg7qT5bGswpxjgt+Kfvd6LF7haJGNsBalV56ROiZBUrZdj6zL22RcMJkqIQ
         ZwIeIB/NPCZGcTqz0av+IrXgk4syOGa6CvDK6t6N2/4LjyIeWwkjxghkYiKyEOOhAR+U
         5CXFKlE07dNhpOd0idZE212zOSd6eDxZHxCwrE/ZsdVg350SfgcYq6bDbib5CToscZpb
         i6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llootBNvnKzlHSo7HBVwmmGvWmrZUKeALsskuPp9oY4=;
        b=RAFAcfAQgTN1lhUeZMOjgpxvGazF6Iz1+MIL9LjojxLOkKrOfk0MJ3xj2WXuFUk3ey
         vHgxK+0ozz5PApKyhpRDXgK8qAOQVCDXxYmh8FVrGU8dNuliiuCPqfcEWZ0iF4ng6DtE
         mGvjhRMTEz+McSwdK9G9XYkh2YNikCvF0VfbVkDq5XIXmoYyByEo57LATXhzfNhXi1aA
         uatZAImhPXDd0L80YVD9GJl7aMXzduzUoQWTVEuIovdCnLpkrvDLloa/fixtzO2NGqye
         6QW65nTJCQldjU+M93BxEYbGS8MFhQx2bohgy+sIpe8DjlKTkZ00NsHOS9t+jw6hBust
         4R5Q==
X-Gm-Message-State: AOAM530coKhY/GnuPIU1sMjfYOY1bvuOplKUgRXOXOIUVPpNoU9uh9DZ
        yon1UUv9KDnZ7wE7ZRRUH9Xsy3hOECva0MyfVXazGg==
X-Google-Smtp-Source: ABdhPJwDpiUpaZytilZz3A9LwfP5rEpTlz66NiST1TJCSJiNj11xLM4RNAU6bTosWzRJ6AUHgpeR9/FZ2okUFaMrfLU=
X-Received: by 2002:a05:6512:1085:b0:479:478b:d2cc with SMTP id
 j5-20020a056512108500b00479478bd2ccmr12747169lfg.540.1654777427515; Thu, 09
 Jun 2022 05:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-5-elver@google.com>
 <CACT4Y+YHp1mxxGNuGke42qcph0ibZb+6Ri_7fNJ+jg11NL-z8g@mail.gmail.com> <CANpmjNMA=UKzpURckHh_Ss14oRoTQ7nZ4yqcb=nV1kBtEcEkdw@mail.gmail.com>
In-Reply-To: <CANpmjNMA=UKzpURckHh_Ss14oRoTQ7nZ4yqcb=nV1kBtEcEkdw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jun 2022 14:23:36 +0200
Message-ID: <CACT4Y+ayhGH253WA_zXYJjfOK=YxGLDZLzkyyqLHW+EZzJYpEg@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 at 14:08, Marco Elver <elver@google.com> wrote:
> > > Due to being a __weak function, hw_breakpoint_weight() will cause the
> > > compiler to always emit a call to it. This generates unnecessarily bad
> > > code (register spills etc.) for no good reason; in fact it appears in
> > > profiles of `perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512`:
> > >
> > >     ...
> > >     0.70%  [kernel]       [k] hw_breakpoint_weight
> > >     ...
> > >
> > > While a small percentage, no architecture defines its own
> > > hw_breakpoint_weight() nor are there users outside hw_breakpoint.c,
> > > which makes the fact it is currently __weak a poor choice.
> > >
> > > Change hw_breakpoint_weight()'s definition to follow a similar protocol
> > > to hw_breakpoint_slots(), such that if <asm/hw_breakpoint.h> defines
> > > hw_breakpoint_weight(), we'll use it instead.
> > >
> > > The result is that it is inlined and no longer shows up in profiles.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  include/linux/hw_breakpoint.h | 1 -
> > >  kernel/events/hw_breakpoint.c | 4 +++-
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> > > index 78dd7035d1e5..9fa3547acd87 100644
> > > --- a/include/linux/hw_breakpoint.h
> > > +++ b/include/linux/hw_breakpoint.h
> > > @@ -79,7 +79,6 @@ extern int dbg_reserve_bp_slot(struct perf_event *bp);
> > >  extern int dbg_release_bp_slot(struct perf_event *bp);
> > >  extern int reserve_bp_slot(struct perf_event *bp);
> > >  extern void release_bp_slot(struct perf_event *bp);
> > > -int hw_breakpoint_weight(struct perf_event *bp);
> > >  int arch_reserve_bp_slot(struct perf_event *bp);
> > >  void arch_release_bp_slot(struct perf_event *bp);
> > >  void arch_unregister_hw_breakpoint(struct perf_event *bp);
> > > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > > index 8e939723f27d..5f40c8dfa042 100644
> > > --- a/kernel/events/hw_breakpoint.c
> > > +++ b/kernel/events/hw_breakpoint.c
> > > @@ -125,10 +125,12 @@ static __init int init_breakpoint_slots(void)
> > >  }
> > >  #endif
> > >
> > > -__weak int hw_breakpoint_weight(struct perf_event *bp)
> >
> > Humm... this was added in 2010 and never actually used to return
> > anything other than 1 since then (?). Looks like over-design. Maybe we
> > drop "#ifndef" and add a comment instead?
>
> Then there's little reason for the function either and we can just
> directly increment/decrement 1 everywhere. If we drop the ability for
> an arch to override, I feel that'd be cleaner.
>
> Either way, codegen won't change though.
>
> Preferences?

I don't have strong preferences either way.
Can also be:
#define HW_BREAKPOINT_WEIGHT 1
