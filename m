Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACB856D4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiGKGaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGKGaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2E695B3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21225611E0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DCCC34115;
        Mon, 11 Jul 2022 06:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657521011;
        bh=QJTLi8411aVXpB+pMG8RYZBgHCHone2O2BCCOD7IaaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGEaOqeQkCn4CMu5ESndBow0HiByXhu4OYot6xLZJfEklqxxP5j/3nEhy28IptNpJ
         uHW/DLjgBMMVWMzBHyYJbkac7uX5AeXhcRrzc1MH20yaE5wBZsgVRhn1uBpfFnrnh5
         df2eUBnMRMXF4TbQK46a1PnW2Hr5kYtdUygvpewbqI59B6bvfeg/vYEhjpQ7iM0ibQ
         wRfgojryLN5U0kCSX/0Gp62Z+hhFp6nUmT+brSIxti+6WC+WEM8bZXUd1jmpD78FzQ
         bmF4dcj9PR9sLfHts+PFCJcauz/nyGtprA3NWfSd2frjATXKsEjV5mBEzdp5ape6XP
         j4PToKNGNpw8A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 03/12] habanalabs/gaudi2: configure virtual MSI-X doorbell interface
Date:   Mon, 11 Jul 2022 09:29:54 +0300
Message-Id: <20220711063003.3182795-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711063003.3182795-1-ogabbay@kernel.org>
References: <20220711063003.3182795-1-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

Due to a watchdog timer in the LBW path, writes to the MSI-X doorbell
can return sporadic error responses.
To work-around this issue, a virtual MSI-X doorbell on the HBW path is
configured, using the MSI-X AXI slave interface in the PCIe controller.
Upon an access to a configured HBW host address, the controller will
generate MSI-X interrupt instead of treating the access as regular host
memory access.

This patch allocates the dedicate host memory page, and communicate the
address to F/W, so it will configure the relevant address match
registers in the controller, and will use this address to generate MSI-X
interrupts for F/W events.

Following patches will handle other initiators in the device, to move
them to use the virtual MSI-X doorbell.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c       | 23 ++++++++++++++++---
 drivers/misc/habanalabs/gaudi2/gaudi2P.h      |  5 ++++
 drivers/misc/habanalabs/gaudi2/gaudi2_masks.h |  3 +++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index d9a85ea56f75..539cb88a88e4 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -2673,9 +2673,11 @@ static void gaudi2_scrub_arcs_dccm(struct hl_device *hdev)
 
 static int gaudi2_late_init(struct hl_device *hdev)
 {
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 	int rc;
 
-	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS, 0x0);
+	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS,
+					gaudi2->virt_msix_db_dma_addr);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to enable PCI access from CPU\n");
 		return rc;
@@ -2922,6 +2924,7 @@ static inline int gaudi2_get_non_zero_random_int(void)
 
 static int gaudi2_sw_init(struct hl_device *hdev)
 {
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct gaudi2_device *gaudi2;
 	int i, rc;
 
@@ -2982,6 +2985,14 @@ static int gaudi2_sw_init(struct hl_device *hdev)
 		goto free_cpu_accessible_dma_pool;
 	}
 
+	gaudi2->virt_msix_db_cpu_addr = hl_cpu_accessible_dma_pool_alloc(hdev, prop->pmmu.page_size,
+								&gaudi2->virt_msix_db_dma_addr);
+	if (!gaudi2->virt_msix_db_cpu_addr) {
+		dev_err(hdev->dev, "Failed to allocate DMA memory for virtual MSI-X doorbell\n");
+		rc = -ENOMEM;
+		goto free_cpu_accessible_dma_pool;
+	}
+
 	spin_lock_init(&gaudi2->hw_queues_lock);
 	spin_lock_init(&gaudi2->kdma_lock);
 
@@ -2990,7 +3001,7 @@ static int gaudi2_sw_init(struct hl_device *hdev)
 							GFP_KERNEL | __GFP_ZERO);
 	if (!gaudi2->scratchpad_kernel_address) {
 		rc = -ENOMEM;
-		goto free_cpu_accessible_dma_pool;
+		goto free_virt_msix_db_mem;
 	}
 
 	gaudi2_user_mapped_blocks_init(hdev);
@@ -2999,15 +3010,18 @@ static int gaudi2_sw_init(struct hl_device *hdev)
 	gaudi2_user_interrupt_setup(hdev);
 
 	hdev->supports_coresight = true;
-	hdev->asic_prop.supports_soft_reset = true;
 	hdev->supports_sync_stream = true;
 	hdev->supports_cb_mapping = true;
 	hdev->supports_wait_for_multi_cs = false;
 
+	prop->supports_soft_reset = true;
+
 	hdev->asic_funcs->set_pci_memory_regions(hdev);
 
 	return 0;
 
+free_virt_msix_db_mem:
+	hl_cpu_accessible_dma_pool_free(hdev, prop->pmmu.page_size, gaudi2->virt_msix_db_cpu_addr);
 free_cpu_accessible_dma_pool:
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
 free_cpu_dma_mem:
@@ -3022,8 +3036,11 @@ static int gaudi2_sw_init(struct hl_device *hdev)
 
 static int gaudi2_sw_fini(struct hl_device *hdev)
 {
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 
+	hl_cpu_accessible_dma_pool_free(hdev, prop->pmmu.page_size, gaudi2->virt_msix_db_cpu_addr);
+
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
 
 	hl_asic_dma_free_coherent(hdev, HL_CPU_ACCESSIBLE_MEM_SIZE, hdev->cpu_accessible_dma_mem,
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2P.h b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
index dc0094a2a911..012413d7df9a 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2P.h
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
@@ -439,6 +439,8 @@ struct dup_block_ctx {
  *                             currently used for HBW QMAN writes which is
  *                             redundant.
  * @scratchpad_bus_address: scratchpad bus address
+ * @virt_msix_db_cpu_addr: host memory page for the virtual MSI-X doorbell.
+ * @virt_msix_db_dma_addr: bus address of the page for the virtual MSI-X doorbell.
  * @dram_bar_cur_addr: current address of DRAM PCI bar.
  * @hw_cap_initialized: This field contains a bit per H/W engine. When that
  *                      engine is initialized, that bit is set by the driver to
@@ -499,6 +501,9 @@ struct gaudi2_device {
 	void				*scratchpad_kernel_address;
 	dma_addr_t			scratchpad_bus_address;
 
+	void				*virt_msix_db_cpu_addr;
+	dma_addr_t			virt_msix_db_dma_addr;
+
 	u64				dram_bar_cur_addr;
 	u64				hw_cap_initialized;
 	u64				active_hw_arc;
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h b/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
index 19ec1f130bef..3fd5cf4a8645 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2_masks.h
@@ -132,4 +132,7 @@
 #define ROT_MSS_HALT_RSB_MASK	BIT(1)
 #define ROT_MSS_HALT_MRSB_MASK	BIT(2)
 
+#define PCIE_DBI_MSIX_ADDRESS_MATCH_LOW_OFF_MSIX_ADDRESS_MATCH_EN_SHIFT	0
+#define PCIE_DBI_MSIX_ADDRESS_MATCH_LOW_OFF_MSIX_ADDRESS_MATCH_EN_MASK	0x1
+
 #endif /* GAUDI2_MASKS_H_ */
-- 
2.25.1

