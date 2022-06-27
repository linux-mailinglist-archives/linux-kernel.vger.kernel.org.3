Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D3855C91C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbiF0U0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbiF0U0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:26:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42E21A80C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B885B81B2B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCF9C341CC;
        Mon, 27 Jun 2022 20:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361595;
        bh=ZJOgukKzIIWG1u+rOhY9IBwltUHizRwnj2gvl++eP5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BiIVhZ7E9SgjYjo8CRplzz3KEJNgQzm4oLyNGsmhLNtpcT48YEBUZLfRWxKoBpljV
         bQNFXVNvKTChNhNcpLGKD5610auQ9yuy/aHKLa44JV1hwTEwnWo7adol2SUMSE2vT8
         Vm1yxf+OiSzPQ1/JGpg3J3Vl8yqdh5rudRAsBnIXHBHFAzsoRiX4OrEfd4sQp1QJf5
         JbQRi+990FcPArv2Qge/AYzgNkTVFO5eVmd2x7n9MZwdJ/a/xGUcVhOuE9MpCi6aCX
         NhULPSOVo8jJSBQelGWkybVl1FuBXoq/17fDw0lt1nv6wBcYzgqTOX1qELpN+sI3Al
         pKYSZ15WHNrSA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 05/12] habanalabs: initialize new asic properties
Date:   Mon, 27 Jun 2022 23:26:13 +0300
Message-Id: <20220627202620.961350-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627202620.961350-1-ogabbay@kernel.org>
References: <20220627202620.961350-1-ogabbay@kernel.org>
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

New asic properties were added for Gaudi2. We want to initialize
and use them, when relevant, also for Goya and Gaudi.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/habanalabs_ioctl.c | 21 ++++++++++++-------
 drivers/misc/habanalabs/gaudi/gaudi.c         | 18 ++++++++++------
 drivers/misc/habanalabs/goya/goya.c           |  3 ++-
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 1d80e0b1e718..a7a00f8dab30 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -47,7 +47,7 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	u32 size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 sram_kmd_size, dram_kmd_size;
+	u64 sram_kmd_size, dram_kmd_size, dram_available_size;
 
 	if ((!size) || (!out))
 		return -EINVAL;
@@ -62,19 +62,22 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	hw_ip.dram_base_address =
 			hdev->mmu_enable && prop->dram_supports_virtual_memory ?
 			prop->dmmu.start_addr : prop->dram_user_base_address;
-	hw_ip.tpc_enabled_mask = prop->tpc_enabled_mask;
+	hw_ip.tpc_enabled_mask = prop->tpc_enabled_mask & 0xFF;
+	hw_ip.tpc_enabled_mask_ext = prop->tpc_enabled_mask;
+
 	hw_ip.sram_size = prop->sram_size - sram_kmd_size;
 
+	dram_available_size = prop->dram_size - dram_kmd_size;
+
 	if (hdev->mmu_enable)
-		hw_ip.dram_size =
-			DIV_ROUND_DOWN_ULL(prop->dram_size - dram_kmd_size,
-						prop->dram_page_size) *
-							prop->dram_page_size;
+		hw_ip.dram_size = DIV_ROUND_DOWN_ULL(dram_available_size,
+				prop->dram_page_size) * prop->dram_page_size;
 	else
-		hw_ip.dram_size = prop->dram_size - dram_kmd_size;
+		hw_ip.dram_size = dram_available_size;
 
 	if (hw_ip.dram_size > PAGE_SIZE)
 		hw_ip.dram_enabled = 1;
+
 	hw_ip.dram_page_size = prop->dram_page_size;
 	hw_ip.device_mem_alloc_default_page_size = prop->device_mem_alloc_default_page_size;
 	hw_ip.num_of_events = prop->num_of_events;
@@ -93,8 +96,12 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	hw_ip.psoc_pci_pll_od = prop->psoc_pci_pll_od;
 	hw_ip.psoc_pci_pll_div_factor = prop->psoc_pci_pll_div_factor;
 
+	hw_ip.decoder_enabled_mask = prop->decoder_enabled_mask;
+	hw_ip.mme_master_slave_mode = prop->mme_master_slave_mode;
 	hw_ip.first_available_interrupt_id = prop->first_available_user_interrupt;
 	hw_ip.number_of_user_interrupts = prop->user_interrupt_count;
+
+	hw_ip.edma_enabled_mask = prop->edma_enabled_mask;
 	hw_ip.server_type = prop->server_type;
 
 	return copy_to_user(out, &hw_ip,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f4581220ecd5..f3cda66e03e7 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -582,10 +582,13 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 						get_collective_mode(hdev, i);
 	}
 
+	prop->cache_line_size = DEVICE_CACHE_LINE_SIZE;
+	prop->cfg_base_address = CFG_BASE;
 	prop->device_dma_offset_for_host_access = HOST_PHYS_BASE;
 	prop->host_base_address = HOST_PHYS_BASE;
 	prop->host_end_address = prop->host_base_address + HOST_PHYS_SIZE;
 	prop->completion_queues_count = NUMBER_OF_CMPLT_QUEUES;
+	prop->completion_mode = HL_COMPLETION_MODE_JOB;
 	prop->collective_first_sob = 0;
 	prop->collective_first_mon = 0;
 
@@ -612,6 +615,9 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 	prop->sram_user_base_address =
 			prop->sram_base_address + SRAM_USER_BASE_OFFSET;
 
+	prop->mmu_cache_mng_addr = MMU_CACHE_MNG_ADDR;
+	prop->mmu_cache_mng_size = MMU_CACHE_MNG_SIZE;
+
 	prop->mmu_pgt_addr = MMU_PAGE_TABLES_ADDR;
 	if (hdev->pldm)
 		prop->mmu_pgt_size = 0x800000; /* 8MB */
@@ -3871,8 +3877,8 @@ static int gaudi_mmu_init(struct hl_device *hdev)
 	}
 
 	/* init MMU cache manage page */
-	WREG32(mmSTLB_CACHE_INV_BASE_39_8, MMU_CACHE_MNG_ADDR >> 8);
-	WREG32(mmSTLB_CACHE_INV_BASE_49_40, MMU_CACHE_MNG_ADDR >> 40);
+	WREG32(mmSTLB_CACHE_INV_BASE_39_8, prop->mmu_cache_mng_addr >> 8);
+	WREG32(mmSTLB_CACHE_INV_BASE_49_40, prop->mmu_cache_mng_addr >> 40);
 
 	/* mem cache invalidation */
 	WREG32(mmSTLB_MEM_CACHE_INVALIDATION, 1);
@@ -4763,7 +4769,7 @@ static void gaudi_dma_free_coherent(struct hl_device *hdev, size_t size,
 static int gaudi_scrub_device_dram(struct hl_device *hdev, u64 val)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64  cur_addr = DRAM_BASE_ADDR_USER;
+	u64 cur_addr = prop->dram_user_base_address;
 	u32 chunk_size, busy;
 	int rc, dma_id;
 
@@ -6068,10 +6074,10 @@ static int gaudi_context_switch(struct hl_device *hdev, u32 asid)
 
 static int gaudi_mmu_clear_pgt_range(struct hl_device *hdev)
 {
-	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u32 size = hdev->asic_prop.mmu_pgt_size +
+			hdev->asic_prop.mmu_cache_mng_size;
 	struct gaudi_device *gaudi = hdev->asic_specific;
-	u64 addr = prop->mmu_pgt_addr;
-	u32 size = prop->mmu_pgt_size + MMU_CACHE_MNG_SIZE;
+	u64 addr = hdev->asic_prop.mmu_pgt_addr;
 
 	if (!(gaudi->hw_cap_initialized & HW_CAP_MMU))
 		return 0;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 0e4dca5e4a5c..d83ceffd1dae 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -389,11 +389,12 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 		prop->hw_queues_props[i].cb_alloc_flags = CB_ALLOC_USER;
 	}
 
+	prop->cfg_base_address = CFG_BASE;
 	prop->device_dma_offset_for_host_access = HOST_PHYS_BASE;
 	prop->host_base_address = HOST_PHYS_BASE;
 	prop->host_end_address = prop->host_base_address + HOST_PHYS_SIZE;
 	prop->completion_queues_count = NUMBER_OF_CMPLT_QUEUES;
-
+	prop->completion_mode = HL_COMPLETION_MODE_JOB;
 	prop->dram_base_address = DRAM_PHYS_BASE;
 	prop->dram_size = DRAM_PHYS_DEFAULT_SIZE;
 	prop->dram_end_address = prop->dram_base_address + prop->dram_size;
-- 
2.25.1

