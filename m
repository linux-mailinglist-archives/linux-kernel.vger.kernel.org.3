Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A351D4DE546
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 04:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241879AbiCSDCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 23:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241856AbiCSDCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 23:02:44 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0F71107ED;
        Fri, 18 Mar 2022 20:01:24 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id f38so18985328ybi.3;
        Fri, 18 Mar 2022 20:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=reWmP4Yyv0Mmo6tNnGsk6in1wc+xPjfMEBmvAdgMoDc=;
        b=QUlxX+ZAOMShNBy+QnsJ90r1OQ2VOtNFYnHa00oELbHAs+M54BOXEIoxDVlOVm/s8+
         avht463rTX2aoWPIV+BF3uceUVZhaAzjTpjizML6oKG8iMMqogbfibpNdUf98CWNccr4
         C+fxRZgXq2MlqUAHZxYCiVIfvISSh3lQLoo40Q4yzat43Ymskbt10DuKHxzG5udvK0od
         qL6a0umXrn4MC3BVDm/TzRjtG4++Mld7fHrAEWnXA+4pxW5VBLG7HLO5pfqIxcyR3WLd
         bxsuv20v9YTz/bGw93sfTvaPzQRSLLFu3tGQENkL00hciLjvIN/mZKLB9RuoDtYCfAig
         1O4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=reWmP4Yyv0Mmo6tNnGsk6in1wc+xPjfMEBmvAdgMoDc=;
        b=rCxymcfEV8osH1DyP8GWdecImFS6YYQYOeLbEQgvqQAEkPp4R3EdR/9h3h1kArc/yc
         +Gxe/u9d5poVQe+Yty7Z+KW7fEl+R2LPoCXL0zbTS3zT+vXajbGI/oCjoNMuYg52aw7k
         dSbXkf7R1jNiLfDRwEbWbtyz9Z2BCs8uoXpZ9WdfAoBIIaCNRU1VX7IFGLbV32ierTBw
         3hg3Grz5MfVfievkbSSM+nVQnml3Fea0n1Jf4fbs6RZbp3YbtaNx3Gbv/t68ZmZkkW2e
         ExoRzhbxFYOcW7YsHPu/B4sqbUn9WnV6bm9BXoGcHLvGcZ/SM9z+8mIX487rHfe9Xj9p
         0qgw==
X-Gm-Message-State: AOAM532f6h5/U8lv8UBcxCB7ugANVO5BcXnQ1KYgYRI8/rmJaP4yJ7YS
        rnNrR8YK0rEpygnsZd1yGLn03YRpWyZwj6JkLV8=
X-Google-Smtp-Source: ABdhPJy0KTsGLEMJSC7xXZIBl4jfjABsDmKySWeDy3fUv2e8cUQp/c8hnHRCm9bEJfcTFciPSvLiI0NwgGoMEQ7JcNk=
X-Received: by 2002:a25:fe04:0:b0:628:af01:f734 with SMTP id
 k4-20020a25fe04000000b00628af01f734mr13139432ybe.441.1647658883838; Fri, 18
 Mar 2022 20:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-7-yuzhao@google.com>
In-Reply-To: <20220309021230.721028-7-yuzhao@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 19 Mar 2022 16:01:13 +1300
Message-ID: <CAGsJ_4xfL7h6M92WGusxbTxQzHOJDj4X4AuC=0HgrEyAYJaJFg@mail.gmail.com>
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

> +static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
> +{
> +       unsigned long old_flags, new_flags;
> +       int type = folio_is_file_lru(folio);
> +       struct lru_gen_struct *lrugen = &lruvec->lrugen;
> +       int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
> +
> +       do {
> +               new_flags = old_flags = READ_ONCE(folio->flags);
> +               VM_BUG_ON_FOLIO(!(new_flags & LRU_GEN_MASK), folio);
> +
> +               new_gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
> +               new_gen = (old_gen + 1) % MAX_NR_GENS;

new_gen is assigned twice, i assume you mean
               old_gen = ((new_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
               new_gen = (old_gen + 1) % MAX_NR_GENS;

or do you always mean new_gen =  lru_gen_from_seq(min_seq) + 1?

> +
> +               new_flags &= ~LRU_GEN_MASK;
> +               new_flags |= (new_gen + 1UL) << LRU_GEN_PGOFF;
> +               new_flags &= ~(LRU_REFS_MASK | LRU_REFS_FLAGS);
> +               /* for folio_end_writeback() */
> +               if (reclaiming)
> +                       new_flags |= BIT(PG_reclaim);
> +       } while (cmpxchg(&folio->flags, old_flags, new_flags) != old_flags);
> +
> +       lru_gen_update_size(lruvec, folio, old_gen, new_gen);
> +
> +       return new_gen;
> +}
> +

Thanks
Barry
