Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A59849B7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347131AbiAYPus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:50:48 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:46500 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582494AbiAYPs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643125739; x=1674661739;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uuU7P40JMh4ZEKpl+/QMPGzxGUUPCLs+4G9cP3BtI2U=;
  b=f1li3HJFgUxgMB+frFACGtcVeOnZmUUBMgWNcs1Ig0wblm9egzrJl1vX
   EUEGJjc/7141J5gQDKrLqfVcvc58r0/1yX0M9AaoO/bpuIddcGfkiFuE3
   5ZsRxDk9zvmEgIjH5j7c0YUxcPNd0lCEdx8ufwVxhd4oCJPX6muFmpdzI
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Jan 2022 07:48:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 07:48:54 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 25 Jan 2022 07:48:53 -0800
Received: from [10.216.12.29] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 25 Jan
 2022 07:48:47 -0800
Message-ID: <d0ecfe37-b8f8-c6f8-49d7-0bdbc2bde47e@quicinc.com>
Date:   Tue, 25 Jan 2022 21:18:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] thermal/core: Clear all mitigation when thermal zone
 is disabled
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "thara.gopinath@linaro.org" <thara.gopinath@linaro.org>,
        "mka@chromium.org" <mka@chromium.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1641581806-32550-1-git-send-email-quic_manafm@quicinc.com>
 <927aca29-fca7-bdf9-9ad6-2599125ca1b4@linaro.org>
 <ab6134bd1ca7f7fd8cedad90c1bbb81f642ac647.camel@intel.com>
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
In-Reply-To: <ab6134bd1ca7f7fd8cedad90c1bbb81f642ac647.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Daniel,

On 1/24/2022 6:35 AM, Pandruvada, Srinivas wrote:
> On Sun, 2022-01-23 at 21:51 +0100, Daniel Lezcano wrote:
>> Hi Manaf,
>>
>> semantically speaking disabling a thermal zone would be to detach the
>> thermal zone from its governor and stop the monitoring.
>>
>> May be add the functions
>>
>>   - thermal_governor_attach(struct thermal_zone_device *tzd)
>>     {
>>          ...
>>          if (tz->governor && tz->governor->bind_to_tz) {
>>                  if (tz->governor->bind_to_tz(tz)) {
>>          }
>>          ...
>>     }
>>
>>   - thermal_governor_detach(struct thermal_zone_device *tzd)
>>     {
>>          ...
>>          if (tz->governor && tz->governor->unbind_from_tz)
>>                  tz->governor->unbind_from_tz(tz);
>>          ...
>>     }
>>
>> And add in the step_wise and power_allocator the reset of the
>> governor's
>> data as well as the cooling device instances in the unbind_from_tz()
>> callback
>>
>> Then, thermal_zone_device_enable() attaches and
>> thermal_zone_device_disable() detaches the governor.
>>
>> Does it make sense ?
> This is better.
>
> Thanks,
> Srinivas
Yes, it makes sense. I will update it in v4
>
>>
>> On 07/01/2022 19:56, Manaf Meethalavalappu Pallikunhi wrote:
>>> Whenever a thermal zone is in trip violated state, there is a
>>> chance
>>> that the same thermal zone mode can be disabled either via thermal
>>> core API or via thermal zone sysfs. Once it is disabled, the
>>> framework
>>> bails out any re-evaluation of thermal zone. It leads to a case
>>> where
>>> if it is already in mitigation state, it will stay the same state
>>> until it is re-enabled.
>>>
>>> To avoid above mentioned issue, on thermal zone disable request
>>> reset thermal zone and clear mitigation for each trip explicitly.
>>>
>>> Signed-off-by: Manaf Meethalavalappu Pallikunhi
>>> <quic_manafm@quicinc.com>
>>> ---
>>>   drivers/thermal/thermal_core.c | 12 ++++++++++--
>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/thermal_core.c
>>> b/drivers/thermal/thermal_core.c
>>> index 51374f4..e288c82 100644
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -447,10 +447,18 @@ static int
>>> thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>>>   
>>>          thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>>>   
>>> -       if (mode == THERMAL_DEVICE_ENABLED)
>>> +       if (mode == THERMAL_DEVICE_ENABLED) {
>>>                  thermal_notify_tz_enable(tz->id);
>>> -       else
>>> +       } else {
>>> +               int trip;
>>> +
>>> +               /* make sure all previous throttlings are cleared
>>> */
>>> +               thermal_zone_device_init(tz);
>>> +               for (trip = 0; trip < tz->trips; trip++)
>>> +                       handle_thermal_trip(tz, trip);
>>> +
>>>                  thermal_notify_tz_disable(tz->id);
>>> +       }
>>>   
>>>          return ret;
>>>   }
>>>
>>
