Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ECE574555
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 08:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbiGNGxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 02:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiGNGw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 02:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F152873E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 23:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEA346189B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E5CC34115;
        Thu, 14 Jul 2022 06:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657781576;
        bh=61Pui0GZtW5hgnzRnZC81LTe8RH+t47rY/TDFUyH2g0=;
        h=From:To:Cc:Subject:Date:From;
        b=JArM1FF3ObVhI/4C28lQQ9k1T2XJleQugxlIU8tKyu/aPsetamnWurQh7IRRgLKLw
         qGdBDp1+jbSdBnG6RQHEuBIX4jTisjek7KQHT6EeZt9LYnODQT38HvXZh2ijJwJwm/
         mOJXMRYDFBOc5xjUt1I9MWrEkSQ0HPLKQB+IrFZRui5nWTvOBGYRjgE93bIP9znh+J
         udQ7MHZ7WlZooc/ArfEaKX0OSItEVjFEi/+5BA3HIlkNrgA2fTxBWp5roJ/Cd+NGmx
         H7xxKZ3w5GNCeG2igcON0U65yH6Aa7BQ0SIY+rnqN8D7spWHQmmKftqTrnodXn/D9c
         mqt5lJHQUeMnA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH] habanalabs: removed seq_file parameter from is_idle asic functions
Date:   Thu, 14 Jul 2022 09:52:50 +0300
Message-Id: <20220714065250.3451780-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
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

From: Dani Liberman <dliberman@habana.ai>

Change is_idle functions so it would be more usable outside debugfs.

Do this by replacing seq_file parameter with regular string.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    | 47 +++++++++-
 drivers/misc/habanalabs/common/habanalabs.h | 17 +++-
 drivers/misc/habanalabs/gaudi/gaudi.c       | 47 +++++-----
 drivers/misc/habanalabs/gaudi2/gaudi2.c     | 97 +++++++++++----------
 drivers/misc/habanalabs/goya/goya.c         | 32 +++----
 5 files changed, 151 insertions(+), 89 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 64439f33a19b..90c91c1b2c10 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -17,6 +17,7 @@
 #define MMU_ASID_BUF_SIZE	10
 #define MMU_KBUF_SIZE		(MMU_ADDR_BUF_SIZE + MMU_ASID_BUF_SIZE)
 #define I2C_MAX_TRANSACTION_LEN	8
+#define ENGINES_DATA_MAX_SIZE	SZ_16K
 
 static struct dentry *hl_debug_root;
 
@@ -586,11 +587,37 @@ static ssize_t mmu_ack_error_value_write(struct file *file,
 	return -EINVAL;
 }
 
+void hl_engine_data_sprintf(struct engines_data *e, const char *fmt, ...)
+{
+	va_list args;
+	int str_size;
+
+	va_start(args, fmt);
+	/* Calculate formatted string length. Assuming each string is null terminated, hence
+	 * increment result by 1
+	 */
+	str_size = vsnprintf(NULL, 0, fmt, args) + 1;
+	va_end(args);
+
+	if ((e->actual_size + str_size) < e->allocated_buf_size) {
+		va_start(args, fmt);
+		vsnprintf(e->buf + e->actual_size, str_size, fmt, args);
+		va_end(args);
+	}
+
+	/* Need to update the size even when not updating destination buffer to get the exact size
+	 * of all input strings
+	 */
+	e->actual_size += str_size;
+
+}
+
 static int engines_show(struct seq_file *s, void *data)
 {
 	struct hl_debugfs_entry *entry = s->private;
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
 	struct hl_device *hdev = dev_entry->hdev;
+	struct engines_data eng_data;
 
 	if (hdev->reset_info.in_reset) {
 		dev_warn_ratelimited(hdev->dev,
@@ -598,7 +625,25 @@ static int engines_show(struct seq_file *s, void *data)
 		return 0;
 	}
 
-	hdev->asic_funcs->is_device_idle(hdev, NULL, 0, s);
+	eng_data.actual_size = 0;
+	eng_data.allocated_buf_size = ENGINES_DATA_MAX_SIZE;
+	eng_data.buf = vmalloc(eng_data.allocated_buf_size);
+	if (!eng_data.buf)
+		return -ENOMEM;
+
+	hdev->asic_funcs->is_device_idle(hdev, NULL, 0, &eng_data);
+
+	if (eng_data.actual_size > eng_data.allocated_buf_size) {
+		dev_err(hdev->dev,
+				"Engines data size (%d Bytes) is bigger than allocated size (%u Bytes)\n",
+				eng_data.actual_size, eng_data.allocated_buf_size);
+		vfree(eng_data.buf);
+		return -ENOMEM;
+	}
+
+	seq_write(s, eng_data.buf, eng_data.actual_size);
+
+	vfree(eng_data.buf);
 
 	return 0;
 }
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index d59bba9e55c9..4d6b31ea1efb 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1371,6 +1371,18 @@ struct fw_load_mgr {
 
 struct hl_cs;
 
+/**
+ * struct engines_data - asic engines data
+ * @buf: buffer for engines data in ascii
+ * @actual_size: actual size of data that was written by the driver to the allocated buffer
+ * @allocated_buf_size: total size of allocated buffer
+ */
+struct engines_data {
+	char *buf;
+	int actual_size;
+	u32 allocated_buf_size;
+};
+
 /**
  * struct hl_asic_funcs - ASIC specific functions that are can be called from
  *                        common code.
@@ -1570,8 +1582,8 @@ struct hl_asic_funcs {
 	int (*mmu_prefetch_cache_range)(struct hl_ctx *ctx, u32 flags, u32 asid, u64 va, u64 size);
 	int (*send_heartbeat)(struct hl_device *hdev);
 	int (*debug_coresight)(struct hl_device *hdev, struct hl_ctx *ctx, void *data);
-	bool (*is_device_idle)(struct hl_device *hdev, u64 *mask_arr,
-					u8 mask_len, struct seq_file *s);
+	bool (*is_device_idle)(struct hl_device *hdev, u64 *mask_arr, u8 mask_len,
+				struct engines_data *e);
 	int (*non_hard_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
@@ -3743,6 +3755,7 @@ struct hl_mmap_mem_buf *
 hl_mmap_mem_buf_alloc(struct hl_mem_mgr *mmg,
 		      struct hl_mmap_mem_buf_behavior *behavior, gfp_t gfp,
 		      void *args);
+void hl_engine_data_sprintf(struct engines_data *e, const char *fmt, ...);
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index cb2988e2c7a8..a3eca13c3fa9 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8066,8 +8066,8 @@ static int gaudi_cpucp_info_get(struct hl_device *hdev)
 	return 0;
 }
 
-static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
-					u8 mask_len, struct seq_file *s)
+static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr, u8 mask_len,
+		struct engines_data *e)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	const char *fmt = "%-5d%-9s%#-14x%#-12x%#x\n";
@@ -8079,8 +8079,8 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 	u64 offset;
 	int i, dma_id, port;
 
-	if (s)
-		seq_puts(s,
+	if (e)
+		hl_engine_data_sprintf(e,
 			"\nDMA  is_idle  QM_GLBL_STS0  QM_CGM_STS  DMA_CORE_STS0\n"
 			"---  -------  ------------  ----------  -------------\n");
 
@@ -8097,14 +8097,14 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 
 		if (mask && !is_eng_idle)
 			set_bit(GAUDI_ENGINE_ID_DMA_0 + dma_id, mask);
-		if (s)
-			seq_printf(s, fmt, dma_id,
+		if (e)
+			hl_engine_data_sprintf(e, fmt, dma_id,
 				is_eng_idle ? "Y" : "N", qm_glbl_sts0,
 				qm_cgm_sts, dma_core_sts0);
 	}
 
-	if (s)
-		seq_puts(s,
+	if (e)
+		hl_engine_data_sprintf(e,
 			"\nTPC  is_idle  QM_GLBL_STS0  QM_CGM_STS  CFG_STATUS\n"
 			"---  -------  ------------  ----------  ----------\n");
 
@@ -8119,14 +8119,14 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 
 		if (mask && !is_eng_idle)
 			set_bit(GAUDI_ENGINE_ID_TPC_0 + i, mask);
-		if (s)
-			seq_printf(s, fmt, i,
+		if (e)
+			hl_engine_data_sprintf(e, fmt, i,
 				is_eng_idle ? "Y" : "N",
 				qm_glbl_sts0, qm_cgm_sts, tpc_cfg_sts);
 	}
 
-	if (s)
-		seq_puts(s,
+	if (e)
+		hl_engine_data_sprintf(e,
 			"\nMME  is_idle  QM_GLBL_STS0  QM_CGM_STS  ARCH_STATUS\n"
 			"---  -------  ------------  ----------  -----------\n");
 
@@ -8147,20 +8147,21 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 
 		if (mask && !is_eng_idle)
 			set_bit(GAUDI_ENGINE_ID_MME_0 + i, mask);
-		if (s) {
+		if (e) {
 			if (!is_slave)
-				seq_printf(s, fmt, i,
+				hl_engine_data_sprintf(e, fmt, i,
 					is_eng_idle ? "Y" : "N",
 					qm_glbl_sts0, qm_cgm_sts, mme_arch_sts);
 			else
-				seq_printf(s, mme_slave_fmt, i,
+				hl_engine_data_sprintf(e, mme_slave_fmt, i,
 					is_eng_idle ? "Y" : "N", "-",
 					"-", mme_arch_sts);
 		}
 	}
 
-	if (s)
-		seq_puts(s, "\nNIC  is_idle  QM_GLBL_STS0  QM_CGM_STS\n"
+	if (e)
+		hl_engine_data_sprintf(e,
+				"\nNIC  is_idle  QM_GLBL_STS0  QM_CGM_STS\n"
 				"---  -------  ------------  ----------\n");
 
 	for (i = 0 ; i < (NIC_NUMBER_OF_ENGINES / 2) ; i++) {
@@ -8174,8 +8175,8 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 
 			if (mask && !is_eng_idle)
 				set_bit(GAUDI_ENGINE_ID_NIC_0 + port, mask);
-			if (s)
-				seq_printf(s, nic_fmt, port,
+			if (e)
+				hl_engine_data_sprintf(e, nic_fmt, port,
 						is_eng_idle ? "Y" : "N",
 						qm_glbl_sts0, qm_cgm_sts);
 		}
@@ -8189,15 +8190,15 @@ static bool gaudi_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 
 			if (mask && !is_eng_idle)
 				set_bit(GAUDI_ENGINE_ID_NIC_0 + port, mask);
-			if (s)
-				seq_printf(s, nic_fmt, port,
+			if (e)
+				hl_engine_data_sprintf(e, nic_fmt, port,
 						is_eng_idle ? "Y" : "N",
 						qm_glbl_sts0, qm_cgm_sts);
 		}
 	}
 
-	if (s)
-		seq_puts(s, "\n");
+	if (e)
+		hl_engine_data_sprintf(e, "\n");
 
 	return is_idle;
 }
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 98336a1a84b0..1140cf7db4a3 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -1663,7 +1663,7 @@ struct gaudi2_cache_invld_params {
 };
 
 struct gaudi2_tpc_idle_data {
-	struct seq_file *s;
+	struct engines_data *e;
 	unsigned long *mask;
 	bool *is_idle;
 	const char *tpc_fmt;
@@ -6172,14 +6172,15 @@ static void gaudi2_is_tpc_engine_idle(struct hl_device *hdev, int dcore, int ins
 	if (idle_data->mask && !is_eng_idle)
 		set_bit(engine_idx, idle_data->mask);
 
-	if (idle_data->s)
-		seq_printf(idle_data->s, idle_data->tpc_fmt, dcore, inst,
+	if (idle_data->e)
+		hl_engine_data_sprintf(idle_data->e,
+					idle_data->tpc_fmt, dcore, inst,
 					is_eng_idle ? "Y" : "N",
 					qm_glbl_sts0, qm_cgm_sts, tpc_cfg_sts);
 }
 
-static bool gaudi2_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
-					u8 mask_len, struct seq_file *s)
+static bool gaudi2_is_device_idle(struct hl_device *hdev, u64 *mask_arr, u8 mask_len,
+					struct engines_data *e)
 {
 	u32 qm_glbl_sts0, qm_glbl_sts1, qm_cgm_sts, dma_core_idle_ind_mask,
 		mme_arch_sts, dec_swreg15, dec_enabled_bit;
@@ -6197,7 +6198,7 @@ static bool gaudi2_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 
 	struct gaudi2_tpc_idle_data tpc_idle_data = {
 		.tpc_fmt = "%-6d%-5d%-9s%#-14x%#-12x%#x\n",
-		.s = s,
+		.e = e,
 		.mask = mask,
 		.is_idle = &is_idle,
 	};
@@ -6209,8 +6210,8 @@ static bool gaudi2_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 	int engine_idx, i, j;
 
 	/* EDMA, Two engines per Dcore */
-	if (s)
-		seq_puts(s,
+	if (e)
+		hl_engine_data_sprintf(e,
 			"\nCORE  EDMA  is_idle  QM_GLBL_STS0  DMA_CORE_IDLE_IND_MASK\n"
 			"----  ----  -------  ------------  ----------------------\n");
 
@@ -6239,19 +6240,19 @@ static bool gaudi2_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 			if (mask && !is_eng_idle)
 				set_bit(engine_idx, mask);
 
-			if (s)
-				seq_printf(s, edma_fmt, i, j,
-						is_eng_idle ? "Y" : "N",
-						qm_glbl_sts0,
-						dma_core_idle_ind_mask);
+			if (e)
+				hl_engine_data_sprintf(e, edma_fmt, i, j,
+							is_eng_idle ? "Y" : "N",
+							qm_glbl_sts0,
+							dma_core_idle_ind_mask);
 		}
 	}
 
 	/* PDMA, Two engines in Full chip */
-	if (s)
-		seq_puts(s,
-			"\nPDMA  is_idle  QM_GLBL_STS0  DMA_CORE_IDLE_IND_MASK\n"
-			"----  -------  ------------  ----------------------\n");
+	if (e)
+		hl_engine_data_sprintf(e,
+					"\nPDMA  is_idle  QM_GLBL_STS0  DMA_CORE_IDLE_IND_MASK\n"
+					"----  -------  ------------  ----------------------\n");
 
 	for (i = 0 ; i < NUM_OF_PDMA ; i++) {
 		engine_idx = GAUDI2_ENGINE_ID_PDMA_0 + i;
@@ -6269,16 +6270,16 @@ static bool gaudi2_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 		if (mask && !is_eng_idle)
 			set_bit(engine_idx, mask);
 
-		if (s)
-			seq_printf(s, pdma_fmt, i, is_eng_idle ? "Y" : "N", qm_glbl_sts0,
-					dma_core_idle_ind_mask);
+		if (e)
+			hl_engine_data_sprintf(e, pdma_fmt, i, is_eng_idle ? "Y" : "N",
+						qm_glbl_sts0, dma_core_idle_ind_mask);
 	}
 
 	/* NIC, twelve macros in Full chip */
-	if (s && hdev->nic_ports_mask)
-		seq_puts(s,
-			"\nNIC  is_idle  QM_GLBL_STS0  QM_CGM_STS\n"
-			"---  -------  ------------  ----------\n");
+	if (e && hdev->nic_ports_mask)
+		hl_engine_data_sprintf(e,
+					"\nNIC  is_idle  QM_GLBL_STS0  QM_CGM_STS\n"
+					"---  -------  ------------  ----------\n");
 
 	for (i = 0 ; i < NIC_NUMBER_OF_ENGINES ; i++) {
 		if (!(i & 1))
@@ -6302,15 +6303,15 @@ static bool gaudi2_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 		if (mask && !is_eng_idle)
 			set_bit(engine_idx, mask);
 
-		if (s)
-			seq_printf(s, nic_fmt, i, is_eng_idle ? "Y" : "N", qm_glbl_sts0,
-					qm_cgm_sts);
+		if (e)
+			hl_engine_data_sprintf(e, nic_fmt, i, is_eng_idle ? "Y" : "N",
+						qm_glbl_sts0, qm_cgm_sts);
 	}
 
-	if (s)
-		seq_puts(s,
-			"\nMME  Stub  is_idle  QM_GLBL_STS0  MME_ARCH_STATUS\n"
-			"---  ----  -------  ------------  ---------------\n");
+	if (e)
+		hl_engine_data_sprintf(e,
+					"\nMME  Stub  is_idle  QM_GLBL_STS0  MME_ARCH_STATUS\n"
+					"---  ----  -------  ------------  ---------------\n");
 	/* MME, one per Dcore */
 	for (i = 0 ; i < NUM_OF_DCORES ; i++) {
 		engine_idx = GAUDI2_DCORE0_ENGINE_ID_MME + i * GAUDI2_ENGINE_ID_DCORE_OFFSET;
@@ -6327,8 +6328,8 @@ static bool gaudi2_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 		is_eng_idle &= IS_MME_IDLE(mme_arch_sts);
 		is_idle &= is_eng_idle;
 
-		if (s)
-			seq_printf(s, mme_fmt, i, "N",
+		if (e)
+			hl_engine_data_sprintf(e, mme_fmt, i, "N",
 				is_eng_idle ? "Y" : "N",
 				qm_glbl_sts0,
 				mme_arch_sts);
@@ -6340,16 +6341,16 @@ static bool gaudi2_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 	/*
 	 * TPC
 	 */
-	if (s && prop->tpc_enabled_mask)
-		seq_puts(s,
+	if (e && prop->tpc_enabled_mask)
+		hl_engine_data_sprintf(e,
 			"\nCORE  TPC   is_idle  QM_GLBL_STS0  QM_CGM_STS  DMA_CORE_IDLE_IND_MASK\n"
 			"----  ---  --------  ------------  ----------  ----------------------\n");
 
 	gaudi2_iterate_tpcs(hdev, &tpc_iter);
 
 	/* Decoders, two each Dcore and two shared PCIe decoders */
-	if (s && (prop->decoder_enabled_mask & (~PCIE_DEC_EN_MASK)))
-		seq_puts(s,
+	if (e && (prop->decoder_enabled_mask & (~PCIE_DEC_EN_MASK)))
+		hl_engine_data_sprintf(e,
 			"\nCORE  DEC  is_idle  VSI_CMD_SWREG15\n"
 			"----  ---  -------  ---------------\n");
 
@@ -6370,13 +6371,14 @@ static bool gaudi2_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 			if (mask && !is_eng_idle)
 				set_bit(engine_idx, mask);
 
-			if (s)
-				seq_printf(s, dec_fmt, i, j, is_eng_idle ? "Y" : "N", dec_swreg15);
+			if (e)
+				hl_engine_data_sprintf(e, dec_fmt, i, j,
+							is_eng_idle ? "Y" : "N", dec_swreg15);
 		}
 	}
 
-	if (s && (prop->decoder_enabled_mask & PCIE_DEC_EN_MASK))
-		seq_puts(s,
+	if (e && (prop->decoder_enabled_mask & PCIE_DEC_EN_MASK))
+		hl_engine_data_sprintf(e,
 			"\nPCIe DEC  is_idle  VSI_CMD_SWREG15\n"
 			"--------  -------  ---------------\n");
 
@@ -6395,12 +6397,13 @@ static bool gaudi2_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 		if (mask && !is_eng_idle)
 			set_bit(engine_idx, mask);
 
-		if (s)
-			seq_printf(s, pcie_dec_fmt, i, is_eng_idle ? "Y" : "N", dec_swreg15);
+		if (e)
+			hl_engine_data_sprintf(e, pcie_dec_fmt, i,
+						is_eng_idle ? "Y" : "N", dec_swreg15);
 	}
 
-	if (s)
-		seq_puts(s,
+	if (e)
+		hl_engine_data_sprintf(e,
 			"\nCORE  ROT  is_idle  QM_GLBL_STS0  QM_CGM_STS  DMA_CORE_STS0\n"
 			"----  ----  -------  ------------  ----------  -------------\n");
 
@@ -6419,8 +6422,8 @@ static bool gaudi2_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 		if (mask && !is_eng_idle)
 			set_bit(engine_idx, mask);
 
-		if (s)
-			seq_printf(s, rot_fmt, i, 0, is_eng_idle ? "Y" : "N",
+		if (e)
+			hl_engine_data_sprintf(e, rot_fmt, i, 0, is_eng_idle ? "Y" : "N",
 					qm_glbl_sts0, qm_cgm_sts, "-");
 	}
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index db4487c33582..7b9f7f8b51f4 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5137,8 +5137,8 @@ int goya_cpucp_info_get(struct hl_device *hdev)
 	return 0;
 }
 
-static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
-					u8 mask_len, struct seq_file *s)
+static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask_arr, u8 mask_len,
+				struct engines_data *e)
 {
 	const char *fmt = "%-5d%-9s%#-14x%#-16x%#x\n";
 	const char *dma_fmt = "%-5d%-9s%#-14x%#x\n";
@@ -5149,9 +5149,9 @@ static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 	u64 offset;
 	int i;
 
-	if (s)
-		seq_puts(s, "\nDMA  is_idle  QM_GLBL_STS0  DMA_CORE_STS0\n"
-				"---  -------  ------------  -------------\n");
+	if (e)
+		hl_engine_data_sprintf(e, "\nDMA  is_idle  QM_GLBL_STS0  DMA_CORE_STS0\n"
+					"---  -------  ------------  -------------\n");
 
 	offset = mmDMA_QM_1_GLBL_STS0 - mmDMA_QM_0_GLBL_STS0;
 
@@ -5164,13 +5164,13 @@ static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 
 		if (mask && !is_eng_idle)
 			set_bit(GOYA_ENGINE_ID_DMA_0 + i, mask);
-		if (s)
-			seq_printf(s, dma_fmt, i, is_eng_idle ? "Y" : "N",
+		if (e)
+			hl_engine_data_sprintf(e, dma_fmt, i, is_eng_idle ? "Y" : "N",
 					qm_glbl_sts0, dma_core_sts0);
 	}
 
-	if (s)
-		seq_puts(s,
+	if (e)
+		hl_engine_data_sprintf(e,
 			"\nTPC  is_idle  QM_GLBL_STS0  CMDQ_GLBL_STS0  CFG_STATUS\n"
 			"---  -------  ------------  --------------  ----------\n");
 
@@ -5187,13 +5187,13 @@ static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 
 		if (mask && !is_eng_idle)
 			set_bit(GOYA_ENGINE_ID_TPC_0 + i, mask);
-		if (s)
-			seq_printf(s, fmt, i, is_eng_idle ? "Y" : "N",
+		if (e)
+			hl_engine_data_sprintf(e, fmt, i, is_eng_idle ? "Y" : "N",
 				qm_glbl_sts0, cmdq_glbl_sts0, tpc_cfg_sts);
 	}
 
-	if (s)
-		seq_puts(s,
+	if (e)
+		hl_engine_data_sprintf(e,
 			"\nMME  is_idle  QM_GLBL_STS0  CMDQ_GLBL_STS0  ARCH_STATUS\n"
 			"---  -------  ------------  --------------  -----------\n");
 
@@ -5207,10 +5207,10 @@ static bool goya_is_device_idle(struct hl_device *hdev, u64 *mask_arr,
 
 	if (mask && !is_eng_idle)
 		set_bit(GOYA_ENGINE_ID_MME_0, mask);
-	if (s) {
-		seq_printf(s, fmt, 0, is_eng_idle ? "Y" : "N", qm_glbl_sts0,
+	if (e) {
+		hl_engine_data_sprintf(e, fmt, 0, is_eng_idle ? "Y" : "N", qm_glbl_sts0,
 				cmdq_glbl_sts0, mme_arch_sts);
-		seq_puts(s, "\n");
+		hl_engine_data_sprintf(e, "\n");
 	}
 
 	return is_idle;
-- 
2.25.1

