Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684AB54837C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbiFMJTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiFMJTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:19:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7B14D12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:19:19 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LM5XJ6xhrzRj13;
        Mon, 13 Jun 2022 17:16:00 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:19:12 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:19:12 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2] ARM: Mark the FDT_FIXED sections as shareable
Date:   Mon, 13 Jun 2022 17:19:01 +0800
Message-ID: <20220613091901.730-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 7a1be318f579 ("ARM: 9012/1: move device tree mapping out of linear
region") use FDT_FIXED_BASE to map the whole FDT_FIXED_SIZE memory area
which contains fdt. But it only reserves the exact physical memory that
fdt occupied. Unfortunately, this mapping is non-shareable. An illegal or
speculative read access can bring the RAM content from non-fdt zone into
cache, PIPT makes it to be hit by subsequently read access through
shareable mapping(such as linear mapping), and the cache consistency
between cores is lost due to non-shareable property.

|<---------FDT_FIXED_SIZE------>|
|                               |
 -------------------------------
| <non-fdt> | <fdt> | <non-fdt> |
 -------------------------------

1. CoreA read <non-fdt> through MT_ROM mapping, the old data is loaded
   into the cache.
2. CoreB write <non-fdt> to update data through linear mapping. CoreA
   received the notification to invalid the corresponding cachelines, but
   the property non-shareable makes it to be ignored.
3. CoreA read <non-fdt> through linear mapping, cache hit, the old data
   is read.

To eliminate this risk, add a new memory type MT_MEMORY_RO. Compared to
MT_ROM, it is shareable and non-executable.

Here's an example:
  list_del corruption. prev->next should be c0ecbf74, but was c08410dc
  kernel BUG at lib/list_debug.c:53!
  ... ...
  PC is at __list_del_entry_valid+0x58/0x98
  LR is at __list_del_entry_valid+0x58/0x98
  psr: 60000093
  sp : c0ecbf30  ip : 00000000  fp : 00000001
  r10: c08410d0  r9 : 00000001  r8 : c0825e0c
  r7 : 20000013  r6 : c08410d0  r5 : c0ecbf74  r4 : c0ecbf74
  r3 : c0825d08  r2 : 00000000  r1 : df7ce6f4  r0 : 00000044
  ... ...
  Stack: (0xc0ecbf30 to 0xc0ecc000)
  bf20:                                     c0ecbf74 c0164fd0 c0ecbf70 c0165170
  bf40: c0eca000 c0840c00 c0840c00 c0824500 c0825e0c c0189bbc c088f404 60000013
  bf60: 60000013 c0e85100 000004ec 00000000 c0ebcdc0 c0ecbf74 c0ecbf74 c0825d08
  ... ...                                           <  next     prev  >
  (__list_del_entry_valid) from (__list_del_entry+0xc/0x20)
  (__list_del_entry) from (finish_swait+0x60/0x7c)
  (finish_swait) from (rcu_gp_kthread+0x560/0xa20)
  (rcu_gp_kthread) from (kthread+0x14c/0x15c)
  (kthread) from (ret_from_fork+0x14/0x24)

The faulty list node to be deleted is a local variable, its address is
c0ecbf74. The dumped stack shows that 'prev' = c0ecbf74, but its value
before lib/list_debug.c:53 is c08410dc. A large amount of printing results
in swapping out the cacheline containing the old data(MT_ROM mapping is
read only, so the cacheline cannot be dirty), and the subsequent dump
operation obtains new data from the DDR.

Fixes: 7a1be318f579 ("ARM: 9012/1: move device tree mapping out of linear region")
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/include/asm/mach/map.h |  1 +
 arch/arm/mm/mmu.c               | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

v1 --> v2:
As Ard Biesheuvel's suggestion, add a new memory type MT_MEMORY_RO instead of
add a new memory type MT_ROM_XIP.

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 92282558caf7cdb..2b8970d8e5a2ff8 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -27,6 +27,7 @@ enum {
 	MT_HIGH_VECTORS,
 	MT_MEMORY_RWX,
 	MT_MEMORY_RW,
+	MT_MEMORY_RO,
 	MT_ROM,
 	MT_MEMORY_RWX_NONCACHED,
 	MT_MEMORY_RW_DTCM,
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 5e2be37a198e29e..cd17e324aa51ea6 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -296,6 +296,13 @@ static struct mem_type mem_types[] __ro_after_init = {
 		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE,
 		.domain    = DOMAIN_KERNEL,
 	},
+	[MT_MEMORY_RO] = {
+		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
+			     L_PTE_XN | L_PTE_RDONLY,
+		.prot_l1   = PMD_TYPE_TABLE,
+		.prot_sect = PMD_TYPE_SECT,
+		.domain    = DOMAIN_KERNEL,
+	},
 	[MT_ROM] = {
 		.prot_sect = PMD_TYPE_SECT,
 		.domain    = DOMAIN_KERNEL,
@@ -489,6 +496,7 @@ static void __init build_mem_type_table(void)
 
 			/* Also setup NX memory mapping */
 			mem_types[MT_MEMORY_RW].prot_sect |= PMD_SECT_XN;
+			mem_types[MT_MEMORY_RO].prot_sect |= PMD_SECT_XN;
 		}
 		if (cpu_arch >= CPU_ARCH_ARMv7 && (cr & CR_TRE)) {
 			/*
@@ -568,6 +576,7 @@ static void __init build_mem_type_table(void)
 		mem_types[MT_ROM].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 		mem_types[MT_MINICLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
+		mem_types[MT_MEMORY_RO].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 #endif
 
 		/*
@@ -587,6 +596,8 @@ static void __init build_mem_type_table(void)
 			mem_types[MT_MEMORY_RWX].prot_pte |= L_PTE_SHARED;
 			mem_types[MT_MEMORY_RW].prot_sect |= PMD_SECT_S;
 			mem_types[MT_MEMORY_RW].prot_pte |= L_PTE_SHARED;
+			mem_types[MT_MEMORY_RO].prot_sect |= PMD_SECT_S;
+			mem_types[MT_MEMORY_RO].prot_pte |= L_PTE_SHARED;
 			mem_types[MT_MEMORY_DMA_READY].prot_pte |= L_PTE_SHARED;
 			mem_types[MT_MEMORY_RWX_NONCACHED].prot_sect |= PMD_SECT_S;
 			mem_types[MT_MEMORY_RWX_NONCACHED].prot_pte |= L_PTE_SHARED;
@@ -647,6 +658,8 @@ static void __init build_mem_type_table(void)
 	mem_types[MT_MEMORY_RWX].prot_pte |= kern_pgprot;
 	mem_types[MT_MEMORY_RW].prot_sect |= ecc_mask | cp->pmd;
 	mem_types[MT_MEMORY_RW].prot_pte |= kern_pgprot;
+	mem_types[MT_MEMORY_RO].prot_sect |= ecc_mask | cp->pmd;
+	mem_types[MT_MEMORY_RO].prot_pte |= kern_pgprot;
 	mem_types[MT_MEMORY_DMA_READY].prot_pte |= kern_pgprot;
 	mem_types[MT_MEMORY_RWX_NONCACHED].prot_sect |= ecc_mask;
 	mem_types[MT_ROM].prot_sect |= cp->pmd;
@@ -1360,7 +1373,7 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
 		map.pfn = __phys_to_pfn(__atags_pointer & SECTION_MASK);
 		map.virtual = FDT_FIXED_BASE;
 		map.length = FDT_FIXED_SIZE;
-		map.type = MT_ROM;
+		map.type = MT_MEMORY_RO;
 		create_mapping(&map);
 	}
 
-- 
2.25.1

