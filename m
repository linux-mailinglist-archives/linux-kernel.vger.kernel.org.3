Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A2510CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356164AbiDZXhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiDZXhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:37:31 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D5069CC8;
        Tue, 26 Apr 2022 16:34:19 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:60524)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njUhF-00Fyzz-QA; Tue, 26 Apr 2022 17:34:17 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35778 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njUhE-004IXg-Hq; Tue, 26 Apr 2022 17:34:17 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <20220421150654.757693825@infradead.org>
Date:   Tue, 26 Apr 2022 18:34:09 -0500
In-Reply-To: <20220421150654.757693825@infradead.org> (Peter Zijlstra's
        message of "Thu, 21 Apr 2022 17:02:49 +0200")
Message-ID: <87fslzfmha.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njUhE-004IXg-Hq;;;mid=<87fslzfmha.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/1sUzsaQCZiIJrvnL7foDQ7cpTq/um60w=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        T_FILL_THIS_FORM_SHORT,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 566 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 13 (2.3%), b_tie_ro: 11 (1.9%), parse: 1.43
        (0.3%), extract_message_metadata: 15 (2.6%), get_uri_detail_list: 2.2
        (0.4%), tests_pri_-1000: 11 (1.9%), tests_pri_-950: 1.33 (0.2%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 197 (34.8%), check_bayes:
        190 (33.6%), b_tokenize: 9 (1.5%), b_tok_get_all: 8 (1.5%),
        b_comp_prob: 2.8 (0.5%), b_tok_touch_all: 166 (29.3%), b_finish: 1.19
        (0.2%), tests_pri_0: 312 (55.2%), check_dkim_signature: 0.62 (0.1%),
        check_dkim_adsp: 3.6 (0.6%), poll_dns_idle: 0.43 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/5] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> Currently ptrace_stop() / do_signal_stop() rely on the special states
> TASK_TRACED and TASK_STOPPED resp. to keep unique state. That is, this
> state exists only in task->__state and nowhere else.
>
> There's two spots of bother with this:
>
>  - PREEMPT_RT has task->saved_state which complicates matters,
>    meaning task_is_{traced,stopped}() needs to check an additional
>    variable.
>
>  - An alternative freezer implementation that itself relies on a
>    special TASK state would loose TASK_TRACED/TASK_STOPPED and will
>    result in misbehaviour.
>
> As such, add additional state to task->jobctl to track this state
> outside of task->__state.
>
> NOTE: this doesn't actually fix anything yet, just adds extra state.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -770,7 +773,9 @@ void signal_wake_up_state(struct task_st
>  	 * By using wake_up_state, we ensure the process will wake up and
>  	 * handle its death signal.
>  	 */
> -	if (!wake_up_state(t, state | TASK_INTERRUPTIBLE))
> +	if (wake_up_state(t, state | TASK_INTERRUPTIBLE))
> +		t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
> +	else
>  		kick_process(t);
>  }

This hunk is subtle and I don't think it is actually what we want if the
code is going to be robust against tsk->__state becoming TASK_FROZEN.

I think we want the clearing of JOBCTL_STOPPED and JOBCTL_TRACED
to be independent of what tsk->__state and tsk->saved_state are.

Something like:

static inline void signal_wake_up(struct task_struct *t, bool resume)
{
	unsigned int state = 0;
	if (resume && !(t->jobctl & JOBCTL_DELAY_WAKEKILL)) {
		t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
		state = TASK_WAKEKILL;
	}
	signal_wake_up_state(t, state);
}

static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
{
	unsigned int state = 0;
	if (resume) {
		t->jobctl &= ~JOBCTL_TRACED;
		state = __TASK_TRACED;
	}
	signal_wake_up_state(t, state);
}

That would allow __set_task_special in the final patch to look like:

/*
 * The special task states (TASK_STOPPED, TASK_TRACED) keep their canonical
 * state in p->jobctl. If either of them got a wakeup that was missed because
 * TASK_FROZEN, then their canonical state reflects that and the below will
 * refuse to restore the special state and instead issue the wakeup.
 */
static int __set_task_special(struct task_struct *p, void *arg)
{
        unsigned int state = 0;

	if (p->jobctl & JOBCTL_TRACED)
        	state = TASK_TRACED;

	else if (p->jobctl & JOBCTL_STOPPED)
		state = TASK_STOPPED;

	if (state)
		WRITE_ONCE(p->__state, state);

	return state;
}


With no need to figure out if a wake_up was dropped and reverse engineer
what the wakeup was.

Eric

