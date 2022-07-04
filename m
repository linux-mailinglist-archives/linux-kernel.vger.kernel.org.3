Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597875658D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbiGDOj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbiGDOjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:39:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D96E031
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:38:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so13942228pjl.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=owwlOHOM/M2Hjs70rPTtHe++aJyVN3o8w2pwCkxxqq0=;
        b=MrbOx9tzCae265g71lGO2iWt1p6ZUOflc/eX6CAA6Hboid4BHQsTVTzNHDDWtjlfn8
         lczlWxDAay456EV3swF5HYHGy0zc6NKrXtZSUttM5i20IMVAv1j/K1L08DDmgOcbvNcI
         JOz8EFmaX4ORJlNBZe5zul6voC07gE0LLkIRPaEwcKwJgBhcQR4AzkXefuNCPJY0ILzk
         sFV/qrHHaE0nRqcaWqdq+d1Le2sSe3BnqM3QSTtSrlz8cXQjkDvCCJkAqOPMNcZbyYzd
         UL677s5D0pTr+dMe11UCbMYwLnfwbt7zR52oFEF8QdUAc2fbDdAkEun/FW27skCj9b3v
         BaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=owwlOHOM/M2Hjs70rPTtHe++aJyVN3o8w2pwCkxxqq0=;
        b=Y2V7SbscJ1PH3emBITS8J+Cpn4smrWMzkCtEMTh2phy4fh+IXv3QjJ8psvQsrIUnGM
         86TDW+mOtC8bE1A+eLr4ZfVn9133dASmxcN+P9oNPE5tIS7kfWZkMH9FzlggAVJezY5z
         Xl+DUdhHn1orjDnf8zJGVF2ZSMi11iTEA+X1/kFpGdF0Bo3/S0tzRojt0QIOF0zv8kmg
         0sGAvXba8kx4na2+ufZsnsV8bNxtA2fBeXgxXw7KVs0XDIoE9gv0KwyOqiCBCGRGVVrw
         fPWsBb8hxD5SkHL01bDiTc3fAeMHNhKe4wJDolsL0ETMBHWn8sz4S3qt1mPnlVzHujHZ
         JHOg==
X-Gm-Message-State: AJIora9tA+HEfM4grZwjodCw8Pwg1+nvbVAUiJF2Dquu2lbM9UMzFQbp
        K/8agvid4KcVyqwMQreTEso=
X-Google-Smtp-Source: AGRyM1sIhLiaNynLLXRi9+Xx5oKQt+1cfdGJOgDFZkSV3sQZrSqGwPIanXXb2CMJoV1P5XmFQXfakA==
X-Received: by 2002:a17:902:ea09:b0:16b:a264:381f with SMTP id s9-20020a170902ea0900b0016ba264381fmr28268635plg.150.1656945534882;
        Mon, 04 Jul 2022 07:38:54 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.221.247.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm20534365pgk.76.2022.07.04.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:38:54 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] locking/qspinlock: remove arch qspinlock_paravirt.h includes
Date:   Tue,  5 Jul 2022 00:38:14 +1000
Message-Id: <20220704143820.3071004-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704143820.3071004-1-npiggin@gmail.com>
References: <20220704143820.3071004-1-npiggin@gmail.com>
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
index 9a235b0d98ca..4045b5683ecb 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -743,16 +743,6 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
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
@@ -769,6 +759,7 @@ __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
 
 	__pv_queued_spin_unlock_slowpath(lock, locked);
 }
+EXPORT_SYMBOL(__pv_queued_spin_unlock);
 #endif
 
 #else /* CONFIG_PARAVIRT_SPINLOCKS */
-- 
2.35.1

