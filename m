Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0843F4C23A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 06:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiBXFgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 00:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiBXFgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:36:14 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1162F25291A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:35:45 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id i27so992983vsr.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 21:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WWHAhC2u3Yrav5+xOTI+5uI30EbKHXrJLx3B/cdCfE=;
        b=Zxw1fP3eRF14/jcI7VdenJgTzhXoypJ0ib3zhRFpIbjr+wVwCNg00v65TATB+HmKJE
         rP9UfsVJh8JfLsEVwK4A9eJWX0+CBWbIzGbgfnidODFWuQaMxX8+rpw36HVTrxbu27Ya
         zbiuaqp2AkVJNKnUoeKihalnYmkzKCCEccK8PWmEk22e/TfJRCRepHNWgG+tsPunMO+5
         DVOs99aUGm2CmZiTWtAx181idOX7NmLagvg69pR2ltDgKcTLxB1lUNNBIKipRviWXene
         yaRA6r3iGGGbwHFKSSPbpkCp+7V9T2tjotbYrVNcWxfzHyeIAWZVoRB7Sq3jCml7lAIk
         xZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WWHAhC2u3Yrav5+xOTI+5uI30EbKHXrJLx3B/cdCfE=;
        b=bQSYn36Eu887BrZcPgZm2U9ncHVrKSQ/G0mIxTX2oeXnUYIoDkX8Ihy7GQkPvyDD59
         +t9Ya8zsyMCnlW1wWXQMQwIjmJmjvWh0xW7Nbkv8O4bIrQQRApQmdohDKRgy6UPMxIlG
         8ae7gBk1/Vohsm9WatAUua7hLGKo8vPvcOdDW7g17gsc0vdPuFOGacF8zou1Wjc241yD
         lsc0SSNtwTVK4JZuvhInCMSDQWIbq6v20OOgpkEJDnqBujgpLLlZd26ysZo93fUJW8W8
         rX/cA452o+sYcMN3gpg6dLBnF4SP/Jq6v+8EFr45o7X/bkjLopA8jX8i8jy0at303gvH
         /PgQ==
X-Gm-Message-State: AOAM532+/jJpVnTHtHOVDWoZk1tYg2MYhQhdoHccoWd3lSCOjbjHV8ME
        DESQvz3Y11WR3w2I+4SjtXIwH/PCdVhBacBTCeyVbw==
X-Google-Smtp-Source: ABdhPJzIv19ZFkAGm9a7wUFfoCm24bkgs4miWsRzSszOLijZZHRHI4Zo6Ve/+i4RNDZIH9qICVbvebwjNoUYss5qmcg=
X-Received: by 2002:a05:6102:2914:b0:31b:b756:7950 with SMTP id
 cz20-20020a056102291400b0031bb7567950mr396078vsb.41.1645680944016; Wed, 23
 Feb 2022 21:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com> <20220208081902.3550911-6-yuzhao@google.com>
 <87bkyy56nv.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAOUHufbekcu09DyEZAkJNRq_1qKaf_xibXQNeAVK=rsGBn9Z4Q@mail.gmail.com>
 <87y2213wrl.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAOUHufY8dRimricP=pvvgg8mEagb369nE8MVe6tnnLXQuKyAEA@mail.gmail.com>
 <87h78p3pp2.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAOUHufYgNr-82AsfGFu6DVOsVUdmVsOo2Jav3nHDXiuu6iDC9A@mail.gmail.com>
 <87a6eg4ywq.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87a6eg4ywq.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 23 Feb 2022 22:35:32 -0700
Message-ID: <CAOUHufY9h2K4dPnufW-uD-EEuvROf6y7cF-w1gJ2VAFaSEDD7Q@mail.gmail.com>
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

On Wed, Feb 23, 2022 at 10:27 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yu Zhao <yuzhao@google.com> writes:
>
> > On Wed, Feb 23, 2022 at 8:32 PM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Yu Zhao <yuzhao@google.com> writes:
> >>
> >> > On Wed, Feb 23, 2022 at 5:59 PM Huang, Ying <ying.huang@intel.com> wrote:
> >> >>
> >> >> Yu Zhao <yuzhao@google.com> writes:
> >> >>
> >> >> > On Wed, Feb 23, 2022 at 1:28 AM Huang, Ying <ying.huang@intel.com> wrote:
> >> >> >>
> >> >> >> Hi, Yu,
> >> >> >>
> >> >> >> Yu Zhao <yuzhao@google.com> writes:
> >> >> >>
> >> >> >> > To avoid confusions, the terms "promotion" and "demotion" will be
> >> >> >> > applied to the multigenerational LRU, as a new convention; the terms
> >> >> >> > "activation" and "deactivation" will be applied to the active/inactive
> >> >> >> > LRU, as usual.
> >> >> >>
> >> >> >> In the memory tiering related commits and patchset, for example as follows,
> >> >> >>
> >> >> >> commit 668e4147d8850df32ca41e28f52c146025ca45c6
> >> >> >> Author: Yang Shi <yang.shi@linux.alibaba.com>
> >> >> >> Date:   Thu Sep 2 14:59:19 2021 -0700
> >> >> >>
> >> >> >>     mm/vmscan: add page demotion counter
> >> >> >>
> >> >> >> https://lore.kernel.org/linux-mm/20220221084529.1052339-1-ying.huang@intel.com/
> >> >> >>
> >> >> >> "demote" and "promote" is used for migrating pages between different
> >> >> >> types of memory.  Is it better for us to avoid overloading these words
> >> >> >> too much to avoid the possible confusion?
> >> >> >
> >> >> > Given that LRU and migration are usually different contexts, I think
> >> >> > we'd be fine, unless we want a third pair of terms.
> >> >>
> >> >> This is true before memory tiering is introduced.  In systems with
> >> >> multiple types memory (called memory tiering), LRU is used to identify
> >> >> pages to be migrated to the slow memory node.  Please take a look at
> >> >> can_demote(), which is called in shrink_page_list().
> >> >
> >> > This sounds clearly two contexts to me. Promotion/demotion (move
> >> > between generations) while pages are on LRU; or promotion/demotion
> >> > (migration between nodes) after pages are taken off LRU.
> >> >
> >> > Note that promotion/demotion are not used in function names. They are
> >> > used to describe how MGLRU works, in comparison with the
> >> > active/inactive LRU. Memory tiering is not within this context.
> >>
> >> Because we have used pgdemote_* in /proc/vmstat, "demotion_enabled" in
> >> /sys/kernel/mm/numa, and will use pgpromote_* in /proc/vmstat.  It seems
> >> better to avoid to use promote/demote directly for MGLRU in ABI.  A
> >> possible solution is to use "mglru" and "promote/demote" together (such
> >> as "mglru_promote_*" when it is needed?
> >
> > *If* it is needed. Currently there are no such plans.
>
> OK.
>
> >> >> >> > +static int get_swappiness(struct mem_cgroup *memcg)
> >> >> >> > +{
> >> >> >> > +     return mem_cgroup_get_nr_swap_pages(memcg) >= MIN_LRU_BATCH ?
> >> >> >> > +            mem_cgroup_swappiness(memcg) : 0;
> >> >> >> > +}
> >> >> >>
> >> >> >> After we introduced demotion support in Linux kernel.  The anonymous
> >> >> >> pages in the fast memory node could be demoted to the slow memory node
> >> >> >> via the page reclaiming mechanism as in the following commit.  Can you
> >> >> >> consider that too?
> >> >> >
> >> >> > Sure. How do I check whether there is still space on the slow node?
> >> >>
> >> >> You can always check the watermark of the slow node.  But now, we
> >> >> actually don't check that (as in demote_page_list()), instead we will
> >> >> wake up kswapd of the slow node.  The intended behavior is something
> >> >> like,
> >> >>
> >> >>   DRAM -> PMEM -> disk
> >> >
> >> > I'll look into this later -- for now, it's a low priority because
> >> > there isn't much demand. I'll bump it up if anybody is interested in
> >> > giving it a try. Meanwhile, please feel free to cook up something if
> >> > you are interested.
> >>
> >> When we introduce a new feature, we shouldn't break an existing one.
> >> That is, not introducing regression.  I think that it is a rule?
> >>
> >> If my understanding were correct, MGLRU will ignore to scan anonymous
> >> page list even if there's demotion target for the node.  This breaks the
> >> demotion feature in the upstream kernel.  Right?
> >
> > I'm not saying this shouldn't be fixed. I'm saying it's a low priority
> > until somebody is interested in using/testing it (or making it work).
>
> We are interested in this feature and can help to test it.

That's great. I'll make sure it works in the next version.
