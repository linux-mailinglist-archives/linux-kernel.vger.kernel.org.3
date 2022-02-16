Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338964B9481
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbiBPX2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:28:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbiBPX2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:28:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B70F515B9BE;
        Wed, 16 Feb 2022 15:28:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EE46D6E;
        Wed, 16 Feb 2022 15:28:21 -0800 (PST)
Received: from [10.57.13.238] (unknown [10.57.13.238])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25C903F718;
        Wed, 16 Feb 2022 15:28:19 -0800 (PST)
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <adbc1cd5-7598-a0b1-629c-8dd920aac2d0@arm.com>
Date:   Wed, 16 Feb 2022 23:28:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UtQgrwPXg4zTZtBin3LWY1yTgCKQ05MmCNqK_6F5S8VA@mail.gmail.com>
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



On 2/16/22 5:21 PM, Doug Anderson wrote:
> Hi,
> 
> On Tue, Feb 8, 2022 at 1:32 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>>     Another important thing is the consistent scale of the power values
>>>     provided by the cooling devices. All of the cooling devices in a single
>>>     thermal zone should have power values reported either in milli-Watts
>>>     or scaled to the same 'abstract scale'.
>>
>> This can change. We have removed the userspace governor from kernel
>> recently. The trend is to implement thermal policy in FW. Dealing with
>> some intermediate configurations are causing complicated design, support
>> of the algorithm logic is also more complex.
> 
> One thing that didn't get addressed is the whole "The trend is to
> implement thermal policy in FW". I'm not sure I can get on board with
> that trend. IMO "moving to FW" isn't a super great trend. FW is harder
> to update than kernel and trying to keep it in sync with the kernel
> isn't wonderful. Unless something _has_ to be in FW I personally
> prefer it to be in the kernel.

There are pros and cons for both approaches (as always).

Although, there are some use cases, where the kernel is not able to
react that fast, e.g. sudden power usage changes, which can cause
that the power rail is not able to sustain within required conditions.
When we are talking about tough requirements for those power & thermal
policies, the mechanism must be fast, precised and reliable.

Here you can find Arm reference FW implementation and an IPA clone
in there (I have been reviewing this) [1][2].

As you can see there is a new FW feature set:
"MPMM, Traffic-cop and Thermal management".

Apart from Arm implementation, there are already known thermal
monitoring mechanisms in HW/FW. Like in the new Qcom SoCs which
are using this driver code [3]. The driver receives an interrupt
about throttling conditions and just populates the thermal pressure.

> 
> ...although now that I re-read this, I'm not sure which firmware you
> might be talking about. Is this the AP firmware, or some companion
> chip / coprocessor? Even so, I'd still rather see things done in the
> kernel when possible...

It's a FW run on a dedicated microprocessor. In Arm SoCs it's usually
some Cortex-M. We communicated with it from the kernel via SCMI drivers
(using shared memory and mailboxes). We recommend to use the SCMI
protocol to send e.g. 'performance request' to the FW via 'fast
channel' instead of having an implementation of PMIC and clock, and do
the voltage & freq change in the kernel (using drivers & locking). That
implementation allows to avoid costly locking and allows to go via
that SCMI cpufreq driver [4] and SCMI perf layer [5] the task scheduler.
We don't need a dedicated 'sugov' kthread in a Deadline policy to
do that work and preempt the currently running task.

IMHO the FW approach opens new opportunities.

Regards,
Lukasz

[1] https://github.com/ARM-software/SCP-firmware/pull/588
[2] 
https://github.com/ARM-software/SCP-firmware/pull/588/commits/59c62ead5eb66353ae805c367bfa86192e28c410
[3] 
https://elixir.bootlin.com/linux/v5.17-rc4/source/drivers/cpufreq/qcom-cpufreq-hw.c#L287
[4] 
https://elixir.bootlin.com/linux/latest/source/drivers/cpufreq/scmi-cpufreq.c#L65
[5] 
https://elixir.bootlin.com/linux/v5.17-rc4/source/drivers/firmware/arm_scmi/perf.c#L465
