Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4365423B6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389091AbiFHBFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382115AbiFGVqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:46:33 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EA4235B15
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:07:48 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id v19so500085uae.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s58JyYfxjJZK+xBks84yqht9lKqAP2iTqEYGVHfv2fA=;
        b=UniKPp2fwri4mGTTugBIeQ1NZBedToPyxhulFcbp+XWVAnwR5PUv5ooePbH/zWikdq
         6FaFxdOB4iEIsUrcTX9Qm4jCxkNTtmM6YKlPmKISkWBzbViQ2rTzilpDo+Iz9nowKLFJ
         WmejIqLXPDwqBVm9B+sGT+TwXPzscXlYaRIvkFA7RNeTqNgz7kP6U+d+Mi1FDaQt+MrA
         UiCKot2InqF/Xaqatw80AlYd7gtH10a85bDH2ZXIa0NKfAVKksTZaxf1/l+Yk1jbOveM
         MIAHxHTJmYsEMuYg4W58T1eg1cbE513Klo79bfZpVLgYtgZuYtoWI37VAmFSLRKiTWYb
         8MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s58JyYfxjJZK+xBks84yqht9lKqAP2iTqEYGVHfv2fA=;
        b=Yb+e1zPy6WnYS60dcR5dVcjHZRgb5Hy6rK7tdS9s99AMwM3lpA6hs1CoFdRBGgaNOg
         DNZ+wn39ifx3op7rt9gQEALr/E+tlMk1H6BrV59qH0IrcTy/2CgnnracGjoCX6YJdie6
         LmhDQdds1S7eX2hklESX8SkMn7gczoog5nhPzSWSUnf8+GPvEhzvuaj2vdJP0A8h7xqn
         Pncv6N1NM0GxxznPtmrqf4v/LW/niqBFXL9uFxdLTY/02duBEa7dPT1BcfGVGU/JbbSR
         e+GAN1/t/rx439fQogVORcoi/8hDeHQsV82Yp8fHeZ4G91NwLHXxEftWRp3JQGMzRXXE
         Frmw==
X-Gm-Message-State: AOAM5304KPlyL8LHLXjifa0DYyYpm5DcTbMK4iS//qmz28LNHKq0Yu4z
        t+kFcJgfP8ynSYl22vj4sOtpeq9gJKxjl1eAgE65tQ==
X-Google-Smtp-Source: ABdhPJzS0mtcx5OOOAWXsJb2eTSprTdFF5fKfwZ/5n8eY041PP99y8PgkVi5+GKdcmJEaZnwyH4Uqru8wQ1EJ+a7ziU=
X-Received: by 2002:ab0:2008:0:b0:352:2b3a:6bce with SMTP id
 v8-20020ab02008000000b003522b3a6bcemr37171732uak.19.1654628867656; Tue, 07
 Jun 2022 12:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220518014632.922072-1-yuzhao@google.com> <20220518014632.922072-8-yuzhao@google.com>
 <CAGsJ_4yboZEY9OfyujPxBa_AEuGM3OAq5y_L9gvzSMUv70BxeQ@mail.gmail.com> <CAGsJ_4w3S_8Kaw2GyB3hg7b4N_D+6yBO7D6qmgxD9Fqz3_dhAg@mail.gmail.com>
In-Reply-To: <CAGsJ_4w3S_8Kaw2GyB3hg7b4N_D+6yBO7D6qmgxD9Fqz3_dhAg@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 7 Jun 2022 13:07:11 -0600
Message-ID: <CAOUHufbi7h6siHdnhsAEiXaCoNrUs9bUnEihYouE4CNMt-Zd_w@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] mm: multi-gen LRU: exploit locality in rmap
To:     Barry Song <21cnbao@gmail.com>
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

On Tue, Jun 7, 2022 at 1:37 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Mon, Jun 6, 2022 at 9:25 PM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Wed, May 18, 2022 at 4:49 PM Yu Zhao <yuzhao@google.com> wrote:

...

> I can't really explain why we are getting a random app/java vm crash in monkey
> test by using ptep_test_and_clear_young() only in lru_gen_look_around() on an
> armv8-a machine without hardware PTE young support.
>
> Moving to  ptep_clear_flush_young() in look_around can make the random
> hang disappear according to zhanyuan(Cc-ed).

This sounds too familiar -- let me ask again: was the following commit
included during the test?

  07509e10dcc7 arm64: pgtable: Fix pte_accessible()

If not, it will cause exactly the problem you described. And what
about this one?

  e914d8f00391 mm: fix unexpected zeroed page mapping with zram swap

Missing it also causes userspace memory corruption on Android, i.e.,
random app crashes.

> On x86, ptep_clear_flush_young() is exactly ptep_test_and_clear_young()
> after
>  'commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case clear
> the accessed bit instead of flushing the TLB")'
>
> But on arm64, they are different. according to Will's comments in this
> thread which
> tried to make arm64 same with x86,
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1793881.html
>
> "
> This is blindly copied from x86 and isn't true for us: we don't invalidate
> the TLB on context switch. That means our window for keeping the stale
> entries around is potentially much bigger and might not be a great idea.
>
> If we roll a TLB invalidation routine without the trailing DSB, what sort of
> performance does that get you?
> "
> We shouldn't think ptep_clear_flush_young() is safe enough in LRU to
> clear PTE young? Any comments from Will?
>
> >
> > btw, lru_gen_look_around() has already included 'address', are we doing
> > pte check for 'address' twice here?

Explained in the previous reply. Hope that clarifies things.
