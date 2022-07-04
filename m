Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A843E5658D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiGDOjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiGDOjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:39:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DFCBCAD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:38:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso3599706pjc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oO4F7kwO8y9QHU02QhioohHedy1C18WaXBdKdAF3Ltk=;
        b=Q2peP0gXv+c3eGxO6wDx4MoXp0liVVhjJ31SqnVVaZdghfXRi8RTaTaA9NjDyfdBwx
         J0CZoTJtMqy24sTcyg2aRjefrCwKIoqTDkoAzxby/84hi+67hNbTYSYMAIVaTLui1IyX
         RnPZnKjegeIOOpYcNpGY+rORD37tL4ExnFkpGQNSkV3BSirLzhiYrEPnrkM79B+cmPe2
         08BPeKGDOa2sI+RRMPT2T8N5b0gbMMygp7yAf2JcX61Z1nALHOkYaGyiprpvx+daFqjd
         6ngOShkM3NIA4qZMlWVx474VhPQ/WYT8uzDDmebMRvkaXYIpDJzoHpzc6bdk2ihW4JXN
         SNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oO4F7kwO8y9QHU02QhioohHedy1C18WaXBdKdAF3Ltk=;
        b=owynWqFUQCWQ+K4OFDUxuv3TFbtv7I7iPyUqdrGtydTFKPvuICFA5Ohjh61lKjIh/L
         QKwydAUMsPLuMeBA9cE2XuAduOhiCGbRaUHhuOF5M0K9ivQZ2DNjEZepePbNu1lH4g7h
         hwGOWXGqlnsJj3AKhvoIlZ8AYx7NyUWRBc622j+nOy7/iRtujjhvhICzBEYZEEDA7Wj+
         JjT86m308A8V0FMGLjaKf8oHmph6T3snZmkw95THeMqedGYhOGUoOexx9P8UM8UDFsSq
         IsRywRUZ2C4FIgoj3qI5youR5izIWyrXY0ZOgHDhP49+i+VZv86GGSzAGYgM5E9ap8mS
         c/fg==
X-Gm-Message-State: AJIora+NtM94s+jOneVAgqk9uH9IcBJj+EoMEb6RHe0RWgTit4g6SEQ4
        sRl7ivqN7udxjYWiUNQUV44=
X-Google-Smtp-Source: AGRyM1vzzhDNtkhWn+uv50KjwbVoeDowVndmdtM//KNYzeWqYbWDNHuOW9M5kw784Fw8ILzstnQwQw==
X-Received: by 2002:a17:90b:4d05:b0:1e0:b53:f4a3 with SMTP id mw5-20020a17090b4d0500b001e00b53f4a3mr37301979pjb.3.1656945538452;
        Mon, 04 Jul 2022 07:38:58 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.221.247.188])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm20534365pgk.76.2022.07.04.07.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:38:58 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] locking/qspinlock: stop renaming queued_spin_lock_slowpath to native_queued_spin_lock_slowpath
Date:   Tue,  5 Jul 2022 00:38:15 +1000
Message-Id: <20220704143820.3071004-9-npiggin@gmail.com>
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
index 4045b5683ecb..412b83040bac 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -295,8 +295,7 @@ static __always_inline void set_locked(struct qspinlock *lock)
  *   pv_kick(cpu)             -- wakes a suspended vcpu
  *
  * Using these we implement __pv_queued_spin_lock_slowpath() and
- * __pv_queued_spin_unlock() to replace native_queued_spin_lock_slowpath() and
- * native_queued_spin_unlock().
+ * __pv_queued_spin_unlock().
  */
 
 #define _Q_SLOW_VAL	(3U << _Q_LOCKED_OFFSET)
@@ -986,10 +985,6 @@ static inline void queued_spin_lock_mcs_queue(struct qspinlock *lock, bool parav
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
@@ -1070,7 +1065,6 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
-#undef queued_spin_lock_slowpath
 void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
 	queued_spin_lock_mcs_queue(lock, true);
-- 
2.35.1

