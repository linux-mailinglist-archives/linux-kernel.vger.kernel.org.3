Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82584462B56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 04:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbhK3D6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 22:58:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:34044 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhK3D6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 22:58:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="233636942"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="233636942"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 19:55:27 -0800
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="540263601"
Received: from rmohanrx-mobl1.gar.corp.intel.com ([10.213.100.150])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 19:55:21 -0800
Message-ID: <9a463228ef9f668618a4d1470eb9925f8d332465.camel@linux.intel.com>
Subject: Re: [PATCH 3/7] thermal: intel: hfi: Minimally initialize the
 Hardware Feedback Interface
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 29 Nov 2021 19:55:18 -0800
In-Reply-To: <20211130032029.GA1371@ranerica-svr.sc.intel.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
         <20211106013312.26698-4-ricardo.neri-calderon@linux.intel.com>
         <CAJZ5v0gd5ZAs4nkbMA4ONt=9ULnrTPqxe_+3M78t9ZC9upEiXw@mail.gmail.com>
         <20211130032029.GA1371@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-11-29 at 19:20 -0800, Ricardo Neri wrote:
> On Wed, Nov 24, 2021 at 03:09:20PM +0100, Rafael J. Wysocki wrote:
> > On Sat, Nov 6, 2021 at 2:34 AM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > 
> > > The Intel Hardware Feedback Interface provides guidance to the
> > > operating
> > > system about the performance and energy efficiency capabilities
> > > of each
> > > CPU in the system. Capabilities are numbers between 0 and 255
> > > where a
> > > higher number represents a higher capability. For each CPU,
> > > energy
> > > efficiency and performance are reported as separate capabilities.
> > > 
> > > Hardware computes these capabilities based on the operating
> > > conditions of
> > > the system such as power and thermal limits. These capabilities
> > > are shared
> > > with the operating system in a table resident in memory. Each
> > > package in
> > > the system has its own HFI instance. Every logical CPU in the
> > > package is
> > > represented in the table. More than one logical CPUs may be
> > > represented in
> > > a single table entry. When the hardware updates the table, it
> > > generates a
> > > package-level thermal interrupt.
> > > 
> > > The size and format of the HFI table depend on the supported
> > > features and
> > > can only be determined at runtime. To minimally initialize the
> > > HFI, parse
> > > its features and allocate one instance per package of a data
> > > structure with
> > > the necessary parameters to read and navigate individual HFI
> > > tables.
> > > 
> > > A subsequent changeset will provide per-CPU initialization and
> > > interrupt
> > > handling.
> > > 

[...]

> > > +       /*
> > > +        * If we are here we know that CPUID_HFI_LEAF exists.
> > > Parse the
> > > +        * supported capabilities and the size of the HFI table.
> > > +        */
> > > +       reg = cpuid_edx(CPUID_HFI_LEAF);
> > > +
> > > +       hfi_features.capabilities = reg & HFI_CAPABILITIES_MASK;
> > > +       if (!(hfi_features.capabilities &
> > > HFI_CAPABILITIES_PERFORMANCE)) {
> > > +               pr_err("Performance reporting not supported! Not
> > > using HFI\n");
> > 
> > This doesn't need to be pr_err().
> 
> Should it be a pr_warn() or perhaps pr_info()?
May be even pr_debug as we can always enable dynamic debug, where we
need to debug.

Thanks,
Srinivas

> 
> Thanks and BR,
> Ricardo
> 


