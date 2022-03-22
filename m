Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF64E38A4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 06:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbiCVF5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 01:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbiCVF51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 01:57:27 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC432A273
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:55:57 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a28so6601192uaf.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVziKtonTIkNbV/B71HuGD9fXJjRE/zSA9pL7FZgyn4=;
        b=rWG3R5qtX3GucWwH/rM7jmJOCfVi1T2dvoGI6lKrW+Kouh7f4j1XUU0D9xwMNzNHOo
         dCnFw11acEpDzgxXIxKkr9JUAeKCz8hqSXKb3u0uMF7Ds2qDxH5HRCPUWjY0KheQt5ys
         dVCRYr3EJc33+LNjGUoQn+m6pD7G2XugAlmc+o/BOLG9KKf5ii9XOblcuHbqLUrW6C2r
         GkCpVUgz7ej3LX9oiCj8+FQoXwEuWTYiR+JgnaNATpY/mb+E+UWRf4BX71w153S3JWuS
         iQ7HJcjF4rNDbIqhlJtMxxMFzQ46p2okOvFx3s6tVJ5pGcqFH90djo0dIcO0q1QlI5zX
         AfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVziKtonTIkNbV/B71HuGD9fXJjRE/zSA9pL7FZgyn4=;
        b=TEjCYf84nBFzxYCKl/M8n4r92fs5COluT3/MMVQbzmNkwl0eHrGfZAKbLOtOLYqFxs
         gHBCNfWSZdiNu4hsyDB5jHFhy1EWHpPnRZDA3ZWxI/C7VrkoPoLumkoM6FbcDvYr4u/8
         Eqvh/VvEiUfCuy2ajgjhlRc/AsX9ZjLFoG5hwLPqOc846VEcu5wvNBMqf+wO6u+NKC7J
         kgMPRbflm8mubQdoAz/gM+bdCx5GfyehE1dbJDYi13E3OvKLwPJ1PPP3eA3ZZaYDulDH
         iT19jpJBULmTTGSyakWpFqar6PxRsV8R5hpke7O+VisUrbvb9Iq0q6S4f/ZPDnn/2IlJ
         g9XQ==
X-Gm-Message-State: AOAM531xzMZ3/XYFUC01NlAG7XqmvNna+U6XrMiTiNAQUL5FF8EQUL2H
        KibF8khuLwsr2myEhWPkvQmkvAgOxEy3IpnwroB+Fg==
X-Google-Smtp-Source: ABdhPJx9NAJdm7wGUG2vKQV8Iy5sHiwmlsE4VyWbB4rB7wkz+hRMGuViJsfZh1uA1fHdTyd2MGjS27NegFyZsCL0rhM=
X-Received: by 2002:ab0:77d5:0:b0:352:42d7:88c2 with SMTP id
 y21-20020ab077d5000000b0035242d788c2mr8221502uar.1.1647928556608; Mon, 21 Mar
 2022 22:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-7-yuzhao@google.com>
 <877d8m7e1x.fsf@linux.ibm.com>
In-Reply-To: <877d8m7e1x.fsf@linux.ibm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 21 Mar 2022 23:55:45 -0600
Message-ID: <CAOUHufbDfwgm8PgCGkhCjbhMbm=fekfjgRR56NL-j+5iUGfVuw@mail.gmail.com>
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

On Mon, Mar 21, 2022 at 11:27 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Yu Zhao <yuzhao@google.com> writes:
>
> > +static void inc_max_seq(struct lruvec *lruvec, unsigned long max_seq)
> > +{
> > +     int prev, next;
> > +     int type, zone;
> > +     struct lru_gen_struct *lrugen = &lruvec->lrugen;
> > +
> > +     spin_lock_irq(&lruvec->lru_lock);
> > +
> > +     VM_BUG_ON(!seq_is_valid(lruvec));
> > +
> > +     if (max_seq != lrugen->max_seq)
> > +             goto unlock;
> > +
> > +     inc_min_seq(lruvec);
>
> Can this min seq update result in pages considered oldest become young.
> ie, if we had seq value of 0 - 3 and we need ageing, the new min seq and
> max_seq value will now become 1 - 4. What happens to pages in the
> generation value 0 which was oldest generation earlier and is youngest
> now.

If anon pages are not reclaimable, e.g., no swapfile, they won't be
scanned at all. So their coldness/hotness don't matter -- they don't
need to be on lrugen->lists[] at all.

If there is a swapfile but it's full, then yes, the inversion will
happen. This can be handled by moving pages from the oldest generation
to the tail of the second oldest generation, which maintains the LRU
order.

In fact, both were handled in the previous versions [1] [2]. They were
removed in v6 for simplicity.

[1] https://lore.kernel.org/linux-mm/20211111041510.402534-5-yuzhao@google.com/
[2] https://lore.kernel.org/linux-mm/20211111041510.402534-7-yuzhao@google.com/

> > +static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness)
> > +{
> > +     int type;
> > +     int scanned;
> > +     int reclaimed;
> > +     LIST_HEAD(list);
> > +     struct folio *folio;
> > +     enum vm_event_item item;
> > +     struct reclaim_stat stat;
> > +     struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> > +     struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> > +
> > +     spin_lock_irq(&lruvec->lru_lock);
> > +
> > +     scanned = isolate_folios(lruvec, sc, swappiness, &type, &list);
> > +
> > +     if (try_to_inc_min_seq(lruvec, swappiness))
> > +             scanned++;
>
> we are doing this before we shrink the page list. Any reason to do this before?

We have isolated pages from lrugen->lists[], and we might have
exhausted all pages in the oldest generations, i.e.,
lrugen->lists[min_seq] is now empty. Incrementing min_seq after
shrink_page_list() is not wrong. However, it's better we do it ASAP so
that concurrent reclaimers are less likely to see a stale min_seq and
come here under the false impression that they'd make some progress.
(Instead, they will go to the aging path and inc_max_seq() first
before coming here.)
