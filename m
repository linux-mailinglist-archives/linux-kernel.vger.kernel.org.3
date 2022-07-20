Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52BF57B526
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiGTLPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTLPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:15:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7568F1BE8D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:15:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14C87B81E20
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8287C3411E;
        Wed, 20 Jul 2022 11:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658315728;
        bh=/MCf6e/7v3s2HuIMTzbjKryVY3ul+vEF18tRV5+EWR0=;
        h=From:To:Cc:Subject:Date:From;
        b=n9Gn5WJxcopa8MRhnChIH3XEMk1JQ6zgp5DiAglMrWXz7tiikFldWSDIQ5ZJF3bUP
         hxqrSeYhozcQcDnFqYI3KHX5ctiHl8xvhYc4dp/xE3Ieg0hlSD0FGoERYTiruJFb45
         Dv3n7Qma6iYaN5okWrHKr391mY4JTO/uEXjT8ub8VcYgwy4xb4pt96fYx5I8L8/IMS
         QpbCgUz8xm7nla+BgP6eNOybf0XJayjEcp1IUXQ0br9FPMw0rBgTtDqOIQmyv3P/EI
         E058o+K7fLbG+EbXUSLI3fltxIqFLhXsBcAEtthzStV2VpgZ2NpaSDdpbf3GhajgJL
         eU3HjCysh+5FQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/9] habanalabs: rename non_hard_reset to compute_reset
Date:   Wed, 20 Jul 2022 14:15:15 +0300
Message-Id: <20220720111523.4069830-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to be more explicit we should use the term compute_reset
for describing the reset in which only the compute engines gets
reset.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 2 +-
 drivers/misc/habanalabs/common/habanalabs.h | 4 ++--
 drivers/misc/habanalabs/gaudi/gaudi.c       | 4 ++--
 drivers/misc/habanalabs/gaudi2/gaudi2.c     | 4 ++--
 drivers/misc/habanalabs/goya/goya.c         | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index b30aeb1c657f..90e346727a7c 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1556,7 +1556,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		if (!hdev->asic_prop.fw_security_enabled)
 			hl_fw_set_max_power(hdev);
 	} else {
-		rc = hdev->asic_funcs->non_hard_reset_late_init(hdev);
+		rc = hdev->asic_funcs->compute_reset_late_init(hdev);
 		if (rc) {
 			if (reset_upon_device_release)
 				dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 4d6b31ea1efb..1e1f2c494423 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1446,7 +1446,7 @@ struct engines_data {
  * @send_heartbeat: send is-alive packet to CPU-CP and verify response.
  * @debug_coresight: perform certain actions on Coresight for debugging.
  * @is_device_idle: return true if device is idle, false otherwise.
- * @non_hard_reset_late_init: perform certain actions needed after a reset which is not hard-reset
+ * @compute_reset_late_init: perform certain actions needed after a compute reset
  * @hw_queues_lock: acquire H/W queues lock.
  * @hw_queues_unlock: release H/W queues lock.
  * @kdma_lock: acquire H/W queues lock. Relevant from GRECO ASIC
@@ -1584,7 +1584,7 @@ struct hl_asic_funcs {
 	int (*debug_coresight)(struct hl_device *hdev, struct hl_ctx *ctx, void *data);
 	bool (*is_device_idle)(struct hl_device *hdev, u64 *mask_arr, u8 mask_len,
 				struct engines_data *e);
-	int (*non_hard_reset_late_init)(struct hl_device *hdev);
+	int (*compute_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
 	void (*hw_queues_unlock)(struct hl_device *hdev);
 	void (*kdma_lock)(struct hl_device *hdev, int dcore_id);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index a7923960fce1..20f62730be02 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7427,7 +7427,7 @@ static void gaudi_print_nic_axi_irq_info(struct hl_device *hdev, u16 event_type,
 		event_type, desc);
 }
 
-static int gaudi_non_hard_reset_late_init(struct hl_device *hdev)
+static int gaudi_compute_reset_late_init(struct hl_device *hdev)
 {
 	/* GAUDI doesn't support any reset except hard-reset */
 	return -EPERM;
@@ -9193,7 +9193,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.send_heartbeat = gaudi_send_heartbeat,
 	.debug_coresight = gaudi_debug_coresight,
 	.is_device_idle = gaudi_is_device_idle,
-	.non_hard_reset_late_init = gaudi_non_hard_reset_late_init,
+	.compute_reset_late_init = gaudi_compute_reset_late_init,
 	.hw_queues_lock = gaudi_hw_queues_lock,
 	.hw_queues_unlock = gaudi_hw_queues_unlock,
 	.kdma_lock = NULL,
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index fd917e837075..ab6ad06cec03 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -6129,7 +6129,7 @@ static int gaudi2_test_queues(struct hl_device *hdev)
 	return ret_val;
 }
 
-static int gaudi2_non_hard_reset_late_init(struct hl_device *hdev)
+static int gaudi2_compute_reset_late_init(struct hl_device *hdev)
 {
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 	size_t irq_arr_size;
@@ -9930,7 +9930,7 @@ static const struct hl_asic_funcs gaudi2_funcs = {
 	.send_heartbeat = gaudi2_send_heartbeat,
 	.debug_coresight = gaudi2_debug_coresight,
 	.is_device_idle = gaudi2_is_device_idle,
-	.non_hard_reset_late_init = gaudi2_non_hard_reset_late_init,
+	.compute_reset_late_init = gaudi2_compute_reset_late_init,
 	.hw_queues_lock = gaudi2_hw_queues_lock,
 	.hw_queues_unlock = gaudi2_hw_queues_unlock,
 	.kdma_lock = gaudi2_kdma_lock,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 7b9f7f8b51f4..d4459c290ea8 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4559,7 +4559,7 @@ static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
 	return rc;
 }
 
-static int goya_non_hard_reset_late_init(struct hl_device *hdev)
+static int goya_compute_reset_late_init(struct hl_device *hdev)
 {
 	/*
 	 * Unmask all IRQs since some could have been received
@@ -5478,7 +5478,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.send_heartbeat = goya_send_heartbeat,
 	.debug_coresight = goya_debug_coresight,
 	.is_device_idle = goya_is_device_idle,
-	.non_hard_reset_late_init = goya_non_hard_reset_late_init,
+	.compute_reset_late_init = goya_compute_reset_late_init,
 	.hw_queues_lock = goya_hw_queues_lock,
 	.hw_queues_unlock = goya_hw_queues_unlock,
 	.kdma_lock = NULL,
-- 
2.25.1

