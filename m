Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4BF548397
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 11:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbiFMJUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbiFMJUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:20:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE81018E34
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 02:20:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7023ED6E;
        Mon, 13 Jun 2022 02:20:03 -0700 (PDT)
Received: from [192.168.68.208] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3808B3F66F;
        Mon, 13 Jun 2022 02:20:01 -0700 (PDT)
Message-ID: <af7d6f49-09c5-6e60-988c-51c3c7c04d96@arm.com>
Date:   Mon, 13 Jun 2022 11:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 15/16] arch_topology: Set cluster identifier in each
 core/thread from /cpu-map
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
References: <20220525081416.3306043-10-sudeep.holla@arm.com>
 <20220525081416.3306043-11-sudeep.holla@arm.com>
 <20220525081416.3306043-12-sudeep.holla@arm.com>
 <20220525081416.3306043-13-sudeep.holla@arm.com>
 <20220525081416.3306043-14-sudeep.holla@arm.com>
 <20220525081416.3306043-15-sudeep.holla@arm.com>
 <20220525081416.3306043-16-sudeep.holla@arm.com>
 <947470ba-35fc-3c72-d01b-c0a7337216a2@arm.com>
 <20220606102159.dduxmvq4m2fm6gks@bogus>
 <CAKfTPtB8iPzEXipsJqNtd9-aJMKx-FAaiGMzOg58HgRQuo39iA@mail.gmail.com>
 <20220610102753.virkx47uyfsojol6@bogus>
Content-Language: en-US
In-Reply-To: <20220610102753.virkx47uyfsojol6@bogus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2022 12:27, Sudeep Holla wrote:
> On Fri, Jun 10, 2022 at 12:08:44PM +0200, Vincent Guittot wrote:
>> On Mon, 6 Jun 2022 at 12:22, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>>
> 
> [...]
> 
>>> Why ? Are you suggesting that we shouldn't present the hardware cluster
>>> to the topology because of the above reason ? If so, sorry that is not a
>>> valid reason. We could add login to return NULL or appropriate value
>>> needed in cpu_clustergroup_mask id it matches MC level mask if we can't
>>> deal that in generic scheduler code. But the topology code can't be
>>> compromised for that reason as it is user visible.
>>
>> I tend to agree with Dietmar. The legacy use of cluster node in DT
>> refers to the dynamiQ or legacy b.L cluster which is also aligned to
>> the LLC and the MC scheduling level. The new cluster level that has
>> been introduced recently does not target this level but some
>> intermediate levels either inside like for the kupeng920 or the v9
>> complex or outside like for the ampere altra. So I would say that
>> there is one cluster node level in DT that refers to the same MC/LLC
>> level and only an additional child/parent cluster node should be used
>> to fill the clustergroup_mask.
>>
> 
> Again I completely disagree. Let us look at the problems separately.
> The hardware topology that some of the tools like lscpu and lstopo expects
> what the hardware looks like and not the scheduler's view of the hardware.
> So the topology masks that gets exposed to the user-space needs fixing
> even today. I have reports from various tooling people about the same.
> E.g. Juno getting exposed as dual socket system is utter non-sense.
> 
> Yes scheduler uses most of the topology masks as is but that is not a must.
> There are these *group_mask functions that can implement what scheduler
> needs to be fed.
> 
> I am not sure why the 2 issues are getting mixed up and that is the main
> reason why I jumped into this to make sure the topology masks are
> not tampered based on the way it needs to be used for scheduler.

I'm all in favor of not mixing up those 2 issues. But I don't understand
why you have to glue them together.

(1) DT systems broken in userspace (lstopo shows Juno with 2 Packages)

(2) Introduce CONFIG_SCHED_CLUSTER for DT systems


(1) This can be solved with your patch-set w/o setting `(1. level)
    cpu-map cluster nodes`. The `socket nodes` taking over the
    functionality of the `cluster nodes` sorts out the `Juno is seen as
    having 2 packages`.
    This will make core_sibling not suitable for cpu_coregroup_mask()
    anymore. But this is OK since llc from cacheinfo (i.e. llc_sibling)
    takes over here.
    There is no need to involve `cluster nodes` anymore.

(2) This will only make sense for Armv9 L2 complexes if we connect `2.
    level cpu-map cluster nodes` with cluster_id and cluster_sibling.
    And only then clusters would mean the same thing in ACPI and DT.
    I guess this was mentioned already a couple of times.

> Both ACPI and DT on a platform must present exact same hardware topology
> to the user-space, there is no space for argument there.
> 
>> IIUC, we don't describe the dynamiQ level in ACPI which  uses cache
>> topology instead to define cpu_coregroup_mask whereas DT described the
>> dynamiQ instead of using cache topology. If you use cache topology
>> now, then you should skip the dynamiQ
>>
> 
> Yes, unless someone can work out a binding to represent that and convince
> DT maintainers ;).
> 
>> Finally, even if CLS and MC have the same scheduling behavior for now,
>> they might ends up with different scheduling properties which would
>> mean that replacing MC level by CLS one for current SoC would become
>> wrong
>>
> 
> Again as I mentioned to Dietmar, that is something we can and must deal with
> in those *group_mask and not expect topology mask to be altered to meet
> CLS/MC or whatever sched domains needs. Sorry, that is my strong opinion
> as the topology is already user-space visible and (tooling) people are
> complaining that DT systems are broken and doesn't match ACPI systems.
> 
> So unless someone gives me non-scheduler and topology specific reasons
> to change that, sorry but my opinion on this matter is not going to change ;).

`lstopo` is fine with a now correct /sys/.../topology/package_cpus (or
core_siblings (old filename). It's not reading
/sys/.../topology/cluster_cpus (yet) so why set it (wrongly) to 0x39 for
CPU0 on Juno when it can stay 0x01?

> You will get this view of topology, find a way to manage with all those
> *group_mask functions. By the way it is already handled for ACPI systems,
> so if you are not happy with that, then that needs fixing as this change
> set just aligns the behaviour on similar ACPI system. So the Juno example
> is incorrect for the reason that the behaviour of scheduler there is different
> with DT and ACPI.

[...]

