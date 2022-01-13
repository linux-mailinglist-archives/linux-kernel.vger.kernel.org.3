Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8696248D949
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiAMNrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:47:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:39238 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234338AbiAMNrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642081623; x=1673617623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0wZIMhV0JR0149ZU+xCqbzummYSqvoRtpN3DEUm30Eo=;
  b=kaPBhlEzH1tjvGeVxlFrFlzDssoDQLtyCx/P0QmxIosuONZ6EhoYJCf2
   mXdUq1yA9r3U2xFCNL8WnBAyVmJgQnOORH+pYMiEUW23heCMa/idl6EY+
   skeYIIYA59JcGBPUnlhcLYTI+hfZLArshACsGzuzL7VZwGYxtTZ+sm0tY
   NmsQuUg4B4MpX/wcLX9V3hmSOBvBFgMRhcGpxKfzzcveDJtcPpSYHhqwY
   8NJ/mvVrrDmlLcwptjdl+/5ZCBQ4OI80vfY7IEq6gRGh5irxqz+2kr6X5
   i2YvYCq91Iv5f3L3M2pDSljOoCyJERbvBlK2d7eh1lCNnvhby4WzQs9O6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243807158"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="243807158"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 05:47:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="691804885"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2022 05:47:02 -0800
Date:   Thu, 13 Jan 2022 05:48:58 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] thermal: intel: hfi: Enable notification interrupt
Message-ID: <20220113134858.GA15346@ranerica-svr.sc.intel.com>
References: <20220108034743.31277-1-ricardo.neri-calderon@linux.intel.com>
 <20220108034743.31277-6-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0jbr=O+pMAikzWZZsFdcg5P8EWvW_zJRT0Ls21iEbJBWA@mail.gmail.com>
 <0d50595854a9d9cd25eb3ac179bd39cf1cc30bcd.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d50595854a9d9cd25eb3ac179bd39cf1cc30bcd.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 03:26:41PM -0800, Srinivas Pandruvada wrote:
> On Wed, 2022-01-12 at 20:47 +0100, Rafael J. Wysocki wrote:
> > On Sat, Jan 8, 2022 at 4:46 AM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > When hardware wants to inform the operating system about updates in
> > > the HFI
> > > table, it issues a package-level thermal event interrupt. For this,
> > > hardware has new interrupt and status bits in the
> > > IA32_PACKAGE_THERM_
> > > INTERRUPT and IA32_PACKAGE_THERM_STATUS registers. The existing
> > > thermal
> > > throttle driver already handles thermal event interrupts: it
> > > initializes
> > > the thermal vector of the local APIC as well as per-CPU and
> > > package-level
> > > interrupt reporting. It also provides routines to service such
> > > interrupts.
> > > Extend its functionality to also handle HFI interrupts.
> > > 
> > > The frequency of the thermal HFI interrupt is specific to each
> > > processor
> > > model. On some processors, a single interrupt happens as soon as
> > > the HFI is
> > > enabled and hardware will never update HFI capabilities afterwards.
> > > On
> > > other processors, thermal and power constraints may cause thermal
> > > HFI
> > > interrupts every tens of milliseconds.
> > > 
> > > To not overwhelm consumers of the HFI data, use delayed work to
> > > throttle
> > > the rate at which HFI updates are processed.
> > > 
> > > 
> 
> [...]
> 
> > > +void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
> > > +{
> > > +       struct hfi_instance *hfi_instance;
> > > +       int cpu = smp_processor_id();
> > > +       struct hfi_cpu_info *info;
> > > +       u64 new_timestamp;
> > > +
> > > +       if (!pkg_therm_status_msr_val)
> > > +               return;
> > > +
> > > +       info = &per_cpu(hfi_cpu_info, cpu);
> > > +       if (!info)
> > > +               return;
> > > +
> > > +       /*
> > > +        * It is possible that we get an HFI thermal interrupt on
> > > this CPU
> > > +        * before its HFI instance is initialized.
> Although this code can handle this situation, you can avoid this.
> 
> You can call intel_hfi_online(cpu) before 
> "
> l = apic_read(APIC_LVTTHMR);
> 	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
> "

Indeed this could work.

intel_hfi_online() also enables the HFI. It is possible to get an HFI
interrupt as soon as we enable it. I was concerned about getting the
interrupt with APIC_LVTTHMR masked and miss it. This should not be
a problem since we will get it as soon as we unmask it.

> in thermal_throttle_online()
> 
> In the same way call intel_hfi_offline(cpu)
> after
> 
> /* Mask the thermal vector before draining evtl. pending work */
> 	l = apic_read(APIC_LVTTHMR);
> 	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
> 
> in thermal_throttle_offline()

Sure, I can do this. 

> 
> 
> > >  This is not a problem. The
> > > +        * CPU that enabled the interrupt for this package will
> > > also get the
> > > +        * interrupt and is fully initialized.
> > > +        */
> > > +       hfi_instance = info->hfi_instance;
> > > +       if (!hfi_instance)
> > > +               return;
> > 
> > Generally, a CPU whose info has been initialized can be offline, so
> > this code may run on an offline CPU.
> > 
> > I'm not actually sure if this is a concern, but just mentioning it in
> > case it is.
> > 
> It will not matter as the handler of the message should be handle case
> as CPU can go offline later after the message even if the CPU was
> offline.
> But I think we can avoid this situation.
> 
> > > +
> > > +       /*
> > > +        * On most systems, all CPUs in the package receive a
> > > package-level
> > > +        * thermal interrupt when there is an HFI update. It is
> > > sufficient to
> > > +        * let a single CPU to acknowledge the update and schedule
> > > work to
> > > +        * process it. The remaining CPUs can resume their work.
> > > +        */
> > > +       if (!raw_spin_trylock(&hfi_instance->event_lock))
> > > +               return;
> > > +
> > > +       /* Skip duplicated updates. */
> > > +       new_timestamp = *(u64 *)hfi_instance->hw_table;
> > > +       if (*hfi_instance->timestamp == new_timestamp) {
> > > +               raw_spin_unlock(&hfi_instance->event_lock);
> > > +               return;
> > > +       }
> > > +
> > > +       raw_spin_lock(&hfi_instance->table_lock);
> > > +
> > > +       /*
> > > +        * Copy the updated table into our local copy. This
> > > includes the new
> > > +        * timestamp.
> > > +        */
> > > +       memcpy(hfi_instance->local_table, hfi_instance->hw_table,
> > > +              hfi_features.nr_table_pages << PAGE_SHIFT);
> > > +
> > > +       raw_spin_unlock(&hfi_instance->table_lock);
> > > +       raw_spin_unlock(&hfi_instance->event_lock);
> > > +
> > > +       /*
> > > +        * Let hardware know that we are done reading the HFI table
> > > and it is
> > > +        * free to update it again.
> > > +        */
> > > +       pkg_therm_status_msr_val &= THERM_STATUS_CLEAR_PKG_MASK &
> > > +                                   ~PACKAGE_THERM_STATUS_HFI_UPDAT
> > > ED;
> > > +       wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS,
> > > pkg_therm_status_msr_val);
> > > +
> > > +       schedule_delayed_work(&hfi_instance->update_work,
> > > HFI_UPDATE_INTERVAL);
> > 
> > AFAICS, 
> For my understanding:
> 
> > if update_work has been scheduled already,
> queue_delayed_work_on is called
> 
> >  but is not pending
> > yet, the delay will be set to the current time plus
> > HFI_UPDATE_INTERVAL, but shouldn't it actually run earlier in that
> > case?
> 
> 
> "
> 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT,
> work_data_bits(work))) {
> 		__queue_delayed_work(cpu, wq, dwork, delay);
> 		ret = true;
> 	}
> "
> Pending bit will be set only one time, so delay will be from 
> the first call of queue_delayed_work_on() + HFI_UPDATE_INTERVAL.
> 
> So on subsequent calls of schedule_delayed_work() the delay is always
> with reference to first call.
> 
> > 
> > Also it looks like the processing introduced in the next patch can
> > take quite a bit of time if there is a sufficiently large number of
> > CPUs in the package, so is it suitable for system_wq in all cases?
> > 
> Good question. What is the threshold of not using system_wq?
> With current set of max cpus/package, I did experiments with busy
> systems with a test functions with several workqueues and check if they
> drift in expiry. But I think we can move away from system_wq. Can this
> be add on patch?

Sure, I can do this.

Thanks and BR,
Ricardo
