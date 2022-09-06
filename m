Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8562E5AEEE2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbiIFPdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiIFPc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A546C3F49
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:43:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C072A61558
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467ABC433C1;
        Tue,  6 Sep 2022 14:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662475410;
        bh=0Es1BceSOJwL7i9c8RCQLR1JeMcRpykCa6VbCcu9uog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTs+r7yN7xX6AeCnjVc0zvCwhyWErW5CLhiJe3appOoRtq5syghgryXaETHo64Gqq
         64t1YrrNsE+PbQZHICNptp/WORlGuQz5XgFSg3Ib9oc0w9GUVtqV524qlvuB6c1F6V
         IpZrIIm0U+XrJ10/vIzPNdgZ0dBnTv2BFi1kMJpRqf18OqK+Es46yRrfHViOJ/CLIX
         ptV51LZwZami0o9QngFtxdcnPOvzsmReycnp4yB2fJrVwwiXeatmHw6XYMqB5qkIHf
         0deGpkkEzzKSPMCstkzEwFgJ90wfIIValRY2naBy5t2pYVuQt++S9ZTEF3Xjmu4Zsj
         poanZjjDH1lkg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 5/9] habanalabs: add support for new cpucp return codes
Date:   Tue,  6 Sep 2022 17:43:14 +0300
Message-Id: <20220906144318.1890416-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906144318.1890416-1-ogabbay@kernel.org>
References: <20220906144318.1890416-1-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

Firmware now responds with a more detailed cpucp return codes.
Driver can now distinguish between error and debug return codes.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c  | 34 +++++++++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h   |  2 ++
 drivers/misc/habanalabs/gaudi2/gaudi2.c       |  2 ++
 .../misc/habanalabs/include/common/cpucp_if.h | 17 +++++++++-
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 8bfb459a8282..c2375917fc02 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -252,7 +252,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 	struct cpucp_packet *pkt;
 	dma_addr_t pkt_dma_addr;
 	struct hl_bd *sent_bd;
-	u32 tmp, expected_ack_val, pi;
+	u32 tmp, expected_ack_val, pi, opcode;
 	int rc;
 
 	pkt = hl_cpu_accessible_dma_pool_alloc(hdev, len, &pkt_dma_addr);
@@ -319,8 +319,35 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 
 	rc = (tmp & CPUCP_PKT_CTL_RC_MASK) >> CPUCP_PKT_CTL_RC_SHIFT;
 	if (rc) {
-		dev_dbg(hdev->dev, "F/W ERROR %d for CPU packet %d\n",
-			rc, (tmp & CPUCP_PKT_CTL_OPCODE_MASK) >> CPUCP_PKT_CTL_OPCODE_SHIFT);
+		opcode = (tmp & CPUCP_PKT_CTL_OPCODE_MASK) >> CPUCP_PKT_CTL_OPCODE_SHIFT;
+
+		if (!prop->supports_advanced_cpucp_rc) {
+			dev_dbg(hdev->dev, "F/W ERROR %d for CPU packet %d\n", rc, opcode);
+			goto scrub_descriptor;
+		}
+
+		switch (rc) {
+		case cpucp_packet_invalid:
+			dev_err(hdev->dev,
+				"CPU packet %d is not supported by F/W\n", opcode);
+			break;
+		case cpucp_packet_fault:
+			dev_err(hdev->dev,
+				"F/W failed processing CPU packet %d\n", opcode);
+			break;
+		case cpucp_packet_invalid_pkt:
+			dev_dbg(hdev->dev,
+				"CPU packet %d is not supported by F/W\n", opcode);
+			break;
+		case cpucp_packet_invalid_params:
+			dev_err(hdev->dev,
+				"F/W reports invalid parameters for CPU packet %d\n", opcode);
+			break;
+
+		default:
+			dev_err(hdev->dev,
+				"Unknown F/W ERROR %d for CPU packet %d\n", rc, opcode);
+		}
 
 		/* propagate the return code from the f/w to the callers who want to check it */
 		if (result)
@@ -332,6 +359,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 		*result = le64_to_cpu(pkt->result);
 	}
 
+scrub_descriptor:
 	/* Scrub previous buffer descriptor 'ctl' field which contains the
 	 * previous PI value written during packet submission.
 	 * We must do this or else F/W can read an old value upon queue wraparound.
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 5083c5098941..4d7681a2b40a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -678,6 +678,7 @@ struct hl_hints_range {
  * @set_max_power_on_device_init: true if need to set max power in F/W on device init.
  * @supports_user_set_page_size: true if user can set the allocation page size.
  * @dma_mask: the dma mask to be set for this device
+ * @supports_advanced_cpucp_rc: true if new cpucp opcodes are supported.
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -785,6 +786,7 @@ struct asic_fixed_properties {
 	u8				set_max_power_on_device_init;
 	u8				supports_user_set_page_size;
 	u8				dma_mask;
+	u8				supports_advanced_cpucp_rc;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index a0b15b2f2ea4..db18e066509c 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -2721,6 +2721,8 @@ static int gaudi2_late_init(struct hl_device *hdev)
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 	int rc;
 
+	hdev->asic_prop.supports_advanced_cpucp_rc = true;
+
 	rc = hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_ENABLE_PCI_ACCESS,
 					gaudi2->virt_msix_db_dma_addr);
 	if (rc) {
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index b837bb1f4cd3..9593d1a26945 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -824,10 +824,25 @@ enum cpucp_led_index {
 	CPUCP_LED2_INDEX
 };
 
+/*
+ * enum cpucp_packet_rc - Error return code
+ * @cpucp_packet_success	-> in case of success.
+ * @cpucp_packet_invalid	-> this is to support Goya and Gaudi platform.
+ * @cpucp_packet_fault		-> in case of processing error like failing to
+ *                                 get device binding or semaphore etc.
+ * @cpucp_packet_invalid_pkt	-> when cpucp packet is un-supported. This is
+ *                                 supported Greco onwards.
+ * @cpucp_packet_invalid_params	-> when checking parameter like length of buffer
+ *				   or attribute value etc. Supported Greco onwards.
+ * @cpucp_packet_rc_max		-> It indicates size of enum so should be at last.
+ */
 enum cpucp_packet_rc {
 	cpucp_packet_success,
 	cpucp_packet_invalid,
-	cpucp_packet_fault
+	cpucp_packet_fault,
+	cpucp_packet_invalid_pkt,
+	cpucp_packet_invalid_params,
+	cpucp_packet_rc_max
 };
 
 /*
-- 
2.25.1

