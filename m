Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A1055F190
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiF1Ws7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiF1Ws4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:48:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3113A709;
        Tue, 28 Jun 2022 15:48:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20E6761AC0;
        Tue, 28 Jun 2022 22:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE46C341C8;
        Tue, 28 Jun 2022 22:48:51 +0000 (UTC)
Date:   Tue, 28 Jun 2022 18:48:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
Message-ID: <20220628184850.05f60d1e@gandalf.local.home>
In-Reply-To: <87czess94h.fsf@email.froward.int.ebiederm.org>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <20220505182645.497868-12-ebiederm@xmission.com>
        <YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
        <877d5ajesi.fsf@email.froward.int.ebiederm.org>
        <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
        <87y1xk8zx5.fsf@email.froward.int.ebiederm.org>
        <YrtKReO2vIiX8VVU@tuxmaker.boeblingen.de.ibm.com>
        <87czess94h.fsf@email.froward.int.ebiederm.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 17:42:22 -0500
"Eric W. Biederman" <ebiederm@xmission.com> wrote:

> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 156a99283b11..cb85bcf84640 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -202,6 +202,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
>  	spin_lock_irq(&task->sighand->siglock);
>  	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
>  	    !__fatal_signal_pending(task)) {
> +		smp_rmb();
>  		task->jobctl |= JOBCTL_PTRACE_FROZEN;
>  		ret = true;
>  	}
> diff --git a/kernel/signal.c b/kernel/signal.c
> index edb1dc9b00dc..bcd576e9de66 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2233,6 +2233,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
>  		return exit_code;
>  
>  	set_special_state(TASK_TRACED);
> +	smp_wmb();
>  	current->jobctl |= JOBCTL_TRACED;
>  

Are not these both done under the sighand->siglock spinlock?

That is, the two paths should already be synchronized, and the memory
barriers will not help anything inside the locks. The locking should (and
must) handle all that.

-- Steve

