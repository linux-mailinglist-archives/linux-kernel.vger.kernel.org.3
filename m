Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF054819F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbiFMIMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239550AbiFMILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:11:34 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF6D1E3EA;
        Mon, 13 Jun 2022 01:11:32 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LM43g22Gxz1K9Vw;
        Mon, 13 Jun 2022 16:09:35 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 16:11:06 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 16:11:04 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        "John Donnelly" <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH 4/5] arm64: kdump: Decide when to reserve crash memory in reserve_crashkernel()
Date:   Mon, 13 Jun 2022 16:09:31 +0800
Message-ID: <20220613080932.663-5-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220613080932.663-1-thunder.leizhen@huawei.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the kexec completes data loading, the crash memory must be set to be
inaccessible, to prevent the current kernel from damaging the data of the
crash kernel. But for some platforms, the DMA zones is not known until the
dtb or acpi table is parsed, but by then the linear mapping has been
created, all are forced to be page-level mapping.

To optimize the system performance (reduce the TLB miss rate) when
crashkernel=X,high is used. The reservation of crash memory is divided
into two phases: reserve crash high memory before paging_init() is called
and crash low memory after it. We only perform page mapping for the crash
high memory.

commit 031495635b46 ("arm64: Do not defer reserve_crashkernel() for
platforms with no DMA memory zones") has caused reserve_crashkernel() to
be called in two places: before or after paging_init(), which is
controlled by whether CONFIG_ZONE_DMA/DMA32 is enabled. Just move the
control into reserve_crashkernel(), prepare for the optimizations
mentioned above.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/mm/init.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 8539598f9e58b4d..fb24efbc46f5ef4 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -90,6 +90,9 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #endif
 
+#define DMA_PHYS_LIMIT_UNKNOWN		0
+#define DMA_PHYS_LIMIT_KNOWN		1
+
 /* Current arm64 boot protocol requires 2MB alignment */
 #define CRASH_ALIGN			SZ_2M
 
@@ -131,18 +134,23 @@ static int __init reserve_crashkernel_low(unsigned long long low_size)
  * line parameter. The memory reserved is used by dump capture kernel when
  * primary kernel is crashing.
  */
-static void __init reserve_crashkernel(void)
+static void __init reserve_crashkernel(int dma_state)
 {
 	unsigned long long crash_base, crash_size;
 	unsigned long long crash_low_size = 0;
 	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
 	char *cmdline = boot_command_line;
+	int dma_enabled = IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
 	int ret;
 	bool fixed_base;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
+	if ((!dma_enabled && (dma_state != DMA_PHYS_LIMIT_UNKNOWN)) ||
+	     (dma_enabled && (dma_state != DMA_PHYS_LIMIT_KNOWN)))
+		return;
+
 	/* crashkernel=X[@offset] */
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
@@ -413,8 +421,7 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
-		reserve_crashkernel();
+	reserve_crashkernel(DMA_PHYS_LIMIT_UNKNOWN);
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
@@ -462,8 +469,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
-		reserve_crashkernel();
+	reserve_crashkernel(DMA_PHYS_LIMIT_KNOWN);
 
 	memblock_dump_all();
 }
-- 
2.25.1

