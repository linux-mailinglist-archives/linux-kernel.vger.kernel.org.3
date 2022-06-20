Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501F6551CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345680AbiFTNOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344203AbiFTNKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047CC1C90C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 344F161531
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE253C385A2;
        Mon, 20 Jun 2022 13:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730285;
        bh=XrEBOe9xjcJ/LnVKgGjK9+wCo3I/byuEwEXiFATHKAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKaBPRsy8/Ki7ltaoJSLt0bYTQBfRMaLgY+rk5Mf7uFx67N2jvXTGRhsnoJHYTCbt
         0SS1osABRjzr/ngGS8TFUikjozkiUQGAWl3yJ6Uf4+GDlURQQXh2ZhtVGUnRsmiWg3
         ooGNWDcPOgGYW6pZRXLAvv+UHqiWWDjs+HSrs6+wrKyxWfT7Mkp2+xObo6TspsJF+B
         kCdM2r2NqIFdfH1Baeo2+Inwtcu9lB+Oq7IFNNTp5VXIMMGC8xF7ygwClG5/ec/rdx
         RPbTYuE1CkKcjEhKZrns/bFw6UdlrIZ+y0yIky8wK8Of0vlzU43Jgny9/sjs7apgOC
         GwUj2LDXYKlpQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 06/17] habanalabs: avoid unnecessary error print
Date:   Mon, 20 Jun 2022 16:04:21 +0300
Message-Id: <20220620130432.1180451-6-ogabbay@kernel.org>
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

From: Dani Liberman <dliberman@habana.ai>

When sending a packet to FW right after it made reset, we will get
packet timeout. Since it is expected behavior, we don't need to
print an error in such case.
Hence, when driver is in hard reset it will avoid from printing error
messages about packet timeout.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 828a36af5b14..bd66e4f84156 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -267,7 +267,14 @@ int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
 	hl_hw_queue_inc_ci_kernel(hdev, hw_queue_id);
 
 	if (rc == -ETIMEDOUT) {
-		dev_err(hdev->dev, "Device CPU packet timeout (0x%x)\n", tmp);
+		/* If FW performed reset just before sending it a packet, we will get a timeout.
+		 * This is expected behavior, hence no need for error message.
+		 */
+		if (!hl_device_operational(hdev, NULL) && !hdev->reset_info.is_in_soft_reset)
+			dev_dbg(hdev->dev, "Device CPU packet timeout (0x%x) due to FW reset\n",
+					tmp);
+		else
+			dev_err(hdev->dev, "Device CPU packet timeout (0x%x)\n", tmp);
 		hdev->device_cpu_disabled = true;
 		goto out;
 	}
-- 
2.25.1

