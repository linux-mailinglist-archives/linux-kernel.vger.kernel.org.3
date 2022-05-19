Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C1052D2F9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbiESMud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbiESMuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:50:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B5FBA57A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:50:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L3qS62BL0zjWxC;
        Thu, 19 May 2022 20:49:26 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 20:50:16 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>, <rcampbell@nvidia.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v4 1/5] mm/swapfile: unuse_pte can map random data if swap read fails
Date:   Thu, 19 May 2022 20:50:26 +0800
Message-ID: <20220519125030.21486-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220519125030.21486-1-linmiaohe@huawei.com>
References: <20220519125030.21486-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in unuse_pte(): when swap page happens to be unreadable,
page filled with random data is mapped into user address space.  In case
of error, a special swap entry indicating swap read fails is set to the
page table.  So the swapcache page can be freed and the user won't end up
with a permanently mounted swap because a sector is bad.  And if the page
is accessed later, the user process will be killed so that corrupted data
is never consumed.  On the other hand, if the page is never accessed, the
user won't even notice it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/swap.h    |  7 ++++++-
 include/linux/swapops.h | 10 ++++++++++
 mm/memory.c             |  5 ++++-
 mm/swapfile.c           | 11 +++++++++++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index f3ae17b43f20..0c0fed1b348f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -55,6 +55,10 @@ static inline int current_is_kswapd(void)
  * actions on faults.
  */
 
+#define SWP_SWAPIN_ERROR_NUM 1
+#define SWP_SWAPIN_ERROR     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
+			     SWP_MIGRATION_NUM + SWP_DEVICE_NUM + \
+			     SWP_PTE_MARKER_NUM)
 /*
  * PTE markers are used to persist information onto PTEs that are mapped with
  * file-backed memories.  As its name "PTE" hints, it should only be applied to
@@ -120,7 +124,8 @@ static inline int current_is_kswapd(void)
 
 #define MAX_SWAPFILES \
 	((1 << MAX_SWAPFILES_SHIFT) - SWP_DEVICE_NUM - \
-	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - SWP_PTE_MARKER_NUM)
+	SWP_MIGRATION_NUM - SWP_HWPOISON_NUM - \
+	SWP_PTE_MARKER_NUM - SWP_SWAPIN_ERROR_NUM)
 
 /*
  * Magic header for a swap area. The first part of the union is
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index fe220df499f1..f24775b41880 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -108,6 +108,16 @@ static inline void *swp_to_radix_entry(swp_entry_t entry)
 	return xa_mk_value(entry.val);
 }
 
+static inline swp_entry_t make_swapin_error_entry(struct page *page)
+{
+	return swp_entry(SWP_SWAPIN_ERROR, page_to_pfn(page));
+}
+
+static inline int is_swapin_error_entry(swp_entry_t entry)
+{
+	return swp_type(entry) == SWP_SWAPIN_ERROR;
+}
+
 #if IS_ENABLED(CONFIG_DEVICE_PRIVATE)
 static inline swp_entry_t make_readable_device_private_entry(pgoff_t offset)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 8fc2bc4c9d21..76f371702e99 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1496,7 +1496,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			/* Only drop the uffd-wp marker if explicitly requested */
 			if (!zap_drop_file_uffd_wp(details))
 				continue;
-		} else if (is_hwpoison_entry(entry)) {
+		} else if (is_hwpoison_entry(entry) ||
+			   is_swapin_error_entry(entry)) {
 			if (!should_zap_cows(details))
 				continue;
 		} else {
@@ -3742,6 +3743,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
+		} else if (is_swapin_error_entry(entry)) {
+			ret = VM_FAULT_SIGBUS;
 		} else if (is_pte_marker_entry(entry)) {
 			ret = handle_pte_marker(vmf);
 		} else {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1c3d5b970ddb..226c7d3ba896 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1788,6 +1788,17 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		goto out;
 	}
 
+	if (unlikely(!PageUptodate(page))) {
+		pte_t pteval;
+
+		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
+		pteval = swp_entry_to_pte(make_swapin_error_entry(page));
+		set_pte_at(vma->vm_mm, addr, pte, pteval);
+		swap_free(entry);
+		ret = 0;
+		goto out;
+	}
+
 	/* See do_swap_page() */
 	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
 	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
-- 
2.23.0

