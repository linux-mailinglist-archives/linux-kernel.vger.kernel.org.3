Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1D656D4BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiGKGaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiGKGaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:30:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C828495B6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 680C0B80DA0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0F2C3411C;
        Mon, 11 Jul 2022 06:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657521010;
        bh=kztKjfZwBV+xAOiRweckqGY7gkQsDOqD3aaVL1Waf0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nedEgdcdy35X7b3kyV9Cj+/Yw02ELtHEO5a4GvoByqTPXDo3fMMqdhwGARoej0hIA
         JgiVwglHNqRS+azI0uLK3zgGbEenWZJVMlnPsW7w06CaS575c+IsaU9L72DRsdsjZY
         7zpNb54h4ycH6Qlj4hggSWIu0K3rsGtnXt7jUm2/Y2wJwzRf8Mnjo3zn2SJ6G+1coN
         f57ecLMINUvnlicn3D/E99LqzI9w1oJFTaTvCuoZa30JSfofiKnwSLfangiIE+SdpB
         jSNolFU/E5ybjMKcfwLjk0EKocIRS0oWlRjHYjSmZSQOOZj+1qDfvkWXyJ6d+FthCL
         6hJLWQlIWJJag==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 02/12] habanalabs: add a value field to hl_fw_send_pci_access_msg()
Date:   Mon, 11 Jul 2022 09:29:53 +0300
Message-Id: <20220711063003.3182795-2-ogabbay@kernel.org>
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

For gaudi2 we need to send a value to F/W as part of the
PCI_ACCESS packet.
As a preparation, modify hl_fw_send_pci_access_msg() to have a 'value'
field.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c      | 5 ++---
 drivers/misc/habanalabs/common/firmware_if.c | 6 +++---
 drivers/misc/habanalabs/common/habanalabs.h  | 2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c        | 6 +++---
 drivers/misc/habanalabs/gaudi2/gaudi2.c      | 6 +++---
 drivers/misc/habanalabs/goya/goya.c          | 4 ++--
 6 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 5a76d7689abe..4391eb22ddb8 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1259,8 +1259,7 @@ static void handle_reset_trigger(struct hl_device *hdev, u32 flags)
 		 * of heartbeat, the device CPU is marked as disable
 		 * so this message won't be sent
 		 */
-		if (hl_fw_send_pci_access_msg(hdev,
-				CPUCP_PACKET_DISABLE_PCI_ACCESS))
+		if (hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS, 0x0))
 			dev_warn(hdev->dev,
 				"Failed to disable PCI access by F/W\n");
 	}
@@ -2054,7 +2053,7 @@ void hl_device_fini(struct hl_device *hdev)
 	 * message won't be send. Also, in case of heartbeat, the device CPU is
 	 * marked as disable so this message won't be sent
 	 */
-	hl_fw_send_pci_access_msg(hdev,	CPUCP_PACKET_DISABLE_PCI_ACCESS);
+	hl_fw_send_pci_access_msg(hdev,	CPUCP_PACKET_DISABLE_PCI_ACCESS, 0x0);
 
 	/* Mark device as disabled */
 	hdev->disabled = true;
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index fd8dd332a59a..f80a8c9d2cc8 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -242,14 +242,14 @@ int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 	return rc;
 }
 
-int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
+int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode, u64 value)
 {
 	struct cpucp_packet pkt = {};
 
 	pkt.ctl = cpu_to_le32(opcode << CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.value = cpu_to_le64(value);
 
-	return hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt,
-						sizeof(pkt), 0, NULL);
+	return hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt), 0, NULL);
 }
 
 int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 3c51eaca521c..0e45f2be13ed 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3631,7 +3631,7 @@ bool hl_is_dram_va(struct hl_device *hdev, u64 virt_addr);
 
 int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 				void __iomem *dst, u32 src_offset, u32 size);
-int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode);
+int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode, u64 value);
 int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 				u16 len, u32 timeout, u64 *result);
 int hl_fw_unmask_irq(struct hl_device *hdev, u16 event_type);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 1f84dd6f3adb..8c1b1824d1a9 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1632,7 +1632,7 @@ static int gaudi_late_init(struct hl_device *hdev)
 		gaudi->hw_cap_initialized &= ~(HW_CAP_NIC0 | HW_CAP_NIC1);
 	}
 
-	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS);
+	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS, 0x0);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to enable PCI access from CPU\n");
 		return rc;
@@ -1677,7 +1677,7 @@ static int gaudi_late_init(struct hl_device *hdev)
 	return 0;
 
 disable_pci_access:
-	hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS);
+	hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS, 0x0);
 
 	return rc;
 }
@@ -4236,7 +4236,7 @@ static int gaudi_suspend(struct hl_device *hdev)
 {
 	int rc;
 
-	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS);
+	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS, 0x0);
 	if (rc)
 		dev_err(hdev->dev, "Failed to disable PCI access from CPU\n");
 
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 26f105a84e6b..d9a85ea56f75 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -2675,7 +2675,7 @@ static int gaudi2_late_init(struct hl_device *hdev)
 {
 	int rc;
 
-	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS);
+	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS, 0x0);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to enable PCI access from CPU\n");
 		return rc;
@@ -2694,7 +2694,7 @@ static int gaudi2_late_init(struct hl_device *hdev)
 	return 0;
 
 disable_pci_access:
-	hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS);
+	hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS, 0x0);
 
 	return rc;
 }
@@ -5323,7 +5323,7 @@ static int gaudi2_suspend(struct hl_device *hdev)
 {
 	int rc;
 
-	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS);
+	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS, 0x0);
 	if (rc)
 		dev_err(hdev->dev, "Failed to disable PCI access from CPU\n");
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 0c333b42225a..216570938b91 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -888,7 +888,7 @@ int goya_late_init(struct hl_device *hdev)
 	 */
 	WREG32(mmMMU_LOG2_DDR_SIZE, ilog2(prop->dram_size));
 
-	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS);
+	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS, 0x0);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to enable PCI access from CPU %d\n", rc);
@@ -2878,7 +2878,7 @@ int goya_suspend(struct hl_device *hdev)
 {
 	int rc;
 
-	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS);
+	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS, 0x0);
 	if (rc)
 		dev_err(hdev->dev, "Failed to disable PCI access from CPU\n");
 
-- 
2.25.1

