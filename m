Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5584982DB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbiAXPCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:02:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:18176 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240003AbiAXPCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036544; x=1674572544;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gQWGnBYzKSd+ZzDSCW3QSEadYERL5hb2FvCp0qoNDBk=;
  b=G5Z5Pc1IYnFbpnQlLg0vLgA6W8APx0/JHmMZ41Ks4oHnLljwC7wjktCG
   bGEcBDvyeBTzCQAIF/q+OU4QyOSY/Tcs6uf/+7ZxeK7AL78FgQx8IF9b3
   Eph2DRA7c5yskCsd/8ud7Xu9w9+qx7JPmDFzDDtivqctIre4b7SzBSOig
   kO7vIvKLrnqRImFV6R/2JqmSNlkCQr5mg01ys49S/h+J7YpBTMKT3rRG9
   K3cwGpSTe1tLEGgnWzoc+1rTnzvkL7VP4SVMOVQ7/gZbIagNBKEDBd+S7
   xW/xrvi2uM4EDD4vaOpAJ6aFJ3JOB9Xtb1cBq3ccJFtdon+mQj+RPx5DD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="309382053"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="309382053"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="768703862"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jan 2022 07:02:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 430E0178; Mon, 24 Jan 2022 17:02:19 +0200 (EET)
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
Subject: [PATCHv2 00/29] TDX Guest: TDX core support
Date:   Mon, 24 Jan 2022 18:01:46 +0300
Message-Id: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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

https://lore.kernel.org/r/20211214150304.62613-1-kirill.shutemov@linux.intel.com

Changes from v1:
  - Rebased to tip/master (94985da003a4).
  - Address feedback from Borislav and Josh.
  - Wire up KVM hypercalls. Needed to send IPI.
Andi Kleen (1):
  x86/tdx: Early boot handling of port I/O

Isaku Yamahata (1):
  x86/tdx: ioapic: Add shared bit for IOAPIC base address

Kirill A. Shutemov (16):
  x86/traps: Add #VE support for TDX guest
  x86/tdx: Add HLT support for TDX guests
  x86/tdx: Add MSR support for TDX guests
  x86/tdx: Handle CPUID via #VE
  x86/tdx: Handle in-kernel MMIO
  x86: Consolidate port I/O helpers
  x86/boot: Allow to hook up alternative port I/O helpers
  x86/boot/compressed: Support TDX guest port I/O at decompression time
  x86/tdx: Get page shared bit info from the TDX module
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
  x86/tdx: Add port I/O emulation
  x86/tdx: Wire up KVM hypercalls
  x86/acpi, x86/boot: Add multiprocessor wake-up support
  x86/topology: Disable CPU online/offline control for TDX guests
  Documentation/x86: Document TDX kernel architecture

Sean Christopherson (2):
  x86/boot: Add a trampoline for booting APs via firmware handoff
  x86/boot: Avoid #VE during boot for TDX platforms

 Documentation/x86/index.rst              |   1 +
 Documentation/x86/tdx.rst                | 194 ++++++++
 arch/x86/Kconfig                         |  15 +
 arch/x86/boot/a20.c                      |  14 +-
 arch/x86/boot/boot.h                     |  35 +-
 arch/x86/boot/compressed/Makefile        |   1 +
 arch/x86/boot/compressed/head_64.S       |  25 +-
 arch/x86/boot/compressed/misc.c          |  26 +-
 arch/x86/boot/compressed/misc.h          |   4 +-
 arch/x86/boot/compressed/pgtable.h       |   2 +-
 arch/x86/boot/compressed/tdcall.S        |   3 +
 arch/x86/boot/compressed/tdx.c           |  88 ++++
 arch/x86/boot/compressed/tdx.h           |  16 +
 arch/x86/boot/cpuflags.c                 |   3 +-
 arch/x86/boot/cpuflags.h                 |   1 +
 arch/x86/boot/early_serial_console.c     |  28 +-
 arch/x86/boot/io.h                       |  28 ++
 arch/x86/boot/main.c                     |   4 +
 arch/x86/boot/pm.c                       |  10 +-
 arch/x86/boot/tty.c                      |   4 +-
 arch/x86/boot/video-vga.c                |   6 +-
 arch/x86/boot/video.h                    |   8 +-
 arch/x86/include/asm/acenv.h             |  16 +-
 arch/x86/include/asm/apic.h              |   7 +
 arch/x86/include/asm/cpufeatures.h       |   1 +
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/idtentry.h          |   4 +
 arch/x86/include/asm/io.h                |  22 +-
 arch/x86/include/asm/kvm_para.h          |  22 +
 arch/x86/include/asm/mem_encrypt.h       |   8 +
 arch/x86/include/asm/pgtable.h           |  19 +-
 arch/x86/include/asm/realmode.h          |   1 +
 arch/x86/include/asm/set_memory.h        |   1 -
 arch/x86/include/asm/shared/io.h         |  32 ++
 arch/x86/include/asm/shared/tdx.h        |  30 ++
 arch/x86/include/asm/tdx.h               |  92 ++++
 arch/x86/kernel/Makefile                 |   4 +
 arch/x86/kernel/acpi/boot.c              | 114 +++++
 arch/x86/kernel/apic/apic.c              |  10 +
 arch/x86/kernel/apic/io_apic.c           |  18 +-
 arch/x86/kernel/asm-offsets.c            |  20 +
 arch/x86/kernel/cc_platform.c            |  43 +-
 arch/x86/kernel/head64.c                 |   7 +
 arch/x86/kernel/head_64.S                |  24 +-
 arch/x86/kernel/idt.c                    |   3 +
 arch/x86/kernel/process.c                |   5 +
 arch/x86/kernel/smpboot.c                |  12 +-
 arch/x86/kernel/tdcall.S                 | 300 ++++++++++++
 arch/x86/kernel/tdx.c                    | 592 +++++++++++++++++++++++
 arch/x86/kernel/traps.c                  | 110 +++++
 arch/x86/mm/ioremap.c                    |   5 +
 arch/x86/mm/mem_encrypt.c                |   9 +-
 arch/x86/mm/mem_encrypt_amd.c            |  10 +-
 arch/x86/mm/pat/set_memory.c             |  44 +-
 arch/x86/realmode/rm/header.S            |   1 +
 arch/x86/realmode/rm/trampoline_64.S     |  63 ++-
 arch/x86/realmode/rm/trampoline_common.S |  12 +-
 arch/x86/realmode/rm/wakemain.c          |  14 +-
 include/linux/cc_platform.h              |  19 +
 kernel/cpu.c                             |   3 +
 60 files changed, 2079 insertions(+), 142 deletions(-)
 create mode 100644 Documentation/x86/tdx.rst
 create mode 100644 arch/x86/boot/compressed/tdcall.S
 create mode 100644 arch/x86/boot/compressed/tdx.c
 create mode 100644 arch/x86/boot/compressed/tdx.h
 create mode 100644 arch/x86/boot/io.h
 create mode 100644 arch/x86/include/asm/shared/io.h
 create mode 100644 arch/x86/include/asm/shared/tdx.h
 create mode 100644 arch/x86/include/asm/tdx.h
 create mode 100644 arch/x86/kernel/tdcall.S
 create mode 100644 arch/x86/kernel/tdx.c

-- 
2.34.1

