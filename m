Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AB94BA298
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241748AbiBQOJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:09:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbiBQOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:09:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2892C2B1658
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:09:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8552B61D45
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5512EC340E9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645106956;
        bh=IX5nWajQNmRX/7Lq4dd9j03HA7qxL1xt07az0HEa/TI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nmbs8+o98l1HpMaoPhGgu+zMeTNYUhmWtyaP84plMQcxxQPnjftl3TB+DMzmeJ1aF
         jDz2c0Y90vcUMw0zYCqoXu1u4eLhopYwuxa/59b4Bz/OTNCBfbtZWngiyrJ8chzXQ+
         VmJ4nJYdZx9qKqXtjiZnBQHGv2vz+I71oQA1C1zX9ZhlVZPpsKh54QPRuos7Vvm+bp
         0tZVn9FxdDx8pr+gZa/A0bIHA8djUWkfCz2iqyU9gAR3FS2QXyfIpXtsFndAsuhBie
         UnDSqq+yxklFRZ1119zVDZ1x8C2UyfAJYaYqBptWRsX+sdXJ5C5VdV4t0AIUSFhfgj
         mOSfcCpiXx/aw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] habanalabs/gaudi: add missing handling of NIC related events
Date:   Thu, 17 Feb 2022 16:09:12 +0200
Message-Id: <20220217140912.156824-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217140912.156824-1-ogabbay@kernel.org>
References: <20220217140912.156824-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few events that can arrive from the f/w and without proper
handling can cause errors to appear in the kernel log without reason.

Add the relevant handling that was missing.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c                  |  5 +++++
 .../misc/habanalabs/include/gaudi/gaudi_async_events.h | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 95201d995743..0eed0efae040 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7977,6 +7977,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_PSOC_MEM_DERR:
 	case GAUDI_EVENT_PSOC_CORESIGHT_DERR:
 	case GAUDI_EVENT_SRAM0_DERR ... GAUDI_EVENT_SRAM28_DERR:
+	case GAUDI_EVENT_NIC0_DERR ... GAUDI_EVENT_NIC4_DERR:
 	case GAUDI_EVENT_DMA_IF0_DERR ... GAUDI_EVENT_DMA_IF3_DERR:
 	case GAUDI_EVENT_HBM_0_DERR ... GAUDI_EVENT_HBM_3_DERR:
 	case GAUDI_EVENT_MMU_DERR:
@@ -8077,6 +8078,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 	case GAUDI_EVENT_PSOC_MEM_SERR:
 	case GAUDI_EVENT_PSOC_CORESIGHT_SERR:
 	case GAUDI_EVENT_SRAM0_SERR ... GAUDI_EVENT_SRAM28_SERR:
+	case GAUDI_EVENT_NIC0_SERR ... GAUDI_EVENT_NIC4_SERR:
 	case GAUDI_EVENT_DMA_IF0_SERR ... GAUDI_EVENT_DMA_IF3_SERR:
 	case GAUDI_EVENT_HBM_0_SERR ... GAUDI_EVENT_HBM_3_SERR:
 		fallthrough;
@@ -8154,6 +8156,9 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
+	case GAUDI_EVENT_STATUS_NIC0_ENG0 ... GAUDI_EVENT_STATUS_NIC4_ENG1:
+		break;
+
 	case GAUDI_EVENT_FIX_POWER_ENV_S ... GAUDI_EVENT_FIX_THERMAL_ENV_E:
 		gaudi_print_clk_change_info(hdev, event_type);
 		hl_fw_unmask_irq(hdev, event_type);
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
index d966bd4dfea6..c07ed4ed304c 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
@@ -311,6 +311,16 @@ enum gaudi_async_event_id {
 	GAUDI_EVENT_FW_ALIVE_S = 645,
 	GAUDI_EVENT_DEV_RESET_REQ = 646,
 	GAUDI_EVENT_PKT_QUEUE_OUT_SYNC = 647,
+	GAUDI_EVENT_STATUS_NIC0_ENG0 = 648,
+	GAUDI_EVENT_STATUS_NIC0_ENG1 = 649,
+	GAUDI_EVENT_STATUS_NIC1_ENG0 = 650,
+	GAUDI_EVENT_STATUS_NIC1_ENG1 = 651,
+	GAUDI_EVENT_STATUS_NIC2_ENG0 = 652,
+	GAUDI_EVENT_STATUS_NIC2_ENG1 = 653,
+	GAUDI_EVENT_STATUS_NIC3_ENG0 = 654,
+	GAUDI_EVENT_STATUS_NIC3_ENG1 = 655,
+	GAUDI_EVENT_STATUS_NIC4_ENG0 = 656,
+	GAUDI_EVENT_STATUS_NIC4_ENG1 = 657,
 	GAUDI_EVENT_FIX_POWER_ENV_S = 658,
 	GAUDI_EVENT_FIX_POWER_ENV_E = 659,
 	GAUDI_EVENT_FIX_THERMAL_ENV_S = 660,
-- 
2.25.1

