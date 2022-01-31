Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF004A4C28
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380271AbiAaQbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:31:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232284AbiAaQbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643646674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aJASGnLlD4P/O7grhZnnKufhLjm9HWilfJojgPid8DI=;
        b=B1ovCrPdT6ztbomRbL2dASNQ5TV0cjVI9H67kaklakwr5DFXIvwfUV7HjSPSISsiQrHoSq
        nnTLYMHNRnFR5L72ky8ufyO+VBcr6uytsySZiMGcVgMl9F30hXdBbLJBCvYgdiY8D8T5ui
        209s5nq7mNaq0YjDweiUU6z001/OmS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-IO4wgBw6N4KC7rRwOYMG2Q-1; Mon, 31 Jan 2022 11:31:10 -0500
X-MC-Unique: IO4wgBw6N4KC7rRwOYMG2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B35001091DAC;
        Mon, 31 Jan 2022 16:31:06 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49476798CD;
        Mon, 31 Jan 2022 16:29:41 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v3 0/9] mm: COW fixes part 1: fix the COW security issue for THP and swap
Date:   Mon, 31 Jan 2022 17:29:30 +0100
Message-Id: <20220131162940.210846-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm: COW fixes part 1: fix the COW security issue for THP and swap

This series is the result of the discussion on the previous approach [1].
More information on the general COW issues can be found there.


This series attempts to optimize and streamline the COW logic for ordinary
anon pages and THP anon pages, fixing two remaining instances of
CVE-2020-29374 in do_swap_page() and do_huge_pmd_wp_page(): information can
leak from a parent process to a child process via anonymous pages shared
during fork().

This issue, including other related COW issues, has been summarized in [2]:
"
  1. Observing Memory Modifications of Private Pages From A Child Process

  Long story short: process-private memory might not be as private as you
  think once you fork(): successive modifications of private memory
  regions in the parent process can still be observed by the child
  process, for example, by smart use of vmsplice()+munmap().

  The core problem is that pinning pages readable in a child process, such
  as done via the vmsplice system call, can result in a child process
  observing memory modifications done in the parent process the child is
  not supposed to observe. [1] contains an excellent summary and [2]
  contains further details. This issue was assigned CVE-2020-29374 [9].

  For this to trigger, it's required to use a fork() without subsequent
  exec(), for example, as used under Android zygote. Without further
  details about an application that forks less-privileged child processes,
  one cannot really say what's actually affected and what's not -- see the
  details section the end of this mail for a short sshd/openssh analysis.

  While commit 17839856fd58 ("gup: document and work around "COW can break
  either way" issue") fixed this issue and resulted in other problems
  (e.g., ptrace on pmem), commit 09854ba94c6a ("mm: do_wp_page()
  simplification") re-introduced part of the problem unfortunately.

  The original reproducer can be modified quite easily to use THP [3] and
  make the issue appear again on upstream kernels. I modified it to use
  hugetlb [4] and it triggers as well. The problem is certainly less
  severe with hugetlb than with THP; it merely highlights that we still
  have plenty of open holes we should be closing/fixing.

  Regarding vmsplice(), the only known workaround is to disallow the
  vmsplice() system call ... or disable THP and hugetlb. But who knows
  what else is affected (RDMA? O_DIRECT?) to achieve the same goal -- in
  the end, it's a more generic issue.
"

This security issue was first reported by Jann Horn on 27 May 2020 and it
currently affects anonymous pages during swapin, anonymous THP and hugetlb.
This series tackles anonymous pages during swapin and anonymous THP:
* do_swap_page() for handling COW on PTEs during swapin directly
* do_huge_pmd_wp_page() for handling COW on PMD-mapped THP during write
  faults

With this series, we'll apply the same COW logic we have in do_wp_page()
to all swappable anon pages: don't reuse (map writable) the page in
case there are additional references (page_count() != 1). All users of
reuse_swap_page() are remove, and consequently reuse_swap_page() is
removed.

In general, we're struggling with the following COW-related issues:
(1) "missed COW": we miss to copy on write and reuse the page (map it
    writable) although we must copy because there are pending references
    from another process to this page. The result is a security issue.
(2) "wrong COW": we copy on write although we wouldn't have to and
    shouldn't: if there are valid GUP references, they will become out of
    sync with the pages mapped into the page table. We fail to detect that
    such a page can be reused safely, especially if never more than a
    single process mapped the page. The result is an intra process
    memory corruption.
(3) "unnecessary COW": we copy on write although we wouldn't have to:
    performance degradation and temporary increases swap+memory consumption
    can be the result.

While this series fixes (1) for swappable anon pages, it tries to reduce
reported cases of (3) first as good and easy as possible to limit the
impact when streamlining. The individual patches try to describe in which
cases we will run into (3).

This series certainly makes (2) worse for THP, because a THP will now get
PTE-mapped on write faults if there are additional references, even if
there was only ever a single process involved: once PTE-mapped, we'll copy
each and every subpage and won't reuse any subpage as long as the
underlying compound page wasn't split.

I'm working on an approach to fix (2) and improve (3): PageAnonExclusive to
mark anon pages that are exclusive to a single process, allow GUP pins only
on such exclusive pages, and allow turning exclusive pages shared
(clearing PageAnonExclusive) only if there are no GUP pins. Anon pages with
PageAnonExclusive set never have to be copied during write faults, but
eventually during fork() if they cannot be turned shared. The improved
reuse logic in this series will essentially also be the logic to reset
PageAnonExclusive. This work will certainly take a while, but I'm planning
on sharing details before having code fully ready.


#1-#5 can be applied independently of the rest. #6-#9 are mostly only
cleanups related to reuse_swap_page().


Notes:
* For now, I'll leave hugetlb code untouched: "unnecessary COW" might
  easily break existing setups because hugetlb pages are a scarce resource
  and we could just end up having to crash the application when we run out
  of hugetlb pages. We have to be very careful and the security aspect with
  hugetlb is most certainly less relevant than for unprivileged anon pages.
* Instead of lru_add_drain() we might actually just drain the lru_add list
  or even just remove the single page of interest from the lru_add list.
  This would require a new helper function, and could be added if the
  conditional lru_add_drain() turn out to be a problem.
* I extended the test case already included in [1] to also test for the
  newly found do_swap_page() case. I'll send that out separately once/if
  this part was merged.

[1] https://lkml.kernel.org/r/20211217113049.23850-1-david@redhat.com
[2] https://lore.kernel.org/r/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com


RFC v2 -> v3:
* "mm: optimize do_wp_page() for exclusive pages in the swapcache"
 * Extend patch description
 * Add RB/Ack
* "mm: optimize do_wp_page() for fresh pages in local LRU pagevecs"
 * Simplify first early check, but keep second early check as is
 * Extend patch description to state why
* "mm/huge_memory: streamline COW logic in do_huge_pmd_wp_page()"
 * Remove conditional LRU pagevec draining and simplify
 * Extend patch description + comments
* "mm/khugepaged: remove reuse_swap_page() usage"
 * Remove the special swapcache handling instead
 * Update patch description

David Hildenbrand (9):
  mm: optimize do_wp_page() for exclusive pages in the swapcache
  mm: optimize do_wp_page() for fresh pages in local LRU pagevecs
  mm: slightly clarify KSM logic in do_swap_page()
  mm: streamline COW logic in do_swap_page()
  mm/huge_memory: streamline COW logic in do_huge_pmd_wp_page()
  mm/khugepaged: remove reuse_swap_page() usage
  mm/swapfile: remove stale reuse_swap_page()
  mm/huge_memory: remove stale page_trans_huge_mapcount()
  mm/huge_memory: remove stale locking logic from __split_huge_pmd()

 include/linux/mm.h                 |   5 --
 include/linux/swap.h               |   4 -
 include/trace/events/huge_memory.h |   1 -
 mm/huge_memory.c                   |  93 +++-------------------
 mm/khugepaged.c                    |  11 ---
 mm/memory.c                        | 121 +++++++++++++++++++++--------
 mm/swapfile.c                      | 104 -------------------------
 7 files changed, 98 insertions(+), 241 deletions(-)


base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
2.34.1

