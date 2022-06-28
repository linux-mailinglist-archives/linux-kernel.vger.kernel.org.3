Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A7555E8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346812AbiF1QCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348135AbiF1QBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:01:44 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5565537A3E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:01:12 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i7so22929980ybe.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSgkWuUAADlOM6Jw2JGSpNYb73+UZZR8Ny928REi7Do=;
        b=dD7WqxrxIulFXhD/bExMZnWi60wwO8Kj+M+kIed6KYNLHB0WWLvTKi3YQglVoCYW4P
         +nCIP4SR+cwnQqQfuATDns64AdE53d0F59geSv0p/m5YXnhqp4LycwIMn8fTF4Q77Gv9
         JOpUOTuY3a9w8gtDFPgVQ2AYVTdCpBjjnDrH38boB6yaYsKF0FG2/J9PB7qqpl9vKHJa
         5PbEManR+KQaodnyqs64a5Pz/K9SPx1dRdNN2bbRiZzRZ65LxBDyShencH0aKN3YaGNN
         DodJhWIcA2oLlhzqE0ACp0cNtsDgcWQAS9pfcEWt337XNT7UXLPRvQp9CgVf6ZrMiAkK
         tJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSgkWuUAADlOM6Jw2JGSpNYb73+UZZR8Ny928REi7Do=;
        b=sxxNvfFph9LxSDMp7HoBd4U+vcCzPG03t+F1X1laadGoWzx1lWc2t+OVIOgeMncK0w
         jXrAESsFxdDeB/f/injit8O86sEJgkC8GQv9GVuaO2UXJQ9zWCbq+vpMQQEmI9422Dsc
         jw9/AbhDBjxMxxQAQISCwd6ZezNAYuS2gjRY+1OL8N5Rg8peMoE4ngc/436+leViBIuD
         6WwkuNURimYihOkHN2RiwVCNH/slDZ/5iFwgHcVeLHOLdKEkeIvaJA+ustAaPq8KZtEQ
         iL0JA7AQE4ixdRQvUIfhOR1ExVG++XW7ikFATsy5gufaS1r3mswfkLaglV9XVEZifsLr
         LZhA==
X-Gm-Message-State: AJIora/+IZd7RQQLzOz2kN1/S9WE+JMSWi3nKdZxdrcID//gEbxQGerW
        lKBVO8oCHKtgzbGnuD28uuk482clfClfj34FGdCg/w==
X-Google-Smtp-Source: AGRyM1sZ36lYEgCFXIjvvLhfzCJJ1REYB15gJrq5Pp+y7LUoSX97r40Vy8EqU/H/mu0brC3/C7znR71H1FQdTL/t3qo=
X-Received: by 2002:a25:cc56:0:b0:66c:d0f6:2f0e with SMTP id
 l83-20020a25cc56000000b0066cd0f62f0emr12156904ybf.168.1656432071758; Tue, 28
 Jun 2022 09:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220628095833.2579903-1-elver@google.com> <20220628095833.2579903-14-elver@google.com>
 <CACT4Y+aJZzkYHc+YJRApOLG-NYe8zXMaqxpQgQQFAy5WY97Ttg@mail.gmail.com>
In-Reply-To: <CACT4Y+aJZzkYHc+YJRApOLG-NYe8zXMaqxpQgQQFAy5WY97Ttg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Jun 2022 18:00:34 +0200
Message-ID: <CANpmjNOh9gzzC7sOOOk1q7Ssj2dFxczj1bmufarYS2KupZQthg@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] perf/hw_breakpoint: Optimize toggle_bp_slot()
 for CPU-independent task targets
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 at 17:45, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, 28 Jun 2022 at 11:59, Marco Elver <elver@google.com> wrote:
> >
> > We can still see that a majority of the time is spent hashing task pointers:
> >
> >     ...
> >     16.98%  [kernel]       [k] rhashtable_jhash2
> >     ...
> >
> > Doing the bookkeeping in toggle_bp_slots() is currently O(#cpus),
> > calling task_bp_pinned() for each CPU, even if task_bp_pinned() is
> > CPU-independent. The reason for this is to update the per-CPU
> > 'tsk_pinned' histogram.
> >
> > To optimize the CPU-independent case to O(1), keep a separate
> > CPU-independent 'tsk_pinned_all' histogram.
> >
> > The major source of complexity are transitions between "all
> > CPU-independent task breakpoints" and "mixed CPU-independent and
> > CPU-dependent task breakpoints". The code comments list all cases that
> > require handling.
> >
> > After this optimization:
> >
> >  | $> perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512
> >  |      Total time: 1.758 [sec]
> >  |
> >  |       34.336621 usecs/op
> >  |     4395.087500 usecs/op/cpu
> >
> >     38.08%  [kernel]       [k] queued_spin_lock_slowpath
> >     10.81%  [kernel]       [k] smp_cfm_core_cond
> >      3.01%  [kernel]       [k] update_sg_lb_stats
> >      2.58%  [kernel]       [k] osq_lock
> >      2.57%  [kernel]       [k] llist_reverse_order
> >      1.45%  [kernel]       [k] find_next_bit
> >      1.21%  [kernel]       [k] flush_tlb_func_common
> >      1.01%  [kernel]       [k] arch_install_hw_breakpoint
> >
> > Showing that the time spent hashing keys has become insignificant.
> >
> > With the given benchmark parameters, that's an improvement of 12%
> > compared with the old O(#cpus) version.
> >
> > And finally, using the less aggressive parameters from the preceding
> > changes, we now observe:
> >
> >  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
> >  |      Total time: 0.067 [sec]
> >  |
> >  |       35.292187 usecs/op
> >  |     2258.700000 usecs/op/cpu
> >
> > Which is an improvement of 12% compared to without the histogram
> > optimizations (baseline is 40 usecs/op). This is now on par with the
> > theoretical ideal (constraints disabled), and only 12% slower than no
> > breakpoints at all.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>
> I don't see any bugs. But the code is quite complex. Does it make
> sense to add some asserts to the histogram type? E.g. counters don't
> underflow, weight is not negative (e.g. accidentally added -1 returned
> from task_bp_pinned()). Not sure if it will be enough to catch all
> types of bugs, though.
> Could kunit tests check that histograms are all 0's at the end?
>
> I am not just about the current code (which may be correct), but also
> future modifications to this code.

I'll think of some more options.

bp_slots_histogram_max*() already has asserts (WARN about underflow;
some with KCSAN help).

The main thing I did to raise my own confidence in the code is inject
bugs and see if the KUnit test catches it. If it didn't I extended the
tests. I'll do that some more maybe.
