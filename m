Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC80564FC4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiGDIck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiGDIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:32:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0D5EB49A;
        Mon,  4 Jul 2022 01:32:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C515C23A;
        Mon,  4 Jul 2022 01:32:36 -0700 (PDT)
Received: from [192.168.33.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99EC3F792;
        Mon,  4 Jul 2022 01:32:34 -0700 (PDT)
Message-ID: <9ff53ef8-c15e-a287-bb7c-823b7ef9f67d@arm.com>
Date:   Mon, 4 Jul 2022 09:32:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 09/12] thermal/core: Register with the trip points
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-10-daniel.lezcano@linexp.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220703183059.4133659-10-daniel.lezcano@linexp.org>
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
> As we added the thermal trip points structure in the thermal zone,
> let's extend the thermal zone register function to have the thermal
> trip structures as a parameter and store it in the 'trips' field of
> the thermal zone structure.
> 
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>   drivers/thermal/thermal_core.c | 22 +++++++++++++++++-----
>   drivers/thermal/thermal_core.h |  4 ++--
>   include/linux/thermal.h        |  6 ++++++
>   3 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 434a675da245..e865c41d2320 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1167,8 +1167,9 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
>   }
>   
>   /**
> - * thermal_zone_device_register() - register a new thermal zone device
> + * thermal_zone_device_register_with_trips() - register a new thermal zone device
>    * @type:	the thermal zone device type
> + * @trips:	a pointer to an array of thermal trips
>    * @ntrips:	the number of trip points the thermal zone support
>    * @mask:	a bit string indicating the writeablility of trip points
>    * @devdata:	private device data
> @@ -1191,10 +1192,10 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
>    * IS_ERR*() helpers.
>    */
>   struct thermal_zone_device *
> -thermal_zone_device_register(const char *type, int ntrips, int mask,
> -			     void *devdata, struct thermal_zone_device_ops *ops,
> -			     struct thermal_zone_params *tzp, int passive_delay,
> -			     int polling_delay)
> +thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int ntrips, int mask,
> +					void *devdata, struct thermal_zone_device_ops *ops,
> +					struct thermal_zone_params *tzp, int passive_delay,
> +					int polling_delay)
>   {
>   	struct thermal_zone_device *tz;
>   	enum thermal_trip_type trip_type;
> @@ -1256,6 +1257,7 @@ thermal_zone_device_register(const char *type, int ntrips, int mask,
>   	tz->device.class = &thermal_class;
>   	tz->devdata = devdata;
>   	tz->ntrips = ntrips;
> +	tz->trips = trips;
>   
>   	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
>   	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
> @@ -1331,6 +1333,16 @@ thermal_zone_device_register(const char *type, int ntrips, int mask,
>   	kfree(tz);
>   	return ERR_PTR(result);
>   }
> +
> +struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
> +							 void *devdata, struct thermal_zone_device_ops *ops,
> +							 struct thermal_zone_params *tzp, int passive_delay,
> +							 int polling_delay)
> +{
> +	return thermal_zone_device_register_with_trips(type, NULL, ntrips, mask,
> +						       devdata, ops, tzp,
> +						       passive_delay, polling_delay);
> +}
>   EXPORT_SYMBOL_GPL(thermal_zone_device_register);
>   
>   /**
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 84e341c1e0fc..bbe3ec26d12e 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -113,12 +113,12 @@ int thermal_build_list_of_policies(char *buf);
>   /* Helpers */
>   void thermal_zone_set_trips(struct thermal_zone_device *tz);
>   
> -static inline struct thermal_trip *thermal_zone_get_trips(struct thermal_zone *tz)
> +static inline struct thermal_trip *thermal_zone_get_trips(struct thermal_zone_device *tz)
>   {
>   	return tz->trips;
>   }
>   
> -static inline int thermal_zone_get_ntrips(struct thermal_zone *tz)
> +static inline int thermal_zone_get_ntrips(struct thermal_zone_device *tz)
>   {
>   	return tz->ntrips;
>   }
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 3733e23b6359..8cbe237a92d0 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -379,8 +379,14 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
>   struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
>   		void *, struct thermal_zone_device_ops *,
>   		struct thermal_zone_params *, int, int);
> +
>   void thermal_zone_device_unregister(struct thermal_zone_device *);
>   
> +struct thermal_zone_device *
> +thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int, int,
> +					void *, struct thermal_zone_device_ops *,
> +					struct thermal_zone_params *, int, int);
> +
>   int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
>   				     struct thermal_cooling_device *,
>   				     unsigned long, unsigned long,

Apart from 'ntrips', which might be 'num_trips', this looks OK.
