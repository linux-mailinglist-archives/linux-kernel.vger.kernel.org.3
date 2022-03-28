Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843CC4E99F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 16:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243989AbiC1Onb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 10:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiC1Ona (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 10:43:30 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC93FBFD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 07:41:49 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:37816)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nYqZ1-008WiG-HV; Mon, 28 Mar 2022 08:41:47 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41450 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nYqZ0-00FCmj-4x; Mon, 28 Mar 2022 08:41:47 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <Ygq5aBB/qMQw6aP5@linutronix.de>
        <8735j2xigt.fsf@email.froward.int.ebiederm.org>
Date:   Mon, 28 Mar 2022 09:41:37 -0500
In-Reply-To: <8735j2xigt.fsf@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 28 Mar 2022 09:25:06 -0500")
Message-ID: <87h77iw34u.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nYqZ0-00FCmj-4x;;;mid=<87h77iw34u.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1924Is3j2oIYwZQNzMPHmCH4vyRECD2J88=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 783 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 4.5 (0.6%), b_tie_ro: 3.1 (0.4%), parse: 1.42
        (0.2%), extract_message_metadata: 19 (2.4%), get_uri_detail_list: 5
        (0.7%), tests_pri_-1000: 17 (2.2%), tests_pri_-950: 1.02 (0.1%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-90: 203 (26.0%), check_bayes:
        195 (25.0%), b_tokenize: 12 (1.6%), b_tok_get_all: 13 (1.7%),
        b_comp_prob: 4.0 (0.5%), b_tok_touch_all: 162 (20.7%), b_finish: 0.77
        (0.1%), tests_pri_0: 522 (66.7%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 1.84 (0.2%), poll_dns_idle: 0.26 (0.0%),
        tests_pri_10: 2.9 (0.4%), tests_pri_500: 8 (1.0%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] signal/x86: Delay calling signals in atomic
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>
>> From: Oleg Nesterov <oleg@redhat.com>
>> Date: Tue, 14 Jul 2015 14:26:34 +0200
>>
>> On x86_64 we must disable preemption before we enable interrupts
>> for stack faults, int3 and debugging, because the current task is using
>> a per CPU debug stack defined by the IST. If we schedule out, another task
>> can come in and use the same stack and cause the stack to be corrupted
>> and crash the kernel on return.
>>
>> When CONFIG_PREEMPT_RT is enabled, spinlock_t locks become sleeping, and
>> one of these is the spin lock used in signal handling.
>>
>> Some of the debug code (int3) causes do_trap() to send a signal.
>> This function calls a spinlock_t lock that has been converted to a
>> sleeping lock. If this happens, the above issues with the corrupted
>> stack is possible.
>>
>> Instead of calling the signal right away, for PREEMPT_RT and x86,
>> the signal information is stored on the stacks task_struct and
>> TIF_NOTIFY_RESUME is set. Then on exit of the trap, the signal resume
>> code will send the signal when preemption is enabled.
>
> Folks I really would have appreciated being copied on a signal handling
> patch like this.
>
> It is too late to nack, but I think this buggy patch deserved one.  Can
> we please fix PREEMPT_RT instead?
>
> As far as I can tell this violates all of rules from
> implementing/maintaining the RT kernel.  Instead of coming up with new
> abstractions that makes sense and can use by everyone this introduces
> a hack only for PREEMPT_RT and a pretty horrible one at that.
>
> This talks about int3, but the code looks for in_atomic().  Which means
> that essentially every call of force_sig will take this path as they
> almost all come from exception handlers.  It is the nature of signals
> that report on faults.  An exception is raised and the kernel reports it
> to userspace with a fault signal (aka force_sig_xxx).
>
> Further this code is buggy.  TIF_NOTIFY_RESUME is not the correct
> flag to set to enter into exit_to_usermode_loop.  TIF_NOTIFY_RESUME is
> about that happens after signal handling.  This very much needs to be
> TIF_SIGPENDING with recalc_sigpending and friends updated to know about
> "task->force_info".
>
> Does someone own this problem?  Can that person please fix this
> properly?
>
> I really don't think it is going to be maintainable for PREEMPT_RT to
> maintain a separate signal delivery path for faults from the rest of
> linux.

I want to say the patch below looks like it was a perfectly fine debug
patch to see if what someone thinks is the issue is the issue.  It is
not a good final solution for the reasons I have already mentioned.

May I ask where the rest of the conversation was?  I can only find the
single posting of this patch on linux-kernel without any conversation,
and the description indicates this change has seen several rounds of
development.

Eric

>> [ rostedt: Switched from #ifdef CONFIG_PREEMPT_RT to
>>   ARCH_RT_DELAYS_SIGNAL_SEND and added comments to the code. ]
>> [bigeasy: Add on 32bit as per Yang Shi, minor rewording. ]
>>
>> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>>  arch/x86/include/asm/signal.h | 13 +++++++++++++
>>  include/linux/sched.h         |  3 +++
>>  kernel/entry/common.c         |  9 +++++++++
>>  kernel/signal.c               | 28 ++++++++++++++++++++++++++++
>>  4 files changed, 53 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
>> index 2dfb5fea13aff..fc03f4f7ed84c 100644
>> --- a/arch/x86/include/asm/signal.h
>> +++ b/arch/x86/include/asm/signal.h
>> @@ -28,6 +28,19 @@ typedef struct {
>>  #define SA_IA32_ABI	0x02000000u
>>  #define SA_X32_ABI	0x01000000u
>>  
>> +/*
>> + * Because some traps use the IST stack, we must keep preemption
>> + * disabled while calling do_trap(), but do_trap() may call
>> + * force_sig_info() which will grab the signal spin_locks for the
>> + * task, which in PREEMPT_RT are mutexes.  By defining
>> + * ARCH_RT_DELAYS_SIGNAL_SEND the force_sig_info() will set
>> + * TIF_NOTIFY_RESUME and set up the signal to be sent on exit of the
>> + * trap.
>> + */
>> +#if defined(CONFIG_PREEMPT_RT)
>> +#define ARCH_RT_DELAYS_SIGNAL_SEND
>> +#endif
>> +
>>  #ifndef CONFIG_COMPAT
>>  #define compat_sigset_t compat_sigset_t
>>  typedef sigset_t compat_sigset_t;
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 75ba8aa60248b..0514237cee3fc 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1087,6 +1087,9 @@ struct task_struct {
>>  	/* Restored if set_restore_sigmask() was used: */
>>  	sigset_t			saved_sigmask;
>>  	struct sigpending		pending;
>> +#ifdef CONFIG_PREEMPT_RT
>> +	struct				kernel_siginfo forced_info;
>> +#endif
>>  	unsigned long			sas_ss_sp;
>>  	size_t				sas_ss_size;
>>  	unsigned int			sas_ss_flags;
>> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
>> index bad713684c2e3..216dbf46e05f5 100644
>> --- a/kernel/entry/common.c
>> +++ b/kernel/entry/common.c
>> @@ -162,6 +162,15 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>>  		if (ti_work & _TIF_NEED_RESCHED)
>>  			schedule();
>>  
>> +#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
>> +		if (unlikely(current->forced_info.si_signo)) {
>> +			struct task_struct *t = current;
>> +
>> +			force_sig_info(&t->forced_info);
>> +			t->forced_info.si_signo = 0;
>> +		}
>> +#endif
>> +
>>  		if (ti_work & _TIF_UPROBE)
>>  			uprobe_notify_resume(regs);
>>  
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 9b04631acde8f..cb2b28c17c0a5 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -1327,6 +1327,34 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
>>  	struct k_sigaction *action;
>>  	int sig = info->si_signo;
>>  
>> +	/*
>> +	 * On some archs, PREEMPT_RT has to delay sending a signal from a trap
>> +	 * since it can not enable preemption, and the signal code's spin_locks
>> +	 * turn into mutexes. Instead, it must set TIF_NOTIFY_RESUME which will
>> +	 * send the signal on exit of the trap.
>> +	 */
>> +#ifdef ARCH_RT_DELAYS_SIGNAL_SEND
>> +	if (in_atomic()) {
>> +		struct task_struct *t = current;
>> +
>> +		if (WARN_ON_ONCE(t->forced_info.si_signo))
>> +			return 0;
>> +
>> +		if (is_si_special(info)) {
>> +			WARN_ON_ONCE(info != SEND_SIG_PRIV);
>> +			t->forced_info.si_signo = info->si_signo;
>> +			t->forced_info.si_errno = 0;
>> +			t->forced_info.si_code = SI_KERNEL;
>> +			t->forced_info.si_pid = 0;
>> +			t->forced_info.si_uid = 0;
>> +		} else {
>> +			t->forced_info = *info;
>> +		}
>> +
>> +		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
>> +		return 0;
>> +	}
>> +#endif
>>  	spin_lock_irqsave(&t->sighand->siglock, flags);
>>  	action = &t->sighand->action[sig-1];
>>  	ignored = action->sa.sa_handler == SIG_IGN;
