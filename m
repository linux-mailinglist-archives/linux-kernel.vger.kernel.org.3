Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0212649407E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236924AbiASTMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbiASTMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:12:15 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFCBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 11:12:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso2026988wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 11:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ji7iGAxDJEeqfoAnF5QNg6c4bsnLencbEnYiubnXrLA=;
        b=QTF5V7vFYj7cQQydREB5BXMKVt4yV03Y5KYj1RbvffieD+/j9C4e5IDsXeoUXynC6p
         fcy+UxQvYkY5evkuGk4B/UG893ZqNr0PW/EmPRgS0MEDcY6J832WcUOjnloC+Kv6Kj6O
         1n/eZoo9TrjTeHcshGTVoXgq0ZZAKyFOhFUDfS+Q0+1VoYi4w6ZurwAqiamq6WcoDq9I
         eJuP9UK9kXp+yV3WzA2zoeceX18K48FyNmz/QafrPWTkoYPafl5VjJHuulqPlzqjcOz8
         fnRg4J/GpV2CItVXNowLOcJg3yX8dbSaSvnZpUPFAOjdJNpmzGiIwVsXu/7joHkQdmWt
         R54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ji7iGAxDJEeqfoAnF5QNg6c4bsnLencbEnYiubnXrLA=;
        b=Azc/WLs73RC4JDhinBCKMUZM+xRnhxotFDidyiNJay4nF5Q1onG3E9zZAOYzwLgDPS
         +1WBwXKLaK+73FtoaHeBsP2dqvt097iN5CFdSroJTUJ/DGmxRyk7c6mfggoFj5iOK7wr
         kRpECdFFuaoo5y+VJmHEIRaso9nKcHThlZyLZ+nUPqLstuex/saMuBcrjunb51EGcsgy
         FTQo80HuKSrEWBj6uvY0YuKaySKkfpnUyKO0hVEP6tVIJbLvqxT2mQLX3miDmlcS9f24
         tTIc68cWdIXIQM9JIWdgmZ0Iui7rB0Mng/Hiv+ZqyIxrP/lzp5Q4wjqbYV7uC2JPpdk2
         Ni2w==
X-Gm-Message-State: AOAM532ZiCXe6pIIx1RrDAmxYhu959g5CoqLVcSxFyyQ6igRT6bk5Ckx
        ZALvmuHmgfq2FNZHNs81hDeuzQ+s4svLWUjI
X-Google-Smtp-Source: ABdhPJxSJjOOAhzSDEzao64v+l/uhAIPXHdJ8PsGS98R3R5M2TnclgkKBRK+l6kI9UZIRg/vwC5bbw==
X-Received: by 2002:a1c:448b:: with SMTP id r133mr1554740wma.110.1642619533242;
        Wed, 19 Jan 2022 11:12:13 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ff82:2d59:f05c:6474? ([2a01:e34:ed2f:f020:ff82:2d59:f05c:6474])
        by smtp.googlemail.com with ESMTPSA id o33sm11664320wms.3.2022.01.19.11.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 11:12:12 -0800 (PST)
Subject: Re: [PATCH v3] thermal/core: Clear all mitigation when thermal zone
 is disabled
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>, thara.gopinath@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1641581806-32550-1-git-send-email-quic_manafm@quicinc.com>
 <cf34f77e-587b-7f97-619f-dcbf431332ff@linaro.org>
 <7c29c833-b558-f0ab-83ab-08371785ffd1@quicinc.com>
 <9fb8fb88-73d7-771e-1309-4363907f7c01@quicinc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f8fc0f68-af7e-f009-4b94-fdb301db7019@linaro.org>
Date:   Wed, 19 Jan 2022 20:12:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <9fb8fb88-73d7-771e-1309-4363907f7c01@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Manaf,

On 19/01/2022 20:05, Manaf Meethalavalappu Pallikunhi wrote:
> Hi Rafael/Daniel,
> 
> Could you please check and comment  ?

It is in my todo list, I'll review it before the end of the week.

Regards

  -- Daniel

> On 1/11/2022 2:15 AM, Manaf Meethalavalappu Pallikunhi wrote:
>> Hi Thara,
>>
>> On 1/10/2022 11:25 PM, Thara Gopinath wrote:
>>> Hi Manaf,
>>>
>>> On 1/7/22 1:56 PM, Manaf Meethalavalappu Pallikunhi wrote:
>>>> Whenever a thermal zone is in trip violated state, there is a chance
>>>> that the same thermal zone mode can be disabled either via thermal
>>>> core API or via thermal zone sysfs. Once it is disabled, the framework
>>>> bails out any re-evaluation of thermal zone. It leads to a case where
>>>> if it is already in mitigation state, it will stay the same state
>>>> until it is re-enabled.
>>>>
>>>> To avoid above mentioned issue, on thermal zone disable request
>>>> reset thermal zone and clear mitigation for each trip explicitly.
>>>>
>>>> Signed-off-by: Manaf Meethalavalappu Pallikunhi
>>>> <quic_manafm@quicinc.com>
>>>> ---
>>>>   drivers/thermal/thermal_core.c | 12 ++++++++++--
>>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/thermal_core.c
>>>> b/drivers/thermal/thermal_core.c
>>>> index 51374f4..e288c82 100644
>>>> --- a/drivers/thermal/thermal_core.c
>>>> +++ b/drivers/thermal/thermal_core.c
>>>> @@ -447,10 +447,18 @@ static int thermal_zone_device_set_mode(struct
>>>> thermal_zone_device *tz,
>>>>         thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>>>>   -    if (mode == THERMAL_DEVICE_ENABLED)
>>>> +    if (mode == THERMAL_DEVICE_ENABLED) {
>>>>           thermal_notify_tz_enable(tz->id);
>>>> -    else
>>>> +    } else {
>>>> +        int trip;
>>>> +
>>>> +        /* make sure all previous throttlings are cleared */
>>>> +        thermal_zone_device_init(tz);
>>>
>>> It looks weird to do a init when you are actually disabling the
>>> thermal zone.
>>>
>>>
>>>> +        for (trip = 0; trip < tz->trips; trip++)
>>>> +            handle_thermal_trip(tz, trip);
>>>
>>> So this is exactly what thermal_zone_device_update does except that
>>> thermal_zone_device_update checks for the mode and bails out if the
>>> zone is disabled.
>>> This will work because as you explained in v2, the temperature is
>>> reset in thermal_zone_device_init and handle_thermal_trip will remove
>>> the mitigation if any.
>>>
>>> My two cents here (Rafael and Daniel can comment more on this).
>>>
>>> I think it will be cleaner if we can have a third mode
>>> THERMAL_DEVICE_DISABLING and have thermal_zone_device_update handle
>>> clearing the mitigation. So this will look like
>>> if (mode == THERMAL_DEVICE_DISABLED)
>>>     tz->mode = THERMAL_DEVICE_DISABLING;
>>> else
>>>     tz->mode = mode;
>>>
>>> thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>>>
>>> if (mode == THERMAL_DEVICE_DISABLED)
>>>     tz->mode = mode;
>>>
>>> You will have to update update_temperature to set tz->temperature =
>>> THERMAL_TEMP_INVALID and thermal_zone_set_trips to set
>>> tz->prev_low_trip = -INT_MAX and tz->prev_high_trip = INT_MAX for
>>> THERMAL_DEVICE_DISABLING mode.
>>
>> I think just updating above fields doesn't guarantee complete clearing
>> of mitigation for all governors. For  step_wise governor, to make sure
>> mitigation removed completely, we have to set each
>> thermal-instance->initialized = false as well.
>>
>> If we add that to above list of variables in update_temperature()
>> under if (mode == THERMAL_DEVICE_DISABLING) , it is same as
>> thermal_zone_device_init function does in current patch. We are just
>> resetting same fields in different place under a new mode, right ?
>>
>> Thanks,
>>
>> Manaf
>>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
