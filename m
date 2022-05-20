Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3652E26A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbiETCVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242111AbiETCVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:21:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20704553A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 19:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653013263; x=1684549263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V6UQ8DzeLKfZNqwV6mywgfWsFOdr/AQaOcZRaiJ27E8=;
  b=almZg6DDVdp/jUq9Jcc3EzfNXztqCRr0UuYZ217z+He7Tsp1x/vhkqXu
   NhDdsy+J5SCoXI2EY57JLFiDRB6Z546l9M4MMABU5U0mW8qu9gnCFs2BF
   AbciW+naNZDDJLjte7QDQi1DkNCq7QdCnCvev8w2q9WRUOR8WdFUkhoJX
   12PHshCUQs6KS/1zGa8o2lH+XEGHuLM/4FvapqvBg5VHX+u3KysrXAXUl
   ClbcSpsCkx3ssBRNs4efxEHxJkvJjzZgrZAkuB91oC2mRrfTS9E2Jbkqu
   z2kpmViHqrEy5hQ8B1kwYMP1C4TomQ2Ua3k2pAQB0+3OOcfB9XNbBaRwJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272421794"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272421794"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 19:20:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="715297402"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2022 19:20:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 97853109; Fri, 20 May 2022 05:20:52 +0300 (EEST)
Date:   Fri, 20 May 2022 05:20:52 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     frederic@kernel.org, paulmck@kernel.org, rjw@rjwysocki.net,
        x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC][PATCH 9/9] arch/idle: Change arch_cpu_idle() IRQ behaviour
Message-ID: <20220520022052.mkrc4v4evtp74bxe@black.fi.intel.com>
References: <20220519212750.656413111@infradead.org>
 <20220519213422.119695559@infradead.org>
 <20220519220349.GM2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519220349.GM2578@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:03:49AM +0200, Peter Zijlstra wrote:
> 
> On Thu, May 19, 2022 at 11:27:59PM +0200, Peter Zijlstra wrote:
> > --- a/arch/x86/coco/tdx/tdx.c
> > +++ b/arch/x86/coco/tdx/tdx.c
> > @@ -178,6 +178,9 @@ void __cpuidle tdx_safe_halt(void)
> >  	 */
> >  	if (__halt(irq_disabled, do_sti))
> >  		WARN_ONCE(1, "HLT instruction emulation failed\n");
> > +
> > +	/* XXX I can't make sense of what @do_sti actually does */
> > +	raw_local_irq_disable();
> >  }
> >  
> 
> Kirill, Dave says I should prod you :-)

It calls STI just before doing TDCALL that requests HLT.
See comment above $TDX_HCALL_ISSUE_STI usage in __tdx_hypercall()[1].

__halt(do_sti == true) matches native_safe_halt() semantics (or suppose
to) and __halt(do_sti == false) corresponds to native_halt().

For context, see Section 3.8 in GHCI[2]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/arch/x86/coco/tdx/tdcall.S?h=x86/tdx#n151
[2] https://www.intel.com/content/dam/develop/external/us/en/documents/intel-tdx-guest-hypervisor-communication-interface-1.0-344426-002.pdf

-- 
 Kirill A. Shutemov
