Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBD153006D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 05:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiEVD5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 23:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiEVD5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 23:57:00 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EEF3466F
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 20:56:57 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i5so7879584ilv.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 20:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WD+OIKZpSTJyD5Vd4IIbMe/iBHfwL25mMqv6khTOaQc=;
        b=pfN4pPEeY9LYegHJheV6brjF5IhI9WGaVam03hHJvQ45QTGNF+vrM2IC9RhsClS8oP
         ixAPLv0NJgoRuoPloqF+4j55f1fEuVVWQv46D8DXTahs0bftZvpWZOcK3d7yQXpT5kC0
         rtDRcDPi7xUQH3EtXLkKYnOHKilzRci6W66tPcPffgtxHt8OX+HN5Q0r6sTeff0bqHLQ
         TfXca2REfKX9shwxKV5KIRbBb8k/hKBjF54qBxwdfS7cxmqUGVHvL5/yg5GZ2crvVNoD
         oVYrRiqiAd4lEptLPKaHNa9rg4M+4LsLKIIuGlj724HV2fOUd8iUhPtNnAj3Jju8QHrK
         RYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WD+OIKZpSTJyD5Vd4IIbMe/iBHfwL25mMqv6khTOaQc=;
        b=mChbYxIZ2qNV3zQdimjnVCfYpBXEGsMK/Tzw4v4rRact1sbN44rjH20evZgWeZQVDe
         5swhoAWJdoSnc7KQ3Mi45nktbrygP7NINOVYRzWAcnEbyqJKHKZ0+FZJqKdJnQEA36DC
         1wO1OsIdM78ZBoxYf2ZdkY7EA8qqrQ+Vg5Cj71vZLXam/WUs/l4I+oFWuyXfAOAad9WY
         SkAcPxDr+KugdnLveKVs7Jwaq5IxRPMJ9g3AaXoixzKbriz85QE3QnnVFaSR3hKSXzC5
         SDPCnOK2nJznvV6VdG8HJDpEtB8brOqpyJ3zz+BsY2iBjyFvFf6JLnCCbe/N7oQ+UjZ7
         VyVA==
X-Gm-Message-State: AOAM5335t6OtUnBVCWOBlMb79/oAh9grMdhvqaxanX5DmecEaoOOEW86
        InlgtQE1+ik6oUpDJaNaLGo=
X-Google-Smtp-Source: ABdhPJyRBpAs9QXdK3UcexEhJHfxO8KKO3LQ830mo1fzt+XW+RBn5su2d0kvUMJS6s/h202Aygl5Dg==
X-Received: by 2002:a05:6e02:1c87:b0:2cf:2d3d:dd89 with SMTP id w7-20020a056e021c8700b002cf2d3ddd89mr9182543ill.36.1653191816560;
        Sat, 21 May 2022 20:56:56 -0700 (PDT)
Received: from n2.us-central1-a.c.spheric-algebra-350919.internal (151.16.70.34.bc.googleusercontent.com. [34.70.16.151])
        by smtp.gmail.com with ESMTPSA id b101-20020a0295ee000000b0032e13e37940sm1806124jai.140.2022.05.21.20.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 20:56:55 -0700 (PDT)
Date:   Sun, 22 May 2022 03:56:54 +0000
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
Message-ID: <Yom0hiDXuCuY4OUP@n2.us-central1-a.c.spheric-algebra-350919.internal>
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

Sounds reasonable. Better explicit than implicit.

> I was thinking of something more along the lines of taking the
> set_memory.c code and ensuring that it never sets (or even observes)
> _PAGE_BIT_GLOBAL on a _PAGE_USER mapping.

Yeah that would be a bit more explicit solution.

> There was also a question of
> if set_memory.c is ever used on userspace mappings.  It would be good to
> validate whether it's possible in-tree today and if not, enforce that
> _PAGE_USER PTEs should never even be observed with set_memory.c.

Simply adding dump_stack() tells me my kernel on my machine does not use
set_memory.c for userspace mappings but Hmm I'll take a look.

> The arch/x86/mm/dump_pagetables.c code is also a reasonable place to put
> assumptions about the page tables since it walks *everything* when asked.

Thanks for that information!

Thanks,
Hyeonggon
