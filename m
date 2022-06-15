Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C080854D0CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357287AbiFOSSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243664AbiFOSSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:18:48 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228054EF40
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:18:48 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i15so11112774plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJXdLmcQUyrb4VKNR1Dojq9lVpq1SvOPdHlcqg6WF3s=;
        b=DuaOiTeN5VpIwVKopMWgQ+RG1ALSGpah21F52G7gtoz7YAIQMdyC5z3gPT+/a7n73B
         5OYry0sjeIEa39VjtdjfY2UAouGqK+B9/PpSodnJ8kuId6t3feBc6yDVXDrZsQayJ3iW
         pXjsZW6adkWX/mxICwRjX/NkD/R3mf7SCJmKJ7hWP3+5BzaCkzPqXeyQl9zJPDjWL55L
         aclzC6udevrjJsjfSLm3QeavXQr3xaxFcts5rxPxJKbjyLqhmtEqNb42jUMTP2qyB/vc
         NJhYd7urPQ/nP/b8MewpNtLzeuB3cqwXu5XIll351C7LKGXLxPNti8EfUUTf0maD1FdM
         rGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJXdLmcQUyrb4VKNR1Dojq9lVpq1SvOPdHlcqg6WF3s=;
        b=2k043YrLjTmkiprTYVdVGWxXiu5bZ8mf4u7V1KXDzrHjnSNYIpQOSMSjsZgLRMyCd8
         RHlRm7HJsbfj9TZz6d/nS4cvBfez9b+KRTp30lgnsZ8V1mGiv6Me7VQUKBhGVtV9bBqP
         oyurzlBjUJ7QFv5QtdBZ0wobKMUPPq1UVAulbPf1DsjeWFZiLPluObI2Z1mC+f8wxmA6
         HdnJAhrI+IKujSAz8WMXmglALbX0dOy5iVdNi+OVW4wJzcRhpPrxkHZ60hyAL//OvGMA
         dVKFCJ2RRJVE4DXEWjjrt6wKG4Rrqde8tFqXWUJTYB+mcBnoWi4RjTi82auqYBRORedN
         JIUw==
X-Gm-Message-State: AJIora9Wag3siZaONT8LiRLnMuw0PjWEMmT2TAsX21TTwktSaoOA4CbH
        NKdvSaQAbPEfD9XahQiCboNhO6dIS8E6kmW+3QQ=
X-Google-Smtp-Source: AGRyM1v5ye0uTYtqCuLoFNVZPFwTYyyNDqLVKrIuaEj0efPlh+dQdAbu4BJK0lTk0wdZiHUK+yEGvVn91sga2c0Tpss=
X-Received: by 2002:a17:90a:ce84:b0:1e4:d803:fad with SMTP id
 g4-20020a17090ace8400b001e4d8030fadmr11878546pju.99.1655317127677; Wed, 15
 Jun 2022 11:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220611084731.55155-1-linmiaohe@huawei.com> <20220611084731.55155-5-linmiaohe@huawei.com>
 <YqoAydWk/IcMp5d2@google.com>
In-Reply-To: <YqoAydWk/IcMp5d2@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Jun 2022 11:18:35 -0700
Message-ID: <CAHbLzkr6AFy_b2SzG0DoLQZt8JAckEhLR_v7SkC=O-4LecaYFQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] mm/khugepaged: minor cleanup for collapse_file
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 8:55 AM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On 11 Jun 16:47, Miaohe Lin wrote:
> > nr_none is always 0 for non-shmem case because the page can be read from
> > the backend store. So when nr_none ! = 0, it must be in is_shmem case.
> > Also only adjust the nrpages and uncharge shmem when nr_none != 0 to save
> > cpu cycles.
> >
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > ---
> >  mm/khugepaged.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 1b5dd3820eac..8e6fad7c7bd9 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1885,8 +1885,7 @@ static void collapse_file(struct mm_struct *mm,
> >
> >       if (nr_none) {
> >               __mod_lruvec_page_state(new_page, NR_FILE_PAGES, nr_none);
> > -             if (is_shmem)
> > -                     __mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
> > +             __mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
> >       }
>
>
> Might be worth a small comment here - even though folks can see in above code
> that this is only incremented in shmem path, might be nice to say why it's
> always 0 for non-shmem (or conversely, why it's only possible to be non 0 on
> shmem).

Agreed, better to have some comments in the code.

>
> >
> >       /* Join all the small entries into a single multi-index entry */
> > @@ -1950,10 +1949,10 @@ static void collapse_file(struct mm_struct *mm,
> >
> >               /* Something went wrong: roll back page cache changes */
> >               xas_lock_irq(&xas);
> > -             mapping->nrpages -= nr_none;
> > -
> > -             if (is_shmem)
> > +             if (nr_none) {
> > +                     mapping->nrpages -= nr_none;
> >                       shmem_uncharge(mapping->host, nr_none);
> > +             }
> >
> >               xas_set(&xas, start);
> >               xas_for_each(&xas, page, end - 1) {
> > --
> > 2.23.0
> >
> >
>
> Otherwise,
>
> Reviewed-by: Zach O'Keefe <zokeefe@google.com>
>
