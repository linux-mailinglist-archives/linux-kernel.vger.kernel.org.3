Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ADE5729B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 01:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiGLXNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 19:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiGLXN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 19:13:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC1EB8E9A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657667606; x=1689203606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/mZZ6XVgf+v/LCjFJuOjf/g/7sNGNi+wlPnmFmhLw7o=;
  b=Hxx3H7G+rWvyfN5HgwHsp+bBcJmtHLnxCvf+VPcO04aLDWahDg9dyILa
   mkf+eO+/FMjcnI15ZBFmyKFqcTgl5dhqlorjCLkzE9uQwAgGsTS4a9vq+
   aW7azepQ83vV+sYP0TGtTHTbY63ODYYYqmPGynT/XjXCXsKBSWyeV+wGS
   9VlgKl2Oc9yXkIK1xFdvDTx4RSvup2at5BI4O8g57L0uZXbDfyEVmca47
   GlA50AWZeMOm0lOEFt/wiLZ7LBH12t3IxCtrpUcqUY2RbyZLOiQL+lV2L
   Sn6Ehzyxz0O2u089bBKb6Vf7sXEphmjVNErRgs+JMXgbvHhWfnawXJw2M
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="283818836"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="283818836"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 16:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="628074967"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 12 Jul 2022 16:13:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A8C88F1; Wed, 13 Jul 2022 02:13:29 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 00/13] Linear Address Masking enabling
Date:   Wed, 13 Jul 2022 02:13:15 +0300
Message-Id: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

v5:
  - Do not use switch_mm() in enable_lam_func()
  - Use mb()/READ_ONCE() pair on LAM enabling;
  - Add self-test by Weihong Zhang;
  - Add comments;
v4:
  - Fix untagged_addr() for LAM_U48;
  - Remove no-threads restriction on LAM enabling;
  - Fix mm_struct access from /proc/$PID/arch_status
  - Fix LAM handling in initialize_tlbstate_and_flush()
  - Pack tlb_state better;
  - Comments and commit messages;
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

[1] ISE, Chapter 10. https://cdrdv2.intel.com/v1/dl/getContent/671368

Kirill A. Shutemov (8):
  x86/mm: Fix CR3_ADDR_MASK
  x86: CPUID and CR3/CR4 flags for Linear Address Masking
  mm: Pass down mm_struct to untagged_addr()
  x86/mm: Handle LAM on context switch
  x86/uaccess: Provide untagged_addr() and remove tags before address
    check
  x86/mm: Provide ARCH_GET_UNTAG_MASK and ARCH_ENABLE_TAGGED_ADDR
  x86: Expose untagging mask in /proc/$PID/arch_status
  x86/mm: Extend LAM to support to LAM_U48

Weihong Zhang (5):
  selftests/x86/lam: Add malloc test cases for linear-address masking
  selftests/x86/lam: Add mmap and SYSCALL test cases for linear-address
    masking
  selftests/x86/lam: Add io_uring test cases for linear-address masking
  selftests/x86/lam: Add inherit test cases for linear-address masking
  selftests/x86/lam: Add tests cases for LAM_U48

 arch/arm64/include/asm/memory.h               |   4 +-
 arch/arm64/include/asm/signal.h               |   2 +-
 arch/arm64/include/asm/uaccess.h              |   4 +-
 arch/arm64/kernel/hw_breakpoint.c             |   2 +-
 arch/arm64/kernel/traps.c                     |   4 +-
 arch/arm64/mm/fault.c                         |  10 +-
 arch/sparc/include/asm/pgtable_64.h           |   2 +-
 arch/sparc/include/asm/uaccess_64.h           |   2 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/elf.h                    |   3 +-
 arch/x86/include/asm/mmu.h                    |   6 +
 arch/x86/include/asm/mmu_context.h            |  58 ++
 arch/x86/include/asm/processor-flags.h        |   2 +-
 arch/x86/include/asm/tlbflush.h               |  36 +
 arch/x86/include/asm/uaccess.h                |  42 +-
 arch/x86/include/uapi/asm/prctl.h             |   3 +
 arch/x86/include/uapi/asm/processor-flags.h   |   6 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/fpu/xstate.c                  |  47 -
 arch/x86/kernel/proc.c                        |  60 ++
 arch/x86/kernel/process.c                     |   3 +
 arch/x86/kernel/process_64.c                  |  83 +-
 arch/x86/kernel/sys_x86_64.c                  |   5 +-
 arch/x86/mm/hugetlbpage.c                     |   6 +-
 arch/x86/mm/mmap.c                            |  10 +-
 arch/x86/mm/tlb.c                             |  42 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   2 +-
 drivers/gpu/drm/radeon/radeon_gem.c           |   2 +-
 drivers/infiniband/hw/mlx4/mr.c               |   2 +-
 drivers/media/common/videobuf2/frame_vector.c |   2 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c |   2 +-
 .../staging/media/atomisp/pci/hmm/hmm_bo.c    |   2 +-
 drivers/tee/tee_shm.c                         |   2 +-
 drivers/vfio/vfio_iommu_type1.c               |   2 +-
 fs/proc/task_mmu.c                            |   2 +-
 include/linux/mm.h                            |  11 -
 include/linux/uaccess.h                       |  15 +
 lib/strncpy_from_user.c                       |   2 +-
 lib/strnlen_user.c                            |   2 +-
 mm/gup.c                                      |   6 +-
 mm/madvise.c                                  |   2 +-
 mm/mempolicy.c                                |   6 +-
 mm/migrate.c                                  |   2 +-
 mm/mincore.c                                  |   2 +-
 mm/mlock.c                                    |   4 +-
 mm/mmap.c                                     |   2 +-
 mm/mprotect.c                                 |   2 +-
 mm/mremap.c                                   |   2 +-
 mm/msync.c                                    |   2 +-
 tools/testing/selftests/x86/Makefile          |   2 +-
 tools/testing/selftests/x86/lam.c             | 913 ++++++++++++++++++
 virt/kvm/kvm_main.c                           |   2 +-
 53 files changed, 1315 insertions(+), 127 deletions(-)
 create mode 100644 arch/x86/kernel/proc.c
 create mode 100644 tools/testing/selftests/x86/lam.c

-- 
2.35.1

