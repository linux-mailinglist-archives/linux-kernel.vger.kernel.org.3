Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA33551CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbiFTNQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344146AbiFTNJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:09:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF391C136
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:05:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56B9961575
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9D2C3411B;
        Mon, 20 Jun 2022 13:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730281;
        bh=jSR7IjcsR2+GyvGmEMWqDNbvzujtbnJRgMjf3an/hzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OPwQpG4D/fChawGIcHTnzG6nEzuJ9m6J8uvTmYEz1qWHw51OOXYD8EISYwL+nwsr1
         qj/GiHnnPhOQUyWCp558ni+8VuU7Gvk0h7I2Oi6niMOVsm6BDkuICVmIZKuooxoSaC
         Bwmsx/ej5XM44Ftkqz2Felbx2nHcyVCUar3Vk4CtuVr7iciNL+VQ/w1Hr+gHVvHRkj
         hI6Sk9XVpUdfWzvrHclyN8Q6GadqAHey/96VnASbIUUCtugrhOg/mSkQrOowucSXkj
         Dwb5e51asL2JmGK+1WY8YbwZ5abPFYEOQbR3Uk+QGOs8Skzi0E2RtUydszV3NQpxsM
         el8agfoblgjJQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 03/17] habanalabs/gaudi: invoke device reset from one code block
Date:   Mon, 20 Jun 2022 16:04:18 +0300
Message-Id: <20220620130432.1180451-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620130432.1180451-1-ogabbay@kernel.org>
References: <20220620130432.1180451-1-ogabbay@kernel.org>
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

In order to prepare the driver code for device reset event
notification, change the event handler function flow to call
device reset from one code block.

In addition, the commit fixes an issue that reset was performed
w/o checking the 'hard_reset_on_fw_event' state and w/o setting
the HL_DRV_RESET_DELAY flag.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index ec9f0a93cbe2..8f37297b2c3b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7795,10 +7795,10 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	u64 data = le64_to_cpu(eq_entry->data[0]), event_mask = 0;
 	u32 ctl = le32_to_cpu(eq_entry->hdr.ctl);
-	u32 fw_fatal_err_flag = 0;
+	u32 fw_fatal_err_flag = 0, flags = 0;
 	u16 event_type = ((ctl & EQ_CTL_EVENT_TYPE_MASK)
 			>> EQ_CTL_EVENT_TYPE_SHIFT);
-	bool reset_required;
+	bool reset_required, reset_direct = false;
 	u8 cause;
 	int rc;
 
@@ -7886,7 +7886,8 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 			dev_err(hdev->dev, "reset required due to %s\n",
 				gaudi_irq_map_table[event_type].name);
 
-			hl_device_reset(hdev, 0);
+			reset_direct = true;
+			goto reset_device;
 		} else {
 			hl_fw_unmask_irq(hdev, event_type);
 		}
@@ -7908,7 +7909,8 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 			dev_err(hdev->dev, "reset required due to %s\n",
 				gaudi_irq_map_table[event_type].name);
 
-			hl_device_reset(hdev, 0);
+			reset_direct = true;
+			goto reset_device;
 		} else {
 			hl_fw_unmask_irq(hdev, event_type);
 		}
@@ -8050,12 +8052,17 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	return;
 
 reset_device:
-	if (hdev->asic_prop.fw_security_enabled)
-		hl_device_reset(hdev, HL_DRV_RESET_HARD
-					| HL_DRV_RESET_BYPASS_REQ_TO_FW
-					| fw_fatal_err_flag);
+	reset_required = true;
+
+	if (hdev->asic_prop.fw_security_enabled && !reset_direct)
+		flags = HL_DRV_RESET_HARD | HL_DRV_RESET_BYPASS_REQ_TO_FW | fw_fatal_err_flag;
 	else if (hdev->hard_reset_on_fw_events)
-		hl_device_reset(hdev, HL_DRV_RESET_HARD | HL_DRV_RESET_DELAY | fw_fatal_err_flag);
+		flags = HL_DRV_RESET_HARD | HL_DRV_RESET_DELAY | fw_fatal_err_flag;
+	else
+		reset_required = false;
+
+	if (reset_required)
+		hl_device_reset(hdev, flags);
 	else
 		hl_fw_unmask_irq(hdev, event_type);
 }
-- 
2.25.1

