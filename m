Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71B250EDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbiDZAmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240059AbiDZAl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:41:58 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9839457B0D;
        Mon, 25 Apr 2022 17:38:52 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:49370)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nj9EA-0068NN-AQ; Mon, 25 Apr 2022 18:38:50 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35646 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nj9E8-000Arw-A1; Mon, 25 Apr 2022 18:38:49 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <20220421150654.817117821@infradead.org>
        <20220425143537.GA12412@redhat.com>
        <20220425183343.GM2731@worktop.programming.kicks-ass.net>
Date:   Mon, 25 Apr 2022 19:38:21 -0500
In-Reply-To: <20220425183343.GM2731@worktop.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 25 Apr 2022 20:33:43 +0200")
Message-ID: <87pml4llvm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nj9E8-000Arw-A1;;;mid=<87pml4llvm.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/nKCNvrH/6D1mBicHpVnHGR+OVYdol7KU=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1427 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (0.8%), b_tie_ro: 10 (0.7%), parse: 1.24
        (0.1%), extract_message_metadata: 13 (0.9%), get_uri_detail_list: 1.64
        (0.1%), tests_pri_-1000: 15 (1.1%), tests_pri_-950: 1.30 (0.1%),
        tests_pri_-900: 1.08 (0.1%), tests_pri_-90: 62 (4.3%), check_bayes: 60
        (4.2%), b_tokenize: 8 (0.6%), b_tok_get_all: 9 (0.6%), b_comp_prob:
        2.9 (0.2%), b_tok_touch_all: 37 (2.6%), b_finish: 0.90 (0.1%),
        tests_pri_0: 1307 (91.6%), check_dkim_signature: 0.61 (0.0%),
        check_dkim_adsp: 3.4 (0.2%), poll_dns_idle: 0.25 (0.0%), tests_pri_10:
        3.1 (0.2%), tests_pri_500: 8 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs
 PREEMPT_RT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Apr 25, 2022 at 04:35:37PM +0200, Oleg Nesterov wrote:
>> On 04/21, Peter Zijlstra wrote:
>> >
>> > +static void clear_traced_quiesce(void)
>> > +{
>> > +	spin_lock_irq(&current->sighand->siglock);
>> > +	WARN_ON_ONCE(!(current->jobctl & JOBCTL_TRACED_QUIESCE));
>> 
>> This WARN_ON_ONCE() doesn't look right, the task can be killed right
>> after ptrace_stop() sets JOBCTL_TRACED | JOBCTL_TRACED_QUIESCE and
>> drops siglock.
>
> OK, will look at that.
>
>> > @@ -2290,14 +2303,26 @@ static int ptrace_stop(int exit_code, in
>> >  		/*
>> >  		 * Don't want to allow preemption here, because
>> >  		 * sys_ptrace() needs this task to be inactive.
>> > -		 *
>> > -		 * XXX: implement read_unlock_no_resched().
>> >  		 */
>> >  		preempt_disable();
>> >  		read_unlock(&tasklist_lock);
>> > -		cgroup_enter_frozen();
>> > +		cgroup_enter_frozen(); // XXX broken on PREEMPT_RT !!!
>> > +
>> > +		/*
>> > +		 * JOBCTL_TRACE_QUIESCE bridges the gap between
>> > +		 * set_current_state(TASK_TRACED) above and schedule() below.
>> > +		 * There must not be any blocking (specifically anything that
>> > +		 * touched ->saved_state on PREEMPT_RT) between here and
>> > +		 * schedule().
>> > +		 *
>> > +		 * ptrace_check_attach() relies on this with its
>> > +		 * wait_task_inactive() usage.
>> > +		 */
>> > +		clear_traced_quiesce();
>> 
>> Well, I think it should be called earlier under tasklist_lock,
>> before preempt_disable() above.
>> 
>> We need tasklist_lock to protect ->parent, debugger can be killed
>> and go away right after read_unlock(&tasklist_lock).
>> 
>> Still trying to convince myself everything is right with
>> JOBCTL_STOPPED/TRACED ...
>
> Can't do it earlier, since cgroup_enter_frozen() can do spinlock (eg.
> use ->saved_state).

There are some other issues in this part of ptrace_stop().


I don't see JOBCTL_TRACED_QUIESCE being cleared "if (!current->ptrace)".


Currently in ptrace_check_attach a parameter of __TASK_TRACED is passed
so that wait_task_inactive cane fail if the "!current->ptrace" branch
of ptrace_stop is take and ptrace_stop does not stop.  With the
TASK_FROZEN state it appears that "!current->ptrace" branch can continue
and freeze somewhere else and wait_task_inactive could decided it was
fine.


I have to run, but hopefully tommorrow I will post the patches that
remove the "!current->ptrace" case altogether and basically
remove the need for quiesce and wait_task_inactive detecting
which branch is taken.

The spinlock in cgroup_enter_frozen remains an issue for PREEMPT_RT.
But the rest of the issues are cleared up by using siglock instead
of tasklist_lock.  Plus the code is just easier to read and understand.

Eric
