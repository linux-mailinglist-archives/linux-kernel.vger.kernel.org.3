Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEEE4615E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhK2NOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:14:21 -0500
Received: from foss.arm.com ([217.140.110.172]:38933 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377107AbhK2NMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:12:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41BFF143B;
        Mon, 29 Nov 2021 05:07:29 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E741A3F766;
        Mon, 29 Nov 2021 05:07:25 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, efuller@redhat.com,
        elver@google.com, ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mark.rutland@arm.com, mattst88@gmail.com, michal.simek@xilinx.com,
        mingo@redhat.com, mpe@ellerman.id.au, npiggin@gmail.com,
        paulmck@kernel.org, paulus@samba.org, peterz@infradead.org,
        rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        vincent.guittot@linaro.org, will@kernel.org
Subject: [PATCH v8 06/11] arm64: snapshot thread flags
Date:   Mon, 29 Nov 2021 13:06:48 +0000
Message-Id: <20211129130653.2037928-7-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129130653.2037928-1-mark.rutland@arm.com>
References: <20211129130653.2037928-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Generally this is
unlikely to cause a problem in practice, but it is somewhat unsound, and
KCSAN will legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/entry-common.c | 2 +-
 arch/arm64/kernel/ptrace.c       | 4 ++--
 arch/arm64/kernel/signal.c       | 2 +-
 arch/arm64/kernel/syscall.c      | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index f7408edf8571..ef7fcefb96bd 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -129,7 +129,7 @@ static __always_inline void prepare_exit_to_user_mode(struct pt_regs *regs)
 
 	local_daif_mask();
 
-	flags = READ_ONCE(current_thread_info()->flags);
+	flags = read_thread_flags();
 	if (unlikely(flags & _TIF_WORK_MASK))
 		do_notify_resume(regs, flags);
 }
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 88a9034fb9b5..33cac3d75150 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1839,7 +1839,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 
 int syscall_trace_enter(struct pt_regs *regs)
 {
-	unsigned long flags = READ_ONCE(current_thread_info()->flags);
+	unsigned long flags = read_thread_flags();
 
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
@@ -1862,7 +1862,7 @@ int syscall_trace_enter(struct pt_regs *regs)
 
 void syscall_trace_exit(struct pt_regs *regs)
 {
-	unsigned long flags = READ_ONCE(current_thread_info()->flags);
+	unsigned long flags = read_thread_flags();
 
 	audit_syscall_exit(regs);
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 8f6372b44b65..d8aaf4b6f432 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -948,7 +948,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 		}
 
 		local_daif_mask();
-		thread_flags = READ_ONCE(current_thread_info()->flags);
+		thread_flags = read_thread_flags();
 	} while (thread_flags & _TIF_WORK_MASK);
 }
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 50a0f1a38e84..c938603b3ba0 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -81,7 +81,7 @@ void syscall_trace_exit(struct pt_regs *regs);
 static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			   const syscall_fn_t syscall_table[])
 {
-	unsigned long flags = current_thread_info()->flags;
+	unsigned long flags = read_thread_flags();
 
 	regs->orig_x0 = regs->regs[0];
 	regs->syscallno = scno;
@@ -148,7 +148,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	 */
 	if (!has_syscall_work(flags) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
 		local_daif_mask();
-		flags = current_thread_info()->flags;
+		flags = read_thread_flags();
 		if (!has_syscall_work(flags) && !(flags & _TIF_SINGLESTEP))
 			return;
 		local_daif_restore(DAIF_PROCCTX);
-- 
2.30.2

