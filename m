Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6103352618A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380123AbiEMMEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350905AbiEMMEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:04:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B25D29449B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:04:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12504143D;
        Fri, 13 May 2022 05:04:47 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A32223F5A1;
        Fri, 13 May 2022 05:04:45 -0700 (PDT)
Message-ID: <634a4b8c-84d2-51a9-ef54-33b81683c849@arm.com>
Date:   Fri, 13 May 2022 14:04:29 +0200
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220513110312.wy6g5avs7ngkmhfu@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 13:03, Sudeep Holla wrote:
> On Fri, May 13, 2022 at 12:42:00PM +0200, Dietmar Eggemann wrote:
>> On 13/05/2022 11:03, Sudeep Holla wrote:
>>> On Fri, May 13, 2022 at 10:34:00AM +0200, Dietmar Eggemann wrote:
>>
>> [...]
>>
>>>> @@ -527,7 +528,8 @@ static int __init parse_core(struct device_node *core, int package_id,
>>>>  			return -EINVAL;
>>>>  		}
>>>>
>>>> -		cpu_topology[cpu].package_id = package_id;
>>>> +		cpu_topology[cpu].package_id = 0;
>>>
>>> While the above looks good and matches with what I am attempting to do
>>> as well ...
>>>
>>>> +		cpu_topology[cpu].llc_id = llc_id;
>>>
>>> This looks wrong for simple reason that this is derived incorrectly from
>>> the cpu-map while there is no guarantee that it matches the last level
>>> cache ID on the system as we didn't parse the cache topology for this.
>>> So I disagree with this change as it might conflict with the actual and
>>> correct llc_id.
>>
>> It might not match the LLC, that's true. Something we have already today
>> in Android for DynamIQ clusters with big/Little. People using 1. level
>> clusters to group CPUs according to uArch.
> 
> Not sure if that is the correct representation of h/w cluster on those
> platforms, but if they want to misguide OS with the f/w(DT in this case)
> well that's their choice.
> 
> The main point is we need to get the exact h/w topology information and
> then we can decide how to present the below masks as required by the
> scheduler for its sched domains.
> 
>> My point is we manage to get:
>>
>> SMT - cpu_smt_mask()
>> CLS - cpu_clustergroup_mask()
>> MC  - cpu_coregroup_mask()
>> DIE - cpu_cpu_mask()
>>
>> covered in ACPI with the cpu_topology[] structure and if we want CLS on
>> DT we have to save cluster_id for the 2. level (DT) cluster.
>>
> 
> I am not sure on the above point. Even with ACPI PPTT we are just setting
> cluster_id based on first or leaf level of the clusters ignoring the

Not sure about this. cluster_id was introduced last year into ACPI PPTT
commit c5e22feffdd7 ("topology: Represent clusters of CPUs within a
die") to cover L3-tag (4 CPUs) within L3 (24 CPUs) on Kunpeng920 for
instance.

cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
CLS
MC
... I skip the NUMA levels

# cat /proc/schedstat | awk '{print $1 " " $2 }' | grep ^[cd] | head -5
cpu0 0
domain0 00000000,00000000,0000000f <--  4 CPUs <-- cluster_id
domain1 00000000,00000000,00ffffff <-- 24 CPUs

If you use cluster_id for 1. level cluster then you cover MC's 24 CPUs

> nesting ATM. And that's exactly what I am trying to get with this series[1]
> 
> 
>> And that's why I proposed to (ab)use llc_id to form the MC mask.
>>
> 
> Sure, it is already supported IIUC by cpu_coregroup_mask in arch_topology.c
> We just need to make sure llc_id is set correctly in case of DT. Now if
> you are saying llc_sibling is not what you need but something else, then
> we may need to add that new mask and update cpu_coregroup_mask to choose
> that based on certain condition which I believe is bit complicated.
> 
>> I'm not currently aware of another solution to get CLS somehow elegantly
>> into a DT system.
> 
> Will grouping of CPUs into cluster they belong not good enough for CLS ?

No, IMHO then you'll cover MC and it's cpu_coregroup_mask() and you get
MC.                                        ^^^^

> I thought that should suffice based on what we have in cpu_clustergroup_mask
> (i.e. cluster sibling mask)

For one level (MC) yes, but not for 2 (MC and CLS). And cluster_id was
introduces for the 2. level.

cpu_clustergroup_mask() is 0f, cpu_coregroup_mask() is 00ffffff.
