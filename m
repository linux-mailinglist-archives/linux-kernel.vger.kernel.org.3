Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7613153C83E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243387AbiFCKOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiFCKO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:14:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 498913B283;
        Fri,  3 Jun 2022 03:14:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCFAE1063;
        Fri,  3 Jun 2022 03:14:27 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDDE03F766;
        Fri,  3 Jun 2022 03:14:18 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        openrisc@lists.librecores.org, linux-csky@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] mm/mmap: Enable more platforms with ARCH_HAS_VM_GET_PAGE_PROT
Date:   Fri,  3 Jun 2022 15:44:05 +0530
Message-Id: <20220603101411.488970-1-anshuman.khandual@arm.com>
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

From the last discussion [1], some more platforms (s390, mips, csky, nios2,
openrisc) were willing to enable ARCH_HAS_VM_GET_PAGE_PROT and also provide
custom vm_get_page_prot() via switch case statement implementation without
any objection. All those platform specific patches have already been acked.

This series makes protection_map[] array private on platforms which define
their own vm_get_page_prot() via ARCH_HAS_VM_GET_PAGE_PROT, and also drops
off their __PXXX/__SXXX macros. This also enables new platforms as in this
series, to drop off their __PXXX/__SXXX macros as generic protection_map[]
is no longer visible to them.

[1] https://lore.kernel.org/all/1646045273-9343-2-git-send-email-anshuman.khandual@arm.com/

This series applies on current mainline and also has been build tested on
multiple platforms.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Cc: openrisc@lists.librecores.org
Cc: linux-csky@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (6):
  mm/mmap: Restrict generic protection_map[] array visibility
  s390/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  mips/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  csky/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  nios2/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
  openrisc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT

 arch/arm64/include/asm/pgtable-prot.h | 18 --------
 arch/arm64/mm/mmap.c                  | 21 ++++++++++
 arch/csky/Kconfig                     |  1 +
 arch/csky/include/asm/pgtable.h       | 18 --------
 arch/csky/mm/init.c                   | 32 ++++++++++++++
 arch/mips/Kconfig                     |  1 +
 arch/mips/include/asm/pgtable.h       | 22 ----------
 arch/mips/mm/cache.c                  | 60 ++++++++++++++++-----------
 arch/nios2/Kconfig                    |  1 +
 arch/nios2/include/asm/pgtable.h      | 24 -----------
 arch/nios2/mm/init.c                  | 47 +++++++++++++++++++++
 arch/openrisc/Kconfig                 |  1 +
 arch/openrisc/include/asm/pgtable.h   | 18 --------
 arch/openrisc/mm/init.c               | 41 ++++++++++++++++++
 arch/powerpc/include/asm/pgtable.h    |  2 +
 arch/powerpc/mm/book3s64/pgtable.c    | 20 +++++++++
 arch/s390/Kconfig                     |  1 +
 arch/s390/include/asm/pgtable.h       | 17 --------
 arch/s390/mm/mmap.c                   | 33 +++++++++++++++
 arch/sparc/include/asm/pgtable_32.h   |  2 +
 arch/sparc/include/asm/pgtable_64.h   | 19 ---------
 arch/sparc/mm/init_64.c               | 20 +++++++++
 arch/x86/include/asm/pgtable_types.h  | 19 ---------
 arch/x86/mm/pgprot.c                  | 19 +++++++++
 include/linux/mm.h                    |  2 +
 mm/mmap.c                             |  2 +-
 26 files changed, 280 insertions(+), 181 deletions(-)

-- 
2.25.1

