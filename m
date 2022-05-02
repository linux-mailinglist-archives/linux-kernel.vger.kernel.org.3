Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A6E517467
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbiEBQje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbiEBQjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:39:31 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A3055BE;
        Mon,  2 May 2022 09:36:01 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:60884)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nlZ1i-00DCkL-Hp; Mon, 02 May 2022 10:35:58 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36694 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nlZ1h-0037gA-G0; Mon, 02 May 2022 10:35:58 -0600
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
Date:   Mon, 02 May 2022 11:35:50 -0500
In-Reply-To: <20220502153934.GD17276@redhat.com> (Oleg Nesterov's message of
        "Mon, 2 May 2022 17:39:35 +0200")
Message-ID: <87levjrixl.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nlZ1h-0037gA-G0;;;mid=<87levjrixl.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/z6Qf/UXEKB8pTQyW3Pw5hOTrbz9KRVus=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 483 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (0.8%), b_tie_ro: 2.7 (0.6%), parse: 0.81
        (0.2%), extract_message_metadata: 3.3 (0.7%), get_uri_detail_list:
        1.78 (0.4%), tests_pri_-1000: 3.2 (0.7%), tests_pri_-950: 0.97 (0.2%),
        tests_pri_-900: 0.86 (0.2%), tests_pri_-90: 67 (13.8%), check_bayes:
        65 (13.5%), b_tokenize: 8 (1.6%), b_tok_get_all: 10 (2.1%),
        b_comp_prob: 2.7 (0.6%), b_tok_touch_all: 42 (8.6%), b_finish: 0.71
        (0.1%), tests_pri_0: 390 (80.7%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 4.2 (0.9%), poll_dns_idle: 2.8 (0.6%), tests_pri_10:
        1.81 (0.4%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 07/12] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/29, Eric W. Biederman wrote:
>>
>> Stop playing with tsk->__state to remove TASK_WAKEKILL while a ptrace
>> command is executing.
>
> Eric, I'll read this patch and the rest of this series tomorrow.
> Somehow I failed to force myself to read yet another version after
> weekend ;)

That is quite alright.

> plus I don't really understand this one...
>
>>  #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
>>  #define TASK_STOPPED			(TASK_WAKEKILL | __TASK_STOPPED)
>> -#define TASK_TRACED			(TASK_WAKEKILL | __TASK_TRACED)
>> +#define TASK_TRACED			__TASK_TRACED
> ...
>>  static inline void signal_wake_up(struct task_struct *t, bool resume)
>>  {
>> -	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
>> +	unsigned int state = 0;
>> +	if (resume) {
>> +		state = TASK_WAKEKILL;
>> +		if (!(t->jobctl & JOBCTL_PTRACE_FROZEN))
>> +			state |= __TASK_TRACED;
>> +	}
>> +	signal_wake_up_state(t, state);
>
> Can't understand why is this better than the previous version which removed
> TASK_WAKEKILL if resume... Looks a bit strange to me. But again, I didn't
> look at the next patches yet.

The goal is to replace the existing mechanism with an equivalent one,
so that we don't have to be clever and deal with it being slightly
different in one case.

The difference is how does signal_pending_state affect how schedule will
sleep in ptrace_stop.

As the patch is constructed currently (and how the existing code works)
is that signal_pending_state will always sleep if ptrace_freeze_traced
completes successfully.

When TASK_WAKEKILL was included in TASK_TRACED schedule might refuse
to sleep even though ptrace_freeze_traced completed successfully.  As
you pointed out wait_task_inactive would then fail, keeping
ptrace_check_attach from succeeded.

Other than complicating the analysis by adding extra states we need to
consider when reviewing the patch, the practical difference is for
Peter's plans to fix PREEMPT_RT or the freezer wait_task_inactive needs
to cope with the final being changed by something else. (TASK_FROZEN in
the freezer case).  I can only see that happening by removing the
dependency on the final state in wait_task_inactive.  Which we can't do
if we depend on wait_task_inactive failing if the process is in the
wrong state.


>> @@ -2209,11 +2209,8 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>>  		spin_lock_irq(&current->sighand->siglock);
>>  	}
>>
>> -	/*
>> -	 * schedule() will not sleep if there is a pending signal that
>> -	 * can awaken the task.
>> -	 */
>> -	set_special_state(TASK_TRACED);
>> +	if (!__fatal_signal_pending(current))
>> +		set_special_state(TASK_TRACED);
>
> This is where I stuck. This probably makes sense, but what does it buy
> for this particular patch?
>
> And if we check __fatal_signal_pending(), why can't ptrace_stop() simply
> return ?

Again this is about preserving existing behavior as much as possible to
simplify analsysis of the patch.

The current code depends upon schedule not sleeping if there was a fatal
signal received before ptrace_stop is called.  With TASK_WAKEKILL
removed from TASK_TRACED that no longer happens.  Just not setting
TASK_TRACED when !__fatal_signal_pending has the same effect.


At a practical level I think it also has an impact on patch:
"10/12 ptrace: Only return signr from ptrace_stop if it was provided".

At a minimum the code would need to do something like:
	if (__fatal_signal_pending(current)) {
		return clear_code ? 0 : exit_code;
        }

With a little bit of care put in to ensure everytime the logic changes
that early return changes too.  I think that just complicates things
unnecessarily.

Eric



