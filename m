Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B1A4F03EB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350455AbiDBO1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356255AbiDBO1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:27:19 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9591B7AE
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648909528; x=1680445528;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R6M6OmbRe4RMZI555C8KBCJG/enQgm/jqTKIB6tEdlU=;
  b=LO0nKSIfMA7PkutT3TXnpO1IM74hoxqiCL+Lna1ofz7VBvzmFOzIfZTs
   cUivUkhK6jk9yQ4WfSw25doR7h/FBzq44dxYjEgwUTCZ5yqwLaJ7VghlL
   SEy5epdpqaIyo0n7NYQXTUEjnuQwuN79MaJl1NE69u9KGtERgQhoXS8y3
   2r4UBaUUAi4Et1KiJxp8NhBs9ZbO3bCikZoQDFa2i4B87DCUVhQRg8GMv
   kygik1LPrc164BrWV6cKTrjljIiHQmpen9rC6PUxg15hptbyl4p4fSYs1
   5pf8yZJreIfTWfld5Xv4PRpw72fYxpSTMpT9IgR0rt/70I4aBxW8xsCR0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="240242657"
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="240242657"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 07:25:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,230,1643702400"; 
   d="scan'208";a="548145044"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 07:25:25 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] irq_work: Use kasan_record_aux_stack_noalloc() record callstack
Date:   Sat,  2 Apr 2022 22:25:55 +0800
Message-Id: <20220402142555.2699582-1-qiang1.zhang@intel.com>
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

[    4.113128] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
[    4.113132] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 239, name: bootlogd
[    4.113149] Preemption disabled at:
[    4.113149] [<ffffffffbab1a531>] rt_mutex_slowunlock+0xa1/0x4e0
[    4.113154] CPU: 3 PID: 239 Comm: bootlogd Tainted: G        W
5.17.1-rt17-yocto-preempt-rt+ #105
[    4.113157] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
[    4.113159] Call Trace:
[    4.113160]  <TASK>
[    4.113161]  dump_stack_lvl+0x60/0x8c
[    4.113165]  dump_stack+0x10/0x12
[    4.113167]  __might_resched.cold+0x13b/0x173
[    4.113172]  rt_spin_lock+0x5b/0xf0
[    4.113179]  get_page_from_freelist+0x20c/0x1610
[    4.113208]  __alloc_pages+0x25e/0x5e0
[    4.113222]  __stack_depot_save+0x3c0/0x4a0
[    4.113228]  kasan_save_stack+0x3a/0x50
[    4.113322]  __kasan_record_aux_stack+0xb6/0xc0
[    4.113326]  kasan_record_aux_stack+0xe/0x10
[    4.113329]  irq_work_queue_on+0x6a/0x1c0
[    4.113333]  pull_rt_task+0x631/0x6b0
[    4.113343]  do_balance_callbacks+0x56/0x80
[    4.113346]  __balance_callbacks+0x63/0x90
[    4.113350]  rt_mutex_setprio+0x349/0x880
[    4.113366]  rt_mutex_slowunlock+0x22a/0x4e0
[    4.113377]  rt_spin_unlock+0x49/0x80
[    4.113380]  uart_write+0x186/0x2b0
[    4.113385]  do_output_char+0x2e9/0x3a0
[    4.113389]  n_tty_write+0x306/0x800
[    4.113413]  file_tty_write.isra.0+0x2af/0x450
[    4.113422]  tty_write+0x22/0x30
[    4.113425]  new_sync_write+0x27c/0x3a0
[    4.113446]  vfs_write+0x3f7/0x5d0
[    4.113451]  ksys_write+0xd9/0x180
[    4.113463]  __x64_sys_write+0x43/0x50
[    4.113466]  do_syscall_64+0x44/0x90
[    4.113469]  entry_SYSCALL_64_after_hwframe+0x44/0xae

On PREEMPT_RT kernel and KASAN is enabled. the kasan_record_aux_stack()
may call alloc_pages(), and the rt-spinlock will be acquired, if
currently in atomic context, will trigger warning. fix it by use
kasan_record_aux_stack_noalloc() to avoid call alloc_pages().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/irq_work.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index f7df715ec28e..7afa40fe5cc4 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -137,7 +137,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (!irq_work_claim(work))
 		return false;
 
-	kasan_record_aux_stack(work);
+	kasan_record_aux_stack_noalloc(work);
 
 	preempt_disable();
 	if (cpu != smp_processor_id()) {
-- 
2.25.1

