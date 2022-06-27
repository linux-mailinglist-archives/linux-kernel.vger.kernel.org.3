Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A2855D015
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbiF0U0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241192AbiF0U0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:26:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2F01A806
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFEBAB81135
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6221C34115;
        Mon, 27 Jun 2022 20:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361594;
        bh=3szgtWJXP6aWRedfVtdC223qE9GjJkj+3Mo78ib0aZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZI1MFluTho//OCxiGIzLr9jYHNcpcFODmN9QdVziweQMBhAuLvwBA72sdXXda0L+B
         +QKqGrAUCyM06K2MNQtb8hIfWDgDNT1Y94UpQPH+BTLeT4hPkmNUMHD35GtxA1s7jh
         eIivzSI2MNIV87oL09jPWtS2u8grond5WYUaYTsYQzIbSLL8NKTliKdBkL6GRWelDv
         TQ597XOQbdHGX54H9b7iZ5JVlR+a69ae4DRQ6CeQGWp2+SdhUK7Jgaejdmu9DxEtuJ
         8soMmyh4b5zkVCutbBxclG5u7/hWvc5cSNt3wfbGeXJvHDM4X1P64K2L2ufZHfPYGS
         iJKY3FK8gCkyw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 04/12] habanalabs: add unsupported functions
Date:   Mon, 27 Jun 2022 23:26:12 +0300
Message-Id: <20220627202620.961350-5-ogabbay@kernel.org>
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

There are a number of new ASIC-specific functions that were added
for Gaudi2. To make the common code work, we need to define empty
implementations of those functions for Goya and Gaudi.

Some functions will return error if called with Goya/Gaudi.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 24 ++++++++++++++++++++++++
 drivers/misc/habanalabs/goya/goya.c   | 24 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ae894335e9f8..f4581220ecd5 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8588,6 +8588,11 @@ static void gaudi_ctx_fini(struct hl_ctx *ctx)
 	gaudi_internal_cb_pool_fini(ctx->hdev, ctx);
 }
 
+int gaudi_pre_schedule_cs(struct hl_cs *cs)
+{
+	return 0;
+}
+
 static u32 gaudi_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
 {
 	return gaudi_cq_assignment[cq_idx];
@@ -8959,6 +8964,14 @@ static void gaudi_enable_events_from_fw(struct hl_device *hdev)
 		gaudi_irq_map_table[GAUDI_EVENT_INTS_REGISTER].cpu_id);
 }
 
+int gaudi_ack_mmu_page_fault_or_access_error(struct hl_device *hdev,
+							u64 mmu_cap_mask)
+{
+	dev_err(hdev->dev, "mmu_error function is not supported\n");
+
+	return -EINVAL;
+}
+
 static int gaudi_map_pll_idx_to_fw_idx(u32 pll_idx)
 {
 	switch (pll_idx) {
@@ -9233,6 +9246,10 @@ static u32 *gaudi_get_stream_master_qid_arr(void)
 	return gaudi_stream_master;
 }
 
+static void gaudi_check_if_razwi_happened(struct hl_device *hdev)
+{
+}
+
 static ssize_t infineon_ver_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
@@ -9304,6 +9321,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.non_hard_reset_late_init = gaudi_non_hard_reset_late_init,
 	.hw_queues_lock = gaudi_hw_queues_lock,
 	.hw_queues_unlock = gaudi_hw_queues_unlock,
+	.kdma_lock = NULL,
+	.kdma_unlock = NULL,
 	.get_pci_id = gaudi_get_pci_id,
 	.get_eeprom_data = gaudi_get_eeprom_data,
 	.get_monitor_dump = gaudi_get_monitor_dump,
@@ -9315,6 +9334,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.halt_coresight = gaudi_halt_coresight,
 	.ctx_init = gaudi_ctx_init,
 	.ctx_fini = gaudi_ctx_fini,
+	.pre_schedule_cs = gaudi_pre_schedule_cs,
 	.get_queue_id_for_cq = gaudi_get_queue_id_for_cq,
 	.load_firmware_to_device = gaudi_load_firmware_to_device,
 	.load_boot_fit_to_device = gaudi_load_boot_fit_to_device,
@@ -9325,14 +9345,17 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.reset_sob = gaudi_reset_sob,
 	.reset_sob_group = gaudi_reset_sob_group,
 	.get_device_time = gaudi_get_device_time,
+	.pb_print_security_errors = NULL,
 	.collective_wait_init_cs = gaudi_collective_wait_init_cs,
 	.collective_wait_create_jobs = gaudi_collective_wait_create_jobs,
+	.get_dec_base_addr = NULL,
 	.scramble_addr = hl_mmu_scramble_addr,
 	.descramble_addr = hl_mmu_descramble_addr,
 	.ack_protection_bits_errors = gaudi_ack_protection_bits_errors,
 	.get_hw_block_id = gaudi_get_hw_block_id,
 	.hw_block_mmap = gaudi_block_mmap,
 	.enable_events_from_fw = gaudi_enable_events_from_fw,
+	.ack_mmu_errors = gaudi_ack_mmu_page_fault_or_access_error,
 	.map_pll_idx_to_fw_idx = gaudi_map_pll_idx_to_fw_idx,
 	.init_firmware_loader = gaudi_init_firmware_loader,
 	.init_cpu_scrambler_dram = gaudi_init_scrambler_hbm,
@@ -9340,6 +9363,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.get_sob_addr = gaudi_get_sob_addr,
 	.set_pci_memory_regions = gaudi_set_pci_memory_regions,
 	.get_stream_master_qid_arr = gaudi_get_stream_master_qid_arr,
+	.check_if_razwi_happened = gaudi_check_if_razwi_happened,
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
 	.access_dev_mem = hl_access_dev_mem,
 	.set_dram_bar_base = gaudi_set_hbm_bar_base,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index df6ed2a3cca7..0e4dca5e4a5c 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5253,6 +5253,11 @@ static int goya_ctx_init(struct hl_ctx *ctx)
 	return 0;
 }
 
+int goya_pre_schedule_cs(struct hl_cs *cs)
+{
+	return 0;
+}
+
 u32 goya_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
 {
 	return cq_idx;
@@ -5332,6 +5337,14 @@ static void goya_enable_events_from_fw(struct hl_device *hdev)
 			GOYA_ASYNC_EVENT_ID_INTS_REGISTER);
 }
 
+int goya_ack_mmu_page_fault_or_access_error(struct hl_device *hdev,
+							u64 mmu_cap_mask)
+{
+	dev_err(hdev->dev, "mmu_error function is not supported\n");
+
+	return -EINVAL;
+}
+
 static int goya_map_pll_idx_to_fw_idx(u32 pll_idx)
 {
 	switch (pll_idx) {
@@ -5407,6 +5420,10 @@ static int goya_get_monitor_dump(struct hl_device *hdev, void *data)
 	return -EOPNOTSUPP;
 }
 
+static void goya_check_if_razwi_happened(struct hl_device *hdev)
+{
+}
+
 static int goya_scrub_device_dram(struct hl_device *hdev, u64 val)
 {
 	return -EOPNOTSUPP;
@@ -5459,6 +5476,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.non_hard_reset_late_init = goya_non_hard_reset_late_init,
 	.hw_queues_lock = goya_hw_queues_lock,
 	.hw_queues_unlock = goya_hw_queues_unlock,
+	.kdma_lock = NULL,
+	.kdma_unlock = NULL,
 	.get_pci_id = goya_get_pci_id,
 	.get_eeprom_data = goya_get_eeprom_data,
 	.get_monitor_dump = goya_get_monitor_dump,
@@ -5470,6 +5489,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.halt_coresight = goya_halt_coresight,
 	.ctx_init = goya_ctx_init,
 	.ctx_fini = goya_ctx_fini,
+	.pre_schedule_cs = goya_pre_schedule_cs,
 	.get_queue_id_for_cq = goya_get_queue_id_for_cq,
 	.load_firmware_to_device = goya_load_firmware_to_device,
 	.load_boot_fit_to_device = goya_load_boot_fit_to_device,
@@ -5480,14 +5500,17 @@ static const struct hl_asic_funcs goya_funcs = {
 	.reset_sob = goya_reset_sob,
 	.reset_sob_group = goya_reset_sob_group,
 	.get_device_time = goya_get_device_time,
+	.pb_print_security_errors = NULL,
 	.collective_wait_init_cs = goya_collective_wait_init_cs,
 	.collective_wait_create_jobs = goya_collective_wait_create_jobs,
+	.get_dec_base_addr = NULL,
 	.scramble_addr = hl_mmu_scramble_addr,
 	.descramble_addr = hl_mmu_descramble_addr,
 	.ack_protection_bits_errors = goya_ack_protection_bits_errors,
 	.get_hw_block_id = goya_get_hw_block_id,
 	.hw_block_mmap = goya_block_mmap,
 	.enable_events_from_fw = goya_enable_events_from_fw,
+	.ack_mmu_errors = goya_ack_mmu_page_fault_or_access_error,
 	.map_pll_idx_to_fw_idx = goya_map_pll_idx_to_fw_idx,
 	.init_firmware_loader = goya_init_firmware_loader,
 	.init_cpu_scrambler_dram = goya_cpu_init_scrambler_dram,
@@ -5495,6 +5518,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_sob_addr = &goya_get_sob_addr,
 	.set_pci_memory_regions = goya_set_pci_memory_regions,
 	.get_stream_master_qid_arr = goya_get_stream_master_qid_arr,
+	.check_if_razwi_happened = goya_check_if_razwi_happened,
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
 	.access_dev_mem = hl_access_dev_mem,
 	.set_dram_bar_base = goya_set_ddr_bar_base,
-- 
2.25.1

