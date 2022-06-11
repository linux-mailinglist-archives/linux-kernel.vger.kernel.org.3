Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69E4547120
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 03:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348595AbiFKB2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 21:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242861AbiFKB2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 21:28:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917AF3FBBD7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654910911; x=1686446911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6kbuoWn2/Np3kiQGVvTfuTgoBDbVE2L6Exk4Okh2Jl0=;
  b=c7X7Mp51y5Ya5P5oU+RWzLFQwJEZL208xvHBLe3ADLRAi17HsGedXczD
   QG0jY+Hb6IiPxsve4PYdEEyi/7lGGpr55JeFtFnoTFWgpj2AWovj8RShG
   FMzEGbs31/yZkk4+nXAPIqW+BFpB206NQzCUuyYwLFwuVS2or5/OVP549
   t9bqHb1OeNFCwrvcQ541EjZGXyCbIQbT6DrqICqd9bOgSibgTeuPdahe1
   17+tKb5nbLeNWjN+xc+tOeHwfn4h/VDdfymiCVdE/PpIWdtZOOu78bl+f
   jKrtR6tfJsAg4xE5XDISs7o1DhwfNnSa3102nvpM8QnyMTz3Rz9I3D2hS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="260914147"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="260914147"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 18:28:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="650128436"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jun 2022 18:28:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A4535F8; Sat, 11 Jun 2022 04:28:30 +0300 (EEST)
Date:   Sat, 11 Jun 2022 04:28:30 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 7/8] x86: Expose untagging mask in
 /proc/$PID/arch_status
Message-ID: <20220611012830.hs437yikbjgwlije@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-8-kirill.shutemov@linux.intel.com>
 <144af1ab-1e7e-b75c-331c-d9c2e55b9062@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <144af1ab-1e7e-b75c-331c-d9c2e55b9062@intel.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 08:24:38AM -0700, Dave Hansen wrote:
> On 6/10/22 07:35, Kirill A. Shutemov wrote:
> > +/*
> > + * Report architecture specific information
> > + */
> > +int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
> > +			struct pid *pid, struct task_struct *task)
> > +{
> > +	/*
> > +	 * Report AVX512 state if the processor and build option supported.
> > +	 */
> > +	if (cpu_feature_enabled(X86_FEATURE_AVX512F))
> > +		avx512_status(m, task);
> > +
> > +	seq_printf(m, "untag_mask:\t%#lx\n", mm_untag_mask(task->mm));
> > +
> > +	return 0;
> > +}
> 
> Arch-specific gunk is great for, well, arch-specific stuff.  AVX-512 and
> its, um, "quirks", really won't show up anywhere else.  But x86 isn't
> even the first to be doing this address tagging business.
> 
> Shouldn't we be talking to the ARM folks about a common way to do this?

+ Catalin, Will.

I guess we can expose the mask via proc for ARM too, but I'm not sure if
we can unify interface further without breaking existing TBI users: TBI is
enabled per-thread while LAM is per-process.

Any opinions?

-- 
 Kirill A. Shutemov
