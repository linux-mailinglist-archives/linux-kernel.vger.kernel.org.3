Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A3C572EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiGMHHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbiGMHHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:07:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BF7E1936
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id o18so9657319pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NCyqPa70fv3Z42VUp89XGP6TUd4gmTjk1XFf+/Ifcs=;
        b=QdUAd5JfSGrvjLVhQmK2BTaamc7nXjK/hKPcTTs/qin7R2KALMmV/fJ7NiDlPZEV0P
         vnctDFYTA3YtOkQ3U5j4QB63N6MXmzO6ElJvUmPhL3aa0eQggs+KcpDYftP5YTkLuEUV
         GS1kAOmVvce2kaZj1ruyfFsP6PXqBWJlFNKEWh+735hqaF5dQMycEzKGzS7YanETmVxS
         zA7Lnhn1sxZOj4bMHVfruZ5ALlK2O4wiS2TcrN9liMQYNdRshgfvfRCCC+JbJdScgojJ
         gKaNmJvEnkvk360wKkyfkRG1oq1t+/68yIw32krh8fASZIZaoMJhro43Ov8q2MDECxLP
         u+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NCyqPa70fv3Z42VUp89XGP6TUd4gmTjk1XFf+/Ifcs=;
        b=JVmmWR+Vjk7NuLSgk3xHnVicR4gYHhyKUptnzbUpMmDT1DnJH8vv/rXSMoVGKIM/E+
         xQWP1HNKJpW0W5LYeqz6QFaVxpXLaGR0ADm2wncsKWAipkkboZcngEBStXhrs0eYTNrl
         K8Oe6TZEtgW2Xtvzcc8wmuq5GWrIfTRasz42UnqsYZjeSUX1+10c2NEIuul1wKnJdPRz
         uXMoZoQqDOtXBddeDAiJaGa42+26R3j6ibdFaRH2TGN9gKXOCaAWXcctkeXpDzGqIRJN
         zcSbGyyNGew/aubelnJ1tCrnRpOgEZmcA+U5LMryUfn/g9OP5flYkpg4pLap1W2swf1a
         yLwA==
X-Gm-Message-State: AJIora8a6bOPy6TY3braTL5tJy7z+PYo4thghOLp0AeaJnXQQUcSDCMp
        1KCkOODaK8mNbmf10hkKyOgnmS5Kung=
X-Google-Smtp-Source: AGRyM1soFb7ZrpjIwg1Zrw0ubdV34FFonDw/28eLQnwXn/qBwN1AkVb6mqtwn4pKMXVir2EHdjVwDQ==
X-Received: by 2002:a05:6a00:1485:b0:52a:ca0b:5383 with SMTP id v5-20020a056a00148500b0052aca0b5383mr1795737pfu.0.1657696039649;
        Wed, 13 Jul 2022 00:07:19 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b0016bd5da20casm8099061plg.134.2022.07.13.00.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:07:19 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/12] locking/qspinlock: inline mcs_spinlock functions into qspinlock
Date:   Wed, 13 Jul 2022 17:06:54 +1000
Message-Id: <20220713070704.308394-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713070704.308394-1-npiggin@gmail.com>
References: <20220713070704.308394-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qspinlock uses mcs_spinlock for the struct type (.next, .locked, and the
misplaced .count), and arch_mcs_spin_{un}lock_contended(). These can be
trivially inlined into qspinlock, the only arch that overrides them is
arm, and it does not implement qspinlock.

The now-unused mcs_spinlock code is removed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/alpha/include/asm/Kbuild       |   1 -
 arch/arc/include/asm/Kbuild         |   1 -
 arch/arm/include/asm/mcs_spinlock.h |  24 ------
 arch/arm64/include/asm/Kbuild       |   1 -
 arch/hexagon/include/asm/Kbuild     |   1 -
 arch/ia64/include/asm/Kbuild        |   1 -
 arch/m68k/include/asm/Kbuild        |   1 -
 arch/microblaze/include/asm/Kbuild  |   1 -
 arch/mips/include/asm/Kbuild        |   1 -
 arch/nios2/include/asm/Kbuild       |   1 -
 arch/parisc/include/asm/Kbuild      |   1 -
 arch/powerpc/include/asm/Kbuild     |   1 -
 arch/s390/include/asm/Kbuild        |   1 -
 arch/sh/include/asm/Kbuild          |   1 -
 arch/sparc/include/asm/Kbuild       |   1 -
 arch/um/include/asm/Kbuild          |   1 -
 arch/x86/include/asm/Kbuild         |   1 -
 arch/xtensa/include/asm/Kbuild      |   1 -
 include/asm-generic/mcs_spinlock.h  |  13 ---
 kernel/locking/mcs_spinlock.h       | 121 ----------------------------
 kernel/locking/qspinlock.c          |  38 ++++-----
 kernel/locking/qspinlock_paravirt.h |  53 ++++++------
 22 files changed, 43 insertions(+), 223 deletions(-)
 delete mode 100644 arch/arm/include/asm/mcs_spinlock.h
 delete mode 100644 include/asm-generic/mcs_spinlock.h
 delete mode 100644 kernel/locking/mcs_spinlock.h

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index 42911c8340c7..d21cf7b3173a 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -3,4 +3,3 @@
 generated-y += syscall_table.h
 generic-y += export.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 3c1afa524b9c..5ae4337a9301 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += user.h
diff --git a/arch/arm/include/asm/mcs_spinlock.h b/arch/arm/include/asm/mcs_spinlock.h
deleted file mode 100644
index 529d2cf4d06f..000000000000
--- a/arch/arm/include/asm/mcs_spinlock.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_MCS_LOCK_H
-#define __ASM_MCS_LOCK_H
-
-#ifdef CONFIG_SMP
-#include <asm/spinlock.h>
-
-/* MCS spin-locking. */
-#define arch_mcs_spin_lock_contended(lock)				\
-do {									\
-	/* Ensure prior stores are observed before we enter wfe. */	\
-	smp_mb();							\
-	while (!(smp_load_acquire(lock)))				\
-		wfe();							\
-} while (0)								\
-
-#define arch_mcs_spin_unlock_contended(lock)				\
-do {									\
-	smp_store_release(lock, 1);					\
-	dsb_sev();							\
-} while (0)
-
-#endif	/* CONFIG_SMP */
-#endif	/* __ASM_MCS_LOCK_H */
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 5c8ee5a541d2..57e9ad366d25 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += early_ioremap.h
-generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += parport.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 3ece3c93fe08..37bbf99f66d4 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -2,4 +2,3 @@
 generic-y += extable.h
 generic-y += iomap.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index f994c1daf9d4..a0198c12e339 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
 generic-y += vtime.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 1b720299deb1..8dbef73ce01d 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -3,5 +3,4 @@ generated-y += syscall_table.h
 generic-y += export.h
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
 generic-y += spinlock.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index a055f5dbe00a..7615a27e0851 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -3,7 +3,6 @@ generated-y += syscall_table.h
 generic-y += cmpxchg.h
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += syscalls.h
 generic-y += tlb.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index dee172716581..65cedca08771 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -9,7 +9,6 @@ generated-y += unistd_nr_o32.h
 
 generic-y += export.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 7fe7437555fb..5718eee9665c 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -2,6 +2,5 @@
 generic-y += cmpxchg.h
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
 generic-y += spinlock.h
 generic-y += user.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index e6e7f74c8ac9..1f0c28d74c88 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -2,5 +2,4 @@
 generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
 generic-y += user.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index bcf95ce0964f..813a8c3405ad 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -4,7 +4,6 @@ generated-y += syscall_table_64.h
 generated-y += syscall_table_spu.h
 generic-y += export.h
 generic-y += kvm_types.h
-generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
 generic-y += vtime.h
 generic-y += early_ioremap.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 1a18d7b82f86..8b036a4ee2ca 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -7,4 +7,3 @@ generated-y += unistd_nr.h
 generic-y += asm-offsets.h
 generic-y += export.h
 generic-y += kvm_types.h
-generic-y += mcs_spinlock.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index fc44d9c88b41..3192f19bcf85 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
 generic-y += parport.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 0b9d98ced34a..f0b913f7ba05 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -3,4 +3,3 @@ generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
 generic-y += export.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b2d834a29f3a..04080c0c1aec 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -14,7 +14,6 @@ generic-y += hw_irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
-generic-y += mcs_spinlock.h
 generic-y += mmiowb.h
 generic-y += module.lds.h
 generic-y += param.h
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 1e51650b79d7..beb7683f7b8f 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -10,4 +10,3 @@ generated-y += xen-hypercalls.h
 
 generic-y += early_ioremap.h
 generic-y += export.h
-generic-y += mcs_spinlock.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index fa07c686cbcc..29ae65cb68c2 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -2,7 +2,6 @@
 generated-y += syscall_table.h
 generic-y += extable.h
 generic-y += kvm_para.h
-generic-y += mcs_spinlock.h
 generic-y += param.h
 generic-y += parport.h
 generic-y += qrwlock.h
diff --git a/include/asm-generic/mcs_spinlock.h b/include/asm-generic/mcs_spinlock.h
deleted file mode 100644
index 10cd4ffc6ba2..000000000000
--- a/include/asm-generic/mcs_spinlock.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __ASM_MCS_SPINLOCK_H
-#define __ASM_MCS_SPINLOCK_H
-
-/*
- * Architectures can define their own:
- *
- *   arch_mcs_spin_lock_contended(l)
- *   arch_mcs_spin_unlock_contended(l)
- *
- * See kernel/locking/mcs_spinlock.c.
- */
-
-#endif /* __ASM_MCS_SPINLOCK_H */
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
deleted file mode 100644
index 85251d8771d9..000000000000
--- a/kernel/locking/mcs_spinlock.h
+++ /dev/null
@@ -1,121 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * MCS lock defines
- *
- * This file contains the main data structure and API definitions of MCS lock.
- *
- * The MCS lock (proposed by Mellor-Crummey and Scott) is a simple spin-lock
- * with the desirable properties of being fair, and with each cpu trying
- * to acquire the lock spinning on a local variable.
- * It avoids expensive cache bounces that common test-and-set spin-lock
- * implementations incur.
- */
-#ifndef __LINUX_MCS_SPINLOCK_H
-#define __LINUX_MCS_SPINLOCK_H
-
-#include <asm/mcs_spinlock.h>
-
-struct mcs_spinlock {
-	struct mcs_spinlock *next;
-	int locked; /* 1 if lock acquired */
-	int count;  /* nesting count, see qspinlock.c */
-};
-
-#ifndef arch_mcs_spin_lock_contended
-/*
- * Using smp_cond_load_acquire() provides the acquire semantics
- * required so that subsequent operations happen after the
- * lock is acquired. Additionally, some architectures such as
- * ARM64 would like to do spin-waiting instead of purely
- * spinning, and smp_cond_load_acquire() provides that behavior.
- */
-#define arch_mcs_spin_lock_contended(l)					\
-do {									\
-	smp_cond_load_acquire(l, VAL);					\
-} while (0)
-#endif
-
-#ifndef arch_mcs_spin_unlock_contended
-/*
- * smp_store_release() provides a memory barrier to ensure all
- * operations in the critical section has been completed before
- * unlocking.
- */
-#define arch_mcs_spin_unlock_contended(l)				\
-	smp_store_release((l), 1)
-#endif
-
-/*
- * Note: the smp_load_acquire/smp_store_release pair is not
- * sufficient to form a full memory barrier across
- * cpus for many architectures (except x86) for mcs_unlock and mcs_lock.
- * For applications that need a full barrier across multiple cpus
- * with mcs_unlock and mcs_lock pair, smp_mb__after_unlock_lock() should be
- * used after mcs_lock.
- */
-
-/*
- * In order to acquire the lock, the caller should declare a local node and
- * pass a reference of the node to this function in addition to the lock.
- * If the lock has already been acquired, then this will proceed to spin
- * on this node->locked until the previous lock holder sets the node->locked
- * in mcs_spin_unlock().
- */
-static inline
-void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
-{
-	struct mcs_spinlock *prev;
-
-	/* Init node */
-	node->locked = 0;
-	node->next   = NULL;
-
-	/*
-	 * We rely on the full barrier with global transitivity implied by the
-	 * below xchg() to order the initialization stores above against any
-	 * observation of @node. And to provide the ACQUIRE ordering associated
-	 * with a LOCK primitive.
-	 */
-	prev = xchg(lock, node);
-	if (likely(prev == NULL)) {
-		/*
-		 * Lock acquired, don't need to set node->locked to 1. Threads
-		 * only spin on its own node->locked value for lock acquisition.
-		 * However, since this thread can immediately acquire the lock
-		 * and does not proceed to spin on its own node->locked, this
-		 * value won't be used. If a debug mode is needed to
-		 * audit lock status, then set node->locked value here.
-		 */
-		return;
-	}
-	WRITE_ONCE(prev->next, node);
-
-	/* Wait until the lock holder passes the lock down. */
-	arch_mcs_spin_lock_contended(&node->locked);
-}
-
-/*
- * Releases the lock. The caller should pass in the corresponding node that
- * was used to acquire the lock.
- */
-static inline
-void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
-{
-	struct mcs_spinlock *next = READ_ONCE(node->next);
-
-	if (likely(!next)) {
-		/*
-		 * Release the lock by setting it to NULL
-		 */
-		if (likely(cmpxchg_release(lock, node, NULL) == node))
-			return;
-		/* Wait until the next pointer is set */
-		while (!(next = READ_ONCE(node->next)))
-			cpu_relax();
-	}
-
-	/* Pass lock to next waiter. */
-	arch_mcs_spin_unlock_contended(&next->locked);
-}
-
-#endif /* __LINUX_MCS_SPINLOCK_H */
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index a0fc21d99199..32f401e966ab 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -66,11 +66,10 @@
  *
  */
 
-#include "mcs_spinlock.h"
 #define MAX_NODES	4
 
 /*
- * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
+ * On 64-bit architectures, the qnode structure will be 16 bytes in
  * size and four of them will fit nicely in one 64-byte cacheline. For
  * pvqspinlock, however, we need more space for extra data. To accommodate
  * that, we insert two more long words to pad it up to 32 bytes. IOW, only
@@ -80,7 +79,9 @@
  * qspinlocks.
  */
 struct qnode {
-	struct mcs_spinlock mcs;
+	struct qnode *next;
+	int locked; /* 1 if lock acquired */
+	int count;  /* nesting count */
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 	int			cpu;
 	u8			state;
@@ -124,18 +125,18 @@ static inline __pure u32 encode_tail(int cpu, int idx)
 	return tail;
 }
 
-static inline __pure struct mcs_spinlock *decode_tail(u32 tail)
+static inline __pure struct qnode *decode_tail(u32 tail)
 {
 	int cpu = (tail >> _Q_TAIL_CPU_OFFSET) - 1;
 	int idx = (tail &  _Q_TAIL_IDX_MASK) >> _Q_TAIL_IDX_OFFSET;
 
-	return per_cpu_ptr(&qnodes[idx].mcs, cpu);
+	return per_cpu_ptr(&qnodes[idx], cpu);
 }
 
 static inline __pure
-struct mcs_spinlock *grab_mcs_node(struct mcs_spinlock *base, int idx)
+struct qnode *grab_qnode(struct qnode *base, int idx)
 {
-	return &((struct qnode *)base + idx)->mcs;
+	return &base[idx];
 }
 
 #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
@@ -271,13 +272,13 @@ static __always_inline void set_locked(struct qspinlock *lock)
  * all the PV callbacks.
  */
 
-static __always_inline void __pv_init_node(struct mcs_spinlock *node) { }
-static __always_inline void __pv_wait_node(struct mcs_spinlock *node,
-					   struct mcs_spinlock *prev) { }
+static __always_inline void __pv_init_node(struct qnode *node) { }
+static __always_inline void __pv_wait_node(struct qnode *node,
+					   struct qnode *prev) { }
 static __always_inline void __pv_kick_node(struct qspinlock *lock,
-					   struct mcs_spinlock *node) { }
+					   struct qnode *node) { }
 static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
-						   struct mcs_spinlock *node)
+						   struct qnode *node)
 						   { return 0; }
 
 #define pv_enabled()		false
@@ -316,7 +317,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
  */
 void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
-	struct mcs_spinlock *prev, *next, *node;
+	struct qnode *prev, *next, *node;
 	u32 old, tail;
 	int idx;
 
@@ -399,7 +400,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 queue:
 	lockevent_inc(lock_slowpath);
 pv_queue:
-	node = this_cpu_ptr(&qnodes[0].mcs);
+	node = this_cpu_ptr(&qnodes[0]);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
 
@@ -421,7 +422,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		goto release;
 	}
 
-	node = grab_mcs_node(node, idx);
+	node = grab_qnode(node, idx);
 
 	/*
 	 * Keep counts of non-zero index values:
@@ -475,7 +476,8 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		WRITE_ONCE(prev->next, node);
 
 		pv_wait_node(node, prev);
-		arch_mcs_spin_lock_contended(&node->locked);
+		/* Wait for mcs node lock to be released */
+		smp_cond_load_acquire(&node->locked, VAL);
 
 		/*
 		 * While waiting for the MCS lock, the next pointer may have
@@ -554,7 +556,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	if (!next)
 		next = smp_cond_load_relaxed(&node->next, (VAL));
 
-	arch_mcs_spin_unlock_contended(&next->locked);
+	smp_store_release(&next->locked, 1); /* unlock the mcs node lock */
 	pv_kick_node(lock, next);
 
 release:
@@ -563,7 +565,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/*
 	 * release the node
 	 */
-	__this_cpu_dec(qnodes[0].mcs.count);
+	__this_cpu_dec(qnodes[0].count);
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 4efe00e6b441..cce3d3dde216 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -267,14 +267,12 @@ pv_wait_early(struct qnode *prev, int loop)
 }
 
 /*
- * Initialize the PV part of the mcs_spinlock node.
+ * Initialize the PV part of the qnode.
  */
-static void pv_init_node(struct mcs_spinlock *node)
+static void pv_init_node(struct qnode *node)
 {
-	struct qnode *pn = (struct qnode *)node;
-
-	pn->cpu = smp_processor_id();
-	pn->state = vcpu_running;
+	node->cpu = smp_processor_id();
+	node->state = vcpu_running;
 }
 
 /*
@@ -282,10 +280,8 @@ static void pv_init_node(struct mcs_spinlock *node)
  * pv_kick_node() is used to set _Q_SLOW_VAL and fill in hash table on its
  * behalf.
  */
-static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
+static void pv_wait_node(struct qnode *node, struct qnode *prev)
 {
-	struct qnode *pn = (struct qnode *)node;
-	struct qnode *pp = (struct qnode *)prev;
 	int loop;
 	bool wait_early;
 
@@ -293,7 +289,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 		for (wait_early = false, loop = SPIN_THRESHOLD; loop; loop--) {
 			if (READ_ONCE(node->locked))
 				return;
-			if (pv_wait_early(pp, loop)) {
+			if (pv_wait_early(prev, loop)) {
 				wait_early = true;
 				break;
 			}
@@ -301,20 +297,20 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 		}
 
 		/*
-		 * Order pn->state vs pn->locked thusly:
+		 * Order node->state vs node->locked thusly:
 		 *
-		 * [S] pn->state = vcpu_halted	  [S] next->locked = 1
-		 *     MB			      MB
-		 * [L] pn->locked		[RmW] pn->state = vcpu_hashed
+		 * [S] node->state = vcpu_halted  [S] next->locked = 1
+		 *     MB                             MB
+		 * [L] node->locked             [RmW] node->state = vcpu_hashed
 		 *
 		 * Matches the cmpxchg() from pv_kick_node().
 		 */
-		smp_store_mb(pn->state, vcpu_halted);
+		smp_store_mb(node->state, vcpu_halted);
 
 		if (!READ_ONCE(node->locked)) {
 			lockevent_inc(pv_wait_node);
 			lockevent_cond_inc(pv_wait_early, wait_early);
-			pv_wait(&pn->state, vcpu_halted);
+			pv_wait(&node->state, vcpu_halted);
 		}
 
 		/*
@@ -322,7 +318,7 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
 		 * value so that pv_wait_head_or_lock() knows to not also try
 		 * to hash this lock.
 		 */
-		cmpxchg(&pn->state, vcpu_halted, vcpu_running);
+		cmpxchg(&node->state, vcpu_halted, vcpu_running);
 
 		/*
 		 * If the locked flag is still not set after wakeup, it is a
@@ -349,10 +345,8 @@ static void pv_wait_node(struct mcs_spinlock *node, struct mcs_spinlock *prev)
  * such that they're waiting in pv_wait_head_or_lock(), this avoids a
  * wake/sleep cycle.
  */
-static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
+static void pv_kick_node(struct qspinlock *lock, struct qnode *node)
 {
-	struct qnode *pn = (struct qnode *)node;
-
 	/*
 	 * If the vCPU is indeed halted, advance its state to match that of
 	 * pv_wait_node(). If OTOH this fails, the vCPU was running and will
@@ -361,15 +355,15 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * Matches with smp_store_mb() and cmpxchg() in pv_wait_node()
 	 *
 	 * The write to next->locked in arch_mcs_spin_unlock_contended()
-	 * must be ordered before the read of pn->state in the cmpxchg()
+	 * must be ordered before the read of node->state in the cmpxchg()
 	 * below for the code to work correctly. To guarantee full ordering
 	 * irrespective of the success or failure of the cmpxchg(),
 	 * a relaxed version with explicit barrier is used. The control
-	 * dependency will order the reading of pn->state before any
+	 * dependency will order the reading of node->state before any
 	 * subsequent writes.
 	 */
 	smp_mb__before_atomic();
-	if (cmpxchg_relaxed(&pn->state, vcpu_halted, vcpu_hashed)
+	if (cmpxchg_relaxed(&node->state, vcpu_halted, vcpu_hashed)
 	    != vcpu_halted)
 		return;
 
@@ -381,7 +375,7 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * needed.
 	 */
 	WRITE_ONCE(lock->locked, _Q_SLOW_VAL);
-	(void)pv_hash(lock, pn);
+	(void)pv_hash(lock, node);
 }
 
 /*
@@ -392,9 +386,8 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
  * The current value of the lock will be returned for additional processing.
  */
 static u32
-pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
+pv_wait_head_or_lock(struct qspinlock *lock, struct qnode *node)
 {
-	struct qnode *pn = (struct qnode *)node;
 	struct qspinlock **lp = NULL;
 	int waitcnt = 0;
 	int loop;
@@ -403,7 +396,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 	 * If pv_kick_node() already advanced our state, we don't need to
 	 * insert ourselves into the hash table anymore.
 	 */
-	if (READ_ONCE(pn->state) == vcpu_hashed)
+	if (READ_ONCE(node->state) == vcpu_hashed)
 		lp = (struct qspinlock **)1;
 
 	/*
@@ -416,7 +409,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 		 * Set correct vCPU state to be used by queue node wait-early
 		 * mechanism.
 		 */
-		WRITE_ONCE(pn->state, vcpu_running);
+		WRITE_ONCE(node->state, vcpu_running);
 
 		/*
 		 * Set the pending bit in the active lock spinning loop to
@@ -432,7 +425,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 
 
 		if (!lp) { /* ONCE */
-			lp = pv_hash(lock, pn);
+			lp = pv_hash(lock, node);
 
 			/*
 			 * We must hash before setting _Q_SLOW_VAL, such that
@@ -456,7 +449,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 				goto gotlock;
 			}
 		}
-		WRITE_ONCE(pn->state, vcpu_hashed);
+		WRITE_ONCE(node->state, vcpu_hashed);
 		lockevent_inc(pv_wait_head);
 		lockevent_cond_inc(pv_wait_again, waitcnt);
 		pv_wait(&lock->locked, _Q_SLOW_VAL);
-- 
2.35.1

