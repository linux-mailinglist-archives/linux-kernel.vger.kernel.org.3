Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F84058CFBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244491AbiHHVdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244374AbiHHVdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:33:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21631B792;
        Mon,  8 Aug 2022 14:33:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g12so9174818pfb.3;
        Mon, 08 Aug 2022 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=rS3Mx8/uZ2d+BgMGOGtvmS/CNUo6wU0+RbWwTqMfR8I=;
        b=WDCv75RRp771BTrXoqCYUYmsK98tI5FHeD3vK8AtBlp07+b9a5FwjIo8VsSqSuRRMi
         1HTbstJmbcsWr5Lk6zNA7l42qj5Mlbkp6xG6WnO+Ug0khtE/pLRXy1M11hRIkWXOSoQa
         Yy57MR/8S0NS9rowud+9Mg//M1aztU3rIf6HyOTIKtnjkbxl75Fj8rkpkKHhf1TZeNAF
         RH8rOzOo0MNU2Fx5pKzs/MfgezRGLNGa6ZM4i12CkUx4StQwYhUbfKCbxHOJvYUXAFw+
         y5IO7YlIENr/PhzT398g/oWyTato2mqiXn4eIyc4dQ15C1wD0zza6q495CmE/Nx+YRoP
         7/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=rS3Mx8/uZ2d+BgMGOGtvmS/CNUo6wU0+RbWwTqMfR8I=;
        b=GI41Hfk3D7DjaAk7uC/nMuDIZHNjstjwYRq2arx5EtVGaNDKrZhyFlnDyRrOqK2LhI
         WtpbE4yTt1jKv49uVBqaDI7IqGyMS/FmB6sdeRHVNQ9BI3eHGdeyAmEP7Cg+quJz6b+B
         3KqQTioidHC0sS/BPlwW1lWKhMW1ITgDnohL++gnSu8oRVmfyLniXJOnbOZ0V4LvUBTW
         qAGr4nw7WPraFsSWniRF19Yd8r1bJfQwPhwtb2igllnNNtN7SWHB+pxZPvOzSNY3A3Nr
         PLd+aE2YoaIsv6o2ITp4PMJW9sCJsxnAtZWWsG8oth/4UyqZ1lA9QbWAvv7cWQ+zPqGi
         6HoQ==
X-Gm-Message-State: ACgBeo2Omn+5R7rySSrsE+gopOttpzk52TMjYJfTJxmMAVpnESi9NUQb
        7QO+r/iCnINipUTShgrobOXMTlUJFJw=
X-Google-Smtp-Source: AA6agR4Q/q2QTvXAEUC14Lyvast2H7Dvne8pF5BOLyeeUrNr9nHEnL523tiqO5tH/lfk6eqYhRXSgw==
X-Received: by 2002:a63:6406:0:b0:41b:f291:2cbf with SMTP id y6-20020a636406000000b0041bf2912cbfmr17518116pgb.96.1659994383453;
        Mon, 08 Aug 2022 14:33:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902eb8d00b0016eef474042sm9057529plg.262.2022.08.08.14.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 14:33:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <593294eb-aecd-2a9c-dc01-1e91b0a00075@roeck-us.net>
Date:   Mon, 8 Aug 2022 14:33:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] thermal/of: Return -ENODEV instead of -EINVAL if
 registration fails
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     michael@walle.cc, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20220808180915.446053-1-daniel.lezcano@linaro.org>
 <20220808180915.446053-2-daniel.lezcano@linaro.org>
 <f8008f05-4e4d-e21f-2e40-e234930ee86e@roeck-us.net>
 <bbd09ad6-db85-5981-a5c1-1dabca1f1b66@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <bbd09ad6-db85-5981-a5c1-1dabca1f1b66@linaro.org>
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

On 8/8/22 13:31, Daniel Lezcano wrote:
> On 08/08/2022 20:35, Guenter Roeck wrote:
>> On 8/8/22 11:09, Daniel Lezcano wrote:
>>> The previous version of the OF code was returning -ENODEV if no
>>> thermal zones description was found or if the lookup of the sensor in
>>> the thermal zones was not found.
>>>
>>> The backend drivers are expecting this return value as an information
>>> about skipping the sensor initialization and considered as normal.
>>>
>>> Fix the return value by replacing -EINVAL by -ENODEV
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>   drivers/thermal/thermal_of.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>>> index 368eb58e97cf..4210c18ef7b2 100644
>>> --- a/drivers/thermal/thermal_of.c
>>> +++ b/drivers/thermal/thermal_of.c
>>> @@ -329,7 +329,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
>>>       np = of_find_node_by_name(NULL, "thermal-zones");
>>>       if (!np) {
>>>           pr_err("Unable to find thermal zones description\n");
>>
>> I really don't like that error message: People will see it (and complain)
>> whenever a sensor registers and there is no thermal zone, even though that
>> is perfectly normal (see description above).
>>
> 
> I agree, I'll change the message to:
> 
>      pr_info("No thermal zones description\n");
> 
> sounds good ?
> 

I think it should be silent or at best pr_debug.

Guenter

>>> -        return ERR_PTR(-EINVAL);
>>> +        return ERR_PTR(-ENODEV);
>>>       }
>>>       /*
>>> @@ -368,7 +368,7 @@ static struct device_node *of_thermal_zone_find(struct device_node *sensor, int
>>>               }
>>>           }
>>>       }
>>> -    tz = ERR_PTR(-EINVAL);
>>> +    tz = ERR_PTR(-ENODEV);
>>>   out:
>>>       of_node_put(np);
>>>       return tz;
>>
> 
> 

