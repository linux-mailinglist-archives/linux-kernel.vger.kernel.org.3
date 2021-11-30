Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B108464205
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345231AbhK3XMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:12:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36562 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345109AbhK3XMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:12:03 -0500
Date:   Tue, 30 Nov 2021 23:08:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638313722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=80eV/7P8gCmJ8Y9fMugjzWW54KdjZIBbbL1G55SzJEI=;
        b=YzCns8uFxKFnBIHF8Yf9HbTmPe4IJPvFiChkk2ez++QKq+PXGXgx4Lr7r6caheu/rS9h8y
        BrkH93DAiZMKXVD/a0mKwBbx4rK4l65ySPwpDNeVWE8Tc+VhQYwxMscK/zWX6o8lsLq01Q
        q8q/wWWZLZPBI25SL/qIKivzrDwLDjU84QeWyZQnEy7pA7Jx5DzqKWSLFda6IqEhHCafpp
        2pULMp2+mHI29Oklm/wq1g8gi3o9We1+A1T8L4OPdMOhfABlYmBTNx2GTzd8xSzmXr98HV
        UYMQnFWHN7l6T+Bnpsnq3Nh8UQPyr2cQWZRtmWCkjgo4/MZ23PnlH+HTUhc1ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638313722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=80eV/7P8gCmJ8Y9fMugjzWW54KdjZIBbbL1G55SzJEI=;
        b=FRLcZVJS3EH+pLi9Jo9GLVkTqUVgWS/St3SS2Yd22mOym1Hs4Ls6Z2HlP8IIcaa119cSxN
        KmIkmU7cJAs3VzCw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] arm64: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129130653.2037928-7-mark.rutland@arm.com>
References: <20211129130653.2037928-7-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163831372148.11128.11692234489872445198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     342b3808786518ced347f40b59bae68664e20007
Gitweb:        https://git.kernel.org/tip/342b3808786518ced347f40b59bae68664e20007
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 29 Nov 2021 13:06:48 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Dec 2021 00:06:44 +01:00

arm64: Snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are disabled,
the flags can change under our feet. Generally this is unlikely to cause a
problem in practice, but it is somewhat unsound, and KCSAN will
legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20211129130653.2037928-7-mark.rutland@arm.com

---
 arch/arm64/kernel/entry-common.c | 2 +-
 arch/arm64/kernel/ptrace.c       | 4 ++--
 arch/arm64/kernel/signal.c       | 2 +-
 arch/arm64/kernel/syscall.c      | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index f7408ed..ef7fcef 100644
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
index 88a9034..33cac3d 100644
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
index 8f6372b..d8aaf4b 100644
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
index 50a0f1a..c938603 100644
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
