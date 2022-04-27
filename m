Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB32511EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbiD0Puz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbiD0Pux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:50:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CF4353A57
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:47:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62764ED1;
        Wed, 27 Apr 2022 08:47:33 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D8753F73B;
        Wed, 27 Apr 2022 08:47:31 -0700 (PDT)
Message-ID: <9f0589d5-ab0a-9203-b961-984c61cc7283@arm.com>
Date:   Wed, 27 Apr 2022 17:47:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] arm64: add SCHED_CLUSTER's dependency on ACPI
Content-Language: en-US
To:     =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>
References: <1650855303-91388-1-git-send-email-wangqing@vivo.com>
 <20220425100635.ig4dxvlflglfagpx@bogus>
 <SL2PR06MB308217E24459AB685FBF6FD2BDF89@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <20220425165946.qb6xilgmjahdh4pa@bogus>
 <SL2PR06MB3082544EFB9C6F518A2EBF04BDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <20220426064053.h4rwvcdvmwxj2hmt@bogus>
 <SL2PR06MB3082F1AEE684E638C1B5F226BDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <20220426132511.7zo4w42kauvrq26n@bogus>
 <2244a7f7-9894-06a0-ea51-edf84f6caada@arm.com>
 <SL2PR06MB3082EA14946F2E207B3043E2BDFA9@SL2PR06MB3082.apcprd06.prod.outlook.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <SL2PR06MB3082EA14946F2E207B3043E2BDFA9@SL2PR06MB3082.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 04:18, 王擎 wrote:
> 
>>> On Tue, Apr 26, 2022 at 06:52:34AM +0000, 王擎 wrote:
>>>>
>>>>>>>>>> From: Wang Qing <wangqing@vivo.com>

[...]

>>      .---------------.
>> CPU   |0 1 2 3 4 5 6 7|
>>      +---------------+
>> uarch |l l l l m m m b| (so called tri-gear: little, medium, big)
>>      +---------------+
>>  L2  |   |   | | | | |
>>      +---------------+
>>  L3  |<--         -->|
>>      +---------------+
>>      |<-- cluster -->|
>>      +---------------+
>>      |<--   DSU   -->|
>>      '---------------'
>>
>> (and I'm not saying here it does!) then the existing SCHED_CLUSTER
>> should be used in DT as well. Since it provides exactly the same
>> functionality for the task scheduler no matter whether it's setup from
>> ACPI or DT.
>>
>> parse_cluster() -> parse_core() should be changed to be able to decode
>> both id's (package_id and cluster_id) in this case.
> 
> Totally agree, but not implemented yet. Because now cluster_id is used
> to describe the package/socket, the modification will involve all DTS.

You're talking about the fact that 1. level clusterX (1) in cpu_map is
used to set `cpu_topology[cpu].package_id`, right? That's the
information for the DIE layer.
The first level cluster[0,1,2] spawn all 8 CPUs and form 3 groups of
CPUS (0-3, 4-6, 7), the later sched groups of the DIE sched domain.
We don't have any socketN since it is a single socket system. Think
about a system with 2 DSUs where you would have socket[0,1].

Sub-chapter 4 in `Documentation/devicetree/bindings/cpu/cpu-topology.txt`:

cpu-map {
        socket0 {
                cluster0 { <--- (1)

Sub-chapter 3 says:

  - cluster node

    ... A system can contain several layers of clustering within a   
    single physical socket and cluster nodes can be contained in parent 
    cluster nodes.

    A cluster node's child nodes must be:
      one or more cluster nodes

This multi-level cluster thing hasn't been coded yet.

parse_cluster()

    ...
    /*
     * First check for child clusters; we currently ignore any
     * information about the nesting of clusters and present the
     * scheduler with a flat list of them.
     */
    ...

[...]

>> I pimped my Hikey 960 to look like one of those Armv9 4-3-1 systems with
>> L2-complexes on the LITTLES and I get:
> 
> This system is exactly what I mentioned, but I have a question,
> How did you parse out the cluster_id based on foo0/foo2?
> Because if ACPI is not used, cluster_id is always -1.

I haven't put in the extension to decode a 2-level clusterX cpu_map in
parse_cluster() -> parse_core(). I just did a mock-up for illustration
purpose inside parse_core() for my H960 with a 4-3-1 cpu-map:

cpu-map
    cluster0
        core0
        core1
        core2
        core3
    cluster1
        core0
        core1
        core2
    cluster2
        core0

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1d6636ebaac5..8af40f13fdb5 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -529,6 +529,11 @@ static int __init parse_core(struct device_node *core, int package_id,
 
                cpu_topology[cpu].package_id = package_id;
                cpu_topology[cpu].core_id = core_id;
+
+               /* mock-up CLS SD on 4-3-1 Armv9 DSU cluster w/ L2-complexes */
+               if (cpu <= 3)
+                       cpu_topology[cpu].cluster_id = cpu / 2;
+
        } else if (leaf && cpu != -ENODEV) {
                pr_err("%pOF: Can't get CPU for leaf core\n", core);
                return -EINVAL;

And on the scheduler-side I only had to enable CONFIG_SCHED_CLUSTER and
everything worked just fine, no need for any arm64-specific topo table
and alike.

IMHO, this is what you have to do. Make a 2 level cluster cpumap:

cpu-map
    cluster0
        cluster0
            core0
            core1
        cluster1
            core2
            core3
    cluster1
        core0
        core1
        core2
    cluster2
        core0

parse-able and set `cpu_topology[cpu].cluster_id` in parse_core().
 
> What I want to do is to change the foo0/foo2 to complex0/complex2 here,
> then parse it like parse_cluster() -> parse_complex() -> parse_core().

You should read `Documentation/devicetree/bindings/cpu/cpu-topology.txt`
and implement the multi-level cluster approach instead. Big advantage
would be that there won't be any DT related changes/extensions needed.

[...]

> Yes, that's what I want, but still a little confused, why we use MC to
> describe "cluster" and use CLS describe "complex", can you show some details?

The DT entity `cluster` has nothing to do with the task scheduler domain
name `SCHED_CLUSTER`. The name is actually meaningless and just there for
debug purposes.
