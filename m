Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1200451AC86
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376627AbiEDSRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376703AbiEDSRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:17:14 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4AF86E39;
        Wed,  4 May 2022 10:37:43 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:39280)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmIwW-001XCw-8N; Wed, 04 May 2022 11:37:40 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36936 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmIwT-00EmeC-TQ; Wed, 04 May 2022 11:37:39 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
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
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
        <20220429214837.386518-7-ebiederm@xmission.com>
        <20220502153934.GD17276@redhat.com>
        <87levjrixl.fsf@email.froward.int.ebiederm.org>
        <20220503134149.GA22999@redhat.com>
        <877d72l50n.fsf@email.froward.int.ebiederm.org>
        <20220504140210.GA24581@redhat.com>
Date:   Wed, 04 May 2022 12:37:07 -0500
In-Reply-To: <20220504140210.GA24581@redhat.com> (Oleg Nesterov's message of
        "Wed, 4 May 2022 16:02:38 +0200")
Message-ID: <87h765ci7w.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nmIwT-00EmeC-TQ;;;mid=<87h765ci7w.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/okH30qBwmDRs8Am6a013Vr3keSCsXcuk=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1676 ms - load_scoreonly_sql: 0.23 (0.0%),
        signal_user_changed: 12 (0.7%), b_tie_ro: 10 (0.6%), parse: 2.4 (0.1%),
         extract_message_metadata: 9 (0.6%), get_uri_detail_list: 5 (0.3%),
        tests_pri_-1000: 5 (0.3%), tests_pri_-950: 2.0 (0.1%), tests_pri_-900:
        1.36 (0.1%), tests_pri_-90: 75 (4.5%), check_bayes: 74 (4.4%),
        b_tokenize: 16 (0.9%), b_tok_get_all: 12 (0.7%), b_comp_prob: 5 (0.3%),
         b_tok_touch_all: 37 (2.2%), b_finish: 0.93 (0.1%), tests_pri_0: 1540
        (91.9%), check_dkim_signature: 0.87 (0.1%), check_dkim_adsp: 2.9
        (0.2%), poll_dns_idle: 0.98 (0.1%), tests_pri_10: 2.3 (0.1%),
        tests_pri_500: 13 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 07/12] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/03, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > But why is it bad if the tracee doesn't sleep in schedule ? If it races
>> > with SIGKILL. I still can't understand this.
>> >
>> > Yes, wait_task_inactive() can fail, so you need to remove WARN_ON_ONCE()
>> > in 11/12.
>>
>> >
>> > Why is removing TASK_WAKEKILL from TASK_TRACED and complicating
>> > *signal_wake_up() better?
>>
>> Not changing __state is better because it removes special cases
>> from the scheduler that only apply to ptrace.
>
> Hmm. But I didn't argue with that? I like the idea of JOBCTL_TASK_FROZEN.
>
> I meant, I do not think that removing KILLABLE from TASK_TRACED (not
> from __state) and complicating *signal_wake_up() (I mean, compared
> to your previous version) is a good idea.
>
> And. At least in context of this series it is fine if the JOBCTL_TASK_FROZEN
> tracee do not block in schedule(), just you need to remove WARN_ON_ONCE()
> around wait_task_inactive().
>
>> > And even if we need to ensure the tracee will always block after
>> > ptrace_freeze_traced(), we can change signal_pending_state() to
>> > return false if JOBCTL_PTRACE_FROZEN. Much simpler, imo. But still
>> > looks unnecessary to me.
>>
>> We still need to change signal_wake_up in that case.  Possibly
>> signal_wake_up_state.
>
> Of course. See above.
>
>> >> if we depend on wait_task_inactive failing if the process is in the
>> >> wrong state.
>> >
>> > OK, I guess this is what I do not understand. Could you spell please?
>> >
>> > And speaking of RT, wait_task_inactive() still can fail because
>> > cgroup_enter_frozen() takes css_set_lock? And it is called under
>> > preempt_disable() ? I don't understand the plan :/
>>
>> Let me describe his freezer change as that is much easier to get to the
>> final result.  RT has more problems as it turns all spin locks into
>> sleeping locks.  When a task is frozen
>
> [...snip...]
>
> Oh, thanks Eric, but I understand this part. But I still can't understand
> why is it that critical to block in schedule... OK, I need to think about
> it. Lets assume this is really necessary.
>
> Anyway. I'd suggest to not change TASK_TRACED in this series and not
> complicate signal_wake_up() more than you did in your previous version:
>
> 	static inline void signal_wake_up(struct task_struct *t, bool resume)
> 	{
> 		bool wakekill = resume && !(t->jobctl & JOBCTL_DELAY_WAKEKILL);
> 		signal_wake_up_state(t, wakekill ? TASK_WAKEKILL : 0);
> 	}

If your concern is signal_wake_up there is no reason it can't be:

	static inline void signal_wake_up(struct task_struct *t, bool fatal)
        {
        	fatal = fatal && !(t->jobctl & JOBCTL_PTRACE_FROZEN);
                signal_wake_up_state(t, fatal ? TASK_WAKEKILL | TASK_TRACED : 0);
        }

I guess I was more targeted in this version, which lead to more if
statements but as there is only one place in the code that can be
JOBCTL_PTRACE_FROZEN and TASK_TRACED there is no point in setting
TASK_WAKEKILL without also setting TASK_TRACED in the wake-up.

So yes. I can make the code as simple as my earlier version of
signal_wake_up.

> JOBCTL_PTRACE_FROZEN is fine.
>
> ptrace_check_attach() can do
>
> 	if (!ret && !ignore_state &&
> 	    /*
> 	     * This can only fail if the frozen tracee races with
> 	     * SIGKILL and enters schedule() with fatal_signal_pending
> 	     */
> 	    !wait_task_inactive(child, __TASK_TRACED))
> 		ret = -ESRCH;
>
> 	return ret;
>
>
> Now. If/when we really need to ensure that the frozen tracee always
> blocks and wait_task_inactive() never fails, we can just do
>
> 	- add the fatal_signal_pending() check into ptrace_stop()
> 	  (like this patch does)
>
> 	- say, change signal_pending_state:
>
> 	static inline int signal_pending_state(unsigned int state, struct task_struct *p)
> 	{
> 		if (!(state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
> 			return 0;
> 		if (!signal_pending(p))
> 			return 0;
> 		if (p->jobctl & JOBCTL_TASK_FROZEN)
> 			return 0;
> 		return (state & TASK_INTERRUPTIBLE) || __fatal_signal_pending(p);
> 	}
>
> in a separate patch which should carefully document the need for this
> change.
>
>> > I didn't look at JOBCTL_PTRACE_SIGNR yet. But this looks minor to me,
>> > I mean, I am not sure it worth the trouble.
>>
>> The immediate problem the JOBCTL_PTRACE_SIGNR patch solves is:
>> - stopping in ptrace_report_syscall.
>> - Not having PT_TRACESYSGOOD set.
>> - The tracee being killed with a fatal signal
>         ^^^^^^
>         tracer ?

Both actually.

>> - The tracee sending SIGTRAP to itself.
>
> Oh, but this is clear. But do we really care? If the tracer exits
> unexpectedly, the tracee can have a lot more problems, I don't think
> that this particular one is that important.

I don't know of complaints, and if you haven't heard them either
that that is a good indication that in practice we don't care.

At a practical level I just don't want that silly case that sets
TASK_TRACED to TASK_RUNNING without stopping at all in ptrace_stop to
remain.  It just seems to make everything more complicated for no real
reason anymore.  The deadlocks may_ptrace_stop was guarding against are
gone.

Plus the test is so racy we case can happen after we drop siglock
before we schedule, or shortly after we have stopped so we really
don't reliably catch the condition the code is trying to catch.

I think the case I care most about is ptrace_signal, which pretty much
requires the tracer to wait and clear exit_code before being terminated
to cause problems.  We don't handle that at all today.

So yeah.  I think the code handles so little at this point we can just
remove the code and simplify things, if we actually care we can come
back and implement JOBCTL_PTRACE_SIGNR or the like.

I will chew on that a bit and see if I can find any reasons for keeping
the code in ptrace_stop at all.



As an added data point we can probably remove handling of the signal
from ptrace_report_syscall entirely (not in this patchset!).

I took a quick skim and it appears that sending a signal in
ptrace_report_syscall appears to be a feature introduced with ptrace
support in Linux v1.0 and the comment in ptrace_report_syscall appears
to document the fact that the code has always been dead.


I made it through 13 of 133 pages of debian code search results for
PTRACE_SYSCALL, and the only use I could find of setting the continue
signal was when the signal reported from wait was not SIGTRAP.  Exactly
the same as in the comment in ptrace_report_syscall.

If that pattern holds for all of the uses of ptrace then the code
in ptrace_report_syscall is dead.



Eric

