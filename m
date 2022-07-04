Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43796565868
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiGDOO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiGDOO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:14:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F4FA46A;
        Mon,  4 Jul 2022 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656944066; x=1688480066;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6UMBiXhSqErP3pi5q319t7EpuHzOc0nnsBjCZ1WVXns=;
  b=gq57rsMEbtaF8KPGFgmU90eLffjMU58neR+uv3R6SSLROMF+/BWpq9gL
   V+XQGctLCCzaqASmNrdqdAY4xyL9dFsde0YMVyTqUUhhHJMDwVtm0qdZA
   /4bVxwOVh3i8Maiy9KLNF/9mVKzkY2ioL5prMtiOwzN2HwVBIm0r/Mu5A
   gUS0RQqUOfUoSwC4miJL56i5+Pu/0Jqvp0dMaUgFqeWlw3nU6uT1AnTjy
   cMcigquVi/t055i558vNb1qYnbsBSIADqthIW23fVxLybcsKleDADMErD
   hf19QmVrabg6eZSZQGrrVRFz4c/npEr1gpty7EMq2X24vgivHQpGpKQEg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="284249422"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="284249422"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 07:14:25 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="590087581"
Received: from bbao3-mobl1.ccr.corp.intel.com ([10.249.173.150])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 07:14:23 -0700
Message-ID: <6c7e1865e7e68ac0f035680044eb878ced715a1b.camel@intel.com>
Subject: Re: [PATCH v3 11/12] thermal/of: Use thermal trips stored in the
 thermal zone
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>
Date:   Mon, 04 Jul 2022 22:14:21 +0800
In-Reply-To: <20220703183059.4133659-12-daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
         <20220703183059.4133659-12-daniel.lezcano@linexp.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-07-03 at 20:30 +0200, Daniel Lezcano wrote:
> Now that we have the thermal trip stored in the thermal zone in a
> generic way, we can rely on them and remove one indirection we found
> in the thermal_of code and do one more step forward the removal of
> the
> duplicated structures.
> 
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>  drivers/thermal/thermal_of.c | 53 +++++++++++-----------------------
> --
>  1 file changed, 16 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c
> b/drivers/thermal/thermal_of.c
> index 16b6b90a2390..bc885729bf23 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -118,12 +118,7 @@ static int of_thermal_set_trips(struct
> thermal_zone_device *tz,
>   */
>  int of_thermal_get_ntrips(struct thermal_zone_device *tz)
>  {
> -	struct __thermal_zone *data = tz->devdata;
> -
> -	if (!data || IS_ERR(data))
> -		return -ENODEV;
> -
> -	return data->ntrips;
> +	return tz->ntrips;
>  }
>  EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
>  
> @@ -139,9 +134,7 @@ EXPORT_SYMBOL_GPL(of_thermal_get_ntrips);
>   */
>  bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int
> trip)
>  {
> -	struct __thermal_zone *data = tz->devdata;
> -
> -	if (!data || trip >= data->ntrips || trip < 0)
> +	if (trip >= tz->ntrips || trip < 0)
>  		return false;
>  
>  	return true;
> @@ -161,12 +154,7 @@ EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
>  const struct thermal_trip *
>  of_thermal_get_trip_points(struct thermal_zone_device *tz)
>  {
> -	struct __thermal_zone *data = tz->devdata;
> -
> -	if (!data)
> -		return NULL;
> -
> -	return data->trips;
> +	return tz->trips;
>  }
>  EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);

what is the difference between
of_thermal_get_ntrips/of_thermal_get_trip_points and
thermal_zone_get_ntrips/thermal_zone_get_trips as introduced in this
patch series?

we need to remove the duplications.

thanks,
rui
>  
> @@ -281,12 +269,10 @@ static int of_thermal_unbind(struct
> thermal_zone_device *thermal,
>  static int of_thermal_get_trip_type(struct thermal_zone_device *tz,
> int trip,
>  				    enum thermal_trip_type *type)
>  {
> -	struct __thermal_zone *data = tz->devdata;
> -
> -	if (trip >= data->ntrips || trip < 0)
> +	if (trip >= tz->ntrips || trip < 0)
>  		return -EDOM;
>  
> -	*type = data->trips[trip].type;
> +	*type = tz->trips[trip].type;
>  
>  	return 0;
>  }
> @@ -294,12 +280,10 @@ static int of_thermal_get_trip_type(struct
> thermal_zone_device *tz, int trip,
>  static int of_thermal_get_trip_temp(struct thermal_zone_device *tz,
> int trip,
>  				    int *temp)
>  {
> -	struct __thermal_zone *data = tz->devdata;
> -
> -	if (trip >= data->ntrips || trip < 0)
> +	if (trip >= tz->ntrips || trip < 0)
>  		return -EDOM;
>  
> -	*temp = data->trips[trip].temperature;
> +	*temp = tz->trips[trip].temperature;
>  
>  	return 0;
>  }
> @@ -309,7 +293,7 @@ static int of_thermal_set_trip_temp(struct
> thermal_zone_device *tz, int trip,
>  {
>  	struct __thermal_zone *data = tz->devdata;
>  
> -	if (trip >= data->ntrips || trip < 0)
> +	if (trip >= tz->ntrips || trip < 0)
>  		return -EDOM;
>  
>  	if (data->ops && data->ops->set_trip_temp) {
> @@ -321,7 +305,7 @@ static int of_thermal_set_trip_temp(struct
> thermal_zone_device *tz, int trip,
>  	}
>  
>  	/* thermal framework should take care of data->mask & (1 <<
> trip) */
> -	data->trips[trip].temperature = temp;
> +	tz->trips[trip].temperature = temp;
>  
>  	return 0;
>  }
> @@ -329,12 +313,10 @@ static int of_thermal_set_trip_temp(struct
> thermal_zone_device *tz, int trip,
>  static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz,
> int trip,
>  				    int *hyst)
>  {
> -	struct __thermal_zone *data = tz->devdata;
> -
> -	if (trip >= data->ntrips || trip < 0)
> +	if (trip >= tz->ntrips || trip < 0)
>  		return -EDOM;
>  
> -	*hyst = data->trips[trip].hysteresis;
> +	*hyst = tz->trips[trip].hysteresis;
>  
>  	return 0;
>  }
> @@ -342,13 +324,11 @@ static int of_thermal_get_trip_hyst(struct
> thermal_zone_device *tz, int trip,
>  static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz,
> int trip,
>  				    int hyst)
>  {
> -	struct __thermal_zone *data = tz->devdata;
> -
> -	if (trip >= data->ntrips || trip < 0)
> +	if (trip >= tz->ntrips || trip < 0)
>  		return -EDOM;
>  
>  	/* thermal framework should take care of data->mask & (1 <<
> trip) */
> -	data->trips[trip].hysteresis = hyst;
> +	tz->trips[trip].hysteresis = hyst;
>  
>  	return 0;
>  }
> @@ -356,12 +336,11 @@ static int of_thermal_set_trip_hyst(struct
> thermal_zone_device *tz, int trip,
>  static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
>  				    int *temp)
>  {
> -	struct __thermal_zone *data = tz->devdata;
>  	int i;
>  
> -	for (i = 0; i < data->ntrips; i++)
> -		if (data->trips[i].type == THERMAL_TRIP_CRITICAL) {
> -			*temp = data->trips[i].temperature;
> +	for (i = 0; i < tz->ntrips; i++)
> +		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
> +			*temp = tz->trips[i].temperature;
>  			return 0;
>  		}
>  

