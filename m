Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1890447F9E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 04:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhL0DM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 22:12:27 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30115 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbhL0DML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 22:12:11 -0500
Received: from kwepemi100002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JMjLG4QRHz1DKFg;
        Mon, 27 Dec 2021 11:08:54 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100002.china.huawei.com (7.221.188.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 27 Dec 2021 11:12:09 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 27 Dec
 2021 11:12:08 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <kirill.shutemov@linux.intel.com>,
        <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 10/15] ubifs: Fix to add refcount once page is set private
Date:   Mon, 27 Dec 2021 11:22:41 +0800
Message-ID: <20211227032246.2886878-11-chengzhihao1@huawei.com>
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

MM defined the rule [1] very clearly that once page was set with PG_private
flag, we should increment the refcount in that page, also main flows like
pageout(), migrate_page() will assume there is one additional page
reference count if page_has_private() returns true. Otherwise, we may
get a BUG in page migration:

  page:0000000080d05b9d refcount:-1 mapcount:0 mapping:000000005f4d82a8
  index:0xe2 pfn:0x14c12
  aops:ubifs_file_address_operations [ubifs] ino:8f1 dentry name:"f30e"
  flags: 0x1fffff80002405(locked|uptodate|owner_priv_1|private|node=0|
  zone=1|lastcpupid=0x1fffff)
  page dumped because: VM_BUG_ON_PAGE(page_count(page) != 0)
  ------------[ cut here ]------------
  kernel BUG at include/linux/page_ref.h:184!
  invalid opcode: 0000 [#1] SMP
  CPU: 3 PID: 38 Comm: kcompactd0 Not tainted 5.15.0-rc5
  RIP: 0010:migrate_page_move_mapping+0xac3/0xe70
  Call Trace:
    ubifs_migrate_page+0x22/0xc0 [ubifs]
    move_to_new_page+0xb4/0x600
    migrate_pages+0x1523/0x1cc0
    compact_zone+0x8c5/0x14b0
    kcompactd+0x2bc/0x560
    kthread+0x18c/0x1e0
    ret_from_fork+0x1f/0x30

Before the time, we should make clean a concept, what does refcount means
in page gotten from grab_cache_page_write_begin(). There are 2 situations:
Situation 1: refcount is 3, page is created by __page_cache_alloc.
  TYPE_A - the write process is using this page
  TYPE_B - page is assigned to one certain mapping by calling
	   __add_to_page_cache_locked()
  TYPE_C - page is added into pagevec list corresponding current cpu by
	   calling lru_cache_add()
Situation 2: refcount is 2, page is gotten from the mapping's tree
  TYPE_B - page has been assigned to one certain mapping
  TYPE_A - the write process is using this page (by calling
	   page_cache_get_speculative())
Filesystem releases one refcount by calling put_page() in xxx_write_end(),
the released refcount corresponds to TYPE_A (write task is using it). If
there are any processes using a page, page migration process will skip the
page by judging whether expected_page_refs() equals to page refcount.

The BUG is caused by following process:
    PA(cpu 0)                           kcompactd(cpu 1)
				compact_zone
ubifs_write_begin
  page_a = grab_cache_page_write_begin
    add_to_page_cache_lru
      lru_cache_add
        pagevec_add // put page into cpu 0's pagevec
  (refcnf = 3, for page creation process)
ubifs_write_end
  SetPagePrivate(page_a) // doesn't increase page count !
  unlock_page(page_a)
  put_page(page_a)  // refcnt = 2
				[...]

    PB(cpu 0)
filemap_read
  filemap_get_pages
    add_to_page_cache_lru
      lru_cache_add
        __pagevec_lru_add // traverse all pages in cpu 0's pagevec
	  __pagevec_lru_add_fn
	    SetPageLRU(page_a)
				isolate_migratepages
                                  isolate_migratepages_block
				    get_page_unless_zero(page_a)
				    // refcnt = 3
                                      list_add(page_a, from_list)
				migrate_pages(from_list)
				  __unmap_and_move
				    move_to_new_page
				      ubifs_migrate_page(page_a)
				        migrate_page_move_mapping
					  expected_page_refs get 3
                                  (migration[1] + mapping[1] + private[1])
	 release_pages
	   put_page_testzero(page_a) // refcnt = 3
                                          page_ref_freeze  // refcnt = 0
	     page_ref_dec_and_test(0 - 1 = -1)
                                          page_ref_unfreeze
                                            VM_BUG_ON_PAGE(-1 != 0, page)

UBIFS doesn't increase the page refcount after setting private flag, which
leads to page migration task believes the page is not used by any other
processes, so the page is migrated. This causes concurrent accessing on
page refcount between put_page() called by other process(eg. read process
calls lru_cache_add) and page_ref_unfreeze() called by migration task.

Actually zhangjun has tried to fix this problem [2] by recalculating page
refcnt in ubifs_migrate_page(). It's better to follow MM rules [1], because
just like Kirill suggested in [2], we need to check all users of
page_has_private() helper. Like f2fs does in [3], fix it by adding/deleting
refcount when setting/clearing private for a page. BTW, according to [4],
we set 'page->private' as 1 because ubifs just simply SetPagePrivate().
And, [5] provided a common helper to set/clear page private, ubifs can
use this helper following the example of iomap, afs, btrfs, etc.

Jump [6] to find a reproducer.

[1] https://lore.kernel.org/lkml/2b19b3c4-2bc4-15fa-15cc-27a13e5c7af1@aol.com
[2] https://www.spinics.net/lists/linux-mtd/msg04018.html
[3] http://lkml.iu.edu/hypermail/linux/kernel/1903.0/03313.html
[4] https://lore.kernel.org/linux-f2fs-devel/20210422154705.GO3596236@casper.infradead.org
[5] https://lore.kernel.org/all/20200517214718.468-1-guoqing.jiang@cloud.ionos.com
[6] https://bugzilla.kernel.org/show_bug.cgi?id=214961

Fixes: 1e51764a3c2ac0 ("UBIFS: add new flash file system")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 5cfa28cd00cd..6b45a037a047 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -570,7 +570,7 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
 	}
 
 	if (!PagePrivate(page)) {
-		SetPagePrivate(page);
+		attach_page_private(page, (void *)1);
 		atomic_long_inc(&c->dirty_pg_cnt);
 		__set_page_dirty_nobuffers(page);
 	}
@@ -947,7 +947,7 @@ static int do_writepage(struct page *page, int len)
 		release_existing_page_budget(c);
 
 	atomic_long_dec(&c->dirty_pg_cnt);
-	ClearPagePrivate(page);
+	detach_page_private(page);
 	ClearPageChecked(page);
 
 	kunmap(page);
@@ -1304,7 +1304,7 @@ static void ubifs_invalidatepage(struct page *page, unsigned int offset,
 		release_existing_page_budget(c);
 
 	atomic_long_dec(&c->dirty_pg_cnt);
-	ClearPagePrivate(page);
+	detach_page_private(page);
 	ClearPageChecked(page);
 }
 
@@ -1471,8 +1471,8 @@ static int ubifs_migrate_page(struct address_space *mapping,
 		return rc;
 
 	if (PagePrivate(page)) {
-		ClearPagePrivate(page);
-		SetPagePrivate(newpage);
+		detach_page_private(page);
+		attach_page_private(newpage, (void *)1);
 	}
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
@@ -1496,7 +1496,7 @@ static int ubifs_releasepage(struct page *page, gfp_t unused_gfp_flags)
 		return 0;
 	ubifs_assert(c, PagePrivate(page));
 	ubifs_assert(c, 0);
-	ClearPagePrivate(page);
+	detach_page_private(page);
 	ClearPageChecked(page);
 	return 1;
 }
@@ -1567,7 +1567,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
 	else {
 		if (!PageChecked(page))
 			ubifs_convert_page_budget(c);
-		SetPagePrivate(page);
+		attach_page_private(page, (void *)1);
 		atomic_long_inc(&c->dirty_pg_cnt);
 		__set_page_dirty_nobuffers(page);
 	}
-- 
2.31.1

