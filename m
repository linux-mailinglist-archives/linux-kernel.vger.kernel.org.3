Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8EE5A8AC6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiIABdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiIABc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:32:57 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDEF155A5D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 18:32:53 -0700 (PDT)
Received: from coburn.home.jannau.net (p54acc2ba.dip0.t-ipconnect.de [84.172.194.186])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 7DE7B26EF4A;
        Thu,  1 Sep 2022 03:25:21 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     iommu@lists.linux.dev
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Joerg Roedel <joro@8bytes.org>,
        Sven Peter <sven@svenpeter.dev>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/5] iommu/io-pgtable: Move Apple DART support to its own file
Date:   Thu,  1 Sep 2022 03:25:16 +0200
Message-Id: <20220901012519.7167-3-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901012519.7167-1-j@jannau.net>
References: <20220901012519.7167-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pte format used by the DARTs found in the Apple M1 (t8103) is not
fully compatible with io-pgtable-arm. The 24 MSB are used for subpage
protection (mapping only parts of page) and conflict with the address
mask. In addition bit 1 is not available for tagging entries but disables
subpage protection. Subpage protection could be useful to support a CPU
granule of 4k with the fixed IOMMU page size of 16k.

The DARTs found on Apple M1 Pro/Max/Ultra use another different pte
format which is even less compatible. To support an output address size
of 42 bit the address is shifted down by 4. Subpage protection is
mandatory and bit 1 signifies uncached mappings used by the display
controller.

It would be advantageous to share code for all known Apple DART
variants to support common features. The page table allocator for DARTs
is less complex since it uses a two levels of translation table without
support for huge pages.

Signed-off-by: Janne Grunau <j@jannau.net>
Acked-by: Robin Murphy <robin.murphy@arm.com>

---

Changes in v4:
- split dart and io-pgtable-dart build to allow building dart as module
- add missing "SELECT IOMMU_IO_PGTABLE"
- made map/unmap_pages/iova_to_phys inon-recursive
- replace pgd concatenation with multiple table handling
- simplified config and page size checks
- collected Robin's Ack

Changes in v3:
- move APPLE_DART to its own io-pgtable implementation, copied from
  io-pgtable-arm and simplified

Changes in v2:
- add APPLE_DART2 io-pgtable format

 MAINTAINERS                     |   1 +
 drivers/iommu/Kconfig           |  13 +-
 drivers/iommu/Makefile          |   1 +
 drivers/iommu/io-pgtable-arm.c  |  63 -----
 drivers/iommu/io-pgtable-dart.c | 428 ++++++++++++++++++++++++++++++++
 drivers/iommu/io-pgtable.c      |   2 +
 6 files changed, 444 insertions(+), 64 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-dart.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fc9ead83d2a..028b7e31e589 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1848,6 +1848,7 @@ F:	drivers/clk/clk-apple-nco.c
 F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
 F:	drivers/iommu/apple-dart.c
+F:	drivers/iommu/io-pgtable-dart.c
 F:	drivers/irqchip/irq-apple-aic.c
 F:	drivers/mailbox/apple-mailbox.c
 F:	drivers/nvme/host/apple.c
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c79a0df090c0..026921c1df53 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -67,6 +67,17 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
 	  If unsure, say N here.
 
+config IOMMU_IO_PGTABLE_DART
+	bool "Apple DART Formats"
+	select IOMMU_IO_PGTABLE
+	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
+	help
+	  Enable support for the Apple DART pagetable formats. These include
+	  the t8020 and t6000/t8110 DART formats used in Apple M1/M2 family
+	  SoCs.
+
+	  If unsure, say N here.
+
 endmenu
 
 config IOMMU_DEBUGFS
@@ -294,7 +305,7 @@ config APPLE_DART
 	tristate "Apple DART IOMMU Support"
 	depends on ARCH_APPLE || (COMPILE_TEST && !GENERIC_ATOMIC64)
 	select IOMMU_API
-	select IOMMU_IO_PGTABLE_LPAE
+	select IOMMU_IO_PGTABLE_DART
 	default ARCH_APPLE
 	help
 	  Support for Apple DART (Device Address Resolution Table) IOMMUs
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 44475a9b3eea..cc9f381013c3 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
+obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
 obj-$(CONFIG_IOASID) += ioasid.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 94ff319ae8ac..d7f5e23da643 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -130,9 +130,6 @@
 #define ARM_MALI_LPAE_MEMATTR_IMP_DEF	0x88ULL
 #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
 
-#define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
-#define APPLE_DART_PTE_PROT_NO_READ (1<<8)
-
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
@@ -406,15 +403,6 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 {
 	arm_lpae_iopte pte;
 
-	if (data->iop.fmt == APPLE_DART) {
-		pte = 0;
-		if (!(prot & IOMMU_WRITE))
-			pte |= APPLE_DART_PTE_PROT_NO_WRITE;
-		if (!(prot & IOMMU_READ))
-			pte |= APPLE_DART_PTE_PROT_NO_READ;
-		return pte;
-	}
-
 	if (data->iop.fmt == ARM_64_LPAE_S1 ||
 	    data->iop.fmt == ARM_32_LPAE_S1) {
 		pte = ARM_LPAE_PTE_nG;
@@ -1107,52 +1095,6 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	return NULL;
 }
 
-static struct io_pgtable *
-apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
-{
-	struct arm_lpae_io_pgtable *data;
-	int i;
-
-	if (cfg->oas > 36)
-		return NULL;
-
-	data = arm_lpae_alloc_pgtable(cfg);
-	if (!data)
-		return NULL;
-
-	/*
-	 * The table format itself always uses two levels, but the total VA
-	 * space is mapped by four separate tables, making the MMIO registers
-	 * an effective "level 1". For simplicity, though, we treat this
-	 * equivalently to LPAE stage 2 concatenation at level 2, with the
-	 * additional TTBRs each just pointing at consecutive pages.
-	 */
-	if (data->start_level < 1)
-		goto out_free_data;
-	if (data->start_level == 1 && data->pgd_bits > 2)
-		goto out_free_data;
-	if (data->start_level > 1)
-		data->pgd_bits = 0;
-	data->start_level = 2;
-	cfg->apple_dart_cfg.n_ttbrs = 1 << data->pgd_bits;
-	data->pgd_bits += data->bits_per_level;
-
-	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data), GFP_KERNEL,
-					   cfg);
-	if (!data->pgd)
-		goto out_free_data;
-
-	for (i = 0; i < cfg->apple_dart_cfg.n_ttbrs; ++i)
-		cfg->apple_dart_cfg.ttbr[i] =
-			virt_to_phys(data->pgd + i * ARM_LPAE_GRANULE(data));
-
-	return &data->iop;
-
-out_free_data:
-	kfree(data);
-	return NULL;
-}
-
 struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
 	.alloc	= arm_64_lpae_alloc_pgtable_s1,
 	.free	= arm_lpae_free_pgtable,
@@ -1178,11 +1120,6 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
 	.free	= arm_lpae_free_pgtable,
 };
 
-struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns = {
-	.alloc	= apple_dart_alloc_pgtable,
-	.free	= arm_lpae_free_pgtable,
-};
-
 #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
 
 static struct io_pgtable_cfg *cfg_cookie __initdata;
diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
new file mode 100644
index 000000000000..43ef375812e6
--- /dev/null
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Apple DART page table allocator.
+ *
+ * Copyright (C) 2022 The Asahi Linux Contributors
+ *
+ * Based on io-pgtable-arm.
+ *
+ * Copyright (C) 2014 ARM Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#define pr_fmt(fmt)	"dart io-pgtable: " fmt
+
+#include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/io-pgtable.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <asm/barrier.h>
+
+#define DART1_MAX_ADDR_BITS	36
+
+#define DART_MAX_TABLES		4
+#define DART_LEVELS		2
+
+/* Struct accessors */
+#define io_pgtable_to_data(x)						\
+	container_of((x), struct dart_io_pgtable, iop)
+
+#define io_pgtable_ops_to_data(x)					\
+	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
+
+#define DART_GRANULE(d)						\
+	(sizeof(dart_iopte) << (d)->bits_per_level)
+#define DART_PTES_PER_TABLE(d)					\
+	(DART_GRANULE(d) >> ilog2(sizeof(dart_iopte)))
+
+#define APPLE_DART1_PADDR_MASK	GENMASK_ULL(35, 12)
+
+/* Apple DART1 protection bits */
+#define APPLE_DART1_PTE_PROT_NO_READ	BIT(8)
+#define APPLE_DART1_PTE_PROT_NO_WRITE	BIT(7)
+#define APPLE_DART1_PTE_PROT_SP_DIS	BIT(1)
+
+/* marks PTE as valid */
+#define APPLE_DART_PTE_VALID		BIT(0)
+
+/* IOPTE accessors */
+#define iopte_deref(pte, d) __va(iopte_to_paddr(pte, d))
+
+struct dart_io_pgtable {
+	struct io_pgtable	iop;
+
+	int			tbl_bits;
+	int			bits_per_level;
+
+	void			*pgd[DART_MAX_TABLES];
+};
+
+typedef u64 dart_iopte;
+
+
+static dart_iopte paddr_to_iopte(phys_addr_t paddr,
+				     struct dart_io_pgtable *data)
+{
+	return paddr & APPLE_DART1_PADDR_MASK;
+}
+
+static phys_addr_t iopte_to_paddr(dart_iopte pte,
+				  struct dart_io_pgtable *data)
+{
+	return pte & APPLE_DART1_PADDR_MASK;
+}
+
+static void *__dart_alloc_pages(size_t size, gfp_t gfp,
+				    struct io_pgtable_cfg *cfg)
+{
+	struct device *dev = cfg->iommu_dev;
+	int order = get_order(size);
+	struct page *p;
+
+	VM_BUG_ON((gfp & __GFP_HIGHMEM));
+	p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
+			     gfp | __GFP_ZERO, order);
+	if (!p)
+		return NULL;
+
+	return page_address(p);
+}
+
+static int dart_init_pte(struct dart_io_pgtable *data,
+			     unsigned long iova, phys_addr_t paddr,
+			     dart_iopte prot, int num_entries,
+			     dart_iopte *ptep)
+{
+	int i;
+	dart_iopte pte = prot;
+	size_t sz = data->iop.cfg.pgsize_bitmap;
+
+	for (i = 0; i < num_entries; i++)
+		if (ptep[i] & APPLE_DART_PTE_VALID) {
+			/* We require an unmap first */
+			WARN_ON(ptep[i] & APPLE_DART_PTE_VALID);
+			return -EEXIST;
+		}
+
+	pte |= APPLE_DART1_PTE_PROT_SP_DIS;
+	pte |= APPLE_DART_PTE_VALID;
+
+	for (i = 0; i < num_entries; i++)
+		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
+
+	return 0;
+}
+
+static dart_iopte dart_install_table(dart_iopte *table,
+					     dart_iopte *ptep,
+					     dart_iopte curr,
+					     struct dart_io_pgtable *data)
+{
+	dart_iopte old, new;
+
+	new = paddr_to_iopte(__pa(table), data) | APPLE_DART_PTE_VALID;
+
+	/*
+	 * Ensure the table itself is visible before its PTE can be.
+	 * Whilst we could get away with cmpxchg64_release below, this
+	 * doesn't have any ordering semantics when !CONFIG_SMP.
+	 */
+	dma_wmb();
+
+	old = cmpxchg64_relaxed(ptep, curr, new);
+
+	return old;
+}
+
+static int dart_get_table(struct dart_io_pgtable *data, unsigned long iova)
+{
+	return (iova >> (3 * data->bits_per_level + ilog2(sizeof(dart_iopte)))) &
+		((1 << data->tbl_bits) - 1);
+}
+
+static int dart_get_l1_index(struct dart_io_pgtable *data, unsigned long iova)
+{
+
+	return (iova >> (2 * data->bits_per_level + ilog2(sizeof(dart_iopte)))) &
+		 ((1 << data->bits_per_level) - 1);
+}
+
+static int dart_get_l2_index(struct dart_io_pgtable *data, unsigned long iova)
+{
+
+	return (iova >> (data->bits_per_level + ilog2(sizeof(dart_iopte)))) &
+		 ((1 << data->bits_per_level) - 1);
+}
+
+static  dart_iopte *dart_get_l2(struct dart_io_pgtable *data, unsigned long iova)
+{
+	dart_iopte pte, *ptep;
+	int tbl = dart_get_table(data, iova);
+
+	ptep = data->pgd[tbl];
+	if (!ptep)
+		return NULL;
+
+	ptep += dart_get_l1_index(data, iova);
+	pte = READ_ONCE(*ptep);
+
+	/* Valid entry? */
+	if (!pte)
+		return 0;
+
+	/* Deref to get level 2 table */
+	return iopte_deref(pte, data);
+}
+
+static dart_iopte dart_prot_to_pte(struct dart_io_pgtable *data,
+					   int prot)
+{
+	dart_iopte pte = 0;
+
+	if (!(prot & IOMMU_WRITE))
+		pte |= APPLE_DART1_PTE_PROT_NO_WRITE;
+	if (!(prot & IOMMU_READ))
+		pte |= APPLE_DART1_PTE_PROT_NO_READ;
+
+	return pte;
+}
+
+static int dart_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
+			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			      int iommu_prot, gfp_t gfp, size_t *mapped)
+{
+	struct dart_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	size_t tblsz = DART_GRANULE(data);
+	int ret = 0, tbl, num_entries, max_entries, map_idx_start;
+	dart_iopte pte, *cptep, *ptep;
+	dart_iopte prot;
+
+	if (WARN_ON(pgsize != cfg->pgsize_bitmap))
+		return -EINVAL;
+
+	if (WARN_ON(paddr >> cfg->oas))
+		return -ERANGE;
+
+	/* If no access, then nothing to do */
+	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
+		return 0;
+
+	tbl = dart_get_table(data, iova);
+
+	ptep = data->pgd[tbl];
+	ptep += dart_get_l1_index(data, iova);
+	pte = READ_ONCE(*ptep);
+
+	/* no L2 table present */
+	if (!pte) {
+		cptep = __dart_alloc_pages(tblsz, gfp, cfg);
+		if (!cptep)
+			return -ENOMEM;
+
+		pte = dart_install_table(cptep, ptep, 0, data);
+		if (pte)
+			free_pages((unsigned long)cptep, get_order(tblsz));
+
+		/* L2 table is present (now) */
+		pte = READ_ONCE(*ptep);
+	}
+
+	ptep = iopte_deref(pte, data);
+
+	/* install a leaf entries into L2 table */
+	prot = dart_prot_to_pte(data, iommu_prot);
+	map_idx_start = dart_get_l2_index(data, iova);
+	max_entries = DART_PTES_PER_TABLE(data) - map_idx_start;
+	num_entries = min_t(int, pgcount, max_entries);
+	ptep += map_idx_start;
+	ret = dart_init_pte(data, iova, paddr, prot, num_entries, ptep);
+	if (!ret && mapped)
+		*mapped += num_entries * pgsize;
+
+	/*
+	 * Synchronise all PTE updates for the new mapping before there's
+	 * a chance for anything to kick off a table walk for the new iova.
+	 */
+	wmb();
+
+	return ret;
+}
+
+static size_t dart_unmap_pages(struct io_pgtable_ops *ops, unsigned long iova,
+				   size_t pgsize, size_t pgcount,
+				   struct iommu_iotlb_gather *gather)
+{
+	struct dart_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	struct io_pgtable_cfg *cfg = &data->iop.cfg;
+	int i = 0, num_entries, max_entries, unmap_idx_start;
+	dart_iopte pte, *ptep;
+
+	if (WARN_ON(pgsize != cfg->pgsize_bitmap || !pgcount))
+		return 0;
+
+	ptep = dart_get_l2(data, iova);
+
+	/* Valid L2 IOPTE pointer? */
+	if (WARN_ON(!ptep))
+		return 0;
+
+	unmap_idx_start = dart_get_l2_index(data, iova);
+	ptep += unmap_idx_start;
+
+	max_entries = DART_PTES_PER_TABLE(data) - unmap_idx_start;
+	num_entries = min_t(int, pgcount, max_entries);
+
+	while (i < num_entries) {
+		pte = READ_ONCE(*ptep);
+		if (WARN_ON(!pte))
+			break;
+
+		/* clear pte */
+		*ptep = 0;
+
+		if (!iommu_iotlb_gather_queued(gather))
+			io_pgtable_tlb_add_page(&data->iop, gather,
+						iova + i * pgsize, pgsize);
+
+		ptep++;
+		i++;
+	}
+
+	return i * pgsize;
+}
+
+static phys_addr_t dart_iova_to_phys(struct io_pgtable_ops *ops,
+					 unsigned long iova)
+{
+	struct dart_io_pgtable *data = io_pgtable_ops_to_data(ops);
+	dart_iopte pte, *ptep;
+
+	ptep = dart_get_l2(data, iova);
+
+	/* Valid L2 IOPTE pointer? */
+	if (!ptep)
+		return 0;
+
+	ptep += dart_get_l2_index(data, iova);
+
+	pte = READ_ONCE(*ptep);
+	/* Found translation */
+	if (pte) {
+		iova &= (data->iop.cfg.pgsize_bitmap - 1);
+		return iopte_to_paddr(pte, data) | iova;
+	}
+
+	/* Ran out of page tables to walk */
+	return 0;
+}
+
+static struct dart_io_pgtable *
+dart_alloc_pgtable(struct io_pgtable_cfg *cfg)
+{
+	struct dart_io_pgtable *data;
+	int tbl_bits, bits_per_level, va_bits, pg_shift;
+
+	pg_shift = __ffs(cfg->pgsize_bitmap);
+	bits_per_level = pg_shift - ilog2(sizeof(dart_iopte));
+
+	va_bits = cfg->ias - pg_shift;
+
+	tbl_bits = max_t(int, 0, va_bits - (bits_per_level * DART_LEVELS));
+	if ((1 << tbl_bits) > DART_MAX_TABLES)
+		return NULL;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	data->tbl_bits = tbl_bits;
+	data->bits_per_level = bits_per_level;
+
+	data->iop.ops = (struct io_pgtable_ops) {
+		.map_pages	= dart_map_pages,
+		.unmap_pages	= dart_unmap_pages,
+		.iova_to_phys	= dart_iova_to_phys,
+	};
+
+	return data;
+}
+
+static struct io_pgtable *
+apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
+{
+	struct dart_io_pgtable *data;
+	int i;
+
+	if (!cfg->coherent_walk)
+		return NULL;
+
+	if (cfg->oas > DART1_MAX_ADDR_BITS)
+		return NULL;
+
+	if (cfg->ias > cfg->oas)
+		return NULL;
+
+	if (!(cfg->pgsize_bitmap == SZ_4K || cfg->pgsize_bitmap == SZ_16K))
+		return NULL;
+
+	data = dart_alloc_pgtable(cfg);
+	if (!data)
+		return NULL;
+
+	cfg->apple_dart_cfg.n_ttbrs = 1 << data->tbl_bits;
+
+	for (i = 0; i < cfg->apple_dart_cfg.n_ttbrs; ++i) {
+		data->pgd[i] = __dart_alloc_pages(DART_GRANULE(data), GFP_KERNEL,
+					   cfg);
+		if (!data->pgd[i])
+			goto out_free_data;
+		cfg->apple_dart_cfg.ttbr[i] = virt_to_phys(data->pgd[i]);
+	}
+
+	return &data->iop;
+
+out_free_data:
+	while (--i >= 0)
+		free_pages((unsigned long)data->pgd[i],
+			   get_order(DART_GRANULE(data)));
+	kfree(data);
+	return NULL;
+}
+
+static void apple_dart_free_pgtable(struct io_pgtable *iop)
+{
+	struct dart_io_pgtable *data = io_pgtable_to_data(iop);
+	dart_iopte *ptep, *end;
+	int i;
+
+	for (i = 0; i < (1 << data->tbl_bits) && data->pgd[i]; ++i) {
+		ptep = data->pgd[i];
+		end = (void *)ptep + DART_GRANULE(data);
+
+		while (ptep != end) {
+			dart_iopte pte = *ptep++;
+
+			if (pte) {
+				unsigned long page =
+					(unsigned long)iopte_deref(pte, data);
+
+				free_pages(page, get_order(DART_GRANULE(data)));
+			}
+		}
+		free_pages((unsigned long)data->pgd[i],
+			   get_order(DART_GRANULE(data)));
+	}
+
+	kfree(data);
+}
+
+struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns = {
+	.alloc	= apple_dart_alloc_pgtable,
+	.free	= apple_dart_free_pgtable,
+};
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index f4bfcef98297..16205ea9272c 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -20,6 +20,8 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 	[ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
 	[ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
 	[ARM_MALI_LPAE] = &io_pgtable_arm_mali_lpae_init_fns,
+#endif
+#ifdef CONFIG_IOMMU_IO_PGTABLE_DART
 	[APPLE_DART] = &io_pgtable_apple_dart_init_fns,
 #endif
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
-- 
2.35.1

