Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793F15A3ABC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 02:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiH1A4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 20:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiH1A4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 20:56:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D006C4DB6E
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 17:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661648167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvB61AUUyCy58XPpSF7Tow+QnKoMMfrS9peNbMrYXNU=;
        b=TgIXXivFC8jFueBneQ4ibxqKzGGxHjIh9bjXp/qfo7jRzSaLqMVzCs+0FQ/jW5+ILdnDih
        +oUwnS5gi/lCm3ERkCNoJsKjZLqn9vYeNVAg5jF3TmvUDFOebqiHMT1t32ezIFiXG1Yok9
        +517NBff1OVqSoWPET2WFk33yYNefnc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-_BgS1K4mNWeHtQcoMRrjUw-1; Sat, 27 Aug 2022 20:56:02 -0400
X-MC-Unique: _BgS1K4mNWeHtQcoMRrjUw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CFEE801231;
        Sun, 28 Aug 2022 00:56:01 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F22A492C3B;
        Sun, 28 Aug 2022 00:55:55 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        ardb@kernel.org, rppt@kernel.org, guanghuifeng@linux.alibaba.com,
        mark.rutland@arm.com, will@kernel.org, linux-mm@kvack.org,
        thunder.leizhen@huawei.com, wangkefeng.wang@huawei.com,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel low memory end
Date:   Sun, 28 Aug 2022 08:55:44 +0800
Message-Id: <20220828005545.94389-2-bhe@redhat.com>
In-Reply-To: <20220828005545.94389-1-bhe@redhat.com>
References: <20220828005545.94389-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
=======
On arm64, block and section mapping is supported to build page tables.
However, currently it enforces to take base page mapping for the whole
linear mapping if CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled and
crashkernel kernel parameter is set. This will cause longer time of the
linear mapping process during bootup and severe performance degradation
during running time.

Root cause:
==========
On arm64, crashkernel reservation relies on knowing the upper limit of
low memory zone because it needs to reserve memory in the zone so that
devices' DMA addressing in kdump kernel can be satisfied. However, the
limit on arm64 is variant. And the upper limit can only be decided late
till bootmem_init() is called.

And we need to map the crashkernel region with base page granularity when
doing linear mapping, because kdump needs to protect the crashkernel region
via set_memory_valid(,0) after kdump kernel loading. However, arm64 doesn't
support well on splitting the built block or section mapping due to some
cpu reststriction [1]. And unfortunately, the linear mapping is done before
bootmem_init().

To resolve the above conflict on arm64, the compromise is enforcing to
take base page mapping for the entire linear mapping if crashkernel is
set, and CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabed. Hence
performance is sacrificed.

Solution:
=========
To fix the problem, we should always take 4G as the crashkernel low
memory end in case CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled.
With this, we don't need to defer the crashkernel reservation till
bootmem_init() is called to set the arm64_dma_phys_limit. As long as
memblock init is done, we can conclude what is the upper limit of low
memory zone.

1) both CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are disabled or memblock_start_of_DRAM() > 4G
  limit = PHYS_ADDR_MAX+1  (Corner cases)
2) CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are enabled:
   limit = 4G  (generic case)

[1]
https://lore.kernel.org/all/YrIIJkhKWSuAqkCx@arm.com/T/#u

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/mm/init.c | 24 ++++++++++++++----------
 arch/arm64/mm/mmu.c  | 38 ++++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index b9af30be813e..8ae55afdd11c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -90,10 +90,22 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
 #endif
 
+static phys_addr_t __init crash_addr_low_max(void)
+{
+	phys_addr_t low_mem_mask = U32_MAX;
+	phys_addr_t phys_start = memblock_start_of_DRAM();
+
+	if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
+	     (phys_start > U32_MAX))
+		low_mem_mask = PHYS_ADDR_MAX;
+
+	return min(low_mem_mask, memblock_end_of_DRAM() - 1) + 1;
+}
+
 /* Current arm64 boot protocol requires 2MB alignment */
 #define CRASH_ALIGN			SZ_2M
 
-#define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
+#define CRASH_ADDR_LOW_MAX		crash_addr_low_max()
 #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
 
 static int __init reserve_crashkernel_low(unsigned long long low_size)
@@ -389,8 +401,7 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (!defer_reserve_crashkernel())
-		reserve_crashkernel();
+	reserve_crashkernel();
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
 }
@@ -434,13 +445,6 @@ void __init bootmem_init(void)
 	 */
 	dma_contiguous_reserve(arm64_dma_phys_limit);
 
-	/*
-	 * request_standard_resources() depends on crashkernel's memory being
-	 * reserved, so do it here.
-	 */
-	if (defer_reserve_crashkernel())
-		reserve_crashkernel();
-
 	memblock_dump_all();
 }
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e7ad44585f40..cdd338fa2115 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -547,13 +547,12 @@ static void __init map_mem(pgd_t *pgdp)
 	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
 
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map) {
-		if (defer_reserve_crashkernel())
-			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
-		else if (crashk_res.end)
-			memblock_mark_nomap(crashk_res.start,
-			    resource_size(&crashk_res));
-	}
+	if (crashk_res.end)
+		memblock_mark_nomap(crashk_res.start,
+				    resource_size(&crashk_res));
+	if (crashk_low_res.end)
+		memblock_mark_nomap(crashk_low_res.start,
+				    resource_size(&crashk_low_res));
 #endif
 
 	/* map all the memory banks */
@@ -589,16 +588,23 @@ static void __init map_mem(pgd_t *pgdp)
 	 * through /sys/kernel/kexec_crash_size interface.
 	 */
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map && !defer_reserve_crashkernel()) {
-		if (crashk_res.end) {
-			__map_memblock(pgdp, crashk_res.start,
-				       crashk_res.end + 1,
-				       PAGE_KERNEL,
-				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-			memblock_clear_nomap(crashk_res.start,
-					     resource_size(&crashk_res));
-		}
+	if (crashk_res.end) {
+		__map_memblock(pgdp, crashk_res.start,
+			       crashk_res.end + 1,
+			       PAGE_KERNEL,
+			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+		memblock_clear_nomap(crashk_res.start,
+				     resource_size(&crashk_res));
 	}
+	if (crashk_low_res.end) {
+		__map_memblock(pgdp, crashk_low_res.start,
+			       crashk_low_res.end + 1,
+			       PAGE_KERNEL,
+			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+		memblock_clear_nomap(crashk_low_res.start,
+				     resource_size(&crashk_low_res));
+	}
+
 #endif
 }
 
-- 
2.34.1

