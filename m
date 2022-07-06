Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B01569441
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiGFVXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiGFVW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:22:58 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D01A066
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:22:57 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:47138)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o9CU2-000KRq-NH; Wed, 06 Jul 2022 15:22:54 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35934 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o9CU1-004OoQ-Pz; Wed, 06 Jul 2022 15:22:54 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
References: <20220706101625.2100298-1-svens@linux.ibm.com>
Date:   Wed, 06 Jul 2022 16:15:17 -0500
In-Reply-To: <20220706101625.2100298-1-svens@linux.ibm.com> (Sven Schnelle's
        message of "Wed, 6 Jul 2022 12:16:25 +0200")
Message-ID: <87k08qlz8a.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o9CU1-004OoQ-Pz;;;mid=<87k08qlz8a.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18r6LBKAPlBXmDEAPvZbvEiy1hnJuRFxrM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Sven Schnelle <svens@linux.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 326 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.5 (1.4%), b_tie_ro: 3.0 (0.9%), parse: 1.07
        (0.3%), extract_message_metadata: 4.4 (1.3%), get_uri_detail_list: 2.1
        (0.6%), tests_pri_-1000: 3.1 (0.9%), tests_pri_-950: 1.18 (0.4%),
        tests_pri_-900: 0.86 (0.3%), tests_pri_-90: 55 (16.9%), check_bayes:
        54 (16.5%), b_tokenize: 5 (1.7%), b_tok_get_all: 8 (2.4%),
        b_comp_prob: 1.84 (0.6%), b_tok_touch_all: 36 (11.0%), b_finish: 0.64
        (0.2%), tests_pri_0: 239 (73.2%), check_dkim_signature: 0.62 (0.2%),
        check_dkim_adsp: 2.4 (0.7%), poll_dns_idle: 0.42 (0.1%), tests_pri_10:
        2.5 (0.8%), tests_pri_500: 8 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] ptrace: fix clearing of JOBCTL_TRACED in
 ptrace_unfreeze_traced()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Schnelle <svens@linux.ibm.com> writes:

> CI reported the following splat while running the strace testsuite:
>
> [ 3976.640309] WARNING: CPU: 1 PID: 3570031 at kernel/ptrace.c:272 ptrace_check_attach+0x12e/0x178
> [ 3976.640391] CPU: 1 PID: 3570031 Comm: strace Tainted: G           OE     5.19.0-20220624.rc3.git0.ee819a77d4e7.300.fc36.s390x #1
> [ 3976.640410] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> [ 3976.640452] Call Trace:
> [ 3976.640454]  [<00000000ab4b645a>] ptrace_check_attach+0x132/0x178
> [ 3976.640457] ([<00000000ab4b6450>] ptrace_check_attach+0x128/0x178)
> [ 3976.640460]  [<00000000ab4b6cde>] __s390x_sys_ptrace+0x86/0x160
> [ 3976.640463]  [<00000000ac03fcec>] __do_syscall+0x1d4/0x200
> [ 3976.640468]  [<00000000ac04e312>] system_call+0x82/0xb0
> [ 3976.640470] Last Breaking-Event-Address:
> [ 3976.640471]  [<00000000ab4ea3c8>] wait_task_inactive+0x98/0x190
>
> This is because JOBCTL_TRACED is set, but the task is not in TASK_TRACED
> state. Caused by ptrace_unfreeze_traced() which does:
>
> task->jobctl &= ~TASK_TRACED
>
> but it should be:
>
> task->jobctl &= ~JOBCTL_TRACED


That would definitely do it.  I had to think about it for a few minutes
to see how it explains some of the stranger behavior but it explains
all of the funny behavior I have seen.

Thank you for tracking this down.

The fact the original bug report was on s390 had me somehow thinking
this was s390 only.

I will double check everything get this in linux-next and then send this
to Linus.

Eric


> Fixes: 31cae1eaae4f ("sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
>  kernel/ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 156a99283b11..1893d909e45c 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -222,7 +222,7 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>  	if (lock_task_sighand(task, &flags)) {
>  		task->jobctl &= ~JOBCTL_PTRACE_FROZEN;
>  		if (__fatal_signal_pending(task)) {
> -			task->jobctl &= ~TASK_TRACED;
> +			task->jobctl &= ~JOBCTL_TRACED;
>  			wake_up_state(task, __TASK_TRACED);
>  		}
>  		unlock_task_sighand(task, &flags);
