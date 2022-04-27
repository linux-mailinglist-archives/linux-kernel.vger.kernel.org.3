Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92530510D20
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 02:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356392AbiD0A11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243117AbiD0A1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:27:23 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B10E3CC4;
        Tue, 26 Apr 2022 17:24:14 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:40810)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njVTX-00D8XQ-QC; Tue, 26 Apr 2022 18:24:11 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35786 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njVTW-006ZIp-P2; Tue, 26 Apr 2022 18:24:11 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <20220425174719.GB12412@redhat.com>
Date:   Tue, 26 Apr 2022 19:24:03 -0500
In-Reply-To: <20220425174719.GB12412@redhat.com> (Oleg Nesterov's message of
        "Mon, 25 Apr 2022 19:47:20 +0200")
Message-ID: <8735hzcr18.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njVTW-006ZIp-P2;;;mid=<8735hzcr18.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+K+Sik1kCOuihclgFx72Bbye8aJrSXdAA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 401 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 5 (1.3%), b_tie_ro: 3.5 (0.9%), parse: 1.19
        (0.3%), extract_message_metadata: 4.9 (1.2%), get_uri_detail_list: 2.6
        (0.7%), tests_pri_-1000: 3.1 (0.8%), tests_pri_-950: 1.15 (0.3%),
        tests_pri_-900: 0.92 (0.2%), tests_pri_-90: 53 (13.3%), check_bayes:
        52 (12.9%), b_tokenize: 7 (1.6%), b_tok_get_all: 8 (2.1%),
        b_comp_prob: 2.1 (0.5%), b_tok_touch_all: 32 (7.9%), b_finish: 0.75
        (0.2%), tests_pri_0: 312 (78.0%), check_dkim_signature: 0.41 (0.1%),
        check_dkim_adsp: 2.8 (0.7%), poll_dns_idle: 1.42 (0.4%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 9 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/21, Peter Zijlstra wrote:
>>
>> @@ -2225,7 +2238,7 @@ static int ptrace_stop(int exit_code, in
>>  	 * schedule() will not sleep if there is a pending signal that
>>  	 * can awaken the task.
>>  	 */
>> -	current->jobctl |= JOBCTL_TRACED;
>> +	current->jobctl |= JOBCTL_TRACED | JOBCTL_TRACED_QUIESCE;
>>  	set_special_state(TASK_TRACED);
>
> OK, this looks wrong. I actually mean the previous patch which sets
> JOBCTL_TRACED.
>
> The problem is that the tracee can be already killed, so that
> fatal_signal_pending(current) is true. In this case we can't rely on
> signal_wake_up_state() which should clear JOBCTL_TRACED, or the
> callers of ptrace_signal_wake_up/etc which clear this flag by hand.
>
> In this case schedule() won't block and ptrace_stop() will leak
> JOBCTL_TRACED. Unless I missed something.
>
> We could check fatal_signal_pending() and damn! this is what I think
> ptrace_stop() should have done from the very beginning. But for now
> I'd suggest to simply clear this flag before return, along with
> DELAY_WAKEKILL and LISTENING.

Oh.  That is an interesting case for JOBCTL_TRACED.  The
scheduler refuses to stop if signal_pending_state(TASK_TRACED, p)
returns true.

The ptrace_stop code used to handle this explicitly and in commit
7d613f9f72ec ("signal: Remove the bogus sigkill_pending in ptrace_stop")
I actually removed the test.  As the test was somewhat wrong and
redundant, and in slightly the wrong location.

But doing:

	/* Don't stop if the task is dying */
	if (unlikely(__fatal_signal_pending(current)))
		return exit_code;

Should work.

>
>>  	current->jobctl &= ~JOBCTL_LISTENING;
>> +	current->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
>
> 	current->jobctl &=
> 		~(~JOBCTL_TRACED | JOBCTL_DELAY_WAKEKILL | JOBCTL_LISTENING);


I presume you meant:

	current->jobctl &=
 		~(JOBCTL_TRACED | JOBCTL_DELAY_WAKEKILL | JOBCTL_LISTENING);

I don't think we want to do that.  For the case you are worried about it
is a valid fix.

In general this is the wrong approach as we want the waker to clear
JOBCTL_TRACED.  If the waker does not it is possible that
ptrace_freeze_traced might attempt to freeze a process whose state
is not appropriate for attach, because the code is past the call
to schedule().

In fact I think clearing JOBCTL_TRACED at the end of ptrace_stop
will allow ptrace_freeze_traced to come in while siglock is dropped,
expect the process to stop, and have the process not stop.  Of
course wait_task_inactive coming first that might not be a problem.



This is a minor problem with the patchset I just posted.  I thought the
only reason wait_task_inactive could fail was if ptrace_stop() hit the
!current->ptrace case.  Thinking about any it any SIGKILL coming in
before tracee stops in schedule will trigger this, so it is not as
safe as I thought to not pass a state into wait_task_inactive.

It is time for me to shut down today.  I will sleep on that and
see what I can see tomorrow.

Eric

