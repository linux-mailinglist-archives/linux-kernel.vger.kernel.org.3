Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F8048A322
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbiAJWqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241804AbiAJWqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:46:21 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18D4C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:46:20 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v186so32890237ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5qkKtUf3/Jnf7wpdOz0Xh2yFMKXSW/sTaG3G712SbQ=;
        b=SjnpnEALOldZ8tn00n34ElbrYt1DPG+JNtAHD3AZJpnKEic28JdHPe0PNv5IzRhc6d
         ySeagT3YWicTbugkiWZaUOHZL6IMbQqX0JxQI2xII3QDUsDbGvur8SNPRUHGrlAVz6fn
         YbVI9LN9nQRb8viYs87kBSYZwT95I7l0DU/pfjYJ3vBhdc+46EYFJyos+c/HKVp/KmL0
         dJ8NR4zSCRNsS4RiRxm0r1v3Hiw5XidgLY2XpCm8xJqSCbfyc4tCxhb5l3dklCjm1h4F
         RlzbM4lYYCAT2ZOuoFVFOQBIVp5zT056mudLnVzfzaL76VxhQBkyYpWrHHoGJqjv+sdY
         E1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5qkKtUf3/Jnf7wpdOz0Xh2yFMKXSW/sTaG3G712SbQ=;
        b=xr84mk5zEyAbXlVvcArrmSc/6NSDlNGtjcUo/oEzLs7gODcycUyttTjgRoHv08NmQ+
         j5AFsJM3XnaJCI242arCxAe3wZ0YCCl9Mwog4hKTU1ufMns/AGdkbOcs3XgTn9fcInkM
         a6jJxINEFEq16O7VZ0y04ykKtoXtgKNSixhDrPprjudGaZwdHyIBmbEsqCCYVL+RWszg
         heCRqR0IWNndutUu6JByrZ4qTf6TW81MOqo8CY1LzAPCE6KCwkx20fiuZbuYYUCa9HRb
         NLF3nnto70TstwoLvOO/NW0EH6Rbed+vJQrFoG5ZvzmGc24JYQgP8YVJPqNYJwQTZ94G
         3PGg==
X-Gm-Message-State: AOAM530dPE8m3kYrJOR4D3ILapeq4OndiVWLuimWGick09ufXrHPdNL1
        ez5+8qO9lzOUnsgLuOxU9SkVS2hwuzn55MoCTbljnQ==
X-Google-Smtp-Source: ABdhPJzcA80LuZntquZycqwJyoSvafg6S1c2pXeqRP1eh45uusRDbKp5mXTGhMYH+yIg5oEgy7qcYRLDHaFcVIGo3WY=
X-Received: by 2002:a05:6902:287:: with SMTP id v7mr2345980ybh.501.1641854779730;
 Mon, 10 Jan 2022 14:46:19 -0800 (PST)
MIME-Version: 1.0
References: <20220104202227.2903605-1-yuzhao@google.com> <YdSuSHa/Vjl6bPkg@google.com>
 <YdgKClGAuHlkzVbQ@dhcp22.suse.cz> <YdiKVJlClB3h1Kmg@google.com>
 <YdxTR4+FL08XyFuO@dhcp22.suse.cz> <YdythmxHpSksJiXs@google.com>
In-Reply-To: <YdythmxHpSksJiXs@google.com>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Mon, 10 Jan 2022 14:46:08 -0800
Message-ID: <CAJmaN=n=kn9-gC8if5wp8Gfj7uN+QVrX0ex=9JPXC7rPvGf1Qg@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
To:     Yu Zhao <yuzhao@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, page-reclaim@google.com,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 2. There have been none that came with the testing/benchmarking
> > >    coverage as this one did. Please point me to some if I'm mistaken,
> > >    and I'll gladly match them.
> >
> > I do appreciate your numbers but you should realize that this is an area
> > that is really hard to get any conclusive testing for.
>
> Fully agreed. That's why we started a new initiative, and we hope more
> people will following these practices:
> 1. All results in this area should be reported with at least standard
>    deviations, or preferably confidence intervals.
> 2. Real applications should be benchmarked (with synthetic load
>    generator), not just synthetic benchmarks (not real applications).
> 3. A wide range of devices should be covered, i.e., servers, desktops,
>    laptops and phones.
>
> I'm very confident to say our benchmark reports were hold to the
> highest standards. We have worked with MariaDB (company), EnterpriseDB
> (Postgres), Redis (company), etc. on these reports. They have copies
> of these reports (PDF version):
> https://linux-mm.googlesource.com/benchmarks/
>
> We welcome any expert in those applications to examine our reports,
> and we'll be happy to run any other benchmarks or same benchmarks with
> different configurations that anybody thinks it's important and we've
> missed.

I really think this gets at the heart of the issue with mm
development, and is one of the reasons it's been extra frustrating to
not have an MM conf for the past couple of years; I think sorting out
how we measure & proceed on changes would be easier done f2f.  E.g.
concluding with a consensus that if something doesn't regress on X, Y,
and Z, and has reasonably maintainable and readable code, we should
merge it and try it out.

But since f2f isn't an option until 2052 at the earliest...

I understand the desire for an "incremental approach that gets us from
A->B".  In the abstract it sounds great.  However, with a change like
this one, I think it's highly likely that such a path would be
littered with regressions both large and small, and would probably be
more difficult to reason about than the relatively clean design of
MGLRU.  On top of that, I don't think we'll get the kind of user
feedback we need for something like this *without* merging it.  Yu has
done a tremendous job collecting data here (and the results are really
incredible), but I think we can all agree that without extensive
testing in the field with all sorts of weird codes, we're not going to
find the problematic behaviors we're concerned about.

So unless we want to eschew big mm changes entirely (we shouldn't!
look at net or scheduling for how important big rewrites are to
progress), I think we should be open to experimenting with new stuff.
We can always revert if things get too unwieldy.

None of this is to say that there may not be lots more comments on the
code or potential fixes/changes to incorporate before merging; I'm
mainly arguing about the mindset we should have to changes like this,
not all the stuff the community is already really good at (i.e.
testing and reviewing code on a nuts & bolts level).

Thanks,
Jesse
