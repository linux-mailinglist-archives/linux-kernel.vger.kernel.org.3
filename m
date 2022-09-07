Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56D05B0086
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiIGJb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiIGJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:31:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F90B6EF29;
        Wed,  7 Sep 2022 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zT7UOXIBjLCEJ5VBUdquxIoLhG3Q99iV2Ry3SdgK2r4=; b=eTctjCAlTASudbxIxAbP0BXI5D
        U8btcf0L2jXI2A03skBpEMmDDgM1a1YKmDjY8v0vhdDr1pt2+LHrMMFdZY1HMqoc6zF6KXhuWcTMf
        TKkwORktjTZ+hdWNC2rHa+lD/0MyIiUvnqsBjpWZBqFcVP+EkCYXb9kpz44aAWR3ruheR94m4GU5B
        vTy1gzY9ozyukNkT3X8z7dLFC2TFUjpcrb+eC+fwaBGPYTxHag/gVegfZxuww649AUhQM4K7hdLHB
        rRX5byG19bEr0mlElGKw8tkatejM1nltKgRCYrSNV7noSGWX1a08a6AFI05u8oGU+FFIUFr/x1bet
        8bqeaX9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVrOY-00APXe-7S; Wed, 07 Sep 2022 09:30:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE5EF30013F;
        Wed,  7 Sep 2022 11:30:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA6342B99BB11; Wed,  7 Sep 2022 11:30:53 +0200 (CEST)
Date:   Wed, 7 Sep 2022 11:30:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] sched: Change wait_task_inactive()s match_state
Message-ID: <YxhkzfuFTvRnpUaH@hirez.programming.kicks-ass.net>
References: <20220822111816.760285417@infradead.org>
 <20220822114648.856734578@infradead.org>
 <YxSBlPb/oZ6x0jfw@gmail.com>
 <Yxcm6oOTbmCbsHvj@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxcm6oOTbmCbsHvj@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 12:54:34PM +0200, Peter Zijlstra wrote:

> > Suggestion #3:
> > 
> > - Couldn't the following users with a 0 mask:
> > 
> >     drivers/powercap/idle_inject.c:         wait_task_inactive(iit->tsk, 0);
> >     fs/coredump.c:                  wait_task_inactive(ptr->task, 0);
> > 
> >   Use ~0 instead (exposed as TASK_ANY or so) and then we can drop the
> >   !match_state special case?
> > 
> >   They'd do something like:
> > 
> >     drivers/powercap/idle_inject.c:         wait_task_inactive(iit->tsk, TASK_ANY);
> >     fs/coredump.c:                  wait_task_inactive(ptr->task, TASK_ANY);
> > 
> >   It's not an entirely 100% equivalent transformation though, but looks OK 
> >   at first sight: ->__state will be some nonzero mask for genuine tasks 
> >   waiting to schedule out, so any match will be functionally the same as a 
> >   0 flag telling us not to check any of the bits, right? I might be missing 
> >   something though.
> 
> I too am thinking that should work. Added patch for that.

---
Subject: sched: Add TASK_ANY for wait_task_inactive()
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Sep 6 12:39:55 CEST 2022

Now that wait_task_inactive()'s @match_state argument is a mask (like
ttwu()) it is possible to replace the special !match_state case with
an 'all-states' value such that any blocked state will match.

Suggested-by: Ingo Molnar (mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/powercap/idle_inject.c |    2 +-
 fs/coredump.c                  |    2 +-
 include/linux/sched.h          |    2 ++
 kernel/sched/core.c            |   16 ++++++++--------
 4 files changed, 12 insertions(+), 10 deletions(-)

--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -254,7 +254,7 @@ void idle_inject_stop(struct idle_inject
 		iit = per_cpu_ptr(&idle_inject_thread, cpu);
 		iit->should_run = 0;
 
-		wait_task_inactive(iit->tsk, 0);
+		wait_task_inactive(iit->tsk, TASK_ANY);
 	}
 
 	cpu_hotplug_enable();
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -412,7 +412,7 @@ static int coredump_wait(int exit_code,
 		 */
 		ptr = core_state->dumper.next;
 		while (ptr != NULL) {
-			wait_task_inactive(ptr->task, 0);
+			wait_task_inactive(ptr->task, TASK_ANY);
 			ptr = ptr->next;
 		}
 	}
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -101,6 +101,8 @@ struct task_group;
 #define TASK_RTLOCK_WAIT		0x1000
 #define TASK_STATE_MAX			0x2000
 
+#define TASK_ANY			(TASK_STATE_MAX-1)
+
 /* Convenience macros for the sake of set_current_state: */
 #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
 #define TASK_STOPPED			(TASK_WAKEKILL | __TASK_STOPPED)
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3254,12 +3254,12 @@ int migrate_swap(struct task_struct *cur
 /*
  * wait_task_inactive - wait for a thread to unschedule.
  *
- * If @match_state is nonzero, it's the @p->state value just checked and
- * not expected to change.  If it changes, i.e. @p might have woken up,
- * then return zero.  When we succeed in waiting for @p to be off its CPU,
- * we return a positive number (its total switch count).  If a second call
- * a short while later returns the same number, the caller can be sure that
- * @p has remained unscheduled the whole time.
+ * Wait for the thread to block in any of the states set in @match_state.
+ * If it changes, i.e. @p might have woken up, then return zero.  When we
+ * succeed in waiting for @p to be off its CPU, we return a positive number
+ * (its total switch count).  If a second call a short while later returns the
+ * same number, the caller can be sure that @p has remained unscheduled the
+ * whole time.
  *
  * The caller must ensure that the task *will* unschedule sometime soon,
  * else this function might spin for a *long* time. This function can't
@@ -3295,7 +3295,7 @@ unsigned long wait_task_inactive(struct
 		 * is actually now running somewhere else!
 		 */
 		while (task_on_cpu(rq, p)) {
-			if (match_state && !(READ_ONCE(p->__state) & match_state))
+			if (!(READ_ONCE(p->__state) & match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -3310,7 +3310,7 @@ unsigned long wait_task_inactive(struct
 		running = task_on_cpu(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (!match_state || (READ_ONCE(p->__state) & match_state))
+		if (READ_ONCE(p->__state) & match_state)
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 
