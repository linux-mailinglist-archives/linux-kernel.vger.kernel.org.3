Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6700F4DA7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352497AbiCPCLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345217AbiCPCLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:11:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE8B5C86C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647396597; x=1678932597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=G95Dj9YxgCWSyZF35CrXM1b7f36RfVn1lCSmpy9plVQ=;
  b=OSqPP3HGu6cszfxkXj11Fbu+KFNh652pSV1rf2l/T0fztoK2Ph8ZJ8c/
   Fj9L5xVP4+NrJ1DDEzoayG6wAGRDIzmji3d5aRRAVlmYK6bDCAe3lvY21
   B1oepVhBPvjRdK2Nwe4c+hzyND7fos+2/NI1JPm+AxvFyOKZ8VQYXwb62
   cXO3xSfYdNNCBCB5MQK698r9N/u96LYBKOy2GfCb3XMiMUGPsslXww3b8
   UIDMpUQxaBXrpTq40A/IEawAxtCSiSFuoLWIuc4c6ii7OnVSj9qF97Llj
   sZM5yVlpCbnuNV1BwBp1aJq/mmOZ0jZ66bv9kTYO2XsOjeIDl9B3NDTlR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="243922863"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="243922863"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="498259501"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2022 19:09:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7D517192; Wed, 16 Mar 2022 04:10:09 +0200 (EET)
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
Subject: [PATCHv6 00/30] TDX Guest: TDX core support
Date:   Wed, 16 Mar 2022 05:08:26 +0300
Message-Id: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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

https://lore.kernel.org/r/20220224155630.52734-1-kirill.shutemov@linux.intel.com

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
  x86/kvm: Make SWIOTLB buffer shared for TD guest
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
 arch/x86/boot/compressed/tdx.c           | 105 ++++
 arch/x86/boot/compressed/tdx.h           |  15 +
 arch/x86/boot/cpuflags.c                 |   3 +-
 arch/x86/boot/cpuflags.h                 |   1 +
 arch/x86/boot/io.h                       |  50 ++
 arch/x86/boot/main.c                     |   4 +
 arch/x86/coco/Makefile                   |   2 +
 arch/x86/coco/core.c                     |  22 +-
 arch/x86/coco/tdx/Makefile               |   3 +
 arch/x86/coco/tdx/tdcall.S               | 204 +++++++
 arch/x86/coco/tdx/tdx.c                  | 702 +++++++++++++++++++++++
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
 arch/x86/include/asm/tdx.h               |  90 +++
 arch/x86/kernel/acpi/boot.c              | 118 ++++
 arch/x86/kernel/apic/apic.c              |  10 +
 arch/x86/kernel/apic/io_apic.c           |  18 +-
 arch/x86/kernel/asm-offsets.c            |  17 +
 arch/x86/kernel/head64.c                 |   7 +
 arch/x86/kernel/head_64.S                |  28 +-
 arch/x86/kernel/idt.c                    |   3 +
 arch/x86/kernel/process.c                |   4 +
 arch/x86/kernel/smpboot.c                |  12 +-
 arch/x86/kernel/traps.c                  | 141 ++++-
 arch/x86/mm/ioremap.c                    |   5 +
 arch/x86/mm/mem_encrypt.c                |   9 +-
 arch/x86/realmode/rm/header.S            |   1 +
 arch/x86/realmode/rm/trampoline_64.S     |  57 +-
 arch/x86/realmode/rm/trampoline_common.S |  12 +-
 arch/x86/realmode/rm/wakemain.c          |   4 +
 arch/x86/virt/vmx/tdx/tdxcall.S          |  94 +++
 include/linux/cc_platform.h              |  10 +
 kernel/cpu.c                             |   7 +
 52 files changed, 2132 insertions(+), 118 deletions(-)
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

