Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D94253E659
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbiFFKWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiFFKWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:22:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1639262CE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:22:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC7C71042;
        Mon,  6 Jun 2022 03:22:48 -0700 (PDT)
Received: from bogus (unknown [10.57.9.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40B5D3F66F;
        Mon,  6 Jun 2022 03:22:46 -0700 (PDT)
Date:   Mon, 6 Jun 2022 11:21:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 15/16] arch_topology: Set cluster identifier in each
 core/thread from /cpu-map
Message-ID: <20220606102159.dduxmvq4m2fm6gks@bogus>
References: <20220525081416.3306043-8-sudeep.holla@arm.com>
 <20220525081416.3306043-9-sudeep.holla@arm.com>
 <20220525081416.3306043-10-sudeep.holla@arm.com>
 <20220525081416.3306043-11-sudeep.holla@arm.com>
 <20220525081416.3306043-12-sudeep.holla@arm.com>
 <20220525081416.3306043-13-sudeep.holla@arm.com>
 <20220525081416.3306043-14-sudeep.holla@arm.com>
 <20220525081416.3306043-15-sudeep.holla@arm.com>
 <20220525081416.3306043-16-sudeep.holla@arm.com>
 <947470ba-35fc-3c72-d01b-c0a7337216a2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <947470ba-35fc-3c72-d01b-c0a7337216a2@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 02:30:04PM +0200, Dietmar Eggemann wrote:
> On 25/05/2022 10:14, Sudeep Holla wrote:
> > Let us set the cluster identifier as parsed from the device tree
> > cluster nodes within /cpu-map.
> > 
> > We don't support nesting of clusters yet as there are no real hardware
> > to support clusters of clusters.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/base/arch_topology.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index b8f0d72908c8..5f4f148a7769 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -492,7 +492,7 @@ static int __init get_cpu_for_node(struct device_node *node)
> >  }
> >  
> >  static int __init parse_core(struct device_node *core, int package_id,
> > -			     int core_id)
> > +			     int cluster_id, int core_id)
> >  {
> >  	char name[20];
> >  	bool leaf = true;
> > @@ -508,6 +508,7 @@ static int __init parse_core(struct device_node *core, int package_id,
> >  			cpu = get_cpu_for_node(t);
> >  			if (cpu >= 0) {
> >  				cpu_topology[cpu].package_id = package_id;
> > +				cpu_topology[cpu].cluster_id = cluster_id;
> >  				cpu_topology[cpu].core_id = core_id;
> >  				cpu_topology[cpu].thread_id = i;
> >  			} else if (cpu != -ENODEV) {
> > @@ -529,6 +530,7 @@ static int __init parse_core(struct device_node *core, int package_id,
> >  		}
> >  
> >  		cpu_topology[cpu].package_id = package_id;
> > +		cpu_topology[cpu].cluster_id = cluster_id;
> 
> I'm still not convinced that this is the right thing to do. Let's take
> the juno board as an example here. And I guess our assumption should be
> that we want to make CONFIG_SCHED_CLUSTER a default option, like
> CONFIG_SCHED_MC is. Simply to avoid a unmanageable zoo of config-option
> combinations.
>

Agreed on the config part.

> (1) Scheduler Domains (SDs) w/o CONFIG_SCHED_CLUSTER:
>
> MC  <-- !!!
> DIE
>
> (2) SDs w/ CONFIG_SCHED_CLUSTER:
>
> CLS <-- !!!
> DIE
>

Yes I have seen this.

> In (2) MC gets degenerated in sd_parent_degenerate() since CLS and MC
> cpumasks are equal and MC does not have any additional flags compared to
> CLS.
> I'm not convinced that we can change the degeneration rules without
> destroying other scenarios of the scheduler so that here MC stays and
> CLS gets removed instead.
>

Why ? Are you suggesting that we shouldn't present the hardware cluster
to the topology because of the above reason ? If so, sorry that is not a
valid reason. We could add login to return NULL or appropriate value
needed in cpu_clustergroup_mask id it matches MC level mask if we can't
deal that in generic scheduler code. But the topology code can't be
compromised for that reason as it is user visible.

> Even though MC and CLS are doing the same right now from the perspective
> of the scheduler, we should also see MC and not CLS under (2). CLS only
> makes sense longer term if the scheduler also makes use of it (next to
> MC) in the wakeup-path for instance. Especially when this happens, a
> platform should always construct the same scheduler domain hierarchy, no
> matter which CONFIG_SCHED_XXX options are enabled.
>
>
> You can see this in update_siblings_masks()
>
>     if (last_level_cache_is_shared)
>         set llc_sibling
>
>     if (cpuid_topo->package_id != cpu_topo->package_id)
>         continue
>
>     set core_sibling
>
>   If llc cache and socket boundaries are congruent, llc_sibling and
>   core_sibling are the same.
>
>     if (cpuid_topo->cluster_id != cpu_topo->cluster_id)
>         continue
>
>     set cluster_sibling
>
>   Now we potentially set clusters. Since socket=0 is by default and we
>   use the existing juno.dts, the cluster nodes end up being congruent to
>   the llc cache cpumasks as well.
>

Correct and I see no problems as it matches what the hardware is. So I am
not expecting any change in any cpumasks there as they all are aligned with
the hardware.

> The problem is that we code `llc cache` and `DT cluster nodes` as the
> same thing in juno.dts. 

Why is that a problem ? If so, blame hardware and deal with it as we have to
😄 as usual we get all sorts of topology.

> `Cluster0/1` are congruent with the llc information, although they should 
> be actually `socket0/1` right now.

That was complete non-sense and wrong. Boot and check in ACPI mode.

> But we can't set-up a cpu-map with a `socketX` containing `coreY` directly.
> And then we use llc_sibling and cluster_sibling in two different SD
> cpumask functions (cpu_coregroup_mask() and cpu_clustergroup_mask()).
>

We just need to deal with that. How is that dealt today with ACPI. My
changes are making these aligned with ACPI. If something is broken as
per you understanding with ACPI, then that needs fixing. The topology
presented and parsed by ACPI is correct and we are aligning DT with that.
There is no question on that.

> Remember, CONFIG_SCHED_CLUSTER was introduced in ACPI/PPTT as a cpumask
> which is a subset of the cpumasks of CONFIG_SCHED_MC.
>

But that change also introduced cluster masks into the topology which again
aligns with my changes.

> IMHO we probably could just introduce your changes w/o setting `cpu-map
> cluster nodes` in DT for now. We would just have to make sure that for
> all `*.dts` affected, the `llc cache` info can take over the old role of
> the `cluster nodes`. In this case e.g. Juno ends up with MC, DIE no
> matter if CONFIG_SCHED_CLUSTER is set or not.

Sure I can agree with that if Juno ACPI is not broken. But I am sure it is
broken based on your argument above. If it is, that needs fixing and this
series just gets topology parsing in both ACPI and DT aligned, nothing
more or nothing less. In the process it may be introducing clusters, but
if it is not dealt correctly in ACPI, then it won't be in DT too and needs
fixing anyways.

--
Regards,
Sudeep
