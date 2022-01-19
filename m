Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DECD494306
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 23:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244726AbiASWZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 17:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357562AbiASWZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:25:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E723C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:25:54 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id a18so19993533edj.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 14:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgjUtIp/NJ23YXRIEjOj0qjbOPGKNdYKcaS2fOswzbc=;
        b=oGsu4bZqbrZah1XP9hAFPpaAxPc35v4wJQuOPO6BSg+l2m68e9br8SuK66riHukFLH
         FXIxgXuLCj2g6EufW8wwPm1p/MvkT1nT1blp81zUvRKjiIloJ5HMv/mSEC5Hx1fjZ/gU
         24pRsKr0zUguTJrpNO/ORsBpWNhlVRjbhQAAAi1Yr+ERmQeLw1l9tVJegpXqqIf6kihG
         Fr5/fcaS+jKnxNy34qGp5472VvREqU/oI/9IRaT5Myb59dZYQ9AwZzifVIgXEt4SIzIE
         lNLpwj1O9nQl1h87Mqzo6KjG6z5+7UzbgI5xmzlB53q6vEnT2MCTyzSkMN0jPg0QD6/M
         DFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgjUtIp/NJ23YXRIEjOj0qjbOPGKNdYKcaS2fOswzbc=;
        b=FH29/UCoPMBjW0vLC+t26eYey50IUxD3NakiK1iv6u3Uaxdz7rJdni+0fVpO5mhHPx
         FOqmQ0UhBWdzD24tVuXwtark4FB0e3AxsIQ3bcWE+ecsKeuzl4uf6THlf7GjJqwdrsOw
         C5gF/v1ltylQ/Y5XH7ac6N6Dk+ExygUbEDZQ/v0OP0PMaRrhshhvGXjyeKlDTd7sQQK6
         DiXYUngrWgP8LUzu7i5P39J03vW51Wiq94Cg/PARHpHXtvPPnXlviy6O8F7y7vtJzmT3
         24lJA2+e/1ux+JGHoOd9v4aoyg48YAdHiAt2+VeJZJY9+MItYSZ57dJNnWJGUc7rxROe
         yqsQ==
X-Gm-Message-State: AOAM533lyjpeh7XyP/xUODOP255kx7iXtKhliPEa/glvl8mL/5JaefZI
        K5r5+VMC96b5QK3g4hoym44mXo87cIvKr+hkRNjYUg==
X-Google-Smtp-Source: ABdhPJzkgP6BEDEgQhuAM2rXNU61+MwKYa2K+ClyYgh+IFMum6eOxwSxae/Wj82WqClt5hDJXhIt8J5jlLwZk0HJSxg=
X-Received: by 2002:aa7:dc53:: with SMTP id g19mr32773866edu.294.1642631152867;
 Wed, 19 Jan 2022 14:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20220104202227.2903605-1-yuzhao@google.com> <YdSuSHa/Vjl6bPkg@google.com>
 <Yd1Css8+jsspeZHh@google.com>
In-Reply-To: <Yd1Css8+jsspeZHh@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 19 Jan 2022 17:25:16 -0500
Message-ID: <CADyq12z9LtDEURaKTY8qx8nb7mqUL5jLnO682DeweFOmw31LDQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] Multigenerational LRU Framework
To:     Yu Zhao <yuzhao@google.com>
Cc:     Alexandre Frade <kernel@xanmod.org>,
        Daniel Byrne <djbyrne@mtu.edu>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
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
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, page-reclaim@google.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 3:41 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Jan 04, 2022 at 01:30:00PM -0700, Yu Zhao wrote:
> > On Tue, Jan 04, 2022 at 01:22:19PM -0700, Yu Zhao wrote:
> > > TLDR
> > > ====
> > > The current page reclaim is too expensive in terms of CPU usage and it
> > > often makes poor choices about what to evict. This patchset offers an
> > > alternative solution that is performant, versatile and
> > > straightforward.
> >
> > <snipped>
> >
> > > Summery
> > > =======
> > > The facts are:
> > > 1. The independent lab results and the real-world applications
> > >    indicate substantial improvements; there are no known regressions.
> > > 2. Thrashing prevention, working set estimation and proactive reclaim
> > >    work out of the box; there are no equivalent solutions.
> > > 3. There is a lot of new code; nobody has demonstrated smaller changes
> > >    with similar effects.
> > >
> > > Our options, accordingly, are:
> > > 1. Given the amount of evidence, the reported improvements will likely
> > >    materialize for a wide range of workloads.
> > > 2. Gauging the interest from the past discussions [14][15][16], the
> > >    new features will likely be put to use for both personal computers
> > >    and data centers.
> > > 3. Based on Google's track record, the new code will likely be well
> > >    maintained in the long term. It'd be more difficult if not
> > >    impossible to achieve similar effects on top of the existing
> > >    design.
> >
> > Hi Andrew, Linus,
> >
> > Can you please take a look at this patchset and let me know if it's
> > 5.17 material?
> >
> > My goal is to get it merged asap so that users can reap the benefits
> > and I can push the sequels. Please examine the data provided -- I
> > think the unprecedented coverage and the magnitude of the improvements
> > warrant a green light.
>
> Downstream kernel maintainers who have been carrying MGLRU for more than
> 3 versions, can you please provide your Acked-by tags?
>
> Having this patchset in the mainline will make your job easier :)
>
>    Alexandre - the XanMod Kernel maintainer
>                https://xanmod.org
>
>    Brian     - the Chrome OS kernel memory maintainer
>                https://www.chromium.org

MGLRU has been maturing in ChromeOS for quite some time, we've
maintained it in a number of different kernels between 4.14 and 5.15,
and it's become the default
for tens of millions of users. We've seen substantial improvements in
terms of CPU utilization and memory pressure resulting in fewer OOM
kills and reduced UI latency. I would love to see this make it
upstream so more desktop users can benefit.

Acked-by: Brian Geffon <bgeffon@google.com>


>
>    Jan       - the Arch Linux Zen kernel maintainer
>                https://archlinux.org
>
>    Steven    - the Liquorix kernel maintainer
>                https://liquorix.net
>
>    Suleiman  - the ARCVM (Android downstream) kernel memory maintainer
>                https://chromium.googlesource.com/chromiumos/third_party/kernel
>
> Also my gratitude to those who have helped test MGLRU:
>
>    Daniel - researcher at Michigan Tech
>             benchmarked memcached
>
>    Holger - who has been testing/patching/contributing to various
>             subsystems since ~2008
>
>    Shuang - researcher at University of Rochester
>             benchmarked fio and provided a report
>
>    Sofia  - EDI https://www.edi.works
>             benchmarked the top eight memory hogs and provided reports
>
> Can you please provide your Tested-by tags? This will ensure the credit
> for your contributions.
>
> Thanks!
