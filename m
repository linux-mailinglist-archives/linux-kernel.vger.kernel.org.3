Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED49512EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344696AbiD1Iml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344190AbiD1Iln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F21F34BAB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651134990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIpAzCZHfZDc6HQttzuYoaoWN2NNPkQULruR9dAqcfo=;
        b=KBFGTmvZ4G/dvUnHtTERntqcJuQ9OWsNp7UH6jTwllNeVuD7wNrDpSIPebQs1fGUi1tNu4
        zqzwMpGoBT13Ykuh2wH2un8Ov1fyawiZvpFQKIcr88aladZdT8d4pQ6S5MNLW5jgCh82Ao
        KDkR8DiD5rDnzLBcFEYasGZHvOHusbY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-baxyjzyaN-qHn6wuif3Zsw-1; Thu, 28 Apr 2022 04:36:18 -0400
X-MC-Unique: baxyjzyaN-qHn6wuif3Zsw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A0F21E1AE5E;
        Thu, 28 Apr 2022 08:36:06 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16364566A32;
        Thu, 28 Apr 2022 08:35:59 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 13/17] mm/rmap: fail try_to_migrate() early when setting a PMD migration entry fails
Date:   Thu, 28 Apr 2022 10:34:37 +0200
Message-Id: <20220428083441.37290-14-david@redhat.com>
In-Reply-To: <20220428083441.37290-1-david@redhat.com>
References: <20220428083441.37290-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's fail right away in case we cannot clear PG_anon_exclusive because
the anon THP may be pinned. Right now, we continue trying to
install migration entries and the caller of try_to_migrate() will
realize that the page is still mapped and has to restore the migration
entries. Let's just fail fast just like for PTE migration entries.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/swapops.h | 4 ++--
 mm/huge_memory.c        | 8 +++++---
 mm/rmap.c               | 6 +++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 06280fc1c99b..8b6e4cd1fab8 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -299,7 +299,7 @@ static inline bool is_pfn_swap_entry(swp_entry_t entry)
 struct page_vma_mapped_walk;
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-extern void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
+extern int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		struct page *page);
 
 extern void remove_migration_pmd(struct page_vma_mapped_walk *pvmw,
@@ -332,7 +332,7 @@ static inline int is_pmd_migration_entry(pmd_t pmd)
 	return !pmd_present(pmd) && is_migration_entry(pmd_to_swp_entry(pmd));
 }
 #else
-static inline void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
+static inline int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		struct page *page)
 {
 	BUILD_BUG();
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 231911b7bf9d..14d7fa6dc793 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3066,7 +3066,7 @@ late_initcall(split_huge_pages_debugfs);
 #endif
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
+int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 		struct page *page)
 {
 	struct vm_area_struct *vma = pvmw->vma;
@@ -3078,7 +3078,7 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	pmd_t pmdswp;
 
 	if (!(pvmw->pmd && !pvmw->pte))
-		return;
+		return 0;
 
 	flush_cache_range(vma, address, address + HPAGE_PMD_SIZE);
 	pmdval = pmdp_invalidate(vma, address, pvmw->pmd);
@@ -3086,7 +3086,7 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	anon_exclusive = PageAnon(page) && PageAnonExclusive(page);
 	if (anon_exclusive && page_try_share_anon_rmap(page)) {
 		set_pmd_at(mm, address, pvmw->pmd, pmdval);
-		return;
+		return -EBUSY;
 	}
 
 	if (pmd_dirty(pmdval))
@@ -3104,6 +3104,8 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	page_remove_rmap(page, vma, true);
 	put_page(page);
 	trace_set_migration_pmd(address, pmd_val(pmdswp));
+
+	return 0;
 }
 
 void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
diff --git a/mm/rmap.c b/mm/rmap.c
index a849c7962281..12f54fbdb920 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1812,7 +1812,11 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
 					!folio_test_pmd_mappable(folio), folio);
 
-			set_pmd_migration_entry(&pvmw, subpage);
+			if (set_pmd_migration_entry(&pvmw, subpage)) {
+				ret = false;
+				page_vma_mapped_walk_done(&pvmw);
+				break;
+			}
 			continue;
 		}
 #endif
-- 
2.35.1

