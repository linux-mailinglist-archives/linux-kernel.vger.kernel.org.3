Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A764B5A4601
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiH2JXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiH2JXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:23:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5C65AA13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A32A1B80DE1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9191CC433D7;
        Mon, 29 Aug 2022 09:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661764988;
        bh=YbbMyFgx4fQb0f1612MP0w6ejCe0+oe51oGjlbK4RoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OALRF5w7MFPKnNA6FBn83RDbYysv7/UW0TnbdtOqksrqx1cw+wd1faVsG5g8YM9/b
         aH3Vs+pP8S0VOuY+LZfBXOOeMNSJXoljnJl5Z28MpzcFQKF6rcxiET9bqGbJ+X28l/
         t6mELyL4aVb80kDi9tQDlfdlGhLLxByJ8O4nLT5dqx22kJNZZzfmCqkXTB6/xh3r/d
         nQ/+vRMQmtbLI6l17cyBHg+w/rkKECBY+X9sO9uLbUu8//qZWMDox81zDFSJCuuWep
         RcYzqOMY8/xpj2rchH3VekU8JVSY1vzLyXnTtImgs2n+Jh1zK8HIRK1m8n/NpZ06er
         /+7/e/uPnAuPg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 7/7] habanalabs: send device active message to f/w
Date:   Mon, 29 Aug 2022 12:22:54 +0300
Message-Id: <20220829092254.930753-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829092254.930753-1-ogabbay@kernel.org>
References: <20220829092254.930753-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

As part of the RAS that is done by the f/w, we should send a message
to the f/w when a user either acquires or releases the device.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c           |  2 ++
 drivers/misc/habanalabs/common/firmware_if.c      | 15 +++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h       |  3 +++
 drivers/misc/habanalabs/common/habanalabs_drv.c   |  2 ++
 drivers/misc/habanalabs/gaudi/gaudi.c             |  6 ++++++
 drivers/misc/habanalabs/gaudi2/gaudi2.c           | 12 ++++++++++++
 drivers/misc/habanalabs/gaudi2/gaudi2P.h          |  1 +
 drivers/misc/habanalabs/goya/goya.c               |  6 ++++++
 drivers/misc/habanalabs/include/common/cpucp_if.h | 11 +++++++++++
 9 files changed, 58 insertions(+)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index ea6238e614f1..986045de552e 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -492,6 +492,8 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	hdev->last_open_session_duration_jif =
 		jiffies - hdev->last_successful_open_jif;
 
+	hdev->asic_funcs->send_device_activity(hdev, false);
+
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 4ede4bb03e8e..cd2eb7e73be5 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -454,6 +454,21 @@ void hl_fw_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 			size);
 }
 
+int hl_fw_send_device_activity(struct hl_device *hdev, bool open)
+{
+	struct cpucp_packet pkt;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_ACTIVE_STATUS_SET <<	CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.value = cpu_to_le64(open);
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt), 0, NULL);
+	if (rc)
+		dev_err(hdev->dev, "failed to send device activity msg(%u)\n", open);
+
+	return rc;
+}
+
 int hl_fw_send_heartbeat(struct hl_device *hdev)
 {
 	struct cpucp_packet hb_pkt;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index cf9cbbd09063..01426e1306ee 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1528,6 +1528,7 @@ struct engines_data {
  * @access_dev_mem: access device memory
  * @set_dram_bar_base: set the base of the DRAM BAR
  * @set_engine_cores: set a config command to enigne cores
+ * @send_device_activity: indication to FW about device availability
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1664,6 +1665,7 @@ struct hl_asic_funcs {
 	u64 (*set_dram_bar_base)(struct hl_device *hdev, u64 addr);
 	int (*set_engine_cores)(struct hl_device *hdev, u32 *core_ids,
 					u32 num_cores, u32 core_command);
+	int (*send_device_activity)(struct hl_device *hdev, bool open);
 };
 
 
@@ -3717,6 +3719,7 @@ int hl_fw_dram_replaced_row_get(struct hl_device *hdev,
 				struct cpucp_hbm_row_info *info);
 int hl_fw_dram_pending_row_get(struct hl_device *hdev, u32 *pend_rows_num);
 int hl_fw_cpucp_engine_core_asid_set(struct hl_device *hdev, u32 asid);
+int hl_fw_send_device_activity(struct hl_device *hdev, bool open);
 int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
 			bool is_wc[3]);
 int hl_pci_elbi_read(struct hl_device *hdev, u64 addr, u32 *data);
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 7bf0dc245d39..f9db7b91bfe3 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -204,6 +204,8 @@ int hl_device_open(struct inode *inode, struct file *filp)
 		goto out_err;
 	}
 
+	rc = hdev->asic_funcs->send_device_activity(hdev, true);
+
 	list_add(&hpriv->dev_node, &hdev->fpriv_list);
 	mutex_unlock(&hdev->fpriv_list_lock);
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 96020693ac29..87dbdbb220da 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9132,6 +9132,11 @@ static void gaudi_add_device_attr(struct hl_device *hdev, struct attribute_group
 	dev_vrm_attr_grp->attrs = gaudi_vrm_dev_attrs;
 }
 
+static int gaudi_send_device_activity(struct hl_device *hdev, bool open)
+{
+	return 0;
+}
+
 static const struct hl_asic_funcs gaudi_funcs = {
 	.early_init = gaudi_early_init,
 	.early_fini = gaudi_early_fini,
@@ -9224,6 +9229,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
 	.access_dev_mem = hl_access_dev_mem,
 	.set_dram_bar_base = gaudi_set_hbm_bar_base,
+	.send_device_activity = gaudi_send_device_activity,
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 4696da7a57c1..330869cb4c0b 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -10031,6 +10031,17 @@ static int gaudi2_get_monitor_dump(struct hl_device *hdev, void *data)
 	return -EOPNOTSUPP;
 }
 
+int gaudi2_send_device_activity(struct hl_device *hdev, bool open)
+{
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+
+	if (!(gaudi2->hw_cap_initialized & HW_CAP_CPU_Q) || hdev->fw_major_version < 37)
+		return 0;
+
+	/* TODO: add check for FW version using minor ver once it's known */
+	return hl_fw_send_device_activity(hdev, open);
+}
+
 static const struct hl_asic_funcs gaudi2_funcs = {
 	.early_init = gaudi2_early_init,
 	.early_fini = gaudi2_early_fini,
@@ -10127,6 +10138,7 @@ static const struct hl_asic_funcs gaudi2_funcs = {
 	.access_dev_mem = hl_access_dev_mem,
 	.set_dram_bar_base = gaudi2_set_hbm_bar_base,
 	.set_engine_cores = gaudi2_set_engine_cores,
+	.send_device_activity = gaudi2_send_device_activity,
 };
 
 void gaudi2_set_asic_funcs(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2P.h b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
index 9094a702678d..a99c348bbf39 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2P.h
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
@@ -553,5 +553,6 @@ void gaudi2_pb_print_security_errors(struct hl_device *hdev, u32 block_addr, u32
 					u32 offended_addr);
 int gaudi2_init_security(struct hl_device *hdev);
 void gaudi2_ack_protection_bits_errors(struct hl_device *hdev);
+int gaudi2_send_device_activity(struct hl_device *hdev, bool open);
 
 #endif /* GAUDI2P_H_ */
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index d8fb91d257b9..5ef9e3ca97a6 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5420,6 +5420,11 @@ static int goya_scrub_device_dram(struct hl_device *hdev, u64 val)
 	return -EOPNOTSUPP;
 }
 
+static int goya_send_device_activity(struct hl_device *hdev, bool open)
+{
+	return 0;
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5512,6 +5517,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
 	.access_dev_mem = hl_access_dev_mem,
 	.set_dram_bar_base = goya_set_ddr_bar_base,
+	.send_device_activity = goya_send_device_activity,
 };
 
 /*
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index abf40e1c4965..b837bb1f4cd3 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -636,6 +636,10 @@ enum pq_init_status {
  *       passes the max size it allows the CpuCP to write to the structure, to prevent
  *       data corruption in case of mismatched driver/FW versions.
  *       Relevant only to Gaudi.
+ *
+ * CPUCP_PACKET_ACTIVE_STATUS_SET -
+ *       LKD sends FW indication whether device is free or in use, this indication is reported
+ *       also to the BMC.
  */
 
 enum cpucp_packet_id {
@@ -691,6 +695,13 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_RESERVED4,			/* not used */
 	CPUCP_PACKET_RESERVED5,			/* not used */
 	CPUCP_PACKET_MONITOR_DUMP_GET,		/* debugfs */
+	CPUCP_PACKET_RESERVED6,			/* not used */
+	CPUCP_PACKET_RESERVED7,			/* not used */
+	CPUCP_PACKET_RESERVED8,			/* not used */
+	CPUCP_PACKET_RESERVED9,			/* not used */
+	CPUCP_PACKET_RESERVED10,		/* not used */
+	CPUCP_PACKET_ACTIVE_STATUS_SET,		/* internal */
+	CPUCP_PACKET_ID_MAX			/* must be last */
 };
 
 #define CPUCP_PACKET_FENCE_VAL	0xFE8CE7A5
-- 
2.25.1

