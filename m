Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6E057185C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiGLLPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiGLLPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:15:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBAA4F7E;
        Tue, 12 Jul 2022 04:14:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DE3F1515;
        Tue, 12 Jul 2022 04:14:58 -0700 (PDT)
Received: from [10.57.13.42] (unknown [10.57.13.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D0E13F70D;
        Tue, 12 Jul 2022 04:14:56 -0700 (PDT)
Message-ID: <2f455ac6-63b4-4452-dc3c-fcf708b7155c@arm.com>
Date:   Tue, 12 Jul 2022 12:14:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/3] thermal/core: Passing a parameter instead of
 calling the function again
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>, rafael@kernel.org
References: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
 <20220708183210.1334839-2-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220708183210.1334839-2-daniel.lezcano@linaro.org>
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



On 7/8/22 19:32, Daniel Lezcano wrote:
> As the trip temperature is already available when calling the
> function, pass it as a parameter instead of having the function
> calling the ops again to retrieve the same data.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/thermal_core.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d9f771b15ed8..f66036b3daae 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -340,12 +340,8 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz)
>   EXPORT_SYMBOL(thermal_zone_device_critical);
>   
>   static void handle_critical_trips(struct thermal_zone_device *tz,
> -				  int trip, enum thermal_trip_type trip_type)
> +				  int trip, int trip_temp, enum thermal_trip_type trip_type)
>   {
> -	int trip_temp;
> -
> -	tz->ops->get_trip_temp(tz, trip, &trip_temp);
> -
>   	/* If we have not crossed the trip_temp, we do not care. */
>   	if (trip_temp <= 0 || tz->temperature < trip_temp)
>   		return;
> @@ -394,7 +390,7 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
>   	handle_thermal_trip_crossed(tz, trip, trip_temp, hyst, type);
>   
>   	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
> -		handle_critical_trips(tz, trip, type);
> +		handle_critical_trips(tz, trip, trip_temp, type);
>   	else
>   		handle_non_critical_trips(tz, trip);
>   	/*

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
