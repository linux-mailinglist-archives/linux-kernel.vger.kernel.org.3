Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61BD4AA261
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbiBDVfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:35:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:5809 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233101AbiBDVft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644010549; x=1675546549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RlVWfZ/6O1kC+NcA0rV+6/IFv3O5/Tcy4Zdh0oKpDbQ=;
  b=FrWvlD8mZYNRy0/XQDxU+peFOztBoxm4wYRMY1/hyDO02giBdUH++b3N
   AGFI/7U2kcMa2wL7FitKy+2aPA5Lg718pLS75IC3n/P2ASjyIisMY3SCK
   ffZp2uy8iToW41ySCaFNuGtg+Cay/y8iR2D23V70+Xqsnskn9jNOYUjrA
   e13E1Fr3zGJ9pplGrAgSqef3YT8+VJXsZ9ZNG4eq2PZPphLS9PRmCXho7
   HoY9/ruETKMgNdix+92q7uTWWesiuMpeobDEvJ9k3IR60IvKgSL94nbjp
   J5bCYCQTqofXM60/1NbQHvyFLQYQ7/SqTWlarUbUiWJur0t5AOsNW0RBn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246036106"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="246036106"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 13:35:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="498599681"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 04 Feb 2022 13:35:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9D9FE176; Fri,  4 Feb 2022 23:35:57 +0200 (EET)
Date:   Sat, 5 Feb 2022 00:35:57 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 28/29] x86/tdx: Warn about unexpected WBINVD
Message-ID: <20220204213557.n2cirp5k4ryv754q@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-29-kirill.shutemov@linux.intel.com>
 <87y22uujkm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y22uujkm.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 02:46:17AM +0100, Thomas Gleixner wrote:
> On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
> 
> > WBINVD causes #VE in TDX guests. There's no reliable way to emulate it.
> > The kernel can ask for VMM assistance, but VMM is untrusted and can ignore
> > the request.
> >
> > Fortunately, there is no use case for WBINVD inside TDX guests.
> 
> If there is not usecase, then why
> 
> > Warn about any unexpected WBINVD.
> 
> instead of terminating the whole thing?
> 
> I'm tired of the "let us emit a warning in the hope it gets fixed'
> thinking.

I probably misunderstood what you meant in the previous WBINVD thread[1] by:

	Then you have the #VE handler which just acts on any other wbinvd
	invocation via warn, panic, whatever, no?

I went the warn path because I think it is consistent with BUG() vs. WARN()
policy: "Use WARN() and WARN_ON() instead, and handle the "impossible"
error condition as gracefully as possible."[2]

IMO, ignored WBINVD has less chance to lead user data loss than panic().

Anyway, I'm okay dropping the patch. It will bring us to "terminate whole
thing" solution. I just wanted to explain why the patch is present in the
series.

[1] https://lore.kernel.org/all/87lf126010.ffs@tglx/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/deprecated.rst

-- 
 Kirill A. Shutemov
