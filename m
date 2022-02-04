Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFAC4AA0EA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiBDUH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:07:56 -0500
Received: from mga18.intel.com ([134.134.136.126]:34078 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237276AbiBDUHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:07:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644005269; x=1675541269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z4NbfNsU6IVb/TMXUrAVWfrz3XFmez1DBnLaxBVI4Os=;
  b=brqBU75snJbxm0l83AeyX8Bl7SOBnm8flPRVJ2aRq6aRGBQpuNZNU3Yk
   BQ9WzrJGZvpV+R8Sa1TRaF54bMGsUVHn5NbxgVGZTKcYrauhwCHAnLS3d
   yUsy+YG42HejcXaxnwBKTCS88zSeRBjDKzS7wrZNv/TQyqeq6xonPRW5U
   ifWbGBlkISTZjGXNRvPg/EvuWrncgIGypHXPYElZO0oYeruzBU0E4+fn3
   Kf1Xae8JVHDZkkejHveUioL2OGhWEYWf09i0HE8y0RHiyrzpygxZK9lGq
   ZUkx4vFcSVbh7ZSqzOp/9kGXTj6Y2rtNUVjA9yNdcyJIfp+abS/qTUiS8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="232001514"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="232001514"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 12:06:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="631805598"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 12:06:31 -0800
Date:   Fri, 4 Feb 2022 12:06:31 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 08/44] x86/fault: Adjust WARN_ON for PKey fault
Message-ID: <20220204200631.GB785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-9-ira.weiny@intel.com>
 <01a47dd8-4717-7b07-39ad-45fee1f78311@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a47dd8-4717-7b07-39ad-45fee1f78311@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 03:10:24PM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Previously if a Protection key fault occurred it indicated something
> > very wrong because user page mappings are not supposed to be in the
> > kernel address space.
> 
> This is missing a key point.  The problem is PK faults on "*kernel*
> addresses.

Ok, I'll try and clarify.

> 
> > Now PKey faults may happen on kernel mappings if the feature is enabled.
> 
> One nit: I've been using "pkeys" and "pkey" as the terms.  I usually
> don't capitalize them except at the beginning of a sentence.

I'll audit the series to use lower case for consistency.

> 
> > If PKS is enabled, avoid the warning in the fault path.
> > 
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  arch/x86/mm/fault.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index d0074c6ed31a..6ed91b632eac 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1148,11 +1148,15 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
> >  		   unsigned long address)
> >  {
> >  	/*
> > -	 * Protection keys exceptions only happen on user pages.  We
> > -	 * have no user pages in the kernel portion of the address
> > -	 * space, so do not expect them here.
> > +	 * X86_PF_PK (Protection key exceptions) may occur on kernel addresses
> > +	 * when PKS (PKeys Supervisor) is enabled.
> > +	 *
> > +	 * However, if PKS is not enabled WARN if this exception is seen
> > +	 * because there are no user pages in the kernel portion of the address
> > +	 * space.
> >  	 */
> > -	WARN_ON_ONCE(hw_error_code & X86_PF_PK);
> > +	WARN_ON_ONCE(!cpu_feature_enabled(X86_FEATURE_PKS) &&
> > +		     (hw_error_code & X86_PF_PK));
> >  
> >  #ifdef CONFIG_X86_32
> >  	/*
> 
> I'm wondering if this warning is even doing us any good.  I'm pretty
> sure it's never triggered on me at least.  Either way, let's not get too
> carried away with the comment.  I think this should do:
> 
> 	/*
> 	 * PF_PF faults should only occur on kernel
> 	 * addresses when supervisor pkeys are enabled.
> 	 */

Sounds better,
Ira
