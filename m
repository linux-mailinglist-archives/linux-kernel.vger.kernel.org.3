Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8994054CD95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345080AbiFOPyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344198AbiFOPyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:54:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482F22FFF0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655308476; x=1686844476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qDm82Al5RdY5yk2Sk8uLzqG18X3zOv/St63Fun4bYIA=;
  b=VP6yeWoSsGTucRRysjSIUBPmzjpDO3solq2OY7A0YQvPk4S8OpmRw/wb
   TN/ippkcS8W6KafxFfOqLM/9LkoISKW0EmC9mukZrXoL1M3Btor31l4Fw
   /OvBfajJ+znxlvLhVswrEM5Rv3OgHNtfxdkgeWE71OMWskr/gueFBRsQy
   ES1mtx3qIxKnSEImb7PajtUWieMwzNwE34Zrkbrd66zr+Lmt3kDxqsn2t
   a4YaNrR6fKE19wlvVzxkRnTjDReka0CHuktklPZA42urpTkPnUsiZbVqE
   QKaJkG4eqZZTVFb6Dve+cQSZdd7SacVrajN7rmNWwmO6IlydudJMYaGhf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="340665774"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="340665774"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="652727965"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2022 08:54:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 67A85109; Wed, 15 Jun 2022 18:54:36 +0300 (EEST)
Date:   Wed, 15 Jun 2022 18:54:36 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 4/8] x86/mm: Handle LAM on context switch
Message-ID: <20220615155436.5fvosccsqbpscli4@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-5-kirill.shutemov@linux.intel.com>
 <d1a5615633f5e0376d7a75c1d8d12bbd89a7a63e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1a5615633f5e0376d7a75c1d8d12bbd89a7a63e.camel@intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:55:02PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2022-06-10 at 17:35 +0300, Kirill A. Shutemov wrote:
> > @@ -687,6 +716,7 @@ void initialize_tlbstate_and_flush(void)
> >         struct mm_struct *mm = this_cpu_read(cpu_tlbstate.loaded_mm);
> >         u64 tlb_gen = atomic64_read(&init_mm.context.tlb_gen);
> >         unsigned long cr3 = __read_cr3();
> > +       u64 lam = cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57);
> >  
> >         /* Assert that CR3 already references the right mm. */
> >         WARN_ON((cr3 & CR3_ADDR_MASK) != __pa(mm->pgd));
> > @@ -700,7 +730,7 @@ void initialize_tlbstate_and_flush(void)
> >                 !(cr4_read_shadow() & X86_CR4_PCIDE));
> >  
> >         /* Force ASID 0 and force a TLB flush. */
> > -       write_cr3(build_cr3(mm->pgd, 0));
> > +       write_cr3(build_cr3(mm->pgd, 0, lam));
> >  
> 
> Can you explain why to keep the lam bits that were in CR3 here? It
> seems to be worried some CR3 bits got changed and need to be set to a
> known state. Why not take them from the MM?
> 
> Also, it warns if the cr3 pfn doesn't match the mm pgd, should it warn
> if cr3 lam bits don't match the MM's copy?

You are right, taking LAM mode from init_mm is more correct. And we need
to update tlbstate with the new LAM mode. 

I think both CR3 and init_mm should LAM disabled here as we are bringing
CPU up. I'll add WARN_ON().

-- 
 Kirill A. Shutemov
