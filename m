Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAFE545941
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 02:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345459AbiFJAnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 20:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbiFJAnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 20:43:33 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EC916A257;
        Thu,  9 Jun 2022 17:43:28 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1nzSk7-0001oS-R0; Fri, 10 Jun 2022 02:43:15 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, hch@lst.de, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, Heiko Stuebner <heiko@sntech.de>,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH 2/3] riscv: Implement Zicbom-based cache management operations
Date:   Fri, 10 Jun 2022 02:43:07 +0200
Message-Id: <20220610004308.1903626-3-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610004308.1903626-1-heiko@sntech.de>
References: <20220610004308.1903626-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Zicbom ISA-extension was ratified in november 2021
and introduces instructions for dcache invalidate, clean
and flush operations.

Implement cache management operations based on them.

Of course not all cores will support this, so implement an
alternative-based mechanism that replaces empty instructions
with ones done around Zicbom instructions.

We're using prebuild instructions for the Zicbom instructions
for now, to not require a bleeding-edge compiler (gcc-12)
for these somewhat simple instructions.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig                   | 15 +++++
 arch/riscv/include/asm/cacheflush.h  |  6 ++
 arch/riscv/include/asm/errata_list.h | 36 ++++++++++-
 arch/riscv/include/asm/hwcap.h       |  1 +
 arch/riscv/kernel/cpu.c              |  1 +
 arch/riscv/kernel/cpufeature.c       | 18 ++++++
 arch/riscv/kernel/setup.c            |  2 +
 arch/riscv/mm/Makefile               |  1 +
 arch/riscv/mm/dma-noncoherent.c      | 93 ++++++++++++++++++++++++++++
 9 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/mm/dma-noncoherent.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 32ffef9f6e5b..384d0c15f2b6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -376,6 +376,21 @@ config RISCV_ISA_SVPBMT
 
 	   If you don't know what to do here, say Y.
 
+config RISCV_ISA_ZICBOM
+	bool "Zicbom extension support for non-coherent dma operation"
+	select ARCH_HAS_DMA_PREP_COHERENT
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_SETUP_DMA_OPS
+	select DMA_DIRECT_REMAP
+	select RISCV_ALTERNATIVE
+	default y
+	help
+	   Adds support to dynamically detect the presence of the ZICBOM extension
+	   (Cache Block Management Operations) and enable its usage.
+
+	   If you don't know what to do here, say Y.
+
 config FPU
 	bool "FPU support"
 	default y
diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 23ff70350992..eb12d014b158 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -42,6 +42,12 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
 
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_RISCV_ISA_ZICBOM
+void riscv_init_cbom_blocksize(void);
+#else
+static inline void riscv_init_cbom_blocksize(void) { }
+#endif
+
 /*
  * Bits in sys_riscv_flush_icache()'s flags argument.
  */
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 398e351e7002..2e80a75b5241 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -20,7 +20,8 @@
 #endif
 
 #define	CPUFEATURE_SVPBMT 0
-#define	CPUFEATURE_NUMBER 1
+#define	CPUFEATURE_CMO 1
+#define	CPUFEATURE_NUMBER 2
 
 #ifdef __ASSEMBLY__
 
@@ -87,6 +88,39 @@ asm volatile(ALTERNATIVE(						\
 #define ALT_THEAD_PMA(_val)
 #endif
 
+/*
+ * cbo.clean rs1
+ * | 31 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *    0...01     rs1       010      00000  0001111
+ *
+ * cbo.flush rs1
+ * | 31 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *    0...10     rs1       010      00000  0001111
+ *
+ * cbo.inval rs1
+ * | 31 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
+ *    0...00     rs1       010      00000  0001111
+ */
+#define CBO_INVAL_A0	".long 0x15200F"
+#define CBO_CLEAN_A0	".long 0x25200F"
+#define CBO_FLUSH_A0	".long 0x05200F"
+
+#define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
+asm volatile(ALTERNATIVE(						\
+	__nops(5),							\
+	"mv a0, %1\n\t"							\
+	"j 2f\n\t"							\
+	"3:\n\t"							\
+	CBO_##_op##_A0 "\n\t"						\
+	"add a0, a0, %0\n\t"						\
+	"2:\n\t"							\
+	"bltu a0, %2, 3b\n\t", 0,					\
+		CPUFEATURE_CMO, CONFIG_RISCV_ISA_ZICBOM)		\
+	: : "r"(_cachesize),						\
+	    "r"(ALIGN((_start), (_cachesize))),				\
+	    "r"(ALIGN((_start) + (_size), (_cachesize)))		\
+	: "a0")
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 4e2486881840..6044e402003d 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -53,6 +53,7 @@ extern unsigned long elf_hwcap;
 enum riscv_isa_ext_id {
 	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
 	RISCV_ISA_EXT_SVPBMT,
+	RISCV_ISA_EXT_ZICBOM,
 	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index fba9e9f46a8c..0365557f7122 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -89,6 +89,7 @@ int riscv_of_parent_hartid(struct device_node *node)
 static struct riscv_isa_ext_data isa_ext_arr[] = {
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
+	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
 	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
 };
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 6a40cb8134bd..e956f4d763ec 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -199,6 +199,7 @@ void __init riscv_fill_hwcap(void)
 			} else {
 				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
 				SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_SVPBMT);
+				SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_ZICBOM);
 			}
 #undef SET_ISA_EXT_MAP
 		}
@@ -259,6 +260,20 @@ static bool __init_or_module cpufeature_probe_svpbmt(unsigned int stage)
 	return false;
 }
 
+static bool __init_or_module cpufeature_probe_cmo(unsigned int stage)
+{
+#ifdef CONFIG_RISCV_ISA_ZICBOM
+	switch (stage) {
+	case RISCV_ALTERNATIVES_EARLY_BOOT:
+		return false;
+	default:
+		return riscv_isa_extension_available(NULL, ZICBOM);
+	}
+#endif
+
+	return false;
+}
+
 /*
  * Probe presence of individual extensions.
  *
@@ -273,6 +288,9 @@ static u32 __init_or_module cpufeature_probe(unsigned int stage)
 	if (cpufeature_probe_svpbmt(stage))
 		cpu_req_feature |= (1U << CPUFEATURE_SVPBMT);
 
+	if (cpufeature_probe_cmo(stage))
+		cpu_req_feature |= (1U << CPUFEATURE_CMO);
+
 	return cpu_req_feature;
 }
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f0f36a4a0e9b..95ef6e2bf45c 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -22,6 +22,7 @@
 #include <linux/crash_dump.h>
 
 #include <asm/alternative.h>
+#include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable.h>
@@ -296,6 +297,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	riscv_fill_hwcap();
+	riscv_init_cbom_blocksize();
 	apply_boot_alternatives();
 }
 
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index ac7a25298a04..548f2f3c00e9 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -30,3 +30,4 @@ endif
 endif
 
 obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
+obj-$(CONFIG_RISCV_ISA_ZICBOM) += dma-noncoherent.o
diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
new file mode 100644
index 000000000000..f77f4c529835
--- /dev/null
+++ b/arch/riscv/mm/dma-noncoherent.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RISC-V specific functions to support DMA for non-coherent devices
+ *
+ * Copyright (c) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/dma-direct.h>
+#include <linux/dma-map-ops.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/libfdt.h>
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <asm/cacheflush.h>
+
+static unsigned int riscv_cbom_block_size = L1_CACHE_BYTES;
+
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		ALT_CMO_OP(CLEAN, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
+		break;
+	case DMA_FROM_DEVICE:
+		ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
+		break;
+	case DMA_BIDIRECTIONAL:
+		ALT_CMO_OP(FLUSH, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
+		break;
+	default:
+		break;
+	}
+}
+
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		ALT_CMO_OP(INVAL, (unsigned long)phys_to_virt(paddr), size, riscv_cbom_block_size);
+		break;
+	default:
+		break;
+	}
+}
+
+void arch_dma_prep_coherent(struct page *page, size_t size)
+{
+	void *flush_addr = page_address(page);
+
+	memset(flush_addr, 0, size);
+	ALT_CMO_OP(FLUSH, (unsigned long)flush_addr, size, riscv_cbom_block_size);
+}
+
+void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
+		const struct iommu_ops *iommu, bool coherent)
+{
+	/* If a specific device is dma-coherent, set it here */
+	dev->dma_coherent = coherent;
+}
+
+void riscv_init_cbom_blocksize(void)
+{
+	struct device_node *node;
+	int ret;
+	u32 val;
+
+	for_each_of_cpu_node(node) {
+		int hartid = riscv_of_processor_hartid(node);
+		int cbom_hartid;
+
+		if (hartid < 0)
+			continue;
+
+		/* set block-size for cbom extension if available */
+		ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
+		if (ret)
+			continue;
+
+		if (!riscv_cbom_block_size) {
+			riscv_cbom_block_size = val;
+			cbom_hartid = hartid;
+		} else {
+			if (riscv_cbom_block_size != val)
+				pr_warn("cbom-block-size mismatched between harts %d and %d\n",
+					cbom_hartid, hartid);
+		}
+	}
+}
-- 
2.35.1

