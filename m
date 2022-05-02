Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5A516BB2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382421AbiEBIJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359101AbiEBIJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:09:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3733CA57
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 01:06:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D031FB811CE
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926E7C385AF;
        Mon,  2 May 2022 08:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651478762;
        bh=Fi9oxpTItGqZov3qBcon3GBQcq8KJGOz8iZs1e2UkCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XxMREyg99sZsYxy8fzKgCCKJKTh1BmXuJxs+x63PWlTivGSX7L4qtUPEqDnYBCOdq
         NV/2gpSSo2AbhacKgVF9txJi4GLaRqkE0UF24LUYDscL0UGDPiV5CedmVqkvBMsnkS
         DYDonhLtxr+cvMTscqocv34gZPU7W7u2BT2xHnM1n923xm90l4l6c4YHfwrUJ8Z+yB
         /Oizrsfw4cNXswxBTkT9CZ+lU1Ap8MLPkkrdhzspVBdgJZkw10hkXeGWhLXBtlxjH6
         6bfvhavG7frB0dGsBEAn6QeGNlIubnafqzlMty2VHGXzRAWHvdnxE8sFRBtQP1WL8H
         IvPYpTAu9H05A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 6/6] habanalabs: add device memory scrub ability through debugfs
Date:   Mon,  2 May 2022 11:05:49 +0300
Message-Id: <20220502080549.230411-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220502080549.230411-1-ogabbay@kernel.org>
References: <20220502080549.230411-1-ogabbay@kernel.org>
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

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

Add the ability to scrub the device memory with a given value.
Add file 'dram_mem_scrub_val' to set the value
and a file 'dram_mem_scrub' to scrub the dram.

This is very important to help during automated tests, when you want
the CI system to randomize the memory before training certain
DL topologies.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../ABI/testing/debugfs-driver-habanalabs     | 14 ++++++
 drivers/misc/habanalabs/common/debugfs.c      | 49 +++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   |  6 +++
 .../misc/habanalabs/common/habanalabs_drv.c   |  8 +++
 drivers/misc/habanalabs/gaudi/gaudi.c         | 18 ++++---
 drivers/misc/habanalabs/goya/goya.c           |  6 +++
 drivers/misc/habanalabs/goya/goyaP.h          |  1 +
 7 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index 84bf3da2bb27..0f8d20fe343f 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -170,6 +170,20 @@ KernelVersion:  5.1
 Contact:        ogabbay@kernel.org
 Description:    Sets the state of the third S/W led on the device
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/memory_scrub
+Date:           May 2022
+KernelVersion:  5.19
+Contact:        dhirschfeld@habana.ai
+Description:    Allows the root user to scrub the dram memory. The scrubbing
+                value can be set using the debugfs file memory_scrub_val.
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/memory_scrub_val
+Date:           May 2022
+KernelVersion:  5.19
+Contact:        dhirschfeld@habana.ai
+Description:    The value to which the dram will be set to when the user
+                scrubs the dram using 'memory_scrub' debugfs file
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/mmu
 Date:           Jan 2019
 KernelVersion:  5.1
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index a9c4f2d4139d..c6744bfc6da4 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -538,6 +538,39 @@ static int engines_show(struct seq_file *s, void *data)
 	return 0;
 }
 
+static ssize_t hl_memory_scrub(struct file *f, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	u64 val = entry->memory_scrub_val;
+	int rc;
+
+	if (!hl_device_operational(hdev, NULL)) {
+		dev_warn_ratelimited(hdev->dev, "Can't scrub memory, device is not operational\n");
+		return -EIO;
+	}
+
+	mutex_lock(&hdev->fpriv_list_lock);
+	if (hdev->is_compute_ctx_active) {
+		mutex_unlock(&hdev->fpriv_list_lock);
+		dev_err(hdev->dev, "can't scrub dram, context exist\n");
+		return -EBUSY;
+	}
+	hdev->is_in_dram_scrub = true;
+	mutex_unlock(&hdev->fpriv_list_lock);
+
+	rc = hdev->asic_funcs->scrub_device_dram(hdev, val);
+
+	mutex_lock(&hdev->fpriv_list_lock);
+	hdev->is_in_dram_scrub = false;
+	mutex_unlock(&hdev->fpriv_list_lock);
+
+	if (rc)
+		return rc;
+	return count;
+}
+
 static bool hl_is_device_va(struct hl_device *hdev, u64 addr)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -1316,6 +1349,11 @@ static ssize_t hl_timeout_locked_write(struct file *f, const char __user *buf,
 	return count;
 }
 
+static const struct file_operations hl_mem_scrub_fops = {
+	.owner = THIS_MODULE,
+	.write = hl_memory_scrub,
+};
+
 static const struct file_operations hl_data32b_fops = {
 	.owner = THIS_MODULE,
 	.read = hl_data_read32,
@@ -1475,6 +1513,17 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 	dev_entry->root = debugfs_create_dir(dev_name(hdev->dev),
 						hl_debug_root);
 
+	debugfs_create_x64("memory_scrub_val",
+				0644,
+				dev_entry->root,
+				&dev_entry->memory_scrub_val);
+
+	debugfs_create_file("memory_scrub",
+				0200,
+				dev_entry->root,
+				dev_entry,
+				&hl_mem_scrub_fops);
+
 	debugfs_create_x64("addr",
 				0644,
 				dev_entry->root,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 496d61ee07c5..59150caa98a2 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1246,6 +1246,7 @@ struct fw_load_mgr {
  *                           its implementation is not trivial when the driver
  *                           is loaded in simulation mode (not upstreamed).
  * @scrub_device_mem: Scrub device memory given an address and size
+ * @scrub_device_dram: Scrub the dram memory of the device.
  * @get_int_queue_base: get the internal queue base address.
  * @test_queues: run simple test on all queues for sanity check.
  * @asic_dma_pool_zalloc: small DMA allocation of coherent memory from DMA pool.
@@ -1357,6 +1358,7 @@ struct hl_asic_funcs {
 	void (*asic_dma_free_coherent)(struct hl_device *hdev, size_t size,
 					void *cpu_addr, dma_addr_t dma_handle);
 	int (*scrub_device_mem)(struct hl_device *hdev, u64 addr, u64 size);
+	int (*scrub_device_dram)(struct hl_device *hdev, u64 val);
 	void* (*get_int_queue_base)(struct hl_device *hdev, u32 queue_id,
 				dma_addr_t *dma_handle, u16 *queue_len);
 	int (*test_queues)(struct hl_device *hdev);
@@ -2011,6 +2013,7 @@ struct hl_debugfs_entry {
  * @addr: next address to read/write from/to in read/write32.
  * @mmu_addr: next virtual address to translate to physical address in mmu_show.
  * @userptr_lookup: the target user ptr to look up for on demand.
+ * @memory_scrub_val: the value to which the dram will be scrubbed to using cb scrub_device_dram
  * @mmu_asid: ASID to use while translating in mmu_show.
  * @state_dump_head: index of the latest state dump
  * @i2c_bus: generic u8 debugfs file for bus value to use in i2c_data_read.
@@ -2041,6 +2044,7 @@ struct hl_dbg_device_entry {
 	u64				addr;
 	u64				mmu_addr;
 	u64				userptr_lookup;
+	u64				memory_scrub_val;
 	u32				mmu_asid;
 	u32				state_dump_head;
 	u8				i2c_bus;
@@ -2704,6 +2708,7 @@ struct hl_reset_info {
  * @id_control: minor of the control device
  * @cpu_pci_msb_addr: 50-bit extension bits for the device CPU's 40-bit
  *                    addresses.
+ * @is_in_dram_scrub: true if dram scrub operation is on going.
  * @disabled: is device disabled.
  * @late_init_done: is late init stage was done during initialization.
  * @hwmon_initialized: is H/W monitor sensors was initialized.
@@ -2834,6 +2839,7 @@ struct hl_device {
 	u16				id;
 	u16				id_control;
 	u16				cpu_pci_msb_addr;
+	u8				is_in_dram_scrub;
 	u8				disabled;
 	u8				late_init_done;
 	u8				hwmon_initialized;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 70203433e6cd..1210de39d661 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -158,6 +158,14 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		goto out_err;
 	}
 
+	if (hdev->is_in_dram_scrub) {
+		dev_dbg_ratelimited(hdev->dev,
+			"Can't open %s during dram scrub\n",
+			dev_name(hdev->dev));
+		rc = -EAGAIN;
+		goto out_err;
+	}
+
 	if (hdev->compute_ctx_in_release) {
 		dev_dbg_ratelimited(hdev->dev,
 			"Can't open %s because another user is still releasing it\n",
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8e9bdbac512e..179d9d32f9a3 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4740,12 +4740,11 @@ static void gaudi_dma_free_coherent(struct hl_device *hdev, size_t size,
 	dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, fixed_dma_handle);
 }
 
-static int gaudi_hbm_scrubbing(struct hl_device *hdev)
+int gaudi_scrub_device_dram(struct hl_device *hdev, u64 val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u64  cur_addr = DRAM_BASE_ADDR_USER;
-	u32 val;
-	u32 chunk_size;
+	u32 chunk_size, busy;
 	int rc, dma_id;
 
 	while (cur_addr < prop->dram_end_address) {
@@ -4759,8 +4758,10 @@ static int gaudi_hbm_scrubbing(struct hl_device *hdev)
 				"Doing HBM scrubbing for 0x%09llx - 0x%09llx\n",
 				cur_addr, cur_addr + chunk_size);
 
-			WREG32(mmDMA0_CORE_SRC_BASE_LO + dma_offset, 0xdeadbeaf);
-			WREG32(mmDMA0_CORE_SRC_BASE_HI + dma_offset, 0xdeadbeaf);
+			WREG32(mmDMA0_CORE_SRC_BASE_LO + dma_offset,
+					lower_32_bits(val));
+			WREG32(mmDMA0_CORE_SRC_BASE_HI + dma_offset,
+					upper_32_bits(val));
 			WREG32(mmDMA0_CORE_DST_BASE_LO + dma_offset,
 						lower_32_bits(cur_addr));
 			WREG32(mmDMA0_CORE_DST_BASE_HI + dma_offset,
@@ -4783,8 +4784,8 @@ static int gaudi_hbm_scrubbing(struct hl_device *hdev)
 			rc = hl_poll_timeout(
 				hdev,
 				mmDMA0_CORE_STS0 + dma_offset,
-				val,
-				((val & DMA0_CORE_STS0_BUSY_MASK) == 0),
+				busy,
+				((busy & DMA0_CORE_STS0_BUSY_MASK) == 0),
 				1000,
 				HBM_SCRUBBING_TIMEOUT_US);
 
@@ -4838,7 +4839,7 @@ static int gaudi_scrub_device_mem(struct hl_device *hdev, u64 addr, u64 size)
 		}
 
 		/* Scrub HBM using all DMA channels in parallel */
-		rc = gaudi_hbm_scrubbing(hdev);
+		rc = gaudi_scrub_device_dram(hdev, 0xdeadbeaf);
 		if (rc)
 			dev_err(hdev->dev,
 				"Failed to clear HBM in mem scrub all\n");
@@ -9208,6 +9209,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.asic_dma_alloc_coherent = gaudi_dma_alloc_coherent,
 	.asic_dma_free_coherent = gaudi_dma_free_coherent,
 	.scrub_device_mem = gaudi_scrub_device_mem,
+	.scrub_device_dram = gaudi_scrub_device_dram,
 	.get_int_queue_base = gaudi_get_int_queue_base,
 	.test_queues = gaudi_test_queues,
 	.asic_dma_pool_zalloc = gaudi_dma_pool_zalloc,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index f8fb6dc04269..7983c362da67 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5434,6 +5434,11 @@ static int goya_mmu_prefetch_cache_range(struct hl_device *hdev, u32 flags, u32
 	return 0;
 }
 
+int goya_scrub_device_dram(struct hl_device *hdev, u64 val)
+{
+	return -EOPNOTSUPP;
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5452,6 +5457,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.asic_dma_alloc_coherent = goya_dma_alloc_coherent,
 	.asic_dma_free_coherent = goya_dma_free_coherent,
 	.scrub_device_mem = goya_scrub_device_mem,
+	.scrub_device_dram = goya_scrub_device_dram,
 	.get_int_queue_base = goya_get_int_queue_base,
 	.test_queues = goya_test_queues,
 	.asic_dma_pool_zalloc = goya_dma_pool_zalloc,
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 647f57402616..10118d4bc87d 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -177,6 +177,7 @@ struct goya_device {
 	enum hl_pm_mng_profile		pm_mng_profile;
 };
 
+int goya_scrub_device_dram(struct hl_device *hdev, u64 val);
 int goya_set_fixed_properties(struct hl_device *hdev);
 int goya_mmu_init(struct hl_device *hdev);
 void goya_init_dma_qmans(struct hl_device *hdev);
-- 
2.25.1

