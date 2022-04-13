Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B624FFE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbiDMTB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiDMTB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05069381B4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649876373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=401ZvCyDBE+XuNxUJ+2RUI38HkBE9VT4CA786JPfRK8=;
        b=F5v2SyjGF0ZbPZRARB86MMV2ruvlQwy3nnAVpMeLVsp5AMarbdTwIPZXahgRJkmAwjiDvs
        AwQbBHq6QoL4TwCceoHO7Ci45fwvHiZJxGhIL+pqnBIpW836apSuP9QtvrgegGR//0h1LB
        3hmKKEiNiOZXykjVS9IFmvtyoY7WhCM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-l-41ANkLMHiGLRPCji73_g-1; Wed, 13 Apr 2022 14:59:14 -0400
X-MC-Unique: l-41ANkLMHiGLRPCji73_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3748B185A7A4;
        Wed, 13 Apr 2022 18:59:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.129])
        by smtp.corp.redhat.com (Postfix) with SMTP id 539162166B4F;
        Wed, 13 Apr 2022 18:59:11 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 13 Apr 2022 20:59:13 +0200 (CEST)
Date:   Wed, 13 Apr 2022 20:59:10 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220413185909.GB30360@redhat.com>
References: <20220412114421.691372568@infradead.org>
 <20220412114853.842942162@infradead.org>
 <20220413132451.GA27281@redhat.com>
 <20220413185704.GA30360@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413185704.GA30360@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13, Oleg Nesterov wrote:
>
> On 04/13, Oleg Nesterov wrote:
> >
> > I like 1-2 but I need to read them (and other patches) again, a
> > couple of nits right now.
>
> Sorry, didn't have time to do this today, and now I am already sleeping.
>
> But... on a second thought, it seems there is a better solution. If nothing
> else it is simpler and doesn't duplicate the wait_task_inactive() logic.
>
> How about the patch below instead? On top of 1/5.
>
> Yes,yes, incomplete. in particular see the "!!!!!!!!!" comments. Just to
> explain the idea.

Cough. forget to attach the patch, sorry for noise.

Oleg.
---

diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
index ec8b312f7506..1b5a57048e13 100644
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -22,7 +22,8 @@ struct task_struct;
 
 #define JOBCTL_STOPPED_BIT	24
 #define JOBCTL_TRACED_BIT	25
-#define JOBCTL_TRACED_FROZEN_BIT 26
+#define JOBCTL_TRACED_XXX_BIT	25
+#define JOBCTL_TRACED_FROZEN_BIT 27
 
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
@@ -35,6 +36,7 @@ struct task_struct;
 
 #define JOBCTL_STOPPED		(1UL << JOBCTL_STOPPED_BIT)
 #define JOBCTL_TRACED		(1UL << JOBCTL_TRACED_BIT)
+#define JOBCTL_TRACED_XXX	(1UL << JOBCTL_TRACED_XXX_BIT)
 #define JOBCTL_TRACED_FROZEN	(1UL << JOBCTL_TRACED_FROZEN_BIT)
 
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 626f96d275c7..86b5226e6ba2 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -255,6 +255,19 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 {
 	int ret = -ESRCH;
 
+	if (!(child->ptrace && child->parent == current))
+		return ret;
+
+	if (ignore_state)
+		return 0;
+
+	if (wait_on_bit(&task->jobctl, JOBCTL_TRACED_XXX_BIT, TASK_KILLABLE))
+		return -EINTR;
+	// now that the tracee cleared JOBCTL_TRACED_XXX_BIT
+	// wait_task_inactive() should succeed or fail "really soon".
+	if (!wait_task_inactive(child, __TASK_TRACED))
+		return ret;
+
 	/*
 	 * We take the read lock around doing both checks to close a
 	 * possible race where someone else was tracing our child and
@@ -269,23 +282,11 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 		 * child->sighand can't be NULL, release_task()
 		 * does ptrace_unlink() before __exit_signal().
 		 */
-		if (ignore_state || ptrace_freeze_traced(child))
+		if (ptrace_freeze_traced(child))
 			ret = 0;
 	}
 	read_unlock(&tasklist_lock);
 
-	if (!ret && !ignore_state) {
-		if (!wait_task_inactive(child, __TASK_TRACED)) {
-			/*
-			 * This can only happen if may_ptrace_stop() fails and
-			 * ptrace_stop() changes ->state back to TASK_RUNNING,
-			 * so we should not worry about leaking __TASK_TRACED.
-			 */
-			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
-			ret = -ESRCH;
-		}
-	}
-
 	return ret;
 }
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 0aea3f0a8002..5ca6235e5231 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2220,7 +2220,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	 * schedule() will not sleep if there is a pending signal that
 	 * can awaken the task.
 	 */
-	current->jobctl |= JOBCTL_TRACED;
+	current->jobctl |= (JOBCTL_TRACED | JOBCTL_TRACED_XXX);
 	set_special_state(TASK_TRACED);
 
 	/*
@@ -2291,6 +2291,10 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 		preempt_disable();
 		read_unlock(&tasklist_lock);
 		cgroup_enter_frozen();
+		// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
+		// wrong, needs siglock
+		current->jobctl &= ~JOBCTL_TRACED_XXX;
+		wake_up_bit(&current->jobctl, ~JOBCTL_TRACED_XXX_BIT);
 		preempt_enable_no_resched();
 		freezable_schedule();
 		cgroup_leave_frozen(true);
@@ -2308,6 +2312,8 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 		if (gstop_done)
 			do_notify_parent_cldstop(current, false, why);
 
+		// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
+		// need to clear ~JOBCTL_TRACED_XXX
 		/* tasklist protects us from ptrace_freeze_traced() */
 		__set_current_state(TASK_RUNNING);
 		read_code = false;

