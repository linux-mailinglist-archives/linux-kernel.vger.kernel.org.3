Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775B7491092
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 20:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbiAQTND convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jan 2022 14:13:03 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36248 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiAQTNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 14:13:02 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:36580)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9XR6-005Hxc-78; Mon, 17 Jan 2022 12:13:00 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:50160 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n9XR4-003obi-4V; Mon, 17 Jan 2022 12:12:59 -0700
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
        Ed Tsai <ed.tsai@mediatek.com>, <linux-api@vger.kernel.org>
References: <20220117164633.322550-1-valentin.schneider@arm.com>
        <20220117164633.322550-3-valentin.schneider@arm.com>
Date:   Mon, 17 Jan 2022 13:12:51 -0600
In-Reply-To: <20220117164633.322550-3-valentin.schneider@arm.com> (Valentin
        Schneider's message of "Mon, 17 Jan 2022 16:46:33 +0000")
Message-ID: <878rve89cc.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1n9XR4-003obi-4V;;;mid=<878rve89cc.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+D0K6w9aeqH3OVlfZDgUzFAGkad9h1nAw=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Valentin Schneider <valentin.schneider@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 701 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (1.7%), b_tie_ro: 10 (1.4%), parse: 1.73
        (0.2%), extract_message_metadata: 25 (3.5%), get_uri_detail_list: 2.4
        (0.3%), tests_pri_-1000: 20 (2.9%), tests_pri_-950: 1.43 (0.2%),
        tests_pri_-900: 1.26 (0.2%), tests_pri_-90: 312 (44.5%), check_bayes:
        290 (41.3%), b_tokenize: 9 (1.3%), b_tok_get_all: 11 (1.6%),
        b_comp_prob: 4.5 (0.6%), b_tok_touch_all: 258 (36.9%), b_finish: 1.52
        (0.2%), tests_pri_0: 311 (44.4%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 3.2 (0.5%), poll_dns_idle: 1.32 (0.2%), tests_pri_10:
        2.7 (0.4%), tests_pri_500: 10 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/2] sched/tracing: Add TASK_RTLOCK_WAIT to TASK_REPORT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Schneider <valentin.schneider@arm.com> writes:

> TASK_RTLOCK_WAIT currently isn't part of TASK_REPORT, thus a task blocking
> on an rtlock will appear as having a task state == 0, IOW TASK_RUNNING.
>
> The actual state is saved in p->saved_state, but reading it after reading
> p->__state has a few issues:
> o that could still be TASK_RUNNING in the case of e.g. rt_spin_lock
> o ttwu_state_match() might have changed that to TASK_RUNNING
>
> Add TASK_RTLOCK_WAIT to TASK_REPORT.
>
> Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  fs/proc/array.c              |  3 ++-
>  include/linux/sched.h        | 17 +++++++++--------
>  include/trace/events/sched.h |  1 +
>  3 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index ff869a66b34e..f4cae65529a6 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -128,9 +128,10 @@ static const char * const task_state_array[] = {
>  	"X (dead)",		/* 0x10 */
>  	"Z (zombie)",		/* 0x20 */
>  	"P (parked)",		/* 0x40 */
> +	"L (rt-locked)",        /* 0x80 */
>  
>  	/* states beyond TASK_REPORT: */
> -	"I (idle)",		/* 0x80 */
> +	"I (idle)",		/* 0x100 */
>  };

I think this is at least possibly an ABI break.  I have a vague memory
that userspace is not ready being reported new task states.  Which is
why we encode some of our states the way we do.

Maybe it was just someone being very conservative.

Still if you are going to add new states to userspace and risk breaking
them can you do some basic analysis and report what ps and similar
programs do.

Simply changing userspace without even mentioning that you are changing
the userspace output of proc looks dangerous indeed.

Looking in the history commit 74e37200de8e ("proc: cleanup/simplify
get_task_state/task_state_array") seems to best document the concern
that userspace does not know how to handle new states.

The fact we have had a parked state for quite a few years despite that
concern seems to argue it is possible to extend the states.  Or perhaps
it just argues that parked states are rare enough it does not matter.

It is definitely the case that the ps manpage documents the possible
states and as such they could be a part of anyone's shell scripts.

From the ps man page:
>        Here are the different values that the s, stat and state output
>        specifiers (header "STAT" or "S") will display to describe the
>        state of a process:
> 
>                D    uninterruptible sleep (usually IO)
>                I    Idle kernel thread
>                R    running or runnable (on run queue)
>                S    interruptible sleep (waiting for an event to complete)
>                T    stopped by job control signal
>                t    stopped by debugger during the tracing
>                W    paging (not valid since the 2.6.xx kernel)
>                X    dead (should never be seen)
>                Z    defunct ("zombie") process, terminated but not reaped by its parent
> 

So it looks like a change that adds to the number of states in the
kernel should update the ps man page as well.

Eric
