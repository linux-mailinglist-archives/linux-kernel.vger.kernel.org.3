Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD6C4B29B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350751AbiBKQJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:09:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350427AbiBKQJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:09:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C1D1B5;
        Fri, 11 Feb 2022 08:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644595781; x=1676131781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDgSDgj/IJxy0V0VS/ahZhuxr3XKA92Buc2Br8phiUs=;
  b=HYHxIV9ks1/NMtBx+8smHHPMPDV34jmg3UpxDPvRNvpvT4FVCrVxIPqI
   0w7JYqCqgjYEentPJZ1mCMDfho6PjOGIdGtZWU++a8v0kHFrtvvBGoqz8
   iN/yKctIVsUStMafgIV4BjUm5gUnFVrpIMBlPc2qJs29L+9eTluqDJA2y
   EsTwBJtKPSOtmm/YEZA/odEjXAfaarMwpvx1sIkvyhpdUTsXs3jSIEtoC
   VmLG3nUdukOXuBNL2tibGefXzYeg1LjU/gwvarTGhcYWXRdyZC/4wcfMq
   lsXFpgczTw1TMYoWzZoTSEJn+k17JhiaelkS6GO5ATJ9PpuZRIRPQqAC3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249703810"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="249703810"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:09:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="630393705"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2022 08:09:39 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 5/6] ACPI / fan: Add additional attributes for fine grain control
Date:   Fri, 11 Feb 2022 08:09:31 -0800
Message-Id: <20220211160932.3221873-6-srinivas.pandruvada@linux.intel.com>
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

Add additional attributes, which helps in implementing algorithm in
the user space to optimize fan control. These attributes are presented
in the same directory as the existing performance state attributes.

Additional attributes:

1. Support of fine grain control
Publish support of presence of fine grain control so that fan speed
can be tuned correctly. This attribute is called "fine_grain_control".

2. fan speed
Publish the actual fan rpm in sysfs. Knowing fan rpm is helpful to
reduce noise level and use passive control instead. Also fan performance
may not be same over time, so the same control value may not be enough
to run the fan at a speed. So a feedback value of speed is helpful. This
sysfs attribute is called "fan_speed_rpm".

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/fan.h      |  3 +++
 drivers/acpi/fan_attr.c | 55 +++++++++++++++++++++++++++++++++++++++--
 drivers/acpi/fan_core.c |  2 +-
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 4c01be2e3b77..44728529a5b6 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -48,8 +48,11 @@ struct acpi_fan {
 	struct acpi_fan_fps *fps;
 	int fps_count;
 	struct thermal_cooling_device *cdev;
+	struct device_attribute fst_speed;
+	struct device_attribute fine_grain_control;
 };
 
+int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst);
 int acpi_fan_create_attributes(struct acpi_device *device);
 void acpi_fan_delete_attributes(struct acpi_device *device);
 #endif
diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
index 7b109022108b..f15157d40713 100644
--- a/drivers/acpi/fan_attr.c
+++ b/drivers/acpi/fan_attr.c
@@ -49,10 +49,50 @@ static ssize_t show_state(struct device *dev, struct device_attribute *attr, cha
 	return count;
 }
 
+static ssize_t show_fan_speed(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct acpi_device *acpi_dev = container_of(dev, struct acpi_device, dev);
+	struct acpi_fan_fst fst;
+	int status;
+
+	status = acpi_fan_get_fst(acpi_dev, &fst);
+	if (status)
+		return status;
+
+	return sprintf(buf, "%lld\n", fst.speed);
+}
+
+static ssize_t show_fine_grain_control(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct acpi_device *acpi_dev = container_of(dev, struct acpi_device, dev);
+	struct acpi_fan *fan = acpi_driver_data(acpi_dev);
+
+	return sprintf(buf, "%d\n", fan->fif.fine_grain_ctrl);
+}
+
 int acpi_fan_create_attributes(struct acpi_device *device)
 {
 	struct acpi_fan *fan = acpi_driver_data(device);
-	int i, status = 0;
+	int i, status;
+
+	sysfs_attr_init(&fan->fine_grain_control.attr);
+	fan->fine_grain_control.show = show_fine_grain_control;
+	fan->fine_grain_control.store = NULL;
+	fan->fine_grain_control.attr.name = "fine_grain_control";
+	fan->fine_grain_control.attr.mode = 0444;
+	status = sysfs_create_file(&device->dev.kobj, &fan->fine_grain_control.attr);
+	if (status)
+		return status;
+
+	/* _FST is present if we are here */
+	sysfs_attr_init(&fan->fst_speed.attr);
+	fan->fst_speed.show = show_fan_speed;
+	fan->fst_speed.store = NULL;
+	fan->fst_speed.attr.name = "fan_speed_rpm";
+	fan->fst_speed.attr.mode = 0444;
+	status = sysfs_create_file(&device->dev.kobj, &fan->fst_speed.attr);
+	if (status)
+		goto rem_fine_grain_attr;
 
 	for (i = 0; i < fan->fps_count; ++i) {
 		struct acpi_fan_fps *fps = &fan->fps[i];
@@ -69,10 +109,18 @@ int acpi_fan_create_attributes(struct acpi_device *device)
 
 			for (j = 0; j < i; ++j)
 				sysfs_remove_file(&device->dev.kobj, &fan->fps[j].dev_attr.attr);
-			break;
+			goto rem_fst_attr;
 		}
 	}
 
+	return 0;
+
+rem_fst_attr:
+	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
+
+rem_fine_grain_attr:
+	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
+
 	return status;
 }
 
@@ -83,4 +131,7 @@ void acpi_fan_delete_attributes(struct acpi_device *device)
 
 	for (i = 0; i < fan->fps_count; ++i)
 		sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
+
+	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
+	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
 }
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 495f59222881..f89e43b89511 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -75,7 +75,7 @@ static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned long
 	return 0;
 }
 
-static int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst)
+int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
-- 
2.34.1

