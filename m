Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE024D9D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349096AbiCOOUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349088AbiCOOUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1E3934649
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647353931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+Anhxjy9idb7nh6PrkDUYGwvKF5JZwvP4UAdCW2cc+o=;
        b=WDMSQfdnJ7z/jiWOeJ/ZngcKPLbxgDGklB2XgVWhnRowbIsZgY9ob1lOLHPAsFEisF2DNf
        67ux6dli8tC9dYwd6RiZEvlfmowNYT5f5NMu0GoMJFaL4WbS7BuBsh3SY2BaF/WqKGRb2b
        yshzTpO59znwUbqjjb0D8ULrLdbQSh4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-MkmlApJ_NiuLzpx0zdSZUg-1; Tue, 15 Mar 2022 10:18:50 -0400
X-MC-Unique: MkmlApJ_NiuLzpx0zdSZUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42DA5803D64;
        Tue, 15 Mar 2022 14:18:48 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4D804087D7E;
        Tue, 15 Mar 2022 14:18:38 +0000 (UTC)
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
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 0/7] mm: COW fixes part 3: reliable GUP R/W FOLL_GET of anonymous pages
Date:   Tue, 15 Mar 2022 15:18:30 +0100
Message-Id: <20220315141837.137118-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More information on the general COW issues can be found at [2]. This series
is based on v5.17-rc8, [1]:
	[PATCH v3 0/9] mm: COW fixes part 1: fix the COW security issue for
	THP and swap
and [4]:
	[PATCH v2 00/15] mm: COW fixes part 2: reliable GUP pins of
	anonymous pages

v1 is located at:
	https://github.com/davidhildenbrand/linux/tree/cow_fixes_part_3_v1


This series fixes memory corruptions when a GUP R/W reference
(FOLL_WRITE | FOLL_GET) was taken on an anonymous page and COW logic fails
to detect exclusivity of the page to then replacing the anonymous page by
a copy in the page table: The GUP reference lost synchronicity with the
pages mapped into the page tables. This series focuses on x86, arm64,
s390x and ppc64/book3s -- other architectures are fairly easy to support
by implementing __HAVE_ARCH_PTE_SWP_EXCLUSIVE.

This primarily fixes the O_DIRECT memory corruptions that can happen on
concurrent swapout, whereby we lose DMA reads to a page (modifying the user
page by writing to it).

O_DIRECT currently uses FOLL_GET for short-term (!FOLL_LONGTERM)
DMA from/to a user page. In the long run, we want to convert it to properly
use FOLL_PIN, and John is working on it, but that might take a while and
might not be easy to backport. In the meantime, let's restore what used to
work before we started modifying our COW logic: make R/W FOLL_GET
references reliable as long as there is no fork() after GUP involved.

This is just the natural follow-up of part 2, that will also further
reduce "wrong COW" on the swapin path, for example, when we cannot remove
a page from the swapcache due to concurrent writeback, or if we have two
threads faulting on the same swapped-out page. Fixing O_DIRECT is just a
nice side-product :)

This issue, including other related COW issues, has been summarized in [3]
under 2):
"
  2. Intra Process Memory Corruptions due to Wrong COW (FOLL_GET)

  It was discovered that we can create a memory corruption by reading a
  file via O_DIRECT to a part (e.g., first 512 bytes) of a page,
  concurrently writing to an unrelated part (e.g., last byte) of the same
  page, and concurrently write-protecting the page via clear_refs
  SOFTDIRTY tracking [6].

  For the reproducer, the issue is that O_DIRECT grabs a reference of the
  target page (via FOLL_GET) and clear_refs write-protects the relevant
  page table entry. On successive write access to the page from the
  process itself, we wrongly COW the page when resolving the write fault,
  resulting in a loss of synchronicity and consequently a memory corruption.

  While some people might think that using clear_refs in this combination
  is a corner cases, it turns out to be a more generic problem unfortunately.

  For example, it was just recently discovered that we can similarly
  create a memory corruption without clear_refs, simply by concurrently
  swapping out the buffer pages [7]. Note that we nowadays even use the
  swap infrastructure in Linux without an actual swap disk/partition: the
  prime example is zram which is enabled as default under Fedora [10].

  The root issue is that a write-fault on a page that has additional
  references results in a COW and thereby a loss of synchronicity
  and consequently a memory corruption if two parties believe they are
  referencing the same page.
"

We don't particularly care about R/O FOLL_GET references: they were never
reliable and O_DIRECT doesn't expect to observe modifications from a page
after DMA was started.

Note that:
* this only fixes the issue on x86, arm64, s390x and ppc64/book3s
  ("enterprise architectures"). Other architectures have to implement
  __HAVE_ARCH_PTE_SWP_EXCLUSIVE to achieve the same.
* this does *not * consider any kind of fork() after taking the reference:
  fork() after GUP never worked reliably with FOLL_GET.
* Not losing PG_anon_exclusive during swapout was the last remaining
  piece. KSM already makes sure that there are no other references on
  a page before considering it for sharing. Page migration maintains
  PG_anon_exclusive and simply fails when there are additional references
  (freezing the refcount fails). Only swapout code dropped the
  PG_anon_exclusive flag because it requires more work to remember +
  restore it.

With this series in place, most COW issues of [3] are fixed on said
architectures. Other architectures can implement
__HAVE_ARCH_PTE_SWP_EXCLUSIVE fairly easily.

What remains is the COW security issue on hugetlb with FOLL_GET, and
SOFTDIRTY tracking. I'll tackle both (guess what?) in part 4 once part 2
and part 3 are on its way upstream.

[1] https://lkml.kernel.org/r/20220131162940.210846-1-david@redhat.com
[2] https://lkml.kernel.org/r/20211217113049.23850-1-david@redhat.com
[3] https://lore.kernel.org/r/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com
[4] https://lkml.kernel.org/r/20220315104741.63071-1-david@redhat.com


David Hildenbrand (7):
  mm/swap: remember PG_anon_exclusive via a swp pte bit
  mm/debug_vm_pgtable: add tests for __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  x86/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  arm64/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  s390/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
  powerpc/pgtable: remove _PAGE_BIT_SWAP_TYPE for book3s
  powerpc/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE for book3s

 arch/arm64/include/asm/pgtable-prot.h        |  1 +
 arch/arm64/include/asm/pgtable.h             | 23 ++++++--
 arch/powerpc/include/asm/book3s/64/pgtable.h | 31 ++++++++---
 arch/s390/include/asm/pgtable.h              | 37 ++++++++++---
 arch/x86/include/asm/pgtable.h               | 16 ++++++
 arch/x86/include/asm/pgtable_64.h            |  4 +-
 arch/x86/include/asm/pgtable_types.h         |  5 ++
 include/linux/pgtable.h                      | 29 +++++++++++
 include/linux/swapops.h                      |  2 +
 mm/debug_vm_pgtable.c                        | 15 ++++++
 mm/memory.c                                  | 55 ++++++++++++++++++--
 mm/rmap.c                                    | 19 ++++---
 mm/swapfile.c                                | 13 ++++-
 13 files changed, 219 insertions(+), 31 deletions(-)

-- 
2.35.1

