Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C1A520619
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiEIUqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiEIUpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:45:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B3248D1;
        Mon,  9 May 2022 13:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72320B81980;
        Mon,  9 May 2022 20:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D56C385BA;
        Mon,  9 May 2022 20:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652128903;
        bh=J8j9VzcB8Y4gabiwK3Jn4PyF1nARtTRu3BMbfR7/Pu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1rGwqCqVBponkVtMWTvVdEuLOszyeOvBvx2bPU/eDR5SQTj1L0gmKM3gf+/laYR8
         4VVpewzhS/3j9ng5/FE2+uOQV8nuan7ZGFSLvF09D8CB8y02sNe4F5fkcyaz5rldyg
         BrWWMGDW2tMk53H0eMlUAA2KGVzN7d/tojdLbv7pMV/+o+V+Q8gTRQiwOnL/iwLOj8
         D9TUcJRX1Ry1wMG0Fg4mw9RZEtsfwijkTLPqTzD5P7ajl18+RuiIOX3/pf5qEkCzXu
         8+awz7QDbUAQ0lLipKDFuSqDifz9iiLdqZuDONRffma3WxVFIeEPGr+oFbF8tr4TXz
         TyH7KrPc9tOrg==
Date:   Mon, 9 May 2022 15:50:56 -0500
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
Message-ID: <20220509205056.GA109715@embeddedor>
References: <20220509194541.GA91598@embeddedor>
 <202205091251.5703DE2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205091251.5703DE2@keescook>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 12:59:15PM -0700, Kees Cook wrote:
> On Mon, May 09, 2022 at 02:45:41PM -0500, Gustavo A. R. Silva wrote:
> > Fix the following -Wstringop-overflow warnings when building with GCC-12.1:
> > 
> > arch/x86/mm/pgtable.c:437:13: warning: 'preallocate_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > arch/x86/mm/pgtable.c:440:13: warning: 'preallocate_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > arch/x86/mm/pgtable.c:462:9: warning: 'free_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > arch/x86/mm/pgtable.c:454:9: warning: 'pgd_prepopulate_pmd' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > arch/x86/mm/pgtable.c:455:9: warning: 'pgd_prepopulate_user_pmd' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > arch/x86/mm/pgtable.c:464:9: warning: 'free_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > 
> > There is a case in which PREALLOCATED_PMDS, MAX_PREALLOCATED_PMDS,
> > PREALLOCATED_USER_PMDS and MAX_PREALLOCATED_USER_PMDS are defined as
> > zero:
> > 
> > 204 #else  /* !CONFIG_X86_PAE */
> > 205 
> > 206 /* No need to prepopulate any pagetable entries in non-PAE modes. */
> > 207 #define PREALLOCATED_PMDS       0
> > 208 #define MAX_PREALLOCATED_PMDS   0
> > 209 #define PREALLOCATED_USER_PMDS   0
> > 210 #define MAX_PREALLOCATED_USER_PMDS 0
> > 211 #endif  /* CONFIG_X86_PAE */
> > 
> > It seems that GCC is legitimately complaining about the fact that, under
> > certain circumstances, u_pmds and pmds are declared as zero-length arrays
> > in the stack and, of course, they are not flexible arrays.
> 
> Ah yeah, I've run into this a few times. Since the relationship between
> the macro pairs can't be seen by GCC, it gets upset (i.e. sizeof(u_pmds)
> has no relationship wtih PREALLOCATED_USER_PMDS and the calls weren't
> inlined, so it can't see that it'll always be 0 and 0).
> 
> > 424 pgd_t *pgd_alloc(struct mm_struct *mm)
> > 425 {
> > 426         pgd_t *pgd;
> > 427         pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
> > 428         pmd_t *pmds[MAX_PREALLOCATED_PMDS];
> > 429
> > 
> > Notice that "Accessing elements of zero-length arrays declared in such
> > contexts is undefined and may be diagnosed."[1]
> > 
> > We can fix this by checking that MAX_PREALLOCATED_PMDS and MAX_PREALLOCATED_USER_PMDS
> > are different than zero, prior to passing u_pmds amd pmds as arguments to any
> > function, in this case to functions preallocate_pmds(), pgd_prepopulate_pmd()
> > and free_pmds().
> > 
> > This helps with the ongoing efforts to globally enable
> > -Wstringop-overflow.
> > 
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > 
> > Link: https://github.com/KSPP/linux/issues/181
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > Changes in v2:
> >  - Check MAX_PREALLOCATED_PMDS and MAX_PREALLOCATED_USER_PMDS
> >    instead of using pointer notation.
> >    Link: https://lore.kernel.org/linux-hardening/20220401005834.GA182932@embeddedor/
> >  - Update changelog text.
> > 
> >  arch/x86/mm/pgtable.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> > index f16059e9a85e..96c3f402a1da 100644
> > --- a/arch/x86/mm/pgtable.c
> > +++ b/arch/x86/mm/pgtable.c
> > @@ -434,14 +434,18 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> >  
> >  	mm->pgd = pgd;
> >  
> > -	if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
> > -		goto out_free_pgd;
> > +	if (MAX_PREALLOCATED_PMDS != 0 && MAX_PREALLOCATED_USER_PMDS != 0) {
> > +		if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
> > +			goto out_free_pgd;
> >  
> > -	if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
> > -		goto out_free_pmds;
> > +		if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
> > +			goto out_free_pmds;
> >  
> > -	if (paravirt_pgd_alloc(mm) != 0)
> > -		goto out_free_user_pmds;
> > +		if (paravirt_pgd_alloc(mm) != 0)
> > +			goto out_free_user_pmds;
> > +	} else {
> > +		goto out_free_pgd;
> 
> The "all 0" case shouldn't be a failure mode; it should just skip the
> preallocate_pmds() calls.

Do you mean something like this:

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f16059e9a85e..4dae168408f1 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -434,11 +434,13 @@ pgd_t *pgd_alloc(struct mm_struct *mm)

        mm->pgd = pgd;

-       if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
-               goto out_free_pgd;
+       if (MAX_PREALLOCATED_PMDS != 0 && MAX_PREALLOCATED_USER_PMDS != 0) {
+               if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
+                       goto out_free_pgd;

-       if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
-               goto out_free_pmds;
+               if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
+                       goto out_free_pmds;
+       }

        if (paravirt_pgd_alloc(mm) != 0)
                goto out_free_user_pmds;

It seems that the above is not enough, because we have the same issue
when calling pgd_prepopulate_pmd(), pgd_prepopulate_user_pmd() and
free_pmds():

  CC      arch/x86/mm/pgtable.o
arch/x86/mm/pgtable.c: In function 'pgd_alloc':
arch/x86/mm/pgtable.c:464:9: warning: 'free_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
  464 |         free_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:464:9: note: referencing argument 2 of type 'pmd_t *[0]'
arch/x86/mm/pgtable.c:213:13: note: in a call to function 'free_pmds'
  213 | static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
      |             ^~~~~~~~~
arch/x86/mm/pgtable.c:466:9: warning: 'free_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
  466 |         free_pmds(mm, pmds, PREALLOCATED_PMDS);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:466:9: note: referencing argument 2 of type 'pmd_t *[0]'
arch/x86/mm/pgtable.c:213:13: note: in a call to function 'free_pmds'
  213 | static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
      |             ^~~~~~~~~
arch/x86/mm/pgtable.c:456:9: warning: 'pgd_prepopulate_pmd' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
  456 |         pgd_prepopulate_pmd(mm, pgd, pmds);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:456:9: note: referencing argument 3 of type 'pmd_t *[0]'
arch/x86/mm/pgtable.c:296:13: note: in a call to function 'pgd_prepopulate_pmd'
  296 | static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
      |             ^~~~~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:457:9: warning: 'pgd_prepopulate_user_pmd' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
  457 |         pgd_prepopulate_user_pmd(mm, pgd, u_pmds);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/pgtable.c:457:9: note: referencing argument 3 of type 'pmd_t *[0]'
arch/x86/mm/pgtable.c:320:13: note: in a call to function 'pgd_prepopulate_user_pmd'
  320 | static void pgd_prepopulate_user_pmd(struct mm_struct *mm,
      |             ^~~~~~~~~~~~~~~~~~~~~~~~

--
Gustavo
> 
> > +	}
> >  
> >  	/*
> >  	 * Make sure that pre-populating the pmds is atomic with
> > -- 
> > 2.27.0
> > 
> 
> -- 
> Kees Cook
