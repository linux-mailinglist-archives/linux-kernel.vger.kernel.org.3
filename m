Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74035511747
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiD0MMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiD0MM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:12:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471AF71D90
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:09:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651061356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zFwpQk7f3urEAhYlURmaehWqRu1LwsGhs7EhKdG/W1s=;
        b=o5+MTiA/n3YuQYlCf25jv8PKoQ4iV5piZFDKUykM+377aQ8pYlGfIUJ6I28g473ticVM6m
        oBZKAXIzVKSSPE9wnk1kJpjO0BCrlhRhYa4ZvPulEY/Y4JHHWxjdTu8ljo9nT34jDL1J/q
        Xf/SDdoJ/jrlB6QdAA0slcBt8nBEMgd28DUVxSddwQBkYq5tiz+8ZVny554ezlK7uyC3Uw
        aDpPWJHpcU3iOa4qSD+wwW/vmbm+SeXuQ4RIqdDk2tnoTeRgpXTfJo6eW0o3mqXvc5gTCZ
        tG0CpReyJVAW5mARbTinbTktpQaE41C8BPTqA47AmRDT7QpRSXccI5ci8pt7/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651061356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zFwpQk7f3urEAhYlURmaehWqRu1LwsGhs7EhKdG/W1s=;
        b=jqYZzottz90yEOiVMb+b6QPXBh9V9ox7dOs6a+TaRWcwm/2kzvowGSEVvNumuKq6+kGZrR
        Y2eN0TymaF052UAg==
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch v12 09/13] task isolation: add preempt notifier to sync
 per-CPU vmstat dirty info to thread info
In-Reply-To: <878rrryp8y.ffs@tglx>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153314.130167792@fedora.localdomain> <878rrryp8y.ffs@tglx>
Date:   Wed, 27 Apr 2022 14:09:16 +0200
Message-ID: <87ilquybgz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27 2022 at 09:11, Thomas Gleixner wrote:
> On Tue, Mar 15 2022 at 12:31, Marcelo Tosatti wrote:
>> If a thread has task isolation activated, is preempted by thread B,
>> which marks vmstat information dirty, and is preempted back in,
>> one might return to userspace with vmstat dirty information on the 
>> CPU in question.
>>
>> To address this problem, add a preempt notifier that transfers vmstat dirty
>> information to TIF_TASK_ISOL thread flag.
>
> How does this compile with CONFIG_KVM=n?

Aside of that, the existance of this preempt notifier alone tells me
that this is either a design fail or has no design in the first place.

The state of vmstat does not matter at all at the point where a task is
scheduled in. It matters when an isolated task goes out to user space or
enters a VM.

We already have something similar in the exit to user path:

   tick_nohz_user_enter_prepare()

So you can do something like the below and have:

static inline void task_isol_exit_to_user_prepare(void)
{
        if (unlikely(current_needs_isol_exit_to_user())
        	__task_isol_exit_to_user_prepare();
}

where current_needs_isol_exit_to_user() is a simple check of either an
existing mechanism like

         task->syscall_work & SYSCALL_WORK_TASK_ISOL_EXIT

or of some new task isolation specific member of task_struct which is
placed so it is cache hot at that point:

        task->isol_work & SYSCALL_TASK_ISOL_EXIT

which is going to be almost zero overhead for any non isolated task.

It's trivial enough to encode the real stuff into task->isol_work and
I'm pretty sure, that a 32bit member is sufficient for that. There is
absolutely no need for a potential 64x64 bit feature matrix.

Thanks,

        tglx
---
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -142,6 +142,12 @@ void noinstr exit_to_user_mode(void)
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
+static void exit_to_user_update_work(void)
+{
+	tick_nohz_user_enter_prepare();
+	task_isol_exit_to_user_prepare();
+}
+
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 					    unsigned long ti_work)
 {
@@ -178,8 +184,7 @@ static unsigned long exit_to_user_mode_l
 		 */
 		local_irq_disable_exit_to_user();
 
-		/* Check if any of the above work has queued a deferred wakeup */
-		tick_nohz_user_enter_prepare();
+		exit_to_user_update_work();
 
 		ti_work = read_thread_flags();
 	}
@@ -194,8 +199,7 @@ static void exit_to_user_mode_prepare(st
 
 	lockdep_assert_irqs_disabled();
 
-	/* Flush pending rcuog wakeup before the last need_resched() check */
-	tick_nohz_user_enter_prepare();
+	exit_to_user_update_work();
 
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
 		ti_work = exit_to_user_mode_loop(regs, ti_work);
