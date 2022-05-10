Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95968521C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241330AbiEJOox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344620AbiEJOog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:44:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C211DEC75;
        Tue, 10 May 2022 07:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCB86B81D24;
        Tue, 10 May 2022 14:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA710C385A6;
        Tue, 10 May 2022 14:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652191368;
        bh=pXXoszgqztIzFdVEytP5/nh7IS85OJYmozKf5aOzEls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cf4KTPXNa1Kora/wu6F3M+JrfXmfxtJ0Ux46u27TvT4TnFDFeK29GuUANLm4paIQ8
         ZMax9E6tEtpvHeZgVnjaCER0/5P5YkHXP7MKbvpvjHjA8Sh7ran3oYk73iwBoO12wo
         KBh6Ui5Xu5WEOFxYG8GMQppcOLLfP6foKKTXg/CMJUeIkmBWzUXZkkTtJF3Vqjx8MU
         QEKxF/JijUKYQSjoxQHKEKMzJIpxDoK1Y5Be9dKzR7xrnl9FL+YM7CzuqCpn1r1Cxz
         ocenxW55uQrBsnwdvc5BkXtOSmavqCFsXmpDFHPTxyHDpH3+2TW5TxIHW7maRjbM3B
         S1eqN8eU0mhPA==
Date:   Tue, 10 May 2022 09:12:02 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] x86/mm/pgtable: Fix -Wstringop-overflow warnings
Message-ID: <20220510141202.GA6878@embeddedor>
References: <20220509194541.GA91598@embeddedor>
 <202205091251.5703DE2@keescook>
 <20220509205056.GA109715@embeddedor>
 <202205091351.6E0BA523@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205091351.6E0BA523@keescook>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 01:54:32PM -0700, Kees Cook wrote:
> On Mon, May 09, 2022 at 03:50:56PM -0500, Gustavo A. R. Silva wrote:
> > On Mon, May 09, 2022 at 12:59:15PM -0700, Kees Cook wrote:
> > > On Mon, May 09, 2022 at 02:45:41PM -0500, Gustavo A. R. Silva wrote:
> > > > Fix the following -Wstringop-overflow warnings when building with GCC-12.1:
> > > > 
> > > > arch/x86/mm/pgtable.c:437:13: warning: 'preallocate_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > > > arch/x86/mm/pgtable.c:440:13: warning: 'preallocate_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > > > arch/x86/mm/pgtable.c:462:9: warning: 'free_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > > > arch/x86/mm/pgtable.c:454:9: warning: 'pgd_prepopulate_pmd' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > > > arch/x86/mm/pgtable.c:455:9: warning: 'pgd_prepopulate_user_pmd' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > > > arch/x86/mm/pgtable.c:464:9: warning: 'free_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > > > 
> > > > There is a case in which PREALLOCATED_PMDS, MAX_PREALLOCATED_PMDS,
> > > > PREALLOCATED_USER_PMDS and MAX_PREALLOCATED_USER_PMDS are defined as
> > > > zero:
> > > > 
> > > > 204 #else  /* !CONFIG_X86_PAE */
> > > > 205 
> > > > 206 /* No need to prepopulate any pagetable entries in non-PAE modes. */
> > > > 207 #define PREALLOCATED_PMDS       0
> > > > 208 #define MAX_PREALLOCATED_PMDS   0
> > > > 209 #define PREALLOCATED_USER_PMDS   0
> > > > 210 #define MAX_PREALLOCATED_USER_PMDS 0
> > > > 211 #endif  /* CONFIG_X86_PAE */
> > > > 
> > > > It seems that GCC is legitimately complaining about the fact that, under
> > > > certain circumstances, u_pmds and pmds are declared as zero-length arrays
> > > > in the stack and, of course, they are not flexible arrays.
> > > 
> > > Ah yeah, I've run into this a few times. Since the relationship between
> > > the macro pairs can't be seen by GCC, it gets upset (i.e. sizeof(u_pmds)
> > > has no relationship wtih PREALLOCATED_USER_PMDS and the calls weren't
> > > inlined, so it can't see that it'll always be 0 and 0).
> > > 
> > > > 424 pgd_t *pgd_alloc(struct mm_struct *mm)
> > > > 425 {
> > > > 426         pgd_t *pgd;
> > > > 427         pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
> > > > 428         pmd_t *pmds[MAX_PREALLOCATED_PMDS];
> > > > 429
> > > > 
> > > > Notice that "Accessing elements of zero-length arrays declared in such
> > > > contexts is undefined and may be diagnosed."[1]
> > > > 
> > > > We can fix this by checking that MAX_PREALLOCATED_PMDS and MAX_PREALLOCATED_USER_PMDS
> > > > are different than zero, prior to passing u_pmds amd pmds as arguments to any
> > > > function, in this case to functions preallocate_pmds(), pgd_prepopulate_pmd()
> > > > and free_pmds().
> > > > 
> > > > This helps with the ongoing efforts to globally enable
> > > > -Wstringop-overflow.
> > > > 
> > > > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > > > 
> > > > Link: https://github.com/KSPP/linux/issues/181
> > > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > ---
> > > > Changes in v2:
> > > >  - Check MAX_PREALLOCATED_PMDS and MAX_PREALLOCATED_USER_PMDS
> > > >    instead of using pointer notation.
> > > >    Link: https://lore.kernel.org/linux-hardening/20220401005834.GA182932@embeddedor/
> > > >  - Update changelog text.
> > > > 
> > > >  arch/x86/mm/pgtable.c | 16 ++++++++++------
> > > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> > > > index f16059e9a85e..96c3f402a1da 100644
> > > > --- a/arch/x86/mm/pgtable.c
> > > > +++ b/arch/x86/mm/pgtable.c
> > > > @@ -434,14 +434,18 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> > > >  
> > > >  	mm->pgd = pgd;
> > > >  
> > > > -	if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
> > > > -		goto out_free_pgd;
> > > > +	if (MAX_PREALLOCATED_PMDS != 0 && MAX_PREALLOCATED_USER_PMDS != 0) {
> > > > +		if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
> > > > +			goto out_free_pgd;
> > > >  
> > > > -	if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
> > > > -		goto out_free_pmds;
> > > > +		if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
> > > > +			goto out_free_pmds;
> > > >  
> > > > -	if (paravirt_pgd_alloc(mm) != 0)
> > > > -		goto out_free_user_pmds;
> > > > +		if (paravirt_pgd_alloc(mm) != 0)
> > > > +			goto out_free_user_pmds;
> > > > +	} else {
> > > > +		goto out_free_pgd;
> > > 
> > > The "all 0" case shouldn't be a failure mode; it should just skip the
> > > preallocate_pmds() calls.
> > 
> > Do you mean something like this:
> > 
> > diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> > index f16059e9a85e..4dae168408f1 100644
> > --- a/arch/x86/mm/pgtable.c
> > +++ b/arch/x86/mm/pgtable.c
> > @@ -434,11 +434,13 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> > 
> >         mm->pgd = pgd;
> > 
> > -       if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
> > -               goto out_free_pgd;
> > +       if (MAX_PREALLOCATED_PMDS != 0 && MAX_PREALLOCATED_USER_PMDS != 0) {
> > +               if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
> > +                       goto out_free_pgd;
> > 
> > -       if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
> > -               goto out_free_pmds;
> > +               if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
> > +                       goto out_free_pmds;
> > +       }
> > 
> >         if (paravirt_pgd_alloc(mm) != 0)
> >                 goto out_free_user_pmds;
> > 
> > It seems that the above is not enough, because we have the same issue
> > when calling pgd_prepopulate_pmd(), pgd_prepopulate_user_pmd() and
> > free_pmds():
> > 
> >   CC      arch/x86/mm/pgtable.o
> > arch/x86/mm/pgtable.c: In function 'pgd_alloc':
> > arch/x86/mm/pgtable.c:464:9: warning: 'free_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> >   464 |         free_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS);
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Ugh. Perhaps just marking both preallocate_pmds() and free_pmds() as
> inline is enough to let the compiler "see" everything correctly?

It doesn't seem to work... however, the following piece of code implies
that pmds and u_pmds should be first preallocated through preallocate_pmds(),
which cannot happen if (MAX_PREALLOCATED_PMDS != 0 && MAX_PREALLOCATED_USER_PMDS != 0)

448         /*
449          * Make sure that pre-populating the pmds is atomic with
450          * respect to anything walking the pgd_list, so that they
451          * never see a partially populated pgd.
452          */
453         spin_lock(&pgd_lock);
454
455         pgd_ctor(mm, pgd);
456         pgd_prepopulate_pmd(mm, pgd, pmds);
457         pgd_prepopulate_user_pmd(mm, pgd, u_pmds);
458
459         spin_unlock(&pgd_lock);
460
461         return pgd;

So, my question here is why do you think the "all 0" case should only skip the
preallocate_pmds() calls and not the pgd_prepopulate_pmd() calls too?

> 
> Otherwise, they'll likely each need the same check that was added to
> pgd_prepopulate_pmd() ages ago for a similar situation...

uhm... that doesn't seem to have an impact nowadays, or at least now
Wstringop-overflow sees the problem first, because now the issue is
detected at the moment of passing the arguments to the the function
and not when actually executing the function?

otherwise, I think we wouldn't see this error:

arch/x86/mm/pgtable.c:454:9: warning: 'pgd_prepopulate_pmd' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
  454 |         pgd_prepopulate_pmd(mm, pgd, pmds);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:454:9: note: referencing argument 3 of type 'pmd_t *[0]'
arch/x86/mm/pgtable.c:296:13: note: in a call to function 'pgd_prepopulate_pmd'
  296 | static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
      |             ^~~~~~~~~~~~~~~~~~~


Thanks
--
Gustavo
