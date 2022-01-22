Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A8496DC2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiAVT6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33078 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiAVT5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FCC960EBB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1C1C340E4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881473;
        bh=3HzoMd75jdYg6JicTjgzKVNIwz8Of4W5VAisaHmT/Zo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=inR8bgJAOV1NlVbMHl0QPTtnOv4KWZ7iPXgZ7e05dcwwq6yqop/g5QBitNX2aiBhI
         +pmvdgfEGr6F+Xf3elMg09jzNOsonxtmS7tKrJVqflH3aPDz6baNdxqW6ZhUtZ7apb
         kYxx+x+mxEbow7Y4XVk6oVb9jLCRGkwTI7fq0pk96mgtSBoDgq2MFkn9wQU+YHpvT3
         lvlfI8vfE5w+p5zDFwvLYfLP14F91jpKpJyRO8L8vZDZUAfpVQXyPw2+tdVc83Zwzx
         QLKhHo9Resc3V7jRDEBbtqYPAr9pjkSPzBU3cR9u4D5gggBFOML5EZ4aKyUGtntuap
         wSkgAopE2neNg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 13/30] habanalabs: add vrm version to sysfs
Date:   Sat, 22 Jan 2022 21:57:14 +0200
Message-Id: <20220122195731.934494-13-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

infineon version is only applicable to GOYA and GAUDI. For later
ASICs, we display the Voltage Regulator Monitor f/w version.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../ABI/testing/sysfs-driver-habanalabs       | 10 +++-
 drivers/misc/habanalabs/common/habanalabs.h   |  4 +-
 drivers/misc/habanalabs/common/sysfs.c        | 46 +++++++++++--------
 drivers/misc/habanalabs/gaudi/gaudi.c         | 25 +++++++++-
 drivers/misc/habanalabs/gaudi/gaudiP.h        |  4 +-
 drivers/misc/habanalabs/goya/goyaP.h          |  3 +-
 drivers/misc/habanalabs/goya/goya_hwmgr.c     | 21 ++++++++-
 7 files changed, 85 insertions(+), 28 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
index 1f127f71d2b4..c16a573eb680 100644
--- a/Documentation/ABI/testing/sysfs-driver-habanalabs
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -115,7 +115,7 @@ What:           /sys/class/habanalabs/hl<n>/infineon_ver
 Date:           Jan 2019
 KernelVersion:  5.1
 Contact:        ogabbay@kernel.org
-Description:    Version of the Device's power supply F/W code
+Description:    Version of the Device's power supply F/W code. Relevant only to GOYA and GAUDI
 
 What:           /sys/class/habanalabs/hl<n>/max_power
 Date:           Jan 2019
@@ -220,4 +220,10 @@ What:           /sys/class/habanalabs/hl<n>/uboot_ver
 Date:           Jan 2019
 KernelVersion:  5.1
 Contact:        ogabbay@kernel.org
-Description:    Version of the u-boot running on the device's CPU
\ No newline at end of file
+Description:    Version of the u-boot running on the device's CPU
+
+What:           /sys/class/habanalabs/hl<n>/vrm_ver
+Date:           Jan 2022
+KernelVersion:  not yet upstreamed
+Contact:        ogabbay@kernel.org
+Description:    Version of the Device's Voltage Regulator Monitor F/W code. N/A to GOYA and GAUDI
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index c116e30a5543..b8acfef9577a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1286,7 +1286,8 @@ struct hl_asic_funcs {
 				bool user_address, u64 val);
 	int (*debugfs_read_dma)(struct hl_device *hdev, u64 addr, u32 size,
 				void *blob_addr);
-	void (*add_device_attr)(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp);
+	void (*add_device_attr)(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp,
+				struct attribute_group *dev_vrm_attr_grp);
 	void (*handle_eqe)(struct hl_device *hdev,
 				struct hl_eq_entry *eq_entry);
 	void* (*get_events_stat)(struct hl_device *hdev, bool aggregate,
@@ -3106,6 +3107,7 @@ int hl_get_power(struct hl_device *hdev, int sensor_index, u32 attr, long *value
 int hl_fw_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 void hl_fw_set_pll_profile(struct hl_device *hdev);
 void hl_sysfs_add_dev_clk_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp);
+void hl_sysfs_add_dev_vrm_attr(struct hl_device *hdev, struct attribute_group *dev_vrm_attr_grp);
 
 void hw_sob_get(struct hl_hw_sob *hw_sob);
 void hw_sob_put(struct hl_hw_sob *hw_sob);
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 606cee6252fe..65b132fa6dbd 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -69,7 +69,26 @@ static DEVICE_ATTR_RO(clk_cur_freq_mhz);
 static struct attribute *hl_dev_clk_attrs[] = {
 	&dev_attr_clk_max_freq_mhz.attr,
 	&dev_attr_clk_cur_freq_mhz.attr,
-	NULL,
+};
+
+static ssize_t vrm_ver_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	struct cpucp_info *cpucp_info;
+
+	cpucp_info = &hdev->asic_prop.cpucp_info;
+
+	if (cpucp_info->infineon_second_stage_version)
+		return sprintf(buf, "%#04x %#04x\n", le32_to_cpu(cpucp_info->infineon_version),
+				le32_to_cpu(cpucp_info->infineon_second_stage_version));
+	else
+		return sprintf(buf, "%#04x\n", le32_to_cpu(cpucp_info->infineon_version));
+}
+
+static DEVICE_ATTR_RO(vrm_ver);
+
+static struct attribute *hl_dev_vrm_attrs[] = {
+	&dev_attr_vrm_ver.attr,
 };
 
 static ssize_t uboot_ver_show(struct device *dev, struct device_attribute *attr,
@@ -121,20 +140,6 @@ static ssize_t cpucp_ver_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%s\n", hdev->asic_prop.cpucp_info.cpucp_version);
 }
 
-static ssize_t infineon_ver_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct hl_device *hdev = dev_get_drvdata(dev);
-
-	if (hdev->asic_prop.cpucp_info.infineon_second_stage_version)
-		return sprintf(buf, "%#04x %#04x\n",
-			le32_to_cpu(hdev->asic_prop.cpucp_info.infineon_version),
-			le32_to_cpu(hdev->asic_prop.cpucp_info.infineon_second_stage_version));
-	else
-		return sprintf(buf, "%#04x\n",
-			le32_to_cpu(hdev->asic_prop.cpucp_info.infineon_version));
-}
-
 static ssize_t fuse_ver_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
@@ -357,7 +362,6 @@ static DEVICE_ATTR_RO(device_type);
 static DEVICE_ATTR_RO(fuse_ver);
 static DEVICE_ATTR_WO(hard_reset);
 static DEVICE_ATTR_RO(hard_reset_cnt);
-static DEVICE_ATTR_RO(infineon_ver);
 static DEVICE_ATTR_RW(max_power);
 static DEVICE_ATTR_RO(pci_addr);
 static DEVICE_ATTR_RO(preboot_btl_ver);
@@ -383,7 +387,6 @@ static struct attribute *hl_dev_attrs[] = {
 	&dev_attr_fuse_ver.attr,
 	&dev_attr_hard_reset.attr,
 	&dev_attr_hard_reset_cnt.attr,
-	&dev_attr_infineon_ver.attr,
 	&dev_attr_max_power.attr,
 	&dev_attr_pci_addr.attr,
 	&dev_attr_preboot_btl_ver.attr,
@@ -404,10 +407,12 @@ static struct attribute_group hl_dev_attr_group = {
 };
 
 static struct attribute_group hl_dev_clks_attr_group;
+static struct attribute_group hl_dev_vrm_attr_group;
 
 static const struct attribute_group *hl_dev_attr_groups[] = {
 	&hl_dev_attr_group,
 	&hl_dev_clks_attr_group,
+	&hl_dev_vrm_attr_group,
 	NULL,
 };
 
@@ -431,13 +436,18 @@ void hl_sysfs_add_dev_clk_attr(struct hl_device *hdev, struct attribute_group *d
 	dev_clk_attr_grp->attrs = hl_dev_clk_attrs;
 }
 
+void hl_sysfs_add_dev_vrm_attr(struct hl_device *hdev, struct attribute_group *dev_vrm_attr_grp)
+{
+	dev_vrm_attr_grp->attrs = hl_dev_vrm_attrs;
+}
+
 int hl_sysfs_init(struct hl_device *hdev)
 {
 	int rc;
 
 	hdev->max_power = hdev->asic_prop.max_power_default;
 
-	hdev->asic_funcs->add_device_attr(hdev, &hl_dev_clks_attr_group);
+	hdev->asic_funcs->add_device_attr(hdev, &hl_dev_clks_attr_group, &hl_dev_vrm_attr_group);
 
 	rc = device_add_groups(hdev->dev, hl_dev_attr_groups);
 	if (rc) {
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index bb0b4ff3451d..c4e41856ad31 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9324,6 +9324,29 @@ static u32 *gaudi_get_stream_master_qid_arr(void)
 	return gaudi_stream_master;
 }
 
+static ssize_t infineon_ver_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	struct cpucp_info *cpucp_info;
+
+	cpucp_info = &hdev->asic_prop.cpucp_info;
+
+	return sprintf(buf, "%#04x\n", le32_to_cpu(cpucp_info->infineon_version));
+}
+
+static DEVICE_ATTR_RO(infineon_ver);
+
+static struct attribute *gaudi_vrm_dev_attrs[] = {
+	&dev_attr_infineon_ver.attr,
+};
+
+static void gaudi_add_device_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp,
+					struct attribute_group *dev_vrm_attr_grp)
+{
+	hl_sysfs_add_dev_clk_attr(hdev, dev_clk_attr_grp);
+	dev_vrm_attr_grp->attrs = gaudi_vrm_dev_attrs;
+}
+
 static const struct hl_asic_funcs gaudi_funcs = {
 	.early_init = gaudi_early_init,
 	.early_fini = gaudi_early_fini,
@@ -9361,7 +9384,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.debugfs_read64 = gaudi_debugfs_read64,
 	.debugfs_write64 = gaudi_debugfs_write64,
 	.debugfs_read_dma = gaudi_debugfs_read_dma,
-	.add_device_attr = hl_sysfs_add_dev_clk_attr,
+	.add_device_attr = gaudi_add_device_attr,
 	.handle_eqe = gaudi_handle_eqe,
 	.get_events_stat = gaudi_get_events_stat,
 	.read_pte = gaudi_read_pte,
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index fdadcbf3ef80..54de7c599072 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
- * Copyright 2019-2020 HabanaLabs, Ltd.
+ * Copyright 2019-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  *
  */
@@ -351,8 +351,6 @@ struct gaudi_device {
 
 void gaudi_init_security(struct hl_device *hdev);
 void gaudi_ack_protection_bits_errors(struct hl_device *hdev);
-void gaudi_add_device_attr(struct hl_device *hdev,
-			struct attribute_group *dev_attr_grp);
 int gaudi_debug_coresight(struct hl_device *hdev, struct hl_ctx *ctx, void *data);
 void gaudi_halt_coresight(struct hl_device *hdev, struct hl_ctx *ctx);
 void gaudi_mmu_prepare_reg(struct hl_device *hdev, u64 reg, u32 asid);
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index d71e2f4de757..647f57402616 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -217,7 +217,8 @@ u64 goya_get_max_power(struct hl_device *hdev);
 void goya_set_max_power(struct hl_device *hdev, u64 value);
 
 void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
-void goya_add_device_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp);
+void goya_add_device_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp,
+				struct attribute_group *dev_vrm_attr_grp);
 int goya_cpucp_info_get(struct hl_device *hdev);
 int goya_debug_coresight(struct hl_device *hdev, struct hl_ctx *ctx, void *data);
 void goya_halt_coresight(struct hl_device *hdev, struct hl_ctx *ctx);
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index c641ff1e23b9..6580fc6a486a 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -359,10 +359,27 @@ static struct attribute *goya_clk_dev_attrs[] = {
 	&dev_attr_pm_mng_profile.attr,
 	&dev_attr_tpc_clk.attr,
 	&dev_attr_tpc_clk_curr.attr,
-	NULL,
 };
 
-void goya_add_device_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp)
+static ssize_t infineon_ver_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	struct cpucp_info *cpucp_info;
+
+	cpucp_info = &hdev->asic_prop.cpucp_info;
+
+	return sprintf(buf, "%#04x\n", le32_to_cpu(cpucp_info->infineon_version));
+}
+
+static DEVICE_ATTR_RO(infineon_ver);
+
+static struct attribute *goya_vrm_dev_attrs[] = {
+	&dev_attr_infineon_ver.attr,
+};
+
+void goya_add_device_attr(struct hl_device *hdev, struct attribute_group *dev_clk_attr_grp,
+				struct attribute_group *dev_vrm_attr_grp)
 {
 	dev_clk_attr_grp->attrs = goya_clk_dev_attrs;
+	dev_vrm_attr_grp->attrs = goya_vrm_dev_attrs;
 }
-- 
2.25.1

