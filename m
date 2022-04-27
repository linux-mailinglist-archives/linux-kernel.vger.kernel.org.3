Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F2512552
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiD0Wig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiD0Wia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:38:30 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4479DA7;
        Wed, 27 Apr 2022 15:35:16 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:39804)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njqFe-004CCe-1P; Wed, 27 Apr 2022 16:35:14 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35990 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njqFc-00Bd4H-Ux; Wed, 27 Apr 2022 16:35:13 -0600
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
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <20220426225211.308418-9-ebiederm@xmission.com>
        <20220427154158.GG17421@redhat.com>
Date:   Wed, 27 Apr 2022 17:35:05 -0500
In-Reply-To: <20220427154158.GG17421@redhat.com> (Oleg Nesterov's message of
        "Wed, 27 Apr 2022 17:41:59 +0200")
Message-ID: <87mtg62m06.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njqFc-00Bd4H-Ux;;;mid=<87mtg62m06.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18S5RmCcBMZtZ5La6DbmgpHNqUhFhXjeT0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 470 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 12 (2.6%), b_tie_ro: 10 (2.2%), parse: 1.31
        (0.3%), extract_message_metadata: 4.2 (0.9%), get_uri_detail_list:
        1.65 (0.4%), tests_pri_-1000: 5 (1.1%), tests_pri_-950: 2.1 (0.4%),
        tests_pri_-900: 1.74 (0.4%), tests_pri_-90: 79 (16.8%), check_bayes:
        77 (16.3%), b_tokenize: 17 (3.5%), b_tok_get_all: 10 (2.0%),
        b_comp_prob: 4.2 (0.9%), b_tok_touch_all: 42 (8.8%), b_finish: 1.13
        (0.2%), tests_pri_0: 342 (72.8%), check_dkim_signature: 0.71 (0.2%),
        check_dkim_adsp: 3.0 (0.6%), poll_dns_idle: 0.94 (0.2%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 11 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

2> On 04/26, Eric W. Biederman wrote:
>>
>>  static void ptrace_unfreeze_traced(struct task_struct *task)
>>  {
>> -	if (READ_ONCE(task->__state) != __TASK_TRACED)
>> +	if (!(READ_ONCE(task->jobctl) & JOBCTL_DELAY_WAKEKILL))
>>  		return;
>>
>>  	WARN_ON(!task->ptrace || task->parent != current);
>> @@ -213,11 +213,10 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>>  	 * Recheck state under the lock to close this race.
>>  	 */
>>  	spin_lock_irq(&task->sighand->siglock);
>
> Now that we do not check __state = __TASK_TRACED, we need lock_task_sighand().
> The tracee can be already woken up by ptrace_resume(), but it is possible that
> it didn't clear DELAY_WAKEKILL yet.

Yes.  The subtle differences in when __TASK_TRACED and
JOBCTL_DELAY_WAKEKILL are cleared are causing me some minor issues.

This "WARN_ON(!task->ptrace || task->parent != current);" also now
needs to be inside siglock, because the __TASK_TRACED is insufficient.


> Now, before we take ->siglock, the tracee can exit and another thread can do
> wait() and reap this task.
>
> Also, I think the comment above should be updated. I agree, it makes sense to
> re-check JOBCTL_DELAY_WAKEKILL under siglock just for clarity, but we no longer
> need to do this to close the race; jobctl &= ~JOBCTL_DELAY_WAKEKILL and
> wake_up_state() are safe even if JOBCTL_DELAY_WAKEKILL was already
> cleared.

I think you are right about it being safe, but I am having a hard time
convincing myself that is true.  I want to be very careful sending
__TASK_TRACED wake_ups as ptrace_stop fundamentally can't handle
spurious wake_ups.

So I think adding task_is_traced to the test to verify the task
is still frozen.

static void ptrace_unfreeze_traced(struct task_struct *task)
{
	unsigned long flags;

	/*
	 * Verify the task is still frozen before unfreezing it,
	 * ptrace_resume could have unfrozen us.
	 */
	if (lock_task_sighand(task, &flags)) {
		if ((task->jobctl & JOBCTL_DELAY_WAKEKILL) &&
		    task_is_traced(task)) {
			task->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
			if (__fatal_signal_pending(task))
				wake_up_state(task, __TASK_TRACED);
		}
		unlock_task_sighand(task, &flags);
	}
}

>> @@ -2307,6 +2307,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>>
>>  	/* LISTENING can be set only during STOP traps, clear it */
>>  	current->jobctl &= ~JOBCTL_LISTENING;
>> +	current->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
>
> minor, but
>
> 	current->jobctl &= ~(JOBCTL_LISTENING | JOBCTL_DELAY_WAKEKILL);
>
> looks better.

Yes.


Eric
