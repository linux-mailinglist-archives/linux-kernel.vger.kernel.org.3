Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0194C58DC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 02:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiB0BIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 20:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiB0BH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 20:07:58 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CFE111C
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 17:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645924043; x=1677460043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TI7zL5UAwq6ggJ6H296ASYJslAopsQ14aVM//XVCzAg=;
  b=mCt+W5t7rQgi7MojBl62YpqT2RT8F7m5gwLOHNEeta5w3YRyWO9v07+t
   wyTRj4MWsd4uIx1+xfh6ykj2+5Vw6lFrUq7TK6KxFMOAOr4ofHl14+m2M
   c0HyLi33E5l/SujRYttBWMUj0LaSSOmA9rtZ4IiUt7dh+5cwG/f3fyDM1
   gd6hJeI/ijHiXPkWP2CAQUzw0Q3jQxB8jN5hzX/skRRViheSLPynANp04
   yekYIohplFk2pHUm0+euFGkgww75Y/B6+1yWQ+ozooq5LhNhtTrpU9fsD
   UDSDrnppjHUCp3ucBnFWy5az6hYrwS5wtBn+8pUb054MOUZApAbKTIaWl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="313412684"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="313412684"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 17:07:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="492333779"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 26 Feb 2022 17:07:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C1E1B94; Sun, 27 Feb 2022 03:07:33 +0200 (EET)
Date:   Sun, 27 Feb 2022 04:07:33 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 10/30] x86/tdx: Handle CPUID via #VE
Message-ID: <20220227010733.abapkmyaroglcafl@black.fi.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-11-kirill.shutemov@linux.intel.com>
 <51b6613d-eabd-941d-19b2-95b33ec27e99@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b6613d-eabd-941d-19b2-95b33ec27e99@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 11:04:04AM -0800, Dave Hansen wrote:
> On 2/24/22 07:56, Kirill A. Shutemov wrote:
> >  static bool virt_exception_user(struct pt_regs *regs, struct ve_info *ve)
> >  {
> > -	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> > -	return false;
> > +	switch (ve->exit_reason) {
> > +	case EXIT_REASON_CPUID:
> > +		return handle_cpuid(regs);
> > +	default:
> > +		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> > +		return false;
> > +	}
> >  }
> 
> What does this mean for userspace?  What kinds of things are we ceding
> to the (untrusted) VMM to supply to userspace?

Here's what I see called from userspace.
CPUID(AX=0x2)
CPUID(AX=0xb, CX=0x0)
CPUID(AX=0xb, CX=0x1)
CPUID(AX=0x40000000, CX=0xfffaba17)
CPUID(AX=0x80000007, CX=0x121)

> >  /* Handle the kernel #VE */
> > @@ -200,6 +235,8 @@ static bool virt_exception_kernel(struct pt_regs *regs, struct ve_info *ve)
> >  		return read_msr(regs);
> >  	case EXIT_REASON_MSR_WRITE:
> >  		return write_msr(regs);
> > +	case EXIT_REASON_CPUID:
> > +		return handle_cpuid(regs);
> >  	default:
> >  		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
> >  		return false;
> What kinds of random CPUID uses in the kernel at runtime need this
> handling?

CPUID(AX=0x2)
CPUID(AX=0x6, CX=0x0)
CPUID(AX=0xb, CX=0x0)
CPUID(AX=0xb, CX=0x1)
CPUID(AX=0xb, CX=0x2)
CPUID(AX=0xf, CX=0x0)
CPUID(AX=0xf, CX=0x1)
CPUID(AX=0x10, CX=0x0)
CPUID(AX=0x10, CX=0x1)
CPUID(AX=0x10, CX=0x2)
CPUID(AX=0x10, CX=0x3)
CPUID(AX=0x16, CX=0x0)
CPUID(AX=0x1f, CX=0x0)
CPUID(AX=0x40000000, CX=0x0)
CPUID(AX=0x40000000, CX=0xfffaba17)
CPUID(AX=0x40000001, CX=0x0)
CPUID(AX=0x80000002, CX=0x0)
CPUID(AX=0x80000003, CX=0x0)
CPUID(AX=0x80000004, CX=0x0)
CPUID(AX=0x80000007, CX=0x0)
CPUID(AX=0x80000007, CX=0x121)

> Is it really OK that we let the VMM inject arbitrary CPUID
> values into random CPUID uses in the kernel... silently?

We realise that this is possible vector of attack and plan to implement
proper filtering. But it is beyon core enabling.

> Is this better than just returning 0's, for instance?

Plain 0 injection breaks the boot. More complicated solution is need.


-- 
 Kirill A. Shutemov
