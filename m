Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD8B4EA2CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiC1WP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiC1WPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:15:31 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FF42921EF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:07:37 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:46094)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nYxWQ-00B9Xg-Hb; Mon, 28 Mar 2022 16:07:34 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:41488 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nYxWP-004pXC-8f; Mon, 28 Mar 2022 16:07:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <Ygq5aBB/qMQw6aP5@linutronix.de>
        <8735j2xigt.fsf@email.froward.int.ebiederm.org>
        <YkHfokLO1UGCISGc@linutronix.de>
Date:   Mon, 28 Mar 2022 17:07:25 -0500
In-Reply-To: <YkHfokLO1UGCISGc@linutronix.de> (Sebastian Andrzej Siewior's
        message of "Mon, 28 Mar 2022 18:17:38 +0200")
Message-ID: <87zgl9pw82.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nYxWP-004pXC-8f;;;mid=<87zgl9pw82.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18iy3ypwwCXhedTnPt+e/Gtvc0bWk4nhFg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 694 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.5%), b_tie_ro: 9 (1.4%), parse: 0.96 (0.1%),
         extract_message_metadata: 13 (1.9%), get_uri_detail_list: 2.5 (0.4%),
        tests_pri_-1000: 6 (0.8%), tests_pri_-950: 1.19 (0.2%),
        tests_pri_-900: 1.01 (0.1%), tests_pri_-90: 126 (18.2%), check_bayes:
        124 (17.8%), b_tokenize: 11 (1.6%), b_tok_get_all: 12 (1.7%),
        b_comp_prob: 3.6 (0.5%), b_tok_touch_all: 93 (13.4%), b_finish: 1.07
        (0.2%), tests_pri_0: 515 (74.2%), check_dkim_signature: 0.91 (0.1%),
        check_dkim_adsp: 2.9 (0.4%), poll_dns_idle: 0.44 (0.1%), tests_pri_10:
        3.6 (0.5%), tests_pri_500: 12 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal/x86: Delay calling signals in atomic
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2022-03-28 09:25:06 [-0500], Eric W. Biederman wrote:
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> 
>> Folks I really would have appreciated being copied on a signal handling
>> patch like this.
>
> Sorry for that. For the whole ptrace/signal part is no maintainer listed
> and I got the feeling that Oleg knows these bits.

Oleg and I maybe a couple of others have been doing the work.

I happen to know the fine differences between TIF_SIGPENDING and
TIF_NOTIFY_RESUME because I have just been doing some cleanup work in
that area.  Plus cleanup in the force_sig_info_to_task area.

>> It is too late to nack, but I think this buggy patch deserved one.  Can
>> we please fix PREEMPT_RT instead?
>
> Sure.
>
>> As far as I can tell this violates all of rules from
>> implementing/maintaining the RT kernel.  Instead of coming up with new
>> abstractions that makes sense and can use by everyone this introduces
>> a hack only for PREEMPT_RT and a pretty horrible one at that.
>>
>> This talks about int3, but the code looks for in_atomic().  Which means
>> that essentially every call of force_sig will take this path as they
>> almost all come from exception handlers.  It is the nature of signals
>> that report on faults.  An exception is raised and the kernel reports it
>> to userspace with a fault signal (aka force_sig_xxx).
>
> The int3 is invoked with disabled interrupts. There are also a few
> others path which are explicit with disabled interrupts or with a
> raw_spinlock_t which lead to an atomic section on PREEMPT_RT. Call
> chains with spinlock_t or a rwlock_t don't lead to a atomic section on
> PREEMPT_RT. Therefore I don't think this is "essentially every call of
> force_sig" that is going to use that.

I was assuming that exception handlers would be like int3 and are in
general cases that would be places that are atomic and don't allow
scheduling.  I admit I don't know the PREEMPT_RT rules though.


>> Further this code is buggy.  TIF_NOTIFY_RESUME is not the correct
>> flag to set to enter into exit_to_usermode_loop.  TIF_NOTIFY_RESUME is
>> about that happens after signal handling.  This very much needs to be
>> TIF_SIGPENDING with recalc_sigpending and friends updated to know about
>> "task->force_info".
>> 
>> Does someone own this problem?  Can that person please fix this
>> properly?
>
> Sure. Instead setting TIF_NOTIFY_RESUME you want the code updated to use
> recalc_sigpending() only. Or do you have other suggestions regarding
> fixing this properly?

The rule with TIF_SIGPENDING (which should be used if this technique is
used at all), is that recalc_sigpending needs to know how to test if
the signal is still pending.

>> I really don't think it is going to be maintainable for PREEMPT_RT to
>> maintain a separate signal delivery path for faults from the rest of
>> linux.
>
> Okay.

We have a few other cases where we deliver signals from interrupts.
Off the top of my head there is SAK and magic sysrq, but I think there
are more.  So I am also not convinced that all signals you care about
will go through force_sig_info_to_task.

What I really don't know and this is essentially a PREEMPT_RT question
is what makes int3 special?  Why don't other faults have this problem?

I remember there was a change where we had threaded interrupt handlers
to get around this for interrupt service routines.  I wonder if we need
to do something similar with faults.  Have a fast part and a threaded
part that runs in a schedulable way.  Although given that for a fault
you need to be fundamentally bound to the task/thread you faulted from
it probably just means having a way to switch to a kernel stack that you
can schedule from, and not use a reserved per cpu stack.  The
task_struct would certainly need to stay the same for all of the pieces.

Or maybe for PREMPT_RT you pick the i386 mechanism.  How does PREEMPT_RT
deal with page faults, or general protection faults?

This is my long winded way of saying that I rather expect that if
PREEMPT_RT is going to call code it has modified to be sleeping that it
would also make it safe for that code to sleep.

Further (and this is probably my ignorance) I just don't see what makes
any of this specific to just int3.  Why aren't other faults affected?

Eric

