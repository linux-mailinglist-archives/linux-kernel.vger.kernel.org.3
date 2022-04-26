Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0245108C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353835AbiDZTSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243674AbiDZTSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:18:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28F935F91
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:15:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BFE823A;
        Tue, 26 Apr 2022 12:15:19 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 412C53F774;
        Tue, 26 Apr 2022 12:15:17 -0700 (PDT)
Message-ID: <2244a7f7-9894-06a0-ea51-edf84f6caada@arm.com>
Date:   Tue, 26 Apr 2022 21:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] arm64: add SCHED_CLUSTER's dependency on ACPI
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>,
        =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220426132511.7zo4w42kauvrq26n@bogus>
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

On 26/04/2022 15:25, Sudeep Holla wrote:
> On Tue, Apr 26, 2022 at 06:52:34AM +0000, 王擎 wrote:
>>
>>>>>>>> From: Wang Qing <wangqing@vivo.com>
>>>>>>>>
>>>>>>>> cluster sched_domain configured by cpu_topology[].cluster_sibling, 
>>>>>>>> which is set by cluster_id, cluster_id can only get from ACPI.
>>>>>>>>
>>>>>>>> If the system does not enable ACPI, cluster_id is always -1, even enable
>>>>>>>> SCHED_CLUSTER is invalid, this is misleading. 
>>>>>>>>
>>>>>>>> So we add SCHED_CLUSTER's dependency on ACPI here.
>>>>>>>>
>>>>>>>
>>>>>>> Any reason why this can't be extended to support DT based systems via
>>>>>>> cpu-map in the device tree. IMO we almost have everything w.r.t topology
>>>>>>> in DT and no reason to deviate this feature between ACPI and DT.
>>>>>>>
>>>>>> That's the problem, we parse out "cluster" info according to the
>>>>>> description in cpu-map, but do assign it to package_id, which used to
>>>>>> configure the MC sched domain, not cluster sched domain.
>>>>>>
>>>>>
>>>>> Right, we haven't updated the code after updating the bindings to match
>>>>> ACPI sockets which are the physical package boundaries. Clusters are not
>>>>> the physical boundaries and the current topology code is not 100% aligned
>>>>> with the bindings after Commit 849b384f92bc ("Documentation: DT: arm: add
>>>>> support for sockets defining package boundaries")
>>>>
>>>> I see, but this commit is a long time ago, why hasn't it been used widely.
>>>> Maybe I can help about it if you need.
>>>>
>>>
>>> I assume no one cared or had a requirement for the same.
>>
>> It took me a while to find the root cause why enabling SCHED_CLUSTER
>> didn't work.
>>
>> We should add SCHED_CLUSTER's dependency before implementation.
>> Otherwise, everyone who doesn't have ACPI but use SCHED_CLUSTER 
>> will have this problem.
>>
> 
> I am fine with that or mark it broken for DT, but ideally I wouldn't
> want to create unnecessary dependency on ACPI or DT when both supports
> the feature.

IMHO trying to introduce SCHED_COMPLEX for DT next to the linux-wide
available SCHED_CLUSTER (used only for ACPI right now) is the wrong way.

_If_ asymmetric sub-clustering of CPUs underneath LLC (L3) makes any
sense on ARMv9 single DSU systems like:

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

(and I'm not saying here it does!) then the existing SCHED_CLUSTER
should be used in DT as well. Since it provides exactly the same
functionality for the task scheduler no matter whether it's setup from
ACPI or DT.

parse_cluster() -> parse_core() should be changed to be able to decode
both id's (package_id and cluster_id) in this case.

DT's cpu_map would have to be changed to code 2 level setups.

For a system like the one above it should look like:

                cpu-map {
                        cluster0 {
                                foo0 {
                                        core0 {
                                                cpu = <&cpu0>;
                                        };
                                        core1 {
                                                cpu = <&cpu1>;
                                        };
                                };
                                foo2 {
                                        core2 {
                                                cpu = <&cpu2>;
                                        };
                                        core3 {
                                                cpu = <&cpu3>;
                                        };
                                };
                        };
                        cluster1 {
                                core0 {
                                        cpu = <&cpu4>;
                                };
                                core1 {
                                        cpu = <&cpu5>;
                                };
                                core2 {
                                        cpu = <&cpu6>;
                                };
                        };
                        cluster2 {
                                core0 {
                                        cpu = <&cpu7>;
                                };
                        };
                };

I pimped my Hikey 960 to look like one of those Armv9 4-3-1 systems with
L2-complexes on the LITTLES and I get:

# cat /sys/kernel/debug/sched/domains/cpu*/domain*/name
CLS
MC
DIE

CLS
MC
DIE

CLS
MC
DIE

CLS
MC
DIE

MC
DIE

MC
DIE

MC
DIE

DIE

cat /proc/schedstat | awk '{print $1 " " $2 }' | grep ^[cd]

cpu0 0
domain0 03
domain1 0f
domain2 ff
cpu1 0
domain0 03
domain1 0f
domain2 ff
cpu2 0
domain0 0c
domain1 0f
domain2 ff
cpu3 0
domain0 0c
domain1 0f
domain2 ff
cpu4 0
domain0 70
domain1 ff
cpu5 0
domain0 70
domain1 ff
cpu6 0
domain0 70
domain1 ff
cpu7 0
domain0 ff

Like I mentioned earlier, I'm not sure if this additional complexity
makes sense on mobile systems running EAS (since only CFS load-balancing
on little CPUs would be affected).

But my hunch is that this setup is what you want for your system. If we
could agree on this one, that would already be some progress to see the
entire story here.
