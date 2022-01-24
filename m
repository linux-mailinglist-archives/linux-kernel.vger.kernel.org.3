Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8A9498002
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbiAXM5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:57:16 -0500
Received: from foss.arm.com ([217.140.110.172]:32822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbiAXM5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:57:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4B17D6E;
        Mon, 24 Jan 2022 04:57:09 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.43.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 57A183F774;
        Mon, 24 Jan 2022 04:57:07 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, hch@infradead.org,
        akpm@linux-foundation.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V1 00/31] mm/mmap: Drop protection_map[] and platform's __SXXX/__PXXX requirements
Date:   Mon, 24 Jan 2022 18:26:37 +0530
Message-Id: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

protection_map[] is an array based construct that translates given vm_flags
combination. This array contains page protection map, which is populated by
the platform via [__S000 .. __S111] and [__P000 .. __P111] exported macros.
Primary usage for protection_map[] is for vm_get_page_prot(), which is used
to determine page protection value for a given vm_flags. vm_get_page_prot()
implementation, could again call platform overrides arch_vm_get_page_prot()
and arch_filter_pgprot(). Some platforms override protection_map[] that was
originally built with __SXXX/__PXXX with different runtime values.

Currently there are multiple layers of abstraction i.e __SXXX/__PXXX macros
, protection_map[], arch_vm_get_page_prot() and arch_filter_pgprot() built
between the platform and generic MM, finally defining vm_get_page_prot().

Hence this series proposes to drop all these abstraction levels and instead
just move the responsibility of defining vm_get_page_prot() to the platform
itself making it clean and simple.

This first introduces ARCH_HAS_VM_GET_PAGE_PROT which enables the platforms
to define custom vm_get_page_prot(). This starts converting platforms that
either change protection_map[] or define the overrides arch_filter_pgprot()
or arch_vm_get_page_prot() which enables for those constructs to be dropped
off completely. This series then converts remaining platforms which enables
for __SXXX/__PXXX constructs to be dropped off completely. Finally it drops
the generic vm_get_page_prot() and then ARCH_HAS_VM_GET_PAGE_PROT as every
platform now defines their own vm_get_page_prot().

The last patch demonstrates how vm_flags combination indices can be defined
as macros and be replaces across all platforms (if required, not done yet).

The series has been inspired from an earlier discuss with Christoph Hellwig

https://lore.kernel.org/all/1632712920-8171-1-git-send-email-anshuman.khandual@arm.com/

This series applies on 5.17-rc1 after the following patch.

https://lore.kernel.org/all/1643004823-16441-1-git-send-email-anshuman.khandual@arm.com/

This has been cross built for multiple platforms. I would like to get some
early feed back on this proposal. All reviews and suggestions welcome.

Hello Christoph,

I have taken the liberty to preserve your authorship on the x86 patch which
is borrowed almost as is from our earlier discussion. I have also added you
as 'Suggested-by:' on the patch that adds config ARCH_HAS_VM_GET_PAGE_PROT.
Nonetheless please feel free to correct me for any other missing authorship
attributes I should have added. Thank you.

- Anshuman

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (30):
  mm/debug_vm_pgtable: Directly use vm_get_page_prot()
  mm/mmap: Clarify protection_map[] indices
  mm/mmap: Add new config ARCH_HAS_VM_GET_PAGE_PROT
  powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  arm64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mips/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mm/mmap: Drop protection_map[]
  mm/mmap: Drop arch_filter_pgprot()
  mm/mmap: Drop arch_vm_get_page_pgprot()
  s390/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  riscv/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  alpha/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  sh/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  arc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  csky/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  extensa/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  parisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  openrisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  um/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  microblaze/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  hexagon/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  nds32/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  ia64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mm/mmap: Drop generic vm_get_page_prot()
  mm/mmap: Drop ARCH_HAS_VM_GET_PAGE_PROT
  mm/mmap: Define macros for vm_flags access permission combinations

Christoph Hellwig (1):
  x86/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT

 arch/alpha/include/asm/pgtable.h          | 17 -----
 arch/alpha/mm/init.c                      | 41 +++++++++++
 arch/arc/include/asm/pgtable-bits-arcv2.h | 17 -----
 arch/arc/mm/mmap.c                        | 41 +++++++++++
 arch/arm/include/asm/pgtable.h            | 18 -----
 arch/arm/mm/mmu.c                         | 50 +++++++++++--
 arch/arm64/Kconfig                        |  1 -
 arch/arm64/include/asm/mman.h             |  3 +-
 arch/arm64/include/asm/pgtable-prot.h     | 18 -----
 arch/arm64/include/asm/pgtable.h          |  2 +-
 arch/arm64/mm/mmap.c                      | 50 +++++++++++++
 arch/csky/include/asm/pgtable.h           | 18 -----
 arch/csky/mm/init.c                       | 41 +++++++++++
 arch/hexagon/include/asm/pgtable.h        | 24 -------
 arch/hexagon/mm/init.c                    | 42 +++++++++++
 arch/ia64/include/asm/pgtable.h           | 17 -----
 arch/ia64/mm/init.c                       | 43 ++++++++++-
 arch/m68k/include/asm/mcf_pgtable.h       | 59 ---------------
 arch/m68k/include/asm/motorola_pgtable.h  | 22 ------
 arch/m68k/include/asm/sun3_pgtable.h      | 22 ------
 arch/m68k/mm/init.c                       | 87 +++++++++++++++++++++++
 arch/m68k/mm/motorola.c                   | 44 +++++++++++-
 arch/microblaze/include/asm/pgtable.h     | 17 -----
 arch/microblaze/mm/init.c                 | 41 +++++++++++
 arch/mips/include/asm/pgtable.h           | 22 ------
 arch/mips/mm/cache.c                      | 65 ++++++++++-------
 arch/nds32/include/asm/pgtable.h          | 17 -----
 arch/nds32/mm/mmap.c                      | 41 +++++++++++
 arch/nios2/include/asm/pgtable.h          | 16 -----
 arch/nios2/mm/init.c                      | 41 +++++++++++
 arch/openrisc/include/asm/pgtable.h       | 18 -----
 arch/openrisc/mm/init.c                   | 41 +++++++++++
 arch/parisc/include/asm/pgtable.h         | 20 ------
 arch/parisc/mm/init.c                     | 41 +++++++++++
 arch/powerpc/include/asm/mman.h           |  3 +-
 arch/powerpc/include/asm/pgtable.h        | 19 -----
 arch/powerpc/mm/mmap.c                    | 47 ++++++++++++
 arch/riscv/include/asm/pgtable.h          | 16 -----
 arch/riscv/mm/init.c                      | 41 +++++++++++
 arch/s390/include/asm/pgtable.h           | 17 -----
 arch/s390/mm/mmap.c                       | 41 +++++++++++
 arch/sh/include/asm/pgtable.h             | 17 -----
 arch/sh/mm/mmap.c                         | 43 +++++++++++
 arch/sparc/include/asm/mman.h             |  1 -
 arch/sparc/include/asm/pgtable_32.h       | 19 -----
 arch/sparc/include/asm/pgtable_64.h       | 19 -----
 arch/sparc/mm/init_32.c                   | 41 +++++++++++
 arch/sparc/mm/init_64.c                   | 71 +++++++++++++-----
 arch/um/include/asm/pgtable.h             | 17 -----
 arch/um/kernel/mem.c                      | 41 +++++++++++
 arch/x86/Kconfig                          |  1 -
 arch/x86/include/asm/pgtable.h            |  5 --
 arch/x86/include/asm/pgtable_types.h      | 19 -----
 arch/x86/include/uapi/asm/mman.h          | 14 ----
 arch/x86/mm/Makefile                      |  2 +-
 arch/x86/mm/mem_encrypt_amd.c             |  4 --
 arch/x86/mm/pgprot.c                      | 71 ++++++++++++++++++
 arch/xtensa/include/asm/pgtable.h         | 18 -----
 arch/xtensa/mm/init.c                     | 41 +++++++++++
 include/linux/mm.h                        | 45 ++++++++++--
 include/linux/mman.h                      |  4 --
 mm/Kconfig                                |  3 -
 mm/debug_vm_pgtable.c                     | 27 +++----
 mm/mmap.c                                 | 22 ------
 64 files changed, 1150 insertions(+), 636 deletions(-)
 create mode 100644 arch/x86/mm/pgprot.c

-- 
2.25.1

