Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099BE4AA520
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378315AbiBEAqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:46:12 -0500
Received: from mga03.intel.com ([134.134.136.65]:15579 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbiBEAqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644021971; x=1675557971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RTnhhinurZQZcCo/zAYuMWSmR/Zk64TZ7GLeuH68Ld0=;
  b=gICqyx86rFzn4xjPwolvYdjiwOjjuWijOoQPm7pbPFSD4sdmiFqHRA6v
   MfwSFF5/u0cajCNUVIVBJiUSntbmTPgarfRT5sv4/XeFhKAyEMf6kfTTb
   9iuPgQRhMotzcCc3Mjq6SvuyekRjmWIsaCwrqtWJTYICh5me7zDyqmVvU
   7Fq06lIyixRNvk6PbY56ZcVJwklQ4qunupo/H05WsTLveto0cAn+3Uu2D
   wHZMXlbiT2V0R05SzrLcdtybjKkS/7sG3mty6mfV6Wj7qTjjvdWly4jNc
   ecoj0Y+P2RiSCMano4IG6tmPqekamu4fjZKmdgi2AYN4wkC2qPqqvf8dp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248417672"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="248417672"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 16:46:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="677248362"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 04 Feb 2022 16:46:09 -0800
Date:   Fri, 4 Feb 2022 16:47:58 -0800
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
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/7] Thermal: Introduce the Hardware Feedback
 Interface for thermal and performance management
Message-ID: <20220205004758.GB11058@ranerica-svr.sc.intel.com>
References: <20220127193454.12814-1-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0gcK10TiVbc8+j1pVN+T2p3EZHEK9Ga2=2ZxeGd=iVkhw@mail.gmail.com>
 <CAJZ5v0j7+xkYOGB8kLxGwwD3ReaXt4oMRK-D-5t2zKeMxd-CYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j7+xkYOGB8kLxGwwD3ReaXt4oMRK-D-5t2zKeMxd-CYA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 07:57:25PM +0100, Rafael J. Wysocki wrote:
> On Sun, Jan 30, 2022 at 4:23 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Jan 27, 2022 at 8:33 PM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > >
> > > Hi,
> > >
> > > This is v5 of this patchset after having incorporated the feedback from
> > > reviewers. Please find v1, v2, v3, and v4 in [1], [2], [3], and [4],
> > > respectively.
> > >
> > > The Intel Hardware Feedback Interface (HFI) [5] provides information about
> > > the performance and energy efficiency of each CPU in the system. It uses a
> > > table that is shared between hardware and the operating system. The
> > > contents of the table may be updated as a result of changes in the
> > > operating conditions of the system (e.g., reaching a thermal limit) or the
> > > action of external factors (e.g., changes in the thermal design power).
> > >
> > > The information that HFI provides are specified as numeric, unit-less
> > > capabilities relative to other CPUs in the system. These capabilities have
> > > a range of [0-255] where higher numbers represent higher capabilities.
> > > Energy efficiency and performance are reported in separate capabilities.
> > > If either the performance or energy capabilities efficiency of a CPU are 0,
> > > the hardware recommends to not schedule any tasks on such CPU for
> > > performance, energy efficiency or thermal reasons, respectively.
> > >
> > > The kernel or user space may use the information from the HFI to modify
> > > task placement and/or adjust power limits. This patchset focuses on the
> > > user space. The thermal notification framework is extended to relay
> > > updates of CPU capacity. Thus, a userspace daemon can affinitize workloads
> > > to certain CPUs and/or offline CPUs whose capabilities are zero.
> > >
> > > The frequency of HFI updates is specific to each processor model. On some
> > > systems, there is just a single HFI update at boot. On other systems, there
> > > may be updates every tens of milliseconds. In order to not overwhelm
> > > userspace with too many updates, they are limited to one update every
> > > CONFIG_HZ jiffies.
> > >
> > > Thanks and BR,
> > > Ricardo
> > >
> > > [1]. https://lore.kernel.org/lkml/20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com/
> > > [2]. https://lore.kernel.org/lkml/20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com/
> > > [3]. https://lore.kernel.org/lkml/20220106025059.25847-8-ricardo.neri-calderon@linux.intel.com/
> > > [4]. https://lore.kernel.org/lkml/20220108034743.31277-1-ricardo.neri-calderon@linux.intel.com/
> > > [5]. https://www.intel.com/sdm
> > >
> > > Changes since v4:
> > >  ++ Unchanged patches: 1, 2.
> > >  * Reworded description hfi_instance::hdr and hfi_instance::data.
> > >    (Patch 3; Srinivas)
> > >  * Call intel_hfi_online() before enabling the thermal vector at the
> > >    local APIC is enabled. This makes sure that a CPU has an associated
> > >    HFI instance when an HFI event happens. Reworded the commit message to
> > >    reflect this change. (Patch 4; Srinivas)
> > >  * Set hfi_instances to NULL if we fail to allocate memory for
> > >    hfi_instance::cpus. (Patch 4; Srinivas)
> > >  * Delayed initialization of local variables until after the check for a
> > >    non-NULL hfi_instances in intel_hfi_online(). (Patch 4; Srinivas)
> > >  * Optimized the error path in init_hfi_init() to not needlessly
> > >    free the memory of cpumasks that have not been allocated. (Patch 4;
> > >    Srinivas)
> > >  * Removed pointless checks for X86_FEATURE_HFI in
> > >    intel_hfi_[on|off]line(). It is sufficient to check for a non-NULL
> > >    hfi_instances or a CPU's hfi_instance. (Patch 4)
> > >  * Added a dedicated (i.e., not system_wq) workqueue to process HFI updates.
> > >    Reworded commit message accordingly. (Patch 5; Rafael)
> > >  * Repurposed comment on possibly receiving an HFI event with a NULL
> > >    hfi_cpu_info::instance. Patch 4 fixed this potential issue. Instead,
> > >    add a debug statement. (Patch 5; Srinivas)
> > >  * Wrapped check for NULL hfi_cpu_info::instance in the unlikely macro.
> > >    (Patch 5; Srinivas)
> > >  * Renamed struct cpu_capability as struct thermal_genl_cpu_caps.
> > >    (Patch 6; Rafael)
> > >  * Removed automatic variable ret from
> > >    thermal_genl_event_cpu_capability_change() and instead always return
> > >    -EMSGSIZE on error. (Patch 6; Rafael)
> > >  * Reworked parsing of HFI capabilities into chunks of
> > >    HFI_MAX_THERM_NOTIFY_COUNT CPUs at a time to reduce the time
> > >    we spend with interrupts disabled. (Patch7; Srinivas)
> > >  * Protected hfi_instance::cpus when iterating over them. (Patch 7;
> > >    Rafael)
> >
> > All patches in the series look good to me now, so I will be queuing it
> > up for 5.18 unless there are any objections or concerns.
> 
> The series has been applied as 5.18 material, thanks!

Thank you very much Rafael for taking the patches. Thanks everyone for
your feedback. It did improve the patches.

BR,
Ricardo
