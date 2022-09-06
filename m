Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A27C5AEEE4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbiIFPdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiIFPc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:32:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94749C3F4E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:43:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3710B818B4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50A8C433D6;
        Tue,  6 Sep 2022 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662475408;
        bh=FCP0TY9E1cwnNuLc1Z4zV9ivkDz5aeGhEOpzIoB0tGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXX1bBniJo98VZfw9vgGYLkVS4SObLST04kBdtX4VqT3ghEfiMILIRS86a1/VOwAK
         l2qUcWsxRD2Uu8qb6L8ibqNlDWh2gMge2P/ikAwAeFAMGSDqevw111eUnriHsFjgjQ
         Hsgz7cskOaILH4+NjTSZ+0n4DdjtII8Xihr6U0wvtyX2soLjmGtPyxMemJ7eHDgB3w
         u7ao3mJvIO4meSGYzUlwVGUCPDQE3NJ5UjzLbvFMGsCs/JSvbIhZ6SzkkzZgzjhMVX
         JvzId3am8yFXfqu9oeWZKXDP7bMgeLseEL62dQyOnqKQbuPKBuO07PnEkwvRccRyn4
         GPbRaqrx1fvWA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 4/9] habanalabs/gaudi2: read F/W security indication after hard reset
Date:   Tue,  6 Sep 2022 17:43:13 +0300
Message-Id: <20220906144318.1890416-4-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

F/W security status might change after every reset.

Add the reading of the preboot status to the hard reset sequence, which
among others reads this security indication.

As this preboot status reading includes the waiting for the preboot to
be ready, it can be removed from the CPU init which is done in a later
stage.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c      | 7 +++++++
 drivers/misc/habanalabs/common/firmware_if.c | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index a59cbbc8965f..9407b14d4b0d 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1585,6 +1585,13 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	 */
 	hdev->disabled = false;
 
+	/* F/W security enabled indication might be updated after hard-reset */
+	if (hard_reset) {
+		rc = hl_fw_read_preboot_status(hdev);
+		if (rc)
+			goto out_err;
+	}
+
 	rc = hdev->asic_funcs->hw_init(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize the H/W after reset\n");
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index cd2eb7e73be5..8bfb459a8282 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2509,13 +2509,6 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	 */
 	dyn_regs = &fw_loader->dynamic_loader.comm_desc.cpu_dyn_regs;
 
-	/* if no preboot loaded indication- wait for preboot */
-	if (!(hdev->fw_loader.fw_comp_loaded & FW_TYPE_PREBOOT_CPU)) {
-		rc = hl_fw_wait_preboot_ready(hdev);
-		if (rc)
-			return -EIO;
-	}
-
 	rc = hl_fw_dynamic_send_protocol_cmd(hdev, fw_loader, COMMS_RST_STATE,
 						0, true,
 						fw_loader->cpu_timeout);
-- 
2.25.1

