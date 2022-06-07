Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C12539B5F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 04:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349221AbiFACrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 22:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349223AbiFACq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 22:46:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14BFD7E
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 19:46:43 -0700 (PDT)
Received: from kwepemi100011.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LCYQj4qv6zfZDX;
        Wed,  1 Jun 2022 10:45:01 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100011.china.huawei.com (7.221.188.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 10:46:41 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 1 Jun
 2022 10:46:40 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <kirill.shutemov@linux.intel.com>, <willy@infradead.org>,
        <s.hauer@pengutronix.de>, <ext-adrian.hunter@nokia.com>,
        <Artem.Bityutskiy@nokia.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 2/2] ubifs: ubifs_releasepage: Remove ubifs_assert(0) to valid this process
Date:   Wed, 1 Jun 2022 11:00:00 +0800
Message-ID: <20220601030000.49714-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220601030000.49714-1-chengzhihao1@huawei.com>
References: <20220601030000.49714-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two states for ubifs writing pages:
1. Dirty, Private
2. Not Dirty, Not Private

The normal process cannot go to ubifs_releasepage() which means there
exists pages being private but not dirty. Reproducer[1] shows that it
could occur (which maybe related to [2]) with following process:

     PA                     PB                    PC
lock(page)[PA]
ubifs_write_end
  attach_page_private         // set Private
  __set_page_dirty_nobuffers  // set Dirty
unlock(page)

write_cache_pages[PA]
  lock(page)
  clear_page_dirty_for_io(page)	// clear Dirty
  ubifs_writepage

                        do_truncation[PB]
			  truncate_setsize
			    i_size_write(inode, newsize) // newsize = 0

    i_size = i_size_read(inode)	// i_size = 0
    end_index = i_size >> PAGE_SHIFT
    if (page->index > end_index)
      goto out // jump
out:
unlock(page)   // Private, Not Dirty

						generic_fadvise[PC]
						  lock(page)
						  invalidate_inode_page
						    try_to_release_page
						      ubifs_releasepage
						        ubifs_assert(c, 0)
		                                        // bad assertion!
						  unlock(page)
			  truncate_pagecache[PB]

Then we may get following assertion failed:
  UBIFS error (ubi0:0 pid 1683): ubifs_assert_failed [ubifs]:
  UBIFS assert failed: 0, in fs/ubifs/file.c:1513
  UBIFS warning (ubi0:0 pid 1683): ubifs_ro_mode [ubifs]:
  switched to read-only mode, error -22
  CPU: 2 PID: 1683 Comm: aa Not tainted 5.16.0-rc5-00184-g0bca5994cacc-dirty #308
  Call Trace:
    dump_stack+0x13/0x1b
    ubifs_ro_mode+0x54/0x60 [ubifs]
    ubifs_assert_failed+0x4b/0x80 [ubifs]
    ubifs_releasepage+0x67/0x1d0 [ubifs]
    try_to_release_page+0x57/0xe0
    invalidate_inode_page+0xfb/0x130
    __invalidate_mapping_pages+0xb9/0x280
    invalidate_mapping_pagevec+0x12/0x20
    generic_fadvise+0x303/0x3c0
    ksys_fadvise64_64+0x4c/0xb0

[1] https://bugzilla.kernel.org/show_bug.cgi?id=215373
[2] https://linux-mtd.infradead.narkive.com/NQoBeT1u/patch-rfc-ubifs-fix-assert-failed-in-ubifs-set-page-dirty

Fixes: 1e51764a3c2ac0 ("UBIFS: add new flash file system")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/file.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 264b0484ea56..bc2eaf331e56 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1495,14 +1495,23 @@ static bool ubifs_release_folio(struct folio *folio, gfp_t unused_gfp_flags)
 	struct inode *inode = folio->mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 
-	/*
-	 * An attempt to release a dirty page without budgeting for it - should
-	 * not happen.
-	 */
 	if (folio_test_writeback(folio))
 		return false;
+
+	/*
+	 * Page is private but not dirty, weird? There is one condition
+	 * making it happened. ubifs_writepage skipped the page because
+	 * page index beyonds isize (for example. truncated by other
+	 * process named A), then the page is invalidated by fadvise64
+	 * syscall before being truncated by process A.
+	 */
 	ubifs_assert(c, folio_test_private(folio));
-	ubifs_assert(c, 0);
+	if (folio_test_checked(folio))
+		release_new_page_budget(c);
+	else
+		release_existing_page_budget(c);
+
+	atomic_long_dec(&c->dirty_pg_cnt);
 	folio_detach_private(folio);
 	folio_clear_checked(folio);
 	return true;
-- 
2.31.1

