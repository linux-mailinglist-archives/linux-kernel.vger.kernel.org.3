Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04F458F415
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiHJWDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiHJWDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:03:50 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8A375393
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:03:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gj1so16090352pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=URnDIs7aNLcIESWIp/5KgFY1oQMcYECdBhNZ3lXDJOw=;
        b=ZTpl2nARbkywqYNttneLJ45MR7cDczBKPBXtGAFhcJJQhwHm6snKyNWd+ZtZuEDtg/
         3wSLCdobfH5JdoXC/8yJvorTqgPJD18gXQHb0A5qg94rEODykExBx7npRYrJJs3UhqK9
         udnhVpRJHa4w+CFJa1dXo6zRduafU/FJ5X5PWu2aZ4gDlCeSDRCtdLs+uqKIv4YWO+8m
         e5ZkON/58WxaNX0JgY/8e0x8H1FNTVkaFtcS1b4uPQHObjm1u8CvXlS7DsLtBFcZjq5R
         eGlTMzqR2RML2Dxqr7qRC4L3zrPR4hr5EpCU3xXRfC+UnfqsAiVCaLdKZVLurX45Fqfl
         hOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=URnDIs7aNLcIESWIp/5KgFY1oQMcYECdBhNZ3lXDJOw=;
        b=h32h59nUBUKtdBx3ai9JnBLAMrzhcwjZWebDqYAYzx8xLf/MoUcPQXLHF4LSAuhoP8
         V6T7KYs8vUIVYaVu8adbJJJfGvVvzNJvm8+wjl3ubdNmHBrceOIUPghTMnpkD7CHXZv3
         Q5l2d52CyG4HtluVRTuB9RzsLUgKLsUJmzQayRafeP+PqDzRNWmMVzQcxIk4XvxMZlIR
         WoWd1qApW4C6cBOFhOwmCCo4iaRdCaUjfaDJXKtVdvi0zjKQpyYA3UrmcnYqULDyvBs8
         96iVVSqCdxE/ek7e+U4vooE5KSZrXFm6pVjugfVJeQ7CvlknvsQdT4WjIeQjQe6AaVKs
         miFw==
X-Gm-Message-State: ACgBeo1675q84rcwf9PkYoPRoV2gY3msUwualmgt215WIMeZj6REY6f5
        PrCbw8Y6DWnZXRGS14IDQiw=
X-Google-Smtp-Source: AA6agR5v9+jgnoMVauUCYjHyMQ54z0K0dWS/BGCIb6TLMlRWZ97O+OFIX8fzEZtP14PjTIyGERnXOw==
X-Received: by 2002:a17:90a:df14:b0:1f3:3a50:9dc1 with SMTP id gp20-20020a17090adf1400b001f33a509dc1mr5616638pjb.139.1660169029500;
        Wed, 10 Aug 2022 15:03:49 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:6053:421e:5dfd:e441])
        by smtp.gmail.com with ESMTPSA id 23-20020a621917000000b0052c0a9234e0sm2575821pfz.11.2022.08.10.15.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 15:03:48 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] locking: Add __lockfunc to slow path functions
Date:   Wed, 10 Aug 2022 15:03:46 -0700
Message-Id: <20220810220346.1919485-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that we can skip the functions in the perf lock contention and other
places like /proc/PID/wchan.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
* annotate pv qspinlock functions too

 arch/x86/include/asm/qspinlock_paravirt.h | 13 +++++++------
 kernel/locking/qrwlock.c                  |  4 ++--
 kernel/locking/qspinlock.c                |  2 +-
 kernel/locking/qspinlock_paravirt.h       |  4 ++--
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock_paravirt.h b/arch/x86/include/asm/qspinlock_paravirt.h
index 892fd8c3a6f7..60ece592b220 100644
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
index 2e1600906c9f..d2ef312a8611 100644
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
index 65a9a10caa6f..2b23378775fe 100644
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
index e84d21aa0722..6afc249ce697 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -489,7 +489,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
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
 
-- 
2.37.1.559.g78731f0fdb-goog

