Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163FA571882
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiGLL3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiGLL3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:29:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A57FC1BEB8;
        Tue, 12 Jul 2022 04:29:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8D901515;
        Tue, 12 Jul 2022 04:29:15 -0700 (PDT)
Received: from [10.57.13.42] (unknown [10.57.13.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 251BD3F70D;
        Tue, 12 Jul 2022 04:29:13 -0700 (PDT)
Message-ID: <6ce87fbb-1460-503b-f1f1-8cf53e702cdf@arm.com>
Date:   Tue, 12 Jul 2022 12:29:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] thermal/core: Fix thermal trip cross point
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>, rafael@kernel.org
References: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
 <20220708183210.1334839-3-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220708183210.1334839-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/22 19:32, Daniel Lezcano wrote:
> The routine doing trip point crossing the way up or down is actually
> wrong.
> 
> A trip point is composed with a trip temperature and a hysteresis.
> 
> The trip temperature is used to detect when the trip point is crossed
> the way up.
> 
> The trip temperature minus the hysteresis is used to detect when the
> trip point is crossed the way down.
> 
> |-----------low--------high------------|
>               |<--------->|
>               |    hyst   |
>               |           |
>               |          -|--> crossed the way up
>               |
>           <---|-- crossed the way down
> 
> For that, there is a two point comparison: the current temperature and
> the previous temperature.
> 
> The actual code assumes if the current temperature is greater than the
> trip temperature and the previous temperature was lesser, then the
> trip point is crossed the way up. That is true only if we crossed the
> way down the low temperature boundary from the previous temperature or
> if the hysteresis is zero. The temperature can decrease between the
> low and high, so the trip point is not crossed the way down and then
> increase again and cross the high temperature raising a new trip point
> crossed detection which is incorrect. The same scenario happens when
> crossing the way down.
> 
> The trip point crossing the way up and down must act as parenthesis, a
> trip point down must close a trip point up. Today we have multiple
> trip point up without the corresponding trip point down.
> 
> In order to fix that, we store the previous trip point which gives the
> information about the previous trip and we change the trip point
> browsing order depending on the temperature trend: in the ascending
> order when the temperature trend is raising, otherwise in the
> descending order.
> 
> As a sidenote, the thermal_zone_device structure has already the
> prev_trip_low and prev_trip_high information which are used by the
> thermal_zone_set_trips() function. This one can be changed to be
> triggered by the trip temperature crossing function, which makes more
> sense, and the two fields will disappear.
> 
> Tested on a rk3399-rock960 with thermal stress and 4 trip points. Also
> tested with temperature emulation to create a temperature jump
> directly to the second trip point.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> V2:
>     - As spotted by Zhang Rui, the trip cross notification does not
>    work if the temperature drops and crosses two trip points in the
>    same update interval. In order to fix that, we browse the trip point
>    in the ascending order when the temperature trend is raising,
>    otherwise in the descending order.
> ---
>   drivers/thermal/thermal_core.c | 46 +++++++++++++++++++++++++---------
>   include/linux/thermal.h        |  2 ++
>   2 files changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index f66036b3daae..89926e029378 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -357,19 +357,35 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>   static void handle_thermal_trip_crossed(struct thermal_zone_device *tz, int trip,
>   					int trip_temp, int trip_hyst, enum thermal_trip_type trip_type)
>   {
> +	int trip_low_temp = trip_temp - trip_hyst;
> +
>   	if (tz->last_temperature == THERMAL_TEMP_INVALID)
>   		return;
>   
> -	if (tz->last_temperature < trip_temp &&
> -	    tz->temperature >= trip_temp) {
> -		thermal_notify_tz_trip_up(tz->id, trip,
> -					  tz->temperature);
> -	}
> -
> -	if (tz->last_temperature >= trip_temp &&
> -	    tz->temperature < (trip_temp - trip_hyst)) {
> -		thermal_notify_tz_trip_down(tz->id, trip,
> -					    tz->temperature);
> +	/*
> +	 * Due to the hysteresis, a third information is needed to
> +	 * detect when the temperature is wavering between the
> +	 * trip_low_temp and the trip_temp. A trip point is crossed
> +	 * the way up only if the temperature is above it while the
> +	 * previous temperature was below *and* we crossed the
> +	 * trip_temp_low before. The previous trip point give us the
> +	 * previous trip point transition. The similar problem exists
> +	 * when crossing the way down.
> +	 *
> +	 * Note the mechanism works only if the caller of the function
> +	 * invoke the function with the trip point ascending or
> +	 * descending regarding the temperature trend. A temperature
> +	 * drop trend will browse the trip point in the descending
> +	 * order
> +	 */
> +	if (tz->last_temperature < trip_temp && tz->temperature >= trip_temp &&
> +	    trip != tz->prev_trip) {
> +		thermal_notify_tz_trip_up(tz->id, trip, tz->temperature);
> +		tz->prev_trip = trip;
> +	} else if (tz->last_temperature >= trip_low_temp && tz->temperature < trip_low_temp &&
> +		   trip == tz->prev_trip) {
> +		thermal_notify_tz_trip_down(tz->id, trip, tz->temperature);
> +		tz->prev_trip = trip - 1;
>   	}
>   }
>   
> @@ -427,6 +443,7 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
>   {
>   	struct thermal_instance *pos;
>   	tz->temperature = THERMAL_TEMP_INVALID;
> +	tz->prev_trip = -1;
>   	tz->prev_low_trip = -INT_MAX;
>   	tz->prev_high_trip = INT_MAX;
>   	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
> @@ -511,8 +528,13 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
>   
>   	tz->notify_event = event;
>   
> -	for (count = 0; count < tz->trips; count++)
> -		handle_thermal_trip(tz, count);
> +	if (tz->last_temperature <= tz->temperature) {
> +		for (count = 0; count < tz->trips; count++)
> +			handle_thermal_trip(tz, count);
> +	} else {
> +		for (count = tz->prev_trip; count >= 0; count--)
> +			handle_thermal_trip(tz, count);
> +	}

In general the code look good. I have one question, though:
Is it always true that these trip points coming from the DT
and parsed in thermal_of_build_thermal_zone() populated by
     for_each_child_of_node(child, gchild) {
          thermal_of_populate_trip(gchild, &tz->trips[i++]);

are always defined in right order in DT?

