Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C9455A034
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiFXRi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiFXRhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9726362F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r6-20020a5b06c6000000b006693f6a6d67so2759142ybq.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DnSvOCh5sWPJ7lcBADLIxPbYxItP++yx8CJTrhTsmkQ=;
        b=US3MsLbvouGIjHoGSmamHgOBwfVLiqHYYcRvXBkO6HEAmTlF5CdcIRrqyBB5+4Y/DV
         R5ICOEZyQShiEkEjw9K8OxlWQ7I2pDRlr90/Vfu04GIdVuiVQX/VzfipMXKUc0bL1aEa
         TCR4uXZB7kclJoTtfEbTGbDmqCNSbz2QMvIDHzOXNXYuywQu3Jt5n7X+BkFVBu9sQGQH
         qf7yTmkeJo9FYAv+IGlcghgPupGKieeYs5gqVMSXqpXZm+f8BJ0HwTzLUGcqBermMTbW
         c36PY+n2Trkho0VVxb4xR3d/LJtyTy475z4gDUpnvFEDh6r5hNbWx3oK1N8zswbyUhI0
         Z1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DnSvOCh5sWPJ7lcBADLIxPbYxItP++yx8CJTrhTsmkQ=;
        b=AifhVqrYv8ZNaSM5bocGmV/IpvI8lQImHHjbBTxI1IjE12XV3jjxIWWwb4kc/9iOta
         oa6cXwocrdnPcLFlYXXmRBB++WwJCHBSdUi0aGeDIR945LDZHrtOjI4nbG2qMqm4Gmus
         9r6jTidb8U2MoDOBjSEoi3Ror+cR6xmSwCvxVTkEUTDmvwGE5VeXDORj2ul4fNHYphvy
         mUeuTUOlAwpXgoqi+7/MVyCS0iWnm7X0SviMr5QeQTNrlurXfdA4bWsFhgJoE5obB+mH
         V6aWqyqJguKVwXsef5Izy8yuQZz4rn+mFkqQc/eTHyPEt424fHBsWMfyINwu8ap+nfAG
         sGhw==
X-Gm-Message-State: AJIora/Hiv41ZlqgI0s3pTwqCLfsLeyhzG+iwfW73kCYEcrA5TkZtd6f
        BWlLOj+CerZugam2T65GPetzRl7uOEFHVt17
X-Google-Smtp-Source: AGRyM1sxobI/l4pLwInW1LtYNGLaoAuSoGnzo1OK2TOmy0CL3gA7mqZqEuZ+4c429ObGraQpvHH4PWrpOdiqB6vM
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:3414:0:b0:66c:7e27:12ec with SMTP
 id b20-20020a253414000000b0066c7e2712ecmr276068yba.439.1656092230261; Fri, 24
 Jun 2022 10:37:10 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:30 +0000
Message-Id: <20220624173656.2033256-1-jthoughton@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity mapping
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC introduces the concept of HugeTLB high-granularity mapping
(HGM)[1].  In broad terms, this series teaches HugeTLB how to map HugeTLB
pages at different granularities, and, more importantly, to partially map
a HugeTLB page.  This cover letter will go over
 - the motivation for these changes
 - userspace API
 - some of the changes to HugeTLB to make this work
 - limitations & future enhancements

High-granularity mapping does *not* involve dissolving the hugepages
themselves; it only affects how they are mapped.

---- Motivation ----

Being able to map HugeTLB memory with PAGE_SIZE PTEs has important use
cases in post-copy live migration and memory failure handling.

- Live Migration (userfaultfd)
For post-copy live migration, using userfaultfd, currently we have to
install an entire hugepage before we can allow a guest to access that page.
This is because, right now, either the WHOLE hugepage is mapped or NONE of
it is.  So either the guest can access the WHOLE hugepage or NONE of it.
This makes post-copy live migration for 1G HugeTLB-backed VMs completely
infeasible.

With high-granularity mapping, we can map PAGE_SIZE pieces of a hugepage,
thereby allowing the guest to access only PAGE_SIZE chunks, and getting
page faults on the rest (and triggering another demand-fetch). This gives
userspace the flexibility to install PAGE_SIZE chunks of memory into a
hugepage, making migration of 1G-backed VMs perfectly feasible, and it
vastly reduces the vCPU stall time during post-copy for 2M-backed VMs.

At Google, for a 48 vCPU VM in post-copy, we can expect these approximate
per-page median fetch latencies:
     4K: <100us
     2M: >10ms
Being able to unpause a vCPU 100x quicker is helpful for guest stability,
and being able to use 1G pages at all can significant improve steady-state
guest performance.

After fully copying a hugepage over the network, we will want to collapse
the mapping down to what it would normally be (e.g., one PUD for a 1G
page). Rather than having the kernel do this automatically, we leave it up
to userspace to tell us to collapse a range (via MADV_COLLAPSE, co-opting
the API that is being introduced for THPs[2]).

- Memory Failure
When a memory error is found within a HugeTLB page, it would be ideal if we
could unmap only the PAGE_SIZE section that contained the error. This is
what THPs are able to do. Using high-granularity mapping, we could do this,
but this isn't tackled in this patch series.

---- Userspace API ----

This patch series introduces a single way to take advantage of
high-granularity mapping: via UFFDIO_CONTINUE. UFFDIO_CONTINUE allows
userspace to resolve MINOR page faults on shared VMAs.

To collapse a HugeTLB address range that has been mapped with several
UFFDIO_CONTINUE operations, userspace can issue MADV_COLLAPSE. We expect
userspace to know when all pages (that they care about) have been fetched.

---- HugeTLB Changes ----

- Mapcount
The way mapcount is handled is different from the way that it was handled
before. If the PUD for a hugepage is not none, a hugepage's mapcount will
be increased. This scheme means that, for hugepages that aren't mapped at
high granularity, their mapcounts will remain the same as what they would
have been pre-HGM.

- Page table walking and manipulation
A new function, hugetlb_walk_to, handles walking HugeTLB page tables for
high-granularity mappings. Eventually, it's possible to merge
hugetlb_walk_to with huge_pte_offset and huge_pte_alloc.

We keep track of HugeTLB page table entries with a new struct, hugetlb_pte.
This is because we generally need to know the "size" of a PTE (previously
always just huge_page_size(hstate)).

For every page table manipulation function that has a huge version (e.g.
huge_ptep_get and ptep_get), there is a wrapper for it (e.g.
hugetlb_ptep_get).  The correct version is used depending on if a HugeTLB
PTE really is "huge".

- Synchronization
For existing bits of HugeTLB, synchronization is unchanged. For splitting
and collapsing HugeTLB PTEs, we require that the i_mmap_rw_sem is held for
writing, and for doing high-granularity page table walks, we require it to
be held for reading.

---- Limitations & Future Changes ----

This patch series only implements high-granularity mapping for VM_SHARED
VMAs.  I intend to implement enough HGM to support 4K unmapping for memory
failure recovery for both shared and private mappings.

The memory failure use case poses its own challenges that can be
addressed, but I will do so in a separate RFC.

Performance has not been heavily scrutinized with this patch series. There
are places where lock contention can significantly reduce performance. This
will be addressed later.

The patch series, as it stands right now, is compatible with the VMEMMAP
page struct optimization[3], as we do not need to modify data contained
in the subpage page structs.

Other omissions:
 - Compatibility with userfaultfd write-protect (will be included in v1).
 - Support for mremap() (will be included in v1). This looks a lot like
   the support we have for fork().
 - Documentation changes (will be included in v1).
 - Completely ignores PMD sharing and hugepage migration (will be included
   in v1).
 - Implementations for architectures that don't use GENERAL_HUGETLB other
   than arm64.

---- Patch Breakdown ----

Patch 1     - Preliminary changes
Patch 2-10  - HugeTLB HGM core changes
Patch 11-13 - HugeTLB HGM page table walking functionality
Patch 14-19 - HugeTLB HGM compatibility with other bits
Patch 20-23 - Userfaultfd and collapse changes
Patch 24-26 - arm64 support and selftests

[1] This used to be called HugeTLB double mapping, a bad and confusing
    name. "High-granularity mapping" is not a great name either. I am open
    to better names.
[2] https://lore.kernel.org/linux-mm/20220604004004.954674-10-zokeefe@google.com/
[3] commit f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")

James Houghton (26):
  hugetlb: make hstate accessor functions const
  hugetlb: sort hstates in hugetlb_init_hstates
  hugetlb: add make_huge_pte_with_shift
  hugetlb: make huge_pte_lockptr take an explicit shift argument.
  hugetlb: add CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
  mm: make free_p?d_range functions public
  hugetlb: add hugetlb_pte to track HugeTLB page table entries
  hugetlb: add hugetlb_free_range to free PT structures
  hugetlb: add hugetlb_hgm_enabled
  hugetlb: add for_each_hgm_shift
  hugetlb: add hugetlb_walk_to to do PT walks
  hugetlb: add HugeTLB splitting functionality
  hugetlb: add huge_pte_alloc_high_granularity
  hugetlb: add HGM support for hugetlb_fault and hugetlb_no_page
  hugetlb: make unmapping compatible with high-granularity mappings
  hugetlb: make hugetlb_change_protection compatible with HGM
  hugetlb: update follow_hugetlb_page to support HGM
  hugetlb: use struct hugetlb_pte for walk_hugetlb_range
  hugetlb: add HGM support for copy_hugetlb_page_range
  hugetlb: add support for high-granularity UFFDIO_CONTINUE
  hugetlb: add hugetlb_collapse
  madvise: add uapi for HugeTLB HGM collapse: MADV_COLLAPSE
  userfaultfd: add UFFD_FEATURE_MINOR_HUGETLBFS_HGM
  arm64/hugetlb: add support for high-granularity mappings
  selftests: add HugeTLB HGM to userfaultfd selftest
  selftests: add HugeTLB HGM to KVM demand paging selftest

 arch/arm64/Kconfig                            |   1 +
 arch/arm64/mm/hugetlbpage.c                   |  63 ++
 arch/powerpc/mm/pgtable.c                     |   3 +-
 arch/s390/mm/gmap.c                           |   8 +-
 fs/Kconfig                                    |   7 +
 fs/proc/task_mmu.c                            |  35 +-
 fs/userfaultfd.c                              |  10 +-
 include/asm-generic/tlb.h                     |   6 +-
 include/linux/hugetlb.h                       | 177 +++-
 include/linux/mm.h                            |   7 +
 include/linux/pagewalk.h                      |   3 +-
 include/uapi/asm-generic/mman-common.h        |   2 +
 include/uapi/linux/userfaultfd.h              |   2 +
 mm/damon/vaddr.c                              |  34 +-
 mm/hmm.c                                      |   7 +-
 mm/hugetlb.c                                  | 987 +++++++++++++++---
 mm/madvise.c                                  |  23 +
 mm/memory.c                                   |   8 +-
 mm/mempolicy.c                                |  11 +-
 mm/migrate.c                                  |   3 +-
 mm/mincore.c                                  |   4 +-
 mm/mprotect.c                                 |   6 +-
 mm/page_vma_mapped.c                          |   3 +-
 mm/pagewalk.c                                 |  18 +-
 mm/userfaultfd.c                              |  57 +-
 .../testing/selftests/kvm/include/test_util.h |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   2 +-
 tools/testing/selftests/kvm/lib/test_util.c   |  14 +
 tools/testing/selftests/vm/userfaultfd.c      |  61 +-
 29 files changed, 1314 insertions(+), 250 deletions(-)

-- 
2.37.0.rc0.161.g10f37bed90-goog

