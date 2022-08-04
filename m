Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374CF589A18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbiHDJvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiHDJvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:51:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9600B23159;
        Thu,  4 Aug 2022 02:51:14 -0700 (PDT)
Date:   Thu, 04 Aug 2022 09:51:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659606673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=djqnORLvkM3/ZxXbmk+hOtafMGSrIZVxCdw+C1iT6IM=;
        b=VJqGqO1W2TIYkwfWSt5gN96Hgxv7GXmjUptA1bUITZPVLc/tW5et3e5vXSfqhGkvCN0Eb3
        Q3syGgLyi0VZ9Tv5qEn8AbdXDvzuR3Q42vutJnAEN/9YVyEbZv8LakaJbvuy3c4OVHqUYi
        r8phUaaTQ7kB8N2XKJUDLb7eTYqJx9fdm6ePFmuRuyHLaIDe4lmchr2xIa8FVS4jv1t+gn
        0aFdTWgk6q287vAM3E9ANRAXMrjCNDqZVKhtX2sVa+MCs4XGUmpeRPzPQKMM2iMa+gULix
        +6dC53ZjHT1FF5oyXeGV7kV8PDzH2n3sfetN6LT6qxc1TBWDVByZO4H7SZHhLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659606673;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=djqnORLvkM3/ZxXbmk+hOtafMGSrIZVxCdw+C1iT6IM=;
        b=vC7bmpQ1LEABte1/jU8NpYQ3BBwgzvA+H65/4kphZF5MLQSVbLc1QYH+nM13lD05hYbY1+
        FYchIS8mOhGkIaDg==
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/spinlocks: Mark spinlocks noinline when
 inline spinlocks are disabled
Cc:     Andi Kleen <ak@linux.intel.com>, Martin Liska <mliska@suse.cz>,
        Jiri Slaby <jslaby@suse.cz>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220719110548.1544-1-jslaby@suse.cz>
References: <20220719110548.1544-1-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <165960667173.15455.16391396611564653452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9aeaf5bc4e30ec968ae660b865ed491a28daf500
Gitweb:        https://git.kernel.org/tip/9aeaf5bc4e30ec968ae660b865ed491a28daf500
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Tue, 19 Jul 2022 13:05:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 04 Aug 2022 11:05:43 +02:00

locking/spinlocks: Mark spinlocks noinline when inline spinlocks are disabled

Otherwise LTO will inline them anyways and cause a large kernel text increase.

Since the explicit intention here is to not inline them marking them noinline
is good documentation even for the non-LTO case.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220719110548.1544-1-jslaby@suse.cz
---
 kernel/locking/spinlock.c | 56 +++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 7f49baa..8475a07 100644
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
