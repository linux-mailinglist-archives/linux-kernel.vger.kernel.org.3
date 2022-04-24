Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB250D081
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 10:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238690AbiDXIpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 04:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiDXIpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 04:45:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCCECD65C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 01:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AC32CCE07EB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 08:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E418FC385A7;
        Sun, 24 Apr 2022 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650789758;
        bh=UIWoN2P//UlTM4cY6HIa1i1PJLeaUcv1bQEl/V3IteY=;
        h=From:To:Cc:Subject:Date:From;
        b=sGcwBoV7YZzqs5d1i8EXJoDEGSB3dw5M5bN7RcBs57QHbRRU4u3SLp1hsjrujWcQM
         ygRs08sLg7BbJYTAXa3rotXp8MkZmCNONbRI9KVHPnYlqaGohodhgPzfC17UY0+jgJ
         KvqCiS2VsJUtnOOMQ2tVI33gNZN2OQptjbLEolxddqmVsmkxWS7YySFIqxnF2H+AxO
         9bN9A+5Irsdrw1LuTPoYpe9FHDSh3oKjiLezRi5DbDapPxk1Xlrko0+zFQlrCIQVpl
         dX8JaKinIHbpP3a8L/v6x9KVnhu4FHJVWwR7gX9I5+CCzc0g8N0OLNUoaVt403M49u
         YRTPugKOkh0dg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH] habanalabs: Add separate poll interval value for protocol
Date:   Sun, 24 Apr 2022 11:42:33 +0300
Message-Id: <20220424084233.2824449-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Currently we're using the same poll interval value for both
COMMs protocol(for sending a command and waits for an ACK)
and the device CPU boot phases status waits.
On COMMs protocol this interval should be much lower than the
device CPU boot which may take long time to change status.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c    | 2 +-
 drivers/misc/habanalabs/common/habanalabs.h     | 6 ++++++
 drivers/misc/habanalabs/common/habanalabs_drv.c | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 7d9d58577bcc..828a36af5b14 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1589,7 +1589,7 @@ static int hl_fw_dynamic_wait_for_status(struct hl_device *hdev,
 		le32_to_cpu(dyn_regs->cpu_cmd_status_to_host),
 		status,
 		FIELD_GET(COMMS_STATUS_STATUS_MASK, status) == expected_status,
-		hdev->fw_poll_interval_usec,
+		hdev->fw_comms_poll_interval_usec,
 		timeout);
 
 	if (rc) {
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index a8e6118c0fc7..19f6af59cfc9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -64,6 +64,7 @@
 #define HL_CPUCP_MON_DUMP_TIMEOUT_USEC	10000000 /* 10s */
 
 #define HL_FW_STATUS_POLL_INTERVAL_USEC		10000 /* 10ms */
+#define HL_FW_COMMS_STATUS_PLDM_POLL_INTERVAL_USEC	1000000 /* 1s */
 
 #define HL_PCI_ELBI_TIMEOUT_MSEC	10 /* 10ms */
 
@@ -2717,6 +2718,9 @@ struct hl_reset_info {
  *                                  session.
  * @open_counter: number of successful device open operations.
  * @fw_poll_interval_usec: FW status poll interval in usec.
+ *                         used for CPU boot status
+ * @fw_comms_poll_interval_usec: FW comms/protocol poll interval in usec.
+ *                                  used for COMMs protocols cmds(COMMS_STS_*)
  * @card_type: Various ASICs have several card types. This indicates the card
  *             type of the current device.
  * @major: habanalabs kernel driver major.
@@ -2847,6 +2851,8 @@ struct hl_device {
 	u64				open_counter;
 	u64				fw_poll_interval_usec;
 	ktime_t				last_successful_open_ktime;
+	u64				fw_comms_poll_interval_usec;
+
 	enum cpucp_card_types		card_type;
 	u32				major;
 	u32				high_pll;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index b85ca1e66eb2..57218e03c222 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -301,6 +301,7 @@ static int fixup_device_params(struct hl_device *hdev)
 	hdev->asic_prop.fw_security_enabled = is_asic_secured(hdev->asic_type);
 
 	hdev->fw_poll_interval_usec = HL_FW_STATUS_POLL_INTERVAL_USEC;
+	hdev->fw_comms_poll_interval_usec = HL_FW_STATUS_POLL_INTERVAL_USEC;
 
 	hdev->stop_on_err = true;
 	hdev->reset_info.curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
-- 
2.25.1

