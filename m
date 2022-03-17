Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1C54DC592
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiCQMLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiCQMLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:11:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 258A61A94AE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:10:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E10E1570;
        Thu, 17 Mar 2022 05:10:15 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5155D3F766;
        Thu, 17 Mar 2022 05:10:12 -0700 (PDT)
Message-ID: <73b491fe-b5e8-ebca-081e-fa339cc903e1@arm.com>
Date:   Thu, 17 Mar 2022 13:10:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched: dynamic config sd_flags if described in DT
To:     =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <1647331137-69890-1-git-send-email-wangqing@vivo.com>
 <68df2f49-9b74-7ea2-0178-be55824b3c89@arm.com>
 <SL2PR06MB3082DBB58303601F73FB77D3BD119@SL2PR06MB3082.apcprd06.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SL2PR06MB3082DBB58303601F73FB77D3BD119@SL2PR06MB3082.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2022 03:46, 王擎 wrote:
> 
>> (1) Can you share more information about your CPU topology?
>>
>> I guess it is a single DSU (DynamIQ Shared Unit) ARMv9 system with 8
>> CPUs? So L3 spans over [CPU0..CPU7].
>>
>> You also mentioned complexes. Am I right in assuming that [CPU0..CPU3]
>> are Cortex-A510 cores where each 2 CPUs share a complex?
>>
>> What kind of uarch are the CPUs in [CPU4..CPU7]? Are they Cortex-A510's
>> as well? I'm not sure after reading your email:
> 
> Yes, Android systems are currently used default_domain with wrong sd_flags, 
> take Qualcomm SM8450 as an example, the CPU and cache topology(1+3+4):

Ah, your system looks like this:

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

> |                           DSU                            |
> |           cluster0         |       cluster1     |cluster2|

^^^ Those aren't real clusters, hence the name <Phantom> SD. The cluster
is [CPU0...CPU7]. Android uses Phantom SD to subgroup CPUs with the same
uarch. That's why you get your MC->DIE SD's on your system and
SHARE_PKG_RESOURCES (ShPR) on MC, rather DIE.

Note, you should already have an asymmetric SD hierarchy. CPU7 should
only have DIE not MC! Each CPU has its own SD hierarchy!

> | core0  core1  core2  core3 |  core4 core5 core6 | core7  |
> |   complex0  |   complex1   |  ------------------------   |
> |   L2 cache  |   L2 cache   |   L2  |  L2 |  L2  |   L2   |
> |                         L3 cache                         |
> 
> The sched domain now:
> DIE[0-7]  (no SD_SHARE_PKG_RESOURCES)
> MC[0-3][4-6][7] (SD_SHARE_PKG_RESOURCES)
> 
> The sched domain should be:
> DIE[0-7]  (SD_SHARE_PKG_RESOURCES)
> MC[0-3][4-6][7] (no SD_SHARE_PKG_RESOURCES)

First remember, using Phantom SD in Android is already a hack. Normally
your system should only have an MC SD for each CPU (with ShPR).

Now, if you want to move ShPR from MC to DIE then a custom topology
table should do it, i.e. you don't have to change any generic task
scheduler code.

static inline int cpu_cpu_flags(void)
{
       return SD_SHARE_PKG_RESOURCES;
}

static struct sched_domain_topology_level custom_topology[] = {
#ifdef CONFIG_SCHED_SMT
        { cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
#endif

#ifdef CONFIG_SCHED_CLUSTER
        { cpu_clustergroup_mask, cpu_cluster_flags, SD_INIT_NAME(CLS) },
#endif

#ifdef CONFIG_SCHED_MC
        { cpu_coregroup_mask, SD_INIT_NAME(MC) },
                            ^^^^
#endif
        { cpu_cpu_mask, cpu_cpu_flags, SD_INIT_NAME(DIE) },
                        ^^^^^^^^^^^^^
        { NULL, },
};

set_sched_topology(custom_topology);

> *CLS[0-1][2-3](SD_SHARE_PKG_RESOURCES)

But why do you want to have yet another SD underneath MC for CPU0-CPU3?
sd_llc is assigned to the highest ShPR SD, which would be DIE.

>> https://lkml.kernel.org/r/SL2PR06MB30828CF9FF2879AFC9DC53D2BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com
>>
>> You might run into the issue that individual CPUs of your system see a
>> different SD hierarchy in case that [CPU4..CPU7] aren't Cortex-A510's,
>> i.e. CPUs not sharing complexes.
>>
>> (2) Related to your MC Sched Domain (SD) layer:
>>
>> If you have a single DSU ARMv9 system, then in Linux kernel mainline you
>> shouldn't have sub-clustering of [CPU0..CPU3] and [CPU4...CPU7].
>>
>> I.e. the cpu-map entry in your dts file should only list cores, not
>> clusters.
> 
> But in fact we will, as mentioned above.

OK, so your system needs this `fake` sub-grouping on uarch boundaries.
Probably because of (out-of-tree) Android/platform code? Have you tried
to run on a clean mainline SD hierarchy (only MC)? Is the Phantom SD
still required?

>> I know that in Android the cluster entries are used to sub-group
>> different uarch CPUs in an asymmetric CPU capacity system (a.k.a. Arm
>> DynamIQ and Phantom domains) but this is eclipsing the true L3 (LLC)
>> information and is not "supported" (in the sense of "used") in mainline.
>>
>> But I have a hard time to see what [CPU0..CPU3] or [CPU4..CPU7] are
>> shareing in your system.
> 
> They share L3 cache, but no share L2 which only shared within complex.

I should have written: What do they share exclusively? I can only see
that they ([CPU0..CPU3], [CPU4..CPU6], [CPU7]) share uarch exclusively.
Which relates to this fake (Phantom) SD. L3 is shared between all CPUs.

>> (3) Why do you want this different SD hierarchy?
>>
>> I assume in mainline your system will have a single SD which is MC (w/o
>> the Phantom domain approach from Android).
>>
>> You mentioned cpus_share_cache(). Or is it the extra SD level which
>> changes the behaviour of CFS load-balancing? I'm just wondering since
>> EAS wouldn't be affected here. I'm sure I can understand this better
>> once we know more about your CPU topology.
> 
> What I want to do is :
> 1.Config the right sd_llc to sd, better to get it dynamically from DT

So this should be ShPR on DIE. You have 2 choices here. Use flat MC SD
(mainline) or Phantom SD's + custom_topology.

> 2.Benefit from the shared cache(L2) of the complex
> i.e. when we look for sibling idle CPU, prior select the L2 shared CPU(inner complex) if L3 is all shared.

But cpus_share_cache() operates on sd_llc_id which relates to DIE SD
even for [CPU0..CPU3]?
