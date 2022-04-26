Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEAF50F262
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343894AbiDZH3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbiDZH3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:29:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18AC32181
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:26:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4D6E23A;
        Tue, 26 Apr 2022 00:26:43 -0700 (PDT)
Received: from [10.57.12.108] (unknown [10.57.12.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55D3B3F73B;
        Tue, 26 Apr 2022 00:26:42 -0700 (PDT)
Message-ID: <61483e12-c2a2-059a-c157-aea23b8a2f4e@arm.com>
Date:   Tue, 26 Apr 2022 08:26:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] arch_topology: Trace the update thermal pressure
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, vincent.guittot@linaro.org,
        rafael@kernel.org, rostedt@goodmis.org, mingo@redhat.com
References: <20220425135317.5880-1-lukasz.luba@arm.com>
 <YmasYv5xHH7EbXXn@kroah.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <YmasYv5xHH7EbXXn@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/22 15:12, Greg KH wrote:
> On Mon, Apr 25, 2022 at 02:53:17PM +0100, Lukasz Luba wrote:
>> Add trace event to capture the moment of the call for updating the thermal
>> pressure value. It's helpful to investigate how often those events occurs
>> in a system dealing with throttling. This trace event is needed since the
>> old 'cdev_update' might not be used by some drivers. Also, the new trace
>> event shows capacity value, not a cooling state.
> 
> Wait, why are thermal events not going through the thermal system so
> that thermal_cdev_update() would catch them?  Don't work around broken
> systems, force them to use the correct apis.

In some platforms the thermal is controlled in FW. In Arm we have
recently implemented a logic of our Intelligent Power Allocation
(kernel governor gov_power_allocator.c) (and a bit more) in our
reference FW [1]. So kernel would not controlling thermal.
There is another platform which does similar [2]. As you can see
in that driver, there is no cooling device created, it just handles
the notification about reduced frequency as an IRQ. Then it
populates this information to the task scheduler using thermal
pressure mechanism. Thanks to that the scheduler can avoid mistakes
in the tasks placement and not put more that that CPU real capacity.

For Arm FW thermal, I can make it, since we don't have it yet.
We are in the middle of internal design of this FW/kernel glue and I
haven't sent the kernel patches yet. I will follow your recommendation.

For the driver [2] I have no device, so I cannot change it and prove the
new works safely.

But we need this trace event to discuss the design for RT task scheduler
and impact of thermal pressure decaying delays. We have Android systems
which suffer the RT issues known for years (like audio apps) and we
started to tackle them. That was the motivation for this new trace
event - a helper which everyone can 'just use' in their current code
state and provide measurements.

We can ask maintainers of that driver [2] to follow your guidance and
fix that cpufreq driver. That might require a split of the logic in
there and a new thermal driver which would handle the part of thermal
updates. If that is feasible, since I have heard that some platforms
can cause a huge noise 'KHz' of those interrupt...
If that is true, I might see the reason why someone goes lightweight way
update-thermal-pressure-only and not via thermal cooling complexity.

IMO this trace event doesn't harm the design and brings also benefit
comparing to the 'cdev_update' trace event which only provides a state
value: [0, n]. That state value then needs additional tools to translate
it: state -> freq -> capacity -> thermal pressure. As you can see
this new event just stores proper value in the trace buffer, no need
to hassle, just 'cat' the trace file. If anyone would like to help
us and share it's trace output, we would have everything we need.

Regards,
Lukasz

> 
> thanks,
> 
> greg k-h


[1] https://github.com/ARM-software/SCP-firmware
[2] 
https://elixir.bootlin.com/linux/v5.17/source/drivers/cpufreq/qcom-cpufreq-hw.c#L300
