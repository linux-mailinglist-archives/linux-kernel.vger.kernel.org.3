Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022B1593470
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 20:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiHOSCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiHOSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:02:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972B22872A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vIBK6gqGPEdsPWZL796FQ/Qaj+IzDk4kXPXl+Fjs5Qc=; b=V1qfXlrOSBgxCqNKtNN+fI+W3w
        MfSO8DUPgSt95sFZnSbXwlCZpB5imAFmJMNUmqkqqY1ONxWUctzEK33zFETfOTazeDDVS+1/fCOfl
        +SWTy2fmY0IiJbHxFpRVe5bsZr8kotWD4tEPElP/L9P8pT3mHtpGaMjns7a0owPfd9OQRp/O8Vnpb
        q4GCAOs25wPM6qrOpnb0R0ge01nIx3kPjABeLAIIqvJJabEbITBhbTN1NGb1IBHKa51uP1cwumtvY
        sY46gjFFpD+0LOxcmQktjwTzz7BwtIhV+EktmP+Q9e0/htuvcYSv0CVXgF4b/CnZgZNCyzC3lf+xv
        UpZQntCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNePs-005wGB-SA; Mon, 15 Aug 2022 18:02:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 656FD980264; Mon, 15 Aug 2022 20:02:17 +0200 (CEST)
Date:   Mon, 15 Aug 2022 20:02:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 04/11] x86/mm: Handle LAM on context switch
Message-ID: <YvqKKQRpGDTGr+pU@worktop.programming.kicks-ass.net>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
 <20220815041803.17954-5-kirill.shutemov@linux.intel.com>
 <YvpNQSEtu+Tbqrpd@worktop.programming.kicks-ass.net>
 <20220815173725.ph6ogtqneiqwqek7@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815173725.ph6ogtqneiqwqek7@box.shutemov.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 08:37:25PM +0300, Kirill A. Shutemov wrote:
> On Mon, Aug 15, 2022 at 03:42:25PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 15, 2022 at 07:17:56AM +0300, Kirill A. Shutemov wrote:
> > > diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> > > index c1e31e9a85d7..fdc0b69b5da7 100644
> > > --- a/arch/x86/mm/tlb.c
> > > +++ b/arch/x86/mm/tlb.c
> > > @@ -154,17 +154,18 @@ static inline u16 user_pcid(u16 asid)
> > >  	return ret;
> > >  }
> > >  
> > > -static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
> > > +static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
> > >  {
> > >  	if (static_cpu_has(X86_FEATURE_PCID)) {
> > > -		return __sme_pa(pgd) | kern_pcid(asid);
> > > +		return __sme_pa(pgd) | kern_pcid(asid) | lam;
> > >  	} else {
> > >  		VM_WARN_ON_ONCE(asid != 0);
> > > -		return __sme_pa(pgd);
> > > +		return __sme_pa(pgd) | lam;
> > >  	}
> > >  }
> > >  
> > > -static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
> > > +static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid,
> > > +					      unsigned long lam)
> > >  {
> > >  	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
> > >  	/*
> > > @@ -173,7 +174,7 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
> > >  	 * boot because all CPU's the have same capabilities:
> > >  	 */
> > >  	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
> > > -	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
> > > +	return __sme_pa(pgd) | kern_pcid(asid) | lam | CR3_NOFLUSH;
> > >  }
> > 
> > Looking at this; I wonder if we want something like this:
> > 
> > --- a/arch/x86/mm/tlb.c
> > +++ b/arch/x86/mm/tlb.c
> > @@ -157,6 +157,7 @@ static inline u16 user_pcid(u16 asid)
> >  static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
> >  {
> >  	if (static_cpu_has(X86_FEATURE_PCID)) {
> > +		VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
> >  		return __sme_pa(pgd) | kern_pcid(asid) | lam;
> >  	} else {
> >  		VM_WARN_ON_ONCE(asid != 0);
> > @@ -167,14 +168,13 @@ static inline unsigned long build_cr3(pg
> >  static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid,
> >  					      unsigned long lam)
> >  {
> > -	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
> >  	/*
> >  	 * Use boot_cpu_has() instead of this_cpu_has() as this function
> >  	 * might be called during early boot. This should work even after
> >  	 * boot because all CPU's the have same capabilities:
> >  	 */
> >  	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
> > -	return __sme_pa(pgd) | kern_pcid(asid) | lam | CR3_NOFLUSH;
> > +	return build_cr3(pgd, asid, lam) | CR3_NOFLUSH;
> >  }
> 
> Looks sane, but seems unrelated to the patch. Is it okay to fold it
> anyway?

Related in so far as that it reduces the number of sites where we have
the actual CR3 'computation' (which is how I arrived at the thing).

Arguably we could even do something like:

static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
{
	unsigned long cr3 = __sme_pa(pgd) | lam;

	if (static_cpu_has(X86_FEATURE_PCID)) {
		VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
		cr |= kern_pcid(asid);
	} else {
		VM_WARN_ON_ONCE(asid != 0);
	}

	return cr3;
}

But perhaps that's pushing things a little.

IMO fine to fold.
