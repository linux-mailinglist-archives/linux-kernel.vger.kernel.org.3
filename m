Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503AE564F47
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiGDIFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiGDIFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:05:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FBDAAE6B;
        Mon,  4 Jul 2022 01:05:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B2AE23A;
        Mon,  4 Jul 2022 01:05:34 -0700 (PDT)
Received: from [192.168.33.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63F6B3F792;
        Mon,  4 Jul 2022 01:05:32 -0700 (PDT)
Message-ID: <b5f69447-7ca2-ae39-2af0-1fa3602f31cd@arm.com>
Date:   Mon, 4 Jul 2022 09:05:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 06/12] thermal/core: Move thermal_set_delay_jiffies to
 static
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-7-daniel.lezcano@linexp.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220703183059.4133659-7-daniel.lezcano@linexp.org>
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
> The function 'thermal_set_delay_jiffies' is only used in
> thermal_core.c but it is defined and implemented in a separate
> file. Move the function to thermal_core.c and make it static.
> 
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>   drivers/thermal/thermal_core.c    | 7 +++++++
>   drivers/thermal/thermal_core.h    | 1 -
>   drivers/thermal/thermal_helpers.c | 7 -------
>   3 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index e22e7d939c54..a8b1628937c6 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1159,6 +1159,13 @@ static void bind_tz(struct thermal_zone_device *tz)
>   	mutex_unlock(&thermal_list_lock);
>   }
>   
> +static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
> +{
> +	*delay_jiffies = msecs_to_jiffies(delay_ms);
> +	if (delay_ms > 1000)
> +		*delay_jiffies = round_jiffies(*delay_jiffies);
> +}
> +
>   /**
>    * thermal_zone_device_register() - register a new thermal zone device
>    * @type:	the thermal zone device type
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 60844e2d59bb..c991bb290512 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -112,7 +112,6 @@ int thermal_build_list_of_policies(char *buf);
>   
>   /* Helpers */
>   void thermal_zone_set_trips(struct thermal_zone_device *tz);
> -void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms);
>   
>   /* sysfs I/F */
>   int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index f4c1e87ef040..60bfda1a1db7 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -174,13 +174,6 @@ void thermal_zone_set_trips(struct thermal_zone_device *tz)
>   	mutex_unlock(&tz->lock);
>   }
>   
> -void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
> -{
> -	*delay_jiffies = msecs_to_jiffies(delay_ms);
> -	if (delay_ms > 1000)
> -		*delay_jiffies = round_jiffies(*delay_jiffies);
> -}
> -
>   static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
>   				       int target)
>   {

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
