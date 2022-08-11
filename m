Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3758FB83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 13:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiHKLkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 07:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiHKLkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 07:40:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0DDDF9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 04:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04772B82060
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAD9C433D7;
        Thu, 11 Aug 2022 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660218010;
        bh=UbxKtPwdDmtUwCcze+RUbPoWu0eXsP/mpEAuHDM1BvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s0PMdpTmrwT8HsIVX33ErLrL51QlwLT5AGSSfJ9HnbX9lMnF0SYud5+gB/r0dAgdm
         RNGGb/RYeH4gLP+AQ4fhy7kuzqpEfUTie5KthDDQgcOKOtA8aCe+lT2oDxj7kaUpuC
         C/iHxR+vhxME5XerHYwDNuTHNhWYvZHRNcwrDuoF9oK7UvDJt7TG+BSNc21Iyzepfy
         aJSCTlcrivqB7BAMcBm4ATnpMbdZM86LBPDGLJFldo9jkzBFonOSM+PcQsbi3Zm2be
         WBOAHRRgjupMx5vgkMsjSRowGzbV5gfGXtI+aJkyVD/2kyBp1V2MauQLGkTJAD7N7o
         QI1/YeNvXWMVQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 3/3] habanalabs: trace DMA allocations
Date:   Thu, 11 Aug 2022 14:39:53 +0300
Message-Id: <20220811113953.1963412-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220811113953.1963412-1-ogabbay@kernel.org>
References: <20220811113953.1963412-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 47 +++++++++++++--------
 drivers/misc/habanalabs/common/habanalabs.h | 40 ++++++++++++++----
 include/trace/events/habanalabs.h           | 19 +++++----
 3 files changed, 72 insertions(+), 34 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index ab2497b6d164..1179173f6095 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -13,6 +13,8 @@
 #include <linux/pci.h>
 #include <linux/hwmon.h>
 
+#include <trace/events/habanalabs.h>
+
 #define HL_RESET_DELAY_USEC		10000	/* 10ms */
 
 enum dma_alloc_type {
@@ -97,7 +99,8 @@ static int hl_access_sram_dram_region(struct hl_device *hdev, u64 addr, u64 *val
 }
 
 static void *hl_dma_alloc_common(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle,
-		gfp_t flag, enum dma_alloc_type alloc_type)
+					gfp_t flag, enum dma_alloc_type alloc_type,
+					const char *caller)
 {
 	void *ptr;
 
@@ -113,11 +116,16 @@ static void *hl_dma_alloc_common(struct hl_device *hdev, size_t size, dma_addr_t
 		break;
 	}
 
+	if (!ZERO_OR_NULL_PTR(ptr))
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
index 4fb592247ae8..f74c5864a5de 100644
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

