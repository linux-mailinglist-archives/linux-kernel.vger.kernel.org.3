Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CCA53E916
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbiFFJzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbiFFJzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:55:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CA0110C33B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:55:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D501F1596;
        Mon,  6 Jun 2022 02:55:03 -0700 (PDT)
Received: from bogus (unknown [10.57.9.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B21D3F66F;
        Mon,  6 Jun 2022 02:55:02 -0700 (PDT)
Date:   Mon, 6 Jun 2022 10:54:15 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 07/16] arch_topology: Use the last level cache
 information from the cacheinfo
Message-ID: <20220606095415.n26cugm2bo7d3rud@bogus>
References: <20220525081416.3306043-1-sudeep.holla@arm.com>
 <20220525081416.3306043-2-sudeep.holla@arm.com>
 <20220525081416.3306043-3-sudeep.holla@arm.com>
 <20220525081416.3306043-4-sudeep.holla@arm.com>
 <20220525081416.3306043-5-sudeep.holla@arm.com>
 <20220525081416.3306043-6-sudeep.holla@arm.com>
 <20220525081416.3306043-7-sudeep.holla@arm.com>
 <20220525081416.3306043-8-sudeep.holla@arm.com>
 <0bf199a0-251d-323c-974a-bfd4e26f4cce@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf199a0-251d-323c-974a-bfd4e26f4cce@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 04:26:00PM +0200, Dietmar Eggemann wrote:
> On 25/05/2022 10:14, Sudeep Holla wrote:
> > The cacheinfo is now initialised early along with the CPU topology
> > initialisation. Instead of relying on the LLC ID information parsed
> > separately only with ACPI PPTT elsewhere, migrate to use the similar
> > information from the cacheinfo.
> > 
> > This is generic for both DT and ACPI systems. The ACPI LLC ID information
> > parsed separately can now be removed from arch specific code.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/base/arch_topology.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 765723448b10..4c486e4e6f2f 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -663,7 +663,8 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
> >  		/* not numa in package, lets use the package siblings */
> >  		core_mask = &cpu_topology[cpu].core_sibling;
> >  	}
> > -	if (cpu_topology[cpu].llc_id != -1) {
> > +
> > +	if (last_level_cache_is_valid(cpu)) {
> >  		if (cpumask_subset(&cpu_topology[cpu].llc_sibling, core_mask))
> >  			core_mask = &cpu_topology[cpu].llc_sibling;
> >  	}
> > @@ -694,7 +695,7 @@ void update_siblings_masks(unsigned int cpuid)
> >  	for_each_online_cpu(cpu) {
> >  		cpu_topo = &cpu_topology[cpu];
> >  
> > -		if (cpu_topo->llc_id != -1 && cpuid_topo->llc_id == cpu_topo->llc_id) {
> > +		if (last_level_cache_is_shared(cpu, cpuid)) {
> >  			cpumask_set_cpu(cpu, &cpuid_topo->llc_sibling);
> >  			cpumask_set_cpu(cpuid, &cpu_topo->llc_sibling);
> >  		}
> 
> I tested v3 on a Kunpeng920 (w/o CONFIG_NUMA) and it looks
> like that last_level_cache_is_shared() isn't working as
> expected.
>

Thanks a lot for detailed instrumentation, I am unable to identify why it is
not working though. I will take a deeper look later.

-- 
Regards,
Sudeep
