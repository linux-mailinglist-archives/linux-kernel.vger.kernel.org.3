Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8170F494082
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbiASTNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:13:53 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:35552 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiASTNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:13:53 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:46500)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nAGP0-004pU3-MY; Wed, 19 Jan 2022 12:13:50 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:45716 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nAGOz-006ccZ-Aj; Wed, 19 Jan 2022 12:13:50 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ed Tsai <ed.tsai@mediatek.com>, linux-api@vger.kernel.org
References: <20220117164633.322550-1-valentin.schneider@arm.com>
        <20220117164633.322550-3-valentin.schneider@arm.com>
        <878rve89cc.fsf@email.froward.int.ebiederm.org>
        <878rvd6jgu.mognet@arm.com>
        <87h7a06hkr.fsf@email.froward.int.ebiederm.org>
        <875yqf7eq4.mognet@arm.com>
Date:   Wed, 19 Jan 2022 13:13:42 -0600
In-Reply-To: <875yqf7eq4.mognet@arm.com> (Valentin Schneider's message of
        "Wed, 19 Jan 2022 18:38:43 +0000")
Message-ID: <87fspj7d3t.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nAGOz-006ccZ-Aj;;;mid=<87fspj7d3t.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+oSM1ZuUDl1IfWlCLn1yiB3bjw4dARZ6s=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Valentin Schneider <valentin.schneider@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 696 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 9 (1.3%), parse: 1.51 (0.2%),
         extract_message_metadata: 12 (1.7%), get_uri_detail_list: 1.61 (0.2%),
         tests_pri_-1000: 7 (0.9%), tests_pri_-950: 1.14 (0.2%),
        tests_pri_-900: 1.00 (0.1%), tests_pri_-90: 89 (12.7%), check_bayes:
        87 (12.5%), b_tokenize: 8 (1.2%), b_tok_get_all: 8 (1.1%),
        b_comp_prob: 2.3 (0.3%), b_tok_touch_all: 65 (9.3%), b_finish: 0.97
        (0.1%), tests_pri_0: 560 (80.5%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.39 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 9 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/2] sched/tracing: Add TASK_RTLOCK_WAIT to TASK_REPORT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Schneider <valentin.schneider@arm.com> writes:

> On 18/01/22 12:10, Eric W. Biederman wrote:
>> Valentin Schneider <valentin.schneider@arm.com> writes:
>>>
>>> Alternatively, TASK_RTLOCK_WAIT could be masqueraded as
>>> TASK_(UN)INTERRUPTIBLE when reported to userspace - it is actually somewhat
>>> similar, unlike TASK_IDLE vs TASK_UNINTERRUPTIBLE for instance. The
>>> handling in get_task_state() will be fugly, but it might be preferable over
>>> exposing a detail userspace might not need to be made aware of?
>>
>> Right.
>>
>> Frequently I have seen people do a cost/benefit analysis.
>>
>> If the benefit is enough, and tracking down the userspace programs that
>> need to be verified to work with the change is inexpensive enough the
>> change is made.  Always keeping in mind that if something was missed and
>> the change causes a regression the change will need to be reverted.
>>
>> If there is little benefit or the cost to track down userspace is great
>> enough the work is put in to hide the change from userspace.  Just
>> because it is too much trouble to expose it to userspace.
>>
>> I honestly don't have any kind of sense about how hard it is to verify
>> that a userspace regression won't result from a change like this.  I
>> just know that the question needs to be asked.
>>
>
> I see it as: does it actually make sense to expose a new state? All the
> information this is conveying is: "this task took a lock that is
> substituted by a sleepable lock under PREEMPT_RT". Now that you brought
> this up, I don't really see much value in this vs just conveying that the
> task is sleeping on a lock, i.e. just report the same as if it had gone
> through rt_mutex_lock(), aka:

That seems reasonable to me.

Eric

>
> ---
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d00837d12b9d..ac7b3eef4a61 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1626,6 +1626,14 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
>  	if (tsk_state == TASK_IDLE)
>  		state = TASK_REPORT_IDLE;
>  
> +	/*
> +	 * We're lying here, but rather than expose a completely new task state
> +	 * to userspace, we can make this appear as if the task had gone through
> +	 * a regular rt_mutex_lock() call.
> +	 */
> +	if (tsk_state == TASK_RTLOCK_WAIT)
> +		state = TASK_UNINTERRUPTIBLE;
> +
>  	return fls(state);
>  }
>  
