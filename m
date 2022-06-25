Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9313855AB99
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 18:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiFYQfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 12:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiFYQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 12:35:38 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0E614032;
        Sat, 25 Jun 2022 09:35:35 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:35330)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o58kr-008kAJ-Nv; Sat, 25 Jun 2022 10:35:29 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57546 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o58kq-009tMf-I3; Sat, 25 Jun 2022 10:35:29 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <20220505182645.497868-12-ebiederm@xmission.com>
        <YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
        <877d5ajesi.fsf@email.froward.int.ebiederm.org>
        <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Date:   Sat, 25 Jun 2022 11:34:46 -0500
In-Reply-To: <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
        (Alexander Gordeev's message of "Tue, 21 Jun 2022 17:15:47 +0200")
Message-ID: <87y1xk8zx5.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o58kq-009tMf-I3;;;mid=<87y1xk8zx5.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/ePAFA6q9C005iTa3Ih+Tk89HZHCvrB+c=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Alexander Gordeev <agordeev@linux.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 604 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (2.0%), b_tie_ro: 11 (1.7%), parse: 1.24
        (0.2%), extract_message_metadata: 15 (2.5%), get_uri_detail_list: 3.3
        (0.6%), tests_pri_-1000: 12 (2.0%), tests_pri_-950: 1.43 (0.2%),
        tests_pri_-900: 1.14 (0.2%), tests_pri_-90: 78 (12.9%), check_bayes:
        76 (12.6%), b_tokenize: 16 (2.6%), b_tok_get_all: 15 (2.5%),
        b_comp_prob: 4.7 (0.8%), b_tok_touch_all: 36 (5.9%), b_finish: 1.23
        (0.2%), tests_pri_0: 462 (76.4%), check_dkim_signature: 1.17 (0.2%),
        check_dkim_adsp: 3.6 (0.6%), poll_dns_idle: 0.64 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 15 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Gordeev <agordeev@linux.ibm.com> writes:

> On Tue, Jun 21, 2022 at 09:02:05AM -0500, Eric W. Biederman wrote:
>> Alexander Gordeev <agordeev@linux.ibm.com> writes:
>> 
>> > On Thu, May 05, 2022 at 01:26:45PM -0500, Eric W. Biederman wrote:
>> >> From: Peter Zijlstra <peterz@infradead.org>
>> >> 
>> >> Currently ptrace_stop() / do_signal_stop() rely on the special states
>> >> TASK_TRACED and TASK_STOPPED resp. to keep unique state. That is, this
>> >> state exists only in task->__state and nowhere else.
>> >> 
>> >> There's two spots of bother with this:
>> >> 
>> >>  - PREEMPT_RT has task->saved_state which complicates matters,
>> >>    meaning task_is_{traced,stopped}() needs to check an additional
>> >>    variable.
>> >> 
>> >>  - An alternative freezer implementation that itself relies on a
>> >>    special TASK state would loose TASK_TRACED/TASK_STOPPED and will
>> >>    result in misbehaviour.
>> >> 
>> >> As such, add additional state to task->jobctl to track this state
>> >> outside of task->__state.
>> >> 
>> >> NOTE: this doesn't actually fix anything yet, just adds extra state.
>> >> 
>> >> --EWB
>> >>   * didn't add a unnecessary newline in signal.h
>> >>   * Update t->jobctl in signal_wake_up and ptrace_signal_wake_up
>> >>     instead of in signal_wake_up_state.  This prevents the clearing
>> >>     of TASK_STOPPED and TASK_TRACED from getting lost.
>> >>   * Added warnings if JOBCTL_STOPPED or JOBCTL_TRACED are not cleared
>> >
>> > Hi Eric, Peter,
>> >
>> > On s390 this patch triggers warning at kernel/ptrace.c:272 when
>> > kill_child testcase from strace tool is repeatedly used (the source
>> > is attached for reference):
>> >
>> > while :; do
>> > 	strace -f -qq -e signal=none -e trace=sched_yield,/kill ./kill_child
>> > done
>> >
>> > It normally takes few minutes to cause the warning in -rc3, but FWIW
>> > it hits almost immediately for ptrace_stop-cleanup-for-v5.19 tag of
>> > git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.
>> >
>> > Commit 7b0fe1367ef2 ("ptrace: Document that wait_task_inactive can't
>> > fail") suggests this WARN_ON_ONCE() is not really expected, yet we
>> > observe a child in __TASK_TRACED state. Could you please comment here?
>> >
>> 
>> For clarity the warning is that the child is not in __TASK_TRACED state.
>> 
>> The code is waiting for the code to stop in the scheduler in the
>> __TASK_TRACED state so that it can safely read and change the
>> processes state.  Some of that state is not even saved until the
>> process is scheduled out so we have to wait until the process
>> is stopped in the scheduler.
>
> So I assume (checked actually) the return 0 below from kernel/sched/core.c:
> wait_task_inactive() is where it bails out:
>
> 3303                 while (task_running(rq, p)) {
> 3304                         if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
> 3305                                 return 0;
> 3306                         cpu_relax();
> 3307                 }
>
> Yet, the child task is always found in __TASK_TRACED state (as seen
> in crash dumps):
>
>> 101447  11342  13      ce3a8100      RU   0.0   10040   4412  strace
>   101450  101447   0      bb04b200      TR   0.0    2272   1136  kill_child
>   108261  101447   2      d0b10100      TR   0.0    2272    532  kill_child
> crash> task bb04b200 __state
> PID: 101450  TASK: bb04b200          CPU: 0   COMMAND: "kill_child"
>   __state = 8,
>
> crash> task d0b10100 __state
> PID: 108261  TASK: d0b10100          CPU: 2   COMMAND: "kill_child"
>   __state = 8,
>

I haven't gotten as far as reproducing this but I have started giving
this issue some thought.

This entire thing smells like a memory barrier is missing somewhere.
However by definition the lock implementations in linux provide all the
needed memory barriers, and in the ptrace_stop and ptrace_check_attach
path I don't see cases where these values are sampled outside of a lock
except in wait_task_inactive.  Does doing that perhaps require a
barrier? 

The two things I can think of that could shed light on what is going on
is enabling lockdep, to enable the debug check in signal_wake_up_state
and verifying bits of state that should be constant while the task
is frozen for ptrace are indeed constant when task is frozen for ptrace.
Something like my patch below.

If you could test that when you have a chance that would help narrow
down what is going on.

Thank you,
Eric

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 156a99283b11..6467a2b1c3bc 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -268,9 +268,13 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	}
 	read_unlock(&tasklist_lock);
 
-	if (!ret && !ignore_state &&
-	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
+	if (!ret && !ignore_state) {
+		WARN_ON_ONCE(!(child->jobctl & JOBCTL_PTRACE_FROZEN));
+		WARN_ON_ONCE(!(child->joctctl & JOBCTL_TRACED));
+		WARN_ON_ONCE(READ_ONCE(child->__state) != __TASK_TRACED);
+		WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED));
 		ret = -ESRCH;
+	}
 
 	return ret;
 }
