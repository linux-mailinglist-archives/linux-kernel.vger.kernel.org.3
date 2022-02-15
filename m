Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF44E4B60F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiBOCXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:23:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiBOCXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:23:43 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BE347AEA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:23:33 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 200so16145003qki.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=lmZloTsNmwsY69gJB9MeYd7MzRZCowvwjlU+iDSaqEA=;
        b=K3aXnemtoZ311il9mh1+OOYZMLA88Xz/c20SN+rqaNwZlEEpMWdVeIdcpzvuK7EgEJ
         fYYovR/x6y0SL7I+F67hhqXJU+7nGUwxYotn+2e85FPiGMIZaRMhTaWG2e6KMbi7unZz
         7+WeL0Fb9GCH7GTLtF6nEO3G+HrqJ1pwxWTOdz6QWKvrjUYBEG8OLQ37rOI0T97RoaoO
         nzGUGGJpnClr8ZMdtRmACLVAtzt8goTApSh48iNZIoAKNNXIgS0TgFXcr3gP17dRVup4
         gaahZlytPO0KtSTHCpGDzaBncJ/MmPu1udLZmfU5UuvFHLwJKCtd8ZB9Mv9PzHdI8Wzc
         jW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=lmZloTsNmwsY69gJB9MeYd7MzRZCowvwjlU+iDSaqEA=;
        b=jhzUxOHr2II91lkxhRF2c+tInb3c0Ju0tto7xqQ7EY2EQdMFBhzbkphtSdD9lAZk7i
         ubzWkFUtXpjaGQY3RIBnpylIjc6D+CbQzeuItHOccoCNsZ1LPLRO64FVQNmNZ6fVo0Qe
         bWSsfxyptdvtw5v8HlyK+x0BDravLKCamoxLJ5MsJ1gA+zZC4JdNqooPUI7kmiWE6Cmt
         podbZ9oWBSZLnVu0+9VZ5tiKBAaILyHEq81uizd9pKANMf1lO7EbKj1TwUz2tbsTvtPX
         CBH2JcNnBf2ItMQijVQgQDVvCk8WgWrEslh/oRglwxK0yi/TsbhO1Fog2DNltM7a2BxS
         tPgw==
X-Gm-Message-State: AOAM532iZywl02ZwUm01jkzqvVAdgBltDr3T/UdTBN8yzR9glX3eUkkM
        5P+ujWYqzSURqtzXUNi6ZgEA0g==
X-Google-Smtp-Source: ABdhPJz5h4DOO5/nNWLmnjqiJ02gZn/4a1nTCI4MCyENVmsXbDp8DCPOApBXInWFs6EY77dmTqRJMQ==
X-Received: by 2002:a05:620a:248f:: with SMTP id i15mr1038107qkn.264.1644891812859;
        Mon, 14 Feb 2022 18:23:32 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d6sm18508058qty.40.2022.02.14.18.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:23:32 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:23:29 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 03/13] mm/munlock: delete munlock_vma_pages_all(), allow
 oomreap
In-Reply-To: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
Message-ID: <d9a9f8c3-1ee0-4c81-7017-6ecb78554a7@google.com>
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

munlock_vma_pages_range() will still be required, when munlocking but
not munmapping a set of pages; but when unmapping a pte, the mlock count
will be maintained in much the same way as it will be maintained when
mapping in the pte.  Which removes the need for munlock_vma_pages_all()
on mlocked vmas when munmapping or exiting: eliminating the catastrophic
contention on i_mmap_rwsem, and the need for page lock on the pages.

There is still a need to update locked_vm accounting according to the
munmapped vmas when munmapping: do that in detach_vmas_to_be_unmapped().
exit_mmap() does not need locked_vm updates, so delete unlock_range().

And wasn't I the one who forbade the OOM reaper to attack mlocked vmas,
because of the uncertainty in blocking on all those page locks?
No fear of that now, so permit the OOM reaper on mlocked vmas.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
v2: same as v1.

 mm/internal.h | 16 ++--------------
 mm/madvise.c  |  5 +++++
 mm/mlock.c    |  4 ++--
 mm/mmap.c     | 32 ++------------------------------
 mm/oom_kill.c |  2 +-
 5 files changed, 12 insertions(+), 47 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index e48c486d5ddf..f235aa92e564 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -71,11 +71,6 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
 		unsigned long floor, unsigned long ceiling);
 void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 
-static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
-{
-	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
-}
-
 struct zap_details;
 void unmap_page_range(struct mmu_gather *tlb,
 			     struct vm_area_struct *vma,
@@ -398,12 +393,8 @@ extern long populate_vma_page_range(struct vm_area_struct *vma,
 extern long faultin_vma_page_range(struct vm_area_struct *vma,
 				   unsigned long start, unsigned long end,
 				   bool write, int *locked);
-extern void munlock_vma_pages_range(struct vm_area_struct *vma,
-			unsigned long start, unsigned long end);
-static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
-{
-	munlock_vma_pages_range(vma, vma->vm_start, vma->vm_end);
-}
+extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
+			      unsigned long len);
 
 /*
  * must be called with vma's mmap_lock held for read or write, and page locked.
@@ -411,9 +402,6 @@ static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
 extern void mlock_vma_page(struct page *page);
 extern void munlock_vma_page(struct page *page);
 
-extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
-			      unsigned long len);
-
 /*
  * Clear the page's PageMlocked().  This can be useful in a situation where
  * we want to unconditionally remove a page from the pagecache -- e.g.,
diff --git a/mm/madvise.c b/mm/madvise.c
index 5604064df464..ae35d72627ef 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -530,6 +530,11 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
 	tlb_end_vma(tlb, vma);
 }
 
+static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
+{
+	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
+}
+
 static long madvise_cold(struct vm_area_struct *vma,
 			struct vm_area_struct **prev,
 			unsigned long start_addr, unsigned long end_addr)
diff --git a/mm/mlock.c b/mm/mlock.c
index aec4ce7919da..5d7ced8303be 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -137,8 +137,8 @@ void munlock_vma_page(struct page *page)
  * Returns with VM_LOCKED cleared.  Callers must be prepared to
  * deal with this.
  */
-void munlock_vma_pages_range(struct vm_area_struct *vma,
-			     unsigned long start, unsigned long end)
+static void munlock_vma_pages_range(struct vm_area_struct *vma,
+				    unsigned long start, unsigned long end)
 {
 	vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 1e8fdb0b51ed..64b5985b5295 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2674,6 +2674,8 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vma,
 	vma->vm_prev = NULL;
 	do {
 		vma_rb_erase(vma, &mm->mm_rb);
+		if (vma->vm_flags & VM_LOCKED)
+			mm->locked_vm -= vma_pages(vma);
 		mm->map_count--;
 		tail_vma = vma;
 		vma = vma->vm_next;
@@ -2778,22 +2780,6 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
 
-static inline void
-unlock_range(struct vm_area_struct *start, unsigned long limit)
-{
-	struct mm_struct *mm = start->vm_mm;
-	struct vm_area_struct *tmp = start;
-
-	while (tmp && tmp->vm_start < limit) {
-		if (tmp->vm_flags & VM_LOCKED) {
-			mm->locked_vm -= vma_pages(tmp);
-			munlock_vma_pages_all(tmp);
-		}
-
-		tmp = tmp->vm_next;
-	}
-}
-
 /* Munmap is split into 2 main parts -- this part which finds
  * what needs doing, and the areas themselves, which do the
  * work.  This now handles partial unmappings.
@@ -2874,12 +2860,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 			return error;
 	}
 
-	/*
-	 * unlock any mlock()ed ranges before detaching vmas
-	 */
-	if (mm->locked_vm)
-		unlock_range(vma, end);
-
 	/* Detach vmas from rbtree */
 	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
 		downgrade = false;
@@ -3147,20 +3127,12 @@ void exit_mmap(struct mm_struct *mm)
 		 * Nothing can be holding mm->mmap_lock here and the above call
 		 * to mmu_notifier_release(mm) ensures mmu notifier callbacks in
 		 * __oom_reap_task_mm() will not block.
-		 *
-		 * This needs to be done before calling unlock_range(),
-		 * which clears VM_LOCKED, otherwise the oom reaper cannot
-		 * reliably test it.
 		 */
 		(void)__oom_reap_task_mm(mm);
-
 		set_bit(MMF_OOM_SKIP, &mm->flags);
 	}
 
 	mmap_write_lock(mm);
-	if (mm->locked_vm)
-		unlock_range(mm->mmap, ULONG_MAX);
-
 	arch_exit_mmap(mm);
 
 	vma = mm->mmap;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 832fb330376e..6b875acabd1e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -526,7 +526,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	set_bit(MMF_UNSTABLE, &mm->flags);
 
 	for (vma = mm->mmap ; vma; vma = vma->vm_next) {
-		if (!can_madv_lru_vma(vma))
+		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
 
 		/*
-- 
2.34.1

