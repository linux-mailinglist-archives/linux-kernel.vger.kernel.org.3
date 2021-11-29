Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2054615E9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377678AbhK2NOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:14:35 -0500
Received: from foss.arm.com ([217.140.110.172]:38948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377477AbhK2NM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:12:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB3C014BF;
        Mon, 29 Nov 2021 05:07:49 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72A463F766;
        Mon, 29 Nov 2021 05:07:46 -0800 (PST)
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
Subject: [PATCH v8 11/11] x86: snapshot thread flags
Date:   Mon, 29 Nov 2021 13:06:53 +0000
Message-Id: <20211129130653.2037928-12-mark.rutland@arm.com>
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
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
---
 arch/x86/kernel/process.c | 8 ++++----
 arch/x86/kernel/process.h | 4 ++--
 arch/x86/mm/tlb.c         | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index e9ee8b526319..180d7a00cb66 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -365,7 +365,7 @@ void arch_setup_new_exec(void)
 		clear_thread_flag(TIF_SSBD);
 		task_clear_spec_ssb_disable(current);
 		task_clear_spec_ssb_noexec(current);
-		speculation_ctrl_update(task_thread_info(current)->flags);
+		speculation_ctrl_update(read_thread_flags());
 	}
 }
 
@@ -617,7 +617,7 @@ static unsigned long speculation_ctrl_update_tif(struct task_struct *tsk)
 			clear_tsk_thread_flag(tsk, TIF_SPEC_IB);
 	}
 	/* Return the updated threadinfo flags*/
-	return task_thread_info(tsk)->flags;
+	return read_task_thread_flags(tsk);
 }
 
 void speculation_ctrl_update(unsigned long tif)
@@ -653,8 +653,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	unsigned long tifp, tifn;
 
-	tifn = READ_ONCE(task_thread_info(next_p)->flags);
-	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
+	tifn = read_task_thread_flags(next_p);
+	tifp = read_task_thread_flags(prev_p);
 
 	switch_to_bitmap(tifp);
 
diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
index 1d0797b2338a..76b547b83232 100644
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -13,8 +13,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p);
 static inline void switch_to_extra(struct task_struct *prev,
 				   struct task_struct *next)
 {
-	unsigned long next_tif = task_thread_info(next)->flags;
-	unsigned long prev_tif = task_thread_info(prev)->flags;
+	unsigned long next_tif = read_task_thread_flags(next);
+	unsigned long prev_tif = read_task_thread_flags(prev);
 
 	if (IS_ENABLED(CONFIG_SMP)) {
 		/*
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 59ba2968af1b..92bb03b9ceb5 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -361,7 +361,7 @@ static void l1d_flush_evaluate(unsigned long prev_mm, unsigned long next_mm,
 
 static unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 {
-	unsigned long next_tif = task_thread_info(next)->flags;
+	unsigned long next_tif = read_task_thread_flags(next);
 	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
 
 	/*
-- 
2.30.2

