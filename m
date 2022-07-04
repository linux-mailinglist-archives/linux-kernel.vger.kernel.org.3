Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A887B56585A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiGDOLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiGDOLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:11:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5F963A3;
        Mon,  4 Jul 2022 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656943865; x=1688479865;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GcegQ4d7S5ejOoKN+JV3Yxl7V276w5LiEjBT6DSCm2A=;
  b=NvPkCiHl+6ToYhQDn0b0vwAtvgkKqVLBk+4ivgXGQZ40SY47CrBHKOJD
   a+ABzo/p1aLXDHYaiZN+9rk9u8FHihQKXGbqoZt6qpYCBHXwtUHzvOEew
   uoMiXvUOzb1UELQ2fcx+iRe1w9f8GKZTn0Gld0swOVYdeXS5VQMe7XhUg
   I+cvSz2TtWF/dSHpHu2GidfRNBHnYGBhkyHAUPfOv6y4C/VVLcIAkAhUe
   mIcFCkuDnXETDOFU4eJs2p5JFk7eaUhrig8dpTUogYzOBbp5w6l9+Yoo7
   6hzjB3ijT8N1bDQg/Tubyhxi0etP2aSHLNGyRy5SrIxdUffl3DEOAYO+S
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="281896787"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="281896787"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 07:11:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="649622770"
Received: from bbao3-mobl1.ccr.corp.intel.com ([10.249.173.150])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 07:11:02 -0700
Message-ID: <e97e094cf99980f461ba798f7179ce1caea3cf87.camel@intel.com>
Subject: Re: [PATCH v3 08/12] thermal/core: Add thermal_trip in thermal_zone
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>
Date:   Mon, 04 Jul 2022 22:11:00 +0800
In-Reply-To: <20220703183059.4133659-9-daniel.lezcano@linexp.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
         <20220703183059.4133659-9-daniel.lezcano@linexp.org>
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
> The thermal trip points are properties of a thermal zone and the
> different sub systems should be able to save them in the thermal zone
> structure instead of having their own definition.
> 
> Give the opportunity to the drivers to create a thermal zone with
> thermal trips which will be accessible directly from the thermal core
> framework.
> 
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>  drivers/thermal/thermal_core.h | 10 ++++++++++
>  include/linux/thermal.h        |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.h
> b/drivers/thermal/thermal_core.h
> index c991bb290512..84e341c1e0fc 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -113,6 +113,16 @@ int thermal_build_list_of_policies(char *buf);
>  /* Helpers */
>  void thermal_zone_set_trips(struct thermal_zone_device *tz);
>  
> +static inline struct thermal_trip *thermal_zone_get_trips(struct
> thermal_zone *tz)

it should be struct thermal_zone_device?
It seems that you fixed it in patch 9/12, and leave it broke here.

> +{
> +	return tz->trips;
> +}
> +
> +static inline int thermal_zone_get_ntrips(struct thermal_zone *tz)

same problem as above.

thanks,
rui
> +{
> +	return tz->ntrips;
> +}
> +
>  /* sysfs I/F */
>  int thermal_zone_create_device_groups(struct thermal_zone_device *,
> int);
>  void thermal_zone_destroy_device_groups(struct thermal_zone_device
> *);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 3a57878a2a6c..3733e23b6359 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -179,6 +179,7 @@ struct thermal_zone_device {
>  	struct thermal_zone_device_ops *ops;
>  	struct thermal_zone_params *tzp;
>  	struct thermal_governor *governor;
> +	struct thermal_trip *trips;
>  	void *governor_data;
>  	struct list_head thermal_instances;
>  	struct ida ida;

