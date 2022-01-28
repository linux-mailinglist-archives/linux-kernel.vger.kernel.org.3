Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C0D4A04A3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351867AbiA1Xvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:51:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:48859 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351892AbiA1Xvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643413898; x=1674949898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ehfsCCjOdGU+puOWYXMjVAXTnfyRC+63WeCqzDsYCo8=;
  b=GK15YzCH/YxWEDDRmbH6hzSpPCAwT94Sgfq1W0d6WmFaITsjyBzVWRFL
   GbfZf7WpPZid3ormcVTgt9Wepvo9FXu23td1tID7nYzSBMMKrN7GYW48i
   i1ICIBJgusJqui76+C7CNKJa4vx37LAzFPl47TiYtAklDF9Qt1T1xpid+
   D3h7oXbmKjjseWRbKAc9H2zbghXfXM1dCOW3BEkevtmD8Meikg7ZO5asE
   THZK4Mu5I6xa4d7d3FeiI2vFR/3XuQRrncxPp7WAA7FEYAJheoAv4lhk0
   pQlMhkYCj4mqL6pXZnJXo5u+ZnzxgXAzwThq24vhUWvo58YSS9kCLn7+w
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="244818044"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="244818044"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:51:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="564352998"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2022 15:51:26 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3] ACPI / fan: Properly handle fine grain control
Date:   Fri, 28 Jan 2022 15:51:18 -0800
Message-Id: <20220128235118.1693865-1-srinivas.pandruvada@linux.intel.com>
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

To support fine grain control (when supported) via thermal sysfs:
- cooling device max state is not _FPS state count but it will be
100 / _FIF.step_size
- cooling device current state is 100 / _FIF.step_size
- cooling device set state will set the control value
curr_state * _FIF.step_size plus any adjustment for 100%.
By the spec, when control value do not sum to 100% because of
_FIF.step_size, OSPM may select an appropriate ending Level increment
to reach 100%.

In addition publish attributes, which helps in implementing
algorithm in the user space to optimize fan control. These
attributes are presened in the same directory as the performance
states.
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
v3
Added fine_grain_control attribute.
v2-update
Change log is missed for v2.
v2
Fix for build issue as reported by Reported-by: kernel test robot <lkp@intel.com>

 .../acpi/fan_performance_states.rst           |  29 +++-
 drivers/acpi/fan.c                            | 164 +++++++++++++++---
 2 files changed, 164 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/acpi/fan_performance_states.rst b/Documentation/admin-guide/acpi/fan_performance_states.rst
index 98fe5c333121..2aec8e89dbd9 100644
--- a/Documentation/admin-guide/acpi/fan_performance_states.rst
+++ b/Documentation/admin-guide/acpi/fan_performance_states.rst
@@ -58,5 +58,30 @@ For example::
  $cat /sys/bus/acpi/devices/INT3404:00/state1
  25:0:3200:12500:1250
 
-When a given field is not populated or its value provided by the platform
-firmware is invalid, the "not-defined" string is shown instead of the value.
+ACPI Fan Fine Grain Control
+=============================
+
+When _FIF object specifies support for fine grain control, then fan speed
+can be set from 0 to 100% with the recommended minimum "step size" via
+_FSL object. User can adjust fan speed using thermal sysfs cooling device.
+
+Here use can look at fan performance states for a reference speed (speed_rpm)
+and set it by changing cooling device cur_state. If the fine grain control
+is supported then user can also adjust to some other speeds which are
+not defined in the performance states.
+
+The support of fine grain control is presented via sysfs attribute
+"fine_grain_control". If fine grain control is present, this attribute
+will show "1" otherwise "0".
+
+This sysfs attribute is presented in the same directory as performance states.
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
index 5cd0ceb50bc8..ab586be2d4fc 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -64,12 +64,20 @@ struct acpi_fan_fif {
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
+	struct device_attribute fine_grain_control;
 };
 
 static struct platform_driver acpi_fan_driver = {
@@ -89,20 +97,23 @@ static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned long
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
@@ -119,31 +130,51 @@ static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
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
+		if (control == fan->fps[i].control)
 			break;
-		} else if (control == fan->fps[i].control) {
-			break;
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
 
@@ -187,12 +218,36 @@ static int fan_set_state_acpi4(struct acpi_device *device, unsigned long state)
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
@@ -258,6 +313,12 @@ static int acpi_fan_get_fif(struct acpi_device *device)
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
@@ -303,6 +364,27 @@ static ssize_t show_state(struct device *dev, struct device_attribute *attr, cha
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
+static ssize_t show_fine_grain_control(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct acpi_device *acpi_dev = container_of(dev, struct acpi_device, dev);
+	struct acpi_fan *fan = acpi_driver_data(acpi_dev);
+
+	return sprintf(buf, "%lld\n", fan->fif.fine_grain_ctrl);
+}
+
 static int acpi_fan_get_fps(struct acpi_device *device)
 {
 	struct acpi_fan *fan = acpi_driver_data(device);
@@ -311,15 +393,35 @@ static int acpi_fan_get_fps(struct acpi_device *device)
 	acpi_status status;
 	int i;
 
+	sysfs_attr_init(&fan->fine_grain_control.attr);
+	fan->fine_grain_control.show = show_fine_grain_control;
+	fan->fine_grain_control.store = NULL;
+	fan->fine_grain_control.attr.name = "fine_grain_control";
+	fan->fine_grain_control.attr.mode = 0444;
+	status = sysfs_create_file(&device->dev.kobj, &fan->fine_grain_control.attr);
+	if (status)
+		return status;
+
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
+
 	status = acpi_evaluate_object(device->handle, "_FPS", NULL, &buffer);
 	if (ACPI_FAILURE(status))
-		return status;
+		goto rem_fst_attr;
 
 	obj = buffer.pointer;
 	if (!obj || obj->type != ACPI_TYPE_PACKAGE || obj->package.count < 2) {
 		dev_err(&device->dev, "Invalid _FPS data\n");
 		status = -EINVAL;
-		goto err;
+		goto rem_fst_attr;
 	}
 
 	fan->fps_count = obj->package.count - 1; /* minus revision field */
@@ -368,6 +470,14 @@ static int acpi_fan_get_fps(struct acpi_device *device)
 
 err:
 	kfree(obj);
+	if (!status)
+		return 0;
+rem_fst_attr:
+	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
+
+rem_fine_grain_attr:
+	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
+
 	return status;
 }
 
-- 
2.31.1

