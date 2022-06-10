Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5811B546875
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349616AbiFJOgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349577AbiFJOgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:36:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BBE13FBF3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654871763; x=1686407763;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FukGPzXByjrkYfduJl2ZJIdOVTCCHjE/6bRGBZlaGCo=;
  b=ILXbaYZpQ+Qib0KEvJ0Dp5HhNK+eGxxwWfX/KIWSPq4SlwGsKmTI5AcW
   8BjYO0Teg747vjeB11keTS3nUmwYfgaEuukGixaj3pO3KMs3OPssBGdS4
   0hsGDGRAFaOLDrlC2NEvjPDW7XXjTefKgf1DHagyuDqhKcNVIH4QTJaFx
   3/tBRK1cye3T98kT+UzP21jx35RDcr/y66AnuuZMK/Lp/0GynCBimG11b
   10g6pwIQnEFhggseMyOHe0TtN9MljXgugt4qpoEoULnofLck+gYEhcH4d
   5+GEIO5+XpwAFJb/c11bVT2V1dMT0S9mR33xcZcbqRgOU302Kc6emdOJS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278781395"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="278781395"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 07:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="908939763"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jun 2022 07:35:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1B005F8; Fri, 10 Jun 2022 17:35:29 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 0/8] Linear Address Masking enabling
Date:   Fri, 10 Jun 2022 17:35:19 +0300
Message-Id: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linear Address Masking[1] (LAM) modifies the checking that is applied to
64-bit linear addresses, allowing software to use of the untranslated
address bits for metadata.

The patchset brings support for LAM for userspace addresses.

LAM_U48 enabling is controversial since it competes for bits with
5-level paging. Its enabling isolated into an optional last patch that
can be applied at maintainer's discretion.

Please review and consider applying.

v3:
  - Rebased onto v5.19-rc1
  - Per-process enabling;
  - API overhaul (again);
  - Avoid branches and costly computations in the fast path;
  - LAM_U48 is in optional patch.
v2:
  - Rebased onto v5.18-rc1
  - New arch_prctl(2)-based API
  - Expose status of LAM (or other thread features) in
    /proc/$PID/arch_status

[1] ISE, Chapter 14.
https://software.intel.com/content/dam/develop/external/us/en/documents-tps/architecture-instruction-set-extensions-programming-reference.pdf

Kirill A. Shutemov (8):
  x86/mm: Fix CR3_ADDR_MASK
  x86: CPUID and CR3/CR4 flags for Linear Address Masking
  mm: Pass down mm_struct to untagged_addr()
  x86/mm: Handle LAM on context switch
  x86/uaccess: Provide untagged_addr() and remove tags before address check
  x86/mm: Provide ARCH_GET_UNTAG_MASK and ARCH_ENABLE_TAGGED_ADDR
  x86: Expose untagging mask in /proc/$PID/arch_status
  x86/mm: Extend LAM to support to LAM_U48

 arch/arm64/include/asm/memory.h               |  4 +-
 arch/arm64/include/asm/signal.h               |  2 +-
 arch/arm64/include/asm/uaccess.h              |  4 +-
 arch/arm64/kernel/hw_breakpoint.c             |  2 +-
 arch/arm64/kernel/traps.c                     |  4 +-
 arch/arm64/mm/fault.c                         | 10 +--
 arch/sparc/include/asm/pgtable_64.h           |  2 +-
 arch/sparc/include/asm/uaccess_64.h           |  2 +
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/elf.h                    |  3 +-
 arch/x86/include/asm/mmu.h                    |  2 +
 arch/x86/include/asm/mmu_context.h            | 58 +++++++++++++++++
 arch/x86/include/asm/processor-flags.h        |  2 +-
 arch/x86/include/asm/tlbflush.h               |  3 +
 arch/x86/include/asm/uaccess.h                | 44 ++++++++++++-
 arch/x86/include/uapi/asm/prctl.h             |  3 +
 arch/x86/include/uapi/asm/processor-flags.h   |  6 ++
 arch/x86/kernel/Makefile                      |  2 +
 arch/x86/kernel/fpu/xstate.c                  | 47 --------------
 arch/x86/kernel/proc.c                        | 50 +++++++++++++++
 arch/x86/kernel/process.c                     |  3 +
 arch/x86/kernel/process_64.c                  | 54 +++++++++++++++-
 arch/x86/kernel/sys_x86_64.c                  |  5 +-
 arch/x86/mm/hugetlbpage.c                     |  6 +-
 arch/x86/mm/mmap.c                            |  9 ++-
 arch/x86/mm/tlb.c                             | 62 ++++++++++++++-----
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +-
 drivers/gpu/drm/radeon/radeon_gem.c           |  2 +-
 drivers/infiniband/hw/mlx4/mr.c               |  2 +-
 drivers/media/common/videobuf2/frame_vector.c |  2 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c |  2 +-
 .../staging/media/atomisp/pci/hmm/hmm_bo.c    |  2 +-
 drivers/tee/tee_shm.c                         |  2 +-
 drivers/vfio/vfio_iommu_type1.c               |  2 +-
 fs/proc/task_mmu.c                            |  2 +-
 include/linux/mm.h                            | 11 ----
 include/linux/uaccess.h                       | 11 ++++
 lib/strncpy_from_user.c                       |  2 +-
 lib/strnlen_user.c                            |  2 +-
 mm/gup.c                                      |  6 +-
 mm/madvise.c                                  |  2 +-
 mm/mempolicy.c                                |  6 +-
 mm/migrate.c                                  |  2 +-
 mm/mincore.c                                  |  2 +-
 mm/mlock.c                                    |  4 +-
 mm/mmap.c                                     |  2 +-
 mm/mprotect.c                                 |  2 +-
 mm/mremap.c                                   |  2 +-
 mm/msync.c                                    |  2 +-
 virt/kvm/kvm_main.c                           |  2 +-
 51 files changed, 342 insertions(+), 126 deletions(-)
 create mode 100644 arch/x86/kernel/proc.c

-- 
2.35.1

