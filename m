Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A735363A9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 15:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352863AbiE0N64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 09:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240514AbiE0N6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:58:53 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024E512AAF;
        Fri, 27 May 2022 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653659933; x=1685195933;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=GF8r/LqGxsImMjC+zviPxuhzQ2c3jmTSmCRe85gniNQ=;
  b=C3Of6hnkQ56S7bWQ7cdTortNPOiWmyrHXfL6fOChe+s7IwPi5IHleIPB
   HRciHQQ1yPTRoU1zVx+7vRKSdpZ9Wsz3K9MD9v/N/jO/ASPhGewFLgPOy
   Ih9ef9P1KP9jQ7XYSvdOl3VReCXiF5/X1gokTSvTAxE+C45WKAGhBVBxI
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 May 2022 06:58:52 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 06:58:52 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 27 May 2022 06:58:51 -0700
Received: from [10.50.53.253] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 27 May
 2022 06:58:49 -0700
Message-ID: <35141cc2-8269-b4c6-8763-6f18c96ea12c@quicinc.com>
Date:   Fri, 27 May 2022 19:28:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 1/2] power_supply: Register cooling device outside of
 probe
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     David Collins <quic_collinsd@quicinc.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@google.com>
References: <1640162489-7847-1-git-send-email-quic_manafm@quicinc.com>
 <029160a5-a7b0-790c-077a-985be5a1d560@quicinc.com>
In-Reply-To: <029160a5-a7b0-790c-077a-985be5a1d560@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

++

On 1/25/2022 1:04 AM, Manaf Meethalavalappu Pallikunhi wrote:
> Hi Sebastian Reichel,
>
> Just reminder for review for these patches
>
> Thanks,
>
> Manaf
>
> On 12/22/2021 2:11 PM, Manaf Meethalavalappu Pallikunhi wrote:
>> Registering the cooling device from the probe can result in the
>> execution of get_property() function before it gets initialized.
>>
>> To avoid this, register the cooling device from a workqueue
>> instead of registering in the probe.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi 
>> <quic_manafm@quicinc.com>
>> ---
>>   drivers/power/supply/power_supply_core.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/power/supply/power_supply_core.c 
>> b/drivers/power/supply/power_supply_core.c
>> index 668369b..ef6f290 100644
>> --- a/drivers/power/supply/power_supply_core.c
>> +++ b/drivers/power/supply/power_supply_core.c
>> @@ -132,6 +132,7 @@ void power_supply_changed(struct power_supply *psy)
>>   }
>>   EXPORT_SYMBOL_GPL(power_supply_changed);
>>   +static int psy_register_cooler(struct power_supply *psy);
>>   /*
>>    * Notify that power supply was registered after parent finished 
>> the probing.
>>    *
>> @@ -139,6 +140,8 @@ EXPORT_SYMBOL_GPL(power_supply_changed);
>>    * calling power_supply_changed() directly from 
>> power_supply_register()
>>    * would lead to execution of get_property() function provided by 
>> the driver
>>    * too early - before the probe ends.
>> + * Also, registering cooling device from the probe will execute the
>> + * get_property() function. So register the cooling device after the 
>> probe.
>>    *
>>    * Avoid that by waiting on parent's mutex.
>>    */
>> @@ -156,6 +159,7 @@ static void 
>> power_supply_deferred_register_work(struct work_struct *work)
>>       }
>>         power_supply_changed(psy);
>> +    psy_register_cooler(psy);
>>         if (psy->dev.parent)
>>           mutex_unlock(&psy->dev.parent->mutex);
>> @@ -1238,10 +1242,6 @@ __power_supply_register(struct device *parent,
>>       if (rc)
>>           goto register_thermal_failed;
>>   -    rc = psy_register_cooler(psy);
>> -    if (rc)
>> -        goto register_cooler_failed;
>> -
>>       rc = power_supply_create_triggers(psy);
>>       if (rc)
>>           goto create_triggers_failed;
>> @@ -1271,8 +1271,6 @@ __power_supply_register(struct device *parent,
>>   add_hwmon_sysfs_failed:
>>       power_supply_remove_triggers(psy);
>>   create_triggers_failed:
>> -    psy_unregister_cooler(psy);
>> -register_cooler_failed:
>>       psy_unregister_thermal(psy);
>>   register_thermal_failed:
>>       device_del(dev);
>>
