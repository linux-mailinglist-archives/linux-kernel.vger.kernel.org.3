Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D7B4EED03
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345812AbiDAMWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiDAMWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:22:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAF5277950
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69FB0619C9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F166BC340EC;
        Fri,  1 Apr 2022 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648815623;
        bh=LRfbvbOAgefiwtUEgSiT6AowtYWD9mjAhaUq8dqVQFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJtFiCWK0ul8DBvpFHknexZBWzcWSRTmWr80UV5/0gVWZ+7qF21wJzJmFqo7jfL4P
         eXkfI6gqqW6hRAbuuYA+vgM8m9JLmK+4U8+wqDtIlNQZEFwSEUHRq4ZAnevWowr3ls
         lEnHWNTHoVwl4OMBdrZ2x94NukcHhjy0arQ9qatGSrdmitHZ7VZn+1TW2AsPniyztC
         lGrwWnLlZU93+UofWB0Ht0amkWx14LaRh5bpS2ExqmS1HLszVl2vwl5s0U784VJWRu
         X5VD+/sf/egzgdDMlP2PNOCjfxtAMjIwI4iPz8KiLudKXhkEb3ZGq3c9aGGOTGtd8y
         ZjPedMUz5Quow==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 2/7] habanalabs: unify code for memory access from debugfs
Date:   Fri,  1 Apr 2022 15:20:12 +0300
Message-Id: <20220401122017.116205-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401122017.116205-1-ogabbay@kernel.org>
References: <20220401122017.116205-1-ogabbay@kernel.org>
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

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

Currently each asic version implements 4 callbacks:
'debugfs_{read32/write32/read64/write64}'
There is a lot of code duplication among the different
callbacks of all asic versions.
This patch unify the code in order to avoid the code
duplication by iterating the pci_mem_region array
in hl_device and use its fields instead of macros.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c | 156 +++++++++++++++--------
 1 file changed, 104 insertions(+), 52 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 30c637eaf59b..02b20a7b8119 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 #include <linux/vmalloc.h>
+#include <linux/iommu.h>
 
 #define MMU_ADDR_BUF_SIZE	40
 #define MMU_ASID_BUF_SIZE	10
@@ -647,13 +648,102 @@ static int device_va_to_pa(struct hl_device *hdev, u64 virt_addr, u32 size,
 	return rc;
 }
 
+static int hl_access_dev_mem_by_region(struct hl_device *hdev, u64 addr,
+		u64 *val, enum debugfs_access_type acc_type, bool *found)
+{
+	size_t acc_size = (acc_type == DEBUGFS_READ64 || acc_type == DEBUGFS_WRITE64) ?
+		sizeof(u64) : sizeof(u32);
+	struct pci_mem_region *mem_reg;
+	int i;
+
+	for (i = 0; i < PCI_REGION_NUMBER; i++) {
+		mem_reg = &hdev->pci_mem_region[i];
+		if (!mem_reg->used)
+			continue;
+		if (addr >= mem_reg->region_base &&
+			addr <= mem_reg->region_base + mem_reg->region_size - acc_size) {
+			*found = true;
+			return hdev->asic_funcs->access_dev_mem(hdev, mem_reg, i,
+				addr, val, acc_type);
+		}
+	}
+	return 0;
+}
+
+static void hl_access_host_mem(struct hl_device *hdev, u64 addr, u64 *val,
+		enum debugfs_access_type acc_type)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 offset = prop->device_dma_offset_for_host_access;
+
+	switch (acc_type) {
+	case DEBUGFS_READ32:
+		*val = *(u32 *) phys_to_virt(addr - offset);
+		break;
+	case DEBUGFS_WRITE32:
+		*(u32 *) phys_to_virt(addr - offset) = *val;
+		break;
+	case DEBUGFS_READ64:
+		*val = *(u64 *) phys_to_virt(addr - offset);
+		break;
+	case DEBUGFS_WRITE64:
+		*(u64 *) phys_to_virt(addr - offset) = *val;
+		break;
+	}
+}
+
+static int hl_access_mem(struct hl_device *hdev, u64 addr, u64 *val,
+	enum debugfs_access_type acc_type)
+{
+	size_t acc_size = (acc_type == DEBUGFS_READ64 || acc_type == DEBUGFS_WRITE64) ?
+		sizeof(u64) : sizeof(u32);
+	u64 host_start = hdev->asic_prop.host_base_address;
+	u64 host_end = hdev->asic_prop.host_end_address;
+	bool user_address, found = false;
+	int rc;
+
+	user_address = hl_is_device_va(hdev, addr);
+	if (user_address) {
+		rc = device_va_to_pa(hdev, addr, acc_size, &addr);
+		if (rc)
+			return rc;
+	}
+
+	rc = hl_access_dev_mem_by_region(hdev, addr, val, acc_type, &found);
+	if (rc) {
+		dev_err(hdev->dev,
+			"Failed reading addr %#llx from dev mem (%d)\n",
+			addr, rc);
+		return rc;
+	}
+
+	if (found)
+		return 0;
+
+	if (!user_address || iommu_present(&pci_bus_type)) {
+		rc = -EINVAL;
+		goto err;
+	}
+
+	if (addr >= host_start && addr <= host_end - acc_size) {
+		hl_access_host_mem(hdev, addr, val, acc_type);
+	} else {
+		rc = -EINVAL;
+		goto err;
+	}
+
+	return 0;
+err:
+	dev_err(hdev->dev, "invalid addr %#llx\n", addr);
+	return rc;
+}
+
 static ssize_t hl_data_read32(struct file *f, char __user *buf,
 					size_t count, loff_t *ppos)
 {
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
-	u64 addr = entry->addr;
-	bool user_address;
+	u64 value64, addr = entry->addr;
 	char tmp_buf[32];
 	ssize_t rc;
 	u32 val;
@@ -666,18 +756,11 @@ static ssize_t hl_data_read32(struct file *f, char __user *buf,
 	if (*ppos)
 		return 0;
 
-	user_address = hl_is_device_va(hdev, addr);
-	if (user_address) {
-		rc = device_va_to_pa(hdev, addr, sizeof(val), &addr);
-		if (rc)
-			return rc;
-	}
-
-	rc = hdev->asic_funcs->debugfs_read32(hdev, addr, user_address, &val);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to read from 0x%010llx\n", addr);
+	rc = hl_access_mem(hdev, addr, &value64, DEBUGFS_READ32);
+	if (rc)
 		return rc;
-	}
+
+	val = value64; /* downcast back to 32 */
 
 	sprintf(tmp_buf, "0x%08x\n", val);
 	return simple_read_from_buffer(buf, count, ppos, tmp_buf,
@@ -689,8 +772,7 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
 {
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
-	u64 addr = entry->addr;
-	bool user_address;
+	u64 value64, addr = entry->addr;
 	u32 value;
 	ssize_t rc;
 
@@ -703,19 +785,10 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
 	if (rc)
 		return rc;
 
-	user_address = hl_is_device_va(hdev, addr);
-	if (user_address) {
-		rc = device_va_to_pa(hdev, addr, sizeof(value), &addr);
-		if (rc)
-			return rc;
-	}
-
-	rc = hdev->asic_funcs->debugfs_write32(hdev, addr, user_address, value);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to write 0x%08x to 0x%010llx\n",
-			value, addr);
+	value64 = value;
+	rc = hl_access_mem(hdev, addr, &value64, DEBUGFS_WRITE32);
+	if (rc)
 		return rc;
-	}
 
 	return count;
 }
@@ -726,7 +799,6 @@ static ssize_t hl_data_read64(struct file *f, char __user *buf,
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
 	u64 addr = entry->addr;
-	bool user_address;
 	char tmp_buf[32];
 	ssize_t rc;
 	u64 val;
@@ -739,18 +811,9 @@ static ssize_t hl_data_read64(struct file *f, char __user *buf,
 	if (*ppos)
 		return 0;
 
-	user_address = hl_is_device_va(hdev, addr);
-	if (user_address) {
-		rc = device_va_to_pa(hdev, addr, sizeof(val), &addr);
-		if (rc)
-			return rc;
-	}
-
-	rc = hdev->asic_funcs->debugfs_read64(hdev, addr, user_address, &val);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to read from 0x%010llx\n", addr);
+	rc = hl_access_mem(hdev, addr, &val, DEBUGFS_READ64);
+	if (rc)
 		return rc;
-	}
 
 	sprintf(tmp_buf, "0x%016llx\n", val);
 	return simple_read_from_buffer(buf, count, ppos, tmp_buf,
@@ -763,7 +826,6 @@ static ssize_t hl_data_write64(struct file *f, const char __user *buf,
 	struct hl_dbg_device_entry *entry = file_inode(f)->i_private;
 	struct hl_device *hdev = entry->hdev;
 	u64 addr = entry->addr;
-	bool user_address;
 	u64 value;
 	ssize_t rc;
 
@@ -776,19 +838,9 @@ static ssize_t hl_data_write64(struct file *f, const char __user *buf,
 	if (rc)
 		return rc;
 
-	user_address = hl_is_device_va(hdev, addr);
-	if (user_address) {
-		rc = device_va_to_pa(hdev, addr, sizeof(value), &addr);
-		if (rc)
-			return rc;
-	}
-
-	rc = hdev->asic_funcs->debugfs_write64(hdev, addr, user_address, value);
-	if (rc) {
-		dev_err(hdev->dev, "Failed to write 0x%016llx to 0x%010llx\n",
-			value, addr);
+	rc = hl_access_mem(hdev, addr, &value, DEBUGFS_WRITE64);
+	if (rc)
 		return rc;
-	}
 
 	return count;
 }
-- 
2.25.1

