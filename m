Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCE759B2B0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiHUIGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiHUIGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD601A385
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAAC160C93
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFABC433D7;
        Sun, 21 Aug 2022 08:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661069181;
        bh=KGLjvgZnXQOFUVGltKbS7dMihA1dC3pDWqrnJZ/juMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZFz86GiJ7fa+hzQZNERgJQUjghMMLvXfKJmNiuEOlIuFw90rJcgSSHT34kK+Oy6jg
         uW4/3kD7xlFh8i+rUEf00v3yP1N86Lo6R/5NN/6P1gLk4jblkf3U5gLRUEHLkwOUF2
         j+n3noDUUW+28nZO64RibT+aiiS1jAglO9k94bAU1NEBKZOsn/EdWLC6P7dF9xV6uP
         Chgq703dWdwQ0ld6c6E6EbQlHaZTREwVtdzbvMCQIDvs7r2XO5t3Vl3v/bhIIRWwuV
         G0qdP1+Pn7zz2R/juGQIFzv+2Or9Tz+RVmb1Q2uWZBfYbneJOptalkZa1mSNvAbMCg
         Fai0V76i6vrFA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH v2 3/3] habanalabs: trace DMA allocations
Date:   Sun, 21 Aug 2022 11:06:08 +0300
Message-Id: <20220821080608.27486-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220821080608.27486-1-ogabbay@kernel.org>
References: <20220821080608.27486-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

This patch add tracepoints in the code for DMA allocation.
The main purpose is to be able to cross data with the map operations and
determine whether memory violation occurred, for example free DMA
allocation before unmapping it from device memory.

To achieve this the DMA alloc/free code flows were refactored so that a
single DMA tracepoint will catch many flows.

To get better understanding of what happened in the DMA allocations
the real allocating function is added to the trace as well.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
Changes in v2:
 - Avoid checking pointer is NULL in case tracing is disabled

 drivers/misc/habanalabs/common/device.c     | 49 +++++++++++++--------
 drivers/misc/habanalabs/common/habanalabs.h | 40 +++++++++++++----
 include/trace/events/habanalabs.h           | 19 ++++----
 3 files changed, 73 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index ab2497b6d164..d4ba67bfbb2e 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -13,6 +13,8 @@
 #include <linux/pci.h>
 #include <linux/hwmon.h>
 
+#include <trace/events/habanalabs.h>
+
 #define HL_RESET_DELAY_USEC		10000	/* 10ms */
 
 enum dma_alloc_type {
@@ -97,9 +99,10 @@ static int hl_access_sram_dram_region(struct hl_device *hdev, u64 addr, u64 *val
 }
 
 static void *hl_dma_alloc_common(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle,
-		gfp_t flag, enum dma_alloc_type alloc_type)
+					gfp_t flag, enum dma_alloc_type alloc_type,
+					const char *caller)
 {
-	void *ptr;
+	void *ptr = NULL;
 
 	switch (alloc_type) {
 	case DMA_ALLOC_COHERENT:
@@ -113,11 +116,16 @@ static void *hl_dma_alloc_common(struct hl_device *hdev, size_t size, dma_addr_t
 		break;
 	}
 
+	if (trace_habanalabs_dma_alloc_enabled() && !ZERO_OR_NULL_PTR(ptr))
+		trace_habanalabs_dma_alloc(hdev->dev, (u64) (uintptr_t) ptr, *dma_handle, size,
+						caller);
+
 	return ptr;
 }
 
 static void hl_asic_dma_free_common(struct hl_device *hdev, size_t size, void *cpu_addr,
-					dma_addr_t dma_handle, enum dma_alloc_type alloc_type)
+					dma_addr_t dma_handle, enum dma_alloc_type alloc_type,
+					const char *caller)
 {
 	switch (alloc_type) {
 	case DMA_ALLOC_COHERENT:
@@ -130,39 +138,44 @@ static void hl_asic_dma_free_common(struct hl_device *hdev, size_t size, void *c
 		hdev->asic_funcs->asic_dma_pool_free(hdev, cpu_addr, dma_handle);
 		break;
 	}
+
+	trace_habanalabs_dma_free(hdev->dev, (u64) (uintptr_t) cpu_addr, dma_handle, size, caller);
 }
 
-void *hl_asic_dma_alloc_coherent(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle,
-					gfp_t flag)
+void *hl_asic_dma_alloc_coherent_caller(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle,
+					gfp_t flag, const char *caller)
 {
-	return hl_dma_alloc_common(hdev, size, dma_handle, flag, DMA_ALLOC_COHERENT);
+	return hl_dma_alloc_common(hdev, size, dma_handle, flag, DMA_ALLOC_COHERENT, caller);
 }
 
-void hl_asic_dma_free_coherent(struct hl_device *hdev, size_t size, void *cpu_addr,
-					dma_addr_t dma_handle)
+void hl_asic_dma_free_coherent_caller(struct hl_device *hdev, size_t size, void *cpu_addr,
+					dma_addr_t dma_handle, const char *caller)
 {
-	hl_asic_dma_free_common(hdev, size, cpu_addr, dma_handle, DMA_ALLOC_COHERENT);
+	hl_asic_dma_free_common(hdev, size, cpu_addr, dma_handle, DMA_ALLOC_COHERENT, caller);
 }
 
-void *hl_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle)
+void *hl_cpu_accessible_dma_pool_alloc_caller(struct hl_device *hdev, size_t size,
+						dma_addr_t *dma_handle, const char *caller)
 {
-	return hl_dma_alloc_common(hdev, size, dma_handle, 0, DMA_ALLOC_CPU_ACCESSIBLE);
+	return hl_dma_alloc_common(hdev, size, dma_handle, 0, DMA_ALLOC_CPU_ACCESSIBLE, caller);
 }
 
-void hl_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size, void *vaddr)
+void hl_cpu_accessible_dma_pool_free_caller(struct hl_device *hdev, size_t size, void *vaddr,
+						const char *caller)
 {
-	hl_asic_dma_free_common(hdev, size, vaddr, 0, DMA_ALLOC_CPU_ACCESSIBLE);
+	hl_asic_dma_free_common(hdev, size, vaddr, 0, DMA_ALLOC_CPU_ACCESSIBLE, caller);
 }
 
-void *hl_asic_dma_pool_zalloc(struct hl_device *hdev, size_t size, gfp_t mem_flags,
-					dma_addr_t *dma_handle)
+void *hl_asic_dma_pool_zalloc_caller(struct hl_device *hdev, size_t size, gfp_t mem_flags,
+					dma_addr_t *dma_handle, const char *caller)
 {
-	return hl_dma_alloc_common(hdev, size, dma_handle, mem_flags, DMA_ALLOC_POOL);
+	return hl_dma_alloc_common(hdev, size, dma_handle, mem_flags, DMA_ALLOC_POOL, caller);
 }
 
-void hl_asic_dma_pool_free(struct hl_device *hdev, void *vaddr, dma_addr_t dma_addr)
+void hl_asic_dma_pool_free_caller(struct hl_device *hdev, void *vaddr, dma_addr_t dma_addr,
+					const char *caller)
 {
-	hl_asic_dma_free_common(hdev, 0, vaddr, dma_addr, DMA_ALLOC_POOL);
+	hl_asic_dma_free_common(hdev, 0, vaddr, dma_addr, DMA_ALLOC_POOL, caller);
 }
 
 int hl_dma_map_sgtable(struct hl_device *hdev, struct sg_table *sgt, enum dma_data_direction dir)
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 237a887b3a43..6e65ca05a1a0 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -143,6 +143,25 @@ enum hl_mmu_enablement {
 
 #define HL_MAX_DCORES			8
 
+/* DMA alloc/free wrappers */
+#define hl_asic_dma_alloc_coherent(hdev, size, dma_handle, flags) \
+	hl_asic_dma_alloc_coherent_caller(hdev, size, dma_handle, flags, __func__)
+
+#define hl_cpu_accessible_dma_pool_alloc(hdev, size, dma_handle) \
+	hl_cpu_accessible_dma_pool_alloc_caller(hdev, size, dma_handle, __func__)
+
+#define hl_asic_dma_pool_zalloc(hdev, size, mem_flags, dma_handle) \
+	hl_asic_dma_pool_zalloc_caller(hdev, size, mem_flags, dma_handle, __func__)
+
+#define hl_asic_dma_free_coherent(hdev, size, cpu_addr, dma_handle) \
+	hl_asic_dma_free_coherent_caller(hdev, size, cpu_addr, dma_handle, __func__)
+
+#define hl_cpu_accessible_dma_pool_free(hdev, size, vaddr) \
+	hl_cpu_accessible_dma_pool_free_caller(hdev, size, vaddr, __func__)
+
+#define hl_asic_dma_pool_free(hdev, vaddr, dma_addr) \
+	hl_asic_dma_pool_free_caller(hdev, vaddr, dma_addr, __func__)
+
 /*
  * Reset Flags
  *
@@ -3444,15 +3463,18 @@ static inline bool hl_mem_area_crosses_range(u64 address, u32 size,
 }
 
 uint64_t hl_set_dram_bar_default(struct hl_device *hdev, u64 addr);
-void *hl_asic_dma_alloc_coherent(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle,
-					gfp_t flag);
-void hl_asic_dma_free_coherent(struct hl_device *hdev, size_t size, void *cpu_addr,
-					dma_addr_t dma_handle);
-void *hl_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle);
-void hl_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size, void *vaddr);
-void *hl_asic_dma_pool_zalloc(struct hl_device *hdev, size_t size, gfp_t mem_flags,
-					dma_addr_t *dma_handle);
-void hl_asic_dma_pool_free(struct hl_device *hdev, void *vaddr, dma_addr_t dma_addr);
+void *hl_asic_dma_alloc_coherent_caller(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle,
+					gfp_t flag, const char *caller);
+void hl_asic_dma_free_coherent_caller(struct hl_device *hdev, size_t size, void *cpu_addr,
+					dma_addr_t dma_handle, const char *caller);
+void *hl_cpu_accessible_dma_pool_alloc_caller(struct hl_device *hdev, size_t size,
+						dma_addr_t *dma_handle, const char *caller);
+void hl_cpu_accessible_dma_pool_free_caller(struct hl_device *hdev, size_t size, void *vaddr,
+						const char *caller);
+void *hl_asic_dma_pool_zalloc_caller(struct hl_device *hdev, size_t size, gfp_t mem_flags,
+					dma_addr_t *dma_handle, const char *caller);
+void hl_asic_dma_pool_free_caller(struct hl_device *hdev, void *vaddr, dma_addr_t dma_addr,
+					const char *caller);
 int hl_dma_map_sgtable(struct hl_device *hdev, struct sg_table *sgt, enum dma_data_direction dir);
 void hl_dma_unmap_sgtable(struct hl_device *hdev, struct sg_table *sgt,
 				enum dma_data_direction dir);
diff --git a/include/trace/events/habanalabs.h b/include/trace/events/habanalabs.h
index 09ca516e1624..f05c5fa668a2 100644
--- a/include/trace/events/habanalabs.h
+++ b/include/trace/events/habanalabs.h
@@ -51,15 +51,16 @@ DEFINE_EVENT(habanalabs_mmu_template, habanalabs_mmu_unmap,
 	TP_ARGS(dev, virt_addr, phys_addr, page_size, flush_pte));
 
 DECLARE_EVENT_CLASS(habanalabs_dma_alloc_template,
-	TP_PROTO(struct device *dev, u64 cpu_addr, u64 dma_addr, size_t size),
+	TP_PROTO(struct device *dev, u64 cpu_addr, u64 dma_addr, size_t size, const char *caller),
 
-	TP_ARGS(dev, cpu_addr, dma_addr, size),
+	TP_ARGS(dev, cpu_addr, dma_addr, size, caller),
 
 	TP_STRUCT__entry(
 		__string(dname, dev_name(dev))
 		__field(u64, cpu_addr)
 		__field(u64, dma_addr)
 		__field(u32, size)
+		__field(const char *, caller)
 	),
 
 	TP_fast_assign(
@@ -67,22 +68,24 @@ DECLARE_EVENT_CLASS(habanalabs_dma_alloc_template,
 		__entry->cpu_addr = cpu_addr;
 		__entry->dma_addr = dma_addr;
 		__entry->size = size;
+		__entry->caller = caller;
 	),
 
-	TP_printk("%s: cpu_addr: %#llx, dma_addr: %#llx, size: %#x",
+	TP_printk("%s: cpu_addr: %#llx, dma_addr: %#llx, size: %#x, caller: %s",
 		__get_str(dname),
 		__entry->cpu_addr,
 		__entry->dma_addr,
-		__entry->size)
+		__entry->size,
+		__entry->caller)
 );
 
 DEFINE_EVENT(habanalabs_dma_alloc_template, habanalabs_dma_alloc,
-	TP_PROTO(struct device *dev, u64 cpu_addr, u64 dma_addr, size_t size),
-	TP_ARGS(dev, cpu_addr, dma_addr, size));
+	TP_PROTO(struct device *dev, u64 cpu_addr, u64 dma_addr, size_t size, const char *caller),
+	TP_ARGS(dev, cpu_addr, dma_addr, size, caller));
 
 DEFINE_EVENT(habanalabs_dma_alloc_template, habanalabs_dma_free,
-	TP_PROTO(struct device *dev, u64 cpu_addr, u64 dma_addr, size_t size),
-	TP_ARGS(dev, cpu_addr, dma_addr, size));
+	TP_PROTO(struct device *dev, u64 cpu_addr, u64 dma_addr, size_t size, const char *caller),
+	TP_ARGS(dev, cpu_addr, dma_addr, size, caller));
 
 #endif /* if !defined(_TRACE_HABANALABS_H) || defined(TRACE_HEADER_MULTI_READ) */
 
-- 
2.25.1

