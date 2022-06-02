Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4853C53BAB4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiFBO0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiFBO0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:26:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE6642A143D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:26:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 969671063;
        Thu,  2 Jun 2022 07:26:12 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 196383F66F;
        Thu,  2 Jun 2022 07:26:10 -0700 (PDT)
Message-ID: <0bf199a0-251d-323c-974a-bfd4e26f4cce@arm.com>
Date:   Thu, 2 Jun 2022 16:26:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 07/16] arch_topology: Use the last level cache
 information from the cacheinfo
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
References: <20220525081416.3306043-1-sudeep.holla@arm.com>
 <20220525081416.3306043-2-sudeep.holla@arm.com>
 <20220525081416.3306043-3-sudeep.holla@arm.com>
 <20220525081416.3306043-4-sudeep.holla@arm.com>
 <20220525081416.3306043-5-sudeep.holla@arm.com>
 <20220525081416.3306043-6-sudeep.holla@arm.com>
 <20220525081416.3306043-7-sudeep.holla@arm.com>
 <20220525081416.3306043-8-sudeep.holla@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220525081416.3306043-8-sudeep.holla@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2022 10:14, Sudeep Holla wrote:
> The cacheinfo is now initialised early along with the CPU topology
> initialisation. Instead of relying on the LLC ID information parsed
> separately only with ACPI PPTT elsewhere, migrate to use the similar
> information from the cacheinfo.
> 
> This is generic for both DT and ACPI systems. The ACPI LLC ID information
> parsed separately can now be removed from arch specific code.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/arch_topology.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 765723448b10..4c486e4e6f2f 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -663,7 +663,8 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
>  		/* not numa in package, lets use the package siblings */
>  		core_mask = &cpu_topology[cpu].core_sibling;
>  	}
> -	if (cpu_topology[cpu].llc_id != -1) {
> +
> +	if (last_level_cache_is_valid(cpu)) {
>  		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
>  			core_mask = &cpu_topology[cpu].llc_sibling;
>  	}
> @@ -694,7 +695,7 @@ void update_siblings_masks(unsigned int cpuid)
>  	for_each_online_cpu(cpu) {
>  		cpu_topo = &cpu_topology[cpu];
>  
> -		if (cpu_topo->llc_id != -1 && cpuid_topo->llc_id == cpu_topo->llc_id) {
> +		if (last_level_cache_is_shared(cpu, cpuid)) {
>  			cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
>  			cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
>  		}

I tested v3 on a Kunpeng920 (w/o CONFIG_NUMA) and it looks
like that last_level_cache_is_shared() isn't working as
expected.

I instrumented cpu_coregroup_mask() like:

const struct cpumask *cpu_coregroup_mask(int cpu)
{
        const cpumask_t *core_mask = cpumask_of_node(cpu_to_node(cpu));

        if (cpumask_subset(&cpu_topology[cpu].core_sibling, core_mask)) {
                core_mask = &cpu_topology[cpu].core_sibling;
                (1)
        }

	(2)

        if (last_level_cache_is_valid(cpu)) {
                if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
                        core_mask = &cpu_topology[cpu].llc_sibling;
                        (3)
        }

        if (IS_ENABLED(CONFIG_SCHED_CLUSTER) &&
            cpumask_subset(core_mask, &cpu_topology[cpu].cluster_sibling))
                core_mask = &cpu_topology[cpu].cluster_sibling;
                (4)

        (5)
        return core_mask;
}

and got:

(A) v3 patch-set:

[   11.561133] (1) cpu_coregroup_mask[0]=0-47
[   11.565670] (2) last_level_cache_is_valid(0)=1
[   11.570587] (3) cpu_coregroup_mask[0]=0    <-- llc_sibling=0 (should be 0-23)
[   11.574833] (4) cpu_coregroup_mask[0]=0-3  <-- Altra hack kicks in!
[   11.579275] (5) cpu_coregroup_mask[0]=0-3

# cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
CLS
DIE

# cat /proc/schedstat | awk '{print $1 " " $2 }' | grep ^[cd] | head -3
cpu0 0
domain0 00000000,00000000,0000000f
domain1 ffffffff,ffffffff,ffffffff

So the MC domain is missing.

(B) mainline as reference (cpu_coregroup_mask() slightly different):

[   11.585008] (1) cpu_coregroup_mask[0]=0-47
[   11.589544] (3) cpu_coregroup_mask[0]=0-23 <-- !!!
[   11.594079] (5) cpu_coregroup_mask[0]=0-23

# cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
CLS
MC                                            <-- !!!
DIE

# cat /proc/schedstat | awk '{print $1 " " $2 }' | grep ^[cd] | head -4
cpu0 0
domain0 00000000,00000000,0000000f
domain1 00000000,00000000,00ffffff            <-- !!!
domain2 ffffffff,ffffffff,ffffffff
