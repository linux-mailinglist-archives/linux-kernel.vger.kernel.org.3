Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE053325F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241059AbiEXUWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbiEXUWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:22:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA5F54BC3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:22:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id z25so4706978pfr.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YUnVxa5pnWd8D3oQLkMmXCsz6an77MCtCR1yPtv/LsQ=;
        b=VSYu/WzfHyNKrcVPPaxgRUerwl88cq5BG0EKH4DrtupwYUlU8DEcGjsDzAizLKW2Qt
         Le6afW2RDgD/ZQ2H87iYUqm7AjSq0acsYfxJ3NwWSWp5/B8TkjNrubmA6StzF2yl2c30
         gLeLi4cktX2vCJGBi3ZXJC8vVhiakpEeT3Q0O4dX1EsczAPYVxcMz0JZANKldm284Ndj
         wi8HRuAzvK0C3BqyFhMdsXlblK9pb/TzDvFopEHEWz50TrWSIq2o06x5lB3fbgPHArgI
         8rmfpApZ1rz+nMfUBzLSUXlTf4HLS7SHuw+b191b/2mmWeMJSHpPUMjVAoT0u44Rb29M
         cO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YUnVxa5pnWd8D3oQLkMmXCsz6an77MCtCR1yPtv/LsQ=;
        b=LLcar6m1a1INbcUrqngNhGXFc6pdhpXjWhhOnN9fiams4nlas/ZbJCI6x8b9XbDmNj
         mr1ifloTKZPSJRXoG4kaD3PpW/lPw7rk5zZA2Tn3CNQpguzLAS0FWKYa6AJ4r8Khdsd8
         i2G0c3nZlG3uEmld+pGG/kxnvCvq6aBhDpLvlS4ZDOxwkyZfdrcmbILRPMknbJCzUISs
         51NVs9W1J1WyKdLw46ydTdgICB8d0PVaUs4jMr1zPsXBEOFj+CLuv7YQgJ4mScGCH9KP
         0GgfkPO+UTYdhwfXb8tGSBCpo59lL5oI1mRqsMoCRoFLMNthLGQ1/wGnv+TBuh2Xq3h5
         uceQ==
X-Gm-Message-State: AOAM532ParoDpGibBcmvU1SEPVihFHAuyhh6Mt3qLvFJPbeLSTOGfuRY
        DsBeC3ZO880fYxcb+wOT/N4pbQ==
X-Google-Smtp-Source: ABdhPJzEzSBOJ49SjfPAIvrDv96S6UMkcFYGOSpHrtGFcUUoN1+ex5IU8zKRocw1wS2WuYmbveO09g==
X-Received: by 2002:a63:4387:0:b0:3c6:9490:4e4b with SMTP id q129-20020a634387000000b003c694904e4bmr25290534pga.438.1653423754123;
        Tue, 24 May 2022 13:22:34 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h186-20020a62dec3000000b0050dc7628191sm9847289pfg.107.2022.05.24.13.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 13:22:33 -0700 (PDT)
Date:   Tue, 24 May 2022 20:22:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
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
Message-ID: <Yo0+huWaiIDmac7Z@google.com>
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
 <56f89895-601e-44c9-bda4-5fae6782e27e@amd.com>
 <YnpTHMvOO/pLJQ+l@hyeyoo>
 <5fe161cb-6c55-6c4d-c208-16c77e115d3f@amd.com>
 <8c2735ac-0335-6e2a-8341-8266d5d13c30@intel.com>
 <YntHrTX12TGp35aF@hyeyoo>
 <20220512103748.GH3441@techsingularity.net>
 <Yn3tssUR8w8mC1DJ@hyeyoo>
 <3f2f7c09-ddf3-6052-9860-8554a4ff2798@intel.com>
 <Yom0hiDXuCuY4OUP@n2.us-central1-a.c.spheric-algebra-350919.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yom0hiDXuCuY4OUP@n2.us-central1-a.c.spheric-algebra-350919.internal>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022, Hyeonggon Yoo wrote:
> On Mon, May 16, 2022 at 07:04:32AM -0700, Dave Hansen wrote:
> > I was thinking of something more along the lines of taking the
> > set_memory.c code and ensuring that it never sets (or even observes)
> > _PAGE_BIT_GLOBAL on a _PAGE_USER mapping.
> 
> Yeah that would be a bit more explicit solution.
> 
> > There was also a question of
> > if set_memory.c is ever used on userspace mappings.  It would be good to
> > validate whether it's possible in-tree today and if not, enforce that
> > _PAGE_USER PTEs should never even be observed with set_memory.c.
> 
> Simply adding dump_stack() tells me my kernel on my machine does not use
> set_memory.c for userspace mappings but Hmm I'll take a look.

vc_slow_virt_to_phys() uses lookup_address_in_pgd() with user mappings, but that
code is all but guaranteed to be buggy, e.g. doesn't guard against concurrent
modifications to user mappings.

show_fault_oops() can also call into lookup_address_in_pgd() with a user mapping,
though at that point the kernel has bigger problems since it's executing from user
memory.

And up until commits 44187235cbcc ("KVM: x86/mmu: fix potential races when walking
host page table") and 643d95aac59a ("Revert "x86/mm: Introduce lookup_address_in_mm()""),
KVM had a similar bug.

Generally speaking, set_memory.c is not equipped to play nice with user mappings.
It mostly "works", but there are races galore.  IMO, hardening set_memory.c to scream
if it's handed a user address or encounters _PAGE_USER PTEs would be a very good thing.
