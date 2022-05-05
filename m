Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA3451C5A4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356143AbiEERFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiEERFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:05:20 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF48A5D674;
        Thu,  5 May 2022 10:00:00 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:48790)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmepa-00GFfm-PE; Thu, 05 May 2022 10:59:58 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37068 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmepZ-0034rQ-GI; Thu, 05 May 2022 10:59:58 -0600
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
References: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <20220504224058.476193-8-ebiederm@xmission.com>
        <20220505145721.GA13929@redhat.com>
Date:   Thu, 05 May 2022 11:59:49 -0500
In-Reply-To: <20220505145721.GA13929@redhat.com> (Oleg Nesterov's message of
        "Thu, 5 May 2022 16:57:22 +0200")
Message-ID: <87v8uj9apm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nmepZ-0034rQ-GI;;;mid=<87v8uj9apm.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18IlEhzpWaHAD1ZV6ZojjYGolgnLPbCqLQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 480 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 9 (2.0%), parse: 0.93 (0.2%),
         extract_message_metadata: 3.9 (0.8%), get_uri_detail_list: 2.0 (0.4%),
         tests_pri_-1000: 3.9 (0.8%), tests_pri_-950: 1.16 (0.2%),
        tests_pri_-900: 0.97 (0.2%), tests_pri_-90: 94 (19.6%), check_bayes:
        93 (19.3%), b_tokenize: 9 (1.9%), b_tok_get_all: 9 (2.0%),
        b_comp_prob: 2.4 (0.5%), b_tok_touch_all: 68 (14.1%), b_finish: 0.87
        (0.2%), tests_pri_0: 348 (72.4%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 3.0 (0.6%), poll_dns_idle: 1.24 (0.3%), tests_pri_10:
        1.98 (0.4%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 08/11] ptrace: Admit ptrace_stop can generate
 spuriuos SIGTRAPs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/04, Eric W. Biederman wrote:
>>
>> -static int ptrace_stop(int exit_code, int why, int clear_code,
>> -			unsigned long message, kernel_siginfo_t *info)
>> +static int ptrace_stop(int exit_code, int why, unsigned long message,
>> +		       kernel_siginfo_t *info)
>>  	__releases(&current->sighand->siglock)
>>  	__acquires(&current->sighand->siglock)
>>  {
>> @@ -2259,54 +2259,33 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>>  
>>  	spin_unlock_irq(&current->sighand->siglock);
>>  	read_lock(&tasklist_lock);
>> -	if (likely(current->ptrace)) {
>> -		/*
>> -		 * Notify parents of the stop.
>> -		 *
>> -		 * While ptraced, there are two parents - the ptracer and
>> -		 * the real_parent of the group_leader.  The ptracer should
>> -		 * know about every stop while the real parent is only
>> -		 * interested in the completion of group stop.  The states
>> -		 * for the two don't interact with each other.  Notify
>> -		 * separately unless they're gonna be duplicates.
>> -		 */
>> +	/*
>> +	 * Notify parents of the stop.
>> +	 *
>> +	 * While ptraced, there are two parents - the ptracer and
>> +	 * the real_parent of the group_leader.  The ptracer should
>> +	 * know about every stop while the real parent is only
>> +	 * interested in the completion of group stop.  The states
>> +	 * for the two don't interact with each other.  Notify
>> +	 * separately unless they're gonna be duplicates.
>> +	 */
>> +	if (current->ptrace)
>>  		do_notify_parent_cldstop(current, true, why);
>> -		if (gstop_done && ptrace_reparented(current))
>> -			do_notify_parent_cldstop(current, false, why);
>> +	if (gstop_done && (!current->ptrace || ptrace_reparented(current)))
>> +		do_notify_parent_cldstop(current, false, why);
>>  
>> -		/*
>> -		 * Don't want to allow preemption here, because
>> -		 * sys_ptrace() needs this task to be inactive.
>> -		 *
>> -		 * XXX: implement read_unlock_no_resched().
>> -		 */
>> -		preempt_disable();
>> -		read_unlock(&tasklist_lock);
>> -		cgroup_enter_frozen();
>> -		preempt_enable_no_resched();
>> -		freezable_schedule();
>> -		cgroup_leave_frozen(true);
>> -	} else {
>> -		/*
>> -		 * By the time we got the lock, our tracer went away.
>> -		 * Don't drop the lock yet, another tracer may come.
>> -		 *
>> -		 * If @gstop_done, the ptracer went away between group stop
>> -		 * completion and here.  During detach, it would have set
>> -		 * JOBCTL_STOP_PENDING on us and we'll re-enter
>> -		 * TASK_STOPPED in do_signal_stop() on return, so notifying
>> -		 * the real parent of the group stop completion is enough.
>> -		 */
>> -		if (gstop_done)
>> -			do_notify_parent_cldstop(current, false, why);
>> -
>> -		/* tasklist protects us from ptrace_freeze_traced() */
>> -		__set_current_state(TASK_RUNNING);
>> -		read_code = false;
>> -		if (clear_code)
>> -			exit_code = 0;
>> -		read_unlock(&tasklist_lock);
>> -	}
>> +	/*
>> +	 * Don't want to allow preemption here, because
>> +	 * sys_ptrace() needs this task to be inactive.
>> +	 *
>> +	 * XXX: implement read_unlock_no_resched().
>> +	 */
>> +	preempt_disable();
>> +	read_unlock(&tasklist_lock);
>> +	cgroup_enter_frozen();
>> +	preempt_enable_no_resched();
>> +	freezable_schedule();
>
> I must have missed something.
>
> So the tracee calls ptrace_notify() but debugger goes away before the
> ptrace_notify() takes siglock. After that the no longer traced task
> will sleep in TASK_TRACED ?
>
> Looks like ptrace_stop() needs to check current->ptrace before it does
> set_special_state(TASK_TRACED) with siglock held? Then we can rely on
> ptrace_unlink() which will wake the tracee up even if debugger exits.
>
> No?

Hmm.  If the debugger goes away when siglock is dropped and reaquired at
the top of ptrace_stop, that would appear to set the debugged process up
to sleep indefinitely.

I was thinking of the SIGKILL case which is handled.

Thank you for catching that.

Eric


