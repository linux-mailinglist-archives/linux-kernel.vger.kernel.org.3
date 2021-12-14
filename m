Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903B64745F5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhLNPGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:06:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34786 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhLNPGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:06:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F8BAB81A2C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8078DC34605;
        Tue, 14 Dec 2021 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494359;
        bh=NpbaHXRKC+KHf1PmmINvdK198LgN9X8s3/B8wZ1moaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVFT2hszhx7+eI1bCn6V2qtw8Z6M5cNjGHUWQy71g8LBr2C7YaMpHvez6vhB14LmU
         rds0U/bDaPUJBdr/6ot8yU9W6Tejx23yj90nNSEjJuhQ9jlbIjgpZr4vxER+dsJBy8
         AV2UG3ZF6dhOJvrq1neoAvQLOgSHgo6sjX9N6iUGW2MbmmK8lIMBsgiuElYa3JFHCN
         2z+m5LlzzyG4uTolca46wvuANBd4rL8AUPP3H4JiHD3DSUZeuiW8Fu8O5rQ3mhHJph
         ICbYn0H7XdsRdOL2wISs5If/JaMnHhQtqyjEwzQBMYSHQU7eNc5px1NwFA2kTbUnF2
         wtAjpcFOKYcPQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 03/11] habanalabs: add current PI value to cpu packets
Date:   Tue, 14 Dec 2021 17:05:43 +0200
Message-Id: <20211214150551.1568192-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214150551.1568192-1-ogabbay@kernel.org>
References: <20211214150551.1568192-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to increase cpucp messaging reliability we will add
the current PI value to the descriptor sent to F/W.
F/W will wait for the PI value as an indication of a valid packet.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 76741898d922..ba9a17ddc3a4 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -246,7 +246,7 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 	 * Which means that we don't need to lock the access to the entire H/W
 	 * queues module when submitting a JOB to the CPU queue.
 	 */
-	hl_hw_queue_submit_bd(hdev, queue, 0, len, pkt_dma_addr);
+	hl_hw_queue_submit_bd(hdev, queue, hl_queue_inc_ptr(queue->pi), len, pkt_dma_addr);
 
 	if (prop->fw_app_cpu_boot_dev_sts0 & CPU_BOOT_DEV_STS0_PKT_PI_ACK_EN)
 		expected_ack_val = queue->pi;
-- 
2.25.1

