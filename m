Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3792756B702
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbiGHKP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiGHKP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:15:26 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD4A1C2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:15:24 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f2so24501135wrr.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 03:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=//ZIEtMiJwet7hlLmuFqjVir93kiywzloQ78cgqOB6Q=;
        b=pDm2XjqZpxPRQbZaEJ2VAYWNdayd4hQ0TH+2vRV7cDIMRNyGSC1DpABuSu98xhl8/W
         5dw09i0NARTn5Nar5Q5cG2av6d7UT6Wt+eBkCMoJQgQVz7hUcQHpU10tECUgqFodjJXX
         GbTFnDZOfFx5bzC4THEN5X/dWXgBQHyMVj67h82bb5x7kZFlGkw6bVcbZSzkXwgeb5u+
         sDgpT7HLgDxeaz622+58YZPDxu5r2LOyHEbAgJCTq97QIQ/dAdGn95t57qgOL0liXEX+
         tvgPyOBp0kqOJoIUnIdNWKju7ZvchW+WIINg8xN0/05LaLd3ttM0BNGHczGZi82podCl
         ZR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=//ZIEtMiJwet7hlLmuFqjVir93kiywzloQ78cgqOB6Q=;
        b=JcC1K6BwfJtLNi5Qn5IlzABb2HlGzFw4rF08KxrmvU8I62YGixt2UqkaS/TkObwyX7
         0EHVVjSjmC9aYafDh/AKElfPpGTybfXzBcVMJsJkIB9c+akaTqMOoSfSIlpW5qdkWioD
         y7TPdnXRDR1Qs5n+8V1TYTBUIi0dSSIQrJ92xq0fUcA9blqcYRsZLAM3iL81R0xD6fPn
         bjR/I5uNnB7ZNSYYsBEV64atz3sZhYyK3f9I56irisSRilIOEAHVnWqH3ulaw2HHbZQ4
         Kin0QKkBZwF44D3RMCxZ98Zdz8uX8Q/DFzH/qeIjQZSd9VqEa1tIW6QGK3jNkBiwcs4/
         2qHA==
X-Gm-Message-State: AJIora9HEuqFeSduQhLS9FX65vKHIb9oCABErhee0MUj0KfPhs50am6o
        tnK36SRxUF2AWmos8slx3PCifA==
X-Google-Smtp-Source: AGRyM1skvvJE90Z/qsompIurlpPMEhkmexMkzxtzONX/3PQzgMmcTArj3JxTdM9dlhqhy8ED3/X16w==
X-Received: by 2002:a05:6000:1789:b0:21d:7279:f455 with SMTP id e9-20020a056000178900b0021d7279f455mr2535366wrg.542.1657275323179;
        Fri, 08 Jul 2022 03:15:23 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id be12-20020a05600c1e8c00b0039c4d022a44sm1718057wmb.1.2022.07.08.03.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 03:15:22 -0700 (PDT)
Message-ID: <828d8a53-7ba2-94f7-693c-ed3e6d4b4c28@linaro.org>
Date:   Fri, 8 Jul 2022 12:15:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] thermal/core: Fix thermal trip cross point
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220707214513.1133506-1-daniel.lezcano@linaro.org>
 <20220707214513.1133506-3-daniel.lezcano@linaro.org>
 <6f8d449906a42ba11698d3c0ae9740b83f918f42.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6f8d449906a42ba11698d3c0ae9740b83f918f42.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Zhang,

thanks for reviewing

On 08/07/2022 05:56, Zhang Rui wrote:
> On Thu, 2022-07-07 at 23:45 +0200, Daniel Lezcano wrote:
>> The routine doing trip point crossing the way up or down is actually
>> wrong.
>>
>> A trip point is composed with a trip temperature and a hysteresis.
>>
>> The trip temperature is used to detect when the trip point is crossed
>> the way up.
>>
>> The trip temperature minus the hysteresis is used to detect when the
>> trip point is crossed the way down.
>>
>>> -----------low--------high------------|
>>
>>               |<--------->|
>>               |    hyst   |
>>               |           |
>>               |          -|--> crossed the way up
>>               |
>>           <---|-- crossed the way down
>>
>> For that, there is a two point comparison: the current temperature
>> and
>> the previous temperature.
>>
>> The actual code assumes if the current temperature is greater than
>> the
>> trip temperature and the previous temperature was lesser, then the
>> trip point is crossed the way up. That is true only if we crossed the
>> way down the low temperature boundary from the previous temperature
>> or
>> if the hysteresis is zero. The temperature can decrease between the
>> low and high, so the trip point is not crossed the way down and then
>> increase again and cross the high temperature raising a new trip
>> point
>> crossed detection which is incorrect. The same scenario happens when
>> crossing the way down.
>>
>> The trip point crossing the way up and down must act as parenthesis,
>> a
>> trip point down must close a trip point up. Today we have multiple
>> trip point up without the corresponding trip point down.
>>
>> In order to fix that, we store the previous trip point which gives
>> the
>> information about the previous trip.
>>
>> As a sidenote, the thermal_zone_device structure has already the
>> prev_trip_low and prev_trip_high information which are used by the
>> thermal_zone_set_trips() function. This one can be changed to be
>> triggered by the trip temperature crossing function, which makes more
>> sense, and the two fields will disappear.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/thermal_core.c | 32 ++++++++++++++++++++++----------
>>   include/linux/thermal.h        |  2 ++
>>   2 files changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c
>> b/drivers/thermal/thermal_core.c
>> index f66036b3daae..92bc9ddb6904 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -357,19 +357,30 @@ static void handle_critical_trips(struct
>> thermal_zone_device *tz,
>>   static void handle_thermal_trip_crossed(struct thermal_zone_device
>> *tz, int trip,
>>   					int trip_temp, int trip_hyst,
>> enum thermal_trip_type trip_type)
>>   {
>> +	int trip_low_temp = trip_temp - trip_hyst;
>> +
>>   	if (tz->last_temperature == THERMAL_TEMP_INVALID)
>>   		return;
>>   
>> -	if (tz->last_temperature < trip_temp &&
>> -	    tz->temperature >= trip_temp) {
>> -		thermal_notify_tz_trip_up(tz->id, trip,
>> -					  tz->temperature);
>> -	}
>> -
>> -	if (tz->last_temperature >= trip_temp &&
>> -	    tz->temperature < (trip_temp - trip_hyst)) {
>> -		thermal_notify_tz_trip_down(tz->id, trip,
>> -					    tz->temperature);
>> +	/*
>> +	 * Due to the hysteresis, a third information is needed to
>> +	 * detect when the temperature is wavering between the
>> +	 * trip_low_temp and the trip_temp. A trip point is crossed
>> +	 * the way up only if the temperature is above it while the
>> +	 * previous temperature was below *and* we crossed the
>> +	 * trip_temp_low before. The previous trip point give us the
>> +	 * previous trip point transition. The similar problem exists
>> +	 * when crossing the way down.
>> +	 */
>> +	if (tz->last_temperature < trip_temp && tz->temperature >=
>> trip_temp &&
>> +	    trip != tz->prev_trip) {
>> +		thermal_notify_tz_trip_up(tz->id, trip, tz-
>>> temperature);
>> +		tz->prev_trip = trip;
>> +		
>> +	} else if (tz->last_temperature >= trip_low_temp && tz-
>>> temperature < trip_low_temp &&
>> +	    trip == tz->prev_trip) {
>> +		thermal_notify_tz_trip_down(tz->id, trip, tz-
>>> temperature);
>> +		tz->prev_trip = trip - 1;
> 
> Say, let's assume hysteresis is Zero,
> When the temperature increases and we do thermal_notify_tz_trip_up()
> for trip 0 and trip 1, tz->prev_trip is set to 1 in this case.
> And then the temperature drops below trip 0, we don't have chance to do
> thermal_notify_tz_trip_down() for trip 0, because we always handle the
> trips in ascending order, and tz->prev_trip is 1 when we do
> handle_thermal_trip(0).

Well I don't see how to handle this case, except accepting the detection 
will happen at the next temperature update, no ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
