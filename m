Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA3051B220
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379076AbiEDWpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379053AbiEDWpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:45:11 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012864B402;
        Wed,  4 May 2022 15:41:32 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:54266)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmNgZ-00EDQr-So; Wed, 04 May 2022 16:41:31 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37004 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmNgX-00GI0k-Nu; Wed, 04 May 2022 16:41:31 -0600
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
Date:   Wed,  4 May 2022 17:40:52 -0500
Message-Id: <20220504224058.476193-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
References: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmNgX-00GI0k-Nu;;;mid=<20220504224058.476193-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+4kRJLN6RAK8ubPgz/9sU4S3k8hjYXYS8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1508 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.8 (0.3%), b_tie_ro: 3.3 (0.2%), parse: 1.44
        (0.1%), extract_message_metadata: 12 (0.8%), get_uri_detail_list: 3.9
        (0.3%), tests_pri_-1000: 11 (0.7%), tests_pri_-950: 1.00 (0.1%),
        tests_pri_-900: 0.86 (0.1%), tests_pri_-90: 58 (3.8%), check_bayes: 56
        (3.7%), b_tokenize: 10 (0.7%), b_tok_get_all: 10 (0.6%), b_comp_prob:
        2.2 (0.1%), b_tok_touch_all: 32 (2.1%), b_finish: 0.76 (0.1%),
        tests_pri_0: 1407 (93.3%), check_dkim_signature: 0.70 (0.0%),
        check_dkim_adsp: 1.78 (0.1%), poll_dns_idle: 0.45 (0.0%),
        tests_pri_10: 1.76 (0.1%), tests_pri_500: 6 (0.4%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH v3 05/11] ptrace: Remove arch_ptrace_attach
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last remaining implementation of arch_ptrace_attach is ia64's
ptrace_attach_sync_user_rbs which was added at the end of 2007 in
commit aa91a2e90044 ("[IA64] Synchronize RBS on PTRACE_ATTACH").

Reading the comments and examining the code ptrace_attach_sync_user_rbs
has the sole purpose of saving registers to the stack when ptrace_attach
changes TASK_STOPPED to TASK_TRACED.  In all other cases arch_ptrace_stop
takes care of the register saving.

In commit d79fdd6d96f4 ("ptrace: Clean transitions between TASK_STOPPED and TRACED")
modified ptrace_attach to wake up the thread and enter ptrace_stop normally even
when the thread starts out stopped.

This makes ptrace_attach_sync_user_rbs completely unnecessary.  So just
remove it.

Cc: linux-ia64@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/ia64/include/asm/ptrace.h |  4 ---
 arch/ia64/kernel/ptrace.c      | 57 ----------------------------------
 kernel/ptrace.c                | 18 -----------
 3 files changed, 79 deletions(-)

diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
index a10a498eede1..402874489890 100644
--- a/arch/ia64/include/asm/ptrace.h
+++ b/arch/ia64/include/asm/ptrace.h
@@ -139,10 +139,6 @@ static inline long regs_return_value(struct pt_regs *regs)
   #define arch_ptrace_stop_needed() \
 	(!test_thread_flag(TIF_RESTORE_RSE))
 
-  extern void ptrace_attach_sync_user_rbs (struct task_struct *);
-  #define arch_ptrace_attach(child) \
-	ptrace_attach_sync_user_rbs(child)
-
   #define arch_has_single_step()  (1)
   #define arch_has_block_step()   (1)
 
diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index a19acd9f5e1f..a45f529046c3 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -617,63 +617,6 @@ void ia64_sync_krbs(void)
 	unw_init_running(do_sync_rbs, ia64_sync_kernel_rbs);
 }
 
-/*
- * After PTRACE_ATTACH, a thread's register backing store area in user
- * space is assumed to contain correct data whenever the thread is
- * stopped.  arch_ptrace_stop takes care of this on tracing stops.
- * But if the child was already stopped for job control when we attach
- * to it, then it might not ever get into ptrace_stop by the time we
- * want to examine the user memory containing the RBS.
- */
-void
-ptrace_attach_sync_user_rbs (struct task_struct *child)
-{
-	int stopped = 0;
-	struct unw_frame_info info;
-
-	/*
-	 * If the child is in TASK_STOPPED, we need to change that to
-	 * TASK_TRACED momentarily while we operate on it.  This ensures
-	 * that the child won't be woken up and return to user mode while
-	 * we are doing the sync.  (It can only be woken up for SIGKILL.)
-	 */
-
-	read_lock(&tasklist_lock);
-	if (child->sighand) {
-		spin_lock_irq(&child->sighand->siglock);
-		if (READ_ONCE(child->__state) == TASK_STOPPED &&
-		    !test_and_set_tsk_thread_flag(child, TIF_RESTORE_RSE)) {
-			set_notify_resume(child);
-
-			WRITE_ONCE(child->__state, TASK_TRACED);
-			stopped = 1;
-		}
-		spin_unlock_irq(&child->sighand->siglock);
-	}
-	read_unlock(&tasklist_lock);
-
-	if (!stopped)
-		return;
-
-	unw_init_from_blocked_task(&info, child);
-	do_sync_rbs(&info, ia64_sync_user_rbs);
-
-	/*
-	 * Now move the child back into TASK_STOPPED if it should be in a
-	 * job control stop, so that SIGCONT can be used to wake it up.
-	 */
-	read_lock(&tasklist_lock);
-	if (child->sighand) {
-		spin_lock_irq(&child->sighand->siglock);
-		if (READ_ONCE(child->__state) == TASK_TRACED &&
-		    (child->signal->flags & SIGNAL_STOP_STOPPED)) {
-			WRITE_ONCE(child->__state, TASK_STOPPED);
-		}
-		spin_unlock_irq(&child->sighand->siglock);
-	}
-	read_unlock(&tasklist_lock);
-}
-
 /*
  * Write f32-f127 back to task->thread.fph if it has been modified.
  */
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index ccc4b465775b..da30dcd477a0 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1285,10 +1285,6 @@ int ptrace_request(struct task_struct *child, long request,
 	return ret;
 }
 
-#ifndef arch_ptrace_attach
-#define arch_ptrace_attach(child)	do { } while (0)
-#endif
-
 SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 		unsigned long, data)
 {
@@ -1297,8 +1293,6 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 
 	if (request == PTRACE_TRACEME) {
 		ret = ptrace_traceme();
-		if (!ret)
-			arch_ptrace_attach(current);
 		goto out;
 	}
 
@@ -1310,12 +1304,6 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 
 	if (request == PTRACE_ATTACH || request == PTRACE_SEIZE) {
 		ret = ptrace_attach(child, request, addr, data);
-		/*
-		 * Some architectures need to do book-keeping after
-		 * a ptrace attach.
-		 */
-		if (!ret)
-			arch_ptrace_attach(child);
 		goto out_put_task_struct;
 	}
 
@@ -1455,12 +1443,6 @@ COMPAT_SYSCALL_DEFINE4(ptrace, compat_long_t, request, compat_long_t, pid,
 
 	if (request == PTRACE_ATTACH || request == PTRACE_SEIZE) {
 		ret = ptrace_attach(child, request, addr, data);
-		/*
-		 * Some architectures need to do book-keeping after
-		 * a ptrace attach.
-		 */
-		if (!ret)
-			arch_ptrace_attach(child);
 		goto out_put_task_struct;
 	}
 
-- 
2.35.3

