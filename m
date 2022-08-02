Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E3C587E9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbiHBPJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbiHBPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:09:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822E52E6B1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:09:31 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lxyxw12MNzlVp6;
        Tue,  2 Aug 2022 23:06:44 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 23:09:26 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 23:09:25 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Abhishek Shah <abhishek.shah@columbia.edu>,
        Gabriel Ryan <gabe@cs.columbia.edu>
Subject: [PATCH] mm: ksm: fix data-race in __ksm_enter / run_store
Date:   Tue, 2 Aug 2022 23:15:50 +0800
Message-ID: <20220802151550.159076-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abhishek reported a data-race issue,

BUG: KCSAN: data-race in __ksm_enter / run_store
write to 0xffffffff881edae0 of 8 bytes by task 6542 on cpu 0:
 run_store+0x19a/0x2d0 mm/ksm.c:2897
 kobj_attr_store+0x44/0x60 lib/kobject.c:824
 sysfs_kf_write+0x16f/0x1a0 fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x2ae/0x370 fs/kernfs/file.c:291
 call_write_iter include/linux/fs.h:2050 [inline]
 new_sync_write fs/read_write.c:504 [inline]
 vfs_write+0x779/0x900 fs/read_write.c:591
 ksys_write+0xde/0x190 fs/read_write.c:644
 __do_sys_write fs/read_write.c:656 [inline]
 __se_sys_write fs/read_write.c:653 [inline]
 __x64_sys_write+0x43/0x50 fs/read_write.c:653
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

read to 0xffffffff881edae0 of 8 bytes by task 6541 on cpu 1:
 __ksm_enter+0x114/0x260 mm/ksm.c:2501
 ksm_madvise+0x291/0x350 mm/ksm.c:2451
 madvise_vma_behavior mm/madvise.c:1039 [inline]
 madvise_walk_vmas mm/madvise.c:1221 [inline]
 do_madvise+0x656/0xeb0 mm/madvise.c:1399
 __do_sys_madvise mm/madvise.c:1412 [inline]
 __se_sys_madvise mm/madvise.c:1410 [inline]
 __x64_sys_madvise+0x64/0x70 mm/madvise.c:1410
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 6541 Comm: syz-executor2-n Not tainted 5.18.0-rc5+ #107
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014

The ksm_run is alread protected by ksm_thread_mutex in run_store, we
could add this lock in __ksm_enter() to avoid the above issue.

Reported-and-tested-by: Abhishek Shah <abhishek.shah@columbia.edu>
Cc: Gabriel Ryan <gabe@cs.columbia.edu>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/ksm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2f315c69fa2c..3f1908946a6f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2507,6 +2507,7 @@ int __ksm_enter(struct mm_struct *mm)
 {
 	struct mm_slot *mm_slot;
 	int needs_wakeup;
+	bool ksm_run_unmerge;
 
 	mm_slot = alloc_mm_slot();
 	if (!mm_slot)
@@ -2515,6 +2516,10 @@ int __ksm_enter(struct mm_struct *mm)
 	/* Check ksm_run too?  Would need tighter locking */
 	needs_wakeup = list_empty(&ksm_mm_head.mm_list);
 
+	mutex_lock(&ksm_thread_mutex);
+	ksm_run_unmerge = !!(ksm_run & KSM_RUN_UNMERGE);
+	mutex_unlock(&ksm_thread_mutex);
+
 	spin_lock(&ksm_mmlist_lock);
 	insert_to_mm_slots_hash(mm, mm_slot);
 	/*
@@ -2527,7 +2532,7 @@ int __ksm_enter(struct mm_struct *mm)
 	 * scanning cursor, otherwise KSM pages in newly forked mms will be
 	 * missed: then we might as well insert at the end of the list.
 	 */
-	if (ksm_run & KSM_RUN_UNMERGE)
+	if (ksm_run_unmerge)
 		list_add_tail(&mm_slot->mm_list, &ksm_mm_head.mm_list);
 	else
 		list_add_tail(&mm_slot->mm_list, &ksm_scan.mm_slot->mm_list);
-- 
2.35.3

