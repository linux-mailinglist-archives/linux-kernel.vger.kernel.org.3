Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A59546DCC4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbhLHUPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236608AbhLHUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:15:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC173C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:12:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04DD3B8226E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 20:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6ECC00446;
        Wed,  8 Dec 2021 20:12:04 +0000 (UTC)
Date:   Wed, 8 Dec 2021 15:12:03 -0500
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/2] sched/tracing: Don't re-read p->state when
 emitting sched_switch event
Message-ID: <20211208151203.2196088c@gandalf.local.home>
In-Reply-To: <20211129123601.2101873-2-valentin.schneider@arm.com>
References: <20211129123601.2101873-1-valentin.schneider@arm.com>
        <20211129123601.2101873-2-valentin.schneider@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 12:36:00 +0000
Valentin Schneider <valentin.schneider@arm.com> wrote:

> As of commit
> 
>   c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
> 
> the following sequence becomes possible:
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
> TASK_WAKING isn't in TASK_REPORT, so the task appears as TASK_RUNNING in
> the trace event.
> 
> Prevent this by pushing the value read from __schedule() down the trace
> event.
> 
> Reported-by: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  include/linux/sched.h             | 11 ++++++++---
>  include/trace/events/sched.h      | 11 +++++++----
>  kernel/sched/core.c               |  4 ++--
>  kernel/trace/fgraph.c             |  4 +++-
>  kernel/trace/ftrace.c             |  4 +++-
>  kernel/trace/trace_events.c       |  8 ++++++--
>  kernel/trace/trace_sched_switch.c |  1 +

I believe you may have missed some functions that register the sched_switch
event. Do a git grep on register_trace_sched_switch.

-- Steve


>  7 files changed, 30 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d2e261adb8ea..d00837d12b9d 100644
