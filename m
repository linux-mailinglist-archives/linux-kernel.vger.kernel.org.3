Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D309551E13
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347597AbiFTOMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351295AbiFTOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:09:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E05233EA98
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:27:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B1A6D6E;
        Mon, 20 Jun 2022 06:27:45 -0700 (PDT)
Received: from [192.168.178.35] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 671113F792;
        Mon, 20 Jun 2022 06:27:43 -0700 (PDT)
Message-ID: <e7d65b22-67a2-b21a-86e5-a9a1606be4d6@arm.com>
Date:   Mon, 20 Jun 2022 15:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 15/16] arch_topology: Set cluster identifier in each
 core/thread from /cpu-map
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
References: <20220525081416.3306043-14-sudeep.holla@arm.com>
 <20220525081416.3306043-15-sudeep.holla@arm.com>
 <20220525081416.3306043-16-sudeep.holla@arm.com>
 <947470ba-35fc-3c72-d01b-c0a7337216a2@arm.com>
 <20220606102159.dduxmvq4m2fm6gks@bogus>
 <CAKfTPtB8iPzEXipsJqNtd9-aJMKx-FAaiGMzOg58HgRQuo39iA@mail.gmail.com>
 <20220610102753.virkx47uyfsojol6@bogus>
 <af7d6f49-09c5-6e60-988c-51c3c7c04d96@arm.com>
 <20220613111743.3od6a5dyyogad4ay@bogus>
 <73574a8f-5c72-8f7e-3dc4-42493131681e@arm.com>
 <20220617111647.62hsqbpl3bk7xb2y@bogus>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220617111647.62hsqbpl3bk7xb2y@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2022 13:16, Sudeep Holla wrote:
> On Thu, Jun 16, 2022 at 05:02:28PM +0100, Dietmar Eggemann wrote:
>> On 13/06/2022 12:17, Sudeep Holla wrote:
>>> On Mon, Jun 13, 2022 at 11:19:36AM +0200, Dietmar Eggemann wrote:
>>>> On 10/06/2022 12:27, Sudeep Holla wrote:
>>>>> On Fri, Jun 10, 2022 at 12:08:44PM +0200, Vincent Guittot wrote:
>>>>>> On Mon, 6 Jun 2022 at 12:22, Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

>>> What are you referring as 'glue them together'. As I said this series just
>>> address the hardware topology and if there is any impact on sched domains
>>> then it is do with alignment with ACPI and DT platform behaviour. I am not
>>> adding anything more to glue topology and info needed for sched domains.
>>
>> You can fix (1) without (2) parsing 1. level cluster nodes as
>> cluster_siblings.
>>
> 
> Technically yes, but I see no point in delaying it as it is considered as
> broken with respect to the moment ACPI exposed the correct value and at the
> same time resulted in exposing incorrect value in case of DT. I am referring
> to the same change that introduced SCHED_CLUSTER. The damage is done and it
> needs repairing ASAP.

OK, then lets `/sys/.../topology/cluster_cpus` refer to pure
topology-based cluster information. This can be DT cluster-node
information or ACPI L3-tag information e.g. for KP920.

>>> Indeed. But I don't get what you mean by 2 level here. ACPI puts 1st level
>>
>> cpu_map {
>>   socket0 {
>>     cluster0 {    <-- 1. level cluster
>>       cluster0 {  <-- 2. level cluster (3 -->)
> 
> Oh I had misunderstood this level nomenclature, I refer it as leaf cluster
> node which is 2. level cluster in this DT snippet.
> 
>>         core0 {
>>
>>         };
>>         core1 {
>>
>>         };
>>       cluster1 {
>>   ...
>>
>> Armv9 L2 complexes: e.g. QC SM8450:
>>
>>       .---------------.
>> CPU   |0 1 2 3 4 5 6 7|
>>       +---------------+
>> uarch |l l l l m m m b| (so called tri-gear: little, medium, big)
>>       +---------------+
>>   L2  |   |   | | | | | <-- 2. level cluster, Armv9 L2 complexes (<-- 3)
> 
> Again before I assume, what exactly <--3 here and in above snippet mean ?

I wanted to show that we could encode `2. level cluster` as `Armv9 L2
complexes`. But since we agreed (after the email was sent) not to
support `nested cluster-nodes`, this idea does not hold anymore.

>>       +---------------+
>>   L3  |<--         -->|
>>       +---------------+
>>       |<-- cluster -->|
> 
> I think this is 2 level cluster or only cluster in this system w.r.t hardware.
> So lets not confuse with multi-level if not necessary.

No need, we said no `nested cluster-node` support in DT.

>>       +---------------+
>>       |<--   DSU   -->|
>>       '---------------'
>>
>> Only if we map (i) into cluster_sibling, we get the same hardware
>> representation (for the task scheduler) for ACPI (4) and DT (5) systems.
>>
> 
> What is (i) above ?

Sorry, (i) was meant to be `3 -->`.

>> (4) examples:
>>
>> Kunpeng920 - 24 CPUs sharing LLC (cpu_coregroup_mask()), 4 CPUs sharing
>> L3-tag (cpu_clustergroup_mask()).
>>
> 
> Again decouple cache info and cluster info from h/w, you have all the info.
> You can couple them together if that helps when you feed sched_domains.

OK, this is what we finally agreed.

>> X86 Jacobsville - 24 CPUs sharing LLC (L3), 4 CPUs sharing L2
>>
>> Armv9 L2 complexes: e.g. QC SM8450 - 8 CPUs sharing LLC (L3), (for A510
>> (little CPUs)) 2 CPUs sharing L2
> 
> [...]
> 
>>> And yes lstopo doesn't read cluster IDs. But we expose them in ACPI system
>>> and not on DT which was my main point.

OK, no further discussion needed here. `/sys/.../topology/cluster_cpus`
shows L2 (LLC) on Juno, L3-tag an KP920 or L2 on X86 Jacobsville. The
cpu_xxx_mask()s of (e.g.) default_topology[] have to make sure that the
scheduler sees the correct information (the hierarchy of cpumasks).

>> Understood. But a Kunpeng920 `cluster_cpus_list` file would contain
>> logically different information than a Juno `cluster_cpus_list` file.
>>
> And why is that ?

If we see it from the angle of the definition of SCHED_CONFIG_CLUSTER
(`... the level of topology above CPUs ...` then I can see that both
definitions are the same. (CPUS should be rather `cores` here, I guess?).

[...]

>>> As pointed out earlier, have you checked ACPI on Juno and with 
>>> CONFIG_SCHED_CLUSTER ? If the behaviour with my series on DT and ACPI
>>> differs, then it is an issue. But AFAIU, it doesn't and that is my main
>>> argument. You are just assuming what we have on Juno with DT is correct
>>> which may be w.r.t to scheduler but definitely not with respect to the
>>> hardware topology exposed to the users. So my aim is to get that fixed.
>>
>> I never run Juno w/ ACPI. Are you saying that
>> find_acpi_cpu_topology_cluster() returns cpu_topology[cpu].cluster_id's
>> which match the `1. level cluster nodes`?
>>
> 
> Again I am totally confused as why this is now 1.level cluster where as above
> SDM was 2.level cluster. Both SoCs have only 1 level of cluster. While SDM
> has 1 DSU cluster, Juno has 2 clusters.

No need in agreeing what level (could) stand(s) here for. We said `no
nested cluster-node`.

>> The function header of find_acpi_cpu_topology_cluster() says that `...
>> the cluster, if present is the level of topology above CPUs. ...`.
>>
> 
> Exactly and that's how sysfs is also defined and we can't go back and change
> that now. I don't see any issue TBH.

OK.

>> From this perspective I can see your point. But this is then still
>> clearly poorly designed.
> 
> Not really as per the definition.

Not from the viewpoint of topology and cacheinfo. But from the scheduler
and the whole thing gets activated by a scheduler CONFIG option.

>> How would we ever support CONFIG_SCHED_CLUSTER
>> in DT when it really (potentially) would bring a benefit (i.e. in the
>> Armv9 L2-complex case) and not only create trouble for the task
>> scheduler to setup its domains correctly?
> 
> Indeed, that is the next problem once we get all these aligned across
> DT and ACPI. They have diverged and I prefer not to allow that anymore
> by adding more divergence e.g. to support Armv9 L2-complex case. Please
> consider that on top of these, I am not addressing that at the moment.
> In fact I am not addressing any sched_domain topics or issues. I have made
> that clear 😉.

If I recall the content of our discussion correctly, `Armv9 L2
complexes` support could come from L2 (probably `LLC - 1` ?) detection
from cacheinfo. But this is not part of this patch-set.

>> Also in case we stick to
>> setting CONFIG_SCHED_CLUSTER=1 by default, CLS should be the default LLC
>> sched domain and MC the exceptional one. Just to respect the way how the
>> task scheduler removes not useful domains today.
> 
> Fix the cpu_clustergroup_mask or any other cpu_*group_mask as per your
> taste. The topology masks are just inputs to these and will not be changed
> or diverged for these reasons. Sorry if that is not helpful, but that is the
> reality with sysfs exposed to the user-space.

Agreed. We don't have to rely on the task scheduler to build the right
sched domain hierarchy out of every cpu_xxx_mask() functions. We can
tweak cpu_xxx_mask() to get this done.

>>> If you are not happy with that, then how can be be happy with what is the
>>> current behaviour on ACPI + and - CONFIG_SCHED_CLUSTER. I haven't got
>>> your opinion yet on that matter.
>>
>> I guess it's clear now that ACPI + CONFIG_SCHED_CLUSTER with ``the level
>> of topology above CPUs` is congruent with LLC` creates trouble to the
>> scheduler. So I don't see why we should replicate this for DT. Let's
>> discuss further tomorrow in person.
> 
> I see it differently. If that creates a trouble, fix that and you will not
> have any issues with DT too.

OK, I think we (arm64) found a way to support a default
CONFIG_SCHED_CLUSTER and fixing the `Juno lstopo` issue with a possible
way to include `Armv9 L2 complexes` support via cacheinfo later.
