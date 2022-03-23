Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55654E4D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiCWHtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiCWHtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:49:17 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0CD71A10;
        Wed, 23 Mar 2022 00:47:48 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id g24so1134161ybj.13;
        Wed, 23 Mar 2022 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CiJKf/EYQG5fX+Pnp/ZQI4kaWo1C4FwFCh1EuwirRA=;
        b=fMmkaJuLc2J8fqqvHTYcFJRreNehN1l1KirWAi6/cnOMCm/mSnNE53vriY6YHcE1dP
         WCaZLouVpypjXrS/m0zuTEgo9WbLkIX/NgMG1ENiuQMbRODaSunvsElZy6rCb/iNP53G
         wa9zrdLnSi7Y2wmTBrD21EbtwWi8xbtNEREdhpfznziHFQA99ArQYbNB7/YBK5ihjl+l
         NnzTivL14FbtiOHkJkcyMNAqr9/XAGqv8csXuBb5ue7X2KOgDUk7CnUP+sz6qdNseDZp
         EkPHFVkMgJGb40ZKftLCNrs0J1QuwRiwgHUlYVPUyeFzwqpXI/DqRCzIauqwBuwsWzts
         IUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CiJKf/EYQG5fX+Pnp/ZQI4kaWo1C4FwFCh1EuwirRA=;
        b=ApCWs5q2JEC6qwrI8FHgq8LG/3sEDw1FjiNPNC0Y3WQOIRRLdMzAAQ4LEupVVGFmsC
         G08GreaPYGVZr/H7xzACxp6s0UF1wiSgQiycK/Q1pmp2mhJcMFB5V1oUFa/RLctrZ0Y4
         2OFPfORW5xbq6Ru9lzbwiN+F2E5sMcwrmGP8lgeQ6KF46x4cmUWb+HS1Eki67+3CBhYA
         inlqFJmT/OK47H3pgGWZ3O7CuipMbgTkNYCnUl/gJP89nzoWP8RPE8fAJexe3Amfvck3
         LmZ0WijtR4xPBPiFKYS5IzGWdJYcwU6J3+Wgp4Zk1BTWyd/h1DwyIwX6ADTNrDPLcZ8+
         NFsg==
X-Gm-Message-State: AOAM531pqzPnojvs9vFM6GXaL6KJloAebH0FhsyML9GdgME1cqn838Wv
        dkGSqnWlG196caw4t9Mx5C/xHxlVbne9n9U67kbmTTjR7VA=
X-Google-Smtp-Source: ABdhPJyVqsy6Cgoh35MKk9aOoweAoIWCPAQuEmZzQBtjrR3088BsOYGf6g4cy4dcdGn1fBHBtlbcR9+dfJ/7odVNQm8=
X-Received: by 2002:a25:4003:0:b0:633:8ab5:b93e with SMTP id
 n3-20020a254003000000b006338ab5b93emr31832861yba.387.1648021667665; Wed, 23
 Mar 2022 00:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-7-yuzhao@google.com>
 <CAGsJ_4xfL7h6M92WGusxbTxQzHOJDj4X4AuC=0HgrEyAYJaJFg@mail.gmail.com> <CAOUHufbiSShp=khZFL6BmJKNNkG-LBrsPoLwYxewcgtZhi5tFg@mail.gmail.com>
In-Reply-To: <CAOUHufbiSShp=khZFL6BmJKNNkG-LBrsPoLwYxewcgtZhi5tFg@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 23 Mar 2022 20:47:36 +1300
Message-ID: <CAGsJ_4zeNtAsq7E9SKVwuKaXnKj80BP2NPHdjtd1i=098M6eDw@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] mm: multi-gen LRU: minimal implementation
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
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

On Sat, Mar 19, 2022 at 4:11 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Fri, Mar 18, 2022 at 9:01 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > > +static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
> > > +{
> > > +       unsigned long old_flags, new_flags;
> > > +       int type = folio_is_file_lru(folio);
> > > +       struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > > +       int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
> > > +
> > > +       do {
> > > +               new_flags = old_flags = READ_ONCE(folio->flags);
> > > +               VM_BUG_ON_FOLIO(!(new_flags & LRU_GEN_MASK), folio);
> > > +
> > > +               new_gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > > +               new_gen = (old_gen + 1) % MAX_NR_GENS;
> >
> > new_gen is assigned twice, i assume you mean
> >                old_gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> >                new_gen = (old_gen + 1) % MAX_NR_GENS;
> >
> > or do you always mean new_gen =  lru_gen_from_seq(min_seq) + 1?
>
> Thanks a lot for your attention to details!
>
> The first line should be in the next patch but I overlooked during the
> last refactoring:

Thanks for the clarification. So an unmapped file-backed page which is
accessed only by system call will always be in either min_seq or
min_seq + 1? it has no chance to be in max_seq like a faulted-in
mapped file page?

>
>   new_gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> + /* folio_update_gen() has promoted this page? */
> + if (new_gen >= 0 && new_gen != old_gen)
> + return new_gen;
> +
>   new_gen = (old_gen + 1) % MAX_NR_GENS;

Thanks
Barry
