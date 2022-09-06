Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A1E5AE547
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbiIFKYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239440AbiIFKXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:23:02 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A08248E8B;
        Tue,  6 Sep 2022 03:22:18 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,293,1654527600"; 
   d="scan'208";a="133888055"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Sep 2022 19:22:18 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5344742174CA;
        Tue,  6 Sep 2022 19:22:14 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 2/2] riscv: vendors: andes: Add support for non-cohernet dma
Date:   Tue,  6 Sep 2022 11:21:54 +0100
Message-Id: <20220906102154.32526-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the AX45MP core, cache coherency is a specification option so it may
not be supported. In this case DMA will fail. As a workaround, firstly we
allocate a global dma coherent pool from which DMA allocations are taken
and marked as non-cacheable in the PMA region as specified in the device
tree. Synchronization callbacks are implemented to synchronize when doing
DMA transactions.

This feature is based on the work posted [0] by Vincent Chen
<vincentc@andestech.com> for the Andes AndeStart RISC-V CPU.

[0] https://lore.kernel.org/lkml/1540982130-28248-1-git-send-email-vincentc@andestech.com/

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/vendors/andes/Makefile             |   1 +
 arch/riscv/vendors/andes/ax45mp_cache.c       | 296 ++++++++++++++++++
 arch/riscv/vendors/andes/ax45mp_nocache_dma.c |  65 ++++
 arch/riscv/vendors/andes/include/proc.h       |   9 +
 4 files changed, 371 insertions(+)
 create mode 100644 arch/riscv/vendors/andes/ax45mp_cache.c
 create mode 100644 arch/riscv/vendors/andes/ax45mp_nocache_dma.c
 create mode 100644 arch/riscv/vendors/andes/include/proc.h

diff --git a/arch/riscv/vendors/andes/Makefile b/arch/riscv/vendors/andes/Makefile
index 60fa8226c4a3..f9ec92b92455 100644
--- a/arch/riscv/vendors/andes/Makefile
+++ b/arch/riscv/vendors/andes/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ARCH_R9A07G043) += ax45mp.o
+obj-$(CONFIG_ARCH_R9A07G043) += ax45mp_cache.o ax45mp_nocache_dma.o
diff --git a/arch/riscv/vendors/andes/ax45mp_cache.c b/arch/riscv/vendors/andes/ax45mp_cache.c
new file mode 100644
index 000000000000..6941821e7e4a
--- /dev/null
+++ b/arch/riscv/vendors/andes/ax45mp_cache.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * non-coherent cache functions for AX45MP
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ *
+ */
+
+#include <linux/cacheinfo.h>
+#include <linux/of_address.h>
+
+#include <asm/sbi.h>
+
+#include "include/sbi.h"
+
+/* D-cache operation */
+#define CCTL_L1D_VA_INVAL		0
+#define CCTL_L1D_VA_WB			1
+
+/* L2 cache */
+#define L2_CACHE_CTL_CEN_MASK		1
+
+/* L2 cache registers */
+#define L2C_REG_CTL_OFFSET		0x8
+#define L2C_REG_C0_CMD_OFFSET		0x40
+#define L2C_REG_C0_ACC_OFFSET		0x48
+#define L2C_REG_STATUS_OFFSET		0x80
+
+/* L2 CCTL status */
+#define CCTL_L2_STATUS_IDLE		0
+
+/* L2 CCTL status cores mask */
+#define CCTL_L2_STATUS_C0_MASK		0xf
+
+/* L2 cache operation */
+#define CCTL_L2_PA_INVAL		0x8
+#define CCTL_L2_PA_WB			0x9
+
+#define L2C_HPM_PER_CORE_OFFSET		0x8
+#define L2C_REG_PER_CORE_OFFSET		0x10
+#define CCTL_L2_STATUS_PER_CORE_OFFSET	4
+
+#define L2C_REG_CN_CMD_OFFSET(n)	\
+	(L2C_REG_C0_CMD_OFFSET + ((n) * L2C_REG_PER_CORE_OFFSET))
+#define L2C_REG_CN_ACC_OFFSET(n)	\
+	(L2C_REG_C0_ACC_OFFSET + ((n) * L2C_REG_PER_CORE_OFFSET))
+#define CCTL_L2_STATUS_CN_MASK(n)	\
+	(CCTL_L2_STATUS_C0_MASK << ((n) * CCTL_L2_STATUS_PER_CORE_OFFSET))
+
+#define MICM_CFG_ISZ_OFFSET		6
+#define MICM_CFG_ISZ_MASK		(0x7  << MICM_CFG_ISZ_OFFSET)
+
+#define MDCM_CFG_DSZ_OFFSET		6
+#define MDCM_CFG_DSZ_MASK		(0x7  << MDCM_CFG_DSZ_OFFSET)
+
+#define CCTL_REG_UCCTLBEGINADDR_NUM	0x80b
+#define CCTL_REG_UCCTLCOMMAND_NUM	0x80c
+
+#define MCACHE_CTL_CCTL_SUEN_OFFSET	8
+#define MMSC_CFG_CCTLCSR_OFFSET		16
+#define MISA_20_OFFSET			20
+
+#define MCACHE_CTL_CCTL_SUEN_MASK	(0x1 << MCACHE_CTL_CCTL_SUEN_OFFSET)
+#define MMSC_CFG_CCTLCSR_MASK		(0x1 << MMSC_CFG_CCTLCSR_OFFSET)
+#define MISA_20_MASK			(0x1 << MISA_20_OFFSET)
+
+#define MAX_CACHE_LINE_SIZE	256
+
+struct ax45mp_cache_info {
+	bool init_done;
+	int dcache_line_size;
+};
+
+static DEFINE_PER_CPU(struct ax45mp_cache_info, cpu_cache_info) = {
+	.init_done = 0,
+	.dcache_line_size = SZ_64,
+};
+
+static void __iomem *l2c_base;
+
+static uint32_t cpu_get_mcache_ctl_status(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_GET_MCACHE_CTL_STATUS, 0, 0, 0, 0, 0, 0);
+	return ret.value;
+}
+
+static uint32_t cpu_get_micm_cfg_status(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_GET_MICM_CTL_STATUS, 0, 0, 0, 0, 0, 0);
+	return ret.value;
+}
+
+static uint32_t cpu_get_mdcm_cfg_status(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_GET_MDCM_CTL_STATUS, 0, 0, 0, 0, 0, 0);
+	return ret.value;
+}
+
+static uint32_t cpu_get_mmsc_cfg_status(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_GET_MMSC_CTL_STATUS, 0, 0, 0, 0, 0, 0);
+	return ret.value;
+}
+
+static uint32_t cpu_get_misa_cfg_status(void)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_GET_MISA_CTL_STATUS, 0, 0, 0, 0, 0, 0);
+	return ret.value;
+}
+
+static void fill_cpu_cache_info(struct ax45mp_cache_info *cpu_ci)
+{
+	struct cpu_cacheinfo *this_cpu_ci =
+			get_cpu_cacheinfo(smp_processor_id());
+	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+	unsigned int i;
+
+	for (i = 0; i < this_cpu_ci->num_leaves ; i++, this_leaf++) {
+		if (this_leaf->type == CACHE_TYPE_DATA)
+			cpu_ci->dcache_line_size = this_leaf->coherency_line_size;
+	}
+
+	cpu_ci->init_done = true;
+}
+
+static inline int get_cache_line_size(void)
+{
+	struct ax45mp_cache_info *cpu_ci =
+			&per_cpu(cpu_cache_info, smp_processor_id());
+
+	if (unlikely(!cpu_ci->init_done))
+		fill_cpu_cache_info(cpu_ci);
+	return cpu_ci->dcache_line_size;
+}
+
+static uint32_t cpu_l2c_get_cctl_status(void)
+{
+	return readl((void *)(l2c_base + L2C_REG_STATUS_OFFSET));
+}
+
+static uint32_t cpu_l2c_ctl_status(void)
+{
+	return readl((void *)(l2c_base + L2C_REG_CTL_OFFSET));
+}
+
+static bool cpu_cache_controlable(void)
+{
+	return (((cpu_get_micm_cfg_status() & MICM_CFG_ISZ_MASK) ||
+		 (cpu_get_mdcm_cfg_status() & MDCM_CFG_DSZ_MASK)) &&
+		(cpu_get_misa_cfg_status() & MISA_20_MASK) &&
+		(cpu_get_mmsc_cfg_status() & MMSC_CFG_CCTLCSR_MASK) &&
+		(cpu_get_mcache_ctl_status() & MCACHE_CTL_CCTL_SUEN_MASK));
+}
+
+static void cpu_dcache_wb_range(unsigned long start,
+				unsigned long end,
+				int line_size)
+{
+	bool ucctl_ok = false;
+	unsigned long pa;
+	int mhartid = 0;
+#ifdef CONFIG_SMP
+	mhartid = smp_processor_id();
+#endif
+
+	ucctl_ok = cpu_cache_controlable();
+
+	while (end > start) {
+		if (ucctl_ok) {
+			csr_write(CCTL_REG_UCCTLBEGINADDR_NUM, start);
+			csr_write(CCTL_REG_UCCTLCOMMAND_NUM, CCTL_L1D_VA_WB);
+		}
+
+		if (l2c_base && (cpu_l2c_ctl_status() & L2_CACHE_CTL_CEN_MASK)) {
+			pa = virt_to_phys((void *)start);
+			writel(pa, (void *)(l2c_base + L2C_REG_CN_ACC_OFFSET(mhartid)));
+			writel(CCTL_L2_PA_WB, (void *)(l2c_base + L2C_REG_CN_CMD_OFFSET(mhartid)));
+			while ((cpu_l2c_get_cctl_status() &
+				CCTL_L2_STATUS_CN_MASK(mhartid)) != CCTL_L2_STATUS_IDLE)
+				;
+		}
+
+		start += line_size;
+	}
+}
+
+static void cpu_dcache_inval_range(unsigned long start,
+				   unsigned long end,
+				   int line_size)
+{
+	bool ucctl_ok = false;
+	unsigned long pa;
+	int mhartid = 0;
+#ifdef CONFIG_SMP
+	mhartid = smp_processor_id();
+#endif
+
+	ucctl_ok = cpu_cache_controlable();
+
+	while (end > start) {
+		if (ucctl_ok) {
+			csr_write(CCTL_REG_UCCTLBEGINADDR_NUM, start);
+			csr_write(CCTL_REG_UCCTLCOMMAND_NUM, CCTL_L1D_VA_INVAL);
+		}
+
+		if (l2c_base && (cpu_l2c_ctl_status() & L2_CACHE_CTL_CEN_MASK)) {
+			pa = virt_to_phys((void *)start);
+			writel(pa, (void *)(l2c_base + L2C_REG_CN_ACC_OFFSET(mhartid)));
+			writel(CCTL_L2_PA_INVAL,
+			       (void *)(l2c_base + L2C_REG_CN_CMD_OFFSET(mhartid)));
+			while ((cpu_l2c_get_cctl_status() &
+				CCTL_L2_STATUS_CN_MASK(mhartid)) != CCTL_L2_STATUS_IDLE)
+				;
+		}
+
+		start += line_size;
+	}
+}
+
+void cpu_dma_inval_range(unsigned long start, unsigned long end)
+{
+	unsigned long line_size = get_cache_line_size();
+	char cache_buf[2][MAX_CACHE_LINE_SIZE] = { 0 };
+	unsigned long old_start = start;
+	unsigned long old_end = end;
+	unsigned long flags;
+
+	if (unlikely(start == end))
+		return;
+
+	start = start & (~(line_size - 1));
+	end = ((end + line_size - 1) & (~(line_size - 1)));
+
+	local_irq_save(flags);
+	if (unlikely(start != old_start))
+		memcpy(&cache_buf[0][0], (void *)start, line_size);
+
+	if (unlikely(end != old_end))
+		memcpy(&cache_buf[1][0], (void *)(old_end & (~(line_size - 1))), line_size);
+
+	cpu_dcache_inval_range(start, end, line_size);
+
+	if (unlikely(start != old_start))
+		memcpy((void *)start, &cache_buf[0][0], (old_start & (line_size - 1)));
+
+	if (unlikely(end != old_end))
+		memcpy((void *)(old_end + 1),
+		       &cache_buf[1][(old_end & (line_size - 1)) + 1],
+		       end - old_end - 1);
+
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(cpu_dma_inval_range);
+
+void cpu_dma_wb_range(unsigned long start, unsigned long end)
+{
+	unsigned long flags;
+	unsigned long line_size = get_cache_line_size();
+
+	local_irq_save(flags);
+	start = start & (~(line_size - 1));
+	cpu_dcache_wb_range(start, end, line_size);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(cpu_dma_wb_range);
+
+static const struct of_device_id ax45mp_cache_ids[] = {
+	{ .compatible = "andestech,ax45mp-cache" },
+	{ /* sentinel */ }
+};
+
+static int __init ax45mp_cache_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, ax45mp_cache_ids);
+	if (!np)
+		return -ENODEV;
+
+	l2c_base = of_iomap(np, 0);
+	if (!l2c_base)
+		return -ENOMEM;
+
+	return 0;
+}
+arch_initcall(ax45mp_cache_init);
diff --git a/arch/riscv/vendors/andes/ax45mp_nocache_dma.c b/arch/riscv/vendors/andes/ax45mp_nocache_dma.c
new file mode 100644
index 000000000000..263012f89d0b
--- /dev/null
+++ b/arch/riscv/vendors/andes/ax45mp_nocache_dma.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMA callbacks implemented for the non-coherent cache
+ * on AX45MP
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ *
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
+
+#include "include/proc.h"
+
+static inline void cache_op(phys_addr_t paddr, size_t size,
+			    void (*fn)(unsigned long start, unsigned long end))
+{
+	unsigned long start;
+
+	start = (unsigned long)phys_to_virt(paddr);
+	fn(start, start + size);
+}
+
+void arch_sync_dma_for_device(phys_addr_t paddr,
+			      size_t size, enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_FROM_DEVICE:
+		cache_op(paddr, size, cpu_dma_inval_range);
+		break;
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cache_op(paddr, size, cpu_dma_wb_range);
+		break;
+	default:
+		BUG();
+	}
+}
+
+void arch_sync_dma_for_cpu(phys_addr_t paddr,
+			   size_t size, enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		cache_op(paddr, size, cpu_dma_inval_range);
+		break;
+	default:
+		BUG();
+	}
+}
+
+void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+		     gfp_t gfp, unsigned long attrs)
+{
+	return dma_alloc_from_global_coherent(dev, size, handle);
+}
+
+void arch_dma_free(struct device *dev, size_t size, void *vaddr,
+		   dma_addr_t handle, unsigned long attrs)
+{
+	dma_release_from_global_coherent(0, vaddr);
+}
diff --git a/arch/riscv/vendors/andes/include/proc.h b/arch/riscv/vendors/andes/include/proc.h
new file mode 100644
index 000000000000..ace9bcfccf6b
--- /dev/null
+++ b/arch/riscv/vendors/andes/include/proc.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __RISCV_ANDES_PROC_H
+#define __RISCV_ANDES_PROC_H
+
+void cpu_dma_inval_range(unsigned long start, unsigned long end);
+void cpu_dma_wb_range(unsigned long start, unsigned long end);
+
+#endif
-- 
2.25.1

