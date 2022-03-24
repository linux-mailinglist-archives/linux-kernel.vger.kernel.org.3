Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5BE4E6127
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349270AbiCXJf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349238AbiCXJfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:35:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4DB1EC51
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57CC1B82324
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3F3C340EC;
        Thu, 24 Mar 2022 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648114445;
        bh=E3iRW+5Yj5mdkvV8ijhg+B/u0XiR6JgZH+cB5GsaIjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IfUeH/ucKQo8mTi4Ey8YaN5J2sdejP/TeY9j8bGJTw6JOUeDdD55aiYMk2C9cPMTF
         3BY22mDu9XUmZGDc7FGn1ZV6DZuVWRA7pPqWeihUCJ/eE52Vo2qrdhSfUiZq5IQ4Uk
         1wdSKe3OZzdL0kpkIn05WZ/T8IcgwBHmFdKvh2Y+DW9hClh/+4Y1+V95y/D1ye5SBF
         WGrD/GTddl8gntoEQH/Q0pN7GsXobKAUX8GDcN0YEO2T7n2TSmV7HOin/YuGODtnek
         QLbL3M0GNXW49UDuPfZ/8+OLnIKkwwSnCn8nBBTkgoA4XCpQ4fbCbWzTQlbePGN0Ep
         5Ztu8ejL3NMsQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 7/7] habanalabs/gaudi: add debugfs to fetch internal sync status
Date:   Thu, 24 Mar 2022 11:33:49 +0200
Message-Id: <20220324093349.3245973-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324093349.3245973-1-ogabbay@kernel.org>
References: <20220324093349.3245973-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

When Gaudi device is secured the monitors data in the configuration
space is blocked from PCI access.
As we need to enable user to get sync-manager monitors registers when
debugging, this patch adds a debugfs that dumps the information to a
binary file (blob).
When a root user will trigger the dump, the driver will send request to
the f/w to fill a data structure containing dump of all monitors
registers.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../ABI/testing/debugfs-driver-habanalabs     | 24 +++++
 drivers/misc/habanalabs/common/debugfs.c      | 87 ++++++++++++++++---
 drivers/misc/habanalabs/common/firmware_if.c  | 47 ++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   | 13 ++-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 11 +++
 drivers/misc/habanalabs/goya/goya.c           |  6 ++
 .../misc/habanalabs/include/common/cpucp_if.h | 38 ++++++++
 7 files changed, 210 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index bcf6915987e4..84bf3da2bb27 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -190,6 +190,30 @@ Description:    Check and display page fault or access violation mmu errors for
                 echo "0x200" > /sys/kernel/debug/habanalabs/hl0/mmu_error
                 cat /sys/kernel/debug/habanalabs/hl0/mmu_error
 
+What:           /sys/kernel/debug/habanalabs/hl<n>/monitor_dump
+Date:           Mar 2022
+KernelVersion:  5.19
+Contact:        osharabi@habana.ai
+Description:    Allows the root user to dump monitors status from the device's
+                protected config space.
+                This property is a binary blob that contains the result of the
+                monitors registers dump.
+                This custom interface is needed (instead of using the generic
+                Linux user-space PCI mapping) because this space is protected
+                and cannot be accessed using PCI read.
+                This interface doesn't support concurrency in the same device.
+                Only supported on GAUDI.
+
+What:           /sys/kernel/debug/habanalabs/hl<n>/monitor_dump_trig
+Date:           Mar 2022
+KernelVersion:  5.19
+Contact:        osharabi@habana.ai
+Description:    Triggers dump of monitor data. The value to trigger the operation
+                must be 1. Triggering the monitor dump operation initiates dump of
+                current registers values of all monitors.
+                When the write is finished, the user can read the "monitor_dump"
+                blob
+
 What:           /sys/kernel/debug/habanalabs/hl<n>/set_power_state
 Date:           Jan 2019
 KernelVersion:  5.1
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index f18495545854..30c637eaf59b 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -829,23 +829,67 @@ static ssize_t hl_dma_size_write(struct file *f, const char __user *buf,
 	}
 
 	/* Free the previous allocation, if there was any */
-	entry->blob_desc.size = 0;
-	vfree(entry->blob_desc.data);
+	entry->data_dma_blob_desc.size = 0;
+	vfree(entry->data_dma_blob_desc.data);
 
-	entry->blob_desc.data = vmalloc(size);
-	if (!entry->blob_desc.data)
+	entry->data_dma_blob_desc.data = vmalloc(size);
+	if (!entry->data_dma_blob_desc.data)
 		return -ENOMEM;
 
 	rc = hdev->asic_funcs->debugfs_read_dma(hdev, addr, size,
-						entry->blob_desc.data);
+						entry->data_dma_blob_desc.data);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to DMA from 0x%010llx\n", addr);
-		vfree(entry->blob_desc.data);
-		entry->blob_desc.data = NULL;
+		vfree(entry->data_dma_blob_desc.data);
+		entry->data_dma_blob_desc.data = NULL;
 		return -EIO;
 	}
 
-	entry->blob_desc.size = size;
+	entry->data_dma_blob_desc.size = size;
+
+	return count;
+}
+
+static ssize_t hl_monitor_dump_trigger(struct file *f, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
+	struct hl_device *hdev = entry->hdev;
+	u32 size, trig;
+	ssize_t rc;
+
+	if (hdev->reset_info.in_reset) {
+		dev_warn_ratelimited(hdev->dev, "Can't dump monitors during reset\n");
+		return 0;
+	}
+	rc = kstrtouint_from_user(buf, count, 10, &trig);
+	if (rc)
+		return rc;
+
+	if (trig != 1) {
+		dev_err(hdev->dev, "Must write 1 to trigger monitor dump\n");
+		return -EINVAL;
+	}
+
+	size = sizeof(struct cpucp_monitor_dump);
+
+	/* Free the previous allocation, if there was any */
+	entry->mon_dump_blob_desc.size = 0;
+	vfree(entry->mon_dump_blob_desc.data);
+
+	entry->mon_dump_blob_desc.data = vmalloc(size);
+	if (!entry->mon_dump_blob_desc.data)
+		return -ENOMEM;
+
+	rc = hdev->asic_funcs->get_monitor_dump(hdev, entry->mon_dump_blob_desc.data);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to dump monitors\n");
+		vfree(entry->mon_dump_blob_desc.data);
+		entry->mon_dump_blob_desc.data = NULL;
+		return -EIO;
+	}
+
+	entry->mon_dump_blob_desc.size = size;
 
 	return count;
 }
@@ -1235,6 +1279,11 @@ static const struct file_operations hl_dma_size_fops = {
 	.write = hl_dma_size_write
 };
 
+static const struct file_operations hl_monitor_dump_fops = {
+	.owner = THIS_MODULE,
+	.write = hl_monitor_dump_trigger
+};
+
 static const struct file_operations hl_i2c_data_fops = {
 	.owner = THIS_MODULE,
 	.read = hl_i2c_data_read,
@@ -1350,8 +1399,10 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 	if (!dev_entry->entry_arr)
 		return;
 
-	dev_entry->blob_desc.size = 0;
-	dev_entry->blob_desc.data = NULL;
+	dev_entry->data_dma_blob_desc.size = 0;
+	dev_entry->data_dma_blob_desc.data = NULL;
+	dev_entry->mon_dump_blob_desc.size = 0;
+	dev_entry->mon_dump_blob_desc.data = NULL;
 
 	INIT_LIST_HEAD(&dev_entry->file_list);
 	INIT_LIST_HEAD(&dev_entry->cb_list);
@@ -1470,7 +1521,18 @@ void hl_debugfs_add_device(struct hl_device *hdev)
 	debugfs_create_blob("data_dma",
 				0400,
 				dev_entry->root,
-				&dev_entry->blob_desc);
+				&dev_entry->data_dma_blob_desc);
+
+	debugfs_create_file("monitor_dump_trig",
+				0200,
+				dev_entry->root,
+				dev_entry,
+				&hl_monitor_dump_fops);
+
+	debugfs_create_blob("monitor_dump",
+				0400,
+				dev_entry->root,
+				&dev_entry->mon_dump_blob_desc);
 
 	debugfs_create_x8("skip_reset_on_timeout",
 				0644,
@@ -1509,7 +1571,8 @@ void hl_debugfs_remove_device(struct hl_device *hdev)
 
 	mutex_destroy(&entry->file_mutex);
 
-	vfree(entry->blob_desc.data);
+	vfree(entry->data_dma_blob_desc.data);
+	vfree(entry->mon_dump_blob_desc.data);
 
 	for (i = 0; i < ARRAY_SIZE(entry->state_dump); ++i)
 		vfree(entry->state_dump[i]);
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 42dce28ca815..13e09183df18 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -821,6 +821,53 @@ int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 	return rc;
 }
 
+int hl_fw_get_monitor_dump(struct hl_device *hdev, void *data)
+{
+	struct cpucp_monitor_dump *mon_dump_cpu_addr;
+	dma_addr_t mon_dump_dma_addr;
+	struct cpucp_packet pkt = {};
+	u32 *src_ptr, *dst_ptr;
+	size_t data_size;
+	u64 result;
+	int i, rc;
+
+	data_size = sizeof(struct cpucp_monitor_dump);
+	mon_dump_cpu_addr = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev, data_size,
+										&mon_dump_dma_addr);
+	if (!mon_dump_cpu_addr) {
+		dev_err(hdev->dev,
+			"Failed to allocate DMA memory for CPU-CP monitor-dump packet\n");
+		return -ENOMEM;
+	}
+
+	memset(mon_dump_cpu_addr, 0, data_size);
+
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_MONITOR_DUMP_GET << CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.addr = cpu_to_le64(mon_dump_dma_addr);
+	pkt.data_max_size = cpu_to_le32(data_size);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+							HL_CPUCP_MON_DUMP_TIMEOUT_USEC, &result);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to handle CPU-CP monitor-dump packet, error %d\n", rc);
+		goto out;
+	}
+
+	/* result contains the actual size */
+	src_ptr = (u32 *)mon_dump_cpu_addr;
+	dst_ptr = data;
+	for (i = 0; i < (data_size / sizeof(u32)); i++) {
+		*dst_ptr = le32_to_cpu(*src_ptr);
+		src_ptr++;
+		dst_ptr++;
+	}
+
+out:
+	hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev, data_size, mon_dump_cpu_addr);
+
+	return rc;
+}
+
 int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters)
 {
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 1f7758fed51e..ece83b264b97 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -61,6 +61,7 @@
 
 #define HL_CPUCP_INFO_TIMEOUT_USEC	10000000 /* 10s */
 #define HL_CPUCP_EEPROM_TIMEOUT_USEC	10000000 /* 10s */
+#define HL_CPUCP_MON_DUMP_TIMEOUT_USEC	10000000 /* 10s */
 
 #define HL_FW_STATUS_POLL_INTERVAL_USEC		10000 /* 10ms */
 
@@ -1293,6 +1294,7 @@ struct fw_load_mgr {
  * @hw_queues_unlock: release H/W queues lock.
  * @get_pci_id: retrieve PCI ID.
  * @get_eeprom_data: retrieve EEPROM data from F/W.
+ * @get_monitor_dump: retrieve monitor registers dump from F/W.
  * @send_cpu_message: send message to F/W. If the message is timedout, the
  *                    driver will eventually reset the device. The timeout can
  *                    be determined by the calling function or it can be 0 and
@@ -1426,8 +1428,8 @@ struct hl_asic_funcs {
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
 	u32 (*get_pci_id)(struct hl_device *hdev);
-	int (*get_eeprom_data)(struct hl_device *hdev, void *data,
-				size_t max_size);
+	int (*get_eeprom_data)(struct hl_device *hdev, void *data, size_t max_size);
+	int (*get_monitor_dump)(struct hl_device *hdev, void *data);
 	int (*send_cpu_message)(struct hl_device *hdev, u32 *msg,
 				u16 len, u32 timeout, u64 *result);
 	int (*pci_bars_map)(struct hl_device *hdev);
@@ -2021,7 +2023,8 @@ struct hl_debugfs_entry {
  * @userptr_spinlock: protects userptr_list.
  * @ctx_mem_hash_list: list of available contexts with MMU mappings.
  * @ctx_mem_hash_spinlock: protects cb_list.
- * @blob_desc: descriptor of blob
+ * @data_dma_blob_desc: data DMA descriptor of blob.
+ * @mon_dump_blob_desc: monitor dump descriptor of blob.
  * @state_dump: data of the system states in case of a bad cs.
  * @state_dump_sem: protects state_dump.
  * @addr: next address to read/write from/to in read/write32.
@@ -2050,7 +2053,8 @@ struct hl_dbg_device_entry {
 	spinlock_t			userptr_spinlock;
 	struct list_head		ctx_mem_hash_list;
 	spinlock_t			ctx_mem_hash_spinlock;
-	struct debugfs_blob_wrapper	blob_desc;
+	struct debugfs_blob_wrapper	data_dma_blob_desc;
+	struct debugfs_blob_wrapper	mon_dump_blob_desc;
 	char				*state_dump[HL_STATE_DUMP_HIST_LEN];
 	struct rw_semaphore		state_dump_sem;
 	u64				addr;
@@ -3183,6 +3187,7 @@ int hl_fw_cpucp_handshake(struct hl_device *hdev,
 				u32 sts_boot_dev_sts1_reg, u32 boot_err0_reg,
 				u32 boot_err1_reg);
 int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size);
+int hl_fw_get_monitor_dump(struct hl_device *hdev, void *data);
 int hl_fw_cpucp_pci_counters_get(struct hl_device *hdev,
 		struct hl_info_pci_counters *counters);
 int hl_fw_cpucp_total_energy_get(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 2101abf1d092..fdcdf47087c8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8500,6 +8500,16 @@ static int gaudi_get_eeprom_data(struct hl_device *hdev, void *data,
 	return hl_fw_get_eeprom_data(hdev, data, max_size);
 }
 
+static int gaudi_get_monitor_dump(struct hl_device *hdev, void *data)
+{
+	struct gaudi_device *gaudi = hdev->asic_specific;
+
+	if (!(gaudi->hw_cap_initialized & HW_CAP_CPU_Q))
+		return 0;
+
+	return hl_fw_get_monitor_dump(hdev, data);
+}
+
 /*
  * this function should be used only during initialization and/or after reset,
  * when there are no active users.
@@ -9459,6 +9469,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.hw_queues_unlock = gaudi_hw_queues_unlock,
 	.get_pci_id = gaudi_get_pci_id,
 	.get_eeprom_data = gaudi_get_eeprom_data,
+	.get_monitor_dump = gaudi_get_monitor_dump,
 	.send_cpu_message = gaudi_send_cpu_message,
 	.pci_bars_map = gaudi_pci_bars_map,
 	.init_iatu = gaudi_init_iatu,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index bc8431e4b50b..36b3cf57aaae 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5680,6 +5680,11 @@ static void goya_get_valid_dram_page_orders(struct hl_info_dev_memalloc_page_siz
 	info->page_order_bitmask = 0;
 }
 
+static int goya_get_monitor_dump(struct hl_device *hdev, void *data)
+{
+	return -EOPNOTSUPP;
+}
+
 static int goya_mmu_prefetch_cache_range(struct hl_device *hdev, u32 flags, u32 asid, u64 va,
 					u64 size)
 {
@@ -5739,6 +5744,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.hw_queues_unlock = goya_hw_queues_unlock,
 	.get_pci_id = goya_get_pci_id,
 	.get_eeprom_data = goya_get_eeprom_data,
+	.get_monitor_dump = goya_get_monitor_dump,
 	.send_cpu_message = goya_send_cpu_message,
 	.pci_bars_map = goya_pci_bars_map,
 	.init_iatu = goya_init_iatu,
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index f00db22f98fb..645fda75ed27 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -389,6 +389,14 @@ enum pq_init_status {
  *
  * CPUCP_PACKET_ENGINE_CORE_ASID_SET -
  *       Packet to perform engine core ASID configuration
+ *
+ * CPUCP_PACKET_MONITOR_DUMP_GET -
+ *       Get monitors registers dump from the CpuCP kernel.
+ *       The CPU will put the registers dump in the a buffer allocated by the driver
+ *       which address is passed via the CpuCp packet. In addition, the host's driver
+ *       passes the max size it allows the CpuCP to write to the structure, to prevent
+ *       data corruption in case of mismatched driver/FW versions.
+ *       Relevant only to Gaudi.
  */
 
 enum cpucp_packet_id {
@@ -439,6 +447,11 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_POWER_SET,			/* internal */
 	CPUCP_PACKET_RESERVED,			/* not used */
 	CPUCP_PACKET_ENGINE_CORE_ASID_SET,	/* internal */
+	CPUCP_PACKET_RESERVED2,			/* not used */
+	CPUCP_PACKET_RESERVED3,			/* not used */
+	CPUCP_PACKET_RESERVED4,			/* not used */
+	CPUCP_PACKET_RESERVED5,			/* not used */
+	CPUCP_PACKET_MONITOR_DUMP_GET,		/* debugfs */
 };
 
 #define CPUCP_PACKET_FENCE_VAL	0xFE8CE7A5
@@ -889,4 +902,29 @@ struct cpucp_hbm_row_replaced_rows_info {
 	struct cpucp_hbm_row_info replaced_rows[CPUCP_HBM_ROW_REPLACE_MAX];
 };
 
+/*
+ * struct dcore_monitor_regs_data - DCORE monitor regs data.
+ * the structure follows sync manager block layout. relevant only to Gaudi.
+ * @mon_pay_addrl: array of payload address low bits.
+ * @mon_pay_addrh: array of payload address high bits.
+ * @mon_pay_data: array of payload data.
+ * @mon_arm: array of monitor arm.
+ * @mon_status: array of monitor status.
+ */
+struct dcore_monitor_regs_data {
+	__le32 mon_pay_addrl[512];
+	__le32 mon_pay_addrh[512];
+	__le32 mon_pay_data[512];
+	__le32 mon_arm[512];
+	__le32 mon_status[512];
+};
+
+/* contains SM data for each SYNC_MNGR (relevant only to Gaudi) */
+struct cpucp_monitor_dump {
+	struct dcore_monitor_regs_data sync_mngr_w_s;
+	struct dcore_monitor_regs_data sync_mngr_e_s;
+	struct dcore_monitor_regs_data sync_mngr_w_n;
+	struct dcore_monitor_regs_data sync_mngr_e_n;
+};
+
 #endif /* CPUCP_IF_H */
-- 
2.25.1

