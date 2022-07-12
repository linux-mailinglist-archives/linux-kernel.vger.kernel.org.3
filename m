Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27D557219C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiGLROs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiGLROn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:14:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0FEB79F7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657646082; x=1689182082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8RMeG8zscE7DyFRKmEbCnGAL3Id+0MlNRoW2dx79+/U=;
  b=cTg+6L+zqjPKM1zZmoY5FRBqRnDWT9a/6i1pOpyynJC1/gKieh6DJT/V
   8a2fKt5e4ETmCYbsKSJDIlZ9KNz3Obi8SS0fIHylirypD9ekG3gOd3a0V
   FhLtI05jvAm3+wz0nUIg1S9J7fsTFTN9G/zc6Je0szjy08NdGu3eCdxAk
   9w18/iUxiv24jcaSjdZJO9pcDoalPCh6aA2itnfhjAG8JmXvI+LMJRbxz
   Tgj46BGv+nlDVQNO1RBO3eEfEjofmTp+9GgIhHXcrFO1NhSH7/mMx+72h
   YJ7e2taAXoyQRAwm2MsMfACnNYkZGHDiUVjVi+N4KYG4BuKtIvkYNmMZZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="348968940"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="348968940"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 10:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="663028079"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2022 10:14:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 442FDF1; Tue, 12 Jul 2022 20:14:46 +0300 (EEST)
Date:   Tue, 12 Jul 2022 20:14:45 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Message-ID: <20220712171445.74b46mgdxgaub3qj@black.fi.intel.com>
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
 <20220622162230.83474-7-kirill.shutemov@linux.intel.com>
 <CAG_fn=Uo8E-6r3otLPC9iEfO02=A0=zROO8R8TL=8vXVZVE5Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=Uo8E-6r3otLPC9iEfO02=A0=zROO8R8TL=8vXVZVE5Ww@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:12:01PM +0200, Alexander Potapenko wrote:
> On Wed, Jun 22, 2022 at 6:22 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > Add a couple of arch_prctl() handles:
> >
> >  - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required number
> >    of tag bits. It is rounded up to the nearest LAM mode that can
> >    provide it. For now only LAM_U57 is supported, with 6 tag bits.
> >
> >  - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
> >    bits located in the address.
> >
> Am I right that the desired way to detect the presence of LAM without
> enabling it is to check that arch_prctl(ARCH_GET_UNTAG_MASK, ...)
> returns zero?

Returns -1UL, but yes.

> Overall, I think these new arch_prctls should be documented following
> the spirit of PR_SET_TAGGED_ADDR_CTRL/PR_GET_TAGGED_ADDR_CTRL
> somewhere.

The plan is to update man page for the syscall once the interface is
upstream.

> > +
> > +static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
> > +{
> > +       int ret = 0;
> > +
> > +       if (!cpu_feature_enabled(X86_FEATURE_LAM))
> > +               return -ENODEV;
> > +
> > +       mutex_lock(&mm->context.lock);
> > +
> > +       /* Already enabled? */
> > +       if (mm->context.lam_cr3_mask) {
> > +               ret = -EBUSY;
> > +               goto out;
> > +       }
> > +
> > +       if (!nr_bits) {
> > +               ret = -EINVAL;
> 
> One would expect that `arch_prctl(ARCH_ENABLE_TAGGED_ADDR, 0)`
> disables tagging for the current process.
> Shouldn't this workflow be supported as well?

Is there an use-case for it?

I would rather keep the interface minimal. We can always add this in the
future if an use-case comes.

-- 
 Kirill A. Shutemov
