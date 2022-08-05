Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6909158A71E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiHEHbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiHEHbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:31:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EDDD27FE5;
        Fri,  5 Aug 2022 00:31:22 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxQM9Cx+xiA5sHAA--.28007S4;
        Fri, 05 Aug 2022 15:31:15 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     lpieralisi@kernel.org, robin.murphy@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, lenb@kernel.org,
        robert.moore@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH V2 2/2] LoongArch: Remove ARCH_HAS_PHYS_TO_DMA
Date:   Fri,  5 Aug 2022 15:31:14 +0800
Message-Id: <1659684674-40612-3-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659684674-40612-1-git-send-email-lvjianmin@loongson.cn>
References: <1659684674-40612-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9DxQM9Cx+xiA5sHAA--.28007S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKF18XryrKry7WFW8XF1rCrg_yoW7XFyfpa
        sIkrs8Gr4xKrs7Xr97Cw1rur15Xr92ka47XFW7K3sakF12qr1UXr1vyF9rXFy5trZrKF4I
        vF95uFyYgF4UWw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUklb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
        AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
        6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
        v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
        v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28I
        cVCjz48v1sIEY20_XrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU56c_DUUUU
        U==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use _DMA defined in ACPI spec for translation betweeen
DMA address and CPU address, and implement acpi_arch_dma_setup
for initializing dev->dma_range_map, where acpi_dma_get_range
is called for parsing _DMA.

e.g.
If we have two dma ranges:
cpu address      dma address    size         offset
0x200080000000   0x2080000000   0x400000000  0x1fe000000000
0x400080000000   0x4080000000   0x400000000  0x3fc000000000

_DMA for pci devices should be declared in host bridge as
flowing:

Name (_DMA, ResourceTemplate() {
        QWordMemory (ResourceProducer,
            PosDecode,
            MinFixed,
            MaxFixed,
            NonCacheable,
            ReadWrite,
            0x0,
            0x4080000000,
            0x447fffffff,
            0x3fc000000000,
            0x400000000,
            ,
            ,
            )

        QWordMemory (ResourceProducer,
            PosDecode,
            MinFixed,
            MaxFixed,
            NonCacheable,
            ReadWrite,
            0x0,
            0x2080000000,
            0x247fffffff,
            0x1fe000000000,
            0x400000000,
            ,
            ,
            )
    })

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 arch/loongarch/Kconfig        |  1 -
 arch/loongarch/kernel/dma.c   | 62 +++++++++++++++++++++----------------------
 arch/loongarch/kernel/setup.c |  2 +-
 include/linux/acpi.h          |  9 ++++---
 4 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index b57daee..9dedcf9 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -7,7 +7,6 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
-	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
diff --git a/arch/loongarch/kernel/dma.c b/arch/loongarch/kernel/dma.c
index 8c9b531..7850e6b 100644
--- a/arch/loongarch/kernel/dma.c
+++ b/arch/loongarch/kernel/dma.c
@@ -2,39 +2,39 @@
 /*
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
-#include <linux/init.h>
+#include <linux/acpi.h>
 #include <linux/dma-direct.h>
-#include <linux/dma-mapping.h>
-#include <linux/dma-map-ops.h>
-#include <linux/swiotlb.h>
 
-#include <asm/bootinfo.h>
-#include <asm/dma.h>
-#include <asm/loongson.h>
-
-/*
- * We extract 4bit node id (bit 44~47) from Loongson-3's
- * 48bit physical address space and embed it into 40bit.
- */
-
-static int node_id_offset;
-
-dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
-{
-	long nid = (paddr >> 44) & 0xf;
-
-	return ((nid << 44) ^ paddr) | (nid << node_id_offset);
-}
-
-phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+void acpi_arch_dma_setup(struct device *dev)
 {
-	long nid = (daddr >> node_id_offset) & 0xf;
+	int ret;
+	const struct bus_dma_region *map = NULL;
+
+	ret = acpi_dma_get_range(dev, &map);
+	if (!ret) {
+		const struct bus_dma_region *r = map;
+		u64 mask, dma_start, dma_end = 0;
+
+		/* determine the overall bounds of all dma regions */
+		for (dma_start = U64_MAX; r->size; r++) {
+
+			/* Take lower and upper limits */
+			if (r->dma_start < dma_start)
+				dma_start = r->dma_start;
+			if (r->dma_start + r->size - 1 > dma_end)
+				dma_end = r->dma_start + r->size - 1;
+		}
+
+		if (dma_start >= dma_end) {
+			dev_dbg(dev, "Invalid DMA regions configuration\n");
+			return;
+		}
+
+		mask = DMA_BIT_MASK(ilog2(dma_end) + 1);
+		dev->bus_dma_limit = dma_end;
+		dev->dma_range_map = map;
+		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
+		*dev->dma_mask = min(*dev->dma_mask, mask);
+	}
 
-	return ((nid << node_id_offset) ^ daddr) | (nid << 44);
-}
-
-void __init plat_swiotlb_setup(void)
-{
-	swiotlb_init(true, SWIOTLB_VERBOSE);
-	node_id_offset = ((readl(LS7A_DMA_CFG) & LS7A_DMA_NODE_MASK) >> LS7A_DMA_NODE_SHF) + 36;
 }
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index c74860b..974f085 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -247,7 +247,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	sparse_init();
 	memblock_set_bottom_up(true);
 
-	plat_swiotlb_setup();
+	swiotlb_init(true, SWIOTLB_VERBOSE);
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 34e0545..33977b87 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -278,14 +278,17 @@ int acpi_table_parse_madt(enum acpi_madt_type id,
 
 void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
 
+#if defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
+void acpi_arch_dma_setup(struct device *dev);
+#else
+static inline void acpi_arch_dma_setup(struct device *dev) { }
+#endif
+
 #ifdef CONFIG_ARM64
 void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
-void acpi_arch_dma_setup(struct device *dev);
 #else
 static inline void
 acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
-static inline void
-acpi_arch_dma_setup(struct device *dev) { }
 #endif
 
 int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
-- 
1.8.3.1

