Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9BE510C42
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355957AbiDZW4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355931AbiDZW4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:56:11 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3374CD43;
        Tue, 26 Apr 2022 15:52:58 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:33968)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU3F-00FkCD-QZ; Tue, 26 Apr 2022 16:52:57 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35772 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU3E-006ASW-L9; Tue, 26 Apr 2022 16:52:57 -0600
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
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 26 Apr 2022 17:52:07 -0500
Message-Id: <20220426225211.308418-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1njU3E-006ASW-L9;;;mid=<20220426225211.308418-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19ApRYm2whcvnRl/iwUWilr3hK7QjBhNcc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 532 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.1%), b_tie_ro: 10 (1.9%), parse: 1.35
        (0.3%), extract_message_metadata: 14 (2.6%), get_uri_detail_list: 3.1
        (0.6%), tests_pri_-1000: 14 (2.6%), tests_pri_-950: 1.24 (0.2%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 95 (17.9%), check_bayes:
        94 (17.6%), b_tokenize: 11 (2.1%), b_tok_get_all: 10 (1.9%),
        b_comp_prob: 2.8 (0.5%), b_tok_touch_all: 66 (12.4%), b_finish: 0.92
        (0.2%), tests_pri_0: 382 (71.7%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 2.9 (0.5%), poll_dns_idle: 1.14 (0.2%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 5/9] signal: Protect parent child relationships by childs siglock
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions ptrace_stop and do_signal_stop have to drop siglock
and grab tasklist_lock because the parent/child relation ship
is guarded by siglock and not siglock.

Simplify things by guarding the parent/child relationship
with siglock.  For the most part this just requires a little bit
of code motion.  In a couple of places more locking was needed.

After this change tsk->parent, tsk->real_parent, tsk->ptrace tsk->ptracer_cred
are all protected by tsk->siglock.

The fields tsk->sibling and tsk->ptrace_entry are mostly protected by
tsk->siglock.  The field tsk->ptrace_entry is not protected by siglock
when tsk->ptrace_entry is reused as the dead task list.  The field
tsk->sibling is not protected by siglock when children are reparented
because their original parent dies.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c   |  4 ++++
 kernel/fork.c   | 12 ++++++------
 kernel/ptrace.c | 13 +++++++++----
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index f072959fcab7..b07af19eca13 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -643,11 +643,15 @@ static void forget_original_parent(struct task_struct *father,
 
 	reaper = find_new_reaper(father, reaper);
 	list_for_each_entry(p, &father->children, sibling) {
+		spin_lock(&p->sighand->siglock);
 		for_each_thread(p, t) {
 			RCU_INIT_POINTER(t->real_parent, reaper);
 			BUG_ON((!t->ptrace) != (rcu_access_pointer(t->parent) == father));
 			if (likely(!t->ptrace))
 				t->parent = t->real_parent;
+		}
+		spin_unlock(&p->sighand->siglock);
+		for_each_thread(p, t) {
 			if (t->pdeath_signal)
 				group_send_sig_info(t->pdeath_signal,
 						    SEND_SIG_NOINFO, t,
diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897560ab..841021da69f3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2367,6 +2367,12 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	write_lock_irq(&tasklist_lock);
 
+	klp_copy_process(p);
+
+	sched_core_fork(p);
+
+	spin_lock(&current->sighand->siglock);
+
 	/* CLONE_PARENT re-uses the old parent */
 	if (clone_flags & (CLONE_PARENT|CLONE_THREAD)) {
 		p->real_parent = current->real_parent;
@@ -2381,12 +2387,6 @@ static __latent_entropy struct task_struct *copy_process(
 		p->exit_signal = args->exit_signal;
 	}
 
-	klp_copy_process(p);
-
-	sched_core_fork(p);
-
-	spin_lock(&current->sighand->siglock);
-
 	/*
 	 * Copy seccomp details explicitly here, in case they were changed
 	 * before holding sighand lock.
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index ccc4b465775b..16d1a84a2cae 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -123,13 +123,12 @@ void __ptrace_unlink(struct task_struct *child)
 	clear_task_syscall_work(child, SYSCALL_EMU);
 #endif
 
+	spin_lock(&child->sighand->siglock);
 	child->parent = child->real_parent;
 	list_del_init(&child->ptrace_entry);
 	old_cred = child->ptracer_cred;
 	child->ptracer_cred = NULL;
 	put_cred(old_cred);
-
-	spin_lock(&child->sighand->siglock);
 	child->ptrace = 0;
 	/*
 	 * Clear all pending traps and TRAPPING.  TRAPPING should be
@@ -447,15 +446,15 @@ static int ptrace_attach(struct task_struct *task, long request,
 	if (task->ptrace)
 		goto unlock_tasklist;
 
+	spin_lock(&task->sighand->siglock);
 	task->ptrace = flags;
 
 	ptrace_link(task, current);
 
 	/* SEIZE doesn't trap tracee on attach */
 	if (!seize)
-		send_sig_info(SIGSTOP, SEND_SIG_PRIV, task);
+		send_signal_locked(SIGSTOP, SEND_SIG_PRIV, task, PIDTYPE_PID);
 
-	spin_lock(&task->sighand->siglock);
 
 	/*
 	 * If the task is already STOPPED, set JOBCTL_TRAP_STOP and
@@ -521,8 +520,10 @@ static int ptrace_traceme(void)
 		 * pretend ->real_parent untraces us right after return.
 		 */
 		if (!ret && !(current->real_parent->flags & PF_EXITING)) {
+			spin_lock(&current->sighand->siglock);
 			current->ptrace = PT_PTRACED;
 			ptrace_link(current, current->real_parent);
+			spin_unlock(&current->sighand->siglock);
 		}
 	}
 	write_unlock_irq(&tasklist_lock);
@@ -689,10 +690,14 @@ static int ptrace_setoptions(struct task_struct *child, unsigned long data)
 		return ret;
 
 	/* Avoid intermediate state when all opts are cleared */
+	write_lock_irq(&tasklist_lock);
+	spin_lock(&child->sighand->siglock);
 	flags = child->ptrace;
 	flags &= ~(PTRACE_O_MASK << PT_OPT_FLAG_SHIFT);
 	flags |= (data << PT_OPT_FLAG_SHIFT);
 	child->ptrace = flags;
+	spin_unlock(&child->sighand->siglock);
+	write_unlock_irq(&tasklist_lock);
 
 	return 0;
 }
-- 
2.35.3

