Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF804AB010
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 15:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243232AbiBFOxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 09:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiBFOxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 09:53:00 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546C6C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 06:52:59 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id r8so19133410uaj.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 06:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FqBgKkEp48YXOFOA5wzxrOSHuuh4qZgyEe5RGqRigo=;
        b=pp7TcDiuO8DE7JxuY9v1mSiV1R7xPDiAjN3tfkfzMturFK7xzBQNPzTZ9RwvbrBl3J
         nbPOWJ5K34vDFBLoN8aDfRzcejDXVIENcjVL/n5FRMUxE6BgLujzvoR69Nk7iKa6cYJ0
         HYYv8OTLXWKq7WTj7RhN0WrUAhuTGJUob4tlwWEBKFhSFNRFHEynoQl8XcOqd66Toh3Q
         uvR14nze/A8b6Zpaa2ZWrHGbTjX4GcRxzAALZQLqVMBpOXTx1Atn1Tz1sB/Ybvab25Pi
         X1fZH1tXfpvkX85I4MkMHjbjcpN/PNw3eI+Rb3ZmiJ4/neLm7zXDjJMbsUOwJJB2njz1
         8waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FqBgKkEp48YXOFOA5wzxrOSHuuh4qZgyEe5RGqRigo=;
        b=XmJTe+v+RIaNqwdu+qdeAXNmvoBhp87q7dSV2UXMWVtv2ygD4QDNgENSdKwk+2piGq
         MDGl7VwwFd55DeOokA9sODK7SAKm8D0vqZswj/slIpz1mOOPNIRTGTNKpwbRgHXF9age
         7WziNEHVwx7xG4uKq7LLtDvYvYg+wBPlgwEl2am6QXy516dnnRXDydyGe3sPLVZgZbHk
         lv5y9+hzPHqTvGvjooPfk/grYLsDoz9yAt9MoIrY3tgVexb2Mmq2qfB2EBpUDGd5NXIn
         BRZx9FXVZWg0g6qiSOoMxjCMRnmGDSbLlvDZFYL+JoF4lzlfn7IDVE+PsuoIEGIBhbMQ
         J1Jg==
X-Gm-Message-State: AOAM532tOg0cHjQe2D3LDwJbi8hDHTMEqXh13FoZAm0W6ui8fxWcH5Y9
        qRi0sLbZcpwSj2mHe8ghSCkVX5izQj983XJB7o0=
X-Google-Smtp-Source: ABdhPJyZ5aSDW0doLYdRW0LQjO+3o9/9x2Sp/CTv8IDgyPMyomuCKsQpOiyuc4MUjtf0nI+7iR67MSRnKlu+ov+u9vs=
X-Received: by 2002:a67:e158:: with SMTP id o24mr3257698vsl.17.1644159178430;
 Sun, 06 Feb 2022 06:52:58 -0800 (PST)
MIME-Version: 1.0
References: <20220204195852.1751729-1-willy@infradead.org> <20220204195852.1751729-21-willy@infradead.org>
In-Reply-To: <20220204195852.1751729-21-willy@infradead.org>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Sun, 6 Feb 2022 14:52:46 +0000
Message-ID: <CANe_+Ugjtu2zw8i3CyCU3mu71L7Gh_etuj_5t64Bx7y7+fj2jA@mail.gmail.com>
Subject: Re: [PATCH 20/75] mm/gup: Convert gup_pte_range() to use a folio
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2022 at 20:21, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> We still call try_grab_folio() once per PTE; a future patch could
> optimise to just adjust the reference count for each page within
> the folio.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  mm/gup.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 00227b2cb1cf..44281350db1a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2252,7 +2252,8 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>         ptem = ptep = pte_offset_map(&pmd, addr);
>         do {
>                 pte_t pte = ptep_get_lockless(ptep);
> -               struct page *head, *page;
> +               struct page *page;
> +               struct folio *folio;
>
>                 /*
>                  * Similar to the PMD case below, NUMA hinting must take slow
> @@ -2279,22 +2280,20 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>                 VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>                 page = pte_page(pte);
>
> -               head = try_grab_compound_head(page, 1, flags);
> -               if (!head)
> +               folio = try_grab_folio(page, 1, flags);
> +               if (!folio)
>                         goto pte_unmap;
>
>                 if (unlikely(page_is_secretmem(page))) {
> -                       put_compound_head(head, 1, flags);
> +                       gup_put_folio(folio, 1, flags);
>                         goto pte_unmap;
>                 }
>
>                 if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> -                       put_compound_head(head, 1, flags);
> +                       gup_put_folio(folio, 1, flags);
>                         goto pte_unmap;
>                 }
>
> -               VM_BUG_ON_PAGE(compound_head(page) != head, page);
> -
>                 /*
>                  * We need to make the page accessible if and only if we are
>                  * going to access its content (the FOLL_PIN case).  Please
> @@ -2308,10 +2307,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>                                 goto pte_unmap;
>                         }

V. Minor/nit: Above the "goto pte_unmap;" is the code block;
           if (flags & FOLL_PIN) {
                        ret = arch_make_page_accessible(page);
                        if (ret) {
                                unpin_user_page(page);
                                goto pte_unmap;
                        }
                }
Other conditions which goto pte_unmap, after successful
try_grab_folio(), call gup_put_folio() (rather than
unpin_user_page()).
No change in functionality, but suggest calling gup_put_folio() here
too for consistency.

Cheers,
Mark
