Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60419550009
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 00:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbiFQWjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 18:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiFQWjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:39:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6534BBA9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655505583; x=1687041583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wG47mPH2ny+DfuBj61UmcLRLOVow6f7xHscwu0hdrEU=;
  b=YctMdPyMcbZmJ0i98FRnnR+wkfIyoQD4hfEtgAtgkCv/gwM/yamj1D/m
   16XW/uui+rH1dS26YFi9c/yoou9dVZeQ8NeCcHRF2ZS+8deD3KHZutxAd
   vPI3ta+O/KWbiH68oDnTydGTg/E/xQLlJSkBqy8m0rh7T/0WFlh8tqgDP
   +K+/Smm4wPpPQo2pvN6ZAF70MBtCbT/AofDMScLd83h6rxXfsn7F3Igvv
   1BJNkZrvjNalEaY6MZPxthZuhh/8XlMvdhhuTNfi7u8khNIFim/g59HgR
   Qo4BExfs97QmHKwIbeisks8Z7TvzLhARZY/5vLkjoI+haveAD8nO+ttIq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277150282"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277150282"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 15:39:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="688494714"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2022 15:39:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E6ACB132; Sat, 18 Jun 2022 01:39:38 +0300 (EEST)
Date:   Sat, 18 Jun 2022 01:39:38 +0300
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
Subject: Re: [PATCHv3 4/8] x86/mm: Handle LAM on context switch
Message-ID: <20220617223938.3qeb7tjr7wdjas27@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
 <CAG_fn=U4hETfYrRbZMJ2xEEgP+FzWmYX+u+Kr=x0NkytU6nGfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=U4hETfYrRbZMJ2xEEgP+FzWmYX+u+Kr=x0NkytU6nGfg@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 05:35:05PM +0200, Alexander Potapenko wrote:
> On Fri, Jun 10, 2022 at 4:35 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > Linear Address Masking mode for userspace pointers encoded in CR3 bits.
> > The mode is selected per-thread. Add new thread features indicate that the
> > thread has Linear Address Masking enabled.
> >
> > switch_mm_irqs_off() now respects these flags and constructs CR3
> > accordingly.
> >
> > The active LAM mode gets recorded in the tlb_state.
> >
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> 
> > +#ifdef CONFIG_X86_64
> > +static inline u64 mm_cr3_lam_mask(struct mm_struct *mm)
> > +{
> > +       return mm->context.lam_cr3_mask;
> > +}
> 
> Nit: can we have either "cr3_lam_mask" or "lam_cr3_mask" in both places?

With changes sugessted by Peter, the field in the mmu_context will be
called 'lam' as it is not CR3 mask anymore.

-- 
 Kirill A. Shutemov
