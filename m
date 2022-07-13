Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93B572ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiGMHIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbiGMHHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:07:53 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8C7E2A3C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:43 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f11so8797615pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z/StboqhuAVzEvcv+05Dw1pybR79zS+xo0AFlQGPzP8=;
        b=TH0MUr1aNtyAMw5tSlehWZRh+7Dwpmv7dYTvzkB6Og/JgZMsPhhuKnPSpAmpfSnxOQ
         xEmwoGJKJ5ooIFWRrlnNUbLyP7cktvAbUEAV2zqvNf+naGGFD7iJiHbEaqHYXZywYVtr
         znxF35xwlP8rpGiHjZabGnf+E7vFcBU+0xejOO97EVaBAptdH4G5fM/PA547dXji+DMU
         2sDRmJx+G/7sSuwcFDLD1/Q1LLP8ZsS74kjq+UINqiTy81HAWVHsvQxs/aAqmYyR/2AX
         fqDgIbf1rd1UgUnktVRfEDViffKg/FrXYlDCwCjPjs2UGkHjE1oZWwYkXm1Crmm2DxKC
         8jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/StboqhuAVzEvcv+05Dw1pybR79zS+xo0AFlQGPzP8=;
        b=2XhPa7qM320e7zWm+tvfaasc8TseNY+oqRd1Hi2vhsHMfY7pQaO4DhijYTdfhiHHNE
         FTNfI0DxgGsfb3AEIgRsWYWgPs2x9RmU3BRJBDYTR6Fdn/PNTK7DXtDWIyCPVbazVadm
         f225VtB5xh89bEJYcvm4wfylisyfhaHAbJsLAgNOWFN4AEcC8DSbwXTsDhwR02+JN0rg
         nEFgOaAWXBYJSq1yWZW61lMY0j9qU7yx7sGQ5jMNtRrkmC7jXmmRDNua7ue5a5WqOVpt
         nH68nSj7YIJctBH5vP63ijUhDkbhQyMSAnyYISRvSmuljHRlmOBMJqCmHGHl2pOJDkCi
         MwsQ==
X-Gm-Message-State: AJIora9y8QcFfAk+kP2Jn606ucoR2y2wvA8mk/RXS5dGL8qE7eOb4H0X
        sGiIrCRgGxutW4qROLdfIS0=
X-Google-Smtp-Source: AGRyM1sfD8hVaoeySN4D+3rQDwl261LpD8XlDUAAPXJ4cQBBc6eg8djSe9XjO0svThhDniwPqOxaJA==
X-Received: by 2002:a62:79d7:0:b0:52a:b557:2796 with SMTP id u206-20020a6279d7000000b0052ab5572796mr1969465pfc.34.1657696062459;
        Wed, 13 Jul 2022 00:07:42 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b0016bd5da20casm8099061plg.134.2022.07.13.00.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:07:42 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/12] locking/qspinlock: stop renaming queued_spin_lock_slowpath to native_queued_spin_lock_slowpath
Date:   Wed, 13 Jul 2022 17:07:00 +1000
Message-Id: <20220713070704.308394-9-npiggin@gmail.com>
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

The native version can simply be queued_spin_lock_slowpath, and the
paravirt version __pv_queued_spin_lock_slowpath, which is as they are
named in the C code.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/qspinlock.h | 38 ++++++++++------------------
 arch/x86/include/asm/qspinlock.h     | 14 +++++++---
 arch/x86/kernel/paravirt.c           |  2 +-
 kernel/locking/qspinlock.c           |  8 +-----
 4 files changed, 26 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index b676c4fb90fd..dd231c756233 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -7,42 +7,32 @@
 
 #define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
 
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
-extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
-extern void __pv_queued_spin_unlock(struct qspinlock *lock);
+void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+void __pv_queued_spin_unlock(struct qspinlock *lock);
 
-static __always_inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
-	if (!is_shared_processor())
-		native_queued_spin_lock_slowpath(lock, val);
+	u32 val = 0;
+
+	if (likely(arch_atomic_try_cmpxchg_lock(&lock->val, &val, _Q_LOCKED_VAL)))
+		return;
+
+	if (!IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) || !is_shared_processor())
+		queued_spin_lock_slowpath(lock, val);
 	else
 		__pv_queued_spin_lock_slowpath(lock, val);
 }
+#define queued_spin_lock queued_spin_lock
 
-#define queued_spin_unlock queued_spin_unlock
 static inline void queued_spin_unlock(struct qspinlock *lock)
 {
-	if (!is_shared_processor())
+	if (!IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) || !is_shared_processor())
 		smp_store_release(&lock->locked, 0);
 	else
 		__pv_queued_spin_unlock(lock);
 }
-
-#else
-extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
-#endif
-
-static __always_inline void queued_spin_lock(struct qspinlock *lock)
-{
-	u32 val = 0;
-
-	if (likely(arch_atomic_try_cmpxchg_lock(&lock->val, &val, _Q_LOCKED_VAL)))
-		return;
-
-	queued_spin_lock_slowpath(lock, val);
-}
-#define queued_spin_lock queued_spin_lock
+#define queued_spin_unlock queued_spin_unlock
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 #define SPIN_THRESHOLD (1<<15) /* not tuned */
diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 7f914fe7bc30..603ad61e9dfe 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -28,7 +28,7 @@ static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lo
 }
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
-extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_init_lock_hash(void);
 extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __raw_callee_save___pv_queued_spin_unlock(struct qspinlock *lock);
@@ -38,7 +38,6 @@ extern bool nopvspin;
 #define __pv_queued_spin_unlock	__pv_queued_spin_unlock
 #endif
 
-#define	queued_spin_unlock queued_spin_unlock
 /**
  * queued_spin_unlock - release a queued spinlock
  * @lock : Pointer to queued spinlock structure
@@ -50,22 +49,29 @@ static inline void native_queued_spin_unlock(struct qspinlock *lock)
 	smp_store_release(&lock->locked, 0);
 }
 
-static inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+static inline void queued_spin_lock(struct qspinlock *lock)
 {
+	int val = 0;
+
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
+		return;
+
 	pv_queued_spin_lock_slowpath(lock, val);
 }
+#define queued_spin_lock queued_spin_lock
 
 static inline void queued_spin_unlock(struct qspinlock *lock)
 {
 	kcsan_release();
 	pv_queued_spin_unlock(lock);
 }
+#define	queued_spin_unlock queued_spin_unlock
 
-#define vcpu_is_preempted vcpu_is_preempted
 static inline bool vcpu_is_preempted(long cpu)
 {
 	return pv_vcpu_is_preempted(cpu);
 }
+#define vcpu_is_preempted vcpu_is_preempted
 #endif
 
 #ifdef CONFIG_PARAVIRT
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 7ca2d46c08cc..f03e2962afa8 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -384,7 +384,7 @@ struct paravirt_patch_template pv_ops = {
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
 	/* Lock ops. */
 #ifdef CONFIG_SMP
-	.lock.queued_spin_lock_slowpath	= native_queued_spin_lock_slowpath,
+	.lock.queued_spin_lock_slowpath	= queued_spin_lock_slowpath,
 	.lock.queued_spin_unlock	=
 				PV_CALLEE_SAVE(__native_queued_spin_unlock),
 	.lock.wait			= paravirt_nop,
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index c4f223a03345..4785a32a6fd2 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -297,8 +297,7 @@ static __always_inline void set_locked(struct qspinlock *lock)
  *   pv_kick(cpu)             -- wakes a suspended vcpu
  *
  * Using these we implement __pv_queued_spin_lock_slowpath() and
- * __pv_queued_spin_unlock() to replace native_queued_spin_lock_slowpath() and
- * native_queued_spin_unlock().
+ * __pv_queued_spin_unlock().
  */
 
 #define _Q_SLOW_VAL	(3U << _Q_LOCKED_OFFSET)
@@ -988,10 +987,6 @@ static __always_inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, b
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-#define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
-#endif
-
 void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
 	if (virt_spin_lock(lock))
@@ -1072,7 +1067,6 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
-#undef queued_spin_lock_slowpath
 void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
 	queued_spin_lock_mcs_queue(lock, true);
-- 
2.35.1

