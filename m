Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC6F4BE81C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358448AbiBUM7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:59:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358452AbiBUM7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:59:33 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FA11EADE;
        Mon, 21 Feb 2022 04:59:08 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id j7so18473968lfu.6;
        Mon, 21 Feb 2022 04:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6QVIzj/QKTBf3Ax92LA0XrnaBxugELYFmeGg6xhiMRU=;
        b=LOtBKCSjh69IiZ8cVDisWRXHNKzBkfGKRzGWQZWNELkYMqrnf6ZOqsNSrHm0+26ALv
         A7Ju8T6BVhkmvkXb3KjXPZwp2HwgfTCpkViUIAnJ090bvbYfK8NNTgiqyU/+QN54uWBM
         4bWJDV5ttFRGs+bPlVn99eZRQssSszzCuDqNRnIYmNGTNxmSjA18/Gpwy7ZMkVD1OP+1
         sk6Vf6CatMXTaDlPTfM0HygLJwa6tjiPCqgKu+eXgOilsZTdo8Xav12OmAgBOGvF/9CW
         ftMR4TrtvftFEvK/TSNV+AwvkUaSQOngfDuukyDeDKEknp6m/U1rdfCatZAkV62Q7dAm
         WsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6QVIzj/QKTBf3Ax92LA0XrnaBxugELYFmeGg6xhiMRU=;
        b=P74Qfd7DjdDryDtw5Y3MqdrgDhHMmFqch0CqWTbqe6IToik2C75pwDjAqZ6QDRghH6
         umn4b1kSEx2HEtL/LtseChbVMYOiYRSYvunNeG96zLcmolfsZy0/ryiE+MlWzNu8gB0v
         QTL0lnT7kWzSVxkZ+jdKUGrOK0XFY6WI7aLlMtWADjl4oqbhSZ53q9KldnHhadDJc658
         2nZcIHLmEcmwmVFEWyGrzxU/24f7JjMWKmshcwHtStwEggeV26lbQ7spjM2I4c3eXpYj
         Bq6/i7aNz19cDWOu37rp+VirwbrEbmQ7yEyPLtV5o1W4i8vITZo8DT+8/ZfT5Gzx0tNY
         aYzA==
X-Gm-Message-State: AOAM532kjEP5bGhMw0mtbWxYpLeHWgyQlnPpQUH7La6ww0cmy8rqHETg
        lrleYcRHrWXFTb4Fcwt+hl4=
X-Google-Smtp-Source: ABdhPJz0q8FLvZq4rS2pRaJDajF4cYv2YkHRkuXUyrJHeDxhtWrjb45ADkN4VVNTt9S4H9K7/Hm60A==
X-Received: by 2002:ac2:4c10:0:b0:444:8c:e717 with SMTP id t16-20020ac24c10000000b00444008ce717mr192313lfq.117.1645448347154;
        Mon, 21 Feb 2022 04:59:07 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id y10sm1328964lja.25.2022.02.21.04.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 04:59:06 -0800 (PST)
Message-ID: <4c12cab4-6265-78c0-46ce-d4014c9919fe@gmail.com>
Date:   Mon, 21 Feb 2022 15:59:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
 <8d0c818a-d714-d8ab-f825-073cf549b959@gmail.com>
 <13b07bb3-90e4-a501-469c-ce64bc90bfd5@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <13b07bb3-90e4-a501-469c-ce64bc90bfd5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.02.2022 15:56, Jon Hunter пишет:
> 
> On 21/02/2022 12:36, Dmitry Osipenko wrote:
>> 21.02.2022 15:01, Jon Hunter пишет:
>>> Hi Dmitry,
>>>
>>> On 18/06/2021 22:54, Dmitry Osipenko wrote:
>>>> Use hwmon_notify_event() to notify userspace and thermal core about
>>>> temperature changes.
>>>>
>>>> Suggested-by: Guenter Roeck <linux@roeck-us.net>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>    drivers/hwmon/lm90.c | 44
>>>> +++++++++++++++++++++++++++++++++-----------
>>>>    1 file changed, 33 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>>>> index 2e057fad05b4..e7b678a40b39 100644
>>>> --- a/drivers/hwmon/lm90.c
>>>> +++ b/drivers/hwmon/lm90.c
>>>> @@ -465,6 +465,7 @@ enum lm90_temp11_reg_index {
>>>>      struct lm90_data {
>>>>        struct i2c_client *client;
>>>> +    struct device *hwmon_dev;
>>>>        u32 channel_config[4];
>>>>        struct hwmon_channel_info temp_info;
>>>>        const struct hwmon_channel_info *info[3];
>>>> @@ -1731,22 +1732,41 @@ static bool lm90_is_tripped(struct i2c_client
>>>> *client, u16 *status)
>>>>          if ((st & (LM90_STATUS_LLOW | LM90_STATUS_LHIGH |
>>>> LM90_STATUS_LTHRM)) ||
>>>>            (st2 & MAX6696_STATUS2_LOT2))
>>>> -        dev_warn(&client->dev,
>>>> -             "temp%d out of range, please check!\n", 1);
>>>> +        dev_dbg(&client->dev,
>>>> +            "temp%d out of range, please check!\n", 1);
>>>>        if ((st & (LM90_STATUS_RLOW | LM90_STATUS_RHIGH |
>>>> LM90_STATUS_RTHRM)) ||
>>>>            (st2 & MAX6696_STATUS2_ROT2))
>>>> -        dev_warn(&client->dev,
>>>> -             "temp%d out of range, please check!\n", 2);
>>>> +        dev_dbg(&client->dev,
>>>> +            "temp%d out of range, please check!\n", 2);
>>>>        if (st & LM90_STATUS_ROPEN)
>>>> -        dev_warn(&client->dev,
>>>> -             "temp%d diode open, please check!\n", 2);
>>>> +        dev_dbg(&client->dev,
>>>> +            "temp%d diode open, please check!\n", 2);
>>>>        if (st2 & (MAX6696_STATUS2_R2LOW | MAX6696_STATUS2_R2HIGH |
>>>>               MAX6696_STATUS2_R2THRM | MAX6696_STATUS2_R2OT2))
>>>> -        dev_warn(&client->dev,
>>>> -             "temp%d out of range, please check!\n", 3);
>>>> +        dev_dbg(&client->dev,
>>>> +            "temp%d out of range, please check!\n", 3);
>>>>        if (st2 & MAX6696_STATUS2_R2OPEN)
>>>> -        dev_warn(&client->dev,
>>>> -             "temp%d diode open, please check!\n", 3);
>>>> +        dev_dbg(&client->dev,
>>>> +            "temp%d diode open, please check!\n", 3);
>>>> +
>>>> +    if (st & LM90_STATUS_LLOW)
>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>> +                   hwmon_temp_min, 0);
>>>> +    if (st & LM90_STATUS_RLOW)
>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>> +                   hwmon_temp_min, 1);
>>>> +    if (st2 & MAX6696_STATUS2_R2LOW)
>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>> +                   hwmon_temp_min, 2);
>>>> +    if (st & LM90_STATUS_LHIGH)
>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>> +                   hwmon_temp_max, 0);
>>>> +    if (st & LM90_STATUS_RHIGH)
>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>> +                   hwmon_temp_max, 1);
>>>> +    if (st2 & MAX6696_STATUS2_R2HIGH)
>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>> +                   hwmon_temp_max, 2);
>>>
>>>
>>> We observed a random null pointer deference crash somewhere in the
>>> thermal core (crash log below is not very helpful) when calling
>>> mutex_lock(). It looks like we get an interrupt when this crash
>>> happens.
>>>
>>> Looking at the lm90 driver, per the above, I now see we are calling
>>> hwmon_notify_event() from the lm90 interrupt handler. Looking at
>>> hwmon_notify_event() I see that ...
>>>
>>> hwmon_notify_event()
>>>    --> hwmon_thermal_notify()
>>>      --> thermal_zone_device_update()
>>>        --> update_temperature()
>>>          --> mutex_lock()
>>>
>>> So although I don't completely understand the crash, it does seem
>>> that we should not be calling hwmon_notify_event() from the
>>> interrupt handler.
>>>
>>> BTW I have not reproduced this myself yet, so I have just been
>>> reviewing the code to try and understand this.
>>
>> Matt Merhar was experiencing a similar issue on T30 Ouya, but I never
>> managed to reproduce it on Nexus 7 and Acer A500 tablets, and couldn't
>> spot any problem in the code. IIRC, it was a NULL dereference of another
>> pointer within that code.
> 
> 
> OK. From looking at the above I don't think we can call
> hwmon_notify_event() from an interrupt handler because this is going to
> try and request a mutex. So we need to fix that.

The interrupt is threaded, so it can take a mutex.
