Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B6F514A91
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347934AbiD2Nji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiD2Njg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:39:36 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F4CC8A84
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j6so6915053pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dpbde/vaZRRFySCr85iPpDzqYqW+eIo3XY8pE4lO6sM=;
        b=ecGalpDz8llCqz+zXe8P6mTGdoUAiMgYIVGYu0HUBQH78AbPHlKQrKuujMDWaTYbpq
         mYAGEt3y1jeMMN6q1+wUH1yPXfM9+cxR4ZMo5cKthMRTBJDMyMtzHut3ETZODuzD1WtW
         +h0gx8sWt2DfqRO339NQFG2D/wje4F/h/r67YCun0rpJ5eNPYoloyyOyGj9/0RUV49E6
         KA20ldAGAjuKP0rMWwd0bMuSdnWortC/3GlpcNz86YufkwZzMPSzw9tjPW39O9XqADDA
         5ScIWptHZM719pknZrA/CI/BRFMkDhZ0xUZinkNQBjiunQ9nmjA8N0JWxXSJHnyXXwzH
         ajPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dpbde/vaZRRFySCr85iPpDzqYqW+eIo3XY8pE4lO6sM=;
        b=Q2HQ14WyDOt1zM+J1ygLcd1aGFGbOh33YD7vKQQgTu0vSp5jv1RBepa9/okWEtGMD6
         aJlSFudxVQdGcbaRu4HePJH2ngCTQADLHzFSNB+2qRBPerXWs0gLLiyu6be9rFHIwPs0
         klay/1lMCZCV0LhFTlddu98ZeYfWDXHjw/H0NOHTtThP4ps52ZOJXZhi+kKNkqBJcZ9t
         pALy3sfQPoAx1kd1YBbxhX/li1r7ou16AfeTiHiZSuIld/aY379LM1ZFWSs59LRMk53I
         o4F4JpeYM5+ROVlupmJpPWyJuEjhkRFI48NBaGAPpP3+Tebnt3b9MSwT6tGp/gHkRs0j
         OvZQ==
X-Gm-Message-State: AOAM533O8bRQQwF2aWf7qoEm4Pt5BFXUrL1sJPR1GFc0PD6aNkbwSesN
        tifkdwe7NAregqGZJYkpajiYWA==
X-Google-Smtp-Source: ABdhPJxeRhBFbkwTHIaM2b9Mdnm1pxMN/wK2KEcBoO7TNdUijwgyiXrx2s/neJyAY//6saUNM26sdA==
X-Received: by 2002:a65:60d3:0:b0:39c:f431:5859 with SMTP id r19-20020a6560d3000000b0039cf4315859mr32419170pgv.442.1651239376174;
        Fri, 29 Apr 2022 06:36:16 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:36:15 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 00/18] Try to free user PTE page table pages
Date:   Fri, 29 Apr 2022 21:35:34 +0800
Message-Id: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series aims to try to free user PTE page table pages when no one is
using it.

The beginning of this story is that some malloc libraries(e.g. jemalloc or
tcmalloc) usually allocate the amount of VAs by mmap() and do not unmap those
VAs. They will use madvise(MADV_DONTNEED) to free physical memory if they want.
But the page tables do not be freed by madvise(), so it can produce many
page tables when the process touches an enormous virtual address space.

The following figures are a memory usage snapshot of one process which actually
happened on our server:

        VIRT:  55t
        RES:   590g
        VmPTE: 110g

As we can see, the PTE page tables size is 110g, while the RES is 590g. In
theory, the process only need 1.2g PTE page tables to map those physical
memory. The reason why PTE page tables occupy a lot of memory is that
madvise(MADV_DONTNEED) only empty the PTE and free physical memory but
doesn't free the PTE page table pages. So we can free those empty PTE page
tables to save memory. In the above cases, we can save memory about 108g(best
case). And the larger the difference between the size of VIRT and RES, the
more memory we save.

In this patch series, we add a pte_ref field to the struct page of page table
to track how many users of user PTE page table. Similar to the mechanism of page
refcount, the user of PTE page table should hold a refcount to it before
accessing. The user PTE page table page may be freed when the last refcount is
dropped.

Different from the idea of another patchset of mine before[1], the pte_ref
becomes a struct percpu_ref type, and we switch it to atomic mode only in cases
such as MADV_DONTNEED and MADV_FREE that may clear the user PTE page table
entryies, and then release the user PTE page table page when checking that
pte_ref is 0. The advantage of this is that there is basically no performance
overhead in percpu mode, but it can also free the empty PTEs. In addition, the
code implementation of this patchset is much simpler and more portable than the
another patchset[1].

Testing:

The following code snippet can show the effect of optimization:

        mmap 50G
        while (1) {
                for (; i < 1024 * 25; i++) {
                        touch 2M memory
                        madvise MADV_DONTNEED 2M
                }
        }

As we can see, the memory usage of VmPTE is reduced:

                        before                          after
VIRT                   50.0 GB                        50.0 GB
RES                     3.1 MB                         3.1 MB
VmPTE                102640 kB                          96 kB

I also have tested the stability by LTP[2] for several weeks. I have not seen
any crash so far.

This series is based on v5.18-rc2.

Comments and suggestions are welcome.

Thanks,
Qi.

[1] https://patchwork.kernel.org/project/linux-mm/cover/20211110105428.32458-1-zhengqi.arch@bytedance.com/
[2] https://github.com/linux-test-project/ltp

Qi Zheng (18):
  x86/mm/encrypt: add the missing pte_unmap() call
  percpu_ref: make ref stable after percpu_ref_switch_to_atomic_sync()
    returns
  percpu_ref: make percpu_ref_switch_lock per percpu_ref
  mm: convert to use ptep_clear() in pte_clear_not_present_full()
  mm: split the related definitions of pte_offset_map_lock() into
    pgtable.h
  mm: introduce CONFIG_FREE_USER_PTE
  mm: add pte_to_page() helper
  mm: introduce percpu_ref for user PTE page table page
  pte_ref: add pte_tryget() and {__,}pte_put() helper
  mm: add pte_tryget_map{_lock}() helper
  mm: convert to use pte_tryget_map_lock()
  mm: convert to use pte_tryget_map()
  mm: add try_to_free_user_pte() helper
  mm: use try_to_free_user_pte() in MADV_DONTNEED case
  mm: use try_to_free_user_pte() in MADV_FREE case
  pte_ref: add track_pte_{set, clear}() helper
  x86/mm: add x86_64 support for pte_ref
  Documentation: add document for pte_ref

 Documentation/vm/index.rst         |   1 +
 Documentation/vm/pte_ref.rst       | 210 ++++++++++++++++++++++++++
 arch/x86/Kconfig                   |   1 +
 arch/x86/include/asm/pgtable.h     |   7 +-
 arch/x86/mm/mem_encrypt_identity.c |  10 +-
 fs/proc/task_mmu.c                 |  16 +-
 fs/userfaultfd.c                   |  10 +-
 include/linux/mm.h                 | 162 ++------------------
 include/linux/mm_types.h           |   1 +
 include/linux/percpu-refcount.h    |   6 +-
 include/linux/pgtable.h            | 196 +++++++++++++++++++++++-
 include/linux/pte_ref.h            |  73 +++++++++
 include/linux/rmap.h               |   2 +
 include/linux/swapops.h            |   4 +-
 kernel/events/core.c               |   5 +-
 lib/percpu-refcount.c              |  86 +++++++----
 mm/Kconfig                         |  10 ++
 mm/Makefile                        |   2 +-
 mm/damon/vaddr.c                   |  30 ++--
 mm/debug_vm_pgtable.c              |   2 +-
 mm/filemap.c                       |   4 +-
 mm/gup.c                           |  20 ++-
 mm/hmm.c                           |   9 +-
 mm/huge_memory.c                   |   4 +-
 mm/internal.h                      |   3 +-
 mm/khugepaged.c                    |  18 ++-
 mm/ksm.c                           |   4 +-
 mm/madvise.c                       |  35 +++--
 mm/memcontrol.c                    |   8 +-
 mm/memory-failure.c                |  15 +-
 mm/memory.c                        | 187 +++++++++++++++--------
 mm/mempolicy.c                     |   4 +-
 mm/migrate.c                       |   8 +-
 mm/migrate_device.c                |  22 ++-
 mm/mincore.c                       |   5 +-
 mm/mlock.c                         |   5 +-
 mm/mprotect.c                      |   4 +-
 mm/mremap.c                        |  10 +-
 mm/oom_kill.c                      |   3 +-
 mm/page_table_check.c              |   2 +-
 mm/page_vma_mapped.c               |  59 +++++++-
 mm/pagewalk.c                      |   6 +-
 mm/pte_ref.c                       | 230 +++++++++++++++++++++++++++++
 mm/rmap.c                          |   9 ++
 mm/swap_state.c                    |   4 +-
 mm/swapfile.c                      |  18 ++-
 mm/userfaultfd.c                   |  11 +-
 mm/vmalloc.c                       |   2 +-
 48 files changed, 1203 insertions(+), 340 deletions(-)
 create mode 100644 Documentation/vm/pte_ref.rst
 create mode 100644 include/linux/pte_ref.h
 create mode 100644 mm/pte_ref.c

-- 
2.20.1

