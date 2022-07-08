Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8CF56B127
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 05:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiGHD4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 23:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGHD4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 23:56:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF974DE7;
        Thu,  7 Jul 2022 20:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657252611; x=1688788611;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MYEPcE7pN1KciP37QC/kj2gcO7ZMO75h5cRFJHszhV8=;
  b=T6bOy/TvmUcr9pzFIzRgeCQMmXYKhBeTQ8Dt/rxvP1i94DOhdK3S/fVp
   hY6m+oy7umIiCKrkIq3eGWJjS7ILXy8zSryRZhJaRNlfax4TSC01zQ0hP
   fO8p9ltDUOFA3rPRvCLfn40yExfM4DpJZ0vdir170HcO+iNVBgxHv1+cy
   D9AH4l/osVoMGmt4DEDFRJS7mEXV61W8gbvaSla6mmQkYJPOJuCTRTMP3
   4Z9slRF+kmMgXE6Y1K+cIHvXzSCgWKROPunjJvuTuHbZQEBf8WZqS8Yob
   KPtwbkBBmiyWciweBF5v+cAK4leLpyoE3tBzVvCiUlrzSv++xy2wLvB4J
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="309744718"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="309744718"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 20:56:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="544063323"
Received: from lshi10-mobl.ccr.corp.intel.com ([10.249.172.47])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 20:56:48 -0700
Message-ID: <6f8d449906a42ba11698d3c0ae9740b83f918f42.camel@intel.com>
Subject: Re: [PATCH 3/3] thermal/core: Fix thermal trip cross point
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 08 Jul 2022 11:56:45 +0800
In-Reply-To: <20220707214513.1133506-3-daniel.lezcano@linaro.org>
References: <20220707214513.1133506-1-daniel.lezcano@linaro.org>
         <20220707214513.1133506-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-07 at 23:45 +0200, Daniel Lezcano wrote:
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
> > -----------low--------high------------|
> 
>              |<--------->|
>              |    hyst   |
>              |           |
>              |          -|--> crossed the way up
>              |
>          <---|-- crossed the way down
> 
> For that, there is a two point comparison: the current temperature
> and
> the previous temperature.
> 
> The actual code assumes if the current temperature is greater than
> the
> trip temperature and the previous temperature was lesser, then the
> trip point is crossed the way up. That is true only if we crossed the
> way down the low temperature boundary from the previous temperature
> or
> if the hysteresis is zero. The temperature can decrease between the
> low and high, so the trip point is not crossed the way down and then
> increase again and cross the high temperature raising a new trip
> point
> crossed detection which is incorrect. The same scenario happens when
> crossing the way down.
> 
> The trip point crossing the way up and down must act as parenthesis,
> a
> trip point down must close a trip point up. Today we have multiple
> trip point up without the corresponding trip point down.
> 
> In order to fix that, we store the previous trip point which gives
> the
> information about the previous trip.
> 
> As a sidenote, the thermal_zone_device structure has already the
> prev_trip_low and prev_trip_high information which are used by the
> thermal_zone_set_trips() function. This one can be changed to be
> triggered by the trip temperature crossing function, which makes more
> sense, and the two fields will disappear.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 32 ++++++++++++++++++++++----------
>  include/linux/thermal.h        |  2 ++
>  2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index f66036b3daae..92bc9ddb6904 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -357,19 +357,30 @@ static void handle_critical_trips(struct
> thermal_zone_device *tz,
>  static void handle_thermal_trip_crossed(struct thermal_zone_device
> *tz, int trip,
>  					int trip_temp, int trip_hyst,
> enum thermal_trip_type trip_type)
>  {
> +	int trip_low_temp = trip_temp - trip_hyst;
> +
>  	if (tz->last_temperature == THERMAL_TEMP_INVALID)
>  		return;
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
> +	 */
> +	if (tz->last_temperature < trip_temp && tz->temperature >=
> trip_temp &&
> +	    trip != tz->prev_trip) {
> +		thermal_notify_tz_trip_up(tz->id, trip, tz-
> >temperature);
> +		tz->prev_trip = trip;
> +		
> +	} else if (tz->last_temperature >= trip_low_temp && tz-
> >temperature < trip_low_temp &&
> +	    trip == tz->prev_trip) {
> +		thermal_notify_tz_trip_down(tz->id, trip, tz-
> >temperature);
> +		tz->prev_trip = trip - 1;

Say, let's assume hysteresis is Zero,
When the temperature increases and we do thermal_notify_tz_trip_up()
for trip 0 and trip 1, tz->prev_trip is set to 1 in this case.
And then the temperature drops below trip 0, we don't have chance to do
thermal_notify_tz_trip_down() for trip 0, because we always handle the
trips in ascending order, and tz->prev_trip is 1 when we do
handle_thermal_trip(0).

thanks,
rui

>  	}
>  }
>  
> @@ -427,6 +438,7 @@ static void thermal_zone_device_init(struct
> thermal_zone_device *tz)
>  {
>  	struct thermal_instance *pos;
>  	tz->temperature = THERMAL_TEMP_INVALID;
> +	tz->prev_trip = -1;
>  	tz->prev_low_trip = -INT_MAX;
>  	tz->prev_high_trip = INT_MAX;
>  	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 231bac2768fb..5b3bfb902d10 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -124,6 +124,7 @@ struct thermal_cooling_device {
>   * @last_temperature:	previous temperature read
>   * @emul_temperature:	emulated temperature when using
> CONFIG_THERMAL_EMULATION
>   * @passive:		1 if you've crossed a passive trip point, 0
> otherwise.
> + * @prev_trip:		previous trip point the thermal zone
> was, -1 if below all of them
>   * @prev_low_trip:	the low current temperature if you've crossed a
> passive
>  			trip point.
>   * @prev_high_trip:	the above current temperature if you've crossed
> a
> @@ -159,6 +160,7 @@ struct thermal_zone_device {
>  	int last_temperature;
>  	int emul_temperature;
>  	int passive;
> +	int prev_trip;
>  	int prev_low_trip;
>  	int prev_high_trip;
>  	atomic_t need_update;

