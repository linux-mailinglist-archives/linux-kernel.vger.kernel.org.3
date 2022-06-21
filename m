Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B93553927
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbiFURrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiFURrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:47:47 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029DA1D33D;
        Tue, 21 Jun 2022 10:47:43 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:40154)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o3hyW-0082j0-AD; Tue, 21 Jun 2022 11:47:40 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:57204 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o3hyU-00FcFh-4P; Tue, 21 Jun 2022 11:47:39 -0600
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
Date:   Tue, 21 Jun 2022 12:47:30 -0500
In-Reply-To: <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
        (Alexander Gordeev's message of "Tue, 21 Jun 2022 17:15:47 +0200")
Message-ID: <87bkulgb7x.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o3hyU-00FcFh-4P;;;mid=<87bkulgb7x.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/dpp5tIacC6XPqlYr0c2axC5loJaQ/H14=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Alexander Gordeev <agordeev@linux.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1603 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.8 (0.3%), b_tie_ro: 3.2 (0.2%), parse: 1.29
        (0.1%), extract_message_metadata: 12 (0.8%), get_uri_detail_list: 3.7
        (0.2%), tests_pri_-1000: 9 (0.6%), tests_pri_-950: 1.09 (0.1%),
        tests_pri_-900: 0.84 (0.1%), tests_pri_-90: 182 (11.4%), check_bayes:
        176 (11.0%), b_tokenize: 9 (0.6%), b_tok_get_all: 12 (0.7%),
        b_comp_prob: 3.0 (0.2%), b_tok_touch_all: 148 (9.2%), b_finish: 0.80
        (0.0%), tests_pri_0: 1377 (85.9%), check_dkim_signature: 0.43 (0.0%),
        check_dkim_adsp: 2.4 (0.1%), poll_dns_idle: 0.65 (0.0%), tests_pri_10:
        2.8 (0.2%), tests_pri_500: 9 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Gordeev <agordeev@linux.ibm.com> writes:

> On Tue, Jun 21, 2022 at 09:02:05AM -0500, Eric W. Biederman wrote:
>> Alexander Gordeev <agordeev@linux.ibm.com> writes:
>> 
>> > On Thu, May 05, 2022 at 01:26:45PM -0500, Eric W. Biederman wrote:
>> >> From: Peter Zijlstra <peterz@infradead.org>
>> >> 
>> >> Currently ptrace_stop() / do_signal_stop() rely on the special states
>> >> TASK_TRACED and TASK_STOPPED resp. to keep unique state. That is, this
>> >> state exists only in task->__state and nowhere else.
>> >> 
>> >> There's two spots of bother with this:
>> >> 
>> >>  - PREEMPT_RT has task->saved_state which complicates matters,
>> >>    meaning task_is_{traced,stopped}() needs to check an additional
>> >>    variable.
>> >> 
>> >>  - An alternative freezer implementation that itself relies on a
>> >>    special TASK state would loose TASK_TRACED/TASK_STOPPED and will
>> >>    result in misbehaviour.
>> >> 
>> >> As such, add additional state to task->jobctl to track this state
>> >> outside of task->__state.
>> >> 
>> >> NOTE: this doesn't actually fix anything yet, just adds extra state.
>> >> 
>> >> --EWB
>> >>   * didn't add a unnecessary newline in signal.h
>> >>   * Update t->jobctl in signal_wake_up and ptrace_signal_wake_up
>> >>     instead of in signal_wake_up_state.  This prevents the clearing
>> >>     of TASK_STOPPED and TASK_TRACED from getting lost.
>> >>   * Added warnings if JOBCTL_STOPPED or JOBCTL_TRACED are not cleared
>> >
>> > Hi Eric, Peter,
>> >
>> > On s390 this patch triggers warning at kernel/ptrace.c:272 when
>> > kill_child testcase from strace tool is repeatedly used (the source
>> > is attached for reference):
>> >
>> > while :; do
>> > 	strace -f -qq -e signal=none -e trace=sched_yield,/kill ./kill_child
>> > done
>> >
>> > It normally takes few minutes to cause the warning in -rc3, but FWIW
>> > it hits almost immediately for ptrace_stop-cleanup-for-v5.19 tag of
>> > git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.
>> >
>> > Commit 7b0fe1367ef2 ("ptrace: Document that wait_task_inactive can't
>> > fail") suggests this WARN_ON_ONCE() is not really expected, yet we
>> > observe a child in __TASK_TRACED state. Could you please comment here?
>> >
>> 
>> For clarity the warning is that the child is not in __TASK_TRACED state.
>> 
>> The code is waiting for the code to stop in the scheduler in the
>> __TASK_TRACED state so that it can safely read and change the
>> processes state.  Some of that state is not even saved until the
>> process is scheduled out so we have to wait until the process
>> is stopped in the scheduler.
>
> So I assume (checked actually) the return 0 below from kernel/sched/core.c:
> wait_task_inactive() is where it bails out:
>
> 3303                 while (task_running(rq, p)) {
> 3304                         if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
> 3305                                 return 0;
> 3306                         cpu_relax();
> 3307                 }
>
> Yet, the child task is always found in __TASK_TRACED state (as seen
> in crash dumps):
>
>> 101447  11342  13      ce3a8100      RU   0.0   10040   4412  strace
>   101450  101447   0      bb04b200      TR   0.0    2272   1136  kill_child
>   108261  101447   2      d0b10100      TR   0.0    2272    532  kill_child
> crash> task bb04b200 __state
> PID: 101450  TASK: bb04b200          CPU: 0   COMMAND: "kill_child"
>   __state = 8,
>
> crash> task d0b10100 __state
> PID: 108261  TASK: d0b10100          CPU: 2   COMMAND: "kill_child"
>   __state = 8,

That is weird.

>> At least on s390 it looks like there is a race between SIGKILL and
>> ptrace_check_attach.  That isn't good.
>>
>> Reading the code below there is something missing because I don't see
>> anything making ptrace calls, and ptrace_check_attach (which contains
>> the warning) only happens in the ptrace syscall.
>
> That is what I believe strace does when calling that code:
>
>  	strace -f -qq -e signal=none -e trace=sched_yield,/kill	./kill_child

Thank you.  That was my braino.

I will have to see if it reproduces for me on x86 (I don't have an
s390).  Perhaps if I can reproduce it I can guess what is going wrong.

So far it appears WARN_ON_ONCE has nothing to warn about yet it is
warning.

Eric
