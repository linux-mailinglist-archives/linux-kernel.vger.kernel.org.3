Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9813A579826
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbiGSLFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236740AbiGSLFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:05:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C927C2CE21
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:05:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 79E3634219;
        Tue, 19 Jul 2022 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658228749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=F+8K+LLBhelbfXnYwOAm/q0ScXwNo0H/Mclt3SBTxHQ=;
        b=C0qVYmhOE9kplPAQ+7gRKzONAVtcb2RUyGeVxOSLpKYUgR0q+dO4RxAcdY9yLitYh/dmAV
        nvMrQEHZXss3OdIjWk80Zd2qkmZJI4MD/k8qxkMY8OFe0+mLyEzKtSKlzvtyfWGG6St507
        dxKTKbs6ZnJnKV42H6WemxSnbiBteyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658228749;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=F+8K+LLBhelbfXnYwOAm/q0ScXwNo0H/Mclt3SBTxHQ=;
        b=Em34YjTaq8F8/k48+pLNmI7KaYtHddftjEqEVixCvOzV8hCQStpHZylwdIoK2XdcbtGIhr
        hfuZDiCsqg++TECA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1EBFB2C141;
        Tue, 19 Jul 2022 11:05:49 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] locking: Mark spinlocks noinline when inline spinlocks are disabled
Date:   Tue, 19 Jul 2022 13:05:48 +0200
Message-Id: <20220719110548.1544-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Otherwise LTO will inline them anyways and cause a large kernel text increase.

Since the explicit intention here is to not inline them marking them noinline
is good documentation even for the non-LTO case.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 kernel/locking/spinlock.c | 56 +++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 7f49baaa4979..8475a0794f8c 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -133,7 +133,7 @@ BUILD_LOCK_OPS(write, rwlock);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_TRYLOCK
-int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock)
+noinline int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock)
 {
 	return __raw_spin_trylock(lock);
 }
@@ -141,7 +141,7 @@ EXPORT_SYMBOL(_raw_spin_trylock);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_TRYLOCK_BH
-int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock)
+noinline int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock)
 {
 	return __raw_spin_trylock_bh(lock);
 }
@@ -149,7 +149,7 @@ EXPORT_SYMBOL(_raw_spin_trylock_bh);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_LOCK
-void __lockfunc _raw_spin_lock(raw_spinlock_t *lock)
+noinline void __lockfunc _raw_spin_lock(raw_spinlock_t *lock)
 {
 	__raw_spin_lock(lock);
 }
@@ -157,7 +157,7 @@ EXPORT_SYMBOL(_raw_spin_lock);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_LOCK_IRQSAVE
-unsigned long __lockfunc _raw_spin_lock_irqsave(raw_spinlock_t *lock)
+noinline unsigned long __lockfunc _raw_spin_lock_irqsave(raw_spinlock_t *lock)
 {
 	return __raw_spin_lock_irqsave(lock);
 }
@@ -165,7 +165,7 @@ EXPORT_SYMBOL(_raw_spin_lock_irqsave);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_LOCK_IRQ
-void __lockfunc _raw_spin_lock_irq(raw_spinlock_t *lock)
+noinline void __lockfunc _raw_spin_lock_irq(raw_spinlock_t *lock)
 {
 	__raw_spin_lock_irq(lock);
 }
@@ -173,7 +173,7 @@ EXPORT_SYMBOL(_raw_spin_lock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_LOCK_BH
-void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)
+noinline void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)
 {
 	__raw_spin_lock_bh(lock);
 }
@@ -181,7 +181,7 @@ EXPORT_SYMBOL(_raw_spin_lock_bh);
 #endif
 
 #ifdef CONFIG_UNINLINE_SPIN_UNLOCK
-void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)
+noinline void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)
 {
 	__raw_spin_unlock(lock);
 }
@@ -189,7 +189,7 @@ EXPORT_SYMBOL(_raw_spin_unlock);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE
-void __lockfunc _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
+noinline void __lockfunc _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 {
 	__raw_spin_unlock_irqrestore(lock, flags);
 }
@@ -197,7 +197,7 @@ EXPORT_SYMBOL(_raw_spin_unlock_irqrestore);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_IRQ
-void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)
+noinline void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)
 {
 	__raw_spin_unlock_irq(lock);
 }
@@ -205,7 +205,7 @@ EXPORT_SYMBOL(_raw_spin_unlock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_BH
-void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)
+noinline void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)
 {
 	__raw_spin_unlock_bh(lock);
 }
@@ -215,7 +215,7 @@ EXPORT_SYMBOL(_raw_spin_unlock_bh);
 #ifndef CONFIG_PREEMPT_RT
 
 #ifndef CONFIG_INLINE_READ_TRYLOCK
-int __lockfunc _raw_read_trylock(rwlock_t *lock)
+noinline int __lockfunc _raw_read_trylock(rwlock_t *lock)
 {
 	return __raw_read_trylock(lock);
 }
@@ -223,7 +223,7 @@ EXPORT_SYMBOL(_raw_read_trylock);
 #endif
 
 #ifndef CONFIG_INLINE_READ_LOCK
-void __lockfunc _raw_read_lock(rwlock_t *lock)
+noinline void __lockfunc _raw_read_lock(rwlock_t *lock)
 {
 	__raw_read_lock(lock);
 }
@@ -231,7 +231,7 @@ EXPORT_SYMBOL(_raw_read_lock);
 #endif
 
 #ifndef CONFIG_INLINE_READ_LOCK_IRQSAVE
-unsigned long __lockfunc _raw_read_lock_irqsave(rwlock_t *lock)
+noinline unsigned long __lockfunc _raw_read_lock_irqsave(rwlock_t *lock)
 {
 	return __raw_read_lock_irqsave(lock);
 }
@@ -239,7 +239,7 @@ EXPORT_SYMBOL(_raw_read_lock_irqsave);
 #endif
 
 #ifndef CONFIG_INLINE_READ_LOCK_IRQ
-void __lockfunc _raw_read_lock_irq(rwlock_t *lock)
+noinline void __lockfunc _raw_read_lock_irq(rwlock_t *lock)
 {
 	__raw_read_lock_irq(lock);
 }
@@ -247,7 +247,7 @@ EXPORT_SYMBOL(_raw_read_lock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_READ_LOCK_BH
-void __lockfunc _raw_read_lock_bh(rwlock_t *lock)
+noinline void __lockfunc _raw_read_lock_bh(rwlock_t *lock)
 {
 	__raw_read_lock_bh(lock);
 }
@@ -255,7 +255,7 @@ EXPORT_SYMBOL(_raw_read_lock_bh);
 #endif
 
 #ifndef CONFIG_INLINE_READ_UNLOCK
-void __lockfunc _raw_read_unlock(rwlock_t *lock)
+noinline void __lockfunc _raw_read_unlock(rwlock_t *lock)
 {
 	__raw_read_unlock(lock);
 }
@@ -263,7 +263,7 @@ EXPORT_SYMBOL(_raw_read_unlock);
 #endif
 
 #ifndef CONFIG_INLINE_READ_UNLOCK_IRQRESTORE
-void __lockfunc _raw_read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+noinline void __lockfunc _raw_read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
 	__raw_read_unlock_irqrestore(lock, flags);
 }
@@ -271,7 +271,7 @@ EXPORT_SYMBOL(_raw_read_unlock_irqrestore);
 #endif
 
 #ifndef CONFIG_INLINE_READ_UNLOCK_IRQ
-void __lockfunc _raw_read_unlock_irq(rwlock_t *lock)
+noinline void __lockfunc _raw_read_unlock_irq(rwlock_t *lock)
 {
 	__raw_read_unlock_irq(lock);
 }
@@ -279,7 +279,7 @@ EXPORT_SYMBOL(_raw_read_unlock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_READ_UNLOCK_BH
-void __lockfunc _raw_read_unlock_bh(rwlock_t *lock)
+noinline void __lockfunc _raw_read_unlock_bh(rwlock_t *lock)
 {
 	__raw_read_unlock_bh(lock);
 }
@@ -287,7 +287,7 @@ EXPORT_SYMBOL(_raw_read_unlock_bh);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_TRYLOCK
-int __lockfunc _raw_write_trylock(rwlock_t *lock)
+noinline int __lockfunc _raw_write_trylock(rwlock_t *lock)
 {
 	return __raw_write_trylock(lock);
 }
@@ -295,7 +295,7 @@ EXPORT_SYMBOL(_raw_write_trylock);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_LOCK
-void __lockfunc _raw_write_lock(rwlock_t *lock)
+noinline void __lockfunc _raw_write_lock(rwlock_t *lock)
 {
 	__raw_write_lock(lock);
 }
@@ -313,7 +313,7 @@ EXPORT_SYMBOL(_raw_write_lock_nested);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_LOCK_IRQSAVE
-unsigned long __lockfunc _raw_write_lock_irqsave(rwlock_t *lock)
+noinline unsigned long __lockfunc _raw_write_lock_irqsave(rwlock_t *lock)
 {
 	return __raw_write_lock_irqsave(lock);
 }
@@ -321,7 +321,7 @@ EXPORT_SYMBOL(_raw_write_lock_irqsave);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_LOCK_IRQ
-void __lockfunc _raw_write_lock_irq(rwlock_t *lock)
+noinline void __lockfunc _raw_write_lock_irq(rwlock_t *lock)
 {
 	__raw_write_lock_irq(lock);
 }
@@ -329,7 +329,7 @@ EXPORT_SYMBOL(_raw_write_lock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_LOCK_BH
-void __lockfunc _raw_write_lock_bh(rwlock_t *lock)
+noinline void __lockfunc _raw_write_lock_bh(rwlock_t *lock)
 {
 	__raw_write_lock_bh(lock);
 }
@@ -337,7 +337,7 @@ EXPORT_SYMBOL(_raw_write_lock_bh);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_UNLOCK
-void __lockfunc _raw_write_unlock(rwlock_t *lock)
+noinline void __lockfunc _raw_write_unlock(rwlock_t *lock)
 {
 	__raw_write_unlock(lock);
 }
@@ -345,7 +345,7 @@ EXPORT_SYMBOL(_raw_write_unlock);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_UNLOCK_IRQRESTORE
-void __lockfunc _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+noinline void __lockfunc _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
 	__raw_write_unlock_irqrestore(lock, flags);
 }
@@ -353,7 +353,7 @@ EXPORT_SYMBOL(_raw_write_unlock_irqrestore);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_UNLOCK_IRQ
-void __lockfunc _raw_write_unlock_irq(rwlock_t *lock)
+noinline void __lockfunc _raw_write_unlock_irq(rwlock_t *lock)
 {
 	__raw_write_unlock_irq(lock);
 }
@@ -361,7 +361,7 @@ EXPORT_SYMBOL(_raw_write_unlock_irq);
 #endif
 
 #ifndef CONFIG_INLINE_WRITE_UNLOCK_BH
-void __lockfunc _raw_write_unlock_bh(rwlock_t *lock)
+noinline void __lockfunc _raw_write_unlock_bh(rwlock_t *lock)
 {
 	__raw_write_unlock_bh(lock);
 }
-- 
2.37.1

