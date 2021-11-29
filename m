Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1664546153D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbhK2Mlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:41:32 -0500
Received: from foss.arm.com ([217.140.110.172]:37696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350257AbhK2Mja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:39:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44EEA1042;
        Mon, 29 Nov 2021 04:36:11 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 623A43F5A1;
        Mon, 29 Nov 2021 04:36:09 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 0/2] sched/tracing: sched_switch prev_state reported as TASK_RUNNING when it's not
Date:   Mon, 29 Nov 2021 12:35:59 +0000
Message-Id: <20211129123601.2101873-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Problem
=======

Abhijeet pointed out that the following sequence of trace events can be
observed:

  cat-1676  [001] d..3 103.010411: sched_waking: comm=grep pid=1677 prio=120 target_cpu=004
  grep-1677 [004] d..2 103.010440: sched_switch: prev_comm=grep prev_pid=1677 prev_prio=120 prev_state=R 0x0 ==> next_comm=swapper/4 next_pid=0 next_prio=120
  <idle>-0  [004] dNh3 103.0100459: sched_wakeup: comm=grep pid=1677 prio=120 target_cpu=004

IOW, not-yet-woken task gets presented as runnable and switched out in
favor of the idle task... Dietmar and I had a look, turns out this sequence
can happen: 

		      p->__state = TASK_INTERRUPTIBLE;
		      __schedule()
			deactivate_task(p);
  ttwu()
    READ !p->on_rq
    p->__state=TASK_WAKING
			trace_sched_switch()
			  __trace_sched_switch_state()
			    task_state_index()
			      return 0;

TASK_WAKING isn't in TASK_REPORT, hence why task_state_index(p) returns 0.
This can happen as of commit c6e7bd7afaeb ("sched/core: Optimize ttwu()
spinning on p->on_cpu") which punted the TASK_WAKING write to the other
side of

  smp_cond_load_acquire(&p->on_cpu, !VAL);

in ttwu().

Uwe reported on #linux-rt what I think is a similar issue with
TASK_RTLOCK_WAIT on PREEMPT_RT; again that state isn't in TASK_REPORT so
you get prev_state=0 despite the task blocking on a lock.

Both of those are very confusing for tooling or even human observers.

Patches
=======

For the TASK_WAKING case, pushing the prev_state read in __schedule() down
to __trace_sched_switch_state() seems sufficient. That's patch 1.

For TASK_RTLOCK_WAIT, it's a bit trickier. One could use ->saved_state as
prev_state, but
a) that is also susceptible to racing (see ttwu() / ttwu_state_match())
b) some lock substitutions (e.g. rt_spin_lock()) leave ->saved_state as
   TASK_RUNNING.

Patch 2 adds TASK_RTLOCK_WAIT to TASK_REPORT instead.

Testing
=======

Briefly tested on an Arm Juno via ftrace+hackbench against
o tip/sched/core@8c92606ab810
o v5.16-rc2-rt4 w/ CONFIG_PREEMPT_RT

Cheers,
Valentin

Valentin Schneider (2):
  sched/tracing: Don't re-read p->state when emitting sched_switch event
  sched/tracing: Add TASK_RTLOCK_WAIT to TASK_REPORT

 fs/proc/array.c                   |  3 ++-
 include/linux/sched.h             | 28 +++++++++++++++++-----------
 include/trace/events/sched.h      | 12 ++++++++----
 kernel/sched/core.c               |  4 ++--
 kernel/trace/fgraph.c             |  4 +++-
 kernel/trace/ftrace.c             |  4 +++-
 kernel/trace/trace_events.c       |  8 ++++++--
 kernel/trace/trace_sched_switch.c |  1 +
 8 files changed, 42 insertions(+), 22 deletions(-)

--
2.25.1

