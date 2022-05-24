Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C456D53229F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiEXFtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiEXFta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:49:30 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202BE5AA43
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 22:49:29 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id jx22so19625407ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 22:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C+n2mFnYxjMdQyExf3HsU7WxNGZU5BDX+JooTakE2y4=;
        b=dv0Kbor1TTr+x1QLlylZKZ43sZkOUEZZTImH5kLD93Qb94RQ3ZhORwrG0eM7mK66mG
         gBHSiY+J66QyXqQQCWFZ3yLnDBG+onBpWWkq8RxM+3T3M+EKc1clGU2qL01xMRwG6WmV
         ZtA6NQpRiUkKlAAVx/3faApJgMlsprV9y/TOZA5itXmwFk/28txMlmF+6YTXoUd3klf1
         bJpLpv06uiEW0kkv737TwO6IWIaQLaaLaN62ZpL1UQl3A33eusBfgWuKuzU9ePcHakun
         ENMLyqYcqsXOi2kf4q+nLeymOxVdV4xVF7gIQ4Rqdm+2ict4c4qeAPVpPK34rlmOXsBt
         Lqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=C+n2mFnYxjMdQyExf3HsU7WxNGZU5BDX+JooTakE2y4=;
        b=wZPRC/lzQiCIsXZ2XdosOtx98r5fjn8xWYCmW46sBKUtnrQa3neQ9jJ4A+HMtYcuro
         alglFkToxhgs+cDhDKwZMSCmKrWb63SrOIV0je1eIr+pdDG3QHzZcTQDDrVRl5R2Pt5F
         e8KgGh+9R1JM0mvGHby0meoeLvoJuu4eHUUTw21Tndim5h2apzG3B5g8x+AYP07RlXxd
         705jjGSvhQ2ealBXZJTEFCIW0cI9PKIMCqOgKQkalNNTLtU3iT3FI+g5iRb2J79MKx06
         tQkzuv3hETQv3JUJ0jOxhI2JreNEDscGnQAwK4A2Gge/j9skrYVps4+SRKPnoUNSMldc
         WzVA==
X-Gm-Message-State: AOAM5311shdNa+2e9C8YQriCYQdSO9RjFXQDYCG+YI4PWWYHYyST3tlj
        /KGapxXHf9w9zfsxydfeL6mcyuSB4Zw=
X-Google-Smtp-Source: ABdhPJwnqbaeXm1LJV1yaBFzppAxn5c6m2k54s5Q1aUNQHRt9ap1eDgcI+Peb5oUEj4D/MpXWRqgAg==
X-Received: by 2002:a17:907:1c1c:b0:6fe:cedb:d089 with SMTP id nc28-20020a1709071c1c00b006fecedbd089mr9727530ejc.323.1653371367631;
        Mon, 23 May 2022 22:49:27 -0700 (PDT)
Received: from gmail.com (84-236-113-78.pool.digikabel.hu. [84.236.113.78])
        by smtp.gmail.com with ESMTPSA id dk16-20020a0564021d9000b0042a6d0508a9sm9059626edb.73.2022.05.23.22.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 22:49:26 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 24 May 2022 07:49:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <Yoxx5MeAyIki0peI@gmail.com>
References: <You+G0njuvLvLll3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <You+G0njuvLvLll3@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Linus,
> 
> Please pull the latest sched/core git tree from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-05-23
> 
>    # HEAD: 991d8d8142cad94f9c5c05db25e67fa83d6f772a topology: Remove unused cpu_cluster_mask()
> 
> Scheduler changes in this cycle were:
> 
>  - Updates to scheduler metrics:
> 
>     - PELT fixes & enhancements
>     - PSI fixes & enhancements
>     - Refactor cpu_util_without()
> 
>  - Updates to instrumentation/debugging:
> 
>     - Remove sched_trace_*() helper functions - can be done via debug info
>     - Fix double update_rq_clock() warnings
> 
>  - Introduce & use "preemption model accessors" to simplify some of
>    the Kconfig complexity.
> 
>  - Make softirq handling RT-safe.
> 
>  - Misc smaller fixes & cleanups.
> 
>  Thanks,
> 
> 	Ingo
> 
> ------------------>
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
> Valentin Schneider (5):
>       preempt/dynamic: Introduce preemption model accessors
>       kcsan: Use preemption model accessors
>       ftrace: Use preemption model accessors for trace header printout
>       MAINTAINERS: Add myself as scheduler topology reviewer
>       mailmap: Update my email address to @redhat.com
> 
> zgpeng (1):
>       sched/fair: Move calculate of avg_load to a better location
> 
> 
>  .mailmap                          |   1 +
>  Documentation/accounting/psi.rst  |   9 +-
>  MAINTAINERS                       |   1 +
>  include/asm-generic/vmlinux.lds.h |  12 +-
>  include/linux/interrupt.h         |   9 ++
>  include/linux/sched.h             |  57 ++++++--
>  include/linux/topology.h          |   7 -
>  kernel/kcsan/kcsan_test.c         |   5 +-
>  kernel/sched/build_policy.c       |   2 +
>  kernel/sched/build_utility.c      |   1 +
>  kernel/sched/core.c               |  35 +++--
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
>  23 files changed, 266 insertions(+), 331 deletions(-)

Note that the above is a v5.18 based shortlog and diffstat, but because the 
RCU tree deep-merged one of the scheduler commits that introduced better, 
Kconfig-invariant preemption model accessors:

   cfe43f478b79 preempt/dynamic: Introduce preemption model accessors

... and you merged the RCU tree already, so you'll get this shortlog & 
diffstat:

=============>
Chengming Zhou (3):
      sched/fair: Fix cfs_rq_clock_pelt() for throttled cfs_rq
      sched/fair: Delete useless condition in tg_unthrottle_up()
      sched/psi: report zeroes for CPU full at the system level

Dietmar Eggemann (4):
      sched/fair: Refactor cpu_util_without()
      sched/fair: Remove sched_trace_*() helper functions
      sched/fair: Remove cfs_rq_tg_path()
      topology: Remove unused cpu_cluster_mask()

Hailong Liu (1):
      psi: Fix trigger being fired unexpectedly at initial

Hao Jia (2):
      sched/core: Avoid obvious double update_rq_clock warning
      sched/deadline: Remove superfluous rq clock update in push_dl_task()

Ingo Molnar (1):
      Merge tag 'v5.18-rc5' into sched/core to pull in fixes & to resolve a conflict

Peter Zijlstra (1):
      sched: Reverse sched_class layout

Sebastian Andrzej Siewior (1):
      smp: Make softirq handling RT safe in flush_smp_call_function_queue()

Tao Zhou (1):
      sched/fair: Revise comment about lb decision matrix

Thomas Gleixner (2):
      sched: Fix missing prototype warnings
      smp: Rename flush_smp_call_function_from_idle()

Valentin Schneider (4):
      kcsan: Use preemption model accessors
      ftrace: Use preemption model accessors for trace header printout
      MAINTAINERS: Add myself as scheduler topology reviewer
      mailmap: Update my email address to @redhat.com

zgpeng (1):
      sched/fair: Move calculate of avg_load to a better location

 .mailmap                          |   1 +
 Documentation/accounting/psi.rst  |   9 +-
 MAINTAINERS                       |   1 +
 include/asm-generic/vmlinux.lds.h |  12 +-
 include/linux/interrupt.h         |   9 ++
 include/linux/sched.h             |  16 +--
 include/linux/topology.h          |   7 -
 kernel/kcsan/kcsan_test.c         |   5 +-
 kernel/sched/build_policy.c       |   2 +
 kernel/sched/build_utility.c      |   1 +
 kernel/sched/core.c               |  23 +--
 kernel/sched/deadline.c           |  15 +-
 kernel/sched/fair.c               | 292 +++++++++-----------------------------
 kernel/sched/idle.c               |   2 +-
 kernel/sched/pelt.h               |   4 +-
 kernel/sched/psi.c                |  18 ++-
 kernel/sched/rt.c                 |   5 +-
 kernel/sched/sched.h              |  55 ++++---
 kernel/sched/smp.h                |   6 +
 kernel/smp.c                      |  32 +++--
 kernel/softirq.c                  |  13 ++
 kernel/stop_machine.c             |   2 -
 kernel/trace/trace.c              |  14 +-
 23 files changed, 213 insertions(+), 331 deletions(-)

Thanks,

	Ingo
