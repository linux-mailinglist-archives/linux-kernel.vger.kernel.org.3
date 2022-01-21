Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28394963A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379780AbiAURQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:16:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59214 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379454AbiAURQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:16:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5D03B82069
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E88C340E1;
        Fri, 21 Jan 2022 17:15:59 +0000 (UTC)
Date:   Fri, 21 Jan 2022 12:15:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH v3 0/2] sched/tracing: sched_switch prev_state reported
 as TASK_RUNNING when it's not
Message-ID: <20220121121558.618b98e7@gandalf.local.home>
In-Reply-To: <20220120162520.570782-1-valentin.schneider@arm.com>
References: <20220120162520.570782-1-valentin.schneider@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 16:25:18 +0000
Valentin Schneider <valentin.schneider@arm.com> wrote:

> Hi folks,
> 
> Problem
> =======
> 
> Abhijeet pointed out that the following sequence of trace events can be
> observed:
> 
>   cat-1676  [001] d..3 103.010411: sched_waking: comm=grep pid=1677 prio=120 target_cpu=004
>   grep-1677 [004] d..2 103.010440: sched_switch: prev_comm=grep prev_pid=1677 prev_prio=120 prev_state=R 0x0 ==> next_comm=swapper/4 next_pid=0 next_prio=120
>   <idle>-0  [004] dNh3 103.0100459: sched_wakeup: comm=grep pid=1677 prio=120 target_cpu=004
> 
> IOW, not-yet-woken task gets presented as runnable and switched out in
> favor of the idle task... Dietmar and I had a look, turns out this sequence
> can happen: 
> 
> 		      p->__state = TASK_INTERRUPTIBLE;
> 		      __schedule()
> 			deactivate_task(p);
>   ttwu()
>     READ !p->on_rq
>     p->__state=TASK_WAKING
> 			trace_sched_switch()
> 			  __trace_sched_switch_state()
> 			    task_state_index()
> 			      return 0;
> 
> TASK_WAKING isn't in TASK_REPORT, hence why task_state_index(p) returns 0.
> This can happen as of commit c6e7bd7afaeb ("sched/core: Optimize ttwu()
> spinning on p->on_cpu") which punted the TASK_WAKING write to the other
> side of
> 
>   smp_cond_load_acquire(&p->on_cpu, !VAL);
> 
> in ttwu().
> 
> Uwe reported on #linux-rt what I think is a similar issue with
> TASK_RTLOCK_WAIT on PREEMPT_RT; again that state isn't in TASK_REPORT so
> you get prev_state=0 despite the task blocking on a lock.
> 
> Both of those are very confusing for tooling or even human observers.



This all looks fine to me:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Peter, want to take this through your tree?

-- Steve
