Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288AC5553E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377412AbiFVS7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377384AbiFVS7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:59:37 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFC231227
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 11:59:36 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id i186so18119397vsc.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 11:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=znYvHmQcO9pIRRv6Z8ozam49umE/VEVHtcAiw2I40Es=;
        b=CLK0Sc/VIQrO0e0i4+me/g3XoHa0rzmIKIsq7EEwFczzkwg7MmJmjQtgOABsf+JhAj
         rdt0AtJ9uvHEebNKgMI2tl7OzmOoGwYLZr1OeLh5aBeYBbjkw8E6v+OuEktc+sdw1Nec
         13m88X9Nab1dyhzoVljcxP30x42qCsjqU6X0Z00ETL+oIY2ZgYndQ9Oj5qTT04s5pIg/
         g9fPQh8DaGU4Zte5VhvuiY8Sem3CAAtxdhE5pRMwYtpUBLNFbgWgKlqyFL7Rrjx4moU/
         8/tM3m0AusZI6GKOgQtIo/UHMUJ00DmKJZHSLtis09uIimKdBEbyyfEblHYNBCRAM+55
         w/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znYvHmQcO9pIRRv6Z8ozam49umE/VEVHtcAiw2I40Es=;
        b=Qqj/tjC8leWaYVJScMWBwFoslFYifuyxalCPX2ItuBCDAcpiZbKlRRaFdTtRwxNRQ0
         KhJkUBIWrtHoizQSa4r5zp7yVerRvgiatM5fUYrpQFiGJTVaxqbkylAd7hMOqi834jpg
         DwtJ4wMtSbryBVwZ1SlL9UGpeKA0/gcxp1eMzoCHpwxRz6FWRamq3RH5EEPsmvs1nrMb
         dyyVtOgTqixoUeZ5bFYQxfc2S4VXjQnrZHrW202TdM2A5qdg6Cyj1ZaY+KBnfSwTfsxQ
         C3rCKZr2d2becpVt4v3nz/O9NKeLfF8UbM/Q/e199Hd57QzQLDSPlbypNRxo9fhtyAd7
         3new==
X-Gm-Message-State: AJIora9G+3lSLEkvD24V89snpZhH8WjKMTnfSBYvqEK9lNiKCiSwVk0r
        lPoMxhhDJniM/GjPmGOs+0CzEQ57MUbc74xUnHAVUw==
X-Google-Smtp-Source: AGRyM1uavjJLzM0cL61VD8DwjKtvC3vJEveEtmvdwbmLM160pNEVOUsFglLOn9gcHkO71FalVgfPg63k9+qdulgbh4w=
X-Received: by 2002:a05:6102:32c8:b0:34c:2358:1824 with SMTP id
 o8-20020a05610232c800b0034c23581824mr17035693vss.65.1655924375399; Wed, 22
 Jun 2022 11:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220614071650.206064-1-yuzhao@google.com> <CAOUHufbuqGJJ1pUJuYW8h6uB5+KpNSJotEd_WSzF5AK-S_6PoA@mail.gmail.com>
 <20220622114552.d878769ee7e3bc6a5240f430@linux-foundation.org>
In-Reply-To: <20220622114552.d878769ee7e3bc6a5240f430@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 22 Jun 2022 12:58:59 -0600
Message-ID: <CAOUHufZw3g4Fpntmwir_Hy5FR7=xvzKoOiA3R24FCW_=tfvUkg@mail.gmail.com>
Subject: Re: [PATCH v12 00/14] Multi-Gen LRU Framework
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
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

On Wed, Jun 22, 2022 at 12:46 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 22 Jun 2022 00:21:47 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > > TLDR
> > > ====
> > > The current page reclaim is too expensive in terms of CPU usage and it
> > > often makes poor choices about what to evict. This patchset offers an
> > > alternative solution that is performant, versatile and
> > > straightforward.
> >
> > I don't see any action items left for me. Are we good for the next merge window?
>
> Qi Zheng just found an item ;)

Well, an embarrassing one, and I hope it's the last one :)

> Yes, I'd like to get this in soon.  I've been waiting for the mapletree work
> to converge a bit further.

No worries. We are not in any rush, just planning ahead, since this
patchset has conflicts with Muchun's LRU page reparenting work [1].

[1] https://lore.kernel.org/linux-mm/20220621125658.64935-1-songmuchun@bytedance.com/
