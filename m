Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6080492C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244059AbiARR32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:29:28 -0500
Received: from foss.arm.com ([217.140.110.172]:33994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347244AbiARR31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:29:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A693BD6E;
        Tue, 18 Jan 2022 09:29:26 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B9D03F774;
        Tue, 18 Jan 2022 09:29:24 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Kenta.Tada\@sony.com" <Kenta.Tada@sony.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ed Tsai <ed.tsai@mediatek.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/tracing: Add TASK_RTLOCK_WAIT to TASK_REPORT
In-Reply-To: <878rve89cc.fsf@email.froward.int.ebiederm.org>
References: <20220117164633.322550-1-valentin.schneider@arm.com> <20220117164633.322550-3-valentin.schneider@arm.com> <878rve89cc.fsf@email.froward.int.ebiederm.org>
Date:   Tue, 18 Jan 2022 17:29:21 +0000
Message-ID: <878rvd6jgu.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/22 13:12, Eric W. Biederman wrote:
> Valentin Schneider <valentin.schneider@arm.com> writes:
>> --- a/fs/proc/array.c
>> +++ b/fs/proc/array.c
>> @@ -128,9 +128,10 @@ static const char * const task_state_array[] = {
>>  	"X (dead)",		/* 0x10 */
>>  	"Z (zombie)",		/* 0x20 */
>>  	"P (parked)",		/* 0x40 */
>> +	"L (rt-locked)",        /* 0x80 */
>>  
>>  	/* states beyond TASK_REPORT: */
>> -	"I (idle)",		/* 0x80 */
>> +	"I (idle)",		/* 0x100 */
>>  };
>
> I think this is at least possibly an ABI break.  I have a vague memory
> that userspace is not ready being reported new task states.  Which is
> why we encode some of our states the way we do.
>
> Maybe it was just someone being very conservative.
>
> Still if you are going to add new states to userspace and risk breaking
> them can you do some basic analysis and report what ps and similar
> programs do.
>
> Simply changing userspace without even mentioning that you are changing
> the userspace output of proc looks dangerous indeed.
>

Yeah, you're right.

> Looking in the history commit 74e37200de8e ("proc: cleanup/simplify
> get_task_state/task_state_array") seems to best document the concern
> that userspace does not know how to handle new states.
>

Thanks for the sha1 and for digging around. Now, I read
74e37200de8e ("proc: cleanup/simplify get_task_state/task_state_array")
as "get_task_state() isn't clear vs what value is actually exposed to
userspace" rather than "get_task_state() could expose things userspace
doesn't know what to do with".

> The fact we have had a parked state for quite a few years despite that
> concern seems to argue it is possible to extend the states.  Or perhaps
> it just argues that parked states are rare enough it does not matter.
>
> It is definitely the case that the ps manpage documents the possible
> states and as such they could be a part of anyone's shell scripts.
>

06eb61844d84 ("sched/debug: Add explicit TASK_IDLE printing") for instance
seems to suggest extending the states OK, but you're right that this then
requires updating ps' manpage.

Alternatively, TASK_RTLOCK_WAIT could be masqueraded as
TASK_(UN)INTERRUPTIBLE when reported to userspace - it is actually somewhat
similar, unlike TASK_IDLE vs TASK_UNINTERRUPTIBLE for instance. The
handling in get_task_state() will be fugly, but it might be preferable over
exposing a detail userspace might not need to be made aware of?

> From the ps man page:
>>        Here are the different values that the s, stat and state output
>>        specifiers (header "STAT" or "S") will display to describe the
>>        state of a process:
>> 
>>                D    uninterruptible sleep (usually IO)
>>                I    Idle kernel thread
>>                R    running or runnable (on run queue)
>>                S    interruptible sleep (waiting for an event to complete)
>>                T    stopped by job control signal
>>                t    stopped by debugger during the tracing
>>                W    paging (not valid since the 2.6.xx kernel)
>>                X    dead (should never be seen)
>>                Z    defunct ("zombie") process, terminated but not reaped by its parent
>> 
>
> So it looks like a change that adds to the number of states in the
> kernel should update the ps man page as well.
>
> Eric
