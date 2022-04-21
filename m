Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B099050A9B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392196AbiDUUKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiDUUK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:10:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8034C78E;
        Thu, 21 Apr 2022 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NdfLnn05R7fjDEiBPK6Cu9YpjR96BrxFTg+OBZR4cMU=; b=VyGfhH7nwhulIRPAAYz6O2eC8T
        zomZ21Q665Y4fWYko1XBovWfs9G4rmXmxxIZu4wEanYOz1XKrfB2oGdCI9VIOy6oo+L7ORTzJp34l
        LGL6IDsUPq/5oW57AJ+anM0/G4541Z68t/kWkroeXOPmj+dFAYQgQIXEXb6CDwu9B3BbpSG41ydCb
        BJcf5m6JxtR9xG+bZCAyAzeja81a7itfYyQPT6MEXwNTdqEB4vm6YZkC/fTd/6Jz6jafIY3ZHjr+Q
        1wXZSNVItxlWTOvwNjrUG8IcrkVP+NaNOXUnRmbPUnnGnD0uEyK79SbZz86oPKxO2tYv8Co2rT7Fd
        JfsJfM3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhd5F-007VjJ-T1; Thu, 21 Apr 2022 20:07:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68CB79861C1; Thu, 21 Apr 2022 22:07:21 +0200 (CEST)
Date:   Thu, 21 Apr 2022 22:07:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] freezer,sched: Rewrite core freezer logic
Message-ID: <20220421200721.GF2762@worktop.programming.kicks-ass.net>
References: <20220421150248.667412396@infradead.org>
 <20220421150655.001952823@infradead.org>
 <878rrys5yj.fsf@email.froward.int.ebiederm.org>
 <20220421195551.GO2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421195551.GO2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 09:55:51PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 21, 2022 at 12:26:44PM -0500, Eric W. Biederman wrote:
> > Peter Zijlstra <peterz@infradead.org> writes:
> > 
> > > --- a/kernel/ptrace.c
> > > +++ b/kernel/ptrace.c
> > > @@ -288,7 +288,7 @@ static int ptrace_check_attach(struct ta
> > >  	}
> > >  	__set_current_state(TASK_RUNNING);
> > >  
> > > -	if (!wait_task_inactive(child, TASK_TRACED) ||
> > > +	if (!wait_task_inactive(child, TASK_TRACED|TASK_FREEZABLE) ||
> > >  	    !ptrace_freeze_traced(child))
> > >  		return -ESRCH;
> > 
> > Do we mind that this is going to fail if the child is frozen
> > during ptrace_check_attach?
> 
> Why should this fail? wait_task_inactive() will in fact succeed if it is
> frozen due to the added TASK_FREEZABLE and some wait_task_inactive()
> changes elsewhere in this patch.

These:

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3260,6 +3260,19 @@ int migrate_swap(struct task_struct *cur
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
+static inline bool __wti_match(struct task_struct *p, unsigned int match_state)
+{
+	unsigned int state = READ_ONCE(p->__state);
+
+	if ((match_state & TASK_FREEZABLE) && state == TASK_FROZEN)
+		return true;
+
+	if (state == (match_state & ~TASK_FREEZABLE))
+		return true;
+
+	return false;
+}
+
 /*
  * wait_task_inactive - wait for a thread to unschedule.
  *
@@ -3304,7 +3317,7 @@ unsigned long wait_task_inactive(struct
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
+			if (match_state && !__wti_match(p, match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -3319,7 +3332,7 @@ unsigned long wait_task_inactive(struct
 		running = task_running(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (!match_state || READ_ONCE(p->__state) == match_state)
+		if (!match_state || __wti_match(p, match_state))
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 


> And I don't see why ptrace_freeze_traced() should fail. It'll warn
> though, I should extend/remove that WARN_ON_ONCE() looking at __state,
> but it should work.

And that looks like (after removal of the one WARN):

static bool ptrace_freeze_traced(struct task_struct *task)
{
	unsigned long flags;
	bool ret = false;

	/* Lockless, nobody but us can set this flag */
	if (task->jobctl & JOBCTL_LISTENING)
		return ret;

	if (!lock_task_sighand(task, &flags))
		return ret;

	if (task_is_traced(task) &&
	    !looks_like_a_spurious_pid(task) &&
	    !__fatal_signal_pending(task)) {
		WARN_ON_ONCE(task->jobctl & JOBCTL_DELAY_WAKEKILL);
		task->jobctl |= JOBCTL_DELAY_WAKEKILL;
		ret = true;
	}
	unlock_task_sighand(task, &flags);

	return ret;
}

And nothing there cares about ->__state.
