Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6216D4635BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhK3Ntm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:49:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:57964 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhK3Ntf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:49:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="233716753"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="233716753"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 05:46:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="744737168"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga006.fm.intel.com with ESMTP; 30 Nov 2021 05:46:14 -0800
Date:   Tue, 30 Nov 2021 05:45:10 -0800
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
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] thermal: intel: hfi: Minimally initialize the
 Hardware Feedback Interface
Message-ID: <20211130134510.GA27861@ranerica-svr.sc.intel.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-4-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0gd5ZAs4nkbMA4ONt=9ULnrTPqxe_+3M78t9ZC9upEiXw@mail.gmail.com>
 <20211130032029.GA1371@ranerica-svr.sc.intel.com>
 <9a463228ef9f668618a4d1470eb9925f8d332465.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a463228ef9f668618a4d1470eb9925f8d332465.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 07:55:18PM -0800, Srinivas Pandruvada wrote:
> On Mon, 2021-11-29 at 19:20 -0800, Ricardo Neri wrote:
> > On Wed, Nov 24, 2021 at 03:09:20PM +0100, Rafael J. Wysocki wrote:
> > > On Sat, Nov 6, 2021 at 2:34 AM Ricardo Neri
> > > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > > 
> > > > The Intel Hardware Feedback Interface provides guidance to the
> > > > operating
> > > > system about the performance and energy efficiency capabilities
> > > > of each
> > > > CPU in the system. Capabilities are numbers between 0 and 255
> > > > where a
> > > > higher number represents a higher capability. For each CPU,
> > > > energy
> > > > efficiency and performance are reported as separate capabilities.
> > > > 
> > > > Hardware computes these capabilities based on the operating
> > > > conditions of
> > > > the system such as power and thermal limits. These capabilities
> > > > are shared
> > > > with the operating system in a table resident in memory. Each
> > > > package in
> > > > the system has its own HFI instance. Every logical CPU in the
> > > > package is
> > > > represented in the table. More than one logical CPUs may be
> > > > represented in
> > > > a single table entry. When the hardware updates the table, it
> > > > generates a
> > > > package-level thermal interrupt.
> > > > 
> > > > The size and format of the HFI table depend on the supported
> > > > features and
> > > > can only be determined at runtime. To minimally initialize the
> > > > HFI, parse
> > > > its features and allocate one instance per package of a data
> > > > structure with
> > > > the necessary parameters to read and navigate individual HFI
> > > > tables.
> > > > 
> > > > A subsequent changeset will provide per-CPU initialization and
> > > > interrupt
> > > > handling.
> > > > 
> 
> [...]
> 
> > > > +       /*
> > > > +        * If we are here we know that CPUID_HFI_LEAF exists.
> > > > Parse the
> > > > +        * supported capabilities and the size of the HFI table.
> > > > +        */
> > > > +       reg = cpuid_edx(CPUID_HFI_LEAF);
> > > > +
> > > > +       hfi_features.capabilities = reg & HFI_CAPABILITIES_MASK;
> > > > +       if (!(hfi_features.capabilities &
> > > > HFI_CAPABILITIES_PERFORMANCE)) {
> > > > +               pr_err("Performance reporting not supported! Not
> > > > using HFI\n");
> > > 
> > > This doesn't need to be pr_err().
> > 
> > Should it be a pr_warn() or perhaps pr_info()?
> May be even pr_debug as we can always enable dynamic debug, where we
> need to debug.

Fair enough. That sounds good. I will make the change.

Thanks and BR,
Ricardo
