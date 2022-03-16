Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C86A4DAF05
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355422AbiCPLnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355429AbiCPLm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:42:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A8F5AEF3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:41:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AABEB819DE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D343C340E9;
        Wed, 16 Mar 2022 11:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647430900;
        bh=fqrbADfL6HWsVoaKFNS9UDjKzeMilK+dwY6xmDeUD+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvkE/+b1k6+3VmxA1lNdXnRoEq5lniE/2mN2PRWBN1+MPvp5F29r6Od7mkwR8vjyT
         KkNaVI+Tz9dok1aomzpglZVS2uAxVvGcAV3WCuI4HfL6yPGUjc9Wfq0XHnnBo++VEd
         VdZpaBGGiRUhKECwNkUGvdqXjU5we1o6sF+oBXVSRngjBDS3frZSj62o6B/njT/MEs
         Wtv07424luFysd9xaE2BVe1JaKJ7SELax3rpENVePV0YTZ4AJisQf8JrGJL+7TMHId
         rHX2dJoqxXB6+q2tMG6dzQBEOmu+jrhFfUqYxDJZDsNU3KMIDl1hnVWYjILIXwI/Zs
         WeCeJ9Gfeoasg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 05/11] habanalabs: add user API to get valid DRAM page sizes
Date:   Wed, 16 Mar 2022 13:41:23 +0200
Message-Id: <20220316114129.2520107-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316114129.2520107-1-ogabbay@kernel.org>
References: <20220316114129.2520107-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Future devices will support multiple device memory page sizes.
In addition, an API for the user was added for it to be able to control
the device memory allocation page size.

This patch is a complementary patch to inform the user of the available
page size supported by the device.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h   |  2 +
 .../misc/habanalabs/common/habanalabs_ioctl.c | 24 +++++++
 drivers/misc/habanalabs/gaudi/gaudi.c         |  7 +++
 drivers/misc/habanalabs/goya/goya.c           |  7 +++
 include/uapi/misc/habanalabs.h                | 63 +++++++++++--------
 5 files changed, 77 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6eb35e4124c2..564797766f42 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1304,6 +1304,7 @@ struct fw_load_mgr {
  * @get_stream_master_qid_arr: get pointer to stream masters QID array
  * @is_valid_dram_page_size: return true if page size is supported in device
  *                           memory allocation, otherwise false.
+ * @get_valid_dram_page_orders: get valid device memory allocation page orders
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1432,6 +1433,7 @@ struct hl_asic_funcs {
 	bool (*is_valid_dram_page_size)(u32 page_size);
 	int (*mmu_get_real_page_size)(struct hl_device *hdev, struct hl_mmu_properties *mmu_prop,
 					u32 page_size, u32 *real_page_size, bool is_dram_addr);
+	void (*get_valid_dram_page_orders)(struct hl_info_dev_memalloc_page_sizes *info);
 };
 
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 14c58579b9cd..c6fe35ae1238 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -591,6 +591,27 @@ static int razwi_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
 }
 
+static int dev_mem_alloc_page_sizes_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
+{
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	struct hl_info_dev_memalloc_page_sizes info = {0};
+	struct hl_device *hdev = hpriv->hdev;
+	u32 max_size = args->return_size;
+
+	if ((!max_size) || (!out))
+		return -EINVAL;
+
+	/*
+	 * Future ASICs that will support multiple DRAM page sizes will support only "powers of 2"
+	 * pages (unlike some of the ASICs before supporting multiple page sizes).
+	 * For this reason for all ASICs that not support multiple page size the function will
+	 * return an empty bitmask indicating that multiple page sizes is not supported.
+	 */
+	hdev->asic_funcs->get_valid_dram_page_orders(&info);
+
+	return copy_to_user(out, &info, min_t(size_t, max_size, sizeof(info))) ? -EFAULT : 0;
+}
+
 static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 				struct device *dev)
 {
@@ -641,6 +662,9 @@ static int _hl_info_ioctl(struct hl_fpriv *hpriv, void *data,
 	case HL_INFO_RAZWI_EVENT:
 		return razwi_info(hpriv, args);
 
+	case HL_INFO_DEV_MEM_ALLOC_PAGE_SIZES:
+		return dev_mem_alloc_page_sizes_info(hpriv, args);
+
 	default:
 		break;
 	}
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 5979434d1905..950a7d6a4a35 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9378,6 +9378,12 @@ static u32 *gaudi_get_stream_master_qid_arr(void)
 	return gaudi_stream_master;
 }
 
+void gaudi_get_valid_dram_page_orders(struct hl_info_dev_memalloc_page_sizes *info)
+{
+	/* set 0 since multiple pages are not supported */
+	info->page_order_bitmask = 0;
+}
+
 static ssize_t infineon_ver_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
@@ -9489,6 +9495,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.get_stream_master_qid_arr = gaudi_get_stream_master_qid_arr,
 	.is_valid_dram_page_size = NULL,
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
+	.get_valid_dram_page_orders = gaudi_get_valid_dram_page_orders,
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ec347bd3bb69..38af7014b845 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5679,6 +5679,12 @@ static u32 *goya_get_stream_master_qid_arr(void)
 	return NULL;
 }
 
+void goya_get_valid_dram_page_orders(struct hl_info_dev_memalloc_page_sizes *info)
+{
+	/* set 0 since multiple pages are not supported */
+	info->page_order_bitmask = 0;
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5767,6 +5773,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_stream_master_qid_arr = goya_get_stream_master_qid_arr,
 	.is_valid_dram_page_size = NULL,
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
+	.get_valid_dram_page_orders = goya_get_valid_dram_page_orders,
 };
 
 /*
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index ae2441521467..f474e7fb018d 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -348,33 +348,35 @@ enum hl_server_type {
  *                            The address which accessing it caused the razwi.
  *                            Razwi initiator.
  *                            Razwi cause, was it a page fault or MMU access error.
+ * HL_INFO_DEV_MEM_ALLOC_PAGE_SIZES - Retrieve valid page sizes for device memory allocation
  */
-#define HL_INFO_HW_IP_INFO		0
-#define HL_INFO_HW_EVENTS		1
-#define HL_INFO_DRAM_USAGE		2
-#define HL_INFO_HW_IDLE			3
-#define HL_INFO_DEVICE_STATUS		4
-#define HL_INFO_DEVICE_UTILIZATION	6
-#define HL_INFO_HW_EVENTS_AGGREGATE	7
-#define HL_INFO_CLK_RATE		8
-#define HL_INFO_RESET_COUNT		9
-#define HL_INFO_TIME_SYNC		10
-#define HL_INFO_CS_COUNTERS		11
-#define HL_INFO_PCI_COUNTERS		12
-#define HL_INFO_CLK_THROTTLE_REASON	13
-#define HL_INFO_SYNC_MANAGER		14
-#define HL_INFO_TOTAL_ENERGY		15
-#define HL_INFO_PLL_FREQUENCY		16
-#define HL_INFO_POWER			17
-#define HL_INFO_OPEN_STATS		18
-#define HL_INFO_DRAM_REPLACED_ROWS	21
-#define HL_INFO_DRAM_PENDING_ROWS	22
-#define HL_INFO_LAST_ERR_OPEN_DEV_TIME	23
-#define HL_INFO_CS_TIMEOUT_EVENT	24
-#define HL_INFO_RAZWI_EVENT		25
-
-#define HL_INFO_VERSION_MAX_LEN		128
-#define HL_INFO_CARD_NAME_MAX_LEN	16
+#define HL_INFO_HW_IP_INFO			0
+#define HL_INFO_HW_EVENTS			1
+#define HL_INFO_DRAM_USAGE			2
+#define HL_INFO_HW_IDLE				3
+#define HL_INFO_DEVICE_STATUS			4
+#define HL_INFO_DEVICE_UTILIZATION		6
+#define HL_INFO_HW_EVENTS_AGGREGATE		7
+#define HL_INFO_CLK_RATE			8
+#define HL_INFO_RESET_COUNT			9
+#define HL_INFO_TIME_SYNC			10
+#define HL_INFO_CS_COUNTERS			11
+#define HL_INFO_PCI_COUNTERS			12
+#define HL_INFO_CLK_THROTTLE_REASON		13
+#define HL_INFO_SYNC_MANAGER			14
+#define HL_INFO_TOTAL_ENERGY			15
+#define HL_INFO_PLL_FREQUENCY			16
+#define HL_INFO_POWER				17
+#define HL_INFO_OPEN_STATS			18
+#define HL_INFO_DRAM_REPLACED_ROWS		21
+#define HL_INFO_DRAM_PENDING_ROWS		22
+#define HL_INFO_LAST_ERR_OPEN_DEV_TIME		23
+#define HL_INFO_CS_TIMEOUT_EVENT		24
+#define HL_INFO_RAZWI_EVENT			25
+#define HL_INFO_DEV_MEM_ALLOC_PAGE_SIZES	26
+
+#define HL_INFO_VERSION_MAX_LEN			128
+#define HL_INFO_CARD_NAME_MAX_LEN		16
 
 /**
  * struct hl_info_hw_ip_info - hardware information on various IPs in the ASIC
@@ -643,6 +645,15 @@ struct hl_info_razwi_event {
 	__u8 pad[2];
 };
 
+/**
+ * struct hl_info_dev_memalloc_page_sizes - valid page sizes in device mem alloc information.
+ * @page_order_bitmask: bitmap in which a set bit represents the order of the supported page size
+ *                      (e.g. 0x2100000 means that 1MB and 32MB pages are supported).
+ */
+struct hl_info_dev_memalloc_page_sizes {
+	__u64 page_order_bitmask;
+};
+
 enum gaudi_dcores {
 	HL_GAUDI_WS_DCORE,
 	HL_GAUDI_WN_DCORE,
-- 
2.25.1

