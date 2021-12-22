Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5932247D598
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbhLVRHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhLVRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:07:50 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E17C061574;
        Wed, 22 Dec 2021 09:07:49 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id g11-20020a4a754b000000b002c679a02b18so1020179oof.3;
        Wed, 22 Dec 2021 09:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VOxC90hitMyTuXvblMg9yAHe4TtcUlIgp6x0D9OBaGI=;
        b=ATOLoT/3SZPbvSAsD4ZN/H6utIrJvC89DPfkccE2uaB+35npNE+NdFElVbAJbemzNk
         phSzpgLy9LcNMiSz8eMB4OXByGIOSI6Ch7oKOluZIT4Kl/A5w2s4XZYBdfOERD2nwM4T
         lGebXhQYyNhiQxDr/Tut/jW1KgAdlDxjnikXkkQydrBe73lJQH6ZY7HtUbSyp0jXCs0e
         q4ghKmkCwyypRfgZLo4A6TAISbJsxyEDYtL80Yux5LBAIEx0swfAJ4tPgt1sU5RJVjHH
         PE9ldC15gyUIvUS0xPnXnEKCw3Vnpsb6uMVk66ExJ/PF0sssX4BpIZyCNtkv4bBQJ0yM
         LG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VOxC90hitMyTuXvblMg9yAHe4TtcUlIgp6x0D9OBaGI=;
        b=WGOdGVynxs2Uedx+0u9TbVadQSclSB0yLC+dP4/F0AQ48+6h0TGJAUZ3AvnsRf+b19
         FCOU2SHghL2hcPTbsDgY6gAl5u/zFLS7EIHOFFHFROGFpx63x6yQCmWxjA0r1ayanApi
         WpUXXYVNJhUrdvuUYymkmiUF58dPVEE2oWw/ggMdBsT5ETRw3NH9C0urF47LKlPKmF+Y
         QSSQMICxHcaOd3KZJlGD5t8RMTmGPITE6XU7DiHNugaVBsMPG1N23bWn+nhawtS2zYwD
         K8jVPUiEVpPg7zU8Wk3h5uRXiIwyARw2it2YZFQVlp1DhuncSB+F1lrq4IrRyNGLpxHf
         EO4g==
X-Gm-Message-State: AOAM531HaW7aKlIXMxZ9RWTf69xU9tFbHHs6aaOHvm08Pq22ru23fNGg
        Y3yFm0+O8bw3P6kzIXQKy7fqpdh9p30=
X-Google-Smtp-Source: ABdhPJz3het8XefkHRa6MkEqx+gBbNhog3ICW4VxjtI0CHQeu7ghLPL5QX6Eht9ce9e2HgRraIMC3g==
X-Received: by 2002:a4a:c695:: with SMTP id m21mr2433724ooq.58.1640192868513;
        Wed, 22 Dec 2021 09:07:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10sm466385oor.33.2021.12.22.09.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 09:07:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221215841.2641417-1-demonsingur@gmail.com>
 <20211221215841.2641417-4-demonsingur@gmail.com>
 <ff8b73b0-0c28-e1f3-d254-ea03fb594ffc@roeck-us.net>
 <03bf1d99-5411-daca-bc96-319e30b5e836@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 3/7] hwmon: (adt7x10) Use
 devm_hwmon_device_register_with_info
Message-ID: <792f0265-4c4c-ce71-9a6a-a20d3ee61f41@roeck-us.net>
Date:   Wed, 22 Dec 2021 09:07:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <03bf1d99-5411-daca-bc96-319e30b5e836@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 10:35 PM, Cosmin Tanislav wrote:
> 
> 
> On 12/22/21 05:08, Guenter Roeck wrote:
>> On 12/21/21 1:58 PM, Cosmin Tanislav wrote:
>>> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
>>>
>> [ ... ]
>>
>>> +
>>> +static int adt7x10_read(struct device *dev, enum hwmon_sensor_types type,
>>> +            u32 attr, int channel, long *val)
>>> +{
>>> +    struct adt7x10_data *data = dev_get_drvdata(dev);
>>> +
>>> +    switch (attr) {
>>> +    case hwmon_temp_input:
>>> +        return adt7x10_temp_read(data, 0, val);
>>> +    case hwmon_temp_max:
>>> +        return adt7x10_temp_read(data, 1, val);
>>> +    case hwmon_temp_min:
>>> +        return adt7x10_temp_read(data, 2, val);
>>> +    case hwmon_temp_crit:
>>> +        return adt7x10_temp_read(data, 3, val);
>>
>> Ok, so you want to keep using the internal "index" to indicate the
>> array position in the register cache. I _did_ specifically ask
>> to use defines for index values in this case. You did not explain
>> why you ignored this. So now you'll have to explain 1) why you
>> ignored my request and 2) why you want to keep the code as is.
>>
>> And, _please_, add a To: recipient to your patches. I am getting
>> tired having to handle the fallout.
>>
>> Guenter
> 
> 
> First of all, maybe you should compare the time these patches were
> sent to the time that your reply that "I ignored" was sent.
> I sent the patches before you "specifically asked me to use defines for
> index values in this case".
> 

Maybe it would be beneficial to wait a few minutes to give me time
to review all patches of a series before sending a new series.

> Second of all, this specific place is a 1:1 conversion from the original code. If I change to using defines here, I'll have to change to using
> defines everywhere else in the code, which doesn't seem to be the scope
> of this exact patch. Of course it looks bad, but it looked equally bad

As suggested, you could have dropped the use of 'index' entirely.
Its use was a side effect of the old hwmon API, where extra fields
in sensor attributes were used to separate attributes. Using the
with_info API, that is no longer necessary. You chose to keep that
part of the code, which is fine, but then I am also asking for
changing the hard coded constants to make it easier to understand
the code going forward. This is especially necessary because "index"
now has two meanings: First, it is the sensor channel, as passed
from the hwmon subsystem and, second, it is the index into
the register cache. Those different use cases now need to be
clearly separated, and the best way to do that is to use an enum
or define to indicate the index into the register cache.

... and I specifically asked for that because I got confused
about it while reviewing the code. People looking at the code
at a later time should not have that problem.

> before. I can introduce more following patches that fix some obvious
> non-functional problems with the driver.
> 
> Third of all, why are you so tense? You're making both of our lives
> harder. I understand being an upstream maintainer is hard work, but
> everyone's job is hard work. It's not like I wanted to work on
> refactoring ADT7x10, I just had to so I can later introduce a
> patch that implements debugfs reg access...

I tend to get more tense if people give me extra work, and do so
repeatedly (like sending follow-up patch series tagged as v1 and
with no change log). I am human, after all, Sorry for that.

Guenter
