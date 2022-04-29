Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BD5515861
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381487AbiD2WcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239151AbiD2Wbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:31:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63490289A7;
        Fri, 29 Apr 2022 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R5m8qcj/TBlfc3wYbiF2A/onmhBLqu9GlFpGk0U50/I=; b=ofMLjzi/nSpalldb3o1frzjtCJ
        yvxQNRyC6D3rUUxwtj3fBk0gLI5zxBz3cxT2Zu+u8KeYWcRPULol6yWkCbeRGvgy9ufd1yts1L8Ox
        +sMMkuZ0aZAJOSPxvTFZ72BRx3EXOj2IbaWecIwapUPEMVatcaTUeIMkRFm5dHgYau8qWIuT88KzE
        osrv6AD/HA/BH097sOtGCJhlqhiqOjkuhbsWEZJLIQIfpw0pIwCypCAXfHIMqkL9glD2iqG1G/EKk
        2VddDaqXzYGc1d4npTbzv5PByMllsAA8Juflw2cT0vqQyHkHeEzQITi84Tb8IEbnb38CnYX5mq6A+
        dn2aAW5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkZ5i-00CrZH-FP; Fri, 29 Apr 2022 22:27:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B55D33002B1;
        Sat, 30 Apr 2022 00:27:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 741F120295B05; Sat, 30 Apr 2022 00:27:55 +0200 (CEST)
Date:   Sat, 30 Apr 2022 00:27:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v2 07/12] ptrace: Don't change __state
Message-ID: <Ymxma2vRP+FjEkgq@hirez.programming.kicks-ass.net>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <20220429214837.386518-7-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429214837.386518-7-ebiederm@xmission.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 04:48:32PM -0500, Eric W. Biederman wrote:
> Stop playing with tsk->__state to remove TASK_WAKEKILL while a ptrace
> command is executing.
> 
> Instead TASK_WAKEKILL from the definition of TASK_TRACED, and
> implemention a new jobctl flag TASK_PTRACE_FROZEN.  This new This new
> flag is set in jobctl_freeze_task and cleared when ptrace_stop is
> awoken or in jobctl_unfreeze_task (when ptrace_stop remains asleep).
> 
> In singal_wake_up add __TASK_TRACED to state along with TASK_WAKEKILL
> when it is indicated a fatal signal is pending.  Skip adding
> __TASK_TRACED when TASK_PTRACE_FROZEN is not set.  This has the same
> effect as changing TASK_TRACED to __TASK_TRACED as all of the wake_ups
> that use TASK_KILLABLE go through signal_wake_up.
> 
> Don't set TASK_TRACED if fatal_signal_pending so that the code
> continues not to sleep if there was a pending fatal signal before
> ptrace_stop is called.  With TASK_WAKEKILL no longer present in
> TASK_TRACED signal_pending_state will no longer prevent ptrace_stop
> from sleeping if there is a pending fatal signal.
> 
> Previously the __state value of __TASK_TRACED was changed to
> TASK_RUNNING when woken up or back to TASK_TRACED when the code was
> left in ptrace_stop.  Now when woken up ptrace_stop now clears
> JOBCTL_PTRACE_FROZEN and when left sleeping ptrace_unfreezed_traced
> clears JOBCTL_PTRACE_FROZEN.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  include/linux/sched.h        |  2 +-
>  include/linux/sched/jobctl.h |  2 ++
>  include/linux/sched/signal.h |  8 +++++++-
>  kernel/ptrace.c              | 21 ++++++++-------------
>  kernel/signal.c              |  9 +++------
>  5 files changed, 21 insertions(+), 21 deletions(-)

Please fold this hunk:

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6310,10 +6310,7 @@ static void __sched notrace __schedule(u
 
 	/*
 	 * We must load prev->state once (task_struct::state is volatile), such
-	 * that:
-	 *
-	 *  - we form a control dependency vs deactivate_task() below.
-	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
+	 * that we form a control dependency vs deactivate_task() below.
 	 */
 	prev_state = READ_ONCE(prev->__state);
 	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {

