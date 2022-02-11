Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541A84B29CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350625AbiBKQJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:09:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350381AbiBKQJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:09:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEA6C66;
        Fri, 11 Feb 2022 08:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644595779; x=1676131779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fRgSXEgUv3DVL7T1DSXlZqr4620E4pOzAESs/lUbShg=;
  b=jsLBrJLfyKNoH7KQWbT5IJxcj/xMYg100ZbPSHJvXCsvpO1SWkTVZw3y
   exaokYC4hJU0vXWnIT3LdViAVz5rRgEkvd9s/JXESU301yqN08CZbcR9q
   UH6/dMciLhCqR9zrL5L2/9mx9yIK1jDsnBh1nHLYMyD/hK+YnupdAdMn8
   XVIftQsZG0gtei5RncszK6DT6d57QQGtvB0VWYwS/FtBleQ5PGGeibkk/
   pzI3VHztJQHcd6jCm0ZwEQHJkNt4vPevap6OI4gVgnduTU/ZCssNdUtPm
   r6ooMvMO5G1K+43PZtgrs+AUNvGkWXMw842IIqsBhfd6kT+Lgxr/NmAMp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249703807"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="249703807"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="630393691"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2022 08:09:38 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 2/6] ACPI / fan: Separate file for attributes creation
Date:   Fri, 11 Feb 2022 08:09:28 -0800
Message-Id: <20220211160932.3221873-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220211160932.3221873-1-srinivas.pandruvada@linux.intel.com>
References: <20220211160932.3221873-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the functionality of creation of sysfs attributes under acpi device
to a new file fan_attr.c. This cleans up the core fan code, which just
use thermal sysfs interface. The original fan.c is renamed to
fan_core.c.

No functional changes are expected.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/Makefile              |  3 +
 drivers/acpi/fan.h                 | 35 +++++++++++
 drivers/acpi/fan_attr.c            | 86 ++++++++++++++++++++++++++
 drivers/acpi/{fan.c => fan_core.c} | 98 +++---------------------------
 4 files changed, 133 insertions(+), 89 deletions(-)
 create mode 100644 drivers/acpi/fan_attr.c
 rename drivers/acpi/{fan.c => fan_core.c} (80%)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index bb757148e7ba..b5a8d3e00a52 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -81,6 +81,9 @@ obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
 obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)	+= tiny-power-button.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
+fan-objs			:= fan_core.o
+fan-objs			+= fan_attr.o
+
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o
 obj-$(CONFIG_ACPI_TAD)		+= acpi_tad.o
 obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index dd9bb8ca2244..36c5e1a57094 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -6,9 +6,44 @@
  *
  * Add new device IDs before the generic ACPI fan one.
  */
+
+#ifndef _ACPI_FAN_H_
+#define _ACPI_FAN_H_
+
 #define ACPI_FAN_DEVICE_IDS	\
 	{"INT3404", }, /* Fan */ \
 	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
 	{"INTC1048", }, /* Fan for Alder Lake generation */ \
 	{"INTC10A2", }, /* Fan for Raptor Lake generation */ \
 	{"PNP0C0B", } /* Generic ACPI fan */
+
+#define ACPI_FPS_NAME_LEN	20
+
+struct acpi_fan_fps {
+	u64 control;
+	u64 trip_point;
+	u64 speed;
+	u64 noise_level;
+	u64 power;
+	char name[ACPI_FPS_NAME_LEN];
+	struct device_attribute dev_attr;
+};
+
+struct acpi_fan_fif {
+	u64 revision;
+	u64 fine_grain_ctrl;
+	u64 step_size;
+	u64 low_speed_notification;
+};
+
+struct acpi_fan {
+	bool acpi4;
+	struct acpi_fan_fif fif;
+	struct acpi_fan_fps *fps;
+	int fps_count;
+	struct thermal_cooling_device *cdev;
+};
+
+int acpi_fan_create_attributes(struct acpi_device *device);
+void acpi_fan_delete_attributes(struct acpi_device *device);
+#endif
diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
new file mode 100644
index 000000000000..7b109022108b
--- /dev/null
+++ b/drivers/acpi/fan_attr.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  fan_attr.c - Create extra attributes for ACPI Fan driver
+ *
+ *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
+ *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ *  Copyright (C) 2022 Intel Corporation. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+
+#include "fan.h"
+
+MODULE_LICENSE("GPL");
+
+static ssize_t show_state(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct acpi_fan_fps *fps = container_of(attr, struct acpi_fan_fps, dev_attr);
+	int count;
+
+	if (fps->control == 0xFFFFFFFF || fps->control > 100)
+		count = scnprintf(buf, PAGE_SIZE, "not-defined:");
+	else
+		count = scnprintf(buf, PAGE_SIZE, "%lld:", fps->control);
+
+	if (fps->trip_point == 0xFFFFFFFF || fps->trip_point > 9)
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
+	else
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->trip_point);
+
+	if (fps->speed == 0xFFFFFFFF)
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
+	else
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->speed);
+
+	if (fps->noise_level == 0xFFFFFFFF)
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
+	else
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->noise_level * 100);
+
+	if (fps->power == 0xFFFFFFFF)
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined\n");
+	else
+		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld\n", fps->power);
+
+	return count;
+}
+
+int acpi_fan_create_attributes(struct acpi_device *device)
+{
+	struct acpi_fan *fan = acpi_driver_data(device);
+	int i, status = 0;
+
+	for (i = 0; i < fan->fps_count; ++i) {
+		struct acpi_fan_fps *fps = &fan->fps[i];
+
+		snprintf(fps->name, ACPI_FPS_NAME_LEN, "state%d", i);
+		sysfs_attr_init(&fps->dev_attr.attr);
+		fps->dev_attr.show = show_state;
+		fps->dev_attr.store = NULL;
+		fps->dev_attr.attr.name = fps->name;
+		fps->dev_attr.attr.mode = 0444;
+		status = sysfs_create_file(&device->dev.kobj, &fps->dev_attr.attr);
+		if (status) {
+			int j;
+
+			for (j = 0; j < i; ++j)
+				sysfs_remove_file(&device->dev.kobj, &fan->fps[j].dev_attr.attr);
+			break;
+		}
+	}
+
+	return status;
+}
+
+void acpi_fan_delete_attributes(struct acpi_device *device)
+{
+	struct acpi_fan *fan = acpi_driver_data(device);
+	int i;
+
+	for (i = 0; i < fan->fps_count; ++i)
+		sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
+}
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan_core.c
similarity index 80%
rename from drivers/acpi/fan.c
rename to drivers/acpi/fan_core.c
index 098d64568d6d..9f8e68403fad 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan_core.c
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  acpi_fan.c - ACPI Fan Driver ($Revision: 29 $)
+ *  fan_core.c - ACPI Fan core Driver
  *
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
+ *  Copyright (C) 2022 Intel Corporation. All rights reserved.
  */
 
 #include <linux/kernel.h>
@@ -45,33 +46,6 @@ static const struct dev_pm_ops acpi_fan_pm = {
 #define FAN_PM_OPS_PTR NULL
 #endif
 
-#define ACPI_FPS_NAME_LEN	20
-
-struct acpi_fan_fps {
-	u64 control;
-	u64 trip_point;
-	u64 speed;
-	u64 noise_level;
-	u64 power;
-	char name[ACPI_FPS_NAME_LEN];
-	struct device_attribute dev_attr;
-};
-
-struct acpi_fan_fif {
-	u64 revision;
-	u64 fine_grain_ctrl;
-	u64 step_size;
-	u64 low_speed_notification;
-};
-
-struct acpi_fan {
-	bool acpi4;
-	struct acpi_fan_fif fif;
-	struct acpi_fan_fps *fps;
-	int fps_count;
-	struct thermal_cooling_device *cdev;
-};
-
 static struct platform_driver acpi_fan_driver = {
 	.probe = acpi_fan_probe,
 	.remove = acpi_fan_remove,
@@ -270,39 +244,6 @@ static int acpi_fan_speed_cmp(const void *a, const void *b)
 	return fps1->speed - fps2->speed;
 }
 
-static ssize_t show_state(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct acpi_fan_fps *fps = container_of(attr, struct acpi_fan_fps, dev_attr);
-	int count;
-
-	if (fps->control == 0xFFFFFFFF || fps->control > 100)
-		count = scnprintf(buf, PAGE_SIZE, "not-defined:");
-	else
-		count = scnprintf(buf, PAGE_SIZE, "%lld:", fps->control);
-
-	if (fps->trip_point == 0xFFFFFFFF || fps->trip_point > 9)
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
-	else
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->trip_point);
-
-	if (fps->speed == 0xFFFFFFFF)
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
-	else
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->speed);
-
-	if (fps->noise_level == 0xFFFFFFFF)
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined:");
-	else
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld:", fps->noise_level * 100);
-
-	if (fps->power == 0xFFFFFFFF)
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "not-defined\n");
-	else
-		count += scnprintf(&buf[count], PAGE_SIZE - count, "%lld\n", fps->power);
-
-	return count;
-}
-
 static int acpi_fan_get_fps(struct acpi_device *device)
 {
 	struct acpi_fan *fan = acpi_driver_data(device);
@@ -347,25 +288,6 @@ static int acpi_fan_get_fps(struct acpi_device *device)
 	sort(fan->fps, fan->fps_count, sizeof(*fan->fps),
 	     acpi_fan_speed_cmp, NULL);
 
-	for (i = 0; i < fan->fps_count; ++i) {
-		struct acpi_fan_fps *fps = &fan->fps[i];
-
-		snprintf(fps->name, ACPI_FPS_NAME_LEN, "state%d", i);
-		sysfs_attr_init(&fps->dev_attr.attr);
-		fps->dev_attr.show = show_state;
-		fps->dev_attr.store = NULL;
-		fps->dev_attr.attr.name = fps->name;
-		fps->dev_attr.attr.mode = 0444;
-		status = sysfs_create_file(&device->dev.kobj, &fps->dev_attr.attr);
-		if (status) {
-			int j;
-
-			for (j = 0; j < i; ++j)
-				sysfs_remove_file(&device->dev.kobj, &fan->fps[j].dev_attr.attr);
-			break;
-		}
-	}
-
 err:
 	kfree(obj);
 	return status;
@@ -396,6 +318,10 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		if (result)
 			return result;
 
+		result = acpi_fan_create_attributes(device);
+		if (result)
+			return result;
+
 		fan->acpi4 = true;
 	} else {
 		result = acpi_device_update_power(device, NULL);
@@ -437,12 +363,8 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	return 0;
 
 err_end:
-	if (fan->acpi4) {
-		int i;
-
-		for (i = 0; i < fan->fps_count; ++i)
-			sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
-	}
+	if (fan->acpi4)
+		acpi_fan_delete_attributes(device);
 
 	return result;
 }
@@ -453,10 +375,8 @@ static int acpi_fan_remove(struct platform_device *pdev)
 
 	if (fan->acpi4) {
 		struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
-		int i;
 
-		for (i = 0; i < fan->fps_count; ++i)
-			sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
+		acpi_fan_delete_attributes(device);
 	}
 	sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
 	sysfs_remove_link(&fan->cdev->device.kobj, "device");
-- 
2.34.1

