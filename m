Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263044B60FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiBOC05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:26:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiBOC0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:26:54 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8257EB3C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:26:43 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id y8so17256078qtn.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=9UznFjE0f1ZIgv9dUCI0SLipO5AY6pyPaKDi8Cv/EQM=;
        b=BbegNf76jqpHkWfFh0RP1kr2zL0tYxxIv8mqNTimgqXOM7hI1v7czAt+R2ulgFX7D7
         kvF2D/2FPfcdv/PuEEiPyw4ze/1K58f+XxRTURfA7K5vv2kZRQK1Dnaag+ioz9x2arL4
         WQhmnhcBCI3AKUOGUj6An/4f7CHn5jfM2ODNe/JLEJKL273t1cav7Vwl8InJnEFRGrZo
         FvzdaoytwW4aPSifIW9ZkhcIMDh0tQmz6pxmLsld42WQs1lMvalvjx0vAPO8cFTuj2w4
         cd8kQvQ1Kzz1+xTHOzPdFlJ1A3aUJ6pqp1vBjO1q348rN4QR500aoAqx/IhI48KbyRxK
         3rzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=9UznFjE0f1ZIgv9dUCI0SLipO5AY6pyPaKDi8Cv/EQM=;
        b=6RuQGK8u0uSr/lFPYtbt5LJo/32+RC18MHDmYuS8DWtBwMqZLu9cMoFFuQGedsw4jD
         XH0ClH8t5bSFGvUS1Woo//+TaIR5cvHTazv/Xro1Yeh6NKcdn3q02Z0/qs1lBS2ilIj6
         gR/dyQcSdmZq9ZjIHeGw09+9v/EoomZZ7ZCD2SbBGMEcwlIhoqokJaV3Lh8it8mm+MEl
         0d4SZNquK2p7yRYscvLjHjPZKp+O/SyIfZJF8BBcE8z3fxcMwB5Bb9PTkzww7oXx9M8O
         aECRhXif7pjC0Na3wy/E1PFwirtuE71H7ra+dqO45joOj9qhPIMs9L6TuGLsmo5XO+UW
         61kw==
X-Gm-Message-State: AOAM532AxY3bw921zoQx0Ctsq3+JDBB4RJ3MsRvzjrpiay+AJBN5xQBP
        eRLf38lWcxnh/NGk3Flp44F5qw==
X-Google-Smtp-Source: ABdhPJz0FzVqX6A8lLoqFJ3jt5ujuQw5P3m1e4tDotlsfo3eBY5AqGxbuwQ9v6CrWIkL3mdlk2vHpA==
X-Received: by 2002:ac8:5810:: with SMTP id g16mr1324261qtg.163.1644892002756;
        Mon, 14 Feb 2022 18:26:42 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 132sm390294qkk.119.2022.02.14.18.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:26:41 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:26:39 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 04/13] mm/munlock: rmap call mlock_vma_page()
 munlock_vma_page()
In-Reply-To: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
Message-ID: <501673c-a5a-6c5f-ab65-38545dfb723d@google.com>
References: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vma argument to mlock_vma_page() and munlock_vma_page(), make them
inline functions which check (vma->vm_flags & VM_LOCKED) before calling
mlock_page() and munlock_page() in mm/mlock.c.

Add bool compound to mlock_vma_page() and munlock_vma_page(): this is
because we have understandable difficulty in accounting pte maps of THPs,
and if passed a PageHead page, mlock_page() and munlock_page() cannot
tell whether it's a pmd map to be counted or a pte map to be ignored.

Add vma arg to page_add_file_rmap() and page_remove_rmap(), like the
others, and use that to call mlock_vma_page() at the end of the page
adds, and munlock_vma_page() at the end of page_remove_rmap() (end or
beginning? unimportant, but end was easier for assertions in testing).

No page lock is required (although almost all adds happen to hold it):
delete the "Serialize with page migration" BUG_ON(!PageLocked(page))s.
Certainly page lock did serialize with page migration, but I'm having
difficulty explaining why that was ever important.

Mlock accounting on THPs has been hard to define, differed between anon
and file, involved PageDoubleMap in some places and not others, required
clear_page_mlock() at some points.  Keep it simple now: just count the
pmds and ignore the ptes, there is no reason for ptes to undo pmd mlocks.

page_add_new_anon_rmap() callers unchanged: they have long been calling
lru_cache_add_inactive_or_unevictable(), which does its own VM_LOCKED
handling (it also checks for not VM_SPECIAL: I think that's overcautious,
and inconsistent with other checks, that mmap_region() already prevents
VM_LOCKED on VM_SPECIAL; but haven't quite convinced myself to change it).

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
v2: Fix kerneldoc on mlock_page() to use colon, per Yang Li.
    mmotm will require minor fixup in mm/huge_memory.c like v1.

 include/linux/rmap.h    | 17 +++++++------
 kernel/events/uprobes.c |  7 ++----
 mm/huge_memory.c        | 17 ++++++-------
 mm/hugetlb.c            |  4 +--
 mm/internal.h           | 36 ++++++++++++++++++++++----
 mm/khugepaged.c         |  4 +--
 mm/ksm.c                | 12 +--------
 mm/memory.c             | 45 +++++++++++----------------------
 mm/migrate.c            |  9 ++-----
 mm/mlock.c              | 21 ++++++----------
 mm/rmap.c               | 56 +++++++++++++++++++----------------------
 mm/userfaultfd.c        | 14 ++++++-----
 12 files changed, 113 insertions(+), 129 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index dc48aa8c2c94..ac29b076082b 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -167,18 +167,19 @@ struct anon_vma *page_get_anon_vma(struct page *page);
  */
 void page_move_anon_rmap(struct page *, struct vm_area_struct *);
 void page_add_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long, bool);
+		unsigned long address, bool compound);
 void do_page_add_anon_rmap(struct page *, struct vm_area_struct *,
-			   unsigned long, int);
+		unsigned long address, int flags);
 void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
-		unsigned long, bool);
-void page_add_file_rmap(struct page *, bool);
-void page_remove_rmap(struct page *, bool);
-
+		unsigned long address, bool compound);
+void page_add_file_rmap(struct page *, struct vm_area_struct *,
+		bool compound);
+void page_remove_rmap(struct page *, struct vm_area_struct *,
+		bool compound);
 void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
-			    unsigned long);
+		unsigned long address);
 void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
-				unsigned long);
+		unsigned long address);
 
 static inline void page_dup_rmap(struct page *page, bool compound)
 {
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6357c3580d07..eed2f7437d96 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -173,7 +173,7 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 			return err;
 	}
 
-	/* For try_to_free_swap() and munlock_vma_page() below */
+	/* For try_to_free_swap() below */
 	lock_page(old_page);
 
 	mmu_notifier_invalidate_range_start(&range);
@@ -201,13 +201,10 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 		set_pte_at_notify(mm, addr, pvmw.pte,
 				  mk_pte(new_page, vma->vm_page_prot));
 
-	page_remove_rmap(old_page, false);
+	page_remove_rmap(old_page, vma, false);
 	if (!page_mapped(old_page))
 		try_to_free_swap(old_page);
 	page_vma_mapped_walk_done(&pvmw);
-
-	if ((vma->vm_flags & VM_LOCKED) && !PageCompound(old_page))
-		munlock_vma_page(old_page);
 	put_page(old_page);
 
 	err = 0;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9a34b85ebcf8..d6477f48a27e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1577,7 +1577,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 
 		if (pmd_present(orig_pmd)) {
 			page = pmd_page(orig_pmd);
-			page_remove_rmap(page, true);
+			page_remove_rmap(page, vma, true);
 			VM_BUG_ON_PAGE(page_mapcount(page) < 0, page);
 			VM_BUG_ON_PAGE(!PageHead(page), page);
 		} else if (thp_migration_supported()) {
@@ -1962,7 +1962,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				set_page_dirty(page);
 			if (!PageReferenced(page) && pmd_young(old_pmd))
 				SetPageReferenced(page);
-			page_remove_rmap(page, true);
+			page_remove_rmap(page, vma, true);
 			put_page(page);
 		}
 		add_mm_counter(mm, mm_counter_file(page), -HPAGE_PMD_NR);
@@ -2096,6 +2096,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			}
 		}
 		unlock_page_memcg(page);
+
+		/* Above is effectively page_remove_rmap(page, vma, true) */
+		munlock_vma_page(page, vma, true);
 	}
 
 	smp_wmb(); /* make pte visible before pmd */
@@ -2103,7 +2106,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 
 	if (freeze) {
 		for (i = 0; i < HPAGE_PMD_NR; i++) {
-			page_remove_rmap(page + i, false);
+			page_remove_rmap(page + i, vma, false);
 			put_page(page + i);
 		}
 	}
@@ -2163,8 +2166,6 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 				do_unlock_page = true;
 			}
 		}
-		if (PageMlocked(page))
-			clear_page_mlock(page);
 	} else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
 		goto out;
 	__split_huge_pmd_locked(vma, pmd, range.start, freeze);
@@ -3138,7 +3139,7 @@ void set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	if (pmd_soft_dirty(pmdval))
 		pmdswp = pmd_swp_mksoft_dirty(pmdswp);
 	set_pmd_at(mm, address, pvmw->pmd, pmdswp);
-	page_remove_rmap(page, true);
+	page_remove_rmap(page, vma, true);
 	put_page(page);
 }
 
@@ -3168,10 +3169,8 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	if (PageAnon(new))
 		page_add_anon_rmap(new, vma, mmun_start, true);
 	else
-		page_add_file_rmap(new, true);
+		page_add_file_rmap(new, vma, true);
 	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
-	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
-		mlock_vma_page(new);
 	update_mmu_cache_pmd(vma, address, pvmw->pmd);
 }
 #endif
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 61895cc01d09..43fb3155298e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5014,7 +5014,7 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 			set_page_dirty(page);
 
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
-		page_remove_rmap(page, true);
+		page_remove_rmap(page, vma, true);
 
 		spin_unlock(ptl);
 		tlb_remove_page_size(tlb, page, huge_page_size(h));
@@ -5259,7 +5259,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Break COW */
 		huge_ptep_clear_flush(vma, haddr, ptep);
 		mmu_notifier_invalidate_range(mm, range.start, range.end);
-		page_remove_rmap(old_page, true);
+		page_remove_rmap(old_page, vma, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
 		set_huge_pte_at(mm, haddr, ptep,
 				make_huge_pte(vma, new_page, 1));
diff --git a/mm/internal.h b/mm/internal.h
index f235aa92e564..3d7dfc8bc471 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -395,12 +395,35 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
 				   bool write, int *locked);
 extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
 			      unsigned long len);
-
 /*
- * must be called with vma's mmap_lock held for read or write, and page locked.
+ * mlock_vma_page() and munlock_vma_page():
+ * should be called with vma's mmap_lock held for read or write,
+ * under page table lock for the pte/pmd being added or removed.
+ *
+ * mlock is usually called at the end of page_add_*_rmap(),
+ * munlock at the end of page_remove_rmap(); but new anon
+ * pages are managed in lru_cache_add_inactive_or_unevictable().
+ *
+ * @compound is used to include pmd mappings of THPs, but filter out
+ * pte mappings of THPs, which cannot be consistently counted: a pte
+ * mapping of the THP head cannot be distinguished by the page alone.
  */
-extern void mlock_vma_page(struct page *page);
-extern void munlock_vma_page(struct page *page);
+void mlock_page(struct page *page);
+static inline void mlock_vma_page(struct page *page,
+			struct vm_area_struct *vma, bool compound)
+{
+	if (unlikely(vma->vm_flags & VM_LOCKED) &&
+	    (compound || !PageTransCompound(page)))
+		mlock_page(page);
+}
+void munlock_page(struct page *page);
+static inline void munlock_vma_page(struct page *page,
+			struct vm_area_struct *vma, bool compound)
+{
+	if (unlikely(vma->vm_flags & VM_LOCKED) &&
+	    (compound || !PageTransCompound(page)))
+		munlock_page(page);
+}
 
 /*
  * Clear the page's PageMlocked().  This can be useful in a situation where
@@ -487,7 +510,10 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 #else /* !CONFIG_MMU */
 static inline void unmap_mapping_folio(struct folio *folio) { }
 static inline void clear_page_mlock(struct page *page) { }
-static inline void mlock_vma_page(struct page *page) { }
+static inline void mlock_vma_page(struct page *page,
+			struct vm_area_struct *vma, bool compound) { }
+static inline void munlock_vma_page(struct page *page,
+			struct vm_area_struct *vma, bool compound) { }
 static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
 {
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 35f14d0a00a6..d5e387c58bde 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -773,7 +773,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
 			 */
 			spin_lock(ptl);
 			ptep_clear(vma->vm_mm, address, _pte);
-			page_remove_rmap(src_page, false);
+			page_remove_rmap(src_page, vma, false);
 			spin_unlock(ptl);
 			free_page_and_swap_cache(src_page);
 		}
@@ -1497,7 +1497,7 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 		if (pte_none(*pte))
 			continue;
 		page = vm_normal_page(vma, addr, *pte);
-		page_remove_rmap(page, false);
+		page_remove_rmap(page, vma, false);
 	}
 
 	pte_unmap_unlock(start_pte, ptl);
diff --git a/mm/ksm.c b/mm/ksm.c
index c20bd4d9a0d9..c5a4403b5dc9 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1177,7 +1177,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 	ptep_clear_flush(vma, addr, ptep);
 	set_pte_at_notify(mm, addr, ptep, newpte);
 
-	page_remove_rmap(page, false);
+	page_remove_rmap(page, vma, false);
 	if (!page_mapped(page))
 		try_to_free_swap(page);
 	put_page(page);
@@ -1252,16 +1252,6 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 			err = replace_page(vma, page, kpage, orig_pte);
 	}
 
-	if ((vma->vm_flags & VM_LOCKED) && kpage && !err) {
-		munlock_vma_page(page);
-		if (!PageMlocked(kpage)) {
-			unlock_page(page);
-			lock_page(kpage);
-			mlock_vma_page(kpage);
-			page = kpage;		/* for final unlock */
-		}
-	}
-
 out_unlock:
 	unlock_page(page);
 out:
diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..53bd9e5f2e33 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -735,9 +735,6 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 
 	set_pte_at(vma->vm_mm, address, ptep, pte);
 
-	if (vma->vm_flags & VM_LOCKED)
-		mlock_vma_page(page);
-
 	/*
 	 * No need to invalidate - it was non-present before. However
 	 * secondary CPUs may have mappings that need invalidating.
@@ -1377,7 +1374,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 					mark_page_accessed(page);
 			}
 			rss[mm_counter(page)]--;
-			page_remove_rmap(page, false);
+			page_remove_rmap(page, vma, false);
 			if (unlikely(page_mapcount(page) < 0))
 				print_bad_pte(vma, addr, ptent, page);
 			if (unlikely(__tlb_remove_page(tlb, page))) {
@@ -1397,10 +1394,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				continue;
 			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
 			rss[mm_counter(page)]--;
-
 			if (is_device_private_entry(entry))
-				page_remove_rmap(page, false);
-
+				page_remove_rmap(page, vma, false);
 			put_page(page);
 			continue;
 		}
@@ -1753,16 +1748,16 @@ static int validate_page_before_insert(struct page *page)
 	return 0;
 }
 
-static int insert_page_into_pte_locked(struct mm_struct *mm, pte_t *pte,
+static int insert_page_into_pte_locked(struct vm_area_struct *vma, pte_t *pte,
 			unsigned long addr, struct page *page, pgprot_t prot)
 {
 	if (!pte_none(*pte))
 		return -EBUSY;
 	/* Ok, finally just insert the thing.. */
 	get_page(page);
-	inc_mm_counter_fast(mm, mm_counter_file(page));
-	page_add_file_rmap(page, false);
-	set_pte_at(mm, addr, pte, mk_pte(page, prot));
+	inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
+	page_add_file_rmap(page, vma, false);
+	set_pte_at(vma->vm_mm, addr, pte, mk_pte(page, prot));
 	return 0;
 }
 
@@ -1776,7 +1771,6 @@ static int insert_page_into_pte_locked(struct mm_struct *mm, pte_t *pte,
 static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 			struct page *page, pgprot_t prot)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	int retval;
 	pte_t *pte;
 	spinlock_t *ptl;
@@ -1785,17 +1779,17 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
 	if (retval)
 		goto out;
 	retval = -ENOMEM;
-	pte = get_locked_pte(mm, addr, &ptl);
+	pte = get_locked_pte(vma->vm_mm, addr, &ptl);
 	if (!pte)
 		goto out;
-	retval = insert_page_into_pte_locked(mm, pte, addr, page, prot);
+	retval = insert_page_into_pte_locked(vma, pte, addr, page, prot);
 	pte_unmap_unlock(pte, ptl);
 out:
 	return retval;
 }
 
 #ifdef pte_index
-static int insert_page_in_batch_locked(struct mm_struct *mm, pte_t *pte,
+static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
 			unsigned long addr, struct page *page, pgprot_t prot)
 {
 	int err;
@@ -1805,7 +1799,7 @@ static int insert_page_in_batch_locked(struct mm_struct *mm, pte_t *pte,
 	err = validate_page_before_insert(page);
 	if (err)
 		return err;
-	return insert_page_into_pte_locked(mm, pte, addr, page, prot);
+	return insert_page_into_pte_locked(vma, pte, addr, page, prot);
 }
 
 /* insert_pages() amortizes the cost of spinlock operations
@@ -1842,7 +1836,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 
 		start_pte = pte_offset_map_lock(mm, pmd, addr, &pte_lock);
 		for (pte = start_pte; pte_idx < batch_size; ++pte, ++pte_idx) {
-			int err = insert_page_in_batch_locked(mm, pte,
+			int err = insert_page_in_batch_locked(vma, pte,
 				addr, pages[curr_page_idx], prot);
 			if (unlikely(err)) {
 				pte_unmap_unlock(start_pte, pte_lock);
@@ -3098,7 +3092,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			 * mapcount is visible. So transitively, TLBs to
 			 * old page will be flushed before it can be reused.
 			 */
-			page_remove_rmap(old_page, false);
+			page_remove_rmap(old_page, vma, false);
 		}
 
 		/* Free the old page.. */
@@ -3118,16 +3112,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	 */
 	mmu_notifier_invalidate_range_only_end(&range);
 	if (old_page) {
-		/*
-		 * Don't let another task, with possibly unlocked vma,
-		 * keep the mlocked page.
-		 */
-		if (page_copied && (vma->vm_flags & VM_LOCKED)) {
-			lock_page(old_page);	/* LRU manipulation */
-			if (PageMlocked(old_page))
-				munlock_vma_page(old_page);
-			unlock_page(old_page);
-		}
 		if (page_copied)
 			free_swap_cache(old_page);
 		put_page(old_page);
@@ -3947,7 +3931,8 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
 
 	add_mm_counter(vma->vm_mm, mm_counter_file(page), HPAGE_PMD_NR);
-	page_add_file_rmap(page, true);
+	page_add_file_rmap(page, vma, true);
+
 	/*
 	 * deposit and withdraw with pmd lock held
 	 */
@@ -3996,7 +3981,7 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	} else {
 		inc_mm_counter_fast(vma->vm_mm, mm_counter_file(page));
-		page_add_file_rmap(page, false);
+		page_add_file_rmap(page, vma, false);
 	}
 	set_pte_at(vma->vm_mm, addr, vmf->pte, entry);
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index c7da064b4781..7c4223ce2500 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -248,14 +248,9 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 			if (PageAnon(new))
 				page_add_anon_rmap(new, vma, pvmw.address, false);
 			else
-				page_add_file_rmap(new, false);
+				page_add_file_rmap(new, vma, false);
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		}
-		if (vma->vm_flags & VM_LOCKED && !PageTransCompound(new))
-			mlock_vma_page(new);
-
-		if (PageTransHuge(page) && PageMlocked(page))
-			clear_page_mlock(page);
 
 		/* No need to invalidate - it was non-present before */
 		update_mmu_cache(vma, pvmw.address, pvmw.pte);
@@ -2331,7 +2326,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			 * drop page refcount. Page won't be freed, as we took
 			 * a reference just above.
 			 */
-			page_remove_rmap(page, false);
+			page_remove_rmap(page, vma, false);
 			put_page(page);
 
 			if (pte_present(pte))
diff --git a/mm/mlock.c b/mm/mlock.c
index 5d7ced8303be..92f28258b4ae 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -78,17 +78,13 @@ void clear_page_mlock(struct page *page)
 	}
 }
 
-/*
- * Mark page as mlocked if not already.
- * If page on LRU, isolate and putback to move to unevictable list.
+/**
+ * mlock_page - mlock a page
+ * @page: page to be mlocked, either a normal page or a THP head.
  */
-void mlock_vma_page(struct page *page)
+void mlock_page(struct page *page)
 {
-	/* Serialize with page migration */
-	BUG_ON(!PageLocked(page));
-
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	VM_BUG_ON_PAGE(PageCompound(page) && PageDoubleMap(page), page);
 
 	if (!TestSetPageMlocked(page)) {
 		int nr_pages = thp_nr_pages(page);
@@ -101,14 +97,11 @@ void mlock_vma_page(struct page *page)
 }
 
 /**
- * munlock_vma_page - munlock a vma page
- * @page: page to be unlocked, either a normal page or THP page head
+ * munlock_page - munlock a page
+ * @page: page to be munlocked, either a normal page or a THP head.
  */
-void munlock_vma_page(struct page *page)
+void munlock_page(struct page *page)
 {
-	/* Serialize with page migration */
-	BUG_ON(!PageLocked(page));
-
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
 	if (TestClearPageMlocked(page)) {
diff --git a/mm/rmap.c b/mm/rmap.c
index 7ce7f1946cff..6cc8bf129f18 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1181,17 +1181,17 @@ void do_page_add_anon_rmap(struct page *page,
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 	}
 
-	if (unlikely(PageKsm(page))) {
+	if (unlikely(PageKsm(page)))
 		unlock_page_memcg(page);
-		return;
-	}
 
 	/* address might be in next vma when migration races vma_adjust */
-	if (first)
+	else if (first)
 		__page_set_anon_rmap(page, vma, address,
 				flags & RMAP_EXCLUSIVE);
 	else
 		__page_check_anon_rmap(page, vma, address);
+
+	mlock_vma_page(page, vma, compound);
 }
 
 /**
@@ -1232,12 +1232,14 @@ void page_add_new_anon_rmap(struct page *page,
 
 /**
  * page_add_file_rmap - add pte mapping to a file page
- * @page: the page to add the mapping to
- * @compound: charge the page as compound or small page
+ * @page:	the page to add the mapping to
+ * @vma:	the vm area in which the mapping is added
+ * @compound:	charge the page as compound or small page
  *
  * The caller needs to hold the pte lock.
  */
-void page_add_file_rmap(struct page *page, bool compound)
+void page_add_file_rmap(struct page *page,
+	struct vm_area_struct *vma, bool compound)
 {
 	int i, nr = 1;
 
@@ -1260,13 +1262,8 @@ void page_add_file_rmap(struct page *page, bool compound)
 						nr_pages);
 	} else {
 		if (PageTransCompound(page) && page_mapping(page)) {
-			struct page *head = compound_head(page);
-
 			VM_WARN_ON_ONCE(!PageLocked(page));
-
-			SetPageDoubleMap(head);
-			if (PageMlocked(page))
-				clear_page_mlock(head);
+			SetPageDoubleMap(compound_head(page));
 		}
 		if (!atomic_inc_and_test(&page->_mapcount))
 			goto out;
@@ -1274,6 +1271,8 @@ void page_add_file_rmap(struct page *page, bool compound)
 	__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
 out:
 	unlock_page_memcg(page);
+
+	mlock_vma_page(page, vma, compound);
 }
 
 static void page_remove_file_rmap(struct page *page, bool compound)
@@ -1368,11 +1367,13 @@ static void page_remove_anon_compound_rmap(struct page *page)
 /**
  * page_remove_rmap - take down pte mapping from a page
  * @page:	page to remove mapping from
+ * @vma:	the vm area from which the mapping is removed
  * @compound:	uncharge the page as compound or small page
  *
  * The caller needs to hold the pte lock.
  */
-void page_remove_rmap(struct page *page, bool compound)
+void page_remove_rmap(struct page *page,
+	struct vm_area_struct *vma, bool compound)
 {
 	lock_page_memcg(page);
 
@@ -1414,6 +1415,8 @@ void page_remove_rmap(struct page *page, bool compound)
 	 */
 out:
 	unlock_page_memcg(page);
+
+	munlock_vma_page(page, vma, compound);
 }
 
 /*
@@ -1469,28 +1472,21 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
+		/* Unexpected PMD-mapped THP? */
+		VM_BUG_ON_PAGE(!pvmw.pte, page);
+
 		/*
-		 * If the page is mlock()d, we cannot swap it out.
+		 * If the page is in an mlock()d vma, we must not swap it out.
 		 */
 		if (!(flags & TTU_IGNORE_MLOCK) &&
 		    (vma->vm_flags & VM_LOCKED)) {
-			/*
-			 * PTE-mapped THP are never marked as mlocked: so do
-			 * not set it on a DoubleMap THP, nor on an Anon THP
-			 * (which may still be PTE-mapped after DoubleMap was
-			 * cleared).  But stop unmapping even in those cases.
-			 */
-			if (!PageTransCompound(page) || (PageHead(page) &&
-			     !PageDoubleMap(page) && !PageAnon(page)))
-				mlock_vma_page(page);
+			/* Restore the mlock which got missed */
+			mlock_vma_page(page, vma, false);
 			page_vma_mapped_walk_done(&pvmw);
 			ret = false;
 			break;
 		}
 
-		/* Unexpected PMD-mapped THP? */
-		VM_BUG_ON_PAGE(!pvmw.pte, page);
-
 		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
 		address = pvmw.address;
 
@@ -1668,7 +1664,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/vm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, PageHuge(page));
+		page_remove_rmap(subpage, vma, PageHuge(page));
 		put_page(page);
 	}
 
@@ -1942,7 +1938,7 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 		 *
 		 * See Documentation/vm/mmu_notifier.rst
 		 */
-		page_remove_rmap(subpage, PageHuge(page));
+		page_remove_rmap(subpage, vma, PageHuge(page));
 		put_page(page);
 	}
 
@@ -2078,7 +2074,7 @@ static bool page_make_device_exclusive_one(struct page *page,
 		 * There is a reference on the page for the swap entry which has
 		 * been removed, so shouldn't take another.
 		 */
-		page_remove_rmap(subpage, false);
+		page_remove_rmap(subpage, vma, false);
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 0780c2a57ff1..15d3e97a6e04 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -95,10 +95,15 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	if (!pte_none(*dst_pte))
 		goto out_unlock;
 
-	if (page_in_cache)
-		page_add_file_rmap(page, false);
-	else
+	if (page_in_cache) {
+		/* Usually, cache pages are already added to LRU */
+		if (newly_allocated)
+			lru_cache_add(page);
+		page_add_file_rmap(page, dst_vma, false);
+	} else {
 		page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
+		lru_cache_add_inactive_or_unevictable(page, dst_vma);
+	}
 
 	/*
 	 * Must happen after rmap, as mm_counter() checks mapping (via
@@ -106,9 +111,6 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
 	 */
 	inc_mm_counter(dst_mm, mm_counter(page));
 
-	if (newly_allocated)
-		lru_cache_add_inactive_or_unevictable(page, dst_vma);
-
 	set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
 
 	/* No need to invalidate - it was non-present before */
-- 
2.34.1

