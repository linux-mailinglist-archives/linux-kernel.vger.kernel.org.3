Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0585496DBD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiAVT55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbiAVT5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8B9C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:57:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4CF5DCE0171
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F44C340E5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881466;
        bh=O29zgo+53OF4w2gLr9hw6BFblJNifZLqnBmrglSCAWU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ArJPQ5v/trxA2SpY7AuI7Ut4StwUvMwuXSmnU04MqrTh2JzLlB2IV2sf+jCscnSJl
         z7V8ozc/T2CCItvQ+Q2B5kAhm0y0osHfX53DrqqG9BMnRRuy0v1EWdXMooQ2ng5wz+
         6MIkg4dpnvqWp2W4POEbI9eUO/9KzbyBl1RC1LxbkqU0yOR9QLXXkjTy9hQ/QPNGXK
         dXQ7HYcM9H0V60zKMav/NnrGPFzGU+9APNvJzjW5y5bY9gzII4dzs/l+XXoCddDCKv
         Fgua6VxnBUGLx2cw/i5So02wNRtNEsTdBN+jciOKohvxo8INAg49JBxWZrrNskOgkV
         DwAZahqjIgKVA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 08/30] habanalabs: get clk is common function
Date:   Sat, 22 Jan 2022 21:57:09 +0200
Message-Id: <20220122195731.934494-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retrieving the clock from the f/w is done exactly the same in ALL our
ASICs. Therefore, no real justification for doing it as an
ASIC-specific function.

The only thing is we need to check if we are running on simulator,
which doesn't require ASIC-specific callback.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h       |  7 ++-----
 drivers/misc/habanalabs/common/habanalabs_ioctl.c |  9 ++++-----
 drivers/misc/habanalabs/common/hwmgr.c            | 13 ++++++++-----
 drivers/misc/habanalabs/gaudi/gaudi.c             |  1 -
 drivers/misc/habanalabs/goya/goya.c               |  3 +--
 5 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 571998899253..ecfdfec7abdc 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2016-2021 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -1190,7 +1190,6 @@ struct fw_load_mgr {
  * @halt_coresight: stop the ETF and ETR traces.
  * @ctx_init: context dependent initialization.
  * @ctx_fini: context dependent cleanup.
- * @get_clk_rate: Retrieve the ASIC current and maximum clock rate in MHz
  * @get_queue_id_for_cq: Get the H/W queue id related to the given CQ index.
  * @load_firmware_to_device: load the firmware to the device's memory
  * @load_boot_fit_to_device: load boot fit to device's memory
@@ -1321,7 +1320,6 @@ struct hl_asic_funcs {
 	void (*halt_coresight)(struct hl_device *hdev, struct hl_ctx *ctx);
 	int (*ctx_init)(struct hl_ctx *ctx);
 	void (*ctx_fini)(struct hl_ctx *ctx);
-	int (*get_clk_rate)(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 	u32 (*get_queue_id_for_cq)(struct hl_device *hdev, u32 cq_idx);
 	int (*load_firmware_to_device)(struct hl_device *hdev);
 	int (*load_boot_fit_to_device)(struct hl_device *hdev);
@@ -3122,8 +3120,7 @@ int hl_set_power(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value);
 int hl_get_power(struct hl_device *hdev,
 			int sensor_index, u32 attr, long *value);
-int hl_get_clk_rate(struct hl_device *hdev,
-			u32 *cur_clk, u32 *max_clk);
+int hl_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 void hl_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
 void hl_sysfs_add_dev_clk_attr(struct hl_device *hdev, struct attribute_group *dev_attr_grp);
 void hw_sob_get(struct hl_hw_sob *hw_sob);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 3ba3a8ffda3e..ed516f911ee2 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -251,13 +251,12 @@ static int get_clk_rate(struct hl_device *hdev, struct hl_info_args *args)
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	rc = hdev->asic_funcs->get_clk_rate(hdev, &clk_rate.cur_clk_rate_mhz,
-						&clk_rate.max_clk_rate_mhz);
+	rc = hl_get_clk_rate(hdev, &clk_rate.cur_clk_rate_mhz, &clk_rate.max_clk_rate_mhz);
 	if (rc)
 		return rc;
 
-	return copy_to_user(out, &clk_rate,
-		min((size_t) max_size, sizeof(clk_rate))) ? -EFAULT : 0;
+	return copy_to_user(out, &clk_rate, min_t(size_t, max_size, sizeof(clk_rate)))
+										? -EFAULT : 0;
 }
 
 static int get_reset_count(struct hl_device *hdev, struct hl_info_args *args)
diff --git a/drivers/misc/habanalabs/common/hwmgr.c b/drivers/misc/habanalabs/common/hwmgr.c
index f0e5417560c3..e96126b46056 100644
--- a/drivers/misc/habanalabs/common/hwmgr.c
+++ b/drivers/misc/habanalabs/common/hwmgr.c
@@ -20,11 +20,16 @@ int hl_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
+	if (!hdev->pdev) {
+		*cur_clk = 0;
+		*max_clk = 0;
+		return 0;
+	}
+
 	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, false);
 
 	if (value < 0) {
-		dev_err(hdev->dev, "Failed to retrieve device max clock %ld\n",
-			value);
+		dev_err(hdev->dev, "Failed to retrieve device max clock %ld\n", value);
 		return value;
 	}
 
@@ -33,9 +38,7 @@ int hl_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, true);
 
 	if (value < 0) {
-		dev_err(hdev->dev,
-			"Failed to retrieve device current clock %ld\n",
-			value);
+		dev_err(hdev->dev, "Failed to retrieve device current clock %ld\n", value);
 		return value;
 	}
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f096cfc03bf3..744d4305db40 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9385,7 +9385,6 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.halt_coresight = gaudi_halt_coresight,
 	.ctx_init = gaudi_ctx_init,
 	.ctx_fini = gaudi_ctx_fini,
-	.get_clk_rate = hl_get_clk_rate,
 	.get_queue_id_for_cq = gaudi_get_queue_id_for_cq,
 	.load_firmware_to_device = gaudi_load_firmware_to_device,
 	.load_boot_fit_to_device = gaudi_load_boot_fit_to_device,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 954ef4d7bbf7..318b97c53ed7 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2021 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -5739,7 +5739,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.halt_coresight = goya_halt_coresight,
 	.ctx_init = goya_ctx_init,
 	.ctx_fini = goya_ctx_fini,
-	.get_clk_rate = hl_get_clk_rate,
 	.get_queue_id_for_cq = goya_get_queue_id_for_cq,
 	.load_firmware_to_device = goya_load_firmware_to_device,
 	.load_boot_fit_to_device = goya_load_boot_fit_to_device,
-- 
2.25.1

