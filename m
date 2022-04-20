Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A4B508E14
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380922AbiDTRMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbiDTRMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:12:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F909140E8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:09:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u15so4824448ejf.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AAgH39aqYNkZFEmodz4sdJEW8mfR6G5OOFNZA9oagFY=;
        b=Qakj4tsgGstygvOiA9O5uUiBRICg8fcpw/1UHUJrVZbFOhFCY0TdFI1pvox2kHpZgH
         JSzFyfkKv3KQLl1eyfhgd31h1VFGLKj9W2N5FNE4Kcj9UoxMgvXJLLBEqqVzwmdYbd9K
         AGPuZhTJW91gSkIGkaT46ezQqI3t2yyIfZUpbYiYay9oonrQOZgK7DTxYF1Ei0q0eyvt
         JHMswMR1rslz6HHA4TrJgDw2A5tzuAcJZt+1E2kCRnEIojalj0MUOYBF9ZlGDB3lvFnh
         FZrlwygxooC5bPWiA5moln7z2YrRO/koHDOPaG3aph3BreOUNXqGGpDm3CAjBhODORn0
         cxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AAgH39aqYNkZFEmodz4sdJEW8mfR6G5OOFNZA9oagFY=;
        b=FtCgjukV8LA9c3o1GyO3GsRLmOkXkbpUZ3gWzwFzEUzlelPCjrw9XbHo1W9nct5MTD
         90xWMGotZPI/W028ldRE14YDKJ1qXOcmSao5SCQhWimU8eG+DbJyPYaNT/n9BrREmdBM
         xwMuryXECZRr88FoLJE1cnTqtBbsc3Pyf7JgySlgN3elWNjWy0x5r0ufSh5Z90rhi7RO
         VKLbC8QsumdoKpqq36gTdQNe9sD1cQ7hRu5buNYmniyVfAmj4MZMHv0BXFHBN1AfgQrW
         r33y7i3c9EUvsRkwsF1dJHIamFOCWSbxBVqcbqn2xl4ofdNkSNNF5CX7xb0vRCs9BPGG
         0maQ==
X-Gm-Message-State: AOAM530qzvzRIyXcaPHaeB+Smk8opO201+Uc4HeTgeQ8kU/vYuQOT1B1
        KnxncpR/QLGow1TBH5Xp0tArBBFEvOjhtI8q7QeDQg==
X-Google-Smtp-Source: ABdhPJyY9jAsgVicM8NGt7TWLzng0j4SkCK0Eh+NgNRIs5YdqcuU/etlcZJHfeXkYbVjr1I5apItKjFwDo3ZegsFvbI=
X-Received: by 2002:a17:906:4cd8:b0:6db:372:c4ba with SMTP id
 q24-20020a1709064cd800b006db0372c4bamr18923831ejt.57.1650474566609; Wed, 20
 Apr 2022 10:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220418034444.520928-1-tongtiangen@huawei.com>
 <20220418034444.520928-4-tongtiangen@huawei.com> <073cb6a6-3dbc-75d4-dbfe-a5299a6b0510@arm.com>
 <CA+CK2bCPrQ=F0jNRxcVZ9f18Rm-kAATO3xFE79TZDoWQ99GC4Q@mail.gmail.com> <16a2620e-986a-6a8f-24eb-d0f7e9c91f24@arm.com>
In-Reply-To: <16a2620e-986a-6a8f-24eb-d0f7e9c91f24@arm.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Apr 2022 13:08:50 -0400
Message-ID: <CA+CK2bAmaweQoiBmo_igEzeKdsPmT-xzCtar36iNzaiFMEJB+w@mail.gmail.com>
Subject: Re: [PATCH -next v4 3/4] arm64: mm: add support for page table check
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Tong Tiangen <tongtiangen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 1:05 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 4/19/22 18:49, Pasha Tatashin wrote:
> > On Tue, Apr 19, 2022 at 6:22 AM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >>
> >> On 4/18/22 09:14, Tong Tiangen wrote:
> >>> +#ifdef CONFIG_PAGE_TABLE_CHECK
> >>> +static inline bool pte_user_accessible_page(pte_t pte)
> >>> +{
> >>> +     return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
> >>> +}
> >>> +
> >>> +static inline bool pmd_user_accessible_page(pmd_t pmd)
> >>> +{
> >>> +     return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> >>> +}
> >>> +
> >>> +static inline bool pud_user_accessible_page(pud_t pud)
> >>> +{
> >>> +     return pud_present(pud) && pud_user(pud);
> >>> +}
> >>> +#endif
> >> Wondering why check for these page table entry states when init_mm
> >> has already being excluded ? Should not user page tables be checked
> >> for in entirety for all updates ? what is the rationale for filtering
> >> out only pxx_user_access_page entries ?
> >
> > The point is to prevent false sharing and memory corruption issues.
> > The idea of PTC to be simple and relatively independent  from the MM
> > state machine that catches invalid page sharing. I.e. if an R/W anon
>
> Right, this mechanism here is truly interdependent validation, which is
> orthogonal to other MM states. Although I was curious, if mm_struct is
> not 'init_mm', what percentage of its total page table mapped entries
> will be user accessible ? These new helpers only filter out entries that
> could potentially create false sharing leading upto memory corruption ?

Yes, the intention is to filter out the false sharing scenarios.
Allows crashing the system prior to memory corruption or memory
leaking.

>
> I am wondering if there is any other way such filtering could have been
> applied without adding all these new page table helpers just for page
> table check purpose.
>
> > page is accessible by user land, that page can never be mapped into
> > another process (internally shared anons are treated as named
> > mappings).
>
> Right.
>
> >
> > Therefore, we try not to rely on MM states, and ensure that when a
> > page-table entry is accessible by user it meets the required
> > assumptions: no false sharing, etc.
>
> Right, filtering reduces the page table entries that needs interception
> during update (set/clear), but was just curious is there another way of
> doing it, without adding page table check specific helpers on platforms
> subscribing PAGE_TABLE_CHECK ?
>

It makes sense to limit the scope of PTC only to user accessible
pages, and not try to catch other bugs. This keeps it reasonably
small, and also lowers runtime overhead so it can be used in
production as well. IMO the extra helpers are not very intrusive, and
generic enough that in the future might be used elsewhere as well.


> >
> > For example, one bug that was caught with PTC was where a driver on an
> > unload would put memory on a freelist but memory is still mapped in
> > user page table.
>
> Should not page's refcount (that it is being used else where) prevented
> releases into free list ? But page table check here might just detect
> such scenarios even before page gets released.

Usually yes. However, there are a number of recent bugs related to
refcount [1][2][3]. This is why we need a stronger checker.

The particular bug, however, did not rely on refcount. The driver
allocated a kernel page for a ringbuffer, upon request shared it with
a userspace by mapping it into the user address space, and later when
the driver was unloaded, it never removed the mapping from the user
address space. Thus, even though the page was freed when the driver
was unloaded, the mapping stayed in the user page table.

[1] https://lore.kernel.org/all/xr9335nxwc5y.fsf@gthelen2.svl.corp.google.com
[2] https://lore.kernel.org/all/1582661774-30925-2-git-send-email-akaher@vmware.com
[3] https://lore.kernel.org/all/20210622021423.154662-3-mike.kravetz@oracle.com
