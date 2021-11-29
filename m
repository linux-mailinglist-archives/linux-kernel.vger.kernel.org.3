Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3102F461973
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378237AbhK2OiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:38:09 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:35049 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378768AbhK2Of5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:35:57 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J2nYM1mbHz9sT4;
        Mon, 29 Nov 2021 15:19:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 15BUlw8q236k; Mon, 29 Nov 2021 15:19:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J2nY41Q1Fz9sTD;
        Mon, 29 Nov 2021 15:19:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E64E8B7AA;
        Mon, 29 Nov 2021 15:19:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id p7JTDfw25QcC; Mon, 29 Nov 2021 15:19:36 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A35298B7B2;
        Mon, 29 Nov 2021 15:19:35 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1ATEJQOc959544
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 15:19:26 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1ATEJQDx959542;
        Mon, 29 Nov 2021 15:19:26 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: [PATCH v3 00/10] Convert powerpc to default topdown mmap layout
Date:   Mon, 29 Nov 2021 15:19:14 +0100
Message-Id: <cover.1638195388.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1638195562; l=3086; s=20211009; h=from:subject:message-id; bh=1erw0VtOXrYy2x4dP5mNsIfz576xCuqm2bQLPruXkhk=; b=3RTY7VpGfoPz4K7IC1rD8QLFf/pgmfgabPWELEGQrvMHxz2lCkgGpIv6svnER43DJvXOXX6sLho+ EsNNhJOnBQn919ggCm87sU94wKDLKr8ADD2q/6+R4BjcTodPjOdc
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rebased on top of Nic's v5 series "powerpc: Make hash MMU code build configurable"

This series converts powerpc to default topdown mmap layout.

powerpc provides its own arch_get_unmapped_area() only when
slices are needed, which is only for book3s/64. First part of
the series moves slices into book3s/64 specific directories
and cleans up other subarchitectures.

Then a small modification is done to core mm to allow
powerpc to still provide its own arch_randomize_brk()

Last part converts to default topdown mmap layout.

Changes in v3:
- Fixed missing <linux/elf-randomize.h> in last patch
- Added a patch to move SZ_1T out of drivers/pci/controller/pci-xgene.c

Changes in v2:
- Moved patch 4 before patch 2
- Make generic arch_randomize_brk() __weak
- Added patch 9

Christophe Leroy (10):
  powerpc/mm: Make slice specific to book3s/64
  powerpc/mm: Move vma_mmu_pagesize() and hugetlb_get_unmapped_area() to
    slice.c
  powerpc/mm: Remove CONFIG_PPC_MM_SLICES
  powerpc/mm: Remove asm/slice.h
  powerpc/mm: Call radix__arch_get_unmapped_area() from
    arch_get_unmapped_area()
  mm: Allow arch specific arch_randomize_brk() with
    CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
  powerpc/mm: Convert to default topdown mmap layout
  powerpc/mm: Properly randomise mmap with slices
  sizes.h: Add SZ_1T macro
  powerpc: Simplify and move arch_randomize_brk()

 arch/powerpc/Kconfig                          |   2 +-
 arch/powerpc/include/asm/book3s/64/hash.h     |   7 +-
 arch/powerpc/include/asm/book3s/64/hugetlb.h  |   4 -
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   1 +
 arch/powerpc/include/asm/book3s/64/slice.h    |  18 ++
 arch/powerpc/include/asm/hugetlb.h            |   2 +-
 arch/powerpc/include/asm/paca.h               |   7 -
 arch/powerpc/include/asm/page.h               |   1 -
 arch/powerpc/include/asm/processor.h          |   2 -
 arch/powerpc/include/asm/slice.h              |  46 ----
 arch/powerpc/kernel/paca.c                    |   5 -
 arch/powerpc/kernel/process.c                 |  41 ----
 arch/powerpc/mm/Makefile                      |   3 +-
 arch/powerpc/mm/book3s64/Makefile             |   2 +-
 arch/powerpc/mm/book3s64/hash_utils.c         |  33 +--
 arch/powerpc/mm/book3s64/radix_hugetlbpage.c  |  55 -----
 arch/powerpc/mm/{ => book3s64}/slice.c        | 200 ++++++++++++++-
 arch/powerpc/mm/hugetlbpage.c                 |  28 ---
 arch/powerpc/mm/mmap.c                        | 228 ------------------
 arch/powerpc/mm/nohash/mmu_context.c          |   9 -
 arch/powerpc/mm/nohash/tlb.c                  |   4 -
 arch/powerpc/platforms/Kconfig.cputype        |   4 -
 drivers/pci/controller/pci-xgene.c            |   1 -
 include/linux/sizes.h                         |   2 +
 mm/util.c                                     |   2 +-
 25 files changed, 237 insertions(+), 470 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/slice.h
 rename arch/powerpc/mm/{ => book3s64}/slice.c (80%)
 delete mode 100644 arch/powerpc/mm/mmap.c

-- 
2.33.1

