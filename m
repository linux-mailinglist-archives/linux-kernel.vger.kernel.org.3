Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132D14AF1F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiBIMjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiBIMje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:39:34 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A982C03E931;
        Wed,  9 Feb 2022 04:39:31 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nHmEu-0001Mv-CK; Wed, 09 Feb 2022 13:38:28 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, huffman@cadence.com,
        mick@ics.forth.gr, allen.baum@esperantotech.com,
        jscheid@ventanamicro.com, rtrauben@gmail.com, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Wei Wu <lazyparser@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: [PATCH v6 12/14] riscv: add RISC-V Svpbmt extension support
Date:   Wed,  9 Feb 2022 13:37:58 +0100
Message-Id: <20220209123800.269774-13-heiko@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209123800.269774-1-heiko@sntech.de>
References: <20220209123800.269774-1-heiko@sntech.de>
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

From: Wei Fu <wefu@redhat.com>

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

As the extension will not be present on all implementations use
alternatives to check its existence at runtime and if needed
adapt the code to use memory-types.

Signed-off-by: Wei Fu <wefu@redhat.com>
Co-developed-by: Liu Shaohua <liush@allwinnertech.com>
Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Co-developed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
[moved to use the alternatives mechanism]
Co-developed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Atish Patra <atish.patra@wdc.com>
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
 arch/riscv/include/asm/errata_list.h  | 13 ++++-
 arch/riscv/include/asm/pgtable-32.h   |  9 +++
 arch/riscv/include/asm/pgtable-64.h   | 47 ++++++++++++++++
 arch/riscv/include/asm/pgtable-bits.h |  4 --
 arch/riscv/include/asm/pgtable.h      | 29 ++++++++--
 arch/riscv/kernel/cpufeature.c        | 79 +++++++++++++++++++++++++++
 6 files changed, 171 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 6b95bd9aee82..a4a9b0842922 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -14,7 +14,8 @@
 #define	ERRATA_SIFIVE_NUMBER 2
 #endif
 
-#define	CPUFEATURE_NUMBER 0
+#define	CPUFEATURE_SVPBMT 0
+#define	CPUFEATURE_NUMBER 1
 
 #ifdef __ASSEMBLY__
 
@@ -36,6 +37,16 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
 		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
 		: : "r" (addr) : "memory")
 
+/*
+ * _val is marked as "will be overwritten", so need to set it to 0
+ * in the default case.
+ */
+#define ALT_SVPBMT_SHIFT 61
+#define ALT_SVPBMT(_val, prot)						\
+asm(ALTERNATIVE("li %0, 0\t\nnop", "li %0, %1\t\nslli %0,%0,%2", 0,	\
+		CPUFEATURE_SVPBMT, CONFIG_64BIT)			\
+		: "=r"(_val) : "I"(prot##_SVPBMT >> ALT_SVPBMT_SHIFT), "I"(ALT_SVPBMT_SHIFT))
+
 #endif /* __ASSEMBLY__ */
 
 #endif
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
index 9412c6157c88..07ba3416cb19 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -8,6 +8,7 @@
 
 #include <linux/bits.h>
 #include <linux/const.h>
+#include <asm/errata_list.h>
 
 extern bool pgtable_l4_enabled;
 
@@ -56,6 +57,52 @@ typedef struct {
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
index bcf230b94c53..b8abc75dfe01 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -174,11 +174,8 @@ extern struct pt_alloc_ops pt_ops __initdata;
 
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
-/*
- * The RISC-V ISA doesn't yet specify how to query or modify PMAs, so we can't
- * change the properties of memory regions.
- */
-#define _PAGE_IOREMAP _PAGE_KERNEL
+#define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
+#define PAGE_KERNEL_IO		__pgprot(_PAGE_IOREMAP)
 
 extern pgd_t swapper_pg_dir[];
 
@@ -518,6 +515,28 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
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
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index fef804346d75..7bce66ee7ce7 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitmap.h>
+#include <linux/libfdt.h>
 #include <linux/of.h>
 #include <asm/alternative.h>
 #include <asm/errata_list.h>
@@ -159,7 +160,85 @@ struct cpufeature_info {
 	bool (*check_func)(unsigned int stage);
 };
 
+#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
+static bool cpufeature_svpbmt_check_fdt(void)
+{
+	const void *fdt = dtb_early_va;
+	const char *str;
+	int offset;
+
+	offset = fdt_path_offset(fdt, "/cpus");
+	if (offset < 0)
+		return false;
+
+	for (offset = fdt_next_node(fdt, offset, NULL); offset >= 0;
+	     offset = fdt_next_node(fdt, offset, NULL)) {
+		str = fdt_getprop(fdt, offset, "device_type", NULL);
+		if (!str || strcmp(str, "cpu"))
+			break;
+
+		str = fdt_getprop(fdt, offset, "mmu-type", NULL);
+		if (!str)
+			continue;
+
+		if (!strncmp(str + 6, "none", 4))
+			continue;
+
+		str = fdt_getprop(fdt, offset, "riscv,mmu", NULL);
+		if (!str)
+			continue;
+
+		if (!strncmp(str + 6, "svpbmt", 6))
+			return true;
+	}
+
+	return false;
+}
+
+static bool cpufeature_svpbmt_check_of(void)
+{
+	struct device_node *node;
+	const char *str;
+
+	for_each_of_cpu_node(node) {
+		if (of_property_read_string(node, "mmu-type", &str))
+			continue;
+
+		if (!strncmp(str + 6, "none", 4))
+			continue;
+
+		if (of_property_read_string(node, "riscv,mmu", &str))
+			continue;
+
+		if (!strncmp(str + 6, "svpbmt", 6))
+			return true;
+	}
+
+	return false;
+}
+#endif
+
+static bool cpufeature_svpbmt_check_func(unsigned int stage)
+{
+	bool ret = false;
+
+#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
+	switch (stage) {
+	case RISCV_ALTERNATIVES_BOOT:
+		return cpufeature_svpbmt_check_fdt();
+	default:
+		return cpufeature_svpbmt_check_of();
+	}
+#endif
+
+	return ret;
+}
+
 static const struct cpufeature_info cpufeature_list[CPUFEATURE_NUMBER] = {
+	{
+		.name = "svpbmt",
+		.check_func = cpufeature_svpbmt_check_func
+	},
 };
 
 static u32 __init cpufeature_probe(unsigned int stage)
-- 
2.30.2

