Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2851C7AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243004AbiEESh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384212AbiEEShG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:37:06 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E44D5E177;
        Thu,  5 May 2022 11:27:27 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:53338)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmgCE-004ZDo-6K; Thu, 05 May 2022 12:27:26 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37118 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmgCC-002BtP-VG; Thu, 05 May 2022 12:27:25 -0600
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
Date:   Thu,  5 May 2022 13:26:38 -0500
Message-Id: <20220505182645.497868-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmgCC-002BtP-VG;;;mid=<20220505182645.497868-5-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/Y91Z+k7ckI3FPQY9G7PbOZct7wt7eL6M=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=56 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 589 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.7%), b_tie_ro: 9 (1.5%), parse: 1.11 (0.2%),
         extract_message_metadata: 13 (2.2%), get_uri_detail_list: 2.8 (0.5%),
        tests_pri_-1000: 14 (2.4%), tests_pri_-950: 1.27 (0.2%),
        tests_pri_-900: 1.06 (0.2%), tests_pri_-90: 115 (19.6%), check_bayes:
        114 (19.3%), b_tokenize: 13 (2.2%), b_tok_get_all: 11 (1.9%),
        b_comp_prob: 3.0 (0.5%), b_tok_touch_all: 82 (14.0%), b_finish: 0.88
        (0.2%), tests_pri_0: 420 (71.3%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 3.0 (0.5%), poll_dns_idle: 1.16 (0.2%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 8 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v4 05/12] ptrace: Remove arch_ptrace_attach
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
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

