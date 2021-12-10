Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA604705C7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbhLJQfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:35:46 -0500
Received: from foss.arm.com ([217.140.110.172]:44054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243570AbhLJQfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:35:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D415E106F;
        Fri, 10 Dec 2021 08:32:04 -0800 (PST)
Received: from e123771.cambridge.arm.com (e123771.cambridge.arm.com [10.1.32.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD9A73F73B;
        Fri, 10 Dec 2021 08:32:03 -0800 (PST)
From:   Chetankumar Mistry <chetan.mistry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org
Subject: [PATCH][RFC 2/2] Remove sysfs entry
Date:   Fri, 10 Dec 2021 16:31:41 +0000
Message-Id: <20211210163141.213106-2-chetan.mistry@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210163141.213106-1-chetan.mistry@arm.com>
References: <20211210163141.213106-1-chetan.mistry@arm.com>
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
 drivers/thermal/gov_power_allocator.c | 68 ++++++++++++++++++---------
 drivers/thermal/thermal_sysfs.c       |  2 -
 include/linux/thermal.h               |  7 ---
 3 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 7819c693ed1a..5be0dfb5f7fc 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -99,6 +99,8 @@ struct zn_coefficients {
 	s32 base_trough;
 	s32 oscillation_count;
 	enum pivot_type prev_pivot;
+
+	int zn_state;
 };
 
 /**
@@ -420,7 +422,31 @@ static inline s32 get_oscillation_count(s32 curr_err,
 					zn_coeffs);
 }
 
-/** is_temperature_safe() - Check if the current temperature is within 10% of the target
+/**
+ * get_zn_state() - Update and get the current Ziegler-Nichols State
+ * @tzp - The thermal zone params to check to determine the current state
+ * @zn_state    - The current state which should be returned if no changes are
+ * made
+ *
+ * Return: The next zieger-nichols state for this pass of the PID controller
+ */
+static inline int get_zn_state(struct thermal_zone_params *tzp, int zn_state)
+{
+	if (tzp->k_po == ZN_RESET && tzp->k_pu == ZN_RESET)
+		return ZN_RESET;
+
+	if (tzp->k_po == ZN_ORIGINAL && tzp->k_pu == ZN_ORIGINAL)
+		return ZN_ORIGINAL;
+
+	if (tzp->k_po == ZN_ON && tzp->k_pu == ZN_ON)
+		return ZN_ON;
+
+	return zn_state;
+}
+
+/**
+ * is_temperature_safe() - Check if the current temperature is within 10% of
+ *                         the target
  *
  * @current_temperature: Current reported temperature
  * @control_temp:        Control Temperature we are targeting
@@ -481,9 +507,21 @@ static inline void ziegler_nichols(struct thermal_zone_device *tz, s32 next_err,
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
@@ -523,7 +561,7 @@ static inline void ziegler_nichols(struct thermal_zone_device *tz, s32 next_err,
 	} else {
 		set_zn_pid_coefficients(tz->tzp, zn_coeffs->period,
 					zn_coeffs->k_ultimate);
-		tz->tzp->ziegler_nichols = ZN_OFF;
+		zn_coeffs->zn_state = ZN_OFF;
 	}
 	return;
 
@@ -540,7 +578,7 @@ static inline void ziegler_nichols(struct thermal_zone_device *tz, s32 next_err,
 					zn_coeffs->k_ultimate);
 		((struct power_allocator_params *)tz->governor_data)
 			->err_integral = 0;
-		tz->tzp->ziegler_nichols = ZN_OFF;
+		zn_coeffs->zn_state = ZN_OFF;
 	} else {
 		if (peak_trough == PEAK)
 			zn_coeffs->t_prev_peak = t_now;
@@ -580,24 +618,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 
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
 
@@ -1031,6 +1052,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
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

