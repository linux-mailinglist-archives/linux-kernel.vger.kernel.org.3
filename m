Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0114247F9E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 04:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhL0DMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 22:12:34 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15980 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbhL0DMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 22:12:13 -0500
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JMjLJ4HzgzZdpD;
        Mon, 27 Dec 2021 11:08:56 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 11:12:11 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 27 Dec
 2021 11:12:10 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>,
        <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 13/15] ubifs: ubifs_writepage: Mark page dirty after writing inode failed
Date:   Mon, 27 Dec 2021 11:22:44 +0800
Message-ID: <20211227032246.2886878-14-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211227032246.2886878-1-chengzhihao1@huawei.com>
References: <20211227032246.2886878-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two states for ubifs writing pages:
1. Dirty, Private
2. Not Dirty, Not Private

There is a third possibility which maybe related to [1] that page is
private but not dirty caused by following process:

          PA
lock(page)
ubifs_write_end
  attach_page_private		// set Private
    __set_page_dirty_nobuffers	// set Dirty
unlock(page)

write_cache_pages
  lock(page)
  clear_page_dirty_for_io(page)	// clear Dirty
  ubifs_writepage
    write_inode
    // fail, goto out, following codes are not executed
    // do_writepage
    //   set_page_writeback 	// set Writeback
    //   detach_page_private	// clear Private
    //   end_page_writeback 	// clear Writeback
    out:
    unlock(page)		// Private, Not Dirty

                                       PB
				ksys_fadvise64_64
				  generic_fadvise
				     invalidate_inode_page
				     // page is neither Dirty nor Writeback
				       invalidate_complete_page
				       // page_has_private is true
					 try_to_release_page
					   ubifs_releasepage
					     ubifs_assert(c, 0) !!!

Then we may get following assertion failed:
  UBIFS error (ubi0:0 pid 1492): ubifs_assert_failed [ubifs]:
  UBIFS assert failed: 0, in fs/ubifs/file.c:1499
  UBIFS warning (ubi0:0 pid 1492): ubifs_ro_mode [ubifs]:
  switched to read-only mode, error -22
  CPU: 2 PID: 1492 Comm: aa Not tainted 5.16.0-rc2-00012-g7bb767dee0ba-dirty
  Call Trace:
    dump_stack+0x13/0x1b
    ubifs_ro_mode+0x54/0x60 [ubifs]
    ubifs_assert_failed+0x4b/0x80 [ubifs]
    ubifs_releasepage+0x7e/0x1e0 [ubifs]
    try_to_release_page+0x57/0xe0
    invalidate_inode_page+0xfb/0x130
    invalidate_mapping_pagevec+0x12/0x20
    generic_fadvise+0x303/0x3c0
    vfs_fadvise+0x35/0x40
    ksys_fadvise64_64+0x4c/0xb0

Jump [2] to find a reproducer.

[1] https://linux-mtd.infradead.narkive.com/NQoBeT1u/patch-rfc-ubifs-fix-assert-failed-in-ubifs-set-page-dirty
[2] https://bugzilla.kernel.org/show_bug.cgi?id=215357

Fixes: 1e51764a3c2ac0 ("UBIFS: add new flash file system")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/file.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 6b45a037a047..7cc2abcb70ae 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1031,7 +1031,7 @@ static int ubifs_writepage(struct page *page, struct writeback_control *wbc)
 		if (page->index >= synced_i_size >> PAGE_SHIFT) {
 			err = inode->i_sb->s_op->write_inode(inode, NULL);
 			if (err)
-				goto out_unlock;
+				goto out_redirty;
 			/*
 			 * The inode has been written, but the write-buffer has
 			 * not been synchronized, so in case of an unclean
@@ -1059,11 +1059,17 @@ static int ubifs_writepage(struct page *page, struct writeback_control *wbc)
 	if (i_size > synced_i_size) {
 		err = inode->i_sb->s_op->write_inode(inode, NULL);
 		if (err)
-			goto out_unlock;
+			goto out_redirty;
 	}
 
 	return do_writepage(page, len);
-
+out_redirty:
+	/*
+	 * redirty_page_for_writepage() won't call ubifs_dirty_inode() because
+	 * it passes I_DIRTY_PAGES flag while calling __mark_inode_dirty(), so
+	 * there is no need to do space budget for dirty inode.
+	 */
+	redirty_page_for_writepage(wbc, page);
 out_unlock:
 	unlock_page(page);
 	return err;
-- 
2.31.1

