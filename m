Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D714AF5AD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiBIPpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiBIPpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:45:18 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAF6C0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:45:20 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id t1so2082093qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 07:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=3shrmB0H/pTmuf5G/5yvegYTbR9AsKh3PxNaIWIn02w=;
        b=EHKiLFCoaGny39YZO5//42CchKuutldtOI0Aa5XAsYwIjfkgAHdpW6t9yqA5RxStk6
         CLg+cwRvAXGb3kwQXp9D5ASK0ef5xOysJxqdtxRZjS8ye11zRD7oh6iu8xHe7rIpLn8P
         YqPsmwxbOajeIzqLUh9yvnMjxrCLwy7x099u1f1jrkluuxXZcNnHK2352KQxlAXW6hsl
         9oh6dKFc4iz1F/+wzT91rbZ3GZB7+irg+P47EaMGZCGWsKU1SwamvAQLx5Ep6JOinRvd
         xe7YozFGz7c/y0ZD/SUGI7nHZchjIps307xqW/ptQYdeXf26nRVQDGviQvpFMx2ArjLs
         EECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=3shrmB0H/pTmuf5G/5yvegYTbR9AsKh3PxNaIWIn02w=;
        b=C4keTi4S2ahGUfMZ1Q1/G21R1AHSr8m6wz4gao+0EpDg+Bug8GGaEZtQNIncC0kUaW
         juSIYTq3Jy35hqZBMM+w7FaMCsjSRp6rUiORVE/kvXRNMdr9bAz1GuSQ1Lp2LFuAgA6N
         e+b4DVqtYEvordfsMGRnCQRTTVHFl7eGIG1tH63v28LQZdQC6bjCjOHU+wcc1qweneDL
         C+V15kGQX25MqWhjVWCa7YIblB3fo4GMHeAsQDufvjxo6mOwhFYxauJV8GQVYJV352N0
         BPlCW9c4cSHr73s8btkCqDlKiQXYKmnQd9MSJFNZtjbkzZ2LFZG8V8VvXpsJ72y4QEm7
         ixNQ==
X-Gm-Message-State: AOAM532l84aJC8bG4pGEQ9q4HvzhlkI9VhdCBbSyxLlfm6ryNPT6jQpp
        ZVyrMlhz1rcpab7+H3jCJd6TyA==
X-Google-Smtp-Source: ABdhPJx6JfoHHNsav36cW9YJ1pnn6SfZ0KNlilDme2t/kXl3V92r+dLYqvXtT5zUA/I1UT6bWFVvnw==
X-Received: by 2002:a05:622a:34f:: with SMTP id r15mr1733163qtw.614.1644421519793;
        Wed, 09 Feb 2022 07:45:19 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bl1sm8465658qkb.16.2022.02.09.07.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:45:17 -0800 (PST)
Date:   Wed, 9 Feb 2022 07:45:14 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        SeongJae Park <sj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 10/13] mm/munlock: mlock_page() munlock_page() batch by
 pagevec
In-Reply-To: <CAMuHMdVxrYioQX1H8CPpYcSADN=22Se-pW14fPu9R0G+6iDtYw@mail.gmail.com>
Message-ID: <d6a391-212f-af1-d762-6231ed904135@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com> <eadba522-cfe1-b0d6-56fc-7bc9f649b89d@google.com> <CAMuHMdVxrYioQX1H8CPpYcSADN=22Se-pW14fPu9R0G+6iDtYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1892591577-1644421517=:6994"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1892591577-1644421517=:6994
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 9 Feb 2022, Geert Uytterhoeven wrote:
>=20
> Thanks for your patch, which is now commit cbaf47432c909044
> ("mm/munlock: mlock_page() munlock_page() batch by pagevec") in
> next-20220209.
>=20
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -402,7 +402,8 @@ extern int mlock_future_check(struct mm_struct *mm,=
 unsigned long flags,
> >   *
> >   * mlock is usually called at the end of page_add_*_rmap(),
> >   * munlock at the end of page_remove_rmap(); but new anon
> > - * pages are managed in lru_cache_add_inactive_or_unevictable().
> > + * pages are managed by lru_cache_add_inactive_or_unevictable()
> > + * calling mlock_new_page().
> >   *
> >   * @compound is used to include pmd mappings of THPs, but filter out
> >   * pte mappings of THPs, which cannot be consistently counted: a pte
> > @@ -425,6 +426,9 @@ static inline void munlock_vma_page(struct page *pa=
ge,
> >             (compound || !PageTransCompound(page)))
> >                 munlock_page(page);
> >  }
> > +void mlock_new_page(struct page *page);
> > +bool need_mlock_page_drain(int cpu);
> > +void mlock_page_drain(int cpu);
>=20
> This is inside an #ifdef CONFIG_MMU section.
>=20
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
>=20
> > @@ -640,6 +634,7 @@ void lru_add_drain_cpu(int cpu)
> >                 pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
> >
> >         activate_page_drain(cpu);
> > +       mlock_page_drain(cpu);
>=20
> noreply@ellerman.id.au reported for m5272c3_defconfig:
>=20
>     mm/swap.c:637:2: error: implicit declaration of function
> =E2=80=98mlock_page_drain=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]
>=20
> http://kisskb.ellerman.id.au/kisskb/buildresult/14694567/

Hi Geert, thanks for your report: SeongJae has posted a fix

https://lore.kernel.org/lkml/20220209094158.21941-2-sj@kernel.org/

but there I'm wondering if it's complete: I'll settle it later today.

Hugh
--0-1892591577-1644421517=:6994--
