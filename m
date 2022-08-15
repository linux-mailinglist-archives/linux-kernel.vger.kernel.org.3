Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB8592889
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240503AbiHOEPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiHOEPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:15:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE9B1402A
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660536906; x=1692072906;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0ahfPVuiJ9/uA08VC52xCxqtENSxJqyCRE1iKM3Dmbk=;
  b=h5e5IaI08+zOdu4IfIhEVksoxQHs0piIBTmLzbutnfXOkwrTkX1vcpXD
   /5dz4YlaqenDE2NCnkAry7PsHctnz+SQB6Go/iVzVbkCraQMhg021iQ/K
   yGezn5dRfj0FuGkIgJbY8+qiLMIbLRuFlJ7Kgk0Gqteiqi9tTrcLkpTdN
   Xw38LTlZTb1c3azFg6qBtViO0om00hq/AqKrDladuXDG1SNjoiC0AE+Wz
   OCzDHnQU937/1zsYhogUpOhPL1Fp5bAgwq9/+MNCabZOCbXWu4NY1Tvtt
   8b6VLYhBxzvAji2rqZLo6boD5vk9wu/iAHMLKPHYRDQNDXqFXN4aYjTxq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="271658896"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="271658896"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 21:15:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="732818239"
Received: from dmalka-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.42.26])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 21:15:01 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 311D2104A63; Mon, 15 Aug 2022 07:18:04 +0300 (+03)
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
Subject: [PATCHv6 00/11] Linear Address Masking enabling
Date:   Mon, 15 Aug 2022 07:17:52 +0300
Message-Id: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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

The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
this time.

Please review and consider applying.

git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam

v6:
  - Rebased onto v6.0-rc1
  - LAM_U48 excluded from the patchet. Still available in the git tree;
  - Add ARCH_GET_MAX_TAG_BITS (and tests for it);
  - Fix build without CONFIG_DEBUG_VM;
  - Update comments;
  - Reviewed/Tested-by from Alexander;
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

Kirill A. Shutemov (7):
  x86/mm: Fix CR3_ADDR_MASK
  x86: CPUID and CR3/CR4 flags for Linear Address Masking
  mm: Pass down mm_struct to untagged_addr()
  x86/mm: Handle LAM on context switch
  x86/uaccess: Provide untagged_addr() and remove tags before address
    check
  x86/mm: Provide arch_prctl() interface for LAM
  x86: Expose untagging mask in /proc/$PID/arch_status

Weihong Zhang (4):
  selftests/x86/lam: Add malloc and tag-bits test cases for
    linear-address masking
  selftests/x86/lam: Add mmap and SYSCALL test cases for linear-address
    masking
  selftests/x86/lam: Add io_uring test cases for linear-address masking
  selftests/x86/lam: Add inherit test cases for linear-address masking

 arch/arm64/include/asm/memory.h               |   4 +-
 arch/arm64/include/asm/signal.h               |   2 +-
 arch/arm64/include/asm/uaccess.h              |   4 +-
 arch/arm64/kernel/hw_breakpoint.c             |   2 +-
 arch/arm64/kernel/traps.c                     |   4 +-
 arch/arm64/mm/fault.c                         |  10 +-
 arch/sparc/include/asm/pgtable_64.h           |   2 +-
 arch/sparc/include/asm/uaccess_64.h           |   2 +
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/mmu.h                    |   6 +
 arch/x86/include/asm/mmu_context.h            |  45 +
 arch/x86/include/asm/processor-flags.h        |   4 +-
 arch/x86/include/asm/tlbflush.h               |  35 +
 arch/x86/include/asm/uaccess.h                |  42 +-
 arch/x86/include/uapi/asm/prctl.h             |   4 +
 arch/x86/include/uapi/asm/processor-flags.h   |   6 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/fpu/xstate.c                  |  47 -
 arch/x86/kernel/proc.c                        |  60 ++
 arch/x86/kernel/process.c                     |   3 +
 arch/x86/kernel/process_64.c                  |  65 +-
 arch/x86/mm/tlb.c                             |  43 +-
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
 tools/testing/selftests/x86/lam.c             | 900 ++++++++++++++++++
 virt/kvm/kvm_main.c                           |   2 +-
 49 files changed, 1256 insertions(+), 121 deletions(-)
 create mode 100644 arch/x86/kernel/proc.c
 create mode 100644 tools/testing/selftests/x86/lam.c

-- 
2.35.1

