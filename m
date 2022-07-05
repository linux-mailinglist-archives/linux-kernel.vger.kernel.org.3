Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32A65660E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiGECDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGECDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:03:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEB011447;
        Mon,  4 Jul 2022 19:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656986591; x=1688522591;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6yqOiTut6fhgR7731Ro8TM2bQGQTqErOV9ElNPqGrD0=;
  b=RH2As1FbicGfQZLzQWFPunVgbBK4KBpElYSrAY8jCRfx5+BMFPo2Oj6j
   yiIiNmbBey9gZkpgj2ITSte1MBTVcYaBloTP+rFWyvzHzKUmlmn2aFRyW
   u0W8Mv7Y2ZWfk71hvxYc7vm2tgfyUMQlb9WkIXMlgvBSADe+qPXepkHLW
   KIDJCeXY2TdSieIUIUIkwNQ5wfwPSgb8RzkZW5WUNZBk2z72XwC7V0Y7K
   hMa9tRwBf7Gxqp5pYlDFX18VIPiWHNR80Dh/J8sZXlM5xluzlNL8yQGiF
   89XW5+Q/+KP0/QNnq80heA9C/Urs7vNXldN09MiitJj781o3EUnAFV0KF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="308766034"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="308766034"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 19:03:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="619588902"
Received: from shuangy2-mobl.ccr.corp.intel.com ([10.249.171.213])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 19:03:08 -0700
Message-ID: <3ec41dbb1e0586841bd7f0ca9ef34d6e4fbbca58.camel@intel.com>
Subject: Re: [PATCH v3 09/12] thermal/core: Register with the trip points
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>
Date:   Tue, 05 Jul 2022 10:03:06 +0800
In-Reply-To: <20220703183059.4133659-10-daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
         <20220703183059.4133659-10-daniel.lezcano@linexp.org>
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

On Sun, 2022-07-03 at 20:30 +0200, Daniel Lezcano wrote:
> As we added the thermal trip points structure in the thermal zone,
> let's extend the thermal zone register function to have the thermal
> trip structures as a parameter and store it in the 'trips' field of
> the thermal zone structure.

Just FYI.

I proposed a small topic for this year' LPC about the
thermal_zone_device_register() parameters.
We have more and more parameters introduced, IMO, it's better to use a
unified structure for registration phase configurations, or reuse
struct thermal_zone_params.
In this way, when a new parameter is needed, we only need to introduce
a new field in the structure, rather than update every caller of this
API, or introduce new wrapper functions like we did in this patch.

thanks,
rui
> 
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>  drivers/thermal/thermal_core.c | 22 +++++++++++++++++-----
>  drivers/thermal/thermal_core.h |  4 ++--
>  include/linux/thermal.h        |  6 ++++++
>  3 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index 434a675da245..e865c41d2320 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1167,8 +1167,9 @@ static void thermal_set_delay_jiffies(unsigned
> long *delay_jiffies, int delay_ms
>  }
>  
>  /**
> - * thermal_zone_device_register() - register a new thermal zone
> device
> + * thermal_zone_device_register_with_trips() - register a new
> thermal zone device
>   * @type:	the thermal zone device type
> + * @trips:	a pointer to an array of thermal trips
>   * @ntrips:	the number of trip points the thermal zone support
>   * @mask:	a bit string indicating the writeablility of trip
> points
>   * @devdata:	private device data
> @@ -1191,10 +1192,10 @@ static void
> thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
>   * IS_ERR*() helpers.
>   */
>  struct thermal_zone_device *
> -thermal_zone_device_register(const char *type, int ntrips, int mask,
> -			     void *devdata, struct
> thermal_zone_device_ops *ops,
> -			     struct thermal_zone_params *tzp, int
> passive_delay,
> -			     int polling_delay)
> +thermal_zone_device_register_with_trips(const char *type, struct
> thermal_trip *trips, int ntrips, int mask,
> +					void *devdata, struct
> thermal_zone_device_ops *ops,
> +					struct thermal_zone_params
> *tzp, int passive_delay,
> +					int polling_delay)
>  {
>  	struct thermal_zone_device *tz;
>  	enum thermal_trip_type trip_type;
> @@ -1256,6 +1257,7 @@ thermal_zone_device_register(const char *type,
> int ntrips, int mask,
>  	tz->device.class = &thermal_class;
>  	tz->devdata = devdata;
>  	tz->ntrips = ntrips;
> +	tz->trips = trips;
>  
>  	thermal_set_delay_jiffies(&tz->passive_delay_jiffies,
> passive_delay);
>  	thermal_set_delay_jiffies(&tz->polling_delay_jiffies,
> polling_delay);
> @@ -1331,6 +1333,16 @@ thermal_zone_device_register(const char *type,
> int ntrips, int mask,
>  	kfree(tz);
>  	return ERR_PTR(result);
>  }
> +
> +struct thermal_zone_device *thermal_zone_device_register(const char
> *type, int ntrips, int mask,
> +							 void *devdata,
> struct thermal_zone_device_ops *ops,
> +							 struct
> thermal_zone_params *tzp, int passive_delay,
> +							 int
> polling_delay)
> +{
> +	return thermal_zone_device_register_with_trips(type, NULL,
> ntrips, mask,
> +						       devdata, ops,
> tzp,
> +						       passive_delay,
> polling_delay);
> +}
>  EXPORT_SYMBOL_GPL(thermal_zone_device_register);
>  
>  /**
> diff --git a/drivers/thermal/thermal_core.h
> b/drivers/thermal/thermal_core.h
> index 84e341c1e0fc..bbe3ec26d12e 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -113,12 +113,12 @@ int thermal_build_list_of_policies(char *buf);
>  /* Helpers */
>  void thermal_zone_set_trips(struct thermal_zone_device *tz);
>  
> -static inline struct thermal_trip *thermal_zone_get_trips(struct
> thermal_zone *tz)
> +static inline struct thermal_trip *thermal_zone_get_trips(struct
> thermal_zone_device *tz)
>  {
>  	return tz->trips;
>  }
>  
> -static inline int thermal_zone_get_ntrips(struct thermal_zone *tz)
> +static inline int thermal_zone_get_ntrips(struct thermal_zone_device
> *tz)
>  {
>  	return tz->ntrips;
>  }
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 3733e23b6359..8cbe237a92d0 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -379,8 +379,14 @@ void
> devm_thermal_zone_of_sensor_unregister(struct device *dev,
>  struct thermal_zone_device *thermal_zone_device_register(const char
> *, int, int,
>  		void *, struct thermal_zone_device_ops *,
>  		struct thermal_zone_params *, int, int);
> +
>  void thermal_zone_device_unregister(struct thermal_zone_device *);
>  
> +struct thermal_zone_device *
> +thermal_zone_device_register_with_trips(const char *, struct
> thermal_trip *, int, int,
> +					void *, struct
> thermal_zone_device_ops *,
> +					struct thermal_zone_params *,
> int, int);
> +
>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *,
> int,
>  				     struct thermal_cooling_device *,
>  				     unsigned long, unsigned long,

