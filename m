Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080AA4FB71E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344269AbiDKJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241756AbiDKJOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:14:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D5F3F892
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:12:11 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KcNNB5P8yzFplN;
        Mon, 11 Apr 2022 17:09:46 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 17:12:06 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 17:12:05 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vijayb@linux.microsoft.com>, <f.fainelli@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH v3 1/3] arm64: mm: Do not defer reserve_crashkernel() if only ZONE_DMA32
Date:   Mon, 11 Apr 2022 17:24:53 +0800
Message-ID: <20220411092455.1461-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220411092455.1461-1-wangkefeng.wang@huawei.com>
References: <20220411092455.1461-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel could benefit due to BLOCK_MAPPINGS, see commit
031495635b46 ("arm64: Do not defer reserve_crashkernel() for
platforms with no DMA memory zones"), if only with ZONE_DMA32,
set arm64_dma_phys_limit to max_zone_phys(32) earlier in
arm64_memblock_init(), so platforms with just ZONE_DMA32 config
enabled will benefit.

Cc: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/mm/init.c | 23 ++++++++++++-----------
 arch/arm64/mm/mmu.c  |  6 ++----
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1e7b1550e2fc..897de41102d9 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -65,8 +65,9 @@ EXPORT_SYMBOL(memstart_addr);
  * Memory reservation for crash kernel either done early or deferred
  * depending on DMA memory zones configs (ZONE_DMA) --
  *
- * In absence of ZONE_DMA configs arm64_dma_phys_limit initialized
- * here instead of max_zone_phys().  This lets early reservation of
+ * In absence of ZONE_DMA and ZONE_DMA32 configs arm64_dma_phys_limit
+ * initialized here and if only with ZONE_DMA32 arm64_dma_phys_limit
+ * initialised to max_zone_phys(32). This lets early reservation of
  * crash kernel memory which has a dependency on arm64_dma_phys_limit.
  * Reserving memory early for crash kernel allows linear creation of block
  * mappings (greater than page-granularity) for all the memory bank rangs.
@@ -160,11 +161,10 @@ static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
 static void __init zone_sizes_init(unsigned long min, unsigned long max)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
-	unsigned int __maybe_unused acpi_zone_dma_bits;
-	unsigned int __maybe_unused dt_zone_dma_bits;
-	phys_addr_t __maybe_unused dma32_phys_limit = max_zone_phys(32);
-
 #ifdef CONFIG_ZONE_DMA
+	unsigned int acpi_zone_dma_bits;
+	unsigned int dt_zone_dma_bits;
+
 	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
 	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
 	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
@@ -172,9 +172,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
 #ifdef CONFIG_ZONE_DMA32
-	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(dma32_phys_limit);
-	if (!arm64_dma_phys_limit)
-		arm64_dma_phys_limit = dma32_phys_limit;
+	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(max_zone_phys(32));
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max;
 
@@ -336,8 +334,11 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
+	if (!IS_ENABLED(CONFIG_ZONE_DMA)) {
+		if (IS_ENABLED(CONFIG_ZONE_DMA32))
+			arm64_dma_phys_limit = max_zone_phys(32);
 		reserve_crashkernel();
+	}
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
@@ -385,7 +386,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
+	if (IS_ENABLED(CONFIG_ZONE_DMA))
 		reserve_crashkernel();
 
 	memblock_dump_all();
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 626ec32873c6..23734481318a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -529,8 +529,7 @@ static void __init map_mem(pgd_t *pgdp)
 
 #ifdef CONFIG_KEXEC_CORE
 	if (crash_mem_map) {
-		if (IS_ENABLED(CONFIG_ZONE_DMA) ||
-		    IS_ENABLED(CONFIG_ZONE_DMA32))
+		if (IS_ENABLED(CONFIG_ZONE_DMA))
 			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 		else if (crashk_res.end)
 			memblock_mark_nomap(crashk_res.start,
@@ -571,8 +570,7 @@ static void __init map_mem(pgd_t *pgdp)
 	 * through /sys/kernel/kexec_crash_size interface.
 	 */
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map &&
-	    !IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) {
+	if (crash_mem_map && !IS_ENABLED(CONFIG_ZONE_DMA)) {
 		if (crashk_res.end) {
 			__map_memblock(pgdp, crashk_res.start,
 				       crashk_res.end + 1,
-- 
2.26.2

