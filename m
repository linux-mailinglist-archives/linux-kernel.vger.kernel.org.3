Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81174AB262
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242409AbiBFVcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbiBFVcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:32:20 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAA1C061355
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:32:19 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id o12so9528343qke.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 13:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=zQkpuLA9DZJBUcE3jcYKmscDjcpqSqOLAzrvayz8ZnU=;
        b=GR8TM5vXeQKiwsAkIe1lxgAeTCAhUmGm16fCx+tfDblMF1EMkt4QZ4Hy/vppBd/MN0
         3UzX65hlcREiX7l/hWchOeXkrk7bmgMPSJT+V6pYw0zBYf3UjwiwzTE94NidxzhmA/z4
         JXkN9JTi/BRohA6w7XEHQMiAYzehy5Q4fMCx2vIQNzs1SKF+gfc+1DtQm76W0l8ErE9+
         wQvZ5eDJafIatsgNYCocYBFZd1leAMWZIt0e2816Pq3GAn8SpZr9GRn3lsGcMFsOIzyr
         FGKMVW302u+8DJp5iuQRFQfQD9sAV2fGeKibi+QKzHSugVsQmj4soDsg0sIXK86OuhDI
         B7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=zQkpuLA9DZJBUcE3jcYKmscDjcpqSqOLAzrvayz8ZnU=;
        b=5YIZD0TMdkJe6BKajyFYQ1VSBG6ioxsYanp/lFHVjY/+5QHpCto2bDD7wrMqoZelOj
         dA/hITVKruv4qHuePKSB60crydLLdKiiaFKgvZ9Jw18E1lb3O9iWRozv/x5fgbIOfMvo
         mEKoEW3S7St2MTl4+bn205WasV+1U9GAWsWLSzlD7u7Z5LasShHG6FuofMPLvAv4Ftif
         Sit8ZgtJoonqVQJQsgl/wbeDWSUFDFSZyZCQdmawCfvRRaRASd89hpTjo8fuGwu7wxbu
         oXL9QTzErdRvHeSg2vlAIliS8fyhXtGtcI4vAXe15GePRwl8kKHZESQ5wZQYXAWxPFPE
         /Igg==
X-Gm-Message-State: AOAM533MvFwOBhjygWxsSX+HK6axOTFuLbdk8yeUuorN7DPTKwxoXcOl
        DUpg5jtAIRzWNgb1KXnxQhL9oQ==
X-Google-Smtp-Source: ABdhPJwjY0WNGaOWMQXMYnAUM4AdKudIMQlTqPQspgi9cVygJ/L+ge74DGirQVBQMsWFL+2MhlIGzw==
X-Received: by 2002:a05:620a:1914:: with SMTP id bj20mr4920106qkb.56.1644183138671;
        Sun, 06 Feb 2022 13:32:18 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w10sm5068516qtj.73.2022.02.06.13.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:32:18 -0800 (PST)
Date:   Sun, 6 Feb 2022 13:32:15 -0800 (PST)
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
Subject: [PATCH 02/13] mm/munlock: delete FOLL_MLOCK and FOLL_POPULATE
In-Reply-To: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
Message-ID: <2b5eee76-183f-bd97-2e9d-f5ff8df63db@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
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

If counting page mlocks, we must not double-count: follow_page_pte() can
tell if a page has already been Mlocked or not, but cannot tell if a pte
has already been counted or not: that will have to be done when the pte
is mapped in (which lru_cache_add_inactive_or_unevictable() already tracks
for new anon pages, but there's no such tracking yet for others).

Delete all the FOLL_MLOCK code - faulting in the missing pages will do
all that is necessary, without special mlock_vma_page() calls from here.

But then FOLL_POPULATE turns out to serve no purpose - it was there so
that its absence would tell faultin_page() not to faultin page when
setting up VM_LOCKONFAULT areas; but if there's no special work needed
here for mlock, then there's no work at all here for VM_LOCKONFAULT.

Have I got that right?  I've not looked into the history, but see that
FOLL_POPULATE goes back before VM_LOCKONFAULT: did it serve a different
purpose before?  Ah, yes, it was used to skip the old stack guard page.

And is it intentional that COW is not broken on existing pages when
setting up a VM_LOCKONFAULT area?  I can see that being argued either
way, and have no reason to disagree with current behaviour.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/mm.h |  2 --
 mm/gup.c           | 43 ++++++++-----------------------------------
 mm/huge_memory.c   | 33 ---------------------------------
 3 files changed, 8 insertions(+), 70 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b192..74ee50c2033b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2925,13 +2925,11 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
 #define FOLL_FORCE	0x10	/* get_user_pages read/write w/o permission */
 #define FOLL_NOWAIT	0x20	/* if a disk transfer is needed, start the IO
 				 * and return without waiting upon it */
-#define FOLL_POPULATE	0x40	/* fault in pages (with FOLL_MLOCK) */
 #define FOLL_NOFAULT	0x80	/* do not fault in pages */
 #define FOLL_HWPOISON	0x100	/* check page is hwpoisoned */
 #define FOLL_NUMA	0x200	/* force NUMA hinting page fault */
 #define FOLL_MIGRATION	0x400	/* wait for page to replace migration entry */
 #define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
-#define FOLL_MLOCK	0x1000	/* lock present pages */
 #define FOLL_REMOTE	0x2000	/* we are working on non-current tsk/mm */
 #define FOLL_COW	0x4000	/* internal GUP flag */
 #define FOLL_ANON	0x8000	/* don't do file mappings */
diff --git a/mm/gup.c b/mm/gup.c
index f0af462ac1e2..2076902344d8 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -572,32 +572,6 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 		 */
 		mark_page_accessed(page);
 	}
-	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
-		/* Do not mlock pte-mapped THP */
-		if (PageTransCompound(page))
-			goto out;
-
-		/*
-		 * The preliminary mapping check is mainly to avoid the
-		 * pointless overhead of lock_page on the ZERO_PAGE
-		 * which might bounce very badly if there is contention.
-		 *
-		 * If the page is already locked, we don't need to
-		 * handle it now - vmscan will handle it later if and
-		 * when it attempts to reclaim the page.
-		 */
-		if (page->mapping && trylock_page(page)) {
-			lru_add_drain();  /* push cached pages to LRU */
-			/*
-			 * Because we lock page here, and migration is
-			 * blocked by the pte's page reference, and we
-			 * know the page is still mapped, we don't even
-			 * need to check for file-cache page truncation.
-			 */
-			mlock_vma_page(page);
-			unlock_page(page);
-		}
-	}
 out:
 	pte_unmap_unlock(ptep, ptl);
 	return page;
@@ -920,9 +894,6 @@ static int faultin_page(struct vm_area_struct *vma,
 	unsigned int fault_flags = 0;
 	vm_fault_t ret;
 
-	/* mlock all present pages, but do not fault in new pages */
-	if ((*flags & (FOLL_POPULATE | FOLL_MLOCK)) == FOLL_MLOCK)
-		return -ENOENT;
 	if (*flags & FOLL_NOFAULT)
 		return -EFAULT;
 	if (*flags & FOLL_WRITE)
@@ -1173,8 +1144,6 @@ static long __get_user_pages(struct mm_struct *mm,
 			case -ENOMEM:
 			case -EHWPOISON:
 				goto out;
-			case -ENOENT:
-				goto next_page;
 			}
 			BUG();
 		} else if (PTR_ERR(page) == -EEXIST) {
@@ -1472,9 +1441,14 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	VM_BUG_ON_VMA(end   > vma->vm_end, vma);
 	mmap_assert_locked(mm);
 
-	gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK;
+	/*
+	 * Rightly or wrongly, the VM_LOCKONFAULT case has never used
+	 * faultin_page() to break COW, so it has no work to do here.
+	 */
 	if (vma->vm_flags & VM_LOCKONFAULT)
-		gup_flags &= ~FOLL_POPULATE;
+		return nr_pages;
+
+	gup_flags = FOLL_TOUCH;
 	/*
 	 * We want to touch writable mappings with a write fault in order
 	 * to break COW, except for shared mappings because these don't COW
@@ -1541,10 +1515,9 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
 	 *	       in the page table.
 	 * FOLL_HWPOISON: Return -EHWPOISON instead of -EFAULT when we hit
 	 *		  a poisoned page.
-	 * FOLL_POPULATE: Always populate memory with VM_LOCKONFAULT.
 	 * !FOLL_FORCE: Require proper access permissions.
 	 */
-	gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK | FOLL_HWPOISON;
+	gup_flags = FOLL_TOUCH | FOLL_HWPOISON;
 	if (write)
 		gup_flags |= FOLL_WRITE;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 406a3c28c026..9a34b85ebcf8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1380,39 +1380,6 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	if (flags & FOLL_TOUCH)
 		touch_pmd(vma, addr, pmd, flags);
 
-	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
-		/*
-		 * We don't mlock() pte-mapped THPs. This way we can avoid
-		 * leaking mlocked pages into non-VM_LOCKED VMAs.
-		 *
-		 * For anon THP:
-		 *
-		 * In most cases the pmd is the only mapping of the page as we
-		 * break COW for the mlock() -- see gup_flags |= FOLL_WRITE for
-		 * writable private mappings in populate_vma_page_range().
-		 *
-		 * The only scenario when we have the page shared here is if we
-		 * mlocking read-only mapping shared over fork(). We skip
-		 * mlocking such pages.
-		 *
-		 * For file THP:
-		 *
-		 * We can expect PageDoubleMap() to be stable under page lock:
-		 * for file pages we set it in page_add_file_rmap(), which
-		 * requires page to be locked.
-		 */
-
-		if (PageAnon(page) && compound_mapcount(page) != 1)
-			goto skip_mlock;
-		if (PageDoubleMap(page) || !page->mapping)
-			goto skip_mlock;
-		if (!trylock_page(page))
-			goto skip_mlock;
-		if (page->mapping && !PageDoubleMap(page))
-			mlock_vma_page(page);
-		unlock_page(page);
-	}
-skip_mlock:
 	page += (addr & ~HPAGE_PMD_MASK) >> PAGE_SHIFT;
 	VM_BUG_ON_PAGE(!PageCompound(page) && !is_zone_device_page(page), page);
 
-- 
2.34.1

