Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB904E5EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348173AbiCXG00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbiCXG0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:26:24 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B917DEDA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:24:52 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id w123so2046806vkg.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGkLO8QE+JkINxXufCxF2QAgYC6g0Sy7UndvDKoQKoY=;
        b=b5W5RtODlUZwjxFNOLlgJKy1liQ7knXpgC6Q4PMKfK70IK3Z+SGPCLgekfc7YBtf6T
         RWnXoJ1DVG/iwdj8CxOvsG63VuHHFRBKgDx7YdCZil2CSFii61MsAk4craMFawUK1KKQ
         CzXcxF4PiKAjWUrnjLmou3WI+kpa5bOhbyd2Br+AmOkuCZmxvE8fh5aFWhanPGyUeM//
         VsQnaJ+jt3Ef6rh/nwOUmkbDyGl80bpLr0qPPjBNjHDjqWvv6RbGGNzQfUiuNSkxmoqO
         z8TwgnXmoPLO7QyTzR66ZAVZkmrjRKkgX3eioW4J9VQKr7lDL735TS1SM4RmJKTIQh4K
         L0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGkLO8QE+JkINxXufCxF2QAgYC6g0Sy7UndvDKoQKoY=;
        b=35Noctnx6p/In9Y9lTaMKp/7FFgb/1xuAHsnQiiEpzlUaRP+nD+bPsO7PmsiM1o5oj
         cedObpuczGMtOResjknRIE20pVMNm5Ph2YDyXUZZGSELkftlTmg7Oqqld7+CPDZoofzV
         XPZ/twrBq0nnGFE5aCUJ9FYShYcGxxKkZmNuRvbD4ndO1CojjQ0Qvz+DcpHIpAvYmWtj
         RZJW+5ys+BWwJK1Smev88TpA293/JWK/vaW74UjY4Sq1xnq8Doksxa48FMy3YLMVNWzm
         HTLmIryNY7Ee8UoIkbqnwYadjUhikWUv5vdNEuj2qlmZpa1gQUU21u8RDG254YgANjZx
         E0cw==
X-Gm-Message-State: AOAM5318O4LsmpCMJG3G/qB9qpWVQnqo3WtzB8NPb92kYaQLwZfnJ8j8
        pGjw0OjXQ7eqym5JVuxNX55PF8CYbAkDPD0BSxQD+A==
X-Google-Smtp-Source: ABdhPJxRn6EidO34JgbBxOQGAq3o3F8SEptQ83Bk4g5oxbRMsM4MHsG6O9JwhGkK9BvQBDCzyAxmpAHbZjknr0b1eDI=
X-Received: by 2002:a1f:a9cb:0:b0:33e:d145:85f0 with SMTP id
 s194-20020a1fa9cb000000b0033ed14585f0mr1848134vke.7.1648103091440; Wed, 23
 Mar 2022 23:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-7-yuzhao@google.com>
 <CAGsJ_4xfL7h6M92WGusxbTxQzHOJDj4X4AuC=0HgrEyAYJaJFg@mail.gmail.com>
 <CAOUHufbiSShp=khZFL6BmJKNNkG-LBrsPoLwYxewcgtZhi5tFg@mail.gmail.com> <CAGsJ_4zeNtAsq7E9SKVwuKaXnKj80BP2NPHdjtd1i=098M6eDw@mail.gmail.com>
In-Reply-To: <CAGsJ_4zeNtAsq7E9SKVwuKaXnKj80BP2NPHdjtd1i=098M6eDw@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 24 Mar 2022 00:24:40 -0600
Message-ID: <CAOUHufazsjhp3GzV7QFOqEeG98zJyRWd+HocyYR1FP3nk-Ho0Q@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] mm: multi-gen LRU: minimal implementation
To:     Barry Song <21cnbao@gmail.com>
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

On Wed, Mar 23, 2022 at 1:47 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Sat, Mar 19, 2022 at 4:11 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Fri, Mar 18, 2022 at 9:01 PM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > > +static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
> > > > +{
> > > > +       unsigned long old_flags, new_flags;
> > > > +       int type = folio_is_file_lru(folio);
> > > > +       struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > > > +       int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
> > > > +
> > > > +       do {
> > > > +               new_flags = old_flags = READ_ONCE(folio->flags);
> > > > +               VM_BUG_ON_FOLIO(!(new_flags & LRU_GEN_MASK), folio);
> > > > +
> > > > +               new_gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > > > +               new_gen = (old_gen + 1) % MAX_NR_GENS;
> > >
> > > new_gen is assigned twice, i assume you mean
> > >                old_gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > >                new_gen = (old_gen + 1) % MAX_NR_GENS;
> > >
> > > or do you always mean new_gen =  lru_gen_from_seq(min_seq) + 1?
> >
> > Thanks a lot for your attention to details!
> >
> > The first line should be in the next patch but I overlooked during the
> > last refactoring:
>
> Thanks for the clarification. So an unmapped file-backed page which is
> accessed only by system call will always be in either min_seq or
> min_seq + 1? it has no chance to be in max_seq like a faulted-in
> mapped file page?

That's right. The rationale is documented here under the `Assumptions`
section [1]. This is also related to Aneesh's question about why MGLRU
doesn't need additional heuristics for VM_EXEC pages [2]. Unmapped
file pages weaken the protection of executable pages under heavy
buffered IO workloads like Java NIO.

[1] https://lore.kernel.org/linux-mm/20220309021230.721028-15-yuzhao@google.com/
[2] https://lore.kernel.org/linux-mm/CAOUHufYfpiGdLSdffvzDqaD5oYFG99oDJ2xgQd2Ph77OFR5NAA@mail.gmail.com/
