Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC6A573894
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiGMOTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbiGMOTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:19:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8ED61145A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:19:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1FFD1424;
        Wed, 13 Jul 2022 07:19:02 -0700 (PDT)
Received: from bogus (unknown [10.57.7.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74EBE3F73D;
        Wed, 13 Jul 2022 07:19:00 -0700 (PDT)
Date:   Wed, 13 Jul 2022 15:18:57 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, conor.dooley@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH -next] arch_topology: Fix cache attributes detection in
 the CPU hotplug path
Message-ID: <20220713141857.p3ruapm6b4in574j@bogus>
References: <20220713133344.1201247-1-sudeep.holla@arm.com>
 <Ys7QzJ14brtz23XY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys7QzJ14brtz23XY@kroah.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 04:03:56PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 13, 2022 at 02:33:44PM +0100, Sudeep Holla wrote:
> > init_cpu_topology() is called only once at the boot and all the cache
> > attributes are detected early for all the possible CPUs. However when
> > the CPUs are hotplugged out, the cacheinfo gets removed. While the
> > attributes are added back when the CPUs are hotplugged back in as part
> > of CPU hotplug state machine, it ends up called quite late after the
> > update_siblings_masks() are called in the secondary_start_kernel()
> > resulting in wrong llc_sibling_masks.
> > 
> > Move the call to detect_cache_attributes() inside update_siblings_masks()
> > to ensure the cacheinfo is updated before the LLC sibling masks are
> > updated. This will fix the incorrect LLC sibling masks generated when
> > the CPUs are hotplugged out and hotplugged back in again.
> > 
> > Reported-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/base/arch_topology.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> > 
> > Hi Conor,
> > 
> > Ionela reported an issue with the CPU hotplug and as a fix I need to
> > move the call to detect_cache_attributes() which I had thought to keep
> > it there from first but for no reason had moved it to init_cpu_topology().
> > 
> > Wonder if this fixes the -ENOMEM on RISC-V as this one is called on the
> > cpu in the secondary CPUs init path while init_cpu_topology executed
> > detect_cache_attributes() for all possible CPUs much earlier. I think
> > this might help as the percpu memory might be initialised in this case.
> > 
> > Anyways give this a try, also test the CPU hotplug and check if nothing
> > is broken on RISC-V. We noticed this bug only on one platform while
> > 
> > Regards,
> > Sudeep
> > 
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 441e14ac33a4..0424b59b695e 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -732,7 +732,11 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
> >  void update_siblings_masks(unsigned int cpuid)
> >  {
> >  	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
> > -	int cpu;
> > +	int cpu, ret;
> > +
> > +	ret = detect_cache_attributes(cpuid);
> > +	if (ret)
> > +		pr_info("Early cacheinfo failed, ret = %d\n", ret);
> 
> No erroring out?
> 

No, this is optional as not all platforms have cacheinfo in the DT and also
the scheduler must work even without the cache information. It may not produce
optimal performance but it must work.

Also we have seen on one RISC-V platform with probably low percpu allocation,
the early detection fails, but it works just fine later device_initcall().
That was the main reason for adding error log, but the idea is to continue
building the information for the scheduler domains even if the LLC information
can't be obtained. In case of failure, we assume all CPUs have only private
caches and no shared LLC.

Hope that makes sense. Let me know if you prefer to drop the error log or
anything else. I just added as we found cases of -ENOMEM on RISC-V and we
want to highlight that.

-- 
Regards,
Sudeep
