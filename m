Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF4F4FB6F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344186AbiDKJKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344164AbiDKJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8063ED0F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61FCF60B7D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963DAC385A5;
        Mon, 11 Apr 2022 09:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649668097;
        bh=gBUaV2zyXghG+nxO03HGWe1gvwUDpzxjI/YD98jIIf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MyLrAnPSfp2deh9q1R539FtKVcqOL9SBynW0+OkQ6mmfi2GEBlKRzL12Yt8DGBNza
         KnU+dkhOzWrc9Npn3FfFXhfo4VAgKEHp1FrOH1Zk0zISQbqVXqPCq3C0V5buhql4Gg
         W27jtzsJQybko4B/zdQIMvnjRKEKsSoTe8WyXaVRayEiwAG+nGLJmWh5yYY6XBJR02
         CPw6Y1rPrBIAFP/umHae0MX+67XlczL/p1tkykmWaQFtQoZ3oID2H2+ZWaYMOuWyJJ
         Loabgq+F8VP/TRnKPo6ezi82mzpjbId3XliOuZwy/T15qvi/aR+7vSPTNE2w5UOBQF
         MfW0LeUvGMhTA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 6/7] habanalabs: use for_each_sgtable_dma_sg for dma sgt
Date:   Mon, 11 Apr 2022 12:08:04 +0300
Message-Id: <20220411090805.1617112-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411090805.1617112-1-ogabbay@kernel.org>
References: <20220411090805.1617112-1-ogabbay@kernel.org>
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

Instead of using for_each_sg when iterating sgt that contains dma
entries, use the more proper for_each_sgtable_dma_sg macro.

In addition, both Goya and Gaudi have the exact same implementation
of the asic function that encapsulate the usage of this macro, so
it is better to move that implementation to the common code.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    |  3 +-
 drivers/misc/habanalabs/common/device.c     | 32 +++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h | 14 ++++---
 drivers/misc/habanalabs/common/memory.c     | 21 +++++-----
 drivers/misc/habanalabs/gaudi/gaudi.c       | 43 +++------------------
 drivers/misc/habanalabs/goya/goya.c         | 41 +++-----------------
 6 files changed, 61 insertions(+), 93 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 02b20a7b8119..ffa613af6b0d 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -370,8 +370,7 @@ static int userptr_lookup_show(struct seq_file *s, void *data)
 		if (dev_entry->userptr_lookup >= userptr->addr &&
 		dev_entry->userptr_lookup < userptr->addr + userptr->size) {
 			total_npages = 0;
-			for_each_sg(userptr->sgt->sgl, sg, userptr->sgt->nents,
-					i) {
+			for_each_sgtable_dma_sg(userptr->sgt, sg, i) {
 				npages = hl_get_sg_info(sg, &dma_addr);
 				sg_start = userptr->addr +
 					total_npages * PAGE_SIZE;
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index a8c1d35cf1e7..0f4f7e538b61 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -80,6 +80,38 @@ static int hl_access_sram_dram_region(struct hl_device *hdev, u64 addr, u64 *val
 	return 0;
 }
 
+int hl_dma_map_sgtable(struct hl_device *hdev, struct sg_table *sgt, enum dma_data_direction dir)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct scatterlist *sg;
+	int rc, i;
+
+	rc = dma_map_sgtable(&hdev->pdev->dev, sgt, dir, 0);
+	if (rc)
+		return rc;
+
+	/* Shift to the device's base physical address of host memory if necessary */
+	if (prop->device_dma_offset_for_host_access)
+		for_each_sgtable_dma_sg(sgt, sg, i)
+			sg->dma_address += prop->device_dma_offset_for_host_access;
+
+	return 0;
+}
+
+void hl_dma_unmap_sgtable(struct hl_device *hdev, struct sg_table *sgt, enum dma_data_direction dir)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct scatterlist *sg;
+	int i;
+
+	/* Cancel the device's base physical address of host memory if necessary */
+	if (prop->device_dma_offset_for_host_access)
+		for_each_sgtable_dma_sg(sgt, sg, i)
+			sg->dma_address -= prop->device_dma_offset_for_host_access;
+
+	dma_unmap_sgtable(&hdev->pdev->dev, sgt, dir, 0);
+}
+
 /*
  * hl_access_cfg_region - access the config region
  *
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e9a64309e99f..5f7e584d0f33 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1274,9 +1274,9 @@ struct fw_load_mgr {
  * @asic_dma_pool_free: free small DMA allocation from pool.
  * @cpu_accessible_dma_pool_alloc: allocate CPU PQ packet from DMA pool.
  * @cpu_accessible_dma_pool_free: free CPU PQ packet from DMA pool.
- * @hl_dma_unmap_sg: DMA unmap scatter-gather list.
+ * @hl_dma_unmap_sgtable: DMA unmap scatter-gather table.
  * @cs_parser: parse Command Submission.
- * @asic_dma_map_sg: DMA map scatter-gather list.
+ * @asic_dma_map_sgtable: DMA map scatter-gather table.
  * @get_dma_desc_list_size: get number of LIN_DMA packets required for CB.
  * @add_end_of_cb_packets: Add packets to the end of CB, if device requires it.
  * @update_eq_ci: update event queue CI.
@@ -1389,12 +1389,11 @@ struct hl_asic_funcs {
 				size_t size, dma_addr_t *dma_handle);
 	void (*cpu_accessible_dma_pool_free)(struct hl_device *hdev,
 				size_t size, void *vaddr);
-	void (*hl_dma_unmap_sg)(struct hl_device *hdev,
-				struct scatterlist *sgl, int nents,
+	void (*hl_dma_unmap_sgtable)(struct hl_device *hdev,
+				struct sg_table *sgt,
 				enum dma_data_direction dir);
 	int (*cs_parser)(struct hl_device *hdev, struct hl_cs_parser *parser);
-	int (*asic_dma_map_sg)(struct hl_device *hdev,
-				struct scatterlist *sgl, int nents,
+	int (*asic_dma_map_sgtable)(struct hl_device *hdev, struct sg_table *sgt,
 				enum dma_data_direction dir);
 	u32 (*get_dma_desc_list_size)(struct hl_device *hdev,
 					struct sg_table *sgt);
@@ -3011,6 +3010,9 @@ static inline bool hl_mem_area_crosses_range(u64 address, u32 size,
 }
 
 uint64_t hl_set_dram_bar_default(struct hl_device *hdev, u64 addr);
+int hl_dma_map_sgtable(struct hl_device *hdev, struct sg_table *sgt, enum dma_data_direction dir);
+void hl_dma_unmap_sgtable(struct hl_device *hdev, struct sg_table *sgt,
+				enum dma_data_direction dir);
 int hl_access_cfg_region(struct hl_device *hdev, u64 addr, u64 *val,
 	enum debugfs_access_type acc_type);
 int hl_access_dev_mem(struct hl_device *hdev, struct pci_mem_region *region,
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 76f55ff0f971..4c7f17c2ba00 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -240,19 +240,18 @@ static int dma_map_host_va(struct hl_device *hdev, u64 addr, u64 size,
 		goto pin_err;
 	}
 
-	rc = hdev->asic_funcs->asic_dma_map_sg(hdev, userptr->sgt->sgl,
-					userptr->sgt->nents, DMA_BIDIRECTIONAL);
-	if (rc) {
-		dev_err(hdev->dev, "failed to map sgt with DMA region\n");
-		goto dma_map_err;
-	}
-
 	userptr->dma_mapped = true;
 	userptr->dir = DMA_BIDIRECTIONAL;
 	userptr->vm_type = VM_TYPE_USERPTR;
 
 	*p_userptr = userptr;
 
+	rc = hdev->asic_funcs->asic_dma_map_sgtable(hdev, userptr->sgt, DMA_BIDIRECTIONAL);
+	if (rc) {
+		dev_err(hdev->dev, "failed to map sgt with DMA region\n");
+		goto dma_map_err;
+	}
+
 	return 0;
 
 dma_map_err:
@@ -903,7 +902,7 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 	 * consecutive block.
 	 */
 	total_npages = 0;
-	for_each_sg(userptr->sgt->sgl, sg, userptr->sgt->nents, i) {
+	for_each_sgtable_dma_sg(userptr->sgt, sg, i) {
 		npages = hl_get_sg_info(sg, &dma_addr);
 
 		total_npages += npages;
@@ -932,7 +931,7 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 	phys_pg_pack->total_size = total_npages * page_size;
 
 	j = 0;
-	for_each_sg(userptr->sgt->sgl, sg, userptr->sgt->nents, i) {
+	for_each_sgtable_dma_sg(userptr->sgt, sg, i) {
 		npages = hl_get_sg_info(sg, &dma_addr);
 
 		/* align down to physical page size and save the offset */
@@ -2446,9 +2445,7 @@ void hl_unpin_host_memory(struct hl_device *hdev, struct hl_userptr *userptr)
 	hl_debugfs_remove_userptr(hdev, userptr);
 
 	if (userptr->dma_mapped)
-		hdev->asic_funcs->hl_dma_unmap_sg(hdev, userptr->sgt->sgl,
-							userptr->sgt->nents,
-							userptr->dir);
+		hdev->asic_funcs->hl_dma_unmap_sgtable(hdev, userptr->sgt, userptr->dir);
 
 	unpin_user_pages_dirty_lock(userptr->pages, userptr->npages, true);
 	kvfree(userptr->pages);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 2824d2f16a25..559f869d8500 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5038,36 +5038,7 @@ static void gaudi_cpu_accessible_dma_pool_free(struct hl_device *hdev,
 	hl_fw_cpu_accessible_dma_pool_free(hdev, size, vaddr);
 }
 
-static int gaudi_dma_map_sg(struct hl_device *hdev, struct scatterlist *sgl,
-			int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	if (!dma_map_sg(&hdev->pdev->dev, sgl, nents, dir))
-		return -ENOMEM;
-
-	/* Shift to the device's base physical address of host memory */
-	for_each_sg(sgl, sg, nents, i)
-		sg->dma_address += HOST_PHYS_BASE;
-
-	return 0;
-}
-
-static void gaudi_dma_unmap_sg(struct hl_device *hdev, struct scatterlist *sgl,
-			int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	/* Cancel the device's base physical address of host memory */
-	for_each_sg(sgl, sg, nents, i)
-		sg->dma_address -= HOST_PHYS_BASE;
-
-	dma_unmap_sg(&hdev->pdev->dev, sgl, nents, dir);
-}
-
-static u32 gaudi_get_dma_desc_list_size(struct hl_device *hdev,
+u32 gaudi_get_dma_desc_list_size(struct hl_device *hdev,
 					struct sg_table *sgt)
 {
 	struct scatterlist *sg, *sg_next_iter;
@@ -5077,8 +5048,7 @@ static u32 gaudi_get_dma_desc_list_size(struct hl_device *hdev,
 
 	dma_desc_cnt = 0;
 
-	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
-
+	for_each_sgtable_dma_sg(sgt, sg, count) {
 		len = sg_dma_len(sg);
 		addr = sg_dma_address(sg);
 
@@ -5132,8 +5102,7 @@ static int gaudi_pin_memory_before_cs(struct hl_device *hdev,
 
 	list_add_tail(&userptr->job_node, parser->job_userptr_list);
 
-	rc = hdev->asic_funcs->asic_dma_map_sg(hdev, userptr->sgt->sgl,
-					userptr->sgt->nents, dir);
+	rc = hdev->asic_funcs->asic_dma_map_sgtable(hdev, userptr->sgt, dir);
 	if (rc) {
 		dev_err(hdev->dev, "failed to map sgt with DMA region\n");
 		goto unpin_memory;
@@ -5408,7 +5377,7 @@ static int gaudi_patch_dma_packet(struct hl_device *hdev,
 	sgt = userptr->sgt;
 	dma_desc_cnt = 0;
 
-	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
+	for_each_sgtable_dma_sg(sgt, sg, count) {
 		len = sg_dma_len(sg);
 		dma_addr = sg_dma_address(sg);
 
@@ -9261,9 +9230,9 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.asic_dma_pool_free = gaudi_dma_pool_free,
 	.cpu_accessible_dma_pool_alloc = gaudi_cpu_accessible_dma_pool_alloc,
 	.cpu_accessible_dma_pool_free = gaudi_cpu_accessible_dma_pool_free,
-	.hl_dma_unmap_sg = gaudi_dma_unmap_sg,
+	.hl_dma_unmap_sgtable = hl_dma_unmap_sgtable,
 	.cs_parser = gaudi_cs_parser,
-	.asic_dma_map_sg = gaudi_dma_map_sg,
+	.asic_dma_map_sgtable = hl_dma_map_sgtable,
 	.get_dma_desc_list_size = gaudi_get_dma_desc_list_size,
 	.add_end_of_cb_packets = gaudi_add_end_of_cb_packets,
 	.update_eq_ci = gaudi_update_eq_ci,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 48235795a55d..75736ccdfe4b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3311,35 +3311,6 @@ void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 	hl_fw_cpu_accessible_dma_pool_free(hdev, size, vaddr);
 }
 
-static int goya_dma_map_sg(struct hl_device *hdev, struct scatterlist *sgl,
-				int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	if (!dma_map_sg(&hdev->pdev->dev, sgl, nents, dir))
-		return -ENOMEM;
-
-	/* Shift to the device's base physical address of host memory */
-	for_each_sg(sgl, sg, nents, i)
-		sg->dma_address += HOST_PHYS_BASE;
-
-	return 0;
-}
-
-static void goya_dma_unmap_sg(struct hl_device *hdev, struct scatterlist *sgl,
-				int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	/* Cancel the device's base physical address of host memory */
-	for_each_sg(sgl, sg, nents, i)
-		sg->dma_address -= HOST_PHYS_BASE;
-
-	dma_unmap_sg(&hdev->pdev->dev, sgl, nents, dir);
-}
-
 u32 goya_get_dma_desc_list_size(struct hl_device *hdev, struct sg_table *sgt)
 {
 	struct scatterlist *sg, *sg_next_iter;
@@ -3349,8 +3320,7 @@ u32 goya_get_dma_desc_list_size(struct hl_device *hdev, struct sg_table *sgt)
 
 	dma_desc_cnt = 0;
 
-	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
-
+	for_each_sgtable_dma_sg(sgt, sg, count) {
 		len = sg_dma_len(sg);
 		addr = sg_dma_address(sg);
 
@@ -3404,8 +3374,7 @@ static int goya_pin_memory_before_cs(struct hl_device *hdev,
 
 	list_add_tail(&userptr->job_node, parser->job_userptr_list);
 
-	rc = hdev->asic_funcs->asic_dma_map_sg(hdev, userptr->sgt->sgl,
-					userptr->sgt->nents, dir);
+	rc = hdev->asic_funcs->asic_dma_map_sgtable(hdev, userptr->sgt, dir);
 	if (rc) {
 		dev_err(hdev->dev, "failed to map sgt with DMA region\n");
 		goto unpin_memory;
@@ -3869,7 +3838,7 @@ static int goya_patch_dma_packet(struct hl_device *hdev,
 	sgt = userptr->sgt;
 	dma_desc_cnt = 0;
 
-	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
+	for_each_sgtable_dma_sg(sgt, sg, count) {
 		len = sg_dma_len(sg);
 		dma_addr = sg_dma_address(sg);
 
@@ -5497,9 +5466,9 @@ static const struct hl_asic_funcs goya_funcs = {
 	.asic_dma_pool_free = goya_dma_pool_free,
 	.cpu_accessible_dma_pool_alloc = goya_cpu_accessible_dma_pool_alloc,
 	.cpu_accessible_dma_pool_free = goya_cpu_accessible_dma_pool_free,
-	.hl_dma_unmap_sg = goya_dma_unmap_sg,
+	.hl_dma_unmap_sgtable = hl_dma_unmap_sgtable,
 	.cs_parser = goya_cs_parser,
-	.asic_dma_map_sg = goya_dma_map_sg,
+	.asic_dma_map_sgtable = hl_dma_map_sgtable,
 	.get_dma_desc_list_size = goya_get_dma_desc_list_size,
 	.add_end_of_cb_packets = goya_add_end_of_cb_packets,
 	.update_eq_ci = goya_update_eq_ci,
-- 
2.25.1

