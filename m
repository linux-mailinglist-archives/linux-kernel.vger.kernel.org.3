Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F316542960
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiFHIXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiFHIVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:21:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2261C3AE80D;
        Wed,  8 Jun 2022 00:48:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id kq6so26719595ejb.11;
        Wed, 08 Jun 2022 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kXkJZDN5f41vCkZwW8ZE7hb5zQfmu2jYPyBC+wVy0V8=;
        b=eNf6oOTDd4otQkXVR6HRhBsozVbIZwZyj++kC1qQELl8tphSLEM/Hu7EmLxoB3GLLo
         mKqHWgCo7DltiHf+Z0vuFYCL3ghZSenJBKEylJBKWkgx2ZZ//nPKQUEtVIFDBJnwsK1u
         14uL/3oKR+8p+woV2hkpDEFVK7PrNRfZNr7YXGN0GJTFMxksR2wV/9vlyQ+Ec7zTivEN
         q0s3MfmTZy6AC9GeJtv6VZfz8wmBxvsHmXZmYzWKXVyWdbhuaKpHghNzNV8f8YiQhGrU
         pZ2k6A5QDSe+DeMhczhQAGKEqlntx/szER82q86xUWbNSbpJLGXHG5LyxviMC0DflYu/
         2ZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kXkJZDN5f41vCkZwW8ZE7hb5zQfmu2jYPyBC+wVy0V8=;
        b=PoFTrtMQw56ILqDotyYIc8djACfQ7gjhRsFHAe6943ewmWy/KxQlJ5+vpfvL/hpTFm
         gHdLO2mkh9i7VVz8hhO9FbM2mTOE47tWvPUArB3bQazA0Gcxs04CYg7fJZ1yY68JbdEi
         MleaVyzK59X0YphWxe/XTe49yyS8oXiCfx4caRBUzXMjQQfIFMYG+U9+StgEj253Aamt
         vsq+7F+90tjFYNUO5WXz08RmX8+Af0HVt0hSeQSKcNPvKJ3mdO9LI5ZI6YH/eAYr3/Jc
         aBzGQrjGh9OZ3/yLu5dLV1tY3awcuJA6zIfwCxAsWyAgMX0BZMvTg3xmSnYWPlXfmIan
         GHvw==
X-Gm-Message-State: AOAM531CeE9Wo2qSFasqSlV+astsgGn7rpouDEV78kIPBtbGn23BSFvM
        /u7JY6LHOhfrtLZIQnM+uOiWfKzqvBAzyTYdgTY=
X-Google-Smtp-Source: ABdhPJxSeTe7VJehA0LRTPFttB6Zx5E5UjOZxX/dzRtWP2rBcx1ZeTzlRRrljEuS9xzqsTj0W3eVnJ09RbifGzFqMlI=
X-Received: by 2002:a17:907:a0c8:b0:711:d82a:1caa with SMTP id
 hw8-20020a170907a0c800b00711d82a1caamr10971990ejc.702.1654674508479; Wed, 08
 Jun 2022 00:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com> <20220518014632.922072-8-yuzhao@google.com>
 <CAGsJ_4yboZEY9OfyujPxBa_AEuGM3OAq5y_L9gvzSMUv70BxeQ@mail.gmail.com>
 <CAGsJ_4w3S_8Kaw2GyB3hg7b4N_D+6yBO7D6qmgxD9Fqz3_dhAg@mail.gmail.com> <CAOUHufbi7h6siHdnhsAEiXaCoNrUs9bUnEihYouE4CNMt-Zd_w@mail.gmail.com>
In-Reply-To: <CAOUHufbi7h6siHdnhsAEiXaCoNrUs9bUnEihYouE4CNMt-Zd_w@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 8 Jun 2022 19:48:17 +1200
Message-ID: <CAGsJ_4w6JjuG4rn2P=d974wBOUtXUUnaZKnx+-G6a8_mSROa+Q@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Yu Zhao <yuzhao@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
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
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
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
        Vaibhav Jain <vaibhav@linux.ibm.com>, huzhanyuan@oppo.com
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

On Wed, Jun 8, 2022 at 7:07 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Jun 7, 2022 at 1:37 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Mon, Jun 6, 2022 at 9:25 PM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > On Wed, May 18, 2022 at 4:49 PM Yu Zhao <yuzhao@google.com> wrote:
>
> ...
>
> > I can't really explain why we are getting a random app/java vm crash in monkey
> > test by using ptep_test_and_clear_young() only in lru_gen_look_around() on an
> > armv8-a machine without hardware PTE young support.
> >
> > Moving to  ptep_clear_flush_young() in look_around can make the random
> > hang disappear according to zhanyuan(Cc-ed).
>
> This sounds too familiar -- let me ask again: was the following commit
> included during the test?
>
>   07509e10dcc7 arm64: pgtable: Fix pte_accessible()
>
> If not, it will cause exactly the problem you described. And what
> about this one?
>
>   e914d8f00391 mm: fix unexpected zeroed page mapping with zram swap
>
> Missing it also causes userspace memory corruption on Android, i.e.,
> random app crashes.
>

According to zhanyuan's testing, we can confirm the above two commits
can fix the random android crash.

Thanks
Barry
