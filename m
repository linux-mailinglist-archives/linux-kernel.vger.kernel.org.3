Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1C4479447
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240443AbhLQStS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:49:18 -0500
Received: from foss.arm.com ([217.140.110.172]:33436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231670AbhLQStQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:49:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 382391042;
        Fri, 17 Dec 2021 10:49:16 -0800 (PST)
Received: from e123771.cambridge.arm.com (e123771.cambridge.arm.com [10.1.33.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1868E3F774;
        Fri, 17 Dec 2021 10:49:14 -0800 (PST)
From:   Chetankumar Mistry <chetan.mistry@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org
Subject: [PATCH v2][RFC 1/2] Implement Ziegler-Nichols Heuristic
Date:   Fri, 17 Dec 2021 18:49:06 +0000
Message-Id: <20211217184907.2103677-1-chetan.mistry@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the Ziegler-Nichols Heuristic algorithm to better
estimate the PID Coefficients for a running platform.
The values are tuned to minimuse the amount of overshoot in
the temperature of the platform and subsequently minimise
the number of switches for cdev states.

Signed-off-by: Chetankumar Mistry <chetan.mistry@arm.com>
---
Changelog v2:
- Updated Kernel-Docs to use ':' delimiter (asked by Randy Dunlap)
- Changed divide operation to use div_frac (requested by kernel_test_robot)

 drivers/thermal/gov_power_allocator.c | 418 ++++++++++++++++++++++++++
 drivers/thermal/thermal_sysfs.c       |   2 +
 include/linux/thermal.h               |   7 +
 3 files changed, 427 insertions(+)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 13e375751d22..b7e85ee8a673 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -49,6 +49,59 @@ static inline s64 div_frac(s64 x, s64 y)
 	return div_s64(x << FRAC_BITS, y);
 }
 
+/**
+ * enum pivot_type - Values representing what type of pivot the current error
+ *                   value is
+ * @PEAK:       The current error is a peak
+ * @TROUGH:     The current error is a trough
+ * @MIDPOINT:   The current error is neither a peak or trough and is some midpoint
+ *             in between
+ */
+enum pivot_type { PEAK = 1, TROUGH = -1, MIDPOINT = 0 };
+
+/**
+ * enum ZN_VALUES - Values which the Ziegler-Nichols variable can take. This
+ *                  determines which set of PID Coefficients to use
+ * @ZN_ORIGINAL: Use the Original PID Coefficients when the thermal zone was
+ *               initially bound
+ * @ZN_OFF:      Use the current set of PID Coefficients
+ * @ZN_ON:       Use Ziegler-Nichols to determine the best set of PID Coefficients
+ * @ZN_RESET:    Reset the Ziegler-Nichols set of PID Coefficients so they can be
+ *               found again
+ */
+enum ZN_VALUES { ZN_ORIGINAL = -1, ZN_OFF = 0, ZN_ON = 1, ZN_RESET = 2 };
+
+/**
+ * struct zn_coefficients - values used by the Ziegler-Nichols Heuristic to
+ *                          determine what the optimal PID coefficients are
+ * @zn_found:   Determine whether we have found or are still searching for
+ *              optimal PID coefficients
+ * @prev_err: Previous err logged
+ * @curr_err: Current err being processed
+ * @t_prev_peak: Timestamp for the previous "Peak"
+ * @period: Period of osciallation
+ * @k_ultimate: Value of k_P which produces stable oscillations
+ * @base_peak: Err value of the current peak
+ * @base_trough: Err value fo the current trough
+ * @oscillation_count: Number of stable oscillations we have observed
+ * @prev_pivot: Whether the previous pivot was a peak or trough
+ * @zn_state: Current Ziegler-Nichols state
+ *
+ */
+struct zn_coefficients {
+	bool zn_found;
+	s32 prev_err;
+	s32 curr_err;
+	u32 t_prev_peak;
+	u32 period;
+	u32 k_ultimate;
+
+	s32 base_peak;
+	s32 base_trough;
+	s32 oscillation_count;
+	enum pivot_type prev_pivot;
+};
+
 /**
  * struct power_allocator_params - parameters for the power allocator governor
  * @allocated_tzp:	whether we have allocated tzp for this thermal zone and
@@ -65,6 +118,8 @@ static inline s64 div_frac(s64 x, s64 y)
  *					controlling for.
  * @sustainable_power:	Sustainable power (heat) that this thermal zone can
  *			dissipate
+ * @zn_coeffs:  Structure to hold information used by the Ziegler-Nichols
+ *              heuristic
  */
 struct power_allocator_params {
 	bool allocated_tzp;
@@ -73,6 +128,7 @@ struct power_allocator_params {
 	int trip_switch_on;
 	int trip_max_desired_temperature;
 	u32 sustainable_power;
+	struct zn_coefficients *zn_coeffs;
 };
 
 /**
@@ -85,6 +141,8 @@ struct power_allocator_params {
  * can give some degree of functionality.  For optimal performance of
  * this governor, provide a sustainable_power in the thermal zone's
  * thermal_zone_params.
+ *
+ * Return: the sustainable power for this thermal_zone
  */
 static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
 {
@@ -171,6 +229,8 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
  * on variables which might be updated by the user sysfs interface. If that
  * happen the new value is going to be estimated and updated. It is also used
  * after thermal zone binding, where the initial values where set to 0.
+ *
+ * Return: The sustainable power for this thermal_zone
  */
 static u32 get_sustainable_power(struct thermal_zone_device *tz,
 				 struct power_allocator_params *params,
@@ -196,6 +256,330 @@ static u32 get_sustainable_power(struct thermal_zone_device *tz,
 	return sustainable_power;
 }
 
+/**
+ * set_original_pid_coefficients() - Reset PID Coefficients in the Thermal Zone
+ *                                   to original values
+ * @tzp: Thermal Zone Parameters we want to update
+ *
+ */
+static inline void set_original_pid_coefficients(struct thermal_zone_params *tzp)
+{
+	static bool init = true;
+	static s32 k_po, k_pu, k_i, k_d, integral_cutoff;
+
+	if (init) {
+		k_po = tzp->k_po;
+		k_pu = tzp->k_pu;
+		k_i = tzp->k_i;
+		k_d = tzp->k_d;
+		integral_cutoff = tzp->integral_cutoff;
+		init = false;
+	} else {
+		tzp->k_po = k_po;
+		tzp->k_pu = k_pu;
+		tzp->k_i = k_i;
+		tzp->k_d = k_d;
+		tzp->integral_cutoff = integral_cutoff;
+	}
+}
+
+/**
+ * set_zn_pid_coefficients() - Calculate and set PID Coefficients based
+ *                             on Ziegler-Nichols Heuristic
+ * @tzp: thermal zone params to set
+ * @period: time taken for error to cycle 1 period
+ * @k_ultimate: the Ultimate Proportional Gain value at which
+ *              the error oscillates around the set-point
+ *
+ * This function sets the PID Coefficients of the thermal device
+ */
+static inline void set_zn_pid_coefficients(struct thermal_zone_params *tzp,
+					   u32 period, s32 k_ultimate)
+{
+	/* Convert time in ms for 1 cycle to cycles/s */
+	s32 freq = 1000 / period;
+
+	/* Make k_pu and k_po identical so it represents k_p */
+	tzp->k_pu = k_ultimate * 1 / 10;
+	tzp->k_po = tzp->k_pu;
+
+	tzp->k_i = freq / 2;
+	/* We want an integral term so if the value is 0, set it to 1 */
+	tzp->k_i = tzp->k_i > 0 ? tzp->k_i : 1;
+
+	tzp->k_d = (33 * freq) / 100;
+	/* We want an integral term so if the value is 0, set it to 1 */
+	tzp->k_d = tzp->k_d > 0 ? tzp->k_d : 1;
+}
+
+/**
+ * is_error_acceptable() - Check whether the error determined to be a pivot
+ *                         point is within the acceptable range
+ * @err: error value we are checking
+ * @base: the base_line value we are comparing against
+ *
+ * This function is used to determine whether our current pivot point is within
+ * the acceptable limits. The value of base is the first pivot point within
+ * this series of oscillations
+ *
+ * Return: boolean representing whether or not the error was within the acceptable
+ *         range
+ */
+static inline bool is_error_acceptable(s32 err, s32 base)
+{
+	/* Margin for error in milli-celcius */
+	const s32 MARGIN = 500;
+	s32 lower = abs(base) - MARGIN;
+	s32 upper = abs(base) + MARGIN;
+
+	if (lower < abs(err) && abs(err) < upper)
+		return true;
+	return false;
+}
+
+/**
+ * is_error_pivot() - Determine whether an error value is a pivot based on the
+ *                    previous and next error values
+ * @next_err: the next error in a series
+ * @curr_err: the current error value we are checking
+ * @prev_err: the previous error in a series
+ * @peak_trough: integer value to output what kind of pivot (if any)
+ *                    the error value is
+ *
+ * Determine whether or not the current value of error is a pivot and if it is
+ * a pivot, which type of pivot it is (peak or trough).
+ *
+ * Return: Bool representing whether the current value is a pivot point and
+ *         integer set to PEAK, TROUGH or MIDPOINT
+ */
+static inline bool is_error_pivot(s32 next_err, s32 curr_err, s32 prev_err,
+				  enum pivot_type *peak_trough)
+{
+	/*
+	 * Check whether curr_err is at it's highest value compared to its neighbours and that error
+	 * value is positive
+	 */
+	if (prev_err < curr_err && curr_err > next_err && curr_err > 0) {
+		*peak_trough = PEAK;
+		return true;
+	}
+	/*
+	 * Check whether curr_err is at it's lowest value compared to its neighbours and that error
+	 * value is negative
+	 */
+	if (prev_err > curr_err && curr_err < next_err && curr_err < 0) {
+		*peak_trough = TROUGH;
+		return true;
+	}
+	/* If the error is not a pivot then it must be somewhere between pivots */
+	*peak_trough = MIDPOINT;
+	return false;
+}
+
+/**
+ * update_oscillation_count() - Update the Oscillation Count for this set of pivots
+ * @curr_err: the current error value we are checking
+ * @base_pivot: the amplitude we are comparing against
+ * @peak_trough: the type of pivot we are currently processing
+ * @zn_coeffs: the data structure holding information used by the Ziegler-Nichols Hueristic
+ *
+ * Update the number of times we have oscillated based on our current error value being within the
+ * accepted range from the amplitude of previous pivots in this oscillation series.
+ *
+ * Return: Integer count of the number of oscillations
+ */
+static inline s32 update_oscillation_count(s32 curr_err, s32 *base_pivot,
+					   enum pivot_type peak_trough,
+					   struct zn_coefficients *zn_coeffs)
+{
+	if (is_error_acceptable(curr_err, *base_pivot) &&
+	    zn_coeffs->prev_pivot == -peak_trough) {
+		zn_coeffs->oscillation_count++;
+	} else {
+		zn_coeffs->oscillation_count = 0;
+		*base_pivot = curr_err;
+	}
+	zn_coeffs->prev_pivot = peak_trough;
+	return zn_coeffs->oscillation_count;
+}
+
+/**
+ * get_oscillation_count() - Update and get the number of times we have oscillated
+ * @curr_err: the current error value we are checking
+ * @peak_trough: the type of pivot we are currently processing
+ * @zn_coeffs: the data structure holding information used by the
+ *                    Ziegler-Nichols Hueristic
+ *
+ * Return: The number of times we have oscillated for this k_ultimate
+ */
+static inline s32 get_oscillation_count(s32 curr_err,
+					enum pivot_type peak_trough,
+					struct zn_coefficients *zn_coeffs)
+{
+	s32 *base_pivot = 0;
+
+	if (peak_trough == PEAK)
+		base_pivot = &zn_coeffs->base_peak;
+	else if (peak_trough == TROUGH)
+		base_pivot = &zn_coeffs->base_trough;
+
+	return update_oscillation_count(curr_err, base_pivot, peak_trough,
+					zn_coeffs);
+}
+
+/**
+ * get_zn_state() - Update and get the current Ziegler-Nichols State
+ * @tzp: The thermal zone params to check to determine the current state
+ * @zn_state: The current state which should be returned if no changes are
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
+ *
+ * @current_temperature: Current reported temperature
+ * @control_temp:        Control Temperature we are targeting
+ *
+ * Return: True if current temperature is within 10% of the target, False otherwise
+ */
+static inline bool is_temperature_safe(int current_temperature,
+				       int control_temp)
+{
+	return (current_temperature - control_temp) < (control_temp / 10) ?
+		       true :
+		       false;
+}
+
+/**
+ * reset_ziegler_nichols() - Reset the Values used to Track Ziegler-Nichols
+ *
+ * @zn_coeffs: the data structure holding information used by the Ziegler-Nichols Hueristic
+ *
+ */
+static inline void reset_ziegler_nichols(struct zn_coefficients *zn_coeffs)
+{
+	zn_coeffs->zn_found = false;
+	zn_coeffs->k_ultimate = 10;
+	zn_coeffs->prev_err = 0;
+	zn_coeffs->curr_err = 0;
+	zn_coeffs->t_prev_peak = 0;
+	zn_coeffs->period = 0;
+	/* Manually input INT_MAX as a previous value so the system cannot use it accidentally */
+	zn_coeffs->oscillation_count = update_oscillation_count(
+		INT_MAX, &zn_coeffs->curr_err, PEAK, zn_coeffs);
+}
+
+/**
+ * ziegler_nichols() - Calculate the k_ultimate and period for the thermal device
+ *                      and use these values to calculate and set the PID coefficients based on
+ *                      the Ziegler-Nichols Heuristic
+ * @tz: The thermal device we are operating on
+ * @next_err: The next error value to be used for calculations
+ * @control_temp: The temperature we are trying to target
+ *
+ * The Ziegler-Nichols PID Coefficient Tuning Method works by determining a K_Ultimate value. This
+ * is the largest K_P which yields a stable set of oscillations in error. By using historic and
+ * current values of error, this function attempts to determine whether or not it is oscillating,
+ * and increment the value of K_Ultimate accordingly.  Once it has determined that the system is
+ * oscillating, it calculates the time between "peaks" to determine its period
+ *
+ */
+static inline void ziegler_nichols(struct thermal_zone_device *tz, s32 next_err,
+				   int control_temp)
+{
+	struct power_allocator_params *params = tz->governor_data;
+	struct zn_coefficients *zn_coeffs = params->zn_coeffs;
+	const int NUMBER_OF_OSCILLATIONS = 10;
+
+	u32 t_now = (u32)div_frac(ktime_get_real_ns(), 1000000);
+	enum pivot_type peak_trough = MIDPOINT;
+	s32 oscillation_count = 0;
+	bool is_pivot;
+	bool is_safe =
+		is_temperature_safe((control_temp - next_err), control_temp);
+
+	if (tz->tzp->ziegler_nichols == ZN_RESET) {
+		reset_ziegler_nichols(zn_coeffs);
+		tz->tzp->ziegler_nichols = ZN_ON;
+	}
+
+	/* Override default PID Coefficients. These will be updated later according to the
+	 * Heuristic
+	 */
+	tz->tzp->k_po = zn_coeffs->k_ultimate;
+	tz->tzp->k_pu = zn_coeffs->k_ultimate;
+	tz->tzp->k_i = 0;
+	tz->tzp->k_d = 0;
+
+	if (!zn_coeffs->zn_found) {
+		/* Make sure that the previous errors have been logged and this isn't executed on
+		 * first pass
+		 */
+		if (zn_coeffs->curr_err != zn_coeffs->prev_err &&
+		    zn_coeffs->prev_err != 0) {
+			if (!is_safe)
+				goto set_zn;
+			is_pivot = is_error_pivot(next_err, zn_coeffs->curr_err,
+						  zn_coeffs->prev_err,
+						  &peak_trough);
+			if (is_pivot) {
+				oscillation_count = get_oscillation_count(
+					zn_coeffs->curr_err, peak_trough,
+					zn_coeffs);
+				if (oscillation_count >=
+				    NUMBER_OF_OSCILLATIONS) {
+					goto set_zn;
+				}
+				if (peak_trough == PEAK)
+					zn_coeffs->t_prev_peak = t_now;
+			}
+			if (!is_pivot || !oscillation_count)
+				zn_coeffs->k_ultimate += 10;
+		}
+		goto update_errors;
+	} else {
+		set_zn_pid_coefficients(tz->tzp, zn_coeffs->period,
+					zn_coeffs->k_ultimate);
+		tz->tzp->ziegler_nichols = ZN_OFF;
+	}
+	return;
+
+update_errors:
+	zn_coeffs->prev_err = zn_coeffs->curr_err;
+	zn_coeffs->curr_err = next_err;
+	return;
+
+set_zn:
+	if (zn_coeffs->t_prev_peak) {
+		zn_coeffs->zn_found = true;
+		zn_coeffs->period = abs(t_now - zn_coeffs->t_prev_peak);
+		set_zn_pid_coefficients(tz->tzp, zn_coeffs->period,
+					zn_coeffs->k_ultimate);
+		((struct power_allocator_params *)tz->governor_data)
+			->err_integral = 0;
+		tz->tzp->ziegler_nichols = ZN_OFF;
+	} else {
+		if (peak_trough == PEAK)
+			zn_coeffs->t_prev_peak = t_now;
+	}
+}
+
 /**
  * pid_controller() - PID controller
  * @tz:	thermal zone we are operating in
@@ -228,6 +612,26 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	sustainable_power = get_sustainable_power(tz, params, control_temp);
 
 	err = control_temp - tz->temperature;
+
+	switch (tz->tzp->ziegler_nichols) {
+	case ZN_ORIGINAL: {
+		set_original_pid_coefficients(tz->tzp);
+		tz->tzp->ziegler_nichols = ZN_OFF;
+		break;
+	}
+	case ZN_RESET: {
+		ziegler_nichols(tz, err, control_temp);
+		tz->tzp->ziegler_nichols = ZN_ON;
+		break;
+	}
+	case ZN_ON: {
+		ziegler_nichols(tz, err, control_temp);
+		break;
+	}
+	default:
+		break;
+	}
+
 	err = int_to_frac(err);
 
 	/* Calculate the proportional term */
@@ -375,6 +779,7 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 	if (capped_extra_power > 0)
 		for (i = 0; i < num_actors; i++) {
 			u64 extra_range = (u64)extra_actor_power[i] * extra_power;
+
 			granted_power[i] += DIV_ROUND_CLOSEST_ULL(extra_range,
 							 capped_extra_power);
 		}
@@ -644,6 +1049,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	int ret;
 	struct power_allocator_params *params;
 	int control_temp;
+	struct zn_coefficients *zn_coeffs;
 
 	ret = check_power_actors(tz);
 	if (ret)
@@ -653,6 +1059,12 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	if (!params)
 		return -ENOMEM;
 
+	zn_coeffs = kzalloc(sizeof(*zn_coeffs), GFP_KERNEL);
+	if (!zn_coeffs)
+		return -ENOMEM;
+
+	params->zn_coeffs = zn_coeffs;
+
 	if (!tz->tzp) {
 		tz->tzp = kzalloc(sizeof(*tz->tzp), GFP_KERNEL);
 		if (!tz->tzp) {
@@ -676,6 +1088,8 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 			estimate_pid_constants(tz, tz->tzp->sustainable_power,
 					       params->trip_switch_on,
 					       control_temp);
+		/* Store the original PID coefficient values */
+		set_original_pid_coefficients(tz->tzp);
 	}
 
 	reset_pid_controller(params);
@@ -696,6 +1110,9 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 
 	dev_dbg(&tz->device, "Unbinding from thermal zone %d\n", tz->id);
 
+	kfree(params->zn_coeffs);
+	params->zn_coeffs = NULL;
+
 	if (params->allocated_tzp) {
 		kfree(tz->tzp);
 		tz->tzp = NULL;
@@ -749,4 +1166,5 @@ static struct thermal_governor thermal_gov_power_allocator = {
 	.unbind_from_tz	= power_allocator_unbind,
 	.throttle	= power_allocator_throttle,
 };
+
 THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index f154bada2906..d2f410a33995 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -342,6 +342,7 @@ create_s32_tzp_attr(k_po);
 create_s32_tzp_attr(k_pu);
 create_s32_tzp_attr(k_i);
 create_s32_tzp_attr(k_d);
+create_s32_tzp_attr(ziegler_nichols);
 create_s32_tzp_attr(integral_cutoff);
 create_s32_tzp_attr(slope);
 create_s32_tzp_attr(offset);
@@ -375,6 +376,7 @@ static struct attribute *thermal_zone_dev_attrs[] = {
 	&dev_attr_k_pu.attr,
 	&dev_attr_k_i.attr,
 	&dev_attr_k_d.attr,
+	&dev_attr_ziegler_nichols.attr,
 	&dev_attr_integral_cutoff.attr,
 	&dev_attr_slope.attr,
 	&dev_attr_offset.attr,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c314893970b3..ed8cd6a826ed 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -282,6 +282,13 @@ struct thermal_zone_params {
 	 * 		Used by thermal zone drivers (default 0).
 	 */
 	int offset;
+
+	/*
+	 * Ziegler-Nichols estimation setting. Allows the user to decide
+	 * whether to use original PID coefficients or calculate using
+	 * the Ziegler-Nichols algorithm
+	 */
+	s32 ziegler_nichols;
 };
 
 /**
-- 
2.25.1

