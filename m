Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE84DAF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355486AbiCPLnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355453AbiCPLnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29C24AE2E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80FAF616C5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F765C340E9;
        Wed, 16 Mar 2022 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647430908;
        bh=hmJnEQeG1AZihBsicNTn3yKXZVt1Z1wqB9GfKQ63n/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9My8HpsHsdF2IwH9IJjdJa23Zb54Z21kaev+phWP4lfknsU0R86YGc0cdlIJT0FB
         pbPNtm28tPzxWHR6w6zL+QEPI23pcAmshVI2EjgKDSBK7nwLYKI3M48tuFa2qbUz3e
         GazLIrs7ridX472oPe+EF7woXdX+ddI8z2fYoS0qXD9KSgl1f1B/eWorgYithm6wO0
         SosJD+YpFa3s9YTapcIDskUAOEmkQNuGm1mx2shQiqRo9muwa83w0yqGXKwccluyR6
         EOM2htlFP1jMkP95wyJ6JnpLrLqYGsEW0OC7U7GptHqnFtyiXWb/GUtrY07zRb97Cp
         u6J1fiwklmZGA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 11/11] habanalabs: modify dma_mask to be ASIC specific property
Date:   Wed, 16 Mar 2022 13:41:29 +0200
Message-Id: <20220316114129.2520107-11-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

The required DMA mask is no longer based on input from the F/W, but it
is fixed per ASIC according to its address space.
As such, the per-ASIC function to get this value can be replaced with a
property variable.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h     |  7 ++-----
 drivers/misc/habanalabs/common/habanalabs_drv.c |  3 ---
 drivers/misc/habanalabs/common/pci/pci.c        | 10 ++++------
 drivers/misc/habanalabs/gaudi/gaudi.c           | 10 ++--------
 drivers/misc/habanalabs/goya/goya.c             | 10 ++--------
 5 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 0079f43bc596..3e7012f7b1a3 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -552,6 +552,7 @@ struct hl_hints_range {
  * @configurable_stop_on_err: is stop-on-error option configurable via debugfs.
  * @set_max_power_on_device_init: true if need to set max power in F/W on device init.
  * @supports_user_set_page_size: true if user can set the allocation page size.
+ * @dma_mask: the dma mask to be set for this device
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -639,6 +640,7 @@ struct asic_fixed_properties {
 	u8				configurable_stop_on_err;
 	u8				set_max_power_on_device_init;
 	u8				supports_user_set_page_size;
+	u8				dma_mask;
 };
 
 /**
@@ -1274,8 +1276,6 @@ struct fw_load_mgr {
  * @gen_wait_cb: Generate a wait CB.
  * @reset_sob: Reset a SOB.
  * @reset_sob_group: Reset SOB group
- * @set_dma_mask_from_fw: set the DMA mask in the driver according to the
- *                        firmware configuration
  * @get_device_time: Get the device time.
  * @collective_wait_init_cs: Generate collective master/slave packets
  *                           and place them in the relevant cs jobs
@@ -1407,7 +1407,6 @@ struct hl_asic_funcs {
 			struct hl_gen_wait_properties *prop);
 	void (*reset_sob)(struct hl_device *hdev, void *data);
 	void (*reset_sob_group)(struct hl_device *hdev, u16 sob_group);
-	void (*set_dma_mask_from_fw)(struct hl_device *hdev);
 	u64 (*get_device_time)(struct hl_device *hdev);
 	int (*collective_wait_init_cs)(struct hl_cs *cs);
 	int (*collective_wait_create_jobs)(struct hl_device *hdev,
@@ -2688,7 +2687,6 @@ struct hl_reset_info {
  *                   huge pages.
  * @init_done: is the initialization of the device done.
  * @device_cpu_disabled: is the device CPU disabled (due to timeouts)
- * @dma_mask: the dma mask that was set for this device
  * @in_debug: whether the device is in a state where the profiling/tracing infrastructure
  *            can be used. This indication is needed because in some ASICs we need to do
  *            specific operations to enable that infrastructure.
@@ -2813,7 +2811,6 @@ struct hl_device {
 	u8				pmmu_huge_range;
 	u8				init_done;
 	u8				device_cpu_disabled;
-	u8				dma_mask;
 	u8				in_debug;
 	u8				cdev_sysfs_created;
 	u8				stop_on_err;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index e870c32a0733..95c000d7dc26 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -309,9 +309,6 @@ static int fixup_device_params(struct hl_device *hdev)
 	/* Enable only after the initialization of the device */
 	hdev->disabled = true;
 
-	/* Set default DMA mask to 32 bits */
-	hdev->dma_mask = 32;
-
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/common/pci/pci.c b/drivers/misc/habanalabs/common/pci/pci.c
index bb9ce22bafc4..610acd4a8057 100644
--- a/drivers/misc/habanalabs/common/pci/pci.c
+++ b/drivers/misc/habanalabs/common/pci/pci.c
@@ -392,6 +392,7 @@ enum pci_region hl_get_pci_memory_region(struct hl_device *hdev, u64 addr)
  */
 int hl_pci_init(struct hl_device *hdev)
 {
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct pci_dev *pdev = hdev->pdev;
 	int rc;
 
@@ -419,17 +420,14 @@ int hl_pci_init(struct hl_device *hdev)
 	}
 
 	/* Driver must sleep in order for FW to finish the iATU configuration */
-	if (hdev->asic_prop.iatu_done_by_fw) {
+	if (hdev->asic_prop.iatu_done_by_fw)
 		usleep_range(2000, 3000);
-		hdev->asic_funcs->set_dma_mask_from_fw(hdev);
-	}
 
-	rc = dma_set_mask_and_coherent(&pdev->dev,
-					DMA_BIT_MASK(hdev->dma_mask));
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(prop->dma_mask));
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to set dma mask to %d bits, error %d\n",
-			hdev->dma_mask, rc);
+			prop->dma_mask, rc);
 		goto unmap_pci_bars;
 	}
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 3cb461288533..f35fa7d7f918 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -674,6 +674,8 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 
 	prop->set_max_power_on_device_init = true;
 
+	prop->dma_mask = 48;
+
 	return 0;
 }
 
@@ -755,8 +757,6 @@ static int gaudi_init_iatu(struct hl_device *hdev)
 	if (rc)
 		goto done;
 
-	hdev->asic_funcs->set_dma_mask_from_fw(hdev);
-
 	/* Outbound Region 0 - Point to Host */
 	outbound_region.addr = HOST_PHYS_BASE;
 	outbound_region.size = HOST_PHYS_SIZE;
@@ -9065,11 +9065,6 @@ static void gaudi_reset_sob(struct hl_device *hdev, void *data)
 	kref_init(&hw_sob->kref);
 }
 
-static void gaudi_set_dma_mask_from_fw(struct hl_device *hdev)
-{
-	hdev->dma_mask = 48;
-}
-
 static u64 gaudi_get_device_time(struct hl_device *hdev)
 {
 	u64 device_time = ((u64) RREG32(mmPSOC_TIMESTAMP_CNTCVU)) << 32;
@@ -9474,7 +9469,6 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.gen_wait_cb = gaudi_gen_wait_cb,
 	.reset_sob = gaudi_reset_sob,
 	.reset_sob_group = gaudi_reset_sob_group,
-	.set_dma_mask_from_fw = gaudi_set_dma_mask_from_fw,
 	.get_device_time = gaudi_get_device_time,
 	.collective_wait_init_cs = gaudi_collective_wait_init_cs,
 	.collective_wait_create_jobs = gaudi_collective_wait_create_jobs,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 38af7014b845..8c165ba3a6cc 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -488,6 +488,8 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 
 	prop->set_max_power_on_device_init = true;
 
+	prop->dma_mask = 48;
+
 	return 0;
 }
 
@@ -575,8 +577,6 @@ static int goya_init_iatu(struct hl_device *hdev)
 	if (rc)
 		goto done;
 
-	hdev->asic_funcs->set_dma_mask_from_fw(hdev);
-
 	/* Outbound Region 0 - Point to Host  */
 	outbound_region.addr = HOST_PHYS_BASE;
 	outbound_region.size = HOST_PHYS_SIZE;
@@ -5562,11 +5562,6 @@ static void goya_reset_sob_group(struct hl_device *hdev, u16 sob_group)
 
 }
 
-static void goya_set_dma_mask_from_fw(struct hl_device *hdev)
-{
-	hdev->dma_mask = 48;
-}
-
 u64 goya_get_device_time(struct hl_device *hdev)
 {
 	u64 device_time = ((u64) RREG32(mmPSOC_TIMESTAMP_CNTCVU)) << 32;
@@ -5754,7 +5749,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.gen_wait_cb = goya_gen_wait_cb,
 	.reset_sob = goya_reset_sob,
 	.reset_sob_group = goya_reset_sob_group,
-	.set_dma_mask_from_fw = goya_set_dma_mask_from_fw,
 	.get_device_time = goya_get_device_time,
 	.collective_wait_init_cs = goya_collective_wait_init_cs,
 	.collective_wait_create_jobs = goya_collective_wait_create_jobs,
-- 
2.25.1

