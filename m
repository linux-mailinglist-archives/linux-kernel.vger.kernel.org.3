Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D31496DD0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiAVT67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33022 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbiAVT5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C25460E04
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D317BC340E2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881465;
        bh=MwXOwoHbiSn+FkarQmab+/C/0lEIoBaO76GULbKBdAk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jdBF+zckKzNbwEA6zf8qeQJOBjwLnlJNiZkGHZFCLnlJplB24PBzTCkCfJPMv3uru
         bvsiWNu562WT5NMWnYsdB5J3tIwBWp2sTsJSBtdyjk52/ZB+h5sfu3I9sXqyDuDl1R
         WFVgLeio+qbBF+Quv13EYLLh5kgN1GGq8GlvlYxElXO6wCgxMR8iqJDIK4mM96g4/J
         t1CJqvQ+JTVwXxmUdO4oh3oq9zyi42Da9tkn7SyCLA6H8DqnTsoCCVqynean0yK9d/
         0H/eLTaMZTyKX4QzJhWGfXZYwTxHc9Aw7tvmZmgUj76mEnnxXgvuieLy1pYD1o/Ntx
         FPs2tbI8i61+g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 07/30] habanalabs: sysfs functions should be in sysfs.c
Date:   Sat, 22 Jan 2022 21:57:08 +0200
Message-Id: <20220122195731.934494-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move common sysfs store/show functions to sysfs.c file for
consistency.

This is part of a patch-set to remove hwmgr.c

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  3 +-
 drivers/misc/habanalabs/common/hwmgr.c      | 72 ---------------------
 drivers/misc/habanalabs/common/sysfs.c      | 70 +++++++++++++++++++-
 drivers/misc/habanalabs/gaudi/gaudi.c       |  2 +-
 4 files changed, 71 insertions(+), 76 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e96f26e7e804..571998899253 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3125,8 +3125,7 @@ int hl_get_power(struct hl_device *hdev,
 int hl_get_clk_rate(struct hl_device *hdev,
 			u32 *cur_clk, u32 *max_clk);
 void hl_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
-void hl_add_device_attr(struct hl_device *hdev,
-			struct attribute_group *dev_attr_grp);
+void hl_sysfs_add_dev_clk_attr(struct hl_device *hdev, struct attribute_group *dev_attr_grp);
 void hw_sob_get(struct hl_hw_sob *hw_sob);
 void hw_sob_put(struct hl_hw_sob *hw_sob);
 void hl_encaps_handle_do_release(struct kref *ref);
diff --git a/drivers/misc/habanalabs/common/hwmgr.c b/drivers/misc/habanalabs/common/hwmgr.c
index 5451019f143f..f0e5417560c3 100644
--- a/drivers/misc/habanalabs/common/hwmgr.c
+++ b/drivers/misc/habanalabs/common/hwmgr.c
@@ -43,75 +43,3 @@ int hl_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 
 	return 0;
 }
-
-static ssize_t clk_max_freq_mhz_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct hl_device *hdev = dev_get_drvdata(dev);
-	long value;
-
-	if (!hl_device_operational(hdev, NULL))
-		return -ENODEV;
-
-	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, false);
-
-	hdev->asic_prop.max_freq_value = value;
-
-	return sprintf(buf, "%lu\n", (value / 1000 / 1000));
-}
-
-static ssize_t clk_max_freq_mhz_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct hl_device *hdev = dev_get_drvdata(dev);
-	int rc;
-	u64 value;
-
-	if (!hl_device_operational(hdev, NULL)) {
-		count = -ENODEV;
-		goto fail;
-	}
-
-	rc = kstrtoull(buf, 0, &value);
-	if (rc) {
-		count = -EINVAL;
-		goto fail;
-	}
-
-	hdev->asic_prop.max_freq_value = value * 1000 * 1000;
-
-	hl_set_frequency(hdev, hdev->asic_prop.clk_pll_index,
-			hdev->asic_prop.max_freq_value);
-
-fail:
-	return count;
-}
-
-static ssize_t clk_cur_freq_mhz_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct hl_device *hdev = dev_get_drvdata(dev);
-	long value;
-
-	if (!hl_device_operational(hdev, NULL))
-		return -ENODEV;
-
-	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, true);
-
-	return sprintf(buf, "%lu\n", (value / 1000 / 1000));
-}
-
-static DEVICE_ATTR_RW(clk_max_freq_mhz);
-static DEVICE_ATTR_RO(clk_cur_freq_mhz);
-
-static struct attribute *hl_dev_attrs[] = {
-	&dev_attr_clk_max_freq_mhz.attr,
-	&dev_attr_clk_cur_freq_mhz.attr,
-	NULL,
-};
-
-void hl_add_device_attr(struct hl_device *hdev,
-			struct attribute_group *dev_attr_grp)
-{
-	dev_attr_grp->attrs = hl_dev_attrs;
-}
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 45c715325e2a..d66cf43788d8 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2019 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -109,6 +109,69 @@ void hl_set_max_power(struct hl_device *hdev)
 		dev_err(hdev->dev, "Failed to set max power, error %d\n", rc);
 }
 
+static ssize_t clk_max_freq_mhz_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+
+	if (!hl_device_operational(hdev, NULL))
+		return -ENODEV;
+
+	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, false);
+
+	hdev->asic_prop.max_freq_value = value;
+
+	return sprintf(buf, "%lu\n", (value / 1000 / 1000));
+}
+
+static ssize_t clk_max_freq_mhz_store(struct device *dev, struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	int rc;
+	u64 value;
+
+	if (!hl_device_operational(hdev, NULL)) {
+		count = -ENODEV;
+		goto fail;
+	}
+
+	rc = kstrtoull(buf, 0, &value);
+	if (rc) {
+		count = -EINVAL;
+		goto fail;
+	}
+
+	hdev->asic_prop.max_freq_value = value * 1000 * 1000;
+
+	hl_set_frequency(hdev, hdev->asic_prop.clk_pll_index, hdev->asic_prop.max_freq_value);
+
+fail:
+	return count;
+}
+
+static ssize_t clk_cur_freq_mhz_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+
+	if (!hl_device_operational(hdev, NULL))
+		return -ENODEV;
+
+	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, true);
+
+	return sprintf(buf, "%lu\n", (value / 1000 / 1000));
+}
+
+static DEVICE_ATTR_RW(clk_max_freq_mhz);
+static DEVICE_ATTR_RO(clk_cur_freq_mhz);
+
+static struct attribute *hl_dev_clk_attrs[] = {
+	&dev_attr_clk_max_freq_mhz.attr,
+	&dev_attr_clk_cur_freq_mhz.attr,
+	NULL,
+};
+
 static ssize_t uboot_ver_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
@@ -463,6 +526,11 @@ static const struct attribute_group *hl_dev_inference_attr_groups[] = {
 	NULL,
 };
 
+void hl_sysfs_add_dev_clk_attr(struct hl_device *hdev, struct attribute_group *dev_attr_grp)
+{
+	dev_attr_grp->attrs = hl_dev_clk_attrs;
+}
+
 int hl_sysfs_init(struct hl_device *hdev)
 {
 	int rc;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 16637d629e67..f096cfc03bf3 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9361,7 +9361,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.debugfs_read64 = gaudi_debugfs_read64,
 	.debugfs_write64 = gaudi_debugfs_write64,
 	.debugfs_read_dma = gaudi_debugfs_read_dma,
-	.add_device_attr = hl_add_device_attr,
+	.add_device_attr = hl_sysfs_add_dev_clk_attr,
 	.handle_eqe = gaudi_handle_eqe,
 	.set_pll_profile = hl_set_pll_profile,
 	.get_events_stat = gaudi_get_events_stat,
-- 
2.25.1

