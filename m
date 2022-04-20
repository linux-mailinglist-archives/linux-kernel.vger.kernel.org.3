Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D674507DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358581AbiDTAmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244069AbiDTAmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:42:40 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA011A2D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 17:39:54 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id d9so130036vsh.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 17:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KT16lddZpOeYEOzxjkpuLBwqew5J7d3LxwdLjYYWCDQ=;
        b=sctCgxK1K3o1FcCO7rvQr3ADGC+2y/q5zKIjHhpp8W+eXKQaq+DYjntlCpz7UR9H81
         Tv5YrcqPtfHJzmdKz9P80FH3XA7nIEBfI2SwjV9PwgwTIyvcDxCDY/ahHe4b9Y29ubQS
         ZZuUKsJTeqbluvdFLtz6CwI3+FWQY4RjkNiEQhQrJtX5EFCjClPp+ZSEkCiY6TejT/m/
         2n+FES1CNoeKXkI9nvvM9uUg3IBqLEA2B/SjcEQ/TTR6KJM4SXYQXXBaJN8W8BDSXgZX
         rUmsCxlXsk1u1leLF4gcOGUcacKgrve+KnL4WN1a7FtjdIBjU8L11UzWS8weJnlr8/qd
         63gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KT16lddZpOeYEOzxjkpuLBwqew5J7d3LxwdLjYYWCDQ=;
        b=VuIGD/nTsNHigM/7yp8XaYjlAtn2NEznpLnYdM5JaZ4snC23b3u/a/e3rAK/TdfKTi
         dyXyiewlECPWxkklmpMErA8FG8EZ+C7fwb34RLF6cMrpbZhN4ZPLBRiHi0R3OFPpGBK5
         NDz6yW3AnH+luclczrqTv+LjYu6uULkqSlgj0vPaLBJBbbKHwNCeF66otp/44FVgFMI0
         Zzt7Xse2MUpvFI/dubiU9cyRx4Xr1MYjJjTRhL7ls7jqctzOJ23sLFs2b1b/ER0AQbxO
         LsVCHzE1sRuU1nPoJdpDDYdIC6wdo9Irkv7eWCzlWPghH/MhHi/9f94TiDyVn1g9iNym
         hjmw==
X-Gm-Message-State: AOAM531iNOgRkMi4rxvkKUFw91JYo6NCsmWS5Gj3l3/MmT4+bPnbcncX
        kQGIeU5HW9JJHboduJ2AH/lChpz6SuFZZxn55+iD1g==
X-Google-Smtp-Source: ABdhPJxtK3l4fn9+QFdiu0rNZ2xlRrzY2+o6YQzD7NeHRc8+S6Z7hXRtCYNygpfogrJcYbf8Hrjskc6cyluLwGUtJnM=
X-Received: by 2002:a05:6102:5113:b0:32a:76b1:e1bc with SMTP id
 bm19-20020a056102511300b0032a76b1e1bcmr622157vsb.41.1650415193573; Tue, 19
 Apr 2022 17:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-6-yuzhao@google.com>
 <20220411191615.a34959bdcc25ef3f9c16a7ce@linux-foundation.org> <20220412070616.GT2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220412070616.GT2731@worktop.programming.kicks-ass.net>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 19 Apr 2022 18:39:17 -0600
Message-ID: <CAOUHufbUyTL-xx1RBovfSh+CrK7mBHGOouvyQBjy1RX1f3dkzw@mail.gmail.com>
Subject: Re: [PATCH v10 05/14] mm: multi-gen LRU: groundwork
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 1:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Apr 11, 2022 at 07:16:15PM -0700, Andrew Morton wrote:
>
> > > +{
> > > +   int gen;
> > > +   unsigned long old_flags, new_flags;
> > > +
> > > +   do {
> > > +           new_flags = old_flags = READ_ONCE(folio->flags);
> > > +           if (!(new_flags & LRU_GEN_MASK))
> > > +                   return false;
> > > +
> > > +           VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
> > > +           VM_BUG_ON_FOLIO(folio_test_unevictable(folio), folio);
> > > +
> > > +           gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> > > +
> > > +           new_flags &= ~LRU_GEN_MASK;
> > > +           /* for shrink_page_list() */
> > > +           if (reclaiming)
> > > +                   new_flags &= ~(BIT(PG_referenced) | BIT(PG_reclaim));
> > > +           else if (lru_gen_is_active(lruvec, gen))
> > > +                   new_flags |= BIT(PG_active);
> > > +   } while (cmpxchg(&folio->flags, old_flags, new_flags) != old_flags);
>
> Also; please use the form:
>
>         unsigned long new, old = READ_ONCE(folio->flags);
>
>         do {
>                 new = /* something */ old;
>         } while (!try_cmpxchg(&folio->flags, &old, new))

Sweet. Thanks.

A related question: if I pass new = old to try_cmpxchg(), does it know
that and avoid an unnecessary atomic op?
