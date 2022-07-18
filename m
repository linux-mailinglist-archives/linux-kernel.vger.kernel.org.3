Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F615784B1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiGROE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiGROE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:04:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B684635E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:04:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bu1so17192706wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/WttLzw94XQkCQWodug0xdDBqbm5qnEWCGk1phYboOA=;
        b=L1ps4mlah3U0D4p1OSfLazp+LQ5WIvllYV6mhGgUoiz60a5DiZPNc0x1mBtg5t3wRP
         hlBCmRuJwxdi1f/BsTGiG2Whlx0DaYX6S8CWObZx90FKG/YTiyXi5ry1wkpiCb/FSKhC
         /5IyzNl6P1/O+Urqklm3DpQ40lnFZKKwu6otsfN8fs3K5HpkY43i6K52irKEUz7/N+zb
         +pWgI03DjiZu3YqbSqr7lpxdeu7pxiDdg7bFG/x7GNmknYVe21TJ/nnoRW04ktKTAnLe
         gPCTm6tLBPQxfNFDP3tNz9kUnyspk3ZlYEBUmeyhQhbX5fxKANvMM+Dli3165c9gr66C
         bfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/WttLzw94XQkCQWodug0xdDBqbm5qnEWCGk1phYboOA=;
        b=P7+VV/84KL40qnghU+XtaFdcmNVqBZxfqjrsxOx4XBWI5cxxYyTkjCMtAVCIjXJF80
         V5OMwyMZw773Hw/Mi6EuyVs8+Pj7XlqEzDSm6vogErifLxpq5SCtnb72ci1Am1yXv/AQ
         7HLsmVv2tpJ66gYUmz1YyRKC7x5G7031IurFZI3fnwKT4byoJDhnR7oLb/tlU8CwUaPT
         ZqzactkHVEG4FaVxvAtpJXhSsesZ/tD/UaIzf5Jb9OwdX4w2v0VyVB+SUMStsxuNYiom
         NhUFMZ3DFeeGcPYVPp1qqaFxK71AwjvDQXTDSTJmlNNxonF4HAFBE6/6SKgLi9fNSCaa
         v1Kg==
X-Gm-Message-State: AJIora/g4rb8tfzb7+iTbXwPkfl/YuNzFyZPySuBKi3HTD8HEUZTkBZT
        ihoEzdSrID1KmEW5riOjlAvlVg==
X-Google-Smtp-Source: AGRyM1usZMBXkhiz17covDRrDryIq/jaFNtFhiNpEqklOOn+jiYIyQyjaUDZ2WsJu8gO7Tov9lzGVw==
X-Received: by 2002:adf:dd0d:0:b0:21d:666b:298e with SMTP id a13-20020adfdd0d000000b0021d666b298emr23410128wrm.412.1658153093631;
        Mon, 18 Jul 2022 07:04:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e? ([2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e])
        by smtp.googlemail.com with ESMTPSA id be9-20020a05600c1e8900b003a30cfb859asm14446695wmb.5.2022.07.18.07.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 07:04:52 -0700 (PDT)
Message-ID: <70a992e3-bf1c-0c33-c122-3c4730ffb232@linaro.org>
Date:   Mon, 18 Jul 2022 16:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/4] thermal/core: Avoid calling ->get_trip_temp()
 unnecessarily
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, amitk@kernel.org, lukasz.luba@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
 <20220715210911.714479-2-daniel.lezcano@linaro.org>
 <aeb6a9d2447a8bbd7d386f88a7f72b33253776c7.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aeb6a9d2447a8bbd7d386f88a7f72b33253776c7.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2022 06:59, Zhang Rui wrote:
> On Fri, 2022-07-15 at 23:09 +0200, Daniel Lezcano wrote:
>> As the trip temperature is already available when calling the
>> function
>> handle_critical_trips(), pass it as a parameter instead of having
>> this
>> function calling the ops again to retrieve the same data.
>>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>    v3:
>>     - Massaged the patch title and the description
>> ---
>>   drivers/thermal/thermal_core.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c
>> b/drivers/thermal/thermal_core.c
>> index d9f771b15ed8..f66036b3daae 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -340,12 +340,8 @@ void thermal_zone_device_critical(struct
>> thermal_zone_device *tz)
>>   EXPORT_SYMBOL(thermal_zone_device_critical);
>>   
>>   static void handle_critical_trips(struct thermal_zone_device *tz,
>> -                                 int trip, enum thermal_trip_type
>> trip_type)
>> +                                 int trip, int trip_temp, enum
>> thermal_trip_type trip_type)
> 
> This indent cleanup belongs to patch 1/4.

It is not an indent cleanup, the 'int trip_temp' is added in the parameters.

> Other than that,
> 
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
