Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777BF48F3B3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 02:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiAOBBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 20:01:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:4852 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbiAOBBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 20:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642208510; x=1673744510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WYKnBtxj0d0Z5N6die+zqAPR/Ua4SB6/AcSav8I8t20=;
  b=MWDWSFJTNovd1CTkBF7W8U2YrW1ODmNzyri09QVUTM7DAl4dfskq05V3
   MAbZWsOyiArs+3QY1ryCDUyzo9nQs5/CcjGX0tOkd5e+q8mY3OH8cNUbv
   8KRTH/Y3vjEFYmqlmRsYBtxVmusZgscpf46uWL/zgfFAhQbyiaMwuLGcG
   VcuTAO52H/AArLS2+hfVhIvEXWKwsIJzXVv04iZpz/Y2HLVqYJtakAON5
   iDsxXsnJhNkjOsdQV4g+hTnG+f6LozKk6r9QYRDHHVeXuvjfyTwclKi+S
   hDsCoyrd3N1ez7dNJdJuZWd28BlHzIbl+PY2c/Pq03oNAhYCbMRx+TGVc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="305090893"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="305090893"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 17:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="516595864"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 14 Jan 2022 17:01:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 74F35C5; Sat, 15 Jan 2022 03:01:55 +0200 (EET)
Date:   Sat, 15 Jan 2022 04:01:55 +0300
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
Subject: Re: [PATCH 10/26] x86/tdx: Support TDX guest port I/O at
 decompression time
Message-ID: <20220115010155.ss2hnyotw4a3nljf@black.fi.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-11-kirill.shutemov@linux.intel.com>
 <YeAuehoOEjUH3vZ3@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeAuehoOEjUH3vZ3@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 02:51:54PM +0100, Borislav Petkov wrote:
> On Tue, Dec 14, 2021 at 06:02:48PM +0300, Kirill A. Shutemov wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > Port IO triggers a #VE exception in TDX guests.  During normal runtime,
> > the kernel will handle those exceptions for any port IO.
> > 
> > But for the early code in the decompressor, #VE cannot be used because
> > the IDT needed for handling the exception is not set up.
> 							  ... yet.
> 
> Well, we're setting up and IDT twice in
> 
> arch/x86/boot/compressed/idt_64.c
> 
> as early as startup_64 for SEV. And the second stage one
> do_boot_stage2_vc() handles port IO too.
> 
> Can't you hook in your VE handler there too?

We certainly can. But do we want to?

IIUC, SEV has to handle #VC very early to deal with CPUID and covering
port I/O in addition via the exception is a logical step.

We had some back and forth on #VE vs direct hypercalls for port I/O in
decompresser and we settled on direct hypercalls.

Adding all the plumbing for #VE just to deal with port I/O was considered
overkill. And I expect debugging exception infrastructure is harder than
direct hypercalls.

Do you see it differently? Do you want to switch to #VE here?

> > Replace IN/OUT instructions with TDX IO hypercalls by defining helper
> > macros __in/__out and by re-defining them in the decompressor code.
> > Also, since TDX IO hypercall requires an IO size parameter, allow
> > __in/__out macros to accept size as an input parameter.
> 
> Please end function/macro names with parentheses. I think in this
> particular case you wanna say
> 
> "__in*()/__out*() macros"
> 
> When a function is mentioned in the changelog, either the text body or the
> subject line, please use the format 'function_name()'. Omitting the
> brackets after the function name can be ambiguous::
> 
>   Subject: subsys/component: Make reservation_count static
> 
>   reservation_count is only used in reservation_stats. Make it static.
> 
> The variant with brackets is more precise::
> 
>   Subject: subsys/component: Make reservation_count() static
> 
>   reservation_count() is only called from reservation_stats(). Make it
>   static.

Okay, got it.

-- 
 Kirill A. Shutemov
