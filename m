Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6636451AD15
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377044AbiEDSlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377146AbiEDSi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:38:26 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A5F32054;
        Wed,  4 May 2022 11:29:07 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:56154)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmJkH-00DgEo-PT; Wed, 04 May 2022 12:29:05 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36958 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmJkG-00DgBZ-C9; Wed, 04 May 2022 12:29:05 -0600
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
        <87h765ci7w.fsf@email.froward.int.ebiederm.org>
Date:   Wed, 04 May 2022 13:28:56 -0500
In-Reply-To: <87h765ci7w.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 04 May 2022 12:37:07 -0500")
Message-ID: <87tua5b193.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nmJkG-00DgBZ-C9;;;mid=<87tua5b193.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+iESQYYB4OuhxUA6dLZ8MgjpNZTFWGE40=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 747 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.4 (0.6%), b_tie_ro: 2.9 (0.4%), parse: 1.48
        (0.2%), extract_message_metadata: 18 (2.3%), get_uri_detail_list: 5
        (0.7%), tests_pri_-1000: 13 (1.7%), tests_pri_-950: 0.98 (0.1%),
        tests_pri_-900: 0.94 (0.1%), tests_pri_-90: 123 (16.5%), check_bayes:
        121 (16.2%), b_tokenize: 13 (1.8%), b_tok_get_all: 15 (1.9%),
        b_comp_prob: 5 (0.7%), b_tok_touch_all: 85 (11.3%), b_finish: 0.74
        (0.1%), tests_pri_0: 570 (76.4%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 10 (1.3%), poll_dns_idle: 0.13 (0.0%), tests_pri_10:
        2.9 (0.4%), tests_pri_500: 8 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 07/12] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Oleg Nesterov <oleg@redhat.com> writes:
>
>> On 05/03, Eric W. Biederman wrote:
>>>
>>> Oleg Nesterov <oleg@redhat.com> writes:
>>>
>>> > But why is it bad if the tracee doesn't sleep in schedule ? If it races
>>> > with SIGKILL. I still can't understand this.
>>> >
>>> > Yes, wait_task_inactive() can fail, so you need to remove WARN_ON_ONCE()
>>> > in 11/12.
>>>
>>> >
>>> > Why is removing TASK_WAKEKILL from TASK_TRACED and complicating
>>> > *signal_wake_up() better?
>>>
>>> Not changing __state is better because it removes special cases
>>> from the scheduler that only apply to ptrace.
>>
>> Hmm. But I didn't argue with that? I like the idea of JOBCTL_TASK_FROZEN.
>>
>> I meant, I do not think that removing KILLABLE from TASK_TRACED (not
>> from __state) and complicating *signal_wake_up() (I mean, compared
>> to your previous version) is a good idea.
>>
>> And. At least in context of this series it is fine if the JOBCTL_TASK_FROZEN
>> tracee do not block in schedule(), just you need to remove WARN_ON_ONCE()
>> around wait_task_inactive().
>>
>>> > And even if we need to ensure the tracee will always block after
>>> > ptrace_freeze_traced(), we can change signal_pending_state() to
>>> > return false if JOBCTL_PTRACE_FROZEN. Much simpler, imo. But still
>>> > looks unnecessary to me.
>>>
>>> We still need to change signal_wake_up in that case.  Possibly
>>> signal_wake_up_state.
>>
>> Of course. See above.
>>
>>> >> if we depend on wait_task_inactive failing if the process is in the
>>> >> wrong state.
>>> >
>>> > OK, I guess this is what I do not understand. Could you spell please?
>>> >
>>> > And speaking of RT, wait_task_inactive() still can fail because
>>> > cgroup_enter_frozen() takes css_set_lock? And it is called under
>>> > preempt_disable() ? I don't understand the plan :/
>>>
>>> Let me describe his freezer change as that is much easier to get to the
>>> final result.  RT has more problems as it turns all spin locks into
>>> sleeping locks.  When a task is frozen
>>
>> [...snip...]
>>
>> Oh, thanks Eric, but I understand this part. But I still can't understand
>> why is it that critical to block in schedule... OK, I need to think about
>> it. Lets assume this is really necessary.
>>
>> Anyway. I'd suggest to not change TASK_TRACED in this series and not
>> complicate signal_wake_up() more than you did in your previous version:
>>
>> 	static inline void signal_wake_up(struct task_struct *t, bool resume)
>> 	{
>> 		bool wakekill = resume && !(t->jobctl & JOBCTL_DELAY_WAKEKILL);
>> 		signal_wake_up_state(t, wakekill ? TASK_WAKEKILL : 0);
>> 	}
>
> If your concern is signal_wake_up there is no reason it can't be:
>
> 	static inline void signal_wake_up(struct task_struct *t, bool fatal)
>         {
>         	fatal = fatal && !(t->jobctl & JOBCTL_PTRACE_FROZEN);
>                 signal_wake_up_state(t, fatal ? TASK_WAKEKILL | TASK_TRACED : 0);
>         }
>
> I guess I was more targeted in this version, which lead to more if
> statements but as there is only one place in the code that can be
> JOBCTL_PTRACE_FROZEN and TASK_TRACED there is no point in setting
> TASK_WAKEKILL without also setting TASK_TRACED in the wake-up.
>
> So yes. I can make the code as simple as my earlier version of
> signal_wake_up.
>
>> JOBCTL_PTRACE_FROZEN is fine.
>>
>> ptrace_check_attach() can do
>>
>> 	if (!ret && !ignore_state &&
>> 	    /*
>> 	     * This can only fail if the frozen tracee races with
>> 	     * SIGKILL and enters schedule() with fatal_signal_pending
>> 	     */
>> 	    !wait_task_inactive(child, __TASK_TRACED))
>> 		ret = -ESRCH;
>>
>> 	return ret;
>>
>>
>> Now. If/when we really need to ensure that the frozen tracee always
>> blocks and wait_task_inactive() never fails, we can just do
>>
>> 	- add the fatal_signal_pending() check into ptrace_stop()
>> 	  (like this patch does)
>>
>> 	- say, change signal_pending_state:
>>
>> 	static inline int signal_pending_state(unsigned int state, struct task_struct *p)
>> 	{
>> 		if (!(state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
>> 			return 0;
>> 		if (!signal_pending(p))
>> 			return 0;
>> 		if (p->jobctl & JOBCTL_TASK_FROZEN)
>> 			return 0;
>> 		return (state & TASK_INTERRUPTIBLE) || __fatal_signal_pending(p);
>> 	}
>>
>> in a separate patch which should carefully document the need for this
>> change.
>>
>>> > I didn't look at JOBCTL_PTRACE_SIGNR yet. But this looks minor to me,
>>> > I mean, I am not sure it worth the trouble.
>>>
>>> The immediate problem the JOBCTL_PTRACE_SIGNR patch solves is:
>>> - stopping in ptrace_report_syscall.
>>> - Not having PT_TRACESYSGOOD set.
>>> - The tracee being killed with a fatal signal
>>         ^^^^^^
>>         tracer ?
>
> Both actually.
>
>>> - The tracee sending SIGTRAP to itself.
>>
>> Oh, but this is clear. But do we really care? If the tracer exits
>> unexpectedly, the tracee can have a lot more problems, I don't think
>> that this particular one is that important.
>
> I don't know of complaints, and if you haven't heard them either
> that that is a good indication that in practice we don't care.
>
> At a practical level I just don't want that silly case that sets
> TASK_TRACED to TASK_RUNNING without stopping at all in ptrace_stop to
> remain.  It just seems to make everything more complicated for no real
> reason anymore.  The deadlocks may_ptrace_stop was guarding against are
> gone.
>
> Plus the test is so racy we case can happen after we drop siglock
> before we schedule, or shortly after we have stopped so we really
> don't reliably catch the condition the code is trying to catch.
>
> I think the case I care most about is ptrace_signal, which pretty much
> requires the tracer to wait and clear exit_code before being terminated
> to cause problems.  We don't handle that at all today.
>
> So yeah.  I think the code handles so little at this point we can just
> remove the code and simplify things, if we actually care we can come
> back and implement JOBCTL_PTRACE_SIGNR or the like.

The original explanation for handling this is:

commit 66519f549ae516e7ff2f24a8a5134713411a4a58
Author: Roland McGrath <roland@redhat.com>
Date:   Tue Jan 4 05:38:15 2005 -0800

    [PATCH] fix ptracer death race yielding bogus BUG_ON
    
    There is a BUG_ON in ptrace_stop that hits if the thread is not ptraced.
    However, there is no synchronization between a thread deciding to do a
    ptrace stop and so going here, and its ptracer dying and so detaching from
    it and clearing its ->ptrace field.
    
    The RHEL3 2.4-based kernel has a backport of a slightly older version of
    the 2.6 signals code, which has a different but equivalent BUG_ON.  This
    actually bit users in practice (when the debugger dies), but was
    exceedingly difficult to reproduce in contrived circumstances.  We moved
    forward in RHEL3 just by removing the BUG_ON, and that fixed the real user
    problems even though I was never able to reproduce the scenario myself.
    So, to my knowledge this scenario has never actually been seen in practice
    under 2.6.  But it's plain to see from the code that it is indeed possible.
    
    This patch removes that BUG_ON, but also goes further and tries to handle
    this case more gracefully than simply avoiding the crash.  By removing the
    BUG_ON alone, it becomes possible for the real parent of a process to see
    spurious SIGCHLD notifications intended for the debugger that has just
    died, and have its child wind up stopped unexpectedly.  This patch avoids
    that possibility by detecting the case when we are about to do the ptrace
    stop but our ptracer has gone away, and simply eliding that ptrace stop
    altogether as if we hadn't been ptraced when we hit the interesting event
    (signal or ptrace_notify call for syscall tracing or something like that).
    
    Signed-off-by: Roland McGrath <roland@redhat.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

And it was all about
	BUG_ON(!(current->ptrace & PT_PTRACED));
At the beginning of ptrace_stop.

Which seems like a bit of buggy overkill.

>
> I will chew on that a bit and see if I can find any reasons for keeping
> the code in ptrace_stop at all.

Still chewing.

Eric
