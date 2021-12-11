Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719E4470F92
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 01:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345512AbhLKAt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 19:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbhLKAt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 19:49:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04814C061714;
        Fri, 10 Dec 2021 16:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bznnGZPflHsmgAjazpAGZncBCoXnhrkUfZfQPCh2qWk=; b=TjJwc2uQb8ZBCkIPDVH3pV7q1R
        pDpy370kXd5Yb/e14jzGmQwGGG2bHDwcghm62lG14+/nwkIR5AO56ft98Qf7Ja3aNQdamG/eWwNn4
        r8cdmVqJekWkyvux891jWtsp9Tnl7ZUxuyUNFIFMR4TU5+o4t7fjA7ffHtAUdEOYSq4XEGgYoz1QT
        I2IG+/YEXgWqwJx2H5rA2MnmTuegZcWKdBeB7YrKOmwxS8fSxJmB5XEZConQZPxvC7V0IS1kDW1iq
        GF8UR3FsRTNf+tHW0fa5c5Kh7Z4LdTr13/cm37XHoNNOfUjYLdcAnuFLO9fTuDw0jp+RNio4sBFco
        yDNS70HA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvqWI-00Apkm-PA; Sat, 11 Dec 2021 00:45:47 +0000
Message-ID: <92b2049a-d2d8-6540-9f5c-9c5191e79f24@infradead.org>
Date:   Fri, 10 Dec 2021 16:45:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH][RFC 1/2] Implement Ziegler-Nichols Heuristic
Content-Language: en-US
To:     Chetankumar Mistry <chetan.mistry@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org
References: <20211210163141.213106-1-chetan.mistry@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211210163141.213106-1-chetan.mistry@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 12/10/21 08:31, Chetankumar Mistry wrote:
> Implement the Ziegler-Nichols Heuristic algorithm to better
> estimate the PID Coefficients for a running platform.
> The values are tuned to minimuse the amount of overshoot in

                          minimise
(as on next line)

> the temperature of the platform and subsequently minimise
> the number of switches for cdev states.
> 
> Signed-off-by: Chetankumar Mistry <chetan.mistry@arm.com>

There are lots of kernel-doc warnings caused by this patch:

gov_power_allocator.c:145: warning: No description found for return value of 'estimate_sustainable_power'
gov_power_allocator.c:233: warning: No description found for return value of 'get_sustainable_power'
gov_power_allocator.c:348: warning: contents before sections
gov_power_allocator.c:60: warning: Enum value 'PEAK' not described in enum 'pivot_type'
gov_power_allocator.c:60: warning: Enum value 'TROUGH' not described in enum 'pivot_type'
gov_power_allocator.c:60: warning: Enum value 'MIDPOINT' not described in enum 'pivot_type'
gov_power_allocator.c:72: warning: Enum value 'ZN_ORIGINAL' not described in enum 'ZN_VALUES'
gov_power_allocator.c:72: warning: Enum value 'ZN_OFF' not described in enum 'ZN_VALUES'
gov_power_allocator.c:72: warning: Enum value 'ZN_ON' not described in enum 'ZN_VALUES'
gov_power_allocator.c:72: warning: Enum value 'ZN_RESET' not described in enum 'ZN_VALUES'
gov_power_allocator.c:102: warning: Function parameter or member 'zn_found' not described in 'zn_coefficients'
gov_power_allocator.c:102: warning: Function parameter or member 'prev_err' not described in 'zn_coefficients'
gov_power_allocator.c:102: warning: Function parameter or member 'curr_err' not described in 'zn_coefficients'
gov_power_allocator.c:102: warning: Function parameter or member 't_prev_peak' not described in 'zn_coefficients'
gov_power_allocator.c:102: warning: Function parameter or member 'period' not described in 'zn_coefficients'
gov_power_allocator.c:102: warning: Function parameter or member 'k_ultimate' not described in 'zn_coefficients'
gov_power_allocator.c:102: warning: Function parameter or member 'base_peak' not described in 'zn_coefficients'
gov_power_allocator.c:102: warning: Function parameter or member 'base_trough' not described in 'zn_coefficients'
gov_power_allocator.c:102: warning: Function parameter or member 'oscillation_count' not described in 'zn_coefficients'
gov_power_allocator.c:102: warning: Function parameter or member 'prev_pivot' not described in 'zn_coefficients'
gov_power_allocator.c:145: warning: No description found for return value of 'estimate_sustainable_power'
gov_power_allocator.c:233: warning: No description found for return value of 'get_sustainable_power'
gov_power_allocator.c:262: warning: Function parameter or member 'tzp' not described in 'set_original_pid_coefficients'
gov_power_allocator.c:348: warning: contents before sections
gov_power_allocator.c:353: warning: Function parameter or member 'next_err' not described in 'is_error_pivot'
gov_power_allocator.c:353: warning: Function parameter or member 'curr_err' not described in 'is_error_pivot'
gov_power_allocator.c:353: warning: Function parameter or member 'prev_err' not described in 'is_error_pivot'
gov_power_allocator.c:353: warning: Function parameter or member 'peak_trough' not described in 'is_error_pivot'

Many of these are due to the use of '-' as a kernel-doc separator character
when it should be ':'.  See examples below.

> ---
>  drivers/thermal/gov_power_allocator.c | 384 ++++++++++++++++++++++++++
>  drivers/thermal/thermal_sysfs.c       |   2 +
>  include/linux/thermal.h               |   7 +
>  3 files changed, 393 insertions(+)
> 
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 13e375751d22..7819c693ed1a 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -49,6 +49,58 @@ static inline s64 div_frac(s64 x, s64 y)
>  	return div_s64(x << FRAC_BITS, y);
>  }
>  
> +/**
> + * enum pivot_type - Values representing what type of pivot the current error
> + *                   value is
> + * @PEAK     - The current error is a peak
> + * @TROUGH   - The current error is a trough
> + * @MIDPOINT - The current error is neither a peak or trough and is some midpoint
> + *             in between

 * @PEAK:     The current error is a peak
 * @TROUGH:   The current error is a trough
 * @MIDPOINT: The current error is neither a peak or trough and is some midpoint
 *            in between


[snip]

>  /**
>   * struct power_allocator_params - parameters for the power allocator governor
>   * @allocated_tzp:	whether we have allocated tzp for this thermal zone and
> @@ -65,6 +117,8 @@ static inline s64 div_frac(s64 x, s64 y)
>   *					controlling for.
>   * @sustainable_power:	Sustainable power (heat) that this thermal zone can
>   *			dissipate
> + * @zn_coeffs:  Structure to hold information used by the Ziegler-Nichols
> + *              heuristic
>   */
>  struct power_allocator_params {
>  	bool allocated_tzp;
> @@ -73,6 +127,7 @@ struct power_allocator_params {
>  	int trip_switch_on;
>  	int trip_max_desired_temperature;
>  	u32 sustainable_power;
> +	struct zn_coefficients *zn_coeffs;
>  };
>  
>  /**
> @@ -196,6 +251,302 @@ static u32 get_sustainable_power(struct thermal_zone_device *tz,
>  	return sustainable_power;
>  }
>  
> +/**
> + * set_original_pid_coefficients() - Reset PID Coefficients in the Thermal Zone
> + *                                   to original values
> + * @tzp - Thermal Zone Parameters we want to update

 * @tzp: Thermal Zone Parameters we want to update

> + *
> + */
> +static inline void
> +set_original_pid_coefficients(struct thermal_zone_params *tzp)

Bad style for Linux; instead use

static inline void set_original_pid_coefficients(struct thermal_zone_params *tzp)
{


> +{
> +	static bool init = true;
> +	static s32 k_po, k_pu, k_i, k_d, integral_cutoff;
> +
> +	if (init) {
> +		k_po = tzp->k_po;
> +		k_pu = tzp->k_pu;
> +		k_i = tzp->k_i;
> +		k_d = tzp->k_d;
> +		integral_cutoff = tzp->integral_cutoff;
> +		init = false;
> +	} else {
> +		tzp->k_po = k_po;
> +		tzp->k_pu = k_pu;
> +		tzp->k_i = k_i;
> +		tzp->k_d = k_d;
> +		tzp->integral_cutoff = integral_cutoff;
> +	}
> +}
> +

[snip]


> +/** update_oscillation_count() - Update the Oscillation Count for this set of pivots @curr_err

Please put "/**" on a separate line:

/**
 * update_oscillation_count() - Update the Oscillation Count for this set of pivots @curr_err


> + * - the current error value we are checking @base_pivot      - the amplitude we are comparing
> + *   against @peak_trough     - the type of pivot we are currently processing @zn_coefficients - the
> + *   data structure holding information used by the Ziegler-Nichols Hueristic
> + *
> + * Update the number of times we have oscillated based on our current error value being within the
> + * accepted range from the amplitude of previous pivots in this oscillation series.
> + *
> + * Return: Integer count of the number of oscillations
> + */
> +static inline s32 update_oscillation_count(s32 curr_err, s32 *base_pivot,
> +					   enum pivot_type peak_trough,
> +					   struct zn_coefficients *zn_coeffs)
> +{
> +	if (is_error_acceptable(curr_err, *base_pivot) &&
> +	    zn_coeffs->prev_pivot == -peak_trough) {
> +		zn_coeffs->oscillation_count++;
> +	} else {
> +		zn_coeffs->oscillation_count = 0;
> +		*base_pivot = curr_err;
> +	}
> +	zn_coeffs->prev_pivot = peak_trough;
> +	return zn_coeffs->oscillation_count;
> +}
> +
> +/** get_oscillation_count() - Update and get the number of times we have oscillated

Ditto.

> + * @curr_err    - the current error value we are checking
> + * @peak_trough - the type of pivot we are currently processing
> + * @zn_coefficients - the data structure holding information used by the
> + *                    Ziegler-Nichols Hueristic
> + *
> + * Return: The number of times we have oscillated for this k_ultimate
> + */
> +static inline s32 get_oscillation_count(s32 curr_err,
> +					enum pivot_type peak_trough,
> +					struct zn_coefficients *zn_coeffs)
> +{
> +	s32 *base_pivot = 0;
> +
> +	if (peak_trough == PEAK)
> +		base_pivot = &zn_coeffs->base_peak;
> +	else if (peak_trough == TROUGH)
> +		base_pivot = &zn_coeffs->base_trough;
> +
> +	return update_oscillation_count(curr_err, base_pivot, peak_trough,
> +					zn_coeffs);
> +}
> +
> +/** is_temperature_safe() - Check if the current temperature is within 10% of the target

Ditto.

> + *
> + * @current_temperature: Current reported temperature
> + * @control_temp:        Control Temperature we are targeting
> + *
> + * Return: True if current temperature is within 10% of the target, False otherwise
> + */
> +static inline bool is_temperature_safe(int current_temperature,
> +				       int control_temp)
> +{
> +	return (current_temperature - control_temp) < (control_temp / 10) ?
> +		       true :
> +		       false;
> +}
> +
> +/** reset_ziegler_nichols() - Reset the Values used to Track Ziegler-Nichols

Ditto.

> + *
> + * @zn_coefficients - the data structure holding information used by the Ziegler-Nichols Hueristic
> + *
> + */
> +static inline void reset_ziegler_nichols(struct zn_coefficients *zn_coeffs)
> +{
> +	zn_coeffs->zn_found = false;
> +	zn_coeffs->k_ultimate = 10;
> +	zn_coeffs->prev_err = 0;
> +	zn_coeffs->curr_err = 0;
> +	zn_coeffs->t_prev_peak = 0;
> +	zn_coeffs->period = 0;
> +	/* Manually input INT_MAX as a previous value so the system cannot use it accidentally */
> +	zn_coeffs->oscillation_count = update_oscillation_count(
> +		INT_MAX, &zn_coeffs->curr_err, PEAK, zn_coeffs);
> +}
> +
> +/** ziegler_nichols() - Calculate the k_ultimate and period for the thermal device

Ditto.

> + *                      and use these values to calculate and set the PID coefficients based on
> + *                      the Ziegler-Nichols Heuristic
> + * @tz               - The thermal device we are operating on
> + * @next_err         - The next error value to be used for calculations
> + * @control_temp     - The temperature we are trying to target
> + *
> + * The Ziegler-Nichols PID Coefficient Tuning Method works by determining a K_Ultimate value. This
> + * is the largest K_P which yields a stable set of oscillations in error. By using historic and
> + * current values of error, this function attempts to determine whether or not it is oscillating,
> + * and increment the value of K_Ultimate accordingly.  Once it has determined that the system is
> + * oscillating, it calculates the time between "peaks" to determine its period
> + *
> + */
> +static inline void ziegler_nichols(struct thermal_zone_device *tz, s32 next_err,
> +				   int control_temp)
> +{
> +	struct power_allocator_params *params = tz->governor_data;
> +	struct zn_coefficients *zn_coeffs = params->zn_coeffs;
> +	const int NUMBER_OF_OSCILLATIONS = 10;
> +
> +	u32 t_now = (u32)(ktime_get_real_ns() / 1000000);
> +	enum pivot_type peak_trough = MIDPOINT;
> +	s32 oscillation_count = 0;
> +	bool is_pivot;
> +	bool is_safe =
> +		is_temperature_safe((control_temp - next_err), control_temp);
> +
> +	if (tz->tzp->ziegler_nichols == ZN_RESET) {
> +		reset_ziegler_nichols(zn_coeffs);
> +		tz->tzp->ziegler_nichols = ZN_ON;
> +	}
> +
> +	/* Override default PID Coefficients. These will be updated later according to the
> +	 * Heuristic
> +	 */
> +	tz->tzp->k_po = zn_coeffs->k_ultimate;
> +	tz->tzp->k_pu = zn_coeffs->k_ultimate;
> +	tz->tzp->k_i = 0;
> +	tz->tzp->k_d = 0;
> +
> +	if (!zn_coeffs->zn_found) {
> +		/* Make sure that the previous errors have been logged and this isn't executed on
> +		 * first pass
> +		 */
> +		if (zn_coeffs->curr_err != zn_coeffs->prev_err &&
> +		    zn_coeffs->prev_err != 0) {
> +			if (!is_safe)
> +				goto set_zn;
> +			is_pivot = is_error_pivot(next_err, zn_coeffs->curr_err,
> +						  zn_coeffs->prev_err,
> +						  &peak_trough);
> +			if (is_pivot) {
> +				oscillation_count = get_oscillation_count(
> +					zn_coeffs->curr_err, peak_trough,
> +					zn_coeffs);
> +				if (oscillation_count >=
> +				    NUMBER_OF_OSCILLATIONS) {
> +					goto set_zn;
> +				}
> +				if (peak_trough == PEAK)
> +					zn_coeffs->t_prev_peak = t_now;
> +			}
> +			if (!is_pivot || !oscillation_count)
> +				zn_coeffs->k_ultimate += 10;
> +		}
> +		goto update_errors;
> +	} else {
> +		set_zn_pid_coefficients(tz->tzp, zn_coeffs->period,
> +					zn_coeffs->k_ultimate);
> +		tz->tzp->ziegler_nichols = ZN_OFF;
> +	}
> +	return;
> +
> +update_errors:
> +	zn_coeffs->prev_err = zn_coeffs->curr_err;
> +	zn_coeffs->curr_err = next_err;
> +	return;
> +
> +set_zn:
> +	if (zn_coeffs->t_prev_peak) {
> +		zn_coeffs->zn_found = true;
> +		zn_coeffs->period = abs(t_now - zn_coeffs->t_prev_peak);
> +		set_zn_pid_coefficients(tz->tzp, zn_coeffs->period,
> +					zn_coeffs->k_ultimate);
> +		((struct power_allocator_params *)tz->governor_data)
> +			->err_integral = 0;
> +		tz->tzp->ziegler_nichols = ZN_OFF;
> +	} else {
> +		if (peak_trough == PEAK)
> +			zn_coeffs->t_prev_peak = t_now;
> +	}
> +}

[snip]


thanks.
-- 
~Randy
