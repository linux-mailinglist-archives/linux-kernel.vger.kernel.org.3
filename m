Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25A564F40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiGDIEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiGDIEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:04:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 922ED55B2;
        Mon,  4 Jul 2022 01:04:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A776C23A;
        Mon,  4 Jul 2022 01:04:05 -0700 (PDT)
Received: from [192.168.33.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8BF43F792;
        Mon,  4 Jul 2022 01:04:03 -0700 (PDT)
Message-ID: <89f930df-5276-e3b1-7569-4c62ffdf135a@arm.com>
Date:   Mon, 4 Jul 2022 09:04:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 04/12] thermal/of: Move thermal_trip structure to
 thermal.h
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-5-daniel.lezcano@linexp.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220703183059.4133659-5-daniel.lezcano@linexp.org>
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
> The structure thermal_trip is now generic and will be usable by the
> different sensor drivers in place of their own structure.
> 
> Move its definition to thermal.h to make it accessible.
> 
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>   drivers/thermal/thermal_core.h | 12 ------------
>   include/linux/thermal.h        | 12 ++++++++++++
>   2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index ff10cdda056c..60844e2d59bb 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -68,18 +68,6 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
>   void thermal_cdev_update(struct thermal_cooling_device *);
>   void __thermal_cdev_update(struct thermal_cooling_device *cdev);
>   
> -/**
> - * struct thermal_trip - representation of a point in temperature domain
> - * @temperature: temperature value in miliCelsius
> - * @hysteresis: relative hysteresis in miliCelsius
> - * @type: trip point type
> - */
> -struct thermal_trip {
> -	int temperature;
> -	int hysteresis;
> -	enum thermal_trip_type type;
> -};
> -
>   int get_tz_trend(struct thermal_zone_device *tz, int trip);
>   
>   struct thermal_instance *
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 365733b428d8..6289b0bb1c97 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -80,6 +80,18 @@ struct thermal_zone_device_ops {
>   	void (*critical)(struct thermal_zone_device *);
>   };
>   
> +/**
> + * struct thermal_trip - representation of a point in temperature domain
> + * @temperature: temperature value in miliCelsius
> + * @hysteresis: relative hysteresis in miliCelsius
> + * @type: trip point type
> + */
> +struct thermal_trip {
> +	int temperature;
> +	int hysteresis;
> +	enum thermal_trip_type type;
> +};
> +
>   struct thermal_cooling_device_ops {
>   	int (*get_max_state) (struct thermal_cooling_device *, unsigned long *);
>   	int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *);


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
