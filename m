Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F012551AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244685AbiFTNNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343761AbiFTNJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:09:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03251AD89
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B178B811C6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3263CC3411B;
        Mon, 20 Jun 2022 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730279;
        bh=bGqw4El/eOiOczitb/hlOItiPpdOmzR9sfVlF4Z8oTI=;
        h=From:To:Cc:Subject:Date:From;
        b=fjBMVYkNvZ68q1XHs2BWKmwQvL9CM9ko/u7mBkdsCNxG573sdfPk5+uWiSdmRUYCX
         tAspCJm0tnOtM4Od5mQHSqFCPKQq+FChNhQtFdeo9Zghxk9PF9TWhPiGjfzLsEXtDD
         DXGyGYcefUKTkQEwxOm3IrF9MDSbCct06yZrLnN0exN1siORA9CyOwki4mMOoOxmVt
         Xzv4mUnQYM+rsBpfYDZelDK7FB7kWr/OChwTb3v7t1hCJkzd2E8jH68Em4QjivsPj9
         AePcL8zh0AttwdsukagWB6OdbQ60illwd57jAEh241bscsvXon5AkVcd3b+ynGXJ0L
         V9E+x8L+49XsQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 01/17] habanalabs/gaudi: collect undefined opcode error info
Date:   Mon, 20 Jun 2022 16:04:16 +0300
Message-Id: <20220620130432.1180451-1-ogabbay@kernel.org>
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

From: Tal Cohen <talcohen@habana.ai>

when an undefined opcode error occurres, the driver collects
the relevant information from the Qman and stores it inside
the hdev data structure. An event fd indication is sent towards the
user space.

Note: another commit shall be followed which will add support to
read the error info by an ioctl.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       |  13 ++-
 drivers/misc/habanalabs/common/habanalabs.h   |  40 ++++++-
 .../misc/habanalabs/common/habanalabs_drv.c   |   1 +
 drivers/misc/habanalabs/gaudi/gaudi.c         | 108 ++++++++++++++----
 include/uapi/misc/habanalabs.h                |   8 +-
 5 files changed, 138 insertions(+), 32 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 38e1ad432e51..0f804ecb6caa 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1531,10 +1531,11 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	return rc;
 }
 
-static void hl_notifier_event_send(struct hl_notifier_event *notifier_event, u64 event)
+static void hl_notifier_event_send(struct hl_notifier_event *notifier_event, u64 event_mask)
 {
 	mutex_lock(&notifier_event->lock);
-	notifier_event->events_mask |= event;
+	notifier_event->events_mask |= event_mask;
+
 	if (notifier_event->eventfd)
 		eventfd_signal(notifier_event->eventfd, 1);
 
@@ -1545,17 +1546,17 @@ static void hl_notifier_event_send(struct hl_notifier_event *notifier_event, u64
  * hl_notifier_event_send_all - notify all user processes via eventfd
  *
  * @hdev: pointer to habanalabs device structure
- * @event: the occurred event
+ * @event_mask: the occurred event/s
  * Returns 0 for success or an error on failure.
  */
-void hl_notifier_event_send_all(struct hl_device *hdev, u64 event)
+void hl_notifier_event_send_all(struct hl_device *hdev, u64 event_mask)
 {
 	struct hl_fpriv	*hpriv;
 
 	mutex_lock(&hdev->fpriv_list_lock);
 
 	list_for_each_entry(hpriv, &hdev->fpriv_list, dev_node)
-		hl_notifier_event_send(&hpriv->notifier_event, event);
+		hl_notifier_event_send(&hpriv->notifier_event, event_mask);
 
 	mutex_unlock(&hdev->fpriv_list_lock);
 
@@ -1563,7 +1564,7 @@ void hl_notifier_event_send_all(struct hl_device *hdev, u64 event)
 	mutex_lock(&hdev->fpriv_ctrl_list_lock);
 
 	list_for_each_entry(hpriv, &hdev->fpriv_ctrl_list, dev_node)
-		hl_notifier_event_send(&hpriv->notifier_event, event);
+		hl_notifier_event_send(&hpriv->notifier_event, event_mask);
 
 	mutex_unlock(&hdev->fpriv_ctrl_list_lock);
 }
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 1ab64e8a05c6..3a0f6dca8361 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2644,14 +2644,48 @@ struct razwi_info {
 	u8		type;
 };
 
+#define MAX_QMAN_STREAMS_INFO		4
+#define OPCODE_INFO_MAX_ADDR_SIZE	8
+/**
+ * struct undefined_opcode_info - info about last undefined opcode error
+ * @timestamp: timestamp of the undefined opcode error
+ * @cb_addr_streams: CB addresses (per stream) that are currently exists in the PQ
+ *                   entiers. In case all streams array entries are
+ *                   filled with values, it means the execution was in Lower-CP.
+ * @cq_addr: the address of the current handled command buffer
+ * @cq_size: the size of the current handled command buffer
+ * @cb_addr_streams_len: num of streams - actual len of cb_addr_streams array.
+ *                       should be equal to 1 incase of undefined opcode
+ *                       in Upper-CP (specific stream) and equal to 4 incase
+ *                       of undefined opcode in Lower-CP.
+ * @engine_id: engine-id that the error occurred on
+ * @stream_id: the stream id the error occurred on. In case the stream equals to
+ *             MAX_QMAN_STREAMS_INFO it means the error occurred on a Lower-CP.
+ * @write_enable: if set, writing to undefined opcode parameters in the structure
+ *                 is enable so the first (root cause) undefined opcode will not be
+ *                 overwritten.
+ */
+struct undefined_opcode_info {
+	ktime_t timestamp;
+	u64 cb_addr_streams[MAX_QMAN_STREAMS_INFO][OPCODE_INFO_MAX_ADDR_SIZE];
+	u64 cq_addr;
+	u32 cq_size;
+	u32 cb_addr_streams_len;
+	u32 engine_id;
+	u32 stream_id;
+	bool write_enable;
+};
+
 /**
  * struct last_error_session_info - info about last session errors occurred.
  * @cs_timeout: CS timeout error last information.
  * @razwi: razwi last information.
+ * @undef_opcode: undefined opcode information
  */
 struct last_error_session_info {
-	struct	cs_timeout_info	cs_timeout;
-	struct	razwi_info	razwi;
+	struct cs_timeout_info		cs_timeout;
+	struct razwi_info		razwi;
+	struct undefined_opcode_info	undef_opcode;
 };
 
 /**
@@ -3159,7 +3193,7 @@ int hl_device_utilization(struct hl_device *hdev, u32 *utilization);
 int hl_build_hwmon_channel_info(struct hl_device *hdev,
 		struct cpucp_sensor *sensors_arr);
 
-void hl_notifier_event_send_all(struct hl_device *hdev, u64 event);
+void hl_notifier_event_send_all(struct hl_device *hdev, u64 event_mask);
 
 int hl_sysfs_init(struct hl_device *hdev);
 void hl_sysfs_fini(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index e617cc394ff7..d02533666746 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -198,6 +198,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	atomic_set(&hdev->last_error.cs_timeout.write_enable, 1);
 	atomic_set(&hdev->last_error.razwi.write_enable, 1);
+	hdev->last_error.undef_opcode.write_enable = true;
 
 	hdev->open_counter++;
 	hdev->last_successful_open_jif = jiffies;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 72b0d145e853..ec9f0a93cbe2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -443,6 +443,38 @@ static s64 gaudi_state_dump_specs_props[] = {
 	[SP_NUM_CORES] = 1,
 };
 
+static const int gaudi_queue_id_to_engine_id[] = {
+	[GAUDI_QUEUE_ID_DMA_0_0...GAUDI_QUEUE_ID_DMA_0_3] = GAUDI_ENGINE_ID_DMA_0,
+	[GAUDI_QUEUE_ID_DMA_1_0...GAUDI_QUEUE_ID_DMA_1_3] = GAUDI_ENGINE_ID_DMA_1,
+	[GAUDI_QUEUE_ID_CPU_PQ] = GAUDI_ENGINE_ID_SIZE,
+	[GAUDI_QUEUE_ID_DMA_2_0...GAUDI_QUEUE_ID_DMA_2_3] = GAUDI_ENGINE_ID_DMA_2,
+	[GAUDI_QUEUE_ID_DMA_3_0...GAUDI_QUEUE_ID_DMA_3_3] = GAUDI_ENGINE_ID_DMA_3,
+	[GAUDI_QUEUE_ID_DMA_4_0...GAUDI_QUEUE_ID_DMA_4_3] = GAUDI_ENGINE_ID_DMA_4,
+	[GAUDI_QUEUE_ID_DMA_5_0...GAUDI_QUEUE_ID_DMA_5_3] = GAUDI_ENGINE_ID_DMA_5,
+	[GAUDI_QUEUE_ID_DMA_6_0...GAUDI_QUEUE_ID_DMA_6_3] = GAUDI_ENGINE_ID_DMA_6,
+	[GAUDI_QUEUE_ID_DMA_7_0...GAUDI_QUEUE_ID_DMA_7_3] = GAUDI_ENGINE_ID_DMA_7,
+	[GAUDI_QUEUE_ID_MME_0_0...GAUDI_QUEUE_ID_MME_0_3] = GAUDI_ENGINE_ID_MME_0,
+	[GAUDI_QUEUE_ID_MME_1_0...GAUDI_QUEUE_ID_MME_1_3] = GAUDI_ENGINE_ID_MME_1,
+	[GAUDI_QUEUE_ID_TPC_0_0...GAUDI_QUEUE_ID_TPC_0_3] = GAUDI_ENGINE_ID_TPC_0,
+	[GAUDI_QUEUE_ID_TPC_1_0...GAUDI_QUEUE_ID_TPC_1_3] = GAUDI_ENGINE_ID_TPC_1,
+	[GAUDI_QUEUE_ID_TPC_2_0...GAUDI_QUEUE_ID_TPC_2_3] = GAUDI_ENGINE_ID_TPC_2,
+	[GAUDI_QUEUE_ID_TPC_3_0...GAUDI_QUEUE_ID_TPC_3_3] = GAUDI_ENGINE_ID_TPC_3,
+	[GAUDI_QUEUE_ID_TPC_4_0...GAUDI_QUEUE_ID_TPC_4_3] = GAUDI_ENGINE_ID_TPC_4,
+	[GAUDI_QUEUE_ID_TPC_5_0...GAUDI_QUEUE_ID_TPC_5_3] = GAUDI_ENGINE_ID_TPC_5,
+	[GAUDI_QUEUE_ID_TPC_6_0...GAUDI_QUEUE_ID_TPC_6_3] = GAUDI_ENGINE_ID_TPC_6,
+	[GAUDI_QUEUE_ID_TPC_7_0...GAUDI_QUEUE_ID_TPC_7_3] = GAUDI_ENGINE_ID_TPC_7,
+	[GAUDI_QUEUE_ID_NIC_0_0...GAUDI_QUEUE_ID_NIC_0_3] = GAUDI_ENGINE_ID_NIC_0,
+	[GAUDI_QUEUE_ID_NIC_1_0...GAUDI_QUEUE_ID_NIC_1_3] = GAUDI_ENGINE_ID_NIC_1,
+	[GAUDI_QUEUE_ID_NIC_2_0...GAUDI_QUEUE_ID_NIC_2_3] = GAUDI_ENGINE_ID_NIC_2,
+	[GAUDI_QUEUE_ID_NIC_3_0...GAUDI_QUEUE_ID_NIC_3_3] = GAUDI_ENGINE_ID_NIC_3,
+	[GAUDI_QUEUE_ID_NIC_4_0...GAUDI_QUEUE_ID_NIC_4_3] = GAUDI_ENGINE_ID_NIC_4,
+	[GAUDI_QUEUE_ID_NIC_5_0...GAUDI_QUEUE_ID_NIC_5_3] = GAUDI_ENGINE_ID_NIC_5,
+	[GAUDI_QUEUE_ID_NIC_6_0...GAUDI_QUEUE_ID_NIC_6_3] = GAUDI_ENGINE_ID_NIC_6,
+	[GAUDI_QUEUE_ID_NIC_7_0...GAUDI_QUEUE_ID_NIC_7_3] = GAUDI_ENGINE_ID_NIC_7,
+	[GAUDI_QUEUE_ID_NIC_8_0...GAUDI_QUEUE_ID_NIC_8_3] = GAUDI_ENGINE_ID_NIC_8,
+	[GAUDI_QUEUE_ID_NIC_9_0...GAUDI_QUEUE_ID_NIC_9_3] = GAUDI_ENGINE_ID_NIC_9,
+};
+
 /* The order here is opposite to the order of the indexing in the h/w.
  * i.e. SYNC_MGR_W_S is actually 0, SYNC_MGR_E_S is 1, etc.
  */
@@ -6989,14 +7021,15 @@ static inline u32 gaudi_queue_idx_dec(u32 idx, u32 q_len)
 }
 
 /**
- * gaudi_print_sw_config_stream_data - print SW config stream data
+ * gaudi_handle_sw_config_stream_data - print SW config stream data
  *
  * @hdev: pointer to the habanalabs device structure
  * @stream: the QMAN's stream
  * @qman_base: base address of QMAN registers block
+ * @event_mask: mask of the last events occurred
  */
-static void gaudi_print_sw_config_stream_data(struct hl_device *hdev, u32 stream,
-						u64 qman_base)
+static void gaudi_handle_sw_config_stream_data(struct hl_device *hdev, u32 stream,
+						u64 qman_base, u64 event_mask)
 {
 	u64 cq_ptr_lo, cq_ptr_hi, cq_tsize, cq_ptr;
 	u32 cq_ptr_lo_off, size;
@@ -7014,24 +7047,32 @@ static void gaudi_print_sw_config_stream_data(struct hl_device *hdev, u32 stream
 	size = RREG32(cq_tsize);
 	dev_info(hdev->dev, "stop on err: stream: %u, addr: %#llx, size: %u\n",
 							stream, cq_ptr, size);
+
+	if (event_mask & HL_NOTIFIER_EVENT_UNDEFINED_OPCODE) {
+		hdev->last_error.undef_opcode.cq_addr = cq_ptr;
+		hdev->last_error.undef_opcode.cq_size = size;
+		hdev->last_error.undef_opcode.stream_id = stream;
+	}
 }
 
 /**
- * gaudi_print_last_pqes_on_err - print last PQEs on error
+ * gaudi_handle_last_pqes_on_err - print last PQEs on error
  *
  * @hdev: pointer to the habanalabs device structure
  * @qid_base: first QID of the QMAN (out of 4 streams)
  * @stream: the QMAN's stream
  * @qman_base: base address of QMAN registers block
+ * @event_mask: mask of the last events occurred
  * @pr_sw_conf: if true print the SW config stream data (CQ PTR and SIZE)
  */
-static void gaudi_print_last_pqes_on_err(struct hl_device *hdev, u32 qid_base,
+static void gaudi_handle_last_pqes_on_err(struct hl_device *hdev, u32 qid_base,
 						u32 stream, u64 qman_base,
+						u64 event_mask,
 						bool pr_sw_conf)
 {
 	u32 ci, qm_ci_stream_off, queue_len;
 	struct hl_hw_queue *q;
-	u64 pq_ci;
+	u64 pq_ci, addr[PQ_FETCHER_CACHE_SIZE];
 	int i;
 
 	q = &hdev->kernel_queues[qid_base + stream];
@@ -7046,16 +7087,16 @@ static void gaudi_print_last_pqes_on_err(struct hl_device *hdev, u32 qid_base,
 	hdev->asic_funcs->hw_queues_lock(hdev);
 
 	if (pr_sw_conf)
-		gaudi_print_sw_config_stream_data(hdev, stream, qman_base);
+		gaudi_handle_sw_config_stream_data(hdev, stream, qman_base, event_mask);
 
 	ci = RREG32(pq_ci);
 
 	/* we should start printing form ci -1 */
 	ci = gaudi_queue_idx_dec(ci, queue_len);
+	memset(addr, 0, sizeof(addr));
 
 	for (i = 0; i < PQ_FETCHER_CACHE_SIZE; i++) {
 		struct hl_bd *bd;
-		u64 addr;
 		u32 len;
 
 		bd = q->kernel_address;
@@ -7066,52 +7107,68 @@ static void gaudi_print_last_pqes_on_err(struct hl_device *hdev, u32 qid_base,
 		if (!len)
 			break;
 
-		addr = le64_to_cpu(bd->ptr);
+		addr[i] = le64_to_cpu(bd->ptr);
 
 		dev_info(hdev->dev, "stop on err PQE(stream %u): ci: %u, addr: %#llx, size: %u\n",
-							stream, ci, addr, len);
+							stream, ci, addr[i], len);
 
 		/* get previous ci, wrap if needed */
 		ci = gaudi_queue_idx_dec(ci, queue_len);
 	}
 
+	if (event_mask & HL_NOTIFIER_EVENT_UNDEFINED_OPCODE) {
+		struct undefined_opcode_info *undef_opcode = &hdev->last_error.undef_opcode;
+		u32 arr_idx = undef_opcode->cb_addr_streams_len;
+
+		if (arr_idx == 0) {
+			undef_opcode->timestamp = ktime_get();
+			undef_opcode->engine_id = gaudi_queue_id_to_engine_id[qid_base];
+		}
+
+		memcpy(undef_opcode->cb_addr_streams[arr_idx], addr, sizeof(addr));
+		undef_opcode->cb_addr_streams_len++;
+	}
+
 	hdev->asic_funcs->hw_queues_unlock(hdev);
 }
 
 /**
- * print_qman_data_on_err - extract QMAN data on error
+ * handle_qman_data_on_err - extract QMAN data on error
  *
  * @hdev: pointer to the habanalabs device structure
  * @qid_base: first QID of the QMAN (out of 4 streams)
  * @stream: the QMAN's stream
  * @qman_base: base address of QMAN registers block
+ * @event_mask: mask of the last events occurred
  *
  * This function attempt to exatract as much data as possible on QMAN error.
  * On upper CP print the SW config stream data and last 8 PQEs.
  * On lower CP print SW config data and last PQEs of ALL 4 upper CPs
  */
-static void print_qman_data_on_err(struct hl_device *hdev, u32 qid_base,
-						u32 stream, u64 qman_base)
+static void handle_qman_data_on_err(struct hl_device *hdev, u32 qid_base,
+				   u32 stream, u64 qman_base, u64 event_mask)
 {
 	u32 i;
 
 	if (stream != QMAN_STREAMS) {
-		gaudi_print_last_pqes_on_err(hdev, qid_base, stream, qman_base,
-									true);
+		gaudi_handle_last_pqes_on_err(hdev, qid_base, stream,
+			qman_base, event_mask, true);
 		return;
 	}
 
-	gaudi_print_sw_config_stream_data(hdev, stream, qman_base);
+	/* handle Lower-CP */
+	gaudi_handle_sw_config_stream_data(hdev, stream, qman_base, event_mask);
 
 	for (i = 0; i < QMAN_STREAMS; i++)
-		gaudi_print_last_pqes_on_err(hdev, qid_base, i, qman_base,
-									false);
+		gaudi_handle_last_pqes_on_err(hdev, qid_base, i,
+			qman_base, event_mask, false);
 }
 
 static void gaudi_handle_qman_err_generic(struct hl_device *hdev,
 					  const char *qm_name,
 					  u64 qman_base,
-					  u32 qid_base)
+					  u32 qid_base,
+					  u64 *event_mask)
 {
 	u32 i, j, glbl_sts_val, arb_err_val, glbl_sts_clr_val;
 	u64 glbl_sts_addr, arb_err_addr;
@@ -7142,12 +7199,21 @@ static void gaudi_handle_qman_err_generic(struct hl_device *hdev,
 				glbl_sts_clr_val |= BIT(j);
 			}
 		}
+		/* check for undefined opcode */
+		if (glbl_sts_val & TPC0_QM_GLBL_STS1_CP_UNDEF_CMD_ERR_MASK &&
+				hdev->last_error.undef_opcode.write_enable) {
+			memset(&hdev->last_error.undef_opcode, 0,
+						sizeof(hdev->last_error.undef_opcode));
+
+			hdev->last_error.undef_opcode.write_enable = false;
+			*event_mask |= HL_NOTIFIER_EVENT_UNDEFINED_OPCODE;
+		}
 
 		/* Write 1 clear errors */
 		if (!hdev->stop_on_err)
 			WREG32(glbl_sts_addr + 4 * i, glbl_sts_clr_val);
 		else
-			print_qman_data_on_err(hdev, qid_base, i, qman_base);
+			handle_qman_data_on_err(hdev, qid_base, i, qman_base, *event_mask);
 	}
 
 	arb_err_val = RREG32(arb_err_addr);
@@ -7385,7 +7451,7 @@ static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type, u64 *e
 		return;
 	}
 
-	gaudi_handle_qman_err_generic(hdev, desc, qman_base, qid_base);
+	gaudi_handle_qman_err_generic(hdev, desc, qman_base, qid_base, event_mask);
 }
 
 static void gaudi_print_irq_info(struct hl_device *hdev, u16 event_type,
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 6d2ccc09dcf2..c94b89cf1ec1 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -1402,9 +1402,13 @@ struct hl_debug_args {
 /*
  * Notifier event values - for the notification mechanism and the HL_INFO_GET_EVENTS command
  *
- * HL_NOTIFIER_EVENT_TPC_ASSERT - Indicates TPC assert event
+ * HL_NOTIFIER_EVENT_TPC_ASSERT       - Indicates TPC assert event
+ * HL_NOTIFIER_EVENT_UNDEFINED_OPCODE - Indicates undefined operation code
+ * HL_NOTIFIER_EVENT_DEVICE_RESET     - Indicates device requires a reset
  */
-#define HL_NOTIFIER_EVENT_TPC_ASSERT  (1 << 0)
+#define HL_NOTIFIER_EVENT_TPC_ASSERT		(1ULL << 0)
+#define HL_NOTIFIER_EVENT_UNDEFINED_OPCODE	(1ULL << 1)
+#define HL_NOTIFIER_EVENT_DEVICE_RESET		(1ULL << 2)
 
 /*
  * Various information operations such as:
-- 
2.25.1

