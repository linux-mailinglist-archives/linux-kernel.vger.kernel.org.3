Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DE94962FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbiAUQi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:38:29 -0500
Received: from gloria.sntech.de ([185.11.138.130]:36132 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233605AbiAUQi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:38:27 -0500
Received: from p508fcef5.dip0.t-ipconnect.de ([80.143.206.245] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nAwuT-0008GA-FJ; Fri, 21 Jan 2022 17:37:09 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 14/14] riscv: add memory-type errata for T-Head
Date:   Fri, 21 Jan 2022 17:36:18 +0100
Message-Id: <20220121163618.351934-15-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220121163618.351934-1-heiko@sntech.de>
References: <20220121163618.351934-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some current cpus based on T-Head cores implement memory-types
way different than described in the svpbmt spec even going
so far as using PTE bits marked as reserved.

Add the T-Head vendor-id and necessary errata code to
replace the affected instructions.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/Kconfig.erratas             | 19 ++++++
 arch/riscv/errata/Makefile             |  1 +
 arch/riscv/errata/sifive/errata.c      |  7 ++-
 arch/riscv/errata/thead/Makefile       |  1 +
 arch/riscv/errata/thead/errata.c       | 85 ++++++++++++++++++++++++++
 arch/riscv/include/asm/alternative.h   |  5 ++
 arch/riscv/include/asm/errata_list.h   | 47 ++++++++++++--
 arch/riscv/include/asm/pgtable-64.h    | 18 +++++-
 arch/riscv/include/asm/pgtable.h       | 18 +++++-
 arch/riscv/include/asm/vendorid_list.h |  1 +
 arch/riscv/kernel/alternative.c        | 14 +++++
 arch/riscv/kernel/cpufeature.c         |  2 +
 arch/riscv/mm/init.c                   |  2 +
 13 files changed, 211 insertions(+), 9 deletions(-)
 create mode 100644 arch/riscv/errata/thead/Makefile
 create mode 100644 arch/riscv/errata/thead/errata.c

diff --git a/arch/riscv/Kconfig.erratas b/arch/riscv/Kconfig.erratas
index d18be8ff0245..380ec039c3dc 100644
--- a/arch/riscv/Kconfig.erratas
+++ b/arch/riscv/Kconfig.erratas
@@ -31,4 +31,23 @@ config ERRATA_SIFIVE_CIP_1200
 
 	  If you don't know what to do here, say "Y".
 
+config ERRATA_THEAD
+	bool "T-HEAD errata"
+	help
+	  All T-HEAD errata Kconfig depend on this Kconfig. Disabling
+	  this Kconfig will disable all T-HEAD errata. Please say "Y"
+	  here if your platform uses T-HEAD CPU cores.
+
+	  If you don't know what to do here, say "Y".
+
+config ERRATA_THEAD_PBMT
+	bool "Apply T-Head memory type errata"
+	depends on ERRATA_THEAD && 64BIT
+	default y
+	help
+	  This will apply the memory type errata to handle the non-standard
+	  memory type bits in page-table-entries on T-Head SoCs.
+
+	  If you don't know what to do here, say "Y".
+
 endmenu
diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
index 0ca1c5281a2d..a1055965fbee 100644
--- a/arch/riscv/errata/Makefile
+++ b/arch/riscv/errata/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
+obj-$(CONFIG_ERRATA_THEAD) += thead/
diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 4fe03ac41fd7..f933d6cdf304 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -84,10 +84,15 @@ void __init sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *
 				     unsigned int stage)
 {
 	struct alt_entry *alt;
-	u32 cpu_req_errata = sifive_errata_probe(archid, impid);
+	u32 cpu_req_errata;
 	u32 cpu_apply_errata = 0;
 	u32 tmp;
 
+	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
+		return;
+
+	cpu_req_errata = sifive_errata_probe(archid, impid);
+
 	for (alt = begin; alt < end; alt++) {
 		if (alt->vendor_id != SIFIVE_VENDOR_ID)
 			continue;
diff --git a/arch/riscv/errata/thead/Makefile b/arch/riscv/errata/thead/Makefile
new file mode 100644
index 000000000000..2d644e19caef
--- /dev/null
+++ b/arch/riscv/errata/thead/Makefile
@@ -0,0 +1 @@
+obj-y += errata.o
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
new file mode 100644
index 000000000000..fd8e0538a3f0
--- /dev/null
+++ b/arch/riscv/errata/thead/errata.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Heiko Stuebner <heiko@sntech.de>
+ */
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <asm/alternative.h>
+#include <asm/cacheflush.h>
+#include <asm/errata_list.h>
+#include <asm/patch.h>
+#include <asm/vendorid_list.h>
+
+struct errata_info {
+	char name[ERRATA_STRING_LENGTH_MAX];
+	bool (*check_func)(unsigned long arch_id, unsigned long impid);
+	unsigned int stage;
+};
+
+static bool errata_mt_check_func(unsigned long  arch_id, unsigned long impid)
+{
+	if (arch_id != 0 || impid != 0)
+		return false;
+	return true;
+}
+
+static const struct errata_info errata_list[ERRATA_THEAD_NUMBER] = {
+	{
+		.name = "memory-types",
+		.stage = RISCV_ALTERNATIVES_EARLY_BOOT,
+		.check_func = errata_mt_check_func
+	},
+};
+
+static u32 thead_errata_probe(unsigned int stage, unsigned long archid, unsigned long impid)
+{
+	const struct errata_info *info;
+	u32 cpu_req_errata = 0;
+	int idx;
+
+	for (idx = 0; idx < ERRATA_THEAD_NUMBER; idx++) {
+		info = &errata_list[idx];
+
+		if ((stage == RISCV_ALTERNATIVES_MODULE ||
+		     info->stage == stage) && info->check_func(archid, impid))
+			cpu_req_errata |= (1U << idx);
+	}
+
+	return cpu_req_errata;
+}
+
+void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
+					      unsigned long archid, unsigned long impid,
+					      unsigned int stage)
+{
+	struct alt_entry *alt;
+	u32 cpu_req_errata = thead_errata_probe(stage, archid, impid);
+	u32 cpu_apply_errata = 0;
+	u32 tmp;
+
+	for (alt = begin; alt < end; alt++) {
+		if (alt->vendor_id != THEAD_VENDOR_ID)
+			continue;
+		if (alt->errata_id >= ERRATA_THEAD_NUMBER)
+			continue;
+
+		tmp = (1U << alt->errata_id);
+		if (cpu_req_errata & tmp) {
+			/* On vm-alternatives, the mmu isn't running yet */
+			if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
+				memcpy((void *)__pa_symbol(alt->old_ptr),
+				       (void *)__pa_symbol(alt->alt_ptr), alt->alt_len);
+			else
+				patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
+
+			cpu_apply_errata |= tmp;
+		}
+	}
+
+	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
+		local_flush_icache_all();
+}
diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index cf3b22173834..d1154c91ab03 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -19,8 +19,10 @@
 
 #define RISCV_ALTERNATIVES_BOOT		0 /* alternatives applied during regular boot */
 #define RISCV_ALTERNATIVES_MODULE	1 /* alternatives applied during module-init */
+#define RISCV_ALTERNATIVES_EARLY_BOOT	2 /* alternatives applied before mmu start */
 
 void __init apply_boot_alternatives(void);
+void __init apply_early_boot_alternatives(void);
 void apply_module_alternatives(void *start, size_t length);
 
 struct alt_entry {
@@ -39,6 +41,9 @@ struct errata_checkfunc_id {
 void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 			      unsigned long archid, unsigned long impid,
 			      unsigned int stage);
+void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
+			     unsigned long archid, unsigned long impid,
+			     unsigned int stage);
 
 void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
 				 unsigned int stage);
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index a4a9b0842922..4fac46b82c16 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -14,6 +14,11 @@
 #define	ERRATA_SIFIVE_NUMBER 2
 #endif
 
+#ifdef CONFIG_ERRATA_THEAD
+#define	ERRATA_THEAD_PBMT 0
+#define	ERRATA_THEAD_NUMBER 1
+#endif
+
 #define	CPUFEATURE_SVPBMT 0
 #define	CPUFEATURE_NUMBER 1
 
@@ -42,10 +47,44 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
  * in the default case.
  */
 #define ALT_SVPBMT_SHIFT 61
-#define ALT_SVPBMT(_val, prot)						\
-asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,	\
-		CPUFEATURE_SVPBMT, CONFIG_64BIT)			\
-		: "=r"(_val) : "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT), "I"(ALT_SVPBMT_SHIFT))
+#define ALT_THEAD_PBMT_SHIFT 59
+#define ALT_SVPBMT(_val, prot)								\
+asm(ALTERNATIVE_2("li %0, 0\t\nnop",							\
+		  "li %0, %1\t\nslli %0,%0,%3", 0, CPUFEATURE_SVPBMT, CONFIG_64BIT,	\
+		  "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID, ERRATA_THEAD_PBMT,	\
+						CONFIG_ERRATA_THEAD_PBMT)		\
+		: "=r"(_val) : "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT),			\
+			       "I"(prot##_THEAD >> ALT_THEAD_PBMT_SHIFT),		\
+			       "I"(ALT_SVPBMT_SHIFT), "I"(ALT_THEAD_PBMT_SHIFT))
+
+#ifdef CONFIG_ERRATA_THEAD_PBMT
+/*
+ * IO/NOCACHE memory types are handled together with svpbmt,
+ * so on T-Head chips, check if no other memory type is set,
+ * and set the non-0 PMA type if applicable.
+ */
+#define ALT_THEAD_PMA(_val)								\
+asm volatile(ALTERNATIVE(								\
+	"nop\n\t"									\
+	"nop\n\t"									\
+	"nop\n\t"									\
+	"nop\n\t"									\
+	"nop\n\t"									\
+	"nop\n\t"									\
+	"nop",										\
+	"li      t3, %2\n\t"								\
+	"slli    t3, t3, %4\n\t"							\
+	"and     t3, %0, t3\n\t"							\
+	"bne     t3, zero, 2f\n\t"							\
+	"li      t3, %3\n\t"								\
+	"slli    t3, t3, %4\n\t"							\
+	"or      %0, %0, t3\n\t"							\
+	"2:",  THEAD_VENDOR_ID, ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)		\
+	: "+r"(_val) : "0"(_val), "I"(_PAGE_MTMASK_THEAD >> ALT_THEAD_PBMT_SHIFT),	\
+		       "I"(_PAGE_PMA_THEAD >> ALT_THEAD_PBMT_SHIFT),  "I"(ALT_THEAD_PBMT_SHIFT))
+#else
+#define ALT_THEAD_PMA(_val)
+#endif
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 58b34ef74acb..e7ce01cdc235 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -49,6 +49,18 @@ typedef struct {
 #define _PAGE_IO_SVPBMT		(1UL << 62)
 #define _PAGE_MTMASK_SVPBMT	(_PAGE_NOCACHE_SVPBMT | _PAGE_IO_SVPBMT)
 
+/*
+ * [63:59] T-Head Memory Type definitions:
+ *
+ * 00000 - NC   Weakly-ordered, Non-cacheable, Non-bufferable, Non-shareable, Non-trustable
+ * 01110 - PMA  Weakly-ordered, Cacheable, Bufferable, Shareable, Non-trustable
+ * 10000 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Non-shareable, Non-trustable
+ */
+#define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
+#define _PAGE_NOCACHE_THEAD	0UL
+#define _PAGE_IO_THEAD		(1UL << 63)
+#define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
+
 static inline u64 riscv_page_mtmask(void)
 {
 	u64 val;
@@ -126,7 +138,11 @@ static inline struct page *pud_page(pud_t pud)
 
 static inline pmd_t pfn_pmd(unsigned long pfn, pgprot_t prot)
 {
-	return __pmd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+	unsigned long prot_val = pgprot_val(prot);
+
+	ALT_THEAD_PMA(prot_val);
+
+	return __pmd((pfn << _PAGE_PFN_SHIFT) | prot_val);
 }
 
 static inline unsigned long _pmd_pfn(pmd_t pmd)
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index a189a21a7c8a..c3b9220b2523 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -219,7 +219,11 @@ static inline void pmd_clear(pmd_t *pmdp)
 
 static inline pgd_t pfn_pgd(unsigned long pfn, pgprot_t prot)
 {
-	return __pgd((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+	unsigned long prot_val = pgprot_val(prot);
+
+	ALT_THEAD_PMA(prot_val);
+
+	return __pgd((pfn << _PAGE_PFN_SHIFT) | prot_val);
 }
 
 static inline unsigned long _pgd_pfn(pgd_t pgd)
@@ -258,7 +262,11 @@ static inline unsigned long pte_pfn(pte_t pte)
 /* Constructs a page table entry */
 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
 {
-	return __pte((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
+	unsigned long prot_val = pgprot_val(prot);
+
+	ALT_THEAD_PMA(prot_val);
+
+	return __pte((pfn << _PAGE_PFN_SHIFT) | prot_val);
 }
 
 #define mk_pte(page, prot)       pfn_pte(page_to_pfn(page), prot)
@@ -367,7 +375,11 @@ static inline int pmd_protnone(pmd_t pmd)
 /* Modify page protection bits */
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
+	unsigned long newprot_val = pgprot_val(newprot);
+
+	ALT_THEAD_PMA(newprot_val);
+
+	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | newprot_val);
 }
 
 #define pgd_ERROR(e) \
diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index 9d934215b3c8..cb89af3f0704 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -6,5 +6,6 @@
 #define ASM_VENDOR_LIST_H
 
 #define SIFIVE_VENDOR_ID	0x489
+#define THEAD_VENDOR_ID		0x5b7
 
 #endif
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 54913857b682..e272599f96ef 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -48,6 +48,11 @@ static void __init init_alternative(void)
 	case SIFIVE_VENDOR_ID:
 		vendor_patch_func = sifive_errata_patch_func;
 		break;
+#endif
+#ifdef CONFIG_ERRATA_THEAD
+	case THEAD_VENDOR_ID:
+		vendor_patch_func = thead_errata_patch_func;
+		break;
 #endif
 	default:
 		vendor_patch_func = NULL;
@@ -85,6 +90,15 @@ void __init apply_boot_alternatives(void)
 			    RISCV_ALTERNATIVES_BOOT);
 }
 
+void __init apply_early_boot_alternatives(void)
+{
+	init_alternative();
+
+	_apply_alternatives((struct alt_entry *)__alt_start,
+			    (struct alt_entry *)__alt_end,
+			    RISCV_ALTERNATIVES_EARLY_BOOT);
+}
+
 #ifdef CONFIG_MODULES
 void apply_module_alternatives(void *start, size_t length)
 {
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d14289fba055..4ed18981d94d 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -224,6 +224,8 @@ static bool cpufeature_svpbmt_check_func(unsigned int stage)
 
 #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
 	switch (stage) {
+	case RISCV_ALTERNATIVES_EARLY_BOOT:
+		return false;
 	case RISCV_ALTERNATIVES_BOOT:
 		return cpufeature_svpbmt_check_fdt();
 	default:
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 24b2b8044602..063d5f022a05 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -624,6 +624,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	BUG_ON((kernel_map.virt_addr + kernel_map.size) > ADDRESS_SPACE_END - SZ_4K);
 #endif
 
+	apply_early_boot_alternatives();
+
 	pt_ops.alloc_pte = alloc_pte_early;
 	pt_ops.get_pte_virt = get_pte_virt_early;
 #ifndef __PAGETABLE_PMD_FOLDED
-- 
2.30.2

