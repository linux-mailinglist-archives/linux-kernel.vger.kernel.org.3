Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF0F4641FF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345136AbhK3XME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbhK3XMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:12:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456D0C061746;
        Tue, 30 Nov 2021 15:08:41 -0800 (PST)
Date:   Tue, 30 Nov 2021 23:08:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638313719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXCdHnS1zySe7YLcZSKygHbfQngvoJkIohTQI8Qi/tk=;
        b=lL0ELH/IK787czxd+9YQUshdF0KgtTaKpQ++cWMxRC/pIq4U7j6veEG3sHDiIKH5E7SS6N
        OFFep8pt1rq8wggXTxBAo1mUTHSMW3GxJtkBhRJg2m+uXLtKAjIxlvM6xJ+7jiyJ13EarW
        oW5aIo48xBRaq2DJrPQJakPW/o4BegRBzwSy+JhYh/BP3tYUwFT9Urkk8A0OMSBEzvDVq4
        uhbKAl9SfZ+GrHm/nY+DWfWCCEGWQM4hg6MVguOhcVj5T1UU78J0S1refUwrutJ36zGNpy
        +KJu1mjd9MOQyEQ+/QbNpP9tLdP6qVR43/Vw9BsJZ4L6yTbddulS4bqHbNJaKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638313719;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXCdHnS1zySe7YLcZSKygHbfQngvoJkIohTQI8Qi/tk=;
        b=qXDe20Uc8uyTkCzJ7MK3dbWQV7ojgjrAxongBDS+26htT+KqzFGY+axc0/7dHxowcc7wqh
        9ieu3rn1YDWZbsCA==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] powerpc: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211129130653.2037928-11-mark.rutland@arm.com>
References: <20211129130653.2037928-11-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163831371748.11128.4942543745019887361.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     985faa78687de6e583cfd8b8094d87dcb80c33a6
Gitweb:        https://git.kernel.org/tip/985faa78687de6e583cfd8b8094d87dcb80c33a6
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 29 Nov 2021 13:06:52 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Dec 2021 00:06:44 +01:00

powerpc: Snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are disabled,
the flags can change under our feet. Generally this is unlikely to cause a
problem in practice, but it is somewhat unsound, and KCSAN will
legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Link: https://lore.kernel.org/r/20211129130653.2037928-11-mark.rutland@arm.com

---
 arch/powerpc/kernel/interrupt.c     | 13 ++++++-------
 arch/powerpc/kernel/ptrace/ptrace.c |  3 +--
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index df048e3..563ebfc 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -181,7 +181,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 
 	local_irq_enable();
 
-	if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
+	if (unlikely(read_thread_flags() & _TIF_SYSCALL_DOTRACE)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {
 			/* Unsupported scv vector */
 			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
@@ -343,7 +343,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 	unsigned long ti_flags;
 
 again:
-	ti_flags = READ_ONCE(current_thread_info()->flags);
+	ti_flags = read_thread_flags();
 	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
 		local_irq_enable();
 		if (ti_flags & _TIF_NEED_RESCHED) {
@@ -359,7 +359,7 @@ again:
 			do_notify_resume(regs, ti_flags);
 		}
 		local_irq_disable();
-		ti_flags = READ_ONCE(current_thread_info()->flags);
+		ti_flags = read_thread_flags();
 	}
 
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && IS_ENABLED(CONFIG_PPC_FPU)) {
@@ -437,7 +437,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	/* Check whether the syscall is issued inside a restartable sequence */
 	rseq_syscall(regs);
 
-	ti_flags = current_thread_info()->flags;
+	ti_flags = read_thread_flags();
 
 	if (unlikely(r3 >= (unsigned long)-MAX_ERRNO) && is_not_scv) {
 		if (likely(!(ti_flags & (_TIF_NOERROR | _TIF_RESTOREALL)))) {
@@ -532,8 +532,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 	unsigned long flags;
 	unsigned long ret = 0;
 	unsigned long kuap;
-	bool stack_store = current_thread_info()->flags &
-						_TIF_EMULATE_STACK_STORE;
+	bool stack_store = read_thread_flags() & _TIF_EMULATE_STACK_STORE;
 
 	if (regs_is_unrecoverable(regs))
 		unrecoverable_exception(regs);
@@ -554,7 +553,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
 again:
 		if (IS_ENABLED(CONFIG_PREEMPT)) {
 			/* Return to preemptible kernel context */
-			if (unlikely(current_thread_info()->flags & _TIF_NEED_RESCHED)) {
+			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
 				if (preempt_count() == 0)
 					preempt_schedule_irq();
 			}
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 7c7093c..c43f77e 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -260,8 +260,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	u32 flags;
 
-	flags = READ_ONCE(current_thread_info()->flags) &
-		(_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
+	flags = read_thread_flags() & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
 
 	if (flags) {
 		int rc = tracehook_report_syscall_entry(regs);
