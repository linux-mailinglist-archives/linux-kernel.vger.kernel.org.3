Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED98532BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbiEXOAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbiEXOAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:00:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5928795DC1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF1961645
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 14:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E0DC385AA;
        Tue, 24 May 2022 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653400836;
        bh=rLCMlm5uimMMgYjkjqdyBJrwmRhzlkLWAi31wPLV5iA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mGyPWCB/Gb31vZc+L6WDQK2pWamesEPvoH8fL1xORREa+SybCC27yZxNfldF4EZ33
         zpSax8nCvGU0ZlAe8oq5peTdnXUfmJ/AAr5A4GIjup2O2C4/I79N1cWmdL/C/6zqHg
         t38z+gixF3lokSZQNBsjf40KMav5Qiv74MOkBA+ELuYVRt7IqG6EKWS/OIGPHc3x3N
         8Is/ZuJeNym8V/GgF2K+LmuVZUBO/Tk0sj39dSPaYLhmr03iNdNyldY0EPsaHLUASn
         ijyf2btdyZC6X1w7s4GTM3sEGJgZKXzq4kQi5XAytBhehh2cnHA27bGT+C9l3cO7+3
         ncTf3bKibhsTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A09D85C0378; Tue, 24 May 2022 07:00:35 -0700 (PDT)
Date:   Tue, 24 May 2022 07:00:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL] scheduler updates for v5.19
Message-ID: <20220524140035.GL1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <You+G0njuvLvLll3@gmail.com>
 <Yoxx5MeAyIki0peI@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yoxx5MeAyIki0peI@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 07:49:24AM +0200, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > Linus,
> > 
> > Please pull the latest sched/core git tree from:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-05-23
> > 
> >    # HEAD: 991d8d8142cad94f9c5c05db25e67fa83d6f772a topology: Remove unused cpu_cluster_mask()
> > 
> > Scheduler changes in this cycle were:
> > 
> >  - Updates to scheduler metrics:
> > 
> >     - PELT fixes & enhancements
> >     - PSI fixes & enhancements
> >     - Refactor cpu_util_without()
> > 
> >  - Updates to instrumentation/debugging:
> > 
> >     - Remove sched_trace_*() helper functions - can be done via debug info
> >     - Fix double update_rq_clock() warnings
> > 
> >  - Introduce & use "preemption model accessors" to simplify some of
> >    the Kconfig complexity.
> > 
> >  - Make softirq handling RT-safe.
> > 
> >  - Misc smaller fixes & cleanups.
> > 
> >  Thanks,
> > 
> > 	Ingo
> > 
> > ------------------>
> > Chengming Zhou (3):
> >       sched/fair: Fix cfs_rq_clock_pelt() for throttled cfs_rq
> >       sched/fair: Delete useless condition in tg_unthrottle_up()
> >       sched/psi: report zeroes for CPU full at the system level
> > 
> > Dietmar Eggemann (4):
> >       sched/fair: Refactor cpu_util_without()
> >       sched/fair: Remove sched_trace_*() helper functions
> >       sched/fair: Remove cfs_rq_tg_path()
> >       topology: Remove unused cpu_cluster_mask()
> > 
> > Hailong Liu (1):
> >       psi: Fix trigger being fired unexpectedly at initial
> > 
> > Hao Jia (2):
> >       sched/core: Avoid obvious double update_rq_clock warning
> >       sched/deadline: Remove superfluous rq clock update in push_dl_task()
> > 
> > Peter Zijlstra (1):
> >       sched: Reverse sched_class layout
> > 
> > Sebastian Andrzej Siewior (1):
> >       smp: Make softirq handling RT safe in flush_smp_call_function_queue()
> > 
> > Tao Zhou (1):
> >       sched/fair: Revise comment about lb decision matrix
> > 
> > Thomas Gleixner (2):
> >       sched: Fix missing prototype warnings
> >       smp: Rename flush_smp_call_function_from_idle()
> > 
> > Valentin Schneider (5):
> >       preempt/dynamic: Introduce preemption model accessors
> >       kcsan: Use preemption model accessors
> >       ftrace: Use preemption model accessors for trace header printout
> >       MAINTAINERS: Add myself as scheduler topology reviewer
> >       mailmap: Update my email address to @redhat.com
> > 
> > zgpeng (1):
> >       sched/fair: Move calculate of avg_load to a better location
> > 
> > 
> >  .mailmap                          |   1 +
> >  Documentation/accounting/psi.rst  |   9 +-
> >  MAINTAINERS                       |   1 +
> >  include/asm-generic/vmlinux.lds.h |  12 +-
> >  include/linux/interrupt.h         |   9 ++
> >  include/linux/sched.h             |  57 ++++++--
> >  include/linux/topology.h          |   7 -
> >  kernel/kcsan/kcsan_test.c         |   5 +-
> >  kernel/sched/build_policy.c       |   2 +
> >  kernel/sched/build_utility.c      |   1 +
> >  kernel/sched/core.c               |  35 +++--
> >  kernel/sched/deadline.c           |  15 +-
> >  kernel/sched/fair.c               | 292 +++++++++-----------------------------
> >  kernel/sched/idle.c               |   2 +-
> >  kernel/sched/pelt.h               |   4 +-
> >  kernel/sched/psi.c                |  18 ++-
> >  kernel/sched/rt.c                 |   5 +-
> >  kernel/sched/sched.h              |  55 ++++---
> >  kernel/sched/smp.h                |   6 +
> >  kernel/smp.c                      |  32 +++--
> >  kernel/softirq.c                  |  13 ++
> >  kernel/stop_machine.c             |   2 -
> >  kernel/trace/trace.c              |  14 +-
> >  23 files changed, 266 insertions(+), 331 deletions(-)
> 
> Note that the above is a v5.18 based shortlog and diffstat, but because the 
> RCU tree deep-merged one of the scheduler commits that introduced better, 
> Kconfig-invariant preemption model accessors:
> 
>    cfe43f478b79 preempt/dynamic: Introduce preemption model accessors

Ah, this one:

cfe43f478b79 ("preempt/dynamic: Introduce preemption model accessors")

Please accept my apologies for the disruption.  This commit was needed
to be able to properly handle CONFIG_PREEMPT_DYNAMIC=y kernels booting
with preempt=none or preempt=voluntary.  But I should have called this
out in my pull request, and failed to do so.  Again, please accept my
apologies for the disruption.

							Thanx, Paul

> ... and you merged the RCU tree already, so you'll get this shortlog & 
> diffstat:
> 
> =============>
> Chengming Zhou (3):
>       sched/fair: Fix cfs_rq_clock_pelt() for throttled cfs_rq
>       sched/fair: Delete useless condition in tg_unthrottle_up()
>       sched/psi: report zeroes for CPU full at the system level
> 
> Dietmar Eggemann (4):
>       sched/fair: Refactor cpu_util_without()
>       sched/fair: Remove sched_trace_*() helper functions
>       sched/fair: Remove cfs_rq_tg_path()
>       topology: Remove unused cpu_cluster_mask()
> 
> Hailong Liu (1):
>       psi: Fix trigger being fired unexpectedly at initial
> 
> Hao Jia (2):
>       sched/core: Avoid obvious double update_rq_clock warning
>       sched/deadline: Remove superfluous rq clock update in push_dl_task()
> 
> Ingo Molnar (1):
>       Merge tag 'v5.18-rc5' into sched/core to pull in fixes & to resolve a conflict
> 
> Peter Zijlstra (1):
>       sched: Reverse sched_class layout
> 
> Sebastian Andrzej Siewior (1):
>       smp: Make softirq handling RT safe in flush_smp_call_function_queue()
> 
> Tao Zhou (1):
>       sched/fair: Revise comment about lb decision matrix
> 
> Thomas Gleixner (2):
>       sched: Fix missing prototype warnings
>       smp: Rename flush_smp_call_function_from_idle()
> 
> Valentin Schneider (4):
>       kcsan: Use preemption model accessors
>       ftrace: Use preemption model accessors for trace header printout
>       MAINTAINERS: Add myself as scheduler topology reviewer
>       mailmap: Update my email address to @redhat.com
> 
> zgpeng (1):
>       sched/fair: Move calculate of avg_load to a better location
> 
>  .mailmap                          |   1 +
>  Documentation/accounting/psi.rst  |   9 +-
>  MAINTAINERS                       |   1 +
>  include/asm-generic/vmlinux.lds.h |  12 +-
>  include/linux/interrupt.h         |   9 ++
>  include/linux/sched.h             |  16 +--
>  include/linux/topology.h          |   7 -
>  kernel/kcsan/kcsan_test.c         |   5 +-
>  kernel/sched/build_policy.c       |   2 +
>  kernel/sched/build_utility.c      |   1 +
>  kernel/sched/core.c               |  23 +--
>  kernel/sched/deadline.c           |  15 +-
>  kernel/sched/fair.c               | 292 +++++++++-----------------------------
>  kernel/sched/idle.c               |   2 +-
>  kernel/sched/pelt.h               |   4 +-
>  kernel/sched/psi.c                |  18 ++-
>  kernel/sched/rt.c                 |   5 +-
>  kernel/sched/sched.h              |  55 ++++---
>  kernel/sched/smp.h                |   6 +
>  kernel/smp.c                      |  32 +++--
>  kernel/softirq.c                  |  13 ++
>  kernel/stop_machine.c             |   2 -
>  kernel/trace/trace.c              |  14 +-
>  23 files changed, 213 insertions(+), 331 deletions(-)
> 
> Thanks,
> 
> 	Ingo
