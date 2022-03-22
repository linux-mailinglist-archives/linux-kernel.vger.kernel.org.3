Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273A64E37C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiCVEEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbiCVEEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:04:37 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A2821275
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:03:09 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 134so7016240vkz.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1WDVkBMGb1UWaUiP/BMa1bimDceuIIYF6DsrMPvkIE=;
        b=S0qxjRqltQsnLpu+b9uTdJ1ZzChP2TnUXVIzPiQtTKv7rlk1UWjMjpE3h3bJ1v9sW5
         huKNUHAUPdXtj83a+494lrok1KWMjxoILFSd5pHwf9iQmsFVDC1eRjvLfix18amc27kO
         MsjP26xdR64RX1aD6Hw91Gd0LUTxfC6mxTRGSBJ99LzE7YFS5Z9RjF5ytt9aaGyHf81w
         sz+tauM57ujRXoLkISPTzAxt18Hgulk2BRNjkFZj9kKAWXZw37XWQVAZvAPw/rP+8Jg7
         rcHa715+9N1drYanKpzpnvhAK+KvRyfiowz/VQuifj507DPS+Fq82rZrypJidfABzyVr
         plzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1WDVkBMGb1UWaUiP/BMa1bimDceuIIYF6DsrMPvkIE=;
        b=c66L8ixwsLtnI8JhdsUhucbn8gY+2SmVXgjGWgeEBOU2UZUvIlkxrfdle5DS17PlRX
         ttpBrF6mBUGX/7fLrXnqPVI1j4iaBN6I2AAoyJP47+4V+uGgNvUExpkbQeeKy7D830/H
         Gek2JYyurqq8Qoi09nHf1/+UkHWjHhGa3yYeaAb17agjPcU+O/vsTq87mGWzg27TFbwh
         qxjVAw7CkN+HGkTSgO6EEw0fdENLhY+pWte/LbcGBmnw/0y6iB69hUPMollaQ2ukoeL/
         sFporo02uIIAtmx0jOYD5eWyssvWrzplw+lNEUCFPd5nBvPmsKcxO1sRRH0dK0lsKILc
         9l9Q==
X-Gm-Message-State: AOAM531+Q4u3lJU2f3gyeOSsWiN71uY/R1ZZmSOlUvF1opAh4b/4AoSA
        nJpEp7ieKV6PxubCz96awB0mSlKl5V6MQ81Y3qjsAA==
X-Google-Smtp-Source: ABdhPJxtzx4fQPL53yxR2Z+LZ1DoZuKamA0ncWy8RZCGDsKAcQCH9+DROmoF8tqhSlZxwTp/BlxCUFz+Sjx0CpOrPd0=
X-Received: by 2002:a05:6122:20a1:b0:33e:e79d:25c2 with SMTP id
 i33-20020a05612220a100b0033ee79d25c2mr3933628vkd.14.1647921788539; Mon, 21
 Mar 2022 21:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-7-yuzhao@google.com>
 <87czif79k2.fsf@linux.ibm.com>
In-Reply-To: <87czif79k2.fsf@linux.ibm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 21 Mar 2022 22:02:57 -0600
Message-ID: <CAOUHufa1nuyJ1MawqBTRZS78EFOGTw0_qh5k3XvDo9XQCvan7g@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] mm: multi-gen LRU: minimal implementation
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
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

On Mon, Mar 21, 2022 at 6:52 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
>  +
> > +static long get_nr_evictable(struct lruvec *lruvec, unsigned long max_seq,
> > +                          unsigned long *min_seq, bool can_swap, bool *need_aging)
> > +{
> > +     int gen, type, zone;
> > +     long old = 0;
> > +     long young = 0;
> > +     long total = 0;
> > +     struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > +
> > +     for (type = !can_swap; type < ANON_AND_FILE; type++) {
> > +             unsigned long seq;
> > +
> > +             for (seq = min_seq[type]; seq <= max_seq; seq++) {
> > +                     long size = 0;
> > +
> > +                     gen = lru_gen_from_seq(seq);
> > +
> > +                     for (zone = 0; zone < MAX_NR_ZONES; zone++)
> > +                             size += READ_ONCE(lrugen->nr_pages[gen][type][zone]);
> > +
> > +                     total += size;
> > +                     if (seq == max_seq)
> > +                             young += size;
> > +                     if (seq + MIN_NR_GENS == max_seq)
> > +                             old += size;
> > +             }
> > +     }
> > +
> > +     /* try to spread pages out across MIN_NR_GENS+1 generations */
> > +     if (min_seq[LRU_GEN_FILE] + MIN_NR_GENS > max_seq)
> > +             *need_aging = true;
> > +     else if (min_seq[LRU_GEN_FILE] + MIN_NR_GENS < max_seq)
> > +             *need_aging = false;
>
> Can you explain/document the reason for the considering the below
> conditions for ageing?
>
> > +     else if (young * MIN_NR_GENS > total)
> > +             *need_aging = true;
>
> Are we trying to consdier the case of more than half the total pages
> young as needing ageing? If so should MIN_NR_GENS be 2 instead of using
> that #define? Or
>
> > +     else if (old * (MIN_NR_GENS + 2) < total)
> > +             *need_aging = true;
>
> What is the significance of '+ 2' ?

Will improve the comment according to my previous reply here [1].

[1] https://lore.kernel.org/linux-mm/CAOUHufYmUPZY0gCC+wYk6Vr1L8KEx+tJeEAhjpBfUnLJsAHq5A@mail.gmail.com/
