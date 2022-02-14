Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7434B519F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbiBNN07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:26:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiBNN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:26:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C95D4EA20
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:26:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 905FD61320
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD094C340EF;
        Mon, 14 Feb 2022 13:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644845210;
        bh=q/V+M1Ar5sL/ii8l3W5CVcPDcjhi/AEV/aEu1GPAsLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekQp53ioV5yw2bxWMsoXGIqszo84ADJY3CtedAKdNLCTvwyYjHT2syRvIdGYuLcig
         mCsWuz0LBUhV/zud4bO/uda9AWsKp/r75oNZiplW6+L253aBSXxKTedjrZnUqnqafS
         feiHpDzZg159vwIg1JGW4rQaoyTpEJ/1B0G2IW41kN3IqbY4fXEdtg+wurwYA/GHQo
         tXqWQVIRRkW5bprm7ctvfcO2Ndreh7TYC0MvG6Iy+kUlGDvJK282Hh7oIyZVWm99fe
         8PUb/o8RBlwbIKvVo990pFsVwLsY3W8ItaFNexZFzv4Dw+GotAib3DmLlH//+1qU8r
         fxxJ83XQVqd4g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     hdanton@sina.com, Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH v2 2/2] habanalabs: allow user to set allocation page size
Date:   Mon, 14 Feb 2022 15:26:42 +0200
Message-Id: <20220214132642.4032856-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214132642.4032856-1-ogabbay@kernel.org>
References: <20220214132642.4032856-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

In future ASICs the MMU will be able to work with multiple page sizes,
thus a new flag is added to allow the user to set the requested page
size.

This flag is added since the whole DRAM is allocated for the user and
the user also should be familiar with the memory usage use case.

As such, the user may choose to "over allocate" memory in favor of
performance (for instance- large page allocations covers more memory
in less TLB entries).

For example: say available page sizes are of 1MB and 32MB. If user
wants to allocate 40MB the user can either set page size to 1MB and
allocate the exact amount of memory (but will result in 40 TLB entries)
or the user can use 32MB pages, "waste" 8MB of physical memory but
occupy only 2 TLB entries.

Note that this feature will be available only to ASIC that supports
multiple DRAM page sizes.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
Changes in v2:
 - Separate to different patch the change of comments to kernel-doc.

 drivers/misc/habanalabs/common/habanalabs.h |  5 ++++
 drivers/misc/habanalabs/common/memory.c     | 31 ++++++++++++++++++++-
 drivers/misc/habanalabs/gaudi/gaudi.c       |  3 +-
 drivers/misc/habanalabs/goya/goya.c         |  1 +
 include/uapi/misc/habanalabs.h              |  5 +++-
 5 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index b5055ab528b8..677ae4ff922c 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -563,6 +563,7 @@ struct hl_hints_range {
  *                              devices)
  * @configurable_stop_on_err: is stop-on-error option configurable via debugfs.
  * @set_max_power_on_device_init: true if need to set max power in F/W on device init.
+ * @supports_user_set_page_size: true if user can set the allocation page size.
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -648,6 +649,7 @@ struct asic_fixed_properties {
 	u8				allow_inference_soft_reset;
 	u8				configurable_stop_on_err;
 	u8				set_max_power_on_device_init;
+	u8				supports_user_set_page_size;
 };
 
 /**
@@ -1311,6 +1313,8 @@ struct fw_load_mgr {
  * @get_sob_addr: get SOB base address offset.
  * @set_pci_memory_regions: setting properties of PCI memory regions
  * @get_stream_master_qid_arr: get pointer to stream masters QID array
+ * @is_valid_dram_page_size: return true if page size is supported in device
+ *                           memory allocation, otherwise false.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1436,6 +1440,7 @@ struct hl_asic_funcs {
 	u32 (*get_sob_addr)(struct hl_device *hdev, u32 sob_id);
 	void (*set_pci_memory_regions)(struct hl_device *hdev);
 	u32* (*get_stream_master_qid_arr)(void);
+	bool (*is_valid_dram_page_size)(u32 page_size);
 };
 
 
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 7bd4cae87a54..385bf3448c73 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -24,6 +24,31 @@ MODULE_IMPORT_NS(DMA_BUF);
 static int allocate_timestamps_buffers(struct hl_fpriv *hpriv,
 			struct hl_mem_in *args, u64 *handle);
 
+static int set_alloc_page_size(struct hl_device *hdev, struct hl_mem_in *args, u32 *page_size)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 psize;
+
+	/*
+	 * for ASIC that supports setting the allocation page size by user we will address
+	 * user's choice only if it is not 0 (as 0 means taking the default page size)
+	 */
+	if (prop->supports_user_set_page_size && args->alloc.page_size) {
+		psize = args->alloc.page_size;
+
+		if (!hdev->asic_funcs->is_valid_dram_page_size(psize)) {
+			dev_err(hdev->dev, "user page size (%#x) is not valid\n", psize);
+			return -EINVAL;
+		}
+	} else {
+		psize = hdev->asic_prop.dram_page_size;
+	}
+
+	*page_size = psize;
+
+	return 0;
+}
+
 /*
  * The va ranges in context object contain a list with the available chunks of
  * device virtual memory.
@@ -69,7 +94,11 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 	bool contiguous;
 
 	num_curr_pgs = 0;
-	page_size = hdev->asic_prop.dram_page_size;
+
+	rc = set_alloc_page_size(hdev, args, &page_size);
+	if (rc)
+		return rc;
+
 	num_pgs = DIV_ROUND_UP_ULL(args->alloc.mem_size, page_size);
 	total_size = num_pgs * page_size;
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ad640a268a3c..a60c0e23d23c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9432,7 +9432,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.state_dump_init = gaudi_state_dump_init,
 	.get_sob_addr = gaudi_get_sob_addr,
 	.set_pci_memory_regions = gaudi_set_pci_memory_regions,
-	.get_stream_master_qid_arr = gaudi_get_stream_master_qid_arr
+	.get_stream_master_qid_arr = gaudi_get_stream_master_qid_arr,
+	.is_valid_dram_page_size = NULL
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c08d96e43c9f..ec9358bcbf0b 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5764,6 +5764,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_sob_addr = &goya_get_sob_addr,
 	.set_pci_memory_regions = goya_set_pci_memory_regions,
 	.get_stream_master_qid_arr = goya_get_stream_master_qid_arr,
+	.is_valid_dram_page_size = NULL
 };
 
 /*
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index a2a953a91b5e..1d6b4f0c4159 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
  *
- * Copyright 2016-2021 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -1130,9 +1130,12 @@ struct hl_mem_in {
 		/**
 		 * structure for device memory allocation (used with the HL_MEM_OP_ALLOC op)
 		 * @mem_size: memory size to allocate
+		 * @page_size: page size to use on allocation. when the value is 0 the default page
+		 *             size will be taken.
 		 */
 		struct {
 			__u64 mem_size;
+			__u64 page_size;
 		} alloc;
 
 		/**
-- 
2.25.1

