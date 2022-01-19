Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9003249400F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355459AbiASSjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:39:01 -0500
Received: from foss.arm.com ([217.140.110.172]:34882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347148AbiASSix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:38:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB281FB;
        Wed, 19 Jan 2022 10:38:52 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B93483F73D;
        Wed, 19 Jan 2022 10:38:49 -0800 (PST)
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
In-Reply-To: <87h7a06hkr.fsf@email.froward.int.ebiederm.org>
References: <20220117164633.322550-1-valentin.schneider@arm.com> <20220117164633.322550-3-valentin.schneider@arm.com> <878rve89cc.fsf@email.froward.int.ebiederm.org> <878rvd6jgu.mognet@arm.com> <87h7a06hkr.fsf@email.froward.int.ebiederm.org>
Date:   Wed, 19 Jan 2022 18:38:43 +0000
Message-ID: <875yqf7eq4.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/22 12:10, Eric W. Biederman wrote:
> Valentin Schneider <valentin.schneider@arm.com> writes:
>>
>> Alternatively, TASK_RTLOCK_WAIT could be masqueraded as
>> TASK_(UN)INTERRUPTIBLE when reported to userspace - it is actually somewhat
>> similar, unlike TASK_IDLE vs TASK_UNINTERRUPTIBLE for instance. The
>> handling in get_task_state() will be fugly, but it might be preferable over
>> exposing a detail userspace might not need to be made aware of?
>
> Right.
>
> Frequently I have seen people do a cost/benefit analysis.
>
> If the benefit is enough, and tracking down the userspace programs that
> need to be verified to work with the change is inexpensive enough the
> change is made.  Always keeping in mind that if something was missed and
> the change causes a regression the change will need to be reverted.
>
> If there is little benefit or the cost to track down userspace is great
> enough the work is put in to hide the change from userspace.  Just
> because it is too much trouble to expose it to userspace.
>
> I honestly don't have any kind of sense about how hard it is to verify
> that a userspace regression won't result from a change like this.  I
> just know that the question needs to be asked.
>

I see it as: does it actually make sense to expose a new state? All the
information this is conveying is: "this task took a lock that is
substituted by a sleepable lock under PREEMPT_RT". Now that you brought
this up, I don't really see much value in this vs just conveying that the
task is sleeping on a lock, i.e. just report the same as if it had gone
through rt_mutex_lock(), aka:

---
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d00837d12b9d..ac7b3eef4a61 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1626,6 +1626,14 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
 	if (tsk_state == TASK_IDLE)
 		state = TASK_REPORT_IDLE;
 
+	/*
+	 * We're lying here, but rather than expose a completely new task state
+	 * to userspace, we can make this appear as if the task had gone through
+	 * a regular rt_mutex_lock() call.
+	 */
+	if (tsk_state == TASK_RTLOCK_WAIT)
+		state = TASK_UNINTERRUPTIBLE;
+
 	return fls(state);
 }
 

