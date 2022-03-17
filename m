Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AC64DD0AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiCQWZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiCQWZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:25:01 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B41221B83
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:23:41 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id kj11so1432629qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=ln+q+8A1KN8U7gf5wjwnyWQV+MXySAfyyLwi73d/Le8=;
        b=qLmc0maohcHAfLu4XiNF3DKPKI+a/LE6YWz8J40iDjmzbVpLKcZIHKXr3lFYTtWdiy
         ymtSPb+2JOHuv4UI/de85hXyyCU9Pj/Q2rIWDGAERS/dTwRXVy7TO22kpFDioyMViPpZ
         YfKzmFIZrCYUmtZsVU3vVxL9sAJOvKhkkwEjh0ivlYYttCaqgZzwpSRC+av7Xkes8uVo
         BnKWsFtBgqYZ93Loj4XXVXOlRJ16hJJatSjlJJBNoaP+oUqXh0tkbQ8mhiLkqReW5dBH
         vR+QgnhR3wJ17ugQkI8D4/DKEiMioNyjTbtAg5/f3X+wPw88qqQlAOGS6DX22j5noApG
         PyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=ln+q+8A1KN8U7gf5wjwnyWQV+MXySAfyyLwi73d/Le8=;
        b=zGAnIhPE9nzv5CE3tYrgWGfT0U/DwnaGtDitMpgdIiLqvIZ/7qR52nJQ8tnWCWYvEA
         7KJ1hi9w6sHAg55mcJ1QneBPpUAJYFA/gs4etwuSgMiD5OAH1iAdNUATuh75HcY4U1eo
         Perh6dw/gpOFTI0gPpYV6CpBJo4ANwD9R/6jmuS2pXNLi07dG2S1MAD4lbhqJdKoq0e2
         ODWm4+EzeEzciviNqjav3rMU0HUFzhO4bLkrlf4gMRx4vq5PL0tTPB97eW8xVAw4eVsX
         vSHogsJGAvROME+y55lpsK3NmjKlg43+vM3dNrkGU6ke5tIbMuc9mdXm7BetOR6M7Ngs
         jIKw==
X-Gm-Message-State: AOAM531GE1/ixh5X0oDbmnhk1VdbGPVolYWx5TxHyryH7mHFxT4KPIRc
        QJZHnOPogtlqBG65Qd4vCfbCxQ==
X-Google-Smtp-Source: ABdhPJwe5WUwqNAudFbF17+uRFZypaWWNX0sZ8TYJ6b1ghJN2dUKjZgG+KzJiFSMsuhAKoRpXBlzvg==
X-Received: by 2002:ad4:576c:0:b0:435:493d:98e9 with SMTP id r12-20020ad4576c000000b00435493d98e9mr5301796qvx.128.1647555820155;
        Thu, 17 Mar 2022 15:23:40 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 75-20020a37044e000000b0067d47fb5aa4sm3145495qke.63.2022.03.17.15.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 15:23:39 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:23:25 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH mmotm] mm/munlock: update
 Documentation/vm/unevictable-lru.rst
Message-ID: <3753962-d491-bf60-f59f-51bfe84fd6a0@google.com>
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

Update Documentation/vm/unevictable-lru.rst to reflect the changes made
by the mm/munlock series: keeping an mlock_count instead of page_mlock()
(formerly try_to_munlock()) and munlock_vma_pages_all() etc.  Also make
other little updates or cleanups wherever noticed.

But, I apologize, this is already out of date, in that "folio" appears
nowhere: 5.18 will be in a transitional state from "page" to "folio",
and documenting its current mix of the two does not help to understand
"the Unevictable LRU".  Should be revisited when naming is more settled.

Signed-off-by: Hugh Dickins <hughd@google.com>
---

 Documentation/vm/unevictable-lru.rst |  473 ++++++++++++---------------
 1 file changed, 211 insertions(+), 262 deletions(-)

--- mmotm/Documentation/vm/unevictable-lru.rst
+++ linux/Documentation/vm/unevictable-lru.rst
@@ -52,8 +52,13 @@ The infrastructure may also be able to h
 unevictable, either by definition or by circumstance, in the future.
 
 
-The Unevictable Page List
--------------------------
+The Unevictable LRU Page List
+-----------------------------
+
+The Unevictable LRU page list is a lie.  It was never an LRU-ordered list, but a
+companion to the LRU-ordered anonymous and file, active and inactive page lists;
+and now it is not even a page list.  But following familiar convention, here in
+this document and in the source, we often imagine it as a fifth LRU page list.
 
 The Unevictable LRU infrastructure consists of an additional, per-node, LRU list
 called the "unevictable" list and an associated page flag, PG_unevictable, to
@@ -63,8 +68,8 @@ The PG_unevictable flag is analogous to,
 PG_active flag in that it indicates on which LRU list a page resides when
 PG_lru is set.
 
-The Unevictable LRU infrastructure maintains unevictable pages on an additional
-LRU list for a few reasons:
+The Unevictable LRU infrastructure maintains unevictable pages as if they were
+on an additional LRU list for a few reasons:
 
  (1) We get to "treat unevictable pages just like we treat other pages in the
      system - which means we get to use the same code to manipulate them, the
@@ -72,13 +77,11 @@ LRU list for a few reasons:
      of the statistics, etc..." [Rik van Riel]
 
  (2) We want to be able to migrate unevictable pages between nodes for memory
-     defragmentation, workload management and memory hotplug.  The linux kernel
+     defragmentation, workload management and memory hotplug.  The Linux kernel
      can only migrate pages that it can successfully isolate from the LRU
-     lists.  If we were to maintain pages elsewhere than on an LRU-like list,
-     where they can be found by isolate_lru_page(), we would prevent their
-     migration, unless we reworked migration code to find the unevictable pages
-     itself.
-
+     lists (or "Movable" pages: outside of consideration here).  If we were to
+     maintain pages elsewhere than on an LRU-like list, where they can be
+     detected by isolate_lru_page(), we would prevent their migration.
 
 The unevictable list does not differentiate between file-backed and anonymous,
 swap-backed pages.  This differentiation is only important while the pages are,
@@ -92,8 +95,8 @@ Memory Control Group Interaction
 --------------------------------
 
 The unevictable LRU facility interacts with the memory control group [aka
-memory controller; see Documentation/admin-guide/cgroup-v1/memory.rst] by extending the
-lru_list enum.
+memory controller; see Documentation/admin-guide/cgroup-v1/memory.rst] by
+extending the lru_list enum.
 
 The memory controller data structure automatically gets a per-node unevictable
 list as a result of the "arrayification" of the per-node LRU lists (one per
@@ -143,7 +146,6 @@ These are currently used in three places
      and this mark remains for the life of the inode.
 
  (2) By SYSV SHM to mark SHM_LOCK'd address spaces until SHM_UNLOCK is called.
-
      Note that SHM_LOCK is not required to page in the locked pages if they're
      swapped out; the application must touch the pages manually if it wants to
      ensure they're in memory.
@@ -156,19 +158,19 @@ These are currently used in three places
 Detecting Unevictable Pages
 ---------------------------
 
-The function page_evictable() in vmscan.c determines whether a page is
+The function page_evictable() in mm/internal.h determines whether a page is
 evictable or not using the query function outlined above [see section
 :ref:`Marking address spaces unevictable <mark_addr_space_unevict>`]
 to check the AS_UNEVICTABLE flag.
 
 For address spaces that are so marked after being populated (as SHM regions
-might be), the lock action (eg: SHM_LOCK) can be lazy, and need not populate
+might be), the lock action (e.g. SHM_LOCK) can be lazy, and need not populate
 the page tables for the region as does, for example, mlock(), nor need it make
 any special effort to push any pages in the SHM_LOCK'd area to the unevictable
 list.  Instead, vmscan will do this if and when it encounters the pages during
 a reclamation scan.
 
-On an unlock action (such as SHM_UNLOCK), the unlocker (eg: shmctl()) must scan
+On an unlock action (such as SHM_UNLOCK), the unlocker (e.g. shmctl()) must scan
 the pages in the region and "rescue" them from the unevictable list if no other
 condition is keeping them unevictable.  If an unevictable region is destroyed,
 the pages are also "rescued" from the unevictable list in the process of
@@ -176,7 +178,7 @@ freeing them.
 
 page_evictable() also checks for mlocked pages by testing an additional page
 flag, PG_mlocked (as wrapped by PageMlocked()), which is set when a page is
-faulted into a VM_LOCKED vma, or found in a vma being VM_LOCKED.
+faulted into a VM_LOCKED VMA, or found in a VMA being VM_LOCKED.
 
 
 Vmscan's Handling of Unevictable Pages
@@ -186,28 +188,23 @@ If unevictable pages are culled in the f
 list at mlock() or mmap() time, vmscan will not encounter the pages until they
 have become evictable again (via munlock() for example) and have been "rescued"
 from the unevictable list.  However, there may be situations where we decide,
-for the sake of expediency, to leave a unevictable page on one of the regular
+for the sake of expediency, to leave an unevictable page on one of the regular
 active/inactive LRU lists for vmscan to deal with.  vmscan checks for such
 pages in all of the shrink_{active|inactive|page}_list() functions and will
 "cull" such pages that it encounters: that is, it diverts those pages to the
-unevictable list for the node being scanned.
+unevictable list for the memory cgroup and node being scanned.
 
 There may be situations where a page is mapped into a VM_LOCKED VMA, but the
 page is not marked as PG_mlocked.  Such pages will make it all the way to
-shrink_page_list() where they will be detected when vmscan walks the reverse
-map in try_to_unmap().  If try_to_unmap() returns SWAP_MLOCK,
-shrink_page_list() will cull the page at that point.
+shrink_active_list() or shrink_page_list() where they will be detected when
+vmscan walks the reverse map in page_referenced() or try_to_unmap().  The page
+is culled to the unevictable list when it is released by the shrinker.
 
 To "cull" an unevictable page, vmscan simply puts the page back on the LRU list
 using putback_lru_page() - the inverse operation to isolate_lru_page() - after
 dropping the page lock.  Because the condition which makes the page unevictable
-may change once the page is unlocked, putback_lru_page() will recheck the
-unevictable state of a page that it places on the unevictable list.  If the
-page has become unevictable, putback_lru_page() removes it from the list and
-retries, including the page_unevictable() test.  Because such a race is a rare
-event and movement of pages onto the unevictable list should be rare, these
-extra evictabilty checks should not occur in the majority of calls to
-putback_lru_page().
+may change once the page is unlocked, __pagevec_lru_add_fn() will recheck the
+unevictable state of a page before placing it on the unevictable list.
 
 
 MLOCKED Pages
@@ -227,16 +224,25 @@ Nick posted his patch as an alternative
 to achieve the same objective: hiding mlocked pages from vmscan.
 
 In Nick's patch, he used one of the struct page LRU list link fields as a count
-of VM_LOCKED VMAs that map the page.  This use of the link field for a count
-prevented the management of the pages on an LRU list, and thus mlocked pages
-were not migratable as isolate_lru_page() could not find them, and the LRU list
-link field was not available to the migration subsystem.
+of VM_LOCKED VMAs that map the page (Rik van Riel had the same idea three years
+earlier).  But this use of the link field for a count prevented the management
+of the pages on an LRU list, and thus mlocked pages were not migratable as
+isolate_lru_page() could not detect them, and the LRU list link field was not
+available to the migration subsystem.
 
-Nick resolved this by putting mlocked pages back on the lru list before
+Nick resolved this by putting mlocked pages back on the LRU list before
 attempting to isolate them, thus abandoning the count of VM_LOCKED VMAs.  When
 Nick's patch was integrated with the Unevictable LRU work, the count was
-replaced by walking the reverse map to determine whether any VM_LOCKED VMAs
-mapped the page.  More on this below.
+replaced by walking the reverse map when munlocking, to determine whether any
+other VM_LOCKED VMAs still mapped the page.
+
+However, walking the reverse map for each page when munlocking was ugly and
+inefficient, and could lead to catastrophic contention on a file's rmap lock,
+when many processes which had it mlocked were trying to exit.  In 5.18, the
+idea of keeping mlock_count in Unevictable LRU list link field was revived and
+put to work, without preventing the migration of mlocked pages.  This is why
+the "Unevictable LRU list" cannot be a linked list of pages now; but there was
+no use for that linked list anyway - though its size is maintained for meminfo.
 
 
 Basic Management
@@ -250,22 +256,18 @@ PageMlocked() functions.
 A PG_mlocked page will be placed on the unevictable list when it is added to
 the LRU.  Such pages can be "noticed" by memory management in several places:
 
- (1) in the mlock()/mlockall() system call handlers;
+ (1) in the mlock()/mlock2()/mlockall() system call handlers;
 
  (2) in the mmap() system call handler when mmapping a region with the
      MAP_LOCKED flag;
 
  (3) mmapping a region in a task that has called mlockall() with the MCL_FUTURE
-     flag
+     flag;
 
- (4) in the fault path, if mlocked pages are "culled" in the fault path,
-     and when a VM_LOCKED stack segment is expanded; or
+ (4) in the fault path and when a VM_LOCKED stack segment is expanded; or
 
  (5) as mentioned above, in vmscan:shrink_page_list() when attempting to
-     reclaim a page in a VM_LOCKED VMA via try_to_unmap()
-
-all of which result in the VM_LOCKED flag being set for the VMA if it doesn't
-already have it set.
+     reclaim a page in a VM_LOCKED VMA by page_referenced() or try_to_unmap().
 
 mlocked pages become unlocked and rescued from the unevictable list when:
 
@@ -280,51 +282,53 @@ mlocked pages become unlocked and rescue
  (4) before a page is COW'd in a VM_LOCKED VMA.
 
 
-mlock()/mlockall() System Call Handling
----------------------------------------
+mlock()/mlock2()/mlockall() System Call Handling
+------------------------------------------------
 
-Both [do\_]mlock() and [do\_]mlockall() system call handlers call mlock_fixup()
+mlock(), mlock2() and mlockall() system call handlers proceed to mlock_fixup()
 for each VMA in the range specified by the call.  In the case of mlockall(),
 this is the entire active address space of the task.  Note that mlock_fixup()
 is used for both mlocking and munlocking a range of memory.  A call to mlock()
-an already VM_LOCKED VMA, or to munlock() a VMA that is not VM_LOCKED is
-treated as a no-op, and mlock_fixup() simply returns.
+an already VM_LOCKED VMA, or to munlock() a VMA that is not VM_LOCKED, is
+treated as a no-op and mlock_fixup() simply returns.
 
-If the VMA passes some filtering as described in "Filtering Special Vmas"
+If the VMA passes some filtering as described in "Filtering Special VMAs"
 below, mlock_fixup() will attempt to merge the VMA with its neighbors or split
-off a subset of the VMA if the range does not cover the entire VMA.  Once the
-VMA has been merged or split or neither, mlock_fixup() will call
-populate_vma_page_range() to fault in the pages via get_user_pages() and to
-mark the pages as mlocked via mlock_vma_page().
+off a subset of the VMA if the range does not cover the entire VMA.  Any pages
+already present in the VMA are then marked as mlocked by mlock_page() via
+mlock_pte_range() via walk_page_range() via mlock_vma_pages_range().
+
+Before returning from the system call, do_mlock() or mlockall() will call
+__mm_populate() to fault in the remaining pages via get_user_pages() and to
+mark those pages as mlocked as they are faulted.
 
 Note that the VMA being mlocked might be mapped with PROT_NONE.  In this case,
 get_user_pages() will be unable to fault in the pages.  That's okay.  If pages
-do end up getting faulted into this VM_LOCKED VMA, we'll handle them in the
-fault path or in vmscan.
+do end up getting faulted into this VM_LOCKED VMA, they will be handled in the
+fault path - which is also how mlock2()'s MLOCK_ONFAULT areas are handled.
 
-Also note that a page returned by get_user_pages() could be truncated or
-migrated out from under us, while we're trying to mlock it.  To detect this,
-populate_vma_page_range() checks page_mapping() after acquiring the page lock.
-If the page is still associated with its mapping, we'll go ahead and call
-mlock_vma_page().  If the mapping is gone, we just unlock the page and move on.
-In the worst case, this will result in a page mapped in a VM_LOCKED VMA
-remaining on a normal LRU list without being PageMlocked().  Again, vmscan will
-detect and cull such pages.
-
-mlock_vma_page() will call TestSetPageMlocked() for each page returned by
-get_user_pages().  We use TestSetPageMlocked() because the page might already
-be mlocked by another task/VMA and we don't want to do extra work.  We
-especially do not want to count an mlocked page more than once in the
-statistics.  If the page was already mlocked, mlock_vma_page() need do nothing
-more.
-
-If the page was NOT already mlocked, mlock_vma_page() attempts to isolate the
-page from the LRU, as it is likely on the appropriate active or inactive list
-at that time.  If the isolate_lru_page() succeeds, mlock_vma_page() will put
-back the page - by calling putback_lru_page() - which will notice that the page
-is now mlocked and divert the page to the node's unevictable list.  If
-mlock_vma_page() is unable to isolate the page from the LRU, vmscan will handle
-it later if and when it attempts to reclaim the page.
+For each PTE (or PMD) being faulted into a VMA, the page add rmap function
+calls mlock_vma_page(), which calls mlock_page() when the VMA is VM_LOCKED
+(unless it is a PTE mapping of a part of a transparent huge page).  Or when
+it is a newly allocated anonymous page, lru_cache_add_inactive_or_unevictable()
+calls mlock_new_page() instead: similar to mlock_page(), but can make better
+judgments, since this page is held exclusively and known not to be on LRU yet.
+
+mlock_page() sets PageMlocked immediately, then places the page on the CPU's
+mlock pagevec, to batch up the rest of the work to be done under lru_lock by
+__mlock_page().  __mlock_page() sets PageUnevictable, initializes mlock_count
+and moves the page to unevictable state ("the unevictable LRU", but with
+mlock_count in place of LRU threading).  Or if the page was already PageLRU
+and PageUnevictable and PageMlocked, it simply increments the mlock_count.
+
+But in practice that may not work ideally: the page may not yet be on an LRU, or
+it may have been temporarily isolated from LRU.  In such cases the mlock_count
+field cannot be touched, but will be set to 0 later when __pagevec_lru_add_fn()
+returns the page to "LRU".  Races prohibit mlock_count from being set to 1 then:
+rather than risk stranding a page indefinitely as unevictable, always err with
+mlock_count on the low side, so that when munlocked the page will be rescued to
+an evictable LRU, then perhaps be mlocked again later if vmscan finds it in a
+VM_LOCKED VMA.
 
 
 Filtering Special VMAs
@@ -339,68 +343,48 @@ mlock_fixup() filters several classes of
    so there is no sense in attempting to visit them.
 
 2) VMAs mapping hugetlbfs page are already effectively pinned into memory.  We
-   neither need nor want to mlock() these pages.  However, to preserve the
-   prior behavior of mlock() - before the unevictable/mlock changes -
-   mlock_fixup() will call make_pages_present() in the hugetlbfs VMA range to
-   allocate the huge pages and populate the ptes.
+   neither need nor want to mlock() these pages.  But __mm_populate() includes
+   hugetlbfs ranges, allocating the huge pages and populating the PTEs.
 
 3) VMAs with VM_DONTEXPAND are generally userspace mappings of kernel pages,
-   such as the VDSO page, relay channel pages, etc. These pages
-   are inherently unevictable and are not managed on the LRU lists.
-   mlock_fixup() treats these VMAs the same as hugetlbfs VMAs.  It calls
-   make_pages_present() to populate the ptes.
+   such as the VDSO page, relay channel pages, etc.  These pages are inherently
+   unevictable and are not managed on the LRU lists.  __mm_populate() includes
+   these ranges, populating the PTEs if not already populated.
+
+4) VMAs with VM_MIXEDMAP set are not marked VM_LOCKED, but __mm_populate()
+   includes these ranges, populating the PTEs if not already populated.
 
 Note that for all of these special VMAs, mlock_fixup() does not set the
 VM_LOCKED flag.  Therefore, we won't have to deal with them later during
 munlock(), munmap() or task exit.  Neither does mlock_fixup() account these
 VMAs against the task's "locked_vm".
 
-.. _munlock_munlockall_handling:
 
 munlock()/munlockall() System Call Handling
 -------------------------------------------
 
-The munlock() and munlockall() system calls are handled by the same functions -
-do_mlock[all]() - as the mlock() and mlockall() system calls with the unlock vs
-lock operation indicated by an argument.  So, these system calls are also
-handled by mlock_fixup().  Again, if called for an already munlocked VMA,
-mlock_fixup() simply returns.  Because of the VMA filtering discussed above,
-VM_LOCKED will not be set in any "special" VMAs.  So, these VMAs will be
-ignored for munlock.
+The munlock() and munlockall() system calls are handled by the same
+mlock_fixup() function as mlock(), mlock2() and mlockall() system calls are.
+If called to munlock an already munlocked VMA, mlock_fixup() simply returns.
+Because of the VMA filtering discussed above, VM_LOCKED will not be set in
+any "special" VMAs.  So, those VMAs will be ignored for munlock.
 
 If the VMA is VM_LOCKED, mlock_fixup() again attempts to merge or split off the
-specified range.  The range is then munlocked via the function
-populate_vma_page_range() - the same function used to mlock a VMA range -
-passing a flag to indicate that munlock() is being performed.
-
-Because the VMA access protections could have been changed to PROT_NONE after
-faulting in and mlocking pages, get_user_pages() was unreliable for visiting
-these pages for munlocking.  Because we don't want to leave pages mlocked,
-get_user_pages() was enhanced to accept a flag to ignore the permissions when
-fetching the pages - all of which should be resident as a result of previous
-mlocking.
-
-For munlock(), populate_vma_page_range() unlocks individual pages by calling
-munlock_vma_page().  munlock_vma_page() unconditionally clears the PG_mlocked
-flag using TestClearPageMlocked().  As with mlock_vma_page(),
-munlock_vma_page() use the Test*PageMlocked() function to handle the case where
-the page might have already been unlocked by another task.  If the page was
-mlocked, munlock_vma_page() updates that zone statistics for the number of
-mlocked pages.  Note, however, that at this point we haven't checked whether
-the page is mapped by other VM_LOCKED VMAs.
-
-We can't call page_mlock(), the function that walks the reverse map to
-check for other VM_LOCKED VMAs, without first isolating the page from the LRU.
-page_mlock() is a variant of try_to_unmap() and thus requires that the page
-not be on an LRU list [more on these below].  However, the call to
-isolate_lru_page() could fail, in which case we can't call page_mlock().  So,
-we go ahead and clear PG_mlocked up front, as this might be the only chance we
-have.  If we can successfully isolate the page, we go ahead and call
-page_mlock(), which will restore the PG_mlocked flag and update the zone
-page statistics if it finds another VMA holding the page mlocked.  If we fail
-to isolate the page, we'll have left a potentially mlocked page on the LRU.
-This is fine, because we'll catch it later if and if vmscan tries to reclaim
-the page.  This should be relatively rare.
+specified range.  All pages in the VMA are then munlocked by munlock_page() via
+mlock_pte_range() via walk_page_range() via mlock_vma_pages_range() - the same
+function used when mlocking a VMA range, with new flags for the VMA indicating
+that it is munlock() being performed.
+
+munlock_page() uses the mlock pagevec to batch up work to be done under
+lru_lock by  __munlock_page().  __munlock_page() decrements the page's
+mlock_count, and when that reaches 0 it clears PageMlocked and clears
+PageUnevictable, moving the page from unevictable state to inactive LRU.
+
+But in practice that may not work ideally: the page may not yet have reached
+"the unevictable LRU", or it may have been temporarily isolated from it.  In
+those cases its mlock_count field is unusable and must be assumed to be 0: so
+that the page will be rescued to an evictable LRU, then perhaps be mlocked
+again later if vmscan finds it in a VM_LOCKED VMA.
 
 
 Migrating MLOCKED Pages
@@ -410,33 +394,38 @@ A page that is being migrated has been i
 locked across unmapping of the page, updating the page's address space entry
 and copying the contents and state, until the page table entry has been
 replaced with an entry that refers to the new page.  Linux supports migration
-of mlocked pages and other unevictable pages.  This involves simply moving the
-PG_mlocked and PG_unevictable states from the old page to the new page.
+of mlocked pages and other unevictable pages.  PG_mlocked is cleared from the
+the old page when it is unmapped from the last VM_LOCKED VMA, and set when the
+new page is mapped in place of migration entry in a VM_LOCKED VMA.  If the page
+was unevictable because mlocked, PG_unevictable follows PG_mlocked; but if the
+page was unevictable for other reasons, PG_unevictable is copied explicitly.
 
 Note that page migration can race with mlocking or munlocking of the same page.
-This has been discussed from the mlock/munlock perspective in the respective
-sections above.  Both processes (migration and m[un]locking) hold the page
-locked.  This provides the first level of synchronization.  Page migration
-zeros out the page_mapping of the old page before unlocking it, so m[un]lock
-can skip these pages by testing the page mapping under page lock.
-
-To complete page migration, we place the new and old pages back onto the LRU
-after dropping the page lock.  The "unneeded" page - old page on success, new
-page on failure - will be freed when the reference count held by the migration
-process is released.  To ensure that we don't strand pages on the unevictable
-list because of a race between munlock and migration, page migration uses the
-putback_lru_page() function to add migrated pages back to the LRU.
+There is mostly no problem since page migration requires unmapping all PTEs of
+the old page (including munlock where VM_LOCKED), then mapping in the new page
+(including mlock where VM_LOCKED).  The page table locks provide sufficient
+synchronization.
+
+However, since mlock_vma_pages_range() starts by setting VM_LOCKED on a VMA,
+before mlocking any pages already present, if one of those pages were migrated
+before mlock_pte_range() reached it, it would get counted twice in mlock_count.
+To prevent that, mlock_vma_pages_range() temporarily marks the VMA as VM_IO,
+so that mlock_vma_page() will skip it.
+
+To complete page migration, we place the old and new pages back onto the LRU
+afterwards.  The "unneeded" page - old page on success, new page on failure -
+is freed when the reference count held by the migration process is released.
 
 
 Compacting MLOCKED Pages
 ------------------------
 
-The unevictable LRU can be scanned for compactable regions and the default
-behavior is to do so.  /proc/sys/vm/compact_unevictable_allowed controls
-this behavior (see Documentation/admin-guide/sysctl/vm.rst).  Once scanning of the
-unevictable LRU is enabled, the work of compaction is mostly handled by
-the page migration code and the same work flow as described in MIGRATING
-MLOCKED PAGES will apply.
+The memory map can be scanned for compactable regions and the default behavior
+is to let unevictable pages be moved.  /proc/sys/vm/compact_unevictable_allowed
+controls this behavior (see Documentation/admin-guide/sysctl/vm.rst).  The work
+of compaction is mostly handled by the page migration code and the same work
+flow as described in Migrating MLOCKED Pages will apply.
+
 
 MLOCKING Transparent Huge Pages
 -------------------------------
@@ -445,51 +434,44 @@ A transparent huge page is represented b
 Therefore, we can only make unevictable an entire compound page, not
 individual subpages.
 
-If a user tries to mlock() part of a huge page, we want the rest of the
-page to be reclaimable.
+If a user tries to mlock() part of a huge page, and no user mlock()s the
+whole of the huge page, we want the rest of the page to be reclaimable.
 
 We cannot just split the page on partial mlock() as split_huge_page() can
-fail and new intermittent failure mode for the syscall is undesirable.
+fail and a new intermittent failure mode for the syscall is undesirable.
 
-We handle this by keeping PTE-mapped huge pages on normal LRU lists: the
-PMD on border of VM_LOCKED VMA will be split into PTE table.
+We handle this by keeping PTE-mlocked huge pages on evictable LRU lists:
+the PMD on the border of a VM_LOCKED VMA will be split into a PTE table.
 
-This way the huge page is accessible for vmscan. Under memory pressure the
+This way the huge page is accessible for vmscan.  Under memory pressure the
 page will be split, subpages which belong to VM_LOCKED VMAs will be moved
-to unevictable LRU and the rest can be reclaimed.
+to the unevictable LRU and the rest can be reclaimed.
+
+/proc/meminfo's Unevictable and Mlocked amounts do not include those parts
+of a transparent huge page which are mapped only by PTEs in VM_LOCKED VMAs.
 
-See also comment in follow_trans_huge_pmd().
 
 mmap(MAP_LOCKED) System Call Handling
 -------------------------------------
 
-In addition the mlock()/mlockall() system calls, an application can request
-that a region of memory be mlocked supplying the MAP_LOCKED flag to the mmap()
-call. There is one important and subtle difference here, though. mmap() + mlock()
-will fail if the range cannot be faulted in (e.g. because mm_populate fails)
-and returns with ENOMEM while mmap(MAP_LOCKED) will not fail. The mmaped
-area will still have properties of the locked area - aka. pages will not get
-swapped out - but major page faults to fault memory in might still happen.
+In addition to the mlock(), mlock2() and mlockall() system calls, an application
+can request that a region of memory be mlocked by supplying the MAP_LOCKED flag
+to the mmap() call.  There is one important and subtle difference here, though.
+mmap() + mlock() will fail if the range cannot be faulted in (e.g. because
+mm_populate fails) and returns with ENOMEM while mmap(MAP_LOCKED) will not fail.
+The mmaped area will still have properties of the locked area - pages will not
+get swapped out - but major page faults to fault memory in might still happen.
 
-Furthermore, any mmap() call or brk() call that expands the heap by a
-task that has previously called mlockall() with the MCL_FUTURE flag will result
+Furthermore, any mmap() call or brk() call that expands the heap by a task
+that has previously called mlockall() with the MCL_FUTURE flag will result
 in the newly mapped memory being mlocked.  Before the unevictable/mlock
-changes, the kernel simply called make_pages_present() to allocate pages and
-populate the page table.
+changes, the kernel simply called make_pages_present() to allocate pages
+and populate the page table.
 
-To mlock a range of memory under the unevictable/mlock infrastructure, the
-mmap() handler and task address space expansion functions call
+To mlock a range of memory under the unevictable/mlock infrastructure,
+the mmap() handler and task address space expansion functions call
 populate_vma_page_range() specifying the vma and the address range to mlock.
 
-The callers of populate_vma_page_range() will have already added the memory range
-to be mlocked to the task's "locked_vm".  To account for filtered VMAs,
-populate_vma_page_range() returns the number of pages NOT mlocked.  All of the
-callers then subtract a non-negative return value from the task's locked_vm.  A
-negative return value represent an error - for example, from get_user_pages()
-attempting to fault in a VMA with PROT_NONE access.  In this case, we leave the
-memory range accounted as locked_vm, as the protections could be changed later
-and pages allocated into that region.
-
 
 munmap()/exit()/exec() System Call Handling
 -------------------------------------------
@@ -500,81 +482,53 @@ munlock the pages if we're removing the
 Before the unevictable/mlock changes, mlocking did not mark the pages in any
 way, so unmapping them required no processing.
 
-To munlock a range of memory under the unevictable/mlock infrastructure, the
-munmap() handler and task address space call tear down function
-munlock_vma_pages_all().  The name reflects the observation that one always
-specifies the entire VMA range when munlock()ing during unmap of a region.
-Because of the VMA filtering when mlocking() regions, only "normal" VMAs that
-actually contain mlocked pages will be passed to munlock_vma_pages_all().
-
-munlock_vma_pages_all() clears the VM_LOCKED VMA flag and, like mlock_fixup()
-for the munlock case, calls __munlock_vma_pages_range() to walk the page table
-for the VMA's memory range and munlock_vma_page() each resident page mapped by
-the VMA.  This effectively munlocks the page, only if this is the last
-VM_LOCKED VMA that maps the page.
-
-
-try_to_unmap()
---------------
-
-Pages can, of course, be mapped into multiple VMAs.  Some of these VMAs may
-have VM_LOCKED flag set.  It is possible for a page mapped into one or more
-VM_LOCKED VMAs not to have the PG_mlocked flag set and therefore reside on one
-of the active or inactive LRU lists.  This could happen if, for example, a task
-in the process of munlocking the page could not isolate the page from the LRU.
-As a result, vmscan/shrink_page_list() might encounter such a page as described
-in section "vmscan's handling of unevictable pages".  To handle this situation,
-try_to_unmap() checks for VM_LOCKED VMAs while it is walking a page's reverse
-map.
-
-try_to_unmap() is always called, by either vmscan for reclaim or for page
-migration, with the argument page locked and isolated from the LRU.  Separate
-functions handle anonymous and mapped file and KSM pages, as these types of
-pages have different reverse map lookup mechanisms, with different locking.
-In each case, whether rmap_walk_anon() or rmap_walk_file() or rmap_walk_ksm(),
-it will call try_to_unmap_one() for every VMA which might contain the page.
-
-When trying to reclaim, if try_to_unmap_one() finds the page in a VM_LOCKED
-VMA, it will then mlock the page via mlock_vma_page() instead of unmapping it,
-and return SWAP_MLOCK to indicate that the page is unevictable: and the scan
-stops there.
-
-mlock_vma_page() is called while holding the page table's lock (in addition
-to the page lock, and the rmap lock): to serialize against concurrent mlock or
-munlock or munmap system calls, mm teardown (munlock_vma_pages_all), reclaim,
-holepunching, and truncation of file pages and their anonymous COWed pages.
-
-
-page_mlock() Reverse Map Scan
----------------------------------
-
-When munlock_vma_page() [see section :ref:`munlock()/munlockall() System Call
-Handling <munlock_munlockall_handling>` above] tries to munlock a
-page, it needs to determine whether or not the page is mapped by any
-VM_LOCKED VMA without actually attempting to unmap all PTEs from the
-page.  For this purpose, the unevictable/mlock infrastructure
-introduced a variant of try_to_unmap() called page_mlock().
-
-page_mlock() walks the respective reverse maps looking for VM_LOCKED VMAs. When
-such a VMA is found the page is mlocked via mlock_vma_page(). This undoes the
-pre-clearing of the page's PG_mlocked done by munlock_vma_page.
-
-Note that page_mlock()'s reverse map walk must visit every VMA in a page's
-reverse map to determine that a page is NOT mapped into any VM_LOCKED VMA.
-However, the scan can terminate when it encounters a VM_LOCKED VMA.
-Although page_mlock() might be called a great many times when munlocking a
-large region or tearing down a large address space that has been mlocked via
-mlockall(), overall this is a fairly rare event.
+For each PTE (or PMD) being unmapped from a VMA, page_remove_rmap() calls
+munlock_vma_page(), which calls munlock_page() when the VMA is VM_LOCKED
+(unless it was a PTE mapping of a part of a transparent huge page).
+
+munlock_page() uses the mlock pagevec to batch up work to be done under
+lru_lock by  __munlock_page().  __munlock_page() decrements the page's
+mlock_count, and when that reaches 0 it clears PageMlocked and clears
+PageUnevictable, moving the page from unevictable state to inactive LRU.
+
+But in practice that may not work ideally: the page may not yet have reached
+"the unevictable LRU", or it may have been temporarily isolated from it.  In
+those cases its mlock_count field is unusable and must be assumed to be 0: so
+that the page will be rescued to an evictable LRU, then perhaps be mlocked
+again later if vmscan finds it in a VM_LOCKED VMA.
+
+
+Truncating MLOCKED Pages
+------------------------
+
+File truncation or hole punching forcibly unmaps the deleted pages from
+userspace; truncation even unmaps and deletes any private anonymous pages
+which had been Copied-On-Write from the file pages now being truncated.
+
+Mlocked pages can be munlocked and deleted in this way: like with munmap(),
+for each PTE (or PMD) being unmapped from a VMA, page_remove_rmap() calls
+munlock_vma_page(), which calls munlock_page() when the VMA is VM_LOCKED
+(unless it was a PTE mapping of a part of a transparent huge page).
+
+However, if there is a racing munlock(), since mlock_vma_pages_range() starts
+munlocking by clearing VM_LOCKED from a VMA, before munlocking all the pages
+present, if one of those pages were unmapped by truncation or hole punch before
+mlock_pte_range() reached it, it would not be recognized as mlocked by this VMA,
+and would not be counted out of mlock_count.  In this rare case, a page may
+still appear as PageMlocked after it has been fully unmapped: and it is left to
+release_pages() (or __page_cache_release()) to clear it and update statistics
+before freeing (this event is counted in /proc/vmstat unevictable_pgs_cleared,
+which is usually 0).
 
 
 Page Reclaim in shrink_*_list()
 -------------------------------
 
-shrink_active_list() culls any obviously unevictable pages - i.e.
-!page_evictable(page) - diverting these to the unevictable list.
+vmscan's shrink_active_list() culls any obviously unevictable pages -
+i.e. !page_evictable(page) pages - diverting those to the unevictable list.
 However, shrink_active_list() only sees unevictable pages that made it onto the
-active/inactive lru lists.  Note that these pages do not have PageUnevictable
-set - otherwise they would be on the unevictable list and shrink_active_list
+active/inactive LRU lists.  Note that these pages do not have PageUnevictable
+set - otherwise they would be on the unevictable list and shrink_active_list()
 would never see them.
 
 Some examples of these unevictable pages on the LRU lists are:
@@ -586,20 +540,15 @@ Some examples of these unevictable pages
      when an application accesses the page the first time after SHM_LOCK'ing
      the segment.
 
- (3) mlocked pages that could not be isolated from the LRU and moved to the
-     unevictable list in mlock_vma_page().
-
-shrink_inactive_list() also diverts any unevictable pages that it finds on the
-inactive lists to the appropriate node's unevictable list.
+ (3) pages still mapped into VM_LOCKED VMAs, which should be marked mlocked,
+     but events left mlock_count too low, so they were munlocked too early.
 
-shrink_inactive_list() should only see SHM_LOCK'd pages that became SHM_LOCK'd
-after shrink_active_list() had moved them to the inactive list, or pages mapped
-into VM_LOCKED VMAs that munlock_vma_page() couldn't isolate from the LRU to
-recheck via page_mlock().  shrink_inactive_list() won't notice the latter,
-but will pass on to shrink_page_list().
-
-shrink_page_list() again culls obviously unevictable pages that it could
-encounter for similar reason to shrink_inactive_list().  Pages mapped into
-VM_LOCKED VMAs but without PG_mlocked set will make it all the way to
-try_to_unmap().  shrink_page_list() will divert them to the unevictable list
-when try_to_unmap() returns SWAP_MLOCK, as discussed above.
+vmscan's shrink_inactive_list() and shrink_page_list() also divert obviously
+unevictable pages found on the inactive lists to the appropriate memory cgroup
+and node unevictable list.
+
+rmap's page_referenced_one(), called via vmscan's shrink_active_list() or
+shrink_page_list(), and rmap's try_to_unmap_one() called via shrink_page_list(),
+check for (3) pages still mapped into VM_LOCKED VMAs, and call mlock_vma_page()
+to correct them.  Such pages are culled to the unevictable list when released
+by the shrinker.
