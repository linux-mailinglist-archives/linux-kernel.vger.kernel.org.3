Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25C8529DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244767AbiEQJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244438AbiEQJOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:14:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6106722B37
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 02:14:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 291531042;
        Tue, 17 May 2022 02:14:51 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09B1A3F73D;
        Tue, 17 May 2022 02:14:49 -0700 (PDT)
Message-ID: <beda044e-0b91-4359-c6bf-5e34c285fc5c@arm.com>
Date:   Tue, 17 May 2022 11:14:44 +0200
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220516103524.35swlxp2367baxx6@bogus>
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

On 16/05/2022 12:35, Sudeep Holla wrote:
> On Fri, May 13, 2022 at 02:04:29PM +0200, Dietmar Eggemann wrote:
>> On 13/05/2022 13:03, Sudeep Holla wrote:
>>> On Fri, May 13, 2022 at 12:42:00PM +0200, Dietmar Eggemann wrote:
>>>> On 13/05/2022 11:03, Sudeep Holla wrote:
>>>>> On Fri, May 13, 2022 at 10:34:00AM +0200, Dietmar Eggemann wrote:

[...]

>> cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
>> CLS
>> MC
>> ... I skip the NUMA levels
>>
>> # cat /proc/schedstat | awk '{print $1 " " $2 }' | grep ^[cd] | head -5
>> cpu0 0
>> domain0 00000000,00000000,0000000f <--  4 CPUs <-- cluster_id
>> domain1 00000000,00000000,00ffffff <-- 24 CPUs
>>
>> If you use cluster_id for 1. level cluster then you cover MC's 24 CPUs
> 
> OK, the way I am looking at this from CPU topology perspective seem to be
> different from what you are expecting here w.r.t sched_domains.
> 
> IMO, these cpumasks on its own must represent real CPU topology and how it
> is used via cpu_*_mask by the scheduler domains is different.

I'm afraid that in case we want to change the mapping of scheduler
(topology) flags (like SD_SHARE_PKG_RESOURCES) via `*_flags()` of
default_topology[] we would have to consider all ACPI corner cases (see
cpu_coregroup_mask()) as well.

See (1) further down.

[...]

> I see on Juno with SCHED_CLUSTER and cluster masks set, I see CLS and MC
> domains.

Right but that's not really correct from the scheduler's POV.

Juno has LLC on cpumasks [0,3-5] and [1-2], not on [0-5]. So the most
important information is the highest Sched Domain with the
SD_SHARE_PKG_RESOURCES flag. This is the MC layer (cpu_core_flags() in
default_topology[]). So the scheduler would think that [0-5] are sharing
LLC.

You have LLC at:

cat /sys/devices/system/cpu/cpu0/cache/index2/shared_cpu_list
                                       ^^^^^^
0,3-5

but the scheduler sees the highest SD_SHARE_PKG_RESOURCES on MC:

cat /sys/kernel/debug/sched/domains/cpu0/domain1/flags
                                         ^^^^^^^
... SD_SHARE_PKG_RESOURCES ...

[...]

>> For one level (MC) yes, but not for 2 (MC and CLS). And cluster_id was
>> introduces for the 2. level.
>>
> 
> That sounds wrong and not what ACPI PPTT code says. My series just aligns
> with what is done with ACPI PPTT IIUC. I need to check that again if my
> understand differs from what is being done. But the example of Kunpeng920
> aligns with my understanding.

(1) IMHO, as long as we don't consider cache (llc) information in DT we
can't have the same coverage as ACPI.

Let's take an ACPI !CONFIG_NUMA Kunpeng920 as an example.

# cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
CLS
MC
DIE

# cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags
SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE
  SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING
  ^^^^^^^^^^^^^^^^^^^^^^
SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE
  SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING
  ^^^^^^^^^^^^^^^^^^^^^^
SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE
  SD_PREFER_SIBLING

cat /proc/schedstat | awk '{print $1 " " $2 }' | grep ^[cd] | head -4
cpu0 0
domain0 00000000,00000000,0000000f
domain1 00000000,00000000,00ffffff <-- (2)
domain2 ffffffff,ffffffff,ffffffff

cat /sys/devices/system/cpu/cpu0/topology/thread_siblings_list
0
cat /sys/devices/system/cpu/cpu0/topology/core_cpus_list
0
cat /sys/devices/system/cpu/cpu0/topology/cluster_cpus_list
0-3
cat /sys/devices/system/cpu/cpu0/topology/core_siblings_list
0-47
cat /sys/devices/system/cpu/cpu0/topology/package_cpus_list
0-47

The MC mask 00ffffff is not derived from any topology mask but from the
llc (index3) mask:

cat /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list
                                       ^^^^^^
0-23 <-- (2)


Coming back to the original request (the support of Armv9 L2 complexes
in Android) from Qing on systems like QC SM8450:

      .---------------.
CPU   |0 1 2 3 4 5 6 7|
      +---------------+
uarch |l l l l m m m b| (so called tri-gear: little, medium, big)
      +---------------+
  L2  |   |   | | | | |
      +---------------+
  L3  |<--         -->|
      +---------------+
      |<-- cluster -->|
      +---------------+
      |<--   DSU   -->|
      '---------------'

This still wouldn't be possible. We know that Phantom Domain (grouping
after uarch) is not supported in mainline but heavily used in Android
(legacy deps).

If we say we only support L2 sharing (asymmetric here since only CPU0-3
have it !!!) and we don't support Phantom then your approach will work
for such systems.
