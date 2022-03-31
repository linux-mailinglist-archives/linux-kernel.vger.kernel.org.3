Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337794ED4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiCaH3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiCaH3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:29:39 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858641E95D2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:27:52 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KTZXy3JZFzBrrb;
        Thu, 31 Mar 2022 15:23:46 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 15:27:50 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 31 Mar 2022 15:27:50 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <vijayb@linux.microsoft.com>, <f.fainelli@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 resend 2/3] arm64: mm: Don't defer reserve_crashkernel() with dma_force_32bit
Date:   Thu, 31 Mar 2022 15:40:54 +0800
Message-ID: <20220331074055.125824-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220331074055.125824-1-wangkefeng.wang@huawei.com>
References: <20220331074055.125824-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

ARM64 enable ZONE_DMA by default, and with ZONE_DMA crash kernel
memory reservation is delayed until DMA zone memory range size
initilazation performed in zone_sizes_init(), but for most platforms
use 32bit dma_zone_bits, so add dma_force_32bit kernel parameter
if ZONE_DMA enabled, and initialize arm64_dma_phys_limit to
dma32_phys_limit in arm64_memblock_init() if dma_force_32bit
is setup, this could let the crash kernel reservation earlier,
and allows linear creation with block mapping.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/include/asm/kexec.h |  1 +
 arch/arm64/mm/init.c           | 42 ++++++++++++++++++++++++++--------
 arch/arm64/mm/mmu.c            |  4 ++--
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 9839bfc163d7..8bea40aea359 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -95,6 +95,7 @@ void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 		      unsigned long arg0, unsigned long arg1,
 		      unsigned long arg2);
 #endif
+bool crashkernel_could_early_reserve(void);
 
 #define ARCH_HAS_KIMAGE_ARCH
 
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index fb01eb489fa9..0aafa9181607 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -66,7 +66,8 @@ EXPORT_SYMBOL(memstart_addr);
  * depending on DMA memory zones configs (ZONE_DMA) --
  *
  * In absence of ZONE_DMA and ZONE_DMA32 configs arm64_dma_phys_limit
- * initialized here and if only with ZONE_DMA32 arm64_dma_phys_limit
+ * initialized here, and if only with ZONE_DMA32 or if with ZONE_DMA
+ * and dma_force_32bit kernel parameter, the arm64_dma_phys_limit is
  * initialised to dma32_phys_limit. This lets early reservation of
  * crash kernel memory which has a dependency on arm64_dma_phys_limit.
  * Reserving memory early for crash kernel allows linear creation of block
@@ -92,6 +93,27 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #endif
 
+static bool __ro_after_init arm64_dma_force_32bit;
+#ifdef CONFIG_ZONE_DMA
+static int __init arm64_dma_force_32bit_setup(char *p)
+{
+	zone_dma_bits = 32;
+	arm64_dma_force_32bit = true;
+
+	return 0;
+}
+early_param("dma_force_32bit", arm64_dma_force_32bit_setup);
+#endif
+
+bool __init crashkernel_could_early_reserve(void)
+{
+	if (!IS_ENABLED(CONFIG_ZONE_DMA))
+		return true;
+	if (arm64_dma_force_32bit)
+		return true;
+	return false;
+}
+
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -163,12 +185,14 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 #ifdef CONFIG_ZONE_DMA
-	unsigned int acpi_zone_dma_bits;
-	unsigned int dt_zone_dma_bits;
+	if (!arm64_dma_force_32bit) {
+		unsigned int acpi_zone_dma_bits;
+		unsigned int dt_zone_dma_bits;
 
-	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
-	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
-	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
+		acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
+		dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
+		zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
+	}
 	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
 	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
@@ -336,8 +360,8 @@ void __init arm64_memblock_init(void)
 	early_init_fdt_scan_reserved_mem();
 
 	dma32_phys_limit = max_zone_phys(32);
-	if (!IS_ENABLED(CONFIG_ZONE_DMA)) {
-		if (IS_ENABLED(CONFIG_ZONE_DMA32))
+	if (crashkernel_could_early_reserve()) {
+		if (IS_ENABLED(CONFIG_ZONE_DMA32) || arm64_dma_force_32bit)
 			arm64_dma_phys_limit = dma32_phys_limit;
 		reserve_crashkernel();
 	}
@@ -388,7 +412,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	if (IS_ENABLED(CONFIG_ZONE_DMA))
+	if (!crashkernel_could_early_reserve())
 		reserve_crashkernel();
 
 	memblock_dump_all();
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 23734481318a..8f7e8452d906 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -529,7 +529,7 @@ static void __init map_mem(pgd_t *pgdp)
 
 #ifdef CONFIG_KEXEC_CORE
 	if (crash_mem_map) {
-		if (IS_ENABLED(CONFIG_ZONE_DMA))
+		if (!crashkernel_could_early_reserve())
 			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 		else if (crashk_res.end)
 			memblock_mark_nomap(crashk_res.start,
@@ -570,7 +570,7 @@ static void __init map_mem(pgd_t *pgdp)
 	 * through /sys/kernel/kexec_crash_size interface.
 	 */
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map && !IS_ENABLED(CONFIG_ZONE_DMA)) {
+	if (crash_mem_map && crashkernel_could_early_reserve()) {
 		if (crashk_res.end) {
 			__map_memblock(pgdp, crashk_res.start,
 				       crashk_res.end + 1,
-- 
2.26.2

