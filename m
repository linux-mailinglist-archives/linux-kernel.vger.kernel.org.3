Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6D3564F33
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiGDH7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiGDH72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:59:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E023DAE43;
        Mon,  4 Jul 2022 00:59:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA59723A;
        Mon,  4 Jul 2022 00:59:27 -0700 (PDT)
Received: from [192.168.33.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D0D63F792;
        Mon,  4 Jul 2022 00:59:25 -0700 (PDT)
Message-ID: <180b55da-9ed2-baba-27b0-fba354a9ecd2@arm.com>
Date:   Mon, 4 Jul 2022 08:59:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 02/12] thermal/of: Replace device node match with
 device node search
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-3-daniel.lezcano@linexp.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220703183059.4133659-3-daniel.lezcano@linexp.org>
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



On 7/3/22 19:30, Daniel Lezcano wrote:
> The thermal_of code builds a trip array associated with the node
> pointer in order to compare the trip point phandle with the list.
> 
> The thermal trip is a thermal zone property and should be moved
> there. If some sensors have hardcoded trip points, they should use the
> exported structure instead of redefining again and again their own
> structure and data to describe exactly the same things.
> 
> In order to move this to the thermal.h header and allow more cleanup,
> we need to remove the node pointer from the structure.
> 
> Instead of building storing the device node, we search directly in the
> device tree the corresponding node. That results in a simplification
> of the code and allows to move the structure to thermal.h
> 
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>   drivers/thermal/thermal_of.c | 62 ++++++++++++++++++++++++------------
>   1 file changed, 42 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index b65d435cb92f..04c910ca8623 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -671,6 +671,35 @@ EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_unregister);
>   
>   /***   functions parsing device tree nodes   ***/
>   
> +static int of_find_trip_id(struct device_node *np, struct device_node *trip)
> +{
> +	struct device_node *trips;
> +	struct device_node *t;
> +	int i = 0;
> +
> +	trips = of_get_child_by_name(np, "trips");
> +	if (!trips) {
> +		pr_err("Failed to find 'trips' node\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Find the trip id point associated with the cooling device map
> +	 */
> +	for_each_child_of_node(trips, t) {
> +
> +		if (t == trip)
> +			goto out;
> +		i++;
> +	}
> +
> +	i = -ENXIO;
> +out:	
> +	of_node_put(trips);
> +
> +	return i;
> +}
> +
>   /**
>    * thermal_of_populate_bind_params - parse and fill cooling map data
>    * @np: DT node containing a cooling-map node
> @@ -686,14 +715,13 @@ EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_unregister);
>    * Return: 0 on success, proper error code otherwise
>    */
>   static int thermal_of_populate_bind_params(struct device_node *np,
> -					   struct __thermal_bind_params *__tbp,
> -					   struct thermal_trip *trips,
> -					   int ntrips)
> +					   struct __thermal_bind_params *__tbp)
>   {
>   	struct of_phandle_args cooling_spec;
>   	struct __thermal_cooling_bind_param *__tcbp;
>   	struct device_node *trip;
>   	int ret, i, count;
> +	int trip_id;
>   	u32 prop;
>   
>   	/* Default weight. Usage is optional */
> @@ -708,18 +736,14 @@ static int thermal_of_populate_bind_params(struct device_node *np,
>   		return -ENODEV;
>   	}
>   
> -	/* match using device_node */
> -	for (i = 0; i < ntrips; i++)
> -		if (trip == trips[i].np) {
> -			__tbp->trip_id = i;
> -			break;
> -		}
> -
> -	if (i == ntrips) {
> -		ret = -ENODEV;
> +	trip_id = of_find_trip_id(np, trip);
> +	if (trip_id < 0) {
> +		ret = trip_id;
>   		goto end;
>   	}
>   
> +	__tbp->trip_id = trip_id;
> +	
>   	count = of_count_phandle_with_args(np, "cooling-device",
>   					   "#cooling-cells");
>   	if (count <= 0) {
> @@ -868,6 +892,7 @@ static struct __thermal_zone
>   __init *thermal_of_build_thermal_zone(struct device_node *np)
>   {
>   	struct device_node *child = NULL, *gchild;
> +	struct device_node *trips;
>   	struct __thermal_zone *tz;
>   	int ret, i;
>   	u32 prop, coef[2];
> @@ -910,13 +935,13 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
>   	}
>   
>   	/* trips */
> -	child = of_get_child_by_name(np, "trips");
> +	trips = of_get_child_by_name(np, "trips");
>   
>   	/* No trips provided */
> -	if (!child)
> +	if (!trips)
>   		goto finish;
>   
> -	tz->ntrips = of_get_child_count(child);
> +	tz->ntrips = of_get_child_count(trips);
>   	if (tz->ntrips == 0) /* must have at least one child */
>   		goto finish;
>   
> @@ -927,14 +952,12 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
>   	}
>   
>   	i = 0;
> -	for_each_child_of_node(child, gchild) {
> +	for_each_child_of_node(trips, gchild) {
>   		ret = thermal_of_populate_trip(gchild, &tz->trips[i++]);
>   		if (ret)
>   			goto free_trips;
>   	}
>   
> -	of_node_put(child);
> -

It's probably needed to put the 'trips' here, isn't it?
Or at the end in 'free_trips'.


>   	/* cooling-maps */
>   	child = of_get_child_by_name(np, "cooling-maps");
>   
> @@ -954,8 +977,7 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
>   
>   	i = 0;
>   	for_each_child_of_node(child, gchild) {
> -		ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++],
> -						      tz->trips, tz->ntrips);
> +		ret = thermal_of_populate_bind_params(gchild, &tz->tbps[i++]);
>   		if (ret)
>   			goto free_tbps;
>   	}
