Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB97758BB1A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiHGNzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 09:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbiHGNzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 09:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A676452
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 06:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C92660EF8
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 13:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D0CC433C1;
        Sun,  7 Aug 2022 13:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659880500;
        bh=v91N7++BkM872wvdMREd4kPBSWJ9kFbasDkA6yDMjzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3q0X7P+oj6Zlz7QdovvbXy4NmW3G25OQvCdk4LrTfFkWHPNCgAzvQRtoXNYbyhCH
         Gg/ce9UYJM5cRglFU23q7Sic2WT6+SRZTzPPeSMNjlQXP7OBophqo8K5nyD0AyueQx
         yvNuJeEYozmeWs9BAsj3gHZWif5wh6ek2w3BblJUwdnShLMzKqSy5wzNFQQ29kBont
         6mZpy+J7Zi0mlN5eigsN7DTbZtUrjOOzwNNxvKuWrpRhNBlxqh+aWX3ksGsz7eVs0i
         S5hjE4VXH2uOC1wh2SHCw2pE1qSIT48xW3kbFjZmPa/Zc9mOP4HIf2Xu0D9fg2rI8R
         zwEypjgKzrZIg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 3/6] habanalabs/gaudi2: new API to control engine cores running mode
Date:   Sun,  7 Aug 2022 16:54:49 +0300
Message-Id: <20220807135452.1219894-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220807135452.1219894-1-ogabbay@kernel.org>
References: <20220807135452.1219894-1-ogabbay@kernel.org>
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

From: Tal Cohen <talcohen@habana.ai>

The current flow of halting the engine cores is implemented by command
buffers built by the user space and sent towards the Driver.

This current flow is broken since the user space does not know when
the cores actually halt as sending a workload is async op.

Therefore the application can not free the memory that is mapped
to the engine cores.

This new API allows the user space to control the running mode. The
API call is sync (returns after the cores are set to the
requested mode).

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 43 ++++++++++-
 drivers/misc/habanalabs/common/habanalabs.h   |  8 ++-
 drivers/misc/habanalabs/gaudi2/gaudi2.c       | 72 +++++++++++++++++--
 .../include/gaudi2/asic_reg/gaudi2_regs.h     |  1 +
 include/uapi/misc/habanalabs.h                | 38 ++++++++--
 5 files changed, 151 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 304e4f3b0e7e..cf4118515678 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -13,7 +13,7 @@
 
 #define HL_CS_FLAGS_TYPE_MASK	(HL_CS_FLAGS_SIGNAL | HL_CS_FLAGS_WAIT | \
 			HL_CS_FLAGS_COLLECTIVE_WAIT | HL_CS_FLAGS_RESERVE_SIGNALS_ONLY | \
-			HL_CS_FLAGS_UNRESERVE_SIGNALS_ONLY)
+			HL_CS_FLAGS_UNRESERVE_SIGNALS_ONLY | HL_CS_FLAGS_ENGINE_CORE_COMMAND)
 
 
 #define MAX_TS_ITER_NUM 10
@@ -1244,6 +1244,8 @@ static enum hl_cs_type hl_cs_get_cs_type(u32 cs_type_flags)
 		return CS_RESERVE_SIGNALS;
 	else if (cs_type_flags & HL_CS_FLAGS_UNRESERVE_SIGNALS_ONLY)
 		return CS_UNRESERVE_SIGNALS;
+	else if (cs_type_flags & HL_CS_FLAGS_ENGINE_CORE_COMMAND)
+		return CS_TYPE_ENGINE_CORE;
 	else
 		return CS_TYPE_DEFAULT;
 }
@@ -2355,6 +2357,41 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	return rc;
 }
 
+static int cs_ioctl_engine_cores(struct hl_fpriv *hpriv, u64 engine_cores,
+						u32 num_engine_cores, u32 core_command)
+{
+	int rc;
+	struct hl_device *hdev = hpriv->hdev;
+	void __user *engine_cores_arr;
+	u32 *cores;
+
+	if (!num_engine_cores || num_engine_cores > hdev->asic_prop.num_engine_cores) {
+		dev_err(hdev->dev, "Number of engine cores %d is invalid\n", num_engine_cores);
+		return -EINVAL;
+	}
+
+	if (core_command != HL_ENGINE_CORE_RUN && core_command != HL_ENGINE_CORE_HALT) {
+		dev_err(hdev->dev, "Engine core command is invalid\n");
+		return -EINVAL;
+	}
+
+	engine_cores_arr = (void __user *) (uintptr_t) engine_cores;
+	cores = kmalloc_array(num_engine_cores, sizeof(u32), GFP_KERNEL);
+	if (!cores)
+		return -ENOMEM;
+
+	if (copy_from_user(cores, engine_cores_arr, num_engine_cores * sizeof(u32))) {
+		dev_err(hdev->dev, "Failed to copy core-ids array from user\n");
+		kfree(cores);
+		return -EFAULT;
+	}
+
+	rc = hdev->asic_funcs->set_engine_cores(hdev, cores, num_engine_cores, core_command);
+	kfree(cores);
+
+	return rc;
+}
+
 int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	union hl_cs_args *args = data;
@@ -2407,6 +2444,10 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		rc = cs_ioctl_unreserve_signals(hpriv,
 					args->in.encaps_sig_handle_id);
 		break;
+	case CS_TYPE_ENGINE_CORE:
+		rc = cs_ioctl_engine_cores(hpriv, args->in.engine_cores,
+				args->in.num_engine_cores, args->in.core_command);
+		break;
 	default:
 		rc = cs_ioctl_default(hpriv, chunks, num_chunks, &cs_seq,
 						args->in.cs_flags,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 8d9e96c6092a..ae3f5832fe58 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -345,7 +345,8 @@ enum hl_cs_type {
 	CS_TYPE_WAIT,
 	CS_TYPE_COLLECTIVE_WAIT,
 	CS_RESERVE_SIGNALS,
-	CS_UNRESERVE_SIGNALS
+	CS_UNRESERVE_SIGNALS,
+	CS_TYPE_ENGINE_CORE
 };
 
 /*
@@ -617,6 +618,7 @@ struct hl_hints_range {
  *                                      which the property supports_user_set_page_size is true
  *                                      (i.e. the DRAM supports multiple page sizes), otherwise
  *                                      it will shall  be equal to dram_page_size.
+ * @num_engine_cores: number of engine cpu cores
  * @collective_first_sob: first sync object available for collective use
  * @collective_first_mon: first monitor available for collective use
  * @sync_stream_first_sob: first sync object available for sync stream use
@@ -737,6 +739,7 @@ struct asic_fixed_properties {
 	u32				faulty_dram_cluster_map;
 	u32				xbar_edge_enabled_mask;
 	u32				device_mem_alloc_default_page_size;
+	u32				num_engine_cores;
 	u16				collective_first_sob;
 	u16				collective_first_mon;
 	u16				sync_stream_first_sob;
@@ -1511,6 +1514,7 @@ struct engines_data {
  * @check_if_razwi_happened: check if there was a razwi due to RR violation.
  * @access_dev_mem: access device memory
  * @set_dram_bar_base: set the base of the DRAM BAR
+ * @set_engine_cores: set a config command to enigne cores
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1645,6 +1649,8 @@ struct hl_asic_funcs {
 	int (*access_dev_mem)(struct hl_device *hdev, enum pci_region region_type,
 				u64 addr, u64 *val, enum debugfs_access_type acc_type);
 	u64 (*set_dram_bar_base)(struct hl_device *hdev, u64 addr);
+	int (*set_engine_cores)(struct hl_device *hdev, u32 *core_ids,
+					u32 num_cores, u32 core_command);
 };
 
 
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 9ccde0258eca..d7fd5f916083 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -1989,6 +1989,7 @@ static int gaudi2_set_fixed_properties(struct hl_device *hdev)
 		prop->pmmu_huge.end_addr = VA_HOST_SPACE_HPAGE_END;
 	}
 
+	prop->num_engine_cores = CPU_ID_MAX;
 	prop->cfg_size = CFG_SIZE;
 	prop->max_asid = MAX_ASID;
 	prop->num_of_events = GAUDI2_EVENT_SIZE;
@@ -3751,14 +3752,16 @@ static void gaudi2_stop_dec(struct hl_device *hdev)
 	gaudi2_stop_pcie_dec(hdev);
 }
 
-static void gaudi2_halt_arc(struct hl_device *hdev, u32 cpu_id)
+static void gaudi2_set_arc_running_mode(struct hl_device *hdev, u32 cpu_id, u32 run_mode)
 {
 	u32 reg_base, reg_val;
 
 	reg_base = gaudi2_arc_blocks_bases[cpu_id];
+	if (run_mode == HL_ENGINE_CORE_RUN)
+		reg_val = FIELD_PREP(ARC_FARM_ARC0_AUX_RUN_HALT_REQ_RUN_REQ_MASK, 1);
+	else
+		reg_val = FIELD_PREP(ARC_FARM_ARC0_AUX_RUN_HALT_REQ_HALT_REQ_MASK, 1);
 
-	/* Halt ARC */
-	reg_val = FIELD_PREP(ARC_FARM_ARC0_AUX_RUN_HALT_REQ_HALT_REQ_MASK, 1);
 	WREG32(reg_base + ARC_HALT_REQ_OFFSET, reg_val);
 }
 
@@ -3768,10 +3771,37 @@ static void gaudi2_halt_arcs(struct hl_device *hdev)
 
 	for (arc_id = CPU_ID_SCHED_ARC0; arc_id < CPU_ID_MAX; arc_id++) {
 		if (gaudi2_is_arc_enabled(hdev, arc_id))
-			gaudi2_halt_arc(hdev, arc_id);
+			gaudi2_set_arc_running_mode(hdev, arc_id, HL_ENGINE_CORE_HALT);
 	}
 }
 
+static int gaudi2_verify_arc_running_mode(struct hl_device *hdev, u32 cpu_id, u32 run_mode)
+{
+	int rc;
+	u32 reg_base, val, ack_mask, timeout_usec = 100000;
+
+	if (hdev->pldm)
+		timeout_usec *= 100;
+
+	reg_base = gaudi2_arc_blocks_bases[cpu_id];
+	if (run_mode == HL_ENGINE_CORE_RUN)
+		ack_mask = ARC_FARM_ARC0_AUX_RUN_HALT_ACK_RUN_ACK_MASK;
+	else
+		ack_mask = ARC_FARM_ARC0_AUX_RUN_HALT_ACK_HALT_ACK_MASK;
+
+	rc = hl_poll_timeout(hdev, reg_base + ARC_HALT_ACK_OFFSET,
+				val, ((val & ack_mask) == ack_mask),
+				1000, timeout_usec);
+
+	if (!rc) {
+		/* Clear */
+		val = FIELD_PREP(ARC_FARM_ARC0_AUX_RUN_HALT_REQ_RUN_REQ_MASK, 0);
+		WREG32(reg_base + ARC_HALT_REQ_OFFSET, val);
+	}
+
+	return rc;
+}
+
 static void gaudi2_reset_arcs(struct hl_device *hdev)
 {
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
@@ -3796,8 +3826,39 @@ static void gaudi2_nic_qmans_manual_flush(struct hl_device *hdev)
 
 	queue_id = GAUDI2_QUEUE_ID_NIC_0_0;
 
-	for (i = 0 ; i < NIC_NUMBER_OF_ENGINES ; i++, queue_id += NUM_OF_PQ_PER_QMAN)
+	for (i = 0 ; i < NIC_NUMBER_OF_ENGINES ; i++, queue_id += NUM_OF_PQ_PER_QMAN) {
+		if (!(hdev->nic_ports_mask & BIT(i)))
+			continue;
+
 		gaudi2_qman_manual_flush_common(hdev, queue_id);
+	}
+}
+
+int gaudi2_set_engine_cores(struct hl_device *hdev, u32 *core_ids,
+			u32 num_cores, u32 core_command)
+{
+	int i, rc;
+
+
+	for (i = 0 ; i < num_cores ; i++) {
+		if (gaudi2_is_arc_enabled(hdev, core_ids[i]))
+			gaudi2_set_arc_running_mode(hdev, core_ids[i], core_command);
+	}
+
+	for (i = 0 ; i < num_cores ; i++) {
+		if (gaudi2_is_arc_enabled(hdev, core_ids[i])) {
+			rc = gaudi2_verify_arc_running_mode(hdev, core_ids[i], core_command);
+
+			if (rc) {
+				dev_err(hdev->dev, "failed to %s arc: %d\n",
+					(core_command == HL_ENGINE_CORE_HALT) ?
+					"HALT" : "RUN", core_ids[i]);
+				return -1;
+			}
+		}
+	}
+
+	return 0;
 }
 
 static void gaudi2_halt_engines(struct hl_device *hdev, bool hard_reset, bool fw_reset)
@@ -9968,6 +10029,7 @@ static const struct hl_asic_funcs gaudi2_funcs = {
 	.mmu_get_real_page_size = gaudi2_mmu_get_real_page_size,
 	.access_dev_mem = hl_access_dev_mem,
 	.set_dram_bar_base = gaudi2_set_hbm_bar_base,
+	.set_engine_cores = gaudi2_set_engine_cores,
 };
 
 void gaudi2_set_asic_funcs(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h b/drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
index d0e2c68a639f..bfda4223bdc8 100644
--- a/drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
+++ b/drivers/misc/habanalabs/include/gaudi2/asic_reg/gaudi2_regs.h
@@ -239,6 +239,7 @@
 #define SFT_IF_RTR_OFFSET	(mmSFT0_HBW_RTR_IF1_RTR_H3_BASE - mmSFT0_HBW_RTR_IF0_RTR_H3_BASE)
 
 #define ARC_HALT_REQ_OFFSET	(mmARC_FARM_ARC0_AUX_RUN_HALT_REQ - mmARC_FARM_ARC0_AUX_BASE)
+#define ARC_HALT_ACK_OFFSET	(mmARC_FARM_ARC0_AUX_RUN_HALT_ACK - mmARC_FARM_ARC0_AUX_BASE)
 
 #define ARC_REGION_CFG_OFFSET(region) \
 	(mmARC_FARM_ARC0_AUX_ARC_REGION_CFG_0 + (region * 4) - mmARC_FARM_ARC0_AUX_BASE)
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 0da8894ab94a..f51c6ae4f94d 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1361,17 +1361,47 @@ struct hl_cs_chunk {
 #define HL_CS_FLAGS_RESERVE_SIGNALS_ONLY	0x1000
 #define HL_CS_FLAGS_UNRESERVE_SIGNALS_ONLY	0x2000
 
+/*
+ * The engine cores CS is merged into the existing CS ioctls.
+ * Use it to control the engine cores mode.
+ */
+#define HL_CS_FLAGS_ENGINE_CORE_COMMAND		0x4000
+
 #define HL_CS_STATUS_SUCCESS		0
 
 #define HL_MAX_JOBS_PER_CS		512
 
+/* HL_ENGINE_CORE_ values
+ *
+ * HL_ENGINE_CORE_HALT: engine core halt
+ * HL_ENGINE_CORE_RUN:  engine core run
+ */
+#define HL_ENGINE_CORE_HALT	(1 << 0)
+#define HL_ENGINE_CORE_RUN	(1 << 1)
+
 struct hl_cs_in {
 
-	/* this holds address of array of hl_cs_chunk for restore phase */
-	__u64 chunks_restore;
+	union {
+		struct {
+			/* this holds address of array of hl_cs_chunk for restore phase */
+			__u64 chunks_restore;
 
-	/* holds address of array of hl_cs_chunk for execution phase */
-	__u64 chunks_execute;
+			/* holds address of array of hl_cs_chunk for execution phase */
+			__u64 chunks_execute;
+		};
+
+		/* Valid only when HL_CS_FLAGS_ENGINE_CORE_COMMAND is set */
+		struct {
+			/* this holds address of array of uint32 for engine_cores */
+			__u64 engine_cores;
+
+			/* number of engine cores in engine_cores array */
+			__u32 num_engine_cores;
+
+			/* the core command to be sent towards engine cores */
+			__u32 core_command;
+		};
+	};
 
 	union {
 		/*
-- 
2.25.1

