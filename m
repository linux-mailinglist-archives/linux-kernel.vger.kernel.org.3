Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA1B466C09
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbhLBWYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:24:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:45358 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236904AbhLBWYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:24:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="217544166"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="217544166"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:21:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="513051426"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Dec 2021 14:21:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4114E109; Fri,  3 Dec 2021 00:21:09 +0200 (EET)
Date:   Fri, 3 Dec 2021 01:21:09 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2] x86: Skip WBINVD instruction for VM guest
Message-ID: <20211202222109.pcsgm2jska3obvmx@black.fi.intel.com>
References: <YZPbQVwWOJCrAH78@zn.tnic>
 <20211119040330.4013045-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87pmqpjcef.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmqpjcef.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 01:40:24AM +0100, Thomas Gleixner wrote:
> Kuppuswamy,
> 
> On Thu, Nov 18 2021 at 20:03, Kuppuswamy Sathyanarayanan wrote:
> > ACPI mandates that CPU caches be flushed before entering any sleep
> > state. This ensures that the CPU and its caches can be powered down
> > without losing data.
> >
> > ACPI-based VMs have maintained this sleep-state-entry behavior.
> > However, cache flushing for VM sleep state entry is useless. Unlike on
> > bare metal, guest sleep states are not correlated with potential data
> > loss of any kind; the host is responsible for data preservation. In
> > fact, some KVM configurations simply skip the cache flushing
> > instruction (see need_emulate_wbinvd()).
> 
> KVM starts out with kvm->arch.noncoherent_dma_count = 0 which makes
> need_emulate_wbinvd() skip WBINVD emulation. So far so good.
> 
> VFIO has code to invoke kvm_arch_register_noncoherent_dma() which
> increments the count which will subsequently cause WBINVD emulation to
> be enabled. What now?
> 
> > Further, on TDX systems, the WBINVD instruction causes an
> > unconditional #VE exception.  If this cache flushing remained, it would
> > need extra code in the form of a #VE handler.
> >
> > All use of ACPI_FLUSH_CPU_CACHE() appears to be in sleep-state-related
> > code.
> 
> C3 is considered a sleep state nowadays? Also ACPI_FLUSH_CPU_CACHE() is
> used in other places which have nothing to do with sleep states.
> 
> git grep is not rocket science to use.
> 
> > This means that the ACPI use of WBINVD is at *best* superfluous.
> 
> Really? You probably meant to say:
> 
>   This means that the ACPI usage of WBINVD from within a guest is at
>   best superfluous.
> 
> No?
> 
> But aside of that this does not give any reasonable answers why
> disabling WBINVD for guests unconditionally in ACPI_FLUSH_CPU_CACHE()
> and the argumentation vs. need_emulate_wbinvd() are actually correct
> under all circumstances.
> 
> I'm neither going to do that analysis nor am I going to accept a patch
> which comes with 'appears' based arguments and some handwavy references
> to disabled WBINVD emulation code which can obviously be enabled for a
> reason.
> 
> The even more interesting question for me is how a TDX guest is dealing
> with all other potential invocations of WBINVD all over the place. Are
> they all going to get the same treatment or are those magically going to
> be never executed in TDX guests?
> 
> I really have to ask why SEV can deal with WBINVD and other things just
> nicely by implementing trivial #VC handler functions, but TDX has to
> prematurely optimize the kernel tree based on half baken arguments?
> 
> Having a few trivial #VE handlers is not the end of the world. You can
> revisit that once basic support for TDX is merged in order to gain
> performance or whatever.
> 
> Either that or you provide patches with arguments which are based on
> proper analysis and not on 'appears to' observations.

I think the right solution to the WBINVD would be to add a #VE handler
that does nothing. We don't have a reasonable way to handle it from within
the guest. We can call the VMM in hope that it would handle it, but VMM is
untrusted and it can ignore the request.

Dave suggested that we need to do code audit to make sure that there's no
user inside TDX guest environment that relies on WBINVD to work correctly.

Below is full call tree of WBINVD. It is substantially larger than I
anticipated from initial grep.

Conclusions:

  - Most of callers are in ACPI code on changing S-states. Ignoring cache
    flush for S-state change on virtual machine should be safe.

  - The only WBINVD I was able to trigger is on poweroff from ACPI code.
    Reboot also should trigger it, but for some reason I don't see it.

  - Few caller in CPU offline code. TDX does not allowed to offline CPU as
    we cannot bring it back -- we don't have SIPI. And even if offline
    works for vCPU it should be safe to ignore WBINVD there.

  - NVDIMMs are not supported inside TDX. If it will change we would need
    to deal with cache flushing for this case. Hopefully, we would be able
    to avoid WBINVD.

  - Cache QoS and MTRR use WBINVD. They are disabled in TDX, but it is
    controlled by VMM if the feature is advertised. We would need to
    filter CPUID/MSRs to make sure VMM would not mess with them.

Is it good enough justification for do-nothing #VE WBINVD handler?

WBINVD
  native_wbinvd()
    wbinvd()
      ACPI_FLUSH_CPU_CACHE()
        acpi_hw_extended_sleep()
          acpi_enter_sleep_state()
            x86_acpi_enter_sleep_state()
              do_suspend_lowlevel()
                x86_acpi_suspend_lowlevel()
                  acpi_suspend_enter()
                    >>> On S3: No suspend-to-ram -- no problem
            acpi_db_do_one_sleep_state()
              acpi_db_sleep()
                acpi_db_command_dispatch()
                  >>> "SLEEP" command of ACPI debugger. I guess can trigger poweroff. WBINVD doesn't make any difference in TDX.
            acpi_hibernation_enter()
              >>> On S4. No hibernate -- no problem.
            acpi_power_off()
              >>> On S5. Triggirable on poweroff, but safe to ignore WBINVD here on TDX
            acpi_suspend_enter()
              >>> On S1. No S1 -- no problem.
            xen_acpi_suspend_lowlevel()
              >>> N/A to TDX.
        acpi_hw_legacy_sleep()
          acpi_enter_sleep_state()
            >>> See above. For ACPI_REDUCED_HARDWARE.
        acpi_enter_sleep_state_s4bios()
          No users? Or I failed to decypther ACPI code.
        acpi_idle_enter()
          acpi_processor_setup_cstates()
            acpi_processor_setup_cpuidle_states()
              acpi_processor_power_state_has_changed()
                acpi_processor_notify()
                  >>> Looks like the driver going to get event in case the number of power state will change. But I can be mistaken. Anyway skipping WBINVD is safe.
              acpi_processor_power_init()
                >>> Only applicable if acpi_idle_driver is in use. N/A to TDX.
        acpi_idle_enter_s2idle()
          acpi_processor_setup_cstates()
            >>> See above.
        acpi_idle_play_dead()
          acpi_processor_setup_cstates()
            >>> See above.
        acpi_sleep_prepare()
          >>> On the way to S3/S4/S5. Safe to ignore WBINVD
        acpi_suspend_enter()
          >>> On the way to S3/S4/S5. Safe to ignore WBINVD
        acpi_hibernation_enter()
          >>> On S4, No S4 -- no problem.
        <Bunch of callers in cpufreq/longhaul.c>
          >>> CPU frequency driver for VIA Cyrix CPU. N/A to TDX.
      flush_agp_cache()
        ipi_handler()
          global_cache_flush()
            >>> Used by bunch of random AGP drivers. N/A to TDX: device passthrough is not supported.
      wbinvd_on_cpu()
        amd_l3_disable_index()
          >>> N/A to TDX
      gart_iommu_init()
        >>> N/A to TDX
      init_amd_k6()
        >>> N/A to TDX
      amd_set_mtrr()
        >>> N/A to TDX
      prepare_set() in mtrr/cyrix.c
        >>> N/A to TDX
      post_set() in mtrr/cyrix.c
        >>> N/A to TDX
      prepare_set() mtrr/generic.c
        >>> MTRR is disabled, but it is in control of VMM.
      mwait_play_dead()
        native_play_dead()
          sev_es_play_dead()
            >>> N/A to TDX.
          play_dead()
            arch_cpu_idle_enter()
              do_idle()
                >>> Only for offline CPUs. Offlining is disabled on TDX.
      hlt_play_dead()
        native_play_dead()
          >>> See above
        resume_play_dead()
          hibernate_resume_nonboot_cpu_disable()
            >>> No hipernate -- no problem.
      pseudo_lock_fn()
        rdtgroup_pseudo_lock_create()
          rdtgroup_schemata_write()
            res_common_files[]
              rdtgroup_init()
                resctrl_late_init()
                  >>> Depends on Cache QoS features that configured by VMM.
      wbinvd_ipi() in kvm/x86.c
        >>> KVM emulation of WBINVD. N/A for TDX guest.
      __wbinvd()
        wbinvd_on_cpu()
          >>> See above
        wbinvd_on_all_cpus()
          sev_flush_asids() and other users in kvm/svm/sev.c
            >>> N/A to TDX
          nvdimm_invalidate_cache()
            >>> No NVDIMMs in TDX
          i830_chipset_flush()
            >>> N/A to TDX
          __sev_platform_init_locked()
            >>> N/A to TDX
          drm_clflush_virt_range(), drm_clflush_pages(), drm_clflush_sg()
            >>> Only for !X86_FEATURE_CLFLUSH, N/A to TDX.
          Few callers in i915
            >>> N/A to TDX
      __sme_early_enc_dec()
        >>> N/A to TDX
      __cpa_flush_all()
        cpa_flush_all()
          cpa_flush()
            >>> Only for !X86_FEATURE_CLFLUSH. N/A to TDX.
      powernow_k6_set_cpu_multiplier()
        >>> N/A to TDX
      disable_caches()
        inject_write_store() in amd64_edac.c
          >>> N/A to TDX
      drm_ati_pcigart_init()
        >>> N/A to TDX
      nettel_init() and other nettel users
        >>> N/A to TDX
      atomisp_acc_start() and other atomisp users
        >>> N/A to TDX
    apply_microcode_intel()/apply_microcode_early()
      >>> N/A to TDX
  identity_mapped()
    >>> Only for AMD SME
  __enc_copy in /mem_encrypt_boot.S
    >>> N/A to TDX
  wakeup_start in platform/olpc/xo1-wakeup.S
    >>> N/A to TDX
  machine_real_restart_asm16 in realmode/rm/reboot.S
    >>> Safe to ignore WBINVD on TDX
  trampoline_start in realmode/rm/trampoline_64.S
    >>> TDX doesn't use realmode trampoline
  flush_cache() in i810_main.h
    >>> N/A to TDX
-- 
 Kirill A. Shutemov
