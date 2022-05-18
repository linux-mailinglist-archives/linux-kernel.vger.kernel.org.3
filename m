Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64D352B807
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiERKX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiERKXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:23:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F14AD111B96
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:23:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B43EF23A;
        Wed, 18 May 2022 03:23:45 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 907923F800;
        Wed, 18 May 2022 03:23:44 -0700 (PDT)
Message-ID: <b0b63d75-b2f4-2298-a85a-668c3a3e5b6b@arm.com>
Date:   Wed, 18 May 2022 12:23:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] arch_topology: Use llc_id instead of package_id
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Qing Wang <wangqing@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel@vger.kernel.org
References: <20220513083400.343706-1-dietmar.eggemann@arm.com>
 <20220513090330.z25fwthekn4rjkwq@bogus>
 <afafbb0c-5279-bee8-1ef4-434733e2a552@arm.com>
 <20220513110312.wy6g5avs7ngkmhfu@bogus>
 <634a4b8c-84d2-51a9-ef54-33b81683c849@arm.com>
 <20220516103524.35swlxp2367baxx6@bogus>
 <beda044e-0b91-4359-c6bf-5e34c285fc5c@arm.com>
 <20220517105718.tvpmj2xxb2qj3bev@bogus>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220517105718.tvpmj2xxb2qj3bev@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 12:57, Sudeep Holla wrote:
> Hi Dietmar,
> 
> Thanks for the detailed response.
> 
> On Tue, May 17, 2022 at 11:14:44AM +0200, Dietmar Eggemann wrote:
>> On 16/05/2022 12:35, Sudeep Holla wrote:
>>> On Fri, May 13, 2022 at 02:04:29PM +0200, Dietmar Eggemann wrote:
>>>> On 13/05/2022 13:03, Sudeep Holla wrote:
>>>>> On Fri, May 13, 2022 at 12:42:00PM +0200, Dietmar Eggemann wrote:
>>>>>> On 13/05/2022 11:03, Sudeep Holla wrote:
>>>>>>> On Fri, May 13, 2022 at 10:34:00AM +0200, Dietmar Eggemann wrote:

[...]

>>> I see on Juno with SCHED_CLUSTER and cluster masks set, I see CLS and MC
>>> domains.
>>
>> Right but that's not really correct from the scheduler's POV.
>>
> 
> OK
> 
>> Juno has LLC on cpumasks [0,3-5] and [1-2], not on [0-5]. So the most
>> important information is the highest Sched Domain with the
>> SD_SHARE_PKG_RESOURCES flag. This is the MC layer (cpu_core_flags() in
>> default_topology[]). So the scheduler would think that [0-5] are sharing
>> LLC.
>>
> 
> Ah OK, but if LLC sibling masks are updated, cpu_coregroup_mask() takes
> care of it IIUC, right ?

Yes. That's the:

691 if (cpu_topology[cpu].llc_id != -1) {
692  if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
693   core_mask = &cpu_topology[cpu].llc_sibling;
694 }

condition in cpu_coregroup_mask().

> 
>> You have LLC at:
>>
>> cat /sys/devices/system/cpu/cpu0/cache/index2/shared_cpu_list
>>                                        ^^^^^^
>> 0,3-5
>>
>> but the scheduler sees the highest SD_SHARE_PKG_RESOURCES on MC:
>>
>> cat /sys/kernel/debug/sched/domains/cpu0/domain1/flags
>>                                          ^^^^^^^
>> ... SD_SHARE_PKG_RESOURCES ...
>>
>> [...]
>>
>>>> For one level (MC) yes, but not for 2 (MC and CLS). And cluster_id was
>>>> introduces for the 2. level.
>>>>
>>>
>>> That sounds wrong and not what ACPI PPTT code says. My series just aligns
>>> with what is done with ACPI PPTT IIUC. I need to check that again if my
>>> understand differs from what is being done. But the example of Kunpeng920
>>> aligns with my understanding.
>>
>> (1) IMHO, as long as we don't consider cache (llc) information in DT we
>> can't have the same coverage as ACPI.
>>
> 
> Agreed. But we are not changing any topology masks as per sched domain
> requirements as they get exposed to the userspace as is.

I see. Your requirement is valid information under
/sys/devices/system/cpu/cpuX/{topology, cache} for userspace.

I'm not sure that we can get core_siblings_list and package_cpus_list
correctly setup.

With your patch we have now:

root@juno:/sys/devices/system/cpu/cpu0/topology# cat core_siblings_list
0-5
root@juno:/sys/devices/system/cpu/cpu0/topology# cat package_cpus_list
0-5

Before we had [0,3-5] for both.


I'm afraid we can have 2 different mask here because of:

72 define_siblings_read_func(core_siblings, core_cpumask);
                                            ^^^^^^^^^^^^
88 define_siblings_read_func(package_cpus, core_cpumask);
                                           ^^^^^^^^^^^^

[...]

> Understood and on Juno if we get llc_siblings right, the sched domains
> must be sorted correctly ?

Yes, then it should do exactly what ACPI is leading us to on this !NUMA
Kunpeng920 example.

>> Coming back to the original request (the support of Armv9 L2 complexes
>> in Android) from Qing on systems like QC SM8450:
>>
>>       .---------------.
>> CPU   |0 1 2 3 4 5 6 7|
>>       +---------------+
>> uarch |l l l l m m m b| (so called tri-gear: little, medium, big)
>>       +---------------+
>>   L2  |   |   | | | | |
>>       +---------------+
>>   L3  |<--         -->|
>>       +---------------+
>>       |<-- cluster -->|
>>       +---------------+
>>       |<--   DSU   -->|
>>       '---------------'
>>
>> This still wouldn't be possible. We know that Phantom Domain (grouping
>> after uarch) is not supported in mainline but heavily used in Android
>> (legacy deps).
>>
> 
> Correct, unless you convince to get a suitable notion of *whatever*
> phantom domains represent into the DT bindings, they don't exist.
> If someone wants to support this config, they must first represent that
> in the firmware so that OS can infer information from the same.

OK, we don't support Phantom domains via 1. level Cluster in cpu-map
anymore. We already explicitly informed the Android community. But I'm
sure people will only discover this if something breaks on their
platforms and they are able to detect this.

>> If we say we only support L2 sharing (asymmetric here since only CPU0-3
>> have it !!!) and we don't support Phantom then your approach will work
>> for such systems.
> 
> Thanks, as I said what is *Phantom* domain ;) ? Can you point me to the
> DT or ACPI binding for the same ? Just kidding, I know they don't exist.

They do ;-) 1. level Clusters ... but they are used for uArch
boundaries, not for LLC boundaries. That's the existing issue in DT,
topology information has 2 sources: (1) cpu-map and (2) cache info.

> Anyways, I understand your concern that llc_sibling must go with my set
> of topology changes which I agree. Is that the only concern ?

Cool. Let me review your v2 first ;-)
