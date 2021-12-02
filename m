Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9782A466DFB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377598AbhLBXrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:47:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:54125 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232981AbhLBXro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:47:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="223745010"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="223745010"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 15:44:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="561399309"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 02 Dec 2021 15:44:13 -0800
Date:   Thu, 2 Dec 2021 15:43:07 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] thermal: intel: hfi: Handle CPU hotplug events
Message-ID: <20211202234307.GA334@ranerica-svr.sc.intel.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-5-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0gemmV1Lz3+9iKz1eiXtkyDc3+4+po4Eidchzk+J2=ceA@mail.gmail.com>
 <20211130132137.GA25524@ranerica-svr.sc.intel.com>
 <CAJZ5v0iXBn1o9ZFzNaYU4ft=JcRfNv7AJ8Sq-9HbBJbp60LpWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iXBn1o9ZFzNaYU4ft=JcRfNv7AJ8Sq-9HbBJbp60LpWQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 02:32:42PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 30, 2021 at 2:22 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > On Wed, Nov 24, 2021 at 03:48:49PM +0100, Rafael J. Wysocki wrote:
> > > On Sat, Nov 6, 2021 at 2:34 AM Ricardo Neri
> > > <ricardo.neri-calderon@linux.intel.com> wrote:
> 
> [cut]
> 
> > > > +/**
> > > > + * intel_hfi_offline() - Disable HFI on @cpu
> > > > + * @cpu:       CPU in which the HFI will be disabled
> > > > + *
> > > > + * Remove @cpu from those covered by its HFI instance.
> > > > + *
> > > > + * On some processors, hardware remembers previous programming settings even
> > > > + * after being reprogrammed. Thus, keep HFI enabled even if all CPUs in the
> > > > + * die/package of @cpu are offline. See note in intel_hfi_online().
> > > > + */
> > > > +void intel_hfi_offline(unsigned int cpu)
> > > > +{
> > > > +       struct cpumask *die_cpumask = topology_core_cpumask(cpu);
> > > > +       struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, cpu);
> > > > +       struct hfi_instance *hfi_instance;
> > > > +
> > > > +       if (!boot_cpu_has(X86_FEATURE_INTEL_HFI))
> > > > +               return;
> > > > +
> > > > +       hfi_instance = info->hfi_instance;
> > > > +       if (!hfi_instance)
> > > > +               return;
> > > > +
> > > > +       if (!hfi_instance->initialized)
> > > > +               return;
> > > > +
> > > > +       mutex_lock(&hfi_lock);
> > > > +
> > > > +       /*
> > > > +        * We were using the core cpumask of @cpu to track CPUs in the same
> > > > +        * die/package. Now it is going offline and we need to find another
> > > > +        * CPU we can use.
> > > > +        */
> > > > +       if (die_cpumask == hfi_instance->cpus) {
> > > > +               int new_cpu;
> > > > +
> > > > +               new_cpu = cpumask_any_but(hfi_instance->cpus, cpu);
> > > > +               if (new_cpu >= nr_cpu_ids)
> > > > +                       /* All other CPUs in the package are offline. */
> > > > +                       hfi_instance->cpus = NULL;
> > > > +               else
> > > > +                       hfi_instance->cpus = topology_core_cpumask(new_cpu);
> > >
> > > Hmmm.  Is topology_core_cpumask() updated when CPUs go offline and online?
> >
> > Yes. A CPU going offline is cleared from its siblings' cpumask [1] and its own [2]
> > in remove_siblinginfo() via cpu_disable_common(). A CPU going online is set
> > in its siblings' cpumask and its own in set_cpu_sibling_map() [3].
> 
> OK, so it is necessary to ensure that intel_hfi_offline() will always
> run after remove_siblinginfo() so it sees the updated mask.  How do we
> ensure that?

I don't think that is possible. remove_siblinginfo() is called from
CPUHP_TEARDOWN_CPU, which always happens after CPUHP_AP_OFFLINE, if I
understand correctly.

I guess that I will need to use a local cpumask as other drivers do.

Thanks and BR,
Ricardo
