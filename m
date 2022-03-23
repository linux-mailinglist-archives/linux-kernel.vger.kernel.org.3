Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A704E5106
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiCWLLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCWLLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:11:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F5675C36
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:09:42 -0700 (PDT)
Date:   Wed, 23 Mar 2022 12:09:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648033781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y/9QlDKkQgJIDKLYV7PPTv1CBQEArmZvtFf+nq36eLQ=;
        b=VCuJqmw4XFfaZutmSwF5amYHYfC1m76r7PhRsHgIhfcogPDP8f2u9lZ5tWWME1oILrqTem
        ZmFvQHTQZaOKeckDMGLynD8NCTtNEyp2r35N1D2JmXDD6MbEy5AAmV7y80O60V0i1tLNd8
        dn6z54ABxTkLUPa1aWX9aHdU7E1K1EuwwIWM8Yj1NrA4E5qehIUWv8Phat8O5L+p7s3U/O
        e5xWdHDo1H/rd5EOzLD0nx98rE/tVve/ppBAuhn/vlJsJ+zXPBTRxcxdAebmVODrGQXZW0
        M8bt7Zb/vkXNgn7JypQszCOU1kXsZS/9vnZGL+NPp719rG0o2a1qYP4Djm2HSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648033781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y/9QlDKkQgJIDKLYV7PPTv1CBQEArmZvtFf+nq36eLQ=;
        b=f2flnjoxpv42V4Isvy48bFJS9P6bMY4ZORKXpweyTqNP3wGNq4aFPqqEyv53r+gZFS79gG
        ai5pyve9T6BsGEBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] locking/local_lock: Pretend to use the per-CPU variable if
 not needed.
Message-ID: <Yjr/9ATrCDxr/0hq@linutronix.de>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic>
 <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <YjrIDlUePHQtIV4K@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjrIDlUePHQtIV4K@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the !RT && !LOCKDEP case the per-CPU variables aren't used. The commit
mentioned below tried to avoid the usage of this_cpu_ptr() because it
generates code, clobbers registers which is not needed.
This change generated so little reference to the variable that llvm
assumed that it is not used and created a warning.

Revert local_lock_*() to its previous static inline implementation for
type checking.
Replace this_cpu_ptr() with __ll_cpu_ptr() which points to
this_cpu_ptr() when it is used.
In the !RT && !LOCKDEP case use per_cpu_ptr(, 0) which does not leave
any code behind and llvm does not complain either. It also ensures that
it is a per-CPU pointer. The assembly output in this case is unchanged.

Fixes: 9983a9d577db4 ("locking/local_lock: Make the empty local_lock_*() function a macro.")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/local_lock_internal.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 6d635e8306d64..e671ead5fbad5 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -24,6 +24,8 @@ typedef struct {
 	},						\
 	.owner = NULL,
 
+#define __ll_cpu_ptr(__ll_cpuptr) (this_cpu_ptr(__ll_cpuptr))
+
 static inline void local_lock_acquire(local_lock_t *l)
 {
 	lock_map_acquire(&l->dep_map);
@@ -44,9 +46,10 @@ static inline void local_lock_debug_init(local_lock_t *l)
 }
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 # define LOCAL_LOCK_DEBUG_INIT(lockname)
-# define local_lock_acquire(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
-# define local_lock_release(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
-# define local_lock_debug_init(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
+# define __ll_cpu_ptr(__ll_cpuptr) per_cpu_ptr(__ll_cpuptr, 0)
+static inline void local_lock_acquire(local_lock_t *l) { }
+static inline void local_lock_release(local_lock_t *l) { }
+static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
@@ -65,36 +68,36 @@ do {								\
 #define __local_lock(lock)					\
 	do {							\
 		preempt_disable();				\
-		local_lock_acquire(this_cpu_ptr(lock));		\
+		local_lock_acquire(__ll_cpu_ptr(lock));		\
 	} while (0)
 
 #define __local_lock_irq(lock)					\
 	do {							\
 		local_irq_disable();				\
-		local_lock_acquire(this_cpu_ptr(lock));		\
+		local_lock_acquire(__ll_cpu_ptr(lock));		\
 	} while (0)
 
 #define __local_lock_irqsave(lock, flags)			\
 	do {							\
 		local_irq_save(flags);				\
-		local_lock_acquire(this_cpu_ptr(lock));		\
+		local_lock_acquire(__ll_cpu_ptr(lock));		\
 	} while (0)
 
 #define __local_unlock(lock)					\
 	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
+		local_lock_release(__ll_cpu_ptr(lock));		\
 		preempt_enable();				\
 	} while (0)
 
 #define __local_unlock_irq(lock)				\
 	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
+		local_lock_release(__ll_cpu_ptr(lock));		\
 		local_irq_enable();				\
 	} while (0)
 
 #define __local_unlock_irqrestore(lock, flags)			\
 	do {							\
-		local_lock_release(this_cpu_ptr(lock));		\
+		local_lock_release(__ll_cpu_ptr(lock));		\
 		local_irq_restore(flags);			\
 	} while (0)
 
-- 
2.35.1

