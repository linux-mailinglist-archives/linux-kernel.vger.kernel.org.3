Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A173544B50
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245133AbiFIMIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbiFIMIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:08:40 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC1C26446E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:08:38 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3137eb64b67so37205717b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/fgAdX8O4qm/LW6iACkSWWobNgY9ruhG5Pvbw2aAB7Y=;
        b=dvX8wSw1YqLr7JxbM16NEQx7FymXa3gbT5EcIMum6jFbUzCSHcypiRmPZr0zHdwexR
         feTWYjxBem01MXvewte4MWZ5GQyjqDuKiI/DfFcbeHBT9uxlz05lR5Eqz5bXQaAqr9ps
         ijd4j4xDHm1WQFKFej8l2ONL6Xd+Pu+UodhIY43rTEq0+n4Nj3stvYhd4LWWmmo0vwHj
         OGDw46J6GAtmOxzcnZ0xUf0iHcf5Fpk0b+A4Xw4ElJyHgRoNhRJauhbkYFnkzaaneGR/
         Kh7uNEWyC/RSiX+Gv+UijRhPtrO/1MHU9XsiL3YG1sSR+jz3gj6LCpSENYb1sC2gKbxL
         2RtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/fgAdX8O4qm/LW6iACkSWWobNgY9ruhG5Pvbw2aAB7Y=;
        b=qzSmdapn5Wqbv+D70gw/cbZXDWTpjNvZSEcfxruw1Wzoamox7dJqwnPjJw9r/6eGYc
         jJdfKdiCNIhaLbt7RA0gkeSHY5Am+jm7MERmyrpHNMpOA7RBFUa9anGYshq6oqAlZhYj
         QPboLpuWaL4WJq62ExrNb3YkuR2ZZMEuazJJ7kaxD+4bhEfm8qx9jn6mujHfgifEFVPB
         XMj8cQcGLzzMYf7foAvnWdAu2TMGGPRJQ4zvci4I/T+4hysqlPiSxGw2N6BrTHelE9EK
         mb+mN/h4zWc2qvetdVpTTGEI9w85e5D7v28rMFe71aBug3sX7HDkkLAZEcxUPJb86snZ
         TmeQ==
X-Gm-Message-State: AOAM5314iDMndo5XGhGw4VMENgpR/OXNw/XEvwhwwl7qr4/64WsVvs++
        fQQ6xuLHSzob6Uz/GCh3YVmQznG1VJPLYAgRfqZi1g==
X-Google-Smtp-Source: ABdhPJzZPS7J7sv47uy951EM3hqz0kXL15GrZMXB34rTuUWfP9U8r11uog9KS6g2i/mBGZE9wGd+ZmLkh6JpF4his44=
X-Received: by 2002:a0d:c0c6:0:b0:2ff:bb2:1065 with SMTP id
 b189-20020a0dc0c6000000b002ff0bb21065mr44133509ywd.512.1654776517756; Thu, 09
 Jun 2022 05:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-5-elver@google.com>
 <CACT4Y+YHp1mxxGNuGke42qcph0ibZb+6Ri_7fNJ+jg11NL-z8g@mail.gmail.com>
In-Reply-To: <CACT4Y+YHp1mxxGNuGke42qcph0ibZb+6Ri_7fNJ+jg11NL-z8g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Jun 2022 14:08:01 +0200
Message-ID: <CANpmjNMA=UKzpURckHh_Ss14oRoTQ7nZ4yqcb=nV1kBtEcEkdw@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Thu, 9 Jun 2022 at 14:03, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, 9 Jun 2022 at 13:31, Marco Elver <elver@google.com> wrote:
> >
> > Due to being a __weak function, hw_breakpoint_weight() will cause the
> > compiler to always emit a call to it. This generates unnecessarily bad
> > code (register spills etc.) for no good reason; in fact it appears in
> > profiles of `perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512`:
> >
> >     ...
> >     0.70%  [kernel]       [k] hw_breakpoint_weight
> >     ...
> >
> > While a small percentage, no architecture defines its own
> > hw_breakpoint_weight() nor are there users outside hw_breakpoint.c,
> > which makes the fact it is currently __weak a poor choice.
> >
> > Change hw_breakpoint_weight()'s definition to follow a similar protocol
> > to hw_breakpoint_slots(), such that if <asm/hw_breakpoint.h> defines
> > hw_breakpoint_weight(), we'll use it instead.
> >
> > The result is that it is inlined and no longer shows up in profiles.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  include/linux/hw_breakpoint.h | 1 -
> >  kernel/events/hw_breakpoint.c | 4 +++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> > index 78dd7035d1e5..9fa3547acd87 100644
> > --- a/include/linux/hw_breakpoint.h
> > +++ b/include/linux/hw_breakpoint.h
> > @@ -79,7 +79,6 @@ extern int dbg_reserve_bp_slot(struct perf_event *bp);
> >  extern int dbg_release_bp_slot(struct perf_event *bp);
> >  extern int reserve_bp_slot(struct perf_event *bp);
> >  extern void release_bp_slot(struct perf_event *bp);
> > -int hw_breakpoint_weight(struct perf_event *bp);
> >  int arch_reserve_bp_slot(struct perf_event *bp);
> >  void arch_release_bp_slot(struct perf_event *bp);
> >  void arch_unregister_hw_breakpoint(struct perf_event *bp);
> > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > index 8e939723f27d..5f40c8dfa042 100644
> > --- a/kernel/events/hw_breakpoint.c
> > +++ b/kernel/events/hw_breakpoint.c
> > @@ -125,10 +125,12 @@ static __init int init_breakpoint_slots(void)
> >  }
> >  #endif
> >
> > -__weak int hw_breakpoint_weight(struct perf_event *bp)
>
> Humm... this was added in 2010 and never actually used to return
> anything other than 1 since then (?). Looks like over-design. Maybe we
> drop "#ifndef" and add a comment instead?

Then there's little reason for the function either and we can just
directly increment/decrement 1 everywhere. If we drop the ability for
an arch to override, I feel that'd be cleaner.

Either way, codegen won't change though.

Preferences?
