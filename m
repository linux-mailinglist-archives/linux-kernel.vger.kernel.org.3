Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F8C4BA79B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243947AbiBQR65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:58:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240904AbiBQR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:58:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F036A15C665;
        Thu, 17 Feb 2022 09:58:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B713B113E;
        Thu, 17 Feb 2022 09:58:40 -0800 (PST)
Received: from [10.57.17.240] (unknown [10.57.17.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51CB13F718;
        Thu, 17 Feb 2022 09:58:38 -0800 (PST)
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
To:     Doug Anderson <dianders@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        amit daniel kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
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
 <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com>
 <CAD=FV=UtQgrwPXg4zTZtBin3LWY1yTgCKQ05MmCNqK_6F5S8VA@mail.gmail.com>
 <adbc1cd5-7598-a0b1-629c-8dd920aac2d0@arm.com>
 <CAD=FV=XzTSxg9sAtUcDhoLnY736u1qGKJy4OwLKp56_ruSUUvQ@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <5445b77b-f730-4b01-b60b-223514629e5a@arm.com>
Date:   Thu, 17 Feb 2022 17:58:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XzTSxg9sAtUcDhoLnY736u1qGKJy4OwLKp56_ruSUUvQ@mail.gmail.com>
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



On 2/17/22 4:50 PM, Doug Anderson wrote:
> Hi,
> 
> On Wed, Feb 16, 2022 at 3:28 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> On 2/16/22 5:21 PM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Tue, Feb 8, 2022 at 1:32 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>>>      Another important thing is the consistent scale of the power values
>>>>>      provided by the cooling devices. All of the cooling devices in a single
>>>>>      thermal zone should have power values reported either in milli-Watts
>>>>>      or scaled to the same 'abstract scale'.
>>>>
>>>> This can change. We have removed the userspace governor from kernel
>>>> recently. The trend is to implement thermal policy in FW. Dealing with
>>>> some intermediate configurations are causing complicated design, support
>>>> of the algorithm logic is also more complex.
>>>
>>> One thing that didn't get addressed is the whole "The trend is to
>>> implement thermal policy in FW". I'm not sure I can get on board with
>>> that trend. IMO "moving to FW" isn't a super great trend. FW is harder
>>> to update than kernel and trying to keep it in sync with the kernel
>>> isn't wonderful. Unless something _has_ to be in FW I personally
>>> prefer it to be in the kernel.
>>
>> There are pros and cons for both approaches (as always).
>>
>> Although, there are some use cases, where the kernel is not able to
>> react that fast, e.g. sudden power usage changes, which can cause
>> that the power rail is not able to sustain within required conditions.
>> When we are talking about tough requirements for those power & thermal
>> policies, the mechanism must be fast, precised and reliable.
>>
>> Here you can find Arm reference FW implementation and an IPA clone
>> in there (I have been reviewing this) [1][2].
>>
>> As you can see there is a new FW feature set:
>> "MPMM, Traffic-cop and Thermal management".
>>
>> Apart from Arm implementation, there are already known thermal
>> monitoring mechanisms in HW/FW. Like in the new Qcom SoCs which
>> are using this driver code [3]. The driver receives an interrupt
>> about throttling conditions and just populates the thermal pressure.
> 
> Yeah, this has come up in another context recently too. Right on on
> the Qcom SoCs I'm working with (sc7180 on Chromebooks) we've
> essentially disabled all the HW/FW throttling (LMH), preferring to let
> Linux manage things. We chose to do it this way with the assumption
> that Linux would be able to make better decisions than the firmware
> and it was easier to understand / update than an opaque
> vendor-provided blob. LMH is still there with super high limits in
> case Linux goofs up (we don't want to damage the CPU) but it's not the
> primary means of throttling.
> 
> As you said, Linux reacts a bit slower, though I've heard that might
> be fixed soon-ish? So far on sc7180 Chromebooks it hasn't been a
> problem because we have more total thermal mass and the CPUs in sc7180
> don't actually generate that much heat compared to other CPUs. We also
> have thermal interrupts enabled, which helps. That being said,
> improvements are certainly welcome!
> 

Thanks Doug for sharing this with me. I'll keep this in mind, your
requirements, configuration and usage.
I've learned recently that some SoCs start throttling very early during
boot, even before the cpumask is available. That was causing
kernel to blow up (deference of a cpumask NULL pointer in that LMH [1]).

[1] 
https://lore.kernel.org/linux-pm/20220128032554.155132-2-bjorn.andersson@linaro.org/
