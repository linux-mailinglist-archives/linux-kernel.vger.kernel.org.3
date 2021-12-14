Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98673474C92
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 21:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbhLNUVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 15:21:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:59050 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhLNUVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 15:21:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="263222326"
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="263222326"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 12:21:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,206,1635231600"; 
   d="scan'208";a="482107666"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2021 12:20:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4ED2915C; Tue, 14 Dec 2021 22:21:06 +0200 (EET)
Date:   Tue, 14 Dec 2021 23:21:06 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/26] x86/tdx: Detect running as a TDX guest in early
 boot
Message-ID: <20211214202106.uazcwby3365x2ymw@black.fi.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-2-kirill.shutemov@linux.intel.com>
 <Ybjf5g66cFHpUKMH@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybjf5g66cFHpUKMH@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 07:18:14PM +0100, Borislav Petkov wrote:
> > In preparation of extending cc_platform_has() API to support TDX guest,
> > use CPUID instruction to detect for TDX guests support in the early
> 
> " ... to detect support for TDX guests... "

Right, thanks.

> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 793e9b42ace0..a61ac6f8821a 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -872,6 +872,19 @@ config ACRN_GUEST
> >  	  IOT with small footprint and real-time features. More details can be
> >  	  found in https://projectacrn.org/.
> >  
> > +# TDX guest uses X2APIC for interrupt management.
> 
> For whom is that comment and who's going to see it? Is that comment
> supposed to explain the "depends on X86_X2APIC" below?

Yes.

But I think it should be pretty self-explanatory. I'll drop it.

> > +config INTEL_TDX_GUEST
> > +	bool "Intel TDX (Trust Domain Extensions) - Guest Support"
> > +	depends on X86_64 && CPU_SUP_INTEL
> > +	depends on X86_X2APIC
> > +	help
> > +	  Support running as a guest under Intel TDX.  Without this support,
> > +	  the guest kernel can not boot or run under TDX.
> > +	  TDX includes memory encryption and integrity capabilities
> > +	  which protect the confidentiality and integrity of guest
> > +	  memory contents and CPU state. TDX guests are protected from
> > +	  potential attacks from the VMM.
> > +

-- 
 Kirill A. Shutemov
