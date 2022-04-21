Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A8450A30D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389339AbiDUOtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389238AbiDUOtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:49:07 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B226218B36;
        Thu, 21 Apr 2022 07:46:17 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:42960)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhY4V-00FHvT-FV; Thu, 21 Apr 2022 08:46:15 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35186 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhY4U-00C6Nm-DU; Thu, 21 Apr 2022 08:46:15 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
References: <20220414115410.GA32752@redhat.com>
        <20220414183433.GC32752@redhat.com>
        <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
        <20220415101644.GA10421@redhat.com>
        <20220415105755.GA15217@redhat.com>
        <Yllep6B8eva2VURJ@hirez.programming.kicks-ass.net>
        <20220418170104.GA16199@redhat.com>
        <20220420131731.GF2731@worktop.programming.kicks-ass.net>
        <20220420180323.GA14947@redhat.com>
        <875yn3zdag.fsf_-_@email.froward.int.ebiederm.org>
        <20220421072138.GI2731@worktop.programming.kicks-ass.net>
Date:   Thu, 21 Apr 2022 09:45:54 -0500
In-Reply-To: <20220421072138.GI2731@worktop.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Thu, 21 Apr 2022 09:21:38 +0200")
Message-ID: <87k0bixzod.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nhY4U-00C6Nm-DU;;;mid=<87k0bixzod.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/z+LKMx7ZRZNtGzHHMAiSTq140t24TiUQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 455 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.9%), b_tie_ro: 2.7 (0.6%), parse: 0.72
        (0.2%), extract_message_metadata: 8 (1.8%), get_uri_detail_list: 1.23
        (0.3%), tests_pri_-1000: 9 (1.9%), tests_pri_-950: 1.07 (0.2%),
        tests_pri_-900: 0.88 (0.2%), tests_pri_-90: 146 (32.1%), check_bayes:
        142 (31.2%), b_tokenize: 6 (1.3%), b_tok_get_all: 7 (1.6%),
        b_comp_prob: 1.71 (0.4%), b_tok_touch_all: 122 (26.8%), b_finish: 0.76
        (0.2%), tests_pri_0: 275 (60.4%), check_dkim_signature: 0.41 (0.1%),
        check_dkim_adsp: 2.9 (0.6%), poll_dns_idle: 0.17 (0.0%), tests_pri_10:
        1.68 (0.4%), tests_pri_500: 6 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Apr 20, 2022 at 03:54:15PM -0500, Eric W. Biederman wrote:
>> 
>> I was thinking about this and I have an approach from a different
>> direction.  In particular it removes the need for ptrace_freeze_attach
>> and ptrace_unfreeze_attach to change __state.  Instead a jobctl
>> bit is used to suppress waking up a process with TASK_WAKEKILL.
>> 
>> I think this would be a good technique to completely decouple
>> PREEMPT_RT from the work that ptrace_freeze_attach does.
>> 
>> Comments?
>
> On first read-through, I like it! A few comments down below..
>
>> @@ -216,13 +217,11 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>>  	 * PTRACE_LISTEN can allow ptrace_trap_notify to wake us up remotely.
>>  	 * Recheck state under the lock to close this race.
>>  	 */
>> -	spin_lock_irq(&task->sighand->siglock);
>> -	if (READ_ONCE(task->__state) == __TASK_TRACED) {
>> -		if (__fatal_signal_pending(task))
>> -			wake_up_state(task, __TASK_TRACED);
>> -		else
>> -			WRITE_ONCE(task->__state, TASK_TRACED);
>> -	}
>> +	spin_unlock_irq(&task->sighand->siglock);
>
>   ^^^^ this should be spin_lock_irq(...)

Doh!

Thank you for spotting that.  That solves my nasty splat in
__send_signal.


>
>> +	WARN_ON(!(task->jobctl & JOBCTL_DELAY_WAKEKILL));
>> +	task->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
>> +	if (fatal_signal_pending(task))
>> +		wake_up_state(task, TASK_WAKEKILL);
>>  	spin_unlock_irq(&task->sighand->siglock);
>>  }
>>  
>> @@ -256,7 +255,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>>  	 */
>>  	read_lock(&tasklist_lock);
>>  	if (child->ptrace && child->parent == current) {
>> -		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
>> +		WARN_ON(child->jobctl & JOBCTL_DELAY_WAKEKILL);
>>  		/*
>>  		 * child->sighand can't be NULL, release_task()
>>  		 * does ptrace_unlink() before __exit_signal().
>> @@ -267,13 +266,13 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>>  	read_unlock(&tasklist_lock);
>>  
>>  	if (!ret && !ignore_state) {
>> -		if (!wait_task_inactive(child, __TASK_TRACED)) {
>> +		if (!wait_task_inactive(child, TASK_TRACED)) {
>
> This is still very dubious, there are spinlocks between
> set_current_state(TASK_TRACED) and schedule(), so wait_task_inactive()
> can fail where we don't want it to due to TASK_TRACED being temporarily
> held in ->saved_state.

When it comes to PREEMPT_RT yes.

I think we might be able to remove the wait_task_inactive, I am
not certain what it gets us.

All this change gets us is the removal of playing with __state.

Eric
