Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371BD5284C0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243611AbiEPMzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243689AbiEPMyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:54:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F92E3A5CA
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:53:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r23so4368784wrr.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RW3LyhQcqgE9zy1F+xq4iCJlLD9gveB3mgv1QCdDgwo=;
        b=W8LdUuv10ewTcDhz1X7a5zGV2iUuUNQI9DHBp0pB1kj2O1+84SnGrz+DkbU9PjKREZ
         daMHKNbuKz70IqhwUlKmXigrH623arBKegFML7riwWs6TgihD1YLiN73ERETQow+WUno
         lPT6o10eSLd9+yfgruBPo1oIC7zQSll41N0Td10cu4dsyGq8TdqBl2b+W4hCUJFq9Xdx
         NtKaMcvYjQiYUqAW6Ak5tG546MMW1KIIKEc2M8XAKapc3NOIjMPuNss8UI6dHDf9hoWI
         NRbZf9yq3qOFJTHSz1xGoYdlStT0JLMxaiJojNQs3cihQVGO/0XNGLGY3ZR6NZeAX5to
         HeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RW3LyhQcqgE9zy1F+xq4iCJlLD9gveB3mgv1QCdDgwo=;
        b=xfxzAaSPr4ac2pNyvLq4zjAD7yHLDuZHkZA/H6PNvbZqCHCNNrd6SMYRttaNZ4ec40
         Jd1X0Fl6KscCOE29qgW/9FHgXA49PClpwZJQ3c5tGu9zwvzeUPTjIMuS3URtoJqN/m19
         ZwoGwQ0h/W96s1+EQAdFYAjanJewV+3Esc8u0Yn2dIEd84msExXnOKiYkph2Kky6aK6J
         xuCCzkBQ4pqJPRAOqQEP829v/kKKSmVtRWAZHQ5D/10u26Loxnqs1hSEjUgUz3e8bR+h
         98HjEQO0bdUTiFpBE6dvjISPyRCJOjYQqx02arjdSqwOiRXRpAg+EnDeRtXNC8AIv0fx
         2b/w==
X-Gm-Message-State: AOAM530GI3Qamyg52Ha4oqEWqX5wCO//zs24hnJMCkwF8jp+5LTGf1/W
        2ri3AZXkb0gfhd5hnBVYdWU=
X-Google-Smtp-Source: ABdhPJwVaUbvlDO5a9DcZzv6XGZZAZB2JybMFB2YgL9SXzdisoGNcasongI8gLNP4TfGQP3q7OihDw==
X-Received: by 2002:a05:6000:1ac8:b0:20c:dced:2f6c with SMTP id i8-20020a0560001ac800b0020cdced2f6cmr13621031wry.107.1652705627883;
        Mon, 16 May 2022 05:53:47 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id x10-20020adfbb4a000000b0020d0435c97bsm4767381wrg.92.2022.05.16.05.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:53:46 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 9A9B0A0E7A; Mon, 16 May 2022 14:54:07 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org, david@redhat.com,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [RFC PATCH v3 5/6] [PATCH 5/6] mm: enable merging of VMAs with different anon_vmas
Date:   Mon, 16 May 2022 14:54:04 +0200
Message-Id: <20220516125405.1675-6-matenajakub@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516125405.1675-1-matenajakub@gmail.com>
References: <20220516125405.1675-1-matenajakub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable merging of a VMA even when it is linked to different
anon_vma than the VMA it is being merged to, but only if the VMA
in question does not share any pages with a parent or child process.
This enables merges that would otherwise not be possible and therefore
decrease number of VMAs of a process.

In this patch the VMA is checked only at the level of anon_vma to find
out if it shares any pages with parent or child process. This check is
performed in is_mergeable_anon_vma() which is a part of vma_merge().
In this case it is not easily possible to check mapcount of individual
pages (as opposed to previous commit "mm: adjust page offset in
mremap"), because vma_merge() does not have a
pointer to the VMA or any other means of easily accessing the page
structures. In the following two paragraphs we are using cases 1
through 8 as described in comment before vma_merge().

The update itself is done during __vma_adjust() for cases 4
through 8 and partially for case 1. Other cases must be solved
elsewhere because __vma_adjust() can only work with pages that already
reside in the location of merge, in other words if VMA already exists
in the location where merge is happening. This is not true for cases 2,
3 and partially case 1, where the next VMA is already present but the
middle part is not. Cases 1,2 and 3 are either expanding or moving VMA
to the location of the merge, but unfortunately at the time of the
merge the mapping is not there yet and therefore the page update has
to be done later. An easy way out is if the pages do not exist yet and
therefore there is nothing to update. This happens e.g. when
expanding a mapping in mmap_region() or in do_brk_flags(). On the other
hand the pages do exist and have to be updated during the mremap call
that moves already existing and possibly faulted mapping. In this case
the page update is done in move_page_tables(). It is actually quite
simple as previous commit "mm: adjust page offset in
mremap" already introduced page update and therefore only
change is updating one more parameter. If rmap walk happens between
__vma_adjust() and page update done in move_page_tables() then old VMA
and old anon_vma are used as it would happen before starting the whole
merge.

The cases 4 through 8 correspond to merges which are a result of a
mprotect call or any other flag update that does not move or resize
the mapping. Together with part of case 1 the update of physical pages
is then handled directly in __vma_adjust() as mentioned before. First
it is determined which address range should be updated, which depends
on the specific case 1, 4, 5, 6, 7 or 8. The address range is set to
variables pu_start and pu_end. Secondly the value being set to the
page->mapping must be determined. However, it is always anon_vma
belonging to the expand parameter of the __vma_adjust() call. The
reason we are updating the pages is that in the __vma_adjust() the
ranges vm_start and vm_end are updated for involved VMAs and so
physical pages can belong to different VMA and anon_vma than before.
The problem is that these two updates (VMAs and pages) should happen
atomically from the rmap walk point of view. This would normally be
solved by using rmap locks, but at the same time we must keep in mind
that page migration uses rmap walk at the start and at the end and
rmap locks might trap it in the middle. This would cause pte to not
point to actual pages but instead remain in the migration entry state,
which would block the page update.
The solution is to drop rmap lock to allow page migration to end
and page walk all the relevant pages, where we wait for possible
migration to end and update the page->mapping (aka anon_vma). After
that we again take rmap lock. This whole page update must be done
after the expand VMA is already enlarged, but the source VMA still has
its original range. This way if rmap walk happens while we are updating
the pages then rmap lock will work either with the old or the new
anon_vma and therefore also the old or new VMA.
If the page is swapped out, zero page or KSM page, then it is not
changed and the correct mapping will be reconstructed from the VMA
itself when the page returns to normal state.
Again as mentioned and explained in the previous commit "mm: adjust page offset in
mremap", the mapcount of the
pages should not change between vma_merge checks and actually merging
in __vma_adjust() as potencial fork is prevented by mmap_lock.

If one of the VMAs is not yet faulted and therefore does not have
anon_vma assigned then this patch is not needed and merge happens even
without it.

Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
---
 include/linux/pagewalk.h |  2 +
 include/linux/rmap.h     | 15 ++++++-
 mm/mmap.c                | 60 ++++++++++++++++++++++++---
 mm/mremap.c              | 22 +++++++---
 mm/pagewalk.c            |  2 +-
 mm/rmap.c                | 87 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 176 insertions(+), 12 deletions(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 11c99c8d343b..9685d1a26f17 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -106,6 +106,8 @@ int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 int walk_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private);
+int __walk_page_range(unsigned long start, unsigned long end,
+			struct mm_walk *walk);
 int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 			  unsigned long end, const struct mm_walk_ops *ops,
 			  pgd_t *pgd,
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 9fee804f47ea..c1ba908f92e6 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -138,6 +138,8 @@ static inline void anon_vma_unlock_read(struct anon_vma *anon_vma)
  */
 void anon_vma_init(void);	/* create anon_vma_cachep */
 int  __anon_vma_prepare(struct vm_area_struct *);
+void reconnect_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
+				struct vm_area_struct *target, struct vm_area_struct *source);
 void take_rmap_locks(struct vm_area_struct *vma);
 void drop_rmap_locks(struct vm_area_struct *vma);
 void unlink_anon_vmas(struct vm_area_struct *);
@@ -154,10 +156,21 @@ static inline int anon_vma_prepare(struct vm_area_struct *vma)
 	return __anon_vma_prepare(vma);
 }
 
+/**
+ * anon_vma_merge() - Merge anon_vmas of the given VMAs
+ * @vma: VMA being merged to
+ * @next: VMA being merged
+ */
 static inline void anon_vma_merge(struct vm_area_struct *vma,
 				  struct vm_area_struct *next)
 {
-	VM_BUG_ON_VMA(vma->anon_vma != next->anon_vma, vma);
+	struct anon_vma *anon_vma1 = vma->anon_vma;
+	struct anon_vma *anon_vma2 = next->anon_vma;
+
+	VM_BUG_ON_VMA(anon_vma1 && anon_vma2 && anon_vma1 != anon_vma2 &&
+			((anon_vma2 != anon_vma2->root)
+			|| !rbt_no_children(anon_vma2)), vma);
+
 	unlink_anon_vmas(next);
 }
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 3ca78baaee13..e7760e378a68 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -753,6 +753,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	bool start_changed = false, end_changed = false;
 	long adjust_next = 0;
 	int remove_next = 0;
+	unsigned long pu_start = 0;
+	unsigned long pu_end = 0;
 
 	if (next && !insert) {
 		struct vm_area_struct *exporter = NULL, *importer = NULL;
@@ -778,6 +780,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 				remove_next = 3;
 				VM_WARN_ON(file != next->vm_file);
 				swap(vma, next);
+				pu_start = start;
+				pu_end = vma->vm_end;
 			} else {
 				VM_WARN_ON(expand != vma);
 				/*
@@ -789,6 +793,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 					   end != next->vm_next->vm_end);
 				/* trim end to next, for case 6 first pass */
 				end = next->vm_end;
+				VM_WARN_ON(vma == NULL);
+
+				pu_start = next->vm_start;
+				pu_end = next->vm_end;
 			}
 
 			exporter = next;
@@ -810,6 +818,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			exporter = next;
 			importer = vma;
 			VM_WARN_ON(expand != importer);
+			pu_start = vma->vm_end;
+			pu_end = end;
 		} else if (end < vma->vm_end) {
 			/*
 			 * vma shrinks, and !insert tells it's not
@@ -820,6 +830,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			exporter = vma;
 			importer = next;
 			VM_WARN_ON(expand != importer);
+			pu_start = end;
+			pu_end = vma->vm_end;
 		}
 
 		/*
@@ -863,8 +875,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	if (!anon_vma && adjust_next)
 		anon_vma = next->anon_vma;
 	if (anon_vma) {
-		VM_WARN_ON(adjust_next && next->anon_vma &&
-			   anon_vma != next->anon_vma);
 		anon_vma_lock_write(anon_vma);
 		anon_vma_interval_tree_pre_update_vma(vma);
 		if (adjust_next)
@@ -887,6 +897,31 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		end_changed = true;
 	}
 	vma->vm_pgoff = pgoff;
+
+	/* Update the anon_vma stored in pages in the range specified by pu_start and pu_end */
+	if (anon_vma && next && anon_vma != next->anon_vma && pu_start != pu_end) {
+		struct vm_area_struct *source;
+
+		anon_vma_unlock_write(anon_vma);
+		VM_WARN_ON(expand == vma && next->anon_vma &&
+			(next->anon_vma != next->anon_vma->root
+				|| !rbt_no_children(next->anon_vma)));
+		VM_WARN_ON(expand == next &&
+			(anon_vma != anon_vma->root || !rbt_no_children(anon_vma)));
+		VM_WARN_ON(expand != vma && expand != next);
+		VM_WARN_ON(expand == NULL);
+		if (expand == vma)
+			source = next;
+		else
+			source = vma;
+		/*
+		 * Page walk over affected address range.
+		 * Wait for migration and update page->mapping.
+		 */
+		reconnect_pages_range(mm, pu_start, pu_end, expand, source);
+		anon_vma_lock_write(anon_vma);
+	}
+
 	if (adjust_next) {
 		next->vm_start += adjust_next;
 		next->vm_pgoff += adjust_next >> PAGE_SHIFT;
@@ -991,6 +1026,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		if (remove_next == 2) {
 			remove_next = 1;
 			end = next->vm_end;
+			pu_start = next->vm_start;
+			pu_end = next->vm_end;
 			goto again;
 		}
 		else if (next)
@@ -1067,7 +1104,20 @@ static inline int is_mergeable_anon_vma(struct anon_vma *anon_vma1,
 	if ((!anon_vma1 || !anon_vma2) && (!vma ||
 		list_is_singular(&vma->anon_vma_chain)))
 		return 1;
-	return anon_vma1 == anon_vma2;
+	if (anon_vma1 == anon_vma2)
+		return 1;
+	/*
+	 * Different anon_vma but not shared by several processes
+	 */
+	else if ((anon_vma1 && anon_vma2) &&
+			(anon_vma1 == anon_vma1->root)
+			&& (rbt_no_children(anon_vma1)))
+		return 1;
+	/*
+	 * Different anon_vma and shared -> unmergeable
+	 */
+	else
+		return 0;
 }
 
 /*
@@ -1213,8 +1263,8 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	}
 	/* Can we merge both the predecessor and the successor? */
 	if (merge_prev && merge_next &&
-			is_mergeable_anon_vma(prev->anon_vma,
-				next->anon_vma, NULL)) {	 /* cases 1, 6 */
+			is_mergeable_anon_vma(next->anon_vma,
+				prev->anon_vma, NULL)) {	 /* cases 1, 6 */
 		err = __vma_adjust(prev, prev->vm_start,
 					next->vm_end, prev->vm_pgoff, NULL,
 					prev);
diff --git a/mm/mremap.c b/mm/mremap.c
index 2ef444abb08a..3b2428288b0e 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -119,12 +119,16 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 }
 
 /*
- * update_pgoff_page() - Update page offset stored in page->index, if the page is not NULL.
+ * update_pgoff_page() - Update page offset stored in page->index
+ * and anon_vma in page->mapping, if the page is not NULL.
  * @addr: new address to calculate the page offset.
  * @page: page to update
+ * @vma: vma to get anon_vma
  */
-static int update_pgoff_page(unsigned long addr, struct page *page)
+static int update_pgoff_page(unsigned long addr, struct page *page, struct vm_area_struct *vma)
 {
+	struct anon_vma *page_anon_vma;
+	unsigned long anon_mapping;
 	if (page != NULL) {
 		get_page(page);
 		if (!trylock_page(page)) {
@@ -132,6 +136,13 @@ static int update_pgoff_page(unsigned long addr, struct page *page)
 			return -1;
 		}
 		page->index = addr >> PAGE_SHIFT;
+
+		anon_mapping = (unsigned long)READ_ONCE(page->mapping);
+		page_anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
+		if (page_anon_vma != vma->anon_vma
+			&& page_anon_vma != NULL) { /* NULL in case of ZERO_PAGE or KSM page */
+			page_move_anon_rmap(page, vma); /* Update physical page's mapping */
+		}
 		unlock_page(page);
 		put_page(page);
 	}
@@ -144,7 +155,8 @@ static int update_pgoff_page(unsigned long addr, struct page *page)
  */
 static int update_pgoff_pte_inner(pte_t *old_pte, unsigned long old_addr,
 					struct vm_area_struct *vma, spinlock_t *old_ptl,
-					pmd_t *old_pmd, unsigned long new_addr)
+					pmd_t *old_pmd, unsigned long new_addr,
+					struct vm_area_struct *new_vma)
 {
 	struct page *page;
 	/*
@@ -170,7 +182,7 @@ static int update_pgoff_pte_inner(pte_t *old_pte, unsigned long old_addr,
 	}
 
 	page = vm_normal_page(vma, old_addr, *old_pte);
-	return update_pgoff_page(new_addr, page);
+	return update_pgoff_page(new_addr, page, new_vma);
 }
 
 static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
@@ -227,7 +239,7 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 
 		if (update_pgoff)
 			if (update_pgoff_pte_inner(old_pte, old_addr, vma, old_ptl,
-						old_pmd, new_addr))
+						old_pmd, new_addr, new_vma))
 				break; /* Causes unlock after for cycle and goto retry */
 		pte = ptep_get_and_clear(mm, old_addr, old_pte);
 		/*
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index d603962ddd52..4076a5ecdec0 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -419,7 +419,7 @@ static int walk_page_test(unsigned long start, unsigned long end,
 	return 0;
 }
 
-static int __walk_page_range(unsigned long start, unsigned long end,
+int __walk_page_range(unsigned long start, unsigned long end,
 			struct mm_walk *walk)
 {
 	int err = 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index b1bddabd21c6..7caa6ec6110a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -73,6 +73,7 @@
 #include <linux/page_idle.h>
 #include <linux/memremap.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/pagewalk.h>
 
 #include <asm/tlbflush.h>
 
@@ -389,6 +390,92 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 	return -ENOMEM;
 }
 
+/*
+ * reconnect_page() - If the page is not NULL and has a non-NULL anon_vma,
+ * reconnect the page to a anon_vma of the given new VMA.
+ * @page: Page to reconnect to different anon_vma
+ * @old: Old VMA the page is connected to
+ * @new: New VMA the page will be reconnected to
+ */
+static int reconnect_page(struct page *page, struct vm_area_struct *old,
+				struct vm_area_struct *new)
+{
+	struct anon_vma *page_anon_vma;
+	unsigned long anon_mapping;
+	/* Do some checks and lock the page */
+	if (page == NULL)
+		return 0; /* Virtual memory page is not mapped */
+	get_page(page);
+	if (!trylock_page(page)) {
+		put_page(page);
+		return -1;
+	}
+	anon_mapping = (unsigned long)READ_ONCE(page->mapping);
+	page_anon_vma = (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
+	if (page_anon_vma != NULL) { /* NULL in case of ZERO_PAGE or KSM page */
+		VM_WARN_ON(page_anon_vma != old->anon_vma);
+		VM_WARN_ON(old->anon_vma == new->anon_vma);
+		/* Update physical page's mapping */
+		page_move_anon_rmap(page, new);
+	}
+	unlock_page(page);
+	put_page(page);
+	return 0;
+}
+
+/*
+ * reconnect_page_pte() - Reconnect page mapped by pte from old anon_vma
+ * to new anon_vma.
+ * @pte: pte to work with
+ * @addr: Address where the page should be mapped.
+ * @end: Not used
+ * @walk: Pagewalk structure holding pointer to old and new VMAs.
+ */
+static int reconnect_page_pte(pte_t *pte, unsigned long addr,
+			    unsigned long end, struct mm_walk *walk)
+{
+	struct vm_area_struct *old = walk->vma;
+	struct page *page;
+
+	/*
+	 * Page's anon_vma will be reconstructed automatically from the
+	 * VMA after the data will be moved back into RAM
+	 */
+	if (!pte_present(*pte))
+		return 0;
+
+	page = vm_normal_page(old, addr, *pte);
+
+	if (reconnect_page(page, old, walk->private) == -1)
+		walk->action = ACTION_AGAIN;
+	return 0;
+}
+
+/*
+ * reconnect_pages_range() - Reconnect physical pages to anon_vma of target VMA
+ * @mm: Memory descriptor
+ * @start: range start
+ * @end: range end
+ * @target: VMA to newly contain all physical pages
+ * @source: VMA which contains the all physical page before reconnecting them
+ */
+void reconnect_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
+				struct vm_area_struct *target, struct vm_area_struct *source)
+{
+	const struct mm_walk_ops reconnect_pages_ops = {
+		.pte_entry = reconnect_page_pte
+	};
+
+	struct mm_walk walk = {
+		.ops            = &reconnect_pages_ops,
+		.mm             = mm,
+		.private        = target,
+		.flags          = WALK_MIGRATION & WALK_LOCK_RMAP,
+		.vma            = source
+	};
+	/* Modify page->mapping for all pages in range */
+	__walk_page_range(start, end, &walk);
+}
 
 /*
  * rbst_no_children() - Used by rbt_no_children to check node subtree.
-- 
2.35.1

