Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0F84AE23C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386077AbiBHT3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386057AbiBHT3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:29:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84077C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:29:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43721B81D41
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4099DC340ED;
        Tue,  8 Feb 2022 19:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644348540;
        bh=8nfSl8r7WhFzC+yfSwUCp3GSiZbNVVuBBSfDHLIk7f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NFEmUzFkHpQpJRZfDK33kIeSusQionqhpWxwhCM7Rbp6qig8Ax0u0qu1Y4+LXpb/v
         /Np5dOK1Ajbp30/oseLvN0MDcT8FiKD1qEldP6RDK0xgkg/GhPcJxql7C4AV2rdRPh
         Rb72K5PhV8Y5tQfrj0g4hhGedm2qhWguPQvyaB6eJEWkFMD2vM2g1nSDDoNJ9aHwcc
         PDjIOEyxKi+rT2as8M3rpP2LedRh10H+sXat88dfD//uznuEK9Be+PK2GvBnCKS/GN
         O7i7Xrjl0d60geN+zdyHqWuLr68FksqeguA7aAhVBENwGlAMBwAl1JBZzTHk8B3dBk
         SPX38bXObcZvQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 4/4] habanalabs: set max power on device init per ASIC
Date:   Tue,  8 Feb 2022 21:28:50 +0200
Message-Id: <20220208192850.3526511-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208192850.3526511-1-ogabbay@kernel.org>
References: <20220208192850.3526511-1-ogabbay@kernel.org>
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

For current devices there is a need to send the max power value to F/W
during device init, for example because there might be several card
types.
In future devices, this info will be programmed in the device's EEPROM
and will be read by F/W, and hence the driver should not send it.

Modify the sending of the relevant message to be done only for ASIC
types that need it.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 3 ++-
 drivers/misc/habanalabs/common/habanalabs.h | 2 ++
 drivers/misc/habanalabs/gaudi/gaudi.c       | 2 ++
 drivers/misc/habanalabs/goya/goya.c         | 2 ++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 63e2449ad136..8ea9dfe3f79b 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1541,7 +1541,8 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	/* Need to call this again because the max power might change,
 	 * depending on card type for certain ASICs
 	 */
-	hl_fw_set_max_power(hdev);
+	if (hdev->asic_prop.set_max_power_on_device_init)
+		hl_fw_set_max_power(hdev);
 
 	/*
 	 * hl_hwmon_init() must be called after device_late_init(), because only
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 93116fe71ef6..b5055ab528b8 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -562,6 +562,7 @@ struct hl_hints_range {
  *                              to the fact that training runs on multiple
  *                              devices)
  * @configurable_stop_on_err: is stop-on-error option configurable via debugfs.
+ * @set_max_power_on_device_init: true if need to set max power in F/W on device init.
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
@@ -646,6 +647,7 @@ struct asic_fixed_properties {
 	u8				supports_soft_reset;
 	u8				allow_inference_soft_reset;
 	u8				configurable_stop_on_err;
+	u8				set_max_power_on_device_init;
 };
 
 /**
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 61aa6dce6dde..ad640a268a3c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -671,6 +671,8 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 
 	prop->configurable_stop_on_err = true;
 
+	prop->set_max_power_on_device_init = true;
+
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c8143b6616af..c08d96e43c9f 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -485,6 +485,8 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 
 	prop->configurable_stop_on_err = true;
 
+	prop->set_max_power_on_device_init = true;
+
 	return 0;
 }
 
-- 
2.25.1

