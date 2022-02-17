Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB04B9C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbiBQJ7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:59:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbiBQJ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:59:30 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597245F56
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:59:16 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id k1so7990155wrd.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 01:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xZlo/aob1wQ1ZSgYV63PX8q9CXH4pQq9F49K4TeXUXw=;
        b=GEns6dn/YbDEzl3bRSfaT+gisuZkkud+dTQxuIVa6g8u70lM1pOC35pnNo8mj1W9RM
         8jNwkADAGmiyi/A4YMcX6f7f83TzurPWrExlFckkbpF2wfi9SgefQaMSTzFkq+Q/HGCJ
         Zg0B3BvXCXFvQWZZxN8IEiiAZGm0kF80hxpKC/Z9Qsg2kUlOHI8cAGKmvU+c/rahKg8i
         66gr/WcDqP5tmzB+2ffiWNrCDYArPqHQR6g2uB6Zf1hluF4NwtUFbDapGCpfy49iEca2
         gMgmWUnojRAH48FOSmGmOfRZtq+SIOe3cwOz3fYpL8G2rj4K74hiLAjZA0ORxapwRwZz
         TikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xZlo/aob1wQ1ZSgYV63PX8q9CXH4pQq9F49K4TeXUXw=;
        b=p2zIy+1VythKu37tA7hJaGqIhJWalP+TTgljfrcjlE8az5HRotPHhjlvYgBtMH0Odw
         HqjDdFz5ihdLriC/octJI0Z1k3tsDE/n1FiqHGYTC5dDA5+pQmSOXqBaR4MPVq0HzMPu
         Q2kwlKB1FyPwcr2kGCiPYl7Kc02bF6iuT42aEjEEJFp02BsbaZ3UlsKnmvbVCOYXjFEE
         cmXtA6oDPYyNaSuTXRZyOX4ur1tVDRwxGSy1iRZPYhkoH+6FQoulpndcj66GzdLkjREn
         qLOi/sEdGRdZTGot+WeIvJkbFRmIWN7NxJ/pRnOjl2CzaOLU/8qQxqvFSHz+UA9vjh0Z
         TGDg==
X-Gm-Message-State: AOAM5328txMJAYy0tjZhTnp9qNkLDvE+F8NtiS/V1KYVa6s3pqHTTYEC
        qOEnbuNjXl0Pq06IKwGN0U5wDg==
X-Google-Smtp-Source: ABdhPJzKK88cFW+h7mO7FwylKHW/WRcpFsyNhKBg95CEVZX7X43qBQ/2gLhSty2TTcxIszwdeoshbQ==
X-Received: by 2002:adf:e811:0:b0:1e4:bf57:7754 with SMTP id o17-20020adfe811000000b001e4bf577754mr1741498wrm.224.1645091954811;
        Thu, 17 Feb 2022 01:59:14 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6165:d98a:b553:c3c1? ([2a01:e34:ed2f:f020:6165:d98a:b553:c3c1])
        by smtp.googlemail.com with ESMTPSA id k3sm1351468wrm.69.2022.02.17.01.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 01:59:14 -0800 (PST)
Message-ID: <bfd33bfe-025e-bfba-04f2-e3c39822d68e@linaro.org>
Date:   Thu, 17 Feb 2022 10:59:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        amit daniel kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre.Gondois@arm.com, Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com> <YgG+TmLrCSXX4Bvt@google.com>
 <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com> <YgKnnFl7Gp8AS30X@google.com>
 <e4532f65-7f8a-7e89-97c1-85cc61462040@arm.com> <YgQ9XLcto9v0fyTf@google.com>
 <d120110a-7d01-0cfd-f7eb-d160e17ec2a8@arm.com>
 <CAD=FV=VntGw1_AzJPpdOk0zSpOVZRH2X1JNg84JX+zCeU1jvXg@mail.gmail.com>
 <Yg13JoHLmeFGPOAW@google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Yg13JoHLmeFGPOAW@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2022 23:13, Matthias Kaehlcke wrote:
> On Wed, Feb 16, 2022 at 09:33:50AM -0800, Doug Anderson wrote:
>> Hi,
>>
>> On Wed, Feb 16, 2022 at 7:35 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>> Hi Matthias,
>>>
>>> On 2/9/22 10:17 PM, Matthias Kaehlcke wrote:
>>>> On Wed, Feb 09, 2022 at 11:16:36AM +0000, Lukasz Luba wrote:
>>>>>
>>>>>
>>>>> On 2/8/22 5:25 PM, Matthias Kaehlcke wrote:
>>>>>> On Tue, Feb 08, 2022 at 09:32:28AM +0000, Lukasz Luba wrote:
>>>>>>>
>>>>>>>
>>>
>>> [snip]
>>>
>>>>>>> Could you point me to those devices please?
>>>>>>
>>>>>> arch/arm64/boot/dts/qcom/sc7180-trogdor-*
>>>>>>
>>>>>> Though as per above they shouldn't be impacted by your change, since the
>>>>>> CPUs always pretend to use milli-Watts.
>>>>>>
>>>>>> [skipped some questions/answers since sc7180 isn't actually impacted by
>>>>>>     the change]
>>>>>
>>>>> Thank you Matthias. I will investigate your setup to get better
>>>>> understanding.
>>>>
>>>> Thanks!
>>>>
>>>
>>> I've checked those DT files and related code.
>>> As you already said, this patch is safe for them.
>>> So we can apply it IMO.
>>>
>>>
>>> -------------Off-topic------------------
>>> Not in $subject comments:
>>>
>>> AFAICS based on two files which define thermal zones:
>>> sc7180-trogdor-homestar.dtsi
>>> sc7180-trogdor-coachz.dtsi
>>>
>>> only the 'big' cores are used as cooling devices in the
>>> 'skin_temp_thermal' - the CPU6 and CPU7.
>>>
>>> I assume you don't want to model at all the power usage
>>> from the Little cluster (which is quite big: 6 CPUs), do you?
>>> I can see that the Little CPUs have small dyn-power-coeff
>>> ~30% of the big and lower max freq, but still might be worth
>>> to add them to IPA. You might give them more 'weight', to
>>> make sure they receive more power during power split.
> 
> In experiments we saw that including the little cores as cooling
> devices for 'skin_temp_thermal' didn't have a significant impact on
> thermals, so we left them out.

I agree, that was also my conclusion after doing some measurements.

Basically, the little cores are always cold and are victims of the big 
cores heat dissipation.

They of course contribute a bit to the heat but capping their 
performance does not change the temperature trend of the whole.

That is less true with silver-gold were it is the same micro-arch but 
different frequencies.


>>> You also don't have GPU cooling device in that thermal zone.
>>> Based on my experience if your GPU is a power hungry one,
>>> e.g. 2-4Watts, you might get better results when you model
>>> this 'hot' device (which impacts your temp sensor reported value).
>>
>> I think the two boards you point at (homestar and coachz) are just the
>> two that override the default defined in the SoC dtsi file. If you
>> look in sc7180.dtsi you'll see 'gpuss1-thermal' which has a cooling
>> map. You can also see the cooling maps for the littles.
> 
> Yep, plus thermal zones with cooling maps for the big cores.
> 
>> I guess we don't have a `dynamic-power-coefficient` for the GPU,
>> though? Seems like we should, but I haven't dug through all the code
>> here...
> 
> To my knowledge the SC7x80 GPU doesn't register an energy model, which is
> one of the reasons the GPU wasn't included as cooling device for
> 'skin_temp_thermal'.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
