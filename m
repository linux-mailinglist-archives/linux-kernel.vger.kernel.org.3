Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8EC564F36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiGDIBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiGDIBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:01:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFDB5AE50;
        Mon,  4 Jul 2022 01:01:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E76FE23A;
        Mon,  4 Jul 2022 01:01:44 -0700 (PDT)
Received: from [192.168.33.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BEA93F792;
        Mon,  4 Jul 2022 01:01:42 -0700 (PDT)
Message-ID: <88ce3064-8a98-c7eb-a77b-fcd5b03db330@arm.com>
Date:   Mon, 4 Jul 2022 09:01:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 03/12] thermal/of: Remove the device node pointer for
 thermal_trip
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-4-daniel.lezcano@linexp.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220703183059.4133659-4-daniel.lezcano@linexp.org>
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
> The device node pointer is no longer needed in the thermal trip
> structure, remove it.
> 
> Cc: Alexandre Bailon <abailon@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc; Eduardo Valentin <eduval@amazon.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> ---
>   drivers/thermal/thermal_core.h | 2 --
>   drivers/thermal/thermal_of.c   | 8 --------
>   2 files changed, 10 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 726e327b4205..ff10cdda056c 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -70,13 +70,11 @@ void __thermal_cdev_update(struct thermal_cooling_device *cdev);
>   
>   /**
>    * struct thermal_trip - representation of a point in temperature domain
> - * @np: pointer to struct device_node that this trip point was created from
>    * @temperature: temperature value in miliCelsius
>    * @hysteresis: relative hysteresis in miliCelsius
>    * @type: trip point type
>    */
>   struct thermal_trip {
> -	struct device_node *np;
>   	int temperature;
>   	int hysteresis;
>   	enum thermal_trip_type type;
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 04c910ca8623..16eb18c24430 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -867,10 +867,6 @@ static int thermal_of_populate_trip(struct device_node *np,
>   		return ret;
>   	}
>   
> -	/* Required for cooling map matching */
> -	trip->np = np;
> -	of_node_get(np);
> -
>   	return 0;
>   }
>   
> @@ -1000,8 +996,6 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
>   
>   	kfree(tz->tbps);
>   free_trips:
> -	for (i = 0; i < tz->ntrips; i++)
> -		of_node_put(tz->trips[i].np);
>   	kfree(tz->trips);
>   	of_node_put(gchild);
>   free_tz:
> @@ -1026,8 +1020,6 @@ static __init void of_thermal_free_zone(struct __thermal_zone *tz)
>   	}
>   
>   	kfree(tz->tbps);
> -	for (i = 0; i < tz->ntrips; i++)
> -		of_node_put(tz->trips[i].np);
>   	kfree(tz->trips);
>   	kfree(tz);
>   }

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
