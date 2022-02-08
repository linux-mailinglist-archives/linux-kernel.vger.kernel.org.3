Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09BB4AD4F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354968AbiBHJcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354954AbiBHJcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:32:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99706C03FECA;
        Tue,  8 Feb 2022 01:32:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A37F11D4;
        Tue,  8 Feb 2022 01:32:42 -0800 (PST)
Received: from [10.57.15.144] (unknown [10.57.15.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 443373F73B;
        Tue,  8 Feb 2022 01:32:36 -0800 (PST)
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com>
Date:   Tue, 8 Feb 2022 09:32:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YgG+TmLrCSXX4Bvt@google.com>
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



On 2/8/22 12:50 AM, Matthias Kaehlcke wrote:
> On Mon, Feb 07, 2022 at 07:30:35AM +0000, Lukasz Luba wrote:
>> The Energy Model supports power values either in Watts or in some abstract
>> scale. When the 2nd option is in use, the thermal governor IPA should not
>> be allowed to operate, since the relation between cooling devices is not
>> properly defined. Thus, it might be possible that big GPU has lower power
>> values in abstract scale than a Little CPU. To mitigate a misbehaviour
>> of the thermal control algorithm, simply not register a cooling device
>> capable of working with IPA.
> 
> Ugh, this would break thermal throttling for existing devices that are
> currently supported in the upstream kernel.

Could you point me to those devices? I cannot find them in the mainline
DT. There are no GPU devices which register Energy Model (EM) in
upstream, neither using DT (which would be power in mW) nor explicitly
providing EM get_power() callback. The EM is needed to have IPA.

Please clarify which existing devices are going to be broken with this
change.

> 
> Wasn't the conclusion that it is the responsability of the device tree
> owners to ensure that cooling devices with different scales aren't used
> in the same thermal zone?

It's based on assumption that someone has DT and control. There was also
implicit assumption that IPA would work properly on such platform - but
it won't.

1. You cannot have 2 thermal zones: one with CPUs and other with GPU
only and both working with two instances of IPA.

2. The abstract power scale doesn't guaranty anything about power values
and IPA was simply designed with milli-Watts in mind. So even working
on CPUs only using bogoWatts, is not what we could guaranty in IPA.

> 
> That's also what's currently specified in the power allocator
> documentation:
> 
>    Another important thing is the consistent scale of the power values
>    provided by the cooling devices. All of the cooling devices in a single
>    thermal zone should have power values reported either in milli-Watts
>    or scaled to the same 'abstract scale'.

This can change. We have removed the userspace governor from kernel
recently. The trend is to implement thermal policy in FW. Dealing with
some intermediate configurations are causing complicated design, support
of the algorithm logic is also more complex.

> 
> Which was actually added by yourself:
> 
> commit 5a64f775691647c242aa40d34f3512e7b179a921
> Author: Lukasz Luba <lukasz.luba@arm.com>
> Date:   Tue Nov 3 09:05:58 2020 +0000
> 
>      PM: EM: Clarify abstract scale usage for power values in Energy Model
> 
>      The Energy Model (EM) can store power values in milli-Watts or in abstract
>      scale. This might cause issues in the subsystems which use the EM for
>          estimating the device power, such as:
> 
>       - mixing of different scales in a subsystem which uses multiple
>              (cooling) devices (e.g. thermal Intelligent Power Allocation (IPA))
> 
>       - assuming that energy [milli-Joules] can be derived from the EM power
>              values which might not be possible since the power scale doesn't have
> 	           to be in milli-Watts
> 
>      To avoid misconfiguration add the requisite documentation to the EM and
>          related subsystems: EAS and IPA.
> 
>      Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> 
> It's ugly to have the abstract scales in the first place, but that's
> unfortunately what we currently have for at least some cooling devices.

A few questions:
Do you use 'we' as Chrome engineers?
Could you point me to those devices please?
Are they new or some old platforms which need just maintenance?
How IPA works for you in such real platform configuration?
If it would be possible could you share some plots of temperature,
frequency and CPUs, GPU utilization?
Do you maybe know how the real power was scaled for them?

It would help me understand and judge.

> 
> IMO it would be preferable to stick to catching incompliant configurations
> in reviews, rather than breaking thermal throttling for existing devices
> with configurations that comply with the current documentation.
> 

Without access to the source code of those devices, it's hard for me to
see if they are broken.

Regards,
Lukasz
