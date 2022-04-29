Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B4D5157E6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381269AbiD2WKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381167AbiD2WKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:10:44 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144B5DBD0E;
        Fri, 29 Apr 2022 15:07:25 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:55002)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYUT-00AIMf-B9; Fri, 29 Apr 2022 15:49:29 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36464 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYUS-007RIp-6h; Fri, 29 Apr 2022 15:49:28 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        tj@kernel.org, linux-pm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri, 29 Apr 2022 16:48:36 -0500
Message-Id: <20220429214837.386518-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nkYUS-007RIp-6h;;;mid=<20220429214837.386518-11-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18Rvz6pahoBBVqRiRjYubwQ90GavkWSLh0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 525 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.8 (0.9%), b_tie_ro: 3.3 (0.6%), parse: 1.35
        (0.3%), extract_message_metadata: 12 (2.2%), get_uri_detail_list: 3.3
        (0.6%), tests_pri_-1000: 11 (2.1%), tests_pri_-950: 0.98 (0.2%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 112 (21.4%), check_bayes:
        111 (21.1%), b_tokenize: 8 (1.6%), b_tok_get_all: 7 (1.3%),
        b_comp_prob: 2.1 (0.4%), b_tok_touch_all: 90 (17.2%), b_finish: 0.81
        (0.2%), tests_pri_0: 371 (70.7%), check_dkim_signature: 0.43 (0.1%),
        check_dkim_adsp: 1.76 (0.3%), poll_dns_idle: 0.45 (0.1%),
        tests_pri_10: 1.79 (0.3%), tests_pri_500: 6 (1.1%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH v2 11/12] ptrace: Always call schedule in ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop testing for !current->ptrace and setting __state to TASK_RUNNING.
The code in __ptrace_unlink wakes up the child with
ptrace_signal_wake_up which will set __state to TASK_RUNNING.  This
leaves the only thing ptrace_stop needs to do is to send the signals.

Make the signals sending conditional upon current->ptrace so that
the correct signals are sent to the parent.

After that call schedule and let the fact that __state == TASK_RUNNING
keep the code from sleeping in schedule.

Now that it is easy to see that ptrace_stop always sleeps in
ptrace_stop after ptrace_freeze_trace succeeds modify
ptrace_check_attach to warn if wait_task_inactive fails.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 14 +++-------
 kernel/signal.c | 68 ++++++++++++++++++-------------------------------
 2 files changed, 28 insertions(+), 54 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d80222251f60..c1afebd2e8f3 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -261,17 +261,9 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
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
+	if (!ret && !ignore_state &&
+	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
+		ret = -ESRCH;
 
 	return ret;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 7cb27a27290a..4cae3f47f664 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2255,51 +2255,33 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 
 	spin_unlock_irq(&current->sighand->siglock);
 	read_lock(&tasklist_lock);
-	if (likely(current->ptrace)) {
-		/*
-		 * Notify parents of the stop.
-		 *
-		 * While ptraced, there are two parents - the ptracer and
-		 * the real_parent of the group_leader.  The ptracer should
-		 * know about every stop while the real parent is only
-		 * interested in the completion of group stop.  The states
-		 * for the two don't interact with each other.  Notify
-		 * separately unless they're gonna be duplicates.
-		 */
+	/*
+	 * Notify parents of the stop.
+	 *
+	 * While ptraced, there are two parents - the ptracer and
+	 * the real_parent of the group_leader.  The ptracer should
+	 * know about every stop while the real parent is only
+	 * interested in the completion of group stop.  The states
+	 * for the two don't interact with each other.  Notify
+	 * separately unless they're gonna be duplicates.
+	 */
+	if (current->ptrace)
 		do_notify_parent_cldstop(current, true, why);
-		if (gstop_done && ptrace_reparented(current))
-			do_notify_parent_cldstop(current, false, why);
-
-		/*
-		 * Don't want to allow preemption here, because
-		 * sys_ptrace() needs this task to be inactive.
-		 *
-		 * XXX: implement read_unlock_no_resched().
-		 */
-		preempt_disable();
-		read_unlock(&tasklist_lock);
-		cgroup_enter_frozen();
-		preempt_enable_no_resched();
-		freezable_schedule();
-		cgroup_leave_frozen(true);
-	} else {
-		/*
-		 * By the time we got the lock, our tracer went away.
-		 * Don't drop the lock yet, another tracer may come.
-		 *
-		 * If @gstop_done, the ptracer went away between group stop
-		 * completion and here.  During detach, it would have set
-		 * JOBCTL_STOP_PENDING on us and we'll re-enter
-		 * TASK_STOPPED in do_signal_stop() on return, so notifying
-		 * the real parent of the group stop completion is enough.
-		 */
-		if (gstop_done)
-			do_notify_parent_cldstop(current, false, why);
+	if (gstop_done && (!current->ptrace || ptrace_reparented(current)))
+		do_notify_parent_cldstop(current, false, why);
 
-		/* tasklist protects us from ptrace_freeze_traced() */
-		__set_current_state(TASK_RUNNING);
-		read_unlock(&tasklist_lock);
-	}
+	/*
+	 * Don't want to allow preemption here, because
+	 * sys_ptrace() needs this task to be inactive.
+	 *
+	 * XXX: implement read_unlock_no_resched().
+	 */
+	preempt_disable();
+	read_unlock(&tasklist_lock);
+	cgroup_enter_frozen();
+	preempt_enable_no_resched();
+	freezable_schedule();
+	cgroup_leave_frozen(true);
 
 	/*
 	 * We are back.  Now reacquire the siglock before touching
-- 
2.35.3

