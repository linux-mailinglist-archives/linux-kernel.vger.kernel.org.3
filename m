Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258B147F6C7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 13:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhLZMnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 07:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbhLZMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 07:43:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183FCC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 04:43:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD36C60C99
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 12:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D64C36AE8;
        Sun, 26 Dec 2021 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640522589;
        bh=BpKlmQU+KuxJRv3tp44iAiu4ehh9I1N2395WKkZx3UQ=;
        h=From:To:Cc:Subject:Date:From;
        b=rpVSQ5bq0tnHYW10RPrIraDEtCIFuTdnLD8OWP4aH91t3A/aZqxE6y6fKKr6aug2Y
         D+48Gjvn9NUym+NIzdgO9AFrVOrI0CCEmDQykKKalNxXOSDEq7oTNkOvk+ZcVEMZcW
         YWCaG6avMTfGiGTZt/MmEyhqJJJoSc+WA7B88NQW+k7oUxGkKJU5Tk5jl7sWN92vAx
         WkbFerhNFdhDe0NB2lBQExDvrVAN1ui1gIMWXxy9Q0y/6SE4wwvHMd+xAYVOE+31tk
         DPLB7fz9y0KMjNsLZGJ9f5SayKQMnmxttXO70SvNKtU+34vI0LwH5tTJ41pK/L2IBE
         0bYWiGKLK95yg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 1/5] habanalabs: add CPU-CP packet for engine core ASID cfg
Date:   Sun, 26 Dec 2021 14:43:00 +0200
Message-Id: <20211226124304.237107-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

In some cases the driver cannot configure ASID of some engines due to
the security level of the relevant registers.
For this a new CPU-CP packet is introduced, which will allow the driver
to ask the F/W to do this configuration instead.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 20 +++++++++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h   |  1 +
 .../misc/habanalabs/include/common/cpucp_if.h |  5 +++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 1d0d228d4872..2cc2015c2416 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1059,6 +1059,26 @@ int hl_fw_dram_pending_row_get(struct hl_device *hdev, u32 *pend_rows_num)
 	return rc;
 }
 
+int hl_fw_cpucp_engine_core_asid_set(struct hl_device *hdev, u32 asid)
+{
+	struct cpucp_packet pkt;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_ENGINE_CORE_ASID_SET << CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.value = cpu_to_le64(asid);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+						HL_CPUCP_INFO_TIMEOUT_USEC, NULL);
+	if (rc)
+		dev_err(hdev->dev,
+			"Failed on ASID configuration request for engine core, error %d\n",
+			rc);
+
+	return rc;
+}
+
 void hl_fw_ask_hard_reset_without_linux(struct hl_device *hdev)
 {
 	struct static_fw_load_mgr *static_loader =
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 78772fe548b9..fc1bdc07a169 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3065,6 +3065,7 @@ int hl_fw_dynamic_send_protocol_cmd(struct hl_device *hdev,
 int hl_fw_dram_replaced_row_get(struct hl_device *hdev,
 				struct cpucp_hbm_row_info *info);
 int hl_fw_dram_pending_row_get(struct hl_device *hdev, u32 *pend_rows_num);
+int hl_fw_cpucp_engine_core_asid_set(struct hl_device *hdev, u32 asid);
 int hl_pci_bars_map(struct hl_device *hdev, const char * const name[3],
 			bool is_wc[3]);
 int hl_pci_elbi_read(struct hl_device *hdev, u64 addr, u32 *data);
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 0114cb52faad..737c39f33f05 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -386,6 +386,9 @@ enum pq_init_status {
  *
  * CPUCP_PACKET_POWER_SET -
  *       Resets power history of device to 0
+ *
+ * CPUCP_PACKET_ENGINE_CORE_ASID_SET -
+ *       Packet to perform engine core ASID configuration
  */
 
 enum cpucp_packet_id {
@@ -434,6 +437,8 @@ enum cpucp_packet_id {
 	CPUCP_PACKET_HBM_REPLACED_ROWS_INFO_GET,/* internal */
 	CPUCP_PACKET_HBM_PENDING_ROWS_STATUS,	/* internal */
 	CPUCP_PACKET_POWER_SET,			/* internal */
+	CPUCP_PACKET_RESERVED,			/* not used */
+	CPUCP_PACKET_ENGINE_CORE_ASID_SET,	/* internal */
 };
 
 #define CPUCP_PACKET_FENCE_VAL	0xFE8CE7A5
-- 
2.25.1

