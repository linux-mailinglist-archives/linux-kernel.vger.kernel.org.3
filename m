Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790304CCCE4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbiCDFSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbiCDFSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:18:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65DB81262D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=e0HRpvWMBQ8SLXvfPiOEp5b+QRkrUs7xMrgcNzBhT4w=;
        b=L8mkktRCUOCM0EIFl8LPlzoYgyTTq+haz7o3RKZzpp465CzY/1QEnsVS0uu/NgTEAiinGk
        9P0zD2FpV5RE3kuzsGcq6PKEt2NRfULmHV8h0IV6xxw1coKkwpOsyyMOMw0amFAgvLIKea
        jNHwPHRFo88iDoYSgm/sU6O7Mk697/Q=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-Ghd2KU7LMi6L_flfhNkOgw-1; Fri, 04 Mar 2022 00:17:24 -0500
X-MC-Unique: Ghd2KU7LMi6L_flfhNkOgw-1
Received: by mail-pj1-f70.google.com with SMTP id mj19-20020a17090b369300b001bedc197c50so6439148pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:17:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0HRpvWMBQ8SLXvfPiOEp5b+QRkrUs7xMrgcNzBhT4w=;
        b=pewsA6dTfbLEbl/XBmHmLVvV2rB5J2bj4oQ8IMJL/I8h6unukroKUFgv4FZgY/SZGo
         3jkpmpgPXO3BL5yNQJPCcJdLzyKKpyJCVzOcGb+g5w6YGEJdO1rxG/buW6tePisXVC/q
         O4JGQ7Ake4gR9PUOdy+X6AuQ3YUARMXj/NcHSIQghwvcxEh1uhh6+6DOljfGXzBnUmR1
         tz1hg2LEaAR3oWsmEK7YuMidUQwNSAxrpxIYJ+faOuWo4KkKScssg5zUjChzjl8EYtL7
         gRW2nScoV9OvvszldMGwnsDAyfDWoIDW5pAAGHqjELBtHKCy/OEnKJt5txn56o+ltSnh
         e8vg==
X-Gm-Message-State: AOAM530uDn0TD0HsDhmfWjfXB/HyXd5SoNmfNnOFZF60H7OEmXUBb/Zc
        a6loq56USb693lqg+TJH9eGu6OZWKyuPGztfE8yeVDWpGEO5c0GcL1tD46skr14ntuiKrc3BTvY
        dziC5gOpT95zKsg2zPO/GjYcz
X-Received: by 2002:a17:902:be0c:b0:14f:d9b3:92a9 with SMTP id r12-20020a170902be0c00b0014fd9b392a9mr39274937pls.53.1646371043079;
        Thu, 03 Mar 2022 21:17:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzxSCA3qOeKysFG5xoACVzdh0Kg3/Srw376djx9Rs6fEWpfjBjo+w/2U4uStqvssmYX9OXKFA==
X-Received: by 2002:a17:902:be0c:b0:14f:d9b3:92a9 with SMTP id r12-20020a170902be0c00b0014fd9b392a9mr39274911pls.53.1646371042604;
        Thu, 03 Mar 2022 21:17:22 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.17.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:17:22 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 00/23] userfaultfd-wp: Support shmem and hugetlbfs
Date:   Fri,  4 Mar 2022 13:16:45 +0800
Message-Id: <20220304051708.86193-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v7 of the series to add shmem+hugetlbfs support for userfaultfd
write protection.  It is based on linux-next tag next-20220301.

The whole tree can be found here for testing:

  https://github.com/xzpeter/linux/tree/uffd-wp-shmem-hugetlbfs

One tweak needed is to replace Nadav's v2 patch "userfaultfd: provide
unmasked address on page-fault" with v3 to unbreak hugetlb in general.

There aren't a lot of changes comparing to v6, majorly rebase and retest to
make sure nothing breaks.  Meanwhile should have addressed comments from
Alistair.

v7 changelog:
- Rebased to next-20220301
- Renamed s/is_pte_marker_uffd_wp/pte_marker_uffd_wp/, add another helper
  pte_marker_entry_uffd_wp as suggested to operate on swp_entry_t [Alistair]
- Drop pte_unmap_same() in pte_marker_handle_uffd_wp() [Alistair]
- In finish_fault(), init vmf->orig_pte with pte_clear(), because some
  pte_none() ptes are not really all zeros, e.g. xtensa and s390 [Alistair]

Previous versions:

  RFC: https://lore.kernel.org/lkml/20210115170907.24498-1-peterx@redhat.com/
  v1:  https://lore.kernel.org/lkml/20210323004912.35132-1-peterx@redhat.com/
  v2:  https://lore.kernel.org/lkml/20210427161317.50682-1-peterx@redhat.com/
  v3:  https://lore.kernel.org/lkml/20210527201927.29586-1-peterx@redhat.com/
  v4:  https://lore.kernel.org/lkml/20210714222117.47648-1-peterx@redhat.com/
  v5:  https://lore.kernel.org/lkml/20210715201422.211004-1-peterx@redhat.com/
  v6:  https://lore.kernel.org/lkml/20211115075522.73795-1-peterx@redhat.com/

Overview
========

Userfaultfd-wp anonymous support was merged two years ago.  There're quite
a few applications that started to leverage this capability either to take
snapshots for user-app memory, or use it for full user controled swapping.

This series tries to complete the feature for uffd-wp so as to cover all
the RAM-based memory types.  So far uffd-wp is the only missing piece of
the rest features (uffd-missing & uffd-minor mode).

One major reason to do so is that anonymous pages are sometimes not
satisfying the need of applications, and there're growing users of either
shmem and hugetlbfs for either sharing purpose (e.g., sharing guest mem
between hypervisor process and device emulation process, shmem local live
migration for upgrades), or for performance on tlb hits.

All these mean that if a uffd-wp app wants to switch to any of the memory
types, it'll stop working.  I think it's worthwhile to have the kernel to
cover all these aspects.

This series chose to protect pages in pte level not page level.

One major reason is safety.  I have no idea how we could make it safe if
any of the uffd-privileged app can wr-protect a page that any other
application can use.  It means this app can block any process potentially
for any time it wants.

The other reason is that it aligns very well with not only the anonymous
uffd-wp solution, but also uffd as a whole.  For example, userfaultfd is
implemented fundamentally based on VMAs.  We set flags to VMAs showing the
status of uffd tracking.  For another per-page based protection solution,
it'll be crossing the fundation line on VMA-based, and it could simply be
too far away already from what's called userfaultfd.

PTE markers
===========

The patchset is based on the idea called PTE markers.  It was discussed in
one of the mm alignment sessions, proposed starting from v6, and this is
the 2nd version of it using PTE marker idea.

PTE marker is a new type of swap entry that is ony applicable to file
backed memories like shmem and hugetlbfs.  It's used to persist some
pte-level information even if the original present ptes in pgtable are
zapped.

Logically pte markers can store more than uffd-wp information, but so far
only one bit is used for uffd-wp purpose.  When the pte marker is installed
with uffd-wp bit set, it means this pte is wr-protected by uffd.

It solves the problem on e.g. file-backed memory mapped ptes got zapped due
to any reason (e.g. thp split, or swapped out), we can still keep the
wr-protect information in the ptes.  Then when the page fault triggers
again, we'll know this pte is wr-protected so we can treat the pte the same
as a normal uffd wr-protected pte.

The extra information is encoded into the swap entry, or swp_offset to be
explicit, with the swp_type being PTE_MARKER.  So far uffd-wp only uses one
bit out of the swap entry, the rest bits of swp_offset are still reserved
for other purposes.

There're two configs to enable/disable PTE markers:

  CONFIG_PTE_MARKER
  CONFIG_PTE_MARKER_UFFD_WP

We can set !PTE_MARKER to completely disable all the PTE markers, along with
uffd-wp support.  I made two config so we can also enable PTE marker but
disable uffd-wp file-backed for other purposes.  At the end of current series,
I'll enable CONFIG_PTE_MARKER by default, but that patch is standalone and if
anyone worries about having it by default, we can also consider turn it off by
dropping that oneliner patch.  So far I don't see a huge risk of doing so, so I
kept that patch.

In most cases, PTE markers should be treated as none ptes.  It is because that
unlike most of the other swap entry types, there's no PFN or block offset
information encoded into PTE markers but some extra well-defined bits showing
the status of the pte.  These bits should only be used as extra data when
servicing an upcoming page fault, and then we behave as if it's a none pte.

I did spend a lot of time observing all the pte_none() users this time. It is
indeed a challenge because there're a lot, and I hope I didn't miss a single of
them when we should take care of pte markers.  Luckily, I don't think it'll
need to be considered in many cases, for example: boot code, arch code
(especially non-x86), kernel-only page handlings (e.g. CPA), or device driver
codes when we're tackling with pure PFN mappings.

I introduced pte_none_mostly() in this series when we need to handle pte
markers the same as none pte, the "mostly" is the other way to write "either
none pte or a pte marker".

I didn't replace pte_none() to cover pte markers for below reasons:

  - Very rare case of pte_none() callers will handle pte markers.  E.g., all
    the kernel pages do not require knowledge of pte markers.  So we don't
    pollute the major use cases.

  - Unconditionally change pte_none() semantics could confuse people, because
    pte_none() existed for so long a time.

  - Unconditionally change pte_none() semantics could make pte_none() slower
    even if in many cases pte markers do not exist.

  - There're cases where we'd like to handle pte markers differntly from
    pte_none(), so a full replace is also impossible.  E.g. khugepaged should
    still treat pte markers as normal swap ptes rather than none ptes, because
    pte markers will always need a fault-in to merge the marker with a valid
    pte.  Or the smap code will need to parse PTE markers not none ptes.

Patch Layout
============

Introducing PTE marker and uffd-wp bit in PTE marker:

  mm: Introduce PTE_MARKER swap entry
  mm: Teach core mm about pte markers
  mm: Check against orig_pte for finish_fault()
  mm/uffd: PTE_MARKER_UFFD_WP

Adding support for shmem uffd-wp:

  mm/shmem: Take care of UFFDIO_COPY_MODE_WP
  mm/shmem: Handle uffd-wp special pte in page fault handler
  mm/shmem: Persist uffd-wp bit across zapping for file-backed
  mm/shmem: Allow uffd wr-protect none pte for file-backed mem
  mm/shmem: Allows file-back mem to be uffd wr-protected on thps
  mm/shmem: Handle uffd-wp during fork()

Adding support for hugetlbfs uffd-wp:

  mm/hugetlb: Introduce huge pte version of uffd-wp helpers
  mm/hugetlb: Hook page faults for uffd write protection
  mm/hugetlb: Take care of UFFDIO_COPY_MODE_WP
  mm/hugetlb: Handle UFFDIO_WRITEPROTECT
  mm/hugetlb: Handle pte markers in page faults
  mm/hugetlb: Allow uffd wr-protect none ptes
  mm/hugetlb: Only drop uffd-wp special pte if required
  mm/hugetlb: Handle uffd-wp during fork()

Misc handling on the rest mm for uffd-wp file-backed:

  mm/khugepaged: Don't recycle vma pgtable if uffd-wp registered
  mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs

Enabling of uffd-wp on file-backed memory:

  mm/uffd: Enable write protection for shmem & hugetlbfs
  mm: Enable PTE markers by default
  selftests/uffd: Enable uffd-wp for shmem/hugetlbfs

Tests
=====

- Compile test on x86_64 and aarch64 on different configs
- Kernel selftests
- uffd-test [0]
- Umapsort [1,2] test for shmem/hugetlb, with swap on/off

Please review, thanks.

[0] https://github.com/xzpeter/clibs/tree/master/uffd-test
[1] https://github.com/xzpeter/umap-apps/tree/peter
[2] https://github.com/xzpeter/umap/tree/peter-shmem-hugetlbfs

Peter Xu (23):
  mm: Introduce PTE_MARKER swap entry
  mm: Teach core mm about pte markers
  mm: Check against orig_pte for finish_fault()
  mm/uffd: PTE_MARKER_UFFD_WP
  mm/shmem: Take care of UFFDIO_COPY_MODE_WP
  mm/shmem: Handle uffd-wp special pte in page fault handler
  mm/shmem: Persist uffd-wp bit across zapping for file-backed
  mm/shmem: Allow uffd wr-protect none pte for file-backed mem
  mm/shmem: Allows file-back mem to be uffd wr-protected on thps
  mm/shmem: Handle uffd-wp during fork()
  mm/hugetlb: Introduce huge pte version of uffd-wp helpers
  mm/hugetlb: Hook page faults for uffd write protection
  mm/hugetlb: Take care of UFFDIO_COPY_MODE_WP
  mm/hugetlb: Handle UFFDIO_WRITEPROTECT
  mm/hugetlb: Handle pte markers in page faults
  mm/hugetlb: Allow uffd wr-protect none ptes
  mm/hugetlb: Only drop uffd-wp special pte if required
  mm/hugetlb: Handle uffd-wp during fork()
  mm/khugepaged: Don't recycle vma pgtable if uffd-wp registered
  mm/pagemap: Recognize uffd-wp bit for shmem/hugetlbfs
  mm/uffd: Enable write protection for shmem & hugetlbfs
  mm: Enable PTE markers by default
  selftests/uffd: Enable uffd-wp for shmem/hugetlbfs

 arch/s390/include/asm/hugetlb.h          |  15 ++
 fs/hugetlbfs/inode.c                     |  15 +-
 fs/proc/task_mmu.c                       |   7 +
 fs/userfaultfd.c                         |  31 +---
 include/asm-generic/hugetlb.h            |  24 +++
 include/linux/hugetlb.h                  |  27 ++--
 include/linux/mm.h                       |  10 ++
 include/linux/mm_inline.h                |  43 +++++
 include/linux/shmem_fs.h                 |   4 +-
 include/linux/swap.h                     |  15 +-
 include/linux/swapops.h                  |  79 +++++++++
 include/linux/userfaultfd_k.h            |  71 ++++++++
 include/uapi/linux/userfaultfd.h         |  10 +-
 mm/Kconfig                               |  16 ++
 mm/filemap.c                             |   5 +
 mm/hmm.c                                 |   2 +-
 mm/hugetlb.c                             | 182 ++++++++++++++++-----
 mm/khugepaged.c                          |  14 +-
 mm/memcontrol.c                          |   8 +-
 mm/memory.c                              | 196 ++++++++++++++++++++---
 mm/mincore.c                             |   3 +-
 mm/mprotect.c                            |  75 ++++++++-
 mm/rmap.c                                |   8 +
 mm/shmem.c                               |   4 +-
 mm/userfaultfd.c                         |  54 +++++--
 tools/testing/selftests/vm/userfaultfd.c |   4 +-
 26 files changed, 795 insertions(+), 127 deletions(-)

-- 
2.32.0

