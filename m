Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795BB55DECE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345183AbiF1LAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345151AbiF1LAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:00:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05682F3AF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25770B81DC6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A61C341CD;
        Tue, 28 Jun 2022 11:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656414012;
        bh=RNCafOcNlujwcAu4BUYXbKSTeqTfvDOp5pyo+5423cU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jl+0HTTaKwWnvXshwmvrq46fV0WVRZdFtTvKf4ugXd5L/PXCcUFrmIHL65AAJHh+3
         +lh6MNx0u7Q/pd4GvYu7FKCJ6PvI1bHbtKOqaFMyUPKniSLlpUQbm0EMmdrsXmzhh8
         TVGrrEh0gN1450FQkUIXihHoBoY/O6u2A5PpBrmszoh8+9peQtHPiiTTDzJZ2mOn3p
         9gEMXbwvzZ6H0Jxmx9hxPEOZXAyslpEswdZRJZR4/AB03f8taTnuCqm+KDA6J2EAK+
         Gdt6HtGQlbWY5phzhynbhtqbxwYMbQDUGnjB82YZrqdfGRUghnqguyOkpI1u9Udt/a
         +0SxnJXlSunWQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH v2 04/12] habanalabs: add unsupported functions
Date:   Tue, 28 Jun 2022 13:59:50 +0300
Message-Id: <20220628105958.1254875-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628105958.1254875-1-ogabbay@kernel.org>
References: <20220628105958.1254875-1-ogabbay@kernel.org>
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
Changes in v2:
 - Set some functions to be static
 - Remove unnecessary error print

 drivers/misc/habanalabs/gaudi/gaudi.c | 21 +++++++++++++++++++++
 drivers/misc/habanalabs/goya/goya.c   | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ae894335e9f8..749f79405ba0 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8588,6 +8588,11 @@ static void gaudi_ctx_fini(struct hl_ctx *ctx)
 	gaudi_internal_cb_pool_fini(ctx->hdev, ctx);
 }
 
+static int gaudi_pre_schedule_cs(struct hl_cs *cs)
+{
+	return 0;
+}
+
 static u32 gaudi_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
 {
 	return gaudi_cq_assignment[cq_idx];
@@ -8959,6 +8964,11 @@ static void gaudi_enable_events_from_fw(struct hl_device *hdev)
 		gaudi_irq_map_table[GAUDI_EVENT_INTS_REGISTER].cpu_id);
 }
 
+static int gaudi_ack_mmu_page_fault_or_access_error(struct hl_device *hdev, u64 mmu_cap_mask)
+{
+	return -EINVAL;
+}
+
 static int gaudi_map_pll_idx_to_fw_idx(u32 pll_idx)
 {
 	switch (pll_idx) {
@@ -9233,6 +9243,10 @@ static u32 *gaudi_get_stream_master_qid_arr(void)
 	return gaudi_stream_master;
 }
 
+static void gaudi_check_if_razwi_happened(struct hl_device *hdev)
+{
+}
+
 static ssize_t infineon_ver_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
@@ -9304,6 +9318,8 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.non_hard_reset_late_init = gaudi_non_hard_reset_late_init,
 	.hw_queues_lock = gaudi_hw_queues_lock,
 	.hw_queues_unlock = gaudi_hw_queues_unlock,
+	.kdma_lock = NULL,
+	.kdma_unlock = NULL,
 	.get_pci_id = gaudi_get_pci_id,
 	.get_eeprom_data = gaudi_get_eeprom_data,
 	.get_monitor_dump = gaudi_get_monitor_dump,
@@ -9315,6 +9331,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.halt_coresight = gaudi_halt_coresight,
 	.ctx_init = gaudi_ctx_init,
 	.ctx_fini = gaudi_ctx_fini,
+	.pre_schedule_cs = gaudi_pre_schedule_cs,
 	.get_queue_id_for_cq = gaudi_get_queue_id_for_cq,
 	.load_firmware_to_device = gaudi_load_firmware_to_device,
 	.load_boot_fit_to_device = gaudi_load_boot_fit_to_device,
@@ -9325,14 +9342,17 @@ static const struct hl_asic_funcs gaudi_funcs = {
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
@@ -9340,6 +9360,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.get_sob_addr = gaudi_get_sob_addr,
 	.set_pci_memory_regions = gaudi_set_pci_memory_regions,
 	.get_stream_master_qid_arr = gaudi_get_stream_master_qid_arr,
+	.check_if_razwi_happened = gaudi_check_if_razwi_happened,
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
 	.access_dev_mem = hl_access_dev_mem,
 	.set_dram_bar_base = gaudi_set_hbm_bar_base,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index df6ed2a3cca7..3fa5ac909648 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5253,6 +5253,11 @@ static int goya_ctx_init(struct hl_ctx *ctx)
 	return 0;
 }
 
+static int goya_pre_schedule_cs(struct hl_cs *cs)
+{
+	return 0;
+}
+
 u32 goya_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
 {
 	return cq_idx;
@@ -5332,6 +5337,11 @@ static void goya_enable_events_from_fw(struct hl_device *hdev)
 			GOYA_ASYNC_EVENT_ID_INTS_REGISTER);
 }
 
+static int goya_ack_mmu_page_fault_or_access_error(struct hl_device *hdev, u64 mmu_cap_mask)
+{
+	return -EINVAL;
+}
+
 static int goya_map_pll_idx_to_fw_idx(u32 pll_idx)
 {
 	switch (pll_idx) {
@@ -5407,6 +5417,10 @@ static int goya_get_monitor_dump(struct hl_device *hdev, void *data)
 	return -EOPNOTSUPP;
 }
 
+static void goya_check_if_razwi_happened(struct hl_device *hdev)
+{
+}
+
 static int goya_scrub_device_dram(struct hl_device *hdev, u64 val)
 {
 	return -EOPNOTSUPP;
@@ -5459,6 +5473,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.non_hard_reset_late_init = goya_non_hard_reset_late_init,
 	.hw_queues_lock = goya_hw_queues_lock,
 	.hw_queues_unlock = goya_hw_queues_unlock,
+	.kdma_lock = NULL,
+	.kdma_unlock = NULL,
 	.get_pci_id = goya_get_pci_id,
 	.get_eeprom_data = goya_get_eeprom_data,
 	.get_monitor_dump = goya_get_monitor_dump,
@@ -5470,6 +5486,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.halt_coresight = goya_halt_coresight,
 	.ctx_init = goya_ctx_init,
 	.ctx_fini = goya_ctx_fini,
+	.pre_schedule_cs = goya_pre_schedule_cs,
 	.get_queue_id_for_cq = goya_get_queue_id_for_cq,
 	.load_firmware_to_device = goya_load_firmware_to_device,
 	.load_boot_fit_to_device = goya_load_boot_fit_to_device,
@@ -5480,14 +5497,17 @@ static const struct hl_asic_funcs goya_funcs = {
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
@@ -5495,6 +5515,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_sob_addr = &goya_get_sob_addr,
 	.set_pci_memory_regions = goya_set_pci_memory_regions,
 	.get_stream_master_qid_arr = goya_get_stream_master_qid_arr,
+	.check_if_razwi_happened = goya_check_if_razwi_happened,
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
 	.access_dev_mem = hl_access_dev_mem,
 	.set_dram_bar_base = goya_set_ddr_bar_base,
-- 
2.25.1

