Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C656F592AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241546AbiHOH5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiHOH5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:57:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD3F1DA6D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:57:46 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M5mnB2Hz4zGpXl;
        Mon, 15 Aug 2022 15:56:14 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 15:57:44 +0800
Received: from huawei.com (10.175.124.27) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 15 Aug
 2022 15:57:43 +0800
From:   Shuqi Zhang <zhangshuqi3@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <zhangshuqi3@huawei.com>
Subject: [PATCH -next] f2fs: fix wrong dirty page count when race between mmap and fallocate.
Date:   Mon, 15 Aug 2022 16:15:55 +0800
Message-ID: <20220815081555.2961943-1-zhangshuqi3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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
                                            down_read(i_mmap_sem)
                                            lock_page
                                            if (PageMappedToDisk(page))
                                              goto out;
                                            // set_page_dirty  --NOT RUN
                                            out: up_read(i_mmap_sem)
                                          lock_page
                                        finish_mkwrite_fault // unlock_pte
f2fs_collapse_range
  down_write(i_mmap_sem)
  truncate_pagecache
    unmap_mapping_pages
      i_mmap_lock_write // down_write(i_mmap_rwsem)
        ......
        zap_pte_range
          pte_offset_map_lock // ---lock_pte
          f2fs_set_data_page_dirty
            if (!PageDirty(page)) {
                                        fault_dirty_shared_page
                                          f2fs_set_data_page_dirty
                                            if (!PageDirty(page)) {
                                              __set_page_dirty_nobuffer
                                              f2fs_update_dirty_page // ++
                                            }
                                          unlock_page
              __set_page_dirty_nobuffers
              f2fs_update_dirty_page // page count++
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
in f2fs_set_data_page_dirty function. Page is set to dirty only ONCE,
but the count is added TWICE by calling f2fs_update_dirty_page.
Thus the count of dirty page cannot accord with the real dirty pages.

Following is the solution to in case of race happens without any lock.
If making sure f2fs_vm_page_mkwrite calls set_page_dirty within immap
lock area, page will already be dirtied when running into
fault_dirty_shared_page-f2fs_set_data_page_dirty.
The count of dirty page will not be increased wrong times.

Signed-off-by: Shuqi Zhang <zhangshuqi3@huawei.com>
---
 fs/f2fs/file.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ce4905a073b3..d837359a9c00 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -140,7 +140,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	 * check to see if the page is mapped already (no holes)
 	 */
 	if (PageMappedToDisk(page))
-		goto out_sem;
+		goto set_dirty;
 
 	/* page is wholly or partially inside EOF */
 	if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
@@ -150,14 +150,15 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 		offset = i_size_read(inode) & ~PAGE_MASK;
 		zero_user_segment(page, offset, PAGE_SIZE);
 	}
-	set_page_dirty(page);
-	if (!PageUptodate(page))
-		SetPageUptodate(page);
 
 	f2fs_update_iostat(sbi, APP_MAPPED_IO, F2FS_BLKSIZE);
-	f2fs_update_time(sbi, REQ_TIME);
 
+set_dirty:
 	trace_f2fs_vm_page_mkwrite(page, DATA);
+	set_page_dirty(page);
+	if (!PageUptodate(page))
+		SetPageUptodate(page);
+	f2fs_update_time(sbi, REQ_TIME);
 out_sem:
 	filemap_invalidate_unlock_shared(inode->i_mapping);
 
-- 
2.25.1

