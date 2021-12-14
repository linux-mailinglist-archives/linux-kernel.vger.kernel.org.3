Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F3D4745CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhLNPDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:03:11 -0500
Received: from mga07.intel.com ([134.134.136.100]:58261 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235156AbhLNPDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:03:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="302372408"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="302372408"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 07:03:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="609896234"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2021 07:03:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 155B5352; Tue, 14 Dec 2021 17:03:08 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 00/26] TDX Guest: TDX core support
Date:   Tue, 14 Dec 2021 18:02:38 +0300
Message-Id: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Intel's Trust Domain Extensions (TDX) protects confidential guest VMs
from the host and physical attacks by isolating the guest register
state and by encrypting the guest memory. In TDX, a special TDX module
sits between the host and the guest, and runs in a special mode and
manages the guest/host separation.

More details of TDX guests can be found in Documentation/x86/tdx.rst.

This cover letter is structured as below:

1. Previous versions/changes  : Contains details about previous submission
                                and its patchset structure.
2. Current Patchset Structure : Covers details about the current patchset
                                 and its structure.
3. Patch-set dependency       : Covers info about this patch series
                                 dependencies.
4. SEV/TDX comparison         : Details about SEV and TDX guest differences
                                 and similarities
5: TDX/VM/comparison          : Compares TDX guests with regular VMs

Previous versions/changes:
--------------------------

Previously, the TDX patch series has been submitted into 4 different
patch sets. You can find them in the following links. Due to review
feedback and to make the next review easier, we have re-organized
the patchsets into two sets (cleanup/core). Details are explained
in the "current patch-set structure" section.

Initial support:
https://lore.kernel.org/lkml/20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com/
#VE support:
https://lore.kernel.org/lkml/20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com/
Boot support:
https://lore.kernel.org/lkml/20211005230550.1819406-1-sathyanarayanan.kuppuswamy@linux.intel.com/
Shared-mm support:
https://lore.kernel.org/lkml/20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com/

Current Patch-set Structure:
----------------------------

The minimal code that can run real userspace is spread across 30
patches in 2 sets:

1. TDX Infrastructure/cleanup set (4 patches)
2. TDX core support (26 patches)

"Infrastructure/cleanup set" includes infrastructure changes made in
generic code (like for sharing with AMD SEV code) to add TDX guest
support. It was posted as 2 different patch series (links are included
below).

Share common features between AMD SEV / TDX guest:
https://lore.kernel.org/r/20211206135505.75045-1-kirill.shutemov@linux.intel.com
Skip CSTAR MSR on Intel:
https://lore.kernel.org/lkml/20211116005103.2929441-1-sathyanarayanan.kuppuswamy@linux.intel.com/

"TDX core support" patches add TDX infrastructure in Linux kernel (like
#VE support for I/O, MMIO, CPUID, etc), detection support, some boot
fixes.

This series adds TDX core support.

Patch-set dependency:
---------------------
This series also has dependency on MMIO decoding patchset.

https://lore.kernel.org/lkml/20211130184933.31005-1-kirill.shutemov@linux.intel.com/

It is also dependent on the "TDX Infrastructure/cleanup set".

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

Andi Kleen (1):
  x86/tdx: Early boot handling of port I/O

Isaku Yamahata (1):
  x86/tdx: ioapic: Add shared bit for IOAPIC base address

Kirill A. Shutemov (13):
  x86/traps: Add #VE support for TDX guest
  x86/tdx: Add HLT support for TDX guests (#VE approach)
  x86/tdx: Add MSR support for TDX guests
  x86/tdx: Handle CPUID via #VE
  x86/tdx: Handle in-kernel MMIO
  x86/tdx: Get page shared bit info from the TDX Module
  x86/tdx: Exclude shared bit from __PHYSICAL_MASK
  x86/tdx: Make pages shared in ioremap()
  x86/tdx: Add helper to convert memory between shared and private
  x86/mm/cpa: Add support for TDX shared memory
  x86/kvm: Use bounce buffers for TD guest
  ACPICA: Avoid cache flush on TDX guest
  x86/tdx: Warn about unexpected WBINVD

Kuppuswamy Sathyanarayanan (9):
  x86/tdx: Detect running as a TDX guest in early boot
  x86/tdx: Extend the cc_platform_has() API to support TDX guests
  x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper
    functions
  x86/tdx: Detect TDX at early kernel decompression time
  x86/tdx: Support TDX guest port I/O at decompression time
  x86/tdx: Add port I/O emulation
  x86/acpi, x86/boot: Add multiprocessor wake-up support
  x86/topology: Disable CPU online/offline control for TDX guests
  Documentation/x86: Document TDX kernel architecture

Sean Christopherson (2):
  x86/boot: Add a trampoline for booting APs via firmware handoff
  x86/boot: Avoid #VE during boot for TDX platforms

 Documentation/x86/index.rst              |   1 +
 Documentation/x86/tdx.rst                | 194 ++++++++
 arch/x86/Kconfig                         |  16 +
 arch/x86/boot/compressed/Makefile        |   2 +
 arch/x86/boot/compressed/head_64.S       |  25 +-
 arch/x86/boot/compressed/misc.c          |   8 +
 arch/x86/boot/compressed/misc.h          |   6 +
 arch/x86/boot/compressed/pgtable.h       |   2 +-
 arch/x86/boot/compressed/tdcall.S        |   3 +
 arch/x86/boot/compressed/tdx.c           |  33 ++
 arch/x86/boot/compressed/tdx.h           |  60 +++
 arch/x86/boot/cpuflags.c                 |  13 +-
 arch/x86/boot/cpuflags.h                 |   2 +
 arch/x86/include/asm/acenv.h             |  16 +-
 arch/x86/include/asm/apic.h              |   7 +
 arch/x86/include/asm/cpufeatures.h       |   1 +
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/idtentry.h          |   4 +
 arch/x86/include/asm/io.h                |  16 +-
 arch/x86/include/asm/pgtable.h           |  19 +-
 arch/x86/include/asm/realmode.h          |   1 +
 arch/x86/include/asm/tdx.h               | 110 +++++
 arch/x86/kernel/Makefile                 |   4 +
 arch/x86/kernel/acpi/boot.c              | 114 +++++
 arch/x86/kernel/apic/apic.c              |  10 +
 arch/x86/kernel/apic/io_apic.c           |  18 +-
 arch/x86/kernel/asm-offsets.c            |  20 +
 arch/x86/kernel/cc_platform.c            |  20 +-
 arch/x86/kernel/head64.c                 |   7 +
 arch/x86/kernel/head_64.S                |  24 +-
 arch/x86/kernel/idt.c                    |   3 +
 arch/x86/kernel/process.c                |   7 +
 arch/x86/kernel/smpboot.c                |  12 +-
 arch/x86/kernel/tdcall.S                 | 302 ++++++++++++
 arch/x86/kernel/tdx.c                    | 586 +++++++++++++++++++++++
 arch/x86/kernel/traps.c                  |  79 +++
 arch/x86/mm/ioremap.c                    |   5 +
 arch/x86/mm/mem_encrypt.c                |  36 +-
 arch/x86/mm/pat/set_memory.c             |  39 +-
 arch/x86/realmode/rm/header.S            |   1 +
 arch/x86/realmode/rm/trampoline_64.S     |  63 ++-
 arch/x86/realmode/rm/trampoline_common.S |  12 +-
 include/linux/cc_platform.h              |  19 +
 kernel/cpu.c                             |   3 +
 44 files changed, 1892 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/x86/tdx.rst
 create mode 100644 arch/x86/boot/compressed/tdcall.S
 create mode 100644 arch/x86/boot/compressed/tdx.c
 create mode 100644 arch/x86/boot/compressed/tdx.h
 create mode 100644 arch/x86/include/asm/tdx.h
 create mode 100644 arch/x86/kernel/tdcall.S
 create mode 100644 arch/x86/kernel/tdx.c

-- 
2.32.0
