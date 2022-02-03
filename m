Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6539B4A85CF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 15:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244407AbiBCOJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 09:09:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:64909 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbiBCOJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 09:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643897375; x=1675433375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4QUDqEoJQQdShRa8w+J3nMpMGK1dP+/hU6MJ4GHQK7g=;
  b=oBYNk83eBYu+0f/kxzUibD9ZotILW/4s5qEfBLRCs+B0AainQbPg/r+c
   4nT0FF1CInzXBtmkqgQH+nBi+wE+SF6K8+i3xFGDQlvU3bWzhom/MWFEq
   aXqr5fhdnyy1a/jTMs7HMBw2Z5XBYwTu1P7hdnRhKTjKDcskebU08szNd
   HT2BMODp9JKgpdn3K5nte9VsG1lXqRIoXnN2okKHokLU5DiY7WZVXm24X
   TQahQh3v8HEv2M67l/0BlvuxJSXHxiFkyYUrvRD3blHN5lYlSydNVBbaa
   /FBeFScTSjO5J9zYBSiybBsc4C14OjY7p2z4KPQ+WDo02IeJZKMwlZ6M1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="311454164"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="311454164"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 06:09:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="676779304"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2022 06:09:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 409BB204; Thu,  3 Feb 2022 16:09:43 +0200 (EET)
Date:   Thu, 3 Feb 2022 17:09:43 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 01/29] x86/tdx: Detect running as a TDX guest in early
 boot
Message-ID: <20220203140943.wwi2hk3h3wzsjmdv@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-2-kirill.shutemov@linux.intel.com>
 <87fsp2z8p8.ffs@tglx>
 <20220201231459.2doc4iaibmuua4qk@black.fi.intel.com>
 <20220203003209.bi6i4llc4jeouuh6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203003209.bi6i4llc4jeouuh6@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 04:32:09PM -0800, Josh Poimboeuf wrote:
> On Wed, Feb 02, 2022 at 02:14:59AM +0300, Kirill A. Shutemov wrote:
> > On Tue, Feb 01, 2022 at 08:29:55PM +0100, Thomas Gleixner wrote:
> > > Kirill,
> > > 
> > > On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> > > 
> > > Just a nitpick...
> > > 
> > > > +static bool tdx_guest_detected __ro_after_init;
> > > > +
> > > > +bool is_tdx_guest(void)
> > > > +{
> > > > +	return tdx_guest_detected;
> > > > +}
> > > > +
> > > > +void __init tdx_early_init(void)
> > > > +{
> > > > +	u32 eax, sig[3];
> > > > +
> > > > +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
> > > > +
> > > > +	if (memcmp(TDX_IDENT, sig, 12))
> > > > +		return;
> > > > +
> > > > +	tdx_guest_detected = true;
> > > > +
> > > > +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> > > 
> > > So with that we have two ways to detect a TDX guest:
> > > 
> > >    - tdx_guest_detected
> > > 
> > >    - X86_FEATURE_TDX_GUEST
> > > 
> > > Shouldn't X86_FEATURE_TDX_GUEST be good enough?
> > 
> > Right. We have only 3 callers of is_tdx_guest() in cc_platform.c
> > I will replace them with cpu_feature_enabled(X86_FEATURE_TDX_GUEST).
> 
> I had the same review comment before.  I was told that cc_platform_has()
> was called before caps have been set up properly, so caps can't be
> relied upon this early.
> 
> I'm not really convinced that's true.  Yes, early_identify_cpu() --
> which runs after tdx_early_init() -- clears all boot_cpu_data's
> capability bits to zero [*].
> 
> But shortly after that, early_identify_cpu() restores any "forced" caps
> with a call to get_cpu_cap() -> apply_forced_caps().
> 
> So as far as I can tell, while it's subtle, it should work.  However, it
> should be tested carefully ;-)
> 
> 
> [ *] The memset() of boot_cpu_data seems unnecessary since it should
>      already be cleared by the compiler when it gets placed in the
>      .data..read_mostly section.
> 

There are couple of uses of cc_platform_has() before tdx_early_init() is
called: in sme_map_bootdata() and sme_unmap_bootdata(). Both called from
copy_bootdata().

We can move tdx_early_init() before copy_bootdata(), but in this case
tdx_early_init() won't be able to parse kernel command line. This
capability used by patches outside the initial TDX submission.

I just realized that we have moved tdx_early_init() back and forth few
times for this reason. Ughh..

I will rework (or drop) patches that parse command line options from
tdx_early_init() and move tdx_early_init() before copy_bootdata().

-- 
 Kirill A. Shutemov
