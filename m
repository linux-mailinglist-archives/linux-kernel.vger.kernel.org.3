Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28704492CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347803AbiARSK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:10:29 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:43220 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbiARSKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:10:23 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:48006)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9sw0-0028Bm-Ki; Tue, 18 Jan 2022 11:10:20 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:60400 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9svz-0026qb-Ei; Tue, 18 Jan 2022 11:10:20 -0700
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
Date:   Tue, 18 Jan 2022 12:10:12 -0600
In-Reply-To: <878rvd6jgu.mognet@arm.com> (Valentin Schneider's message of
        "Tue, 18 Jan 2022 17:29:21 +0000")
Message-ID: <87h7a06hkr.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n9svz-0026qb-Ei;;;mid=<87h7a06hkr.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+GdPcXRX9fPx6fHK6oCi3BAAvq5AF1mLk=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Valentin Schneider <valentin.schneider@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 548 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.1 (0.6%), b_tie_ro: 2.1 (0.4%), parse: 1.36
        (0.2%), extract_message_metadata: 14 (2.5%), get_uri_detail_list: 2.7
        (0.5%), tests_pri_-1000: 6 (1.1%), tests_pri_-950: 1.04 (0.2%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 96 (17.6%), check_bayes:
        94 (17.1%), b_tokenize: 8 (1.5%), b_tok_get_all: 34 (6.2%),
        b_comp_prob: 2.1 (0.4%), b_tok_touch_all: 47 (8.5%), b_finish: 0.64
        (0.1%), tests_pri_0: 412 (75.3%), check_dkim_signature: 0.47 (0.1%),
        check_dkim_adsp: 3.6 (0.7%), poll_dns_idle: 0.02 (0.0%), tests_pri_10:
        1.85 (0.3%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/2] sched/tracing: Add TASK_RTLOCK_WAIT to TASK_REPORT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Schneider <valentin.schneider@arm.com> writes:

> On 17/01/22 13:12, Eric W. Biederman wrote:
>> Valentin Schneider <valentin.schneider@arm.com> writes:
>>> --- a/fs/proc/array.c
>>> +++ b/fs/proc/array.c
>>> @@ -128,9 +128,10 @@ static const char * const task_state_array[] = {
>>>  	"X (dead)",		/* 0x10 */
>>>  	"Z (zombie)",		/* 0x20 */
>>>  	"P (parked)",		/* 0x40 */
>>> +	"L (rt-locked)",        /* 0x80 */
>>>  
>>>  	/* states beyond TASK_REPORT: */
>>> -	"I (idle)",		/* 0x80 */
>>> +	"I (idle)",		/* 0x100 */
>>>  };
>>
>> I think this is at least possibly an ABI break.  I have a vague memory
>> that userspace is not ready being reported new task states.  Which is
>> why we encode some of our states the way we do.
>>
>> Maybe it was just someone being very conservative.
>>
>> Still if you are going to add new states to userspace and risk breaking
>> them can you do some basic analysis and report what ps and similar
>> programs do.
>>
>> Simply changing userspace without even mentioning that you are changing
>> the userspace output of proc looks dangerous indeed.
>>
>
> Yeah, you're right.
>
>> Looking in the history commit 74e37200de8e ("proc: cleanup/simplify
>> get_task_state/task_state_array") seems to best document the concern
>> that userspace does not know how to handle new states.
>>
>
> Thanks for the sha1 and for digging around. Now, I read
> 74e37200de8e ("proc: cleanup/simplify get_task_state/task_state_array")
> as "get_task_state() isn't clear vs what value is actually exposed to
> userspace" rather than "get_task_state() could expose things userspace
> doesn't know what to do with".

There is also commit abd50b39e783 ("wait: introduce EXIT_TRACE to avoid
the racy EXIT_DEAD->EXIT_ZOMBIE transition").

Which I think is more of what I was remembering.

>> The fact we have had a parked state for quite a few years despite that
>> concern seems to argue it is possible to extend the states.  Or perhaps
>> it just argues that parked states are rare enough it does not matter.
>>
>> It is definitely the case that the ps manpage documents the possible
>> states and as such they could be a part of anyone's shell scripts.
>>
>
> 06eb61844d84 ("sched/debug: Add explicit TASK_IDLE printing") for instance
> seems to suggest extending the states OK, but you're right that this then
> requires updating ps' manpage.
>
> Alternatively, TASK_RTLOCK_WAIT could be masqueraded as
> TASK_(UN)INTERRUPTIBLE when reported to userspace - it is actually somewhat
> similar, unlike TASK_IDLE vs TASK_UNINTERRUPTIBLE for instance. The
> handling in get_task_state() will be fugly, but it might be preferable over
> exposing a detail userspace might not need to be made aware of?

Right.

Frequently I have seen people do a cost/benefit analysis.

If the benefit is enough, and tracking down the userspace programs that
need to be verified to work with the change is inexpensive enough the
change is made.  Always keeping in mind that if something was missed and
the change causes a regression the change will need to be reverted.

If there is little benefit or the cost to track down userspace is great
enough the work is put in to hide the change from userspace.  Just
because it is too much trouble to expose it to userspace.

I honestly don't have any kind of sense about how hard it is to verify
that a userspace regression won't result from a change like this.  I
just know that the question needs to be asked.

Eric
