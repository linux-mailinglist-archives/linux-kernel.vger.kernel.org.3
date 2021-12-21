Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F847C352
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbhLUPq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbhLUPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:46:55 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD422C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:46:54 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id f138so1477287qke.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RKJqaZULeG1QSA7YB831SR6HERaPIQOIwY733yUqU5M=;
        b=FKON5HAyn15g62AGhOlT1/tBz+VEw1J67ZHg3wwFLM8ZgF8fXf2LcxUQI365+XnEvp
         7WyWvfd+32btAKnG7C3/aIuB3xfZm55cFb5ugAQ8ST1/145P5LenlINlmo3DZmrzo8zb
         uIo242st9q8BikF5hgObrPFY+SIaDvInrNRImnfXXsqF6KH2Q00gueQ8N0Y+q3y7Fu91
         hRhDr+Gco87JRzd8fkqTAtbUrfUNbv7rPdS8FvOkYHKPnyd8jw3J6SFAmeVfo5OTXxwb
         w4wiwz8v1zVH4sD4khwU/oJlbp9yOeIjT5IipirRF9BJmr1K1xtPleoa1ZgMnGJH0JLT
         3BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKJqaZULeG1QSA7YB831SR6HERaPIQOIwY733yUqU5M=;
        b=YzA6haczAmT0a52uxAWGAfc8zTo36akUtEDriIRtey/6n46j/JY3ansAfLFZ2ae0xs
         yIumiveL70sqUaNvwdgjnShdDgIEJ/NjnihjXR4np49LVMa0uRnmgy07eO+uP+graGCK
         o0C7uXS3DKOS1M2RM7ZmlJHXmThiak/f3EYVIF9jQGN+Fgbgj+kjY1XK24kxZQJMeHKw
         uum7wCzLmarbV0+nOaP/Cr4UoUGHkUNTaRLNMUSvrhn4XZxekqc8lJ5d9vD882bDnn5S
         maS0FtNuPJzIgJ8gZZB9JQqOtUjMvAAOrc30TBNXGXqjbBj8jDVGiiA4YzvA7rb5WMji
         sNfA==
X-Gm-Message-State: AOAM530+yaWGbCiAsCc2jrAdlIQTmB4wDWVVlrVv6dBC/aVn9BNQDqHj
        GaBkF467U6N4NqgmUq8j4JAysQ==
X-Google-Smtp-Source: ABdhPJzcVYX4pffnC7B1BEW7SxoZDfhSLwDnPuVSyGmvG/Ya68GAB7xCw58hA1bjyg8lE09NC2cp3g==
X-Received: by 2002:a05:620a:4096:: with SMTP id f22mr2473224qko.600.1640101614024;
        Tue, 21 Dec 2021 07:46:54 -0800 (PST)
Received: from soleen.c.googlers.com.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id d20sm224588qtg.73.2021.12.21.07.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:46:53 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        akpm@linux-foundation.org, rientjes@google.com, pjt@google.com,
        weixugc@google.com, gthelen@google.com, mingo@redhat.com,
        corbet@lwn.net, will@kernel.org, rppt@kernel.org,
        keescook@chromium.org, tglx@linutronix.de, peterz@infradead.org,
        masahiroy@kernel.org, samitolvanen@google.com,
        dave.hansen@linux.intel.com, x86@kernel.org, frederic@kernel.org,
        hpa@zytor.com, aneesh.kumar@linux.ibm.com, jirislaby@kernel.org,
        songmuchun@bytedance.com, qydwhotmail@gmail.com, hughd@google.com
Subject: [PATCH v3 1/4] mm: change page type prior to adding page table entry
Date:   Tue, 21 Dec 2021 15:46:47 +0000
Message-Id: <20211221154650.1047963-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
In-Reply-To: <20211221154650.1047963-1-pasha.tatashin@soleen.com>
References: <20211221154650.1047963-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are  a few places where we first update the entry in the user page
table, and later change the struct page to indicate that this is
anonymous or file page.

In most places, however, we first configure the page metadata and then
insert entries into the page table. Page table check, will use
the information from struct page to verify the type of entry is
inserted.

Change the order in all places to first update struct page, and later to
update page table.

This means that we first do calls that may change the type of page (anon
or file):

	page_move_anon_rmap
	page_add_anon_rmap
	do_page_add_anon_rmap
	page_add_new_anon_rmap
	page_add_file_rmap
	hugepage_add_anon_rmap
	hugepage_add_new_anon_rmap

And after that do calls that add entries to the page table:

	set_huge_pte_at
	set_pte_at

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/hugetlb.c  | 6 +++---
 mm/memory.c   | 9 +++++----
 mm/migrate.c  | 5 ++---
 mm/swapfile.c | 4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a1baa198519a..61895cc01d09 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4684,8 +4684,8 @@ hugetlb_install_page(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr
 		     struct page *new_page)
 {
 	__SetPageUptodate(new_page);
-	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1));
 	hugepage_add_new_anon_rmap(new_page, vma, addr);
+	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, new_page, 1));
 	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
 	ClearHPageRestoreReserve(new_page);
 	SetHPageMigratable(new_page);
@@ -5259,10 +5259,10 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Break COW */
 		huge_ptep_clear_flush(vma, haddr, ptep);
 		mmu_notifier_invalidate_range(mm, range.start, range.end);
-		set_huge_pte_at(mm, haddr, ptep,
-				make_huge_pte(vma, new_page, 1));
 		page_remove_rmap(old_page, true);
 		hugepage_add_new_anon_rmap(new_page, vma, haddr);
+		set_huge_pte_at(mm, haddr, ptep,
+				make_huge_pte(vma, new_page, 1));
 		SetHPageMigratable(new_page);
 		/* Make the old page be freed below */
 		new_page = old_page;
diff --git a/mm/memory.c b/mm/memory.c
index 71e475d440b0..11cb28a2ca54 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -720,8 +720,6 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 	else if (is_writable_device_exclusive_entry(entry))
 		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 
-	set_pte_at(vma->vm_mm, address, ptep, pte);
-
 	/*
 	 * No need to take a page reference as one was already
 	 * created when the swap entry was made.
@@ -735,6 +733,8 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 		 */
 		WARN_ON_ONCE(!PageAnon(page));
 
+	set_pte_at(vma->vm_mm, address, ptep, pte);
+
 	if (vma->vm_flags & VM_LOCKED)
 		mlock_vma_page(page);
 
@@ -3635,8 +3635,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		pte = pte_mkuffd_wp(pte);
 		pte = pte_wrprotect(pte);
 	}
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
-	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
 	vmf->orig_pte = pte;
 
 	/* ksm created a completely new copy */
@@ -3647,6 +3645,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
 	}
 
+	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
+	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
+
 	swap_free(entry);
 	if (mem_cgroup_swap_full(page) ||
 	    (vma->vm_flags & VM_LOCKED) || PageMlocked(page))
diff --git a/mm/migrate.c b/mm/migrate.c
index c9296d63878d..f943a2d99de7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -237,20 +237,19 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 
 			pte = pte_mkhuge(pte);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
-			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 			if (PageAnon(new))
 				hugepage_add_anon_rmap(new, vma, pvmw.address);
 			else
 				page_dup_rmap(new, true);
+			set_huge_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		} else
 #endif
 		{
-			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
-
 			if (PageAnon(new))
 				page_add_anon_rmap(new, vma, pvmw.address, false);
 			else
 				page_add_file_rmap(new, false);
+			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		}
 		if (vma->vm_flags & VM_LOCKED && !PageTransCompound(new))
 			mlock_vma_page(new);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e59e08ef46e1..e64207e2ef1d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1917,14 +1917,14 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
 	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
 	get_page(page);
-	set_pte_at(vma->vm_mm, addr, pte,
-		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	if (page == swapcache) {
 		page_add_anon_rmap(page, vma, addr, false);
 	} else { /* ksm created a completely new copy */
 		page_add_new_anon_rmap(page, vma, addr, false);
 		lru_cache_add_inactive_or_unevictable(page, vma);
 	}
+	set_pte_at(vma->vm_mm, addr, pte,
+		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
 	swap_free(entry);
 out:
 	pte_unmap_unlock(pte, ptl);
-- 
2.34.1.307.g9b7440fafd-goog

