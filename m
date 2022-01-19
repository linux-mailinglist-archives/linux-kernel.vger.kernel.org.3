Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C58493EB5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356278AbiASRAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243637AbiASRAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:00:39 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9412C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:00:38 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c9so2743946plg.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+miCtcK/AqsybC9kGvXCIMuIzeqRj4OXN3BobeqDEUo=;
        b=K/2ZjAm2fs8HahIuAat0NhAX7Ei2c00JN0IdOuUX6t/dhtEaL0qFZGuJNqVgz3Wbq1
         DqNKYBCTQb/g1sx8TKs0O2wLWqp+uxKxq/LY8gJhZRW2vZOIh23E8TpTLtAYWgCE81OO
         6w1Q9ANCTvlLhhwW4UB7d8ewEeRBtPI6uFwqmeguWR/38nm4Swb+wjdjV3rPE7nVZve7
         ltctmU0Fgzo8VB8bVaFPhvgP/gDGpnN7NCJNXIROghFiQhG6LAhbE9fwanNHPgApnvBw
         00l8vG6tZoyKG3hqgsaP7YL2l+F01JoPtmNAICd9dlzogLjq9KlYSSC56iS0F7Qhzl6O
         WZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+miCtcK/AqsybC9kGvXCIMuIzeqRj4OXN3BobeqDEUo=;
        b=IBShc13t98OYCfw4vqhOVuF6VlvsdRdbKh6R5AVh3AGhcNxTQhw/zG2D8Fr3tP42f8
         rp2Oj5Q/mnIulsGnVyelID8xKOnJgPjQhNB5omY1fJeePNOsihtGHMkB03bHsyMqzi2W
         KRrynGvxgS/4545o5zHapm9hudvgX0G6BnlyC1xOZEMKx6hysqNUi0SwehHRuCnwb9TW
         XSvvxnND3yfwbHzSySE33FWG7vYvJgi83jhVLKCSXcjHiyFgED7ni/2tjOv5geqAB8Ad
         P4gajokMw6wVa8BGIEkmmz3I4yh/cM4uRpmdFAgYdkB0JECOfcj6KhaByUqekJ17MaDn
         qmxQ==
X-Gm-Message-State: AOAM533i7yDIKLHlYsNCBOFbtZbRwmIpmw4dzOdbVixltCECL7UhMhGO
        VBCksLiXrRtGg1m4KV8F/UE1bvk0V7jBOhOuvTQ0LInwx4M=
X-Google-Smtp-Source: ABdhPJzsPKAdJawi2o/caxCQqkDSAvrXLEzsPlx4tZTMVShOZR6MIF3N0SfPKEZEgr9U4XvOFhfTfZw7NnvadJkckF0=
X-Received: by 2002:a17:902:a5c6:b0:149:c926:7c31 with SMTP id
 t6-20020a170902a5c600b00149c9267c31mr34261842plq.141.1642611638142; Wed, 19
 Jan 2022 09:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20220118235244.540103-1-yury.norov@gmail.com> <YefzAQ5LXJk1ytfI@FVFF77S0Q05N>
In-Reply-To: <YefzAQ5LXJk1ytfI@FVFF77S0Q05N>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 19 Jan 2022 09:00:23 -0800
Message-ID: <CAAH8bW-CxxL7DkBdHeZ60ZyPKJ8EOY2rh+hCEiyeH7Kih42EQQ@mail.gmail.com>
Subject: Re: [PATCH] vmap(): don't allow invalid pages
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 3:17 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi,
>
> I replied ot the original RFC before spotting this; duplicating those comments
> here because I think they apply regardless of the mechanism used to work around
> this.
>
> On Tue, Jan 18, 2022 at 03:52:44PM -0800, Yury Norov wrote:
> > vmap() takes struct page *pages as one of arguments, and user may provide
> > an invalid pointer which would lead to DABT at address translation later.
> >
> > Currently, kernel checks the pages against NULL. In my case, however, the
> > address was not NULL, and was big enough so that the hardware generated
> > Address Size Abort on arm64.
>
> Can you give an example of when this might happen? It sounds like you're
> actually hitting this, so a backtrace would be nice.
>
> I'm a bit confused as to when why we'd try to vmap() pages that we
> didn't have a legitimate struct page for -- where did these addresses
> come from?
>
> It sounds like this is going wrong at a higher level, and we're passing
> entirely bogus struct page pointers around. This seems like the sort of
> thing DEBUG_VIRTUAL or similar should check when we initially generate
> the struct page pointer.

Hi Mark,

This is an out-of-tree code that does:

    vaddr1 = dma_alloc_coherent()
    page = virt_to_page() // Wrong here
    ...
    vaddr2 = vmap(page)
    memset(vaddr2) // Fault here

virt_to_page() returns a wrong pointer if vaddr1 is not a linear kernel address.
The problem is that vmap() populates pte with bad pfn successfully, and it's
much harder to debug at memory access time.

> > Interestingly, this abort happens even if copy_from_kernel_nofault() is
> > used, which is quite inconvenient for debugging purposes.
>
> I can go take a look at this, but TBH we never expect to take an address size
> fault to begin with, so this is arguably correct -- it's an internal
> consistency problem.
>
> > This patch adds a pfn_valid() check into vmap() path, so that invalid
> > mapping will not be created.
> >
> > RFC: https://lkml.org/lkml/2022/1/18/815
> > v1: use pfn_valid() instead of adding an arch-specific
> >     arch_vmap_page_valid(). Thanks to Matthew Wilcox for the hint.
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  mm/vmalloc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index d2a00ad4e1dd..a4134ee56b10 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -477,6 +477,8 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
> >                       return -EBUSY;
> >               if (WARN_ON(!page))
> >                       return -ENOMEM;
> > +             if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> > +                     return -EINVAL;
>
> My fear here is that for this to fire, we've already passed a bogus struct page
> pointer around the intermediate infrastructure, and any of that might try to
> use it in unsafe ways (in future even if we don't use it today).
>
> I think the fundamental issue here is that we generate a bogus struct page
> pointer at all, and knowing where that came from would help to fix that.

You're right. That's why WARN_ON() is used for the page == null in the code
above, I believe, - to let client code know that something goes wrong, and it's
not a regular ENOMEM situation.

Thanks,
Yury

> Thanks,
> Mark.
>
> >               set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
> >               (*nr)++;
> >       } while (pte++, addr += PAGE_SIZE, addr != end);
> > --
> > 2.30.2
> >
