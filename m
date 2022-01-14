Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7C348F0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 21:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbiANU2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 15:28:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:34023 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232761AbiANU2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 15:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642192086; x=1673728086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NBtuZOCI/VvXKB7yr72RHMvqEhb3Bk1Y/6yE42Illw8=;
  b=QHZbrroiDeONOBl7dBwTcp+I+r44QDann1p3FG/7kBACqJ9gq3L7eDbh
   HQyPitoJaolmoFLHaJvrqMY8OkRRnzZ8ef18W5VOsAztE9VUbllADSp+A
   lEWo7pkyI3/wLACOdE4qjYRR8uSane/xPDiBGlhcITOAFqWwPZ7cxg4Tk
   s4PXRjkpJsWK+3wz0+/tlExJ/4qYToreMcV8ycJ219rdwRjeZ0oUsVusx
   ScDNWNEXQpE81fMUJ4+yiplHLUVB4T7Cm1WhbLuhxY7GuSQlEbvgnuQCg
   OuEkFApy7NPbl6ttbBlLLTaVQ3Ol2R7T15blQJFtasVM4PgEk/vQdav2I
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="244282797"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="244282797"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 12:28:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="473767991"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2022 12:28:05 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [UPDATE][PATCH v2] ACPI / fan: Properly handle fine grain control
Date:   Fri, 14 Jan 2022 12:28:05 -0800
Message-Id: <20220114202805.103233-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When _FIF object specifies support for fine grain control, then fan speed
can be set from 0 to 100% with the recommended minimum "step size" via
_FSL object. Here the control value doesn't need to match any value from
_FPS object.

Currently we have a simple solution implemented which just pick maximum
control value from _FPS to display the actual state, but this is not
optimal when there is a big window between two control values in
_FPS. Also there is no way to set to any speed which doesn't match
control values in _FPS. The system firmware can start the fan at speed
which doesn't match any control value.

To support fine grain control via thermal sysfs:
- cooling device max state is not _FPS state count but it will be
100 / _FIF.step_size
- cooling device current state is 100 / _FIF.step_size
- cooling device set state will set the control value
curr_state * _FIF.step_size plus any adjustment for 100%.
By the spec, when control value do not sum to 100% because of
_FIF.step_size, OSPM may select an appropriate ending Level increment
to reach 100%.

Also publish the actual fan rpm in sysfs in the same place where
_FIF objects are displayed. Knowing fan rpm is helpful to reduce noise
level and use passive control instead. Also fan performance may not be
same over time, so the same control value may not be enough to run the
fan at a speed. So a feedback value of speed is helpful. This sysfs
attribute is called "fan_speed_rpm".

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2-update
Change log is missed for v2.
Missed one kfree(obj) on failure.
v2
Fix for build issue as reported by Reported-by: kernel test robot <lkp@intel.com>

 .../acpi/fan_performance_states.rst           |  10 ++
 drivers/acpi/fan.c                            | 142 ++++++++++++++----
 2 files changed, 125 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/acpi/fan_performance_states.rst b/Documentation/admin-guide/acpi/fan_performance_states.rst
index 98fe5c333121..2a5988d747e5 100644
--- a/Documentation/admin-guide/acpi/fan_performance_states.rst
+++ b/Documentation/admin-guide/acpi/fan_performance_states.rst
@@ -60,3 +60,13 @@ For example::
 
 When a given field is not populated or its value provided by the platform
 firmware is invalid, the "not-defined" string is shown instead of the value.
+
+ACPI Fan Performance Feedback
+=============================
+
+The optional _FST object provides status information for the fan device.
+This includes field to provide current fan speed in revolutions per minute
+at which the fan is rotating.
+
+This speed is presented in the sysfs using the attribute "fan_speed_rpm",
+in the same directory as performance states.
diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 5cd0ceb50bc8..b1ca5530c16c 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -64,12 +64,19 @@ struct acpi_fan_fif {
 	u64 low_speed_notification;
 };
 
+struct acpi_fan_fst {
+	u64 revision;
+	u64 control;
+	u64 speed;
+};
+
 struct acpi_fan {
 	bool acpi4;
 	struct acpi_fan_fif fif;
 	struct acpi_fan_fps *fps;
 	int fps_count;
 	struct thermal_cooling_device *cdev;
+	struct device_attribute fst_speed;
 };
 
 static struct platform_driver acpi_fan_driver = {
@@ -89,20 +96,23 @@ static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned long
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_fan *fan = acpi_driver_data(device);
 
-	if (fan->acpi4)
-		*state = fan->fps_count - 1;
-	else
+	if (fan->acpi4) {
+		if (fan->fif.fine_grain_ctrl)
+			*state = 100 / (int)fan->fif.step_size;
+		else
+			*state = fan->fps_count - 1;
+	} else {
 		*state = 1;
+	}
+
 	return 0;
 }
 
-static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
+static int fan_get_fps(struct acpi_device *device, struct acpi_fan_fst *fst)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_fan *fan = acpi_driver_data(device);
 	union acpi_object *obj;
 	acpi_status status;
-	int control, i;
 
 	status = acpi_evaluate_object(device->handle, "_FST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -119,31 +129,51 @@ static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
 		goto err;
 	}
 
-	control = obj->package.elements[1].integer.value;
+	fst->revision = obj->package.elements[0].integer.value;
+	fst->control = obj->package.elements[1].integer.value;
+	fst->speed = obj->package.elements[2].integer.value;
+
+	status = 0;
+err:
+	kfree(obj);
+	return status;
+}
+
+static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
+{
+	struct acpi_fan *fan = acpi_driver_data(device);
+	struct acpi_fan_fst fst;
+	int status;
+	int control, i;
+
+	status = fan_get_fps(device, &fst);
+	if (status)
+		return status;
+
+	control = fst.control;
+
+	if (fan->fif.fine_grain_ctrl) {
+		/* This control should be same what we set using _FSL by spec */
+		if (control > 100) {
+			dev_dbg(&device->dev, "Invalid control value returned\n");
+			return -EINVAL;
+		}
+
+		*state = control / (int)fan->fif.step_size;
+		return 0;
+	}
+
 	for (i = 0; i < fan->fps_count; i++) {
-		/*
-		 * When Fine Grain Control is set, return the state
-		 * corresponding to maximum fan->fps[i].control
-		 * value compared to the current speed. Here the
-		 * fan->fps[] is sorted array with increasing speed.
-		 */
-		if (fan->fif.fine_grain_ctrl && control < fan->fps[i].control) {
-			i = (i > 0) ? i - 1 : 0;
-			break;
-		} else if (control == fan->fps[i].control) {
+		if (control == fan->fps[i].control)
 			break;
-		}
 	}
 	if (i == fan->fps_count) {
 		dev_dbg(&device->dev, "Invalid control value returned\n");
-		status = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	*state = i;
 
-err:
-	kfree(obj);
 	return status;
 }
 
@@ -187,12 +217,36 @@ static int fan_set_state_acpi4(struct acpi_device *device, unsigned long state)
 {
 	struct acpi_fan *fan = acpi_driver_data(device);
 	acpi_status status;
+	u64 value = state;
+	int max_state;
+
+	if (fan->fif.fine_grain_ctrl)
+		max_state = 100 / (int)fan->fif.step_size;
+	else
+		max_state = fan->fps_count - 1;
 
-	if (state >= fan->fps_count)
+	if (state > max_state)
 		return -EINVAL;
 
-	status = acpi_execute_simple_method(device->handle, "_FSL",
-					    fan->fps[state].control);
+	if (fan->fif.fine_grain_ctrl) {
+		int rem;
+
+		value *= fan->fif.step_size;
+
+		/*
+		 * In the event OSPM’s incremental selections of Level
+		 * using the StepSize field value do not sum to 100%,
+		 * OSPM may select an appropriate ending Level
+		 * increment to reach 100%.
+		 */
+		rem = 100 - value;
+		if (rem && rem < fan->fif.step_size)
+			value = 100;
+	} else {
+		value = fan->fps[state].control;
+	}
+
+	status = acpi_execute_simple_method(device->handle, "_FSL", value);
 	if (ACPI_FAILURE(status)) {
 		dev_dbg(&device->dev, "Failed to set state by _FSL\n");
 		return status;
@@ -258,6 +312,12 @@ static int acpi_fan_get_fif(struct acpi_device *device)
 		status = -EINVAL;
 	}
 
+	/* If there is a bug in step size and set as 0, change to 1 */
+	if (!fan->fif.step_size)
+		fan->fif.step_size = 1;
+	/* If step size > 9, change to 9 (by spec valid values 1-9) */
+	if (fan->fif.step_size > 9)
+		fan->fif.step_size = 9;
 err:
 	kfree(obj);
 	return status;
@@ -303,6 +363,19 @@ static ssize_t show_state(struct device *dev, struct device_attribute *attr, cha
 	return count;
 }
 
+static ssize_t show_fan_speed(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct acpi_device *acpi_dev = container_of(dev, struct acpi_device, dev);
+	struct acpi_fan_fst fst;
+	int status;
+
+	status = fan_get_fps(acpi_dev, &fst);
+	if (status)
+		return status;
+
+	return sprintf(buf, "%lld\n", fst.speed);
+}
+
 static int acpi_fan_get_fps(struct acpi_device *device)
 {
 	struct acpi_fan *fan = acpi_driver_data(device);
@@ -311,15 +384,25 @@ static int acpi_fan_get_fps(struct acpi_device *device)
 	acpi_status status;
 	int i;
 
+	/* _FST is present if we are here */
+	sysfs_attr_init(&fan->fst_speed.attr);
+	fan->fst_speed.show = show_fan_speed;
+	fan->fst_speed.store = NULL;
+	fan->fst_speed.attr.name = "fan_speed_rpm";
+	fan->fst_speed.attr.mode = 0444;
+	status = sysfs_create_file(&device->dev.kobj, &fan->fst_speed.attr);
+	if (status)
+		return status;
+
 	status = acpi_evaluate_object(device->handle, "_FPS", NULL, &buffer);
 	if (ACPI_FAILURE(status))
-		return status;
+		goto rem_attr;
 
 	obj = buffer.pointer;
 	if (!obj || obj->type != ACPI_TYPE_PACKAGE || obj->package.count < 2) {
 		dev_err(&device->dev, "Invalid _FPS data\n");
 		status = -EINVAL;
-		goto err;
+		goto rem_attr;
 	}
 
 	fan->fps_count = obj->package.count - 1; /* minus revision field */
@@ -368,6 +451,11 @@ static int acpi_fan_get_fps(struct acpi_device *device)
 
 err:
 	kfree(obj);
+	if (!status)
+		return 0;
+rem_attr:
+	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
+
 	return status;
 }
 
-- 
2.34.1

