Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599324EEA1F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiDAJLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344322AbiDAJL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:11:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AA3198958;
        Fri,  1 Apr 2022 02:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648804179; x=1680340179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qRPdv9PmrjB2+eqpmkvc6pDI5296u1UnhUf/jBHiUrs=;
  b=dfN9/1pCtX9iKBlpPDtUccqb14Lggr+AZVVvsTqWXyqYK/VG2SY8ad7a
   8kR9oOzWHB/EXjwBWItAmur0wTq0NW03uMZt/2mimO009geK1SUsKD8cx
   edPX7znG4VYelRfeIuQewiuduFldlb51SXKp9FRWSMUj4t1ky7rFqHQ9a
   h+inJwss3APN/vGcQ2ZERy9bK6f8PbdRMiwkcpZce/LQ0DRv2jf0YiiO3
   hOgDxTyb6LOLxFzMO9ymaD/3NEjXk0kKua9ZTKsqEneuaKQzkNbNNbIir
   S0QTHrNz00WcaWB7JqZGo5ZKdM59KQxcw3Mpe+arkXt3a9WTTVOJ7/YgJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="240024108"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="240024108"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 02:09:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="567317605"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 02:09:35 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, bigeasy@linutronix.de,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH] kasan: Fix sleeping function called from invalid context in PREEMPT_RT
Date:   Fri,  1 Apr 2022 17:10:06 +0800
Message-Id: <20220401091006.2100058-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
___cache_free() is called in IPI interrupt context, the local lock
or spin lock will be acquired. on PREEMPT_RT kernel, these lock is
replaced with sleepbale rt spin lock, so the above problem is triggered.
fix it by migrating the release action from the IPI interrupt context
to the task context on RT kernel.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 mm/kasan/quarantine.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 08291ed33e93..c26fa6473119 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -90,6 +90,7 @@ static void qlist_move_all(struct qlist_head *from, struct qlist_head *to)
  */
 static DEFINE_PER_CPU(struct qlist_head, cpu_quarantine);
 
+static DEFINE_PER_CPU(struct qlist_head, cpu_shrink_qlist);
 /* Round-robin FIFO array of batches. */
 static struct qlist_head global_quarantine[QUARANTINE_BATCHES];
 static int quarantine_head;
@@ -311,12 +312,14 @@ static void qlist_move_cache(struct qlist_head *from,
 static void per_cpu_remove_cache(void *arg)
 {
 	struct kmem_cache *cache = arg;
-	struct qlist_head to_free = QLIST_INIT;
+	struct qlist_head *to_free;
 	struct qlist_head *q;
 
+	to_free = this_cpu_ptr(&cpu_shrink_qlist);
 	q = this_cpu_ptr(&cpu_quarantine);
-	qlist_move_cache(q, &to_free, cache);
-	qlist_free_all(&to_free, cache);
+	qlist_move_cache(q, to_free, cache);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		qlist_free_all(to_free, cache);
 }
 
 /* Free all quarantined objects belonging to cache. */
@@ -324,6 +327,7 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
 {
 	unsigned long flags, i;
 	struct qlist_head to_free = QLIST_INIT;
+	int cpu;
 
 	/*
 	 * Must be careful to not miss any objects that are being moved from
@@ -334,6 +338,11 @@ void kasan_quarantine_remove_cache(struct kmem_cache *cache)
 	 */
 	on_each_cpu(per_cpu_remove_cache, cache, 1);
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		for_each_possible_cpu(cpu)
+			qlist_free_all(per_cpu_ptr(&cpu_shrink_qlist, cpu), cache);
+	}
+
 	raw_spin_lock_irqsave(&quarantine_lock, flags);
 	for (i = 0; i < QUARANTINE_BATCHES; i++) {
 		if (qlist_empty(&global_quarantine[i]))
-- 
2.25.1

