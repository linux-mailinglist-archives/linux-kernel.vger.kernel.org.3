Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C024D6A42
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiCKXDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiCKXDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:03:08 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16228248CCE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:58:10 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id j9so5460422vkj.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3INdYjmD9sI3AAGt1tE2s/Am9WLmWC+N03DHnuY4rE8=;
        b=BMA7qz0hmDXjgLAj/07b1iUaF7Hpsjn69duyTb+GziOeEl6FfVlZDbJDnlOKFb5OxL
         993gwyQ2uOEj3GwTJER0T9zTHJQ6k2YiGQTupxTGAeMkt/rxQ8SU7B9al7D4z9jq+inU
         xbnrI77JFap8h53TWHjivFVxM/5MoRxNBSh2yX54H67Yp6YZMsQAViCyWkISwhr/YT+i
         mF5wyHwgkInp+C4d5kf++Um69oOINKpvHpy1b28ckD6Y+qNFCGvwWa9cJ9efFbon6Epm
         qL/hHNgx/Su35VLn9pfl0NE6jHYctKc0W1IDlZ6EMyJaDiqCHBSVDl5l8Gtv573d3IuH
         NkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3INdYjmD9sI3AAGt1tE2s/Am9WLmWC+N03DHnuY4rE8=;
        b=599/SR7FDKKFxqlFxEG6pSOe1nhklmmwBRT2aq3aG5SQveO8ACX4EeWkc8TCIb7n+h
         NJIyA57CFfhS9n9Fr0Qh9Gbi+AkvtcLLsORdfqOKAKiTSAXKnY47ggV1GXP8kZiTZ5Zw
         YQmMugCHZf+bpOMJB+bj6xOg9mCeypATLd+TocMmtQCpdQ6xr2Xo9QBZ0S68obURGAb0
         aauw3lNaZjdpC81ABYWlq4YEkwWXJTFKbAchTGGNSYWeBzpnrXNi3QxiyGhTMz8fJ3BS
         wRQU66rO3KwVPlFQH+8CQF46lBE9w1CBZiZiECiwe5566yVbAs0QOEamWNPAkBKGVLOI
         Bj/w==
X-Gm-Message-State: AOAM530v7Ds5/LHz25GFz5DwRyjzeOtTv6lo68xQsCUijJt+NSSqP6Hx
        wCOjIQsO+3HbXh0rYUhCsPSRUGHDb17D6QCJjzNc/g==
X-Google-Smtp-Source: ABdhPJwGpXBfC5BGWFXcbt51OotnQdLdCIZrxqrjphxJw0BNDdEab0gCbm4RnWAIGbVNilKBQ/CyJES1Xl9HPBWgrnk=
X-Received: by 2002:a05:6122:2089:b0:337:bb38:9145 with SMTP id
 i9-20020a056122208900b00337bb389145mr5955292vkd.14.1647039488964; Fri, 11 Mar
 2022 14:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-2-yuzhao@google.com>
 <CAGsJ_4yt_q4=pPW1M6fHN9HrV5JuTo9_9GQ0wv4-VT7tivU1+Q@mail.gmail.com>
In-Reply-To: <CAGsJ_4yt_q4=pPW1M6fHN9HrV5JuTo9_9GQ0wv4-VT7tivU1+Q@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 11 Mar 2022 15:57:57 -0700
Message-ID: <CAOUHufZy+3+0zWTpAr8wJkWeQ4c4b9msiuWWu0XK=_aedqB=8w@mail.gmail.com>
Subject: Re: [PATCH v9 01/14] mm: x86, arm64: add arch_has_hw_pte_young()
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
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 11, 2022 at 3:55 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Wed, Mar 9, 2022 at 3:47 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > Some architectures automatically set the accessed bit in PTEs, e.g.,
> > x86 and arm64 v8.2. On architectures that do not have this capability,
> > clearing the accessed bit in a PTE usually triggers a page fault
> > following the TLB miss of this PTE (to emulate the accessed bit).
> >
> > Being aware of this capability can help make better decisions, e.g.,
> > whether to spread the work out over a period of time to reduce bursty
> > page faults when trying to clear the accessed bit in many PTEs.
> >
> > Note that theoretically this capability can be unreliable, e.g.,
> > hotplugged CPUs might be different from builtin ones. Therefore it
> > should not be used in architecture-independent code that involves
> > correctness, e.g., to determine whether TLB flushes are required (in
> > combination with the accessed bit).
> >
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > Acked-by: Brian Geffon <bgeffon@google.com>
> > Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> > Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Acked-by: Steven Barrett <steven@liquorix.net>
> > Acked-by: Suleiman Souhlal <suleiman@google.com>
> > Acked-by: Will Deacon <will@kernel.org>
> > Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> > Tested-by: Donald Carr <d@chaos-reins.com>
> > Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> > Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> > Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> > Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> > Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > ---
>
> Reviewed-by: Barry Song <baohua@kernel.org>

Thanks.

> i guess arch_has_hw_pte_young() isn't called that often in either
> mm/memory.c or mm/vmscan.c.
> Otherwise, moving to a static key might help. Is it?

MRS shouldn't be slower than either branch of a static key. With a
static key, we only can optimize one of the two cases.

There is a *theoretical* problem with MRS: ARM specs don't prohibit a
physical CPU to support both cases (on different logical CPUs).
