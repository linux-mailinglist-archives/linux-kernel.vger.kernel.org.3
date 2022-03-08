Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9774B4D20F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349870AbiCHTIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349852AbiCHTIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:08:45 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC01240B3;
        Tue,  8 Mar 2022 11:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646766467; x=1678302467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Us7q9LMJIjiFf9CRtdPQhiFU1UsJWO+ZNbcGobFxGg=;
  b=Mwt/nMOn4djEg0UaUGkoW6IdtLB+uU/8eiOfsFF+Jd4vdQ3GShQsG+S5
   m+lS3mV+3Fb//RNDPFuOpklVNETjg5XPBbBP1d1uAx9QCvKeAzvj5c+5T
   I3bVgbb9GTzintJ/vNNHnR4yQpFjeb91LLIntcvpbpDVV6WipavxuBjAF
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Mar 2022 11:07:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 11:07:44 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Mar 2022 11:07:44 -0800
Received: from [10.216.46.57] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 8 Mar 2022
 11:07:40 -0800
Message-ID: <27a01b22-1db7-5e5a-212d-092cedfaa50f@quicinc.com>
Date:   Wed, 9 Mar 2022 00:37:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drivers/thermal/thermal_of: Add change_mode ops support
 for thermal_of sensor
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1646752834-25043-1-git-send-email-quic_manafm@quicinc.com>
 <c1a0576b-89fa-6e91-b80e-f2aa20dc7c77@linaro.org>
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
In-Reply-To: <c1a0576b-89fa-6e91-b80e-f2aa20dc7c77@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/2022 11:28 PM, Daniel Lezcano wrote:
> On 08/03/2022 16:20, Manaf Meethalavalappu Pallikunhi wrote:
>> The sensor driver which register through thermal_of interface doesn't
>> have an option to get thermal zone mode change notification from
>> thermal core.
>>
>> Add support for change_mode ops in thermal_of interface so that sensor
>> driver can use this ops for mode change notification.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi 
>> <quic_manafm@quicinc.com>
>> ---
>>   drivers/thermal/thermal_of.c | 14 ++++++++++++++
>>   include/linux/thermal.h      |  3 +++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>> index 9233f7e..a4e3820 100644
>> --- a/drivers/thermal/thermal_of.c
>> +++ b/drivers/thermal/thermal_of.c
>> @@ -203,6 +203,17 @@ static int of_thermal_get_trend(struct 
>> thermal_zone_device *tz, int trip,
>>       return data->ops->get_trend(data->sensor_data, trip, trend);
>>   }
>>   +static int of_thermal_change_mode(struct thermal_zone_device *tz,
>> +                enum thermal_device_mode mode)
>> +{
>> +    struct __thermal_zone *data = tz->devdata;
>> +
>> +    if (!data->ops || !data->ops->change_mode)
>> +        return -EINVAL;
>
>
> If this function is called it is because below in the bind function 
> ops->change_mode was true, so the condition above is always true, no ?

I agree, it is reduntant. I just followed other ops similar sanity 
check. I will remove it in next revision.

I think I missed to clear tzd->ops->change_mode  in 
tz_of_sensor_unregister() path. I will update that as well

>
>
>> +    return data->ops->change_mode(data->sensor_data, mode);
>> +}
>> +
>>   static int of_thermal_bind(struct thermal_zone_device *thermal,
>>                  struct thermal_cooling_device *cdev)
>>   {
>> @@ -408,6 +419,9 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>>       if (ops->set_emul_temp)
>>           tzd->ops->set_emul_temp = of_thermal_set_emul_temp;
>>   +    if (ops->change_mode)
>> +        tzd->ops->change_mode = of_thermal_change_mode;
>> +
>>       mutex_unlock(&tzd->lock);
>>         return tzd;
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index c3148939..365733b 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -299,6 +299,8 @@ struct thermal_zone_params {
>>    *           temperature.
>>    * @set_trip_temp: a pointer to a function that sets the trip 
>> temperature on
>>    *           hardware.
>> + * @change_mode: a pointer to a function that notifies the thermal zone
>> + *           mode change.
>>    */
>>   struct thermal_zone_of_device_ops {
>>       int (*get_temp)(void *, int *);
>> @@ -306,6 +308,7 @@ struct thermal_zone_of_device_ops {
>>       int (*set_trips)(void *, int, int);
>>       int (*set_emul_temp)(void *, int);
>>       int (*set_trip_temp)(void *, int, int);
>> +    int (*change_mode) (void *, enum thermal_device_mode);
>>   };
>>     /* Function declarations */
>
>
