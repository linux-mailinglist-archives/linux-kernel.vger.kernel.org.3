Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7844B610A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiBOCcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:32:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiBOCcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:32:01 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8D6B65FA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:31:52 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id o5so16442264qvm.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=SEHRUOH5N9XtoyGwgSgWRzInurRzgz1DBRcTDOVUssY=;
        b=Ef93WPz4BNfQgCvNVDzYXhPEoVfw8YCKHvG6ms7UdB7bFwbn+0qNzMPyUWbIg64oq+
         MxE98w/ljM1MoSG1BvggJ6eAg4YLTUqcaz0jdQ1vd3MZhXYmijykAwPeuREWzO5BN4Gr
         GXxgwiuuLFphEWGcMIdagwrnRQCXPDiGXkFZk82Ss2VAHH/zIXJbXuqQjlrui/TdrF0f
         DEY4YioAZllKQPHkZQUSGcf4M8euKcAKwOPWjtibLdKxL+AQmQi+F+kgXZIW/ThkH5Xx
         Kb4sKrxpheoCiJY3zti20+oL6KCsGkFJiPHkSVNUGTrNMpHmDh3HGLwPvNcsVrZPq41P
         bvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=SEHRUOH5N9XtoyGwgSgWRzInurRzgz1DBRcTDOVUssY=;
        b=yqmJFZbCc/AWXk6BJCDRQCbQ6yxtigCSP6lO5CIVka7tKjMNQyH3u4V0YZY9ElBh+l
         9wihHrjemgQzzW14tcRjrr/MfWrzI2l1dLVT9vMNaJfXJG8nnvHl7foBt9S4o37n2H9J
         dumpournbbf8wkI1WBs2FOy8CF4fp1xAYZZ7GgFlk+OATQFMHxVcWZGMjX+QwO9QmH95
         O0Kko7Iw1zOgrRUg/aDJzhDkIvuUPqmi1dVgFMcsiJblfbr3k/oCyp4ofexM67Vaej8+
         yZPSbXvfrqRol5E7ODi2J+hyzK8DuT5gGL+gJPQI7lQNfMVfdhWaJhcQhMRHQdDR/G2b
         0VAw==
X-Gm-Message-State: AOAM532SSwDc3KMYqflSJ2hJULE9oc28wAy6mox5r36ZgjMKqIhqzKnI
        marbDEfPbW+Z4pRY/8DpAeJGpQ==
X-Google-Smtp-Source: ABdhPJzxJaqmReL22Kes+tEvk+cR241J/U9I6IjlYTTv8kuo3FsPJYf1LN3+scnIctYC81CMtO/55w==
X-Received: by 2002:a05:6214:20ab:: with SMTP id 11mr1304781qvd.98.1644892311112;
        Mon, 14 Feb 2022 18:31:51 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id br35sm16757332qkb.118.2022.02.14.18.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:31:50 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:31:48 -0800 (PST)
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
        Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 07/13] mm/munlock: mlock_pte_range() when mlocking or
 munlocking
In-Reply-To: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
Message-ID: <d39f6e4d-aa4f-731a-68ee-e77cdbf1d7bb@google.com>
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

Fill in missing pieces: reimplementation of munlock_vma_pages_range(),
required to lower the mlock_counts when munlocking without munmapping;
and its complement, implementation of mlock_vma_pages_range(), required
to raise the mlock_counts on pages already there when a range is mlocked.

Combine them into just the one function mlock_vma_pages_range(), using
walk_page_range() to run mlock_pte_range().  This approach fixes the
"Very slow unlockall()" of unpopulated PROT_NONE areas, reported in
https://lore.kernel.org/linux-mm/70885d37-62b7-748b-29df-9e94f3291736@gmail.com/

Munlock clears VM_LOCKED at the start, under exclusive mmap_lock; but if
a racing truncate or holepunch (depending on i_mmap_rwsem) gets to the
pte first, it will not try to munlock the page: leaving release_pages()
to correct it when the last reference to the page is gone - that's okay,
a page is not evictable anyway while it is held by an extra reference.

Mlock sets VM_LOCKED at the start, under exclusive mmap_lock; but if
a racing remove_migration_pte() or try_to_unmap_one() (depending on
i_mmap_rwsem) gets to the pte first, it will try to mlock the page,
then mlock_pte_range() mlock it a second time.  This is harder to
reproduce, but a more serious race because it could leave the page
unevictable indefinitely though the area is munlocked afterwards.
Guard against it by setting the (inappropriate) VM_IO flag,
and modifying mlock_vma_page() to decline such vmas.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
v2: Delete reintroduced VM_LOCKED_CLEAR_MASKing here, per Vlastimil.
    Use oldflags instead of vma->vm_flags in mlock_fixup(), per Vlastimil.
    Make clearer comment on mmap_lock and WRITE_ONCE, per Hillf.

 mm/internal.h |   3 +-
 mm/mlock.c    | 111 ++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 91 insertions(+), 23 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index a43d79335c16..b3f0dd3ffba2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -412,7 +412,8 @@ void mlock_page(struct page *page);
 static inline void mlock_vma_page(struct page *page,
 			struct vm_area_struct *vma, bool compound)
 {
-	if (unlikely(vma->vm_flags & VM_LOCKED) &&
+	/* VM_IO check prevents migration from double-counting during mlock */
+	if (unlikely((vma->vm_flags & (VM_LOCKED|VM_IO)) == VM_LOCKED) &&
 	    (compound || !PageTransCompound(page)))
 		mlock_page(page);
 }
diff --git a/mm/mlock.c b/mm/mlock.c
index f8a3a54687dd..581ea8bf1b83 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -14,6 +14,7 @@
 #include <linux/swapops.h>
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
+#include <linux/pagewalk.h>
 #include <linux/mempolicy.h>
 #include <linux/syscalls.h>
 #include <linux/sched.h>
@@ -127,25 +128,91 @@ void munlock_page(struct page *page)
 	unlock_page_memcg(page);
 }
 
+static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
+			   unsigned long end, struct mm_walk *walk)
+
+{
+	struct vm_area_struct *vma = walk->vma;
+	spinlock_t *ptl;
+	pte_t *start_pte, *pte;
+	struct page *page;
+
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (ptl) {
+		if (!pmd_present(*pmd))
+			goto out;
+		if (is_huge_zero_pmd(*pmd))
+			goto out;
+		page = pmd_page(*pmd);
+		if (vma->vm_flags & VM_LOCKED)
+			mlock_page(page);
+		else
+			munlock_page(page);
+		goto out;
+	}
+
+	start_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
+		if (!pte_present(*pte))
+			continue;
+		page = vm_normal_page(vma, addr, *pte);
+		if (!page)
+			continue;
+		if (PageTransCompound(page))
+			continue;
+		if (vma->vm_flags & VM_LOCKED)
+			mlock_page(page);
+		else
+			munlock_page(page);
+	}
+	pte_unmap(start_pte);
+out:
+	spin_unlock(ptl);
+	cond_resched();
+	return 0;
+}
+
 /*
- * munlock_vma_pages_range() - munlock all pages in the vma range.'
- * @vma - vma containing range to be munlock()ed.
+ * mlock_vma_pages_range() - mlock any pages already in the range,
+ *                           or munlock all pages in the range.
+ * @vma - vma containing range to be mlock()ed or munlock()ed
  * @start - start address in @vma of the range
- * @end - end of range in @vma.
- *
- *  For mremap(), munmap() and exit().
+ * @end - end of range in @vma
+ * @newflags - the new set of flags for @vma.
  *
- * Called with @vma VM_LOCKED.
- *
- * Returns with VM_LOCKED cleared.  Callers must be prepared to
- * deal with this.
+ * Called for mlock(), mlock2() and mlockall(), to set @vma VM_LOCKED;
+ * called for munlock() and munlockall(), to clear VM_LOCKED from @vma.
  */
-static void munlock_vma_pages_range(struct vm_area_struct *vma,
-				    unsigned long start, unsigned long end)
+static void mlock_vma_pages_range(struct vm_area_struct *vma,
+	unsigned long start, unsigned long end, vm_flags_t newflags)
 {
-	vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
+	static const struct mm_walk_ops mlock_walk_ops = {
+		.pmd_entry = mlock_pte_range,
+	};
 
-	/* Reimplementation to follow in later commit */
+	/*
+	 * There is a slight chance that concurrent page migration,
+	 * or page reclaim finding a page of this now-VM_LOCKED vma,
+	 * will call mlock_vma_page() and raise page's mlock_count:
+	 * double counting, leaving the page unevictable indefinitely.
+	 * Communicate this danger to mlock_vma_page() with VM_IO,
+	 * which is a VM_SPECIAL flag not allowed on VM_LOCKED vmas.
+	 * mmap_lock is held in write mode here, so this weird
+	 * combination should not be visible to other mmap_lock users;
+	 * but WRITE_ONCE so rmap walkers must see VM_IO if VM_LOCKED.
+	 */
+	if (newflags & VM_LOCKED)
+		newflags |= VM_IO;
+	WRITE_ONCE(vma->vm_flags, newflags);
+
+	lru_add_drain();
+	walk_page_range(vma->vm_mm, start, end, &mlock_walk_ops, NULL);
+	lru_add_drain();
+
+	if (newflags & VM_IO) {
+		newflags &= ~VM_IO;
+		WRITE_ONCE(vma->vm_flags, newflags);
+	}
 }
 
 /*
@@ -164,10 +231,9 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	pgoff_t pgoff;
 	int nr_pages;
 	int ret = 0;
-	int lock = !!(newflags & VM_LOCKED);
-	vm_flags_t old_flags = vma->vm_flags;
+	vm_flags_t oldflags = vma->vm_flags;
 
-	if (newflags == vma->vm_flags || (vma->vm_flags & VM_SPECIAL) ||
+	if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
 	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
 	    vma_is_dax(vma) || vma_is_secretmem(vma))
 		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
@@ -199,9 +265,9 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	 * Keep track of amount of locked VM.
 	 */
 	nr_pages = (end - start) >> PAGE_SHIFT;
-	if (!lock)
+	if (!(newflags & VM_LOCKED))
 		nr_pages = -nr_pages;
-	else if (old_flags & VM_LOCKED)
+	else if (oldflags & VM_LOCKED)
 		nr_pages = 0;
 	mm->locked_vm += nr_pages;
 
@@ -211,11 +277,12 @@ static int mlock_fixup(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	 * set VM_LOCKED, populate_vma_page_range will bring it back.
 	 */
 
-	if (lock)
+	if ((newflags & VM_LOCKED) && (oldflags & VM_LOCKED)) {
+		/* No work to do, and mlocking twice would be wrong */
 		vma->vm_flags = newflags;
-	else
-		munlock_vma_pages_range(vma, start, end);
-
+	} else {
+		mlock_vma_pages_range(vma, start, end, newflags);
+	}
 out:
 	*prev = vma;
 	return ret;
-- 
2.34.1

