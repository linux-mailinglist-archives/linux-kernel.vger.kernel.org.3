Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16251496DC0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiAVT6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiAVT5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE45C061401
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:57:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8F8CACE09EC
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554E3C004E1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881468;
        bh=CtjmQtuMHT1G3ngqF4JvNb/bFgjwW/WrKbkZkM1tOJE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gTtlAFcjzBJjRVzYn2oKtxAnLOX2HkE2nim528QGr1kSsYOqKQ0owgunPrGC62WV9
         Pz2c0IhAv1CSEeYeVwY8UABmS+u1cghy5A1QTgK2+pkQLG3PwXrotBDfWWVnJoaWQY
         4okbYSioUIEr6i4H8riRou0Zx70DCCsgmCS8sEwJ2p/NHCyGpc9Que98Ku8IGhlQrI
         9fhZGWsREpNFdehWPWkzLq1qYxZtHbsxqUh4EnUkwpXwFZlpKEV/o0+kp8BBmw3T9D
         8LlGaPw5IpUHw2EXDWOC0zneknBVidBLhs7cyVG9guDbnMhwNFXM3wwHJjuBv5oXNp
         YC5QazLOYrqdQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 09/30] habanalabs: remove hwmgr.c
Date:   Sat, 22 Jan 2022 21:57:10 +0200
Message-Id: <20220122195731.934494-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two remaining functions in this file belong to firmware_if.c,
as they communicate with the firmware.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/Makefile       |  2 +-
 drivers/misc/habanalabs/common/firmware_if.c  | 42 +++++++++++++++-
 drivers/misc/habanalabs/common/habanalabs.h   |  4 +-
 .../misc/habanalabs/common/habanalabs_ioctl.c |  2 +-
 drivers/misc/habanalabs/common/hwmgr.c        | 48 -------------------
 drivers/misc/habanalabs/gaudi/gaudi.c         |  2 +-
 6 files changed, 46 insertions(+), 54 deletions(-)
 delete mode 100644 drivers/misc/habanalabs/common/hwmgr.c

diff --git a/drivers/misc/habanalabs/common/Makefile b/drivers/misc/habanalabs/common/Makefile
index 82c3824cad00..6ebe3c7001ff 100644
--- a/drivers/misc/habanalabs/common/Makefile
+++ b/drivers/misc/habanalabs/common/Makefile
@@ -11,4 +11,4 @@ HL_COMMON_FILES := common/habanalabs_drv.o common/device.o common/context.o \
 		common/command_buffer.o common/hw_queue.o common/irq.o \
 		common/sysfs.o common/hwmon.o common/memory.o \
 		common/command_submission.o common/firmware_if.o \
-		common/state_dump.o common/hwmgr.o
+		common/state_dump.o
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 6775c5c3166b..f7ccbd288510 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2021 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -2682,3 +2682,43 @@ int hl_fw_init_cpu(struct hl_device *hdev)
 			hl_fw_dynamic_init_cpu(hdev, fw_loader) :
 			hl_fw_static_init_cpu(hdev, fw_loader);
 }
+
+void hl_fw_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
+{
+	hl_set_frequency(hdev, hdev->asic_prop.clk_pll_index,
+				hdev->asic_prop.max_freq_value);
+}
+
+int hl_fw_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
+{
+	long value;
+
+	if (!hl_device_operational(hdev, NULL))
+		return -ENODEV;
+
+	if (!hdev->pdev) {
+		*cur_clk = 0;
+		*max_clk = 0;
+		return 0;
+	}
+
+	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, false);
+
+	if (value < 0) {
+		dev_err(hdev->dev, "Failed to retrieve device max clock %ld\n", value);
+		return value;
+	}
+
+	*max_clk = (value / 1000 / 1000);
+
+	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, true);
+
+	if (value < 0) {
+		dev_err(hdev->dev, "Failed to retrieve device current clock %ld\n", value);
+		return value;
+	}
+
+	*cur_clk = (value / 1000 / 1000);
+
+	return 0;
+}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index ecfdfec7abdc..c782d44d58d5 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3120,8 +3120,8 @@ int hl_set_power(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value);
 int hl_get_power(struct hl_device *hdev,
 			int sensor_index, u32 attr, long *value);
-int hl_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
-void hl_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
+int hl_fw_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
+void hl_fw_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
 void hl_sysfs_add_dev_clk_attr(struct hl_device *hdev, struct attribute_group *dev_attr_grp);
 void hw_sob_get(struct hl_hw_sob *hw_sob);
 void hw_sob_put(struct hl_hw_sob *hw_sob);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index ed516f911ee2..d19097576b05 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -251,7 +251,7 @@ static int get_clk_rate(struct hl_device *hdev, struct hl_info_args *args)
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	rc = hl_get_clk_rate(hdev, &clk_rate.cur_clk_rate_mhz, &clk_rate.max_clk_rate_mhz);
+	rc = hl_fw_get_clk_rate(hdev, &clk_rate.cur_clk_rate_mhz, &clk_rate.max_clk_rate_mhz);
 	if (rc)
 		return rc;
 
diff --git a/drivers/misc/habanalabs/common/hwmgr.c b/drivers/misc/habanalabs/common/hwmgr.c
deleted file mode 100644
index e96126b46056..000000000000
--- a/drivers/misc/habanalabs/common/hwmgr.c
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-/*
- * Copyright 2019-2021 HabanaLabs, Ltd.
- * All Rights Reserved.
- */
-
-#include "habanalabs.h"
-
-void hl_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
-{
-	hl_set_frequency(hdev, hdev->asic_prop.clk_pll_index,
-			hdev->asic_prop.max_freq_value);
-}
-
-int hl_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
-{
-	long value;
-
-	if (!hl_device_operational(hdev, NULL))
-		return -ENODEV;
-
-	if (!hdev->pdev) {
-		*cur_clk = 0;
-		*max_clk = 0;
-		return 0;
-	}
-
-	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, false);
-
-	if (value < 0) {
-		dev_err(hdev->dev, "Failed to retrieve device max clock %ld\n", value);
-		return value;
-	}
-
-	*max_clk = (value / 1000 / 1000);
-
-	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, true);
-
-	if (value < 0) {
-		dev_err(hdev->dev, "Failed to retrieve device current clock %ld\n", value);
-		return value;
-	}
-
-	*cur_clk = (value / 1000 / 1000);
-
-	return 0;
-}
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 744d4305db40..ae86147dfde4 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9363,7 +9363,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.debugfs_read_dma = gaudi_debugfs_read_dma,
 	.add_device_attr = hl_sysfs_add_dev_clk_attr,
 	.handle_eqe = gaudi_handle_eqe,
-	.set_pll_profile = hl_set_pll_profile,
+	.set_pll_profile = hl_fw_set_pll_profile,
 	.get_events_stat = gaudi_get_events_stat,
 	.read_pte = gaudi_read_pte,
 	.write_pte = gaudi_write_pte,
-- 
2.25.1

