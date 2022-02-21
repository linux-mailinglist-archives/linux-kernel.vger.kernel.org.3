Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732394BE50A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379104AbiBUP0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:26:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379165AbiBUPZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:25:53 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF422183F;
        Mon, 21 Feb 2022 07:25:30 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id v10so32885695qvk.7;
        Mon, 21 Feb 2022 07:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ukjWUqaZt3+eoNsRHcVB7snMzKbwCuF6mFtYkqxmZ+w=;
        b=AZvCNBBYZjkTIx5jboOTn+ceGrwYKyT4nZ5iSb7DyPc9U5qMp0i11bZrpz19YMU/MF
         O6Vo9mmajkJxvslVISnbXxMDIA8GGtU79YLKgz0MnWKBPRzcEZlfOZw0vfj2SNgVknY7
         cOXy4KCFu1NHzDzOPEtO3e6HkAnMrDG5KtKLah7q3nuU8K+ZTwqCYqcE3uCGihFE9vqX
         8epQ8deSoVHQTZY89snDKKsTRgqCwRZf0tIeA0afsaxWxTbSPOjCUSeeDrFfbLLJuZ+P
         QJ+oMW6DkTFTWUIhxEsmv73mjMwIjYYVITL5M40PyuhmBayqWyVv0Wl0u6cxCtXroiRe
         OsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ukjWUqaZt3+eoNsRHcVB7snMzKbwCuF6mFtYkqxmZ+w=;
        b=TCmU66uAFFG95BkO+OUo8BJbygVni2JVP9YNJ/Aqhn5rY9JesWPpY8ONhrr3GT5JjN
         uctnpSpwJKRp4fI57yGqIOpK3HPxfBWEdNkTFuQOA7i0CgsfHLbngxZrsej4O0+cp+Vj
         AlLbT/5sSGpC/1astx/sMSWwv5B/ZaZknvbA0o1uYP88HRCtmOdtwuUCUnaXojW9ZHr7
         u4AnAKkmq5YIxCwTpxY7xIX+6HW2KI8oqScoNL8mobYNp3naTQlYQUPMFCnnSRShK4B6
         DLLfQCo1f5q6aI5JY7ayGVD3jUeGw0ICuHtHNcVWm7FqGRONs7CvCsL8zBMXRi8kHS1r
         YkPw==
X-Gm-Message-State: AOAM5325UuMr2hbox1hwvTCmhSwap0tdFqqzx+EMkd5focnE8GqEY3YM
        FOevmQ30JAmc0BusIaysDQM=
X-Google-Smtp-Source: ABdhPJxuO2DSy2ULLdq/c/JMRUqXKUObiKD2ugSfuXgHZEjXyyNAIK3y2vXEU7JRQ2dxAs20bGoWxg==
X-Received: by 2002:ac8:5a4f:0:b0:2dd:e0d4:a4f1 with SMTP id o15-20020ac85a4f000000b002dde0d4a4f1mr8825807qta.478.1645457129220;
        Mon, 21 Feb 2022 07:25:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t18sm30430655qta.90.2022.02.21.07.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 07:25:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <143c0449-8ce6-2179-1391-b3e3160b9846@roeck-us.net>
Date:   Mon, 21 Feb 2022 07:25:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
Content-Language: en-US
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
 <8d0c818a-d714-d8ab-f825-073cf549b959@gmail.com>
 <13b07bb3-90e4-a501-469c-ce64bc90bfd5@nvidia.com>
 <4c12cab4-6265-78c0-46ce-d4014c9919fe@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <4c12cab4-6265-78c0-46ce-d4014c9919fe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 04:59, Dmitry Osipenko wrote:
> 21.02.2022 15:56, Jon Hunter пишет:
>>
>> On 21/02/2022 12:36, Dmitry Osipenko wrote:
>>> 21.02.2022 15:01, Jon Hunter пишет:
>>>> Hi Dmitry,
>>>>
>>>> On 18/06/2021 22:54, Dmitry Osipenko wrote:
>>>>> Use hwmon_notify_event() to notify userspace and thermal core about
>>>>> temperature changes.
>>>>>
>>>>> Suggested-by: Guenter Roeck <linux@roeck-us.net>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>     drivers/hwmon/lm90.c | 44
>>>>> +++++++++++++++++++++++++++++++++-----------
>>>>>     1 file changed, 33 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>>>>> index 2e057fad05b4..e7b678a40b39 100644
>>>>> --- a/drivers/hwmon/lm90.c
>>>>> +++ b/drivers/hwmon/lm90.c
>>>>> @@ -465,6 +465,7 @@ enum lm90_temp11_reg_index {
>>>>>       struct lm90_data {
>>>>>         struct i2c_client *client;
>>>>> +    struct device *hwmon_dev;
>>>>>         u32 channel_config[4];
>>>>>         struct hwmon_channel_info temp_info;
>>>>>         const struct hwmon_channel_info *info[3];
>>>>> @@ -1731,22 +1732,41 @@ static bool lm90_is_tripped(struct i2c_client
>>>>> *client, u16 *status)
>>>>>           if ((st & (LM90_STATUS_LLOW | LM90_STATUS_LHIGH |
>>>>> LM90_STATUS_LTHRM)) ||
>>>>>             (st2 & MAX6696_STATUS2_LOT2))
>>>>> -        dev_warn(&client->dev,
>>>>> -             "temp%d out of range, please check!\n", 1);
>>>>> +        dev_dbg(&client->dev,
>>>>> +            "temp%d out of range, please check!\n", 1);
>>>>>         if ((st & (LM90_STATUS_RLOW | LM90_STATUS_RHIGH |
>>>>> LM90_STATUS_RTHRM)) ||
>>>>>             (st2 & MAX6696_STATUS2_ROT2))
>>>>> -        dev_warn(&client->dev,
>>>>> -             "temp%d out of range, please check!\n", 2);
>>>>> +        dev_dbg(&client->dev,
>>>>> +            "temp%d out of range, please check!\n", 2);
>>>>>         if (st & LM90_STATUS_ROPEN)
>>>>> -        dev_warn(&client->dev,
>>>>> -             "temp%d diode open, please check!\n", 2);
>>>>> +        dev_dbg(&client->dev,
>>>>> +            "temp%d diode open, please check!\n", 2);
>>>>>         if (st2 & (MAX6696_STATUS2_R2LOW | MAX6696_STATUS2_R2HIGH |
>>>>>                MAX6696_STATUS2_R2THRM | MAX6696_STATUS2_R2OT2))
>>>>> -        dev_warn(&client->dev,
>>>>> -             "temp%d out of range, please check!\n", 3);
>>>>> +        dev_dbg(&client->dev,
>>>>> +            "temp%d out of range, please check!\n", 3);
>>>>>         if (st2 & MAX6696_STATUS2_R2OPEN)
>>>>> -        dev_warn(&client->dev,
>>>>> -             "temp%d diode open, please check!\n", 3);
>>>>> +        dev_dbg(&client->dev,
>>>>> +            "temp%d diode open, please check!\n", 3);
>>>>> +
>>>>> +    if (st & LM90_STATUS_LLOW)
>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>> +                   hwmon_temp_min, 0);
>>>>> +    if (st & LM90_STATUS_RLOW)
>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>> +                   hwmon_temp_min, 1);
>>>>> +    if (st2 & MAX6696_STATUS2_R2LOW)
>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>> +                   hwmon_temp_min, 2);
>>>>> +    if (st & LM90_STATUS_LHIGH)
>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>> +                   hwmon_temp_max, 0);
>>>>> +    if (st & LM90_STATUS_RHIGH)
>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>> +                   hwmon_temp_max, 1);
>>>>> +    if (st2 & MAX6696_STATUS2_R2HIGH)
>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>> +                   hwmon_temp_max, 2);
>>>>
>>>>
>>>> We observed a random null pointer deference crash somewhere in the
>>>> thermal core (crash log below is not very helpful) when calling
>>>> mutex_lock(). It looks like we get an interrupt when this crash
>>>> happens.
>>>>
>>>> Looking at the lm90 driver, per the above, I now see we are calling
>>>> hwmon_notify_event() from the lm90 interrupt handler. Looking at
>>>> hwmon_notify_event() I see that ...
>>>>
>>>> hwmon_notify_event()
>>>>     --> hwmon_thermal_notify()
>>>>       --> thermal_zone_device_update()
>>>>         --> update_temperature()
>>>>           --> mutex_lock()
>>>>
>>>> So although I don't completely understand the crash, it does seem
>>>> that we should not be calling hwmon_notify_event() from the
>>>> interrupt handler.
>>>>
>>>> BTW I have not reproduced this myself yet, so I have just been
>>>> reviewing the code to try and understand this.
>>>
>>> Matt Merhar was experiencing a similar issue on T30 Ouya, but I never
>>> managed to reproduce it on Nexus 7 and Acer A500 tablets, and couldn't
>>> spot any problem in the code. IIRC, it was a NULL dereference of another
>>> pointer within that code.
>>
>>
>> OK. From looking at the above I don't think we can call
>> hwmon_notify_event() from an interrupt handler because this is going to
>> try and request a mutex. So we need to fix that.
> 
> The interrupt is threaded, so it can take a mutex.

Exactly. The problem is elsewhere.

Guenter
