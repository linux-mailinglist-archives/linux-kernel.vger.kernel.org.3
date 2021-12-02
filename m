Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8374660EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356806AbhLBJ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:57:09 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32867 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356824AbhLBJ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:56:42 -0500
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J4WVD4psxzcbWq;
        Thu,  2 Dec 2021 17:53:08 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 17:53:16 +0800
Received: from huawei.com (10.175.113.32) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 2 Dec
 2021 17:53:15 +0800
From:   Nanyong Sun <sunnanyong@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: ksm: fix use-after-free kasan report in ksm_might_need_to_copy
Date:   Thu, 2 Dec 2021 18:29:40 +0800
Message-ID: <20211202102940.1069634-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When under the stress of swapping in/out with KSM enabled, there is
a low probability that kasan reports the BUG of use-after-free in
ksm_might_need_to_copy() when do swap in. The freed object is the
anon_vma got from page_anon_vma(page).
It is because a swapcache page associated with one anon_vma now needed
for another anon_vma, but the page's original vma was unmapped and
the anon_vma was freed. In this case the if condition below always
return false and then alloc a new page to copy. Swapin process then
use the new page and can continue to run well, so this is harmless
actually.

} else if (anon_vma->root == vma->anon_vma->root &&
                 page->index == linear_page_index(vma, address)) {

This patch exchange the order of above two judgment statement to avoid
the kasan warning. Let cpu run "page->index ==
linear_page_index(vma, address)" firstly and return false basically to
skip the read of anon_vma->root which may trigger the kasan
use-after-free warning.

==================================================================
BUG: KASAN: use-after-free in ksm_might_need_to_copy+0x12e/0x5b0
Read of size 8 at addr ffff88be9977dbd0 by task khugepaged/694

 CPU: 8 PID: 694 Comm: khugepaged Kdump: loaded Tainted: G OE - 4.18.0.x86_64
 Hardware name: 1288H V5/BC11SPSC0, BIOS 7.93 01/14/2021
Call Trace:
 dump_stack+0xf1/0x19b
 print_address_description+0x70/0x360
 kasan_report+0x1b2/0x330
 ksm_might_need_to_copy+0x12e/0x5b0
 do_swap_page+0x452/0xe70
 __collapse_huge_page_swapin+0x24b/0x720
 khugepaged_scan_pmd+0xcae/0x1ff0
 khugepaged+0x8ee/0xd70
 kthread+0x1a2/0x1d0
 ret_from_fork+0x1f/0x40

Allocated by task 2306153:
 kasan_kmalloc+0xa0/0xd0
 kmem_cache_alloc+0xc0/0x1c0
 anon_vma_clone+0xf7/0x380
 anon_vma_fork+0xc0/0x390
 copy_process+0x447b/0x4810
 _do_fork+0x118/0x620
 do_syscall_64+0x112/0x360
 entry_SYSCALL_64_after_hwframe+0x65/0xca

Freed by task 2306242:
 __kasan_slab_free+0x130/0x180
 kmem_cache_free+0x78/0x1d0
 unlink_anon_vmas+0x19c/0x4a0
 free_pgtables+0x137/0x1b0
 exit_mmap+0x133/0x320
 mmput+0x15e/0x390
 do_exit+0x8c5/0x1210
 do_group_exit+0xb5/0x1b0
 __x64_sys_exit_group+0x21/0x30
 do_syscall_64+0x112/0x360
 entry_SYSCALL_64_after_hwframe+0x65/0xca

The buggy address belongs to the object at ffff88be9977dba0
 which belongs to the cache anon_vma_chain of size 64
The buggy address is located 48 bytes inside of
 64-byte region [ffff88be9977dba0, ffff88be9977dbe0)
The buggy address belongs to the page:
page:ffffea00fa65df40 count:1 mapcount:0 mapping:ffff888107717800 index:0x0
flags: 0x17ffffc0000100(slab)
==================================================================

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 mm/ksm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 0662093237e4..4ce462dd31a4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2575,8 +2575,8 @@ struct page *ksm_might_need_to_copy(struct page *page,
 			return page;	/* no need to copy it */
 	} else if (!anon_vma) {
 		return page;		/* no need to copy it */
-	} else if (anon_vma->root == vma->anon_vma->root &&
-		 page->index == linear_page_index(vma, address)) {
+	} else if (page->index == linear_page_index(vma, address) &&
+			anon_vma->root == vma->anon_vma->root) {
 		return page;		/* still no need to copy it */
 	}
 	if (!PageUptodate(page))
-- 
2.25.1

