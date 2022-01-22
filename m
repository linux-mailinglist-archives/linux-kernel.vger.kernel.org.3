Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB0B496DC1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiAVT6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33066 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiAVT5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5410C60E04
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13345C004E1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881471;
        bh=Lu6GeqxEiUU7cALggqRpN40jsYFD82n6TnEcncCGZcY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Z0VXmwubC/GnDAzQQtlwDfq3IWHUxHjJvseX7UAYwNAKLcknUUn33Yq1Hbu1SpqK2
         ULSppRCafInZTWROuOYUSNQ9lSKGRmIWxBgjysDQNptVNJp/SOphcn1lNmR7ZINF8b
         I8qtCiul5ZO8w//7xMEADWdiKfboWvWX/06kSqbdO+C6t7rSqrr6ZMwMjwpyEPy2pQ
         mD08FlLIFKY/M4a9KHtpewMxbVtwxZdIQct2CLilRyCEaByQLmWBSSYq0ibrUGGu/f
         iJvi1tOvKQE+j/ttLVPX7fTSuyQfpNgqpXgSlBHYH3LBlF+YNudtk5vF0yZLY2H/NR
         oJ3y7F4+HGvLQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 12/30] habanalabs: rename dev_attr_grp to dev_clk_attr_grp
Date:   Sat, 22 Jan 2022 21:57:13 +0200
Message-Id: <20220122195731.934494-12-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this attribute group we are only adding clocks. This is in
preparation for adding a device specific attribute group which is
not related to clocks.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 5 ++---
 drivers/misc/habanalabs/common/sysfs.c      | 4 ++--
 drivers/misc/habanalabs/goya/goyaP.h        | 5 ++---
 drivers/misc/habanalabs/goya/goya_hwmgr.c   | 7 +++----
 4 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 3dc155948730..c116e30a5543 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1286,8 +1286,7 @@ struct hl_asic_funcs {
 				bool user_address, u64 val);
 	int (*debugfs_read_dma)(struct hl_device *hdev, u64 addr, u32 size,
 				void *blob_addr);
-	void (*add_device_attr)(struct hl_device *hdev,
-				struct attribute_group *dev_attr_grp);
+	void (*add_device_attr)(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp);
 	void (*handle_eqe)(struct hl_device *hdev,
 				struct hl_eq_entry *eq_entry);
 	void* (*get_events_stat)(struct hl_device *hdev, bool aggregate,
@@ -3106,7 +3105,7 @@ int hl_set_power(struct hl_device *hdev, int sensor_index, u32 attr, long value)
 int hl_get_power(struct hl_device *hdev, int sensor_index, u32 attr, long *value);
 int hl_fw_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 void hl_fw_set_pll_profile(struct hl_device *hdev);
-void hl_sysfs_add_dev_clk_attr(struct hl_device *hdev, struct attribute_group *dev_attr_grp);
+void hl_sysfs_add_dev_clk_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp);
 
 void hw_sob_get(struct hl_hw_sob *hw_sob);
 void hw_sob_put(struct hl_hw_sob *hw_sob);
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index ce3538d36bb7..606cee6252fe 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -426,9 +426,9 @@ static const struct attribute_group *hl_dev_inference_attr_groups[] = {
 	NULL,
 };
 
-void hl_sysfs_add_dev_clk_attr(struct hl_device *hdev, struct attribute_group *dev_attr_grp)
+void hl_sysfs_add_dev_clk_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp)
 {
-	dev_attr_grp->attrs = hl_dev_clk_attrs;
+	dev_clk_attr_grp->attrs = hl_dev_clk_attrs;
 }
 
 int hl_sysfs_init(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 3740fd25bf84..d71e2f4de757 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -217,8 +217,7 @@ u64 goya_get_max_power(struct hl_device *hdev);
 void goya_set_max_power(struct hl_device *hdev, u64 value);
 
 void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
-void goya_add_device_attr(struct hl_device *hdev,
-			struct attribute_group *dev_attr_grp);
+void goya_add_device_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp);
 int goya_cpucp_info_get(struct hl_device *hdev);
 int goya_debug_coresight(struct hl_device *hdev, struct hl_ctx *ctx, void *data);
 void goya_halt_coresight(struct hl_device *hdev, struct hl_ctx *ctx);
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index 7d4f26c67d8e..c641ff1e23b9 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -350,7 +350,7 @@ static DEVICE_ATTR_RW(pm_mng_profile);
 static DEVICE_ATTR_RW(tpc_clk);
 static DEVICE_ATTR_RO(tpc_clk_curr);
 
-static struct attribute *goya_dev_attrs[] = {
+static struct attribute *goya_clk_dev_attrs[] = {
 	&dev_attr_high_pll.attr,
 	&dev_attr_ic_clk.attr,
 	&dev_attr_ic_clk_curr.attr,
@@ -362,8 +362,7 @@ static struct attribute *goya_dev_attrs[] = {
 	NULL,
 };
 
-void goya_add_device_attr(struct hl_device *hdev,
-			struct attribute_group *dev_attr_grp)
+void goya_add_device_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp)
 {
-	dev_attr_grp->attrs = goya_dev_attrs;
+	dev_clk_attr_grp->attrs = goya_clk_dev_attrs;
 }
-- 
2.25.1

