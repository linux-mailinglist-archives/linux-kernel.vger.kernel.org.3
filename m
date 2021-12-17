Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE52479448
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbhLQStT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:49:19 -0500
Received: from foss.arm.com ([217.140.110.172]:33446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239844AbhLQStR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:49:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 741541476;
        Fri, 17 Dec 2021 10:49:17 -0800 (PST)
Received: from e123771.cambridge.arm.com (e123771.cambridge.arm.com [10.1.33.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6D9403F774;
        Fri, 17 Dec 2021 10:49:16 -0800 (PST)
From:   Chetankumar Mistry <chetan.mistry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org
Subject: [PATCH v2][RFC 2/2] Remove sysfs entry
Date:   Fri, 17 Dec 2021 18:49:07 +0000
Message-Id: <20211217184907.2103677-2-chetan.mistry@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217184907.2103677-1-chetan.mistry@arm.com>
References: <20211217184907.2103677-1-chetan.mistry@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch introduced a sysfs entry to track the
Ziegler-Nichols state.
This patch will remove it, if it is unwanted.

Signed-off-by: Chetankumar Mistry <chetan.mistry@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 44 +++++++++++++--------------
 drivers/thermal/thermal_sysfs.c       |  2 --
 include/linux/thermal.h               |  7 -----
 3 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index b7e85ee8a673..c0be03d0d161 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -100,6 +100,8 @@ struct zn_coefficients {
 	s32 base_trough;
 	s32 oscillation_count;
 	enum pivot_type prev_pivot;
+
+	int zn_state;
 };
 
 /**
@@ -431,7 +433,7 @@ static inline s32 get_oscillation_count(s32 curr_err,
  * get_zn_state() - Update and get the current Ziegler-Nichols State
  * @tzp: The thermal zone params to check to determine the current state
  * @zn_state: The current state which should be returned if no changes are
- * made
+ *            made
  *
  * Return: The next zieger-nichols state for this pass of the PID controller
  */
@@ -514,9 +516,21 @@ static inline void ziegler_nichols(struct thermal_zone_device *tz, s32 next_err,
 	bool is_safe =
 		is_temperature_safe((control_temp - next_err), control_temp);
 
-	if (tz->tzp->ziegler_nichols == ZN_RESET) {
+	zn_coeffs->zn_state = get_zn_state(tz->tzp, zn_coeffs->zn_state);
+	switch (zn_coeffs->zn_state) {
+	case ZN_ORIGINAL: {
+		set_original_pid_coefficients(tz->tzp);
+		zn_coeffs->zn_state = ZN_OFF;
+		return;
+	}
+	case ZN_RESET: {
 		reset_ziegler_nichols(zn_coeffs);
-		tz->tzp->ziegler_nichols = ZN_ON;
+		zn_coeffs->zn_state = ZN_ON;
+		break;
+	}
+
+	case ZN_OFF:
+		return;
 	}
 
 	/* Override default PID Coefficients. These will be updated later according to the
@@ -556,7 +570,7 @@ static inline void ziegler_nichols(struct thermal_zone_device *tz, s32 next_err,
 	} else {
 		set_zn_pid_coefficients(tz->tzp, zn_coeffs->period,
 					zn_coeffs->k_ultimate);
-		tz->tzp->ziegler_nichols = ZN_OFF;
+		zn_coeffs->zn_state = ZN_OFF;
 	}
 	return;
 
@@ -573,7 +587,7 @@ static inline void ziegler_nichols(struct thermal_zone_device *tz, s32 next_err,
 					zn_coeffs->k_ultimate);
 		((struct power_allocator_params *)tz->governor_data)
 			->err_integral = 0;
-		tz->tzp->ziegler_nichols = ZN_OFF;
+		zn_coeffs->zn_state = ZN_OFF;
 	} else {
 		if (peak_trough == PEAK)
 			zn_coeffs->t_prev_peak = t_now;
@@ -613,24 +627,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 
 	err = control_temp - tz->temperature;
 
-	switch (tz->tzp->ziegler_nichols) {
-	case ZN_ORIGINAL: {
-		set_original_pid_coefficients(tz->tzp);
-		tz->tzp->ziegler_nichols = ZN_OFF;
-		break;
-	}
-	case ZN_RESET: {
-		ziegler_nichols(tz, err, control_temp);
-		tz->tzp->ziegler_nichols = ZN_ON;
-		break;
-	}
-	case ZN_ON: {
-		ziegler_nichols(tz, err, control_temp);
-		break;
-	}
-	default:
-		break;
-	}
+	ziegler_nichols(tz, err, control_temp);
 
 	err = int_to_frac(err);
 
@@ -1064,6 +1061,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 		return -ENOMEM;
 
 	params->zn_coeffs = zn_coeffs;
+	zn_coeffs->zn_state = ZN_ON;
 
 	if (!tz->tzp) {
 		tz->tzp = kzalloc(sizeof(*tz->tzp), GFP_KERNEL);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index d2f410a33995..f154bada2906 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -342,7 +342,6 @@ create_s32_tzp_attr(k_po);
 create_s32_tzp_attr(k_pu);
 create_s32_tzp_attr(k_i);
 create_s32_tzp_attr(k_d);
-create_s32_tzp_attr(ziegler_nichols);
 create_s32_tzp_attr(integral_cutoff);
 create_s32_tzp_attr(slope);
 create_s32_tzp_attr(offset);
@@ -376,7 +375,6 @@ static struct attribute *thermal_zone_dev_attrs[] = {
 	&dev_attr_k_pu.attr,
 	&dev_attr_k_i.attr,
 	&dev_attr_k_d.attr,
-	&dev_attr_ziegler_nichols.attr,
 	&dev_attr_integral_cutoff.attr,
 	&dev_attr_slope.attr,
 	&dev_attr_offset.attr,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index ed8cd6a826ed..c314893970b3 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -282,13 +282,6 @@ struct thermal_zone_params {
 	 * 		Used by thermal zone drivers (default 0).
 	 */
 	int offset;
-
-	/*
-	 * Ziegler-Nichols estimation setting. Allows the user to decide
-	 * whether to use original PID coefficients or calculate using
-	 * the Ziegler-Nichols algorithm
-	 */
-	s32 ziegler_nichols;
 };
 
 /**
-- 
2.25.1

