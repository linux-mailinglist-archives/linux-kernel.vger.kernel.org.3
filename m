Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCCB49F5B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347460AbiA1IyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243447AbiA1IyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:54:22 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F1BC061714;
        Fri, 28 Jan 2022 00:54:21 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id s5so13744797ejx.2;
        Fri, 28 Jan 2022 00:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mfa0O3qu1wZcHEBOXT6AY/+zf9YLw7v0iaKsWN6BE6k=;
        b=gahkIPkUCispjnbwyFW7qCQKJs7V6/Suv2KYfgacpg0HMhWtTQM92L+zPmt+PUeGyD
         o6CCE6udcmlCzmeL4RDLgs2RnpngD47kIt3SEZAQJqHYQdpEQ5FsmhSttjAadVHcNrXg
         bbuECXUl2iSnmGVy5qeiU6Wp6OEWZraXLLKmq6I97Lh2oElZxvTcFf3BVaoElaYQGN47
         ZGESroIum1IM1u8AfGbmIY+j/WkOl+2nCZaZxvosiOla5eskc9HPibW5xPMNOLlT4XdJ
         Fut/zz93mAXb9E88TFLtscbQiZ3Ma7iKbYmzgoAsiAnrggm4w9Df9azAwmxUFU6+tPEE
         nOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mfa0O3qu1wZcHEBOXT6AY/+zf9YLw7v0iaKsWN6BE6k=;
        b=sfo/VxSS9dh02M20ViEvmDFyriHVlVcyG+6V7fMLq4qboonuew1K4J07uULVc1LV41
         DRVffgyzsLXx1oqE/BXMSdeFdMWZSCVArrey/ZNWs+JecKhADZRmGQAatjtyTzwEGJ5N
         vmKo9QwVr3BngEnk1V7/HO5BrV/3OsqldwVl1Iftm6CCJbUgBjcHaANIGEpR1f7ioE/d
         A+jWJSnCQU5vjgX3I3C14kPvXO34hCYEk3j3fnFeiJZN2wJACatI9ChvcoPgE3k04sHh
         7OYkDZn4MSKzjlOXsGzGxC5/npdcfJgXQJYQjKAsR6o+VCJrwiQkdnJMWy8YayZc+BJa
         H7fQ==
X-Gm-Message-State: AOAM531tSZMVpVrQYfVi0Cmgf6ifU19BLCq9WAI3ypG2iRF5iiHC8RcN
        XtnrF6UC9HFo2HA0oZOYa+OmqzPRIAqCalcHGuc=
X-Google-Smtp-Source: ABdhPJwDVqEdoKYA0/xCVZ9gS/VecyzMcDN47USHcFNSAdkfiUFOOZIl07e7Qubt4Pk2xiAS5KMkMuLmi5+7XiJmOLc=
X-Received: by 2002:a17:907:72c3:: with SMTP id du3mr6192984ejc.457.1643360060307;
 Fri, 28 Jan 2022 00:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20220104202227.2903605-1-yuzhao@google.com> <CAGsJ_4zULJ5vPwn73Z5Bap3eRkAX+Yv24c-n41+zC7fN8xG60g@mail.gmail.com>
 <Ye+dPmO17JN2bNLL@google.com>
In-Reply-To: <Ye+dPmO17JN2bNLL@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 28 Jan 2022 21:54:09 +1300
Message-ID: <CAGsJ_4w5GM5r916XEz+gj=33A+b98kyJONLNpEnBMmX5XnPRmg@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
To:     Yu Zhao <yuzhao@google.com>
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
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, page-reclaim@google.com,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 7:48 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Sun, Jan 23, 2022 at 06:43:06PM +1300, Barry Song wrote:
> > On Wed, Jan 5, 2022 at 7:17 PM Yu Zhao <yuzhao@google.com> wrote:
>
> <snipped>
>
> > > Large-scale deployments
> > > -----------------------
> > > We've rolled out MGLRU to tens of millions of Chrome OS users and
> > > about a million Android users. Google's fleetwide profiling [13] show=
s
> > > an overall 40% decrease in kswapd CPU usage, in addition to
> >
> > Hi Yu,
> >
> > Was the overall 40% decrease of kswap CPU usgae seen on x86 or arm64?
> > And I am curious how much we are taking advantage of NONLEAF_PMD_YOUNG.
> > Does it help a lot in decreasing the cpu usage?
>
> Hi Barry,
>
> The fleet-wide profiling data I shared was from x86. For arm64, I only
> have data from synthetic benchmarks at the moment, and it also shows
> similar improvements.
>
> For Chrome OS (individual users), walk_pte_range(), the function that
> would benefit from ARCH_HAS_NONLEAF_PMD_YOUNG, only uses a small
> portion (<4%) of kswapd CPU time. So ARCH_HAS_NONLEAF_PMD_YOUNG isn't
> that helpful.

Hi Yu,
Thanks!

In the current kernel, depending on reverse mapping, while memory is
under pressure,
the cpu usage of kswapd can be very very high especially while a lot of pag=
es
have large mapcount, thus a huge reverse mapping cost.

Regarding  <4%, I guess the figure came from machines with NONLEAF_PMD_YOUN=
G=EF=BC=9F
In this case, we can skip many PTE scans while PMD has no accessed bit
set. But for
a machine without NONLEAF, will the figure of cpu usage be much larger?

>
> > If so, this might be
> > a good proof that arm64 also needs this hardware feature?
> > In short, I am curious how much the improvement in this patchset depend=
s
> > on the hardware ability of NONLEAF_PMD_YOUNG.
>
> For data centers, I do think ARCH_HAS_NONLEAF_PMD_YOUNG has some value.
> In addition to cold/hot memory scanning, there are other use cases like
> dirty tracking, which can benefit from the accessed bit on non-leaf
> entries. I know some proprietary software uses this capability on x86
> for different purposes than this patchset does. And AFAIK, x86 is the
> only arch that supports this capability, e.g., risc-v and ppc can only
> set the accessed bit in PTEs.

Yep. NONLEAF is a nice feature.

btw, page table should have a separate DIRTY bit, right? wouldn't dirty pag=
e
tracking depend on the DIRTY bit rather than the accessed bit? so x86 also =
has
NONLEAF dirty bit? Or they are scanning accessed bit of PMD before
scanning DIRTY bits of PTEs?

>
> In fact, I've discussed this with one of the arm maintainers Will. So
> please check with him too if you are interested in moving forward with
> the idea. I might be able to provide with additional data if you need
> it to make a decision.

I am interested in running it and have some data without NONLEAF
especially while free memory is very limited and the system has memory
thrashing.

>
> Thanks.

Thanks
Barry
