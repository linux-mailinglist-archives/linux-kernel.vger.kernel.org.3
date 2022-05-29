Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D453708B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 12:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiE2Kcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 06:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiE2Kco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 06:32:44 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2019740E55
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:32:41 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 2so8830840iou.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LwwoQYR2ORpRNhK4MoMYiNzHU8QyLU3W9ubNdWH2aeo=;
        b=MVeQo4cZ/E0x6L7YEyK/+zDWpm10pgfLFBacjunWcD8PSlL2po4SV7xzR8nUnm2Rc3
         h6Rm2PGjwh90MOQdyF1hzO+WKvAhOZTIAB9AaHiYiZX/VTMUnnvNRYv02nicDGgVRzA8
         cwZXJkLTilVXb9401oQ1eT1bZswmIv8F/BySHzJsW+GGZD+nzqzN1pxMmSNoNlDfLB77
         ZSSXEJfXwBWbu3NTsROTFq8OoDab3eI85PICiNyAesF4e3rWVYtcHf0oTmg5vR0aqQnw
         pTYvD/aaIOmw5W13u+vg5VgEkMUCdAN3ogIbk+5GOxDjPEo6hPSBaFyOltb0AGbbnLR7
         MCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LwwoQYR2ORpRNhK4MoMYiNzHU8QyLU3W9ubNdWH2aeo=;
        b=OdqFrqC6OPBhfS+F/aHEoSXQGzrQsGnQ55wjZF3MTUG7vjuHhQ4INAxZdmZShCX9rK
         C4MXRnm5ZvF9Bt4gPKvpfX5BX7V2SsEyUPUODXtuHt3juHC5jkR2W2AmLWoDT3GPvrZM
         z5EQTezcImKZnR01cwB/Kos5Hzophp1NoJEMdsNRyCEIdVP1LUosXgHE8Ti41xN/YwK/
         N2qdmVISOgIxMHuyiL6gvUrtrcR05MP+zxe0TZQ1tUbRPzUJcU5rTQstIWOI51rUEO1F
         1uKk0DyS9bPyKAfaPpPqMLWL0ZGJ1g/tEc09su6RUxxEaskDlgmWaBzk3Gszf0qeX5tI
         w37g==
X-Gm-Message-State: AOAM533M87VZ+gQZpJUv/FYJIOXs7MFzt9sypz55vJJkvDp/nLlaplLJ
        zTDPS3Sq7/eITu7xARW7Zls=
X-Google-Smtp-Source: ABdhPJwPhNG/9jG22wHXfc3SUixEmr9mAtpCKn02IlcEatGkfhRZMQCgqgap3G57mZ2FECfYJcOR4w==
X-Received: by 2002:a05:6638:2601:b0:331:3a3:3bd8 with SMTP id m1-20020a056638260100b0033103a33bd8mr3546750jat.62.1653820360416;
        Sun, 29 May 2022 03:32:40 -0700 (PDT)
Received: from n2.us-central1-a.c.spheric-algebra-350919.internal (151.16.70.34.bc.googleusercontent.com. [34.70.16.151])
        by smtp.gmail.com with ESMTPSA id x18-20020a927c12000000b002d149ec2606sm2794127ilc.65.2022.05.29.03.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 03:32:39 -0700 (PDT)
Date:   Sun, 29 May 2022 10:32:37 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        akpm@linux-foundation.org, willy@infradead.org
Subject: Re: Is _PAGE_PROTNONE set only for user mappings?
Message-ID: <YpNLxXvGFQpyPjRa@n2.us-central1-a.c.spheric-algebra-350919.internal>
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
 <56f89895-601e-44c9-bda4-5fae6782e27e@amd.com>
 <YnpTHMvOO/pLJQ+l@hyeyoo>
 <5fe161cb-6c55-6c4d-c208-16c77e115d3f@amd.com>
 <8c2735ac-0335-6e2a-8341-8266d5d13c30@intel.com>
 <YntHrTX12TGp35aF@hyeyoo>
 <20220512103748.GH3441@techsingularity.net>
 <Yn3tssUR8w8mC1DJ@hyeyoo>
 <3f2f7c09-ddf3-6052-9860-8554a4ff2798@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2f7c09-ddf3-6052-9860-8554a4ff2798@intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 07:04:32AM -0700, Dave Hansen wrote:
> On 5/12/22 22:33, Hyeonggon Yoo wrote:
> > Thanks Mel, and IIUC nor does do_kern_addr_fault() in arch/x86/mm/fault.c
> > expect _PAGE_PROTNONE instead of _PAGE_GLOBAL. I want to make it clear
> > in the code that _PAGE_PROTNONE is only used for user mappings.
> > 
> > How does below look?
> > 
> > diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> > index 40497a9020c6..f8d02b91a90c 100644
> > --- a/arch/x86/include/asm/pgtable_types.h
> > +++ b/arch/x86/include/asm/pgtable_types.h
> > @@ -35,7 +35,10 @@
> >  #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
> >  
> >  /* If _PAGE_BIT_PRESENT is clear, we use these: */
> > -/* - if the user mapped it with PROT_NONE; pte_present gives true */
> > +/*
> > + * if the user mapped it with PROT_NONE; pte_present gives true
> > + * this is only used for user mappings (with _PAGE_BIT_USER)
> > + */
> >  #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
> >  
> >  #define _PAGE_PRESENT	(_AT(pteval_t, 1) << _PAGE_BIT_PRESENT)
> > @@ -115,7 +118,8 @@
> >  #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
> >  #endif
> >  
> > -#define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
> > +#define _PAGE_PROTNONE	((_AT(pteval_t, 1) << _PAGE_BIT_USER) | \
> > +			 (_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE))
> >  
> >  /*
> >   * Set of bits not changed in pte_modify.  The pte's
> 
> I don't like the idea of _PAGE_BIT_USER being so implicit.  It is
> something kernel users should know explicitly that they are messing with.
> 
> I was thinking of something more along the lines of taking the
> set_memory.c code and ensuring that it never sets (or even observes)
> _PAGE_BIT_GLOBAL on a _PAGE_USER mapping.  There was also a question of
> if set_memory.c is ever used on userspace mappings.  It would be good to
> validate whether it's possible in-tree today and if not, enforce that
> _PAGE_USER PTEs should never even be observed with set_memory.c.

Writing code I'm a bit confused:
commit d1440b23c922d8 ("x86/mm: Factor out pageattr
_PAGE_GLOBAL setting") says:

	"This unconditional setting of _PAGE_GLOBAL is a problem when we have
	PTI and non-PTI and we want some areas to have _PAGE_GLOBAL and some
	not." 

Is this this sentence not valid anymore in PTI,
and just unconditionally setting _PAGE_GLOBAL would be okay in kernel
side regardless of PTI?

I'm wondering it because previously I thought "Let's not clear
_PAGE_GLOBAL in set_memory.c for kernel mappings and make pmd/pte_present() not
confuse when _PAGE_USER is not set"

But you don't like it as it's a bit implicit.
Then I wonder - how do we know when to set _PAGE_GLOBAL again?

> The arch/x86/mm/dump_pagetables.c code is also a reasonable place to put
> assumptions about the page tables since it walks *everything* when asked.
