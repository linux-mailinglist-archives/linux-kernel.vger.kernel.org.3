Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECA957B694
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiGTMi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiGTMi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:38:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191604D4EA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658320707; x=1689856707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rAu6jpHhECuVsZhliLNHW/MdjQNLrwdQjmE6gnDMnzM=;
  b=BkoxqAydOAIU3mahg2C9rzxK05NSMDcJZDHy5mRn+6+zlehgE9+jBOBw
   lCEnEq+phTHvaRsFpsEbMRtKoqyAj1lcL8sqMuRy5qLIc+YMqz1VVJP+C
   8GlggBeWxDGwxHSshPPLi8PumaChn8fToS1DifiZa2nV+sl55Vd8OitWo
   ye2L1rBjs/nf2yFEyk3PcsQ74hjT9KQ/8b4wZEGqgwyXCjdnxweP4RtaC
   MVJzZ8DKaOTxI91437mUqZ/iZnFtKG0AXpJy2qXZr9KdMfyNV/3W5vOjw
   uVqUZb/WJRAvTqvs2SVcq4ng0k/JT2T4weZdHdSDEY1XI+EjWNfI/67mB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="373065392"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="373065392"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 05:38:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="740273645"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2022 05:38:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E8798199; Wed, 20 Jul 2022 15:38:31 +0300 (EEST)
Date:   Wed, 20 Jul 2022 15:38:31 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Kostya Serebryany <kcc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCHv5.1 04/13] x86/mm: Handle LAM on context switch
Message-ID: <20220720123831.ebftged5jjpw3mfy@black.fi.intel.com>
References: <20220712231328.5294-6-kirill.shutemov@linux.intel.com>
 <20220713150200.17080-1-kirill.shutemov@linux.intel.com>
 <CAG_fn=VVBOe8cvbWSMLfJf577yirThABQOMmihNW4pg55Sfhfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=VVBOe8cvbWSMLfJf577yirThABQOMmihNW4pg55Sfhfg@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 10:57:01AM +0200, Alexander Potapenko wrote:
> >         /*
> > @@ -491,6 +493,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
> >  {
> >         struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
> >         u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> > +       unsigned long prev_lam = tlbstate_lam_cr3_mask();
> Note: this variable is never used if CONFIG_DEBUG_VM is off.

Good point. I will add this:

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 4c93f87a8928..5e9ed9f55c36 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -558,6 +558,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	if (real_prev == next) {
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
+		VM_WARN_ON(prev_lam != new_lam);

 		/*
 		 * Even in lazy TLB mode, the CPU should stay set in the
-- 
 Kirill A. Shutemov
