Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6699C4E5C32
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346690AbiCXALa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbiCXAL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:11:28 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B56BA7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:09:55 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nXB0s-00055s-OZ; Thu, 24 Mar 2022 01:07:38 +0100
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
Subject: [PATCH v8 11/14] riscv: add RISC-V Svpbmt extension support
Date:   Thu, 24 Mar 2022 01:07:07 +0100
Message-Id: <20220324000710.575331-12-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324000710.575331-1-heiko@sntech.de>
References: <20220324000710.575331-1-heiko@sntech.de>
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
 arch/riscv/include/asm/errata_list.h  | 13 +++++++-
 arch/riscv/include/asm/hwcap.h        |  1 +
 arch/riscv/include/asm/pgtable-32.h   |  9 +++++
 arch/riscv/include/asm/pgtable-64.h   | 47 +++++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable-bits.h |  4 ---
 arch/riscv/include/asm/pgtable.h      | 29 ++++++++++++++---
 arch/riscv/kernel/cpu.c               |  1 +
 arch/riscv/kernel/cpufeature.c        | 18 ++++++++++
 8 files changed, 112 insertions(+), 10 deletions(-)

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
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 691fc9c8099b..656cd626eb1a 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -51,6 +51,7 @@ extern unsigned long elf_hwcap;
  * available logical extension id.
  */
 enum riscv_isa_ext_id {
+	RISCV_ISA_EXT_SVPBMT = RISCV_ISA_EXT_BASE,
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
index 6d31489818cd..009a17f94b86 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -175,11 +175,8 @@ extern struct pt_alloc_ops pt_ops __initdata;
 
 #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
 
-/*
- * The RISC-V ISA doesn't yet specify how to query or modify PMAs, so we can't
- * change the properties of memory regions.
- */
-#define _PAGE_IOREMAP _PAGE_KERNEL
+#define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
+#define PAGE_KERNEL_IO		__pgprot(_PAGE_IOREMAP)
 
 extern pgd_t swapper_pg_dir[];
 
@@ -519,6 +516,28 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
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
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index fc115e307ef5..01a4799e7e1c 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -87,6 +87,7 @@ int riscv_of_parent_hartid(struct device_node *node)
  *    extensions by an underscore.
  */
 static struct riscv_isa_ext_data isa_ext_arr[] = {
+	__RISCV_ISA_EXT_DATA("svpbmt", RISCV_ISA_EXT_SVPBMT),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c0ffc26c3ef3..fab9c5367949 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
+#include <linux/libfdt.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <asm/alternative.h>
@@ -195,6 +196,8 @@ void __init riscv_fill_hwcap(void)
 			if (!ext_long) {
 				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
 				set_bit(*ext - 'a', this_isa);
+			} else {
+				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
 			}
 #undef SET_ISA_EXT_MAP
 		}
@@ -246,7 +249,22 @@ struct cpufeature_info {
 	bool (*check_func)(unsigned int stage);
 };
 
+static bool __init_or_module cpufeature_svpbmt_check_func(unsigned int stage)
+{
+	bool ret = false;
+
+#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
+	return riscv_isa_extension_available(NULL, SVPBMT);
+#endif
+
+	return ret;
+}
+
 static const struct cpufeature_info __initdata_or_module cpufeature_list[CPUFEATURE_NUMBER] = {
+	{
+		.name = "svpbmt",
+		.check_func = cpufeature_svpbmt_check_func
+	},
 };
 
 static u32 __init_or_module cpufeature_probe(unsigned int stage)
-- 
2.35.1

