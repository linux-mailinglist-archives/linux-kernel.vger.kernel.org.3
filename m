Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA1C507D52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358462AbiDSXtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358119AbiDSXt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE9E0D3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:46:41 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650411999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gV1NPvhWqevaLDnsto21jSgZ5z3UMPKT9ZDyF4NUDjI=;
        b=JbVvZ61g94jvZo5QB2i9Oabx1UF6slRGru0piZbgE2YP9FsJ+KyQSzF5bJry4iJDtljHu4
        MKEK3MjyVpME2CtM8HsKacejtuF+J+/4QZbmZyvDWFx7O7yhr3Lm9bRfSdZOXpft08ediJ
        vY6fuTMkPLFpWZ6RqiOGeihmWDp+hY2XB4PYrFNY6YW6ACb9OZrREnGAHG9SqVWu3ytkMr
        k89CI4a7rBe+LVsq+3Gdlxt4lQqwRv8UIClb2bxKBFzX2izr6usLWFEOIHdfpr6XT9Uyn4
        DXZyNd4dweOsk7UwxA5hdMI8dyiKLnYLKiFbO3VtCn3PNTFhItegdIfXtnxtog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650411999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gV1NPvhWqevaLDnsto21jSgZ5z3UMPKT9ZDyF4NUDjI=;
        b=xWgRHLC3d9kfrjKbloMittILjeex3JSk9C7+jk5xN8/siGnk1uSlevOilzBkzgibl0J6Mz
        DU5VTDoELHth3zCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH printk v3 01/15] printk: rename cpulock functions
Date:   Wed, 20 Apr 2022 01:52:23 +0206
Message-Id: <20220419234637.357112-2-john.ogness@linutronix.de>
In-Reply-To: <20220419234637.357112-1-john.ogness@linutronix.de>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the printk cpulock is CPU-reentrant and since it is used
in all contexts, its usage must be carefully considered and
most likely will require programming locklessly. To avoid
mistaking the printk cpulock as a typical lock, rename it to
cpu_sync. The main functions then become:

    printk_cpu_sync_get_irqsave(flags);
    printk_cpu_sync_put_irqrestore(flags);

Add extra notes of caution in the function description to help
developers understand the requirements for correct usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h | 54 +++++++++++++++++++-------------
 kernel/printk/printk.c | 71 +++++++++++++++++++++---------------------
 lib/dump_stack.c       |  4 +--
 lib/nmi_backtrace.c    |  4 +--
 4 files changed, 73 insertions(+), 60 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 1522df223c0f..859323a52985 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -277,43 +277,55 @@ static inline void printk_trigger_flush(void)
 #endif
 
 #ifdef CONFIG_SMP
-extern int __printk_cpu_trylock(void);
-extern void __printk_wait_on_cpu_lock(void);
-extern void __printk_cpu_unlock(void);
+extern int __printk_cpu_sync_try_get(void);
+extern void __printk_cpu_sync_wait(void);
+extern void __printk_cpu_sync_put(void);
 
 /**
- * printk_cpu_lock_irqsave() - Acquire the printk cpu-reentrant spinning
- *                             lock and disable interrupts.
+ * printk_cpu_sync_get_irqsave() - Acquire the printk cpu-reentrant spinning
+ *                                 lock and disable interrupts.
  * @flags: Stack-allocated storage for saving local interrupt state,
- *         to be passed to printk_cpu_unlock_irqrestore().
+ *         to be passed to printk_cpu_sync_put_irqrestore().
  *
  * If the lock is owned by another CPU, spin until it becomes available.
  * Interrupts are restored while spinning.
+ *
+ * CAUTION: This function must be used carefully. It does not behave like a
+ * typical lock. Here are important things to watch out for...
+ *
+ *     * This function is reentrant on the same CPU. Therefore the calling
+ *       code must not assume exclusive access to data if code accessing the
+ *       data can run reentrant or within NMI context on the same CPU.
+ *
+ *     * If there exists usage of this function from NMI context, it becomes
+ *       unsafe to perform any type of locking or spinning to wait for other
+ *       CPUs after calling this function from any context. This includes
+ *       using spinlocks or any other busy-waiting synchronization methods.
  */
-#define printk_cpu_lock_irqsave(flags)		\
-	for (;;) {				\
-		local_irq_save(flags);		\
-		if (__printk_cpu_trylock())	\
-			break;			\
-		local_irq_restore(flags);	\
-		__printk_wait_on_cpu_lock();	\
+#define printk_cpu_sync_get_irqsave(flags)		\
+	for (;;) {					\
+		local_irq_save(flags);			\
+		if (__printk_cpu_sync_try_get())	\
+			break;				\
+		local_irq_restore(flags);		\
+		__printk_cpu_sync_wait();		\
 	}
 
 /**
- * printk_cpu_unlock_irqrestore() - Release the printk cpu-reentrant spinning
- *                                  lock and restore interrupts.
- * @flags: Caller's saved interrupt state, from printk_cpu_lock_irqsave().
+ * printk_cpu_sync_put_irqrestore() - Release the printk cpu-reentrant spinning
+ *                                    lock and restore interrupts.
+ * @flags: Caller's saved interrupt state, from printk_cpu_sync_get_irqsave().
  */
-#define printk_cpu_unlock_irqrestore(flags)	\
+#define printk_cpu_sync_put_irqrestore(flags)	\
 	do {					\
-		__printk_cpu_unlock();		\
+		__printk_cpu_sync_put();	\
 		local_irq_restore(flags);	\
-	} while (0)				\
+	} while (0)
 
 #else
 
-#define printk_cpu_lock_irqsave(flags) ((void)flags)
-#define printk_cpu_unlock_irqrestore(flags) ((void)flags)
+#define printk_cpu_sync_get_irqsave(flags) ((void)flags)
+#define printk_cpu_sync_put_irqrestore(flags) ((void)flags)
 
 #endif /* CONFIG_SMP */
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index da03c15ecc89..13a1eebe72af 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3667,26 +3667,26 @@ EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 #endif
 
 #ifdef CONFIG_SMP
-static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
-static atomic_t printk_cpulock_nested = ATOMIC_INIT(0);
+static atomic_t printk_cpu_sync_owner = ATOMIC_INIT(-1);
+static atomic_t printk_cpu_sync_nested = ATOMIC_INIT(0);
 
 /**
- * __printk_wait_on_cpu_lock() - Busy wait until the printk cpu-reentrant
- *                               spinning lock is not owned by any CPU.
+ * __printk_cpu_sync_wait() - Busy wait until the printk cpu-reentrant
+ *                            spinning lock is not owned by any CPU.
  *
  * Context: Any context.
  */
-void __printk_wait_on_cpu_lock(void)
+void __printk_cpu_sync_wait(void)
 {
 	do {
 		cpu_relax();
-	} while (atomic_read(&printk_cpulock_owner) != -1);
+	} while (atomic_read(&printk_cpu_sync_owner) != -1);
 }
-EXPORT_SYMBOL(__printk_wait_on_cpu_lock);
+EXPORT_SYMBOL(__printk_cpu_sync_wait);
 
 /**
- * __printk_cpu_trylock() - Try to acquire the printk cpu-reentrant
- *                          spinning lock.
+ * __printk_cpu_sync_try_get() - Try to acquire the printk cpu-reentrant
+ *                               spinning lock.
  *
  * If no processor has the lock, the calling processor takes the lock and
  * becomes the owner. If the calling processor is already the owner of the
@@ -3695,7 +3695,7 @@ EXPORT_SYMBOL(__printk_wait_on_cpu_lock);
  * Context: Any context. Expects interrupts to be disabled.
  * Return: 1 on success, otherwise 0.
  */
-int __printk_cpu_trylock(void)
+int __printk_cpu_sync_try_get(void)
 {
 	int cpu;
 	int old;
@@ -3705,79 +3705,80 @@ int __printk_cpu_trylock(void)
 	/*
 	 * Guarantee loads and stores from this CPU when it is the lock owner
 	 * are _not_ visible to the previous lock owner. This pairs with
-	 * __printk_cpu_unlock:B.
+	 * __printk_cpu_sync_put:B.
 	 *
 	 * Memory barrier involvement:
 	 *
-	 * If __printk_cpu_trylock:A reads from __printk_cpu_unlock:B, then
-	 * __printk_cpu_unlock:A can never read from __printk_cpu_trylock:B.
+	 * If __printk_cpu_sync_try_get:A reads from __printk_cpu_sync_put:B,
+	 * then __printk_cpu_sync_put:A can never read from
+	 * __printk_cpu_sync_try_get:B.
 	 *
 	 * Relies on:
 	 *
-	 * RELEASE from __printk_cpu_unlock:A to __printk_cpu_unlock:B
+	 * RELEASE from __printk_cpu_sync_put:A to __printk_cpu_sync_put:B
 	 * of the previous CPU
 	 *    matching
-	 * ACQUIRE from __printk_cpu_trylock:A to __printk_cpu_trylock:B
-	 * of this CPU
+	 * ACQUIRE from __printk_cpu_sync_try_get:A to
+	 * __printk_cpu_sync_try_get:B of this CPU
 	 */
-	old = atomic_cmpxchg_acquire(&printk_cpulock_owner, -1,
-				     cpu); /* LMM(__printk_cpu_trylock:A) */
+	old = atomic_cmpxchg_acquire(&printk_cpu_sync_owner, -1,
+				     cpu); /* LMM(__printk_cpu_sync_try_get:A) */
 	if (old == -1) {
 		/*
 		 * This CPU is now the owner and begins loading/storing
-		 * data: LMM(__printk_cpu_trylock:B)
+		 * data: LMM(__printk_cpu_sync_try_get:B)
 		 */
 		return 1;
 
 	} else if (old == cpu) {
 		/* This CPU is already the owner. */
-		atomic_inc(&printk_cpulock_nested);
+		atomic_inc(&printk_cpu_sync_nested);
 		return 1;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL(__printk_cpu_trylock);
+EXPORT_SYMBOL(__printk_cpu_sync_try_get);
 
 /**
- * __printk_cpu_unlock() - Release the printk cpu-reentrant spinning lock.
+ * __printk_cpu_sync_put() - Release the printk cpu-reentrant spinning lock.
  *
  * The calling processor must be the owner of the lock.
  *
  * Context: Any context. Expects interrupts to be disabled.
  */
-void __printk_cpu_unlock(void)
+void __printk_cpu_sync_put(void)
 {
-	if (atomic_read(&printk_cpulock_nested)) {
-		atomic_dec(&printk_cpulock_nested);
+	if (atomic_read(&printk_cpu_sync_nested)) {
+		atomic_dec(&printk_cpu_sync_nested);
 		return;
 	}
 
 	/*
 	 * This CPU is finished loading/storing data:
-	 * LMM(__printk_cpu_unlock:A)
+	 * LMM(__printk_cpu_sync_put:A)
 	 */
 
 	/*
 	 * Guarantee loads and stores from this CPU when it was the
 	 * lock owner are visible to the next lock owner. This pairs
-	 * with __printk_cpu_trylock:A.
+	 * with __printk_cpu_sync_try_get:A.
 	 *
 	 * Memory barrier involvement:
 	 *
-	 * If __printk_cpu_trylock:A reads from __printk_cpu_unlock:B,
-	 * then __printk_cpu_trylock:B reads from __printk_cpu_unlock:A.
+	 * If __printk_cpu_sync_try_get:A reads from __printk_cpu_sync_put:B,
+	 * then __printk_cpu_sync_try_get:B reads from __printk_cpu_sync_put:A.
 	 *
 	 * Relies on:
 	 *
-	 * RELEASE from __printk_cpu_unlock:A to __printk_cpu_unlock:B
+	 * RELEASE from __printk_cpu_sync_put:A to __printk_cpu_sync_put:B
 	 * of this CPU
 	 *    matching
-	 * ACQUIRE from __printk_cpu_trylock:A to __printk_cpu_trylock:B
-	 * of the next CPU
+	 * ACQUIRE from __printk_cpu_sync_try_get:A to
+	 * __printk_cpu_sync_try_get:B of the next CPU
 	 */
-	atomic_set_release(&printk_cpulock_owner,
-			   -1); /* LMM(__printk_cpu_unlock:B) */
+	atomic_set_release(&printk_cpu_sync_owner,
+			   -1); /* LMM(__printk_cpu_sync_put:B) */
 }
-EXPORT_SYMBOL(__printk_cpu_unlock);
+EXPORT_SYMBOL(__printk_cpu_sync_put);
 #endif /* CONFIG_SMP */
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 6b7f1bf6715d..83471e81501a 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -102,9 +102,9 @@ asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 	 * Permit this cpu to perform nested stack dumps while serialising
 	 * against other CPUs
 	 */
-	printk_cpu_lock_irqsave(flags);
+	printk_cpu_sync_get_irqsave(flags);
 	__dump_stack(log_lvl);
-	printk_cpu_unlock_irqrestore(flags);
+	printk_cpu_sync_put_irqrestore(flags);
 }
 EXPORT_SYMBOL(dump_stack_lvl);
 
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 199ab201d501..d01aec6ae15c 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -99,7 +99,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 		 * Allow nested NMI backtraces while serializing
 		 * against other CPUs.
 		 */
-		printk_cpu_lock_irqsave(flags);
+		printk_cpu_sync_get_irqsave(flags);
 		if (!READ_ONCE(backtrace_idle) && regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at %pS\n",
 				cpu, (void *)instruction_pointer(regs));
@@ -110,7 +110,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 			else
 				dump_stack();
 		}
-		printk_cpu_unlock_irqrestore(flags);
+		printk_cpu_sync_put_irqrestore(flags);
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
-- 
2.30.2

