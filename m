Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E558A48CF17
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 00:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiALX0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 18:26:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:10603 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235404AbiALX0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642030010; x=1673566010;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A8NXBKY11uBwem2fBUT79Oaol16Pmltoe0d0Hr8s254=;
  b=OJGZbqjdlU4X/7Q+a2I29upiSlWL9AgKEzzOd6eMwgX7pzehtoieA+ZJ
   vU9ptd8b+ONTF7yKZF95v/v8EFhCuGYMMP78k1hDQHzuK5waZXxu4CPq9
   hC+T14UckjtCLujWayLk4rk17GqGosqLqTyNv4UHI4pUP531UO/9zSzlc
   vczr1wEOBrVH1v+bqEraZU1X0O0M7YSAh/8N9CHBhp35/QP/MqPgPSBW5
   lYDlzZuTZB9blnw7eoB9hb4j0EIwFaXB8RQ+UXDSDwQK5MFSsSgasDICY
   DlsAKvdt9ZhFAU1Wrh3EiwmM9Ceb7Ulz3Q919UBeN7GE8oFjpp7Hh0lSY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243829706"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="243829706"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:26:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529411586"
Received: from japete-mobl1.amr.corp.intel.com ([10.212.252.179])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:26:44 -0800
Message-ID: <0d50595854a9d9cd25eb3ac179bd39cf1cc30bcd.camel@linux.intel.com>
Subject: Re: [PATCH v4 5/7] thermal: intel: hfi: Enable notification
 interrupt
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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
Date:   Wed, 12 Jan 2022 15:26:41 -0800
In-Reply-To: <CAJZ5v0jbr=O+pMAikzWZZsFdcg5P8EWvW_zJRT0Ls21iEbJBWA@mail.gmail.com>
References: <20220108034743.31277-1-ricardo.neri-calderon@linux.intel.com>
         <20220108034743.31277-6-ricardo.neri-calderon@linux.intel.com>
         <CAJZ5v0jbr=O+pMAikzWZZsFdcg5P8EWvW_zJRT0Ls21iEbJBWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-12 at 20:47 +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 8, 2022 at 4:46 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> > When hardware wants to inform the operating system about updates in
> > the HFI
> > table, it issues a package-level thermal event interrupt. For this,
> > hardware has new interrupt and status bits in the
> > IA32_PACKAGE_THERM_
> > INTERRUPT and IA32_PACKAGE_THERM_STATUS registers. The existing
> > thermal
> > throttle driver already handles thermal event interrupts: it
> > initializes
> > the thermal vector of the local APIC as well as per-CPU and
> > package-level
> > interrupt reporting. It also provides routines to service such
> > interrupts.
> > Extend its functionality to also handle HFI interrupts.
> > 
> > The frequency of the thermal HFI interrupt is specific to each
> > processor
> > model. On some processors, a single interrupt happens as soon as
> > the HFI is
> > enabled and hardware will never update HFI capabilities afterwards.
> > On
> > other processors, thermal and power constraints may cause thermal
> > HFI
> > interrupts every tens of milliseconds.
> > 
> > To not overwhelm consumers of the HFI data, use delayed work to
> > throttle
> > the rate at which HFI updates are processed.
> > 
> > 

[...]

> > +void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
> > +{
> > +       struct hfi_instance *hfi_instance;
> > +       int cpu = smp_processor_id();
> > +       struct hfi_cpu_info *info;
> > +       u64 new_timestamp;
> > +
> > +       if (!pkg_therm_status_msr_val)
> > +               return;
> > +
> > +       info = &per_cpu(hfi_cpu_info, cpu);
> > +       if (!info)
> > +               return;
> > +
> > +       /*
> > +        * It is possible that we get an HFI thermal interrupt on
> > this CPU
> > +        * before its HFI instance is initialized.
Although this code can handle this situation, you can avoid this.

You can call intel_hfi_online(cpu) before 
"
l = apic_read(APIC_LVTTHMR);
	apic_write(APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
"
in thermal_throttle_online()

In the same way call intel_hfi_offline(cpu)
after

/* Mask the thermal vector before draining evtl. pending work */
	l = apic_read(APIC_LVTTHMR);
	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);

in thermal_throttle_offline()


> >  This is not a problem. The
> > +        * CPU that enabled the interrupt for this package will
> > also get the
> > +        * interrupt and is fully initialized.
> > +        */
> > +       hfi_instance = info->hfi_instance;
> > +       if (!hfi_instance)
> > +               return;
> 
> Generally, a CPU whose info has been initialized can be offline, so
> this code may run on an offline CPU.
> 
> I'm not actually sure if this is a concern, but just mentioning it in
> case it is.
> 
It will not matter as the handler of the message should be handle case
as CPU can go offline later after the message even if the CPU was
offline.
But I think we can avoid this situation.

> > +
> > +       /*
> > +        * On most systems, all CPUs in the package receive a
> > package-level
> > +        * thermal interrupt when there is an HFI update. It is
> > sufficient to
> > +        * let a single CPU to acknowledge the update and schedule
> > work to
> > +        * process it. The remaining CPUs can resume their work.
> > +        */
> > +       if (!raw_spin_trylock(&hfi_instance->event_lock))
> > +               return;
> > +
> > +       /* Skip duplicated updates. */
> > +       new_timestamp = *(u64 *)hfi_instance->hw_table;
> > +       if (*hfi_instance->timestamp == new_timestamp) {
> > +               raw_spin_unlock(&hfi_instance->event_lock);
> > +               return;
> > +       }
> > +
> > +       raw_spin_lock(&hfi_instance->table_lock);
> > +
> > +       /*
> > +        * Copy the updated table into our local copy. This
> > includes the new
> > +        * timestamp.
> > +        */
> > +       memcpy(hfi_instance->local_table, hfi_instance->hw_table,
> > +              hfi_features.nr_table_pages << PAGE_SHIFT);
> > +
> > +       raw_spin_unlock(&hfi_instance->table_lock);
> > +       raw_spin_unlock(&hfi_instance->event_lock);
> > +
> > +       /*
> > +        * Let hardware know that we are done reading the HFI table
> > and it is
> > +        * free to update it again.
> > +        */
> > +       pkg_therm_status_msr_val &= THERM_STATUS_CLEAR_PKG_MASK &
> > +                                   ~PACKAGE_THERM_STATUS_HFI_UPDAT
> > ED;
> > +       wrmsrl(MSR_IA32_PACKAGE_THERM_STATUS,
> > pkg_therm_status_msr_val);
> > +
> > +       schedule_delayed_work(&hfi_instance->update_work,
> > HFI_UPDATE_INTERVAL);
> 
> AFAICS, 
For my understanding:

> if update_work has been scheduled already,
queue_delayed_work_on is called

>  but is not pending
> yet, the delay will be set to the current time plus
> HFI_UPDATE_INTERVAL, but shouldn't it actually run earlier in that
> case?


"
	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT,
work_data_bits(work))) {
		__queue_delayed_work(cpu, wq, dwork, delay);
		ret = true;
	}
"
Pending bit will be set only one time, so delay will be from 
the first call of queue_delayed_work_on() + HFI_UPDATE_INTERVAL.

So on subsequent calls of schedule_delayed_work() the delay is always
with reference to first call.

> 
> Also it looks like the processing introduced in the next patch can
> take quite a bit of time if there is a sufficiently large number of
> CPUs in the package, so is it suitable for system_wq in all cases?
> 
Good question. What is the threshold of not using system_wq?
With current set of max cpus/package, I did experiments with busy
systems with a test functions with several workqueues and check if they
drift in expiry. But I think we can move away from system_wq. Can this
be add on patch?

Thanks,
Srinivas

> > +}
> > +
> >  static void init_hfi_cpu_index(struct hfi_cpu_info *info)
> >  {
> >         union cpuid6_edx edx;
> > @@ -259,8 +350,20 @@ void intel_hfi_online(unsigned int cpu)
> > 
> >         init_hfi_instance(hfi_instance);
> > 
> > +       INIT_DELAYED_WORK(&hfi_instance->update_work,
> > hfi_update_work_fn);
> > +       raw_spin_lock_init(&hfi_instance->table_lock);
> > +       raw_spin_lock_init(&hfi_instance->event_lock);
> > +
> >         cpumask_set_cpu(cpu, hfi_instance->cpus);
> > 
> > +       /*
> > +        * Enable the hardware feedback interface and never disable
> > it. See
> > +        * comment on programming the address of the table.
> > +        */
> > +       rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
> > +       msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
> > +       wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
> > +
> >  unlock:
> >         mutex_unlock(&hfi_instance_lock);
> >         return;
> > diff --git a/drivers/thermal/intel/intel_hfi.h
> > b/drivers/thermal/intel/intel_hfi.h
> > index 56c6b2d75202..325aa78b745c 100644
> > --- a/drivers/thermal/intel/intel_hfi.h
> > +++ b/drivers/thermal/intel/intel_hfi.h
> > @@ -6,10 +6,12 @@
> >  void __init intel_hfi_init(void);
> >  void intel_hfi_online(unsigned int cpu);
> >  void intel_hfi_offline(unsigned int cpu);
> > +void intel_hfi_process_event(__u64 pkg_therm_status_msr_val);
> >  #else
> >  static inline void intel_hfi_init(void) { }
> >  static inline void intel_hfi_online(unsigned int cpu) { }
> >  static inline void intel_hfi_offline(unsigned int cpu) { }
> > +static inline void intel_hfi_process_event(__u64
> > pkg_therm_status_msr_val) { }
> >  #endif /* CONFIG_INTEL_HFI_THERMAL */
> > 
> >  #endif /* _INTEL_HFI_H */
> > diff --git a/drivers/thermal/intel/therm_throt.c
> > b/drivers/thermal/intel/therm_throt.c
> > index 2a79598a7f7a..930e19eeeac6 100644
> > --- a/drivers/thermal/intel/therm_throt.c
> > +++ b/drivers/thermal/intel/therm_throt.c
> > @@ -619,6 +619,10 @@ void intel_thermal_interrupt(void)
> >                                         PACKAGE_THERM_STATUS_POWER_
> > LIMIT,
> >                                         POWER_LIMIT_EVENT,
> >                                         PACKAGE_LEVEL);
> > +
> > +               if (this_cpu_has(X86_FEATURE_HFI))
> > +                       intel_hfi_process_event(msr_val &
> > +                                               PACKAGE_THERM_STATU
> > S_HFI_UPDATED);
> >         }
> >  }
> > 
> > @@ -728,6 +732,12 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
> >                         wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
> >                               l | (PACKAGE_THERM_INT_LOW_ENABLE
> >                                 | PACKAGE_THERM_INT_HIGH_ENABLE),
> > h);
> > +
> > +               if (cpu_has(c, X86_FEATURE_HFI)) {
> > +                       rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l,
> > h);
> > +                       wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
> > +                             l | PACKAGE_THERM_INT_HFI_ENABLE, h);
> > +               }
> >         }
> > 
> >         rdmsr(MSR_IA32_MISC_ENABLE, l, h);
> > --
> > 2.17.1
> > 

