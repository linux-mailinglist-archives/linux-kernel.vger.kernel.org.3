Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAC949404D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356976AbiASTGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:06:02 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:51598 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356952AbiASTF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642619157; x=1674155157;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=8tpMU1MPfLluRg4b410pi6oF7iQdI0FSUxvs6PPkE9o=;
  b=QbByzD8acXaXWRd622LRwIzWjcVEhgkBwk8Jo2gf4nNLBUWtvNGcDSFQ
   T+pOaXIhP/xQBI8V3klzHVCSTTlN4SZOotYfbJLJkcEUdhXPgc3y5fiXy
   FZ3fng4HcBJuyKPL1bih9LIDsqjnMq99dwkHXc8T4N4CBvk5YpF3YBcEa
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 19 Jan 2022 11:05:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 11:05:53 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 19 Jan 2022 11:05:54 -0800
Received: from [10.216.15.20] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 19 Jan
 2022 11:05:47 -0800
Message-ID: <9fb8fb88-73d7-771e-1309-4363907f7c01@quicinc.com>
Date:   Thu, 20 Jan 2022 00:35:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] thermal/core: Clear all mitigation when thermal zone
 is disabled
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Amit Kucheria" <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Matthias Kaehlcke" <mka@chromium.org>, <thara.gopinath@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1641581806-32550-1-git-send-email-quic_manafm@quicinc.com>
 <cf34f77e-587b-7f97-619f-dcbf431332ff@linaro.org>
 <7c29c833-b558-f0ab-83ab-08371785ffd1@quicinc.com>
In-Reply-To: <7c29c833-b558-f0ab-83ab-08371785ffd1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael/Daniel,

Could you please check and comment  ?

Thanks,

Manaf

On 1/11/2022 2:15 AM, Manaf Meethalavalappu Pallikunhi wrote:
> Hi Thara,
>
> On 1/10/2022 11:25 PM, Thara Gopinath wrote:
>> Hi Manaf,
>>
>> On 1/7/22 1:56 PM, Manaf Meethalavalappu Pallikunhi wrote:
>>> Whenever a thermal zone is in trip violated state, there is a chance
>>> that the same thermal zone mode can be disabled either via thermal
>>> core API or via thermal zone sysfs. Once it is disabled, the framework
>>> bails out any re-evaluation of thermal zone. It leads to a case where
>>> if it is already in mitigation state, it will stay the same state
>>> until it is re-enabled.
>>>
>>> To avoid above mentioned issue, on thermal zone disable request
>>> reset thermal zone and clear mitigation for each trip explicitly.
>>>
>>> Signed-off-by: Manaf Meethalavalappu Pallikunhi 
>>> <quic_manafm@quicinc.com>
>>> ---
>>>   drivers/thermal/thermal_core.c | 12 ++++++++++--
>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/thermal_core.c 
>>> b/drivers/thermal/thermal_core.c
>>> index 51374f4..e288c82 100644
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -447,10 +447,18 @@ static int thermal_zone_device_set_mode(struct 
>>> thermal_zone_device *tz,
>>>         thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>>>   -    if (mode == THERMAL_DEVICE_ENABLED)
>>> +    if (mode == THERMAL_DEVICE_ENABLED) {
>>>           thermal_notify_tz_enable(tz->id);
>>> -    else
>>> +    } else {
>>> +        int trip;
>>> +
>>> +        /* make sure all previous throttlings are cleared */
>>> +        thermal_zone_device_init(tz);
>>
>> It looks weird to do a init when you are actually disabling the 
>> thermal zone.
>>
>>
>>> +        for (trip = 0; trip < tz->trips; trip++)
>>> +            handle_thermal_trip(tz, trip);
>>
>> So this is exactly what thermal_zone_device_update does except that 
>> thermal_zone_device_update checks for the mode and bails out if the 
>> zone is disabled.
>> This will work because as you explained in v2, the temperature is 
>> reset in thermal_zone_device_init and handle_thermal_trip will remove 
>> the mitigation if any.
>>
>> My two cents here (Rafael and Daniel can comment more on this).
>>
>> I think it will be cleaner if we can have a third mode 
>> THERMAL_DEVICE_DISABLING and have thermal_zone_device_update handle 
>> clearing the mitigation. So this will look like
>> if (mode == THERMAL_DEVICE_DISABLED)
>>     tz->mode = THERMAL_DEVICE_DISABLING;
>> else
>>     tz->mode = mode;
>>
>> thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>>
>> if (mode == THERMAL_DEVICE_DISABLED)
>>     tz->mode = mode;
>>
>> You will have to update update_temperature to set tz->temperature = 
>> THERMAL_TEMP_INVALID and thermal_zone_set_trips to set 
>> tz->prev_low_trip = -INT_MAX and tz->prev_high_trip = INT_MAX for
>> THERMAL_DEVICE_DISABLING mode.
>
> I think just updating above fields doesn't guarantee complete clearing 
> of mitigation for all governors. For  step_wise governor, to make sure 
> mitigation removed completely, we have to set each 
> thermal-instance->initialized = false as well.
>
> If we add that to above list of variables in update_temperature() 
> under if (mode == THERMAL_DEVICE_DISABLING) , it is same as 
> thermal_zone_device_init function does in current patch. We are just 
> resetting same fields in different place under a new mode, right ?
>
> Thanks,
>
> Manaf
>
