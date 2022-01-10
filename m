Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386E548A113
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243854AbiAJUqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:46:04 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:57089 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239763AbiAJUqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641847563; x=1673383563;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o66mVFYLBPliOYwGmHmc8WSTm1KLBStmLgLNs0rcxw4=;
  b=KfvpGt4x6BULEsNu0kLEGlZyb+/VZRItN2WS0CdWFnnpn9rA4Tbca1Dl
   baiM/ceqMoKWT8PPzrR26ibPLZKz2wYnRBbBkpph+jeyn/ayzDRdLSfXI
   iJd2nt6KguWq2BaIOTd3GuPhzWSRdRMCIXQL6XyqKOxycZKanNqNJJAsx
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Jan 2022 12:46:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 12:46:02 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 10 Jan 2022 12:46:01 -0800
Received: from [10.216.6.1] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 10 Jan
 2022 12:45:56 -0800
Message-ID: <7c29c833-b558-f0ab-83ab-08371785ffd1@quicinc.com>
Date:   Tue, 11 Jan 2022 02:15:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] thermal/core: Clear all mitigation when thermal zone
 is disabled
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Amit Kucheria" <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Matthias Kaehlcke" <mka@chromium.org>, <thara.gopinath@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1641581806-32550-1-git-send-email-quic_manafm@quicinc.com>
 <cf34f77e-587b-7f97-619f-dcbf431332ff@linaro.org>
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
In-Reply-To: <cf34f77e-587b-7f97-619f-dcbf431332ff@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thara,

On 1/10/2022 11:25 PM, Thara Gopinath wrote:
> Hi Manaf,
>
> On 1/7/22 1:56 PM, Manaf Meethalavalappu Pallikunhi wrote:
>> Whenever a thermal zone is in trip violated state, there is a chance
>> that the same thermal zone mode can be disabled either via thermal
>> core API or via thermal zone sysfs. Once it is disabled, the framework
>> bails out any re-evaluation of thermal zone. It leads to a case where
>> if it is already in mitigation state, it will stay the same state
>> until it is re-enabled.
>>
>> To avoid above mentioned issue, on thermal zone disable request
>> reset thermal zone and clear mitigation for each trip explicitly.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi 
>> <quic_manafm@quicinc.com>
>> ---
>>   drivers/thermal/thermal_core.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c 
>> b/drivers/thermal/thermal_core.c
>> index 51374f4..e288c82 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -447,10 +447,18 @@ static int thermal_zone_device_set_mode(struct 
>> thermal_zone_device *tz,
>>         thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>>   -    if (mode == THERMAL_DEVICE_ENABLED)
>> +    if (mode == THERMAL_DEVICE_ENABLED) {
>>           thermal_notify_tz_enable(tz->id);
>> -    else
>> +    } else {
>> +        int trip;
>> +
>> +        /* make sure all previous throttlings are cleared */
>> +        thermal_zone_device_init(tz);
>
> It looks weird to do a init when you are actually disabling the 
> thermal zone.
>
>
>> +        for (trip = 0; trip < tz->trips; trip++)
>> +            handle_thermal_trip(tz, trip);
>
> So this is exactly what thermal_zone_device_update does except that 
> thermal_zone_device_update checks for the mode and bails out if the 
> zone is disabled.
> This will work because as you explained in v2, the temperature is 
> reset in thermal_zone_device_init and handle_thermal_trip will remove 
> the mitigation if any.
>
> My two cents here (Rafael and Daniel can comment more on this).
>
> I think it will be cleaner if we can have a third mode 
> THERMAL_DEVICE_DISABLING and have thermal_zone_device_update handle 
> clearing the mitigation. So this will look like
> if (mode == THERMAL_DEVICE_DISABLED)
>     tz->mode = THERMAL_DEVICE_DISABLING;
> else
>     tz->mode = mode;
>
> thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>
> if (mode == THERMAL_DEVICE_DISABLED)
>     tz->mode = mode;
>
> You will have to update update_temperature to set tz->temperature = 
> THERMAL_TEMP_INVALID and thermal_zone_set_trips to set 
> tz->prev_low_trip = -INT_MAX and tz->prev_high_trip = INT_MAX for
> THERMAL_DEVICE_DISABLING mode.

I think just updating above fields doesn't guarantee complete clearing 
of mitigation for all governors. For  step_wise governor, to make sure 
mitigation removed completely, we have to set each 
thermal-instance->initialized = false as well.

If we add that to above list of variables in update_temperature() under 
if (mode == THERMAL_DEVICE_DISABLING) , it is same as 
thermal_zone_device_init function does in current patch. We are just 
resetting same fields in different place under a new mode, right ?

Thanks,

Manaf

