Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FED482CDA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 22:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiABVpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 16:45:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:58440 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbiABVpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 16:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641159907; x=1672695907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xO/JmsssR8ZfShdl3iRvcMqWEs9calz7UZ3M1sCetyY=;
  b=HKBOb4LyifOQsELBfM/NA4fDKedtDyhg7CUf2Mywv/RjPq2T/iFxYKeM
   OjRdlsp2cSv5MpH6O5QuVM35mQx4viO4g4z+caAwQF08FxLKqmV69bEdK
   WxP4ZHxMFMfl6YRf4eS3C4XbzsCRnBjzScsdHjT1F9KPtz3pR1k+EuWCL
   msnTJA6rTJdhy/9oujlwh5i3SDCQ2JWqMXKBFK421kjQKnOrFMkxII0eq
   psKXbOnKxk9eBhA2cI3wJJGihSIk+8rkXFxG3zw/TI2v9bckrjARfACms
   LSOsi+GQKr4StGsW/jvUMdODwW2iFT2burclavZVc2dD/bkMcYkXANlmw
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="240812927"
X-IronPort-AV: E=Sophos;i="5.88,256,1635231600"; 
   d="scan'208";a="240812927"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2022 13:45:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,256,1635231600"; 
   d="scan'208";a="667238226"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2022 13:45:06 -0800
Date:   Sun, 2 Jan 2022 13:46:47 -0800
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
Subject: Re: [PATCH v2 3/7] thermal: intel: hfi: Minimally initialize the
 Hardware Feedback Interface
Message-ID: <20220102214647.GC14930@ranerica-svr.sc.intel.com>
References: <20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com>
 <20211220151438.1196-4-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hQUMBw-0t0QzvCfOvzp0WEhE64xiU1JX2jkzdG5BJrMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hQUMBw-0t0QzvCfOvzp0WEhE64xiU1JX2jkzdG5BJrMg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 07:43:22PM +0100, Rafael J. Wysocki wrote:
> On Mon, Dec 20, 2021 at 4:23 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > The Intel Hardware Feedback Interface provides guidance to the operating
> > system about the performance and energy efficiency capabilities of each
> > CPU in the system. Capabilities are numbers between 0 and 255 where a
> > higher number represents a higher capability. For each CPU, energy
> > efficiency and performance are reported as separate capabilities.
> >
> > Hardware computes these capabilities based on the operating conditions of
> > the system such as power and thermal limits. These capabilities are shared
> > with the operating system in a table resident in memory. Each package in
> > the system has its own HFI instance. Every logical CPU in the package is
> > represented in the table. More than one logical CPUs may be represented in
> > a single table entry. When the hardware updates the table, it generates a
> > package-level thermal interrupt.
> >
> > The size and format of the HFI table depend on the supported features and
> > can only be determined at runtime. To minimally initialize the HFI, parse
> > its features and allocate one instance per package of a data structure with
> > the necessary parameters to read and navigate a local copy (i.e., owned by
> > the driver) of individual HFI tables.
> >
> > A subsequent changeset will provide per-CPU initialization and interrupt
> > handling.
> >
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Co-developed by: Aubrey Li <aubrey.li@linux.intel.com>
> > Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v1:
> >   * Renamed X86_FEATURE_INTEL_HFI as X86_FEATURE_HFI. (Boris)
> >   * Reworked parsing of HFI features using bitfields instead of bitmasks.
> >     (PeterZ).
> >   * Removed hfi_instance::parsed as hfi_parse_features() is called only
> >     once via intel_hfi_init() via thermal_throttle_init_device().
> >     (Rafael)
> >   * Converted pr_err() to pr_debug(). (Srinivas, Rafael)
> >   * Removed unnecessary dependency on CONFIG_SCHED_MC.
> >   * Renamed hfi_instance::ts_counter as hfi_instance::timestamp.
> >   * Renamed hfi_instance::table_base as hfi_instance::local_table and
> >     relocated its definition to this patch.
> >   * Wrapped hfi_instance::timestamp and hfi_instance:local_table in an
> >     anonymous union, since both point at the same location.
> > ---
> >  drivers/thermal/intel/Kconfig       |  12 ++
> >  drivers/thermal/intel/Makefile      |   1 +
> >  drivers/thermal/intel/intel_hfi.c   | 175 ++++++++++++++++++++++++++++
> >  drivers/thermal/intel/intel_hfi.h   |  11 ++
> >  drivers/thermal/intel/therm_throt.c |   3 +
> >  5 files changed, 202 insertions(+)
> >  create mode 100644 drivers/thermal/intel/intel_hfi.c
> >  create mode 100644 drivers/thermal/intel/intel_hfi.h
> >
> > diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> > index c83ea5d04a1d..1a21ff60fdc7 100644
> > --- a/drivers/thermal/intel/Kconfig
> > +++ b/drivers/thermal/intel/Kconfig
> > @@ -99,3 +99,15 @@ config INTEL_MENLOW
> >           Intel Menlow platform.
> >
> >           If unsure, say N.
> > +
> > +config INTEL_HFI
> 
> This looks like it may be too general, because HFI is not a thermal-only thing.

> 
> Maybe cal it INTEL_HFI_THERMAL?

True. The *Enhanced* HFI introduces the concept of thread classes [1]. I was
planning to wrap this patchset, which parses the HFI table and deals
with updates, as INTEL_HFI. The code that deals with classes would be
wrapped as INTEL_EHFI.

After this comment, so you still think that INTEL_HFI_THERMAL makes more
sense?

Thanks and BR,
Ricardo


[1]. https://www.intel.com/content/www/us/en/develop/download/intel-architecture-instruction-set-extensions-programming-reference.html , Chapter 13

