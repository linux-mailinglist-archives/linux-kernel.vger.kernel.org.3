Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F94154D91D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 06:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358588AbiFPEJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 00:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347756AbiFPEJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 00:09:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17BA856F94
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:09:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C88DD12FC;
        Wed, 15 Jun 2022 21:09:34 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93C323F7F5;
        Wed, 15 Jun 2022 21:09:32 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     hch@infradead.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/2] mm/mmap: Drop __SXXX/__PXXX macros from across platforms
Date:   Thu, 16 Jun 2022 09:39:22 +0530
Message-Id: <20220616040924.1022607-1-anshuman.khandual@arm.com>
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
protection_map[] for all possible vm_flags access permission combinations.

This series drops __SXXX/__PXXX macros from across platforms in the tree.
First it makes protection_map[] array private (static) on platforms which
enable ARCH_HAS_VM_GET_PAGE_PROT, later moves protection_map[] array into
arch for all remaining platforms (!ARCH_HAS_VM_GET_PAGE_PROT), dropping
the generic one. In the process __SXXX/__PXXX macros become redundant and
thus get dropped off completely. I understand that the diff stat is large
here, but please do suggest if there is a better way. This series applies
on v5.19-rc1 and has been build tested for multiple platforms.

The CC list for this series has been reduced to just minimum, until there
is some initial agreement.

- Anshuman

Changes in V3:

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

https://lore.kernel.org/linux-mm/20220603101411.488970-1-anshuman.khandual@arm.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (2):
  mm/mmap: Restrict generic protection_map[] array visibility
  mm/mmap: Drop generic protection_map[] array

 arch/alpha/include/asm/pgtable.h          | 17 -------
 arch/alpha/mm/init.c                      | 21 +++++++++
 arch/arc/include/asm/pgtable-bits-arcv2.h | 18 --------
 arch/arc/mm/mmap.c                        | 19 ++++++++
 arch/arm/include/asm/pgtable.h            | 17 -------
 arch/arm/lib/uaccess_with_memcpy.c        |  2 +-
 arch/arm/mm/mmu.c                         | 19 ++++++++
 arch/arm64/include/asm/pgtable-prot.h     | 18 --------
 arch/arm64/mm/mmap.c                      | 21 +++++++++
 arch/csky/include/asm/pgtable.h           | 18 --------
 arch/csky/mm/init.c                       | 19 ++++++++
 arch/hexagon/include/asm/pgtable.h        | 27 ------------
 arch/hexagon/mm/init.c                    | 41 +++++++++++++++++
 arch/ia64/include/asm/pgtable.h           | 18 --------
 arch/ia64/mm/init.c                       | 27 +++++++++++-
 arch/loongarch/include/asm/pgtable-bits.h | 19 --------
 arch/loongarch/mm/cache.c                 | 45 +++++++++++++++++++
 arch/m68k/include/asm/mcf_pgtable.h       | 54 -----------------------
 arch/m68k/include/asm/motorola_pgtable.h  | 22 ---------
 arch/m68k/include/asm/sun3_pgtable.h      | 17 -------
 arch/m68k/mm/mcfmmu.c                     | 54 +++++++++++++++++++++++
 arch/m68k/mm/motorola.c                   | 19 ++++++++
 arch/m68k/mm/sun3mmu.c                    | 19 ++++++++
 arch/microblaze/include/asm/pgtable.h     | 17 -------
 arch/microblaze/mm/init.c                 | 19 ++++++++
 arch/mips/include/asm/pgtable.h           | 22 ---------
 arch/mips/mm/cache.c                      |  2 +
 arch/nios2/include/asm/pgtable.h          | 16 -------
 arch/nios2/mm/init.c                      | 19 ++++++++
 arch/openrisc/include/asm/pgtable.h       | 18 --------
 arch/openrisc/mm/init.c                   | 19 ++++++++
 arch/parisc/include/asm/pgtable.h         | 18 --------
 arch/parisc/mm/init.c                     | 19 ++++++++
 arch/powerpc/include/asm/pgtable.h        | 18 --------
 arch/powerpc/mm/book3s64/pgtable.c        |  6 +++
 arch/powerpc/mm/pgtable.c                 | 20 +++++++++
 arch/riscv/include/asm/pgtable.h          | 20 ---------
 arch/riscv/mm/init.c                      | 19 ++++++++
 arch/s390/include/asm/pgtable.h           | 17 -------
 arch/s390/mm/mmap.c                       | 19 ++++++++
 arch/sh/include/asm/pgtable.h             | 17 -------
 arch/sh/mm/mmap.c                         | 19 ++++++++
 arch/sparc/include/asm/pgtable_32.h       | 19 --------
 arch/sparc/include/asm/pgtable_64.h       | 19 --------
 arch/sparc/mm/init_32.c                   | 19 ++++++++
 arch/sparc/mm/init_64.c                   |  3 ++
 arch/um/include/asm/pgtable.h             | 17 -------
 arch/um/kernel/mem.c                      | 19 ++++++++
 arch/x86/include/asm/pgtable_types.h      | 19 --------
 arch/x86/mm/pgprot.c                      | 19 ++++++++
 arch/x86/um/mem_32.c                      |  2 +-
 arch/xtensa/include/asm/pgtable.h         | 18 --------
 arch/xtensa/mm/init.c                     | 19 ++++++++
 include/linux/mm.h                        |  2 +
 mm/mmap.c                                 | 19 --------
 55 files changed, 547 insertions(+), 522 deletions(-)

-- 
2.25.1

