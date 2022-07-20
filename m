Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE3557B52A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiGTLP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiGTLPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:15:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7082529CBF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:15:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A3D461CBC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F268C341CA;
        Wed, 20 Jul 2022 11:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658315740;
        bh=A0y/BPT9t8243TJ5cILGLgRFMM6JcjZyI0MCGhQ7lPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1T0aO3G9Pz0ehFWMQSTEZs06xNL2hYBAgq2rQ5QWwhLImixhRSbUKbiA3MEZONop
         LRcwdvUzWDlQAxRaeFCRjFB8cD0M8xav0JPnUy45orlxjP80RnBZmScKyd0ilG/M1x
         +efQx7iVnijKNOYJ8/nHiHC8gmDzL7D2/BBEGN1/QK6FX+Uj3Ip6PaCIhBL8YJ0RJq
         /7+yEUg9FOeUGrEFiicBFN4QnRRwOULTgUwjtKqp+YYjspWLfww1DU5ZeN9eAKHBsZ
         pMr6T+clOkJhDq5k+ogriMNQV/lR8stJl9wTR6y4wLcMs2dBFSFZtIv6Ii/1ZL+Htv
         Qb5k+rYpOsvzg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 9/9] habanalabs: remove all kdma locks
Date:   Wed, 20 Jul 2022 14:15:23 +0300
Message-Id: <20220720111523.4069830-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720111523.4069830-1-ogabbay@kernel.org>
References: <20220720111523.4069830-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't use KDMA concurrently in the driver. The only use is through
debugfs and we don't protect concurrent access through it.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  4 ----
 drivers/misc/habanalabs/gaudi/gaudi.c       |  2 --
 drivers/misc/habanalabs/gaudi2/gaudi2.c     | 23 ---------------------
 drivers/misc/habanalabs/gaudi2/gaudi2P.h    |  3 ---
 drivers/misc/habanalabs/goya/goya.c         |  2 --
 5 files changed, 34 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index d3efec600458..8d9e96c6092a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1452,8 +1452,6 @@ struct engines_data {
  * @compute_reset_late_init: perform certain actions needed after a compute reset
  * @hw_queues_lock: acquire H/W queues lock.
  * @hw_queues_unlock: release H/W queues lock.
- * @kdma_lock: acquire H/W queues lock. Relevant from GRECO ASIC
- * @kdma_unlock: release H/W queues lock. Relevant from GRECO ASIC
  * @get_pci_id: retrieve PCI ID.
  * @get_eeprom_data: retrieve EEPROM data from F/W.
  * @get_monitor_dump: retrieve monitor registers dump from F/W.
@@ -1590,8 +1588,6 @@ struct hl_asic_funcs {
 	int (*compute_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
-	void (*kdma_lock)(struct hl_device *hdev, int dcore_id);
-	void (*kdma_unlock)(struct hl_device *hdev, int dcore_id);
 	u32 (*get_pci_id)(struct hl_device *hdev);
 	int (*get_eeprom_data)(struct hl_device *hdev, void *data, size_t max_size);
 	int (*get_monitor_dump)(struct hl_device *hdev, void *data);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 20f62730be02..4d11efed3e64 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9196,8 +9196,6 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.compute_reset_late_init = gaudi_compute_reset_late_init,
 	.hw_queues_lock = gaudi_hw_queues_lock,
 	.hw_queues_unlock = gaudi_hw_queues_unlock,
-	.kdma_lock = NULL,
-	.kdma_unlock = NULL,
 	.get_pci_id = gaudi_get_pci_id,
 	.get_eeprom_data = gaudi_get_eeprom_data,
 	.get_monitor_dump = gaudi_get_monitor_dump,
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 3531a339e742..2c43ed403509 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -3010,7 +3010,6 @@ static int gaudi2_sw_init(struct hl_device *hdev)
 	}
 
 	spin_lock_init(&gaudi2->hw_queues_lock);
-	spin_lock_init(&gaudi2->kdma_lock);
 
 	gaudi2->scratchpad_kernel_address = hl_asic_dma_alloc_coherent(hdev, PAGE_SIZE,
 							&gaudi2->scratchpad_bus_address,
@@ -6464,22 +6463,6 @@ static void gaudi2_hw_queues_unlock(struct hl_device *hdev)
 	spin_unlock(&gaudi2->hw_queues_lock);
 }
 
-static void gaudi2_kdma_lock(struct hl_device *hdev, int dcore_id)
-	__acquires(&gaudi2->kdma_lock)
-{
-	struct gaudi2_device *gaudi2 = hdev->asic_specific;
-
-	spin_lock(&gaudi2->kdma_lock);
-}
-
-static void gaudi2_kdma_unlock(struct hl_device *hdev, int dcore_id)
-	__releases(&gaudi2->kdma_lock)
-{
-	struct gaudi2_device *gaudi2 = hdev->asic_specific;
-
-	spin_unlock(&gaudi2->kdma_lock);
-}
-
 static u32 gaudi2_get_pci_id(struct hl_device *hdev)
 {
 	return hdev->pdev->device;
@@ -9122,8 +9105,6 @@ static int gaudi2_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size, v
 		goto unreserve_va;
 	}
 
-	hdev->asic_funcs->kdma_lock(hdev, 0);
-
 	/* Enable MMU on KDMA */
 	gaudi2_kdma_set_mmbp_asid(hdev, false, ctx->asid);
 
@@ -9151,8 +9132,6 @@ static int gaudi2_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size, v
 
 	gaudi2_kdma_set_mmbp_asid(hdev, true, HL_KERNEL_ASID_ID);
 
-	hdev->asic_funcs->kdma_unlock(hdev, 0);
-
 	mutex_lock(&ctx->mmu_lock);
 	hl_mmu_unmap_contiguous(ctx, reserved_va_base, SZ_2M);
 	hl_mmu_invalidate_cache_range(hdev, false, MMU_OP_USERPTR,
@@ -9951,8 +9930,6 @@ static const struct hl_asic_funcs gaudi2_funcs = {
 	.compute_reset_late_init = gaudi2_compute_reset_late_init,
 	.hw_queues_lock = gaudi2_hw_queues_lock,
 	.hw_queues_unlock = gaudi2_hw_queues_unlock,
-	.kdma_lock = gaudi2_kdma_lock,
-	.kdma_unlock = gaudi2_kdma_unlock,
 	.get_pci_id = gaudi2_get_pci_id,
 	.get_eeprom_data = gaudi2_get_eeprom_data,
 	.get_monitor_dump = gaudi2_get_monitor_dump,
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2P.h b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
index 5110574a650e..347ea1dd78e2 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2P.h
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
@@ -457,7 +457,6 @@ struct dup_block_ctx {
  *                 the user can map.
  * @lfsr_rand_seeds: array of MME ACC random seeds to set.
  * @hw_queues_lock: protects the H/W queues from concurrent access.
- * @kdma_lock: protects the KDMA engine from concurrent access.
  * @scratchpad_kernel_address: general purpose PAGE_SIZE contiguous memory,
  *                             this memory region should be write-only.
  *                             currently used for HBW QMAN writes which is
@@ -509,7 +508,6 @@ struct dup_block_ctx {
  * @flush_db_fifo: flag to force flush DB FIFO after a write.
  * @hbm_cfg: HBM subsystem settings
  * @hw_queues_lock_mutex: used by simulator instead of hw_queues_lock.
- * @kdma_lock_mutex: used by simulator instead of kdma_lock.
  */
 struct gaudi2_device {
 	int (*cpucp_info_get)(struct hl_device *hdev);
@@ -518,7 +516,6 @@ struct gaudi2_device {
 	int				lfsr_rand_seeds[MME_NUM_OF_LFSR_SEEDS];
 
 	spinlock_t			hw_queues_lock;
-	spinlock_t			kdma_lock;
 
 	void				*scratchpad_kernel_address;
 	dma_addr_t			scratchpad_bus_address;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index d4459c290ea8..91429d6ea037 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5481,8 +5481,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.compute_reset_late_init = goya_compute_reset_late_init,
 	.hw_queues_lock = goya_hw_queues_lock,
 	.hw_queues_unlock = goya_hw_queues_unlock,
-	.kdma_lock = NULL,
-	.kdma_unlock = NULL,
 	.get_pci_id = goya_get_pci_id,
 	.get_eeprom_data = goya_get_eeprom_data,
 	.get_monitor_dump = goya_get_monitor_dump,
-- 
2.25.1

