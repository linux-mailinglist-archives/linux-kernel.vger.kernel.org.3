Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9087A572ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiGMHIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiGMHHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:07:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD88E2A1E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fz10so10780921pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=905v9R4P6Da5F35eFheoGycTQtObbagfCZ0iYpTk9DM=;
        b=O5wPRgxh6AUMXh5KXFNWpXzVEohOrNZN1hpsbQ/d9isZFDvkrJBR14fMJYpirIxNBJ
         FXcPS84eAHjysEkcEMsM70Gj3ADdxN50J1uxKl/t9N5m+wO4XOlFw6O3Asj6tLtOwRkN
         a5wlPcLEcRZmM0tCDyZnFGaNk5kZ7e3App6DY3Z2oWbSZ4I8RSVBrbqX/bc3McqOHsCA
         n4BXNhyVJ0yrAMKNRkRbtUdkBu3/QnUeWDL1GyxUI6pwNXVOljakkbwSREomxWk17h1R
         ULY6pc6iljbzv1k3kkf5Rrh0whVMI4vnmP7peHI8oJg5/Vq7ullVez6BS1sIU52ciIKr
         hSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=905v9R4P6Da5F35eFheoGycTQtObbagfCZ0iYpTk9DM=;
        b=NItSOGCJG7k9XF2fI1oteazKOV9M0eQpPOR7YL5jPzXsqiGrIPOeR+rbT67PXbktI+
         VCzwLHWH19pIeE8IhOB0+NBz0ER0Tv4enww762++mpoIA8oBj4470wlJRf/MBuvSGD/6
         AJb9i6tAbaFaCxieeMh0/JkIjx8s/ynT9TguaW2lej1I8sfnzfaLFPxhlCt3cSVlKqgB
         OZPUydhA0vZG7YlchbPaZm+ou0ATBZ/pV2OWFvTbm3y/XddBnOOMTGprB7xrRUv0AlZ/
         RqVsTuRETH07dss2oAV5xInB3SnYJCNsliNoZoEm1SKYXjxT1ME5CsRide4eXH61KyoB
         peWg==
X-Gm-Message-State: AJIora/ZT1iQrImaxxYzmq9BC9gi1jW0VFrQeKdUKFUFkIaLz3NkMicD
        EC/uhXgfn1vcnbe+99jcA6I=
X-Google-Smtp-Source: AGRyM1seMTDgf+6u/eAsASyNugn+q6giry6nouDYpAVkgpwOD2kiI5YYhma8MdWeBzAGpN7KQwuitg==
X-Received: by 2002:a17:902:f544:b0:16c:5119:d4c2 with SMTP id h4-20020a170902f54400b0016c5119d4c2mr1806894plf.1.1657696058723;
        Wed, 13 Jul 2022 00:07:38 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b0016bd5da20casm8099061plg.134.2022.07.13.00.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:07:38 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/12] locking/qspinlock: remove arch qspinlock_paravirt.h includes
Date:   Wed, 13 Jul 2022 17:06:59 +1000
Message-Id: <20220713070704.308394-8-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/qspinlock_paravirt.h |  7 --
 arch/x86/include/asm/qspinlock.h              |  4 ++
 arch/x86/include/asm/qspinlock_paravirt.h     | 72 -------------------
 arch/x86/kernel/paravirt-spinlocks.c          | 71 ++++++++++++++++++
 kernel/locking/qspinlock.c                    | 11 +--
 5 files changed, 76 insertions(+), 89 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
 delete mode 100644 arch/x86/include/asm/qspinlock_paravirt.h

diff --git a/arch/powerpc/include/asm/qspinlock_paravirt.h b/arch/powerpc/include/asm/qspinlock_paravirt.h
deleted file mode 100644
index 6b60e7736a47..000000000000
--- a/arch/powerpc/include/asm/qspinlock_paravirt.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _ASM_POWERPC_QSPINLOCK_PARAVIRT_H
-#define _ASM_POWERPC_QSPINLOCK_PARAVIRT_H
-
-EXPORT_SYMBOL(__pv_queued_spin_unlock);
-
-#endif /* _ASM_POWERPC_QSPINLOCK_PARAVIRT_H */
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index d87451df480b..7f914fe7bc30 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -34,6 +34,10 @@ extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
 extern bool nopvspin;
 
+#ifdef CONFIG_64BIT
+#define __pv_queued_spin_unlock	__pv_queued_spin_unlock
+#endif
+
 #define	queued_spin_unlock queued_spin_unlock
 /**
  * queued_spin_unlock - release a queued spinlock
diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
deleted file mode 100644
index 892fd8c3a6f7..000000000000
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ /dev/null
@@ -1,72 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_QSPINLOCK_PARAVIRT_H
-#define __ASM_QSPINLOCK_PARAVIRT_H
-
-#include <asm/ibt.h>
-
-/*
- * For x86-64, PV_CALLEE_SAVE_REGS_THUNK() saves and restores 8 64-bit
- * registers. For i386, however, only 1 32-bit register needs to be saved
- * and restored. So an optimized version of __pv_queued_spin_unlock() is
- * hand-coded for 64-bit, but it isn't worthwhile to do it for 32-bit.
- */
-#ifdef CONFIG_64BIT
-
-PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
-#define __pv_queued_spin_unlock	__pv_queued_spin_unlock
-#define PV_UNLOCK		"__raw_callee_save___pv_queued_spin_unlock"
-#define PV_UNLOCK_SLOWPATH	"__raw_callee_save___pv_queued_spin_unlock_slowpath"
-
-/*
- * Optimized assembly version of __raw_callee_save___pv_queued_spin_unlock
- * which combines the registers saving trunk and the body of the following
- * C code:
- *
- * void __pv_queued_spin_unlock(struct qspinlock *lock)
- * {
- *	u8 lockval = cmpxchg(&lock->locked, _Q_LOCKED_VAL, 0);
- *
- *	if (likely(lockval == _Q_LOCKED_VAL))
- *		return;
- *	pv_queued_spin_unlock_slowpath(lock, lockval);
- * }
- *
- * For x86-64,
- *   rdi = lock              (first argument)
- *   rsi = lockval           (second argument)
- *   rdx = internal variable (set to 0)
- */
-asm    (".pushsection .text;"
-	".globl " PV_UNLOCK ";"
-	".type " PV_UNLOCK ", @function;"
-	".align 4,0x90;"
-	PV_UNLOCK ": "
-	ASM_ENDBR
-	FRAME_BEGIN
-	"push  %rdx;"
-	"mov   $0x1,%eax;"
-	"xor   %edx,%edx;"
-	LOCK_PREFIX "cmpxchg %dl,(%rdi);"
-	"cmp   $0x1,%al;"
-	"jne   .slowpath;"
-	"pop   %rdx;"
-	FRAME_END
-	ASM_RET
-	".slowpath: "
-	"push   %rsi;"
-	"movzbl %al,%esi;"
-	"call " PV_UNLOCK_SLOWPATH ";"
-	"pop    %rsi;"
-	"pop    %rdx;"
-	FRAME_END
-	ASM_RET
-	".size " PV_UNLOCK ", .-" PV_UNLOCK ";"
-	".popsection");
-
-#else /* CONFIG_64BIT */
-
-extern void __pv_queued_spin_unlock(struct qspinlock *lock);
-PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock);
-
-#endif /* CONFIG_64BIT */
-#endif
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 9e1ea99ad9df..c6a107dfe20d 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -7,6 +7,7 @@
 #include <linux/export.h>
 #include <linux/jump_label.h>
 
+#include <asm/ibt.h>
 #include <asm/paravirt.h>
 
 __visible void __native_queued_spin_unlock(struct qspinlock *lock)
@@ -15,6 +16,76 @@ __visible void __native_queued_spin_unlock(struct qspinlock *lock)
 }
 PV_CALLEE_SAVE_REGS_THUNK(__native_queued_spin_unlock);
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+/*
+ * For x86-64, PV_CALLEE_SAVE_REGS_THUNK() saves and restores 8 64-bit
+ * registers. For i386, however, only 1 32-bit register needs to be saved
+ * and restored. So an optimized version of __pv_queued_spin_unlock() is
+ * hand-coded for 64-bit, but it isn't worthwhile to do it for 32-bit.
+ */
+#ifdef CONFIG_64BIT
+
+__visible void
+__pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked);
+
+PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
+#define PV_UNLOCK		"__raw_callee_save___pv_queued_spin_unlock"
+#define PV_UNLOCK_SLOWPATH	"__raw_callee_save___pv_queued_spin_unlock_slowpath"
+
+/*
+ * Optimized assembly version of __raw_callee_save___pv_queued_spin_unlock
+ * which combines the registers saving trunk and the body of the following
+ * C code:
+ *
+ * void __pv_queued_spin_unlock(struct qspinlock *lock)
+ * {
+ *	u8 lockval = cmpxchg(&lock->locked, _Q_LOCKED_VAL, 0);
+ *
+ *	if (likely(lockval == _Q_LOCKED_VAL))
+ *		return;
+ *	pv_queued_spin_unlock_slowpath(lock, lockval);
+ * }
+ *
+ * For x86-64,
+ *   rdi = lock              (first argument)
+ *   rsi = lockval           (second argument)
+ *   rdx = internal variable (set to 0)
+ */
+asm    (".pushsection .text;"
+	".globl " PV_UNLOCK ";"
+	".type " PV_UNLOCK ", @function;"
+	".align 4,0x90;"
+	PV_UNLOCK ": "
+	ASM_ENDBR
+	FRAME_BEGIN
+	"push  %rdx;"
+	"mov   $0x1,%eax;"
+	"xor   %edx,%edx;"
+	LOCK_PREFIX "cmpxchg %dl,(%rdi);"
+	"cmp   $0x1,%al;"
+	"jne   .slowpath;"
+	"pop   %rdx;"
+	FRAME_END
+	ASM_RET
+	".slowpath: "
+	"push   %rsi;"
+	"movzbl %al,%esi;"
+	"call " PV_UNLOCK_SLOWPATH ";"
+	"pop    %rsi;"
+	"pop    %rdx;"
+	FRAME_END
+	ASM_RET
+	".size " PV_UNLOCK ", .-" PV_UNLOCK ";"
+	".popsection");
+
+#else /* CONFIG_64BIT */
+
+extern void __pv_queued_spin_unlock(struct qspinlock *lock);
+PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock);
+
+#endif /* CONFIG_64BIT */
+#endif /* CONFIG_PARAVIRT_SPINLOCKS */
+
 bool pv_is_native_spin_unlock(void)
 {
 	return pv_ops.lock.queued_spin_unlock.func ==
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 3b3663d15402..c4f223a03345 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -745,16 +745,6 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 	pv_kick(node->cpu);
 }
 
-/*
- * Include the architecture specific callee-save thunk of the
- * __pv_queued_spin_unlock(). This thunk is put together with
- * __pv_queued_spin_unlock() to make the callee-save thunk and the real unlock
- * function close to each other sharing consecutive instruction cachelines.
- * Alternatively, architecture specific version of __pv_queued_spin_unlock()
- * can be defined.
- */
-#include <asm/qspinlock_paravirt.h>
-
 #ifndef __pv_queued_spin_unlock
 __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
 {
@@ -771,6 +761,7 @@ __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
 
 	__pv_queued_spin_unlock_slowpath(lock, locked);
 }
+EXPORT_SYMBOL(__pv_queued_spin_unlock);
 #endif
 
 #else /* CONFIG_PARAVIRT_SPINLOCKS */
-- 
2.35.1

