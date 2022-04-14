Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EFB500CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242935AbiDNMBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242888AbiDNMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:01:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC96888FD;
        Thu, 14 Apr 2022 04:58:36 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KfHxR4tmvzgYmL;
        Thu, 14 Apr 2022 19:56:43 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 19:58:34 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 19:58:33 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH v22 6/9] arm64: kdump: Use page-level mapping for the high memory of crashkernel
Date:   Thu, 14 Apr 2022 19:57:17 +0800
Message-ID: <20220414115720.1887-7-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220414115720.1887-1-thunder.leizhen@huawei.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the crashkernel has both high memory above 4G and low memory under 4G,
kexec always loads the content such as Imge and dtb to the high memory
instead of the low memory. This means that only high memory requires write
protection based on page-level mapping. The allocation of high memory does
not depend on the DMA boundary. So we can reserve the high memory first
even if the crashkernel reservation is deferred.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/init.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/mmu.c  |  3 +-
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 99d5539c13de3b1..b1b40b900fae170 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -90,6 +90,9 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #endif
 
+static bool crash_high_mem_reserved __initdata;
+static struct resource crashk_res_high;
+
 /* Current arm64 boot protocol requires 2MB alignment */
 #define CRASH_ALIGN			SZ_2M
 
@@ -128,6 +131,66 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
 	return 0;
 }
 
+static void __init reserve_crashkernel_high(void)
+{
+	unsigned long long crash_base, crash_size;
+	char *cmdline = boot_command_line;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	/* crashkernel=X[@offset] */
+	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
+				&crash_size, &crash_base);
+	if (ret || !crash_size) {
+		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
+		if (ret || !crash_size)
+			return;
+	}
+
+	crash_size = PAGE_ALIGN(crash_size);
+
+	/*
+	 * For the case crashkernel=X, may fall back to reserve memory above
+	 * 4G, make reservations here in advance. It will be released later if
+	 * the region is successfully reserved under 4G.
+	 */
+	if (!crash_base) {
+		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
+						       crash_base, CRASH_ADDR_HIGH_MAX);
+		if (!crash_base)
+			return;
+
+		crash_high_mem_reserved = true;
+	}
+
+	/* Mark the memory range that requires page-level mappings */
+	crashk_res.start = crash_base;
+	crashk_res.end   = crash_base + crash_size - 1;
+}
+
+static void __init hand_over_reserved_high_mem(void)
+{
+	crashk_res_high.start = crashk_res.start;
+	crashk_res_high.end   = crashk_res.end;
+
+	crashk_res.start = 0;
+	crashk_res.end   = 0;
+}
+
+static void __init take_reserved_high_mem(unsigned long long *crash_base,
+					  unsigned long long *crash_size)
+{
+	*crash_base = crashk_res_high.start;
+	*crash_size = resource_size(&crashk_res_high);
+}
+
+static void __init free_reserved_high_mem(void)
+{
+	memblock_phys_free(crashk_res_high.start, resource_size(&crashk_res_high));
+}
+
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -159,6 +222,8 @@ static void __init reserve_crashkernel(void)
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
+	hand_over_reserved_high_mem();
+
 	/* crashkernel=X[@offset] */
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
@@ -177,6 +242,11 @@ static void __init reserve_crashkernel(void)
 
 		high = true;
 		crash_max = CRASH_ADDR_HIGH_MAX;
+
+		if (crash_high_mem_reserved) {
+			take_reserved_high_mem(&crash_base, &crash_size);
+			goto reserve_low;
+		}
 	}
 
 	fixed_base = !!crash_base;
@@ -195,6 +265,11 @@ static void __init reserve_crashkernel(void)
 		 * reserved later.
 		 */
 		if (!fixed_base && (crash_max == CRASH_ADDR_LOW_MAX)) {
+			if (crash_high_mem_reserved) {
+				take_reserved_high_mem(&crash_base, &crash_size);
+				goto reserve_low;
+			}
+
 			crash_max = CRASH_ADDR_HIGH_MAX;
 			goto retry;
 		}
@@ -212,6 +287,7 @@ static void __init reserve_crashkernel(void)
 	 * condition to make sure the crash low memory will be reserved.
 	 */
 	if ((crash_base >= CRASH_ADDR_LOW_MAX) || high) {
+reserve_low:
 		/* case #3 of crashkernel,low reservation */
 		if (!high)
 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
@@ -220,6 +296,12 @@ static void __init reserve_crashkernel(void)
 			memblock_phys_free(crash_base, crash_size);
 			return;
 		}
+	} else if (crash_high_mem_reserved) {
+		/*
+		 * The crash memory is successfully allocated under 4G, and the
+		 * previously reserved high memory is no longer required.
+		 */
+		free_reserved_high_mem();
 	}
 
 	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
@@ -437,6 +519,8 @@ void __init arm64_memblock_init(void)
 
 	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
 		reserve_crashkernel();
+	else
+		reserve_crashkernel_high();
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8c6666cbc7f2216..f84eca55b103d0c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -531,7 +531,8 @@ static void __init map_mem(pgd_t *pgdp)
 	if (crash_mem_map &&
 	    (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32)))
 		eflags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
-	else if (crashk_res.end)
+
+	if (crashk_res.end)
 		memblock_mark_nomap(crashk_res.start,
 				    resource_size(&crashk_res));
 #endif
-- 
2.25.1

