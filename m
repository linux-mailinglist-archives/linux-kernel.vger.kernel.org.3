Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF1C559D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiFXPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiFXPhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BA849936
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B88E6223A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 15:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748A5C34114;
        Fri, 24 Jun 2022 15:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656085068;
        bh=e/cS9D6b4TrzzYgINxS6M2BWrOELLkqEX491xvFqsjE=;
        h=From:To:Cc:Subject:Date:From;
        b=bvhr+09YaCZI0crAyQABMn3e1uYYdYjnjkRUvlnz5aI+7SMY72G75fQe+4T94WFqs
         tVzyLj7CGDG2+wg2rJJn83GzK1GPEv8wTT8PHo/zX0tYrAYdvvI/5DGuToiMeIC9XE
         Ej52+Wpz6VlulcR8H4+nUqD+VrSqpIx1hheH5tZ8PX7BTI1DOxLhK/xGyn9oN0HCMw
         YaahKJUC/V0DF/4rn4H47uvIlWkB5nGKhgg8TylQ9Tb5PWC2NK41xy8OET1SfxnYDf
         xxVGs+Xwb3eFAUz3auX/irjUGVGfeuJSKORWzbX5VOT/x4/anFBq7FgusbjxkzlQF6
         hO0ftAyyRkbvA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 1/2] habanalabs: refactor dma asic-specific functions
Date:   Fri, 24 Jun 2022 18:37:42 +0300
Message-Id: <20220624153743.1825744-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

This is a pre-requisite patch for adding tracepoints to the DMA memory
operations (allocation/free) in the driver.

The main purpose is to be able to cross data with the map operations and
determine whether memory violation occurred, for example free DMA
allocation before unmapping it from device memory.

To achieve this the DMA alloc/free code flows were refactored so that a
single DMA tracepoint will catch many flows.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   | 12 +--
 drivers/misc/habanalabs/common/device.c       | 75 ++++++++++++++++
 drivers/misc/habanalabs/common/firmware_if.c  | 39 ++++----
 drivers/misc/habanalabs/common/habanalabs.h   |  9 ++
 drivers/misc/habanalabs/common/hw_queue.c     | 34 +++----
 drivers/misc/habanalabs/common/irq.c          | 16 ++--
 drivers/misc/habanalabs/gaudi/gaudi.c         | 89 +++++++------------
 drivers/misc/habanalabs/goya/goya.c           | 40 +++------
 8 files changed, 162 insertions(+), 152 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index e13b2b39c058..b027f66f8bd4 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -143,8 +143,7 @@ static void cb_fini(struct hl_device *hdev, struct hl_cb *cb)
 		gen_pool_free(hdev->internal_cb_pool,
 				(uintptr_t)cb->kernel_address, cb->size);
 	else
-		hdev->asic_funcs->asic_dma_free_coherent(hdev, cb->size,
-				cb->kernel_address, cb->bus_address);
+		hl_asic_dma_free_coherent(hdev, cb->size, cb->kernel_address, cb->bus_address);
 
 	kfree(cb);
 }
@@ -195,14 +194,11 @@ static struct hl_cb *hl_cb_alloc(struct hl_device *hdev, u32 cb_size,
 		cb->is_internal = true;
 		cb->bus_address =  hdev->internal_cb_va_base + cb_offset;
 	} else if (ctx_id == HL_KERNEL_ASID_ID) {
-		p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev, cb_size,
-						&cb->bus_address, GFP_ATOMIC);
+		p = hl_asic_dma_alloc_coherent(hdev, cb_size, &cb->bus_address, GFP_ATOMIC);
 		if (!p)
-			p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev,
-					cb_size, &cb->bus_address, GFP_KERNEL);
+			p = hl_asic_dma_alloc_coherent(hdev, cb_size, &cb->bus_address, GFP_KERNEL);
 	} else {
-		p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev, cb_size,
-						&cb->bus_address,
+		p = hl_asic_dma_alloc_coherent(hdev, cb_size, &cb->bus_address,
 						GFP_USER | __GFP_ZERO);
 	}
 
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 34ba521e2d1a..c42557052f88 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -17,6 +17,12 @@
 
 #define MEM_SCRUB_DEFAULT_VAL 0x1122334455667788
 
+enum dma_alloc_type {
+	DMA_ALLOC_COHERENT,
+	DMA_ALLOC_CPU_ACCESSIBLE,
+	DMA_ALLOC_POOL,
+};
+
 /*
  * hl_set_dram_bar- sets the bar to allow later access to address
  *
@@ -90,6 +96,75 @@ static int hl_access_sram_dram_region(struct hl_device *hdev, u64 addr, u64 *val
 	return 0;
 }
 
+static void *hl_dma_alloc_common(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle,
+		gfp_t flag, enum dma_alloc_type alloc_type)
+{
+	void *ptr;
+
+	switch (alloc_type) {
+	case DMA_ALLOC_COHERENT:
+		ptr = hdev->asic_funcs->asic_dma_alloc_coherent(hdev, size, dma_handle, flag);
+		break;
+	case DMA_ALLOC_CPU_ACCESSIBLE:
+		ptr = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev, size, dma_handle);
+		break;
+	case DMA_ALLOC_POOL:
+		ptr = hdev->asic_funcs->asic_dma_pool_zalloc(hdev, size, flag, dma_handle);
+		break;
+	}
+
+	return ptr;
+}
+
+static void hl_asic_dma_free_common(struct hl_device *hdev, size_t size, void *cpu_addr,
+					dma_addr_t dma_handle, enum dma_alloc_type alloc_type)
+{
+	switch (alloc_type) {
+	case DMA_ALLOC_COHERENT:
+		hdev->asic_funcs->asic_dma_free_coherent(hdev, size, cpu_addr, dma_handle);
+		break;
+	case DMA_ALLOC_CPU_ACCESSIBLE:
+		hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev, size, cpu_addr);
+		break;
+	case DMA_ALLOC_POOL:
+		hdev->asic_funcs->asic_dma_pool_free(hdev, cpu_addr, dma_handle);
+		break;
+	}
+}
+
+void *hl_asic_dma_alloc_coherent(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle,
+					gfp_t flag)
+{
+	return hl_dma_alloc_common(hdev, size, dma_handle, flag, DMA_ALLOC_COHERENT);
+}
+
+void hl_asic_dma_free_coherent(struct hl_device *hdev, size_t size, void *cpu_addr,
+					dma_addr_t dma_handle)
+{
+	hl_asic_dma_free_common(hdev, size, cpu_addr, dma_handle, DMA_ALLOC_COHERENT);
+}
+
+void *hl_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle)
+{
+	return hl_dma_alloc_common(hdev, size, dma_handle, 0, DMA_ALLOC_CPU_ACCESSIBLE);
+}
+
+void hl_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size, void *vaddr)
+{
+	hl_asic_dma_free_common(hdev, size, vaddr, 0, DMA_ALLOC_CPU_ACCESSIBLE);
+}
+
+void *hl_asic_dma_pool_zalloc(struct hl_device *hdev, size_t size, gfp_t mem_flags,
+					dma_addr_t *dma_handle)
+{
+	return hl_dma_alloc_common(hdev, size, dma_handle, mem_flags, DMA_ALLOC_POOL);
+}
+
+void hl_asic_dma_pool_free(struct hl_device *hdev, void *vaddr, dma_addr_t dma_addr)
+{
+	hl_asic_dma_free_common(hdev, 0, vaddr, dma_addr, DMA_ALLOC_POOL);
+}
+
 int hl_dma_map_sgtable(struct hl_device *hdev, struct sg_table *sgt, enum dma_data_direction dir)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 42dfbfff92fd..cb89d8423f9e 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -218,8 +218,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 	u32 tmp, expected_ack_val, pi;
 	int rc;
 
-	pkt = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev, len,
-								&pkt_dma_addr);
+	pkt = hl_cpu_accessible_dma_pool_alloc(hdev, len, &pkt_dma_addr);
 	if (!pkt) {
 		dev_err(hdev->dev,
 			"Failed to allocate DMA memory for packet to CPU\n");
@@ -303,7 +302,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 out:
 	mutex_unlock(&hdev->send_cpu_message_lock);
 
-	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev, len, pkt);
+	hl_cpu_accessible_dma_pool_free(hdev, len, pkt);
 
 	return rc;
 }
@@ -644,10 +643,8 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev,
 	u64 result;
 	int rc;
 
-	cpucp_info_cpu_addr =
-			hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
-					sizeof(struct cpucp_info),
-					&cpucp_info_dma_addr);
+	cpucp_info_cpu_addr = hl_cpu_accessible_dma_pool_alloc(hdev, sizeof(struct cpucp_info),
+								&cpucp_info_dma_addr);
 	if (!cpucp_info_cpu_addr) {
 		dev_err(hdev->dev,
 			"Failed to allocate DMA memory for CPU-CP info packet\n");
@@ -708,8 +705,7 @@ int hl_fw_cpucp_info_get(struct hl_device *hdev,
 		prop->fw_app_cpu_boot_dev_sts1 = RREG32(sts_boot_dev_sts1_reg);
 
 out:
-	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
-			sizeof(struct cpucp_info), cpucp_info_cpu_addr);
+	hl_cpu_accessible_dma_pool_free(hdev, sizeof(struct cpucp_info), cpucp_info_cpu_addr);
 
 	return rc;
 }
@@ -792,9 +788,8 @@ int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 	u64 result;
 	int rc;
 
-	eeprom_info_cpu_addr =
-			hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
-					max_size, &eeprom_info_dma_addr);
+	eeprom_info_cpu_addr = hl_cpu_accessible_dma_pool_alloc(hdev, max_size,
+									&eeprom_info_dma_addr);
 	if (!eeprom_info_cpu_addr) {
 		dev_err(hdev->dev,
 			"Failed to allocate DMA memory for CPU-CP EEPROM packet\n");
@@ -822,8 +817,7 @@ int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 	memcpy(data, eeprom_info_cpu_addr, min((size_t)result, max_size));
 
 out:
-	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev, max_size,
-			eeprom_info_cpu_addr);
+	hl_cpu_accessible_dma_pool_free(hdev, max_size, eeprom_info_cpu_addr);
 
 	return rc;
 }
@@ -840,8 +834,7 @@ int hl_fw_get_monitor_dump(struct hl_device *hdev, void *data)
 	int i, rc;
 
 	data_size = sizeof(struct cpucp_monitor_dump);
-	mon_dump_cpu_addr = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev, data_size,
-										&mon_dump_dma_addr);
+	mon_dump_cpu_addr = hl_cpu_accessible_dma_pool_alloc(hdev, data_size, &mon_dump_dma_addr);
 	if (!mon_dump_cpu_addr) {
 		dev_err(hdev->dev,
 			"Failed to allocate DMA memory for CPU-CP monitor-dump packet\n");
@@ -871,7 +864,7 @@ int hl_fw_get_monitor_dump(struct hl_device *hdev, void *data)
 	}
 
 out:
-	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev, data_size, mon_dump_cpu_addr);
+	hl_cpu_accessible_dma_pool_free(hdev, data_size, mon_dump_cpu_addr);
 
 	return rc;
 }
@@ -1064,10 +1057,9 @@ int hl_fw_dram_replaced_row_get(struct hl_device *hdev,
 	u64 result;
 	int rc;
 
-	cpucp_repl_rows_info_cpu_addr =
-			hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
-					sizeof(struct cpucp_hbm_row_info),
-					&cpucp_repl_rows_info_dma_addr);
+	cpucp_repl_rows_info_cpu_addr = hl_cpu_accessible_dma_pool_alloc(hdev,
+							sizeof(struct cpucp_hbm_row_info),
+							&cpucp_repl_rows_info_dma_addr);
 	if (!cpucp_repl_rows_info_cpu_addr) {
 		dev_err(hdev->dev,
 			"Failed to allocate DMA memory for CPU-CP replaced rows info packet\n");
@@ -1092,9 +1084,8 @@ int hl_fw_dram_replaced_row_get(struct hl_device *hdev,
 	memcpy(info, cpucp_repl_rows_info_cpu_addr, sizeof(*info));
 
 out:
-	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
-					sizeof(struct cpucp_hbm_row_info),
-					cpucp_repl_rows_info_cpu_addr);
+	hl_cpu_accessible_dma_pool_free(hdev, sizeof(struct cpucp_hbm_row_info),
+						cpucp_repl_rows_info_cpu_addr);
 
 	return rc;
 }
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 4d2f69fb4b9d..c5c0861f2059 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3121,6 +3121,15 @@ static inline bool hl_mem_area_crosses_range(u64 address, u32 size,
 }
 
 uint64_t hl_set_dram_bar_default(struct hl_device *hdev, u64 addr);
+void *hl_asic_dma_alloc_coherent(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle,
+					gfp_t flag);
+void hl_asic_dma_free_coherent(struct hl_device *hdev, size_t size, void *cpu_addr,
+					dma_addr_t dma_handle);
+void *hl_cpu_accessible_dma_pool_alloc(struct hl_device *hdev, size_t size, dma_addr_t *dma_handle);
+void hl_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size, void *vaddr);
+void *hl_asic_dma_pool_zalloc(struct hl_device *hdev, size_t size, gfp_t mem_flags,
+					dma_addr_t *dma_handle);
+void hl_asic_dma_pool_free(struct hl_device *hdev, void *vaddr, dma_addr_t dma_addr);
 int hl_dma_map_sgtable(struct hl_device *hdev, struct sg_table *sgt, enum dma_data_direction dir);
 void hl_dma_unmap_sgtable(struct hl_device *hdev, struct sg_table *sgt,
 				enum dma_data_direction dir);
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 32408887dd7c..1abd2340927a 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -807,13 +807,9 @@ static int ext_and_cpu_queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
 	int rc;
 
 	if (is_cpu_queue)
-		p = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
-							HL_QUEUE_SIZE_IN_BYTES,
-							&q->bus_address);
+		p = hl_cpu_accessible_dma_pool_alloc(hdev, HL_QUEUE_SIZE_IN_BYTES, &q->bus_address);
 	else
-		p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev,
-						HL_QUEUE_SIZE_IN_BYTES,
-						&q->bus_address,
+		p = hl_asic_dma_alloc_coherent(hdev, HL_QUEUE_SIZE_IN_BYTES, &q->bus_address,
 						GFP_KERNEL | __GFP_ZERO);
 	if (!p)
 		return -ENOMEM;
@@ -839,14 +835,10 @@ static int ext_and_cpu_queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
 
 free_queue:
 	if (is_cpu_queue)
-		hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
-					HL_QUEUE_SIZE_IN_BYTES,
-					q->kernel_address);
+		hl_cpu_accessible_dma_pool_free(hdev, HL_QUEUE_SIZE_IN_BYTES, q->kernel_address);
 	else
-		hdev->asic_funcs->asic_dma_free_coherent(hdev,
-					HL_QUEUE_SIZE_IN_BYTES,
-					q->kernel_address,
-					q->bus_address);
+		hl_asic_dma_free_coherent(hdev, HL_QUEUE_SIZE_IN_BYTES, q->kernel_address,
+						q->bus_address);
 
 	return rc;
 }
@@ -885,10 +877,8 @@ static int hw_queue_init(struct hl_device *hdev, struct hl_hw_queue *q)
 {
 	void *p;
 
-	p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev,
-						HL_QUEUE_SIZE_IN_BYTES,
-						&q->bus_address,
-						GFP_KERNEL | __GFP_ZERO);
+	p = hl_asic_dma_alloc_coherent(hdev, HL_QUEUE_SIZE_IN_BYTES, &q->bus_address,
+					GFP_KERNEL | __GFP_ZERO);
 	if (!p)
 		return -ENOMEM;
 
@@ -1061,14 +1051,10 @@ static void queue_fini(struct hl_device *hdev, struct hl_hw_queue *q)
 	kfree(q->shadow_queue);
 
 	if (q->queue_type == QUEUE_TYPE_CPU)
-		hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
-					HL_QUEUE_SIZE_IN_BYTES,
-					q->kernel_address);
+		hl_cpu_accessible_dma_pool_free(hdev, HL_QUEUE_SIZE_IN_BYTES, q->kernel_address);
 	else
-		hdev->asic_funcs->asic_dma_free_coherent(hdev,
-					HL_QUEUE_SIZE_IN_BYTES,
-					q->kernel_address,
-					q->bus_address);
+		hl_asic_dma_free_coherent(hdev, HL_QUEUE_SIZE_IN_BYTES, q->kernel_address,
+						q->bus_address);
 }
 
 int hl_hw_queues_create(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/common/irq.c b/drivers/misc/habanalabs/common/irq.c
index 8500e15ef743..898262b6734e 100644
--- a/drivers/misc/habanalabs/common/irq.c
+++ b/drivers/misc/habanalabs/common/irq.c
@@ -403,8 +403,8 @@ int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id)
 {
 	void *p;
 
-	p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev, HL_CQ_SIZE_IN_BYTES,
-				&q->bus_address, GFP_KERNEL | __GFP_ZERO);
+	p = hl_asic_dma_alloc_coherent(hdev, HL_CQ_SIZE_IN_BYTES, &q->bus_address,
+					GFP_KERNEL | __GFP_ZERO);
 	if (!p)
 		return -ENOMEM;
 
@@ -429,9 +429,7 @@ int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id)
  */
 void hl_cq_fini(struct hl_device *hdev, struct hl_cq *q)
 {
-	hdev->asic_funcs->asic_dma_free_coherent(hdev, HL_CQ_SIZE_IN_BYTES,
-						 q->kernel_address,
-						 q->bus_address);
+	hl_asic_dma_free_coherent(hdev, HL_CQ_SIZE_IN_BYTES, q->kernel_address, q->bus_address);
 }
 
 void hl_cq_reset(struct hl_device *hdev, struct hl_cq *q)
@@ -464,9 +462,7 @@ int hl_eq_init(struct hl_device *hdev, struct hl_eq *q)
 {
 	void *p;
 
-	p = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
-							HL_EQ_SIZE_IN_BYTES,
-							&q->bus_address);
+	p = hl_cpu_accessible_dma_pool_alloc(hdev, HL_EQ_SIZE_IN_BYTES, &q->bus_address);
 	if (!p)
 		return -ENOMEM;
 
@@ -490,9 +486,7 @@ void hl_eq_fini(struct hl_device *hdev, struct hl_eq *q)
 {
 	flush_workqueue(hdev->eq_wq);
 
-	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev,
-					HL_EQ_SIZE_IN_BYTES,
-					q->kernel_address);
+	hl_cpu_accessible_dma_pool_free(hdev, HL_EQ_SIZE_IN_BYTES, q->kernel_address);
 }
 
 void hl_eq_reset(struct hl_device *hdev, struct hl_eq *q)
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 478374418b90..8d206c848e9a 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1070,8 +1070,7 @@ static int gaudi_init_tpc_mem(struct hl_device *hdev)
 	}
 
 	fw_size = fw->size;
-	cpu_addr = hdev->asic_funcs->asic_dma_alloc_coherent(hdev, fw_size,
-			&dma_handle, GFP_KERNEL | __GFP_ZERO);
+	cpu_addr = hl_asic_dma_alloc_coherent(hdev, fw_size, &dma_handle, GFP_KERNEL | __GFP_ZERO);
 	if (!cpu_addr) {
 		dev_err(hdev->dev,
 			"Failed to allocate %zu of dma memory for TPC kernel\n",
@@ -1084,8 +1083,7 @@ static int gaudi_init_tpc_mem(struct hl_device *hdev)
 
 	rc = _gaudi_init_tpc_mem(hdev, dma_handle, fw_size);
 
-	hdev->asic_funcs->asic_dma_free_coherent(hdev, fw->size, cpu_addr,
-			dma_handle);
+	hl_asic_dma_free_coherent(hdev, fw->size, cpu_addr, dma_handle);
 
 out:
 	release_firmware(fw);
@@ -1729,11 +1727,9 @@ static int gaudi_alloc_cpu_accessible_dma_mem(struct hl_device *hdev)
 	 */
 
 	for (i = 0 ; i < GAUDI_ALLOC_CPU_MEM_RETRY_CNT ; i++) {
-		virt_addr_arr[i] =
-			hdev->asic_funcs->asic_dma_alloc_coherent(hdev,
-						HL_CPU_ACCESSIBLE_MEM_SIZE,
-						&dma_addr_arr[i],
-						GFP_KERNEL | __GFP_ZERO);
+		virt_addr_arr[i] = hl_asic_dma_alloc_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE,
+								&dma_addr_arr[i],
+								GFP_KERNEL | __GFP_ZERO);
 		if (!virt_addr_arr[i]) {
 			rc = -ENOMEM;
 			goto free_dma_mem_arr;
@@ -1762,9 +1758,7 @@ static int gaudi_alloc_cpu_accessible_dma_mem(struct hl_device *hdev)
 
 free_dma_mem_arr:
 	for (j = 0 ; j < i ; j++)
-		hdev->asic_funcs->asic_dma_free_coherent(hdev,
-						HL_CPU_ACCESSIBLE_MEM_SIZE,
-						virt_addr_arr[j],
+		hl_asic_dma_free_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE, virt_addr_arr[j],
 						dma_addr_arr[j]);
 
 	return rc;
@@ -1780,9 +1774,7 @@ static void gaudi_free_internal_qmans_pq_mem(struct hl_device *hdev)
 		q = &gaudi->internal_qmans[i];
 		if (!q->pq_kernel_addr)
 			continue;
-		hdev->asic_funcs->asic_dma_free_coherent(hdev, q->pq_size,
-							q->pq_kernel_addr,
-							q->pq_dma_addr);
+		hl_asic_dma_free_coherent(hdev, q->pq_size, q->pq_kernel_addr, q->pq_dma_addr);
 	}
 }
 
@@ -1817,10 +1809,8 @@ static int gaudi_alloc_internal_qmans_pq_mem(struct hl_device *hdev)
 			goto free_internal_qmans_pq_mem;
 		}
 
-		q->pq_kernel_addr = hdev->asic_funcs->asic_dma_alloc_coherent(
-						hdev, q->pq_size,
-						&q->pq_dma_addr,
-						GFP_KERNEL | __GFP_ZERO);
+		q->pq_kernel_addr = hl_asic_dma_alloc_coherent(hdev, q->pq_size, &q->pq_dma_addr,
+								GFP_KERNEL | __GFP_ZERO);
 		if (!q->pq_kernel_addr) {
 			rc = -ENOMEM;
 			goto free_internal_qmans_pq_mem;
@@ -1961,10 +1951,8 @@ static int gaudi_sw_init(struct hl_device *hdev)
 	if (!hdev->asic_prop.fw_security_enabled)
 		GAUDI_CPU_TO_PCI_ADDR(hdev->cpu_accessible_dma_address,
 					hdev->cpu_pci_msb_addr);
-	hdev->asic_funcs->asic_dma_free_coherent(hdev,
-			HL_CPU_ACCESSIBLE_MEM_SIZE,
-			hdev->cpu_accessible_dma_mem,
-			hdev->cpu_accessible_dma_address);
+	hl_asic_dma_free_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE, hdev->cpu_accessible_dma_mem,
+					hdev->cpu_accessible_dma_address);
 free_dma_pool:
 	dma_pool_destroy(hdev->dma_pool);
 free_gaudi_device:
@@ -1984,10 +1972,8 @@ static int gaudi_sw_fini(struct hl_device *hdev)
 		GAUDI_CPU_TO_PCI_ADDR(hdev->cpu_accessible_dma_address,
 					hdev->cpu_pci_msb_addr);
 
-	hdev->asic_funcs->asic_dma_free_coherent(hdev,
-			HL_CPU_ACCESSIBLE_MEM_SIZE,
-			hdev->cpu_accessible_dma_mem,
-			hdev->cpu_accessible_dma_address);
+	hl_asic_dma_free_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE, hdev->cpu_accessible_dma_mem,
+					hdev->cpu_accessible_dma_address);
 
 	dma_pool_destroy(hdev->dma_pool);
 
@@ -4936,8 +4922,7 @@ static int gaudi_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 
 	fence_val = GAUDI_QMAN0_FENCE_VAL;
 
-	fence_ptr = hdev->asic_funcs->asic_dma_pool_zalloc(hdev, 4, GFP_KERNEL,
-							&fence_dma_addr);
+	fence_ptr = hl_asic_dma_pool_zalloc(hdev, 4, GFP_KERNEL, &fence_dma_addr);
 	if (!fence_ptr) {
 		dev_err(hdev->dev,
 			"Failed to allocate memory for H/W queue %d testing\n",
@@ -4947,9 +4932,8 @@ static int gaudi_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 
 	*fence_ptr = 0;
 
-	fence_pkt = hdev->asic_funcs->asic_dma_pool_zalloc(hdev,
-					sizeof(struct packet_msg_prot),
-					GFP_KERNEL, &pkt_dma_addr);
+	fence_pkt = hl_asic_dma_pool_zalloc(hdev, sizeof(struct packet_msg_prot), GFP_KERNEL,
+						&pkt_dma_addr);
 	if (!fence_pkt) {
 		dev_err(hdev->dev,
 			"Failed to allocate packet for H/W queue %d testing\n",
@@ -4989,11 +4973,9 @@ static int gaudi_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 	}
 
 free_pkt:
-	hdev->asic_funcs->asic_dma_pool_free(hdev, (void *) fence_pkt,
-					pkt_dma_addr);
+	hl_asic_dma_pool_free(hdev, (void *) fence_pkt, pkt_dma_addr);
 free_fence_ptr:
-	hdev->asic_funcs->asic_dma_pool_free(hdev, (void *) fence_ptr,
-					fence_dma_addr);
+	hl_asic_dma_pool_free(hdev, (void *) fence_ptr, fence_dma_addr);
 	return rc;
 }
 
@@ -6164,10 +6146,7 @@ static int gaudi_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
 	bool is_eng_idle;
 	int rc = 0, dma_id;
 
-	kernel_addr = hdev->asic_funcs->asic_dma_alloc_coherent(
-						hdev, SZ_2M,
-						&dma_addr,
-						GFP_KERNEL | __GFP_ZERO);
+	kernel_addr = hl_asic_dma_alloc_coherent(hdev, SZ_2M, &dma_addr, GFP_KERNEL | __GFP_ZERO);
 
 	if (!kernel_addr)
 		return -ENOMEM;
@@ -6256,8 +6235,7 @@ static int gaudi_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
 out:
 	hdev->asic_funcs->hw_queues_unlock(hdev);
 
-	hdev->asic_funcs->asic_dma_free_coherent(hdev, SZ_2M, kernel_addr,
-						dma_addr);
+	hl_asic_dma_free_coherent(hdev, SZ_2M, kernel_addr, dma_addr);
 
 	return rc;
 }
@@ -6603,8 +6581,7 @@ static int gaudi_send_job_on_qman0(struct hl_device *hdev,
 		return -EBUSY;
 	}
 
-	fence_ptr = hdev->asic_funcs->asic_dma_pool_zalloc(hdev, 4, GFP_KERNEL,
-							&fence_dma_addr);
+	fence_ptr = hl_asic_dma_pool_zalloc(hdev, 4, GFP_KERNEL, &fence_dma_addr);
 	if (!fence_ptr) {
 		dev_err(hdev->dev,
 			"Failed to allocate fence memory for QMAN0\n");
@@ -6650,8 +6627,7 @@ static int gaudi_send_job_on_qman0(struct hl_device *hdev,
 free_fence_ptr:
 	WREG32(mmDMA0_CORE_PROT + dma_offset, BIT(DMA0_CORE_PROT_ERR_VAL_SHIFT));
 
-	hdev->asic_funcs->asic_dma_pool_free(hdev, (void *) fence_ptr,
-					fence_dma_addr);
+	hl_asic_dma_pool_free(hdev, (void *) fence_ptr, fence_dma_addr);
 	return rc;
 }
 
@@ -8504,11 +8480,10 @@ static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
 	if (!(gaudi->hw_cap_initialized & HW_CAP_MMU))
 		return 0;
 
-	hdev->internal_cb_pool_virt_addr =
-			hdev->asic_funcs->asic_dma_alloc_coherent(hdev,
-					HOST_SPACE_INTERNAL_CB_SZ,
-					&hdev->internal_cb_pool_dma_addr,
-					GFP_KERNEL | __GFP_ZERO);
+	hdev->internal_cb_pool_virt_addr = hl_asic_dma_alloc_coherent(hdev,
+							HOST_SPACE_INTERNAL_CB_SZ,
+							&hdev->internal_cb_pool_dma_addr,
+							GFP_KERNEL | __GFP_ZERO);
 
 	if (!hdev->internal_cb_pool_virt_addr)
 		return -ENOMEM;
@@ -8563,10 +8538,8 @@ static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
 destroy_internal_cb_pool:
 	gen_pool_destroy(hdev->internal_cb_pool);
 free_internal_cb_pool:
-	hdev->asic_funcs->asic_dma_free_coherent(hdev,
-			HOST_SPACE_INTERNAL_CB_SZ,
-			hdev->internal_cb_pool_virt_addr,
-			hdev->internal_cb_pool_dma_addr);
+	hl_asic_dma_free_coherent(hdev, HOST_SPACE_INTERNAL_CB_SZ, hdev->internal_cb_pool_virt_addr,
+					hdev->internal_cb_pool_dma_addr);
 
 	return rc;
 }
@@ -8589,10 +8562,8 @@ static void gaudi_internal_cb_pool_fini(struct hl_device *hdev,
 
 	gen_pool_destroy(hdev->internal_cb_pool);
 
-	hdev->asic_funcs->asic_dma_free_coherent(hdev,
-			HOST_SPACE_INTERNAL_CB_SZ,
-			hdev->internal_cb_pool_virt_addr,
-			hdev->internal_cb_pool_dma_addr);
+	hl_asic_dma_free_coherent(hdev, HOST_SPACE_INTERNAL_CB_SZ, hdev->internal_cb_pool_virt_addr,
+					hdev->internal_cb_pool_dma_addr);
 }
 
 static int gaudi_ctx_init(struct hl_ctx *ctx)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 411a4be09aa6..9d5245275726 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -1012,11 +1012,9 @@ static int goya_sw_init(struct hl_device *hdev)
 		goto free_goya_device;
 	}
 
-	hdev->cpu_accessible_dma_mem =
-			hdev->asic_funcs->asic_dma_alloc_coherent(hdev,
-					HL_CPU_ACCESSIBLE_MEM_SIZE,
-					&hdev->cpu_accessible_dma_address,
-					GFP_KERNEL | __GFP_ZERO);
+	hdev->cpu_accessible_dma_mem = hl_asic_dma_alloc_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE,
+							&hdev->cpu_accessible_dma_address,
+							GFP_KERNEL | __GFP_ZERO);
 
 	if (!hdev->cpu_accessible_dma_mem) {
 		rc = -ENOMEM;
@@ -1066,10 +1064,8 @@ static int goya_sw_init(struct hl_device *hdev)
 free_cpu_accessible_dma_pool:
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
 free_cpu_dma_mem:
-	hdev->asic_funcs->asic_dma_free_coherent(hdev,
-			HL_CPU_ACCESSIBLE_MEM_SIZE,
-			hdev->cpu_accessible_dma_mem,
-			hdev->cpu_accessible_dma_address);
+	hl_asic_dma_free_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE, hdev->cpu_accessible_dma_mem,
+					hdev->cpu_accessible_dma_address);
 free_dma_pool:
 	dma_pool_destroy(hdev->dma_pool);
 free_goya_device:
@@ -1090,10 +1086,8 @@ static int goya_sw_fini(struct hl_device *hdev)
 
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
 
-	hdev->asic_funcs->asic_dma_free_coherent(hdev,
-			HL_CPU_ACCESSIBLE_MEM_SIZE,
-			hdev->cpu_accessible_dma_mem,
-			hdev->cpu_accessible_dma_address);
+	hl_asic_dma_free_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE, hdev->cpu_accessible_dma_mem,
+					hdev->cpu_accessible_dma_address);
 
 	dma_pool_destroy(hdev->dma_pool);
 
@@ -3102,8 +3096,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 		return -EBUSY;
 	}
 
-	fence_ptr = hdev->asic_funcs->asic_dma_pool_zalloc(hdev, 4, GFP_KERNEL,
-							&fence_dma_addr);
+	fence_ptr = hl_asic_dma_pool_zalloc(hdev, 4, GFP_KERNEL, &fence_dma_addr);
 	if (!fence_ptr) {
 		dev_err(hdev->dev,
 			"Failed to allocate fence memory for QMAN0\n");
@@ -3143,8 +3136,7 @@ static int goya_send_job_on_qman0(struct hl_device *hdev, struct hl_cs_job *job)
 	}
 
 free_fence_ptr:
-	hdev->asic_funcs->asic_dma_pool_free(hdev, (void *) fence_ptr,
-					fence_dma_addr);
+	hl_asic_dma_pool_free(hdev, (void *) fence_ptr, fence_dma_addr);
 
 	goya_qman0_set_security(hdev, false);
 
@@ -3180,8 +3172,7 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 
 	fence_val = GOYA_QMAN0_FENCE_VAL;
 
-	fence_ptr = hdev->asic_funcs->asic_dma_pool_zalloc(hdev, 4, GFP_KERNEL,
-							&fence_dma_addr);
+	fence_ptr = hl_asic_dma_pool_zalloc(hdev, 4, GFP_KERNEL, &fence_dma_addr);
 	if (!fence_ptr) {
 		dev_err(hdev->dev,
 			"Failed to allocate memory for H/W queue %d testing\n",
@@ -3191,9 +3182,8 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 
 	*fence_ptr = 0;
 
-	fence_pkt = hdev->asic_funcs->asic_dma_pool_zalloc(hdev,
-					sizeof(struct packet_msg_prot),
-					GFP_KERNEL, &pkt_dma_addr);
+	fence_pkt = hl_asic_dma_pool_zalloc(hdev, sizeof(struct packet_msg_prot), GFP_KERNEL,
+						&pkt_dma_addr);
 	if (!fence_pkt) {
 		dev_err(hdev->dev,
 			"Failed to allocate packet for H/W queue %d testing\n",
@@ -3232,11 +3222,9 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 	}
 
 free_pkt:
-	hdev->asic_funcs->asic_dma_pool_free(hdev, (void *) fence_pkt,
-					pkt_dma_addr);
+	hl_asic_dma_pool_free(hdev, (void *) fence_pkt, pkt_dma_addr);
 free_fence_ptr:
-	hdev->asic_funcs->asic_dma_pool_free(hdev, (void *) fence_ptr,
-					fence_dma_addr);
+	hl_asic_dma_pool_free(hdev, (void *) fence_ptr, fence_dma_addr);
 	return rc;
 }
 
-- 
2.25.1

