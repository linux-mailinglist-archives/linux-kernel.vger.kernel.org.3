Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1355B132
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 12:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiFZKdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 06:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiFZKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 06:33:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C95E101D7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 03:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E2C861177
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 10:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20152C341CB;
        Sun, 26 Jun 2022 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656239590;
        bh=okXhggd116ikOIv7Ma4tsfvoZ4sxbGPsd7uz5Si032g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dJ3nYw+q9KW1xcoMmJUF9q69suk3wDDMyZIWHgl8jgyx1RyZyYVNkoUxPRRsmC33e
         gH52Fc9qPnmCKtxTy2LPCbK9twAY5FdMZmD2w1JaER64U5PxgChP+y4hqLImHjmOoA
         whnzURcUokix0+kDKZP0G0YHg7EXrjZFPjGkp3jWbw1Hqu3cdXh9xtPfaN3ChI5u8e
         RBd8e5/Elh6FsdSDFJi5Z3ou63QdIQEFyixDAilID+Rxm6c31418Sj6iHY1WKoWIns
         X63Ow4pMz7DEn5/88oeuRjPaL5n347IjGah7JciTk59AywOq+919Wens/eTf+bt1od
         tak7N40NxJegQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/2] habanalabs: communicate supported page sizes to user
Date:   Sun, 26 Jun 2022 13:33:04 +0300
Message-Id: <20220626103304.46126-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220626103304.46126-1-ogabbay@kernel.org>
References: <20220626103304.46126-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Because in future ASICs the driver will allow the user to set the
page size we need to make sure this data is propagated in all APIs.

In addition, since this is already an ASIC property we no longer need
ASIC function for it.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h       | 5 +++--
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 2 +-
 drivers/misc/habanalabs/common/memory.c           | 4 ++--
 drivers/misc/habanalabs/gaudi/gaudi.c             | 7 -------
 drivers/misc/habanalabs/goya/goya.c               | 7 -------
 5 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index df8d1038723d..c5f9501b1113 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -401,6 +401,8 @@ enum hl_device_hw_state {
  * @hop_masks: array holds HOPs masks.
  * @last_mask: mask to get the bit indicating this is the last hop.
  * @pgt_size: size for page tables.
+ * @supported_pages_mask: bitmask for supported page size (relevant only for MMUs
+ *                        supporting multiple page size).
  * @page_size: default page size used to allocate memory.
  * @num_hops: The amount of hops supported by the translation table.
  * @hop_table_size: HOP table size.
@@ -415,6 +417,7 @@ struct hl_mmu_properties {
 	u64	hop_masks[MMU_HOP_MAX];
 	u64	last_mask;
 	u64	pgt_size;
+	u64	supported_pages_mask;
 	u32	page_size;
 	u32	num_hops;
 	u32	hop_table_size;
@@ -1332,7 +1335,6 @@ struct fw_load_mgr {
  * @get_sob_addr: get SOB base address offset.
  * @set_pci_memory_regions: setting properties of PCI memory regions
  * @get_stream_master_qid_arr: get pointer to stream masters QID array
- * @get_valid_dram_page_orders: get valid device memory allocation page orders
  * @access_dev_mem: access device memory
  * @set_dram_bar_base: set the base of the DRAM BAR
  */
@@ -1453,7 +1455,6 @@ struct hl_asic_funcs {
 	u32* (*get_stream_master_qid_arr)(void);
 	int (*mmu_get_real_page_size)(struct hl_device *hdev, struct hl_mmu_properties *mmu_prop,
 					u32 page_size, u32 *real_page_size, bool is_dram_addr);
-	void (*get_valid_dram_page_orders)(struct hl_info_dev_memalloc_page_sizes *info);
 	int (*access_dev_mem)(struct hl_device *hdev, struct pci_mem_region *region,
 		enum pci_region region_type, u64 addr, u64 *val, enum debugfs_access_type acc_type);
 	u64 (*set_dram_bar_base)(struct hl_device *hdev, u64 addr);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index fe7ed46cd1c5..e66dec385ba6 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -648,7 +648,7 @@ static int dev_mem_alloc_page_sizes_info(struct hl_fpriv *hpriv, struct hl_info_
 	 * For this reason for all ASICs that not support multiple page size the function will
 	 * return an empty bitmask indicating that multiple page sizes is not supported.
 	 */
-	hdev->asic_funcs->get_valid_dram_page_orders(&info);
+	info.page_order_bitmask = hdev->asic_prop.dmmu.supported_pages_mask;
 
 	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
 }
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index bc921f32716a..0964c26d717c 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -27,7 +27,7 @@ static int allocate_timestamps_buffers(struct hl_fpriv *hpriv,
 static int set_alloc_page_size(struct hl_device *hdev, struct hl_mem_in *args, u32 *page_size)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u32 psize;
+	u64 psize;
 
 	/*
 	 * for ASIC that supports setting the allocation page size by user we will address
@@ -37,7 +37,7 @@ static int set_alloc_page_size(struct hl_device *hdev, struct hl_mem_in *args, u
 		psize = args->alloc.page_size;
 
 		if (!is_power_of_2(psize)) {
-			dev_err(hdev->dev, "user page size (%#x) is not power of 2\n", psize);
+			dev_err(hdev->dev, "user page size (%#llx) is not power of 2\n", psize);
 			return -EINVAL;
 		}
 	} else {
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 33ad7226dd8c..584feac7ee83 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9237,12 +9237,6 @@ static u32 *gaudi_get_stream_master_qid_arr(void)
 	return gaudi_stream_master;
 }
 
-static void gaudi_get_valid_dram_page_orders(struct hl_info_dev_memalloc_page_sizes *info)
-{
-	/* set 0 since multiple pages are not supported */
-	info->page_order_bitmask = 0;
-}
-
 static ssize_t infineon_ver_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
@@ -9351,7 +9345,6 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.set_pci_memory_regions = gaudi_set_pci_memory_regions,
 	.get_stream_master_qid_arr = gaudi_get_stream_master_qid_arr,
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
-	.get_valid_dram_page_orders = gaudi_get_valid_dram_page_orders,
 	.access_dev_mem = hl_access_dev_mem,
 	.set_dram_bar_base = gaudi_set_hbm_bar_base,
 };
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 49f859a1f07a..9bde01de4fcf 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5405,12 +5405,6 @@ static u32 *goya_get_stream_master_qid_arr(void)
 	return NULL;
 }
 
-static void goya_get_valid_dram_page_orders(struct hl_info_dev_memalloc_page_sizes *info)
-{
-	/* set 0 since multiple pages are not supported */
-	info->page_order_bitmask = 0;
-}
-
 static int goya_get_monitor_dump(struct hl_device *hdev, void *data)
 {
 	return -EOPNOTSUPP;
@@ -5505,7 +5499,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.set_pci_memory_regions = goya_set_pci_memory_regions,
 	.get_stream_master_qid_arr = goya_get_stream_master_qid_arr,
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
-	.get_valid_dram_page_orders = goya_get_valid_dram_page_orders,
 	.access_dev_mem = hl_access_dev_mem,
 	.set_dram_bar_base = goya_set_ddr_bar_base,
 };
-- 
2.25.1

