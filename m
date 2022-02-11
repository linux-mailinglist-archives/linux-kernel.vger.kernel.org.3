Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35C24B29BD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350802AbiBKQJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:09:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350409AbiBKQJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:09:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88131D84;
        Fri, 11 Feb 2022 08:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644595781; x=1676131781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1rdaSwi1dN/EBmd/AELzBZJmFKJgZJZg5SMiMgNnjYs=;
  b=DpwEtIVfIyd7PD1cc7KNKzWJq12m9ZUXl2PdZ7RKECN6dQOBbZfrU3hh
   OwFwAN3mAjZkgPVzR3bGqvjJDqqr6Aj41zfg5I7jfBZ94zpERMhBysKEy
   YBLEM0kb60vtRSTxKkBTUH2Ju50npWeSLm2RLyjml0k+De1f61nJyIhFF
   f7gfblZXZXap9Cf9ax+7ve6TiDd3uNQ2MZ5cWw2YFm9/WE05Qcxs07NXI
   /LeqGaFBpKq6Y39LpGniXAwKPi//gKQ9swK5HPBEJcU2PCs5iJiX5uGei
   UnLTHo1Yld7xkpblwhi4thQcZUc63EF5rjA+kzuj7sc6YCyJrM21LPVOY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249703809"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="249703809"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:09:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="630393699"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2022 08:09:38 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 4/6] ACPI / fan: Properly handle fine grain control
Date:   Fri, 11 Feb 2022 08:09:30 -0800
Message-Id: <20220211160932.3221873-5-srinivas.pandruvada@linux.intel.com>
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
Step size can be from 1 to 9.
- cooling device current state is _FST.control / _FIF.step_size
- cooling device set state will set the control value
cdev.curr_state * _FIF.step_size plus any adjustment for 100%.
By the spec, when control value do not sum to 100% because of
_FIF.step_size, OSPM may select an appropriate ending Level increment
to reach 100%.

There is no rounding during calculation. For example if step size
is 6:
thermal sysfs cooling device max_state = 100/6 = 16
So user can set any value from 0-16.

If the system boots with a _FST.control which is not multiples
of step_size, the thermal sysfs cur_state will be based on the
range. For example for step size = 6:
_FST.control	thermal sysfs cur_state
------------------------------------------------
0-5		0
6-11		1
..
..
90-95		15
96-100		16

While setting the _FST.control, the compensation will be at
the last step for cur_state = 16, which will set the _FST.control
to 100.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/fan.h      |  6 +++
 drivers/acpi/fan_core.c | 94 +++++++++++++++++++++++++++++------------
 2 files changed, 74 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 6cbb4b028da0..4c01be2e3b77 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -36,6 +36,12 @@ struct acpi_fan_fif {
 	u8 low_speed_notification;
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
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 484cee0fb13e..495f59222881 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -63,20 +63,24 @@ static int fan_get_max_state(struct thermal_cooling_device *cdev, unsigned long
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_fan *fan = acpi_driver_data(device);
 
-	if (fan->acpi4)
-		*state = fan->fps_count - 1;
-	else
+	if (fan->acpi4) {
+		if (fan->fif.fine_grain_ctrl)
+			*state = 100 / fan->fif.step_size;
+		else
+			*state = fan->fps_count - 1;
+	} else {
 		*state = 1;
+	}
+
 	return 0;
 }
 
-static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
+static int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_fan *fan = acpi_driver_data(device);
 	union acpi_object *obj;
 	acpi_status status;
-	int control, i;
+	int ret = 0;
 
 	status = acpi_evaluate_object(device->handle, "_FST", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
@@ -89,35 +93,52 @@ static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
 	    obj->package.count != 3 ||
 	    obj->package.elements[1].type != ACPI_TYPE_INTEGER) {
 		dev_err(&device->dev, "Invalid _FST data\n");
-		status = -EINVAL;
+		ret = -EINVAL;
 		goto err;
 	}
 
-	control = obj->package.elements[1].integer.value;
+	fst->revision = obj->package.elements[0].integer.value;
+	fst->control = obj->package.elements[1].integer.value;
+	fst->speed = obj->package.elements[2].integer.value;
+
+err:
+	kfree(obj);
+	return ret;
+}
+
+static int fan_get_state_acpi4(struct acpi_device *device, unsigned long *state)
+{
+	struct acpi_fan *fan = acpi_driver_data(device);
+	struct acpi_fan_fst fst;
+	int status, i;
+
+	status = acpi_fan_get_fst(device, &fst);
+	if (status)
+		return status;
+
+	if (fan->fif.fine_grain_ctrl) {
+		/* This control should be same what we set using _FSL by spec */
+		if (fst.control > 100) {
+			dev_dbg(&device->dev, "Invalid control value returned\n");
+			goto match_fps;
+		}
+
+		*state = fst.control / fan->fif.step_size;
+		return 0;
+	}
+
+match_fps:
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
+		if (fst.control == fan->fps[i].control)
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
 
@@ -161,12 +182,27 @@ static int fan_set_state_acpi4(struct acpi_device *device, unsigned long state)
 {
 	struct acpi_fan *fan = acpi_driver_data(device);
 	acpi_status status;
+	u64 value = state;
+	int max_state;
 
-	if (state >= fan->fps_count)
+	if (fan->fif.fine_grain_ctrl)
+		max_state = 100 / fan->fif.step_size;
+	else
+		max_state = fan->fps_count - 1;
+
+	if (state > max_state)
 		return -EINVAL;
 
-	status = acpi_execute_simple_method(device->handle, "_FSL",
-					    fan->fps[state].control);
+	if (fan->fif.fine_grain_ctrl) {
+		value *= fan->fif.step_size;
+		/* Spec allows compensate the last step only */
+		if (value + fan->fif.step_size > 100)
+			value = 100;
+	} else {
+		value = fan->fps[state].control;
+	}
+
+	status = acpi_execute_simple_method(device->handle, "_FSL", value);
 	if (ACPI_FAILURE(status)) {
 		dev_dbg(&device->dev, "Failed to set state by _FSL\n");
 		return -ENODEV;
@@ -238,6 +274,12 @@ static int acpi_fan_get_fif(struct acpi_device *device)
 	fan->fif.step_size = fields[2];
 	fan->fif.low_speed_notification = fields[3];
 
+	/* If there is a bug in step size and set as 0, change to 1 */
+	if (!fan->fif.step_size)
+		fan->fif.step_size = 1;
+	/* If step size > 9, change to 9 (by spec valid values 1-9) */
+	else if (fan->fif.step_size > 9)
+		fan->fif.step_size = 9;
 err:
 	kfree(obj);
 	return status;
-- 
2.34.1

