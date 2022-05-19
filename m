Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1774B52DCD5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243958AbiESSbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243999AbiESSav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:30:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9EE26E6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so5985275pjq.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3AnSMal5kZBx9xm4mSXNs4WPl8F37Q3+gJ0liTuUGj8=;
        b=DqyOtcWpw4/3gxmaDqPLZ8Nw2zNdRfmi5MkPTr3BdkmaJjnEHaRPCqeIAFBBKuNKBE
         h2dju+OhAqrp2X6l0mMHrxj4mzqMZ0eWPKEKD9b+L7/GThKosMVuqNcyOWKS60R34KM1
         hediFHBh1JTxzqa2Z5ehPZ3hBA4/tfyYLAgxGUedkLNypGn0dr8L4a1wo2CbSzmxdUSa
         WOkF+6I7F0pHpnkPTMT10UEnmIklsh4mHE7d6NqYABpgJANOoIawN/sUwhG6ym72WJOQ
         LsOA2DmFBfEbg4X5vCFpwNcKunJBCswMsmuOG1np8WTFAzdILVpbSh7SfBZqblYG2r5q
         BN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3AnSMal5kZBx9xm4mSXNs4WPl8F37Q3+gJ0liTuUGj8=;
        b=lFEwxd3m6Pg+ILzK/0ptxHFV30yYJk7mxnc7kAdCSctdkz+b9XisYrbzyyz6MgBbM1
         GnZyhwT/lk/y0QtIR1/PqKEGCjBJ70PFZjJ2Js2YQRnSi6F0ytq66pBp66bfTxwtNYMY
         knaoHGxGKIW2kNW1KSVic9rCs4j+qoGxvASFS8AWg4uU2vw2TiLtLDLQlu4UqFaay8Dk
         yYC1Yto0/dyt1cennTUB7sEt5xex2DSJWOWmgeg++syubLGCOM5CEYcAb7d2R4ZpF1Xv
         wG9KBOqdJwFI31X46rUMaUBeUkgCQ56OwBk68vXXwSWPW2r3Yw0oSVTDgLcjQn0olOPU
         RxYg==
X-Gm-Message-State: AOAM532unj/RJgnwBksS3sXJ+PLP20es9TwiU4p3UplZTR7E6wSc1RK2
        1E5JSW9dWPSdS4g79aOT1Hg=
X-Google-Smtp-Source: ABdhPJyMRyDLR4APr3oRJmf7ZTPIAO7XQa8q/I4hne4Qf279PozzpMkdV7r2ne7m+D/j/icwgzsbJA==
X-Received: by 2002:a17:90b:4c07:b0:1df:755e:e0df with SMTP id na7-20020a17090b4c0700b001df755ee0dfmr6456309pjb.244.1652985042428;
        Thu, 19 May 2022 11:30:42 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id z5-20020a63e105000000b003c14af505f6sm3884674pgh.14.2022.05.19.11.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:30:42 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Chih-En Lin <shiyn.lin@gmail.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: [RFC PATCH 6/6] mm: Expand Copy-On-Write to PTE table
Date:   Fri, 20 May 2022 02:31:27 +0800
Message-Id: <20220519183127.3909598-7-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519183127.3909598-1-shiyn.lin@gmail.com>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
MIME-Version: 1.0
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

This patch adds the Copy-On-Write (COW) mechanism to the PTE table.
To enable the COW page table use the clone3() system call with the
CLONE_COW_PGTABLE flag. It will set the MMF_COW_PGTABLE flag to the
processes.

It uses the MMF_COW_PGTABLE flag to distinguish the default page table
and the COW one. Moreover, it is difficult to distinguish whether the
entire page table is out of COW state. So the MMF_COW_PGTABLE flag won't
be disabled after its setup.

Since the memory space of the page table is distinctive for each process
in kernel space. It uses the address of the PMD index for the ownership
of the PTE table to identify which one of the processes needs to update
the page table state. In other words, only the owner will update COW PTE
state, like the RSS and pgtable_bytes.

It uses the reference count to control the lifetime of COW PTE table.
When someone breaks COW, it will copy the COW PTE table and decrease the
reference count. But if the reference count is equal to one before the
break COW, it will reuse the COW PTE table.

This patch modifies the part of the copy page table to do the basic COW.
For the break COW, it modifies the part of a page fault, zaps page table
, unmapping, and remapping.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/pgtable.h |   3 +
 mm/memory.c             | 262 ++++++++++++++++++++++++++++++++++++----
 mm/mmap.c               |   4 +
 mm/mremap.c             |   5 +
 4 files changed, 251 insertions(+), 23 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 33c01fec7b92..357ce3722ee8 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -631,6 +631,9 @@ static inline int cow_pte_refcount_read(pmd_t *pmd)
 	return atomic_read(&pmd_page(*pmd)->cow_pgtable_refcount);
 }
 
+extern int handle_cow_pte(struct vm_area_struct *vma, pmd_t *pmd,
+		unsigned long addr, bool alloc);
+
 #ifndef pte_access_permitted
 #define pte_access_permitted(pte, write) \
 	(pte_present(pte) && (!(write) || pte_write(pte)))
diff --git a/mm/memory.c b/mm/memory.c
index aa66af76e214..ff3fcbe4dfb5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -247,6 +247,8 @@ static inline void free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
+		BUG_ON(cow_pte_refcount_read(pmd) != 1);
+		BUG_ON(!cow_pte_owner_is_same(pmd, NULL));
 		free_pte_range(tlb, pmd, addr);
 	} while (pmd++, addr = next, addr != end);
 
@@ -1031,7 +1033,7 @@ static inline void cow_pte_rss(struct mm_struct *mm, struct vm_area_struct *vma,
 static int
 copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	       pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
-	       unsigned long end)
+	       unsigned long end, bool is_src_pte_locked)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
 	struct mm_struct *src_mm = src_vma->vm_mm;
@@ -1053,8 +1055,10 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		goto out;
 	}
 	src_pte = pte_offset_map(src_pmd, addr);
-	src_ptl = pte_lockptr(src_mm, src_pmd);
-	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
+	if (!is_src_pte_locked) {
+		src_ptl = pte_lockptr(src_mm, src_pmd);
+		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
+	}
 	orig_src_pte = src_pte;
 	orig_dst_pte = dst_pte;
 	arch_enter_lazy_mmu_mode();
@@ -1067,7 +1071,8 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 		if (progress >= 32) {
 			progress = 0;
 			if (need_resched() ||
-			    spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
+			    (!is_src_pte_locked && spin_needbreak(src_ptl)) ||
+			    spin_needbreak(dst_ptl))
 				break;
 		}
 		if (pte_none(*src_pte)) {
@@ -1118,7 +1123,8 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
 
 	arch_leave_lazy_mmu_mode();
-	spin_unlock(src_ptl);
+	if (!is_src_pte_locked)
+		spin_unlock(src_ptl);
 	pte_unmap(orig_src_pte);
 	add_mm_rss_vec(dst_mm, rss);
 	pte_unmap_unlock(orig_dst_pte, dst_ptl);
@@ -1180,11 +1186,55 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 				continue;
 			/* fall through */
 		}
-		if (pmd_none_or_clear_bad(src_pmd))
-			continue;
-		if (copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd,
-				   addr, next))
+
+		if (test_bit(MMF_COW_PGTABLE, &src_mm->flags)) {
+
+			 if (pmd_none(*src_pmd))
+				continue;
+
+			/* XXX: Skip if the PTE already COW this time. */
+			if (!pmd_none(*dst_pmd) &&
+			    cow_pte_refcount_read(src_pmd) > 1)
+				continue;
+
+			/* If PTE doesn't have an owner, the parent needs to
+			 * take this PTE.
+			 */
+			if (cow_pte_owner_is_same(src_pmd, NULL)) {
+				set_cow_pte_owner(src_pmd, src_pmd);
+				/* XXX: The process may COW PTE fork two times.
+				 * But in some situations, owner has cleared.
+				 * Previously Child (This time is the parent)
+				 * COW PTE forking, but previously parent, owner
+				 * , break COW. So it needs to add back the RSS
+				 * state and pgtable bytes.
+				 */
+				if (!pmd_write(*src_pmd)) {
+					unsigned long pte_start =
+						addr & PMD_MASK;
+					unsigned long pte_end =
+						(addr + PMD_SIZE) & PMD_MASK;
+					cow_pte_rss(src_mm, src_vma, src_pmd,
+					    pte_start, pte_end, true /* inc */);
+					mm_inc_nr_ptes(src_mm);
+					smp_wmb();
+					pmd_populate(src_mm, src_pmd,
+							pmd_page(*src_pmd));
+				}
+			}
+
+			pmdp_set_wrprotect(src_mm, addr, src_pmd);
+
+			/* Child reference count */
+			pmd_get_pte(src_pmd);
+
+			/* COW for PTE table */
+			set_pmd_at(dst_mm, addr, dst_pmd, *src_pmd);
+		} else if (!pmd_none_or_clear_bad(src_pmd) &&
+			    copy_pte_range(dst_vma, src_vma, dst_pmd, src_pmd,
+				    addr, next, false)) {
 			return -ENOMEM;
+		}
 	} while (dst_pmd++, src_pmd++, addr = next, addr != end);
 	return 0;
 }
@@ -1336,6 +1386,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 struct zap_details {
 	struct folio *single_folio;	/* Locked folio to be unmapped */
 	bool even_cows;			/* Zap COWed private pages too? */
+	bool cow_pte;			/* Do not free COW PTE */
 };
 
 /* Whether we should zap all COWed (private) pages too */
@@ -1398,8 +1449,9 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			page = vm_normal_page(vma, addr, ptent);
 			if (unlikely(!should_zap_page(details, page)))
 				continue;
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
+			if (!details || !details->cow_pte)
+				ptent = ptep_get_and_clear_full(mm, addr, pte,
+								tlb->fullmm);
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			if (unlikely(!page))
 				continue;
@@ -1413,8 +1465,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				    likely(!(vma->vm_flags & VM_SEQ_READ)))
 					mark_page_accessed(page);
 			}
-			rss[mm_counter(page)]--;
-			page_remove_rmap(page, vma, false);
+			if (!details || !details->cow_pte) {
+				rss[mm_counter(page)]--;
+				page_remove_rmap(page, vma, false);
+			} else
+				continue;
 			if (unlikely(page_mapcount(page) < 0))
 				print_bad_pte(vma, addr, ptent, page);
 			if (unlikely(__tlb_remove_page(tlb, page))) {
@@ -1425,6 +1480,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			continue;
 		}
 
+		// TODO: Deal COW PTE with swap
+
 		entry = pte_to_swp_entry(ptent);
 		if (is_device_private_entry(entry) ||
 		    is_device_exclusive_entry(entry)) {
@@ -1513,16 +1570,34 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 			spin_unlock(ptl);
 		}
 
-		/*
-		 * Here there can be other concurrent MADV_DONTNEED or
-		 * trans huge page faults running, and if the pmd is
-		 * none or trans huge it can change under us. This is
-		 * because MADV_DONTNEED holds the mmap_lock in read
-		 * mode.
-		 */
-		if (pmd_none_or_trans_huge_or_clear_bad(pmd))
-			goto next;
-		next = zap_pte_range(tlb, vma, pmd, addr, next, details);
+
+		if (test_bit(MMF_COW_PGTABLE, &tlb->mm->flags) &&
+		    !pmd_none(*pmd) && !pmd_write(*pmd)) {
+			struct zap_details cow_pte_details = {0};
+			if (details)
+				cow_pte_details = *details;
+			cow_pte_details.cow_pte = true;
+			/* Flush the TLB but do not free the COW PTE */
+			next = zap_pte_range(tlb, vma, pmd, addr,
+						next, &cow_pte_details);
+			if (details)
+				*details = cow_pte_details;
+			handle_cow_pte(vma, pmd, addr, false);
+		} else {
+			if (details)
+				details->cow_pte = false;
+			/*
+			 * Here there can be other concurrent MADV_DONTNEED or
+			 * trans huge page faults running, and if the pmd is
+			 * none or trans huge it can change under us. This is
+			 * because MADV_DONTNEED holds the mmap_lock in read
+			 * mode.
+			 */
+			if (pmd_none_or_trans_huge_or_clear_bad(pmd))
+				goto next;
+			next = zap_pte_range(tlb, vma, pmd, addr, next,
+					details);
+		}
 next:
 		cond_resched();
 	} while (pmd++, addr = next, addr != end);
@@ -4621,6 +4696,134 @@ void cow_pte_fallback(struct vm_area_struct *vma, pmd_t *pmd,
 	BUG_ON(pmd_page(*pmd)->cow_pte_owner);
 }
 
+/* Break COW PTE:
+ * - two state here
+ *   - After fork :   [parent, rss=1, ref=2, write=NO , owner=parent]
+ *                 to [parent, rss=1, ref=1, write=YES, owner=NULL  ]
+ *                    COW PTE become [ref=1, write=NO , owner=NULL  ]
+ *                    [child , rss=0, ref=2, write=NO , owner=parent]
+ *                 to [child , rss=1, ref=1, write=YES, owner=NULL  ]
+ *                    COW PTE become [ref=1, write=NO , owner=parent]
+ *   NOTE
+ *     - Copy the COW PTE to new PTE.
+ *     - Clear the owner of COW PTE and set PMD entry writable when it is owner.
+ *     - Increase RSS if it is not owner.
+ */
+static int break_cow_pte(struct vm_area_struct *vma, pmd_t *pmd,
+		unsigned long addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long start, end;
+	pmd_t cowed_entry = *pmd;
+
+	if (cow_pte_refcount_read(&cowed_entry) == 1) {
+		cow_pte_fallback(vma, pmd, addr);
+		return 1;
+	}
+
+	BUG_ON(pmd_write(cowed_entry));
+
+	start = addr & PMD_MASK;
+	end = (addr + PMD_SIZE) & PMD_MASK;
+
+	pmd_clear(pmd);
+	if (copy_pte_range(vma, vma, pmd, &cowed_entry,
+				start, end, true))
+		return -ENOMEM;
+
+	/* Here, it is the owner, so clear the ownership. To keep RSS state and
+	 * page table bytes correct, it needs to decrease them.
+	 */
+	if (cow_pte_owner_is_same(&cowed_entry, pmd)) {
+		set_cow_pte_owner(&cowed_entry, NULL);
+		cow_pte_rss(mm, vma, pmd, start, end, false /* dec */);
+		mm_dec_nr_ptes(mm);
+	}
+
+	pmd_put_pte(vma, &cowed_entry, addr);
+
+	BUG_ON(!pmd_write(*pmd));
+	BUG_ON(cow_pte_refcount_read(pmd) != 1);
+
+	return 0;
+}
+
+static int zap_cow_pte(struct vm_area_struct *vma, pmd_t *pmd,
+		unsigned long addr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long start, end;
+
+	if (pmd_put_pte(vma, pmd, addr)) {
+		// fallback
+		return 1;
+	}
+
+	start = addr & PMD_MASK;
+	end = (addr + PMD_SIZE) & PMD_MASK;
+
+	/* If PMD entry is owner, clear the ownership, and decrease RSS state
+	 * and pgtable_bytes.
+	 */
+	if (cow_pte_owner_is_same(pmd, pmd)) {
+		set_cow_pte_owner(pmd, NULL);
+		cow_pte_rss(mm, vma, pmd, start, end, false /* dec */);
+		mm_dec_nr_ptes(mm);
+	}
+
+	pmd_clear(pmd);
+	return 0;
+}
+
+/* If alloc set means it won't break COW. For this case, it will just decrease
+ * the reference count. The address needs to be at the beginning of the PTE page
+ * since COW PTE is copy-on-write the entire PTE.
+ * If pmd is NULL, it will get the pmd from vma and check it is cowing.
+ */
+int handle_cow_pte(struct vm_area_struct *vma, pmd_t *pmd,
+		unsigned long addr, bool alloc)
+{
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	struct mm_struct *mm = vma->vm_mm;
+	int ret = 0;
+	spinlock_t *ptl = NULL;
+
+	if (!pmd) {
+		pgd = pgd_offset(mm, addr);
+		if (pgd_none_or_clear_bad(pgd))
+			return 0;
+		p4d = p4d_offset(pgd, addr);
+		if (p4d_none_or_clear_bad(p4d))
+			return 0;
+		pud = pud_offset(p4d, addr);
+		if (pud_none_or_clear_bad(pud))
+			return 0;
+		pmd = pmd_offset(pud, addr);
+		if (pmd_none(*pmd) || pmd_write(*pmd))
+			return 0;
+	}
+
+	// TODO: handle COW PTE with swap
+	BUG_ON(is_swap_pmd(*pmd));
+	BUG_ON(pmd_trans_huge(*pmd));
+	BUG_ON(pmd_devmap(*pmd));
+
+	BUG_ON(pmd_none(*pmd));
+	BUG_ON(pmd_write(*pmd));
+
+	ptl = pte_lockptr(mm, pmd);
+	spin_lock(ptl);
+	if (!alloc)
+		ret = zap_cow_pte(vma, pmd, addr);
+	else
+		ret = break_cow_pte(vma, pmd, addr);
+	spin_unlock(ptl);
+
+	return ret;
+}
+
 /*
  * These routines also need to handle stuff like marking pages dirty
  * and/or accessed for architectures that don't do it in hardware (most
@@ -4825,6 +5028,19 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 				return 0;
 			}
 		}
+
+		/* When the PMD entry is set with write protection, it needs to
+		 * handle the on-demand PTE. It will allocate a new PTE and copy
+		 * the old one, then set this entry writeable and decrease the
+		 * reference count at COW PTE.
+		 */
+		if (test_bit(MMF_COW_PGTABLE, &mm->flags) &&
+		    !pmd_none(vmf.orig_pmd) && !pmd_write(vmf.orig_pmd)) {
+			if (handle_cow_pte(vmf.vma, vmf.pmd, vmf.real_address,
+			   (cow_pte_refcount_read(&vmf.orig_pmd) > 1) ?
+			   true : false) < 0)
+				return VM_FAULT_OOM;
+		}
 	}
 
 	return handle_pte_fault(&vmf);
diff --git a/mm/mmap.c b/mm/mmap.c
index 313b57d55a63..e3a9c38e87e8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2709,6 +2709,10 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 			return err;
 	}
 
+	if (test_bit(MMF_COW_PGTABLE, &vma->vm_mm->flags) &&
+	    handle_cow_pte(vma, NULL, addr, true) < 0)
+		return -ENOMEM;
+
 	new = vm_area_dup(vma);
 	if (!new)
 		return -ENOMEM;
diff --git a/mm/mremap.c b/mm/mremap.c
index 303d3290b938..01aefdfc61b7 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -532,6 +532,11 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
 		if (!old_pmd)
 			continue;
+
+		if (test_bit(MMF_COW_PGTABLE, &vma->vm_mm->flags) &&
+		    !pmd_none(*old_pmd) && !pmd_write(*old_pmd))
+			handle_cow_pte(vma, old_pmd, old_addr, true);
+
 		new_pmd = alloc_new_pmd(vma->vm_mm, vma, new_addr);
 		if (!new_pmd)
 			break;
-- 
2.36.1

