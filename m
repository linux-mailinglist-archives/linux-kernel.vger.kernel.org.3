Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6E45284BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbiEPMyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243542AbiEPMy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:54:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23C53A1BF
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:53:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u3so20422875wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A0rWI2lLONIT7+b9pf3JkzKqaAFR6Sio8Kh0BbPP5t4=;
        b=cRNQBWUSaU8ZTb3mLWayUvSt2WgVFapHE6E+2n78CQWApmnv3YTT/1CpT4J0OFjVJG
         cxoaZ1tDhKtqOChZ7/K0lynsretSamTSt56kDmZm+L/iPkMCrJ/EYEG4mAd+2qPVZM1r
         3TDktZv12TOO4Fk7YUIfYwtHTCYKew20BwJDx5nbPVZ2Wxwd8DvKuGflHem6KlM/hGCM
         EYLyNgYr4OWW6EIgl9g+nkgrTyms4tm8LnIUCtQQoe0Ep+3Eon/PhxktLFMBA79iBGue
         ed9l1U4fNmaYQG663niRCxbqgrZAnq8MmVhgFh/IVrmu+4zRK+Qm52lXqPYo+8ViWh0D
         5nxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A0rWI2lLONIT7+b9pf3JkzKqaAFR6Sio8Kh0BbPP5t4=;
        b=v12N5+/LEoiMmp7Fk2Bm2jN7cSULx241nzAIWz2VHQkJ+tot/QYMTWUQNoBd1hvRJl
         XXN2rhBf/z9jia1eXrYsFTl6J7HVhyIwNnTot9D5/H8nmwR2lMC42nrMks1KBIqOoKnd
         XcuZ5IO99r/9DVDZWzVotMZrWkJG3C8BaeQ8fILOxJH967YbUrmcdjuBHZVuaKSHvHXr
         nZ6Nk/Ul0STLFoXfwo3Pg8yKPGkeu9qhIGp9QVDlvPaq2Azj/cjQk71fj8hOGO5KFJFv
         KuXsbFjDlaJqTqofSDyxhyhFSo9KfC1HrnZ4Er8CaU8ILOR7e6fxAZ9BrMFGAAIYobEm
         IbBw==
X-Gm-Message-State: AOAM531STquDzD4RY41ACJp3VtCfqFwgbEAQ9uYpTndmDarko3I7Ywve
        vl6ply0Aw7063v6DBZ6sCpU=
X-Google-Smtp-Source: ABdhPJyskl20gRCnwQJxLVV5hqWKuOYrDBxhqPI4L3BVflIiUd4SYWT46rl95XELnlRm0Wb4JJgd0w==
X-Received: by 2002:adf:eb8e:0:b0:20c:b378:67b2 with SMTP id t14-20020adfeb8e000000b0020cb37867b2mr14465715wrn.164.1652705626101;
        Mon, 16 May 2022 05:53:46 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id l11-20020adfbd8b000000b0020c5253d91esm9607279wrh.106.2022.05.16.05.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:53:45 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 96D23A0E79; Mon, 16 May 2022 14:54:07 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org, david@redhat.com,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [RFC PATCH v3 4/6] [PATCH 4/6] mm: adjust page offset in mremap
Date:   Mon, 16 May 2022 14:54:03 +0200
Message-Id: <20220516125405.1675-5-matenajakub@gmail.com>
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

Adjust page offset of a VMA when it's moved to a new location by mremap.
This is made possible for all VMAs that do not share their anonymous
pages with other processes and it is checked by going through the anon_vma
tree and looking for parent child relationship. Also and maybe
redundantly this is checked for individual struct pages belonging to the
given vma by looking at their mapcount or swap entry reference count if
the page is swapped out. This is all done in can_update_faulted_pgoff(),
is_shared_pte().

If none of the pages is shared then we proceed with the
page offset update. This means updating page offset in the copy_vma()
which is used when creating the VMA copy or possibly when deciding
whether to merge with a neighboring VMA. We also set pgoff_updatable to
true to later update page offsets of individual pages.
This is done later in move_page_tables() when moving
individual pte entries to the target VMA. The page offset update
actually forces the move to happen at the pte level by using
move_ptes(). It is necessary because the page update must happen
atomically with the move and that is not possible when moving bigger
entries like pmd or pud. We do not need to update swapped out pages,
because in that case page offset is reconstructed automatically from VMA
after the page is swapped in.
As mentioned above there is a small amount of time between checking and
actually updating the page offset of pages as well as between merging VMAs
and again updating the pages. This could potencially interfere with rmap
walk, but fortunately in that case rmap walk can use the still existing old
VMA, as it would before the mremap started. Any other potential changes
to the VMA or pages is prevented by mmap_lock, which prevents forking and
therefore also COW and hence raising the mapcount. Because pages are not
shared, but belong to only one process, there is no other process which
might fork and in that way increase mapcount of the pages in question.

If a page is shared we can't update page offset of the page, because
that would interfere with the page offset for the other processes using
the page. Page offset is basically immutable as long as the page is used
by more than one process.
Previously, adjusting page offset was possible only for not yet faulted
VMAs, even though a page offset matching the virtual address of the
anonymous VMA is necessary to successfully merge with another VMA.

Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
---
 fs/exec.c                |   2 +-
 include/linux/mm.h       |   4 +-
 include/linux/pagewalk.h |   2 +
 include/linux/rmap.h     |   2 +
 mm/mmap.c                | 113 +++++++++++++++++++++++++++++++------
 mm/mremap.c              | 117 +++++++++++++++++++++++++++++++++------
 mm/pagewalk.c            |   2 +-
 mm/rmap.c                |  41 ++++++++++++++
 8 files changed, 244 insertions(+), 39 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e3e55d5e0be1..207f60fcb2b4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -709,7 +709,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	 * process cleanup to remove whatever mess we made.
 	 */
 	if (length != move_page_tables(vma, old_start,
-				       vma, new_start, length, false))
+				       vma, new_start, length, false, false))
 		return -ENOMEM;
 
 	lru_add_drain();
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e34edb775334..d8e482aef901 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1951,7 +1951,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 extern unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks);
+		bool need_rmap_locks, bool update_pgoff);
 
 /*
  * Flags used by change_protection().  For now we make it a bitmap so
@@ -2637,7 +2637,7 @@ extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks);
+	bool *need_rmap_locks, bool *update_pgoff);
 extern void exit_mmap(struct mm_struct *);
 
 static inline int check_data_rlimit(unsigned long rlim,
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 07345df51324..11c99c8d343b 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -101,6 +101,8 @@ struct mm_walk {
 	void *private;
 };
 
+int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
+			struct mm_walk *walk);
 int walk_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		void *private);
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index d2d5e511dd93..9fee804f47ea 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -144,6 +144,8 @@ void unlink_anon_vmas(struct vm_area_struct *);
 int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *);
 int anon_vma_fork(struct vm_area_struct *, struct vm_area_struct *);
 
+bool rbt_no_children(struct anon_vma *av);
+
 static inline int anon_vma_prepare(struct vm_area_struct *vma)
 {
 	if (likely(vma->anon_vma))
diff --git a/mm/mmap.c b/mm/mmap.c
index 4a4611443593..3ca78baaee13 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -48,6 +48,8 @@
 #include <linux/pkeys.h>
 #include <linux/oom.h>
 #include <linux/sched/mm.h>
+#include <linux/pagewalk.h>
+#include <linux/swapops.h>
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
@@ -3189,28 +3191,100 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 	return 0;
 }
 
+/*
+ * is_shared_pte() - Check if the given pte points to a page that is not shared between processes.
+ * @pte: pte to check
+ * @addr: Address where the page is mapped
+ * @end: Not used
+ * @walk: Pagewalk structure holding pointer to VMA where the page belongs
+ */
+static int is_shared_pte(pte_t *pte, unsigned long addr,
+				unsigned long end, struct mm_walk *walk)
+{
+	int err;
+	struct page *page;
+	struct vm_area_struct *old = walk->vma;
+
+	if (is_swap_pte(*pte)) {
+		swp_entry_t entry = pte_to_swp_entry(*pte);
+		struct swap_info_struct *info = swp_swap_info(entry);
+		/*
+		 * If the reference count is higher than one than the swap slot is used by
+		 * more than one process or the swap cache is active, which means that the
+		 * page is mapped by at least one process and swapped out by at least one
+		 * process, so in both cases this means the page is shared.
+		 * There can also exist continuation pages if the reference count is too
+		 * high to fit in just one cell. This is specified by the flag COUNT_CONTINUED,
+		 * which again triggers the below condition if set.
+		 */
+		return info->swap_map[swp_offset(entry)] > 1;
+	}
+
+	if (!pte_present(*pte))
+		return 0;
+	page = vm_normal_page(old, addr, *pte);
+	if (page == NULL)
+		return 0;
+	/* Check page is not shared with other processes */
+	err = page_mapcount(page) + page_swapcount(page) > 1;
+	return err;
+}
+
+/**
+ * can_update_faulted_pgoff() - Check if pgoff update is possible for faulted pages of a vma
+ * @vma: VMA which should be moved
+ * @addr: new virtual address
+ * If the vma and its pages are not shared with another process, updating
+ * the new pgoff and also updating index parameter (copy of the pgoff) in
+ * all faulted pages is possible.
+ */
+static bool can_update_faulted_pgoff(struct vm_area_struct *vma, unsigned long addr)
+{
+	const struct mm_walk_ops can_update_pgoff_ops = {
+		.pte_entry = is_shared_pte
+	};
+
+	/* Check vma is not shared with other processes */
+	if (vma->anon_vma->root != vma->anon_vma || !rbt_no_children(vma->anon_vma))
+		return 1;
+	/* walk_page_vma() returns 0 on success */
+	return !walk_page_vma(vma, &can_update_pgoff_ops, NULL, WALK_MIGRATION | WALK_LOCK_RMAP);
+}
+
 /*
  * Copy the vma structure to a new location in the same mm,
  * prior to moving page table entries, to effect an mremap move.
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks)
+	bool *need_rmap_locks, bool *update_pgoff)
 {
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
-	bool faulted_in_anon_vma = true;
+	bool anon_pgoff_updated = false;
+	*need_rmap_locks = false;
+	*update_pgoff = false;
 
 	/*
-	 * If anonymous vma has not yet been faulted, update new pgoff
+	 * Try to update new pgoff for anonymous vma
 	 * to match new location, to increase its chance of merging.
 	 */
-	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
-		pgoff = addr >> PAGE_SHIFT;
-		faulted_in_anon_vma = false;
+	if (unlikely(vma_is_anonymous(vma))) {
+		if (!vma->anon_vma) {
+			pgoff = addr >> PAGE_SHIFT;
+			anon_pgoff_updated = true;
+		} else {
+			anon_pgoff_updated = can_update_faulted_pgoff(vma, addr);
+			if (anon_pgoff_updated) {
+				/* Update pgoff of the copied VMA */
+				pgoff = addr >> PAGE_SHIFT;
+				*update_pgoff = true;
+				*need_rmap_locks = true;
+			}
+		}
 	}
 
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
@@ -3227,19 +3301,25 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 			/*
 			 * The only way we can get a vma_merge with
 			 * self during an mremap is if the vma hasn't
-			 * been faulted in yet and we were allowed to
-			 * reset the dst vma->vm_pgoff to the
-			 * destination address of the mremap to allow
-			 * the merge to happen. mremap must change the
-			 * vm_pgoff linearity between src and dst vmas
-			 * (in turn preventing a vma_merge) to be
-			 * safe. It is only safe to keep the vm_pgoff
-			 * linear if there are no pages mapped yet.
+			 * been faulted in yet or is not shared and
+			 * we were allowed to reset the dst
+			 * vma->vm_pgoff to the destination address of
+			 * the mremap to allow the merge to happen.
+			 * mremap must change the vm_pgoff linearity
+			 * between src and dst vmas (in turn
+			 * preventing a vma_merge) to be safe. It is
+			 * only safe to keep the vm_pgoff linear if
+			 * there are no pages mapped yet or the none
+			 * of the pages are shared with another process.
 			 */
-			VM_BUG_ON_VMA(faulted_in_anon_vma, new_vma);
+			VM_BUG_ON_VMA(!anon_pgoff_updated, new_vma);
 			*vmap = vma = new_vma;
 		}
-		*need_rmap_locks = (new_vma->vm_pgoff <= vma->vm_pgoff);
+		/*
+		 * If new_vma is located before the old vma, rmap traversal order is altered
+		 * and we need to apply rmap locks on vma later.
+		 */
+		*need_rmap_locks |= (new_vma->vm_pgoff <= vma->vm_pgoff);
 	} else {
 		new_vma = vm_area_dup(vma);
 		if (!new_vma)
@@ -3256,7 +3336,6 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
 		vma_link(mm, new_vma, prev, rb_link, rb_parent);
-		*need_rmap_locks = false;
 	}
 	return new_vma;
 
diff --git a/mm/mremap.c b/mm/mremap.c
index 309fab7ed706..2ef444abb08a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -24,6 +24,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/uaccess.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/pagewalk.h>
 #include <linux/rmap.h>
 
 #include <asm/cacheflush.h>
@@ -117,10 +118,66 @@ static pte_t move_soft_dirty_pte(pte_t pte)
 	return pte;
 }
 
+/*
+ * update_pgoff_page() - Update page offset stored in page->index, if the page is not NULL.
+ * @addr: new address to calculate the page offset.
+ * @page: page to update
+ */
+static int update_pgoff_page(unsigned long addr, struct page *page)
+{
+	if (page != NULL) {
+		get_page(page);
+		if (!trylock_page(page)) {
+			put_page(page);
+			return -1;
+		}
+		page->index = addr >> PAGE_SHIFT;
+		unlock_page(page);
+		put_page(page);
+	}
+	return 0;
+}
+
+/*
+ * update_pgoff_pte_inner() - Wait for migration and update page offset of
+ * a page represented by pte, if the pte points to mapped page.
+ */
+static int update_pgoff_pte_inner(pte_t *old_pte, unsigned long old_addr,
+					struct vm_area_struct *vma, spinlock_t *old_ptl,
+					pmd_t *old_pmd, unsigned long new_addr)
+{
+	struct page *page;
+	/*
+	 * If pte is in migration state then wait for migration
+	 * and return with -1 to trigger relocking mechanism in move_ptes().
+	 */
+	if (!pte_present(*old_pte)) {
+		if (!pte_none(*old_pte)) {
+			swp_entry_t entry;
+			entry = pte_to_swp_entry(*old_pte);
+			if (is_migration_entry(entry)) {
+				migration_entry_wait(vma->vm_mm, old_pmd, old_addr);
+				return -1;
+			}
+		}
+		/*
+		 * If there is no migration entry, but at the same
+		 * time the page is not present then the page offset
+		 * will be reconstructed automatically from the
+		 * VMA after the page is moved back into RAM.
+		 */
+		return 0;
+	}
+
+	page = vm_normal_page(vma, old_addr, *old_pte);
+	return update_pgoff_page(new_addr, page);
+}
+
 static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		unsigned long old_addr, unsigned long old_end,
 		struct vm_area_struct *new_vma, pmd_t *new_pmd,
-		unsigned long new_addr, bool need_rmap_locks)
+		unsigned long new_addr, bool need_rmap_locks,
+		bool update_pgoff)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
@@ -146,6 +203,8 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	 *   serialize access to individual ptes, but only rmap traversal
 	 *   order guarantees that we won't miss both the old and new ptes).
 	 */
+
+retry:
 	if (need_rmap_locks)
 		take_rmap_locks(vma);
 
@@ -166,6 +225,10 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 		if (pte_none(*old_pte))
 			continue;
 
+		if (update_pgoff)
+			if (update_pgoff_pte_inner(old_pte, old_addr, vma, old_ptl,
+						old_pmd, new_addr))
+				break; /* Causes unlock after for cycle and goto retry */
 		pte = ptep_get_and_clear(mm, old_addr, old_pte);
 		/*
 		 * If we are remapping a valid PTE, make sure
@@ -194,6 +257,8 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *old_pmd,
 	pte_unmap_unlock(old_pte - 1, old_ptl);
 	if (need_rmap_locks)
 		drop_rmap_locks(vma);
+	if (old_addr < old_end)
+		goto retry;
 }
 
 #ifndef arch_supports_page_table_move
@@ -422,11 +487,19 @@ static __always_inline unsigned long get_extent(enum pgt_entry entry,
  * pgt_entry. Returns true if the move was successful, else false.
  */
 static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
-			unsigned long old_addr, unsigned long new_addr,
-			void *old_entry, void *new_entry, bool need_rmap_locks)
+			struct vm_area_struct *new_vma,	unsigned long old_addr,
+			unsigned long new_addr,	void *old_entry, void *new_entry,
+			bool need_rmap_locks, bool update_pgoff)
 {
 	bool moved = false;
 
+	/*
+	 * In case of page offset update move must be done
+	 * at the pte level using move_ptes()
+	 */
+	if (update_pgoff)
+		return false;
+
 	/* See comment in move_ptes() */
 	if (need_rmap_locks)
 		take_rmap_locks(vma);
@@ -465,7 +538,7 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks)
+		bool need_rmap_locks, bool update_pgoff)
 {
 	unsigned long extent, old_end;
 	struct mmu_notifier_range range;
@@ -492,7 +565,14 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		 * If extent is PUD-sized try to speed up the move by moving at the
 		 * PUD level if possible.
 		 */
-		extent = get_extent(NORMAL_PUD, old_addr, old_end, new_addr);
+		if (update_pgoff)
+			/*
+			 * In case of pgoff update, extent is set to PMD
+			 * and is done using move_ptes()
+			 */
+			extent = get_extent(NORMAL_PMD, old_addr, old_end, new_addr);
+		else
+			extent = get_extent(NORMAL_PUD, old_addr, old_end, new_addr);
 
 		old_pud = get_old_pud(vma->vm_mm, old_addr);
 		if (!old_pud)
@@ -502,15 +582,15 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			break;
 		if (pud_trans_huge(*old_pud) || pud_devmap(*old_pud)) {
 			if (extent == HPAGE_PUD_SIZE) {
-				move_pgt_entry(HPAGE_PUD, vma, old_addr, new_addr,
-					       old_pud, new_pud, need_rmap_locks);
+				move_pgt_entry(HPAGE_PUD, vma, new_vma, old_addr, new_addr,
+					       old_pud, new_pud, need_rmap_locks, update_pgoff);
 				/* We ignore and continue on error? */
 				continue;
 			}
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD) && extent == PUD_SIZE) {
 
-			if (move_pgt_entry(NORMAL_PUD, vma, old_addr, new_addr,
-					   old_pud, new_pud, true))
+			if (move_pgt_entry(NORMAL_PUD, vma, new_vma, old_addr, new_addr,
+					   old_pud, new_pud, true, update_pgoff))
 				continue;
 		}
 
@@ -524,8 +604,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
 		    pmd_devmap(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
-			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr,
-					   old_pmd, new_pmd, need_rmap_locks))
+			    move_pgt_entry(HPAGE_PMD, vma, new_vma, old_addr, new_addr,
+					   old_pmd, new_pmd, need_rmap_locks, update_pgoff))
 				continue;
 			split_huge_pmd(vma, old_pmd, old_addr);
 			if (pmd_trans_unstable(old_pmd))
@@ -536,15 +616,15 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 			 * If the extent is PMD-sized, try to speed the move by
 			 * moving at the PMD level if possible.
 			 */
-			if (move_pgt_entry(NORMAL_PMD, vma, old_addr, new_addr,
-					   old_pmd, new_pmd, true))
+			if (move_pgt_entry(NORMAL_PMD, vma, new_vma, old_addr, new_addr,
+					   old_pmd, new_pmd, true, update_pgoff))
 				continue;
 		}
 
 		if (pte_alloc(new_vma->vm_mm, new_pmd))
 			break;
 		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
-			  new_pmd, new_addr, need_rmap_locks);
+			  new_pmd, new_addr, need_rmap_locks, update_pgoff);
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
@@ -568,7 +648,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	unsigned long hiwater_vm;
 	int split = 0;
 	int err = 0;
-	bool need_rmap_locks;
+	bool need_rmap_locks = false;
+	bool update_pgoff = false;
 
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
@@ -608,7 +689,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
 	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
-			   &need_rmap_locks);
+			   &need_rmap_locks, &update_pgoff);
 	if (!new_vma) {
 		if (vm_flags & VM_ACCOUNT)
 			vm_unacct_memory(to_account >> PAGE_SHIFT);
@@ -616,7 +697,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len,
-				     need_rmap_locks);
+				     need_rmap_locks, update_pgoff);
 	if (moved_len < old_len) {
 		err = -ENOMEM;
 	} else if (vma->vm_ops && vma->vm_ops->mremap) {
@@ -630,7 +711,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		 * and then proceed to unmap new area instead of old.
 		 */
 		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,
-				 true);
+				 true, update_pgoff);
 		vma = new_vma;
 		old_len = new_len;
 		old_addr = new_addr;
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 0bfb8c9255f3..d603962ddd52 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -89,7 +89,7 @@ static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
 	return err;
 }
 
-static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
+int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			  struct mm_walk *walk)
 {
 	pte_t *pte;
diff --git a/mm/rmap.c b/mm/rmap.c
index d4d95ada0946..b1bddabd21c6 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -389,6 +389,47 @@ int anon_vma_fork(struct vm_area_struct *vma, struct vm_area_struct *pvma)
 	return -ENOMEM;
 }
 
+
+/*
+ * rbst_no_children() - Used by rbt_no_children to check node subtree.
+ * Check if none of the VMAs connected to the node subtree via
+ * anon_vma_chain are in child relationship to the given anon_vma.
+ * @av: anon_vma to check
+ * @node: node to check in this level
+ */
+static bool rbst_no_children(struct anon_vma *av, struct rb_node *node)
+{
+	struct anon_vma_chain *model;
+	struct anon_vma_chain *avc;
+
+	if (node == NULL) /* leaf node */
+		return true;
+	avc = container_of(node, typeof(*(model)), rb);
+	if (avc->vma->anon_vma != av)
+		/*
+		 * Inequality implies avc belongs
+		 * to a VMA of a child process
+		 */
+		return false;
+	return (rbst_no_children(av, node->rb_left) &&
+	rbst_no_children(av, node->rb_right));
+}
+
+/*
+ * rbt_no_children() - Check if none of the VMAs connected to the given
+ * anon_vma via anon_vma_chain are in child relationship
+ * @av: anon_vma to check if it has children
+ */
+bool rbt_no_children(struct anon_vma *av)
+{
+	struct rb_node *root_node;
+
+	if (av == NULL || av->degree <= 1) /* Higher degree might not necessarily imply children */
+		return true;
+	root_node = av->rb_root.rb_root.rb_node;
+	return rbst_no_children(av, root_node);
+}
+
 void unlink_anon_vmas(struct vm_area_struct *vma)
 {
 	struct anon_vma_chain *avc, *next;
-- 
2.35.1

