Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830A54EEE6B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346268AbiDANsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiDANsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:48:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C31B2557
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648820781; x=1680356781;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dq4ZeuHSuqCc8HBShNDGOUX84T9yRxGqXlCI/ZSyqZE=;
  b=FAfUzuxIAFIbWs9NfF+wfIfSa1DcOUeexkBSaJRuRy6Et6p5CFiKOrEF
   gB7RPKZOd3M7Tg1Ecz7ezFrquKOxWo8ppHRCQgQBra2AB1gUb1k1jKWT4
   9IK0XmboVj/7nv+eqk8ps2cov5z8EOznMfcW/ov7u2gUCBBBsQXKMGSdY
   F9y20HWcBrOD+z1BqhOANqzi26Kn8G4D31DenzqgBOVvfWX6Zgm/OruR/
   qnfDhf/RdbjFR0ZumgSET5dinXIlRTjY0OkNjSVJ5Jdb9GF13+xW7Mgb8
   BM+/a8FDwHkRXvftCSe6xer0Oo13mHjLNm+YQ6gXFiK6GpOagW3oPSK4e
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="346576008"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="346576008"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 06:46:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="720888741"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 06:46:18 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2] kasan: Fix sleeping function called from invalid context on RT kernel
Date:   Fri,  1 Apr 2022 21:46:49 +0800
Message-Id: <20220401134649.2222485-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
preempt_count: 1, expected: 0
...........
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.1-rt16-yocto-preempt-rt #22
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
Call Trace:
<TASK>
dump_stack_lvl+0x60/0x8c
dump_stack+0x10/0x12
 __might_resched.cold+0x13b/0x173
rt_spin_lock+0x5b/0xf0
 ___cache_free+0xa5/0x180
qlist_free_all+0x7a/0x160
per_cpu_remove_cache+0x5f/0x70
smp_call_function_many_cond+0x4c4/0x4f0
on_each_cpu_cond_mask+0x49/0xc0
kasan_quarantine_remove_cache+0x54/0xf0
kasan_cache_shrink+0x9/0x10
kmem_cache_shrink+0x13/0x20
acpi_os_purge_cache+0xe/0x20
acpi_purge_cached_objects+0x21/0x6d
acpi_initialize_objects+0x15/0x3b
acpi_init+0x130/0x5ba
do_one_initcall+0xe5/0x5b0
kernel_init_freeable+0x34f/0x3ad
kernel_init+0x1e/0x140
ret_from_fork+0x22/0x30

When the kmem_cache_shrink() be called, the IPI was triggered, the
___cache_free() is called in IPI interrupt context, the local-lock
or spin-lock will be acquired. on PREEMPT_RT kernel, these lock is
replaced with sleepbale rt-spinlock, so the above problem is triggered.
fix it by move the qlist_free_allfrom() the IPI interrupt context
to the task context when PREEMPT_RT is enabled.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Add raw_spinlock protect per-cpu shrink qlist. 

 mm/kasan/quarantine.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 08291ed33e93..0e33d30abb8d 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -99,6 +99,17 @@ static unsigned long quarantine_size;
 static DEFINE_RAW_SPINLOCK(quarantine_lock);
 DEFINE_STATIC_SRCU(remove_cache_srcu);
 
+#ifdef CONFIG_PREEMPT_RT
+struct cpu_shrink_qlist {
+	raw_spinlock_t lock;
+	struct qlist_head qlist;
+};
+
+static DEFINE_PER_CPU(struct cpu_shrink_qlist, shrink_qlist) = {
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(shrink_qlist.lock),
+};
+#endif
+
 /* Maximum size of the global queue. */
 static unsigned long quarantine_max_size;
 
@@ -311,12 +322,23 @@ static void qlist_move_cache(struct qlist_head *from,
 static void per_cpu_remove_cache(void *arg)
 {
 	struct kmem_cache *cache = arg;
-	struct qlist_head to_free = QLIST_INIT;
 	struct qlist_head *q;
-
+#ifndef CONFIG_PREEMPT_RT
+	struct qlist_head to_free = QLIST_INIT;
+#else
+	unsigned long flags;
+	struct cpu_shrink_qlist *sq;
+#endif
 	q = this_cpu_ptr(&cpu_quarantine);
+#ifndef CONFIG_PREEMPT_RT
 	qlist_move_cache(q, &to_free, cache);
 	qlist_free_all(&to_free, cache);
+#else
+	sq = this_cpu_ptr(&shrink_qlist);
+	raw_spin_lock_irqsave(&sq->lock, flags);
+	qlist_move_cache(q, &sq->qlist, cache);
+	raw_spin_unlock_irqrestore(&sq->lock, flags);
+#endif
 }
 
 /* Free all quarantined objects belonging to cache. */
@@ -324,6 +346,10 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
 {
 	unsigned long flags, i;
 	struct qlist_head to_free = QLIST_INIT;
+#ifdef CONFIG_PREEMPT_RT
+	int cpu;
+	struct cpu_shrink_qlist *sq;
+#endif
 
 	/*
 	 * Must be careful to not miss any objects that are being moved from
@@ -334,6 +360,16 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
 	 */
 	on_each_cpu(per_cpu_remove_cache, cache, 1);
 
+#ifdef CONFIG_PREEMPT_RT
+	for_each_online_cpu(cpu) {
+		sq = per_cpu_ptr(&shrink_qlist, cpu);
+		raw_spin_lock_irqsave(&sq->lock, flags);
+		qlist_move_cache(&sq->qlist, &to_free, cache);
+		raw_spin_unlock_irqrestore(&sq->lock, flags);
+	}
+	qlist_free_all(&to_free, cache);
+#endif
+
 	raw_spin_lock_irqsave(&quarantine_lock, flags);
 	for (i = 0; i < QUARANTINE_BATCHES; i++) {
 		if (qlist_empty(&global_quarantine[i]))
-- 
2.25.1

