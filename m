Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408274DDCF4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbiCRPb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiCRPb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:31:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3124815DABB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647617437; x=1679153437;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UssxH+wx9oZQ51+nOHpI71xUpXx3uJVYFLPrc3V1q38=;
  b=JHMUotlBnI1VkczQ56VsEZX6jA1o6gYzqJ2JSegIFnP+VSYxV1iX7YWE
   zsqJeS74p1/TlxQxyvpAdT47a6Z4ur3zx/Gr0zNOLcvc1QEQw2iX4eH8e
   wbX0vwpLXrXxvbCSze8ULRfjniw0JIbKZWnf3N3cJL4uO8sSZsmSj19Eg
   OT0mJ56x35Dx/TCFY1o/Kumg5q45O9zA0p4Dl/r2L7zKQijYyq1PQRjGL
   4WNwvzVM3KqEz4y6nFOoD4jROW4hqNph+RvUTaUW2aGAyvdDZvIjzf1Q+
   ZZlEstoeQcg2hRs2KCHNnyMMPKAebu0zNrxF53+ACUdJTDZSSZvn0T6sY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="239318127"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="239318127"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 08:30:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="517262263"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 18 Mar 2022 08:30:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 90A9B10E; Fri, 18 Mar 2022 17:30:49 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv7 00/30] TDX Guest: TDX core support
Date:   Fri, 18 Mar 2022 18:30:18 +0300
Message-Id: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Intel's Trust Domain Extensions (TDX) protects confidential guest VMs
from the host and physical attacks by isolating the guest register
state and by encrypting the guest memory. In TDX, a special TDX module
sits between the host and the guest, and runs in a special mode and
manages the guest/host separation.

	Please review and consider applying.

More details of TDX guests can be found in Documentation/x86/tdx.rst.

Dependencies:
-------------

The patchset depends on:
 - changes in x86/cc branch of the current TIP tree[1]
 - changes in swiotlb-init-cleanup branch of the Christoph's misc tree[2]

I'm not sure how to approach applying patches for such cases.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
[2] git://git.infradead.org/users/hch/misc

SEV/TDX comparison:
-------------------

TDX has a lot of similarities to SEV. It enhances confidentiality
of guest memory and state (like registers) and includes a new exception
(#VE) for the same basic reasons as SEV-ES. Like SEV-SNP (not merged
yet), TDX limits the host's ability to make changes in the guest
physical address space.

TDX/VM comparison:
------------------

Some of the key differences between TD and regular VM is,

1. Multi CPU bring-up is done using the ACPI MADT wake-up table.
2. A new #VE exception handler is added. The TDX module injects #VE exception
   to the guest TD in cases of instructions that need to be emulated, disallowed
   MSR accesses, etc.
3. By default memory is marked as private, and TD will selectively share it with
   VMM based on need.

You can find TDX related documents in the following link.

https://software.intel.com/content/www/br/pt/develop/articles/intel-trust-domain-extensions.html

Git tree:

https://github.com/intel/tdx.git guest-upstream

Previous version:

https://lore.kernel.org/r/20220316020856.24435-1-kirill.shutemov@linux.intel.com

Changes from v6:
  - Drop unused early_is_tdx_guest() and tdx_guest_detected;
  - Drop unused port I/O callback in pio_ops;
  - Restructure code around TDX_GET_INFO, cc_mask and physical_mask;
  - Drop unneeded mailbox_lock in ACPI wake up code;
  - Use memory barrier for serialzation around acpi_mp_wake_mailbox;
  - Update comments and commit messages;
  - Add Reviewed-bys and Suggested-by;
  - Fix few nits from checkpatch;
Changes from v5:
  - Drop paranoid check against TDX_IDENT;
  - Move files around;
  - Clarify why TDX_SEAMCALL_VMFAILINVALID has the value it has;
  - Better diagnostics for TDVMCALL failure;
  - WARN() instead of BUG() for confused instruction decoder for MMIO;
  - Rework port I/O in decompression code to avoid "pio_ops." at all call sites
    of I/O helpers;
  - Refactor code around tdx_enc_status_changed()
  - Utilize updated swiotlb code to initialize it for TDX (swiotlb-init-cleanup branch)
  - io_apic_set_fixmap_nocache() -> io_apic_set_fixmap();
  - Updates to comments and commit messages;
Changes from v4:
  - Update comments for TDX_MODULE_CALL()
  - Clarify how TDX_SEAMCALL_VMFAILINVALID is defined
  - Updated comments in __tdx_hypercall()
  - Get rid of td_info
  - Move exc_general_protection() refactoring into a separate patch
  - Updates comments around #VE handling
  - Add hcall_func() to differenciate exit reason from hypercalls
  - Only allow hypervisor CPUID leaves to be handled with #VE
  - Update MMIO handling comments and commit message
  - Update commit messages from port I/O related pateches
  - Rename init_io_ops() to init_default_io_ops()
  - Refactor handle_io()
  - Fold warning fix from a stand along patch to patch that make the warning
    triggerable
  - Do not flush cache on entering sleep state for any virtual machine, not only TDX
  - Documentation is updated
Changes from v3:
  - Rebased on top of merged x86/coco patches
  - Sanity build-time check for TDX detection (Cyrill Gorcunov)
  - Correction in the documentation regarding #VE for CPUID
Changes from v2:
  - Move TDX-Guest-specific code under arch/x86/coco/
  - Code shared between host and guest is under arch/x86/virt/
  - Fix handling CR4.MCE for !CONFIG_X86_MCE
  - A separate patch to clarify CR0.NE situation
  - Use u8/u16/u32 for port I/O handler
  - Rework TDCALL helpers:
    + consolidation between guest and host
    + clearer interface
    + A new tdx_module_call() panic() if TDCALL fails
  - Rework MMIO handling to imporove readability
  - New generic API to deal encryption masks
  - Move tdx_early_init() before copy_bootdata() (again)
  - Rework #VE handing to share more code with #GP handler
  - Rework __set_memory_enc_pgtable() to provide proper abstruction for both
    SME/SEV and TDX cases.
  - Fix warning on build with X86_MEM_ENCRYPT=y
  - ... and more
Changes from v1:
  - Rebased to tip/master (94985da003a4).
  - Address feedback from Borislav and Josh.
  - Wire up KVM hypercalls. Needed to send IPI.
Andi Kleen (1):
  x86/tdx: Port I/O: add early boot support

Isaku Yamahata (1):
  x86/tdx: ioapic: Add shared bit for IOAPIC base address

Kirill A. Shutemov (18):
  x86/tdx: Provide common base for SEAMCALL and TDCALL C wrappers
  x86/tdx: Extend the confidential computing API to support TDX guests
  x86/tdx: Exclude shared bit from __PHYSICAL_MASK
  x86/traps: Refactor exc_general_protection()
  x86/traps: Add #VE support for TDX guest
  x86/tdx: Add HLT support for TDX guests
  x86/tdx: Add MSR support for TDX guests
  x86/tdx: Handle CPUID via #VE
  x86/tdx: Handle in-kernel MMIO
  x86: Adjust types used in port I/O helpers
  x86: Consolidate port I/O helpers
  x86/boot: Port I/O: allow to hook up alternative helpers
  x86/boot: Port I/O: add decompression-time support for TDX
  x86/boot: Set CR0.NE early and keep it set during the boot
  x86/tdx: Make pages shared in ioremap()
  x86/mm/cpa: Add support for TDX shared memory
  x86/mm: Make DMA memory shared for TD guest
  ACPICA: Avoid cache flush inside virtual machines

Kuppuswamy Sathyanarayanan (8):
  x86/tdx: Detect running as a TDX guest in early boot
  x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper
    functions
  x86/tdx: Detect TDX at early kernel decompression time
  x86/tdx: Port I/O: add runtime hypercalls
  x86/tdx: Wire up KVM hypercalls
  x86/acpi, x86/boot: Add multiprocessor wake-up support
  x86/topology: Disable CPU online/offline control for TDX guests
  Documentation/x86: Document TDX kernel architecture

Sean Christopherson (2):
  x86/boot: Add a trampoline for booting APs via firmware handoff
  x86/boot: Avoid #VE during boot for TDX platforms

 Documentation/x86/index.rst              |   1 +
 Documentation/x86/tdx.rst                | 214 +++++++
 arch/x86/Kconfig                         |  15 +
 arch/x86/boot/boot.h                     |  37 +-
 arch/x86/boot/compressed/Makefile        |   1 +
 arch/x86/boot/compressed/head_64.S       |  27 +-
 arch/x86/boot/compressed/misc.c          |  12 +
 arch/x86/boot/compressed/misc.h          |   4 +-
 arch/x86/boot/compressed/pgtable.h       |   2 +-
 arch/x86/boot/compressed/tdcall.S        |   3 +
 arch/x86/boot/compressed/tdx.c           |  77 +++
 arch/x86/boot/compressed/tdx.h           |  13 +
 arch/x86/boot/cpuflags.c                 |   3 +-
 arch/x86/boot/cpuflags.h                 |   1 +
 arch/x86/boot/io.h                       |  41 ++
 arch/x86/boot/main.c                     |   4 +
 arch/x86/coco/Makefile                   |   2 +
 arch/x86/coco/core.c                     |  22 +-
 arch/x86/coco/tdx/Makefile               |   3 +
 arch/x86/coco/tdx/tdcall.S               | 204 +++++++
 arch/x86/coco/tdx/tdx.c                  | 710 +++++++++++++++++++++++
 arch/x86/include/asm/acenv.h             |  14 +-
 arch/x86/include/asm/apic.h              |   7 +
 arch/x86/include/asm/cpufeatures.h       |   1 +
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/idtentry.h          |   4 +
 arch/x86/include/asm/io.h                |  42 +-
 arch/x86/include/asm/kvm_para.h          |  22 +
 arch/x86/include/asm/mem_encrypt.h       |   6 +-
 arch/x86/include/asm/realmode.h          |   1 +
 arch/x86/include/asm/shared/io.h         |  34 ++
 arch/x86/include/asm/shared/tdx.h        |  40 ++
 arch/x86/include/asm/tdx.h               |  90 +++
 arch/x86/kernel/acpi/boot.c              | 115 ++++
 arch/x86/kernel/apic/apic.c              |  10 +
 arch/x86/kernel/apic/io_apic.c           |  18 +-
 arch/x86/kernel/asm-offsets.c            |  17 +
 arch/x86/kernel/head64.c                 |   7 +
 arch/x86/kernel/head_64.S                |  28 +-
 arch/x86/kernel/idt.c                    |   3 +
 arch/x86/kernel/process.c                |   4 +
 arch/x86/kernel/smpboot.c                |  12 +-
 arch/x86/kernel/traps.c                  | 143 ++++-
 arch/x86/mm/ioremap.c                    |   5 +
 arch/x86/mm/mem_encrypt.c                |   9 +-
 arch/x86/realmode/rm/header.S            |   1 +
 arch/x86/realmode/rm/trampoline_64.S     |  57 +-
 arch/x86/realmode/rm/trampoline_common.S |  12 +-
 arch/x86/realmode/rm/wakemain.c          |   4 +
 arch/x86/virt/vmx/tdx/tdxcall.S          |  94 +++
 include/linux/cc_platform.h              |  10 +
 kernel/cpu.c                             |   7 +
 52 files changed, 2103 insertions(+), 118 deletions(-)
 create mode 100644 Documentation/x86/tdx.rst
 create mode 100644 arch/x86/boot/compressed/tdcall.S
 create mode 100644 arch/x86/boot/compressed/tdx.c
 create mode 100644 arch/x86/boot/compressed/tdx.h
 create mode 100644 arch/x86/boot/io.h
 create mode 100644 arch/x86/coco/tdx/Makefile
 create mode 100644 arch/x86/coco/tdx/tdcall.S
 create mode 100644 arch/x86/coco/tdx/tdx.c
 create mode 100644 arch/x86/include/asm/shared/io.h
 create mode 100644 arch/x86/include/asm/shared/tdx.h
 create mode 100644 arch/x86/include/asm/tdx.h
 create mode 100644 arch/x86/virt/vmx/tdx/tdxcall.S

-- 
2.34.1

