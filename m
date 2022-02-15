Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77004B60EB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiBOCWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:22:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiBOCWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:22:05 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659AE1147
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:21:56 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id p14so17317362qtx.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=XpVf8sy056jRyPa9drMdsEh9TQFT4vmT+7aOxE3q5hg=;
        b=YzbBYPCFtjYviPqU0UnG8kQyotr4lFmYMaSFnMO7tj6IHg/0wXSmYjKyvhPsWKcfEV
         lJS9MVPWafm44wb8v1GwOG1qchh3a3QfS8x137RR7OfqD3pIrU2MOVrcAO1h15+lxRlq
         ADMwHwA9s5rDSHEiinGc7ASmwyTgtE3Vn+BrJDtTdGJw2sahbZWj/uk6bF4ck8diCNut
         Ud4hEcmE2iErdmM92rzti7BgfVHGegRNRIm1W4QUod3ZhHAIb6zV7bRfCEc8fltahLWu
         Mgc0UTRi4CN5GrGzhNfsgPd/K85oxTzBenkBH/jdTl+JcIfORDLPaPQ+6TJtSOsRk7kt
         H6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=XpVf8sy056jRyPa9drMdsEh9TQFT4vmT+7aOxE3q5hg=;
        b=b0QJXoRpOAdvadXNyGots/PChJWHdroFQ9zuWPph6GuKSui6XOSRJb3ToyXDr4RdVY
         4HESr+XnIUIcloOtYwp+6DnZ9yR7YbvugBYfrqn1+rg1FTU7dYaeDFsc1Vu28ianzMEK
         fo4Bna+hyoO6ZDjWbwDo4XwWH3kjpjDlZKnTzaZok+N52V1cvMBqMRhtL0KZj7C+vV2S
         fQV5fFllXTyCjbdMXrtkyV5TFv041ElRWp/3luzqRMJjlBX4IiDceyUNONV2eDK6xmPA
         3hkN0V0XKKAWuZ1SubzKnnTXQ2NCgvCX9ArIKjJbv98raaqOueyT/OycnD2nyJ8cYD5b
         gbeA==
X-Gm-Message-State: AOAM532hwF7Xf1HHCeSkGKI/WlQ/8pwQe6jrtethNlAdAqfx1p+g6aAi
        0iqkLupDmevPU+MzmvAMh/ZE+A==
X-Google-Smtp-Source: ABdhPJz4Bmr7FpfejqS5S8AGFcoAxxCc3s3HCFsMnc1FMAUr9kVT/tIbYpIhNNTXbhh68pxiqT98vg==
X-Received: by 2002:ac8:5ac4:: with SMTP id d4mr1362870qtd.144.1644891715385;
        Mon, 14 Feb 2022 18:21:55 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h5sm19719419qth.54.2022.02.14.18.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:21:54 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:21:52 -0800 (PST)
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
Subject: [PATCH v2 02/13] mm/munlock: delete FOLL_MLOCK and FOLL_POPULATE
In-Reply-To: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
Message-ID: <cbed9c9f-1747-f06a-15ad-b2d9fb6025eb@google.com>
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
v2: same as v1.

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

