Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549564B9CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiBQKPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:15:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbiBQKPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:15:35 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F57A2AB501
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:15:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d27so8099397wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uXPjyUbnGf2R0Jh08e82SEM1cq95d9bSmagcbmHhOnY=;
        b=qW6AhkZlb/X1OPSfZ3pGfuQv0mrJ+5yCGTceVZitvK5OLrIEKSPHuQYt3wGUtve4YL
         j1weDXBuwUZ2JkUSMVaByXEqdt90ymNIJRBBOrLIVnEpSiUgjbXRuLTKSmSv4BYe6KX9
         CH2byDORt4Iq02HJ8wzZm7glXwB0RIm8JnO2YuGi6serB5xznbMzSvSG/XbKFncAALgV
         BDPGICLgH/qJ5RgmkTH2EgCP34FO7nKRi1U4F4f/3GHKE/J0ZuUp6evWYLd+C1CCnalm
         SdoXrQ0jqnWRO8Y0GCUGADgcVOMvTP/SperH6/5SirO1QjuwYjuJfpzEoHaPTBm+W8PH
         j8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uXPjyUbnGf2R0Jh08e82SEM1cq95d9bSmagcbmHhOnY=;
        b=w1+OzSvF3swjCCSM82xIAbZxYnW3dpN7r5gWxVr2eob84ZzHJol4ttCpesxg5NOMM7
         DQbkGq1Ix/YQcrHjUczWmRBABYBuyIgq9dO2z5vpJvbZahDx/tlfgHPPN21ORyDDfdzA
         PLOxqh5ugEp2NxMHJw9h6CLqPmypCBmLSWEcOF5v4lcWT8jMTex40ANq1qKzL1Z0R2IV
         EsOxa4rTRKjrYEX7D1l/ivg2o2gWjZP/v8BNLX1QQmRdyeyoGvTttu8hYPrLCuZd0Y9D
         MxS1vFDpWtnpjOJ0bPEsejqGqVypr5e0Wgsujy2Hs8vj5ssP6yEvY1h9F9QwT+Aqs2hj
         ttwQ==
X-Gm-Message-State: AOAM531CovJhAt1/hRIhSWckcFpAOFI9k+PuRQzweNIzUbu9pl/bKILJ
        tVfayfEiDmgMOt2+Zb2Qe9/hLw==
X-Google-Smtp-Source: ABdhPJwBOyltaX/dWga3kBRek3+K4UILAJPJ3dnmFjP7T2OUEKlNyrSOkNTUDJHoXVWUINUmPqToWw==
X-Received: by 2002:a5d:5405:0:b0:1e3:3724:e08a with SMTP id g5-20020a5d5405000000b001e33724e08amr1703124wrv.110.1645092919026;
        Thu, 17 Feb 2022 02:15:19 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6165:d98a:b553:c3c1? ([2a01:e34:ed2f:f020:6165:d98a:b553:c3c1])
        by smtp.googlemail.com with ESMTPSA id t187sm764258wma.22.2022.02.17.02.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 02:15:18 -0800 (PST)
Message-ID: <21a360ea-14a8-6aa3-6e2b-dfa406426654@linaro.org>
Date:   Thu, 17 Feb 2022 11:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
 <Yg13JoHLmeFGPOAW@google.com> <e9ae0530-64bd-3684-1f7d-b496d65d9e70@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e9ae0530-64bd-3684-1f7d-b496d65d9e70@arm.com>
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

On 16/02/2022 23:43, Lukasz Luba wrote:
> 
> 
> On 2/16/22 10:13 PM, Matthias Kaehlcke wrote:
>> On Wed, Feb 16, 2022 at 09:33:50AM -0800, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Wed, Feb 16, 2022 at 7:35 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>> Hi Matthias,
>>>>
>>>> On 2/9/22 10:17 PM, Matthias Kaehlcke wrote:
>>>>> On Wed, Feb 09, 2022 at 11:16:36AM +0000, Lukasz Luba wrote:
>>>>>>
>>>>>>
>>>>>> On 2/8/22 5:25 PM, Matthias Kaehlcke wrote:
>>>>>>> On Tue, Feb 08, 2022 at 09:32:28AM +0000, Lukasz Luba wrote:
>>>>>>>>
>>>>>>>>
>>>>
>>>> [snip]
>>>>
>>>>>>>> Could you point me to those devices please?
>>>>>>>
>>>>>>> arch/arm64/boot/dts/qcom/sc7180-trogdor-*
>>>>>>>
>>>>>>> Though as per above they shouldn't be impacted by your change, 
>>>>>>> since the
>>>>>>> CPUs always pretend to use milli-Watts.
>>>>>>>
>>>>>>> [skipped some questions/answers since sc7180 isn't actually 
>>>>>>> impacted by
>>>>>>>     the change]
>>>>>>
>>>>>> Thank you Matthias. I will investigate your setup to get better
>>>>>> understanding.
>>>>>
>>>>> Thanks!
>>>>>
>>>>
>>>> I've checked those DT files and related code.
>>>> As you already said, this patch is safe for them.
>>>> So we can apply it IMO.
>>>>
>>>>
>>>> -------------Off-topic------------------
>>>> Not in $subject comments:
>>>>
>>>> AFAICS based on two files which define thermal zones:
>>>> sc7180-trogdor-homestar.dtsi
>>>> sc7180-trogdor-coachz.dtsi
>>>>
>>>> only the 'big' cores are used as cooling devices in the
>>>> 'skin_temp_thermal' - the CPU6 and CPU7.
>>>>
>>>> I assume you don't want to model at all the power usage
>>>> from the Little cluster (which is quite big: 6 CPUs), do you?
>>>> I can see that the Little CPUs have small dyn-power-coeff
>>>> ~30% of the big and lower max freq, but still might be worth
>>>> to add them to IPA. You might give them more 'weight', to
>>>> make sure they receive more power during power split.
>>
>> In experiments we saw that including the little cores as cooling
>> devices for 'skin_temp_thermal' didn't have a significant impact on
>> thermals, so we left them out.
>>
>>>> You also don't have GPU cooling device in that thermal zone.
>>>> Based on my experience if your GPU is a power hungry one,
>>>> e.g. 2-4Watts, you might get better results when you model
>>>> this 'hot' device (which impacts your temp sensor reported value).
>>>
>>> I think the two boards you point at (homestar and coachz) are just the
>>> two that override the default defined in the SoC dtsi file. If you
>>> look in sc7180.dtsi you'll see 'gpuss1-thermal' which has a cooling
>>> map. You can also see the cooling maps for the littles.
>>
>> Yep, plus thermal zones with cooling maps for the big cores.
>>
>>> I guess we don't have a `dynamic-power-coefficient` for the GPU,
>>> though? Seems like we should, but I haven't dug through all the code
>>> here...
>>
>> To my knowledge the SC7x80 GPU doesn't register an energy model, which is
>> one of the reasons the GPU wasn't included as cooling device for
>> 'skin_temp_thermal'.
>>
> 
> You can give it a try by editing the DT and adding in the
> GPU node the 'dynamic-power-coefficient' + probably
> small modification in the driver code.

That should not work for sc7180 as the DT does not specify the voltage 
values. The QCom backend should retrieve the voltage values for each 
OPPs from a register or a hardcoded table coming from the SoC documentation.

However, I can confirm dynamic-power-coefficient will add an energy 
model on GPU (or any devfreq device) if the voltage is specified in the 
OPP description. Checked with panfrost driver and memory controller on 
rk3399.

> If the GPU driver registers the cooling device in the new way, you
> would also get EM registered thanks to the devfreq cooling new code
> (commit: 84e0d87c9944eb36ae6037a).
> 
> You can check an example from Panfrost GPU driver [1].
> 
> I can see some upstream MSM GPU driver, but I don't know if that is
> your GPU driver. It registers the 'old' way the devfreq cooling [2]
> but it would be easy to change to use the new function.
> The GPU driver would use the same dev_pm_opp_of_register_em() as
> your CPUs do, so EM would be in 'milli-Watts' (so should be fine).
> 
> 
> [1] 
> https://elixir.bootlin.com/linux/v5.16/source/drivers/gpu/drm/panfrost/panfrost_devfreq.c#L153 
> 
> [2] 
> https://elixir.bootlin.com/linux/v5.16/source/drivers/gpu/drm/msm/msm_gpu_devfreq.c#L129 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
