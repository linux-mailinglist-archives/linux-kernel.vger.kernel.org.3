Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF2E46E8C1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbhLINGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:06:35 -0500
Received: from foss.arm.com ([217.140.110.172]:56408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233267AbhLINGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:06:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60FEEED1;
        Thu,  9 Dec 2021 05:03:00 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 970553F5A1;
        Thu,  9 Dec 2021 05:02:58 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
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
Subject: Re: [RFC PATCH 1/2] sched/tracing: Don't re-read p->state when emitting sched_switch event
In-Reply-To: <20211208151203.2196088c@gandalf.local.home>
References: <20211129123601.2101873-1-valentin.schneider@arm.com> <20211129123601.2101873-2-valentin.schneider@arm.com> <20211208151203.2196088c@gandalf.local.home>
Date:   Thu, 09 Dec 2021 13:02:53 +0000
Message-ID: <875yry9bia.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/21 15:12, Steven Rostedt wrote:
> On Mon, 29 Nov 2021 12:36:00 +0000
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>
>> As of commit
>>
>>   c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
>>
>> the following sequence becomes possible:
>>
>>                    p->__state = TASK_INTERRUPTIBLE;
>>                    __schedule()
>>                      deactivate_task(p);
>>   ttwu()
>>     READ !p->on_rq
>>     p->__state=TASK_WAKING
>>                      trace_sched_switch()
>>                        __trace_sched_switch_state()
>>                          task_state_index()
>>                            return 0;
>>
>> TASK_WAKING isn't in TASK_REPORT, so the task appears as TASK_RUNNING in
>> the trace event.
>>
>> Prevent this by pushing the value read from __schedule() down the trace
>> event.
>>
>> Reported-by: Abhijeet Dharmapurikar <adharmap@quicinc.com>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>> ---
>>  include/linux/sched.h             | 11 ++++++++---
>>  include/trace/events/sched.h      | 11 +++++++----
>>  kernel/sched/core.c               |  4 ++--
>>  kernel/trace/fgraph.c             |  4 +++-
>>  kernel/trace/ftrace.c             |  4 +++-
>>  kernel/trace/trace_events.c       |  8 ++++++--
>>  kernel/trace/trace_sched_switch.c |  1 +
>
> I believe you may have missed some functions that register the sched_switch
> event. Do a git grep on register_trace_sched_switch.
>

Thanks! I'll wait a bit to see if anyone truly hates the idea and then will
patch those up.

> -- Steve
>
>
>>  7 files changed, 30 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index d2e261adb8ea..d00837d12b9d 100644
