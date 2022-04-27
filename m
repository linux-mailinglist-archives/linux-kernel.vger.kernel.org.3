Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E25E5110CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357945AbiD0GEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242834AbiD0GEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:04:35 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187F73FDBC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:01:25 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id 63so241372uaw.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eEenBPTT+A8NftOZwlTNAzvJdJr06gaMpQKvN58cBsM=;
        b=rB0CdeG5tjzYHEixLfnyBxBN8Py8g9fJZ/W8h2JVMHNdvkQi0/EHFiqOmCaacpuXFU
         628XUqXPgbnn7+t5QuJUsrZg0LS0BjRpKvOscPq6mLwMsr41GQdTFZiIRZmRxLrzsb7t
         uvwjkz4lksY9DHaFI2FD37wIh3fNKYVnM/qZpX2u6qfDLcCGqIpzO7YPwg8nfDpIxdJH
         dm14+oFOJdwhUJoom7iHvraVdDFnJTXC3IshjVIwoqTpyXHZno4TMfXJ9p98ndxMp3bU
         5WMIyH8nXzVUxgIPlTZ4F3VnO56QrYBo2felfbpX4PnzYDfDjf311D8Hgg8LcOQygVEK
         qH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eEenBPTT+A8NftOZwlTNAzvJdJr06gaMpQKvN58cBsM=;
        b=YzIjkMSgOwaGhHbkVw/3+jE8LYbmKiE60Q/A7L5b2MODdWnTew6ZpVmD8SVwAygYc+
         7D8Gm7MpXYZbbd50ieAEJA0sigtuAnNBCTbqxdRt5YdWbouPCfBgoTgRZEVOVwiixRD1
         lbGrRKi5l/w/o9fyjPXXAMZrJ3JWDnXhhUNbWLonqm3LSEl9GfwilGN7ACBJBkTQwOg0
         1ax6IABatSrWp21IbWHuOd1FUKVwJO+RCo8krH7eLNYTNx+xHPY93lo0CP+QD1Yum0FN
         UvL5lZRdsPBUCQua4GpEbe7gTNCy2UDN6H0fh50WYXGaXS3AV32USyx7SGmGbKw3fPDq
         fqxA==
X-Gm-Message-State: AOAM532jE99JDrcGHTMoi3FribdE3mBeM0MHOwKIOOUi71WRp5i2MusB
        2FLykQeV2gRPchvkcrwVvmXmWpbPMU3SNG4zSmbUnA==
X-Google-Smtp-Source: ABdhPJxgvGijbH7jxYuaIKjHR/e2sUn7feZnfqFOoKQXZ9QvO1ndFMrJOawwmWogeWkH02N9ILsUauEjnILfGArW+Qs=
X-Received: by 2002:ab0:77d5:0:b0:352:42d7:88c2 with SMTP id
 y21-20020ab077d5000000b0035242d788c2mr7891618uar.1.1651039283985; Tue, 26 Apr
 2022 23:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-8-yuzhao@google.com>
 <87zgk7xi13.fsf@linux.ibm.com> <CAOUHufbRLUg8274At8ZkUMUz2ghuGs52AvJsMkjQR=6-pusEhw@mail.gmail.com>
 <bab0d3f3-9f03-142c-7f53-86cb8cb178e4@linux.ibm.com>
In-Reply-To: <bab0d3f3-9f03-142c-7f53-86cb8cb178e4@linux.ibm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 27 Apr 2022 00:00:47 -0600
Message-ID: <CAOUHufah=yc7pucvWg83pymHX4+govxaYiLYDt7dHnGVTfJMQg@mail.gmail.com>
Subject: Re: [PATCH v10 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:31 PM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 4/27/22 10:08 AM, Yu Zhao wrote:
> > On Tue, Apr 26, 2022 at 10:33 PM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> Yu Zhao <yuzhao@google.com> writes:
> >>
> >> ....
> >>
> >>   diff --git a/mm/rmap.c b/mm/rmap.c
> >>> index fedb82371efe..7cb7ef29088a 100644
> >>> --- a/mm/rmap.c
> >>> +++ b/mm/rmap.c
> >>> @@ -73,6 +73,7 @@
> >>>   #include <linux/page_idle.h>
> >>>   #include <linux/memremap.h>
> >>>   #include <linux/userfaultfd_k.h>
> >>> +#include <linux/mm_inline.h>
> >>>
> >>>   #include <asm/tlbflush.h>
> >>>
> >>> @@ -821,6 +822,12 @@ static bool folio_referenced_one(struct folio *folio,
> >>>                }
> >>>
> >>>                if (pvmw.pte) {
> >>> +                     if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
> >>> +                         !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))) {
> >>> +                             lru_gen_look_around(&pvmw);
> >>> +                             referenced++;
> >>> +                     }
> >>
> >> Is it required to update referenced here? we do that below after
> >> clearing the young bit. Or is the goal to identify whether we found any
> >> young pte around?
> >
> > referenced++ is needed because lru_gen_look_around() also clears the
> > young bit in pvmw.pte. And ptep_clear_flush_young_notify() will return
> > false unless mmu notifier returns true.
>
> should we then use a mmu notifier variant of clear_young in
> lru_gen_look_around() ?

Generally multiple sets of page tables don't share the same memory
locality. E.g., for kvm, its secondary page tables map to guest
physical address space, whose locality is very different from typical
virtual address space. In this case lru_gen_look_around() is generally
not helpful. For this reason, we don't use the mmu notifier variants
of pte_young() or clear_young().
