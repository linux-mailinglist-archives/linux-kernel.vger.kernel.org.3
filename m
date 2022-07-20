Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151A857BABB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241490AbiGTPot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiGTPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:44:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E6E65558
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:44:40 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658331878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1nCw/d8mMCerK6pUWZZkFfHHY0GZjcAjEhigenqTT4=;
        b=PyFHsyknRI8r9DGfID1BjToxl92n2S/IDowb7A0lSidydkrXfD8KEzEKvrfIPyoOiqFtnx
        TajbaIafyz6fhyYQLPBG4hu+qQQF0wFomKlaC9Uj1oe8zC4uZsw7fxvGrrT6xlQv/12Zk+
        /SkUZ2fIIA/tRZYmKc/o1ip/Qh+jV2EZP+hsGf2GaxFb8h/s3EJtWABiA1MWnF0l+YI/ix
        rtzcH1XGPPtVUu4nx8S1q4jQelyhX20Lyub2dw9Nppc3E4SKho5CGdsFNWYPGBnt3GLCcN
        1Mw9wT6bJ5guHmEp1XqrX/7sjhDJ0UaljRSsdCNBJYiVUdp+dt2gbwqg6ingQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658331878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1nCw/d8mMCerK6pUWZZkFfHHY0GZjcAjEhigenqTT4=;
        b=ALYdyqt5jVntiWP9qZ4vfQWyI+HlTubbGj9eGJn728aCLR+LYFVICRNmFiMUlo7KcS5KMt
        y7R2A26E/uV8ntDw==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] signal: Don't disable preemption in ptrace_stop() on PREEMPT_RT.
Date:   Wed, 20 Jul 2022 17:44:34 +0200
Message-Id: <20220720154435.232749-2-bigeasy@linutronix.de>
In-Reply-To: <20220720154435.232749-1-bigeasy@linutronix.de>
References: <20220720154435.232749-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit
   53da1d9456fe7 ("fix ptrace slowness")

is just band aid around the problem.
The invocation of do_notify_parent_cldstop() wakes the parent and makes
it runnable. The scheduler then wants to replace this still running task
with the parent. With the read_lock() acquired this is not possible
because preemption is disabled and so this is deferred until read_unlock().
This scheduling point is undesired and is avoided by disabling preemption
around the unlock operation enabled again before the schedule() invocation
without a preemption point.
This is only undesired because the parent sleeps a cycle in
wait_task_inactive() until the traced task leaves the run-queue in
schedule(). It is not a correctness issue, it is just band aid to avoid the
visbile delay which sums up over multiple invocations.
The task can still be preempted if an interrupt occurs between
preempt_enable_no_resched() and freezable_schedule() because on the IRQ-exit
path of the interrupt scheduling _will_ happen. This is ignored since it do=
es
not happen very often.

On PREEMPT_RT keeping preemption disabled during the invocation of
cgroup_enter_frozen() becomes a problem because the function acquires
css_set_lock which is a sleeping lock on PREEMPT_RT and must not be
acquired with disabled preemption.

Don't disable preemption on PREEMPT_RT. Remove the TODO regarding adding
read_unlock_no_resched() as there is no need for it and will cause harm.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/signal.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2297,13 +2297,13 @@ static int ptrace_stop(int exit_code, in
 	/*
 	 * Don't want to allow preemption here, because
 	 * sys_ptrace() needs this task to be inactive.
-	 *
-	 * XXX: implement read_unlock_no_resched().
 	 */
-	preempt_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 	read_unlock(&tasklist_lock);
 	cgroup_enter_frozen();
-	preempt_enable_no_resched();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable_no_resched();
 	freezable_schedule();
 	cgroup_leave_frozen(true);
=20
