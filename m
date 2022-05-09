Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D5752063D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 22:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiEIU6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 16:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiEIU62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 16:58:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF4120F9F6
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 13:54:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w17-20020a17090a529100b001db302efed6so408130pjh.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 13:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n5pWkW8vyxdahuBYLn1QEYI5QGj49/IF8mdNBcsPP+I=;
        b=iJof/KR0Ikeg2KpC/9dEBhujUSudsPA3ZV3jaGU0iQydTU/CvmWvToXlMVPcHukeOY
         yEwNZQ93Y2RUAtizBvNGz+KW6uaqiPHAdl1J+f3g2L3AZPMQS14PgNgnSD2gEcyUYs31
         +mmmvSYUuEKp8iFi/1i/H/6zNjeI1BDOj2zPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n5pWkW8vyxdahuBYLn1QEYI5QGj49/IF8mdNBcsPP+I=;
        b=e7gA9Q/uEaUa2Dzx/ewlohv+m7roqIF7rI1Ktll+US6df+48YRPSXT2X0gJyx2Cy/L
         0Dnq66svEHB7i1h0u50pDBpNjdyxMAtm36AzsjOMe/Bryw8XKWgktM2Zw8cgFIQMiaxW
         utGjKcOMF2wMW5u77CXeaKVnDV/rtWZi333eKd3URUKyJyziORh5W+w+MKZ+lSo4K2Hu
         yeRwXicQnDw6mmG6TpWa32PKvRw1o0KqNeRGhj18d1hUHR1YPT5yrl2gc5LmMr0P2vUu
         QcHX+uYMQ+I7laADvd012s3YMwUrQkwz25YSzEW7CMD5eZRV33E1husVD5JaXeg+ELui
         yDjw==
X-Gm-Message-State: AOAM530qhPX14sYn2xo9GYANYZZtnnppQthx9gMVFNtKi8DDar1xvGyc
        YqVmo8778BcTne7ZMe0rU87/9t2KzleQCQ==
X-Google-Smtp-Source: ABdhPJywSwIrtfva2y7nf5o9xsTAWEXdf6saLoz4JLLYV517uWxjBUxw7W485XVNMI/eDBoaFDUIDg==
X-Received: by 2002:a17:902:bf4c:b0:15c:3d1b:8a47 with SMTP id u12-20020a170902bf4c00b0015c3d1b8a47mr18434601pls.118.1652129673334;
        Mon, 09 May 2022 13:54:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id br11-20020a056a00440b00b0050dc7628151sm8951821pfb.43.2022.05.09.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 13:54:33 -0700 (PDT)
Date:   Mon, 9 May 2022 13:54:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] x86/mm/pgtable: Fix -Wstringop-overflow warnings
Message-ID: <202205091351.6E0BA523@keescook>
References: <20220509194541.GA91598@embeddedor>
 <202205091251.5703DE2@keescook>
 <20220509205056.GA109715@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509205056.GA109715@embeddedor>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 03:50:56PM -0500, Gustavo A. R. Silva wrote:
> On Mon, May 09, 2022 at 12:59:15PM -0700, Kees Cook wrote:
> > On Mon, May 09, 2022 at 02:45:41PM -0500, Gustavo A. R. Silva wrote:
> > > Fix the following -Wstringop-overflow warnings when building with GCC-12.1:
> > > 
> > > arch/x86/mm/pgtable.c:437:13: warning: 'preallocate_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > > arch/x86/mm/pgtable.c:440:13: warning: 'preallocate_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > > arch/x86/mm/pgtable.c:462:9: warning: 'free_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > > arch/x86/mm/pgtable.c:454:9: warning: 'pgd_prepopulate_pmd' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > > arch/x86/mm/pgtable.c:455:9: warning: 'pgd_prepopulate_user_pmd' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > > arch/x86/mm/pgtable.c:464:9: warning: 'free_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
> > > 
> > > There is a case in which PREALLOCATED_PMDS, MAX_PREALLOCATED_PMDS,
> > > PREALLOCATED_USER_PMDS and MAX_PREALLOCATED_USER_PMDS are defined as
> > > zero:
> > > 
> > > 204 #else  /* !CONFIG_X86_PAE */
> > > 205 
> > > 206 /* No need to prepopulate any pagetable entries in non-PAE modes. */
> > > 207 #define PREALLOCATED_PMDS       0
> > > 208 #define MAX_PREALLOCATED_PMDS   0
> > > 209 #define PREALLOCATED_USER_PMDS   0
> > > 210 #define MAX_PREALLOCATED_USER_PMDS 0
> > > 211 #endif  /* CONFIG_X86_PAE */
> > > 
> > > It seems that GCC is legitimately complaining about the fact that, under
> > > certain circumstances, u_pmds and pmds are declared as zero-length arrays
> > > in the stack and, of course, they are not flexible arrays.
> > 
> > Ah yeah, I've run into this a few times. Since the relationship between
> > the macro pairs can't be seen by GCC, it gets upset (i.e. sizeof(u_pmds)
> > has no relationship wtih PREALLOCATED_USER_PMDS and the calls weren't
> > inlined, so it can't see that it'll always be 0 and 0).
> > 
> > > 424 pgd_t *pgd_alloc(struct mm_struct *mm)
> > > 425 {
> > > 426         pgd_t *pgd;
> > > 427         pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
> > > 428         pmd_t *pmds[MAX_PREALLOCATED_PMDS];
> > > 429
> > > 
> > > Notice that "Accessing elements of zero-length arrays declared in such
> > > contexts is undefined and may be diagnosed."[1]
> > > 
> > > We can fix this by checking that MAX_PREALLOCATED_PMDS and MAX_PREALLOCATED_USER_PMDS
> > > are different than zero, prior to passing u_pmds amd pmds as arguments to any
> > > function, in this case to functions preallocate_pmds(), pgd_prepopulate_pmd()
> > > and free_pmds().
> > > 
> > > This helps with the ongoing efforts to globally enable
> > > -Wstringop-overflow.
> > > 
> > > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > > 
> > > Link: https://github.com/KSPP/linux/issues/181
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > > Changes in v2:
> > >  - Check MAX_PREALLOCATED_PMDS and MAX_PREALLOCATED_USER_PMDS
> > >    instead of using pointer notation.
> > >    Link: https://lore.kernel.org/linux-hardening/20220401005834.GA182932@embeddedor/
> > >  - Update changelog text.
> > > 
> > >  arch/x86/mm/pgtable.c | 16 ++++++++++------
> > >  1 file changed, 10 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> > > index f16059e9a85e..96c3f402a1da 100644
> > > --- a/arch/x86/mm/pgtable.c
> > > +++ b/arch/x86/mm/pgtable.c
> > > @@ -434,14 +434,18 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> > >  
> > >  	mm->pgd = pgd;
> > >  
> > > -	if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
> > > -		goto out_free_pgd;
> > > +	if (MAX_PREALLOCATED_PMDS != 0 && MAX_PREALLOCATED_USER_PMDS != 0) {
> > > +		if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
> > > +			goto out_free_pgd;
> > >  
> > > -	if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
> > > -		goto out_free_pmds;
> > > +		if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
> > > +			goto out_free_pmds;
> > >  
> > > -	if (paravirt_pgd_alloc(mm) != 0)
> > > -		goto out_free_user_pmds;
> > > +		if (paravirt_pgd_alloc(mm) != 0)
> > > +			goto out_free_user_pmds;
> > > +	} else {
> > > +		goto out_free_pgd;
> > 
> > The "all 0" case shouldn't be a failure mode; it should just skip the
> > preallocate_pmds() calls.
> 
> Do you mean something like this:
> 
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index f16059e9a85e..4dae168408f1 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -434,11 +434,13 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
> 
>         mm->pgd = pgd;
> 
> -       if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
> -               goto out_free_pgd;
> +       if (MAX_PREALLOCATED_PMDS != 0 && MAX_PREALLOCATED_USER_PMDS != 0) {
> +               if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
> +                       goto out_free_pgd;
> 
> -       if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
> -               goto out_free_pmds;
> +               if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
> +                       goto out_free_pmds;
> +       }
> 
>         if (paravirt_pgd_alloc(mm) != 0)
>                 goto out_free_user_pmds;
> 
> It seems that the above is not enough, because we have the same issue
> when calling pgd_prepopulate_pmd(), pgd_prepopulate_user_pmd() and
> free_pmds():
> 
>   CC      arch/x86/mm/pgtable.o
> arch/x86/mm/pgtable.c: In function 'pgd_alloc':
> arch/x86/mm/pgtable.c:464:9: warning: 'free_pmds' accessing 8 bytes in a region of size 0 [-Wstringop-overflow=]
>   464 |         free_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ugh. Perhaps just marking both preallocate_pmds() and free_pmds() as
inline is enough to let the compiler "see" everything correctly?

Otherwise, they'll likely each need the same check that was added to
pgd_prepopulate_pmd() ages ago for a similar situation...

-- 
Kees Cook
