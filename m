Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93574DE78C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 12:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242756AbiCSLQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 07:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiCSLQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 07:16:32 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1502C3DD4;
        Sat, 19 Mar 2022 04:15:11 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id o5so20107691ybe.2;
        Sat, 19 Mar 2022 04:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmpfHS1P+qpaVI9DLkTFbIW8LYRa15RLKPALOZCQDKk=;
        b=U2lczM+Kei/H8pl07DdkRF/zKfwtoBL7jGf/hZk6ujcHWCiCiUIOg+g+eqUv5YMNQU
         sE3SJxo82a1CAdrGtGIK1WNfH3hgGzJqW8l95OP68GFDbkjIdaflEC3/VyslJacg938Y
         fw7vv4WJg2Ze898KPgW406xg16quHSMDJJjeLfZ+AGBs3P6EMcHWK5J2cUq2lp9TMVdq
         rISsYg+8UBpFBVKu7YUjca2eIgncLRWlnFqpjku7saZ8H1MFWO9yRbvTUSfKMwCLDwQC
         5qwjcxH6Wup0k1IrYotTOjMWuMAltNeGrnfEp6KI8jacb1kxnjx89ji/U5KmkKDbe7oJ
         5rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmpfHS1P+qpaVI9DLkTFbIW8LYRa15RLKPALOZCQDKk=;
        b=YStwtHM6GqeZMizK+g8B05dzfKEKo+n0Bx1RS4hkHlr9R0t0I0e7/uR1KketpZkkZV
         CP2oEXo6yvpNF6wMHH8v5fOMfxEO+NjvfqIHLcQc058VEiEVO79USGVmyuO3H1DpCPxA
         MemqiX1/Nm7iJVXewuSfY6BbMLMk6/mv5lZWfT9sKTLbEgsH31XtVW1vCy8udOSC07hz
         LPHJTVWfYsGx+rZDLa87XYG99RPrP14niaEdCxHBdn/TQTeks7WiUjM+AupYRY1KOzHj
         fA2T09s4mTGAMxpcZdBTRBtfUDyiqcGt5Fv9EkSd58R4azmBdQl8CCTXbx2YR/lB4Oe0
         xM0w==
X-Gm-Message-State: AOAM533kD5/7v+7HG9B1H585KLPmKTHoH7jalNOPDobTukG9ozFHmR/4
        0IzwUSJU+mkf0R6zoOSh7b6Jpw3ZNlijYQSYOVs=
X-Google-Smtp-Source: ABdhPJxlHmYPruUoNqz/mzX0ofnX1IhGKWK+gllmONTx2BCLV1p3PSGIbJQ6vwLyx55cqi63NW1jMmc+uZUxWKWHiII=
X-Received: by 2002:a25:fe04:0:b0:628:af01:f734 with SMTP id
 k4-20020a25fe04000000b00628af01f734mr14210131ybe.441.1647688510994; Sat, 19
 Mar 2022 04:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-7-yuzhao@google.com>
In-Reply-To: <20220309021230.721028-7-yuzhao@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 20 Mar 2022 00:15:00 +1300
Message-ID: <CAGsJ_4zw0gX0+OPE3MPaSRH53LdVR0TNv1RN5DK9dtNPvgd8iQ@mail.gmail.com>
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

> +                            unsigned long *min_seq, bool can_swap, bool *need_aging)
> +{
> +       int gen, type, zone;
> +       long old = 0;
> +       long young = 0;
> +       long total = 0;
> +       struct lru_gen_struct *lrugen = &lruvec->lrugen;
> +
> +       for (type = !can_swap; type < ANON_AND_FILE; type++) {
> +               unsigned long seq;
> +
> +               for (seq = min_seq[type]; seq <= max_seq; seq++) {
> +                       long size = 0;
> +
> +                       gen = lru_gen_from_seq(seq);
> +
> +                       for (zone = 0; zone < MAX_NR_ZONES; zone++)
> +                               size += READ_ONCE(lrugen->nr_pages[gen][type][zone]);
> +
> +                       total += size;
> +                       if (seq == max_seq)
> +                               young += size;
> +                       if (seq + MIN_NR_GENS == max_seq)
> +                               old += size;
> +               }
> +       }
> +
> +       /* try to spread pages out across MIN_NR_GENS+1 generations */
> +       if (min_seq[LRU_GEN_FILE] + MIN_NR_GENS > max_seq)
> +               *need_aging = true;
> +       else if (min_seq[LRU_GEN_FILE] + MIN_NR_GENS < max_seq)
> +               *need_aging = false;
> +       else if (young * MIN_NR_GENS > total)
> +               *need_aging = true;

Could we have some doc here? Given MIN_NR_GENS=2 and MAX_NR_GENS=4,
it seems you mean if we have three generations and the youngest pages are more
than 1/2 of the total pages, we need aging?


> +       else if (old * (MIN_NR_GENS + 2) < total)
> +               *need_aging = true;

it seems you mean if the oldest pages are less than 1/4 of the total pages,
we need aging? Can we have comments to explain why here?

your commit message only says " The aging produces young generations.
Given an lruvec, it increments max_seq when max_seq-min_seq+1
approaches MIN_NR_GENS." it can't explain what the code is doing
here.


> +       else
> +               *need_aging = false;
> +
> +       return total > 0 ? total : 0;
> +}

Thanks
Barry
