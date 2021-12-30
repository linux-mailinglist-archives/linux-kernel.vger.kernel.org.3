Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2A1481F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbhL3SQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:16:24 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:54908 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237082AbhL3SQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640888183; x=1672424183;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RiMVmQ9LOmrelT64K7hBp62RSOIjUTvB8SLq8zRYLEE=;
  b=s0l3JoG3OL8aODXxZtbx97pYOENrwR10XvEQ3Z+GIzbuc0EwN4FHzA3m
   9RbWxS0nmZV2LBqqDbVENeDYOfPOQdbrehCqy9qU64B+d9L9LEQHTQSs0
   gqpx1lD7w3SyuEfm96cem78JF7j092JX6C6YeVqUDUXEClVUsF4YkB23P
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Dec 2021 10:16:23 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 10:16:22 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 30 Dec 2021 10:16:22 -0800
Received: from [10.216.59.167] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 30 Dec
 2021 10:16:17 -0800
Message-ID: <0294025e-6579-f8af-278b-e4a2d2688ec1@quicinc.com>
Date:   Thu, 30 Dec 2021 23:46:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] thermal/core: Clear all mitigation when thermal zone
 is disabled
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1640761407-2028-1-git-send-email-quic_manafm@quicinc.com>
 <CAJZ5v0hApA+fnuRmT_xDdJiqmkGfrfku=8rNG7G_YohGYZm5nw@mail.gmail.com>
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
In-Reply-To: <CAJZ5v0hApA+fnuRmT_xDdJiqmkGfrfku=8rNG7G_YohGYZm5nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/30/2021 9:39 PM, Rafael J. Wysocki wrote:
> On Wed, Dec 29, 2021 at 8:03 AM Manaf Meethalavalappu Pallikunhi
> <quic_manafm@quicinc.com> wrote:
>> Whenever a thermal zone is in trip violated state, there is a chance
>> that the same thermal zone mode can be disabled either via thermal
>> core API or via thermal zone sysfs. Once it is disabled, the framework
>> bails out any re-evaluation of thermal zone. It leads to a case where
>> if it is already in mitigation state, it will stay the same state
>> until it is re-enabled.
> You seem to be arguing that disabling a thermal zone should prevent it
> from throttling anything, which is reasonable, but I'm not sure if the
> change below is sufficient for that.
>
>> To avoid above mentioned issue, on thermal zone disable request
>> reset thermal zone and clear mitigation for each trip explicitly.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
>> ---
>>   drivers/thermal/thermal_core.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 51374f4..5f4e35b 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -427,6 +427,7 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>>                                          enum thermal_device_mode mode)
>>   {
>>          int ret = 0;
>> +       int trip;
> This can be declared in the block in which it is used.
Sure, will update in next patch version
>
>>          mutex_lock(&tz->lock);
>>
>> @@ -449,8 +450,14 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
>>
>>          if (mode == THERMAL_DEVICE_ENABLED)
> The coding style asks for braces here if they are used after the else.
Sure will update in next version
>>                  thermal_notify_tz_enable(tz->id);
>> -       else
>> +       else {
>> +               /* make sure all previous throttlings are cleared */
>> +               thermal_zone_device_init(tz);
>> +               for (trip = 0; trip < tz->trips; trip++)
>> +                       handle_thermal_trip(tz, trip);
> So I'm not sure if this makes the throttling go away in all cases (eg.
> what if the current temperature is still above the given trip at this
> point?).

The thermal_zone_device_init() will reset current temperature with THERMAL_TEMP_INVALID. Then the following API
thandle_thermal_trip() doesn't call get_temp to sensor driver again instead it will use this reset temperature
value for each trip re-evaluation. Hence  for above mentioned case, I think it will clear the throttling
irrespective of what is the actual current temperature at that instant. Otherwise please correct me

May I know is there any other possible cases where throttling will not go away completely ?

>> +
>>                  thermal_notify_tz_disable(tz->id);
>> +       }
>>
>>          return ret;
>>   }
>>
