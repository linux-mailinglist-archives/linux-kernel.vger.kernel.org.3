Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA24E55A116
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiFXSlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiFXSlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:41:17 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161597E03A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:41:16 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id k25so3105370vso.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4+jlKA2MuKfsqlQKQKRe/HqT1miRmg69fLPyVUKNjQ=;
        b=sxIcJSo63iX/SUVe7VfaQTahrlYlzTbAqhphyNGj0SW7URdt4yFUBgZ3H/7DdTDtdJ
         jERetC1D7ido45YuTMmqALusV1vuqlW/+4ahHlPrtQZDExVxvlql3uXoDA0z7RQrG3hU
         7bOtosRuG3wuj6utg3QdICOx4noPHXnSyFpWtrYtr0GTlSlk3+gs7bAFkenDk+0WiHSz
         xeM1mFJp70kd2OQNuXqwf2mNg2mER4sOK/n30s4RHG/6d7q8AhosdtPKmRNky0Oo50tc
         uayr0eDY1/S4asl0jq7HGQIcaJ/Pe6BkFqrajWJ33Qv9kXgkmIO2bXCk8F1BcassR6e5
         F+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4+jlKA2MuKfsqlQKQKRe/HqT1miRmg69fLPyVUKNjQ=;
        b=K4jl6zBkFtvx6DZbFKQq5U836PD18zgGxQBikRPIa4wLnakXPvKOYKS3ywwH3oQJuv
         mt/isfatNYnr2F0NYXHOOW4wzCGkwsARKmWb3L6JDWG1WGcj6hH/ecRgTEkllnMISh4Q
         tCUkAOBY0B1Mj/lgyG7/kBBF2MG7qdO27i4JJwHhUqwA1ywKRrKnKPoIjZ6tLGOvAbQ1
         YB2T8o2/fsvgYHTGpLsyX4A3HYQcR7TcjREWuzktEtOcBS9DTVZPTxS4ZlbAjUA/QQwd
         kXbFYNI7//mUMwLMHgcc9hKUNq1Ic3kYpFNNPwdOkjrMy2MdB7anMofGqKyxWNRDx8S1
         7LdQ==
X-Gm-Message-State: AJIora+fxzOWx+vaVTsXH4dRCnZPNPn4ztztDfGENjc8/QWcAQ/H9OaF
        u3CBMVGESiYSulQCVeTE4hQOhOqEJMsmT8eUoPIKcA==
X-Google-Smtp-Source: AGRyM1tpbBpZdu8urdU2pKi1QbESSp0kafQg59HKzIsbrmnN65/hgao4dXfEylcaaE1oyNBDFWU75sNC8P+NMaJwQDU=
X-Received: by 2002:a05:6102:101:b0:354:355b:711b with SMTP id
 z1-20020a056102010100b00354355b711bmr329617vsq.61.1656096074970; Fri, 24 Jun
 2022 11:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 24 Jun 2022 11:41:03 -0700
Message-ID: <CAHS8izPnJd5EQjUi9cOk=03u3X1rk0PexTQZi+bEE4VMtFfksQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/26] hugetlb: Introduce HugeTLB high-granularity mapping
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Jun 24, 2022 at 10:37 AM James Houghton <jthoughton@google.com> wrote:
>
> This RFC introduces the concept of HugeTLB high-granularity mapping
> (HGM)[1].  In broad terms, this series teaches HugeTLB how to map HugeTLB
> pages at different granularities, and, more importantly, to partially map
> a HugeTLB page.  This cover letter will go over
>  - the motivation for these changes
>  - userspace API
>  - some of the changes to HugeTLB to make this work
>  - limitations & future enhancements
>
> High-granularity mapping does *not* involve dissolving the hugepages
> themselves; it only affects how they are mapped.
>
> ---- Motivation ----
>
> Being able to map HugeTLB memory with PAGE_SIZE PTEs has important use
> cases in post-copy live migration and memory failure handling.
>
> - Live Migration (userfaultfd)
> For post-copy live migration, using userfaultfd, currently we have to
> install an entire hugepage before we can allow a guest to access that page.
> This is because, right now, either the WHOLE hugepage is mapped or NONE of
> it is.  So either the guest can access the WHOLE hugepage or NONE of it.
> This makes post-copy live migration for 1G HugeTLB-backed VMs completely
> infeasible.
>
> With high-granularity mapping, we can map PAGE_SIZE pieces of a hugepage,
> thereby allowing the guest to access only PAGE_SIZE chunks, and getting
> page faults on the rest (and triggering another demand-fetch). This gives
> userspace the flexibility to install PAGE_SIZE chunks of memory into a
> hugepage, making migration of 1G-backed VMs perfectly feasible, and it
> vastly reduces the vCPU stall time during post-copy for 2M-backed VMs.
>
> At Google, for a 48 vCPU VM in post-copy, we can expect these approximate
> per-page median fetch latencies:
>      4K: <100us
>      2M: >10ms
> Being able to unpause a vCPU 100x quicker is helpful for guest stability,
> and being able to use 1G pages at all can significant improve steady-state
> guest performance.
>
> After fully copying a hugepage over the network, we will want to collapse
> the mapping down to what it would normally be (e.g., one PUD for a 1G
> page). Rather than having the kernel do this automatically, we leave it up
> to userspace to tell us to collapse a range (via MADV_COLLAPSE, co-opting
> the API that is being introduced for THPs[2]).
>
> - Memory Failure
> When a memory error is found within a HugeTLB page, it would be ideal if we
> could unmap only the PAGE_SIZE section that contained the error. This is
> what THPs are able to do. Using high-granularity mapping, we could do this,
> but this isn't tackled in this patch series.
>
> ---- Userspace API ----
>
> This patch series introduces a single way to take advantage of
> high-granularity mapping: via UFFDIO_CONTINUE. UFFDIO_CONTINUE allows
> userspace to resolve MINOR page faults on shared VMAs.
>
> To collapse a HugeTLB address range that has been mapped with several
> UFFDIO_CONTINUE operations, userspace can issue MADV_COLLAPSE. We expect
> userspace to know when all pages (that they care about) have been fetched.
>

Thanks James! Cover letter looks good. A few questions:

Why not have the kernel collapse the hugepage once all the 4K pages
have been fetched automatically? It would remove the need for a new
userspace API, and AFACT there aren't really any cases where it is
beneficial to have a hugepage sharded into 4K mappings when those
mappings can be collapsed.

> ---- HugeTLB Changes ----
>
> - Mapcount
> The way mapcount is handled is different from the way that it was handled
> before. If the PUD for a hugepage is not none, a hugepage's mapcount will
> be increased. This scheme means that, for hugepages that aren't mapped at
> high granularity, their mapcounts will remain the same as what they would
> have been pre-HGM.
>

Sorry, I didn't quite follow this. It says mapcount is handled
differently, but the same if the page is not mapped at high
granularity. Can you elaborate on how the mapcount handling will be
different when the page is mapped at high granularity?

> - Page table walking and manipulation
> A new function, hugetlb_walk_to, handles walking HugeTLB page tables for
> high-granularity mappings. Eventually, it's possible to merge
> hugetlb_walk_to with huge_pte_offset and huge_pte_alloc.
>
> We keep track of HugeTLB page table entries with a new struct, hugetlb_pte.
> This is because we generally need to know the "size" of a PTE (previously
> always just huge_page_size(hstate)).
>
> For every page table manipulation function that has a huge version (e.g.
> huge_ptep_get and ptep_get), there is a wrapper for it (e.g.
> hugetlb_ptep_get).  The correct version is used depending on if a HugeTLB
> PTE really is "huge".
>
> - Synchronization
> For existing bits of HugeTLB, synchronization is unchanged. For splitting
> and collapsing HugeTLB PTEs, we require that the i_mmap_rw_sem is held for
> writing, and for doing high-granularity page table walks, we require it to
> be held for reading.
>
> ---- Limitations & Future Changes ----
>
> This patch series only implements high-granularity mapping for VM_SHARED
> VMAs.  I intend to implement enough HGM to support 4K unmapping for memory
> failure recovery for both shared and private mappings.
>
> The memory failure use case poses its own challenges that can be
> addressed, but I will do so in a separate RFC.
>
> Performance has not been heavily scrutinized with this patch series. There
> are places where lock contention can significantly reduce performance. This
> will be addressed later.
>
> The patch series, as it stands right now, is compatible with the VMEMMAP
> page struct optimization[3], as we do not need to modify data contained
> in the subpage page structs.
>
> Other omissions:
>  - Compatibility with userfaultfd write-protect (will be included in v1).
>  - Support for mremap() (will be included in v1). This looks a lot like
>    the support we have for fork().
>  - Documentation changes (will be included in v1).
>  - Completely ignores PMD sharing and hugepage migration (will be included
>    in v1).
>  - Implementations for architectures that don't use GENERAL_HUGETLB other
>    than arm64.
>
> ---- Patch Breakdown ----
>
> Patch 1     - Preliminary changes
> Patch 2-10  - HugeTLB HGM core changes
> Patch 11-13 - HugeTLB HGM page table walking functionality
> Patch 14-19 - HugeTLB HGM compatibility with other bits
> Patch 20-23 - Userfaultfd and collapse changes
> Patch 24-26 - arm64 support and selftests
>
> [1] This used to be called HugeTLB double mapping, a bad and confusing
>     name. "High-granularity mapping" is not a great name either. I am open
>     to better names.

I would drop 1 extra word and do "granular mapping", as in the mapping
is more granular than what it normally is (2MB/1G, etc).

> [2] https://lore.kernel.org/linux-mm/20220604004004.954674-10-zokeefe@google.com/
> [3] commit f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
>
> James Houghton (26):
>   hugetlb: make hstate accessor functions const
>   hugetlb: sort hstates in hugetlb_init_hstates
>   hugetlb: add make_huge_pte_with_shift
>   hugetlb: make huge_pte_lockptr take an explicit shift argument.
>   hugetlb: add CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
>   mm: make free_p?d_range functions public
>   hugetlb: add hugetlb_pte to track HugeTLB page table entries
>   hugetlb: add hugetlb_free_range to free PT structures
>   hugetlb: add hugetlb_hgm_enabled
>   hugetlb: add for_each_hgm_shift
>   hugetlb: add hugetlb_walk_to to do PT walks
>   hugetlb: add HugeTLB splitting functionality
>   hugetlb: add huge_pte_alloc_high_granularity
>   hugetlb: add HGM support for hugetlb_fault and hugetlb_no_page
>   hugetlb: make unmapping compatible with high-granularity mappings
>   hugetlb: make hugetlb_change_protection compatible with HGM
>   hugetlb: update follow_hugetlb_page to support HGM
>   hugetlb: use struct hugetlb_pte for walk_hugetlb_range
>   hugetlb: add HGM support for copy_hugetlb_page_range
>   hugetlb: add support for high-granularity UFFDIO_CONTINUE
>   hugetlb: add hugetlb_collapse
>   madvise: add uapi for HugeTLB HGM collapse: MADV_COLLAPSE
>   userfaultfd: add UFFD_FEATURE_MINOR_HUGETLBFS_HGM
>   arm64/hugetlb: add support for high-granularity mappings
>   selftests: add HugeTLB HGM to userfaultfd selftest
>   selftests: add HugeTLB HGM to KVM demand paging selftest
>
>  arch/arm64/Kconfig                            |   1 +
>  arch/arm64/mm/hugetlbpage.c                   |  63 ++
>  arch/powerpc/mm/pgtable.c                     |   3 +-
>  arch/s390/mm/gmap.c                           |   8 +-
>  fs/Kconfig                                    |   7 +
>  fs/proc/task_mmu.c                            |  35 +-
>  fs/userfaultfd.c                              |  10 +-
>  include/asm-generic/tlb.h                     |   6 +-
>  include/linux/hugetlb.h                       | 177 +++-
>  include/linux/mm.h                            |   7 +
>  include/linux/pagewalk.h                      |   3 +-
>  include/uapi/asm-generic/mman-common.h        |   2 +
>  include/uapi/linux/userfaultfd.h              |   2 +
>  mm/damon/vaddr.c                              |  34 +-
>  mm/hmm.c                                      |   7 +-
>  mm/hugetlb.c                                  | 987 +++++++++++++++---
>  mm/madvise.c                                  |  23 +
>  mm/memory.c                                   |   8 +-
>  mm/mempolicy.c                                |  11 +-
>  mm/migrate.c                                  |   3 +-
>  mm/mincore.c                                  |   4 +-
>  mm/mprotect.c                                 |   6 +-
>  mm/page_vma_mapped.c                          |   3 +-
>  mm/pagewalk.c                                 |  18 +-
>  mm/userfaultfd.c                              |  57 +-
>  .../testing/selftests/kvm/include/test_util.h |   2 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |   2 +-
>  tools/testing/selftests/kvm/lib/test_util.c   |  14 +
>  tools/testing/selftests/vm/userfaultfd.c      |  61 +-
>  29 files changed, 1314 insertions(+), 250 deletions(-)
>
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
