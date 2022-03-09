Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989364D35B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiCIQor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238071AbiCIQbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:21 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21927192E0C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:25:35 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:33334)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz7y-00328U-41; Wed, 09 Mar 2022 09:25:30 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz7v-005hAS-8B; Wed, 09 Mar 2022 09:25:29 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:44 -0600
Message-Id: <20220309162454.123006-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz7v-005hAS-8B;;;mid=<20220309162454.123006-3-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/sDzBTHW67M6UEaK95g0wgs6B99Iz0Cd0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 2140 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (0.5%), b_tie_ro: 9 (0.4%), parse: 3.8 (0.2%),
        extract_message_metadata: 40 (1.9%), get_uri_detail_list: 24 (1.1%),
        tests_pri_-1000: 15 (0.7%), tests_pri_-950: 1.27 (0.1%),
        tests_pri_-900: 1.06 (0.0%), tests_pri_-90: 338 (15.8%), check_bayes:
        336 (15.7%), b_tokenize: 52 (2.4%), b_tok_get_all: 21 (1.0%),
        b_comp_prob: 5 (0.2%), b_tok_touch_all: 252 (11.8%), b_finish: 1.02
        (0.0%), tests_pri_0: 1710 (79.9%), check_dkim_signature: 1.14 (0.1%),
        check_dkim_adsp: 2.8 (0.1%), poll_dns_idle: 0.86 (0.0%), tests_pri_10:
        2.5 (0.1%), tests_pri_500: 10 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 03/13] ptrace: Create ptrace_report_syscall_{entry,exit} in ptrace.h
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename tracehook_report_syscall_{entry,exit} to
ptrace_report_syscall_{entry,exit} and place them in ptrace.h

There is no longer any generic tracehook infractructure so make
these ptrace specific functions ptrace specific.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/Kconfig                        |  2 +-
 arch/alpha/kernel/ptrace.c          |  5 ++-
 arch/arc/kernel/ptrace.c            |  5 ++-
 arch/arm/kernel/ptrace.c            |  5 ++-
 arch/arm64/kernel/ptrace.c          |  7 ++--
 arch/csky/kernel/ptrace.c           |  5 ++-
 arch/h8300/kernel/ptrace.c          |  5 ++-
 arch/hexagon/kernel/traps.c         |  6 ++--
 arch/ia64/kernel/ptrace.c           |  4 +--
 arch/m68k/kernel/ptrace.c           |  6 ++--
 arch/microblaze/kernel/ptrace.c     |  5 ++-
 arch/mips/kernel/ptrace.c           |  5 ++-
 arch/nds32/include/asm/syscall.h    |  2 +-
 arch/nds32/kernel/ptrace.c          |  5 ++-
 arch/nios2/kernel/ptrace.c          |  5 ++-
 arch/openrisc/kernel/ptrace.c       |  5 ++-
 arch/parisc/kernel/ptrace.c         |  7 ++--
 arch/powerpc/kernel/ptrace/ptrace.c |  8 ++---
 arch/riscv/kernel/ptrace.c          |  5 ++-
 arch/sh/kernel/ptrace_32.c          |  5 ++-
 arch/sparc/kernel/ptrace_32.c       |  5 ++-
 arch/sparc/kernel/ptrace_64.c       |  5 ++-
 arch/um/kernel/ptrace.c             |  5 ++-
 arch/xtensa/kernel/ptrace.c         |  5 ++-
 include/asm-generic/syscall.h       |  2 +-
 include/linux/entry-common.h        |  6 ++--
 include/linux/ptrace.h              | 51 +++++++++++++++++++++++++++++
 include/linux/tracehook.h           | 51 -----------------------------
 include/uapi/linux/ptrace.h         |  2 +-
 kernel/entry/common.c               |  1 +
 30 files changed, 109 insertions(+), 126 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 678a80713b21..a517a949eb1d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -217,7 +217,7 @@ config TRACE_IRQFLAGS_SUPPORT
 #	asm/syscall.h		supplying asm-generic/syscall.h interface
 #	linux/regset.h		user_regset interfaces
 #	CORE_DUMP_USE_REGSET	#define'd in linux/elf.h
-#	TIF_SYSCALL_TRACE	calls tracehook_report_syscall_{entry,exit}
+#	TIF_SYSCALL_TRACE	calls ptrace_report_syscall_{entry,exit}
 #	TIF_NOTIFY_RESUME	calls tracehook_notify_resume()
 #	signal delivery		calls tracehook_signal_handler()
 #
diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index 8c43212ae38e..a1a239ea002d 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -15,7 +15,6 @@
 #include <linux/user.h>
 #include <linux/security.h>
 #include <linux/signal.h>
-#include <linux/tracehook.h>
 #include <linux/audit.h>
 
 #include <linux/uaccess.h>
@@ -323,7 +322,7 @@ asmlinkage unsigned long syscall_trace_enter(void)
 	unsigned long ret = 0;
 	struct pt_regs *regs = current_pt_regs();
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(current_pt_regs()))
+	    ptrace_report_syscall_entry(current_pt_regs()))
 		ret = -1UL;
 	audit_syscall_entry(regs->r0, regs->r16, regs->r17, regs->r18, regs->r19);
 	return ret ?: current_pt_regs()->r0;
@@ -334,5 +333,5 @@ syscall_trace_leave(void)
 {
 	audit_syscall_exit(current_pt_regs());
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(current_pt_regs(), 0);
+		ptrace_report_syscall_exit(current_pt_regs(), 0);
 }
diff --git a/arch/arc/kernel/ptrace.c b/arch/arc/kernel/ptrace.c
index 883391977fdf..54b419ac8bda 100644
--- a/arch/arc/kernel/ptrace.c
+++ b/arch/arc/kernel/ptrace.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/ptrace.h>
-#include <linux/tracehook.h>
 #include <linux/sched/task_stack.h>
 #include <linux/regset.h>
 #include <linux/unistd.h>
@@ -258,7 +257,7 @@ long arch_ptrace(struct task_struct *child, long request,
 
 asmlinkage int syscall_trace_entry(struct pt_regs *regs)
 {
-	if (tracehook_report_syscall_entry(regs))
+	if (ptrace_report_syscall_entry(regs))
 		return ULONG_MAX;
 
 	return regs->r8;
@@ -266,5 +265,5 @@ asmlinkage int syscall_trace_entry(struct pt_regs *regs)
 
 asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 {
-	tracehook_report_syscall_exit(regs, 0);
+	ptrace_report_syscall_exit(regs, 0);
 }
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index e5aa3237853d..bfe88c6e60d5 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -22,7 +22,6 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/regset.h>
 #include <linux/audit.h>
-#include <linux/tracehook.h>
 #include <linux/unistd.h>
 
 #include <asm/syscall.h>
@@ -843,8 +842,8 @@ static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
 	regs->ARM_ip = dir;
 
 	if (dir == PTRACE_SYSCALL_EXIT)
-		tracehook_report_syscall_exit(regs, 0);
-	else if (tracehook_report_syscall_entry(regs))
+		ptrace_report_syscall_exit(regs, 0);
+	else if (ptrace_report_syscall_entry(regs))
 		current_thread_info()->abi_syscall = -1;
 
 	regs->ARM_ip = ip;
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index b7845575f86f..230a47b9189e 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -27,7 +27,6 @@
 #include <linux/perf_event.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/regset.h>
-#include <linux/tracehook.h>
 #include <linux/elf.h>
 
 #include <asm/compat.h>
@@ -1818,11 +1817,11 @@ static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
 	regs->regs[regno] = dir;
 
 	if (dir == PTRACE_SYSCALL_ENTER) {
-		if (tracehook_report_syscall_entry(regs))
+		if (ptrace_report_syscall_entry(regs))
 			forget_syscall(regs);
 		regs->regs[regno] = saved_reg;
 	} else if (!test_thread_flag(TIF_SINGLESTEP)) {
-		tracehook_report_syscall_exit(regs, 0);
+		ptrace_report_syscall_exit(regs, 0);
 		regs->regs[regno] = saved_reg;
 	} else {
 		regs->regs[regno] = saved_reg;
@@ -1832,7 +1831,7 @@ static void report_syscall(struct pt_regs *regs, enum ptrace_syscall_dir dir)
 		 * tracer modifications to the registers may have rewound the
 		 * state machine.
 		 */
-		tracehook_report_syscall_exit(regs, 1);
+		ptrace_report_syscall_exit(regs, 1);
 	}
 }
 
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 1a5f54e0d272..0f7e7b653c72 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -12,7 +12,6 @@
 #include <linux/sched/task_stack.h>
 #include <linux/signal.h>
 #include <linux/smp.h>
-#include <linux/tracehook.h>
 #include <linux/uaccess.h>
 #include <linux/user.h>
 
@@ -321,7 +320,7 @@ long arch_ptrace(struct task_struct *child, long request,
 asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		if (tracehook_report_syscall_entry(regs))
+		if (ptrace_report_syscall_entry(regs))
 			return -1;
 
 	if (secure_computing() == -1)
@@ -339,7 +338,7 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 	audit_syscall_exit(regs);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, 0);
+		ptrace_report_syscall_exit(regs, 0);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
diff --git a/arch/h8300/kernel/ptrace.c b/arch/h8300/kernel/ptrace.c
index a11db009d0ea..a9898b27b756 100644
--- a/arch/h8300/kernel/ptrace.c
+++ b/arch/h8300/kernel/ptrace.c
@@ -12,7 +12,6 @@
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/audit.h>
-#include <linux/tracehook.h>
 #include <linux/regset.h>
 #include <linux/elf.h>
 
@@ -174,7 +173,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	long ret = 0;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
+	    ptrace_report_syscall_entry(regs))
 		/*
 		 * Tracing decided this syscall should not happen.
 		 * We'll return a bogus call number to get an ENOSYS
@@ -196,5 +195,5 @@ asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
 
 	step = test_thread_flag(TIF_SINGLESTEP);
 	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, step);
+		ptrace_report_syscall_exit(regs, step);
 }
diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
index 1240f038cce0..6447763ce5a9 100644
--- a/arch/hexagon/kernel/traps.c
+++ b/arch/hexagon/kernel/traps.c
@@ -14,7 +14,7 @@
 #include <linux/kdebug.h>
 #include <linux/syscalls.h>
 #include <linux/signal.h>
-#include <linux/tracehook.h>
+#include <linux/ptrace.h>
 #include <asm/traps.h>
 #include <asm/vm_fault.h>
 #include <asm/syscall.h>
@@ -348,7 +348,7 @@ void do_trap0(struct pt_regs *regs)
 
 		/* allow strace to catch syscall args  */
 		if (unlikely(test_thread_flag(TIF_SYSCALL_TRACE) &&
-			tracehook_report_syscall_entry(regs)))
+			ptrace_report_syscall_entry(regs)))
 			return;  /*  return -ENOSYS somewhere?  */
 
 		/* Interrupts should be re-enabled for syscall processing */
@@ -386,7 +386,7 @@ void do_trap0(struct pt_regs *regs)
 
 		/* allow strace to get the syscall return state  */
 		if (unlikely(test_thread_flag(TIF_SYSCALL_TRACE)))
-			tracehook_report_syscall_exit(regs, 0);
+			ptrace_report_syscall_exit(regs, 0);
 
 		break;
 	case TRAP_DEBUG:
diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index 6a1439eaa050..6af64aae087d 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -1217,7 +1217,7 @@ syscall_trace_enter (long arg0, long arg1, long arg2, long arg3,
 		     struct pt_regs regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		if (tracehook_report_syscall_entry(&regs))
+		if (ptrace_report_syscall_entry(&regs))
 			return -ENOSYS;
 
 	/* copy user rbs to kernel rbs */
@@ -1243,7 +1243,7 @@ syscall_trace_leave (long arg0, long arg1, long arg2, long arg3,
 
 	step = test_thread_flag(TIF_SINGLESTEP);
 	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(&regs, step);
+		ptrace_report_syscall_exit(&regs, step);
 
 	/* copy user rbs to kernel rbs */
 	if (test_thread_flag(TIF_RESTORE_RSE))
diff --git a/arch/m68k/kernel/ptrace.c b/arch/m68k/kernel/ptrace.c
index aa3a0b8d07e9..a0c99fe3118e 100644
--- a/arch/m68k/kernel/ptrace.c
+++ b/arch/m68k/kernel/ptrace.c
@@ -19,7 +19,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/signal.h>
-#include <linux/tracehook.h>
+#include <linux/ptrace.h>
 
 #include <linux/uaccess.h>
 #include <asm/page.h>
@@ -282,13 +282,13 @@ asmlinkage int syscall_trace_enter(void)
 	int ret = 0;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		ret = tracehook_report_syscall_entry(task_pt_regs(current));
+		ret = ptrace_report_syscall_entry(task_pt_regs(current));
 	return ret;
 }
 
 asmlinkage void syscall_trace_leave(void)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(task_pt_regs(current), 0);
+		ptrace_report_syscall_exit(task_pt_regs(current), 0);
 }
 #endif /* CONFIG_COLDFIRE */
diff --git a/arch/microblaze/kernel/ptrace.c b/arch/microblaze/kernel/ptrace.c
index badd286882ae..5234d0c1dcaa 100644
--- a/arch/microblaze/kernel/ptrace.c
+++ b/arch/microblaze/kernel/ptrace.c
@@ -33,7 +33,6 @@
 #include <linux/elf.h>
 #include <linux/audit.h>
 #include <linux/seccomp.h>
-#include <linux/tracehook.h>
 
 #include <linux/errno.h>
 #include <asm/processor.h>
@@ -140,7 +139,7 @@ asmlinkage unsigned long do_syscall_trace_enter(struct pt_regs *regs)
 	secure_computing_strict(regs->r12);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
+	    ptrace_report_syscall_entry(regs))
 		/*
 		 * Tracing decided this syscall should not happen.
 		 * We'll return a bogus call number to get an ENOSYS
@@ -161,7 +160,7 @@ asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
 
 	step = test_thread_flag(TIF_SINGLESTEP);
 	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, step);
+		ptrace_report_syscall_exit(regs, step);
 }
 
 void ptrace_disable(struct task_struct *child)
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index db7c5be1d4a3..567aec4abac0 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -27,7 +27,6 @@
 #include <linux/smp.h>
 #include <linux/security.h>
 #include <linux/stddef.h>
-#include <linux/tracehook.h>
 #include <linux/audit.h>
 #include <linux/seccomp.h>
 #include <linux/ftrace.h>
@@ -1317,7 +1316,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs, long syscall)
 	current_thread_info()->syscall = syscall;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
-		if (tracehook_report_syscall_entry(regs))
+		if (ptrace_report_syscall_entry(regs))
 			return -1;
 		syscall = current_thread_info()->syscall;
 	}
@@ -1376,7 +1375,7 @@ asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 		trace_sys_exit(regs, regs_return_value(regs));
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, 0);
+		ptrace_report_syscall_exit(regs, 0);
 
 	user_enter();
 }
diff --git a/arch/nds32/include/asm/syscall.h b/arch/nds32/include/asm/syscall.h
index 90aa56c94af1..04d55ce18d50 100644
--- a/arch/nds32/include/asm/syscall.h
+++ b/arch/nds32/include/asm/syscall.h
@@ -39,7 +39,7 @@ syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
  *
  * It's only valid to call this when @task is stopped for system
  * call exit tracing (due to TIF_SYSCALL_TRACE or TIF_SYSCALL_AUDIT),
- * after tracehook_report_syscall_entry() returned nonzero to prevent
+ * after ptrace_report_syscall_entry() returned nonzero to prevent
  * the system call from taking place.
  *
  * This rolls back the register state in @regs so it's as if the
diff --git a/arch/nds32/kernel/ptrace.c b/arch/nds32/kernel/ptrace.c
index d0eda870fbc2..6a6988cf689d 100644
--- a/arch/nds32/kernel/ptrace.c
+++ b/arch/nds32/kernel/ptrace.c
@@ -3,7 +3,6 @@
 
 #include <linux/ptrace.h>
 #include <linux/regset.h>
-#include <linux/tracehook.h>
 #include <linux/elf.h>
 #include <linux/sched/task_stack.h>
 
@@ -103,7 +102,7 @@ void user_disable_single_step(struct task_struct *child)
 asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
-		if (tracehook_report_syscall_entry(regs))
+		if (ptrace_report_syscall_entry(regs))
 			forget_syscall(regs);
 	}
 	return regs->syscallno;
@@ -113,6 +112,6 @@ asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 {
 	int step = test_thread_flag(TIF_SINGLESTEP);
 	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, step);
+		ptrace_report_syscall_exit(regs, step);
 
 }
diff --git a/arch/nios2/kernel/ptrace.c b/arch/nios2/kernel/ptrace.c
index a6ea9e1b4f61..cd62f310778b 100644
--- a/arch/nios2/kernel/ptrace.c
+++ b/arch/nios2/kernel/ptrace.c
@@ -15,7 +15,6 @@
 #include <linux/regset.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
-#include <linux/tracehook.h>
 #include <linux/uaccess.h>
 #include <linux/user.h>
 
@@ -134,7 +133,7 @@ asmlinkage int do_syscall_trace_enter(void)
 	int ret = 0;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		ret = tracehook_report_syscall_entry(task_pt_regs(current));
+		ret = ptrace_report_syscall_entry(task_pt_regs(current));
 
 	return ret;
 }
@@ -142,5 +141,5 @@ asmlinkage int do_syscall_trace_enter(void)
 asmlinkage void do_syscall_trace_exit(void)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(task_pt_regs(current), 0);
+		ptrace_report_syscall_exit(task_pt_regs(current), 0);
 }
diff --git a/arch/openrisc/kernel/ptrace.c b/arch/openrisc/kernel/ptrace.c
index 4d60ae2a12fa..b971740fc2aa 100644
--- a/arch/openrisc/kernel/ptrace.c
+++ b/arch/openrisc/kernel/ptrace.c
@@ -22,7 +22,6 @@
 #include <linux/ptrace.h>
 #include <linux/audit.h>
 #include <linux/regset.h>
-#include <linux/tracehook.h>
 #include <linux/elf.h>
 
 #include <asm/thread_info.h>
@@ -159,7 +158,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 	long ret = 0;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs))
+	    ptrace_report_syscall_entry(regs))
 		/*
 		 * Tracing decided this syscall should not happen.
 		 * We'll return a bogus call number to get an ENOSYS
@@ -181,5 +180,5 @@ asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
 
 	step = test_thread_flag(TIF_SINGLESTEP);
 	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, step);
+		ptrace_report_syscall_exit(regs, step);
 }
diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 65de6c4c9354..96ef6a6b66e5 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -15,7 +15,6 @@
 #include <linux/elf.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
-#include <linux/tracehook.h>
 #include <linux/user.h>
 #include <linux/personality.h>
 #include <linux/regset.h>
@@ -316,7 +315,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
-		int rc = tracehook_report_syscall_entry(regs);
+		int rc = ptrace_report_syscall_entry(regs);
 
 		/*
 		 * As tracesys_next does not set %r28 to -ENOSYS
@@ -327,7 +326,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 		if (rc) {
 			/*
 			 * A nonzero return code from
-			 * tracehook_report_syscall_entry() tells us
+			 * ptrace_report_syscall_entry() tells us
 			 * to prevent the syscall execution.  Skip
 			 * the syscall call and the syscall restart handling.
 			 *
@@ -381,7 +380,7 @@ void do_syscall_trace_exit(struct pt_regs *regs)
 #endif
 
 	if (stepping || test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, stepping);
+		ptrace_report_syscall_exit(regs, stepping);
 }
 
 
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index c43f77e2ac31..f394b0d6473f 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -16,7 +16,7 @@
  */
 
 #include <linux/regset.h>
-#include <linux/tracehook.h>
+#include <linux/ptrace.h>
 #include <linux/audit.h>
 #include <linux/context_tracking.h>
 #include <linux/syscalls.h>
@@ -263,12 +263,12 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 	flags = read_thread_flags() & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
 
 	if (flags) {
-		int rc = tracehook_report_syscall_entry(regs);
+		int rc = ptrace_report_syscall_entry(regs);
 
 		if (unlikely(flags & _TIF_SYSCALL_EMU)) {
 			/*
 			 * A nonzero return code from
-			 * tracehook_report_syscall_entry() tells us to prevent
+			 * ptrace_report_syscall_entry() tells us to prevent
 			 * the syscall execution, but we are not going to
 			 * execute it anyway.
 			 *
@@ -334,7 +334,7 @@ void do_syscall_trace_leave(struct pt_regs *regs)
 
 	step = test_thread_flag(TIF_SINGLESTEP);
 	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, step);
+		ptrace_report_syscall_exit(regs, step);
 }
 
 void __init pt_regs_check(void);
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index a89243730153..793c7da0554b 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -17,7 +17,6 @@
 #include <linux/regset.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
-#include <linux/tracehook.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -241,7 +240,7 @@ long arch_ptrace(struct task_struct *child, long request,
 __visible int do_syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		if (tracehook_report_syscall_entry(regs))
+		if (ptrace_report_syscall_entry(regs))
 			return -1;
 
 	/*
@@ -266,7 +265,7 @@ __visible void do_syscall_trace_exit(struct pt_regs *regs)
 	audit_syscall_exit(regs);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, 0);
+		ptrace_report_syscall_exit(regs, 0);
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 5281685f6ad1..d417988d9770 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -20,7 +20,6 @@
 #include <linux/io.h>
 #include <linux/audit.h>
 #include <linux/seccomp.h>
-#include <linux/tracehook.h>
 #include <linux/elf.h>
 #include <linux/regset.h>
 #include <linux/hw_breakpoint.h>
@@ -456,7 +455,7 @@ long arch_ptrace(struct task_struct *child, long request,
 asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs)) {
+	    ptrace_report_syscall_entry(regs)) {
 		regs->regs[0] = -ENOSYS;
 		return -1;
 	}
@@ -484,5 +483,5 @@ asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
 
 	step = test_thread_flag(TIF_SINGLESTEP);
 	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, step);
+		ptrace_report_syscall_exit(regs, step);
 }
diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index 5318174a0268..e7db48acb838 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -21,7 +21,6 @@
 #include <linux/signal.h>
 #include <linux/regset.h>
 #include <linux/elf.h>
-#include <linux/tracehook.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -439,9 +438,9 @@ asmlinkage int syscall_trace(struct pt_regs *regs, int syscall_exit_p)
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
 		if (syscall_exit_p)
-			tracehook_report_syscall_exit(regs, 0);
+			ptrace_report_syscall_exit(regs, 0);
 		else
-			ret = tracehook_report_syscall_entry(regs);
+			ret = ptrace_report_syscall_entry(regs);
 	}
 
 	return ret;
diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 2b92155db8a5..86a7eb5c27ba 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -25,7 +25,6 @@
 #include <linux/audit.h>
 #include <linux/signal.h>
 #include <linux/regset.h>
-#include <linux/tracehook.h>
 #include <trace/syscall.h>
 #include <linux/compat.h>
 #include <linux/elf.h>
@@ -1095,7 +1094,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 		user_exit();
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		ret = tracehook_report_syscall_entry(regs);
+		ret = ptrace_report_syscall_entry(regs);
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
 		trace_sys_enter(regs, regs->u_regs[UREG_G1]);
@@ -1118,7 +1117,7 @@ asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 		trace_sys_exit(regs, regs->u_regs[UREG_I0]);
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, 0);
+		ptrace_report_syscall_exit(regs, 0);
 
 	if (test_thread_flag(TIF_NOHZ))
 		user_enter();
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index b425f47bddbb..bfaf6ab1ac03 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -6,7 +6,6 @@
 #include <linux/audit.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
-#include <linux/tracehook.h>
 #include <linux/uaccess.h>
 #include <asm/ptrace-abi.h>
 
@@ -135,7 +134,7 @@ int syscall_trace_enter(struct pt_regs *regs)
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return 0;
 
-	return tracehook_report_syscall_entry(regs);
+	return ptrace_report_syscall_entry(regs);
 }
 
 void syscall_trace_leave(struct pt_regs *regs)
@@ -151,7 +150,7 @@ void syscall_trace_leave(struct pt_regs *regs)
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
 
-	tracehook_report_syscall_exit(regs, 0);
+	ptrace_report_syscall_exit(regs, 0);
 	/* force do_signal() --> is_syscall() */
 	if (ptraced & PT_PTRACED)
 		set_thread_flag(TIF_SIGPENDING);
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index bb3f4797d212..323c678a691f 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -26,7 +26,6 @@
 #include <linux/security.h>
 #include <linux/signal.h>
 #include <linux/smp.h>
-#include <linux/tracehook.h>
 #include <linux/uaccess.h>
 
 #define CREATE_TRACE_POINTS
@@ -550,7 +549,7 @@ int do_syscall_trace_enter(struct pt_regs *regs)
 		regs->areg[2] = -ENOSYS;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    tracehook_report_syscall_entry(regs)) {
+	    ptrace_report_syscall_entry(regs)) {
 		regs->areg[2] = -ENOSYS;
 		regs->syscall = NO_SYSCALL;
 		return 0;
@@ -583,5 +582,5 @@ void do_syscall_trace_leave(struct pt_regs *regs)
 	step = test_thread_flag(TIF_SINGLESTEP);
 
 	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
-		tracehook_report_syscall_exit(regs, step);
+		ptrace_report_syscall_exit(regs, step);
 }
diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 81695eb02a12..5a80fe728dc8 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -44,7 +44,7 @@ int syscall_get_nr(struct task_struct *task, struct pt_regs *regs);
  *
  * It's only valid to call this when @task is stopped for system
  * call exit tracing (due to %SYSCALL_WORK_SYSCALL_TRACE or
- * %SYSCALL_WORK_SYSCALL_AUDIT), after tracehook_report_syscall_entry()
+ * %SYSCALL_WORK_SYSCALL_AUDIT), after ptrace_report_syscall_entry()
  * returned nonzero to prevent the system call from taking place.
  *
  * This rolls back the register state in @regs so it's as if the
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2e2b8d6140ed..a670e9fba7a9 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -3,7 +3,7 @@
 #define __LINUX_ENTRYCOMMON_H
 
 #include <linux/static_call_types.h>
-#include <linux/tracehook.h>
+#include <linux/ptrace.h>
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
@@ -95,7 +95,7 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
 #ifndef arch_syscall_enter_tracehook
 static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs)
 {
-	return tracehook_report_syscall_entry(regs);
+	return ptrace_report_syscall_entry(regs);
 }
 #endif
 
@@ -294,7 +294,7 @@ static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step);
 #ifndef arch_syscall_exit_tracehook
 static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
 {
-	tracehook_report_syscall_exit(regs, step);
+	ptrace_report_syscall_exit(regs, step);
 }
 #endif
 
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 91b1074edb4c..5310f43e4762 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -440,4 +440,55 @@ static inline int ptrace_report_syscall(unsigned long message)
 	current->ptrace_message = 0;
 	return fatal_signal_pending(current);
 }
+
+/**
+ * ptrace_report_syscall_entry - task is about to attempt a system call
+ * @regs:		user register state of current task
+ *
+ * This will be called if %SYSCALL_WORK_SYSCALL_TRACE or
+ * %SYSCALL_WORK_SYSCALL_EMU have been set, when the current task has just
+ * entered the kernel for a system call.  Full user register state is
+ * available here.  Changing the values in @regs can affect the system
+ * call number and arguments to be tried.  It is safe to block here,
+ * preventing the system call from beginning.
+ *
+ * Returns zero normally, or nonzero if the calling arch code should abort
+ * the system call.  That must prevent normal entry so no system call is
+ * made.  If @task ever returns to user mode after this, its register state
+ * is unspecified, but should be something harmless like an %ENOSYS error
+ * return.  It should preserve enough information so that syscall_rollback()
+ * can work (see asm-generic/syscall.h).
+ *
+ * Called without locks, just after entering kernel mode.
+ */
+static inline __must_check int ptrace_report_syscall_entry(
+	struct pt_regs *regs)
+{
+	return ptrace_report_syscall(PTRACE_EVENTMSG_SYSCALL_ENTRY);
+}
+
+/**
+ * ptrace_report_syscall_exit - task has just finished a system call
+ * @regs:		user register state of current task
+ * @step:		nonzero if simulating single-step or block-step
+ *
+ * This will be called if %SYSCALL_WORK_SYSCALL_TRACE has been set, when
+ * the current task has just finished an attempted system call.  Full
+ * user register state is available here.  It is safe to block here,
+ * preventing signals from being processed.
+ *
+ * If @step is nonzero, this report is also in lieu of the normal
+ * trap that would follow the system call instruction because
+ * user_enable_block_step() or user_enable_single_step() was used.
+ * In this case, %SYSCALL_WORK_SYSCALL_TRACE might not be set.
+ *
+ * Called without locks, just before checking for pending signals.
+ */
+static inline void ptrace_report_syscall_exit(struct pt_regs *regs, int step)
+{
+	if (step)
+		user_single_step_report(regs);
+	else
+		ptrace_report_syscall(PTRACE_EVENTMSG_SYSCALL_EXIT);
+}
 #endif
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 998bc3863559..819e82ac09bd 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -52,57 +52,6 @@
 struct linux_binprm;
 
 
-/**
- * tracehook_report_syscall_entry - task is about to attempt a system call
- * @regs:		user register state of current task
- *
- * This will be called if %SYSCALL_WORK_SYSCALL_TRACE or
- * %SYSCALL_WORK_SYSCALL_EMU have been set, when the current task has just
- * entered the kernel for a system call.  Full user register state is
- * available here.  Changing the values in @regs can affect the system
- * call number and arguments to be tried.  It is safe to block here,
- * preventing the system call from beginning.
- *
- * Returns zero normally, or nonzero if the calling arch code should abort
- * the system call.  That must prevent normal entry so no system call is
- * made.  If @task ever returns to user mode after this, its register state
- * is unspecified, but should be something harmless like an %ENOSYS error
- * return.  It should preserve enough information so that syscall_rollback()
- * can work (see asm-generic/syscall.h).
- *
- * Called without locks, just after entering kernel mode.
- */
-static inline __must_check int tracehook_report_syscall_entry(
-	struct pt_regs *regs)
-{
-	return ptrace_report_syscall(PTRACE_EVENTMSG_SYSCALL_ENTRY);
-}
-
-/**
- * tracehook_report_syscall_exit - task has just finished a system call
- * @regs:		user register state of current task
- * @step:		nonzero if simulating single-step or block-step
- *
- * This will be called if %SYSCALL_WORK_SYSCALL_TRACE has been set, when
- * the current task has just finished an attempted system call.  Full
- * user register state is available here.  It is safe to block here,
- * preventing signals from being processed.
- *
- * If @step is nonzero, this report is also in lieu of the normal
- * trap that would follow the system call instruction because
- * user_enable_block_step() or user_enable_single_step() was used.
- * In this case, %SYSCALL_WORK_SYSCALL_TRACE might not be set.
- *
- * Called without locks, just before checking for pending signals.
- */
-static inline void tracehook_report_syscall_exit(struct pt_regs *regs, int step)
-{
-	if (step)
-		user_single_step_report(regs);
-	else
-		ptrace_report_syscall(PTRACE_EVENTMSG_SYSCALL_EXIT);
-}
-
 /**
  * tracehook_signal_handler - signal handler setup is complete
  * @stepping:		nonzero if debugger single-step or block-step in use
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 3747bf816f9a..b7af92e07d1f 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -114,7 +114,7 @@ struct ptrace_rseq_configuration {
 
 /*
  * These values are stored in task->ptrace_message
- * by tracehook_report_syscall_* to describe the current syscall-stop.
+ * by ptrace_report_syscall_* to describe the current syscall-stop.
  */
 #define PTRACE_EVENTMSG_SYSCALL_ENTRY	1
 #define PTRACE_EVENTMSG_SYSCALL_EXIT	2
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bad713684c2e..f52e57c4d6d8 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -2,6 +2,7 @@
 
 #include <linux/context_tracking.h>
 #include <linux/entry-common.h>
+#include <linux/tracehook.h>
 #include <linux/highmem.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
-- 
2.29.2

