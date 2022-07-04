Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEC4564FD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiGDIgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGDIgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:36:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DED1B482;
        Mon,  4 Jul 2022 01:35:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 473CC23A;
        Mon,  4 Jul 2022 01:35:59 -0700 (PDT)
Received: from [192.168.33.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 707583F792;
        Mon,  4 Jul 2022 01:35:57 -0700 (PDT)
Message-ID: <5142343f-6792-a358-d049-cbaeb8c07726@arm.com>
Date:   Mon, 4 Jul 2022 09:35:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 08/12] thermal/core: Add thermal_trip in thermal_zone
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-9-daniel.lezcano@linexp.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220703183059.4133659-9-daniel.lezcano@linexp.org>
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
>   drivers/thermal/thermal_core.h | 10 ++++++++++
>   include/linux/thermal.h        |  1 +
>   2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index c991bb290512..84e341c1e0fc 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -113,6 +113,16 @@ int thermal_build_list_of_policies(char *buf);
>   /* Helpers */
>   void thermal_zone_set_trips(struct thermal_zone_device *tz);
>   
> +static inline struct thermal_trip *thermal_zone_get_trips(struct thermal_zone *tz)
> +{
> +	return tz->trips;
> +}
> +
> +static inline int thermal_zone_get_ntrips(struct thermal_zone *tz)
> +{
> +	return tz->ntrips;

'num_trips' ?

> +}
> +
>   /* sysfs I/F */
>   int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
>   void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 3a57878a2a6c..3733e23b6359 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h

Missing doc comment new line for this new field.

> @@ -179,6 +179,7 @@ struct thermal_zone_device {
>   	struct thermal_zone_device_ops *ops;
>   	struct thermal_zone_params *tzp;
>   	struct thermal_governor *governor;
> +	struct thermal_trip *trips;

I would group together two lines:
struct thermal_trip *trips;
int num_trips;

>   	void *governor_data;
>   	struct list_head thermal_instances;
>   	struct ida ida;
