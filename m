Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C445685FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiGFKpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiGFKpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:45:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACB76337
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6+vRWgIROMcCt5sXw27vWrci5F+2pQj9WFh5sEOI6pk=; b=doYmDC3cqezpwdGRODF/WXYOY0
        pzg8Ru5FGeuPBBxmGx97bSVkgmwV2KHdd/co3cEo+/we24ZjPv9GCvo3tZAuLccNcRiqVhWlArE51
        AFoofFBkVb5DoTSsvCdAiWNbhSmIaZnr9BbhRrEzOggnlPmSO4jMYXEyXOCCOi+IHKZ0EqKLoMrQs
        YdPOfzjB6U+UvFmynzAJoyudFKTE0KY4+6wJvgEH/zwO5xVLbAGShWsJzKRB/0+T8JHmwWIVo62wt
        dalU/Vw9i/tnWIpe9nf/aqTAEc016KLoxpZOUEHa4Te+Hw0f+6EGuI+Yt5M7qichZ3vOi76U0aW4b
        xzG1+x6w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o92Wj-001aAH-CT; Wed, 06 Jul 2022 10:45:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E124980050; Wed,  6 Jul 2022 12:44:59 +0200 (CEST)
Date:   Wed, 6 Jul 2022 12:44:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace: fix clearing of JOBCTL_TRACED in
 ptrace_unfreeze_traced()
Message-ID: <YsVnqtvOa9ImLkmj@worktop.programming.kicks-ass.net>
References: <20220706101625.2100298-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706101625.2100298-1-svens@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 12:16:25PM +0200, Sven Schnelle wrote:
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
> 
> Fixes: 31cae1eaae4f ("sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

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
> -- 
> 2.34.1
> 
