Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874BD476691
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 00:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhLOXfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 18:35:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:49741 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232073AbhLOXfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:35:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="226219203"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="226219203"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 15:35:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="464466077"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 15 Dec 2021 15:35:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5B26FD4; Thu, 16 Dec 2021 01:35:17 +0200 (EET)
Date:   Thu, 16 Dec 2021 02:35:17 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/26] x86/tdx: Extend the cc_platform_has() API to
 support TDX guests
Message-ID: <20211215233517.4cpiqqvlvxgd3qek@black.fi.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-3-kirill.shutemov@linux.intel.com>
 <20211215231904.rpakxlrp64zmxhhg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215231904.rpakxlrp64zmxhhg@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 03:19:04PM -0800, Josh Poimboeuf wrote:
> On Tue, Dec 14, 2021 at 06:02:40PM +0300, Kirill A. Shutemov wrote:
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -22,6 +22,7 @@ CFLAGS_REMOVE_early_printk.o = -pg
> >  CFLAGS_REMOVE_head64.o = -pg
> >  CFLAGS_REMOVE_sev.o = -pg
> >  CFLAGS_REMOVE_cc_platform.o = -pg
> > +CFLAGS_REMOVE_tdx.o = -pg
> >  endif
> >  
> >  KASAN_SANITIZE_head$(BITS).o				:= n
> > @@ -31,6 +32,7 @@ KASAN_SANITIZE_stacktrace.o				:= n
> >  KASAN_SANITIZE_paravirt.o				:= n
> >  KASAN_SANITIZE_sev.o					:= n
> >  KASAN_SANITIZE_cc_platform.o				:= n
> > +KASAN_SANITIZE_tdx.o					:= n
> >  
> >  # With some compiler versions the generated code results in boot hangs, caused
> >  # by several compilation units. To be safe, disable all instrumentation.
> > @@ -50,6 +52,7 @@ KCOV_INSTRUMENT		:= n
> >  
> >  CFLAGS_head$(BITS).o	+= -fno-stack-protector
> >  CFLAGS_cc_platform.o	+= -fno-stack-protector
> > +CFLAGS_tdx.o		+= -fno-stack-protector
> >  
> >  CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
> 
> Don't these Makefile changes belong in patch 1, which adds tdx.c?

Removing of the instrumentation is required because is_tdx_guest() is
called from cc_platform_has().

Commit message tries to communicate this:

	Since is_tdx_guest() function (through cc_platform_has() API) is used in
	the early boot code, disable the instrumentation flags and function
	tracer. This is similar to AMD SEV and cc_platform.c.

-- 
 Kirill A. Shutemov
