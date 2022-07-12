Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2EA571ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiGLNG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiGLNG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:06:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEE0B1CEF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:06:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z12so11089080wrq.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lU3R3A+FeDJtWJs7PhdGneGdJ2+vM2VZjpiEtp5grTY=;
        b=ZMfiDEuasVobiKv5Ohs9XmZ7QtNpLP4qfbi/iHo9gMOYn2LhSwigwfjzvGj+EbmFhw
         aZ58dSqXyat45qenKqs8JxIsJ7z8hseky5aaI1RGj1DtXp6W3n8A24FTRmJ9eUoIDNZQ
         bNmDxAV0vu4pl60Z9CwuJRDizNi0yj4+KeATFNzJ96me2CGL64iFiiDvyoIS/1YXoFVm
         iJx8oYfpXmlcOqiryh70NM5MXivRvv911FBZjOX3t0zelkuGBMRjxPB3jvPGcl4eN9O2
         amonjn1YaBUh0zeqOjL40wXg0XpmxOAirgnvBphbeUtPtZkbuIgUt2gCzcHdudXEYJFy
         6EgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lU3R3A+FeDJtWJs7PhdGneGdJ2+vM2VZjpiEtp5grTY=;
        b=XX/Mu9iWX96DOws6WHuNP2fhImbxC7DkynjRI91X8Igz1TGeVNa7BjmNSQQiLb8Vh8
         L4sebFwa9QiM9dU9HydWPl9BI7NUoiZ0AHRApf9uUxqLoXT9844Kgiz2g4/Q05EXkKW6
         +8atQXpw0hGpgfOKMJ3av+27jx1tVrBnrFwJfN1Io7/Eh99rQFr8E9HJGTNp70Btu8C1
         lIS5+xKnGwegBFxDtXJ6hmIjKuaMN+zuki3ch9QjWruYeNQIVeXLvY2m9kadtoAqJ1Xq
         n6bdKpFyay42QEBmYe6b6mkqDaUSAqV6Eqr+X3BhtfrmhcMWEOmhCXbCwWJERkNR0anh
         0Prg==
X-Gm-Message-State: AJIora9GVhvGzyW2HmtMMEpdlcwV4A5VsvKuK61UGik3OJK/Jl/k151q
        Y6oy8BUPLTc4XlhubdyHlzWlpg==
X-Google-Smtp-Source: AGRyM1veNh1SFwFHd4ImrgxzvJoaw3xapybXwj312Gsclhhlcuj+v43yiNWXfZxbqbkHq5TpYqPklA==
X-Received: by 2002:a05:6000:68e:b0:21d:76e3:cc80 with SMTP id bo14-20020a056000068e00b0021d76e3cc80mr22134673wrb.327.1657631181717;
        Tue, 12 Jul 2022 06:06:21 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:da26:64bf:ffc2:b735? ([2a05:6e02:1041:c10:da26:64bf:ffc2:b735])
        by smtp.googlemail.com with ESMTPSA id o14-20020a056000010e00b0021d7ad6b9fdsm8221792wrx.57.2022.07.12.06.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 06:06:21 -0700 (PDT)
Message-ID: <af074493-d342-9439-8d78-c07c5df82203@linaro.org>
Date:   Tue, 12 Jul 2022 15:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] thermal/core: Fix thermal trip cross point
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>, rafael@kernel.org
References: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
 <20220708183210.1334839-3-daniel.lezcano@linaro.org>
 <6ce87fbb-1460-503b-f1f1-8cf53e702cdf@arm.com>
 <2d680cd9-9e97-e06c-55c2-2a3a1504488e@linaro.org>
 <5d513646-a917-b969-b2d2-9d5f4e0e6f4d@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5d513646-a917-b969-b2d2-9d5f4e0e6f4d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 14:40, Lukasz Luba wrote:
> 
> 
> On 7/12/22 13:30, Daniel Lezcano wrote:
>> On 12/07/2022 13:29, Lukasz Luba wrote:
>>
>> [ ... ]
>>
>>>> @@ -511,8 +528,13 @@ void thermal_zone_device_update(struct 
>>>> thermal_zone_device *tz,
>>>>       tz->notify_event = event;
>>>> -    for (count = 0; count < tz->trips; count++)
>>>> -        handle_thermal_trip(tz, count);
>>>> +    if (tz->last_temperature <= tz->temperature) {
>>>> +        for (count = 0; count < tz->trips; count++)
>>>> +            handle_thermal_trip(tz, count);
>>>> +    } else {
>>>> +        for (count = tz->prev_trip; count >= 0; count--)
>>>> +            handle_thermal_trip(tz, count);
>>>> +    }
>>>
>>> In general the code look good. I have one question, though:
>>> Is it always true that these trip points coming from the DT
>>> and parsed in thermal_of_build_thermal_zone() populated by
>>>      for_each_child_of_node(child, gchild) {
>>>           thermal_of_populate_trip(gchild, &tz->trips[i++]);
>>>
>>> are always defined in right order in DT?
>>
>> Hmm, that is a good question. Even if the convention is to put the 
>> trip point in the ascending order, I don't find any documentation 
>> telling it is mandatory. Given that I don't feel particularly 
>> comfortable to assume that is the case.
>>
>> Perhaps, it would make more sense to build a map of indexes telling 
>> the order in the trip points and work with it instead.
>>
>>
> 
> Sounds a reliable way to move forward. Maybe you could just sort in the
> right order those trip points in the thermal_of_build_thermal_zone()
> in an additional patch to this series?
> Than this patch could stay as is, because it looks go

Unfortunately, there is the manual setup as well as the ACPI.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
