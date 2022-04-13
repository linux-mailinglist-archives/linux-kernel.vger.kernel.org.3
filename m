Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDEE4FED4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiDMDGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiDMDFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:05:51 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A098C54BFE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:03:24 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1neTHt-0006sN-Ft; Wed, 13 Apr 2022 05:03:21 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        hch@lst.de, arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Heiko Stuebner <heiko@sntech.de>,
        Wei Wu <lazyparser@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Bill Huffman <huffman@cadence.com>
Subject: [PATCH v9 09/12] riscv: add RISC-V Svpbmt extension support
Date:   Wed, 13 Apr 2022 05:03:04 +0200
Message-Id: <20220413030307.133807-10-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413030307.133807-1-heiko@sntech.de>
References: <20220413030307.133807-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Svpbmt (the S should be capitalized) is the
"Supervisor-mode: page-based memory types" extension
that specifies attributes for cacheability, idempotency
and ordering.

The relevant settings are done in special bits in PTEs:

Here is the svpbmt PTE format:
| 63 | 62-61 | 60-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
  N     MT     RSW    D   A   G   U   X   W   R   V
        ^

Of the Reserved bits [63:54] in a leaf PTE, the high bit is already
allocated (as the N bit), so bits [62:61] are used as the MT (aka
MemType) field. This field specifies one of three memory types that
are close equivalents (or equivalent in effect) to the three main x86
and ARMv8 memory types - as shown in the following table.

RISC-V
Encoding &
MemType     RISC-V Description
----------  ------------------------------------------------
00 - PMA    Normal Cacheable, No change to implied PMA memory type
01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
11 - Rsvd   Reserved for future standard use

As the extension will not be present on all implementations,
implement a method to handle cpufeatures via alternatives
to not incur runtime penalties on cpu variants not supporting
specific extensions and patch relevant code parts at runtime.

Co-developed-by: Wei Fu <wefu@redhat.com>
Signed-off-by: Wei Fu <wefu@redhat.com>
Co-developed-by: Liu Shaohua <liush@allwinnertech.com>
Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Co-developed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
[moved to use the alternatives mechanism]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Drew Fustini <drew@beagleboard.org>
Cc: Wei Fu <wefu@redhat.com>
Cc: Wei Wu <lazyparser@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Greg Favor <gfavor@ventanamicro.com>
Cc: Andrea Mondelli <andrea.mondelli@huawei.com>
Cc: Jonathan Behrens <behrensj@mit.edu>
Cc: Xinhaoqu (Freddie) <xinhaoqu@huawei.com>
Cc: Bill Huffman <huffman@cadence.com>
Cc: Nick Kossifidis <mick@ics.forth.gr>
Cc: Allen Baum <allen.baum@esperantotech.com>
Cc: Josh Scheid <jscheid@ventanamicro.com>
Cc: Richard Trauben <rtrauben@gmail.com>
---
 arch/riscv/Kconfig                    | 13 +++++
 arch/riscv/include/asm/alternative.h  |  3 ++
 arch/riscv/include/asm/errata_list.h  | 15 ++++++
 arch/riscv/include/asm/hwcap.h        |  1 +
 arch/riscv/include/asm/pgtable-32.h   |  9 ++++
 arch/riscv/include/asm/pgtable-64.h   | 47 +++++++++++++++++
 arch/riscv/include/asm/pgtable-bits.h |  4 --
 arch/riscv/include/asm/pgtable.h      | 29 +++++++++--
 arch/riscv/kernel/alternative.c       |  2 +
 arch/riscv/kernel/cpu.c               |  1 +
 arch/riscv/kernel/cpufeature.c        | 75 ++++++++++++++++++++++++++-
 11 files changed, 189 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 26464dae8ab7..3935358c03f5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -343,6 +343,19 @@ config RISCV_ISA_C
 
 	   If you don't know what to do here, say Y.
 
+config RISCV_ISA_SVPBMT
+	bool "SVPBMT extension support"
+	depends on 64BIT && MMU
+	select RISCV_ALTERNATIVE
+	default y
+	help
+	   Adds support to dynamically detect the presence of the SVPBMT extension
+	   (Supervisor-mode: page-based memory types) and enable its usage.
+
+	   The SVPBMT extension is only available on 64Bit cpus.
+
+	   If you don't know what to do here, say Y.
+
 config FPU
 	bool "FPU support"
 	default y
diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index 0859529ff08e..64936356c37c 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -42,6 +42,9 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 			      unsigned long archid, unsigned long impid,
 			      unsigned int stage);
 
+void riscv_cpufeature_patch_func(struct alt_entry *begin, struct alt_entry *end,
+				 unsigned int stage);
+
 #else /* CONFIG_RISCV_ALTERNATIVE */
 
 static inline void apply_boot_alternatives(void) { }
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 5f1046e82d9f..dbfcd9b72bd8 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -14,6 +14,9 @@
 #define	ERRATA_SIFIVE_NUMBER 2
 #endif
 
+#define	CPUFEATURE_SVPBMT 0
+#define	CPUFEATURE_NUMBER 1
+
 #ifdef __ASSEMBLY__
 
 #define ALT_INSN_FAULT(x)						\
@@ -34,6 +37,18 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
 		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
 		: : "r" (addr) : "memory")
 
+/*
+ * _val is marked as "will be overwritten", so need to set it to 0
+ * in the default case.
+ */
+#define ALT_SVPBMT_SHIFT 61
+#define ALT_SVPBMT(_val, prot)						\
+asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,	\
+		CPUFEATURE_SVPBMT, CONFIG_RISCV_ISA_SVPBMT)		\
+		: "=r"(_val)						\
+		: "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT),		\
+		  "I"(ALT_SVPBMT_SHIFT))
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 0734e42f74f2..4e2486881840 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -52,6 +52,7 @@ extern unsigned long elf_hwcap;
  */
 enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
+	RISCV_ISA_EXT_SVPBMT,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
index e266a4fe7f43..59ba1fbaf784 100644
--- a/arch/riscv/include/asm/pgtable-32.h
+++ b/arch/riscv/include/asm/pgtable-32.h
@@ -24,4 +24,13 @@
  */
 #define _PAGE_PFN_MASK  GENMASK(31, 10)
 
+#define _PAGE_NOCACHE		0
+#define _PAGE_IO		0
+#define _PAGE_MTMASK		0
+
+/* Set of bits to preserve across pte_modify() */
+#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
+					  _PAGE_WRITE | _PAGE_EXEC |	\
+					  _PAGE_USER | _PAGE_GLOBAL))
+
 #endif /* _ASM_RISCV_PGTABLE_32_H */
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 15f3ad5aee4f..2354501f0203 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -8,6 +8,7 @@
 
 #include <linux/bits.h>
 #include <linux/const.h>
+#include <asm/errata_list.h>
 
 extern bool pgtable_l4_enabled;
 extern bool pgtable_l5_enabled;
@@ -73,6 +74,52 @@ typedef struct {
  */
 #define _PAGE_PFN_MASK  GENMASK(53, 10)
 
+/*
+ * [62:61] Svpbmt Memory Type definitions:
+ *
+ *  00 - PMA    Normal Cacheable, No change to implied PMA memory type
+ *  01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
+ *  10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
+ *  11 - Rsvd   Reserved for future standard use
+ */
+#define _PAGE_NOCACHE_SVPBMT	(1UL << 61)
+#define _PAGE_IO_SVPBMT		(1UL << 62)
+#define _PAGE_MTMASK_SVPBMT	(_PAGE_NOCACHE_SVPBMT | _PAGE_IO_SVPBMT)
+
+static inline u64 riscv_page_mtmask(void)
+{
+	u64 val;
+
+	ALT_SVPBMT(val, _PAGE_MTMASK);
+	return val;
+}
+
+static inline u64 riscv_page_nocache(void)
+{
+	u64 val;
+
+	ALT_SVPBMT(val, _PAGE_NOCACHE);
+	return val;
+}
+
+static inline u64 riscv_page_io(void)
+{
+	u64 val;
+
+	ALT_SVPBMT(val, _PAGE_IO);
+	return val;
+}
+
+#define _PAGE_NOCACHE		riscv_page_nocache()
+#define _PAGE_IO		riscv_page_io()
+#define _PAGE_MTMASK		riscv_page_mtmask()
+
+/* Set of bits to preserve across pte_modify() */
+#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
+					  _PAGE_WRITE | _PAGE_EXEC |	\
+					  _PAGE_USER | _PAGE_GLOBAL |	\
+					  _PAGE_MTMASK))
+
 static inline int pud_present(pud_t pud)
 {
 	return (pud_val(pud) & _PAGE_PRESENT);
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index e571fa954afc..b9e13a8fe2b7 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -29,10 +29,6 @@
 
 #define _PAGE_PFN_SHIFT 10
 
-/* Set of bits to preserve across pte_modify() */
-#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
-					  _PAGE_WRITE | _PAGE_EXEC |	\
-					  _PAGE_USER | _PAGE_GLOBAL))
 /*
  * when all of R/W/X are zero, the PTE is a pointer to the next level
  * of the page table; otherwise, it is a leaf PTE.
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index faba543e2b08..c55341b72de1 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -179,11 +179,8 @@ extern struct pt_alloc_ops pt_ops __initdata;
 
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
-/*
- * The RISC-V ISA doesn't yet specify how to query or modify PMAs, so we can't
- * change the properties of memory regions.
- */
-#define _PAGE_IOREMAP _PAGE_KERNEL
+#define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
+#define PAGE_KERNEL_IO		__pgprot(_PAGE_IOREMAP)
 
 extern pgd_t swapper_pg_dir[];
 
@@ -523,6 +520,28 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	return ptep_test_and_clear_young(vma, address, ptep);
 }
 
+#define pgprot_noncached pgprot_noncached
+static inline pgprot_t pgprot_noncached(pgprot_t _prot)
+{
+	unsigned long prot = pgprot_val(_prot);
+
+	prot &= ~_PAGE_MTMASK;
+	prot |= _PAGE_IO;
+
+	return __pgprot(prot);
+}
+
+#define pgprot_writecombine pgprot_writecombine
+static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
+{
+	unsigned long prot = pgprot_val(_prot);
+
+	prot &= ~_PAGE_MTMASK;
+	prot |= _PAGE_NOCACHE;
+
+	return __pgprot(prot);
+}
+
 /*
  * THP functions
  */
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 223770b3945c..e6c9de9f9ba6 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -63,6 +63,8 @@ static void __init_or_module _apply_alternatives(struct alt_entry *begin,
 						 struct alt_entry *end,
 						 unsigned int stage)
 {
+	riscv_cpufeature_patch_func(begin, end, stage);
+
 	if (!vendor_patch_func)
 		return;
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ccb617791e56..40c8776aec12 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -88,6 +88,7 @@ int riscv_of_parent_hartid(struct device_node *node)
  */
 static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1b2d42d7f589..f514b949c6a7 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -8,9 +8,15 @@
 
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
+#include <linux/libfdt.h>
+#include <linux/module.h>
 #include <linux/of.h>
-#include <asm/processor.h>
+#include <asm/alternative.h>
+#include <asm/errata_list.h>
 #include <asm/hwcap.h>
+#include <asm/patch.h>
+#include <asm/pgtable.h>
+#include <asm/processor.h>
 #include <asm/smp.h>
 #include <asm/switch_to.h>
 
@@ -192,6 +198,7 @@ void __init riscv_fill_hwcap(void)
 				set_bit(*ext - 'a', this_isa);
 			} else {
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
+				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
 			}
 #undef SET_ISA_EXT_MAP
 		}
@@ -237,3 +244,69 @@ void __init riscv_fill_hwcap(void)
 		static_branch_enable(&cpu_hwcap_fpu);
 #endif
 }
+
+#ifdef CONFIG_RISCV_ALTERNATIVE
+struct cpufeature_info {
+	char name[ERRATA_STRING_LENGTH_MAX];
+	bool (*check_func)(unsigned int stage);
+};
+
+static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int stage)
+{
+#ifdef CONFIG_RISCV_ISA_SVPBMT
+	return riscv_isa_extension_available(NULL, SVPBMT);
+#endif
+
+	return false;
+}
+
+static const struct cpufeature_info __initdata_or_module
+cpufeature_list[CPUFEATURE_NUMBER] = {
+	{
+		.name = "svpbmt",
+		.check_func = cpufeature_svpbmt_check_func
+	},
+};
+
+static u32 __init_or_module cpufeature_probe(unsigned int stage)
+{
+	const struct cpufeature_info *info;
+	u32 cpu_req_feature = 0;
+	int idx;
+
+	for (idx = 0; idx < CPUFEATURE_NUMBER; idx++) {
+		info = &cpufeature_list[idx];
+
+		if (info->check_func(stage))
+			cpu_req_feature |= (1U << idx);
+	}
+
+	return cpu_req_feature;
+}
+
+void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
+						  struct alt_entry *end,
+						  unsigned int stage)
+{
+	u32 cpu_req_feature = cpufeature_probe(stage);
+	u32 cpu_apply_feature = 0;
+	struct alt_entry *alt;
+	u32 tmp;
+
+	for (alt = begin; alt < end; alt++) {
+		if (alt->vendor_id != 0)
+			continue;
+		if (alt->errata_id >= CPUFEATURE_NUMBER) {
+			WARN(1, "This feature id:%d is not in kernel cpufeature list",
+				alt->errata_id);
+			continue;
+		}
+
+		tmp = (1U << alt->errata_id);
+		if (cpu_req_feature & tmp) {
+			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
+			cpu_apply_feature |= tmp;
+		}
+	}
+}
+#endif
-- 
2.35.1

