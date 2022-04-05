Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1584F219E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiDEClw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiDEClm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B343A15D07C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OBi61s+JghKUXWEe1OMMiWyW0nyr4WAh2C6liQr6Dlo=;
        b=DGCs7tH0fef1XI/5yrfLW7bnvahaVn2/1EhXsBInMb1+3Y37g4PEDlIhUiTS/WwrpqM6v7
        jSl9ETzPRMK6J1kn8JBy/Ykyy+SJ3HpWxsPiSA5vdc2E+ElQoQMNpPQuerht4umvIBeUuh
        KZd+fVUN9WDL3GDmIkz4Pr6Liih/xgY=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-JCLj_j20PfCoMdGh0MxADA-1; Mon, 04 Apr 2022 21:46:50 -0400
X-MC-Unique: JCLj_j20PfCoMdGh0MxADA-1
Received: by mail-il1-f198.google.com with SMTP id a6-20020a056e02120600b002ca412e65a7so2678987ilq.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBi61s+JghKUXWEe1OMMiWyW0nyr4WAh2C6liQr6Dlo=;
        b=UL+thRSBQy4MvYqgQWybHAxuhRQyvgVy8WsWvNw9B5bNfwt8TULHUtd/ffudwozqzl
         vBwsP9hW5xeCwJf7je+3VVU5dV+dI9I9y9aeJ3uR6G1klzOtn0ngCzq5VhGQrVBT/z6I
         M99qDwF6rE5w7iEW6NAaz5xck1n/prFQHIESb5QOIcAcSsh1qoFlAxtlMv7lr2IEX2TE
         nddtAoh/Tcw3NcSj0a9V20TtHPxtj2/PtjGmFE/vASeEal3nCH57qPletelM2EyftU4O
         3RqrGSl2zTdwHzlqR9sBKuOTK2+teh60IXt/aON4ijhSn0fNrD2QM3zBFE2v/bVGfI3b
         f10g==
X-Gm-Message-State: AOAM533rilRnGR/td/f7dutBU5cvpLy0wFmrZcD5wov9b4qiDhba/6kF
        dEWz7fKVswQOrETHcBdLqeF9KVkoo+HRezdl7QTSg2V2UyLFcf47LqSU/NBDhpHqMR7jyZa0y8b
        tnBW4smZ7IVEEBY8ZNe+mE7W6cIx/QMcQJImheSlxo8FHkajwdcCK1QQNc5vtilNonpgd9YMcEA
        ==
X-Received: by 2002:a05:6e02:1d8d:b0:2c8:8b83:d970 with SMTP id h13-20020a056e021d8d00b002c88b83d970mr549908ila.319.1649123209841;
        Mon, 04 Apr 2022 18:46:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvWuYYKglYirQ0LRfM2I1hSO8c/Zl59XM54StjU2RIzTxV8oxULWLP0ovJKacVWrfuMbg88w==
X-Received: by 2002:a05:6e02:1d8d:b0:2c8:8b83:d970 with SMTP id h13-20020a056e021d8d00b002c88b83d970mr549877ila.319.1649123209434;
        Mon, 04 Apr 2022 18:46:49 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id d14-20020a056602184e00b00649673c175asm7556676ioi.25.2022.04.04.18.46.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:46:49 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v8 00/23] userfaultfd-wp: Support shmem and hugetlbfs
Date:   Mon,  4 Apr 2022 21:46:23 -0400
Message-Id: <20220405014646.13522-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v8 of the series to add shmem+hugetlbfs support for userfaultfd
write protection.  It is based on v5.17-mmots-2022-03-31-20-40.

I touched up two small details after the rebase, namely:

  - Let UFFDIO_REGISTER fail gracefully if CONFIG_PTE_MARKER_UFFD_WP is not
    set, in "mm/uffd: Enable write protection for shmem & hugetlbfs".

  - Tweaked the patch "mm: Enable PTE markers by default" to make sure
    it'll be auto-enabled on x86_64 (for real) by kconfig where proper.

During testing of recent versions, I grew another unit test for uffd-wp
specifically (uffd-test [0], name is not important.. though).  The current
vm/userfaultfd test doesn't cover the case to check what message we expect,
so the simple new test can catch errors when e.g. one page was wr-protected
but it was wrongly written without being noticed by the fault resolving
thread, hence data corrupt.

I used to only find such issues with umapsort only, and MISSING mode won't
have those data loss issues.  But now many of it can also be found with
uffd-test [0].  I plan to port it to linux repo after this series lands.

The whole tree can be found here for testing:

  https://github.com/xzpeter/linux/tree/uffd-wp-shmem-hugetlbfs

Previous versions:

  RFC: https://lore.kernel.org/lkml/20210115170907.24498-1-peterx@redhat.com
  v1:  https://lore.kernel.org/lkml/20210323004912.35132-1-peterx@redhat.com
  v2:  https://lore.kernel.org/lkml/20210427161317.50682-1-peterx@redhat.com
  v3:  https://lore.kernel.org/lkml/20210527201927.29586-1-peterx@redhat.com
  v4:  https://lore.kernel.org/lkml/20210714222117.47648-1-peterx@redhat.com
  v5:  https://lore.kernel.org/lkml/20210715201422.211004-1-peterx@redhat.com
  v6:  https://lore.kernel.org/lkml/20211115075522.73795-1-peterx@redhat.com
  v7:  https://lore.kernel.org/lkml/20220304051708.86193-1-peterx@redhat.com

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
 fs/userfaultfd.c                         |  31 ++--
 include/asm-generic/hugetlb.h            |  24 +++
 include/linux/hugetlb.h                  |  27 ++--
 include/linux/mm.h                       |  10 ++
 include/linux/mm_inline.h                |  43 +++++
 include/linux/shmem_fs.h                 |   4 +-
 include/linux/swap.h                     |  15 +-
 include/linux/swapops.h                  |  79 +++++++++
 include/linux/userfaultfd_k.h            |  80 +++++++++
 include/uapi/linux/userfaultfd.h         |  10 +-
 mm/Kconfig                               |  17 ++
 mm/filemap.c                             |   5 +
 mm/hmm.c                                 |   2 +-
 mm/hugetlb.c                             | 183 ++++++++++++++++-----
 mm/khugepaged.c                          |  14 +-
 mm/memcontrol.c                          |   8 +-
 mm/memory.c                              | 196 ++++++++++++++++++++---
 mm/mincore.c                             |   3 +-
 mm/mprotect.c                            |  75 ++++++++-
 mm/rmap.c                                |   8 +
 mm/shmem.c                               |   4 +-
 mm/userfaultfd.c                         |  54 +++++--
 tools/testing/selftests/vm/userfaultfd.c |   4 +-
 26 files changed, 807 insertions(+), 126 deletions(-)

-- 
2.32.0

