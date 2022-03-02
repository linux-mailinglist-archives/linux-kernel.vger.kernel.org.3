Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246A64CA805
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242965AbiCBO3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242921AbiCBO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:28:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371AC228
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231283; x=1677767283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oKsrfX7a3rMjt4oLUEbLvHwOeyqkpWl5426OGE/83rY=;
  b=Dk5q6O6X/mBmhexnu9TBmbhPi1aycoyCaALordXpKyLRsV28zNM3+K2L
   wZm2KoVzXsal0urkKYvQ9l1Z0DiH6BndPXMNJ2aHvEADD08esTew1MsJY
   HrjrJk8aS2/DgbdfJZNv+INajuQOGMv4PTPKdTI2GjfmZgyRE5j/WvZkE
   bUkrczLr2gEwy2eAEGTLmy5pfGNaESPOHUCZOQqcH8GgpTE9ZUXI/hrfO
   yji62S0as1/W5/vOHkqLSgTiUb0ojTgXrN9RboZE9J57cxZITll+bc0ac
   bwsqDB5rF+N2haSwymvoybkXcJPmaD2PPZBJb0KIPmsiZ4OcKc1wnd1N0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="233376433"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="233376433"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="508216365"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2022 06:27:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B3845183; Wed,  2 Mar 2022 16:28:11 +0200 (EET)
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
Subject: [PATCHv5 00/30] TDX Guest: TDX core support
Date:   Wed,  2 Mar 2022 17:27:36 +0300
Message-Id: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

All dependencies of the patchset are in Linus' tree now.

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

https://lore.kernel.org/r/20220224155630.52734-1-kirill.shutemov@linux.intel.com

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
  x86/kvm: Use bounce buffers for TD guest
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
 Documentation/x86/tdx.rst                | 214 ++++++++
 arch/x86/Kconfig                         |  15 +
 arch/x86/boot/a20.c                      |  14 +-
 arch/x86/boot/boot.h                     |  35 +-
 arch/x86/boot/compressed/Makefile        |   1 +
 arch/x86/boot/compressed/head_64.S       |  27 +-
 arch/x86/boot/compressed/misc.c          |  26 +-
 arch/x86/boot/compressed/misc.h          |   4 +-
 arch/x86/boot/compressed/pgtable.h       |   2 +-
 arch/x86/boot/compressed/tdcall.S        |   3 +
 arch/x86/boot/compressed/tdx.c           |  99 ++++
 arch/x86/boot/compressed/tdx.h           |  15 +
 arch/x86/boot/cpuflags.c                 |   3 +-
 arch/x86/boot/cpuflags.h                 |   1 +
 arch/x86/boot/early_serial_console.c     |  28 +-
 arch/x86/boot/io.h                       |  32 ++
 arch/x86/boot/main.c                     |   4 +
 arch/x86/boot/pm.c                       |  10 +-
 arch/x86/boot/tty.c                      |   4 +-
 arch/x86/boot/video-vga.c                |   6 +-
 arch/x86/boot/video.h                    |   8 +-
 arch/x86/coco/Makefile                   |   2 +
 arch/x86/coco/core.c                     |  14 +-
 arch/x86/coco/tdcall.S                   | 201 +++++++
 arch/x86/coco/tdx.c                      | 634 +++++++++++++++++++++++
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
 arch/x86/include/asm/shared/tdx.h        |  37 ++
 arch/x86/include/asm/tdx.h               |  90 ++++
 arch/x86/kernel/acpi/boot.c              | 118 +++++
 arch/x86/kernel/apic/apic.c              |  10 +
 arch/x86/kernel/apic/io_apic.c           |  15 +-
 arch/x86/kernel/asm-offsets.c            |  19 +
 arch/x86/kernel/head64.c                 |   7 +
 arch/x86/kernel/head_64.S                |  28 +-
 arch/x86/kernel/idt.c                    |   3 +
 arch/x86/kernel/process.c                |   4 +
 arch/x86/kernel/smpboot.c                |  12 +-
 arch/x86/kernel/traps.c                  | 138 ++++-
 arch/x86/mm/ioremap.c                    |   5 +
 arch/x86/mm/mem_encrypt.c                |   9 +-
 arch/x86/realmode/rm/header.S            |   1 +
 arch/x86/realmode/rm/trampoline_64.S     |  57 +-
 arch/x86/realmode/rm/trampoline_common.S |  12 +-
 arch/x86/realmode/rm/wakemain.c          |  14 +-
 arch/x86/virt/tdxcall.S                  |  95 ++++
 include/linux/cc_platform.h              |  10 +
 kernel/cpu.c                             |   7 +
 57 files changed, 2074 insertions(+), 159 deletions(-)
 create mode 100644 Documentation/x86/tdx.rst
 create mode 100644 arch/x86/boot/compressed/tdcall.S
 create mode 100644 arch/x86/boot/compressed/tdx.c
 create mode 100644 arch/x86/boot/compressed/tdx.h
 create mode 100644 arch/x86/boot/io.h
 create mode 100644 arch/x86/coco/tdcall.S
 create mode 100644 arch/x86/coco/tdx.c
 create mode 100644 arch/x86/include/asm/shared/io.h
 create mode 100644 arch/x86/include/asm/shared/tdx.h
 create mode 100644 arch/x86/include/asm/tdx.h
 create mode 100644 arch/x86/virt/tdxcall.S

-- 
2.34.1

