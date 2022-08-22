Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CAA59BCBE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiHVJXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiHVJWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:22:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB3103B;
        Mon, 22 Aug 2022 02:22:13 -0700 (PDT)
Date:   Mon, 22 Aug 2022 09:22:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661160131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqD4dwkcta/FIB4mvo8R8Bl3bXln57ojkCv8je5A1Xo=;
        b=b3koV1ZL/Y+u6wqLAxXqWJkDvTiX9Mw9Qw7P+uAp4nBHbGviRfDLlspjxVumZOB4s1OTl7
        /t7+FRnNSsTm2Np9oAL081PLknCHxeWp+Iufc2wd7ZtNBVYe4Z5Ju7Ho8a3a1FcnschPR/
        onlgEFfNYqMtdWd1iMNM1D7dMyfqlNuQAVhhXB1h2k7MynTGh1Szmz5JfvO02ZJYzJDxvR
        vnuGBMjadtZE6cN97EoXFbhSJB/oCtselE8nsTvrVrNsR+xXlkKQ8xkykfBMIgmHFGjjHE
        JnB9VMzkDWuRmlsJXs2f+fXItFnCug6Gf92AtJp8EGiQ6a61y3aWYuS1unpLpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661160131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqD4dwkcta/FIB4mvo8R8Bl3bXln57ojkCv8je5A1Xo=;
        b=G0+0/Hzyl9yY7K/BAoosChrGo/02K9cD2nuftLQ77aJWrSGpI/r+Q8i/F9s4v25Eob35ez
        MYVBNDkzNCsKBwAA==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Add __lockfunc to slow path functions
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220810220346.1919485-1-namhyung@kernel.org>
References: <20220810220346.1919485-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <166116013010.401.3026894317996177541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     501f7f69bca195da266de83eb2c26c30813fba97
Gitweb:        https://git.kernel.org/tip/501f7f69bca195da266de83eb2c26c30813fba97
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 10 Aug 2022 15:03:46 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 Aug 2022 19:47:51 +02:00

locking: Add __lockfunc to slow path functions

So that we can skip the functions in the perf lock contention and other
places like /proc/PID/wchan.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20220810220346.1919485-1-namhyung@kernel.org
---
 arch/x86/include/asm/qspinlock_paravirt.h | 13 +++++++------
 kernel/locking/qrwlock.c                  |  4 ++--
 kernel/locking/qspinlock.c                |  2 +-
 kernel/locking/qspinlock_paravirt.h       |  4 ++--
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 892fd8c..60ece59 100644
--- a/arch/x86/include/asm/qspinlock_paravirt.h
+++ b/arch/x86/include/asm/qspinlock_paravirt.h
@@ -12,7 +12,7 @@
  */
 #ifdef CONFIG_64BIT
 
-PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
+__PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath, ".spinlock.text");
 #define __pv_queued_spin_unlock	__pv_queued_spin_unlock
 #define PV_UNLOCK		"__raw_callee_save___pv_queued_spin_unlock"
 #define PV_UNLOCK_SLOWPATH	"__raw_callee_save___pv_queued_spin_unlock_slowpath"
@@ -20,9 +20,10 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
 /*
  * Optimized assembly version of __raw_callee_save___pv_queued_spin_unlock
  * which combines the registers saving trunk and the body of the following
- * C code:
+ * C code.  Note that it puts the code in the .spinlock.text section which
+ * is equivalent to adding __lockfunc in the C code:
  *
- * void __pv_queued_spin_unlock(struct qspinlock *lock)
+ * void __lockfunc __pv_queued_spin_unlock(struct qspinlock *lock)
  * {
  *	u8 lockval = cmpxchg(&lock->locked, _Q_LOCKED_VAL, 0);
  *
@@ -36,7 +37,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock_slowpath);
  *   rsi = lockval           (second argument)
  *   rdx = internal variable (set to 0)
  */
-asm    (".pushsection .text;"
+asm    (".pushsection .spinlock.text;"
 	".globl " PV_UNLOCK ";"
 	".type " PV_UNLOCK ", @function;"
 	".align 4,0x90;"
@@ -65,8 +66,8 @@ asm    (".pushsection .text;"
 
 #else /* CONFIG_64BIT */
 
-extern void __pv_queued_spin_unlock(struct qspinlock *lock);
-PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock);
+extern void __lockfunc __pv_queued_spin_unlock(struct qspinlock *lock);
+__PV_CALLEE_SAVE_REGS_THUNK(__pv_queued_spin_unlock, ".spinlock.text");
 
 #endif /* CONFIG_64BIT */
 #endif
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 2e16009..d2ef312 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -18,7 +18,7 @@
  * queued_read_lock_slowpath - acquire read lock of a queued rwlock
  * @lock: Pointer to queued rwlock structure
  */
-void queued_read_lock_slowpath(struct qrwlock *lock)
+void __lockfunc queued_read_lock_slowpath(struct qrwlock *lock)
 {
 	/*
 	 * Readers come here when they cannot get the lock without waiting
@@ -63,7 +63,7 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
  * queued_write_lock_slowpath - acquire write lock of a queued rwlock
  * @lock : Pointer to queued rwlock structure
  */
-void queued_write_lock_slowpath(struct qrwlock *lock)
+void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
 {
 	int cnts;
 
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 65a9a10..2b23378 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -313,7 +313,7 @@ static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
  * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
  *   queue               :         ^--'                             :
  */
-void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 {
 	struct mcs_spinlock *prev, *next, *node;
 	u32 old, tail;
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index e84d21a..6afc249 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -489,7 +489,7 @@ gotlock:
  * PV versions of the unlock fastpath and slowpath functions to be used
  * instead of queued_spin_unlock().
  */
-__visible void
+__visible __lockfunc void
 __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 {
 	struct pv_node *node;
@@ -544,7 +544,7 @@ __pv_queued_spin_unlock_slowpath(struct qspinlock *lock, u8 locked)
 #include <asm/qspinlock_paravirt.h>
 
 #ifndef __pv_queued_spin_unlock
-__visible void __pv_queued_spin_unlock(struct qspinlock *lock)
+__visible __lockfunc void __pv_queued_spin_unlock(struct qspinlock *lock)
 {
 	u8 locked;
 
