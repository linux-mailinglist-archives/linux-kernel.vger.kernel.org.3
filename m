Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA44A47E68B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349299AbhLWQzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:55:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:43909 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233597AbhLWQzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640278546; x=1671814546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EIbGWKBabvxgEfOoZhx/EGM4lcrtAH/4qkhaNcy2FQw=;
  b=WkcEliI50bienu6tayXsGcwFpYbQdx8RcvIi18RrmBN7JXwkYEXsgyDS
   VairJdQGHjcXqHlWudNTKY2QLpCVVPirvFulz+vivwmHSArLWINq8tCVf
   kBmDqina3calps0+RE0h3JHtUgmYwNqPYoMoa/cklsKHLq0UAT4GXIUFR
   GHgA6qzAv+1BbfwXXonXF0zoZ3xfu7UdUjPGM5AxIy4SU3hzj1adDLx2Q
   C8VeXwS1JcQjJpVnhVw/hiQJm6KShDtrRr/SK8Z3FbiNNDCVn8Rf3FYLc
   V67OSKL0AoO1MAWl27ZS7g3JMoCJhLvr3JyDYOhCRtvrKNEKTva8m1RbF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="227696606"
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="227696606"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 08:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="759207328"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 23 Dec 2021 08:55:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 471A8125; Thu, 23 Dec 2021 18:55:49 +0200 (EET)
Date:   Thu, 23 Dec 2021 19:55:48 +0300
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
Subject: Re: [PATCH 03/26] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-ID: <20211223165548.xr57h25g4diixivp@black.fi.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-4-kirill.shutemov@linux.intel.com>
 <YcIm8fngUsVulUoI@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcIm8fngUsVulUoI@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 08:11:45PM +0100, Borislav Petkov wrote:
> On Tue, Dec 14, 2021 at 06:02:41PM +0300, Kirill A. Shutemov wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > Guests communicate with VMMs with hypercalls. Historically, these
> > are implemented using instructions that are known to cause VMEXITs
> > like VMCALL, VMLAUNCH, etc. However, with TDX, VMEXITs no longer
> > expose the guest state to the host. This prevents the old hypercall
> > mechanisms from working. So, to communicate with VMM, TDX
> > specification defines a new instruction called TDCALL.
> > 
> > In a TDX based VM, since the VMM is an untrusted entity, an intermediary
> > layer (TDX module) exists in the CPU to facilitate secure communication
> 
> in the CPU?!
> 
> I think you wanna say, "it is loaded like a firmware into a special CPU
> mode called SEAM..." or so.

What about this?

	In a TDX based VM, since the VMM is an untrusted entity, an intermediary
	layer -- TDX module -- facilitates secure communication between the host
	and the guest. TDX module is loaded like a firmware into a special CPU
	mode called SEAM. TDX guests communicate with the TDX module using the
	TDCALL instruction.

Does it look fine?

> > (using the TDCALL instruction).
> > 
> > __tdx_hypercall()    - Used by the guest to request services from the
> > 		       VMM (via TDVMCALL).
> > __tdx_module_call()  - Used to communicate with the TDX Module (via
> > 		       TDCALL).
> 
> "module". No need to capitalize every word like in CPU manuals.

Okay, I will change it globally over the whole patchset.

> > Originally-by: Sean Christopherson <seanjc@google.com>
> 
> Just state that in free text in the commit message:
> 
> "Based on a previous patch by Sean... "

Okay.

> > +	/*
> > +	 * Since this function can be initiated without an output pointer,
> > +	 * check if caller provided an output struct before storing
> > +	 * output registers.
> > +	 */
> > +	test %r12, %r12
> > +	jz mcall_done
> 
> All those local label names need to be prefixed with .L so that they
> don't appear in the vmlinux symbol table unnecessarily:
> 
> 	jz .Lno_output_struct

Ah, okay. I did not know about special treatment for .L labels.
Again, will check whole patchset.

-- 
 Kirill A. Shutemov
