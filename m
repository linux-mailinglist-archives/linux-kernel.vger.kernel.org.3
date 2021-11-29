Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7D64615DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377503AbhK2NMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:12:35 -0500
Received: from foss.arm.com ([217.140.110.172]:38494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377463AbhK2NK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:10:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B3B311D4;
        Mon, 29 Nov 2021 05:07:10 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0AFB83F766;
        Mon, 29 Nov 2021 05:07:06 -0800 (PST)
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
Subject: [PATCH v8 02/11] entry: snapshot thread flags
Date:   Mon, 29 Nov 2021 13:06:44 +0000
Message-Id: <20211129130653.2037928-3-mark.rutland@arm.com>
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
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/entry-kvm.h | 2 +-
 kernel/entry/common.c     | 4 ++--
 kernel/entry/kvm.c        | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 0d7865a0731c..07c878d6e323 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -75,7 +75,7 @@ static inline void xfer_to_guest_mode_prepare(void)
  */
 static inline bool __xfer_to_guest_mode_work_pending(void)
 {
-	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	unsigned long ti_work = read_thread_flags();
 
 	return !!(ti_work & XFER_TO_GUEST_MODE_WORK);
 }
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d5a61d565ad5..bad713684c2e 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -187,7 +187,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		/* Check if any of the above work has queued a deferred wakeup */
 		tick_nohz_user_enter_prepare();
 
-		ti_work = READ_ONCE(current_thread_info()->flags);
+		ti_work = read_thread_flags();
 	}
 
 	/* Return the latest work state for arch_exit_to_user_mode() */
@@ -196,7 +196,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 static void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
-	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
+	unsigned long ti_work = read_thread_flags();
 
 	lockdep_assert_irqs_disabled();
 
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 49972ee99aff..96d476e06c77 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -26,7 +26,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 		if (ret)
 			return ret;
 
-		ti_work = READ_ONCE(current_thread_info()->flags);
+		ti_work = read_thread_flags();
 	} while (ti_work & XFER_TO_GUEST_MODE_WORK || need_resched());
 	return 0;
 }
@@ -43,7 +43,7 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
 	 * disabled in the inner loop before going into guest mode. No need
 	 * to disable interrupts here.
 	 */
-	ti_work = READ_ONCE(current_thread_info()->flags);
+	ti_work = read_thread_flags();
 	if (!(ti_work & XFER_TO_GUEST_MODE_WORK))
 		return 0;
 
-- 
2.30.2

