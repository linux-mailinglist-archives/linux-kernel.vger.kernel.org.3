Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A287355F181
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiF1Wmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiF1Wmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:42:53 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA8F3A712;
        Tue, 28 Jun 2022 15:42:52 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:36676)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o6Juy-0058HI-1R; Tue, 28 Jun 2022 16:42:48 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57884 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o6Juw-000UzI-RZ; Tue, 28 Jun 2022 16:42:47 -0600
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
        <87y1xk8zx5.fsf@email.froward.int.ebiederm.org>
        <YrtKReO2vIiX8VVU@tuxmaker.boeblingen.de.ibm.com>
Date:   Tue, 28 Jun 2022 17:42:22 -0500
In-Reply-To: <YrtKReO2vIiX8VVU@tuxmaker.boeblingen.de.ibm.com> (Alexander
        Gordeev's message of "Tue, 28 Jun 2022 20:36:53 +0200")
Message-ID: <87czess94h.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o6Juw-000UzI-RZ;;;mid=<87czess94h.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+S1iu9v81AzGxBg+K7lPcv87U80HJrcrw=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Alexander Gordeev <agordeev@linux.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 512 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (0.7%), b_tie_ro: 2.6 (0.5%), parse: 1.29
        (0.3%), extract_message_metadata: 5 (1.1%), get_uri_detail_list: 3.1
        (0.6%), tests_pri_-1000: 5 (1.1%), tests_pri_-950: 1.57 (0.3%),
        tests_pri_-900: 1.26 (0.2%), tests_pri_-90: 91 (17.8%), check_bayes:
        90 (17.5%), b_tokenize: 17 (3.3%), b_tok_get_all: 12 (2.3%),
        b_comp_prob: 3.5 (0.7%), b_tok_touch_all: 54 (10.6%), b_finish: 0.63
        (0.1%), tests_pri_0: 384 (75.1%), check_dkim_signature: 0.45 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 1.06 (0.2%), tests_pri_10:
        1.78 (0.3%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Gordeev <agordeev@linux.ibm.com> writes:

> On Sat, Jun 25, 2022 at 11:34:46AM -0500, Eric W. Biederman wrote:
>> I haven't gotten as far as reproducing this but I have started giving
>> this issue some thought.
>> 
>> This entire thing smells like a memory barrier is missing somewhere.
>> However by definition the lock implementations in linux provide all the
>> needed memory barriers, and in the ptrace_stop and ptrace_check_attach
>> path I don't see cases where these values are sampled outside of a lock
>> except in wait_task_inactive.  Does doing that perhaps require a
>> barrier? 
>> 
>> The two things I can think of that could shed light on what is going on
>> is enabling lockdep, to enable the debug check in signal_wake_up_state
>> and verifying bits of state that should be constant while the task
>> is frozen for ptrace are indeed constant when task is frozen for ptrace.
>> Something like my patch below.
>> 
>> If you could test that when you have a chance that would help narrow
>> down what is going on.
>> 
>> Thank you,
>> Eric
>> 
>> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
>> index 156a99283b11..6467a2b1c3bc 100644
>> --- a/kernel/ptrace.c
>> +++ b/kernel/ptrace.c
>> @@ -268,9 +268,13 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>>  	}
>>  	read_unlock(&tasklist_lock);
>>  
>> -	if (!ret && !ignore_state &&
>> -	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
>> +	if (!ret && !ignore_state) {
>> +		WARN_ON_ONCE(!(child->jobctl & JOBCTL_PTRACE_FROZEN));
>> +		WARN_ON_ONCE(!(child->joctctl & JOBCTL_TRACED));
>> +		WARN_ON_ONCE(READ_ONCE(child->__state) != __TASK_TRACED);
>> +		WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED));
>>  		ret = -ESRCH;
>> +	}
>>  
>>  	return ret;
>>  }
>
> I modified your chunk a bit - hope that is what you had in mind:

Yes.

> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 156a99283b11..f0e9a9a4d63c 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -268,9 +268,19 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  	}
>  	read_unlock(&tasklist_lock);
>  
> -	if (!ret && !ignore_state &&
> -	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
> -		ret = -ESRCH;
> +	if (!ret && !ignore_state) {
> +		unsigned int __state;
> +
> +		WARN_ON_ONCE(!(child->jobctl & JOBCTL_PTRACE_FROZEN));
> +		WARN_ON_ONCE(!(child->jobctl & JOBCTL_TRACED));
> +		__state = READ_ONCE(child->__state);
> +		if (__state != __TASK_TRACED) {
> +			pr_err("%s(%d) __state %x", __FUNCTION__, __LINE__, __state);
> +			WARN_ON_ONCE(1);
> +		}
> +		if (WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
> +			ret = -ESRCH;
> +	}
>  
>  	return ret;
>  }
>
>
> When WARN_ON_ONCE(1) hits the child __state is always zero/TASK_RUNNING,
> as reported by the preceding pr_err(). Yet, in the resulting core dump
> it is always __TASK_TRACED.

Did you enable CONFIG_LOCKDEP?  I am just wanting to ensure
that every caller of signal_wake_up_state was holding siglock.

> Removing WARN_ON_ONCE(1) while looping until (__state != __TASK_TRACED)
> confirms the unexpected __state is always TASK_RUNNING. It never observed
> more than one iteration and gets printed once in 30-60 mins.

Hmm.  This does smell lock a missing barrier.

> So probably when the condition is entered __state is TASK_RUNNING more
> often, but gets overwritten with __TASK_TRACED pretty quickly. Which kind
> of consistent with my previous observation that kernel/sched/core.c:3305
> is where return 0 makes wait_task_inactive() fail.
>
> No other WARN_ON_ONCE() hit ever.

Yes.  This smells like something is missing.

I am completely rusty at rolling barriers by hand but does something
like the below clear up those mysterious warnings?

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 156a99283b11..cb85bcf84640 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -202,6 +202,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
+		smp_rmb();
 		task->jobctl |= JOBCTL_PTRACE_FROZEN;
 		ret = true;
 	}
diff --git a/kernel/signal.c b/kernel/signal.c
index edb1dc9b00dc..bcd576e9de66 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2233,6 +2233,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 		return exit_code;
 
 	set_special_state(TASK_TRACED);
+	smp_wmb();
 	current->jobctl |= JOBCTL_TRACED;
 
 	/*

Eric
