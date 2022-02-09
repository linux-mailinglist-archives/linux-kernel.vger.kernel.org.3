Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1718D4AF0F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiBIMIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiBIMGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:06:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33FFFC076869;
        Wed,  9 Feb 2022 03:16:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDAA7ED1;
        Wed,  9 Feb 2022 03:16:40 -0800 (PST)
Received: from [10.57.1.254] (unknown [10.57.1.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 884F33F73B;
        Wed,  9 Feb 2022 03:16:38 -0800 (PST)
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com> <YgG+TmLrCSXX4Bvt@google.com>
 <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com> <YgKnnFl7Gp8AS30X@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <e4532f65-7f8a-7e89-97c1-85cc61462040@arm.com>
Date:   Wed, 9 Feb 2022 11:16:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YgKnnFl7Gp8AS30X@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/22 5:25 PM, Matthias Kaehlcke wrote:
> On Tue, Feb 08, 2022 at 09:32:28AM +0000, Lukasz Luba wrote:
>>
>>
>> On 2/8/22 12:50 AM, Matthias Kaehlcke wrote:
>>> On Mon, Feb 07, 2022 at 07:30:35AM +0000, Lukasz Luba wrote:
>>>> The Energy Model supports power values either in Watts or in some abstract
>>>> scale. When the 2nd option is in use, the thermal governor IPA should not
>>>> be allowed to operate, since the relation between cooling devices is not
>>>> properly defined. Thus, it might be possible that big GPU has lower power
>>>> values in abstract scale than a Little CPU. To mitigate a misbehaviour
>>>> of the thermal control algorithm, simply not register a cooling device
>>>> capable of working with IPA.
>>>
>>> Ugh, this would break thermal throttling for existing devices that are
>>> currently supported in the upstream kernel.
>>
>> Could you point me to those devices? I cannot find them in the mainline
>> DT. There are no GPU devices which register Energy Model (EM) in
>> upstream, neither using DT (which would be power in mW) nor explicitly
>> providing EM get_power() callback. The EM is needed to have IPA.
>>
>> Please clarify which existing devices are going to be broken with this
>> change.
> 
> I was thinking about arch/arm64/boot/dts/qcom/sc7180-trogdor-*, and
> potentially other SC7180 boards that use IPA for the CPU thermal
> zones.
> 
> Initially SC7180 used an abstract scale for the CPU energy model,
> however I realized your change doesn't actually impact SC7180 CPUs
> for two reasons:
> 
> 1. The energy model of the CPUs is registered through
> 
>    cpufreq_register_em_with_opp
>      dev_pm_opp_of_register_em
>        em_dev_register_perf_domain
> 
> em_dev_register_perf_domain() is called with 'milliwatts = true',
> regardless of the potentially abstract scale, so IPA would not be
> disabled with your change.

That good registration.

> 
> 2. There is a patch from Doug that adjusted the dynamic power
> coefficients of the CPUs to be closer to reality:
> 
> commit 82ea7d411d43f60dce878252558e926f957109f0
> Author: Douglas Anderson <dianders@chromium.org>
> Date:   Thu Sep 2 14:51:37 2021 -0700
> 
>      arm64: dts: qcom: sc7180: Base dynamic CPU power coefficients in reality

Thanks for the link to the commit. I'll have a look. It's good that it
doesn't break this board.

> 
>>> Wasn't the conclusion that it is the responsability of the device tree
>>> owners to ensure that cooling devices with different scales aren't used
>>> in the same thermal zone?
>>
>> It's based on assumption that someone has DT and control. There was also
>> implicit assumption that IPA would work properly on such platform - but
>> it won't.
>>
>> 1. You cannot have 2 thermal zones: one with CPUs and other with GPU
>> only and both working with two instances of IPA.
> 
> It's not clear to me why such a configuration wouldn't work. Is it also a
> problem to have multiple CPU thermal zones (one for each core) that use
> multiple instances of IPA? SC7180 has separate thermal zones for each core
> (or thermal sensor), Chrome OS uses IPA for CPU thermal throttling.

Unfortunately, the control mechanism is not working best in such setup.
Main idea of IPA is to find 'best' OPP for a cooling device, e.g.
one in the middle of a freq table. Worst scenario is when we change
our decision between lowest and highest OPP, in short periods.
It's burning too much power at highest freq, then we throttle too much,
then we unthrottle because temp is dropping by some 'good enough' value.
This situation can happen due to a few reasons:
1. Power values from EM are not reflecting reality, e.g. scaled too much
2. We don't have proper information about CPU load and frequencies used
3. PID coefficients are not properly set
4. board has small physical thermal sink potential but silicon if 'hot'
5. the workload is too dynamic
6. there is another power hungry device (GPU, DSP, ISP) which is outside
    of our control loop, e.g. is controlled in other thermal zone and has
    impact on our temp sensor value

Proper setup and tuning of IPA could bring quite good benefit, because
it could pick the 'best at that moment' OPPs for the devices, instead
of throttling too hard and then unthrottling. Unfortunately, it's
tricky and needs time (experiments, understanding the system).

We have been trying to easy this entry barrier for developers. Very good
results brings the optimization of the PID coefficients. The automated
mechanism would figure out best values for the given board based on the
tests run. It's under review now, there are also shared results [1][2].
It would solve a some of the issues with complex tuning.

I was going to give it a try for my old experiments with the bogoWatts
devices, but I don't expect that this is a silver bullet. Regarding
the 'two thermal zones with IPA issues' I'm prity sure it won't help.

> 
>> 2. The abstract power scale doesn't guaranty anything about power values
>> and IPA was simply designed with milli-Watts in mind. So even working
>> on CPUs only using bogoWatts, is not what we could guaranty in IPA.
> 
> That's bad news for SoCs that are configured with bogoWatt values, from
> past discussions I had the impression that this is unfortunately not
> uncommon.
> 
>> It's ugly to have the abstract scales in the first place, but that's
>> unfortunately what we currently have for at least some cooling devices.
> 
>> A few questions:
>>
>> Do you use 'we' as Chrome engineers?
> 
> I was referring to the kernel, in particular QCOM SC7180.

Thanks for sharing the name.

> 
>> Could you point me to those devices please?
> 
> arch/arm64/boot/dts/qcom/sc7180-trogdor-*
> 
> Though as per above they shouldn't be impacted by your change, since the
> CPUs always pretend to use milli-Watts.
> 
> [skipped some questions/answers since sc7180 isn't actually impacted by
>   the change]

Thank you Matthias. I will investigate your setup to get better
understanding.

Regards,
Lukasz

> 
> Thanks
> 
> Matthias
> 

[1] https://nbviewer.org/gist/chemis01/0e86ad81508860659a57338dae8274f9
[2] 
https://lore.kernel.org/all/20211217184907.2103677-1-chetan.mistry@arm.com/
