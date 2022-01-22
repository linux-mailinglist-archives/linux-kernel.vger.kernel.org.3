Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45125496DBC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiAVT5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:57:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33050 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbiAVT5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCD3360EB3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91287C340E4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881469;
        bh=Y3hYZqVHeMKgfh14abfGl627PDQ816diRiTpa/a8GyY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ihvQ8kh9vTUMUTBtFhWSyk0b+zlqwRCT4Dhf5ltU/sc/9/adM3XkonAHron8sgRtO
         F85533IQYC7QoMXOzCUPhII/mLc3yEvrS5+vk3GEZZjSx/gi53JGygyQbACVw+bUGR
         l1EbMnoFVEkJKuktQHUYdsFxGCG/Qk+0p+DO/MWF+7o3XySC6cBHi/YqFO1xBhwA+F
         l5hcVjTkWaUqZUWwUROXAi+ezokVTw/E5vFg5UIinp++YHucE0HmX9L1p4ig8+Ay0k
         MQxSvwdbZiscJmqR/RQlkiB9TA48ei/3ZHLChPXJz9ErT7Ve/3dD1g7Ey8Biod+KPg
         UVBUFmL7dVpjw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 10/30] habanalabs: move more f/w functions to firmware_if.c
Date:   Sat, 22 Jan 2022 21:57:11 +0200
Message-Id: <20220122195731.934494-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For better maintainability, try to concentrate all the common functions
that communicate with the f/w in firmware_if.c

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c      |   6 +-
 drivers/misc/habanalabs/common/firmware_if.c | 101 ++++++++++++++++-
 drivers/misc/habanalabs/common/habanalabs.h  |  44 +++-----
 drivers/misc/habanalabs/common/sysfs.c       | 110 +------------------
 drivers/misc/habanalabs/goya/goya_hwmgr.c    |  38 +++----
 5 files changed, 141 insertions(+), 158 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 9955e0d3502b..c98a0a81e7d5 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2021 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -1228,7 +1228,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 			goto out_err;
 		}
 
-		hl_set_max_power(hdev);
+		hl_fw_set_max_power(hdev);
 	} else {
 		rc = hdev->asic_funcs->non_hard_reset_late_init(hdev);
 		if (rc) {
@@ -1534,7 +1534,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	/* Need to call this again because the max power might change,
 	 * depending on card type for certain ASICs
 	 */
-	hl_set_max_power(hdev);
+	hl_fw_set_max_power(hdev);
 
 	/*
 	 * hl_hwmon_init() must be called after device_late_init(), because only
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index f7ccbd288510..508ee349f4e4 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2685,7 +2685,7 @@ int hl_fw_init_cpu(struct hl_device *hdev)
 
 void hl_fw_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
 {
-	hl_set_frequency(hdev, hdev->asic_prop.clk_pll_index,
+	hl_fw_set_frequency(hdev, hdev->asic_prop.clk_pll_index,
 				hdev->asic_prop.max_freq_value);
 }
 
@@ -2702,7 +2702,7 @@ int hl_fw_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 		return 0;
 	}
 
-	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, false);
+	value = hl_fw_get_frequency(hdev, hdev->asic_prop.clk_pll_index, false);
 
 	if (value < 0) {
 		dev_err(hdev->dev, "Failed to retrieve device max clock %ld\n", value);
@@ -2711,7 +2711,7 @@ int hl_fw_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 
 	*max_clk = (value / 1000 / 1000);
 
-	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, true);
+	value = hl_fw_get_frequency(hdev, hdev->asic_prop.clk_pll_index, true);
 
 	if (value < 0) {
 		dev_err(hdev->dev, "Failed to retrieve device current clock %ld\n", value);
@@ -2722,3 +2722,98 @@ int hl_fw_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 
 	return 0;
 }
+
+long hl_fw_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
+{
+	struct cpucp_packet pkt;
+	u32 used_pll_idx;
+	u64 result;
+	int rc;
+
+	rc = get_used_pll_index(hdev, pll_index, &used_pll_idx);
+	if (rc)
+		return rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	if (curr)
+		pkt.ctl = cpu_to_le32(CPUCP_PACKET_FREQUENCY_CURR_GET <<
+						CPUCP_PKT_CTL_OPCODE_SHIFT);
+	else
+		pkt.ctl = cpu_to_le32(CPUCP_PACKET_FREQUENCY_GET << CPUCP_PKT_CTL_OPCODE_SHIFT);
+
+	pkt.pll_index = cpu_to_le32((u32)used_pll_idx);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt), 0, &result);
+
+	if (rc) {
+		dev_err(hdev->dev, "Failed to get frequency of PLL %d, error %d\n",
+			used_pll_idx, rc);
+		return rc;
+	}
+
+	return (long) result;
+}
+
+void hl_fw_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq)
+{
+	struct cpucp_packet pkt;
+	u32 used_pll_idx;
+	int rc;
+
+	rc = get_used_pll_index(hdev, pll_index, &used_pll_idx);
+	if (rc)
+		return;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_FREQUENCY_SET << CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.pll_index = cpu_to_le32((u32)used_pll_idx);
+	pkt.value = cpu_to_le64(freq);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt), 0, NULL);
+
+	if (rc)
+		dev_err(hdev->dev, "Failed to set frequency to PLL %d, error %d\n",
+			used_pll_idx, rc);
+}
+
+u64 hl_fw_get_max_power(struct hl_device *hdev)
+{
+	struct cpucp_packet pkt;
+	u64 result;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_MAX_POWER_GET << CPUCP_PKT_CTL_OPCODE_SHIFT);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt), 0, &result);
+
+	if (rc) {
+		dev_err(hdev->dev, "Failed to get max power, error %d\n", rc);
+		return (u64) rc;
+	}
+
+	return result;
+}
+
+void hl_fw_set_max_power(struct hl_device *hdev)
+{
+	struct cpucp_packet pkt;
+	int rc;
+
+	/* TODO: remove this after simulator supports this packet */
+	if (!hdev->pdev)
+		return;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = cpu_to_le32(CPUCP_PACKET_MAX_POWER_SET << CPUCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.value = cpu_to_le64(hdev->max_power);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt), 0, NULL);
+
+	if (rc)
+		dev_err(hdev->dev, "Failed to set max power, error %d\n", rc);
+}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index c782d44d58d5..2bf73e5ce47f 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3092,37 +3092,25 @@ enum pci_region hl_get_pci_memory_region(struct hl_device *hdev, u64 addr);
 int hl_pci_init(struct hl_device *hdev);
 void hl_pci_fini(struct hl_device *hdev);
 
-long hl_get_frequency(struct hl_device *hdev, u32 pll_index,
-								bool curr);
-void hl_set_frequency(struct hl_device *hdev, u32 pll_index,
-								u64 freq);
-int hl_get_temperature(struct hl_device *hdev,
-		       int sensor_index, u32 attr, long *value);
-int hl_set_temperature(struct hl_device *hdev,
-		       int sensor_index, u32 attr, long value);
-int hl_get_voltage(struct hl_device *hdev,
-		   int sensor_index, u32 attr, long *value);
-int hl_get_current(struct hl_device *hdev,
-		   int sensor_index, u32 attr, long *value);
-int hl_get_fan_speed(struct hl_device *hdev,
-		     int sensor_index, u32 attr, long *value);
-int hl_get_pwm_info(struct hl_device *hdev,
-		    int sensor_index, u32 attr, long *value);
-void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
-			long value);
-u64 hl_get_max_power(struct hl_device *hdev);
-void hl_set_max_power(struct hl_device *hdev);
-int hl_set_voltage(struct hl_device *hdev,
-			int sensor_index, u32 attr, long value);
-int hl_set_current(struct hl_device *hdev,
-			int sensor_index, u32 attr, long value);
-int hl_set_power(struct hl_device *hdev,
-			int sensor_index, u32 attr, long value);
-int hl_get_power(struct hl_device *hdev,
-			int sensor_index, u32 attr, long *value);
+long hl_fw_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
+void hl_fw_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq);
+int hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr, long *value);
+int hl_set_temperature(struct hl_device *hdev, int sensor_index, u32 attr, long value);
+int hl_get_voltage(struct hl_device *hdev, int sensor_index, u32 attr, long *value);
+int hl_get_current(struct hl_device *hdev, int sensor_index, u32 attr, long *value);
+int hl_get_fan_speed(struct hl_device *hdev, int sensor_index, u32 attr, long *value);
+int hl_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr, long *value);
+void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr, long value);
+u64 hl_fw_get_max_power(struct hl_device *hdev);
+void hl_fw_set_max_power(struct hl_device *hdev);
+int hl_set_voltage(struct hl_device *hdev, int sensor_index, u32 attr, long value);
+int hl_set_current(struct hl_device *hdev, int sensor_index, u32 attr, long value);
+int hl_set_power(struct hl_device *hdev, int sensor_index, u32 attr, long value);
+int hl_get_power(struct hl_device *hdev, int sensor_index, u32 attr, long *value);
 int hl_fw_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 void hl_fw_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
 void hl_sysfs_add_dev_clk_attr(struct hl_device *hdev, struct attribute_group *dev_attr_grp);
+
 void hw_sob_get(struct hl_hw_sob *hw_sob);
 void hw_sob_put(struct hl_hw_sob *hw_sob);
 void hl_encaps_handle_do_release(struct kref *ref);
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index d66cf43788d8..ce3538d36bb7 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -9,106 +9,6 @@
 
 #include <linux/pci.h>
 
-long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
-{
-	struct cpucp_packet pkt;
-	u32 used_pll_idx;
-	u64 result;
-	int rc;
-
-	rc = get_used_pll_index(hdev, pll_index, &used_pll_idx);
-	if (rc)
-		return rc;
-
-	memset(&pkt, 0, sizeof(pkt));
-
-	if (curr)
-		pkt.ctl = cpu_to_le32(CPUCP_PACKET_FREQUENCY_CURR_GET <<
-						CPUCP_PKT_CTL_OPCODE_SHIFT);
-	else
-		pkt.ctl = cpu_to_le32(CPUCP_PACKET_FREQUENCY_GET <<
-						CPUCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.pll_index = cpu_to_le32((u32)used_pll_idx);
-
-	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						0, &result);
-
-	if (rc) {
-		dev_err(hdev->dev,
-			"Failed to get frequency of PLL %d, error %d\n",
-			used_pll_idx, rc);
-		return rc;
-	}
-
-	return (long) result;
-}
-
-void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq)
-{
-	struct cpucp_packet pkt;
-	u32 used_pll_idx;
-	int rc;
-
-	rc = get_used_pll_index(hdev, pll_index, &used_pll_idx);
-	if (rc)
-		return;
-
-	memset(&pkt, 0, sizeof(pkt));
-
-	pkt.ctl = cpu_to_le32(CPUCP_PACKET_FREQUENCY_SET <<
-					CPUCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.pll_index = cpu_to_le32((u32)used_pll_idx);
-	pkt.value = cpu_to_le64(freq);
-
-	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						0, NULL);
-
-	if (rc)
-		dev_err(hdev->dev,
-			"Failed to set frequency to PLL %d, error %d\n",
-			used_pll_idx, rc);
-}
-
-u64 hl_get_max_power(struct hl_device *hdev)
-{
-	struct cpucp_packet pkt;
-	u64 result;
-	int rc;
-
-	memset(&pkt, 0, sizeof(pkt));
-
-	pkt.ctl = cpu_to_le32(CPUCP_PACKET_MAX_POWER_GET <<
-				CPUCP_PKT_CTL_OPCODE_SHIFT);
-
-	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						0, &result);
-
-	if (rc) {
-		dev_err(hdev->dev, "Failed to get max power, error %d\n", rc);
-		return (u64) rc;
-	}
-
-	return result;
-}
-
-void hl_set_max_power(struct hl_device *hdev)
-{
-	struct cpucp_packet pkt;
-	int rc;
-
-	memset(&pkt, 0, sizeof(pkt));
-
-	pkt.ctl = cpu_to_le32(CPUCP_PACKET_MAX_POWER_SET <<
-				CPUCP_PKT_CTL_OPCODE_SHIFT);
-	pkt.value = cpu_to_le64(hdev->max_power);
-
-	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						0, NULL);
-
-	if (rc)
-		dev_err(hdev->dev, "Failed to set max power, error %d\n", rc);
-}
-
 static ssize_t clk_max_freq_mhz_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
@@ -117,7 +17,7 @@ static ssize_t clk_max_freq_mhz_show(struct device *dev, struct device_attribute
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, false);
+	value = hl_fw_get_frequency(hdev, hdev->asic_prop.clk_pll_index, false);
 
 	hdev->asic_prop.max_freq_value = value;
 
@@ -144,7 +44,7 @@ static ssize_t clk_max_freq_mhz_store(struct device *dev, struct device_attribut
 
 	hdev->asic_prop.max_freq_value = value * 1000 * 1000;
 
-	hl_set_frequency(hdev, hdev->asic_prop.clk_pll_index, hdev->asic_prop.max_freq_value);
+	hl_fw_set_frequency(hdev, hdev->asic_prop.clk_pll_index, hdev->asic_prop.max_freq_value);
 
 fail:
 	return count;
@@ -158,7 +58,7 @@ static ssize_t clk_cur_freq_mhz_show(struct device *dev, struct device_attribute
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, true);
+	value = hl_fw_get_frequency(hdev, hdev->asic_prop.clk_pll_index, true);
 
 	return sprintf(buf, "%lu\n", (value / 1000 / 1000));
 }
@@ -386,7 +286,7 @@ static ssize_t max_power_show(struct device *dev, struct device_attribute *attr,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	val = hl_get_max_power(hdev);
+	val = hl_fw_get_max_power(hdev);
 
 	return sprintf(buf, "%lu\n", val);
 }
@@ -411,7 +311,7 @@ static ssize_t max_power_store(struct device *dev,
 	}
 
 	hdev->max_power = value;
-	hl_set_max_power(hdev);
+	hl_fw_set_max_power(hdev);
 
 out:
 	return count;
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index 76b47749affe..f9f3afe94056 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2021 HabanaLabs, Ltd.
+ * Copyright 2016-2022 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
@@ -13,19 +13,19 @@ void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
 
 	switch (freq) {
 	case PLL_HIGH:
-		hl_set_frequency(hdev, HL_GOYA_MME_PLL, hdev->high_pll);
-		hl_set_frequency(hdev, HL_GOYA_TPC_PLL, hdev->high_pll);
-		hl_set_frequency(hdev, HL_GOYA_IC_PLL, hdev->high_pll);
+		hl_fw_set_frequency(hdev, HL_GOYA_MME_PLL, hdev->high_pll);
+		hl_fw_set_frequency(hdev, HL_GOYA_TPC_PLL, hdev->high_pll);
+		hl_fw_set_frequency(hdev, HL_GOYA_IC_PLL, hdev->high_pll);
 		break;
 	case PLL_LOW:
-		hl_set_frequency(hdev, HL_GOYA_MME_PLL, GOYA_PLL_FREQ_LOW);
-		hl_set_frequency(hdev, HL_GOYA_TPC_PLL, GOYA_PLL_FREQ_LOW);
-		hl_set_frequency(hdev, HL_GOYA_IC_PLL, GOYA_PLL_FREQ_LOW);
+		hl_fw_set_frequency(hdev, HL_GOYA_MME_PLL, GOYA_PLL_FREQ_LOW);
+		hl_fw_set_frequency(hdev, HL_GOYA_TPC_PLL, GOYA_PLL_FREQ_LOW);
+		hl_fw_set_frequency(hdev, HL_GOYA_IC_PLL, GOYA_PLL_FREQ_LOW);
 		break;
 	case PLL_LAST:
-		hl_set_frequency(hdev, HL_GOYA_MME_PLL, goya->mme_clk);
-		hl_set_frequency(hdev, HL_GOYA_TPC_PLL, goya->tpc_clk);
-		hl_set_frequency(hdev, HL_GOYA_IC_PLL, goya->ic_clk);
+		hl_fw_set_frequency(hdev, HL_GOYA_MME_PLL, goya->mme_clk);
+		hl_fw_set_frequency(hdev, HL_GOYA_TPC_PLL, goya->tpc_clk);
+		hl_fw_set_frequency(hdev, HL_GOYA_IC_PLL, goya->ic_clk);
 		break;
 	default:
 		dev_err(hdev->dev, "unknown frequency setting\n");
@@ -41,7 +41,7 @@ static ssize_t mme_clk_show(struct device *dev, struct device_attribute *attr,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, HL_GOYA_MME_PLL, false);
+	value = hl_fw_get_frequency(hdev, HL_GOYA_MME_PLL, false);
 
 	if (value < 0)
 		return value;
@@ -74,7 +74,7 @@ static ssize_t mme_clk_store(struct device *dev, struct device_attribute *attr,
 		goto fail;
 	}
 
-	hl_set_frequency(hdev, HL_GOYA_MME_PLL, value);
+	hl_fw_set_frequency(hdev, HL_GOYA_MME_PLL, value);
 	goya->mme_clk = value;
 
 fail:
@@ -90,7 +90,7 @@ static ssize_t tpc_clk_show(struct device *dev, struct device_attribute *attr,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, HL_GOYA_TPC_PLL, false);
+	value = hl_fw_get_frequency(hdev, HL_GOYA_TPC_PLL, false);
 
 	if (value < 0)
 		return value;
@@ -123,7 +123,7 @@ static ssize_t tpc_clk_store(struct device *dev, struct device_attribute *attr,
 		goto fail;
 	}
 
-	hl_set_frequency(hdev, HL_GOYA_TPC_PLL, value);
+	hl_fw_set_frequency(hdev, HL_GOYA_TPC_PLL, value);
 	goya->tpc_clk = value;
 
 fail:
@@ -139,7 +139,7 @@ static ssize_t ic_clk_show(struct device *dev, struct device_attribute *attr,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, HL_GOYA_IC_PLL, false);
+	value = hl_fw_get_frequency(hdev, HL_GOYA_IC_PLL, false);
 
 	if (value < 0)
 		return value;
@@ -172,7 +172,7 @@ static ssize_t ic_clk_store(struct device *dev, struct device_attribute *attr,
 		goto fail;
 	}
 
-	hl_set_frequency(hdev, HL_GOYA_IC_PLL, value);
+	hl_fw_set_frequency(hdev, HL_GOYA_IC_PLL, value);
 	goya->ic_clk = value;
 
 fail:
@@ -188,7 +188,7 @@ static ssize_t mme_clk_curr_show(struct device *dev,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, HL_GOYA_MME_PLL, true);
+	value = hl_fw_get_frequency(hdev, HL_GOYA_MME_PLL, true);
 
 	if (value < 0)
 		return value;
@@ -205,7 +205,7 @@ static ssize_t tpc_clk_curr_show(struct device *dev,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, HL_GOYA_TPC_PLL, true);
+	value = hl_fw_get_frequency(hdev, HL_GOYA_TPC_PLL, true);
 
 	if (value < 0)
 		return value;
@@ -222,7 +222,7 @@ static ssize_t ic_clk_curr_show(struct device *dev,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, HL_GOYA_IC_PLL, true);
+	value = hl_fw_get_frequency(hdev, HL_GOYA_IC_PLL, true);
 
 	if (value < 0)
 		return value;
-- 
2.25.1

