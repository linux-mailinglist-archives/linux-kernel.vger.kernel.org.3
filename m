Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792B5534D59
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245189AbiEZKdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiEZKdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:33:20 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A5437BFE
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:33:19 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j6so768817ilk.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zYDUOysOW0ZxZ/pfsRLXQW4yQ39IQOnULx1VRIJZPdo=;
        b=N/LR5YCzy58uRufBXx/aWg92n8BI0j3y/JIzrEoBhILNdzpUD9053jJbc8NN2RTWRB
         thf5zhN1x+LAma3cpGgYEWJDRmIRKr5nyY46GOYzGSVPwfjF9rS15r7X3bRcD8FSCwqN
         Hixf56AC0Z+2eH5X1WHJOb4RLh3YbWLVgBhlFzWdTxQ8AQBErDMXVdV1hKt6RLInw6vI
         2RDVulbD6+1XN6XrmMH2iaxTpfOYKPhElIxCQXyRoGaUadXnOlYTgMIsK40zSfWN0RW5
         eLWotul+rQdnKiBug/ahqkNqR6nFk4/B12gKxf+8Jr7GcRvidPVFMcMM47q6GPmzYsWL
         jrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zYDUOysOW0ZxZ/pfsRLXQW4yQ39IQOnULx1VRIJZPdo=;
        b=yQ+CohRip6UmI5UxOag6a5JHPKigCkNEunBSEpKerV2R94gKn4rJ4K/pVTKOLsknIz
         /ou3P+VzchHbWvzoLUfZ83MNMnEKfN8qph+PAlhBnXTbVHdLL5PN0UHJzhoX++/Jho+U
         jMEcJD+q7ct1dkxToPACcyNoIgPAVVvr1o6oBP/m8xdm6XVqa6/NeUA2eTgWGX/NixLP
         z/CApmXKhqgZTdT/+hgMCr/10oj1l1dncqyoNtaCsh0QCNBS2Yij0UeJB/TkD5/63NZz
         OYvQnSTAmiGp38oYoe6rQTsLdt07knmn6jJ31kr4pc8UJKVRii2KV6MYUIf3GTYJnRKt
         GZrg==
X-Gm-Message-State: AOAM530jfwz0K3lypZ0Ofst7RgsA54T7RRSvNbUG0KCWyMIJFXuNAlxY
        KgBTcXmAPvJaF1aDoGjlswQ=
X-Google-Smtp-Source: ABdhPJyEZz9amONlSBqu7a0QpuCWeDi3nHYdBY6SEYI6rg5t45axwsy2+zvSNI79Jc+2MuaNAmiRuw==
X-Received: by 2002:a92:ca08:0:b0:2d1:c1ee:cde5 with SMTP id j8-20020a92ca08000000b002d1c1eecde5mr7368508ils.148.1653561198611;
        Thu, 26 May 2022 03:33:18 -0700 (PDT)
Received: from n2.us-central1-a.c.spheric-algebra-350919.internal (151.16.70.34.bc.googleusercontent.com. [34.70.16.151])
        by smtp.gmail.com with ESMTPSA id f13-20020a056638112d00b0032b5e4281d3sm314818jar.62.2022.05.26.03.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:33:17 -0700 (PDT)
Date:   Thu, 26 May 2022 10:33:16 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Sean Christopherson <seanjc@google.com>
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
Message-ID: <Yo9XbP87WwxjYUir@n2.us-central1-a.c.spheric-algebra-350919.internal>
References: <56f89895-601e-44c9-bda4-5fae6782e27e@amd.com>
 <YnpTHMvOO/pLJQ+l@hyeyoo>
 <5fe161cb-6c55-6c4d-c208-16c77e115d3f@amd.com>
 <8c2735ac-0335-6e2a-8341-8266d5d13c30@intel.com>
 <YntHrTX12TGp35aF@hyeyoo>
 <20220512103748.GH3441@techsingularity.net>
 <Yn3tssUR8w8mC1DJ@hyeyoo>
 <3f2f7c09-ddf3-6052-9860-8554a4ff2798@intel.com>
 <Yom0hiDXuCuY4OUP@n2.us-central1-a.c.spheric-algebra-350919.internal>
 <Yo0+huWaiIDmac7Z@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo0+huWaiIDmac7Z@google.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 08:22:30PM +0000, Sean Christopherson wrote:
> On Sun, May 22, 2022, Hyeonggon Yoo wrote:
> > On Mon, May 16, 2022 at 07:04:32AM -0700, Dave Hansen wrote:
> > > I was thinking of something more along the lines of taking the
> > > set_memory.c code and ensuring that it never sets (or even observes)
> > > _PAGE_BIT_GLOBAL on a _PAGE_USER mapping.
> > 
> > Yeah that would be a bit more explicit solution.
> > 
> > > There was also a question of
> > > if set_memory.c is ever used on userspace mappings.  It would be good to
> > > validate whether it's possible in-tree today and if not, enforce that
> > > _PAGE_USER PTEs should never even be observed with set_memory.c.
> > 
> > Simply adding dump_stack() tells me my kernel on my machine does not use
> > set_memory.c for userspace mappings but Hmm I'll take a look.
> 
> vc_slow_virt_to_phys() uses lookup_address_in_pgd() with user mappings, but that
> code is all but guaranteed to be buggy, e.g. doesn't guard against concurrent
> modifications to user mappings.
> 
> show_fault_oops() can also call into lookup_address_in_pgd() with a user mapping,
> though at that point the kernel has bigger problems since it's executing from user
> memory.
> 
> And up until commits 44187235cbcc ("KVM: x86/mmu: fix potential races when walking
> host page table") and 643d95aac59a ("Revert "x86/mm: Introduce lookup_address_in_mm()""),
> KVM had a similar bug.

Thanks for your helpful insight.

I was curious if set_memory*() helpers are used for user mappings.
with some quick look ptrace() and uprobes (where updating application's text is needed)
use kmap + memcpy or replace_page() instead of set_memory*() API.

_lookup_address_cpa() uses init_mm.pgd when cpa.pgd is not specified
and the only place that passes pgd is efi subsystem (efi_mm.pgd), which is not a
userspace.

So it is *obvious* that set_memory*() functions should not be used
for user mappings. because that will only result in updating only init_mm's
page table.

Therefore answering to the first question ('do we really need to unset _PAGE_GLOBAL when we're
clearing _PAGE_PRESENT in set_memory.c to avoid confusing it as
_PAGE_PROTNONE?'):

	we don't need to consider PROT_NONE semantics in set_memory.c
	because we don't (shouldn't) change user mappings in it and _PAGE_PROTNONE is not used
	for kernel mappings.

> Generally speaking, set_memory.c is not equipped to play nice with user mappings.
> It mostly "works", but there are races galore.  IMO, hardening set_memory.c to scream
> if it's handed a user address or encounters _PAGE_USER PTEs would be a very good thing.

I agree that would be a good thing too.

Thanks,
Hyeonggon
