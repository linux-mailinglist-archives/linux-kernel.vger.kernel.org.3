Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D66A5A73C9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 04:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiHaCHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 22:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHaCHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:07:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A0360534
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 19:07:03 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MHSBT0xwVzlWdH;
        Wed, 31 Aug 2022 10:03:13 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 10:06:32 +0800
Received: from huawei.com (10.175.124.27) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 10:06:31 +0800
From:   Shuqi Zhang <zhangshuqi3@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <zhangshuqi3@huawei.com>
Subject: [PATCH v2 -next] f2fs: fix wrong dirty page count when race between mmap and fallocate.
Date:   Wed, 31 Aug 2022 10:24:40 +0800
Message-ID: <20220831022440.2985736-1-zhangshuqi3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a BUG_ON issue as follows when running xfstest-generic-503:
WARNING: CPU: 21 PID: 1385 at fs/f2fs/inode.c:762 f2fs_evict_inode+0x847/0xaa0
Modules linked in:
CPU: 21 PID: 1385 Comm: umount Not tainted 5.19.0-rc5+ #73
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014

Call Trace:
evict+0x129/0x2d0
dispose_list+0x4f/0xb0
evict_inodes+0x204/0x230
generic_shutdown_super+0x5b/0x1e0
kill_block_super+0x29/0x80
kill_f2fs_super+0xe6/0x140
deactivate_locked_super+0x44/0xc0
deactivate_super+0x79/0x90
cleanup_mnt+0x114/0x1a0
__cleanup_mnt+0x16/0x20
task_work_run+0x98/0x100
exit_to_user_mode_prepare+0x3d0/0x3e0
syscall_exit_to_user_mode+0x12/0x30
do_syscall_64+0x42/0x80
entry_SYSCALL_64_after_hwframe+0x46/0xb0

Function flow analysis when BUG occurs:
f2fs_fallocate                    mmap
                                  do_page_fault
                                    pte_spinlock  // ---lock_pte
                                    do_wp_page
                                      wp_page_shared
                                        pte_unmap_unlock   // unlock_pte
                                          do_page_mkwrite
                                          f2fs_vm_page_mkwrite
                                            down_read(invalidate_lock)
                                            lock_page
                                            if (PageMappedToDisk(page))
                                              goto out;
                                            // set_page_dirty  --NOT RUN
                                            out: up_read(invalidate_lock);
                                        finish_mkwrite_fault // unlock_pte
f2fs_collapse_range
  down_write(i_mmap_sem)
  truncate_pagecache
    unmap_mapping_pages
      i_mmap_lock_write // down_write(i_mmap_rwsem)
        ......
        zap_pte_range
          pte_offset_map_lock // ---lock_pte
           set_page_dirty
            f2fs_dirty_data_folio
              if (!folio_test_dirty(folio)) {
                                        fault_dirty_shared_page
                                          set_page_dirty
                                            f2fs_dirty_data_folio
                                              if (!folio_test_dirty(folio)) {
                                                filemap_dirty_folio
                                                f2fs_update_dirty_folio // ++
                                              }
                                            unlock_page
                filemap_dirty_folio
                f2fs_update_dirty_folio // page count++
              }
          pte_unmap_unlock  // --unlock_pte
      i_mmap_unlock_write  // up_write(i_mmap_rwsem)
  truncate_inode_pages
  up_write(i_mmap_sem)

When race happens between mmap-do_page_fault-wp_page_shared and
fallocate-truncate_pagecache-zap_pte_range, the zap_pte_range calls
function set_page_dirty without page lock. Besides, though
truncate_pagecache has immap and pte lock, wp_page_shared calls
fault_dirty_shared_page without any. In this case, two threads race
in f2fs_dirty_data_folio function. Page is set to dirty only ONCE,
but the count is added TWICE by calling filemap_dirty_folio.
Thus the count of dirty page cannot accord with the real dirty pages.

Following is the solution to in case of race happens without any lock.
Since folio_test_set_dirty in filemap_dirty_folio is atomic, judge return
value will not be at risk of race.

Signed-off-by: Shuqi Zhang <zhangshuqi3@huawei.com>
---
 fs/f2fs/checkpoint.c | 3 +--
 fs/f2fs/data.c       | 3 +--
 fs/f2fs/node.c       | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 8259e0fa97e1..3a3329bf1033 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -448,8 +448,7 @@ static bool f2fs_dirty_meta_folio(struct address_space *mapping,
 
 	if (!folio_test_uptodate(folio))
 		folio_mark_uptodate(folio);
-	if (!folio_test_dirty(folio)) {
-		filemap_dirty_folio(mapping, folio);
+	if (filemap_dirty_folio(mapping, folio)) {
 		inc_page_count(F2FS_M_SB(mapping), F2FS_DIRTY_META);
 		set_page_private_reference(&folio->page);
 		return true;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index aa3ccddfa037..16c39bd948a0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3697,8 +3697,7 @@ static bool f2fs_dirty_data_folio(struct address_space *mapping,
 		folio_mark_uptodate(folio);
 	BUG_ON(folio_test_swapcache(folio));
 
-	if (!folio_test_dirty(folio)) {
-		filemap_dirty_folio(mapping, folio);
+	if (filemap_dirty_folio(mapping, folio)) {
 		f2fs_update_dirty_folio(inode, folio);
 		return true;
 	}
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e06a0c478b39..3506ffcb31f8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2147,8 +2147,7 @@ static bool f2fs_dirty_node_folio(struct address_space *mapping,
 	if (IS_INODE(&folio->page))
 		f2fs_inode_chksum_set(F2FS_M_SB(mapping), &folio->page);
 #endif
-	if (!folio_test_dirty(folio)) {
-		filemap_dirty_folio(mapping, folio);
+	if (filemap_dirty_folio(mapping, folio)) {
 		inc_page_count(F2FS_M_SB(mapping), F2FS_DIRTY_NODES);
 		set_page_private_reference(&folio->page);
 		return true;
-- 
2.25.1

