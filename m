Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF52D4B9D88
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbiBQKsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:48:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiBQKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:48:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 818A229412E;
        Thu, 17 Feb 2022 02:47:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24854D6E;
        Thu, 17 Feb 2022 02:47:49 -0800 (PST)
Received: from [10.57.17.240] (unknown [10.57.17.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0B5D3F66F;
        Thu, 17 Feb 2022 02:47:46 -0800 (PST)
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
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
 <7c059f4f-7439-0cad-c398-96dbde4e49c1@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5b8ca53e-3595-85fd-5ae9-a5e8285e8513@arm.com>
Date:   Thu, 17 Feb 2022 10:47:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7c059f4f-7439-0cad-c398-96dbde4e49c1@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2/17/22 10:10 AM, Daniel Lezcano wrote:
> On 16/02/2022 18:33, Doug Anderson wrote:
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
>>>>>> Though as per above they shouldn't be impacted by your change, 
>>>>>> since the
>>>>>> CPUs always pretend to use milli-Watts.
>>>>>>
>>>>>> [skipped some questions/answers since sc7180 isn't actually 
>>>>>> impacted by
>>>>>>     the change]
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
>>>
>>> You also don't have GPU cooling device in that thermal zone.
>>> Based on my experience if your GPU is a power hungry one,
>>> e.g. 2-4Watts, you might get better results when you model
>>> this 'hot' device (which impacts your temp sensor reported value).
>>
>> I think the two boards you point at (homestar and coachz) are just the
>> two that override the default defined in the SoC dtsi file. If you
>> look in sc7180.dtsi you'll see 'gpuss1-thermal' which has a cooling
>> map. You can also see the cooling maps for the littles.
>>
>> I guess we don't have a `dynamic-power-coefficient` for the GPU,
>> though? Seems like we should, but I haven't dug through all the code
>> here...
> 
> The dynamic-power-coefficient is available for OPPs which includes 
> CPUfreq and devfreq. As the GPU is managed by devfreq, setting the 
> dynamic-power-coefficient makes the energy model available for it.
> 
> However, the OPPs must define the frequency and the voltage. That is the 
> case for most platforms except on QCom platform.
> 
> That may not be specified as it uses a frequency index and the hardware 
> does the voltage change in our back. The QCom cpufreq backend get the 
> voltage table from a register (or whatever) and completes the voltage 
> values for the OPPs, thus adding the information which is missing in the 
> device tree. The energy model can then initializes itself and allows the 
> usage of the Energy Aware Scheduler.
> 
> However this piece of code is missing for the GPU part.
> 

Thank you for joining the discussion. I don't know about that Qcom
GPU voltage information is missing.

If the voltage is not available (only the frequencies), there is
another way. There is an 'advanced' EM which uses registration function:
em_dev_register_perf_domain(). It uses a local driver callback to get
power for each found frequency. It has benefit because there is no
restriction to 'fit' into the math formula, instead just avg power
values can be feed into EM. It's called 'advanced' EM [1].

Now we hit (again) the DT & EM issue (it's an old one, IIRC Morten
was proposing from ~2014 this upstream, but EAS wasn't merged back
then):
where to store these power-freq values, which are then used by the
callback. We have the 'dynamic-power-coefficient' in DT, but
it has limitations. It would be good to have this simple array
attached to the GPU/CPU node. IMHO it meet the requirement of DT,
it describes the HW (it would have HZ and Watts values).

Doug, Matthias could you have a look at that function and its
usage, please [1]?
If you guys would support me in this, I would start, with an RFC
proposal, a discussion on LKML.


[1] 
https://elixir.bootlin.com/linux/v5.17-rc4/source/Documentation/power/energy-model.rst#L87
