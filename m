Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86312468198
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383883AbhLDA5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:57:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:28230 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354600AbhLDA5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:57:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237305485"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="237305485"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 16:54:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="478507703"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 03 Dec 2021 16:54:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E34EC109; Sat,  4 Dec 2021 02:54:27 +0200 (EET)
Date:   Sat, 4 Dec 2021 03:54:27 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kuppuswamy Sathyanarayanan 
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
Message-ID: <20211204005427.ccinxlwwab3jsuct@black.fi.intel.com>
References: <YZPbQVwWOJCrAH78@zn.tnic>
 <20211119040330.4013045-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87pmqpjcef.ffs@tglx>
 <20211202222109.pcsgm2jska3obvmx@black.fi.intel.com>
 <87lf126010.ffs@tglx>
 <20211203234915.jw6kdd2qnfrionch@black.fi.intel.com>
 <2519e6b6-4f74-e2f8-c428-0fceb0e16472@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2519e6b6-4f74-e2f8-c428-0fceb0e16472@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 04:20:34PM -0800, Dave Hansen wrote:
> On 12/3/21 3:49 PM, Kirill A. Shutemov wrote:
> > -	ACPI_FLUSH_CPU_CACHE();
> > +	if (acpi_state >= ACPI_STATE_S1 && acpi_state <= ACPI_STATE_S3)
> > +		ACPI_FLUSH_CPU_CACHE();
> 
> It's a bit of a bummer that this per-sleep-state logic has to be
> repeated so many time.
> 
> If you pass acpi_state into ACPI_FLUSH_CPU_CACHE() can you centralize
> the set of places where that knowledge about which sleep states require
> flushing?

Yes, sure, it is doable. It we decide that it is the way to go.

> > TDX doesn't support these S- and C-states. TDX is only supports S0 and S5.
> 
> This makes me a bit nervous.  Is this "the first TDX implementation
> supports..." or "the TDX architecture *prohibits* supporting S1 (or
> whatever"?

TDX Virtual Firmware Design Guide only states that "ACPI S3 (not supported
by TDX guests)".

Kernel reports in dmesg "ACPI: PM: (supports S0 S5)".

But I don't see how any state beyond S0 and S5 make sense in TDX context.
Do you?

I find it neat that adjusting ACPI code to conform the spec makes TDX
work.

> I really think we need some kind of architecture guarantee.  Without
> that, we risk breaking things if someone at our employer simply changes
> their mind.

Guarantees are hard.

If somebody change their mind we will get unexpected #VE and crash.
I think it is acceptable way to handle unexpected change in confidential
computing environment.

> The:
> 
> > #define ACPI_FLUSH_CPU_CACHE_PHYS()     \
> >         if (!cpu_feature_enabled(XXX))	\
> >         	wbinvd();               \  
> 
> does seem simpler and less error-prone than this, though.

If it it the way to go, I can make a patch.

But there's no reason to have ACPI_FLUSH_CPU_CACHE_PHYS in addition to
ACPI_FLUSH_CPU_CACHE. All ACPI_FLUSH_CPU_CACHE can skip cache flush on
TDX.

-- 
 Kirill A. Shutemov
