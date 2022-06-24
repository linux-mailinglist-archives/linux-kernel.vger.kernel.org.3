Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C6B55901D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 06:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiFXEoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiFXEn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:43:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8763753A57;
        Thu, 23 Jun 2022 21:43:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4787612FC;
        Thu, 23 Jun 2022 21:43:55 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 961313F66F;
        Thu, 23 Jun 2022 21:43:47 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     hch@infradead.org, christophe.leroy@csgroup.eu,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org, openrisc@lists.librecores.org,
        linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 00/26] mm/mmap: Drop __SXXX/__PXXX macros from across platforms
Date:   Fri, 24 Jun 2022 10:13:13 +0530
Message-Id: <20220624044339.1533882-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__SXXX/__PXXX macros is an unnecessary abstraction layer in creating the
generic protection_map[] array which is used for vm_get_page_prot(). This
abstraction layer can be avoided, if the platforms just define the array
protection_map[] for all possible vm_flags access permission combinations
and also export vm_get_page_prot() implementation.

This series drops __SXXX/__PXXX macros from across platforms in the tree.
First it build protects generic protection_map[] array with '#ifdef __P000'
and moves it inside platforms which enable ARCH_HAS_VM_GET_PAGE_PROT. Later
this build protects same array with '#ifdef ARCH_HAS_VM_GET_PAGE_PROT' and
moves inside remaining platforms while enabling ARCH_HAS_VM_GET_PAGE_PROT.
This adds a new macro DECLARE_VM_GET_PAGE_PROT defining the current generic
vm_get_page_prot(), in order for it to be reused on platforms that do not
require custom implementation. Finally, ARCH_HAS_VM_GET_PAGE_PROT can just
be dropped, as all platforms now define and export vm_get_page_prot(), via
looking up a private and static protection_map[] array. protection_map[]
data type is the following for all platforms without deviation (except the
powerpc one which is shared between 32 and 64 bit platforms), keeping it
unchanged for now.

static pgprot_t protection_map[16] __ro_after_init

This series applies on v5.19-rc3 and has been build tested for multiple
platforms. While here it has dropped off all previous tags from folks after
the current restructuring. Series common CC list has been expanded to cover
all impacted platforms for wider reach.

- Anshuman

Changes in V4:

- Both protection_map[] and vm_get_page_prot() moves inside all platforms
- Split patches to create modular changes for individual platforms
- Add macro DECLARE_VM_GET_PAGE_PROT defining generic vm_get_page_prot()
- Drop ARCH_HAS_VM_GET_PAGE_PROT

Changes in V3:

https://lore.kernel.org/all/20220616040924.1022607-1-anshuman.khandual@arm.com/

- Fix build issues on powerpc and riscv

Changes in V2:

https://lore.kernel.org/all/20220613053354.553579-1-anshuman.khandual@arm.com/

- Add 'const' identifier to protection_map[] on powerpc
- Dropped #ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT check from sparc 32
- Dropped protection_map[] init from sparc 64
- Dropped all new platform changes subscribing ARCH_HAS_VM_GET_PAGE_PROT
- Added a second patch which moves generic protection_map[] array into
  all remaining platforms (!ARCH_HAS_VM_GET_PAGE_PROT)

Changes in V1:

https://lore.kernel.org/all/20220603101411.488970-1-anshuman.khandual@arm.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: x86@kernel.org
Cc: openrisc@lists.librecores.org
Cc: linux-xtensa@linux-xtensa.org
Cc: linux-csky@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-um@lists.infradead.org
Cc: linux-sh@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (26):
  mm/mmap: Build protect protection_map[] with __P000
  mm/mmap: Define DECLARE_VM_GET_PAGE_PROT
  powerpc/mm: Move protection_map[] inside the platform
  sparc/mm: Move protection_map[] inside the platform
  arm64/mm: Move protection_map[] inside the platform
  x86/mm: Move protection_map[] inside the platform
  mm/mmap: Build protect protection_map[] with ARCH_HAS_VM_GET_PAGE_PROT
  microblaze/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  loongarch/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  openrisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  extensa/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  hexagon/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  parisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  alpha/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  riscv/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  csky/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  s390/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  ia64/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mips/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  arc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  um/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  sh/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mm/mmap: Drop ARCH_HAS_VM_GET_PAGE_PROT

 arch/alpha/include/asm/pgtable.h          | 17 -------
 arch/alpha/mm/init.c                      | 22 +++++++++
 arch/arc/include/asm/pgtable-bits-arcv2.h | 18 --------
 arch/arc/mm/mmap.c                        | 20 +++++++++
 arch/arm/include/asm/pgtable.h            | 17 -------
 arch/arm/lib/uaccess_with_memcpy.c        |  2 +-
 arch/arm/mm/mmu.c                         | 20 +++++++++
 arch/arm64/Kconfig                        |  1 -
 arch/arm64/include/asm/pgtable-prot.h     | 18 --------
 arch/arm64/mm/mmap.c                      | 21 +++++++++
 arch/csky/include/asm/pgtable.h           | 18 --------
 arch/csky/mm/init.c                       | 20 +++++++++
 arch/hexagon/include/asm/pgtable.h        | 27 -----------
 arch/hexagon/mm/init.c                    | 42 +++++++++++++++++
 arch/ia64/include/asm/pgtable.h           | 18 --------
 arch/ia64/mm/init.c                       | 28 +++++++++++-
 arch/loongarch/include/asm/pgtable-bits.h | 19 --------
 arch/loongarch/mm/cache.c                 | 46 +++++++++++++++++++
 arch/m68k/include/asm/mcf_pgtable.h       | 54 ----------------------
 arch/m68k/include/asm/motorola_pgtable.h  | 22 ---------
 arch/m68k/include/asm/sun3_pgtable.h      | 17 -------
 arch/m68k/mm/mcfmmu.c                     | 55 +++++++++++++++++++++++
 arch/m68k/mm/motorola.c                   | 20 +++++++++
 arch/m68k/mm/sun3mmu.c                    | 20 +++++++++
 arch/microblaze/include/asm/pgtable.h     | 17 -------
 arch/microblaze/mm/init.c                 | 20 +++++++++
 arch/mips/include/asm/pgtable.h           | 22 ---------
 arch/mips/mm/cache.c                      |  3 ++
 arch/nios2/include/asm/pgtable.h          | 16 -------
 arch/nios2/mm/init.c                      | 20 +++++++++
 arch/openrisc/include/asm/pgtable.h       | 18 --------
 arch/openrisc/mm/init.c                   | 20 +++++++++
 arch/parisc/include/asm/pgtable.h         | 18 --------
 arch/parisc/mm/init.c                     | 20 +++++++++
 arch/powerpc/Kconfig                      |  1 -
 arch/powerpc/include/asm/pgtable.h        | 20 +--------
 arch/powerpc/mm/pgtable.c                 | 24 ++++++++++
 arch/riscv/include/asm/pgtable.h          | 20 ---------
 arch/riscv/mm/init.c                      | 20 +++++++++
 arch/s390/include/asm/pgtable.h           | 17 -------
 arch/s390/mm/mmap.c                       | 20 +++++++++
 arch/sh/include/asm/pgtable.h             | 17 -------
 arch/sh/mm/mmap.c                         | 20 +++++++++
 arch/sparc/Kconfig                        |  1 -
 arch/sparc/include/asm/pgtable_32.h       | 19 --------
 arch/sparc/include/asm/pgtable_64.h       | 19 --------
 arch/sparc/mm/init_32.c                   | 20 +++++++++
 arch/sparc/mm/init_64.c                   |  3 ++
 arch/um/include/asm/pgtable.h             | 17 -------
 arch/um/kernel/mem.c                      | 20 +++++++++
 arch/x86/Kconfig                          |  1 -
 arch/x86/include/asm/pgtable_types.h      | 19 --------
 arch/x86/mm/mem_encrypt_amd.c             |  7 ++-
 arch/x86/mm/pgprot.c                      | 27 +++++++++++
 arch/x86/um/mem_32.c                      |  2 +-
 arch/xtensa/include/asm/pgtable.h         | 18 --------
 arch/xtensa/mm/init.c                     | 20 +++++++++
 include/linux/mm.h                        |  9 +++-
 mm/Kconfig                                |  3 --
 mm/mmap.c                                 | 27 -----------
 60 files changed, 584 insertions(+), 543 deletions(-)

-- 
2.25.1

