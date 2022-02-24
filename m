Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA74C210F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiBXBfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiBXBfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:35:14 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291F013AA0E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:34:46 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id p33so182276uap.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlTEvCMe8gLH8mkJngq0jMMrhF4Rb9J1L2FbOtnoMeA=;
        b=sjYQXiAaTh8Pan58Dwbpxw8kVwXQt1oAtAF/M0W1jQ6kHv5MlMXbLhguJMlVQsz2mt
         4eif8qTqHSAlzgJNMnMyUMVZy0186FJfeZP8a5XgyewuzQB8LgrY2v/VlIIxYnS5Tvw1
         ahrvsWzDtvSalYitjQ/o/WowcaihqDCzMk82kA52tuXXN6+6QBx7m2q3ulEvMJ16uYEz
         V5ZujsVnuN04sVmFL0PQPdCxfh/nwn5+yzc7DL6LoS+q3O+BFjnSOUMS2VOf/ZURdy8K
         DDwVwm1IctjAuB6SKRa1QT3xdSHHJFY0rf7QFg88fopcFzkRII9LEpXSGdwirgd0ndLd
         SQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlTEvCMe8gLH8mkJngq0jMMrhF4Rb9J1L2FbOtnoMeA=;
        b=hrZESqKqo3SwLOuVrBf9DxSrDZaCemeKOyfWuAaeSYyc/YNTKsmUgtok3QZWatGTH9
         UOanXRGEim1aMWxjZd5sMsuXvxWAgd5xd0cZjD+aEOKwdHC+IzablubwN9WpwLbmXCRp
         8B64Gt4C3To2pocJAyUcL7EV4j7hxQXtnB5wr0g5S7zcUTJC6VuK6mQRAm7Jm9WZaaJv
         jDXtVvLKiy4uVoKVLQkKQj/419KrMJqM69MzjZkCa0sj8r1dGFBk6Yt7kX3np85vf2+o
         ChAVn8ZEu/3G2uuxJYpH8jNKDjtKbL3rV8LOFdhxsLKBrWghkM/MWobVSLAa7JXO0LV7
         8C/w==
X-Gm-Message-State: AOAM532xBxxSgzukwflnGM9rTDp265+UTC0SVWgQEBt0aP2geA0hokRQ
        oQpQDy6LA8hIN882fiwvlb+83vv/IJHOKFvIWpOaLg==
X-Google-Smtp-Source: ABdhPJxBaf8RnByOCleoWZEZPun+AOvuwypSAyh6/fwhiM94QTJdh8bQ3/HbbFgUPiAM6IdBkr8T8WRot1ZydwqPvVI=
X-Received: by 2002:ab0:2111:0:b0:341:8339:51b4 with SMTP id
 d17-20020ab02111000000b00341833951b4mr162619ual.76.1645666485123; Wed, 23 Feb
 2022 17:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20220208081902.3550911-1-yuzhao@google.com> <20220208081902.3550911-6-yuzhao@google.com>
 <87bkyy56nv.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAOUHufbekcu09DyEZAkJNRq_1qKaf_xibXQNeAVK=rsGBn9Z4Q@mail.gmail.com>
 <87y2213wrl.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87y2213wrl.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 23 Feb 2022 18:34:33 -0700
Message-ID: <CAOUHufY8dRimricP=pvvgg8mEagb369nE8MVe6tnnLXQuKyAEA@mail.gmail.com>
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

On Wed, Feb 23, 2022 at 5:59 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yu Zhao <yuzhao@google.com> writes:
>
> > On Wed, Feb 23, 2022 at 1:28 AM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Hi, Yu,
> >>
> >> Yu Zhao <yuzhao@google.com> writes:
> >>
> >> > To avoid confusions, the terms "promotion" and "demotion" will be
> >> > applied to the multigenerational LRU, as a new convention; the terms
> >> > "activation" and "deactivation" will be applied to the active/inactive
> >> > LRU, as usual.
> >>
> >> In the memory tiering related commits and patchset, for example as follows,
> >>
> >> commit 668e4147d8850df32ca41e28f52c146025ca45c6
> >> Author: Yang Shi <yang.shi@linux.alibaba.com>
> >> Date:   Thu Sep 2 14:59:19 2021 -0700
> >>
> >>     mm/vmscan: add page demotion counter
> >>
> >> https://lore.kernel.org/linux-mm/20220221084529.1052339-1-ying.huang@intel.com/
> >>
> >> "demote" and "promote" is used for migrating pages between different
> >> types of memory.  Is it better for us to avoid overloading these words
> >> too much to avoid the possible confusion?
> >
> > Given that LRU and migration are usually different contexts, I think
> > we'd be fine, unless we want a third pair of terms.
>
> This is true before memory tiering is introduced.  In systems with
> multiple types memory (called memory tiering), LRU is used to identify
> pages to be migrated to the slow memory node.  Please take a look at
> can_demote(), which is called in shrink_page_list().

This sounds clearly two contexts to me. Promotion/demotion (move
between generations) while pages are on LRU; or promotion/demotion
(migration between nodes) after pages are taken off LRU.

Note that promotion/demotion are not used in function names. They are
used to describe how MGLRU works, in comparison with the
active/inactive LRU. Memory tiering is not within this context.

> >> > +static int get_swappiness(struct mem_cgroup *memcg)
> >> > +{
> >> > +     return mem_cgroup_get_nr_swap_pages(memcg) >= MIN_LRU_BATCH ?
> >> > +            mem_cgroup_swappiness(memcg) : 0;
> >> > +}
> >>
> >> After we introduced demotion support in Linux kernel.  The anonymous
> >> pages in the fast memory node could be demoted to the slow memory node
> >> via the page reclaiming mechanism as in the following commit.  Can you
> >> consider that too?
> >
> > Sure. How do I check whether there is still space on the slow node?
>
> You can always check the watermark of the slow node.  But now, we
> actually don't check that (as in demote_page_list()), instead we will
> wake up kswapd of the slow node.  The intended behavior is something
> like,
>
>   DRAM -> PMEM -> disk

I'll look into this later -- for now, it's a low priority because
there isn't much demand. I'll bump it up if anybody is interested in
giving it a try. Meanwhile, please feel free to cook up something if
you are interested.
