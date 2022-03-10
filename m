Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3206E4D51B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245733AbiCJTGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245720AbiCJTGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:06:05 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2864B155C31
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:05:03 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:36372)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nSO5t-00BOjE-Ig; Thu, 10 Mar 2022 12:05:01 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34906 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nSO5r-00An3g-R8; Thu, 10 Mar 2022 12:05:01 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
        <20220309162454.123006-8-ebiederm@xmission.com>
        <202203091455.D4ED8650@keescook>
Date:   Thu, 10 Mar 2022 13:04:52 -0600
In-Reply-To: <202203091455.D4ED8650@keescook> (Kees Cook's message of "Wed, 9
        Mar 2022 21:57:22 -0800")
Message-ID: <874k45633f.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nSO5r-00An3g-R8;;;mid=<874k45633f.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+SjRMkqeoTgoT9aKhC2twqfhDnLzIkuVE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1001 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.1%), b_tie_ro: 10 (1.0%), parse: 1.28
        (0.1%), extract_message_metadata: 19 (1.9%), get_uri_detail_list: 5
        (0.5%), tests_pri_-1000: 25 (2.5%), tests_pri_-950: 1.28 (0.1%),
        tests_pri_-900: 1.03 (0.1%), tests_pri_-90: 221 (22.1%), check_bayes:
        219 (21.9%), b_tokenize: 19 (1.9%), b_tok_get_all: 13 (1.3%),
        b_comp_prob: 4.1 (0.4%), b_tok_touch_all: 178 (17.8%), b_finish: 1.08
        (0.1%), tests_pri_0: 708 (70.7%), check_dkim_signature: 0.74 (0.1%),
        check_dkim_adsp: 2.6 (0.3%), poll_dns_idle: 0.76 (0.1%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 8 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 08/13] task_work: Call tracehook_notify_signal from
 get_signal on all architectures
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Mar 09, 2022 at 10:24:49AM -0600, Eric W. Biederman wrote:
>> Always handle TIF_NOTIFY_SIGNAL in get_signal.  With commit 35d0b389f3b2
>> ("task_work: unconditionally run task_work from get_signal()") always
>> calling task_wofffffffrk_run all of the work of tracehook_notify_signal is
>
> typo: cat on keyboard
>
>> already happening except clearing TIF_NOTIFY_SIGNAL.
>> 
>> Factor clear_notify_signal out of tracehook_notify_signal and use it in
>> get_signal so that get_signal only needs one call of trask_work_run.
>
> typo: trask -> task
>
>> 
>> To keep the semantics in sync update xfer_to_guest_mode_work (which
>> does not call get_signal) to call tracehook_notify_signal if either
>> _TIF_SIGPENDING or _TIF_NOTIFY_SIGNAL.

First let me say thanks for the close look at this work.

> I see three logical changes in this patch, I think?
>
> - creation and use of clear_notify_signal()
> - removal of handle_signal_work() and removal of
>   arch_do_signal_or_restart() has_signal arg
> - something with get_signal() I don't understand yet:
>   - why is clear_notify_signal() added?
>   - why is tracehook_notify_signal() removed?


The spoiler is the change to get_signal is the logical change.
The rest of the changes follow from that change.  Please see below.

The inline expansion of tracehook_notify_signal in get_signal and
in it's other two callers in the next change is the only real kernel
internal api change in this series of changes.

The optimization that was tried with TIF_NOTIFY_SIGNAL and being able to
only call task_work_run() when TIF_NOTIFY_SIGNAL was set instead of when
get_signal was called failed, and caused a regression.  The removal of
calling task_work_run from get_signal has been reverted but the rest
of the change had not been.  So this change just removes the rest of
the failed optimization.

Please see below for my detailed description of the get_signal change.

I hope this helps.

>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  arch/s390/kernel/signal.c    |  4 ++--
>>  arch/x86/kernel/signal.c     |  4 ++--
>>  include/linux/entry-common.h |  2 +-
>>  include/linux/tracehook.h    |  9 +++++++--
>>  kernel/entry/common.c        | 12 ++----------
>>  kernel/entry/kvm.c           |  2 +-
>>  kernel/signal.c              | 14 +++-----------
>>  7 files changed, 18 insertions(+), 29 deletions(-)
>> 
>> diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
>> index 307f5d99514d..ea9e5e8182cd 100644
>> --- a/arch/s390/kernel/signal.c
>> +++ b/arch/s390/kernel/signal.c
>> @@ -453,7 +453,7 @@ static void handle_signal(struct ksignal *ksig, sigset_t *oldset,
>>   * stack-frames in one go after that.
>>   */
>>  
>> -void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
>> +void arch_do_signal_or_restart(struct pt_regs *regs)
>>  {
>>  	struct ksignal ksig;
>>  	sigset_t *oldset = sigmask_to_save();
>> @@ -466,7 +466,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
>>  	current->thread.system_call =
>>  		test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->int_code : 0;
>>  
>> -	if (has_signal && get_signal(&ksig)) {
>
> Right, the only caller of arch_do_signal_or_restart(),
> handle_signal_work(), only happens after its caller has already checked
> _TIF_SIGPENDING.

It could be TIF_SIGPENDING or TIF_NOTIFY_SIGNAL.  The work for
TIF_NOTIFY_SIGNAL has been moved unconditionally into get_signal.
So it no longer makes sense to care which flag has been set.

>> +	if (get_signal(&ksig)) {
>>  		/* Whee!  Actually deliver the signal.  */
>>  		if (current->thread.system_call) {
>>  			regs->int_code = current->thread.system_call;
>> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
>> index ec71e06ae364..de3d5b5724d8 100644
>> --- a/arch/x86/kernel/signal.c
>> +++ b/arch/x86/kernel/signal.c
>> @@ -861,11 +861,11 @@ static inline unsigned long get_nr_restart_syscall(const struct pt_regs *regs)
>>   * want to handle. Thus you cannot kill init even with a SIGKILL even by
>>   * mistake.
>>   */
>> -void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
>> +void arch_do_signal_or_restart(struct pt_regs *regs)
>>  {
>>  	struct ksignal ksig;
>>  
>> -	if (has_signal && get_signal(&ksig)) {
>> +	if (get_signal(&ksig)) {
>>  		/* Whee! Actually deliver the signal.  */
>>  		handle_signal(&ksig, regs);
>>  		return;
>> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
>> index 9efbdda61f7a..3537fd25f14e 100644
>> --- a/include/linux/entry-common.h
>> +++ b/include/linux/entry-common.h
>> @@ -257,7 +257,7 @@ static __always_inline void arch_exit_to_user_mode(void) { }
>>   *
>>   * Invoked from exit_to_user_mode_loop().
>>   */
>> -void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal);
>> +void arch_do_signal_or_restart(struct pt_regs *regs);
>>  
>>  /**
>>   * exit_to_user_mode - Fixup state when exiting to user mode
>> diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
>> index fa834a22e86e..b44a7820c468 100644
>> --- a/include/linux/tracehook.h
>> +++ b/include/linux/tracehook.h
>> @@ -106,6 +106,12 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
>>  	rseq_handle_notify_resume(NULL, regs);
>>  }
>>  
>> +static inline void clear_notify_signal(void)
>> +{
>> +	clear_thread_flag(TIF_NOTIFY_SIGNAL);
>> +	smp_mb__after_atomic();
>> +}
>> +
>>  /*
>>   * called by exit_to_user_mode_loop() if ti_work & _TIF_NOTIFY_SIGNAL. This
>>   * is currently used by TWA_SIGNAL based task_work, which requires breaking
>> @@ -113,8 +119,7 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
>>   */
>>  static inline void tracehook_notify_signal(void)
>>  {
>> -	clear_thread_flag(TIF_NOTIFY_SIGNAL);
>> -	smp_mb__after_atomic();
>> +	clear_notify_signal();
>>  	if (task_work_pending(current))
>>  		task_work_run();
>>  }
>> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
>> index f0b1daa1e8da..79eaf9b4b10d 100644
>> --- a/kernel/entry/common.c
>> +++ b/kernel/entry/common.c
>> @@ -139,15 +139,7 @@ void noinstr exit_to_user_mode(void)
>>  }
>>  
>>  /* Workaround to allow gradual conversion of architecture code */
>> -void __weak arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal) { }
>> -
>> -static void handle_signal_work(struct pt_regs *regs, unsigned long ti_work)
>> -{
>> -	if (ti_work & _TIF_NOTIFY_SIGNAL)
>> -		tracehook_notify_signal();
>> -
>> -	arch_do_signal_or_restart(regs, ti_work & _TIF_SIGPENDING);
>> -}

With the work of tracehook_notify_signal happening in get_signal (called
from arch_do_signal_or_restart) there is no longer a reason to call
tracehook_notify_signal on it's own, or to remember if it was
TIF_NOTIFY_SIGNAL or TIF_SIGPENDING which was set.

>> +void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
>>  
>>  static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>>  					    unsigned long ti_work)
>> @@ -170,7 +162,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>>  			klp_update_patch_state(current);
>>  
>>  		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
>> -			handle_signal_work(regs, ti_work);
>> +			arch_do_signal_or_restart(regs);
>>  
>>  		if (ti_work & _TIF_NOTIFY_RESUME)
>>  			tracehook_notify_resume(regs);
>> diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
>> index 96d476e06c77..cabf36a489e4 100644
>> --- a/kernel/entry/kvm.c
>> +++ b/kernel/entry/kvm.c
>> @@ -8,7 +8,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
>>  	do {
>>  		int ret;
>>  
>> -		if (ti_work & _TIF_NOTIFY_SIGNAL)
>> +		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
>>  			tracehook_notify_signal();
>>  
>>  		if (ti_work & _TIF_SIGPENDING) {
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 3b4cf25fb9b3..8632b88982c9 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2626,20 +2626,12 @@ bool get_signal(struct ksignal *ksig)
>>  	struct signal_struct *signal = current->signal;
>>  	int signr;
>>  
>> +	clear_notify_signal();
>
> Why is this added?

See below.
>
>>  	if (unlikely(task_work_pending(current)))
>>  		task_work_run();
>>  
>> -	/*
>> -	 * For non-generic architectures, check for TIF_NOTIFY_SIGNAL so
>> -	 * that the arch handlers don't all have to do it. If we get here
>> -	 * without TIF_SIGPENDING, just exit after running signal work.
>> -	 */
>> -	if (!IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
>> -		if (test_thread_flag(TIF_NOTIFY_SIGNAL))
>> -			tracehook_notify_signal();
>
> I don't see why this gets removed?

This is the core change of this change, the rest
follows from this change.

The definition of tracehook_notify_signal is:

  static inline void tracehook_notify_signal(void)
  {
  	clear_notify_signal();
  	if (task_work_pending(current))
  		task_work_run();
  }


Which means the only difference between:
	if (unlikely(task_work_pending(current)))
		task_work_run()

and tracehook_notify_signal is the work done by clear_notify_signal.
So I added the missing work and remove the fancy conditional.

There are only two architectures that define CONFIG_GENERIC_ENTRY
x86 and s390.  At some point the task_work_run was moved completely
out of get_signal (on x86 and s390) and it was assumed it was enough
to call tracehook_notify_signal when TIF_NOTIFY_SIGNAL was set.

That turned out to be false and kernel regressions were encountered.  So
the call to task_work_run was added back to get_signal.


Which is where this change comes in.  There is an unconditional call to
task_work_run() in get_signal, and a funny conditional call to
task_work_run().

So this change is just changing the kernel to unconditionally call
task_work_run() in get_signal(), as well as clearing TIF_NOTIFY_SIGNAL.

The result is that on the common path tracehook_notify_signal no longer
needs to be called.

My next change removes tracehook_notify_signal entirely.  Which is
the other reason I add clear_notify_signal.

>
>> -		if (!task_sigpending(current))
>> -			return false;
>> -	}
>> +	if (!task_sigpending(current))
>> +		return false;
>>  
>>  	if (unlikely(uprobe_deny_signal()))
>>  		return false;
>> -- 
>> 2.29.2
>> 

Eric
