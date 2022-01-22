Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF23496DC5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiAVT6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40594 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiAVT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8258ACE09EC
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C68DC004E1;
        Sat, 22 Jan 2022 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881477;
        bh=IXIbUqJGHmg3ojfwHCdVG4hBWMeEp3Aaeq5o+Fa7dkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bHp+dyaScu7jdKwfUTR7iYnWb2EwLLdcNpQU2ixNB78GuQjgMjrVbXp8wrwBcclWi
         cCB6u7iLqm24n5uuo+Z6jEh+v7nuX9AQhYR5ur5aP4rpbmS7ZwozeZ2tPwFkJqQNiG
         TuUVcaLNWTiRrAocHqVhdVdgUrK4HoZ2cTpdo8Inp5Bo/u4LuuDttAtPU1Yj0rmoW0
         J/4LEZj1r/iW/Qj4YcpINmA3aaUMnH+1KlmN9pAmfGkMDUmxRfy7Zwt4LPaapAI902
         4/lAhzVLj41RyvjBZp9uN4u/D46yQ0LAwX5Cnz0Rr6OQ85tBbyhfT9ssfF/YZh2LgN
         0uDUD0xmAQJrg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajaravi Krishna Katta <rkatta@habana.ai>
Subject: [PATCH 16/30] habanalabs: sysfs support for fw os version
Date:   Sat, 22 Jan 2022 21:57:17 +0200
Message-Id: <20220122195731.934494-16-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajaravi Krishna Katta <rkatta@habana.ai>

Adds new sysfs entry to display firmware os version
/sys/class/habanalabs/hl<n>/fw_os_ver

Signed-off-by: Rajaravi Krishna Katta <rkatta@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 Documentation/ABI/testing/sysfs-driver-habanalabs |  6 ++++++
 drivers/misc/habanalabs/common/sysfs.c            | 10 ++++++++++
 drivers/misc/habanalabs/include/common/cpucp_if.h |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
index c16a573eb680..96646fb2e7a1 100644
--- a/Documentation/ABI/testing/sysfs-driver-habanalabs
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -69,6 +69,12 @@ KernelVersion:  5.1
 Contact:        ogabbay@kernel.org
 Description:    Displays the device's version from the eFuse
 
+What:           /sys/class/habanalabs/hl<n>/fw_os_ver
+Date:           Dec 2021
+KernelVersion:  5.18
+Contact:        ogabbay@kernel.org
+Description:    Version of the firmware OS running on the device's CPU
+
 What:           /sys/class/habanalabs/hl<n>/hard_reset
 Date:           Jan 2019
 KernelVersion:  5.1
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 65b132fa6dbd..3f220dd3b6b2 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -156,6 +156,14 @@ static ssize_t thermal_ver_show(struct device *dev,
 	return sprintf(buf, "%s", hdev->asic_prop.cpucp_info.thermal_version);
 }
 
+static ssize_t fw_os_ver_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s", hdev->asic_prop.cpucp_info.fw_os_version);
+}
+
 static ssize_t preboot_btl_ver_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -370,6 +378,7 @@ static DEVICE_ATTR_RO(soft_reset_cnt);
 static DEVICE_ATTR_RO(status);
 static DEVICE_ATTR_RO(thermal_ver);
 static DEVICE_ATTR_RO(uboot_ver);
+static DEVICE_ATTR_RO(fw_os_ver);
 
 static struct bin_attribute bin_attr_eeprom = {
 	.attr = {.name = "eeprom", .mode = (0444)},
@@ -393,6 +402,7 @@ static struct attribute *hl_dev_attrs[] = {
 	&dev_attr_status.attr,
 	&dev_attr_thermal_ver.attr,
 	&dev_attr_uboot_ver.attr,
+	&dev_attr_fw_os_ver.attr,
 	NULL,
 };
 
diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 737c39f33f05..f00db22f98fb 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -780,6 +780,7 @@ struct cpucp_security_info {
  *                     (0 = functional 1 = binned)
  * @xbar_binning_mask: Xbar binning mask, 1 bit per Xbar instance
  *                     (0 = functional 1 = binned)
+ * @fw_os_version: Firmware OS Version
  */
 struct cpucp_info {
 	struct cpucp_sensor sensors[CPUCP_MAX_SENSORS];
@@ -807,6 +808,7 @@ struct cpucp_info {
 	__le32 reserved6;
 	__u8 pll_map[PLL_MAP_LEN];
 	__le64 mme_binning_mask;
+	__u8 fw_os_version[VERSION_MAX_LEN];
 };
 
 struct cpucp_mac_addr {
-- 
2.25.1

