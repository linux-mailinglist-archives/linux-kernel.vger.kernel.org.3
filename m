Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A18252BF27
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbiERPyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbiERPyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:54:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10A891CC9BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:54:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C08F23A;
        Wed, 18 May 2022 08:54:38 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 792CD3F718;
        Wed, 18 May 2022 08:54:37 -0700 (PDT)
Message-ID: <0a5a1220-dc31-690e-9ae3-ebff53a68305@arm.com>
Date:   Wed, 18 May 2022 17:54:23 +0200
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
 <b0b63d75-b2f4-2298-a85a-668c3a3e5b6b@arm.com>
 <20220518104344.wh5thzaw2zg4f6jq@bogus>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220518104344.wh5thzaw2zg4f6jq@bogus>
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

On 18/05/2022 12:43, Sudeep Holla wrote:
> On Wed, May 18, 2022 at 12:23:35PM +0200, Dietmar Eggemann wrote:
>> On 17/05/2022 12:57, Sudeep Holla wrote:
> [...]

[...]

>> I see. Your requirement is valid information under
>> /sys/devices/system/cpu/cpuX/{topology, cache} for userspace.
>>
>> I'm not sure that we can get core_siblings_list and package_cpus_list
>> correctly setup.
>>
>> With your patch we have now:
>>
>> root@juno:/sys/devices/system/cpu/cpu0/topology# cat core_siblings_list
>> 0-5
>> root@juno:/sys/devices/system/cpu/cpu0/topology# cat package_cpus_list
>> 0-5
>>
>> Before we had [0,3-5] for both.
>>
> 
> Correct and that was pure wrong for a single socket system. It must
> cover all the CPUs. Tools like lscpu reports them as 2 socket system
> which is wrong. There were reports for that but no one really chased it
> up to get it fixed. So assumed it is not so important but still it is
> wrong. ACPI platforms cared and wanted it fixed with ACPI PPTT since
> the PPTT support. So check the difference without my patches on Juno
> in DT and ACPI boot. We should get same output for both.
> 
>>
>> I'm afraid we can have 2 different mask here because of:

Sorry, s/can/can't

>> 72 define_siblings_read_func(core_siblings, core_cpumask);
>>                                             ^^^^^^^^^^^^
>> 88 define_siblings_read_func(package_cpus, core_cpumask);
>>                                            ^^^^^^^^^^^^
>>
> 
> Yes even I got confused and the Documentation revealed one is deprecated
> or obsolete(Documentation/ABI/stable/sysfs-devices-system-cpu)
> 
>  74 What:           /sys/devices/system/cpu/cpuX/topology/package_cpus
>  75 Description:    internal kernel map of the CPUs sharing the same physical_package_id.
>  76                 (deprecated name: "core_siblings").
>  77 Values:         hexadecimal bitmask.
>  78
>  79 What:           /sys/devices/system/cpu/cpuX/topology/package_cpus_list
>  80 Description:    human-readable list of CPUs sharing the same physical_package_id.
>  81                 The format is like 0-3, 8-11, 14,17.
>  82                 (deprecated name: "core_siblings_list")
>  83 Values:         decimal list.

Ah, that makes it more clear to me! Thanks. So DIE boundary, i.e.
cpu_cpu_mask() {return cpumask_of_node(cpu_to_node(cpu))} is not related
to package cpumask at all. This is why we have the first if condition in
cpu_coregroup_mask():

658 const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));
...
661 if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
662  /* not numa in package, lets use the package siblings */
663   core_mask = &cpu_topology[cpu].core_sibling;

[...]

>> OK, we don't support Phantom domains via 1. level Cluster in cpu-map
>> anymore. We already explicitly informed the Android community. But I'm
>> sure people will only discover this if something breaks on their
>> platforms and they are able to detect this.
>>
> 
> Again if it was working just by cache with their own phantom domains that
> are not upstream, then nothing is broken. At-least I see that we have now
> fixed and aligned DT with ACPI. While I understand your concern, I see
> this as main issue and not sched domains which may or may not be using
> topology info incorrectly.

OK, lets see how you incorporated llc into the topology code in your v2
first.

>>>> If we say we only support L2 sharing (asymmetric here since only CPU0-3
>>>> have it !!!) and we don't support Phantom then your approach will work
>>>> for such systems.
>>>
>>> Thanks, as I said what is *Phantom* domain ;) ? Can you point me to the
>>> DT or ACPI binding for the same ? Just kidding, I know they don't exist.
>>
>> They do ;-) 1. level Clusters ... but they are used for uArch
>> boundaries, not for LLC boundaries. That's the existing issue in DT,
>> topology information has 2 sources: (1) cpu-map and (2) cache info.
>>
> 
> Sure, they can fix or add more optimisation on top of what I have sent[1]

If you add llc parsing in your v2, they should have everything they need
for Armv9 with uArch boundaries and L2 complexes. What I'm interested in
is seeing how we solve the 2 sources (cache and cpu-map) issue here.
Example:

cpu-map:

 socket
  cluster <-- (1)
   core
    thread

cache:

 llc

How do people know that (1) is L2 and not LLC?

But let us switch the discussion to you v2 on this one. I have to see
your implementation first.

> [1] https://lore.kernel.org/lkml/20220518093325.2070336-1-sudeep.holla@arm.com

[...]
