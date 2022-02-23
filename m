Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E714C0F48
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbiBWJgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239303AbiBWJgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:36:53 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01421593B2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:36:26 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id t22so2473772vsa.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RNctXvz/+pBy9XAX0EqBi4IREn0H0T0ytHG6ULPDoI0=;
        b=V3LuRwEpxHob6IJLmsHbuhIouyLQNrSHcNT4Snuspt5KDa5sThyfL2rrzDDYtjjzBa
         K9IO34tFfrQD5KR9tgEfdY6KkjuUTZfC6TSAWolAfHbVKCZ0l+jFZMRE6ZcGxff71UY2
         vvBhV5Ji9qT2q145R46bknnHaiSo21b1UU2GyBnXm//3H7jko5nnzW00cwOW+Q/Cvq9Y
         Ol1VIZkRuHYq/9moH6ihYLZt9xQzvhkErQNAfQ0nOyzLf+0qRkPXD/UPZ8NBff8WWLUV
         XsGzsdFcnAufwM56SI1jh4ipBUd3Yxvv+hlUpdktOcDmn9L9UEZ4yL7ultE9dL7sCjdI
         CiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RNctXvz/+pBy9XAX0EqBi4IREn0H0T0ytHG6ULPDoI0=;
        b=BHunDg/dwWnSJcTPbR/vkTWZbvGXw1ueH4dpGNDRU8IOdkDz9/7vnRbi2cD9sLSSd+
         xhYa+wiev7gbgVVLJaN4IMRKWxuWCGD6nr3LyP6TzTE64h2RBDdBcerfe9VUsFb5EbaK
         CBB2jTXemAgUKCHGlHXo3zAaLPHcxJEOxbK8DTBiA1wuMXR7f36JWOtLUv+oG76IM1W4
         D5Vdz165XnPtPQVMdcuKeWmSSpu3zUyF3rfz4LvlRzLgzXQETLxFJ0mkzRmLawS6ocJ8
         iP/IdBYU0daqANTcshM7DS+yoDtkMSNT3GkPxnfoo/oBTcZWyKvR4ojitscGIlK7GLsu
         ANlA==
X-Gm-Message-State: AOAM533x+S90hiQfSYt7MPvw6xiyAQ0gRzO6AIhLkZnmB9bYk1UM8obh
        8rpPwJwvGaF9+rajuhxZ+IPNV71gXrhamzpSzXFeaw==
X-Google-Smtp-Source: ABdhPJwrN8fS2vL8pC+XpnMNYgxdYuOBZM8HK8roIA0KECuRJmupbXZoBV8Bw2+nj8jF+3c68XJb462SZUbdaFzsQfQ=
X-Received: by 2002:a05:6102:3a06:b0:31b:d9c6:c169 with SMTP id
 b6-20020a0561023a0600b0031bd9c6c169mr11510124vsu.22.1645608984949; Wed, 23
 Feb 2022 01:36:24 -0800 (PST)
MIME-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com> <20220208081902.3550911-6-yuzhao@google.com>
 <87bkyy56nv.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87bkyy56nv.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 23 Feb 2022 02:36:13 -0700
Message-ID: <CAOUHufbekcu09DyEZAkJNRq_1qKaf_xibXQNeAVK=rsGBn9Z4Q@mail.gmail.com>
Subject: Re: [PATCH v7 05/12] mm: multigenerational LRU: minimal implementation
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
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
        Sofia Trinh <sofia.trinh@edi.works>
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

On Wed, Feb 23, 2022 at 1:28 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Hi, Yu,
>
> Yu Zhao <yuzhao@google.com> writes:
>
> > To avoid confusions, the terms "promotion" and "demotion" will be
> > applied to the multigenerational LRU, as a new convention; the terms
> > "activation" and "deactivation" will be applied to the active/inactive
> > LRU, as usual.
>
> In the memory tiering related commits and patchset, for example as follows,
>
> commit 668e4147d8850df32ca41e28f52c146025ca45c6
> Author: Yang Shi <yang.shi@linux.alibaba.com>
> Date:   Thu Sep 2 14:59:19 2021 -0700
>
>     mm/vmscan: add page demotion counter
>
> https://lore.kernel.org/linux-mm/20220221084529.1052339-1-ying.huang@intel.com/
>
> "demote" and "promote" is used for migrating pages between different
> types of memory.  Is it better for us to avoid overloading these words
> too much to avoid the possible confusion?

Given that LRU and migration are usually different contexts, I think
we'd be fine, unless we want a third pair of terms.

> > +static int get_swappiness(struct mem_cgroup *memcg)
> > +{
> > +     return mem_cgroup_get_nr_swap_pages(memcg) >= MIN_LRU_BATCH ?
> > +            mem_cgroup_swappiness(memcg) : 0;
> > +}
>
> After we introduced demotion support in Linux kernel.  The anonymous
> pages in the fast memory node could be demoted to the slow memory node
> via the page reclaiming mechanism as in the following commit.  Can you
> consider that too?

Sure. How do I check whether there is still space on the slow node?
