Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE06052C737
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 01:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiERW4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiERWzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:55:53 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D3822EA56;
        Wed, 18 May 2022 15:55:19 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:55588)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZZ-003bgl-Vq; Wed, 18 May 2022 16:55:18 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZY-002Z0O-My; Wed, 18 May 2022 16:55:17 -0600
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
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed, 18 May 2022 17:53:53 -0500
Message-Id: <20220518225355.784371-14-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSZY-002Z0O-My;;;mid=<20220518225355.784371-14-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19FLqwrnq1bvGioZrorhislxB7aEEARHFA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ******;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 637 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (1.8%), b_tie_ro: 10 (1.5%), parse: 1.19
        (0.2%), extract_message_metadata: 12 (1.9%), get_uri_detail_list: 2.2
        (0.3%), tests_pri_-1000: 18 (2.9%), tests_pri_-950: 1.28 (0.2%),
        tests_pri_-900: 1.05 (0.2%), tests_pri_-90: 156 (24.5%), check_bayes:
        155 (24.3%), b_tokenize: 13 (2.1%), b_tok_get_all: 12 (1.9%),
        b_comp_prob: 3.3 (0.5%), b_tok_touch_all: 121 (19.0%), b_finish: 1.03
        (0.2%), tests_pri_0: 416 (65.3%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 2.9 (0.5%), poll_dns_idle: 0.94 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 14 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 14/16] signal: Protect parent child relationships by childs siglock
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions ptrace_stop and do_signal_stop have to drop siglock
and grab tasklist_lock because the parent/child relation ship
is guarded by tasklist_lock and not siglock.

Simplify things by additionally guarding the parent/child relationship
with siglock.  This just requires a little bit of code motion.

After this change tsk->parent, tsk->real_parent, tsk->ptracer_cred
are all protected by tsk->siglock.

The fields tsk->sibling and tsk->ptrace_entry are mostly protected by
tsk->siglock.  The field tsk->ptrace_entry is not protected by siglock
when tsk->ptrace_entry is reused as the dead task list.  The field
tsk->sibling is not protected by siglock when children are reparented
because their original parent dies.

The field tsk->ptrace is protected by siglock except for the options
which may change without siglock being held.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c   |  4 ++++
 kernel/fork.c   | 12 ++++++------
 kernel/ptrace.c |  9 +++++----
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 0e26f73c49ac..bad434b23c48 100644
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
index fbadd2f21f09..77dfdb3d1ced 100644
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
@@ -441,15 +440,15 @@ static int ptrace_attach(struct task_struct *task, long request,
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
@@ -517,8 +516,10 @@ static int ptrace_traceme(void)
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
-- 
2.35.3

