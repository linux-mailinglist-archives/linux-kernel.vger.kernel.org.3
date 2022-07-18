Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B214578398
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiGRNVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbiGRNVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:21:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE2A248E0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:21:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d16so16988103wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=q5w09ckeGgEvgHwxmxmc3ezqZGQDYExZynBvXnLIt8E=;
        b=Jvw9Klhi275DuZ9tfIlA+0LOiDjcu4UC/lQXpku3IUYsCJcdQRc2yjejIMCUi/tMmW
         MVaI3dFPVAxTn911Zi6stVQadx1r0FgkmgKUhm5sXh0xa6v1wNNDVCDYr3PhdRDVqcXs
         kX3/9so11EWGonn7ZJyol1ezeYbYL4ICmZt6wOFDyRVOjfTYJdun000KEazDXOreeKdR
         Byxkidt2r8nvpMd4do4vkia8lTNb7UcD9T0aeDvm/wiA/JoTEzGupd3eVCNWIsiIvOBT
         aOj50A27mZH5IdYJ1DKYt1oPVWl7bZigyXAuTm/DC/tXwc/zJ/a77nX3/FDFq8TK3t02
         7LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q5w09ckeGgEvgHwxmxmc3ezqZGQDYExZynBvXnLIt8E=;
        b=pTOd9am0cN9HVE4i/gOJQqgecK4r/66STlMzaPRPKDwzLTXpdrv/VDZhNDrfRVQWZi
         C5R30NhHDDGGMgHLnwz117qzezwvmcMfFGRwm9Tck5VxRT/drW0OkRixD9GiTgysDBuQ
         mZOw1y+f25mHFvc9WKyFt+WwJyd6J5ZUd2UPMa9r+jrQSgnajU1uwWicxZvJ2mU+FTbR
         Eme2B8pwDkeevWC6M5rjxNyl4AhoiwieyjhvqqCIn6TSMcittb8B4kU9ELNAUcH7AqKZ
         GP0y81N5SrQX4PkeiAQ49qt3cKVGEb+XgNh8CfaFEctfg/LPojRt0wr7cQW78K32OiSJ
         xMIQ==
X-Gm-Message-State: AJIora9Jz+O/mH+bkr8KYhBAVsnTTcE8BgSChjBR0TD4lpwu6V0jBOhb
        DaOdl8yQ2Uz/FrD5pqZsy1TUWw==
X-Google-Smtp-Source: AGRyM1tk/pPv7/XveZl11s7JDIiES5VnzaW5an5ZDKMfD/k7nS/W8eSDip40/dfligRm1fRO3UAxRQ==
X-Received: by 2002:adf:d1c8:0:b0:21d:a082:9290 with SMTP id b8-20020adfd1c8000000b0021da0829290mr23641028wrd.246.1658150491428;
        Mon, 18 Jul 2022 06:21:31 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e? ([2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e])
        by smtp.googlemail.com with ESMTPSA id f9-20020a05600c4e8900b003a31fd05e0fsm2491063wmq.2.2022.07.18.06.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 06:21:30 -0700 (PDT)
Message-ID: <04bd27a8-5148-c8eb-5687-83ef511618df@linaro.org>
Date:   Mon, 18 Jul 2022 15:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/4] thermal/core: Build ascending ordered indexes for
 the trip points
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
Cc:     quic_manafm@quicinc.com, amitk@kernel.org, lukasz.luba@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
 <20220715210911.714479-3-daniel.lezcano@linaro.org>
 <6d08939a167870ff7c1c83bb254fda5939f1d648.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6d08939a167870ff7c1c83bb254fda5939f1d648.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Zhang,

thanks for the review

On 18/07/2022 07:28, Zhang Rui wrote:
> On Fri, 2022-07-15 at 23:09 +0200, Daniel Lezcano wrote:

[ ... ]

>> Instead of taking the risk of breaking the existing platforms, use an
>> array of temperature ordered trip identifiers and make it available
>> for the code needing to browse the trip points in an ordered way.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>> +static void sort_trips_indexes(struct thermal_zone_device *tz)
>> +{
>> +       int i, j;
>> +
>> +       for (i = 0; i < tz->trips; i++)
>> +               tz->trips_indexes[i] = i;
>> +
>> +       for (i = 0; i < tz->trips; i++) {
>> +               for (j = i + 1; j < tz->trips; j++) {
>> +                       int t1, t2;
>> +
>> +                       tz->ops->get_trip_temp(tz, tz-
>>> trips_indexes[i], &t1);
> 
> This line can be moved to the upper loop.

Right, thanks!

>> +                       tz->ops->get_trip_temp(tz, tz-
>>> trips_indexes[j], &t2);
>> +
> 
> what about the disabled trip points?
> 
> we should ignore those trip points and check the return value to make
> sure we're comparing the valid trip_temp values.

We don't have to care about, whatever the position, the corresponding 
trip id will be disabled by the trip init function before calling this 
one and ignored in the handle_thermal_trip() function


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
